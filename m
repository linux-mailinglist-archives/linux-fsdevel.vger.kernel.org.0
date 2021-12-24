Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4823647EC06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 07:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351499AbhLXGXF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Dec 2021 01:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbhLXGXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:23:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF49C061401;
        Thu, 23 Dec 2021 22:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qI7lXvvMoc0IufV+s1LYxI05hpwbc17U/Dwbb4fRDqw=; b=PF7RFoCdFoJcJYY3ubn/Mm950W
        Ik5wpFXsmm/YCMEZblrqY6meM3WKYBkARI4J+1+MPyY2TKaMAadHHlo7TnlbDiUqiX+wq6xLUMbIj
        xBk/9FTGKB3DKYHhm1L8AdhmBC73Eny43XDM47Oha2c1ziDculRwv1h8eiB2tYDemQpSepxDttpZZ
        B+m92AdIIQUdVTU9/0mvyMTLp4dSxvWKAss6+Wpi6VjbWg3YOxvXRPV4wgEJFVAWxEFpwHPV4Imx0
        w3ukXWAAIHh2e53VfgTfl1sQYLFenwQDidWKDNWRfN9oTcoBGC5Go62noU73Iw/0TOIZ85kTbIcp9
        RxedC6CQ==;
Received: from p4fdb0b85.dip0.t-ipconnect.de ([79.219.11.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0dye-00Dmz0-93; Fri, 24 Dec 2021 06:22:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 01/13] mm: remove cleancache
Date:   Fri, 24 Dec 2021 07:22:34 +0100
Message-Id: <20211224062246.1258487-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224062246.1258487-1-hch@lst.de>
References: <20211224062246.1258487-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The cleancache subsystem is unused since the removal of Xen tmem driver
in commit 814bbf49dcd0 ("xen: remove tmem driver").

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/vm/cleancache.rst      | 296 -------------------------
 Documentation/vm/frontswap.rst       |  12 +-
 Documentation/vm/index.rst           |   1 -
 MAINTAINERS                          |   7 -
 arch/arm/configs/bcm2835_defconfig   |   1 -
 arch/arm/configs/qcom_defconfig      |   1 -
 arch/m68k/configs/amiga_defconfig    |   1 -
 arch/m68k/configs/apollo_defconfig   |   1 -
 arch/m68k/configs/atari_defconfig    |   1 -
 arch/m68k/configs/bvme6000_defconfig |   1 -
 arch/m68k/configs/hp300_defconfig    |   1 -
 arch/m68k/configs/mac_defconfig      |   1 -
 arch/m68k/configs/multi_defconfig    |   1 -
 arch/m68k/configs/mvme147_defconfig  |   1 -
 arch/m68k/configs/mvme16x_defconfig  |   1 -
 arch/m68k/configs/q40_defconfig      |   1 -
 arch/m68k/configs/sun3_defconfig     |   1 -
 arch/m68k/configs/sun3x_defconfig    |   1 -
 arch/s390/configs/debug_defconfig    |   1 -
 arch/s390/configs/defconfig          |   1 -
 block/bdev.c                         |   5 -
 fs/btrfs/extent_io.c                 |  10 -
 fs/btrfs/super.c                     |   2 -
 fs/ext4/readpage.c                   |   6 -
 fs/ext4/super.c                      |   3 -
 fs/f2fs/data.c                       |   7 -
 fs/mpage.c                           |   7 -
 fs/ntfs3/ntfs_fs.h                   |   1 -
 fs/ocfs2/super.c                     |   2 -
 fs/super.c                           |   3 -
 include/linux/cleancache.h           | 124 -----------
 include/linux/fs.h                   |   5 -
 mm/Kconfig                           |  22 --
 mm/Makefile                          |   1 -
 mm/cleancache.c                      | 315 ---------------------------
 mm/filemap.c                         |  11 -
 mm/truncate.c                        |  15 +-
 37 files changed, 4 insertions(+), 867 deletions(-)
 delete mode 100644 Documentation/vm/cleancache.rst
 delete mode 100644 include/linux/cleancache.h
 delete mode 100644 mm/cleancache.c

diff --git a/Documentation/vm/cleancache.rst b/Documentation/vm/cleancache.rst
deleted file mode 100644
index 68cba9131c318..0000000000000
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
index 1979f430c1c5b..e2e5ab3e375e3 100644
--- a/Documentation/vm/frontswap.rst
+++ b/Documentation/vm/frontswap.rst
@@ -8,12 +8,6 @@ Frontswap provides a "transcendent memory" interface for swap pages.
 In some environments, dramatic performance savings may be obtained because
 swapped pages are saved in RAM (or a RAM-like device) instead of a swap disk.
 
-(Note, frontswap -- and :ref:`cleancache` (merged at 3.0) -- are the "frontends"
-and the only necessary changes to the core kernel for transcendent memory;
-all other supporting code -- the "backends" -- is implemented as drivers.
-See the LWN.net article `Transcendent memory in a nutshell`_
-for a detailed overview of frontswap and related kernel parts)
-
 .. _Transcendent memory in a nutshell: https://lwn.net/Articles/454795/
 
 Frontswap is so named because it can be thought of as the opposite of
@@ -87,11 +81,9 @@ This interface is ideal when data is transformed to a different form
 and size (such as with compression) or secretly moved (as might be
 useful for write-balancing for some RAM-like devices).  Swap pages (and
 evicted page-cache pages) are a great use for this kind of slower-than-RAM-
-but-much-faster-than-disk "pseudo-RAM device" and the frontswap (and
-cleancache) interface to transcendent memory provides a nice way to read
-and write -- and indirectly "name" -- the pages.
+but-much-faster-than-disk "pseudo-RAM device".
 
-Frontswap -- and cleancache -- with a fairly small impact on the kernel,
+Frontswap with a fairly small impact on the kernel,
 provides a huge amount of flexibility for more dynamic, flexible RAM
 utilization in various system configurations:
 
diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
index 932440805453e..44365c4574a37 100644
--- a/Documentation/vm/index.rst
+++ b/Documentation/vm/index.rst
@@ -15,7 +15,6 @@ algorithms.  If you are looking for advice on simply allocating memory, see the
    active_mm
    arch_pgtable_helpers
    balance
-   cleancache
    damon/index
    free_page_reporting
    frontswap
diff --git a/MAINTAINERS b/MAINTAINERS
index 35f0a1472bafa..9951a677c6d2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4683,13 +4683,6 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/cla
 F:	include/linux/cfi.h
 F:	kernel/cfi.c
 
-CLEANCACHE API
-M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
-L:	linux-kernel@vger.kernel.org
-S:	Maintained
-F:	include/linux/cleancache.h
-F:	mm/cleancache.c
-
 CLK API
 M:	Russell King <linux@armlinux.org.uk>
 L:	linux-clk@vger.kernel.org
diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 383c632eba7bd..a9ed79b7f8716 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -31,7 +31,6 @@ CONFIG_ARCH_BCM2835=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
 CONFIG_KSM=y
-CONFIG_CLEANCACHE=y
 CONFIG_CMA=y
 CONFIG_SECCOMP=y
 CONFIG_KEXEC=y
diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 0daa9c0d298e7..9981566f20961 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -27,7 +27,6 @@ CONFIG_PCIE_QCOM=y
 CONFIG_SMP=y
 CONFIG_PREEMPT=y
 CONFIG_HIGHMEM=y
-CONFIG_CLEANCACHE=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CPU_IDLE=y
diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index e2b14ea993423..c3173bdd394e9 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -45,7 +45,6 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_AOUT=m
 CONFIG_BINFMT_MISC=m
 # CONFIG_COMPACTION is not set
-CONFIG_CLEANCACHE=y
 CONFIG_ZPOOL=m
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 41f3f3b738b3e..4900fa2f3580b 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -41,7 +41,6 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_AOUT=m
 CONFIG_BINFMT_MISC=m
 # CONFIG_COMPACTION is not set
-CONFIG_CLEANCACHE=y
 CONFIG_ZPOOL=m
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index 3fd0ea135886b..d6e243023390f 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -48,7 +48,6 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_AOUT=m
 CONFIG_BINFMT_MISC=m
 # CONFIG_COMPACTION is not set
-CONFIG_CLEANCACHE=y
 CONFIG_ZPOOL=m
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 11a19f87e5864..4755f97a21835 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -38,7 +38,6 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_AOUT=m
 CONFIG_BINFMT_MISC=m
 # CONFIG_COMPACTION is not set
-CONFIG_CLEANCACHE=y
 CONFIG_ZPOOL=m
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index ee981271476a8..8c68178c6ae15 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -40,7 +40,6 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_AOUT=m
 CONFIG_BINFMT_MISC=m
 # CONFIG_COMPACTION is not set
-CONFIG_CLEANCACHE=y
 CONFIG_ZPOOL=m
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index a48656d328dd1..ddc492ced755c 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -39,7 +39,6 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_AOUT=m
 CONFIG_BINFMT_MISC=m
 # CONFIG_COMPACTION is not set
-CONFIG_CLEANCACHE=y
 CONFIG_ZPOOL=m
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index b9b7a5cc6a1e6..6b1651eb27499 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -59,7 +59,6 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_AOUT=m
 CONFIG_BINFMT_MISC=m
 # CONFIG_COMPACTION is not set
-CONFIG_CLEANCACHE=y
 CONFIG_ZPOOL=m
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index 3887b1c9c5fdc..2fc003520753a 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -37,7 +37,6 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_AOUT=m
 CONFIG_BINFMT_MISC=m
 # CONFIG_COMPACTION is not set
-CONFIG_CLEANCACHE=y
 CONFIG_ZPOOL=m
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 19e5992bba6ca..44fd3c0a311b0 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -38,7 +38,6 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_AOUT=m
 CONFIG_BINFMT_MISC=m
 # CONFIG_COMPACTION is not set
-CONFIG_CLEANCACHE=y
 CONFIG_ZPOOL=m
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index af25efaa32967..695a92e10522e 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -39,7 +39,6 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_AOUT=m
 CONFIG_BINFMT_MISC=m
 # CONFIG_COMPACTION is not set
-CONFIG_CLEANCACHE=y
 CONFIG_ZPOOL=m
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index 14dd96d3f5efd..e655a9f5b6376 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -35,7 +35,6 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_AOUT=m
 CONFIG_BINFMT_MISC=m
 # CONFIG_COMPACTION is not set
-CONFIG_CLEANCACHE=y
 CONFIG_ZPOOL=m
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 8ac2402ac334a..27193459defbf 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -35,7 +35,6 @@ CONFIG_IOSCHED_BFQ=m
 CONFIG_BINFMT_AOUT=m
 CONFIG_BINFMT_MISC=m
 # CONFIG_COMPACTION is not set
-CONFIG_CLEANCACHE=y
 CONFIG_ZPOOL=m
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 354e51dcb3e27..7fe8975b49ece 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -96,7 +96,6 @@ CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
-CONFIG_CLEANCACHE=y
 CONFIG_FRONTSWAP=y
 CONFIG_CMA_DEBUG=y
 CONFIG_CMA_DEBUGFS=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 8dee6c3782f35..466780c465f53 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -91,7 +91,6 @@ CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
-CONFIG_CLEANCACHE=y
 CONFIG_FRONTSWAP=y
 CONFIG_CMA_SYSFS=y
 CONFIG_CMA_AREAS=7
diff --git a/block/bdev.c b/block/bdev.c
index 8bf93a19041b7..102837a370517 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -24,7 +24,6 @@
 #include <linux/pseudo_fs.h>
 #include <linux/uio.h>
 #include <linux/namei.h>
-#include <linux/cleancache.h>
 #include <linux/part_stat.h>
 #include <linux/uaccess.h>
 #include "../fs/internal.h"
@@ -88,10 +87,6 @@ void invalidate_bdev(struct block_device *bdev)
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
index 9234d96a7fd5c..b1299fd44cfeb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -12,7 +12,6 @@
 #include <linux/writeback.h>
 #include <linux/pagevec.h>
 #include <linux/prefetch.h>
-#include <linux/cleancache.h>
 #include <linux/fsverity.h>
 #include "misc.h"
 #include "extent_io.h"
@@ -3583,15 +3582,6 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		goto out;
 	}
 
-	if (!PageUptodate(page)) {
-		if (cleancache_get_page(page) == 0) {
-			BUG_ON(blocksize != PAGE_SIZE);
-			unlock_extent(tree, start, end);
-			unlock_page(page);
-			goto out;
-		}
-	}
-
 	if (page->index == last_byte >> PAGE_SHIFT) {
 		size_t zero_offset = offset_in_page(last_byte);
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a1c54a2c787c5..39f76b889bdf6 100644
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
@@ -1374,7 +1373,6 @@ static int btrfs_fill_super(struct super_block *sb,
 		goto fail_close;
 	}
 
-	cleancache_init_fs(sb);
 	sb->s_flags |= SB_ACTIVE;
 	return 0;
 
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 3db9234035053..4cd62f1d848c8 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -43,7 +43,6 @@
 #include <linux/writeback.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
-#include <linux/cleancache.h>
 
 #include "ext4.h"
 
@@ -350,11 +349,6 @@ int ext4_mpage_readpages(struct inode *inode,
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
index b72d989b77fb6..b259343ebfc54 100644
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
@@ -3141,8 +3140,6 @@ static int ext4_setup_super(struct super_block *sb, struct ext4_super_block *es,
 			EXT4_BLOCKS_PER_GROUP(sb),
 			EXT4_INODES_PER_GROUP(sb),
 			sbi->s_mount_opt, sbi->s_mount_opt2);
-
-	cleancache_init_fs(sb);
 	return err;
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0a1d236212f85..d8e739d0eef37 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -18,7 +18,6 @@
 #include <linux/swap.h>
 #include <linux/prefetch.h>
 #include <linux/uio.h>
-#include <linux/cleancache.h>
 #include <linux/sched/signal.h>
 #include <linux/fiemap.h>
 #include <linux/iomap.h>
@@ -2035,12 +2034,6 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 		block_nr = map->m_pblk + block_in_file - map->m_lblk;
 		SetPageMappedToDisk(page);
 
-		if (!PageUptodate(page) && (!PageSwapCache(page) &&
-					!cleancache_get_page(page))) {
-			SetPageUptodate(page);
-			goto confused;
-		}
-
 		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
 						DATA_GENERIC_ENHANCE_READ)) {
 			ret = -EFSCORRUPTED;
diff --git a/fs/mpage.c b/fs/mpage.c
index 334e7d09aa652..87f5cfef6caa7 100644
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
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 8aaec7e0804ef..fb825059d4886 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -11,7 +11,6 @@
 
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
-#include <linux/cleancache.h>
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/kernel.h>
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 1286b88b6fa17..2772dec9dcea4 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -25,7 +25,6 @@
 #include <linux/mount.h>
 #include <linux/seq_file.h>
 #include <linux/quotaops.h>
-#include <linux/cleancache.h>
 #include <linux/signal.h>
 
 #define CREATE_TRACE_POINTS
@@ -2283,7 +2282,6 @@ static int ocfs2_initialize_super(struct super_block *sb,
 		mlog_errno(status);
 		goto bail;
 	}
-	cleancache_init_shared_fs(sb);
 
 	osb->ocfs2_wq = alloc_ordered_workqueue("ocfs2_wq", WQ_MEM_RECLAIM);
 	if (!osb->ocfs2_wq) {
diff --git a/fs/super.c b/fs/super.c
index 3bfc0f8fbd5bc..79aa179a1b081 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -31,7 +31,6 @@
 #include <linux/mutex.h>
 #include <linux/backing-dev.h>
 #include <linux/rculist_bl.h>
-#include <linux/cleancache.h>
 #include <linux/fscrypt.h>
 #include <linux/fsnotify.h>
 #include <linux/lockdep.h>
@@ -260,7 +259,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_time_gran = 1000000000;
 	s->s_time_min = TIME64_MIN;
 	s->s_time_max = TIME64_MAX;
-	s->cleancache_poolid = CLEANCACHE_NO_POOL;
 
 	s->s_shrink.seeks = DEFAULT_SEEKS;
 	s->s_shrink.scan_objects = super_cache_scan;
@@ -330,7 +328,6 @@ void deactivate_locked_super(struct super_block *s)
 {
 	struct file_system_type *fs = s->s_type;
 	if (atomic_dec_and_test(&s->s_active)) {
-		cleancache_invalidate_fs(s);
 		unregister_shrinker(&s->s_shrink);
 		fs->kill_sb(s);
 
diff --git a/include/linux/cleancache.h b/include/linux/cleancache.h
deleted file mode 100644
index 5f5730c1d324f..0000000000000
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
index 45c69dae6b38c..0ec4d7742f5b2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1535,11 +1535,6 @@ struct super_block {
 
 	const struct dentry_operations *s_d_op; /* default d_op for dentries */
 
-	/*
-	 * Saved pool identifier for cleancache (-1 means none)
-	 */
-	int cleancache_poolid;
-
 	struct shrinker s_shrink;	/* per-sb shrinker handle */
 
 	/* Number of inodes with nlink == 0 but still referenced */
diff --git a/mm/Kconfig b/mm/Kconfig
index a99bd499ef51d..430240289b02b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -444,28 +444,6 @@ config USE_PERCPU_NUMA_NODE_ID
 config HAVE_SETUP_PER_CPU_AREA
 	bool
 
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
index 588d3113f3b08..70d4309c9ce33 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -104,7 +104,6 @@ obj-$(CONFIG_DEBUG_KMEMLEAK) += kmemleak.o
 obj-$(CONFIG_DEBUG_RODATA_TEST) += rodata_test.o
 obj-$(CONFIG_DEBUG_VM_PGTABLE) += debug_vm_pgtable.o
 obj-$(CONFIG_PAGE_OWNER) += page_owner.o
-obj-$(CONFIG_CLEANCACHE) += cleancache.o
 obj-$(CONFIG_MEMORY_ISOLATION) += page_isolation.o
 obj-$(CONFIG_ZPOOL)	+= zpool.o
 obj-$(CONFIG_ZBUD)	+= zbud.o
diff --git a/mm/cleancache.c b/mm/cleancache.c
deleted file mode 100644
index db7eee9c08863..0000000000000
--- a/mm/cleancache.c
+++ /dev/null
@@ -1,315 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Cleancache frontend
- *
- * This code provides the generic "frontend" layer to call a matching
- * "backend" driver implementation of cleancache.  See
- * Documentation/vm/cleancache.rst for more information.
- *
- * Copyright (C) 2009-2010 Oracle Corp. All rights reserved.
- * Author: Dan Magenheimer
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
-
-	debugfs_create_u64("succ_gets", 0444, root, &cleancache_succ_gets);
-	debugfs_create_u64("failed_gets", 0444, root, &cleancache_failed_gets);
-	debugfs_create_u64("puts", 0444, root, &cleancache_puts);
-	debugfs_create_u64("invalidates", 0444, root, &cleancache_invalidates);
-#endif
-	return 0;
-}
-module_init(init_cleancache)
diff --git a/mm/filemap.c b/mm/filemap.c
index 6400b5dfe0a48..0d061a7c18f5a 100644
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
@@ -151,16 +150,6 @@ static void filemap_unaccount_folio(struct address_space *mapping,
 {
 	long nr;
 
-	/*
-	 * if we're uptodate, flush out into the cleancache, otherwise
-	 * invalidate any existing cleancache entries.  We can't leave
-	 * stale data around in the cleancache once our page is gone
-	 */
-	if (folio_test_uptodate(folio) && folio_test_mappedtodisk(folio))
-		cleancache_put_page(&folio->page);
-	else
-		cleancache_invalidate_page(mapping, &folio->page);
-
 	VM_BUG_ON_FOLIO(folio_mapped(folio), folio);
 	if (!IS_ENABLED(CONFIG_DEBUG_VM) && unlikely(folio_mapped(folio))) {
 		int mapcount;
diff --git a/mm/truncate.c b/mm/truncate.c
index 3ddd170a6bf1f..d0e928a254880 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -22,7 +22,6 @@
 #include <linux/buffer_head.h>	/* grr. try_to_release_page,
 				   do_invalidatepage */
 #include <linux/shmem_fs.h>
-#include <linux/cleancache.h>
 #include <linux/rmap.h>
 #include "internal.h"
 
@@ -264,7 +263,6 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 	 */
 	folio_zero_range(folio, offset, length);
 
-	cleancache_invalidate_page(folio->mapping, &folio->page);
 	if (folio_has_private(folio))
 		do_invalidatepage(&folio->page, offset, length);
 	if (!folio_test_large(folio))
@@ -351,7 +349,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	bool partial_end;
 
 	if (mapping_empty(mapping))
-		goto out;
+		return;
 
 	/*
 	 * 'start' and 'end' always covers the range of pages to be fully
@@ -443,9 +441,6 @@ void truncate_inode_pages_range(struct address_space *mapping,
 		folio_batch_release(&fbatch);
 		index++;
 	}
-
-out:
-	cleancache_invalidate_inode(mapping);
 }
 EXPORT_SYMBOL(truncate_inode_pages_range);
 
@@ -499,10 +494,6 @@ void truncate_inode_pages_final(struct address_space *mapping)
 		xa_unlock_irq(&mapping->i_pages);
 	}
 
-	/*
-	 * Cleancache needs notification even if there are no pages or shadow
-	 * entries.
-	 */
 	truncate_inode_pages(mapping, 0);
 }
 EXPORT_SYMBOL(truncate_inode_pages_final);
@@ -662,7 +653,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	int did_range_unmap = 0;
 
 	if (mapping_empty(mapping))
-		goto out;
+		return 0;
 
 	folio_batch_init(&fbatch);
 	index = start;
@@ -726,8 +717,6 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 	if (dax_mapping(mapping)) {
 		unmap_mapping_pages(mapping, start, end - start + 1, false);
 	}
-out:
-	cleancache_invalidate_inode(mapping);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(invalidate_inode_pages2_range);
-- 
2.30.2

