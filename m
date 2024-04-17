Return-Path: <linux-fsdevel+bounces-17155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DCF8A876F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034C71C20B4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDE01474A6;
	Wed, 17 Apr 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uPztRZaU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C038146A78;
	Wed, 17 Apr 2024 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367404; cv=none; b=L9XRgHzomcoLHrKtcud0Fi2UNCjCvc2CdV5Ei8aJqEi6bAZvTxYMFFI6q39A5YLDq1mkp3zkZKvwbGVsDj/Ouw7hIaNzSJCCBgBROE23kOoInFjN0l1ktsMD+otIQDJAdGjA1zy7eSj5DVnUs3iy5BtvspgqPeAs60j2E+Hmf+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367404; c=relaxed/simple;
	bh=QWTyDLlYiZOpO2Naz9bByLVW11NOAi59E6jl/VmNrUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMtnbZNHspxD+P+tErRcsOhO2N7VyC2hr4DALMcAcfwcZ1Ml9d4Sr0xfXga/JnVDWThFFxR3SvTeNTsll3VfEiFDM9EV0MNQ6IQdGuPenYrvCdrQmkakStknV/xt9NhlKKqyR6JEBs5VkW0kT8yqQ2eHdMquq6DlanB9jghCAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uPztRZaU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rdjlNSX8C/htS6Mxa32uWZ1ZzztETsvkjNXWJRJzqrw=; b=uPztRZaUKBT8zxJTP2vZNpDjIc
	W7t1+K/iyVvU1H3rFFwn8EZPv75DNS8+56efcijCko4mAugygQ3m0GSELjIJ2MJkDR4JYir0Yy5Lz
	VKzj2/0YtVOfK2J/TXfmuppIx1mhXxC0UVVrph/NfYMyHOPFbLzau6ZafvXZ2AAEnT3DgZX1tW3eM
	7fzgCk94Oy67xHHUl64vjZJ7D3BL8SZGiLcEC113o2yEGWTJRxHhbrk+Ul7qIYOpsm24MGuuyUV1n
	SFNEbkUEJmjx3vo/O78Uio+DdYI5fwY+wUm3fAqIzEBlyworruqf4ZnAvC7VfBAT/+uMvjm9n+Y8W
	1RQAZ6MQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rx77o-00EPh4-0Y;
	Wed, 17 Apr 2024 15:23:04 +0000
Date: Wed, 17 Apr 2024 16:23:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240417152304.GC2118490@ZenIV>
References: <20240410105911.hfxz4qh3n5ekrpqg@quack3>
 <20240410223443.GG2118490@ZenIV>
 <20240411-logik-besorgen-b7d590d6c1e9@brauner>
 <20240411140409.GH2118490@ZenIV>
 <20240412-egalisieren-fernreise-71b1f21f8e64@brauner>
 <20240412112919.GN2118490@ZenIV>
 <20240413-hievt-zweig-2e40ac6443aa@brauner>
 <20240415204511.GV2118490@ZenIV>
 <20240416063253.GA2118490@ZenIV>
 <20240417134312.mntxg6iju4aalxpy@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417134312.mntxg6iju4aalxpy@quack3>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 17, 2024 at 03:43:12PM +0200, Jan Kara wrote:

> > fs/btrfs/volumes.c:485: ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);
> > 	Some of the callers do not bother with exclusive open;
> > in particular, if btrfs_get_dev_args_from_path() ever gets a pathname
> > of a mounted device with something other than btrfs on it, it won't
> > be pretty.
> 
> Yeah and frankly reading through btrfs_read_dev_super() I'm not sure which
> code needs the block size set either. We use read_cache_page_gfp() for the
> IO there as well.

FWIW, I don't understand the use of invalidate_bdev() in btrfs_get_bdev_and_sb(),
especially when called from btrfs_get_dev_args_from_path() - what's the point
of evicting page cache before reading the on-disk superblock, when all we are
going to do with the data we get is scan through internal list of opened devices
for uuid, etc.  matches?

Could btrfs folks comment on that one?

