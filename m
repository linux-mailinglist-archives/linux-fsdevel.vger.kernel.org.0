Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701262DD987
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 20:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgLQTuO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 14:50:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgLQTuN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 14:50:13 -0500
Message-ID: <f089a090dfe8e0554be46187ad345649a2feb4ad.camel@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608234573;
        bh=6M77sfOqL6ihI39KKZ2MrMyW78kRW0crwtWPbHsgXyw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mT5ymEl4pB64SNCmAaQtiVMv2iXxtMLfe/aMt2z6aDI2VKg2KZU6f1wBBT5oZHpja
         eM/Zly7lH1uULMGUvXO91eoNIsIeKkYWtp89OpG3hXT2e/1CXZgzczYHqPV8Sogfup
         UX9MB/b8rJDQpgJfLDDEWU4aqQytk+A5SScHu4/xeSj+4FkCwnHC/vG/6PF2VZ1ZKu
         PRCQOGH0CsX7c6Zxk9A5g+oFmNV68Db//26tBIc/Tf2UJqBrHarFDHdgm5Bl8DwDHr
         Y1X5Ac6Zmxu6QR/g6NPejjzuJxf50VYE/Uewde8SWXIzSas1lv9VfokCIBPlKk7ajQ
         iRMO7HKg3FpDQ==
Subject: Re: [PATCH 1/3] vfs: add new f_op->syncfs vector
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, amir73il@gmail.com,
        sargun@sargun.me, miklos@szeredi.hu, willy@infradead.org,
        jack@suse.cz, neilb@suse.com, Christoph Hellwig <hch@lst.de>
Date:   Thu, 17 Dec 2020 14:49:30 -0500
In-Reply-To: <20201217004935.GN3579531@ZenIV.linux.org.uk>
References: <20201216233149.39025-1-vgoyal@redhat.com>
         <20201216233149.39025-2-vgoyal@redhat.com>
         <20201217004935.GN3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-12-17 at 00:49 +0000, Al Viro wrote:
> [Christoph added to Cc...]
> On Wed, Dec 16, 2020 at 06:31:47PM -0500, Vivek Goyal wrote:
> > Current implementation of __sync_filesystem() ignores the return code
> > from ->sync_fs(). I am not sure why that's the case. There must have
> > been some historical reason for this.
> > 
> > Ignoring ->sync_fs() return code is problematic for overlayfs where
> > it can return error if sync_filesystem() on upper super block failed.
> > That error will simply be lost and sycnfs(overlay_fd), will get
> > success (despite the fact it failed).
> > 
> > If we modify existing implementation, there is a concern that it will
> > lead to user space visible behavior changes and break things. So
> > instead implement a new file_operations->syncfs() call which will
> > be called in syncfs() syscall path. Return code from this new
> > call will be captured. And all the writeback error detection
> > logic can go in there as well. Only filesystems which implement
> > this call get affected by this change. Others continue to fallback
> > to existing mechanism.
> 
> That smells like a massive source of confusion down the road.  I'd just
> looked through the existing instances; many always return 0, but quite
> a few sometimes try to return an error:
> fs/btrfs/super.c:2412:  .sync_fs        = btrfs_sync_fs,
> fs/exfat/super.c:204:   .sync_fs        = exfat_sync_fs,
> fs/ext4/super.c:1674:   .sync_fs        = ext4_sync_fs,
> fs/f2fs/super.c:2480:   .sync_fs        = f2fs_sync_fs,
> fs/gfs2/super.c:1600:   .sync_fs                = gfs2_sync_fs,
> fs/hfsplus/super.c:368: .sync_fs        = hfsplus_sync_fs,
> fs/nilfs2/super.c:689:  .sync_fs        = nilfs_sync_fs,
> fs/ocfs2/super.c:139:   .sync_fs        = ocfs2_sync_fs,
> fs/overlayfs/super.c:399:       .sync_fs        = ovl_sync_fs,
> fs/ubifs/super.c:2052:  .sync_fs       = ubifs_sync_fs,
> is the list of such.  There are 4 method callers:
> dquot_quota_sync(), dquot_disable(), __sync_filesystem() and
> sync_fs_one_sb().  For sync_fs_one_sb() we want to ignore the
> return value; for __sync_filesystem() we almost certainly
> do *not* - it ends with return __sync_blockdev(sb->s_bdev, wait),
> after all.  The question for that one is whether we want
> __sync_blockdev() called even in case of ->sync_fs() reporting
> a failure, and I suspect that it's safer to call it anyway and
> return the first error value we'd got.  No idea about quota
> situation.
> 

The only problem there is that makes it a bit difficult to override the
error return to syncfs, which is really what overlayfs wants to be able
to do. Their syncfs syncs out the upper layer, so it makes sense to just
have their file->f_sb_err track the upper layer's sb->s_wb_err.

You can plumb the errors from sync_fs all the way through to the syncfs
syscall, but we can't currently tell whether we're doing the sync_fs op
on behalf of sync(), syncfs() or something else entirely. We need to
ensure that if it does return an error, that it doesn't get dropped on
the floor.

I think it'd be simpler to just add f_op->syncfs and change
s_op->sync_fs to a different name, to lessen the confusion.
s_op->sync_fs sort of makes it look like you're implementing syncfs(2),
but there's a bit more to it than that.

Maybe s_op->sync_filesystem? There are only about 113 instances
"sync_fs" in the tree. Changing the name might also help highlight the
fact that the return code won't be ignored like it used to be.
-- 
Jeff Layton <jlayton@kernel.org>

