Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DA72DC631
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgLPSYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbgLPSYS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:24:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F265C06179C;
        Wed, 16 Dec 2020 10:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=kzVxzXwCOxP1qxGGZOouC7j1OurbkbfG6A2tzSUkWZk=; b=VjaHv6HHxC+DIkX7S7Z2+6Ek2D
        XHOLg5TwZTimWbnniZiZw1As5eu92yd+BwXbLksd+hEGzlm17lBzLRMhtx/oSBBUwVHkZ224dBTxs
        qUcLnTNj8bvOX5cD9394zLvcLE5zl9b9CdTB97WqQekimwtFpcIx7hm5MvlaUs0TyUQny7yIvyDCY
        O32HFWgXXonPHSqstWSEac7cQOY3XxJ+d6pyfgfqIkrCx1N5g8KJZrZUX+/kIpG4/wnXb/8tcC8G2
        1EFvNIplQT2rZMekyoS3VnJ7asRTvcnN7NmCLMMojj+5zYyeq06CVLXRmMgDBJZXze5YWOB2nA4zj
        0V8YWP5g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSa-00075u-Lr; Wed, 16 Dec 2020 18:23:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/25] Page folios
Date:   Wed, 16 Dec 2020 18:23:10 +0000
Message-Id: <20201216182335.27227-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One of the great things about compound pages is that when you try to
do various operations on a tail page, it redirects to the head page and
everything Just Works.  One of the awful things is how much we pay for
that simplicity.  Here's an example, end_page_writeback():

        if (PageReclaim(page)) {
                ClearPageReclaim(page);
                rotate_reclaimable_page(page);
        }
        get_page(page);
        if (!test_clear_page_writeback(page))
                BUG();

        smp_mb__after_atomic();
        wake_up_page(page, PG_writeback);
        put_page(page);

That all looks very straightforward, but if you dive into the disassembly,
you see that there are four calls to compound_head() in this function
(PageReclaim(), ClearPageReclaim(), get_page() and put_page()).  It's
all for nothing, because if anyone does call this routine with a tail
page, wake_up_page() will VM_BUG_ON_PGFLAGS(PageTail(page), page).

I'm not really a CPU person, but I imagine there's some kind of dependency
here that sucks too:

    1fd7:       48 8b 57 08             mov    0x8(%rdi),%rdx
    1fdb:       48 8d 42 ff             lea    -0x1(%rdx),%rax
    1fdf:       83 e2 01                and    $0x1,%edx
    1fe2:       48 0f 44 c7             cmove  %rdi,%rax
    1fe6:       f0 80 60 02 fb          lock andb $0xfb,0x2(%rax)

Sure, it's going to be cache hot, but that cmove has to execute before
the lock andb.

I would like to introduce a new concept that I call a Page Folio.
Or just struct folio to its friends.  Here it is,
struct folio {
        struct page page;
};

A folio is a struct page which is guaranteed not to be a tail page.
So it's either a head page or a base (order-0) page.  That means
we don't have to call compound_head() on it and we save massively.
end_page_writeback() reduces from four calls to compound_head() to just
one (at the beginning of the function) and it shrinks from 213 bytes
to 126 bytes (using distro kernel config options).  I think even that one
can be eliminated, but I'm going slowly at this point and taking the
safe route of transforming a random struct page pointer into a struct
folio pointer by calling page_folio().  By the end of this exercise,
end_page_writeback() will become end_folio_writeback().

This is going to be a ton of work, and massively disruptive.  It'll touch
every filesystem, and a good few device drivers!  But I think it's worth
it.  Not every routine benefits as much as end_page_writeback(), but it
makes everything a little better.  At 29 bytes per call to lock_page(),
unlock_page(), put_page() and get_page(), that's on the order of 60kB of
text for allyesconfig.  More when you add on all the PageFoo() calls.
With the small amount of work I've done here, mm/filemap.o shrinks its
text segment by over a kilobyte from 33687 to 32318 bytes (and also 192
bytes of data).

But better than that, it's good documentation.  A function which has a
struct page argument might be expecting a head or base page and will
BUG if given a tail page.  It might work with any kind of page and
operate on PAGE_SIZE bytes.  It might work with any kind of page and
operate on page_size() bytes if given a head page but PAGE_SIZE bytes
if given a base or tail page.  It might operate on page_size() bytes
if passed a head or tail page.  We have examples of all of these today.
If a function takes a folio argument, it's operating on the entire folio.

This version of the patch series converts the deduplication code from
operating on pages to operating on folios.  Most of the patches are
somewhat generic infrastructure we'll need, then there's a big gulp as
all filesystems are converted to use folios for readahead and readpage.
Finally, we can convert the deduplification code to use page folios.

If you're interested, you can listen to a discussion of page folios
from last week here: https://www.youtube.com/watch?v=iP49_ER1FUM
Git tree version here (against next-20201216):
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/folio

Matthew Wilcox (Oracle) (25):
  mm: Introduce struct folio
  mm: Add put_folio
  mm: Add get_folio
  mm: Create FolioFlags
  mm: Add unlock_folio
  mm: Add lock_folio
  mm: Add lock_folio_killable
  mm: Add __alloc_folio_node and alloc_folio
  mm: Convert __page_cache_alloc to return a folio
  mm/filemap: Convert end_page_writeback to use a folio
  mm: Convert mapping_get_entry to return a folio
  mm: Add mark_folio_accessed
  mm: Add filemap_get_folio and find_get_folio
  mm/filemap: Add folio_add_to_page_cache
  mm/swap: Convert rotate_reclaimable_page to folio
  mm: Add folio_mapping
  mm: Rename THP_SUPPORT to MULTI_PAGE_FOLIOS
  btrfs: Use readahead_batch_length
  fs: Change page refcount rules for readahead
  fs: Change readpage to take a folio
  mm: Convert wait_on_page_bit to wait_on_folio_bit
  mm: Add wait_on_folio_locked & wait_on_folio_locked_killable
  mm: Add flush_dcache_folio
  mm: Add read_cache_folio and read_mapping_folio
  fs: Convert vfs_dedupe_file_range_compare to folios

 Documentation/core-api/cachetlb.rst   |   6 +
 Documentation/filesystems/locking.rst |   2 +-
 Documentation/filesystems/porting.rst |   8 +
 Documentation/filesystems/vfs.rst     |  35 +-
 fs/9p/vfs_addr.c                      |   9 +-
 fs/adfs/inode.c                       |   4 +-
 fs/affs/file.c                        |   8 +-
 fs/affs/symlink.c                     |   3 +-
 fs/afs/dir.c                          |   2 +-
 fs/afs/file.c                         |   5 +-
 fs/afs/write.c                        |   2 +-
 fs/befs/linuxvfs.c                    |  23 +-
 fs/bfs/file.c                         |   4 +-
 fs/block_dev.c                        |   4 +-
 fs/btrfs/compression.c                |   4 +-
 fs/btrfs/ctree.h                      |   2 +-
 fs/btrfs/extent_io.c                  |  19 +-
 fs/btrfs/file.c                       |  13 +-
 fs/btrfs/free-space-cache.c           |   9 +-
 fs/btrfs/inode.c                      |  16 +-
 fs/btrfs/ioctl.c                      |  11 +-
 fs/btrfs/relocation.c                 |  11 +-
 fs/btrfs/send.c                       |  11 +-
 fs/buffer.c                           |  12 +-
 fs/cachefiles/rdwr.c                  |  17 +-
 fs/ceph/addr.c                        |   8 +-
 fs/ceph/file.c                        |   2 +-
 fs/cifs/file.c                        |   3 +-
 fs/coda/symlink.c                     |   3 +-
 fs/cramfs/inode.c                     |   3 +-
 fs/ecryptfs/mmap.c                    |   3 +-
 fs/efs/inode.c                        |   4 +-
 fs/efs/symlink.c                      |   3 +-
 fs/erofs/data.c                       |  12 +-
 fs/erofs/zdata.c                      |   8 +-
 fs/exfat/inode.c                      |   4 +-
 fs/ext2/inode.c                       |   4 +-
 fs/ext4/ext4.h                        |   2 +-
 fs/ext4/inode.c                       |  10 +-
 fs/ext4/readpage.c                    |  35 +-
 fs/f2fs/data.c                        |  12 +-
 fs/fat/inode.c                        |   4 +-
 fs/freevxfs/vxfs_immed.c              |   7 +-
 fs/freevxfs/vxfs_subr.c               |   7 +-
 fs/fuse/dir.c                         |   8 +-
 fs/fuse/file.c                        |   7 +-
 fs/gfs2/aops.c                        |  13 +-
 fs/hfs/inode.c                        |   4 +-
 fs/hfsplus/inode.c                    |   4 +-
 fs/hpfs/file.c                        |   4 +-
 fs/hpfs/namei.c                       |   3 +-
 fs/inode.c                            |   4 +-
 fs/iomap/buffered-io.c                |  14 +-
 fs/isofs/compress.c                   |   3 +-
 fs/isofs/inode.c                      |   4 +-
 fs/isofs/rock.c                       |   3 +-
 fs/jffs2/file.c                       |  20 +-
 fs/jffs2/os-linux.h                   |   2 +-
 fs/jfs/inode.c                        |   4 +-
 fs/jfs/jfs_metapage.c                 |   3 +-
 fs/libfs.c                            |  10 +-
 fs/minix/inode.c                      |   4 +-
 fs/mpage.c                            |   9 +-
 fs/nfs/file.c                         |   5 +-
 fs/nfs/read.c                         |   7 +-
 fs/nfs/symlink.c                      |  12 +-
 fs/nilfs2/inode.c                     |   4 +-
 fs/ntfs/aops.c                        |   3 +-
 fs/ocfs2/aops.c                       |  14 +-
 fs/ocfs2/refcounttree.c               |   5 +-
 fs/ocfs2/symlink.c                    |   3 +-
 fs/omfs/file.c                        |   4 +-
 fs/orangefs/inode.c                   |   3 +-
 fs/qnx4/inode.c                       |   4 +-
 fs/qnx6/inode.c                       |   4 +-
 fs/reiserfs/inode.c                   |   4 +-
 fs/remap_range.c                      | 109 +++---
 fs/romfs/super.c                      |   3 +-
 fs/squashfs/file.c                    |   3 +-
 fs/squashfs/symlink.c                 |   3 +-
 fs/sysv/itree.c                       |   4 +-
 fs/ubifs/file.c                       |   8 +-
 fs/udf/file.c                         |   8 +-
 fs/udf/inode.c                        |   4 +-
 fs/udf/symlink.c                      |   3 +-
 fs/ufs/inode.c                        |   4 +-
 fs/vboxsf/file.c                      |   3 +-
 fs/xfs/xfs_aops.c                     |   4 +-
 fs/zonefs/super.c                     |   4 +-
 include/asm-generic/cacheflush.h      |  13 +
 include/linux/buffer_head.h           |   2 +-
 include/linux/fs.h                    |   6 +-
 include/linux/gfp.h                   |  11 +
 include/linux/iomap.h                 |   2 +-
 include/linux/mm.h                    |  57 +++-
 include/linux/mm_types.h              |  17 +
 include/linux/mpage.h                 |   2 +-
 include/linux/nfs_fs.h                |   2 +-
 include/linux/page-flags.h            |  80 ++++-
 include/linux/pagemap.h               | 227 +++++++++----
 include/linux/swap.h                  |   9 +-
 mm/filemap.c                          | 466 +++++++++++++-------------
 mm/internal.h                         |   1 +
 mm/page-writeback.c                   |   7 +-
 mm/page_io.c                          |   6 +-
 mm/readahead.c                        |  24 +-
 mm/shmem.c                            |   2 +-
 mm/swap.c                             |  40 ++-
 mm/swapfile.c                         |   6 +-
 mm/util.c                             |  20 +-
 net/ceph/pagelist.c                   |   4 +-
 net/ceph/pagevec.c                    |   2 +-
 112 files changed, 983 insertions(+), 752 deletions(-)

-- 
2.29.2

