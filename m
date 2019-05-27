Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3540F2B231
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 12:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfE0KcT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 06:32:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:52392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726280AbfE0KcQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 06:32:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 45060AE79;
        Mon, 27 May 2019 10:32:12 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mm@kvack.org
Cc:     Juergen Gross <jgross@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH 2/3] mm: remove cleancache.c
Date:   Mon, 27 May 2019 12:32:06 +0200
Message-Id: <20190527103207.13287-3-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190527103207.13287-1-jgross@suse.com>
References: <20190527103207.13287-1-jgross@suse.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the removal of tmem and xen-selfballoon the only user of
cleancache is gone. Remove it, too.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 Documentation/vm/cleancache.rst  | 296 ------------------------------------
 Documentation/vm/frontswap.rst   |  10 +-
 Documentation/vm/index.rst       |   1 -
 MAINTAINERS                      |   7 -
 drivers/staging/erofs/data.c     |   6 -
 drivers/staging/erofs/internal.h |   1 -
 fs/block_dev.c                   |   5 -
 fs/btrfs/extent_io.c             |   9 --
 fs/btrfs/super.c                 |   2 -
 fs/ext4/readpage.c               |   6 -
 fs/ext4/super.c                  |   2 -
 fs/f2fs/data.c                   |   3 +-
 fs/mpage.c                       |   7 -
 fs/ocfs2/super.c                 |   2 -
 fs/super.c                       |   3 -
 include/linux/cleancache.h       | 124 ---------------
 include/linux/fs.h               |   5 -
 mm/Kconfig                       |  22 ---
 mm/Makefile                      |   1 -
 mm/cleancache.c                  | 317 ---------------------------------------
 mm/filemap.c                     |  11 --
 mm/truncate.c                    |  15 +-
 22 files changed, 10 insertions(+), 845 deletions(-)
 delete mode 100644 Documentation/vm/cleancache.rst
 delete mode 100644 include/linux/cleancache.h
 delete mode 100644 mm/cleancache.c

diff --git a/Documentation/vm/cleancache.rst b/Documentation/vm/cleancache.rst
deleted file mode 100644
index 68cba9131c31..000000000000
--- a/Documentation/vm/cleancache.rst
+++ /dev/null
@@ -1,296 +0,0 @@
-.. _cleancache:
-
-==========
-Cleancache
-==========
-
-Motivation
-==========
-
-Cleancache is a new optional feature provided by the VFS layer that
-potentially dramatically increases page cache effectiveness for
-many workloads in many environments at a negligible cost.
-
-Cleancache can be thought of as a page-granularity victim cache for clean
-pages that the kernel's pageframe replacement algorithm (PFRA) would like
-to keep around, but can't since there isn't enough memory.  So when the
-PFRA "evicts" a page, it first attempts to use cleancache code to
-put the data contained in that page into "transcendent memory", memory
-that is not directly accessible or addressable by the kernel and is
-of unknown and possibly time-varying size.
-
-Later, when a cleancache-enabled filesystem wishes to access a page
-in a file on disk, it first checks cleancache to see if it already
-contains it; if it does, the page of data is copied into the kernel
-and a disk access is avoided.
-
-Transcendent memory "drivers" for cleancache are currently implemented
-in Xen (using hypervisor memory) and zcache (using in-kernel compressed
-memory) and other implementations are in development.
-
-:ref:`FAQs <faq>` are included below.
-
-Implementation Overview
-=======================
-
-A cleancache "backend" that provides transcendent memory registers itself
-to the kernel's cleancache "frontend" by calling cleancache_register_ops,
-passing a pointer to a cleancache_ops structure with funcs set appropriately.
-The functions provided must conform to certain semantics as follows:
-
-Most important, cleancache is "ephemeral".  Pages which are copied into
-cleancache have an indefinite lifetime which is completely unknowable
-by the kernel and so may or may not still be in cleancache at any later time.
-Thus, as its name implies, cleancache is not suitable for dirty pages.
-Cleancache has complete discretion over what pages to preserve and what
-pages to discard and when.
-
-Mounting a cleancache-enabled filesystem should call "init_fs" to obtain a
-pool id which, if positive, must be saved in the filesystem's superblock;
-a negative return value indicates failure.  A "put_page" will copy a
-(presumably about-to-be-evicted) page into cleancache and associate it with
-the pool id, a file key, and a page index into the file.  (The combination
-of a pool id, a file key, and an index is sometimes called a "handle".)
-A "get_page" will copy the page, if found, from cleancache into kernel memory.
-An "invalidate_page" will ensure the page no longer is present in cleancache;
-an "invalidate_inode" will invalidate all pages associated with the specified
-file; and, when a filesystem is unmounted, an "invalidate_fs" will invalidate
-all pages in all files specified by the given pool id and also surrender
-the pool id.
-
-An "init_shared_fs", like init_fs, obtains a pool id but tells cleancache
-to treat the pool as shared using a 128-bit UUID as a key.  On systems
-that may run multiple kernels (such as hard partitioned or virtualized
-systems) that may share a clustered filesystem, and where cleancache
-may be shared among those kernels, calls to init_shared_fs that specify the
-same UUID will receive the same pool id, thus allowing the pages to
-be shared.  Note that any security requirements must be imposed outside
-of the kernel (e.g. by "tools" that control cleancache).  Or a
-cleancache implementation can simply disable shared_init by always
-returning a negative value.
-
-If a get_page is successful on a non-shared pool, the page is invalidated
-(thus making cleancache an "exclusive" cache).  On a shared pool, the page
-is NOT invalidated on a successful get_page so that it remains accessible to
-other sharers.  The kernel is responsible for ensuring coherency between
-cleancache (shared or not), the page cache, and the filesystem, using
-cleancache invalidate operations as required.
-
-Note that cleancache must enforce put-put-get coherency and get-get
-coherency.  For the former, if two puts are made to the same handle but
-with different data, say AAA by the first put and BBB by the second, a
-subsequent get can never return the stale data (AAA).  For get-get coherency,
-if a get for a given handle fails, subsequent gets for that handle will
-never succeed unless preceded by a successful put with that handle.
-
-Last, cleancache provides no SMP serialization guarantees; if two
-different Linux threads are simultaneously putting and invalidating a page
-with the same handle, the results are indeterminate.  Callers must
-lock the page to ensure serial behavior.
-
-Cleancache Performance Metrics
-==============================
-
-If properly configured, monitoring of cleancache is done via debugfs in
-the `/sys/kernel/debug/cleancache` directory.  The effectiveness of cleancache
-can be measured (across all filesystems) with:
-
-``succ_gets``
-	number of gets that were successful
-
-``failed_gets``
-	number of gets that failed
-
-``puts``
-	number of puts attempted (all "succeed")
-
-``invalidates``
-	number of invalidates attempted
-
-A backend implementation may provide additional metrics.
-
-.. _faq:
-
-FAQ
-===
-
-* Where's the value? (Andrew Morton)
-
-Cleancache provides a significant performance benefit to many workloads
-in many environments with negligible overhead by improving the
-effectiveness of the pagecache.  Clean pagecache pages are
-saved in transcendent memory (RAM that is otherwise not directly
-addressable to the kernel); fetching those pages later avoids "refaults"
-and thus disk reads.
-
-Cleancache (and its sister code "frontswap") provide interfaces for
-this transcendent memory (aka "tmem"), which conceptually lies between
-fast kernel-directly-addressable RAM and slower DMA/asynchronous devices.
-Disallowing direct kernel or userland reads/writes to tmem
-is ideal when data is transformed to a different form and size (such
-as with compression) or secretly moved (as might be useful for write-
-balancing for some RAM-like devices).  Evicted page-cache pages (and
-swap pages) are a great use for this kind of slower-than-RAM-but-much-
-faster-than-disk transcendent memory, and the cleancache (and frontswap)
-"page-object-oriented" specification provides a nice way to read and
-write -- and indirectly "name" -- the pages.
-
-In the virtual case, the whole point of virtualization is to statistically
-multiplex physical resources across the varying demands of multiple
-virtual machines.  This is really hard to do with RAM and efforts to
-do it well with no kernel change have essentially failed (except in some
-well-publicized special-case workloads).  Cleancache -- and frontswap --
-with a fairly small impact on the kernel, provide a huge amount
-of flexibility for more dynamic, flexible RAM multiplexing.
-Specifically, the Xen Transcendent Memory backend allows otherwise
-"fallow" hypervisor-owned RAM to not only be "time-shared" between multiple
-virtual machines, but the pages can be compressed and deduplicated to
-optimize RAM utilization.  And when guest OS's are induced to surrender
-underutilized RAM (e.g. with "self-ballooning"), page cache pages
-are the first to go, and cleancache allows those pages to be
-saved and reclaimed if overall host system memory conditions allow.
-
-And the identical interface used for cleancache can be used in
-physical systems as well.  The zcache driver acts as a memory-hungry
-device that stores pages of data in a compressed state.  And
-the proposed "RAMster" driver shares RAM across multiple physical
-systems.
-
-* Why does cleancache have its sticky fingers so deep inside the
-  filesystems and VFS? (Andrew Morton and Christoph Hellwig)
-
-The core hooks for cleancache in VFS are in most cases a single line
-and the minimum set are placed precisely where needed to maintain
-coherency (via cleancache_invalidate operations) between cleancache,
-the page cache, and disk.  All hooks compile into nothingness if
-cleancache is config'ed off and turn into a function-pointer-
-compare-to-NULL if config'ed on but no backend claims the ops
-functions, or to a compare-struct-element-to-negative if a
-backend claims the ops functions but a filesystem doesn't enable
-cleancache.
-
-Some filesystems are built entirely on top of VFS and the hooks
-in VFS are sufficient, so don't require an "init_fs" hook; the
-initial implementation of cleancache didn't provide this hook.
-But for some filesystems (such as btrfs), the VFS hooks are
-incomplete and one or more hooks in fs-specific code are required.
-And for some other filesystems, such as tmpfs, cleancache may
-be counterproductive.  So it seemed prudent to require a filesystem
-to "opt in" to use cleancache, which requires adding a hook in
-each filesystem.  Not all filesystems are supported by cleancache
-only because they haven't been tested.  The existing set should
-be sufficient to validate the concept, the opt-in approach means
-that untested filesystems are not affected, and the hooks in the
-existing filesystems should make it very easy to add more
-filesystems in the future.
-
-The total impact of the hooks to existing fs and mm files is only
-about 40 lines added (not counting comments and blank lines).
-
-* Why not make cleancache asynchronous and batched so it can more
-  easily interface with real devices with DMA instead of copying each
-  individual page? (Minchan Kim)
-
-The one-page-at-a-time copy semantics simplifies the implementation
-on both the frontend and backend and also allows the backend to
-do fancy things on-the-fly like page compression and
-page deduplication.  And since the data is "gone" (copied into/out
-of the pageframe) before the cleancache get/put call returns,
-a great deal of race conditions and potential coherency issues
-are avoided.  While the interface seems odd for a "real device"
-or for real kernel-addressable RAM, it makes perfect sense for
-transcendent memory.
-
-* Why is non-shared cleancache "exclusive"?  And where is the
-  page "invalidated" after a "get"? (Minchan Kim)
-
-The main reason is to free up space in transcendent memory and
-to avoid unnecessary cleancache_invalidate calls.  If you want inclusive,
-the page can be "put" immediately following the "get".  If
-put-after-get for inclusive becomes common, the interface could
-be easily extended to add a "get_no_invalidate" call.
-
-The invalidate is done by the cleancache backend implementation.
-
-* What's the performance impact?
-
-Performance analysis has been presented at OLS'09 and LCA'10.
-Briefly, performance gains can be significant on most workloads,
-especially when memory pressure is high (e.g. when RAM is
-overcommitted in a virtual workload); and because the hooks are
-invoked primarily in place of or in addition to a disk read/write,
-overhead is negligible even in worst case workloads.  Basically
-cleancache replaces I/O with memory-copy-CPU-overhead; on older
-single-core systems with slow memory-copy speeds, cleancache
-has little value, but in newer multicore machines, especially
-consolidated/virtualized machines, it has great value.
-
-* How do I add cleancache support for filesystem X? (Boaz Harrash)
-
-Filesystems that are well-behaved and conform to certain
-restrictions can utilize cleancache simply by making a call to
-cleancache_init_fs at mount time.  Unusual, misbehaving, or
-poorly layered filesystems must either add additional hooks
-and/or undergo extensive additional testing... or should just
-not enable the optional cleancache.
-
-Some points for a filesystem to consider:
-
-  - The FS should be block-device-based (e.g. a ram-based FS such
-    as tmpfs should not enable cleancache)
-  - To ensure coherency/correctness, the FS must ensure that all
-    file removal or truncation operations either go through VFS or
-    add hooks to do the equivalent cleancache "invalidate" operations
-  - To ensure coherency/correctness, either inode numbers must
-    be unique across the lifetime of the on-disk file OR the
-    FS must provide an "encode_fh" function.
-  - The FS must call the VFS superblock alloc and deactivate routines
-    or add hooks to do the equivalent cleancache calls done there.
-  - To maximize performance, all pages fetched from the FS should
-    go through the do_mpag_readpage routine or the FS should add
-    hooks to do the equivalent (cf. btrfs)
-  - Currently, the FS blocksize must be the same as PAGESIZE.  This
-    is not an architectural restriction, but no backends currently
-    support anything different.
-  - A clustered FS should invoke the "shared_init_fs" cleancache
-    hook to get best performance for some backends.
-
-* Why not use the KVA of the inode as the key? (Christoph Hellwig)
-
-If cleancache would use the inode virtual address instead of
-inode/filehandle, the pool id could be eliminated.  But, this
-won't work because cleancache retains pagecache data pages
-persistently even when the inode has been pruned from the
-inode unused list, and only invalidates the data page if the file
-gets removed/truncated.  So if cleancache used the inode kva,
-there would be potential coherency issues if/when the inode
-kva is reused for a different file.  Alternately, if cleancache
-invalidated the pages when the inode kva was freed, much of the value
-of cleancache would be lost because the cache of pages in cleanache
-is potentially much larger than the kernel pagecache and is most
-useful if the pages survive inode cache removal.
-
-* Why is a global variable required?
-
-The cleancache_enabled flag is checked in all of the frequently-used
-cleancache hooks.  The alternative is a function call to check a static
-variable. Since cleancache is enabled dynamically at runtime, systems
-that don't enable cleancache would suffer thousands (possibly
-tens-of-thousands) of unnecessary function calls per second.  So the
-global variable allows cleancache to be enabled by default at compile
-time, but have insignificant performance impact when cleancache remains
-disabled at runtime.
-
-* Does cleanache work with KVM?
-
-The memory model of KVM is sufficiently different that a cleancache
-backend may have less value for KVM.  This remains to be tested,
-especially in an overcommitted system.
-
-* Does cleancache work in userspace?  It sounds useful for
-  memory hungry caches like web browsers.  (Jamie Lokier)
-
-No plans yet, though we agree it sounds useful, at least for
-apps that bypass the page cache (e.g. O_DIRECT).
-
-Last updated: Dan Magenheimer, April 13 2011
diff --git a/Documentation/vm/frontswap.rst b/Documentation/vm/frontswap.rst
index 1979f430c1c5..511c921bc8d2 100644
--- a/Documentation/vm/frontswap.rst
+++ b/Documentation/vm/frontswap.rst
@@ -8,8 +8,8 @@ Frontswap provides a "transcendent memory" interface for swap pages.
 In some environments, dramatic performance savings may be obtained because
 swapped pages are saved in RAM (or a RAM-like device) instead of a swap disk.
 
-(Note, frontswap -- and :ref:`cleancache` (merged at 3.0) -- are the "frontends"
-and the only necessary changes to the core kernel for transcendent memory;
+(Note, frontswap is the "frontend"
+and the only necessary change to the core kernel for transcendent memory;
 all other supporting code -- the "backends" -- is implemented as drivers.
 See the LWN.net article `Transcendent memory in a nutshell`_
 for a detailed overview of frontswap and related kernel parts)
@@ -87,11 +87,11 @@ This interface is ideal when data is transformed to a different form
 and size (such as with compression) or secretly moved (as might be
 useful for write-balancing for some RAM-like devices).  Swap pages (and
 evicted page-cache pages) are a great use for this kind of slower-than-RAM-
-but-much-faster-than-disk "pseudo-RAM device" and the frontswap (and
-cleancache) interface to transcendent memory provides a nice way to read
+but-much-faster-than-disk "pseudo-RAM device" and the frontswap
+interface to transcendent memory provides a nice way to read
 and write -- and indirectly "name" -- the pages.
 
-Frontswap -- and cleancache -- with a fairly small impact on the kernel,
+Frontswap with a fairly small impact on the kernel,
 provides a huge amount of flexibility for more dynamic, flexible RAM
 utilization in various system configurations:
 
diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
index e8d943b21cf9..9e42be5f0c44 100644
--- a/Documentation/vm/index.rst
+++ b/Documentation/vm/index.rst
@@ -30,7 +30,6 @@ descriptions of data structures and algorithms.
 
    active_mm
    balance
-   cleancache
    frontswap
    highmem
    hmm
diff --git a/MAINTAINERS b/MAINTAINERS
index 2336dd26ece4..d33b46475629 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3928,13 +3928,6 @@ M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
 S:	Maintained
 F:	.clang-format
 
-CLEANCACHE API
-M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
-L:	linux-kernel@vger.kernel.org
-S:	Maintained
-F:	mm/cleancache.c
-F:	include/linux/cleancache.h
-
 CLK API
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-clk@vger.kernel.org
diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
index 746685f90564..0f5f9429a01c 100644
--- a/drivers/staging/erofs/data.c
+++ b/drivers/staging/erofs/data.c
@@ -205,12 +205,6 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 		goto has_updated;
 	}
 
-	if (cleancache_get_page(page) == 0) {
-		err = 0;
-		SetPageUptodate(page);
-		goto has_updated;
-	}
-
 	/* note that for readpage case, bio also equals to NULL */
 	if (bio &&
 	    /* not continuous */
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index c47778b3fabd..a31b26b28985 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -19,7 +19,6 @@
 #include <linux/pagemap.h>
 #include <linux/bio.h>
 #include <linux/buffer_head.h>
-#include <linux/cleancache.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include "erofs_fs.h"
diff --git a/fs/block_dev.c b/fs/block_dev.c
index e6886c93c89d..5ddd460a927b 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -29,7 +29,6 @@
 #include <linux/uio.h>
 #include <linux/namei.h>
 #include <linux/log2.h>
-#include <linux/cleancache.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/falloc.h>
 #include <linux/uaccess.h>
@@ -96,10 +95,6 @@ void invalidate_bdev(struct block_device *bdev)
 		lru_add_drain_all();	/* make sure all lru add caches are flushed */
 		invalidate_mapping_pages(mapping, 0, -1);
 	}
-	/* 99% of the time, we don't need to flush the cleancache on the bdev.
-	 * But, for the strange corners, lets be cautious
-	 */
-	cleancache_invalidate_inode(mapping);
 }
 EXPORT_SYMBOL(invalidate_bdev);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index db337e53aab3..07f468b4dcea 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -12,7 +12,6 @@
 #include <linux/writeback.h>
 #include <linux/pagevec.h>
 #include <linux/prefetch.h>
-#include <linux/cleancache.h>
 #include "extent_io.h"
 #include "extent_map.h"
 #include "ctree.h"
@@ -3015,14 +3014,6 @@ static int __do_readpage(struct extent_io_tree *tree,
 
 	set_page_extent_mapped(page);
 
-	if (!PageUptodate(page)) {
-		if (cleancache_get_page(page) == 0) {
-			BUG_ON(blocksize != PAGE_SIZE);
-			unlock_extent(tree, start, end);
-			goto out;
-		}
-	}
-
 	if (page->index == last_byte >> PAGE_SHIFT) {
 		char *userpage;
 		size_t zero_offset = offset_in_page(last_byte);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 0645ec428b4f..707f0096b437 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -23,7 +23,6 @@
 #include <linux/miscdevice.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
-#include <linux/cleancache.h>
 #include <linux/ratelimit.h>
 #include <linux/crc32c.h>
 #include <linux/btrfs.h>
@@ -1228,7 +1227,6 @@ static int btrfs_fill_super(struct super_block *sb,
 		goto fail_close;
 	}
 
-	cleancache_init_fs(sb);
 	sb->s_flags |= SB_ACTIVE;
 	return 0;
 
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index c916017db334..5b471552e794 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -43,7 +43,6 @@
 #include <linux/writeback.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
-#include <linux/cleancache.h>
 
 #include "ext4.h"
 
@@ -225,11 +224,6 @@ int ext4_mpage_readpages(struct address_space *mapping,
 		} else if (fully_mapped) {
 			SetPageMappedToDisk(page);
 		}
-		if (fully_mapped && blocks_per_page == 1 &&
-		    !PageUptodate(page) && cleancache_get_page(page) == 0) {
-			SetPageUptodate(page);
-			goto confused;
-		}
 
 		/*
 		 * This page will go to BIO.  Do we need to send this
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4079605d437a..04d083364497 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -39,7 +39,6 @@
 #include <linux/log2.h>
 #include <linux/crc16.h>
 #include <linux/dax.h>
-#include <linux/cleancache.h>
 #include <linux/uaccess.h>
 #include <linux/iversion.h>
 #include <linux/unicode.h>
@@ -2307,7 +2306,6 @@ static int ext4_setup_super(struct super_block *sb, struct ext4_super_block *es,
 			EXT4_INODES_PER_GROUP(sb),
 			sbi->s_mount_opt, sbi->s_mount_opt2);
 
-	cleancache_init_fs(sb);
 	return err;
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index eda4181d2092..935c98ef6169 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -16,7 +16,6 @@
 #include <linux/bio.h>
 #include <linux/prefetch.h>
 #include <linux/uio.h>
-#include <linux/cleancache.h>
 #include <linux/sched/signal.h>
 
 #include "f2fs.h"
@@ -1563,7 +1562,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 		block_nr = map->m_pblk + block_in_file - map->m_lblk;
 		SetPageMappedToDisk(page);
 
-		if (!PageUptodate(page) && !cleancache_get_page(page)) {
+		if (!PageUptodate(page)) {
 			SetPageUptodate(page);
 			goto confused;
 		}
diff --git a/fs/mpage.c b/fs/mpage.c
index 436a85260394..744b18ec3d98 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -29,7 +29,6 @@
 #include <linux/writeback.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
-#include <linux/cleancache.h>
 #include "internal.h"
 
 /*
@@ -284,12 +283,6 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 		SetPageMappedToDisk(page);
 	}
 
-	if (fully_mapped && blocks_per_page == 1 && !PageUptodate(page) &&
-	    cleancache_get_page(page) == 0) {
-		SetPageUptodate(page);
-		goto confused;
-	}
-
 	/*
 	 * This page will go to BIO.  Do we need to send this BIO off first?
 	 */
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 8821bc7b9c72..b3f18d3b9da0 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -41,7 +41,6 @@
 #include <linux/mount.h>
 #include <linux/seq_file.h>
 #include <linux/quotaops.h>
-#include <linux/cleancache.h>
 #include <linux/signal.h>
 
 #define CREATE_TRACE_POINTS
@@ -2328,7 +2327,6 @@ static int ocfs2_initialize_super(struct super_block *sb,
 		mlog_errno(status);
 		goto bail;
 	}
-	cleancache_init_shared_fs(sb);
 
 	osb->ocfs2_wq = alloc_ordered_workqueue("ocfs2_wq", WQ_MEM_RECLAIM);
 	if (!osb->ocfs2_wq) {
diff --git a/fs/super.c b/fs/super.c
index 2739f57515f8..5ce5121e9e76 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -31,7 +31,6 @@
 #include <linux/mutex.h>
 #include <linux/backing-dev.h>
 #include <linux/rculist_bl.h>
-#include <linux/cleancache.h>
 #include <linux/fsnotify.h>
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
@@ -257,7 +256,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_maxbytes = MAX_NON_LFS;
 	s->s_op = &default_op;
 	s->s_time_gran = 1000000000;
-	s->cleancache_poolid = CLEANCACHE_NO_POOL;
 
 	s->s_shrink.seeks = DEFAULT_SEEKS;
 	s->s_shrink.scan_objects = super_cache_scan;
@@ -326,7 +324,6 @@ void deactivate_locked_super(struct super_block *s)
 {
 	struct file_system_type *fs = s->s_type;
 	if (atomic_dec_and_test(&s->s_active)) {
-		cleancache_invalidate_fs(s);
 		unregister_shrinker(&s->s_shrink);
 		fs->kill_sb(s);
 
diff --git a/include/linux/cleancache.h b/include/linux/cleancache.h
deleted file mode 100644
index 5f5730c1d324..000000000000
--- a/include/linux/cleancache.h
+++ /dev/null
@@ -1,124 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_CLEANCACHE_H
-#define _LINUX_CLEANCACHE_H
-
-#include <linux/fs.h>
-#include <linux/exportfs.h>
-#include <linux/mm.h>
-
-#define CLEANCACHE_NO_POOL		-1
-#define CLEANCACHE_NO_BACKEND		-2
-#define CLEANCACHE_NO_BACKEND_SHARED	-3
-
-#define CLEANCACHE_KEY_MAX 6
-
-/*
- * cleancache requires every file with a page in cleancache to have a
- * unique key unless/until the file is removed/truncated.  For some
- * filesystems, the inode number is unique, but for "modern" filesystems
- * an exportable filehandle is required (see exportfs.h)
- */
-struct cleancache_filekey {
-	union {
-		ino_t ino;
-		__u32 fh[CLEANCACHE_KEY_MAX];
-		u32 key[CLEANCACHE_KEY_MAX];
-	} u;
-};
-
-struct cleancache_ops {
-	int (*init_fs)(size_t);
-	int (*init_shared_fs)(uuid_t *uuid, size_t);
-	int (*get_page)(int, struct cleancache_filekey,
-			pgoff_t, struct page *);
-	void (*put_page)(int, struct cleancache_filekey,
-			pgoff_t, struct page *);
-	void (*invalidate_page)(int, struct cleancache_filekey, pgoff_t);
-	void (*invalidate_inode)(int, struct cleancache_filekey);
-	void (*invalidate_fs)(int);
-};
-
-extern int cleancache_register_ops(const struct cleancache_ops *ops);
-extern void __cleancache_init_fs(struct super_block *);
-extern void __cleancache_init_shared_fs(struct super_block *);
-extern int  __cleancache_get_page(struct page *);
-extern void __cleancache_put_page(struct page *);
-extern void __cleancache_invalidate_page(struct address_space *, struct page *);
-extern void __cleancache_invalidate_inode(struct address_space *);
-extern void __cleancache_invalidate_fs(struct super_block *);
-
-#ifdef CONFIG_CLEANCACHE
-#define cleancache_enabled (1)
-static inline bool cleancache_fs_enabled_mapping(struct address_space *mapping)
-{
-	return mapping->host->i_sb->cleancache_poolid >= 0;
-}
-static inline bool cleancache_fs_enabled(struct page *page)
-{
-	return cleancache_fs_enabled_mapping(page->mapping);
-}
-#else
-#define cleancache_enabled (0)
-#define cleancache_fs_enabled(_page) (0)
-#define cleancache_fs_enabled_mapping(_page) (0)
-#endif
-
-/*
- * The shim layer provided by these inline functions allows the compiler
- * to reduce all cleancache hooks to nothingness if CONFIG_CLEANCACHE
- * is disabled, to a single global variable check if CONFIG_CLEANCACHE
- * is enabled but no cleancache "backend" has dynamically enabled it,
- * and, for the most frequent cleancache ops, to a single global variable
- * check plus a superblock element comparison if CONFIG_CLEANCACHE is enabled
- * and a cleancache backend has dynamically enabled cleancache, but the
- * filesystem referenced by that cleancache op has not enabled cleancache.
- * As a result, CONFIG_CLEANCACHE can be enabled by default with essentially
- * no measurable performance impact.
- */
-
-static inline void cleancache_init_fs(struct super_block *sb)
-{
-	if (cleancache_enabled)
-		__cleancache_init_fs(sb);
-}
-
-static inline void cleancache_init_shared_fs(struct super_block *sb)
-{
-	if (cleancache_enabled)
-		__cleancache_init_shared_fs(sb);
-}
-
-static inline int cleancache_get_page(struct page *page)
-{
-	if (cleancache_enabled && cleancache_fs_enabled(page))
-		return __cleancache_get_page(page);
-	return -1;
-}
-
-static inline void cleancache_put_page(struct page *page)
-{
-	if (cleancache_enabled && cleancache_fs_enabled(page))
-		__cleancache_put_page(page);
-}
-
-static inline void cleancache_invalidate_page(struct address_space *mapping,
-					struct page *page)
-{
-	/* careful... page->mapping is NULL sometimes when this is called */
-	if (cleancache_enabled && cleancache_fs_enabled_mapping(mapping))
-		__cleancache_invalidate_page(mapping, page);
-}
-
-static inline void cleancache_invalidate_inode(struct address_space *mapping)
-{
-	if (cleancache_enabled && cleancache_fs_enabled_mapping(mapping))
-		__cleancache_invalidate_inode(mapping);
-}
-
-static inline void cleancache_invalidate_fs(struct super_block *sb)
-{
-	if (cleancache_enabled)
-		__cleancache_invalidate_fs(sb);
-}
-
-#endif /* _LINUX_CLEANCACHE_H */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d..a2a965bd30f2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1475,11 +1475,6 @@ struct super_block {
 
 	const struct dentry_operations *s_d_op; /* default d_op for dentries */
 
-	/*
-	 * Saved pool identifier for cleancache (-1 means none)
-	 */
-	int cleancache_poolid;
-
 	struct shrinker s_shrink;	/* per-sb shrinker handle */
 
 	/* Number of inodes with nlink == 0 but still referenced */
diff --git a/mm/Kconfig b/mm/Kconfig
index f0c76ba47695..5166fe4af00b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -435,28 +435,6 @@ config NEED_PER_CPU_KM
 	bool
 	default y
 
-config CLEANCACHE
-	bool "Enable cleancache driver to cache clean pages if tmem is present"
-	help
-	  Cleancache can be thought of as a page-granularity victim cache
-	  for clean pages that the kernel's pageframe replacement algorithm
-	  (PFRA) would like to keep around, but can't since there isn't enough
-	  memory.  So when the PFRA "evicts" a page, it first attempts to use
-	  cleancache code to put the data contained in that page into
-	  "transcendent memory", memory that is not directly accessible or
-	  addressable by the kernel and is of unknown and possibly
-	  time-varying size.  And when a cleancache-enabled
-	  filesystem wishes to access a page in a file on disk, it first
-	  checks cleancache to see if it already contains it; if it does,
-	  the page is copied into the kernel and a disk access is avoided.
-	  When a transcendent memory driver is available (such as zcache or
-	  Xen transcendent memory), a significant I/O reduction
-	  may be achieved.  When none is available, all cleancache calls
-	  are reduced to a single pointer-compare-against-NULL resulting
-	  in a negligible performance hit.
-
-	  If unsure, say Y to enable cleancache
-
 config FRONTSWAP
 	bool "Enable frontswap to cache swap pages if tmem is present"
 	depends on SWAP
diff --git a/mm/Makefile b/mm/Makefile
index ac5e5ba78874..312cc7de894c 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -85,7 +85,6 @@ obj-$(CONFIG_DEBUG_KMEMLEAK) += kmemleak.o
 obj-$(CONFIG_DEBUG_KMEMLEAK_TEST) += kmemleak-test.o
 obj-$(CONFIG_DEBUG_RODATA_TEST) += rodata_test.o
 obj-$(CONFIG_PAGE_OWNER) += page_owner.o
-obj-$(CONFIG_CLEANCACHE) += cleancache.o
 obj-$(CONFIG_MEMORY_ISOLATION) += page_isolation.o
 obj-$(CONFIG_ZPOOL)	+= zpool.o
 obj-$(CONFIG_ZBUD)	+= zbud.o
diff --git a/mm/cleancache.c b/mm/cleancache.c
deleted file mode 100644
index 2bf12da9baa0..000000000000
--- a/mm/cleancache.c
+++ /dev/null
@@ -1,317 +0,0 @@
-/*
- * Cleancache frontend
- *
- * This code provides the generic "frontend" layer to call a matching
- * "backend" driver implementation of cleancache.  See
- * Documentation/vm/cleancache.rst for more information.
- *
- * Copyright (C) 2009-2010 Oracle Corp. All rights reserved.
- * Author: Dan Magenheimer
- *
- * This work is licensed under the terms of the GNU GPL, version 2.
- */
-
-#include <linux/module.h>
-#include <linux/fs.h>
-#include <linux/exportfs.h>
-#include <linux/mm.h>
-#include <linux/debugfs.h>
-#include <linux/cleancache.h>
-
-/*
- * cleancache_ops is set by cleancache_register_ops to contain the pointers
- * to the cleancache "backend" implementation functions.
- */
-static const struct cleancache_ops *cleancache_ops __read_mostly;
-
-/*
- * Counters available via /sys/kernel/debug/cleancache (if debugfs is
- * properly configured.  These are for information only so are not protected
- * against increment races.
- */
-static u64 cleancache_succ_gets;
-static u64 cleancache_failed_gets;
-static u64 cleancache_puts;
-static u64 cleancache_invalidates;
-
-static void cleancache_register_ops_sb(struct super_block *sb, void *unused)
-{
-	switch (sb->cleancache_poolid) {
-	case CLEANCACHE_NO_BACKEND:
-		__cleancache_init_fs(sb);
-		break;
-	case CLEANCACHE_NO_BACKEND_SHARED:
-		__cleancache_init_shared_fs(sb);
-		break;
-	}
-}
-
-/*
- * Register operations for cleancache. Returns 0 on success.
- */
-int cleancache_register_ops(const struct cleancache_ops *ops)
-{
-	if (cmpxchg(&cleancache_ops, NULL, ops))
-		return -EBUSY;
-
-	/*
-	 * A cleancache backend can be built as a module and hence loaded after
-	 * a cleancache enabled filesystem has called cleancache_init_fs. To
-	 * handle such a scenario, here we call ->init_fs or ->init_shared_fs
-	 * for each active super block. To differentiate between local and
-	 * shared filesystems, we temporarily initialize sb->cleancache_poolid
-	 * to CLEANCACHE_NO_BACKEND or CLEANCACHE_NO_BACKEND_SHARED
-	 * respectively in case there is no backend registered at the time
-	 * cleancache_init_fs or cleancache_init_shared_fs is called.
-	 *
-	 * Since filesystems can be mounted concurrently with cleancache
-	 * backend registration, we have to be careful to guarantee that all
-	 * cleancache enabled filesystems that has been mounted by the time
-	 * cleancache_register_ops is called has got and all mounted later will
-	 * get cleancache_poolid. This is assured by the following statements
-	 * tied together:
-	 *
-	 * a) iterate_supers skips only those super blocks that has started
-	 *    ->kill_sb
-	 *
-	 * b) if iterate_supers encounters a super block that has not finished
-	 *    ->mount yet, it waits until it is finished
-	 *
-	 * c) cleancache_init_fs is called from ->mount and
-	 *    cleancache_invalidate_fs is called from ->kill_sb
-	 *
-	 * d) we call iterate_supers after cleancache_ops has been set
-	 *
-	 * From a) it follows that if iterate_supers skips a super block, then
-	 * either the super block is already dead, in which case we do not need
-	 * to bother initializing cleancache for it, or it was mounted after we
-	 * initiated iterate_supers. In the latter case, it must have seen
-	 * cleancache_ops set according to d) and initialized cleancache from
-	 * ->mount by itself according to c). This proves that we call
-	 * ->init_fs at least once for each active super block.
-	 *
-	 * From b) and c) it follows that if iterate_supers encounters a super
-	 * block that has already started ->init_fs, it will wait until ->mount
-	 * and hence ->init_fs has finished, then check cleancache_poolid, see
-	 * that it has already been set and therefore do nothing. This proves
-	 * that we call ->init_fs no more than once for each super block.
-	 *
-	 * Combined together, the last two paragraphs prove the function
-	 * correctness.
-	 *
-	 * Note that various cleancache callbacks may proceed before this
-	 * function is called or even concurrently with it, but since
-	 * CLEANCACHE_NO_BACKEND is negative, they will all result in a noop
-	 * until the corresponding ->init_fs has been actually called and
-	 * cleancache_ops has been set.
-	 */
-	iterate_supers(cleancache_register_ops_sb, NULL);
-	return 0;
-}
-EXPORT_SYMBOL(cleancache_register_ops);
-
-/* Called by a cleancache-enabled filesystem at time of mount */
-void __cleancache_init_fs(struct super_block *sb)
-{
-	int pool_id = CLEANCACHE_NO_BACKEND;
-
-	if (cleancache_ops) {
-		pool_id = cleancache_ops->init_fs(PAGE_SIZE);
-		if (pool_id < 0)
-			pool_id = CLEANCACHE_NO_POOL;
-	}
-	sb->cleancache_poolid = pool_id;
-}
-EXPORT_SYMBOL(__cleancache_init_fs);
-
-/* Called by a cleancache-enabled clustered filesystem at time of mount */
-void __cleancache_init_shared_fs(struct super_block *sb)
-{
-	int pool_id = CLEANCACHE_NO_BACKEND_SHARED;
-
-	if (cleancache_ops) {
-		pool_id = cleancache_ops->init_shared_fs(&sb->s_uuid, PAGE_SIZE);
-		if (pool_id < 0)
-			pool_id = CLEANCACHE_NO_POOL;
-	}
-	sb->cleancache_poolid = pool_id;
-}
-EXPORT_SYMBOL(__cleancache_init_shared_fs);
-
-/*
- * If the filesystem uses exportable filehandles, use the filehandle as
- * the key, else use the inode number.
- */
-static int cleancache_get_key(struct inode *inode,
-			      struct cleancache_filekey *key)
-{
-	int (*fhfn)(struct inode *, __u32 *fh, int *, struct inode *);
-	int len = 0, maxlen = CLEANCACHE_KEY_MAX;
-	struct super_block *sb = inode->i_sb;
-
-	key->u.ino = inode->i_ino;
-	if (sb->s_export_op != NULL) {
-		fhfn = sb->s_export_op->encode_fh;
-		if  (fhfn) {
-			len = (*fhfn)(inode, &key->u.fh[0], &maxlen, NULL);
-			if (len <= FILEID_ROOT || len == FILEID_INVALID)
-				return -1;
-			if (maxlen > CLEANCACHE_KEY_MAX)
-				return -1;
-		}
-	}
-	return 0;
-}
-
-/*
- * "Get" data from cleancache associated with the poolid/inode/index
- * that were specified when the data was put to cleanache and, if
- * successful, use it to fill the specified page with data and return 0.
- * The pageframe is unchanged and returns -1 if the get fails.
- * Page must be locked by caller.
- *
- * The function has two checks before any action is taken - whether
- * a backend is registered and whether the sb->cleancache_poolid
- * is correct.
- */
-int __cleancache_get_page(struct page *page)
-{
-	int ret = -1;
-	int pool_id;
-	struct cleancache_filekey key = { .u.key = { 0 } };
-
-	if (!cleancache_ops) {
-		cleancache_failed_gets++;
-		goto out;
-	}
-
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	pool_id = page->mapping->host->i_sb->cleancache_poolid;
-	if (pool_id < 0)
-		goto out;
-
-	if (cleancache_get_key(page->mapping->host, &key) < 0)
-		goto out;
-
-	ret = cleancache_ops->get_page(pool_id, key, page->index, page);
-	if (ret == 0)
-		cleancache_succ_gets++;
-	else
-		cleancache_failed_gets++;
-out:
-	return ret;
-}
-EXPORT_SYMBOL(__cleancache_get_page);
-
-/*
- * "Put" data from a page to cleancache and associate it with the
- * (previously-obtained per-filesystem) poolid and the page's,
- * inode and page index.  Page must be locked.  Note that a put_page
- * always "succeeds", though a subsequent get_page may succeed or fail.
- *
- * The function has two checks before any action is taken - whether
- * a backend is registered and whether the sb->cleancache_poolid
- * is correct.
- */
-void __cleancache_put_page(struct page *page)
-{
-	int pool_id;
-	struct cleancache_filekey key = { .u.key = { 0 } };
-
-	if (!cleancache_ops) {
-		cleancache_puts++;
-		return;
-	}
-
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	pool_id = page->mapping->host->i_sb->cleancache_poolid;
-	if (pool_id >= 0 &&
-		cleancache_get_key(page->mapping->host, &key) >= 0) {
-		cleancache_ops->put_page(pool_id, key, page->index, page);
-		cleancache_puts++;
-	}
-}
-EXPORT_SYMBOL(__cleancache_put_page);
-
-/*
- * Invalidate any data from cleancache associated with the poolid and the
- * page's inode and page index so that a subsequent "get" will fail.
- *
- * The function has two checks before any action is taken - whether
- * a backend is registered and whether the sb->cleancache_poolid
- * is correct.
- */
-void __cleancache_invalidate_page(struct address_space *mapping,
-					struct page *page)
-{
-	/* careful... page->mapping is NULL sometimes when this is called */
-	int pool_id = mapping->host->i_sb->cleancache_poolid;
-	struct cleancache_filekey key = { .u.key = { 0 } };
-
-	if (!cleancache_ops)
-		return;
-
-	if (pool_id >= 0) {
-		VM_BUG_ON_PAGE(!PageLocked(page), page);
-		if (cleancache_get_key(mapping->host, &key) >= 0) {
-			cleancache_ops->invalidate_page(pool_id,
-					key, page->index);
-			cleancache_invalidates++;
-		}
-	}
-}
-EXPORT_SYMBOL(__cleancache_invalidate_page);
-
-/*
- * Invalidate all data from cleancache associated with the poolid and the
- * mappings's inode so that all subsequent gets to this poolid/inode
- * will fail.
- *
- * The function has two checks before any action is taken - whether
- * a backend is registered and whether the sb->cleancache_poolid
- * is correct.
- */
-void __cleancache_invalidate_inode(struct address_space *mapping)
-{
-	int pool_id = mapping->host->i_sb->cleancache_poolid;
-	struct cleancache_filekey key = { .u.key = { 0 } };
-
-	if (!cleancache_ops)
-		return;
-
-	if (pool_id >= 0 && cleancache_get_key(mapping->host, &key) >= 0)
-		cleancache_ops->invalidate_inode(pool_id, key);
-}
-EXPORT_SYMBOL(__cleancache_invalidate_inode);
-
-/*
- * Called by any cleancache-enabled filesystem at time of unmount;
- * note that pool_id is surrendered and may be returned by a subsequent
- * cleancache_init_fs or cleancache_init_shared_fs.
- */
-void __cleancache_invalidate_fs(struct super_block *sb)
-{
-	int pool_id;
-
-	pool_id = sb->cleancache_poolid;
-	sb->cleancache_poolid = CLEANCACHE_NO_POOL;
-
-	if (cleancache_ops && pool_id >= 0)
-		cleancache_ops->invalidate_fs(pool_id);
-}
-EXPORT_SYMBOL(__cleancache_invalidate_fs);
-
-static int __init init_cleancache(void)
-{
-#ifdef CONFIG_DEBUG_FS
-	struct dentry *root = debugfs_create_dir("cleancache", NULL);
-	if (root == NULL)
-		return -ENXIO;
-	debugfs_create_u64("succ_gets", 0444, root, &cleancache_succ_gets);
-	debugfs_create_u64("failed_gets", 0444, root, &cleancache_failed_gets);
-	debugfs_create_u64("puts", 0444, root, &cleancache_puts);
-	debugfs_create_u64("invalidates", 0444, root, &cleancache_invalidates);
-#endif
-	return 0;
-}
-module_init(init_cleancache)
diff --git a/mm/filemap.c b/mm/filemap.c
index df2006ba0cfa..de7c4655d752 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -35,7 +35,6 @@
 #include <linux/cpuset.h>
 #include <linux/hugetlb.h>
 #include <linux/memcontrol.h>
-#include <linux/cleancache.h>
 #include <linux/shmem_fs.h>
 #include <linux/rmap.h>
 #include <linux/delayacct.h>
@@ -157,16 +156,6 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 {
 	int nr;
 
-	/*
-	 * if we're uptodate, flush out into the cleancache, otherwise
-	 * invalidate any existing cleancache entries.  We can't leave
-	 * stale data around in the cleancache once our page is gone
-	 */
-	if (PageUptodate(page) && PageMappedToDisk(page))
-		cleancache_put_page(page);
-	else
-		cleancache_invalidate_page(mapping, page);
-
 	VM_BUG_ON_PAGE(PageTail(page), page);
 	VM_BUG_ON_PAGE(page_mapped(page), page);
 	if (!IS_ENABLED(CONFIG_DEBUG_VM) && unlikely(page_mapped(page))) {
diff --git a/mm/truncate.c b/mm/truncate.c
index 8563339041f6..9eb4060b7a93 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -22,7 +22,6 @@
 #include <linux/buffer_head.h>	/* grr. try_to_release_page,
 				   do_invalidatepage */
 #include <linux/shmem_fs.h>
-#include <linux/cleancache.h>
 #include <linux/rmap.h>
 #include "internal.h"
 
@@ -301,7 +300,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	int		i;
 
 	if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
-		goto out;
+		return;
 
 	/* Offsets within partial pages */
 	partial_start = lstart & (PAGE_SIZE - 1);
@@ -382,7 +381,6 @@ void truncate_inode_pages_range(struct address_space *mapping,
 			}
 			wait_on_page_writeback(page);
 			zero_user_segment(page, partial_start, top);
-			cleancache_invalidate_page(mapping, page);
 			if (page_has_private(page))
 				do_invalidatepage(page, partial_start,
 						  top - partial_start);
@@ -395,7 +393,6 @@ void truncate_inode_pages_range(struct address_space *mapping,
 		if (page) {
 			wait_on_page_writeback(page);
 			zero_user_segment(page, 0, partial_end);
-			cleancache_invalidate_page(mapping, page);
 			if (page_has_private(page))
 				do_invalidatepage(page, 0,
 						  partial_end);
@@ -408,7 +405,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	 * will be released, just zeroed, so we can bail out now.
 	 */
 	if (start >= end)
-		goto out;
+		return;
 
 	index = start;
 	for ( ; ; ) {
@@ -453,9 +450,6 @@ void truncate_inode_pages_range(struct address_space *mapping,
 		pagevec_release(&pvec);
 		index++;
 	}
-
-out:
-	cleancache_invalidate_inode(mapping);
 }
 EXPORT_SYMBOL(truncate_inode_pages_range);
 
@@ -681,7 +675,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	int did_range_unmap = 0;
 
 	if (mapping->nrpages == 0 && mapping->nrexceptional == 0)
-		goto out;
+		return 0;
 
 	pagevec_init(&pvec);
 	index = start;
@@ -751,8 +745,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	if (dax_mapping(mapping)) {
 		unmap_mapping_pages(mapping, start, end - start + 1, false);
 	}
-out:
-	cleancache_invalidate_inode(mapping);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(invalidate_inode_pages2_range);
-- 
2.16.4

