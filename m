Return-Path: <linux-fsdevel+bounces-11518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D248543B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 09:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C50C1C26B29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 08:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB8B125C8;
	Wed, 14 Feb 2024 08:00:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2401125A3;
	Wed, 14 Feb 2024 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707897636; cv=none; b=jAtPtIC8p+5a3vIuuclwublETeE8d+IAzfKiBBX97QbBDvI5CwnIh2bJ/EoUWPV7sWYj6uc97LPsOoIC7/75CnKJUItB9dFFOYGBb24zNAeaiK4rS0b1IVB3q/RZXvlUrn/neav3JpGqYYIKsXA26BGNJG+LIXdnjciOC2Sdikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707897636; c=relaxed/simple;
	bh=w+kO/jU3FepRDw8e+GUzUO0e9U3cbv0TzS0zcfTAyPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0rAsk8ZzR3YddveEp5jUiLTaNEEzvWmkSB6kRqsJBT9jGg4xFlo1w+HN2sdpNhKGxvZYv1PsOPEz1ezAgiwofxxzAaizFNFqKUOD9/kQH/w7trQLlm9ZM/mHK8CsMN3ItoPQhXoNjRPd7/WWdRLDCOrKjUfbrZXdyO8BmkB+V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0DD4C227AAD; Wed, 14 Feb 2024 09:00:25 +0100 (CET)
Date: Wed, 14 Feb 2024 09:00:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH v3 14/15] nvme: Support atomic writes
Message-ID: <20240214080024.GA10357@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-15-john.g.garry@oracle.com> <20240213064204.GB23305@lst.de> <0323ba69-dff9-4465-817e-2c349141b753@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0323ba69-dff9-4465-817e-2c349141b753@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Feb 13, 2024 at 02:21:25PM +0000, John Garry wrote:
>> Please also read through TP4098(a) and look at the MAM field.
>
> It's not public, AFAIK.

Oracle is a member, so you can take a look at it easily.  If we need
it for Linux I can also work with the NVMe Board to release it.

> And I don't think a feature which allows us to straddle boundaries is too 
> interesting really.

Without MAM=1 NVMe can't support atomic writes larger than
AWUPF/NAWUPF, which is typically set to the indirection table
size.  You're leaving a lot of potential unused with that.


