Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DA92DCEF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 10:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgLQJ6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 04:58:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:57860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgLQJ6M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 04:58:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ABA97AC7B;
        Thu, 17 Dec 2020 09:57:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5B3921E135E; Thu, 17 Dec 2020 10:57:28 +0100 (CET)
Date:   Thu, 17 Dec 2020 10:57:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        jlayton@kernel.org, amir73il@gmail.com, sargun@sargun.me,
        miklos@szeredi.hu, willy@infradead.org, jack@suse.cz,
        neilb@suse.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] vfs: add new f_op->syncfs vector
Message-ID: <20201217095728.GB6989@quack2.suse.cz>
References: <20201216233149.39025-1-vgoyal@redhat.com>
 <20201216233149.39025-2-vgoyal@redhat.com>
 <20201217004935.GN3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217004935.GN3579531@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-12-20 00:49:35, Al Viro wrote:
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

WRT quota situation: All the ->sync_fs() calls there are due to cache
coherency reasons (we need to get quota changes to disk, then prune quota
files's page cache, and then userspace can read current quota structures
from the disk). We don't want to fail dquot_disable() just because caches
might be incoherent so ignoring ->sync_fs() return value there is fine.
With dquot_quota_sync() it might make some sense to return the error -
that's just a backend for Q_SYNC quotactl(2). OTOH I'm not sure anybody
really cares - Q_SYNC is rarely used.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
