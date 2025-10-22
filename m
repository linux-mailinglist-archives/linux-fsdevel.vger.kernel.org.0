Return-Path: <linux-fsdevel+bounces-65050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4E7BFA110
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 07:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E7818C5190
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 05:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044F12ECD19;
	Wed, 22 Oct 2025 05:34:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0660241665;
	Wed, 22 Oct 2025 05:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111283; cv=none; b=XCaiRLXtAG9dr11EAhkJcNaa20i7hoi0CDccwZpNeIvkrhYmEDxaCHxEWFfa5HgFA6wq47J9kqgdrkQ4wR4Zh1+JM8wlMkoCclXLOMnjf9EBqkBVMKjkap2steguxKZm9zkZA89VcrjZNy4dwnKaJmHznQSKwDw0jj900sdNjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111283; c=relaxed/simple;
	bh=gsDXUURKh7jMSr5chgzvZQTNTnV3Qsf+wVti7kG94X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxW8znAZjJgGdxVkAxfcY43wHUXxCstdJ4/1kiVCJzEr09CObD6lFgLFEaexHcTsminEpElY2bCMWlNYorQirO48YPSbBU1UcHlvaMeapzKb5KtfvHxYWyoA4NZAHqSLBQQQqTv0XUU9/Et6VHUsn2s5F9rw+IzvQk5GsMT+R10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0582A227A88; Wed, 22 Oct 2025 07:34:35 +0200 (CEST)
Date: Wed, 22 Oct 2025 07:34:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	dlemoal@kernel.org, hans.holmberg@wdc.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: allow file systems to increase the minimum writeback chunk
 size v2
Message-ID: <20251022053434.GA3729@lst.de>
References: <20251017034611.651385-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017034611.651385-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks like everything is reviewed now, can we get this queued up
as it fixes nasty fragmentation for zoned XFS?

It seems like the most recent writeback updates went through the VFS
tree, although -mm has been quite common as well.

On Fri, Oct 17, 2025 at 05:45:46AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> The relatively low minimal writeback size of 4MiB leads means that
> written back inodes on rotational media are switched a lot.  Besides
> introducing additional seeks, this also can lead to extreme file
> fragmentation on zoned devices when a lot of files are cached relative
> to the available writeback bandwidth.
> 							         
> Add a superblock field that allows the file system to override the
> default size, and set it to the zone size for zoned XFS.
> 
> Changes since v1:
>  - covert the field to a long to match other related writeback code
>  - cap the zone XFS writeback size to the maximum extent size
>  - write an extensive comment about the tradeoffs of setting the value
>  - fix a commit message typo
> 
> Diffstat:
>  fs/fs-writeback.c         |   26 +++++++++-----------------
>  fs/super.c                |    1 +
>  fs/xfs/xfs_zone_alloc.c   |   28 ++++++++++++++++++++++++++--
>  include/linux/fs.h        |    1 +
>  include/linux/writeback.h |    5 +++++
>  5 files changed, 42 insertions(+), 19 deletions(-)
---end quoted text---

