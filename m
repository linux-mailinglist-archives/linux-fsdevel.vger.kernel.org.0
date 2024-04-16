Return-Path: <linux-fsdevel+bounces-17021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823A68A63CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 08:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9A81F21AB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 06:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EF16D1A3;
	Tue, 16 Apr 2024 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gKh/xSYR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6763D0AF;
	Tue, 16 Apr 2024 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249186; cv=none; b=Hn9dJsRHbHuSspZO+VwLrGpPzkI5QywTKNdnk/bpt8VtdEwBk9SiTBKH1I+fMzya8gdq5y1tYqz3V0aGI5Eel9kEmK3XFvpQttnf+aJCNGH0ivUOtwIh/tqKBagdsqz7A+56iTetUPmGVtjlnbY6S1lUDJY9+bZKZqD8CvL8LaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249186; c=relaxed/simple;
	bh=W88QBy2o5uexxr4JE9kGiXTSAKWxVG9ekxTMtXItMik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEheTNSCtE85Es0U68DlcPMeYBlnAGv7GexB5vL8uTz7VssiKOMTU4Afdsz9CkB+q9O19j+D6veTisn/CpFgPsi3lOACS3/DJTV/Fmy6bjrg9xp02Wlh3fxpNo42PxidE1WUHUdhi545gzFl7hllQcbkHsHMAhNtByuqxWNxWdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gKh/xSYR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hREpjKgfbsIOL7AOTVuwKPWDWJ1jPpxuTGpXgGkCe+0=; b=gKh/xSYRma1KcbLQ8T4xR2coiE
	9XhWc/JIDK2+EI6MgnTxU+ihTBNOx4SWu4BKCR1lauYjct/DOIntonhafPQGZQS4WJAEJwagrv3hD
	PwDZFq23w2puAmvCZZZJe98/ZhOJkmKnvUbfnEJRExoIo3DCskVsgpyI1K1++AwgCFLUzc6a3jzZ+
	FC+qR9mF2toNp4Je/qgrPJb42Sp/cLnkiUEKYwYUqRm8zNL+PvnS3QnB+rcnlFYvRqKe0cWH09NCF
	/JTTYeeXBI/0xHzQVWPEg1EAvvYYj2zIOImMQ3u+8mqa/rKpwLToqUw6advoruX+9Dkj25Mtmq3lg
	gbk9mX4Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rwcNB-00DHEb-0g;
	Tue, 16 Apr 2024 06:32:53 +0000
Date: Tue, 16 Apr 2024 07:32:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de,
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240416063253.GA2118490@ZenIV>
References: <20240409042643.GP538574@ZenIV>
 <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
 <20240410105911.hfxz4qh3n5ekrpqg@quack3>
 <20240410223443.GG2118490@ZenIV>
 <20240411-logik-besorgen-b7d590d6c1e9@brauner>
 <20240411140409.GH2118490@ZenIV>
 <20240412-egalisieren-fernreise-71b1f21f8e64@brauner>
 <20240412112919.GN2118490@ZenIV>
 <20240413-hievt-zweig-2e40ac6443aa@brauner>
 <20240415204511.GV2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415204511.GV2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 15, 2024 at 09:45:11PM +0100, Al Viro wrote:
> On Sat, Apr 13, 2024 at 05:25:01PM +0200, Christian Brauner wrote:
> 
> > > It also simplifies the hell out of the patch series - it's one obviously
> > > safe automatic change in a single commit.
> > 
> > It's trivial to fold the simple file_mapping() conversion into a single
> > patch as well.
> 
> ... after a bunch of patches that propagate struct file to places where
> it has no business being.  Compared to a variant that doesn't need those
> patches at all.
> 
> > It's a pure artifact of splitting the patches per
> > subsystem/driver.
> 
> No, it is not.  ->bd_mapping conversion can be done without any
> preliminaries.  Note that it doesn't need messing with bdev_read_folio(),
> it doesn't need this journal->j_fs_dev_file thing, etc.
> 
> One thing I believe is completely wrong in this series is bdev_inode()
> existence.  It (and equivalent use of file_inode() on struct file is
> even worse) is papering over the real interface deficiencies.  And
> extra file_inode() uses are just about impossible to catch ;-/
> 
> IMO we should *never* use file_inode() on opened block devices.
> At all.  It's brittle, it's asking for trouble as soon as somebody
> passes a normally opened struct file to one of the functions using it
> and it papers over the missing primitives.

BTW, speaking of the things where opened struct file would be a good
idea - set_blocksize() should take an opened struct file, and it should
have non-NULL ->private_data.

Changing block size under e.g. a mounted filesystem should never happen;
doing that is asking for serious breakage.

Looking through the current callers (mainline), most are OK (and easy
to switch).  However,
	
drivers/block/pktcdvd.c:2285:           set_blocksize(disk->part0, CD_FRAMESIZE);
drivers/block/pktcdvd.c:2529:   set_blocksize(file_bdev(bdev_file), CD_FRAMESIZE);
	Might be broken; pktcdvd.c being what it is...

drivers/md/bcache/super.c:2558: if (set_blocksize(file_bdev(bdev_file), 4096))
	Almost certainly broken; hit register_bcache() with pathname of a mounted
block device, and if the block size on filesystem in question is not 4K, the things
will get interesting.

fs/btrfs/volumes.c:485: ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);
	Some of the callers do not bother with exclusive open;
in particular, if btrfs_get_dev_args_from_path() ever gets a pathname
of a mounted device with something other than btrfs on it, it won't
be pretty.

kernel/power/swap.c:371:        res = set_blocksize(file_bdev(hib_resume_bdev_file), PAGE_SIZE);
kernel/power/swap.c:1577:               set_blocksize(file_bdev(hib_resume_bdev_file), PAGE_SIZE);
	Special cases (for obvious reasons); said that, why do we bother
with set_blocksize() on those anyway?

