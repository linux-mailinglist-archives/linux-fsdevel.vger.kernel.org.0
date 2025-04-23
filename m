Return-Path: <linux-fsdevel+bounces-47063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943F0A9839D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 10:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D107A3BD85B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA1F28BA92;
	Wed, 23 Apr 2025 08:25:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694AF2749CA;
	Wed, 23 Apr 2025 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396732; cv=none; b=XpIZBcTnlS0EKCRSl/tIGJvHCgN3R3jGOlQ7gxw18pkn0I4Ntn2udtthwX7sfD+AZ3fc7qJO/GhIgyDtquTiwG9+glfbxDqp1dbMdmXsMkQJXZGPCbq9OyaH478StHwFXa5TNruAEjZXddUk4C/Or/Pm95dfQvuRURwGoMyn+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396732; c=relaxed/simple;
	bh=kDp1hBZ0zciE7L3Cq/8IlL7j2Zy+99ATtc1YUC9630s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnlwWUzfPS+MR55GI8U0XkPREoG243dwPiWRC3i+WZpuwRLf8FTaHXhQnflsempIdovJN0KRysyKSGKwjixk8pYq4u3eeYVw9VlO1TOwEt8CKXNX3qedJxWB03NU7+XJwbT5gPE7AauVb/cSwklFw1zy8el0ejPdxOZSm0EENHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0DCF968BFE; Wed, 23 Apr 2025 10:25:26 +0200 (CEST)
Date: Wed, 23 Apr 2025 10:25:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v8 12/15] xfs: add xfs_file_dio_write_atomic()
Message-ID: <20250423082525.GB29539@lst.de>
References: <20250422122739.2230121-1-john.g.garry@oracle.com> <20250422122739.2230121-13-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422122739.2230121-13-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 22, 2025 at 12:27:36PM +0000, John Garry wrote:
> Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.
> 
> The function works based on two operating modes:
> - HW offload, i.e. REQ_ATOMIC-based
> - CoW based with out-of-places write and atomic extent remapping
> 
> The preferred method is HW offload as it will be faster. If HW offload is
> not possible, then we fallback to the CoW-based method.
> 
> HW offload would not be possible for the write length exceeding the HW
> offload limit, the write spanning multiple extents, unaligned disk blocks,
> etc.
> 
> Apart from the write exceeding the HW offload limit, other conditions for
> HW offload can only be detected in the iomap handling for the write. As
> such, we use a fallback method to issue the write if we detect in the
> ->iomap_begin() handler that HW offload is not possible. Special code
> -ENOPROTOOPT is returned from ->iomap_begin() to inform that HW offload
> not possible.

This text could use a little rewrite starting with the fact that the
hardware offload now isn't required to start with and entirely
optional and then flow from the there to state when we can use it
instead of when we can't use it.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

