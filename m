Return-Path: <linux-fsdevel+bounces-11305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7608528DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CE728331F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 06:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8654917995;
	Tue, 13 Feb 2024 06:24:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690DC1772F;
	Tue, 13 Feb 2024 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805473; cv=none; b=DJS4tVn0jBu1/QxtNImV1CymybBd80mfARX9L+jP+0+KmU7ExTwgHUgm/XWO6tLhfz52adE/dGBEjEtQjym+CGV3qj+krdNIBavsDRNtyyTGRgbLEg2B+EI5PiLbC/P4mMA+W5L/DZlq3peen3d+F+ACOz72CYDulB06lD6o83s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805473; c=relaxed/simple;
	bh=3ihRSTn4GBO+EIOLZpr+K4VXJGFPRHT8OsRuZDz1slY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i27FjbCkMHZkeJZqdHTvvevM94V3EuuoST49cO1+6sYL1mvc9pWlZ5FlHkjPvPtkRD+N4aR44K3/KQNpq2J2CGNycZN9OUIjMGJLb5yCP8dhVNhTTtX6hUK9I7wd8rLwcImCIzJ8xjb1cyqUcabqHXgiK0vKyBLZwAv8Ky76fQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A182F227A87; Tue, 13 Feb 2024 07:24:27 +0100 (CET)
Date: Tue, 13 Feb 2024 07:24:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 05/15] block: Add REQ_ATOMIC flag
Message-ID: <20240213062427.GC23128@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com> <20240124113841.31824-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124113841.31824-6-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 24, 2024 at 11:38:31AM +0000, John Garry wrote:
> From: Himanshu Madhani <himanshu.madhani@oracle.com>
> 
> Add flag REQ_ATOMIC, meaning an atomic operation. This should only be
> used in conjunction with REQ_OP_WRITE.
> 
> We will not add a special "request atomic write" operation, as to try to
> avoid maintenance effort for an operation which is almost the same as
> REQ_OP_WRITE.

I'd also merge this into the main atomic writes block layer patch..


