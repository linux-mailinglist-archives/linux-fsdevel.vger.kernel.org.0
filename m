Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60A66A2621
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBYBPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBYBPp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:15:45 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD6E125AF
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:40 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id e21so827842oie.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bP0b9LEh+czsntuQtuFO394YmoIhlhhyVn8RIeEz6ik=;
        b=YQDOmiA63tCuMr9s3l3Rd9pC93S3yVLf70fQp57U+S855K152uWEaAa56mHRR6rTD/
         FfxXb3260CBSFB3FVYNgxvUO1RwGcEHS4D97hHkMkymVHDJKGF9DDRBY6vjYhGbYtVPG
         kTiKP4gLZL5Q/2dpl+e/E7iGIH5sDxeQnUlK+4viXwLTCmNc/bf7hXuUfIOL18Q80fFX
         sEjmitXRqvJZNPcDlqyqIbIcg1FWLMl6O9vtSQDjx8TigxokNDUOFJUOi2niYfDiwshv
         4I3FWnYOCGSb4nos2i/k20J9NWfH5JMsvzNgCg1dOI8VbrimuHdL8zk6ANL0ziT3Smzm
         zoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bP0b9LEh+czsntuQtuFO394YmoIhlhhyVn8RIeEz6ik=;
        b=3mXOImxPPaa17rKrfZ/aEjfzPx4aMc/gab0VKMDONUDFYMcUUHEoNzkKoldVXk/Zjj
         HdoX9lMsWENyokwWQ7iFJnrK2uCk54fqR3Ie0FFMkc8gAoaGVeUPTAX2FuE1mBiOQUoi
         iRruRe36R3vRi0O98nk4E1mXOZyp3g3a0/82LmkN+rKBpWJyLe/lNxjBnHFptTe3hzkk
         WQryddmw0TLVLpKojCN6iOi9IZJuRG/GhIU5EGGoAUQEOieUdJ9RrKSbG7dCmAyszYGh
         aMRrhpGuLL9RtRR4rOqvuSrz2eW7q9BNstCO2gCWJilRdNWDc+LHynXbxHB2BPK1aZ4f
         7ZPQ==
X-Gm-Message-State: AO0yUKVTPcY69fgZ3Ureg6maO1raVW6XGBz1KlfcEGhmuJw70kWScqlL
        A2Q7wr34yY2yJMlVZSQobh0k/Fh8yXAETu5+
X-Google-Smtp-Source: AK7set+Vu9I4XFZx8dWNNlH2AuFuwZpw3FssR6NKUq/tg4GrKO5VuhdCb20ehxM2pYpK6+F1h7QnwA==
X-Received: by 2002:a05:6808:424e:b0:37f:9b35:1880 with SMTP id dp14-20020a056808424e00b0037f9b351880mr5556720oib.27.1677287738824;
        Fri, 24 Feb 2023 17:15:38 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:15:37 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 02/76] ssdfs: key file system declarations
Date:   Fri, 24 Feb 2023 17:08:13 -0800
Message-Id: <20230225010927.813929-3-slava@dubeyko.com>
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

This patch contains declarations of key constants,
macros, inline functions implementations and
function declarations.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/ssdfs.h              |  411 ++++++++++
 fs/ssdfs/ssdfs_constants.h    |   81 ++
 fs/ssdfs/ssdfs_fs_info.h      |  412 ++++++++++
 fs/ssdfs/ssdfs_inline.h       | 1346 +++++++++++++++++++++++++++++++++
 fs/ssdfs/ssdfs_inode_info.h   |  143 ++++
 fs/ssdfs/ssdfs_thread_info.h  |   42 +
 fs/ssdfs/version.h            |    7 +
 include/trace/events/ssdfs.h  |  255 +++++++
 include/uapi/linux/ssdfs_fs.h |  117 +++
 9 files changed, 2814 insertions(+)
 create mode 100644 fs/ssdfs/ssdfs.h
 create mode 100644 fs/ssdfs/ssdfs_constants.h
 create mode 100644 fs/ssdfs/ssdfs_fs_info.h
 create mode 100644 fs/ssdfs/ssdfs_inline.h
 create mode 100644 fs/ssdfs/ssdfs_inode_info.h
 create mode 100644 fs/ssdfs/ssdfs_thread_info.h
 create mode 100644 fs/ssdfs/version.h
 create mode 100644 include/trace/events/ssdfs.h
 create mode 100644 include/uapi/linux/ssdfs_fs.h

diff --git a/fs/ssdfs/ssdfs.h b/fs/ssdfs/ssdfs.h
new file mode 100644
index 000000000000..c0d5d7ace2eb
--- /dev/null
+++ b/fs/ssdfs/ssdfs.h
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/ssdfs.h - in-core declarations.
+ *
+ * Copyright (c) 2019-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#ifndef _SSDFS_H
+#define _SSDFS_H
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kobject.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/crc32.h>
+#include <linux/pagemap.h>
+#include <linux/ssdfs_fs.h>
+
+#include "ssdfs_constants.h"
+#include "ssdfs_thread_info.h"
+#include "ssdfs_inode_info.h"
+#include "snapshot.h"
+#include "snapshot_requests_queue.h"
+#include "snapshot_rules.h"
+#include "ssdfs_fs_info.h"
+#include "ssdfs_inline.h"
+
+/*
+ * struct ssdfs_value_pair - value/position pair
+ * @value: some value
+ * @pos: position of value
+ */
+struct ssdfs_value_pair {
+	int value;
+	int pos;
+};
+
+/*
+ * struct ssdfs_min_max_pair - minimum and maximum values pair
+ * @min: minimum value/position pair
+ * @max: maximum value/position pair
+ */
+struct ssdfs_min_max_pair {
+	struct ssdfs_value_pair min;
+	struct ssdfs_value_pair max;
+};
+
+/*
+ * struct ssdfs_block_bmap_range - block bitmap items range
+ * @start: begin item
+ * @len: count of items in the range
+ */
+struct ssdfs_block_bmap_range {
+	u32 start;
+	u32 len;
+};
+
+struct ssdfs_peb_info;
+struct ssdfs_peb_container;
+struct ssdfs_segment_info;
+struct ssdfs_peb_blk_bmap;
+
+/* btree_node.c */
+void ssdfs_zero_btree_node_obj_cache_ptr(void);
+int ssdfs_init_btree_node_obj_cache(void);
+void ssdfs_shrink_btree_node_obj_cache(void);
+void ssdfs_destroy_btree_node_obj_cache(void);
+
+/* btree_search.c */
+void ssdfs_zero_btree_search_obj_cache_ptr(void);
+int ssdfs_init_btree_search_obj_cache(void);
+void ssdfs_shrink_btree_search_obj_cache(void);
+void ssdfs_destroy_btree_search_obj_cache(void);
+
+/* compression.c */
+int ssdfs_compressors_init(void);
+void ssdfs_free_workspaces(void);
+void ssdfs_compressors_exit(void);
+
+/* dev_bdev.c */
+struct bio *ssdfs_bdev_bio_alloc(struct block_device *bdev,
+				 unsigned int nr_iovecs,
+				 unsigned int op,
+				 gfp_t gfp_mask);
+void ssdfs_bdev_bio_put(struct bio *bio);
+int ssdfs_bdev_bio_add_page(struct bio *bio, struct page *page,
+			    unsigned int len, unsigned int offset);
+int ssdfs_bdev_readpage(struct super_block *sb, struct page *page,
+			loff_t offset);
+int ssdfs_bdev_readpages(struct super_block *sb, struct pagevec *pvec,
+			 loff_t offset);
+int ssdfs_bdev_read(struct super_block *sb, loff_t offset,
+		    size_t len, void *buf);
+int ssdfs_bdev_can_write_page(struct super_block *sb, loff_t offset,
+			      bool need_check);
+int ssdfs_bdev_writepage(struct super_block *sb, loff_t to_off,
+			 struct page *page, u32 from_off, size_t len);
+int ssdfs_bdev_writepages(struct super_block *sb, loff_t to_off,
+			  struct pagevec *pvec,
+			  u32 from_off, size_t len);
+
+/* dev_zns.c */
+u64 ssdfs_zns_zone_size(struct super_block *sb, loff_t offset);
+u64 ssdfs_zns_zone_capacity(struct super_block *sb, loff_t offset);
+
+/* dir.c */
+int ssdfs_inode_by_name(struct inode *dir,
+			const struct qstr *child,
+			ino_t *ino);
+int ssdfs_create(struct user_namespace *mnt_userns,
+		 struct inode *dir, struct dentry *dentry,
+		 umode_t mode, bool excl);
+
+/* file.c */
+int ssdfs_allocate_inline_file_buffer(struct inode *inode);
+void ssdfs_destroy_inline_file_buffer(struct inode *inode);
+int ssdfs_fsync(struct file *file, loff_t start, loff_t end, int datasync);
+
+/* fs_error.c */
+extern __printf(5, 6)
+void ssdfs_fs_error(struct super_block *sb, const char *file,
+		    const char *function, unsigned int line,
+		    const char *fmt, ...);
+int ssdfs_set_page_dirty(struct page *page);
+int __ssdfs_clear_dirty_page(struct page *page);
+int ssdfs_clear_dirty_page(struct page *page);
+void ssdfs_clear_dirty_pages(struct address_space *mapping);
+
+/* inode.c */
+bool is_raw_inode_checksum_correct(struct ssdfs_fs_info *fsi,
+				   void *buf, size_t size);
+struct inode *ssdfs_iget(struct super_block *sb, ino_t ino);
+struct inode *ssdfs_new_inode(struct inode *dir, umode_t mode,
+			      const struct qstr *qstr);
+int ssdfs_getattr(struct user_namespace *mnt_userns,
+		  const struct path *path, struct kstat *stat,
+		  u32 request_mask, unsigned int query_flags);
+int ssdfs_setattr(struct user_namespace *mnt_userns,
+		  struct dentry *dentry, struct iattr *attr);
+void ssdfs_evict_inode(struct inode *inode);
+int ssdfs_write_inode(struct inode *inode, struct writeback_control *wbc);
+int ssdfs_statfs(struct dentry *dentry, struct kstatfs *buf);
+void ssdfs_set_inode_flags(struct inode *inode);
+
+/* inodes_tree.c */
+void ssdfs_zero_free_ino_desc_cache_ptr(void);
+int ssdfs_init_free_ino_desc_cache(void);
+void ssdfs_shrink_free_ino_desc_cache(void);
+void ssdfs_destroy_free_ino_desc_cache(void);
+
+/* ioctl.c */
+long ssdfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+
+/* log_footer.c */
+bool __is_ssdfs_log_footer_magic_valid(struct ssdfs_signature *magic);
+bool is_ssdfs_log_footer_magic_valid(struct ssdfs_log_footer *footer);
+bool is_ssdfs_log_footer_csum_valid(void *buf, size_t buf_size);
+bool is_ssdfs_volume_state_info_consistent(struct ssdfs_fs_info *fsi,
+					   void *buf,
+					   struct ssdfs_log_footer *footer,
+					   u64 dev_size);
+int ssdfs_read_unchecked_log_footer(struct ssdfs_fs_info *fsi,
+				    u64 peb_id, u32 bytes_off,
+				    void *buf, bool silent,
+				    u32 *log_pages);
+int ssdfs_check_log_footer(struct ssdfs_fs_info *fsi,
+			   void *buf,
+			   struct ssdfs_log_footer *footer,
+			   bool silent);
+int ssdfs_read_checked_log_footer(struct ssdfs_fs_info *fsi, void *log_hdr,
+				  u64 peb_id, u32 bytes_off, void *buf,
+				  bool silent);
+int ssdfs_prepare_current_segment_ids(struct ssdfs_fs_info *fsi,
+					__le64 *array,
+					size_t size);
+int ssdfs_prepare_volume_state_info_for_commit(struct ssdfs_fs_info *fsi,
+						u16 fs_state,
+						__le64 *cur_segs,
+						size_t size,
+						u64 last_log_time,
+						u64 last_log_cno,
+						struct ssdfs_volume_state *vs);
+int ssdfs_prepare_log_footer_for_commit(struct ssdfs_fs_info *fsi,
+					u32 log_pages,
+					u32 log_flags,
+					u64 last_log_time,
+					u64 last_log_cno,
+					struct ssdfs_log_footer *footer);
+
+/* offset_translation_table.c */
+void ssdfs_zero_blk2off_frag_obj_cache_ptr(void);
+int ssdfs_init_blk2off_frag_obj_cache(void);
+void ssdfs_shrink_blk2off_frag_obj_cache(void);
+void ssdfs_destroy_blk2off_frag_obj_cache(void);
+
+/* options.c */
+int ssdfs_parse_options(struct ssdfs_fs_info *fs_info, char *data);
+void ssdfs_initialize_fs_errors_option(struct ssdfs_fs_info *fsi);
+int ssdfs_show_options(struct seq_file *seq, struct dentry *root);
+
+/* peb_migration_scheme.c */
+int ssdfs_peb_start_migration(struct ssdfs_peb_container *pebc);
+bool is_peb_under_migration(struct ssdfs_peb_container *pebc);
+bool is_pebs_relation_alive(struct ssdfs_peb_container *pebc);
+bool has_peb_migration_done(struct ssdfs_peb_container *pebc);
+bool should_migration_be_finished(struct ssdfs_peb_container *pebc);
+int ssdfs_peb_finish_migration(struct ssdfs_peb_container *pebc);
+bool has_ssdfs_source_peb_valid_blocks(struct ssdfs_peb_container *pebc);
+int ssdfs_peb_prepare_range_migration(struct ssdfs_peb_container *pebc,
+				      u32 range_len, int blk_type);
+int ssdfs_peb_migrate_valid_blocks_range(struct ssdfs_segment_info *si,
+					 struct ssdfs_peb_container *pebc,
+					 struct ssdfs_peb_blk_bmap *peb_blkbmap,
+					 struct ssdfs_block_bmap_range *range);
+
+/* readwrite.c */
+int ssdfs_read_page_from_volume(struct ssdfs_fs_info *fsi,
+				u64 peb_id, u32 bytes_off,
+				struct page *page);
+int ssdfs_read_pagevec_from_volume(struct ssdfs_fs_info *fsi,
+				   u64 peb_id, u32 bytes_off,
+				   struct pagevec *pvec);
+int ssdfs_aligned_read_buffer(struct ssdfs_fs_info *fsi,
+			      u64 peb_id, u32 bytes_off,
+			      void *buf, size_t size,
+			      size_t *read_bytes);
+int ssdfs_unaligned_read_buffer(struct ssdfs_fs_info *fsi,
+				u64 peb_id, u32 bytes_off,
+				void *buf, size_t size);
+int ssdfs_can_write_sb_log(struct super_block *sb,
+			   struct ssdfs_peb_extent *sb_log);
+int ssdfs_unaligned_read_pagevec(struct pagevec *pvec,
+				 u32 offset, u32 size,
+				 void *buf);
+int ssdfs_unaligned_write_pagevec(struct pagevec *pvec,
+				  u32 offset, u32 size,
+				  void *buf);
+
+/* recovery.c */
+int ssdfs_init_sb_info(struct ssdfs_fs_info *fsi,
+			struct ssdfs_sb_info *sbi);
+void ssdfs_destruct_sb_info(struct ssdfs_sb_info *sbi);
+void ssdfs_backup_sb_info(struct ssdfs_fs_info *fsi);
+void ssdfs_restore_sb_info(struct ssdfs_fs_info *fsi);
+int ssdfs_gather_superblock_info(struct ssdfs_fs_info *fsi, int silent);
+
+/* segment.c */
+void ssdfs_zero_seg_obj_cache_ptr(void);
+int ssdfs_init_seg_obj_cache(void);
+void ssdfs_shrink_seg_obj_cache(void);
+void ssdfs_destroy_seg_obj_cache(void);
+int ssdfs_segment_get_used_data_pages(struct ssdfs_segment_info *si);
+
+/* sysfs.c */
+int ssdfs_sysfs_init(void);
+void ssdfs_sysfs_exit(void);
+int ssdfs_sysfs_create_device_group(struct super_block *sb);
+void ssdfs_sysfs_delete_device_group(struct ssdfs_fs_info *fsi);
+int ssdfs_sysfs_create_seg_group(struct ssdfs_segment_info *si);
+void ssdfs_sysfs_delete_seg_group(struct ssdfs_segment_info *si);
+int ssdfs_sysfs_create_peb_group(struct ssdfs_peb_container *pebc);
+void ssdfs_sysfs_delete_peb_group(struct ssdfs_peb_container *pebc);
+
+/* volume_header.c */
+bool __is_ssdfs_segment_header_magic_valid(struct ssdfs_signature *magic);
+bool is_ssdfs_segment_header_magic_valid(struct ssdfs_segment_header *hdr);
+bool is_ssdfs_partial_log_header_magic_valid(struct ssdfs_signature *magic);
+bool is_ssdfs_volume_header_csum_valid(void *vh_buf, size_t buf_size);
+bool is_ssdfs_partial_log_header_csum_valid(void *plh_buf, size_t buf_size);
+bool is_ssdfs_volume_header_consistent(struct ssdfs_fs_info *fsi,
+					struct ssdfs_volume_header *vh,
+					u64 dev_size);
+int ssdfs_check_segment_header(struct ssdfs_fs_info *fsi,
+				struct ssdfs_segment_header *hdr,
+				bool silent);
+int ssdfs_read_checked_segment_header(struct ssdfs_fs_info *fsi,
+					u64 peb_id, u32 pages_off,
+					void *buf, bool silent);
+int ssdfs_check_partial_log_header(struct ssdfs_fs_info *fsi,
+				   struct ssdfs_partial_log_header *hdr,
+				   bool silent);
+void ssdfs_create_volume_header(struct ssdfs_fs_info *fsi,
+				struct ssdfs_volume_header *vh);
+int ssdfs_prepare_volume_header_for_commit(struct ssdfs_fs_info *fsi,
+					   struct ssdfs_volume_header *vh);
+int ssdfs_prepare_segment_header_for_commit(struct ssdfs_fs_info *fsi,
+					    u32 log_pages,
+					    u16 seg_type,
+					    u32 seg_flags,
+					    u64 last_log_time,
+					    u64 last_log_cno,
+					    struct ssdfs_segment_header *hdr);
+int ssdfs_prepare_partial_log_header_for_commit(struct ssdfs_fs_info *fsi,
+					int sequence_id,
+					u32 log_pages,
+					u16 seg_type,
+					u32 flags,
+					u64 last_log_time,
+					u64 last_log_cno,
+					struct ssdfs_partial_log_header *hdr);
+
+/* memory leaks checker */
+void ssdfs_acl_memory_leaks_init(void);
+void ssdfs_acl_check_memory_leaks(void);
+void ssdfs_block_bmap_memory_leaks_init(void);
+void ssdfs_block_bmap_check_memory_leaks(void);
+void ssdfs_blk2off_memory_leaks_init(void);
+void ssdfs_blk2off_check_memory_leaks(void);
+void ssdfs_btree_memory_leaks_init(void);
+void ssdfs_btree_check_memory_leaks(void);
+void ssdfs_btree_hierarchy_memory_leaks_init(void);
+void ssdfs_btree_hierarchy_check_memory_leaks(void);
+void ssdfs_btree_node_memory_leaks_init(void);
+void ssdfs_btree_node_check_memory_leaks(void);
+void ssdfs_btree_search_memory_leaks_init(void);
+void ssdfs_btree_search_check_memory_leaks(void);
+void ssdfs_lzo_memory_leaks_init(void);
+void ssdfs_lzo_check_memory_leaks(void);
+void ssdfs_zlib_memory_leaks_init(void);
+void ssdfs_zlib_check_memory_leaks(void);
+void ssdfs_compr_memory_leaks_init(void);
+void ssdfs_compr_check_memory_leaks(void);
+void ssdfs_cur_seg_memory_leaks_init(void);
+void ssdfs_cur_seg_check_memory_leaks(void);
+void ssdfs_dentries_memory_leaks_init(void);
+void ssdfs_dentries_check_memory_leaks(void);
+void ssdfs_dev_bdev_memory_leaks_init(void);
+void ssdfs_dev_bdev_check_memory_leaks(void);
+void ssdfs_dev_zns_memory_leaks_init(void);
+void ssdfs_dev_zns_check_memory_leaks(void);
+void ssdfs_dev_mtd_memory_leaks_init(void);
+void ssdfs_dev_mtd_check_memory_leaks(void);
+void ssdfs_dir_memory_leaks_init(void);
+void ssdfs_dir_check_memory_leaks(void);
+void ssdfs_diff_memory_leaks_init(void);
+void ssdfs_diff_check_memory_leaks(void);
+void ssdfs_ext_queue_memory_leaks_init(void);
+void ssdfs_ext_queue_check_memory_leaks(void);
+void ssdfs_ext_tree_memory_leaks_init(void);
+void ssdfs_ext_tree_check_memory_leaks(void);
+void ssdfs_file_memory_leaks_init(void);
+void ssdfs_file_check_memory_leaks(void);
+void ssdfs_fs_error_memory_leaks_init(void);
+void ssdfs_fs_error_check_memory_leaks(void);
+void ssdfs_inode_memory_leaks_init(void);
+void ssdfs_inode_check_memory_leaks(void);
+void ssdfs_ino_tree_memory_leaks_init(void);
+void ssdfs_ino_tree_check_memory_leaks(void);
+void ssdfs_invext_tree_memory_leaks_init(void);
+void ssdfs_invext_tree_check_memory_leaks(void);
+void ssdfs_parray_memory_leaks_init(void);
+void ssdfs_parray_check_memory_leaks(void);
+void ssdfs_page_vector_memory_leaks_init(void);
+void ssdfs_page_vector_check_memory_leaks(void);
+void ssdfs_flush_memory_leaks_init(void);
+void ssdfs_flush_check_memory_leaks(void);
+void ssdfs_gc_memory_leaks_init(void);
+void ssdfs_gc_check_memory_leaks(void);
+void ssdfs_map_queue_memory_leaks_init(void);
+void ssdfs_map_queue_check_memory_leaks(void);
+void ssdfs_map_tbl_memory_leaks_init(void);
+void ssdfs_map_tbl_check_memory_leaks(void);
+void ssdfs_map_cache_memory_leaks_init(void);
+void ssdfs_map_cache_check_memory_leaks(void);
+void ssdfs_map_thread_memory_leaks_init(void);
+void ssdfs_map_thread_check_memory_leaks(void);
+void ssdfs_migration_memory_leaks_init(void);
+void ssdfs_migration_check_memory_leaks(void);
+void ssdfs_peb_memory_leaks_init(void);
+void ssdfs_peb_check_memory_leaks(void);
+void ssdfs_read_memory_leaks_init(void);
+void ssdfs_read_check_memory_leaks(void);
+void ssdfs_recovery_memory_leaks_init(void);
+void ssdfs_recovery_check_memory_leaks(void);
+void ssdfs_req_queue_memory_leaks_init(void);
+void ssdfs_req_queue_check_memory_leaks(void);
+void ssdfs_seg_obj_memory_leaks_init(void);
+void ssdfs_seg_obj_check_memory_leaks(void);
+void ssdfs_seg_bmap_memory_leaks_init(void);
+void ssdfs_seg_bmap_check_memory_leaks(void);
+void ssdfs_seg_blk_memory_leaks_init(void);
+void ssdfs_seg_blk_check_memory_leaks(void);
+void ssdfs_seg_tree_memory_leaks_init(void);
+void ssdfs_seg_tree_check_memory_leaks(void);
+void ssdfs_seq_arr_memory_leaks_init(void);
+void ssdfs_seq_arr_check_memory_leaks(void);
+void ssdfs_dict_memory_leaks_init(void);
+void ssdfs_dict_check_memory_leaks(void);
+void ssdfs_shextree_memory_leaks_init(void);
+void ssdfs_shextree_check_memory_leaks(void);
+void ssdfs_snap_reqs_queue_memory_leaks_init(void);
+void ssdfs_snap_reqs_queue_check_memory_leaks(void);
+void ssdfs_snap_rules_list_memory_leaks_init(void);
+void ssdfs_snap_rules_list_check_memory_leaks(void);
+void ssdfs_snap_tree_memory_leaks_init(void);
+void ssdfs_snap_tree_check_memory_leaks(void);
+void ssdfs_xattr_memory_leaks_init(void);
+void ssdfs_xattr_check_memory_leaks(void);
+
+#endif /* _SSDFS_H */
diff --git a/fs/ssdfs/ssdfs_constants.h b/fs/ssdfs/ssdfs_constants.h
new file mode 100644
index 000000000000..d5ba89d8b272
--- /dev/null
+++ b/fs/ssdfs/ssdfs_constants.h
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/ssdfs_constants.h - SSDFS constant declarations.
+ *
+ * Copyright (c) 2019-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#ifndef _SSDFS_CONSTANTS_H
+#define _SSDFS_CONSTANTS_H
+
+/*
+ * Thread types
+ */
+enum {
+	SSDFS_PEB_READ_THREAD,
+	SSDFS_PEB_FLUSH_THREAD,
+	SSDFS_PEB_GC_THREAD,
+	SSDFS_PEB_THREAD_TYPE_MAX,
+};
+
+enum {
+	SSDFS_SEG_USING_GC_THREAD,
+	SSDFS_SEG_USED_GC_THREAD,
+	SSDFS_SEG_PRE_DIRTY_GC_THREAD,
+	SSDFS_SEG_DIRTY_GC_THREAD,
+	SSDFS_GC_THREAD_TYPE_MAX,
+};
+
+enum {
+	SSDFS_256B	= 256,
+	SSDFS_512B	= 512,
+	SSDFS_1KB	= 1024,
+	SSDFS_2KB	= 2048,
+	SSDFS_4KB	= 4096,
+	SSDFS_8KB	= 8192,
+	SSDFS_16KB	= 16384,
+	SSDFS_32KB	= 32768,
+	SSDFS_64KB	= 65536,
+	SSDFS_128KB	= 131072,
+	SSDFS_256KB	= 262144,
+	SSDFS_512KB	= 524288,
+	SSDFS_1MB	= 1048576,
+	SSDFS_2MB	= 2097152,
+	SSDFS_8MB	= 8388608,
+	SSDFS_16MB	= 16777216,
+	SSDFS_32MB	= 33554432,
+	SSDFS_64MB	= 67108864,
+	SSDFS_128MB	= 134217728,
+	SSDFS_256MB	= 268435456,
+	SSDFS_512MB	= 536870912,
+	SSDFS_1GB	= 1073741824,
+	SSDFS_2GB	= 2147483648,
+	SSDFS_8GB	= 8589934592,
+	SSDFS_16GB	= 17179869184,
+	SSDFS_32GB	= 34359738368,
+	SSDFS_64GB	= 68719476736,
+};
+
+enum {
+	SSDFS_UNKNOWN_PAGE_TYPE,
+	SSDFS_USER_DATA_PAGES,
+	SSDFS_METADATA_PAGES,
+	SSDFS_PAGES_TYPE_MAX
+};
+
+#define SSDFS_INVALID_CNO	U64_MAX
+#define SSDFS_SECTOR_SHIFT	9
+#define SSDFS_DEFAULT_TIMEOUT	(msecs_to_jiffies(120000))
+#define SSDFS_NANOSECS_PER_SEC	(1000000000)
+#define SSDFS_SECS_PER_HOUR	(60 * 60)
+#define SSDFS_HOURS_PER_DAY	(24)
+#define SSDFS_DAYS_PER_WEEK	(7)
+#define SSDFS_WEEKS_PER_MONTH	(4)
+
+#endif /* _SSDFS_CONSTANTS_H */
diff --git a/fs/ssdfs/ssdfs_fs_info.h b/fs/ssdfs/ssdfs_fs_info.h
new file mode 100644
index 000000000000..18ba9c463af4
--- /dev/null
+++ b/fs/ssdfs/ssdfs_fs_info.h
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/ssdfs_fs_info.h - in-core fs information.
+ *
+ * Copyright (c) 2019-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#ifndef _SSDFS_FS_INFO_H
+#define _SSDFS_FS_INFO_H
+
+/* Global FS states */
+enum {
+	SSDFS_UNKNOWN_GLOBAL_FS_STATE,
+	SSDFS_REGULAR_FS_OPERATIONS,
+	SSDFS_METADATA_GOING_FLUSHING,
+	SSDFS_METADATA_UNDER_FLUSH,
+	SSDFS_GLOBAL_FS_STATE_MAX
+};
+
+/*
+ * struct ssdfs_volume_block - logical block
+ * @seg_id: segment ID
+ * @blk_index: block index in segment
+ */
+struct ssdfs_volume_block {
+	u64 seg_id;
+	u16 blk_index;
+};
+
+/*
+ * struct ssdfs_volume_extent - logical extent
+ * @start: initial logical block
+ * @len: extent length
+ */
+struct ssdfs_volume_extent {
+	struct ssdfs_volume_block start;
+	u16 len;
+};
+
+/*
+ * struct ssdfs_peb_extent - PEB's extent
+ * @leb_id: LEB ID
+ * @peb_id: PEB ID
+ * @page_offset: offset in pages
+ * @pages_count: pages count
+ */
+struct ssdfs_peb_extent {
+	u64 leb_id;
+	u64 peb_id;
+	u32 page_offset;
+	u32 pages_count;
+};
+
+/*
+ * struct ssdfs_zone_fragment - zone fragment
+ * @ino: inode identification number
+ * @logical_blk_offset: logical offset from file's beginning in blocks
+ * @extent: zone fragment descriptor
+ */
+struct ssdfs_zone_fragment {
+	u64 ino;
+	u64 logical_blk_offset;
+	struct ssdfs_raw_extent extent;
+};
+
+/*
+ * struct ssdfs_metadata_options - metadata options
+ * @blk_bmap.flags: block bitmap's flags
+ * @blk_bmap.compression: compression type
+ *
+ * @blk2off_tbl.flags: offset transaltion table's flags
+ * @blk2off_tbl.compression: compression type
+ *
+ * @user_data.flags: user data's flags
+ * @user_data.compression: compression type
+ * @user_data.migration_threshold: default value of destination PEBs in migration
+ */
+struct ssdfs_metadata_options {
+	struct {
+		u16 flags;
+		u8 compression;
+	} blk_bmap;
+
+	struct {
+		u16 flags;
+		u8 compression;
+	} blk2off_tbl;
+
+	struct {
+		u16 flags;
+		u8 compression;
+		u16 migration_threshold;
+	} user_data;
+};
+
+/*
+ * struct ssdfs_sb_info - superblock info
+ * @vh_buf: volume header buffer
+ * @vh_buf_size: size of volume header buffer in bytes
+ * @vs_buf: volume state buffer
+ * @vs_buf_size: size of volume state buffer in bytes
+ * @last_log: latest sb log
+ */
+struct ssdfs_sb_info {
+	void *vh_buf;
+	size_t vh_buf_size;
+	void *vs_buf;
+	size_t vs_buf_size;
+	struct ssdfs_peb_extent last_log;
+};
+
+/*
+ * struct ssdfs_device_ops - device operations
+ * @device_name: get device name
+ * @device_size: get device size in bytes
+ * @open_zone: open zone
+ * @reopen_zone: reopen closed zone
+ * @close_zone: close zone
+ * @read: read from device
+ * @readpage: read page
+ * @readpages: read sequence of pages
+ * @can_write_page: can we write into page?
+ * @writepage: write page to device
+ * @writepages: write sequence of pages to device
+ * @erase: erase block
+ * @trim: support of background erase operation
+ * @peb_isbad: check that physical erase block is bad
+ * @sync: synchronize page cache with device
+ */
+struct ssdfs_device_ops {
+	const char * (*device_name)(struct super_block *sb);
+	__u64 (*device_size)(struct super_block *sb);
+	int (*open_zone)(struct super_block *sb, loff_t offset);
+	int (*reopen_zone)(struct super_block *sb, loff_t offset);
+	int (*close_zone)(struct super_block *sb, loff_t offset);
+	int (*read)(struct super_block *sb, loff_t offset, size_t len,
+		    void *buf);
+	int (*readpage)(struct super_block *sb, struct page *page,
+			loff_t offset);
+	int (*readpages)(struct super_block *sb, struct pagevec *pvec,
+			 loff_t offset);
+	int (*can_write_page)(struct super_block *sb, loff_t offset,
+				bool need_check);
+	int (*writepage)(struct super_block *sb, loff_t to_off,
+			 struct page *page, u32 from_off, size_t len);
+	int (*writepages)(struct super_block *sb, loff_t to_off,
+			  struct pagevec *pvec, u32 from_off, size_t len);
+	int (*erase)(struct super_block *sb, loff_t offset, size_t len);
+	int (*trim)(struct super_block *sb, loff_t offset, size_t len);
+	int (*peb_isbad)(struct super_block *sb, loff_t offset);
+	int (*mark_peb_bad)(struct super_block *sb, loff_t offset);
+	void (*sync)(struct super_block *sb);
+};
+
+/*
+ * struct ssdfs_snapshot_subsystem - snapshots subsystem
+ * @reqs_queue: snapshot requests queue
+ * @rules_list: snapshot rules list
+ * @tree: snapshots btree
+ */
+struct ssdfs_snapshot_subsystem {
+	struct ssdfs_snapshot_reqs_queue reqs_queue;
+	struct ssdfs_snapshot_rules_list rules_list;
+	struct ssdfs_snapshots_btree_info *tree;
+};
+
+/*
+ * struct ssdfs_fs_info - in-core fs information
+ * @log_pagesize: log2(page size)
+ * @pagesize: page size in bytes
+ * @log_erasesize: log2(erase block size)
+ * @erasesize: physical erase block size in bytes
+ * @log_segsize: log2(segment size)
+ * @segsize: segment size in bytes
+ * @log_pebs_per_seg: log2(erase blocks per segment)
+ * @pebs_per_seg: physical erase blocks per segment
+ * @pages_per_peb: pages per physical erase block
+ * @pages_per_seg: pages per segment
+ * @leb_pages_capacity: maximal number of logical blocks per LEB
+ * @peb_pages_capacity: maximal number of NAND pages can be written per PEB
+ * @lebs_per_peb_index: difference of LEB IDs between PEB indexes in segment
+ * @fs_ctime: volume create timestamp (mkfs phase)
+ * @fs_cno: volume create checkpoint
+ * @raw_inode_size: raw inode size in bytes
+ * @create_threads_per_seg: number of creation threads per segment
+ * @mount_opts: mount options
+ * @metadata_options: metadata options
+ * @volume_sem: volume semaphore
+ * @last_vh: buffer for last valid volume header
+ * @vh: volume header
+ * @vs: volume state
+ * @sbi: superblock info
+ * @sbi_backup: backup copy of superblock info
+ * @sb_seg_log_pages: full log size in sb segment (pages count)
+ * @segbmap_log_pages: full log size in segbmap segment (pages count)
+ * @maptbl_log_pages: full log size in maptbl segment (pages count)
+ * @lnodes_seg_log_pages: full log size in leaf nodes segment (pages count)
+ * @hnodes_seg_log_pages: full log size in hybrid nodes segment (pages count)
+ * @inodes_seg_log_pages: full log size in index nodes segment (pages count)
+ * @user_data_log_pages: full log size in user data segment (pages count)
+ * @volume_state_lock: lock for mutable volume metadata
+ * @free_pages: free pages count on the volume
+ * @reserved_new_user_data_pages: reserved pages of growing files' content
+ * @updated_user_data_pages: number of updated pages of files' content
+ * @flushing_user_data_requests: number of user data processing flush request
+ * @pending_wq: wait queue for flush threads of user data segments
+ * @finish_user_data_flush_wq: wait queue for waiting the end of user data flush
+ * @fs_mount_time: file system mount timestamp
+ * @fs_mod_time: last write timestamp
+ * @fs_mount_cno: mount checkpoint
+ * @boot_vs_mount_timediff: difference between boottime and mounttime
+ * @fs_flags: file system flags
+ * @fs_state: file system state
+ * @fs_errors: behaviour when detecting errors
+ * @fs_feature_compat: compatible feature set
+ * @fs_feature_compat_ro: read-only compatible feature set
+ * @fs_feature_incompat: incompatible feature set
+ * @fs_uuid: 128-bit volume's uuid
+ * @fs_label: volume name
+ * @migration_threshold: default value of destination PEBs in migration
+ * @resize_mutex: resize mutex
+ * @nsegs: number of segments on the volume
+ * @sb_segs_sem: semaphore for superblock's array of LEB/PEB numbers
+ * @sb_lebs: array of LEB ID numbers
+ * @sb_pebs: array of PEB ID numbers
+ * @segbmap: segment bitmap object
+ * @segbmap_inode: segment bitmap inode
+ * @maptbl: PEB mapping table object
+ * @maptbl_cache: maptbl cache
+ * @segs_tree: tree of segment objects
+ * @segs_tree_inode: segment tree inode
+ * @cur_segs: array of current segments
+ * @shextree: shared extents tree
+ * @shdictree: shared dictionary
+ * @inodes_tree: inodes btree
+ * @invextree: invalidated extents btree
+ * @snapshots: snapshots subsystem
+ * @gc_thread: array of GC threads
+ * @gc_wait_queue: array of GC threads' wait queues
+ * @gc_should_act: array of counters that define necessity of GC activity
+ * @flush_reqs: current number of flush requests
+ * @sb: pointer on VFS superblock object
+ * @mtd: MTD info
+ * @devops: device access operations
+ * @pending_bios: count of pending BIOs (dev_bdev.c ONLY)
+ * @erase_page: page with content for erase operation (dev_bdev.c ONLY)
+ * @is_zns_device: file system volume is on ZNS device
+ * @zone_size: zone size in bytes
+ * @zone_capacity: zone capacity in bytes available for write operations
+ * @max_open_zones: open zones limitation (upper bound)
+ * @open_zones: current number of opened zones
+ * @dev_kobj: /sys/fs/ssdfs/<device> kernel object
+ * @dev_kobj_unregister: completion state for <device> kernel object
+ * @maptbl_kobj: /sys/fs/<ssdfs>/<device>/maptbl kernel object
+ * @maptbl_kobj_unregister: completion state for maptbl kernel object
+ * @segbmap_kobj: /sys/fs/<ssdfs>/<device>/segbmap kernel object
+ * @segbmap_kobj_unregister: completion state for segbmap kernel object
+ * @segments_kobj: /sys/fs/<ssdfs>/<device>/segments kernel object
+ * @segments_kobj_unregister: completion state for segments kernel object
+ */
+struct ssdfs_fs_info {
+	u8 log_pagesize;
+	u32 pagesize;
+	u8 log_erasesize;
+	u32 erasesize;
+	u8 log_segsize;
+	u32 segsize;
+	u8 log_pebs_per_seg;
+	u32 pebs_per_seg;
+	u32 pages_per_peb;
+	u32 pages_per_seg;
+	u32 leb_pages_capacity;
+	u32 peb_pages_capacity;
+	u32 lebs_per_peb_index;
+	u64 fs_ctime;
+	u64 fs_cno;
+	u16 raw_inode_size;
+	u16 create_threads_per_seg;
+
+	unsigned long mount_opts;
+	struct ssdfs_metadata_options metadata_options;
+
+	struct rw_semaphore volume_sem;
+	struct ssdfs_volume_header last_vh;
+	struct ssdfs_volume_header *vh;
+	struct ssdfs_volume_state *vs;
+	struct ssdfs_sb_info sbi;
+	struct ssdfs_sb_info sbi_backup;
+	u16 sb_seg_log_pages;
+	u16 segbmap_log_pages;
+	u16 maptbl_log_pages;
+	u16 lnodes_seg_log_pages;
+	u16 hnodes_seg_log_pages;
+	u16 inodes_seg_log_pages;
+	u16 user_data_log_pages;
+
+	atomic_t global_fs_state;
+
+	spinlock_t volume_state_lock;
+	u64 free_pages;
+	u64 reserved_new_user_data_pages;
+	u64 updated_user_data_pages;
+	u64 flushing_user_data_requests;
+	wait_queue_head_t pending_wq;
+	wait_queue_head_t finish_user_data_flush_wq;
+	u64 fs_mount_time;
+	u64 fs_mod_time;
+	u64 fs_mount_cno;
+	u64 boot_vs_mount_timediff;
+	u32 fs_flags;
+	u16 fs_state;
+	u16 fs_errors;
+	u64 fs_feature_compat;
+	u64 fs_feature_compat_ro;
+	u64 fs_feature_incompat;
+	unsigned char fs_uuid[SSDFS_UUID_SIZE];
+	char fs_label[SSDFS_VOLUME_LABEL_MAX];
+	u16 migration_threshold;
+
+	struct mutex resize_mutex;
+	u64 nsegs;
+
+	struct rw_semaphore sb_segs_sem;
+	u64 sb_lebs[SSDFS_SB_CHAIN_MAX][SSDFS_SB_SEG_COPY_MAX];
+	u64 sb_pebs[SSDFS_SB_CHAIN_MAX][SSDFS_SB_SEG_COPY_MAX];
+
+	struct ssdfs_segment_bmap *segbmap;
+	struct inode *segbmap_inode;
+
+	struct ssdfs_peb_mapping_table *maptbl;
+	struct ssdfs_maptbl_cache maptbl_cache;
+
+	struct ssdfs_segment_tree *segs_tree;
+	struct inode *segs_tree_inode;
+
+	struct ssdfs_current_segs_array *cur_segs;
+
+	struct ssdfs_shared_extents_tree *shextree;
+	struct ssdfs_shared_dict_btree_info *shdictree;
+	struct ssdfs_inodes_btree_info *inodes_tree;
+	struct ssdfs_invextree_info *invextree;
+
+	struct ssdfs_snapshot_subsystem snapshots;
+
+	struct ssdfs_thread_info gc_thread[SSDFS_GC_THREAD_TYPE_MAX];
+	wait_queue_head_t gc_wait_queue[SSDFS_GC_THREAD_TYPE_MAX];
+	atomic_t gc_should_act[SSDFS_GC_THREAD_TYPE_MAX];
+	atomic64_t flush_reqs;
+
+	struct super_block *sb;
+
+	struct mtd_info *mtd;
+	const struct ssdfs_device_ops *devops;
+	atomic_t pending_bios;			/* for dev_bdev.c */
+	struct page *erase_page;		/* for dev_bdev.c */
+
+	bool is_zns_device;
+	u64 zone_size;
+	u64 zone_capacity;
+	u32 max_open_zones;
+	atomic_t open_zones;
+
+	/* /sys/fs/ssdfs/<device> */
+	struct kobject dev_kobj;
+	struct completion dev_kobj_unregister;
+
+	/* /sys/fs/<ssdfs>/<device>/maptbl */
+	struct kobject maptbl_kobj;
+	struct completion maptbl_kobj_unregister;
+
+	/* /sys/fs/<ssdfs>/<device>/segbmap */
+	struct kobject segbmap_kobj;
+	struct completion segbmap_kobj_unregister;
+
+	/* /sys/fs/<ssdfs>/<device>/segments */
+	struct kobject segments_kobj;
+	struct completion segments_kobj_unregister;
+
+#ifdef CONFIG_SSDFS_TESTING
+	struct address_space testing_pages;
+	struct inode *testing_inode;
+	bool do_fork_invalidation;
+#endif /* CONFIG_SSDFS_TESTING */
+};
+
+#define SSDFS_FS_I(sb) \
+	((struct ssdfs_fs_info *)(sb->s_fs_info))
+
+/*
+ * GC thread functions
+ */
+int ssdfs_using_seg_gc_thread_func(void *data);
+int ssdfs_used_seg_gc_thread_func(void *data);
+int ssdfs_pre_dirty_seg_gc_thread_func(void *data);
+int ssdfs_dirty_seg_gc_thread_func(void *data);
+int ssdfs_start_gc_thread(struct ssdfs_fs_info *fsi, int type);
+int ssdfs_stop_gc_thread(struct ssdfs_fs_info *fsi, int type);
+
+/*
+ * Device operations
+ */
+extern const struct ssdfs_device_ops ssdfs_mtd_devops;
+extern const struct ssdfs_device_ops ssdfs_bdev_devops;
+extern const struct ssdfs_device_ops ssdfs_zns_devops;
+
+#endif /* _SSDFS_FS_INFO_H */
diff --git a/fs/ssdfs/ssdfs_inline.h b/fs/ssdfs/ssdfs_inline.h
new file mode 100644
index 000000000000..9c416438b291
--- /dev/null
+++ b/fs/ssdfs/ssdfs_inline.h
@@ -0,0 +1,1346 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/ssdfs_inline.h - inline functions and macros.
+ *
+ * Copyright (c) 2019-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#ifndef _SSDFS_INLINE_H
+#define _SSDFS_INLINE_H
+
+#include <linux/slab.h>
+#include <linux/swap.h>
+
+#define SSDFS_CRIT(fmt, ...) \
+	pr_crit("pid %d:%s:%d %s(): " fmt, \
+		 current->pid, __FILE__, __LINE__, __func__, ##__VA_ARGS__)
+
+#define SSDFS_ERR(fmt, ...) \
+	pr_err("pid %d:%s:%d %s(): " fmt, \
+		 current->pid, __FILE__, __LINE__, __func__, ##__VA_ARGS__)
+
+#define SSDFS_WARN(fmt, ...) \
+	do { \
+		pr_warn("pid %d:%s:%d %s(): " fmt, \
+			current->pid, __FILE__, __LINE__, \
+			__func__, ##__VA_ARGS__); \
+		dump_stack(); \
+	} while (0)
+
+#define SSDFS_NOTICE(fmt, ...) \
+	pr_notice(fmt, ##__VA_ARGS__)
+
+#define SSDFS_INFO(fmt, ...) \
+	pr_info(fmt, ##__VA_ARGS__)
+
+#ifdef CONFIG_SSDFS_DEBUG
+
+#define SSDFS_DBG(fmt, ...) \
+	pr_debug("pid %d:%s:%d %s(): " fmt, \
+		 current->pid, __FILE__, __LINE__, __func__, ##__VA_ARGS__)
+
+#else /* CONFIG_SSDFS_DEBUG */
+
+#define SSDFS_DBG(fmt, ...) \
+	no_printk(KERN_DEBUG fmt, ##__VA_ARGS__)
+
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+extern atomic64_t ssdfs_allocated_pages;
+extern atomic64_t ssdfs_memory_leaks;
+
+extern atomic64_t ssdfs_locked_pages;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+static inline
+void ssdfs_memory_leaks_increment(void *kaddr)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_inc(&ssdfs_memory_leaks);
+
+	SSDFS_DBG("memory %p, allocation count %lld\n",
+		  kaddr,
+		  atomic64_read(&ssdfs_memory_leaks));
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+static inline
+void ssdfs_memory_leaks_decrement(void *kaddr)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_dec(&ssdfs_memory_leaks);
+
+	SSDFS_DBG("memory %p, allocation count %lld\n",
+		  kaddr,
+		  atomic64_read(&ssdfs_memory_leaks));
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+static inline
+void *ssdfs_kmalloc(size_t size, gfp_t flags)
+{
+	void *kaddr = kmalloc(size, flags);
+
+	if (kaddr)
+		ssdfs_memory_leaks_increment(kaddr);
+
+	return kaddr;
+}
+
+static inline
+void *ssdfs_kzalloc(size_t size, gfp_t flags)
+{
+	void *kaddr = kzalloc(size, flags);
+
+	if (kaddr)
+		ssdfs_memory_leaks_increment(kaddr);
+
+	return kaddr;
+}
+
+static inline
+void *ssdfs_kvzalloc(size_t size, gfp_t flags)
+{
+	void *kaddr = kvzalloc(size, flags);
+
+	if (kaddr)
+		ssdfs_memory_leaks_increment(kaddr);
+
+	return kaddr;
+}
+
+static inline
+void *ssdfs_kcalloc(size_t n, size_t size, gfp_t flags)
+{
+	void *kaddr = kcalloc(n, size, flags);
+
+	if (kaddr)
+		ssdfs_memory_leaks_increment(kaddr);
+
+	return kaddr;
+}
+
+static inline
+void ssdfs_kfree(void *kaddr)
+{
+	if (kaddr) {
+		ssdfs_memory_leaks_decrement(kaddr);
+		kfree(kaddr);
+	}
+}
+
+static inline
+void ssdfs_kvfree(void *kaddr)
+{
+	if (kaddr) {
+		ssdfs_memory_leaks_decrement(kaddr);
+		kvfree(kaddr);
+	}
+}
+
+static inline
+void ssdfs_get_page(struct page *page)
+{
+	get_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d, flags %#lx\n",
+		  page, page_ref_count(page), page->flags);
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+static inline
+void ssdfs_put_page(struct page *page)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (page_ref_count(page) < 1) {
+		SSDFS_WARN("page %p, count %d\n",
+			  page, page_ref_count(page));
+	}
+}
+
+static inline
+void ssdfs_lock_page(struct page *page)
+{
+	lock_page(page);
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_locked_pages) < 0) {
+		SSDFS_WARN("ssdfs_locked_pages %lld\n",
+			   atomic64_read(&ssdfs_locked_pages));
+	}
+
+	atomic64_inc(&ssdfs_locked_pages);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+static inline
+void ssdfs_account_locked_page(struct page *page)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (!page)
+		return;
+
+	if (!PageLocked(page)) {
+		SSDFS_WARN("page %p, page_index %llu\n",
+			   page, (u64)page_index(page));
+	}
+
+	if (atomic64_read(&ssdfs_locked_pages) < 0) {
+		SSDFS_WARN("ssdfs_locked_pages %lld\n",
+			   atomic64_read(&ssdfs_locked_pages));
+	}
+
+	atomic64_inc(&ssdfs_locked_pages);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+static inline
+void ssdfs_unlock_page(struct page *page)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (!PageLocked(page)) {
+		SSDFS_WARN("page %p, page_index %llu\n",
+			   page, (u64)page_index(page));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+	unlock_page(page);
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_dec(&ssdfs_locked_pages);
+
+	if (atomic64_read(&ssdfs_locked_pages) < 0) {
+		SSDFS_WARN("ssdfs_locked_pages %lld\n",
+			   atomic64_read(&ssdfs_locked_pages));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+static inline
+struct page *ssdfs_alloc_page(gfp_t gfp_mask)
+{
+	struct page *page;
+
+	page = alloc_page(gfp_mask);
+	if (unlikely(!page)) {
+		SSDFS_ERR("unable to allocate memory page\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ssdfs_get_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d, "
+		  "flags %#lx, page_index %lu\n",
+		  page, page_ref_count(page),
+		  page->flags, page_index(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_inc(&ssdfs_allocated_pages);
+
+	SSDFS_DBG("page %p, allocated_pages %lld\n",
+		  page, atomic64_read(&ssdfs_allocated_pages));
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+	return page;
+}
+
+static inline
+void ssdfs_account_page(struct page *page)
+{
+	return;
+}
+
+static inline
+void ssdfs_forget_page(struct page *page)
+{
+	return;
+}
+
+/*
+ * ssdfs_add_pagevec_page() - add page into pagevec
+ * @pvec: pagevec
+ *
+ * This function adds empty page into pagevec.
+ *
+ * RETURN:
+ * [success] - pointer on added page.
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - fail to allocate memory.
+ * %-E2BIG      - pagevec is full.
+ */
+static inline
+struct page *ssdfs_add_pagevec_page(struct pagevec *pvec)
+{
+	struct page *page;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pvec);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (pagevec_space(pvec) == 0) {
+		SSDFS_ERR("pagevec hasn't space\n");
+		return ERR_PTR(-E2BIG);
+	}
+
+	page = ssdfs_alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (IS_ERR_OR_NULL(page)) {
+		err = (page == NULL ? -ENOMEM : PTR_ERR(page));
+		SSDFS_ERR("unable to allocate memory page\n");
+		return ERR_PTR(err);
+	}
+
+	pagevec_add(pvec, page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pvec %p, pagevec count %u\n",
+		  pvec, pagevec_count(pvec));
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return page;
+}
+
+static inline
+void ssdfs_free_page(struct page *page)
+{
+	if (!page)
+		return;
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (PageLocked(page)) {
+		SSDFS_WARN("page %p is still locked\n",
+			   page);
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (page_ref_count(page) <= 0 ||
+	    page_ref_count(page) > 1) {
+		SSDFS_WARN("page %p, count %d\n",
+			  page, page_ref_count(page));
+	}
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_dec(&ssdfs_allocated_pages);
+
+	SSDFS_DBG("page %p, allocated_pages %lld\n",
+		  page, atomic64_read(&ssdfs_allocated_pages));
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+	__free_pages(page, 0);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d, "
+		  "flags %#lx, page_index %lu\n",
+		  page, page_ref_count(page),
+		  page->flags, page_index(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+static inline
+void ssdfs_pagevec_release(struct pagevec *pvec)
+{
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pvec %p\n", pvec);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!pvec)
+		return;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("pvec count %u\n", pagevec_count(pvec));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+
+		if (!page)
+			continue;
+
+		ssdfs_free_page(page);
+
+		pvec->pages[i] = NULL;
+	}
+
+	pagevec_reinit(pvec);
+}
+
+#define SSDFS_MEMORY_LEAKS_CHECKER_FNS(name)				\
+static inline								\
+void ssdfs_##name##_cache_leaks_increment(void *kaddr)			\
+{									\
+	atomic64_inc(&ssdfs_##name##_cache_leaks);			\
+	SSDFS_DBG("memory %p, allocation count %lld\n",			\
+		  kaddr,						\
+		  atomic64_read(&ssdfs_##name##_cache_leaks));		\
+	ssdfs_memory_leaks_increment(kaddr);				\
+}									\
+static inline								\
+void ssdfs_##name##_cache_leaks_decrement(void *kaddr)			\
+{									\
+	atomic64_dec(&ssdfs_##name##_cache_leaks);			\
+	SSDFS_DBG("memory %p, allocation count %lld\n",			\
+		  kaddr,						\
+		  atomic64_read(&ssdfs_##name##_cache_leaks));		\
+	ssdfs_memory_leaks_decrement(kaddr);				\
+}									\
+static inline								\
+void *ssdfs_##name##_kmalloc(size_t size, gfp_t flags)			\
+{									\
+	void *kaddr = ssdfs_kmalloc(size, flags);			\
+	if (kaddr) {							\
+		atomic64_inc(&ssdfs_##name##_memory_leaks);		\
+		SSDFS_DBG("memory %p, allocation count %lld\n",		\
+			  kaddr,					\
+			  atomic64_read(&ssdfs_##name##_memory_leaks));	\
+	}								\
+	return kaddr;							\
+}									\
+static inline								\
+void *ssdfs_##name##_kzalloc(size_t size, gfp_t flags)			\
+{									\
+	void *kaddr = ssdfs_kzalloc(size, flags);			\
+	if (kaddr) {							\
+		atomic64_inc(&ssdfs_##name##_memory_leaks);		\
+		SSDFS_DBG("memory %p, allocation count %lld\n",		\
+			  kaddr,					\
+			  atomic64_read(&ssdfs_##name##_memory_leaks));	\
+	}								\
+	return kaddr;							\
+}									\
+static inline								\
+void *ssdfs_##name##_kvzalloc(size_t size, gfp_t flags)			\
+{									\
+	void *kaddr = ssdfs_kvzalloc(size, flags);			\
+	if (kaddr) {							\
+		atomic64_inc(&ssdfs_##name##_memory_leaks);		\
+		SSDFS_DBG("memory %p, allocation count %lld\n",		\
+			  kaddr,					\
+			  atomic64_read(&ssdfs_##name##_memory_leaks));	\
+	}								\
+	return kaddr;							\
+}									\
+static inline								\
+void *ssdfs_##name##_kcalloc(size_t n, size_t size, gfp_t flags)	\
+{									\
+	void *kaddr = ssdfs_kcalloc(n, size, flags);			\
+	if (kaddr) {							\
+		atomic64_inc(&ssdfs_##name##_memory_leaks);		\
+		SSDFS_DBG("memory %p, allocation count %lld\n",		\
+			  kaddr,					\
+			  atomic64_read(&ssdfs_##name##_memory_leaks));	\
+	}								\
+	return kaddr;							\
+}									\
+static inline								\
+void ssdfs_##name##_kfree(void *kaddr)					\
+{									\
+	if (kaddr) {							\
+		atomic64_dec(&ssdfs_##name##_memory_leaks);		\
+		SSDFS_DBG("memory %p, allocation count %lld\n",		\
+			  kaddr,					\
+			  atomic64_read(&ssdfs_##name##_memory_leaks));	\
+	}								\
+	ssdfs_kfree(kaddr);						\
+}									\
+static inline								\
+void ssdfs_##name##_kvfree(void *kaddr)					\
+{									\
+	if (kaddr) {							\
+		atomic64_dec(&ssdfs_##name##_memory_leaks);		\
+		SSDFS_DBG("memory %p, allocation count %lld\n",		\
+			  kaddr,					\
+			  atomic64_read(&ssdfs_##name##_memory_leaks));	\
+	}								\
+	ssdfs_kvfree(kaddr);						\
+}									\
+static inline								\
+struct page *ssdfs_##name##_alloc_page(gfp_t gfp_mask)			\
+{									\
+	struct page *page;						\
+	page = ssdfs_alloc_page(gfp_mask);				\
+	if (!IS_ERR_OR_NULL(page)) {					\
+		atomic64_inc(&ssdfs_##name##_page_leaks);		\
+		SSDFS_DBG("page %p, allocated_pages %lld\n",		\
+			  page,						\
+			  atomic64_read(&ssdfs_##name##_page_leaks));	\
+	}								\
+	return page;							\
+}									\
+static inline								\
+void ssdfs_##name##_account_page(struct page *page)			\
+{									\
+	if (page) {							\
+		atomic64_inc(&ssdfs_##name##_page_leaks);		\
+		SSDFS_DBG("page %p, allocated_pages %lld\n",		\
+			  page,						\
+			  atomic64_read(&ssdfs_##name##_page_leaks));	\
+	}								\
+}									\
+static inline								\
+void ssdfs_##name##_forget_page(struct page *page)			\
+{									\
+	if (page) {							\
+		atomic64_dec(&ssdfs_##name##_page_leaks);		\
+		SSDFS_DBG("page %p, allocated_pages %lld\n",		\
+			  page,						\
+			  atomic64_read(&ssdfs_##name##_page_leaks));	\
+	}								\
+}									\
+static inline								\
+struct page *ssdfs_##name##_add_pagevec_page(struct pagevec *pvec)	\
+{									\
+	struct page *page;						\
+	page = ssdfs_add_pagevec_page(pvec);				\
+	if (!IS_ERR_OR_NULL(page)) {					\
+		atomic64_inc(&ssdfs_##name##_page_leaks);		\
+		SSDFS_DBG("page %p, allocated_pages %lld\n",		\
+			  page,						\
+			  atomic64_read(&ssdfs_##name##_page_leaks));	\
+	}								\
+	return page;							\
+}									\
+static inline								\
+void ssdfs_##name##_free_page(struct page *page)			\
+{									\
+	if (page) {							\
+		atomic64_dec(&ssdfs_##name##_page_leaks);		\
+		SSDFS_DBG("page %p, allocated_pages %lld\n",		\
+			  page,						\
+			  atomic64_read(&ssdfs_##name##_page_leaks));	\
+	}								\
+	ssdfs_free_page(page);						\
+}									\
+static inline								\
+void ssdfs_##name##_pagevec_release(struct pagevec *pvec)		\
+{									\
+	int i;								\
+	if (pvec) {							\
+		for (i = 0; i < pagevec_count(pvec); i++) {		\
+			struct page *page = pvec->pages[i];		\
+			if (!page)					\
+				continue;				\
+			atomic64_dec(&ssdfs_##name##_page_leaks);	\
+			SSDFS_DBG("page %p, allocated_pages %lld\n",	\
+			    page,					\
+			    atomic64_read(&ssdfs_##name##_page_leaks));	\
+		}							\
+	}								\
+	ssdfs_pagevec_release(pvec);					\
+}									\
+
+#define SSDFS_MEMORY_ALLOCATOR_FNS(name)				\
+static inline								\
+void ssdfs_##name##_cache_leaks_increment(void *kaddr)			\
+{									\
+	ssdfs_memory_leaks_increment(kaddr);				\
+}									\
+static inline								\
+void ssdfs_##name##_cache_leaks_decrement(void *kaddr)			\
+{									\
+	ssdfs_memory_leaks_decrement(kaddr);				\
+}									\
+static inline								\
+void *ssdfs_##name##_kmalloc(size_t size, gfp_t flags)			\
+{									\
+	return ssdfs_kmalloc(size, flags);				\
+}									\
+static inline								\
+void *ssdfs_##name##_kzalloc(size_t size, gfp_t flags)			\
+{									\
+	return ssdfs_kzalloc(size, flags);				\
+}									\
+static inline								\
+void *ssdfs_##name##_kvzalloc(size_t size, gfp_t flags)			\
+{									\
+	return ssdfs_kvzalloc(size, flags);				\
+}									\
+static inline								\
+void *ssdfs_##name##_kcalloc(size_t n, size_t size, gfp_t flags)	\
+{									\
+	return ssdfs_kcalloc(n, size, flags);				\
+}									\
+static inline								\
+void ssdfs_##name##_kfree(void *kaddr)					\
+{									\
+	ssdfs_kfree(kaddr);						\
+}									\
+static inline								\
+void ssdfs_##name##_kvfree(void *kaddr)					\
+{									\
+	ssdfs_kvfree(kaddr);						\
+}									\
+static inline								\
+struct page *ssdfs_##name##_alloc_page(gfp_t gfp_mask)			\
+{									\
+	return ssdfs_alloc_page(gfp_mask);				\
+}									\
+static inline								\
+void ssdfs_##name##_account_page(struct page *page)			\
+{									\
+	ssdfs_account_page(page);					\
+}									\
+static inline								\
+void ssdfs_##name##_forget_page(struct page *page)			\
+{									\
+	ssdfs_forget_page(page);					\
+}									\
+static inline								\
+struct page *ssdfs_##name##_add_pagevec_page(struct pagevec *pvec)	\
+{									\
+	return ssdfs_add_pagevec_page(pvec);				\
+}									\
+static inline								\
+void ssdfs_##name##_free_page(struct page *page)			\
+{									\
+	ssdfs_free_page(page);						\
+}									\
+static inline								\
+void ssdfs_##name##_pagevec_release(struct pagevec *pvec)		\
+{									\
+	ssdfs_pagevec_release(pvec);					\
+}									\
+
+static inline
+__le32 ssdfs_crc32_le(void *data, size_t len)
+{
+	return cpu_to_le32(crc32(~0, data, len));
+}
+
+static inline
+int ssdfs_calculate_csum(struct ssdfs_metadata_check *check,
+			  void *buf, size_t buf_size)
+{
+	u16 bytes;
+	u16 flags;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!check || !buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	bytes = le16_to_cpu(check->bytes);
+	flags = le16_to_cpu(check->flags);
+
+	if (bytes > buf_size) {
+		SSDFS_ERR("corrupted size %d of checked data\n", bytes);
+		return -EINVAL;
+	}
+
+	if (flags & SSDFS_CRC32) {
+		check->csum = 0;
+		check->csum = ssdfs_crc32_le(buf, bytes);
+	} else {
+		SSDFS_ERR("unknown flags set %#x\n", flags);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline
+bool is_csum_valid(struct ssdfs_metadata_check *check,
+		   void *buf, size_t buf_size)
+{
+	__le32 old_csum;
+	__le32 calc_csum;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!check);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	old_csum = check->csum;
+
+	err = ssdfs_calculate_csum(check, buf, buf_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to calculate checksum\n");
+		return false;
+	}
+
+	calc_csum = check->csum;
+	check->csum = old_csum;
+
+	if (old_csum != calc_csum) {
+		SSDFS_ERR("old_csum %#x != calc_csum %#x\n",
+			  __le32_to_cpu(old_csum),
+			  __le32_to_cpu(calc_csum));
+		return false;
+	}
+
+	return true;
+}
+
+static inline
+bool is_ssdfs_magic_valid(struct ssdfs_signature *magic)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!magic);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (le32_to_cpu(magic->common) != SSDFS_SUPER_MAGIC)
+		return false;
+	if (magic->version.major > SSDFS_MAJOR_REVISION ||
+	    magic->version.minor > SSDFS_MINOR_REVISION) {
+		SSDFS_INFO("Volume has unsupported %u.%u version. "
+			   "Driver expects %u.%u version.\n",
+			   magic->version.major,
+			   magic->version.minor,
+			   SSDFS_MAJOR_REVISION,
+			   SSDFS_MINOR_REVISION);
+		return false;
+	}
+
+	return true;
+}
+
+#define SSDFS_SEG_HDR(ptr) \
+	((struct ssdfs_segment_header *)(ptr))
+#define SSDFS_LF(ptr) \
+	((struct ssdfs_log_footer *)(ptr))
+#define SSDFS_VH(ptr) \
+	((struct ssdfs_volume_header *)(ptr))
+#define SSDFS_VS(ptr) \
+	((struct ssdfs_volume_state *)(ptr))
+#define SSDFS_PLH(ptr) \
+	((struct ssdfs_partial_log_header *)(ptr))
+
+/*
+ * Flags for mount options.
+ */
+#define SSDFS_MOUNT_COMPR_MODE_NONE		(1 << 0)
+#define SSDFS_MOUNT_COMPR_MODE_ZLIB		(1 << 1)
+#define SSDFS_MOUNT_COMPR_MODE_LZO		(1 << 2)
+#define SSDFS_MOUNT_ERRORS_CONT			(1 << 3)
+#define SSDFS_MOUNT_ERRORS_RO			(1 << 4)
+#define SSDFS_MOUNT_ERRORS_PANIC		(1 << 5)
+#define SSDFS_MOUNT_IGNORE_FS_STATE		(1 << 6)
+
+#define ssdfs_clear_opt(o, opt)		((o) &= ~SSDFS_MOUNT_##opt)
+#define ssdfs_set_opt(o, opt)		((o) |= SSDFS_MOUNT_##opt)
+#define ssdfs_test_opt(o, opt)		((o) & SSDFS_MOUNT_##opt)
+
+#define SSDFS_LOG_FOOTER_OFF(seg_hdr)({ \
+	u32 offset; \
+	int index; \
+	struct ssdfs_metadata_descriptor *desc; \
+	index = SSDFS_LOG_FOOTER_INDEX; \
+	desc = &SSDFS_SEG_HDR(seg_hdr)->desc_array[index]; \
+	offset = le32_to_cpu(desc->offset); \
+	offset; \
+})
+
+#define SSDFS_LOG_PAGES(seg_hdr) \
+	(le16_to_cpu(SSDFS_SEG_HDR(seg_hdr)->log_pages))
+#define SSDFS_SEG_TYPE(seg_hdr) \
+	(le16_to_cpu(SSDFS_SEG_HDR(seg_hdr)->seg_type))
+
+#define SSDFS_MAIN_SB_PEB(vh, type) \
+	(le64_to_cpu(SSDFS_VH(vh)->sb_pebs[type][SSDFS_MAIN_SB_SEG].peb_id))
+#define SSDFS_COPY_SB_PEB(vh, type) \
+	(le64_to_cpu(SSDFS_VH(vh)->sb_pebs[type][SSDFS_COPY_SB_SEG].peb_id))
+#define SSDFS_MAIN_SB_LEB(vh, type) \
+	(le64_to_cpu(SSDFS_VH(vh)->sb_pebs[type][SSDFS_MAIN_SB_SEG].leb_id))
+#define SSDFS_COPY_SB_LEB(vh, type) \
+	(le64_to_cpu(SSDFS_VH(vh)->sb_pebs[type][SSDFS_COPY_SB_SEG].leb_id))
+
+#define SSDFS_SEG_CNO(seg_hdr) \
+	(le64_to_cpu(SSDFS_SEG_HDR(seg_hdr)->cno))
+
+static inline
+u64 ssdfs_current_timestamp(void)
+{
+	struct timespec64 cur_time;
+
+	ktime_get_coarse_real_ts64(&cur_time);
+
+	return (u64)timespec64_to_ns(&cur_time);
+}
+
+static inline
+void ssdfs_init_boot_vs_mount_timediff(struct ssdfs_fs_info *fsi)
+{
+	struct timespec64 uptime;
+
+	ktime_get_boottime_ts64(&uptime);
+	fsi->boot_vs_mount_timediff = timespec64_to_ns(&uptime);
+}
+
+static inline
+u64 ssdfs_current_cno(struct super_block *sb)
+{
+	struct ssdfs_fs_info *fsi = SSDFS_FS_I(sb);
+	struct timespec64 uptime;
+	u64 boot_vs_mount_timediff;
+	u64 fs_mount_cno;
+
+	spin_lock(&fsi->volume_state_lock);
+	boot_vs_mount_timediff = fsi->boot_vs_mount_timediff;
+	fs_mount_cno = fsi->fs_mount_cno;
+	spin_unlock(&fsi->volume_state_lock);
+
+	ktime_get_boottime_ts64(&uptime);
+	return fs_mount_cno +
+		timespec64_to_ns(&uptime) -
+		boot_vs_mount_timediff;
+}
+
+#define SSDFS_MAPTBL_CACHE_HDR(ptr) \
+	((struct ssdfs_maptbl_cache_header *)(ptr))
+
+#define SSDFS_SEG_HDR_MAGIC(vh) \
+	(le16_to_cpu(SSDFS_VH(vh)->magic.key))
+#define SSDFS_SEG_TIME(seg_hdr) \
+	(le64_to_cpu(SSDFS_SEG_HDR(seg_hdr)->timestamp))
+
+#define SSDFS_VH_CNO(vh) \
+	(le64_to_cpu(SSDFS_VH(vh)->create_cno))
+#define SSDFS_VH_TIME(vh) \
+	(le64_to_cpu(SSDFS_VH(vh)->create_timestamp)
+
+#define SSDFS_VS_CNO(vs) \
+	(le64_to_cpu(SSDFS_VS(vs)->cno))
+#define SSDFS_VS_TIME(vs) \
+	(le64_to_cpu(SSDFS_VS(vs)->timestamp)
+
+#define SSDFS_POFFTH(ptr) \
+	((struct ssdfs_phys_offset_table_header *)(ptr))
+#define SSDFS_PHYSOFFD(ptr) \
+	((struct ssdfs_phys_offset_descriptor *)(ptr))
+
+static inline
+pgoff_t ssdfs_phys_page_to_mem_page(struct ssdfs_fs_info *fsi,
+				    pgoff_t index)
+{
+	if (fsi->log_pagesize == PAGE_SHIFT)
+		return index;
+	else if (fsi->log_pagesize > PAGE_SHIFT)
+		return index << (fsi->log_pagesize - PAGE_SHIFT);
+	else
+		return index >> (PAGE_SHIFT - fsi->log_pagesize);
+}
+
+static inline
+pgoff_t ssdfs_mem_page_to_phys_page(struct ssdfs_fs_info *fsi,
+				    pgoff_t index)
+{
+	if (fsi->log_pagesize == PAGE_SHIFT)
+		return index;
+	else if (fsi->log_pagesize > PAGE_SHIFT)
+		return index >> (fsi->log_pagesize - PAGE_SHIFT);
+	else
+		return index << (PAGE_SHIFT - fsi->log_pagesize);
+}
+
+#define SSDFS_MEMPAGE2BYTES(index) \
+	((pgoff_t)index << PAGE_SHIFT)
+#define SSDFS_BYTES2MEMPAGE(offset) \
+	((pgoff_t)offset >> PAGE_SHIFT)
+
+/*
+ * ssdfs_write_offset_to_mem_page_index() - convert write offset into mem page
+ * @fsi: pointer on shared file system object
+ * @start_page: index of log's start physical page
+ * @write_offset: offset in bytes from log's beginning
+ */
+static inline
+pgoff_t ssdfs_write_offset_to_mem_page_index(struct ssdfs_fs_info *fsi,
+					     u16 start_page,
+					     u32 write_offset)
+{
+	u32 page_off;
+
+	page_off = ssdfs_phys_page_to_mem_page(fsi, start_page);
+	page_off = SSDFS_MEMPAGE2BYTES(page_off) + write_offset;
+	return SSDFS_BYTES2MEMPAGE(page_off);
+}
+
+#define SSDFS_BLKBMP_HDR(ptr) \
+	((struct ssdfs_block_bitmap_header *)(ptr))
+#define SSDFS_SBMP_FRAG_HDR(ptr) \
+	((struct ssdfs_segbmap_fragment_header *)(ptr))
+#define SSDFS_BTN(ptr) \
+	((struct ssdfs_btree_node *)(ptr))
+
+static inline
+bool need_add_block(struct page *page)
+{
+	return PageChecked(page);
+}
+
+static inline
+bool is_diff_page(struct page *page)
+{
+	return PageChecked(page);
+}
+
+static inline
+void set_page_new(struct page *page)
+{
+	SetPageChecked(page);
+}
+
+static inline
+void clear_page_new(struct page *page)
+{
+	ClearPageChecked(page);
+}
+
+static
+inline void ssdfs_set_page_private(struct page *page,
+				   unsigned long private)
+{
+	set_page_private(page, private);
+	SetPagePrivate(page);
+}
+
+static
+inline void ssdfs_clear_page_private(struct page *page,
+				     unsigned long private)
+{
+	set_page_private(page, private);
+	ClearPagePrivate(page);
+}
+
+static inline
+bool can_be_merged_into_extent(struct page *page1, struct page *page2)
+{
+	ino_t ino1 = page1->mapping->host->i_ino;
+	ino_t ino2 = page2->mapping->host->i_ino;
+	pgoff_t index1 = page_index(page1);
+	pgoff_t index2 = page_index(page2);
+	pgoff_t diff_index;
+	bool has_identical_type;
+	bool has_identical_ino;
+
+	has_identical_type = (PageChecked(page1) && PageChecked(page2)) ||
+				(!PageChecked(page1) && !PageChecked(page2));
+	has_identical_ino = ino1 == ino2;
+
+	if (index1 >= index2)
+		diff_index = index1 - index2;
+	else
+		diff_index = index2 - index1;
+
+	return has_identical_type && has_identical_ino && (diff_index == 1);
+}
+
+static inline
+int ssdfs_memcpy(void *dst, u32 dst_off, u32 dst_size,
+		 const void *src, u32 src_off, u32 src_size,
+		 u32 copy_size)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	if ((src_off + copy_size) > src_size) {
+		SSDFS_ERR("fail to copy: "
+			  "src_off %u, copy_size %u, src_size %u\n",
+			  src_off, copy_size, src_size);
+		return -ERANGE;
+	}
+
+	if ((dst_off + copy_size) > dst_size) {
+		SSDFS_ERR("fail to copy: "
+			  "dst_off %u, copy_size %u, dst_size %u\n",
+			  dst_off, copy_size, dst_size);
+		return -ERANGE;
+	}
+
+	SSDFS_DBG("dst %p, dst_off %u, dst_size %u, "
+		  "src %p, src_off %u, src_size %u, "
+		  "copy_size %u\n",
+		  dst, dst_off, dst_size,
+		  src, src_off, src_size,
+		  copy_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memcpy((u8 *)dst + dst_off, (u8 *)src + src_off, copy_size);
+	return 0;
+}
+
+static inline
+int ssdfs_memcpy_page(struct page *dst_page, u32 dst_off, u32 dst_size,
+		      struct page *src_page, u32 src_off, u32 src_size,
+		      u32 copy_size)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	if ((src_off + copy_size) > src_size) {
+		SSDFS_ERR("fail to copy: "
+			  "src_off %u, copy_size %u, src_size %u\n",
+			  src_off, copy_size, src_size);
+		return -ERANGE;
+	}
+
+	if ((dst_off + copy_size) > dst_size) {
+		SSDFS_ERR("fail to copy: "
+			  "dst_off %u, copy_size %u, dst_size %u\n",
+			  dst_off, copy_size, dst_size);
+		return -ERANGE;
+	}
+
+	SSDFS_DBG("dst_page %p, dst_off %u, dst_size %u, "
+		  "src_page %p, src_off %u, src_size %u, "
+		  "copy_size %u\n",
+		  dst_page, dst_off, dst_size,
+		  src_page, src_off, src_size,
+		  copy_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memcpy_page(dst_page, dst_off, src_page, src_off, copy_size);
+	return 0;
+}
+
+static inline
+int ssdfs_memcpy_from_page(void *dst, u32 dst_off, u32 dst_size,
+			   struct page *page, u32 src_off, u32 src_size,
+			   u32 copy_size)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	if ((src_off + copy_size) > src_size) {
+		SSDFS_ERR("fail to copy: "
+			  "src_off %u, copy_size %u, src_size %u\n",
+			  src_off, copy_size, src_size);
+		return -ERANGE;
+	}
+
+	if ((dst_off + copy_size) > dst_size) {
+		SSDFS_ERR("fail to copy: "
+			  "dst_off %u, copy_size %u, dst_size %u\n",
+			  dst_off, copy_size, dst_size);
+		return -ERANGE;
+	}
+
+	SSDFS_DBG("dst %p, dst_off %u, dst_size %u, "
+		  "page %p, src_off %u, src_size %u, "
+		  "copy_size %u\n",
+		  dst, dst_off, dst_size,
+		  page, src_off, src_size,
+		  copy_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memcpy_from_page((u8 *)dst + dst_off, page, src_off, copy_size);
+	return 0;
+}
+
+static inline
+int ssdfs_memcpy_to_page(struct page *page, u32 dst_off, u32 dst_size,
+			 void *src, u32 src_off, u32 src_size,
+			 u32 copy_size)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	if ((src_off + copy_size) > src_size) {
+		SSDFS_ERR("fail to copy: "
+			  "src_off %u, copy_size %u, src_size %u\n",
+			  src_off, copy_size, src_size);
+		return -ERANGE;
+	}
+
+	if ((dst_off + copy_size) > dst_size) {
+		SSDFS_ERR("fail to copy: "
+			  "dst_off %u, copy_size %u, dst_size %u\n",
+			  dst_off, copy_size, dst_size);
+		return -ERANGE;
+	}
+
+	SSDFS_DBG("page %p, dst_off %u, dst_size %u, "
+		  "src %p, src_off %u, src_size %u, "
+		  "copy_size %u\n",
+		  page, dst_off, dst_size,
+		  src, src_off, src_size,
+		  copy_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memcpy_to_page(page, dst_off, (u8 *)src + src_off, copy_size);
+	return 0;
+}
+
+static inline
+int ssdfs_memmove(void *dst, u32 dst_off, u32 dst_size,
+		  const void *src, u32 src_off, u32 src_size,
+		  u32 move_size)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	if ((src_off + move_size) > src_size) {
+		SSDFS_ERR("fail to move: "
+			  "src_off %u, move_size %u, src_size %u\n",
+			  src_off, move_size, src_size);
+		return -ERANGE;
+	}
+
+	if ((dst_off + move_size) > dst_size) {
+		SSDFS_ERR("fail to move: "
+			  "dst_off %u, move_size %u, dst_size %u\n",
+			  dst_off, move_size, dst_size);
+		return -ERANGE;
+	}
+
+	SSDFS_DBG("dst %p, dst_off %u, dst_size %u, "
+		  "src %p, src_off %u, src_size %u, "
+		  "move_size %u\n",
+		  dst, dst_off, dst_size,
+		  src, src_off, src_size,
+		  move_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memmove((u8 *)dst + dst_off, (u8 *)src + src_off, move_size);
+	return 0;
+}
+
+static inline
+int ssdfs_memmove_page(struct page *dst_page, u32 dst_off, u32 dst_size,
+			struct page *src_page, u32 src_off, u32 src_size,
+			u32 move_size)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	if ((src_off + move_size) > src_size) {
+		SSDFS_ERR("fail to move: "
+			  "src_off %u, move_size %u, src_size %u\n",
+			  src_off, move_size, src_size);
+		return -ERANGE;
+	}
+
+	if ((dst_off + move_size) > dst_size) {
+		SSDFS_ERR("fail to move: "
+			  "dst_off %u, move_size %u, dst_size %u\n",
+			  dst_off, move_size, dst_size);
+		return -ERANGE;
+	}
+
+	SSDFS_DBG("dst_page %p, dst_off %u, dst_size %u, "
+		  "src_page %p, src_off %u, src_size %u, "
+		  "move_size %u\n",
+		  dst_page, dst_off, dst_size,
+		  src_page, src_off, src_size,
+		  move_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memcpy_page(dst_page, dst_off, src_page, src_off, move_size);
+	return 0;
+}
+
+static inline
+int ssdfs_memset_page(struct page *page, u32 dst_off, u32 dst_size,
+		      int value, u32 set_size)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	if ((dst_off + set_size) > dst_size) {
+		SSDFS_ERR("fail to copy: "
+			  "dst_off %u, set_size %u, dst_size %u\n",
+			  dst_off, set_size, dst_size);
+		return -ERANGE;
+	}
+
+	SSDFS_DBG("page %p, dst_off %u, dst_size %u, "
+		  "value %#x, set_size %u\n",
+		  page, dst_off, dst_size,
+		  value, set_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset_page(page, dst_off, value, set_size);
+	return 0;
+}
+
+static inline
+int ssdfs_memzero_page(struct page *page, u32 dst_off, u32 dst_size,
+		       u32 set_size)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	if ((dst_off + set_size) > dst_size) {
+		SSDFS_ERR("fail to copy: "
+			  "dst_off %u, set_size %u, dst_size %u\n",
+			  dst_off, set_size, dst_size);
+		return -ERANGE;
+	}
+
+	SSDFS_DBG("page %p, dst_off %u, dst_size %u, "
+		  "set_size %u\n",
+		  page, dst_off, dst_size, set_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memzero_page(page, dst_off, set_size);
+	return 0;
+}
+
+static inline
+bool is_ssdfs_file_inline(struct ssdfs_inode_info *ii)
+{
+	return atomic_read(&ii->private_flags) & SSDFS_INODE_HAS_INLINE_FILE;
+}
+
+static inline
+size_t ssdfs_inode_inline_file_capacity(struct inode *inode)
+{
+	struct ssdfs_inode_info *ii = SSDFS_I(inode);
+	size_t raw_inode_size;
+	size_t metadata_len;
+
+	raw_inode_size = ii->raw_inode_size;
+	metadata_len = offsetof(struct ssdfs_inode, internal);
+
+	if (raw_inode_size <= metadata_len) {
+		SSDFS_ERR("corrupted raw inode: "
+			  "raw_inode_size %zu, metadata_len %zu\n",
+			  raw_inode_size, metadata_len);
+		return 0;
+	}
+
+	return raw_inode_size - metadata_len;
+}
+
+/*
+ * __ssdfs_generate_name_hash() - generate a name's hash
+ * @name: pointer on the name's string
+ * @len: length of the name
+ * @inline_name_max_len: max length of inline name
+ */
+static inline
+u64 __ssdfs_generate_name_hash(const char *name, size_t len,
+				size_t inline_name_max_len)
+{
+	u32 hash32_lo, hash32_hi;
+	size_t copy_len;
+	u64 name_hash;
+	u32 diff = 0;
+	u8 symbol1, symbol2;
+	int i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!name);
+
+	SSDFS_DBG("name %s, len %zu, inline_name_max_len %zu\n",
+		  name, len, inline_name_max_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (len == 0) {
+		SSDFS_ERR("invalid len %zu\n", len);
+		return U64_MAX;
+	}
+
+	copy_len = min_t(size_t, len, inline_name_max_len);
+	hash32_lo = full_name_hash(NULL, name, copy_len);
+
+	if (len <= inline_name_max_len) {
+		hash32_hi = len;
+
+		for (i = 1; i < len; i++) {
+			symbol1 = (u8)name[i - 1];
+			symbol2 = (u8)name[i];
+			diff = 0;
+
+			if (symbol1 > symbol2)
+				diff = symbol1 - symbol2;
+			else
+				diff = symbol2 - symbol1;
+
+			hash32_hi += diff * symbol1;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("hash32_hi %x, symbol1 %x, "
+				  "symbol2 %x, index %d, diff %u\n",
+				  hash32_hi, symbol1, symbol2,
+				  i, diff);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+	} else {
+		hash32_hi = full_name_hash(NULL,
+					   name + inline_name_max_len,
+					   len - copy_len);
+	}
+
+	name_hash = SSDFS_NAME_HASH(hash32_lo, hash32_hi);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("name %s, len %zu, name_hash %llx\n",
+		  name, len, name_hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return name_hash;
+}
+
+#define SSDFS_LOG_FOOTER_OFF(seg_hdr)({ \
+	u32 offset; \
+	int index; \
+	struct ssdfs_metadata_descriptor *desc; \
+	index = SSDFS_LOG_FOOTER_INDEX; \
+	desc = &SSDFS_SEG_HDR(seg_hdr)->desc_array[index]; \
+	offset = le32_to_cpu(desc->offset); \
+	offset; \
+})
+
+#define SSDFS_WAITED_TOO_LONG_MSECS		(1000)
+
+static inline
+void ssdfs_check_jiffies_left_till_timeout(unsigned long value)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	unsigned int msecs;
+
+	msecs = jiffies_to_msecs(SSDFS_DEFAULT_TIMEOUT - value);
+	if (msecs >= SSDFS_WAITED_TOO_LONG_MSECS)
+		SSDFS_ERR("function waited %u msecs\n", msecs);
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+#define SSDFS_WAIT_COMPLETION(end)({ \
+	unsigned long res; \
+	int err = 0; \
+	res = wait_for_completion_timeout(end, SSDFS_DEFAULT_TIMEOUT); \
+	if (res == 0) { \
+		err = -ERANGE; \
+	} else { \
+		ssdfs_check_jiffies_left_till_timeout(res); \
+	} \
+	err; \
+})
+
+#define SSDFS_FSI(ptr) \
+	((struct ssdfs_fs_info *)(ptr))
+#define SSDFS_BLKT(ptr) \
+	((struct ssdfs_area_block_table *)(ptr))
+#define SSDFS_FRAGD(ptr) \
+	((struct ssdfs_fragment_desc *)(ptr))
+#define SSDFS_BLKD(ptr) \
+	((struct ssdfs_block_descriptor *)(ptr))
+#define SSDFS_BLKSTOFF(ptr) \
+	((struct ssdfs_blk_state_offset *)(ptr))
+#define SSDFS_STNODE_HDR(ptr) \
+	((struct ssdfs_segment_tree_node_header *)(ptr))
+#define SSDFS_SNRU_HDR(ptr) \
+	((struct ssdfs_snapshot_rules_header *)(ptr))
+#define SSDFS_SNRU_INFO(ptr) \
+	((struct ssdfs_snapshot_rule_info *)(ptr))
+
+#define SSDFS_LEB2SEG(fsi, leb) \
+	((u64)ssdfs_get_seg_id_for_leb_id(fsi, leb))
+
+#endif /* _SSDFS_INLINE_H */
diff --git a/fs/ssdfs/ssdfs_inode_info.h b/fs/ssdfs/ssdfs_inode_info.h
new file mode 100644
index 000000000000..5e98f4fa3672
--- /dev/null
+++ b/fs/ssdfs/ssdfs_inode_info.h
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/ssdfs_inode_info.h - SSDFS in-core inode.
+ *
+ * Copyright (c) 2019-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#ifndef _SSDFS_INODE_INFO_H
+#define _SSDFS_INODE_INFO_H
+
+/*
+ * Inode flags (GETFLAGS/SETFLAGS)
+ */
+#define	SSDFS_SECRM_FL			FS_SECRM_FL	/* Secure deletion */
+#define	SSDFS_UNRM_FL			FS_UNRM_FL	/* Undelete */
+#define	SSDFS_COMPR_FL			FS_COMPR_FL	/* Compress file */
+#define SSDFS_SYNC_FL			FS_SYNC_FL	/* Synchronous updates */
+#define SSDFS_IMMUTABLE_FL		FS_IMMUTABLE_FL	/* Immutable file */
+#define SSDFS_APPEND_FL			FS_APPEND_FL	/* writes to file may only append */
+#define SSDFS_NODUMP_FL			FS_NODUMP_FL	/* do not dump file */
+#define SSDFS_NOATIME_FL		FS_NOATIME_FL	/* do not update atime */
+/* Reserved for compression usage... */
+#define SSDFS_DIRTY_FL			FS_DIRTY_FL
+#define SSDFS_COMPRBLK_FL		FS_COMPRBLK_FL	/* One or more compressed clusters */
+#define SSDFS_NOCOMP_FL			FS_NOCOMP_FL	/* Don't compress */
+#define SSDFS_ECOMPR_FL			FS_ECOMPR_FL	/* Compression error */
+/* End compression flags --- maybe not all used */
+#define SSDFS_BTREE_FL			FS_BTREE_FL	/* btree format dir */
+#define SSDFS_INDEX_FL			FS_INDEX_FL	/* hash-indexed directory */
+#define SSDFS_IMAGIC_FL			FS_IMAGIC_FL	/* AFS directory */
+#define SSDFS_JOURNAL_DATA_FL		FS_JOURNAL_DATA_FL /* Reserved for ext3 */
+#define SSDFS_NOTAIL_FL			FS_NOTAIL_FL	/* file tail should not be merged */
+#define SSDFS_DIRSYNC_FL		FS_DIRSYNC_FL	/* dirsync behaviour (directories only) */
+#define SSDFS_TOPDIR_FL			FS_TOPDIR_FL	/* Top of directory hierarchies*/
+#define SSDFS_RESERVED_FL		FS_RESERVED_FL	/* reserved for ext2 lib */
+
+#define SSDFS_FL_USER_VISIBLE		FS_FL_USER_VISIBLE	/* User visible flags */
+#define SSDFS_FL_USER_MODIFIABLE	FS_FL_USER_MODIFIABLE	/* User modifiable flags */
+
+/* Flags that should be inherited by new inodes from their parent. */
+#define SSDFS_FL_INHERITED (SSDFS_SECRM_FL | SSDFS_UNRM_FL | SSDFS_COMPR_FL |\
+			   SSDFS_SYNC_FL | SSDFS_NODUMP_FL |\
+			   SSDFS_NOATIME_FL | SSDFS_COMPRBLK_FL |\
+			   SSDFS_NOCOMP_FL | SSDFS_JOURNAL_DATA_FL |\
+			   SSDFS_NOTAIL_FL | SSDFS_DIRSYNC_FL)
+
+/* Flags that are appropriate for regular files (all but dir-specific ones). */
+#define SSDFS_REG_FLMASK (~(SSDFS_DIRSYNC_FL | SSDFS_TOPDIR_FL))
+
+/* Flags that are appropriate for non-directories/regular files. */
+#define SSDFS_OTHER_FLMASK (SSDFS_NODUMP_FL | SSDFS_NOATIME_FL)
+
+/* Mask out flags that are inappropriate for the given type of inode. */
+static inline __u32 ssdfs_mask_flags(umode_t mode, __u32 flags)
+{
+	if (S_ISDIR(mode))
+		return flags;
+	else if (S_ISREG(mode))
+		return flags & SSDFS_REG_FLMASK;
+	else
+		return flags & SSDFS_OTHER_FLMASK;
+}
+
+/*
+ * struct ssdfs_inode_info - in-core inode
+ * @vfs_inode: VFS inode object
+ * @birthtime: creation time
+ * @raw_inode_size: raw inode size in bytes
+ * @private_flags: inode's private flags
+ * @lock: inode lock
+ * @parent_ino: parent inode ID
+ * @flags: inode flags
+ * @name_hash: name's hash code
+ * @name_len: name length
+ * @extents_tree: extents btree
+ * @dentries_tree: dentries btree
+ * @xattrs_tree: extended attributes tree
+ * @inline_file: inline file buffer
+ * @raw_inode: raw inode
+ */
+struct ssdfs_inode_info {
+	struct inode vfs_inode;
+	struct timespec64 birthtime;
+	u16 raw_inode_size;
+
+	atomic_t private_flags;
+
+	struct rw_semaphore lock;
+	u64 parent_ino;
+	u32 flags;
+	u64 name_hash;
+	u16 name_len;
+	struct ssdfs_extents_btree_info *extents_tree;
+	struct ssdfs_dentries_btree_info *dentries_tree;
+	struct ssdfs_xattrs_btree_info *xattrs_tree;
+	void *inline_file;
+	struct ssdfs_inode raw_inode;
+};
+
+static inline struct ssdfs_inode_info *SSDFS_I(struct inode *inode)
+{
+	return container_of(inode, struct ssdfs_inode_info, vfs_inode);
+}
+
+static inline
+struct ssdfs_extents_btree_info *SSDFS_EXTREE(struct ssdfs_inode_info *ii)
+{
+	if (S_ISDIR(ii->vfs_inode.i_mode))
+		return NULL;
+	else
+		return ii->extents_tree;
+}
+
+static inline
+struct ssdfs_dentries_btree_info *SSDFS_DTREE(struct ssdfs_inode_info *ii)
+{
+	if (S_ISDIR(ii->vfs_inode.i_mode))
+		return ii->dentries_tree;
+	else
+		return NULL;
+}
+
+static inline
+struct ssdfs_xattrs_btree_info *SSDFS_XATTREE(struct ssdfs_inode_info *ii)
+{
+	return ii->xattrs_tree;
+}
+
+extern const struct file_operations ssdfs_dir_operations;
+extern const struct inode_operations ssdfs_dir_inode_operations;
+extern const struct file_operations ssdfs_file_operations;
+extern const struct inode_operations ssdfs_file_inode_operations;
+extern const struct address_space_operations ssdfs_aops;
+extern const struct inode_operations ssdfs_special_inode_operations;
+extern const struct inode_operations ssdfs_symlink_inode_operations;
+
+#endif /* _SSDFS_INODE_INFO_H */
diff --git a/fs/ssdfs/ssdfs_thread_info.h b/fs/ssdfs/ssdfs_thread_info.h
new file mode 100644
index 000000000000..2816a50e18e4
--- /dev/null
+++ b/fs/ssdfs/ssdfs_thread_info.h
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/ssdfs_thread_info.h - thread declarations.
+ *
+ * Copyright (c) 2019-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#ifndef _SSDFS_THREAD_INFO_H
+#define _SSDFS_THREAD_INFO_H
+
+/*
+ * struct ssdfs_thread_info - thread info
+ * @task: task descriptor
+ * @wait: wait queue
+ * @full_stop: ending of thread's activity
+ */
+struct ssdfs_thread_info {
+	struct task_struct *task;
+	struct wait_queue_entry wait;
+	struct completion full_stop;
+};
+
+/* function prototype */
+typedef int (*ssdfs_threadfn)(void *data);
+
+/*
+ * struct ssdfs_thread_descriptor - thread descriptor
+ * @threadfn: thread's function
+ * @fmt: thread's name format
+ */
+struct ssdfs_thread_descriptor {
+	ssdfs_threadfn threadfn;
+	const char *fmt;
+};
+
+#endif /* _SSDFS_THREAD_INFO_H */
diff --git a/fs/ssdfs/version.h b/fs/ssdfs/version.h
new file mode 100644
index 000000000000..5231f8a1f575
--- /dev/null
+++ b/fs/ssdfs/version.h
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+#ifndef _SSDFS_VERSION_H
+#define _SSDFS_VERSION_H
+
+#define SSDFS_VERSION "SSDFS v.4.42"
+
+#endif /* _SSDFS_VERSION_H */
diff --git a/include/trace/events/ssdfs.h b/include/trace/events/ssdfs.h
new file mode 100644
index 000000000000..dbf117dccd28
--- /dev/null
+++ b/include/trace/events/ssdfs.h
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * include/trace/events/ssdfs.h - definition of tracepoints.
+ *
+ * Copyright (c) 2019-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM ssdfs
+
+#if !defined(_TRACE_SSDFS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SSDFS_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(ssdfs__inode,
+
+	TP_PROTO(struct inode *inode),
+
+	TP_ARGS(inode),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(umode_t, mode)
+		__field(loff_t,	size)
+		__field(unsigned int, nlink)
+		__field(blkcnt_t, blocks)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->mode	= inode->i_mode;
+		__entry->nlink	= inode->i_nlink;
+		__entry->size	= inode->i_size;
+		__entry->blocks	= inode->i_blocks;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, i_mode = 0x%hx, "
+		"i_size = %lld, i_nlink = %u, i_blocks = %llu",
+		MAJOR(__entry->dev),
+		MINOR(__entry->dev),
+		(unsigned long)__entry->ino,
+		__entry->mode,
+		__entry->size,
+		(unsigned int)__entry->nlink,
+		(unsigned long long)__entry->blocks)
+);
+
+DECLARE_EVENT_CLASS(ssdfs__inode_exit,
+
+	TP_PROTO(struct inode *inode, int ret),
+
+	TP_ARGS(inode, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(int,	ret)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->ret	= ret;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, ret = %d",
+		MAJOR(__entry->dev),
+		MINOR(__entry->dev),
+		(unsigned long)__entry->ino,
+		__entry->ret)
+);
+
+DEFINE_EVENT(ssdfs__inode, ssdfs_inode_new,
+
+	TP_PROTO(struct inode *inode),
+
+	TP_ARGS(inode)
+);
+
+DEFINE_EVENT(ssdfs__inode_exit, ssdfs_inode_new_exit,
+
+	TP_PROTO(struct inode *inode, int ret),
+
+	TP_ARGS(inode, ret)
+);
+
+DEFINE_EVENT(ssdfs__inode, ssdfs_inode_request,
+
+	TP_PROTO(struct inode *inode),
+
+	TP_ARGS(inode)
+);
+
+DEFINE_EVENT(ssdfs__inode, ssdfs_inode_evict,
+
+	TP_PROTO(struct inode *inode),
+
+	TP_ARGS(inode)
+);
+
+DEFINE_EVENT(ssdfs__inode, ssdfs_iget,
+
+	TP_PROTO(struct inode *inode),
+
+	TP_ARGS(inode)
+);
+
+DEFINE_EVENT(ssdfs__inode_exit, ssdfs_iget_exit,
+
+	TP_PROTO(struct inode *inode, int ret),
+
+	TP_ARGS(inode, ret)
+);
+
+TRACE_EVENT(ssdfs_sync_fs,
+
+	TP_PROTO(struct super_block *sb, int wait),
+
+	TP_ARGS(sb, wait),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(int,	wait)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= sb->s_dev;
+		__entry->wait	= wait;
+	),
+
+	TP_printk("dev = (%d,%d), wait = %d",
+		MAJOR(__entry->dev),
+		MINOR(__entry->dev),
+		__entry->wait)
+);
+
+TRACE_EVENT(ssdfs_sync_fs_exit,
+
+	TP_PROTO(struct super_block *sb, int wait, int ret),
+
+	TP_ARGS(sb, wait, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(int,	wait)
+		__field(int,	ret)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= sb->s_dev;
+		__entry->wait	= wait;
+		__entry->ret	= ret;
+	),
+
+	TP_printk("dev = (%d,%d), wait = %d, ret = %d",
+		MAJOR(__entry->dev),
+		MINOR(__entry->dev),
+		__entry->wait,
+		__entry->ret)
+);
+
+DEFINE_EVENT(ssdfs__inode, ssdfs_sync_file_enter,
+
+	TP_PROTO(struct inode *inode),
+
+	TP_ARGS(inode)
+);
+
+TRACE_EVENT(ssdfs_sync_file_exit,
+
+	TP_PROTO(struct file *file, int datasync, int ret),
+
+	TP_ARGS(file, datasync, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(ino_t,	parent)
+		__field(int,	datasync)
+		__field(int,	ret)
+	),
+
+	TP_fast_assign(
+		struct dentry *dentry = file->f_path.dentry;
+		struct inode *inode = dentry->d_inode;
+
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->parent		= dentry->d_parent->d_inode->i_ino;
+		__entry->datasync	= datasync;
+		__entry->ret		= ret;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, parent = %ld, "
+		"datasync = %d, ret = %d",
+		MAJOR(__entry->dev),
+		MINOR(__entry->dev),
+		(unsigned long)__entry->ino,
+		(unsigned long)__entry->parent,
+		__entry->datasync,
+		__entry->ret)
+);
+
+TRACE_EVENT(ssdfs_unlink_enter,
+
+	TP_PROTO(struct inode *dir, struct dentry *dentry),
+
+	TP_ARGS(dir, dentry),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(loff_t,	size)
+		__field(blkcnt_t, blocks)
+		__field(const char *,	name)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= dir->i_sb->s_dev;
+		__entry->ino	= dir->i_ino;
+		__entry->size	= dir->i_size;
+		__entry->blocks	= dir->i_blocks;
+		__entry->name	= dentry->d_name.name;
+	),
+
+	TP_printk("dev = (%d,%d), dir ino = %lu, i_size = %lld, "
+		"i_blocks = %llu, name = %s",
+		MAJOR(__entry->dev),
+		MINOR(__entry->dev),
+		(unsigned long)__entry->ino,
+		__entry->size,
+		(unsigned long long)__entry->blocks,
+		__entry->name)
+);
+
+DEFINE_EVENT(ssdfs__inode_exit, ssdfs_unlink_exit,
+
+	TP_PROTO(struct inode *inode, int ret),
+
+	TP_ARGS(inode, ret)
+);
+
+#endif /* _TRACE_SSDFS_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/include/uapi/linux/ssdfs_fs.h b/include/uapi/linux/ssdfs_fs.h
new file mode 100644
index 000000000000..50c81751afc9
--- /dev/null
+++ b/include/uapi/linux/ssdfs_fs.h
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * include/uapi/linux/ssdfs_fs.h - SSDFS common declarations.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2023 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ */
+
+#ifndef _UAPI_LINUX_SSDFS_H
+#define _UAPI_LINUX_SSDFS_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/* SSDFS magic signatures */
+#define SSDFS_SUPER_MAGIC			0x53734466	/* SsDf */
+#define SSDFS_SEGMENT_HDR_MAGIC			0x5348		/* SH */
+#define SSDFS_LOG_FOOTER_MAGIC			0x4C46		/* LF */
+#define SSDFS_PARTIAL_LOG_HDR_MAGIC		0x5048		/* PH */
+#define SSDFS_BLK_BMAP_MAGIC			0x424D		/* BM */
+#define SSDFS_FRAGMENT_DESC_MAGIC		0x66		/* f */
+#define SSDFS_CHAIN_HDR_MAGIC			0x63		/* c */
+#define SSDFS_PHYS_OFF_TABLE_MAGIC		0x504F5448	/* POTH */
+#define SSDFS_BLK2OFF_TABLE_HDR_MAGIC		0x5474		/* Tt */
+#define SSDFS_SEGBMAP_HDR_MAGIC			0x534D		/* SM */
+#define SSDFS_INODE_MAGIC			0x6469		/* di */
+#define SSDFS_PEB_TABLE_MAGIC			0x5074		/* Pt */
+#define SSDFS_LEB_TABLE_MAGIC			0x4C74		/* Lt */
+#define SSDFS_MAPTBL_CACHE_MAGIC		0x4D63		/* Mc */
+#define SSDFS_MAPTBL_CACHE_PEB_STATE_MAGIC	0x4D635053	/* McPS */
+#define SSDFS_INODES_BTREE_MAGIC		0x496E4274	/* InBt */
+#define SSDFS_INODES_BNODE_MAGIC		0x494E		/* IN */
+#define SSDFS_DENTRIES_BTREE_MAGIC		0x44654274	/* DeBt */
+#define SSDFS_DENTRIES_BNODE_MAGIC		0x444E		/* DN */
+#define SSDFS_EXTENTS_BTREE_MAGIC		0x45784274	/* ExBt */
+#define SSDFS_SHARED_EXTENTS_BTREE_MAGIC	0x53454274	/* SEBt */
+#define SSDFS_EXTENTS_BNODE_MAGIC		0x454E		/* EN */
+#define SSDFS_XATTR_BTREE_MAGIC			0x45414274	/* EABt */
+#define SSDFS_SHARED_XATTR_BTREE_MAGIC		0x53454174	/* SEAt */
+#define SSDFS_XATTR_BNODE_MAGIC			0x414E		/* AN */
+#define SSDFS_SHARED_DICT_BTREE_MAGIC		0x53446963	/* SDic */
+#define SSDFS_DICTIONARY_BNODE_MAGIC		0x534E		/* SN */
+#define SSDFS_SNAPSHOTS_BTREE_MAGIC		0x536E4274	/* SnBt */
+#define SSDFS_SNAPSHOTS_BNODE_MAGIC		0x736E		/* sn */
+#define SSDFS_SNAPSHOT_RULES_MAGIC		0x536E5275	/* SnRu */
+#define SSDFS_SNAPSHOT_RECORD_MAGIC		0x5372		/* Sr */
+#define SSDFS_PEB2TIME_RECORD_MAGIC		0x5072		/* Pr */
+#define SSDFS_DIFF_BLOB_MAGIC			0x4466		/* Df */
+#define SSDFS_INVEXT_BTREE_MAGIC		0x49784274	/* IxBt */
+#define SSDFS_INVEXT_BNODE_MAGIC		0x4958		/* IX */
+
+/* SSDFS revision */
+#define SSDFS_MAJOR_REVISION		1
+#define SSDFS_MINOR_REVISION		15
+
+/* SSDFS constants */
+#define SSDFS_MAX_NAME_LEN		255
+#define SSDFS_UUID_SIZE			16
+#define SSDFS_VOLUME_LABEL_MAX		16
+#define SSDFS_MAX_SNAP_RULE_NAME_LEN	16
+#define SSDFS_MAX_SNAPSHOT_NAME_LEN	12
+
+#define SSDFS_RESERVED_VBR_SIZE		1024 /* Volume Boot Record size*/
+#define SSDFS_DEFAULT_SEG_SIZE		8388608
+
+/*
+ * File system states
+ */
+#define SSDFS_MOUNTED_FS		0x0000  /* Mounted FS state */
+#define SSDFS_VALID_FS			0x0001  /* Unmounted cleanly */
+#define SSDFS_ERROR_FS			0x0002  /* Errors detected */
+#define SSDFS_RESIZE_FS			0x0004	/* Resize required */
+#define SSDFS_LAST_KNOWN_FS_STATE	SSDFS_RESIZE_FS
+
+/*
+ * Behaviour when detecting errors
+ */
+#define SSDFS_ERRORS_CONTINUE		1	/* Continue execution */
+#define SSDFS_ERRORS_RO			2	/* Remount fs read-only */
+#define SSDFS_ERRORS_PANIC		3	/* Panic */
+#define SSDFS_ERRORS_DEFAULT		SSDFS_ERRORS_CONTINUE
+#define SSDFS_LAST_KNOWN_FS_ERROR	SSDFS_ERRORS_PANIC
+
+/* Reserved inode id */
+#define SSDFS_INVALID_EXTENTS_BTREE_INO		5
+#define SSDFS_SNAPSHOTS_BTREE_INO		6
+#define SSDFS_TESTING_INO			7
+#define SSDFS_SHARED_DICT_BTREE_INO		8
+#define SSDFS_INODES_BTREE_INO			9
+#define SSDFS_SHARED_EXTENTS_BTREE_INO		10
+#define SSDFS_SHARED_XATTR_BTREE_INO		11
+#define SSDFS_MAPTBL_INO			12
+#define SSDFS_SEG_TREE_INO			13
+#define SSDFS_SEG_BMAP_INO			14
+#define SSDFS_PEB_CACHE_INO			15
+#define SSDFS_ROOT_INO				16
+
+#define SSDFS_LINK_MAX		INT_MAX
+
+#define SSDFS_CUR_SEG_DEFAULT_ID	3
+#define SSDFS_LOG_PAGES_DEFAULT		32
+#define SSDFS_CREATE_THREADS_DEFAULT	1
+
+#endif /* _UAPI_LINUX_SSDFS_H */
-- 
2.34.1

