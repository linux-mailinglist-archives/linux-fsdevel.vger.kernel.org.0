Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A8C6A2676
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjBYBVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBYBTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:19:40 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0675C1589F
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:18:17 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bg11so812411oib.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jup9EBcd3t7MSDZcKBvvRB0BzHwVjq3QJkgr/CpCrJI=;
        b=527Dwf1sKsAQ+3iKDibWaZwv3fbOcnEngj7BMPxGv9fs8Xra25I7v+qASGbt/5rael
         xn5k/n2eQoj2vwd3CZEZVqldUHPsnszrM+2Zxb4+gdf7MS7VZALhQTxSkencA7KExybK
         znuL9ur7eemN/+ssFtlthwJ1z/ybKA3Qs/BxoI2ZzrCds8MT4KsXewjxcXlfW8DCs0YG
         gnZJeTbI+aHw4m9SoLFRpw6E0TpY/lDbnVKP4nAfahpk1IycA2WHB7VtYoMuu7XZBjXH
         ri14uhX6ufJRR6LPn82FJGVdhuntIfM1rwRND517DP98g401yskYV4FnILS9C2OTCP3t
         rbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jup9EBcd3t7MSDZcKBvvRB0BzHwVjq3QJkgr/CpCrJI=;
        b=zy4+AZeJYqHq1tA4wCc5WrWh9wpwnUZE/AEtktlrU1D7nDh0lGpevGVGRoO6aLxPvP
         YpnqVElFbJbm4QxcMzhHDH2OHGArFGPGrGn7qEognFBl4PccvTo6PSwQ5p9PL2ho4BPQ
         K+byMsUKGSrHz5jjv9HSMmpq6QPvQmYhnsGKZnxZpt+mAlymygoD47F8HwxXBKTbV6qN
         xBS7UojwTPrWdAwjT8M+uAZDhiscGNC2WbQ2ymFFLjVGbdqzPKoWBRcom3My2rmWufKs
         tgWlbCPTKNk9dDWrOQufEd8jT49gZ534+hlIIJGkZ6JmMqe9Fno/etkCIuDKrceDgDba
         Oiqw==
X-Gm-Message-State: AO0yUKU2csXAzxlpx31ClH+5c20JoplpCptwm/epcEqjzIU52JMEh1Qf
        z0VQO/dLG6fhaj3uOAzvfUpm866MKmvwWIWF
X-Google-Smtp-Source: AK7set+olN9wIPpk0GxZ/cytePRp7dK+2OkgT/tHGdCczQcsTlCDNkJI3zBhYOU7xcO5QeTmlCjiBg==
X-Received: by 2002:a05:6808:984:b0:383:e383:f07b with SMTP id a4-20020a056808098400b00383e383f07bmr3152320oic.48.1677287895846;
        Fri, 24 Feb 2023 17:18:15 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:18:15 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 76/76] introduce SSDFS file system
Date:   Fri, 24 Feb 2023 17:09:27 -0800
Message-Id: <20230225010927.813929-77-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230225010927.813929-1-slava@dubeyko.com>
References: <20230225010927.813929-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Integrate SSDFS file system into kernel infrastructure.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/Kconfig                 |   1 +
 fs/Makefile                |   1 +
 fs/ssdfs/Kconfig           | 300 +++++++++++++++++++++++++++++++++++++
 fs/ssdfs/Makefile          |  50 +++++++
 include/uapi/linux/magic.h |   1 +
 5 files changed, 353 insertions(+)
 create mode 100644 fs/ssdfs/Kconfig
 create mode 100644 fs/ssdfs/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index 2685a4d0d353..e969c0564926 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -319,6 +319,7 @@ source "fs/sysv/Kconfig"
 source "fs/ufs/Kconfig"
 source "fs/erofs/Kconfig"
 source "fs/vboxsf/Kconfig"
+source "fs/ssdfs/Kconfig"
 
 endif # MISC_FILESYSTEMS
 
diff --git a/fs/Makefile b/fs/Makefile
index 4dea17840761..61262a487a1f 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -137,3 +137,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_SSDFS)		+= ssdfs/
diff --git a/fs/ssdfs/Kconfig b/fs/ssdfs/Kconfig
new file mode 100644
index 000000000000..48786339798e
--- /dev/null
+++ b/fs/ssdfs/Kconfig
@@ -0,0 +1,300 @@
+config SSDFS
+	tristate "SSDFS file system support"
+	depends on BLOCK || MTD
+	help
+	  SSDFS is flash-friendly file system. The architecture of
+	  file system has been designed to be the LFS file system
+	  that can: (1) exclude the GC overhead, (2) prolong NAND
+	  flash devices lifetime, (3) achieve a good performance
+	  balance even if the NAND flash device's lifetime is a priority.
+
+	  If unsure, say N.
+
+config SSDFS_BLOCK_DEVICE
+	bool "Block layer support"
+	depends on BLOCK && SSDFS
+	depends on BLK_DEV_ZONED
+	default y
+	help
+	  This option enables block layer support.
+
+	  If unsure, say N.
+
+config SSDFS_MTD_DEVICE
+	bool "MTD support"
+	depends on !SSDFS_BLOCK_DEVICE && MTD && SSDFS
+	default n
+	help
+	  This option enables MTD layer support.
+
+	  If unsure, say N.
+
+config SSDFS_POSIX_ACL
+	bool "SSDFS POSIX Access Control Lists"
+	depends on SSDFS
+	select FS_POSIX_ACL
+	help
+	  POSIX Access Control Lists (ACLs) support permissions for users and
+	  groups beyond the owner/group/world scheme.
+
+	  To learn more about Access Control Lists, visit the POSIX ACLs for
+	  Linux website <http://acl.bestbits.at/>.
+
+	  If you don't know what Access Control Lists are, say N
+
+config SSDFS_SECURITY
+	bool "SSDFS Security Labels"
+	depends on SSDFS
+	help
+	  Security labels support alternative access control models
+	  implemented by security modules like SELinux.  This option
+	  enables an extended attribute handler for file security
+	  labels in the SSDFS filesystem.
+
+	  If you are not using a security module that requires using
+	  extended attributes for file security labels, say N.
+
+menu "Write amplification management"
+
+config SSDFS_ZLIB
+	bool "SSDFS ZLIB compression support"
+	select ZLIB_INFLATE
+	select ZLIB_DEFLATE
+	depends on SSDFS
+	default y
+	help
+	  Zlib is designed to be a free, general-purpose, legally unencumbered,
+	  lossless data-compression library for use on virtually any computer
+	  hardware and operating system. It offers a good trade-off between
+	  compression achieved and the amount of CPU time and memory necessary
+	  to compress and decompress. See <http://www.gzip.org/zlib/> for
+	  further information.
+
+	  If unsure, say Y.
+
+config SSDFS_ZLIB_COMR_LEVEL
+	int "Zlib compression level (0 => NO_COMPRESSION, 9 => BEST_COMPRESSION)"
+	depends on SSDFS_ZLIB
+	range 0 9
+	default 9
+	help
+	  Select Zlib compression level.
+	  Examples:
+		     0  => Z_NO_COMPRESSION
+		     1  => Z_BEST_SPEED
+		     9  => Z_BEST_COMPRESSION
+
+config SSDFS_LZO
+	bool "SSDFS LZO compression support"
+	select LZO_COMPRESS
+	select LZO_DECOMPRESS
+	depends on SSDFS
+	default n
+	help
+	  minilzo-based compression. Generally works better than Zlib.
+	  LZO compression is mainly aimed at embedded systems with slower
+	  CPUs where the overheads of zlib are too high.
+
+	  If unsure, say N.
+
+config SSDFS_DIFF_ON_WRITE
+	bool "SSDFS Diff-On-Write support"
+	depends on SSDFS
+	help
+	  This option enables delta-encoding support.
+
+	  If unsure, say N.
+
+config SSDFS_DIFF_ON_WRITE_METADATA
+	bool "SSDFS Diff-On-Write support (metadata case)"
+	depends on SSDFS_DIFF_ON_WRITE
+	help
+	  This option enables delta-encoding support for metadata.
+
+	  If unsure, say N.
+
+config SSDFS_DIFF_ON_WRITE_METADATA_THRESHOLD
+	int "Btree node modification percentage threshold (1% - 50%)"
+	range 1 50
+	default 25
+	depends on SSDFS_DIFF_ON_WRITE_METADATA
+	help
+	  Select btree node modification percentage threshold as
+	  upper bound of modified items in a node.
+
+config SSDFS_DIFF_ON_WRITE_USER_DATA
+	bool "SSDFS Diff-On-Write support (user data case)"
+	depends on SSDFS_DIFF_ON_WRITE
+	help
+	  This option enables delta-encoding support for user data.
+
+	  If unsure, say N.
+
+config SSDFS_DIFF_ON_WRITE_USER_DATA_THRESHOLD
+	int "Logical block's modified bits percentage threshold (1% - 50%)"
+	range 1 50
+	default 50
+	depends on SSDFS_DIFF_ON_WRITE_USER_DATA
+	help
+	  Select logical block modification percentage threshold as
+	  upper bound of modified bits in the logical block.
+
+endmenu
+
+menu "Performance"
+
+config SSDFS_FIXED_SUPERBLOCK_SEGMENTS_SET
+	bool "SSDFS fixed superblock segments set"
+	depends on SSDFS
+	default y
+	help
+	  This option enables the technique of repeatable using the
+	  reserved set of superblock segments in the beginning
+	  of a volume.
+
+	  If unsure, say N.
+
+config SSDFS_SAVE_WHOLE_BLK2OFF_TBL_IN_EVERY_LOG
+	bool "Save whole offset translation table in every log"
+	depends on SSDFS
+	help
+	  This option enables the technique of storing the whole
+	  offset translation table in every log. SSDFS can distribute
+	  the complete state of ofset translation table among multiple
+	  logs. It could decrease amount of metadata in the log.
+	  However, this policy increases the amount of read I/O requests
+	  because it requires to read multiple log headers in the same
+	  erase block. If a big erase block contains a lot of small
+	  partial logs then it can degrades file system performance
+	  because of significant amount of read I/O during
+	  initialization phase.
+
+	  If unsure, say N.
+
+endmenu
+
+menu "Reliability"
+
+config SSDFS_CHECK_LOGICAL_BLOCK_EMPTYNESS
+	bool "SSDFS check a logical block emptyness on every write"
+	depends on SSDFS
+	help
+	  This option enables the technique of checking a logical block
+	  emptyness on every write. The goal of this technique is
+	  to prevent the re-writing pages with existing data because
+	  SSD's FTL can manage this sutiation. However, this can be the
+	  source of data and metadata corruption in the case of some
+	  issues in file system driver logic. But it needs to take into
+	  account that this technique could degrade the write performance
+	  of file system driver. Also, file system volume has to be erased
+	  during creation by mkfs. Otherwise, file system driver will fail
+	  to write even for the case correct write operations.
+
+	  If unsure, say N.
+
+endmenu
+
+menu "Development"
+
+config SSDFS_DEBUG
+	bool "SSDFS debugging"
+	depends on SSDFS
+	help
+	  This option enables additional pre-condition and post-condition
+	  checking in functions. The main goal of this option is providing
+	  environment for debugging code in SSDFS driver and excluding
+	  debug checking from end-users' kernel build. This option enables
+	  debug output by means of pr_debug() from all files too. You can
+	  disable debug output from any file via the 'dynamic_debug/control'
+	  file. Please, see Documentation/dynamic-debug-howto.txt for
+	  additional information.
+
+	  If you are going to debug SSDFS driver then choose Y here.
+	  If unsure, say N.
+
+config SSDFS_TRACK_API_CALL
+	bool "SSDFS API calls tracking"
+	depends on SSDFS
+	help
+	  This option enables output from the key subsystems' fucntions.
+	  The main goal of this option is providing the vision of
+	  file system activity.
+
+	  If you are going to debug SSDFS driver then choose Y here.
+	  If unsure, say N.
+
+config SSDFS_MEMORY_LEAKS_ACCOUNTING
+	bool "SSDFS memory leaks accounting"
+	depends on SSDFS
+	help
+	  This option enables accounting of memory allocation
+	  (kmalloc, kzalloc, kcalloc, kmem_cache_alloc, alloc_page)
+	  by means of incrementing a global counters and deallocation
+	  (kfree, kmem_cache_free, free_page) by means decrementing
+	  the same global counters. Also, there are special global counters
+	  that tracking the number of locked/unlocked memory pages.
+	  However, global counters have an unpleasant side effect.
+	  If there are several mounted SSDFS partitions in the system
+	  then memory leaks accounting subsystem is miscalculating
+	  the number of memory leaks and triggers false alarms.
+	  It makes sense to use the memory leaks accounting subsystem
+	  only for single mounted SSDFS partition in the system.
+
+	  If you are going to check memory leaks in SSDFS driver then
+	  choose Y here. If unsure, say N.
+
+config SSDFS_SHOW_CONSUMED_MEMORY
+	bool "SSDFS shows consumed memory"
+	select SSDFS_MEMORY_LEAKS_ACCOUNTING
+	help
+	  This option enables showing the amount of allocated
+	  memory and memory pages in the form of memory leaks
+	  on every syncfs event.
+
+	  If you are going to check memory consumption in SSDFS driver
+	  then choose Y here. If unsure, say N.
+
+config SSDFS_BTREE_CONSISTENCY_CHECK
+	bool "SSDFS btree consistency check"
+	depends on SSDFS
+	help
+	  This option enables checking the btree consistency.
+
+	  If you are going to check btree consistency in SSDFS driver then
+	  choose Y here. If unsure, say N.
+
+config SSDFS_BTREE_STRICT_CONSISTENCY_CHECK
+	bool "SSDFS btree strict consistency check"
+	depends on SSDFS
+	help
+	  This option enables checking the btree consistency
+	  after every btree's operation. This option could
+	  seriously degrades the file system performance.
+
+	  If you are going to check btree consistency in SSDFS driver then
+	  choose Y here. If unsure, say N.
+
+config SSDFS_TESTING
+	bool "SSDFS testing"
+	depends on SSDFS
+	select SSDFS_DEBUG
+	select SSDFS_MEMORY_LEAKS_ACCOUNTING
+	select SSDFS_BTREE_CONSISTENCY_CHECK
+	help
+	  This option enables testing infrastructure of SSDFS
+	  filesystem.
+
+	  If you are going to test SSDFS driver then choose Y here.
+	  If unsure, say N.
+
+config SSDFS_UNDER_DEVELOPMENT_FUNC
+	bool "SSDFS under development functionality"
+	depends on SSDFS
+	help
+	  This option enables functionality that is under
+	  development yet.
+
+	  If you are going to check under development functionality
+	  in SSDFS driver then choose Y here. If unsure, say N.
+
+endmenu
diff --git a/fs/ssdfs/Makefile b/fs/ssdfs/Makefile
new file mode 100644
index 000000000000..d910e3e40257
--- /dev/null
+++ b/fs/ssdfs/Makefile
@@ -0,0 +1,50 @@
+#
+# SPDX-License-Identifier: BSD-3-Clause-Clear
+# Makefile for the Linux SSD-oriented File System  (SSDFS)
+#
+#
+
+obj-$(CONFIG_SSDFS)			+= ssdfs.o
+
+#ccflags-$(CONFIG_SSDFS_DEBUG)		+= -DDEBUG
+
+ssdfs-y	:= super.o fs_error.o recovery.o \
+		recovery_fast_search.o recovery_slow_search.o \
+		recovery_thread.o \
+		options.o page_array.o page_vector.o \
+		dynamic_array.o volume_header.o log_footer.o \
+		block_bitmap.o block_bitmap_tables.o \
+		peb_block_bitmap.o segment_block_bitmap.o \
+		sequence_array.o offset_translation_table.o \
+		request_queue.o readwrite.o  \
+		peb.o peb_gc_thread.o peb_read_thread.o peb_flush_thread.o \
+		peb_container.o \
+		segment.o segment_tree.o current_segment.o \
+		segment_bitmap.o segment_bitmap_tables.o \
+		peb_mapping_queue.o \
+		peb_mapping_table.o peb_mapping_table_thread.o \
+		peb_mapping_table_cache.o peb_migration_scheme.o \
+		btree_search.o btree_node.o btree_hierarchy.o btree.o \
+		extents_queue.o extents_tree.o \
+		shared_extents_tree.o shared_extents_tree_thread.o \
+		inodes_tree.o dentries_tree.o \
+		shared_dictionary.o shared_dictionary_thread.o \
+		xattr_tree.o \
+		snapshot_requests_queue.o snapshot_rules.o \
+		snapshot.o snapshots_tree.o snapshots_tree_thread.o \
+		invalidated_extents_tree.o \
+		inode.o file.o dir.o ioctl.o \
+		sysfs.o \
+		xattr.o xattr_user.o xattr_trusted.o \
+		compression.o
+
+ssdfs-$(CONFIG_SSDFS_POSIX_ACL)			+= acl.o
+ssdfs-$(CONFIG_SSDFS_SECURITY)			+= xattr_security.o
+ssdfs-$(CONFIG_SSDFS_ZLIB)			+= compr_zlib.o
+ssdfs-$(CONFIG_SSDFS_LZO)			+= compr_lzo.o
+ssdfs-$(CONFIG_SSDFS_MTD_DEVICE)		+= dev_mtd.o
+ssdfs-$(CONFIG_SSDFS_BLOCK_DEVICE)		+= dev_bdev.o dev_zns.o
+ssdfs-$(CONFIG_SSDFS_TESTING)			+= testing.o
+ssdfs-$(CONFIG_SSDFS_DIFF_ON_WRITE)		+= diff_on_write.o
+ssdfs-$(CONFIG_SSDFS_DIFF_ON_WRITE_METADATA)	+= diff_on_write_metadata.o
+ssdfs-$(CONFIG_SSDFS_DIFF_ON_WRITE_USER_DATA)	+= diff_on_write_user_data.o
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 6325d1d0e90f..f49a25d61bc0 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -95,6 +95,7 @@
 #define BPF_FS_MAGIC		0xcafe4a11
 #define AAFS_MAGIC		0x5a3c69f0
 #define ZONEFS_MAGIC		0x5a4f4653
+#define SSDFS_SUPER_MAGIC	0x53734466 /* SsDf */
 
 /* Since UDF 2.01 is ISO 13346 based... */
 #define UDF_SUPER_MAGIC		0x15013346
-- 
2.34.1

