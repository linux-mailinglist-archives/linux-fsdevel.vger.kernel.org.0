Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3A96A2667
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBYBT5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBYBTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:19:10 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D74F268F
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:49 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id q15so781827oiw.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWOMVD44xQ6+Wbo0BRb4CTj9Bc/5AQGNyo54vDsZCYo=;
        b=DdzbwAYAkPEhYSqXz+V4pgEJFVC9cXY03nedfRX+zRMnVhX5gGzcziwLF+9UX/5xFZ
         u1WO2+m6Yqm6jCgfuFPk2F9iY2x7K6QS7SwQ6cwr0pcbgfIqZi3Cvb1O6sISnPHs+kkQ
         H+U39I/Ilq4tUzq6c87ps42yK75zStSE4sOZBlGY4T31RvmR9oUCDstpoZPBu65hI0cK
         p4w8l3kcAbUP+/sdb1mC/fubM+cerhYqgd8ZugiRo4A5TPqYbd2kQFhAjBOhYtnv4xkp
         sMaEyWIkjF7IBQx2j6ZN/n0ipi8zpDYt0MsS8NarRz0q13h9T/pwECsui+qMreoXSg+G
         u+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWOMVD44xQ6+Wbo0BRb4CTj9Bc/5AQGNyo54vDsZCYo=;
        b=WSEdiCRNPyuQqICfByALDfqfr+58v1e5AY9mhn6Llsl1Htca3IG7CJIKZz50+KWnAQ
         QzDAiNxk0eG1q6bKPf8A/BEFWZaf5gcDWBORIzE7NyfwPHWbwxEGJOepqPhQh+mPy0OR
         qlSBrHICchI0T9C0Gp6hi+PcdMZeE22Bo8/EU0BvY9JQ4wEfJrDhorvQ9LDwRBXD/jZK
         1cCjryMYErg1On8sEXQQJ/YeKA5tN1Lxj2aLqcPHi/9k4WU2nP/RkpVnqQ79W5KrUqZx
         SNtmZF6nqsKXOrL5ITNx+CSp+RCpWQpmWuX8c7l1PH1XIvbT/fSbKCxYNqlO2E4ygUof
         +L3Q==
X-Gm-Message-State: AO0yUKVdav5qp8+FFKIaZsIMDma6P0b94ECihhtSO1X0pYBiBT0UTifj
        XH4LL+Nol0APGR4FUVEUJZtf2YpW+20v8JlL
X-Google-Smtp-Source: AK7set8iT1fUafBTHd5KiB5ve9ZXaOIJmDBS95Q/a3rHbFoxycrnq0LxXw2/iVaTtoCJwsPcf3HF8g==
X-Received: by 2002:a05:6808:253:b0:383:f380:8694 with SMTP id m19-20020a056808025300b00383f3808694mr1936167oie.18.1677287866427;
        Fri, 24 Feb 2023 17:17:46 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:45 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 62/76] ssdfs: introduce dentries b-tree
Date:   Fri, 24 Feb 2023 17:09:13 -0800
Message-Id: <20230225010927.813929-63-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230225010927.813929-1-slava@dubeyko.com>
References: <20230225010927.813929-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SSDFS dentry is the metadata structure of fixed size (32 bytes).
It contains inode ID, name hash, name length, and inline string
for 12 symbols. Generally speaking, the dentry is able to store
8.3 filename inline. If the name of file/folder has longer name
(more than 12 symbols) then the dentry will keep only the portion of
the name but the whole name will be stored into a shared dictionary.
The goal of such approach is to represent the dentry by compact
metadata structure of fixed size for the fast and efficient operations
with the dentries. It is possible to point out that there are a lot of
use-cases when the length of file or folder is not very long. As a result,
dentry’s inline string could be only storage for the file/folder name.
Moreover, the goal of shared dictionary is to store the long names
efficiently by means of using the deduplication mechanism.

Dentries b-tree is the hybrid b-tree with the root node is stored into
the private inode’s area. By default, inode’s private area has 128 bytes
in size. Also SSDFS dentry has 32 bytes in size. As a result, inode’s
private area provides enough space for 4 inline dentries. Generally
speaking, if a folder contains 4 or lesser files then the dentries
can be stored into the inode’s private area without the necessity
to create the dentries b-tree. Otherwise, if a folder includes
more than 4 files or folders then it needs to create the regular
dentries b-tree with the root node is stored into the private area
of inode. Actually, every node of dentries b-tree contains the header,
index area (for the case of hybrid node), and array of dentries are ordered
by hash value of filename. Moreover, if a b-tree node has 8 KB size then
it is capable to contain maximum 256 dentries. Generally speaking,
the hybrid b-tree was opted for the dentries metadata structure
by virtue of compactness of metadata structure representation and
efficient lookup mechanism. Dentries is ordered on the basis of
name’s hash. Every node of dentries b-tree has: (1) dirty bitmap -
tracking modified dentries, (2) lock bitmap - exclusive locking of
particular dentries without the necessity to lock the whole b-tree
node. Actually, it is expected that dentries b-tree could contain
not many nodes in average because the two nodes (8K in size) of
dentries b-tree is capable to store about 400 dentries.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/dentries_tree.c | 3013 ++++++++++++++++++++++++++++++++++++++
 fs/ssdfs/dentries_tree.h |  156 ++
 2 files changed, 3169 insertions(+)
 create mode 100644 fs/ssdfs/dentries_tree.c
 create mode 100644 fs/ssdfs/dentries_tree.h

diff --git a/fs/ssdfs/dentries_tree.c b/fs/ssdfs/dentries_tree.c
new file mode 100644
index 000000000000..8c2ce87d1077
--- /dev/null
+++ b/fs/ssdfs/dentries_tree.c
@@ -0,0 +1,3013 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/dentries_tree.c - dentries btree implementation.
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
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/pagevec.h>
+
+#include "peb_mapping_queue.h"
+#include "peb_mapping_table_cache.h"
+#include "ssdfs.h"
+#include "btree_search.h"
+#include "btree_node.h"
+#include "btree.h"
+#include "shared_dictionary.h"
+#include "segment_tree.h"
+#include "dentries_tree.h"
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+atomic64_t ssdfs_dentries_page_leaks;
+atomic64_t ssdfs_dentries_memory_leaks;
+atomic64_t ssdfs_dentries_cache_leaks;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+/*
+ * void ssdfs_dentries_cache_leaks_increment(void *kaddr)
+ * void ssdfs_dentries_cache_leaks_decrement(void *kaddr)
+ * void *ssdfs_dentries_kmalloc(size_t size, gfp_t flags)
+ * void *ssdfs_dentries_kzalloc(size_t size, gfp_t flags)
+ * void *ssdfs_dentries_kcalloc(size_t n, size_t size, gfp_t flags)
+ * void ssdfs_dentries_kfree(void *kaddr)
+ * struct page *ssdfs_dentries_alloc_page(gfp_t gfp_mask)
+ * struct page *ssdfs_dentries_add_pagevec_page(struct pagevec *pvec)
+ * void ssdfs_dentries_free_page(struct page *page)
+ * void ssdfs_dentries_pagevec_release(struct pagevec *pvec)
+ */
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	SSDFS_MEMORY_LEAKS_CHECKER_FNS(dentries)
+#else
+	SSDFS_MEMORY_ALLOCATOR_FNS(dentries)
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+
+void ssdfs_dentries_memory_leaks_init(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_set(&ssdfs_dentries_page_leaks, 0);
+	atomic64_set(&ssdfs_dentries_memory_leaks, 0);
+	atomic64_set(&ssdfs_dentries_cache_leaks, 0);
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+void ssdfs_dentries_check_memory_leaks(void)
+{
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	if (atomic64_read(&ssdfs_dentries_page_leaks) != 0) {
+		SSDFS_ERR("DENTRIES TREE: "
+			  "memory leaks include %lld pages\n",
+			  atomic64_read(&ssdfs_dentries_page_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_dentries_memory_leaks) != 0) {
+		SSDFS_ERR("DENTRIES TREE: "
+			  "memory allocator suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_dentries_memory_leaks));
+	}
+
+	if (atomic64_read(&ssdfs_dentries_cache_leaks) != 0) {
+		SSDFS_ERR("DENTRIES TREE: "
+			  "caches suffers from %lld leaks\n",
+			  atomic64_read(&ssdfs_dentries_cache_leaks));
+	}
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+}
+
+#define S_SHIFT 12
+static unsigned char
+ssdfs_type_by_mode[S_IFMT >> S_SHIFT] = {
+	[S_IFREG >> S_SHIFT]	= SSDFS_FT_REG_FILE,
+	[S_IFDIR >> S_SHIFT]	= SSDFS_FT_DIR,
+	[S_IFCHR >> S_SHIFT]	= SSDFS_FT_CHRDEV,
+	[S_IFBLK >> S_SHIFT]	= SSDFS_FT_BLKDEV,
+	[S_IFIFO >> S_SHIFT]	= SSDFS_FT_FIFO,
+	[S_IFSOCK >> S_SHIFT]	= SSDFS_FT_SOCK,
+	[S_IFLNK >> S_SHIFT]	= SSDFS_FT_SYMLINK,
+};
+
+static inline
+void ssdfs_set_file_type(struct ssdfs_dir_entry *de, struct inode *inode)
+{
+	umode_t mode = inode->i_mode;
+
+	de->file_type = ssdfs_type_by_mode[(mode & S_IFMT)>>S_SHIFT];
+}
+
+/*
+ * ssdfs_dentries_tree_create() - create dentries tree of a new inode
+ * @fsi: pointer on shared file system object
+ * @ii: pointer on in-core SSDFS inode
+ *
+ * This method tries to create dentries btree for a new inode.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - unable to allocate memory.
+ */
+int ssdfs_dentries_tree_create(struct ssdfs_fs_info *fsi,
+				struct ssdfs_inode_info *ii)
+{
+	struct ssdfs_dentries_btree_info *ptr;
+	size_t dentry_size = sizeof(struct ssdfs_dir_entry);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !ii);
+	BUG_ON(!rwsem_is_locked(&ii->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("ii %p, ino %lu\n",
+		  ii, ii->vfs_inode.i_ino);
+#else
+	SSDFS_DBG("ii %p, ino %lu\n",
+		  ii, ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (S_ISDIR(ii->vfs_inode.i_mode))
+		ii->dentries_tree = NULL;
+	else {
+		SSDFS_WARN("regular file cannot have dentries tree\n");
+		return -ERANGE;
+	}
+
+	ptr = ssdfs_dentries_kzalloc(sizeof(struct ssdfs_dentries_btree_info),
+				     GFP_KERNEL);
+	if (!ptr) {
+		SSDFS_ERR("fail to allocate dentries tree\n");
+		return -ENOMEM;
+	}
+
+	atomic_set(&ptr->state, SSDFS_DENTRIES_BTREE_UNKNOWN_STATE);
+	atomic_set(&ptr->type, SSDFS_INLINE_DENTRIES_ARRAY);
+	atomic64_set(&ptr->dentries_count, 0);
+	init_rwsem(&ptr->lock);
+	ptr->generic_tree = NULL;
+	memset(ptr->buffer.dentries, 0xFF,
+		dentry_size * SSDFS_INLINE_DENTRIES_COUNT);
+	ptr->inline_dentries = ptr->buffer.dentries;
+	memset(&ptr->root_buffer, 0xFF,
+		sizeof(struct ssdfs_btree_inline_root_node));
+	ptr->root = NULL;
+	ssdfs_memcpy(&ptr->desc,
+		     0, sizeof(struct ssdfs_dentries_btree_descriptor),
+		     &fsi->segs_tree->dentries_btree,
+		     0, sizeof(struct ssdfs_dentries_btree_descriptor),
+		     sizeof(struct ssdfs_dentries_btree_descriptor));
+	ptr->owner = ii;
+	ptr->fsi = fsi;
+	atomic_set(&ptr->state, SSDFS_DENTRIES_BTREE_CREATED);
+
+	ssdfs_debug_dentries_btree_object(ptr);
+
+	ii->dentries_tree = ptr;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_tree_destroy() - destroy dentries tree
+ * @ii: pointer on in-core SSDFS inode
+ */
+void ssdfs_dentries_tree_destroy(struct ssdfs_inode_info *ii)
+{
+	struct ssdfs_dentries_btree_info *tree;
+	size_t dentry_size = sizeof(struct ssdfs_dir_entry);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!ii);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("ii %p, ino %lu\n",
+		  ii, ii->vfs_inode.i_ino);
+#else
+	SSDFS_DBG("ii %p, ino %lu\n",
+		  ii, ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	tree = SSDFS_DTREE(ii);
+
+	if (!tree) {
+		SSDFS_DBG("dentries tree is absent: ino %lu\n",
+			  ii->vfs_inode.i_ino);
+		return;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_CREATED:
+	case SSDFS_DENTRIES_BTREE_INITIALIZED:
+		/* expected state*/
+		break;
+
+	case SSDFS_DENTRIES_BTREE_CORRUPTED:
+		SSDFS_WARN("dentries tree is corrupted: "
+			   "ino %lu\n",
+			   ii->vfs_inode.i_ino);
+		break;
+
+	case SSDFS_DENTRIES_BTREE_DIRTY:
+		if (atomic64_read(&tree->dentries_count) > 0) {
+			SSDFS_WARN("dentries tree is dirty: "
+				   "ino %lu\n",
+				   ii->vfs_inode.i_ino);
+		} else {
+			/* regular destroy */
+			atomic_set(&tree->state,
+				    SSDFS_DENTRIES_BTREE_UNKNOWN_STATE);
+		}
+		break;
+
+	default:
+		SSDFS_WARN("invalid state of dentries tree: "
+			   "ino %lu, state %#x\n",
+			   ii->vfs_inode.i_ino,
+			   atomic_read(&tree->state));
+		return;
+	}
+
+	if (rwsem_is_locked(&tree->lock)) {
+		/* inform about possible trouble */
+		SSDFS_WARN("tree is locked under destruction\n");
+	}
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_DENTRIES_ARRAY:
+		if (!tree->inline_dentries) {
+			SSDFS_WARN("empty inline_dentries pointer\n");
+			memset(tree->buffer.dentries, 0xFF,
+				dentry_size * SSDFS_INLINE_DENTRIES_COUNT);
+		} else {
+			memset(tree->inline_dentries, 0xFF,
+				dentry_size * SSDFS_INLINE_DENTRIES_COUNT);
+		}
+		tree->inline_dentries = NULL;
+		break;
+
+	case SSDFS_PRIVATE_DENTRIES_BTREE:
+		if (!tree->generic_tree) {
+			SSDFS_WARN("empty generic_tree pointer\n");
+			ssdfs_btree_destroy(&tree->buffer.tree);
+		} else {
+			/* destroy tree via pointer */
+			ssdfs_btree_destroy(tree->generic_tree);
+		}
+		tree->generic_tree = NULL;
+		break;
+
+	default:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG();
+#else
+		SSDFS_WARN("invalid dentries btree state %#x\n",
+			   atomic_read(&tree->state));
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+	}
+
+	memset(&tree->root_buffer, 0xFF,
+		sizeof(struct ssdfs_btree_inline_root_node));
+	tree->root = NULL;
+
+	tree->owner = NULL;
+	tree->fsi = NULL;
+
+	atomic_set(&tree->type, SSDFS_DENTRIES_BTREE_UNKNOWN_TYPE);
+	atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_UNKNOWN_STATE);
+
+	ssdfs_dentries_kfree(ii->dentries_tree);
+	ii->dentries_tree = NULL;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+}
+
+/*
+ * ssdfs_dentries_tree_init() - init dentries tree for existing inode
+ * @fsi: pointer on shared file system object
+ * @ii: pointer on in-core SSDFS inode
+ *
+ * This method tries to create the dentries tree and to initialize
+ * the root node.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOMEM     - unable to allocate memory.
+ * %-ERANGE     - internal error.
+ * %-EIO        - corrupted raw on-disk inode.
+ */
+int ssdfs_dentries_tree_init(struct ssdfs_fs_info *fsi,
+			     struct ssdfs_inode_info *ii)
+{
+	struct ssdfs_inode raw_inode;
+	struct ssdfs_btree_node *node;
+	struct ssdfs_dentries_btree_info *tree;
+	struct ssdfs_btree_inline_root_node *root_node;
+	u16 flags;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !ii);
+	BUG_ON(!rwsem_is_locked(&ii->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("fsi %p, ii %p, ino %lu\n",
+		  fsi, ii, ii->vfs_inode.i_ino);
+#else
+	SSDFS_DBG("fsi %p, ii %p, ino %lu\n",
+		  fsi, ii, ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	tree = SSDFS_DTREE(ii);
+	if (!tree) {
+		SSDFS_DBG("dentries tree is absent: ino %lu\n",
+			  ii->vfs_inode.i_ino);
+		return -ERANGE;
+	}
+
+	ssdfs_memcpy(&raw_inode,
+		     0, sizeof(struct ssdfs_inode),
+		     &ii->raw_inode,
+		     0, sizeof(struct ssdfs_inode),
+		     sizeof(struct ssdfs_inode));
+
+	flags = le16_to_cpu(raw_inode.private_flags);
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_CREATED:
+		/* expected tree state */
+		break;
+
+	default:
+		SSDFS_WARN("unexpected state of tree %#x\n",
+			   atomic_read(&tree->state));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_DENTRIES_ARRAY:
+		/* expected tree type */
+		break;
+
+	case SSDFS_PRIVATE_DENTRIES_BTREE:
+		SSDFS_WARN("unexpected type of tree %#x\n",
+			   atomic_read(&tree->type));
+		return -ERANGE;
+
+	default:
+		SSDFS_WARN("invalid type of tree %#x\n",
+			   atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	down_write(&tree->lock);
+
+	if (flags & SSDFS_INODE_HAS_DENTRIES_BTREE) {
+		atomic64_set(&tree->dentries_count,
+			     le32_to_cpu(raw_inode.count_of.dentries));
+
+		if (tree->generic_tree) {
+			err = -ERANGE;
+			atomic_set(&tree->state,
+				   SSDFS_DENTRIES_BTREE_CORRUPTED);
+			SSDFS_WARN("generic tree exists\n");
+			goto finish_tree_init;
+		}
+
+		tree->generic_tree = &tree->buffer.tree;
+		tree->inline_dentries = NULL;
+		atomic_set(&tree->type, SSDFS_PRIVATE_DENTRIES_BTREE);
+
+		err = ssdfs_btree_create(fsi,
+					 ii->vfs_inode.i_ino,
+					 &ssdfs_dentries_btree_desc_ops,
+					 &ssdfs_dentries_btree_ops,
+					 tree->generic_tree);
+		if (unlikely(err)) {
+			atomic_set(&tree->state,
+				   SSDFS_DENTRIES_BTREE_CORRUPTED);
+			SSDFS_ERR("fail to create dentries tree: err %d\n",
+				  err);
+			goto finish_tree_init;
+		}
+
+		err = ssdfs_btree_radix_tree_find(tree->generic_tree,
+						  SSDFS_BTREE_ROOT_NODE_ID,
+						  &node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to get the root node: err %d\n",
+				  err);
+			goto fail_create_generic_tree;
+		} else if (unlikely(!node)) {
+			err = -ERANGE;
+			SSDFS_WARN("empty node pointer\n");
+			goto fail_create_generic_tree;
+		}
+
+		root_node = &raw_inode.internal[0].area1.dentries_root;
+		err = ssdfs_btree_create_root_node(node, root_node);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to init the root node: err %d\n",
+				  err);
+			goto fail_create_generic_tree;
+		}
+
+		tree->root = &tree->root_buffer;
+		ssdfs_memcpy(tree->root,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     root_node,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     sizeof(struct ssdfs_btree_inline_root_node));
+
+		atomic_set(&tree->type, SSDFS_PRIVATE_DENTRIES_BTREE);
+		atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_INITIALIZED);
+
+fail_create_generic_tree:
+		if (unlikely(err)) {
+			atomic_set(&tree->state,
+				   SSDFS_DENTRIES_BTREE_CORRUPTED);
+			ssdfs_btree_destroy(tree->generic_tree);
+			tree->generic_tree = NULL;
+			goto finish_tree_init;
+		}
+	} else if (flags & SSDFS_INODE_HAS_XATTR_BTREE) {
+		atomic64_set(&tree->dentries_count,
+			     le32_to_cpu(raw_inode.count_of.dentries));
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(atomic64_read(&tree->dentries_count) >
+			SSDFS_INLINE_DENTRIES_PER_AREA);
+#else
+		if (atomic64_read(&tree->dentries_count) >
+		    SSDFS_INLINE_DENTRIES_PER_AREA) {
+			err = -EIO;
+			atomic_set(&tree->state,
+				   SSDFS_DENTRIES_BTREE_CORRUPTED);
+			SSDFS_ERR("corrupted on-disk raw inode: "
+				  "dentries_count %llu\n",
+				  (u64)atomic64_read(&tree->dentries_count));
+			goto finish_tree_init;
+		}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (!tree->inline_dentries) {
+			err = -ERANGE;
+			atomic_set(&tree->state,
+				   SSDFS_DENTRIES_BTREE_CORRUPTED);
+			SSDFS_WARN("undefined inline dentries pointer\n");
+			goto finish_tree_init;
+		} else {
+			ssdfs_memcpy(tree->inline_dentries,
+				     0, ssdfs_inline_dentries_size(),
+				     &raw_inode.internal[0].area1,
+				     0, ssdfs_area_dentries_size(),
+				     ssdfs_area_dentries_size());
+		}
+
+		atomic_set(&tree->type, SSDFS_INLINE_DENTRIES_ARRAY);
+		atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_INITIALIZED);
+	} else if (flags & SSDFS_INODE_HAS_INLINE_DENTRIES) {
+		u32 dentries_count = le32_to_cpu(raw_inode.count_of.dentries);
+		u32 i;
+
+		atomic64_set(&tree->dentries_count, dentries_count);
+
+		if (!tree->inline_dentries) {
+			err = -ERANGE;
+			atomic_set(&tree->state,
+				   SSDFS_DENTRIES_BTREE_CORRUPTED);
+			SSDFS_WARN("undefined inline dentries pointer\n");
+			goto finish_tree_init;
+		} else {
+			ssdfs_memcpy(tree->inline_dentries,
+				     0, ssdfs_inline_dentries_size(),
+				     &raw_inode.internal,
+				     0, ssdfs_inline_dentries_size(),
+				     ssdfs_inline_dentries_size());
+		}
+
+		for (i = 0; i < dentries_count; i++) {
+			u64 hash;
+			struct ssdfs_dir_entry *dentry =
+					&tree->inline_dentries[i];
+
+			hash = le64_to_cpu(dentry->hash_code);
+
+			if (hash == 0) {
+				size_t len = dentry->name_len;
+				const char *name =
+					(const char *)dentry->inline_string;
+
+				if (len > SSDFS_DENTRY_INLINE_NAME_MAX_LEN) {
+					err = -ERANGE;
+					SSDFS_ERR("dentry hasn't hash code: "
+						  "len %zu\n", len);
+					goto finish_tree_init;
+				}
+
+				hash = __ssdfs_generate_name_hash(name, len,
+					    SSDFS_DENTRY_INLINE_NAME_MAX_LEN);
+				if (hash == U64_MAX) {
+					err = -ERANGE;
+					SSDFS_ERR("fail to generate hash\n");
+					goto finish_tree_init;
+				}
+
+				dentry->hash_code = cpu_to_le64(hash);
+			}
+		}
+
+		atomic_set(&tree->type, SSDFS_INLINE_DENTRIES_ARRAY);
+		atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_INITIALIZED);
+	} else
+		BUG();
+
+finish_tree_init:
+	up_write(&tree->lock);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("dentries_count %llu\n",
+		  atomic64_read(&tree->dentries_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_dentries_btree_object(tree);
+
+	return err;
+}
+
+/*
+ * ssdfs_migrate_inline2generic_tree() - convert inline tree into generic
+ * @tree: dentries tree
+ *
+ * This method tries to convert the inline tree into generic one.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EFAULT     - the tree is empty.
+ */
+static
+int ssdfs_migrate_inline2generic_tree(struct ssdfs_dentries_btree_info *tree)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_dir_entry dentries[SSDFS_INLINE_DENTRIES_COUNT];
+	struct ssdfs_dir_entry *cur;
+	struct ssdfs_btree_search *search;
+	size_t dentry_size = sizeof(struct ssdfs_dir_entry);
+	size_t dentries_bytes;
+	s64 dentries_count, dentries_capacity;
+	int private_flags;
+	s64 i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p\n", tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = tree->fsi;
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_DENTRIES_ARRAY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_CREATED:
+	case SSDFS_DENTRIES_BTREE_INITIALIZED:
+	case SSDFS_DENTRIES_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	dentries_count = atomic64_read(&tree->dentries_count);
+
+	if (!tree->owner) {
+		SSDFS_ERR("empty owner inode\n");
+		return -ERANGE;
+	}
+
+	private_flags = atomic_read(&tree->owner->private_flags);
+
+	dentries_capacity = SSDFS_INLINE_DENTRIES_COUNT;
+	if (private_flags & SSDFS_INODE_HAS_XATTR_BTREE)
+		dentries_capacity -= SSDFS_INLINE_DENTRIES_PER_AREA;
+	if (private_flags & SSDFS_INODE_HAS_DENTRIES_BTREE) {
+		SSDFS_ERR("the dentries tree is generic\n");
+		return -ERANGE;
+	}
+
+	if (dentries_count > dentries_capacity) {
+		SSDFS_WARN("dentries tree is corrupted: "
+			   "dentries_count %lld, dentries_capacity %lld\n",
+			   dentries_count, dentries_capacity);
+		atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_CORRUPTED);
+		return -ERANGE;
+	} else if (dentries_count == 0) {
+		SSDFS_DBG("empty tree\n");
+		return -EFAULT;
+	} else if (dentries_count < dentries_capacity) {
+		SSDFS_WARN("dentries_count %lld, dentries_capacity %lld\n",
+			   dentries_count, dentries_capacity);
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree->inline_dentries || tree->generic_tree);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(dentries, 0xFF, ssdfs_inline_dentries_size());
+
+	dentries_bytes = dentry_size * dentries_capacity;
+	ssdfs_memcpy(dentries, 0, ssdfs_inline_dentries_size(),
+		     tree->inline_dentries, 0, ssdfs_inline_dentries_size(),
+		     dentries_bytes);
+
+	atomic64_sub(dentries_count, &tree->dentries_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("dentries_count %llu\n",
+		  atomic64_read(&tree->dentries_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < dentries_count; i++) {
+		cur = &dentries[i];
+
+		cur->dentry_type = SSDFS_REGULAR_DENTRY;
+	}
+
+	tree->generic_tree = &tree->buffer.tree;
+	tree->inline_dentries = NULL;
+
+	err = ssdfs_btree_create(fsi,
+				 tree->owner->vfs_inode.i_ino,
+				 &ssdfs_dentries_btree_desc_ops,
+				 &ssdfs_dentries_btree_ops,
+				 &tree->buffer.tree);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to create generic tree: err %d\n",
+			  err);
+		goto recover_inline_tree;
+	}
+
+	search = ssdfs_btree_search_alloc();
+	if (!search) {
+		err = -ENOMEM;
+		SSDFS_ERR("fail to allocate btree search object\n");
+		goto destroy_generic_tree;
+	}
+
+	ssdfs_btree_search_init(search);
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+	search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT |
+			SSDFS_BTREE_SEARCH_HAS_VALID_INO;
+	cur = &dentries[0];
+	search->request.start.hash = le64_to_cpu(cur->hash_code);
+	search->request.start.ino = le64_to_cpu(cur->ino);
+	if (dentries_count > 1) {
+		cur = &dentries[dentries_count - 1];
+		search->request.end.hash = le64_to_cpu(cur->hash_code);
+		search->request.end.ino = le64_to_cpu(cur->ino);
+	} else {
+		search->request.end.hash = search->request.start.hash;
+		search->request.end.ino = search->request.start.ino;
+	}
+	search->request.count = (u16)dentries_count;
+
+	err = ssdfs_btree_find_item(&tree->buffer.tree, search);
+	if (err == -ENODATA) {
+		/* expected error */
+		err = 0;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find item: "
+			  "start (hash %llx, ino %llu), "
+			  "end (hash %llx, ino %llu), err %d\n",
+			  search->request.start.hash,
+			  search->request.start.ino,
+			  search->request.end.hash,
+			  search->request.end.ino,
+			  err);
+		goto finish_add_range;
+	}
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+	case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+	case SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE:
+		/* expected state */
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid search result's state %#x\n",
+			  search->result.state);
+		goto finish_add_range;
+	}
+
+	if (search->result.buf) {
+		err = -ERANGE;
+		SSDFS_ERR("search->result.buf %p\n",
+			  search->result.buf);
+		goto finish_add_range;
+	}
+
+	if (dentries_count == 1) {
+		search->result.buf_state = SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+		search->result.buf_size = sizeof(struct ssdfs_dir_entry);
+		search->result.items_in_buffer = dentries_count;
+		search->result.buf = &search->raw.dentry;
+		ssdfs_memcpy(&search->raw.dentry, 0, dentry_size,
+			     dentries, 0, ssdfs_inline_dentries_size(),
+			     search->result.buf_size);
+	} else {
+		err = ssdfs_btree_search_alloc_result_buf(search,
+			    dentries_count * sizeof(struct ssdfs_dir_entry));
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to allocate memory for buffer\n");
+			goto finish_add_range;
+		}
+
+		ssdfs_memcpy(search->result.buf, 0, search->result.buf_size,
+			     dentries, 0, ssdfs_inline_dentries_size(),
+			     search->result.buf_size);
+		search->result.items_in_buffer = (u16)dentries_count;
+	}
+
+	search->request.type = SSDFS_BTREE_SEARCH_ADD_RANGE;
+
+	err = ssdfs_btree_add_range(&tree->buffer.tree, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add the range into tree: "
+			   "start_hash %llx, end_hash %llx, err %d\n",
+			   search->request.start.hash,
+			   search->request.end.hash,
+			   err);
+		goto finish_add_range;
+	}
+
+finish_add_range:
+	ssdfs_btree_search_free(search);
+
+	if (unlikely(err))
+		goto destroy_generic_tree;
+
+	err = ssdfs_btree_synchronize_root_node(tree->generic_tree,
+						tree->root);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to synchronize the root node: "
+			  "err %d\n", err);
+		goto destroy_generic_tree;
+	}
+
+	atomic_set(&tree->type, SSDFS_PRIVATE_DENTRIES_BTREE);
+	atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_DIRTY);
+
+	atomic_or(SSDFS_INODE_HAS_DENTRIES_BTREE,
+		  &tree->owner->private_flags);
+	atomic_and(~SSDFS_INODE_HAS_INLINE_DENTRIES,
+		  &tree->owner->private_flags);
+
+	return 0;
+
+destroy_generic_tree:
+	ssdfs_btree_destroy(&tree->buffer.tree);
+
+recover_inline_tree:
+	for (i = 0; i < dentries_count; i++) {
+		cur = &dentries[i];
+
+		cur->dentry_type = SSDFS_INLINE_DENTRY;
+	}
+
+	ssdfs_memcpy(tree->buffer.dentries, 0, ssdfs_inline_dentries_size(),
+		     dentries, 0, ssdfs_inline_dentries_size(),
+		     ssdfs_inline_dentries_size());
+
+	tree->inline_dentries = tree->buffer.dentries;
+	tree->generic_tree = NULL;
+
+	atomic64_set(&tree->dentries_count, dentries_count);
+
+	return err;
+}
+
+/*
+ * ssdfs_dentries_tree_flush() - save modified dentries tree
+ * @fsi: pointer on shared file system object
+ * @ii: pointer on in-core SSDFS inode
+ *
+ * This method tries to flush inode's dentries btree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_dentries_tree_flush(struct ssdfs_fs_info *fsi,
+				struct ssdfs_inode_info *ii)
+{
+	struct ssdfs_dentries_btree_info *tree;
+	size_t dentry_size = sizeof(struct ssdfs_dir_entry);
+	int flags;
+	u64 dentries_count;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !ii);
+	BUG_ON(!rwsem_is_locked(&ii->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("fsi %p, ii %p, ino %lu\n",
+		  fsi, ii, ii->vfs_inode.i_ino);
+#else
+	SSDFS_DBG("fsi %p, ii %p, ino %lu\n",
+		  fsi, ii, ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	tree = SSDFS_DTREE(ii);
+	if (!tree) {
+		SSDFS_DBG("dentries tree is absent: ino %lu\n",
+			  ii->vfs_inode.i_ino);
+		return -ERANGE;
+	}
+
+	flags = atomic_read(&ii->private_flags);
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_DIRTY:
+		/* need to flush */
+		break;
+
+	case SSDFS_DENTRIES_BTREE_CREATED:
+	case SSDFS_DENTRIES_BTREE_INITIALIZED:
+		/* do nothing */
+		return 0;
+
+	case SSDFS_DENTRIES_BTREE_CORRUPTED:
+		SSDFS_DBG("dentries btree corrupted: ino %lu\n",
+			  ii->vfs_inode.i_ino);
+		return -EOPNOTSUPP;
+
+	default:
+		SSDFS_WARN("unexpected state of tree %#x\n",
+			   atomic_read(&tree->state));
+		return -ERANGE;
+	}
+
+	down_write(&tree->lock);
+
+	dentries_count = atomic64_read(&tree->dentries_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("dentries_count %llu\n", dentries_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (dentries_count >= U32_MAX) {
+		err = -EOPNOTSUPP;
+		SSDFS_ERR("fail to store dentries_count %llu\n",
+			  dentries_count);
+		goto finish_dentries_tree_flush;
+	}
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_DENTRIES_ARRAY:
+		if (!tree->inline_dentries) {
+			err = -ERANGE;
+			atomic_set(&tree->state,
+				   SSDFS_DENTRIES_BTREE_CORRUPTED);
+			SSDFS_WARN("undefined inline dentries pointer\n");
+			goto finish_dentries_tree_flush;
+		}
+
+		if (dentries_count == 0) {
+			flags = atomic_read(&ii->private_flags);
+
+			if (flags & SSDFS_INODE_HAS_XATTR_BTREE) {
+				memset(&ii->raw_inode.internal[0].area1, 0xFF,
+					ssdfs_area_dentries_size());
+			} else {
+				memset(&ii->raw_inode.internal, 0xFF,
+					ssdfs_inline_dentries_size());
+			}
+		} else if (dentries_count <= SSDFS_INLINE_DENTRIES_PER_AREA) {
+			flags = atomic_read(&ii->private_flags);
+
+			if (flags & SSDFS_INODE_HAS_XATTR_BTREE) {
+				memset(&ii->raw_inode.internal[0].area1, 0xFF,
+					ssdfs_area_dentries_size());
+				ssdfs_memcpy(&ii->raw_inode.internal[0].area1,
+					     0, ssdfs_area_dentries_size(),
+					     tree->inline_dentries,
+					     0, ssdfs_inline_dentries_size(),
+					     dentries_count * dentry_size);
+			} else {
+				memset(&ii->raw_inode.internal, 0xFF,
+					ssdfs_inline_dentries_size());
+				ssdfs_memcpy(&ii->raw_inode.internal,
+					     0, ssdfs_inline_dentries_size(),
+					     tree->inline_dentries,
+					     0, ssdfs_inline_dentries_size(),
+					     dentries_count * dentry_size);
+			}
+		} else if (dentries_count <= SSDFS_INLINE_DENTRIES_COUNT) {
+			flags = atomic_read(&ii->private_flags);
+
+			if (flags & SSDFS_INODE_HAS_XATTR_BTREE) {
+				err = -EAGAIN;
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("tree should be converted: "
+					  "ino %lu\n",
+					  ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_DEBUG */
+			} else {
+				memset(&ii->raw_inode.internal, 0xFF,
+					ssdfs_inline_dentries_size());
+				ssdfs_memcpy(&ii->raw_inode.internal,
+					     0, ssdfs_inline_dentries_size(),
+					     tree->inline_dentries,
+					     0, ssdfs_inline_dentries_size(),
+					     dentries_count * dentry_size);
+			}
+
+			if (err == -EAGAIN) {
+				err = ssdfs_migrate_inline2generic_tree(tree);
+				if (unlikely(err)) {
+					atomic_set(&tree->state,
+						SSDFS_DENTRIES_BTREE_CORRUPTED);
+					SSDFS_ERR("fail to convert tree: "
+						  "err %d\n", err);
+					goto finish_dentries_tree_flush;
+				} else
+					goto try_generic_tree_flush;
+			}
+		} else {
+			err = -ERANGE;
+			atomic_set(&tree->state,
+				   SSDFS_DENTRIES_BTREE_CORRUPTED);
+			SSDFS_WARN("invalid dentries_count %llu\n",
+				   (u64)atomic64_read(&tree->dentries_count));
+			goto finish_dentries_tree_flush;
+		}
+
+		atomic_or(SSDFS_INODE_HAS_INLINE_DENTRIES,
+			  &ii->private_flags);
+		break;
+
+	case SSDFS_PRIVATE_DENTRIES_BTREE:
+try_generic_tree_flush:
+		if (!tree->generic_tree) {
+			err = -ERANGE;
+			atomic_set(&tree->state,
+				   SSDFS_DENTRIES_BTREE_CORRUPTED);
+			SSDFS_WARN("undefined generic tree pointer\n");
+			goto finish_dentries_tree_flush;
+		}
+
+		err = ssdfs_btree_flush(tree->generic_tree);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to flush dentries btree: "
+				  "ino %lu, err %d\n",
+				  ii->vfs_inode.i_ino, err);
+			goto finish_dentries_tree_flush;
+		}
+
+		if (!tree->root) {
+			err = -ERANGE;
+			atomic_set(&tree->state,
+				   SSDFS_DENTRIES_BTREE_CORRUPTED);
+			SSDFS_WARN("undefined root node pointer\n");
+			goto finish_dentries_tree_flush;
+		}
+
+		ssdfs_memcpy(&ii->raw_inode.internal[0].area1.dentries_root,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     tree->root,
+			     0, sizeof(struct ssdfs_btree_inline_root_node),
+			     sizeof(struct ssdfs_btree_inline_root_node));
+
+		atomic_or(SSDFS_INODE_HAS_DENTRIES_BTREE,
+			  &ii->private_flags);
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_WARN("invalid type of tree %#x\n",
+			   atomic_read(&tree->type));
+		goto finish_dentries_tree_flush;
+	}
+
+	ii->raw_inode.count_of.dentries = cpu_to_le32((u32)dentries_count);
+	atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_INITIALIZED);
+
+finish_dentries_tree_flush:
+	up_write(&tree->lock);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("RAW INODE DUMP\n");
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+			     &ii->raw_inode,
+			     sizeof(struct ssdfs_inode));
+	SSDFS_DBG("\n");
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/******************************************************************************
+ *                     DENTRIES TREE OBJECT FUNCTIONALITY                     *
+ ******************************************************************************/
+
+/*
+ * need_initialize_dentries_btree_search() - check necessity to init the search
+ * @name_hash: name hash
+ * @search: search object
+ */
+static inline
+bool need_initialize_dentries_btree_search(u64 name_hash,
+					   struct ssdfs_btree_search *search)
+{
+	return need_initialize_btree_search(search) ||
+		search->request.start.hash != name_hash;
+}
+
+/*
+ * ssdfs_generate_name_hash() - generate a name's hash
+ * @str: string descriptor
+ */
+u64 ssdfs_generate_name_hash(const struct qstr *str)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!str);
+
+	SSDFS_DBG("name %s, len %u\n",
+		  str->name, str->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return __ssdfs_generate_name_hash(str->name, str->len,
+					  SSDFS_DENTRY_INLINE_NAME_MAX_LEN);
+}
+
+/*
+ * ssdfs_check_dentry_for_request() - check dentry
+ * @fsi:  pointer on shared file system object
+ * @dentry: pointer on dentry object
+ * @search: search object
+ *
+ * This method tries to check @dentry for the @search request.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - continue the search.
+ * %-ENODATA    - possible place was found.
+ */
+static
+int ssdfs_check_dentry_for_request(struct ssdfs_fs_info *fsi,
+				   struct ssdfs_dir_entry *dentry,
+				   struct ssdfs_btree_search *search)
+{
+	struct ssdfs_shared_dict_btree_info *dict;
+	u32 req_flags;
+	u64 search_hash;
+	u64 req_ino;
+	const char *req_name;
+	size_t req_name_len;
+	u64 hash_code;
+	u64 ino;
+	u8 dentry_type;
+	u8 file_type;
+	u8 flags;
+	u8 name_len;
+	int res, err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !dentry || !search);
+
+	SSDFS_DBG("fsi %p, dentry %p, search %p\n",
+		  fsi, dentry, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	dict = fsi->shdictree;
+	if (!dict) {
+		SSDFS_ERR("shared dictionary is absent\n");
+		return -ERANGE;
+	}
+
+	req_flags = search->request.flags;
+	search_hash = search->request.start.hash;
+	req_ino = search->request.start.ino;
+	req_name = search->request.start.name;
+	req_name_len = search->request.start.name_len;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("search_hash %llx, req_ino %llu\n",
+		  search_hash, req_ino);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hash_code = le64_to_cpu(dentry->hash_code);
+	ino = le64_to_cpu(dentry->ino);
+	dentry_type = dentry->dentry_type;
+	file_type = dentry->file_type;
+	flags = dentry->flags;
+	name_len = dentry->name_len;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("hash_code %llx, ino %llu, "
+		  "type %#x, file_type %#x, flags %#x, name_len %u\n",
+		  hash_code, ino, dentry_type,
+		  file_type, flags, name_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (dentry_type <= SSDFS_DENTRY_UNKNOWN_TYPE ||
+	    dentry_type >= SSDFS_DENTRY_TYPE_MAX) {
+		SSDFS_ERR("corrupted dentry: dentry_type %#x\n",
+			  dentry_type);
+		return -EIO;
+	}
+
+	if (file_type <= SSDFS_FT_UNKNOWN ||
+	    file_type >= SSDFS_FT_MAX) {
+		SSDFS_ERR("corrupted dentry: file_type %#x\n",
+			  file_type);
+		return -EIO;
+	}
+
+	if (hash_code != 0 && search_hash < hash_code) {
+		err = -ENODATA;
+		search->result.err = -ENODATA;
+		search->result.state =
+			SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+		goto finish_check_dentry;
+	} else if (hash_code != 0 && search_hash > hash_code) {
+		/* continue the search */
+		err = -EAGAIN;
+		goto finish_check_dentry;
+	} else {
+		/* search_hash == hash_code */
+
+		if (req_flags & SSDFS_BTREE_SEARCH_HAS_VALID_INO) {
+			if (req_ino < ino) {
+				/* hash collision case */
+				err = -ENODATA;
+				search->result.err = -ENODATA;
+				search->result.state =
+					SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+				goto finish_check_dentry;
+			} else if (req_ino == ino) {
+				search->result.state =
+					SSDFS_BTREE_SEARCH_VALID_ITEM;
+				goto extract_full_name;
+			} else {
+				/* hash collision case */
+				/* continue the search */
+				err = -EAGAIN;
+				goto finish_check_dentry;
+			}
+		}
+
+		if (req_flags & SSDFS_BTREE_SEARCH_HAS_VALID_NAME) {
+			int res;
+
+			if (!req_name) {
+				SSDFS_ERR("empty name pointer\n");
+				return -ERANGE;
+			}
+
+			name_len = min_t(u8, name_len,
+					 SSDFS_DENTRY_INLINE_NAME_MAX_LEN);
+			res = strncmp(req_name, dentry->inline_string,
+					name_len);
+			if (res < 0) {
+				/* hash collision case */
+				err = -ENODATA;
+				search->result.err = -ENODATA;
+				search->result.state =
+					SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+				goto finish_check_dentry;
+			} else if (res == 0) {
+				search->result.state =
+					SSDFS_BTREE_SEARCH_VALID_ITEM;
+				goto extract_full_name;
+			} else {
+				/* hash collision case */
+				/* continue the search */
+				err = -EAGAIN;
+				goto finish_check_dentry;
+			}
+		}
+
+extract_full_name:
+		if (flags & SSDFS_DENTRY_HAS_EXTERNAL_STRING) {
+			err = ssdfs_shared_dict_get_name(dict, search_hash,
+							 &search->name);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to extract the name: "
+					  "hash %llx, err %d\n",
+					  search_hash, err);
+				goto finish_check_dentry;
+			}
+		} else
+			goto finish_check_dentry;
+
+		if (req_flags & SSDFS_BTREE_SEARCH_HAS_VALID_NAME) {
+			name_len = dentry->name_len;
+
+			res = strncmp(req_name, search->name.str,
+					name_len);
+			if (res < 0) {
+				/* hash collision case */
+				err = -ENODATA;
+				search->result.err = -ENODATA;
+				search->result.state =
+					SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND;
+				goto finish_check_dentry;
+			} else if (res == 0) {
+				search->result.state =
+					SSDFS_BTREE_SEARCH_VALID_ITEM;
+				goto finish_check_dentry;
+			} else {
+				/* hash collision case */
+				/* continue the search */
+				err = -EAGAIN;
+				goto finish_check_dentry;
+			}
+		}
+	}
+
+finish_check_dentry:
+	return err;
+}
+
+/*
+ * ssdfs_dentries_tree_find_inline_dentry() - find inline dentry
+ * @tree: btree object
+ * @search: search object
+ *
+ * This method tries to find an inline dentry.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - possible place was found.
+ */
+static int
+ssdfs_dentries_tree_find_inline_dentry(struct ssdfs_dentries_btree_info *tree,
+					struct ssdfs_btree_search *search)
+{
+	s64 dentries_count;
+	u32 req_flags;
+	s64 i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !tree->fsi || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p\n",
+		  tree, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (atomic_read(&tree->type) != SSDFS_INLINE_DENTRIES_ARRAY) {
+		SSDFS_ERR("invalid tree type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	ssdfs_btree_search_free_result_buf(search);
+
+	dentries_count = atomic64_read(&tree->dentries_count);
+
+	if (dentries_count < 0) {
+		SSDFS_ERR("invalid dentries_count %lld\n",
+			  dentries_count);
+		return -ERANGE;
+	} else if (dentries_count == 0) {
+		SSDFS_DBG("empty tree\n");
+		search->result.state = SSDFS_BTREE_SEARCH_OUT_OF_RANGE;
+		search->result.err = -ENODATA;
+		search->result.start_index = 0;
+		search->result.count = 0;
+		search->result.search_cno = ssdfs_current_cno(tree->fsi->sb);
+		search->result.buf_state =
+				SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE;
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+		search->result.buf = NULL;
+		search->result.buf_size = 0;
+		search->result.items_in_buffer = 0;
+		return -ENODATA;
+	} else if (dentries_count > SSDFS_INLINE_DENTRIES_COUNT) {
+		SSDFS_ERR("invalid dentries_count %lld\n",
+			  dentries_count);
+		return -ERANGE;
+	}
+
+	if (!tree->inline_dentries) {
+		SSDFS_ERR("inline dentries haven't been initialized\n");
+		return -ERANGE;
+	}
+
+	req_flags = search->request.flags;
+
+	for (i = 0; i < dentries_count; i++) {
+		struct ssdfs_dir_entry *dentry;
+		u64 hash_code;
+		u64 ino;
+		u8 type;
+		u8 flags;
+		u8 name_len;
+
+		search->result.buf = NULL;
+		search->result.state = SSDFS_BTREE_SEARCH_UNKNOWN_RESULT;
+
+		dentry = &tree->inline_dentries[i];
+		hash_code = le64_to_cpu(dentry->hash_code);
+		ino = le64_to_cpu(dentry->ino);
+		type = dentry->dentry_type;
+		flags = dentry->flags;
+		name_len = dentry->name_len;
+
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("i %llu, hash_code %llx, ino %llu, "
+			  "type %#x, flags %#x, name_len %u\n",
+			  (u64)i, hash_code, ino, type, flags, name_len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		if (type != SSDFS_INLINE_DENTRY) {
+			SSDFS_ERR("corrupted dentry: "
+				  "hash_code %llx, ino %llu, "
+				  "type %#x, flags %#x\n",
+				  hash_code, ino,
+				  type, flags);
+			atomic_set(&tree->state,
+				   SSDFS_DENTRIES_BTREE_CORRUPTED);
+			return -ERANGE;
+		}
+
+		if (flags & ~SSDFS_DENTRY_FLAGS_MASK) {
+			SSDFS_ERR("corrupted dentry: "
+				  "hash_code %llx, ino %llu, "
+				  "type %#x, flags %#x\n",
+				  hash_code, ino,
+				  type, flags);
+			atomic_set(&tree->state,
+				   SSDFS_DENTRIES_BTREE_CORRUPTED);
+			return -ERANGE;
+		}
+
+		if (hash_code >= U64_MAX || ino >= U64_MAX) {
+			SSDFS_ERR("corrupted dentry: "
+				  "hash_code %llx, ino %llu, "
+				  "type %#x, flags %#x\n",
+				  hash_code, ino,
+				  type, flags);
+			atomic_set(&tree->state,
+				   SSDFS_DENTRIES_BTREE_CORRUPTED);
+			return -ERANGE;
+		}
+
+		if (!(req_flags & SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE)) {
+			SSDFS_ERR("invalid request: hash is absent\n");
+			return -ERANGE;
+		}
+
+		ssdfs_memcpy(&search->raw.dentry.header,
+			     0, sizeof(struct ssdfs_dir_entry),
+			     dentry,
+			     0, sizeof(struct ssdfs_dir_entry),
+			     sizeof(struct ssdfs_dir_entry));
+
+		search->result.err = 0;
+		search->result.start_index = (u16)i;
+		search->result.count = 1;
+		search->result.search_cno = ssdfs_current_cno(tree->fsi->sb);
+		search->result.buf_state = SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+		search->result.buf = &search->raw.dentry;
+		search->result.buf_size = sizeof(struct ssdfs_dir_entry);
+		search->result.items_in_buffer = 1;
+
+		err = ssdfs_check_dentry_for_request(tree->fsi, dentry, search);
+		if (err == -ENODATA)
+			goto finish_search_inline_dentry;
+		else if (err == -EAGAIN)
+			continue;
+		else if (unlikely(err)) {
+			SSDFS_ERR("fail to check dentry: err %d\n", err);
+			goto finish_search_inline_dentry;
+		} else {
+			search->result.state =
+				SSDFS_BTREE_SEARCH_VALID_ITEM;
+			goto finish_search_inline_dentry;
+		}
+	}
+
+	err = -ENODATA;
+	search->result.err = -ENODATA;
+	search->result.start_index = dentries_count;
+	search->result.state = SSDFS_BTREE_SEARCH_OUT_OF_RANGE;
+
+finish_search_inline_dentry:
+	return err;
+}
+
+/*
+ * __ssdfs_dentries_tree_find() - find a dentry in the tree
+ * @tree: dentries tree
+ * @search: search object
+ *
+ * This method tries to find a dentry in the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - item hasn't been found
+ */
+static
+int __ssdfs_dentries_tree_find(struct ssdfs_dentries_btree_info *tree,
+				struct ssdfs_btree_search *search)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+
+	SSDFS_DBG("tree %p, search %p\n",
+		  tree, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_CREATED:
+	case SSDFS_DENTRIES_BTREE_INITIALIZED:
+	case SSDFS_DENTRIES_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_DENTRIES_ARRAY:
+		down_read(&tree->lock);
+		err = ssdfs_dentries_tree_find_inline_dentry(tree, search);
+		up_read(&tree->lock);
+
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find the inline dentry: "
+				  "hash %llx\n",
+				  search->request.start.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find the inline dentry: "
+				  "hash %llx, err %d\n",
+				  search->request.start.hash, err);
+		}
+		break;
+
+	case SSDFS_PRIVATE_DENTRIES_BTREE:
+		down_read(&tree->lock);
+		err = ssdfs_btree_find_item(tree->generic_tree, search);
+		up_read(&tree->lock);
+
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find the dentry: "
+				  "hash %llx\n",
+				  search->request.start.hash);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find the dentry: "
+				  "hash %llx, err %d\n",
+				  search->request.start.hash, err);
+		}
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid dentries tree type %#x\n",
+			  atomic_read(&tree->type));
+		break;
+	}
+
+	ssdfs_debug_dentries_btree_object(tree);
+
+	return err;
+}
+
+/*
+ * ssdfs_dentries_tree_find() - find a dentry in the tree
+ * @tree: dentries tree
+ * @name: name string
+ * @len: length of the string
+ * @search: search object
+ *
+ * This method tries to find a dentry for the requested @name.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - item hasn't been found
+ */
+int ssdfs_dentries_tree_find(struct ssdfs_dentries_btree_info *tree,
+			     const char *name, size_t len,
+			     struct ssdfs_btree_search *search)
+{
+	u64 name_hash;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !name || !search);
+
+	SSDFS_DBG("tree %p, name %s, len %zu, search %p\n",
+		  tree, name, len, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+
+	name_hash = __ssdfs_generate_name_hash(name, len,
+					SSDFS_DENTRY_INLINE_NAME_MAX_LEN);
+	if (name_hash == U64_MAX) {
+		SSDFS_ERR("fail to generate name hash\n");
+		return -ERANGE;
+	}
+
+	if (need_initialize_dentries_btree_search(name_hash, search)) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+		search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT |
+			SSDFS_BTREE_SEARCH_HAS_VALID_NAME;
+		search->request.start.hash = name_hash;
+		search->request.start.name = name;
+		search->request.start.name_len = len;
+		search->request.end.hash = name_hash;
+		search->request.end.name = name;
+		search->request.end.name_len = len;
+		search->request.count = 1;
+	}
+
+	return __ssdfs_dentries_tree_find(tree, search);
+}
+
+/*
+ * ssdfs_dentries_tree_find_leaf_node() - find a leaf node in the tree
+ * @tree: dentries tree
+ * @name_hash: name hash
+ * @search: search object
+ *
+ * This method tries to find a leaf node for the requested @name_hash.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_dentries_tree_find_leaf_node(struct ssdfs_dentries_btree_info *tree,
+					u64 name_hash,
+					struct ssdfs_btree_search *search)
+{
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+
+	SSDFS_DBG("tree %p, name_hash %llx, search %p\n",
+		  tree, name_hash, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+
+	if (need_initialize_dentries_btree_search(name_hash, search)) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+		search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT;
+		search->request.start.hash = name_hash;
+		search->request.start.name = NULL;
+		search->request.start.name_len = 0;
+		search->request.end.hash = name_hash;
+		search->request.end.name = NULL;
+		search->request.end.name_len = 0;
+		search->request.count = 1;
+	}
+
+	err = __ssdfs_dentries_tree_find(tree, search);
+	if (err == -ENODATA) {
+		switch (search->result.state) {
+		case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+		case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+		case SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE:
+			/* expected state */
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("unexpected result's state %#x\n",
+				  search->result.state);
+			goto finish_find_leaf_node;
+		}
+
+		switch (atomic_read(&tree->type)) {
+		case SSDFS_INLINE_DENTRIES_ARRAY:
+			/* do nothing */
+			break;
+
+		case SSDFS_PRIVATE_DENTRIES_BTREE:
+			switch (search->node.state) {
+			case SSDFS_BTREE_SEARCH_FOUND_LEAF_NODE_DESC:
+			case SSDFS_BTREE_SEARCH_FOUND_INDEX_NODE_DESC:
+				/* expected state */
+				err = 0;
+				break;
+
+			default:
+				err = -ERANGE;
+				SSDFS_ERR("unexpected node state %#x\n",
+					  search->node.state);
+				break;
+			}
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid dentries tree type %#x\n",
+				  atomic_read(&tree->type));
+			break;
+		}
+	}
+
+finish_find_leaf_node:
+	return err;
+}
+
+/*
+ * can_name_be_inline() - check that name can be inline
+ * @str: string descriptor
+ */
+static inline
+bool can_name_be_inline(const struct qstr *str)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!str || !str->name);
+
+	SSDFS_DBG("name %s, len %u\n",
+		  str->name, str->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return str->len <= SSDFS_DENTRY_INLINE_NAME_MAX_LEN;
+}
+
+/*
+ * ssdfs_prepare_dentry() - prepare dentry object
+ * @str: string descriptor
+ * @ii: inode descriptor
+ * @dentry_type: dentry type
+ * @search: search object
+ *
+ * This method tries to prepare a dentry for adding into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_prepare_dentry(const struct qstr *str,
+			 struct ssdfs_inode_info *ii,
+			 int dentry_type,
+			 struct ssdfs_btree_search *search)
+{
+	struct ssdfs_raw_dentry *dentry;
+	u64 name_hash;
+	u32 copy_len;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!str || !str->name || !ii || !search);
+
+	SSDFS_DBG("name %s, len %u, ino %lu\n",
+		  str->name, str->len, ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (dentry_type <= SSDFS_DENTRIES_BTREE_UNKNOWN_TYPE ||
+	    dentry_type >= SSDFS_DENTRIES_BTREE_TYPE_MAX) {
+		SSDFS_ERR("invalid dentry type %#x\n",
+			  dentry_type);
+		return -EINVAL;
+	}
+
+	name_hash = ssdfs_generate_name_hash(str);
+	if (name_hash == U64_MAX) {
+		SSDFS_ERR("fail to generate name hash\n");
+		return -ERANGE;
+	}
+
+	switch (search->result.buf_state) {
+	case SSDFS_BTREE_SEARCH_UNKNOWN_BUFFER_STATE:
+		search->result.buf_state = SSDFS_BTREE_SEARCH_INLINE_BUFFER;
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(search->result.buf);
+#endif /* CONFIG_SSDFS_DEBUG */
+		search->result.buf = &search->raw.dentry;
+		search->result.buf_size = sizeof(struct ssdfs_raw_dentry);
+		search->result.items_in_buffer = 1;
+		break;
+
+	case SSDFS_BTREE_SEARCH_INLINE_BUFFER:
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(!search->result.buf);
+		BUG_ON(search->result.buf_size !=
+			sizeof(struct ssdfs_raw_dentry));
+		BUG_ON(search->result.items_in_buffer != 1);
+#endif /* CONFIG_SSDFS_DEBUG */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected buffer state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	dentry = &search->raw.dentry;
+
+	dentry->header.ino = cpu_to_le64(ii->vfs_inode.i_ino);
+	dentry->header.hash_code = cpu_to_le64(name_hash);
+	dentry->header.flags = 0;
+
+	if (str->len > SSDFS_MAX_NAME_LEN) {
+		SSDFS_ERR("invalid name_len %u\n",
+			  str->len);
+		return -ERANGE;
+	}
+
+	dentry->header.dentry_type = (u8)dentry_type;
+	ssdfs_set_file_type(&dentry->header, &ii->vfs_inode);
+
+	if (str->len > SSDFS_DENTRY_INLINE_NAME_MAX_LEN)
+		dentry->header.flags |= SSDFS_DENTRY_HAS_EXTERNAL_STRING;
+
+	dentry->header.name_len = (u8)str->len;
+
+	memset(dentry->header.inline_string, 0,
+		SSDFS_DENTRY_INLINE_NAME_MAX_LEN);
+	copy_len = min_t(u32, (u32)str->len, SSDFS_DENTRY_INLINE_NAME_MAX_LEN);
+	ssdfs_memcpy(dentry->header.inline_string,
+		     0, SSDFS_DENTRY_INLINE_NAME_MAX_LEN,
+		     str->name, 0, str->len,
+		     copy_len);
+
+	memset(search->name.str, 0, SSDFS_MAX_NAME_LEN);
+	search->name.len = (u8)str->len;
+	ssdfs_memcpy(search->name.str, 0, SSDFS_MAX_NAME_LEN,
+		     str->name, 0, str->len,
+		     str->len);
+
+	search->request.flags |= SSDFS_BTREE_SEARCH_INLINE_BUF_HAS_NEW_ITEM;
+
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_tree_add_inline_dentry() - add inline dentry into the tree
+ * @tree: dentries tree
+ * @search: search object
+ *
+ * This method tries to add the inline dentry into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOSPC     - inline tree hasn't room for the new dentry.
+ * %-EEXIST     - dentry exists in the tree.
+ */
+static int
+ssdfs_dentries_tree_add_inline_dentry(struct ssdfs_dentries_btree_info *tree,
+					struct ssdfs_btree_search *search)
+{
+	struct ssdfs_dir_entry *cur;
+	size_t dentry_size = sizeof(struct ssdfs_dir_entry);
+	s64 dentries_count, dentries_capacity;
+	int private_flags;
+	u64 hash1, hash2;
+	u64 ino1, ino2;
+	u16 start_index;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p\n",
+		  tree, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_DENTRIES_ARRAY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_CREATED:
+	case SSDFS_DENTRIES_BTREE_INITIALIZED:
+	case SSDFS_DENTRIES_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	if (!tree->inline_dentries) {
+		SSDFS_ERR("empty inline tree %p\n",
+			  tree->inline_dentries);
+		return -ERANGE;
+	}
+
+	dentries_count = atomic64_read(&tree->dentries_count);
+
+	if (!tree->owner) {
+		SSDFS_ERR("empty owner inode\n");
+		return -ERANGE;
+	}
+
+	private_flags = atomic_read(&tree->owner->private_flags);
+
+	dentries_capacity = SSDFS_INLINE_DENTRIES_COUNT;
+	if (private_flags & SSDFS_INODE_HAS_XATTR_BTREE)
+		dentries_capacity -= SSDFS_INLINE_DENTRIES_PER_AREA;
+	if (private_flags & SSDFS_INODE_HAS_DENTRIES_BTREE) {
+		SSDFS_ERR("the dentries tree is generic\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("dentries_count %lld, dentries_capacity %lld\n",
+		  dentries_count, dentries_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (dentries_count > dentries_capacity) {
+		SSDFS_WARN("dentries tree is corrupted: "
+			   "dentries_count %lld, dentries_capacity %lld\n",
+			   dentries_count, dentries_capacity);
+		atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_CORRUPTED);
+		return -ERANGE;
+	} else if (dentries_count == dentries_capacity) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("inline tree hasn't room for the new dentry: "
+			  "dentries_count %lld, dentries_capacity %lld\n",
+			  dentries_count, dentries_capacity);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENOSPC;
+	}
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+	case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid search result's state %#x, "
+			  "start_index %u\n",
+			  search->result.state,
+			  search->result.start_index);
+		return -ERANGE;
+	}
+
+	if (search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER) {
+		SSDFS_ERR("invalid buf_state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	hash1 = search->request.start.hash;
+	ino1 = search->request.start.ino;
+	hash2 = le64_to_cpu(search->raw.dentry.header.hash_code);
+	ino2 = le64_to_cpu(search->raw.dentry.header.ino);
+
+	if (hash1 != hash2 || ino1 != ino2) {
+		SSDFS_ERR("corrupted dentry: "
+			  "request (hash %llx, ino %llu), "
+			  "dentry (hash %llx, ino %llu)\n",
+			  hash1, ino1, hash2, ino2);
+		return -ERANGE;
+	}
+
+	start_index = search->result.start_index;
+
+	if (dentries_count == 0) {
+		if (start_index != 0) {
+			SSDFS_ERR("invalid start_index %u\n",
+				  start_index);
+			return -ERANGE;
+		}
+
+		cur = &tree->inline_dentries[start_index];
+		ssdfs_memcpy(cur, 0, dentry_size,
+			     &search->raw.dentry.header, 0, dentry_size,
+			     dentry_size);
+	} else {
+		if (start_index >= dentries_capacity) {
+			SSDFS_ERR("start_index %u >= dentries_capacity %lld\n",
+				  start_index, dentries_capacity);
+			return -ERANGE;
+		}
+
+		cur = &tree->inline_dentries[start_index];
+
+		if ((start_index + 1) <= dentries_count) {
+			err = ssdfs_memmove(tree->inline_dentries,
+					    (start_index + 1) * dentry_size,
+					    ssdfs_inline_dentries_size(),
+					    tree->inline_dentries,
+					    start_index * dentry_size,
+					    ssdfs_inline_dentries_size(),
+					    (dentries_count - start_index) *
+						dentry_size);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to move: err %d\n", err);
+				return err;
+			}
+
+			ssdfs_memcpy(cur, 0, dentry_size,
+				     &search->raw.dentry.header, 0, dentry_size,
+				     dentry_size);
+
+			hash1 = le64_to_cpu(cur->hash_code);
+			ino1 = le64_to_cpu(cur->ino);
+
+			cur = &tree->inline_dentries[start_index + 1];
+
+			hash2 = le64_to_cpu(cur->hash_code);
+			ino2 = le64_to_cpu(cur->ino);
+		} else {
+			ssdfs_memcpy(cur, 0, dentry_size,
+				     &search->raw.dentry.header, 0, dentry_size,
+				     dentry_size);
+
+			if (start_index > 0) {
+				hash2 = le64_to_cpu(cur->hash_code);
+				ino2 = le64_to_cpu(cur->ino);
+
+				cur =
+				    &tree->inline_dentries[start_index - 1];
+
+				hash1 = le64_to_cpu(cur->hash_code);
+				ino1 = le64_to_cpu(cur->ino);
+			}
+		}
+
+		if (hash1 < hash2) {
+			/*
+			 * Correct order. Do nothing.
+			 */
+		} else if (hash1 == hash2) {
+			if (ino1 < ino2) {
+				/*
+				 * Correct order. Do nothing.
+				 */
+			} else if (ino1 < ino2) {
+				SSDFS_ERR("duplicated dentry: "
+					  "hash1 %llx, ino1 %llu, "
+					  "hash2 %llx, ino2 %llu\n",
+					  hash1, ino1, hash2, ino2);
+				atomic_set(&tree->state,
+					SSDFS_DENTRIES_BTREE_CORRUPTED);
+				return -ERANGE;
+			} else {
+				SSDFS_ERR("invalid dentries oredring: "
+					  "hash1 %llx, ino1 %llu, "
+					  "hash2 %llx, ino2 %llu\n",
+					  hash1, ino1, hash2, ino2);
+				atomic_set(&tree->state,
+					SSDFS_DENTRIES_BTREE_CORRUPTED);
+				return -ERANGE;
+			}
+		} else {
+			SSDFS_ERR("invalid hash order: "
+				  "hash1 %llx > hash2 %llx\n",
+				  hash1, hash2);
+			atomic_set(&tree->state,
+				    SSDFS_DENTRIES_BTREE_CORRUPTED);
+			return -ERANGE;
+		}
+	}
+
+	dentries_count = atomic64_inc_return(&tree->dentries_count);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("dentries_count %llu\n",
+		  atomic64_read(&tree->dentries_count));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (dentries_count > dentries_capacity) {
+		SSDFS_WARN("dentries_count is too much: "
+			   "count %lld, capacity %lld\n",
+			   dentries_count, dentries_capacity);
+		atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_CORRUPTED);
+		return -ERANGE;
+	}
+
+	atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_DIRTY);
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_tree_add_dentry() - add the dentry into the tree
+ * @tree: dentries tree
+ * @search: search object
+ *
+ * This method tries to add the generic dentry into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - dentry exists in the tree.
+ */
+static
+int ssdfs_dentries_tree_add_dentry(struct ssdfs_dentries_btree_info *tree,
+				   struct ssdfs_btree_search *search)
+{
+	u64 hash1, hash2;
+	u64 ino1, ino2;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p\n",
+		  tree, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_PRIVATE_DENTRIES_BTREE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_CREATED:
+	case SSDFS_DENTRIES_BTREE_INITIALIZED:
+	case SSDFS_DENTRIES_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	if (!tree->generic_tree) {
+		SSDFS_ERR("empty generic tree %p\n",
+			  tree->generic_tree);
+		return -ERANGE;
+	}
+
+	switch (search->result.state) {
+	case SSDFS_BTREE_SEARCH_POSSIBLE_PLACE_FOUND:
+	case SSDFS_BTREE_SEARCH_OUT_OF_RANGE:
+	case SSDFS_BTREE_SEARCH_PLEASE_ADD_NODE:
+	case SSDFS_BTREE_SEARCH_OBSOLETE_RESULT:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid search result's state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER) {
+		SSDFS_ERR("invalid buf_state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	hash1 = search->request.start.hash;
+	ino1 = search->request.start.ino;
+	hash2 = le64_to_cpu(search->raw.dentry.header.hash_code);
+	ino2 = le64_to_cpu(search->raw.dentry.header.ino);
+
+	if (hash1 != hash2 || ino1 != ino2) {
+		SSDFS_ERR("corrupted dentry: "
+			  "request (hash %llx, ino %llu), "
+			  "dentry (hash %llx, ino %llu)\n",
+			  hash1, ino1, hash2, ino2);
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_add_item(tree->generic_tree, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to add the dentry into the tree: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	err = ssdfs_btree_synchronize_root_node(tree->generic_tree,
+						tree->root);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to synchronize the root node: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_DIRTY);
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_tree_add() - add dentry into the tree
+ * @tree: dentries tree
+ * @str: name of the file/folder
+ * @ii: inode info
+ * @search: search object
+ *
+ * This method tries to add dentry into the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EEXIST     - dentry exists in the tree.
+ */
+int ssdfs_dentries_tree_add(struct ssdfs_dentries_btree_info *tree,
+			    const struct qstr *str,
+			    struct ssdfs_inode_info *ii,
+			    struct ssdfs_btree_search *search)
+{
+	struct ssdfs_shared_dict_btree_info *dict;
+	u64 name_hash;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !str || !ii || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, ii %p, ino %lu\n",
+		  tree, ii, ii->vfs_inode.i_ino);
+#else
+	SSDFS_DBG("tree %p, ii %p, ino %lu\n",
+		  tree, ii, ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	dict = tree->fsi->shdictree;
+	if (!dict) {
+		SSDFS_ERR("shared dictionary is absent\n");
+		return -ERANGE;
+	}
+
+	search->request.type = SSDFS_BTREE_SEARCH_ADD_ITEM;
+
+	name_hash = ssdfs_generate_name_hash(str);
+	if (name_hash == U64_MAX) {
+		SSDFS_ERR("fail to generate name hash\n");
+		return -ERANGE;
+	}
+
+	if (need_initialize_dentries_btree_search(name_hash, search)) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_ADD_ITEM;
+		search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT |
+			SSDFS_BTREE_SEARCH_HAS_VALID_NAME |
+			SSDFS_BTREE_SEARCH_HAS_VALID_INO;
+		search->request.start.hash = name_hash;
+		search->request.start.name = str->name;
+		search->request.start.name_len = str->len;
+		search->request.start.ino = ii->vfs_inode.i_ino;
+		search->request.end.hash = name_hash;
+		search->request.end.name = str->name;
+		search->request.end.name_len = str->len;
+		search->request.end.ino = ii->vfs_inode.i_ino;
+		search->request.count = 1;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_CREATED:
+	case SSDFS_DENTRIES_BTREE_INITIALIZED:
+	case SSDFS_DENTRIES_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_DENTRIES_ARRAY:
+		down_write(&tree->lock);
+
+		err = ssdfs_dentries_tree_find_inline_dentry(tree, search);
+		if (err == -ENODATA) {
+			/*
+			 * Dentry doesn't exist for requested name hash.
+			 * It needs to create a new dentry.
+			 */
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find the inline dentry: "
+				  "name_hash %llx, err %d\n",
+				  name_hash, err);
+			goto finish_add_inline_dentry;
+		}
+
+		if (err == -ENODATA) {
+			err = ssdfs_prepare_dentry(str, ii,
+						   SSDFS_INLINE_DENTRY,
+						   search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare the dentry: "
+					  "name_hash %llx, ino %lu, "
+					  "err %d\n",
+					  name_hash,
+					  ii->vfs_inode.i_ino,
+					  err);
+				goto finish_add_inline_dentry;
+			}
+
+			search->request.type = SSDFS_BTREE_SEARCH_ADD_ITEM;
+			err = ssdfs_dentries_tree_add_inline_dentry(tree,
+								    search);
+			if (err == -ENOSPC) {
+				err = ssdfs_migrate_inline2generic_tree(tree);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to migrate the tree: "
+						  "err %d\n",
+						  err);
+					goto finish_add_inline_dentry;
+				} else {
+					search->request.type =
+						SSDFS_BTREE_SEARCH_ADD_ITEM;
+					downgrade_write(&tree->lock);
+					goto try_to_add_into_generic_tree;
+				}
+			} else if (unlikely(err)) {
+				SSDFS_ERR("fail to add the dentry: "
+					  "name_hash %llx, ino %lu, "
+					  "err %d\n",
+					  name_hash,
+					  ii->vfs_inode.i_ino,
+					  err);
+				goto finish_add_inline_dentry;
+			}
+
+			if (!can_name_be_inline(str)) {
+				err = ssdfs_shared_dict_save_name(dict,
+								  name_hash,
+								  str);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to store name: "
+						  "hash %llx, err %d\n",
+						  name_hash, err);
+					goto finish_add_inline_dentry;
+				}
+			}
+		} else {
+			err = -EEXIST;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("dentry exists in the tree: "
+				  "name_hash %llx, ino %lu\n",
+				  name_hash, ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_add_inline_dentry;
+		}
+
+finish_add_inline_dentry:
+		up_write(&tree->lock);
+		break;
+
+	case SSDFS_PRIVATE_DENTRIES_BTREE:
+		down_read(&tree->lock);
+try_to_add_into_generic_tree:
+		err = ssdfs_btree_find_item(tree->generic_tree, search);
+		if (err == -ENODATA) {
+			/*
+			 * Dentry doesn't exist for requested name.
+			 * It needs to create a new dentry.
+			 */
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find the dentry: "
+				  "name_hash %llx, ino %lu, "
+				  "err %d\n",
+				  name_hash,
+				  ii->vfs_inode.i_ino,
+				  err);
+			goto finish_add_generic_dentry;
+		}
+
+		if (err == -ENODATA) {
+			err = ssdfs_prepare_dentry(str, ii,
+						   SSDFS_REGULAR_DENTRY,
+						   search);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to prepare the dentry: "
+					  "name_hash %llx, ino %lu, "
+					  "err %d\n",
+					  name_hash,
+					  ii->vfs_inode.i_ino,
+					  err);
+				goto finish_add_generic_dentry;
+			}
+
+			search->request.type = SSDFS_BTREE_SEARCH_ADD_ITEM;
+			err = ssdfs_dentries_tree_add_dentry(tree, search);
+
+			ssdfs_btree_search_forget_parent_node(search);
+			ssdfs_btree_search_forget_child_node(search);
+
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to add the dentry: "
+					  "name_hash %llx, ino %lu, "
+					  "err %d\n",
+					  name_hash,
+					  ii->vfs_inode.i_ino,
+					  err);
+				goto finish_add_generic_dentry;
+			}
+
+			if (!can_name_be_inline(str)) {
+				err = ssdfs_shared_dict_save_name(dict,
+								  name_hash,
+								  str);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to store name: "
+						  "hash %llx, err %d\n",
+						  name_hash, err);
+					goto finish_add_generic_dentry;
+				}
+			}
+		} else {
+			err = -EEXIST;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("dentry exists in the tree: "
+				  "name_hash %llx, ino %lu\n",
+				  name_hash, ii->vfs_inode.i_ino);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_add_generic_dentry;
+		}
+
+finish_add_generic_dentry:
+		up_read(&tree->lock);
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_dentries_btree_object(tree);
+
+	return err;
+}
+
+/*
+ * ssdfs_change_dentry() - change a dentry
+ * @str: string descriptor
+ * @new_ii: new inode info
+ * @dentry_type: dentry type
+ * @search: search object
+ *
+ * This method tries to prepare a new state of the dentry object.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_change_dentry(const struct qstr *str,
+			struct ssdfs_inode_info *new_ii,
+			int dentry_type,
+			struct ssdfs_btree_search *search)
+{
+	struct ssdfs_raw_dentry *dentry;
+	ino_t ino;
+	u64 name_hash;
+	u32 copy_len;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!str || !str->name || !new_ii || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ino = new_ii->vfs_inode.i_ino;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("name %s, len %u, ino %lu\n",
+		  str->name, str->len, ino);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (dentry_type <= SSDFS_DENTRIES_BTREE_UNKNOWN_TYPE ||
+	    dentry_type >= SSDFS_DENTRIES_BTREE_TYPE_MAX) {
+		SSDFS_ERR("invalid dentry type %#x\n",
+			  dentry_type);
+		return -EINVAL;
+	}
+
+	name_hash = ssdfs_generate_name_hash(str);
+	if (name_hash == U64_MAX) {
+		SSDFS_ERR("fail to generate name hash\n");
+		return -ERANGE;
+	}
+
+	if (search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER ||
+	    !search->result.buf ||
+	    search->result.buf_size != sizeof(struct ssdfs_raw_dentry)) {
+		SSDFS_ERR("invalid buffer state: "
+			  "state %#x, buf %p\n",
+			  search->result.buf_state,
+			  search->result.buf);
+		return -ERANGE;
+	}
+
+	dentry = &search->raw.dentry;
+
+	if (ino != le64_to_cpu(dentry->header.ino)) {
+		SSDFS_ERR("invalid ino: "
+			  "ino1 %lu != ino2 %llu\n",
+			 ino,
+			 le64_to_cpu(dentry->header.ino));
+		return -ERANGE;
+	}
+
+	dentry->header.hash_code = cpu_to_le64(name_hash);
+	dentry->header.flags = 0;
+
+	dentry->header.dentry_type = (u8)dentry_type;
+	ssdfs_set_file_type(&dentry->header, &new_ii->vfs_inode);
+
+	if (str->len > SSDFS_MAX_NAME_LEN) {
+		SSDFS_ERR("invalid name_len %u\n",
+			  str->len);
+		return -ERANGE;
+	}
+
+	if (str->len > SSDFS_DENTRY_INLINE_NAME_MAX_LEN)
+		dentry->header.flags |= SSDFS_DENTRY_HAS_EXTERNAL_STRING;
+
+	dentry->header.name_len = (u8)str->len;
+
+	memset(dentry->header.inline_string, 0,
+		SSDFS_DENTRY_INLINE_NAME_MAX_LEN);
+	copy_len = min_t(u32, (u32)str->len, SSDFS_DENTRY_INLINE_NAME_MAX_LEN);
+	ssdfs_memcpy(dentry->header.inline_string,
+		     0, SSDFS_DENTRY_INLINE_NAME_MAX_LEN,
+		     str->name, 0, str->len,
+		     copy_len);
+
+	memset(search->name.str, 0, SSDFS_MAX_NAME_LEN);
+	search->name.len = (u8)str->len;
+	ssdfs_memcpy(search->name.str, 0, SSDFS_MAX_NAME_LEN,
+		     str->name, 0, str->len,
+		     str->len);
+
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_tree_change_inline_dentry() - change inline dentry
+ * @tree: dentries tree
+ * @search: search object
+ *
+ * This method tries to change the existing inline dentry.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - dentry doesn't exist in the tree.
+ */
+static int
+ssdfs_dentries_tree_change_inline_dentry(struct ssdfs_dentries_btree_info *tree,
+					 struct ssdfs_btree_search *search)
+{
+	struct ssdfs_dir_entry *cur;
+	size_t dentry_size = sizeof(struct ssdfs_dir_entry);
+	u64 hash1, hash2;
+	u64 ino1, ino2;
+	int private_flags;
+	s64 dentries_count, dentries_capacity;
+	u16 start_index;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p\n",
+		  tree, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_DENTRIES_ARRAY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_CREATED:
+	case SSDFS_DENTRIES_BTREE_INITIALIZED:
+	case SSDFS_DENTRIES_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	if (!tree->inline_dentries) {
+		SSDFS_ERR("empty inline tree %p\n",
+			  tree->inline_dentries);
+		return -ERANGE;
+	}
+
+	if (search->result.state != SSDFS_BTREE_SEARCH_VALID_ITEM) {
+		SSDFS_ERR("invalid search result's state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER) {
+		SSDFS_ERR("invalid buf_state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	hash1 = search->request.start.hash;
+	ino1 = search->request.start.ino;
+
+	cur = &search->raw.dentry.header;
+	hash2 = le64_to_cpu(cur->hash_code);
+	ino2 = le64_to_cpu(cur->ino);
+
+	if (hash1 != hash2 || ino1 != ino2) {
+		SSDFS_ERR("hash1 %llx, hash2 %llx, "
+			  "ino1 %llu, ino2 %llu\n",
+			  hash1, hash2, ino1, ino2);
+		return -ERANGE;
+	}
+
+	if (!tree->owner) {
+		SSDFS_ERR("empty owner inode\n");
+		return -ERANGE;
+	}
+
+	dentries_count = atomic64_read(&tree->dentries_count);
+	private_flags = atomic_read(&tree->owner->private_flags);
+
+	dentries_capacity = SSDFS_INLINE_DENTRIES_COUNT;
+	if (private_flags & SSDFS_INODE_HAS_XATTR_BTREE)
+		dentries_capacity -= SSDFS_INLINE_DENTRIES_PER_AREA;
+	if (private_flags & SSDFS_INODE_HAS_DENTRIES_BTREE) {
+		SSDFS_ERR("the dentries tree is generic\n");
+		return -ERANGE;
+	}
+
+	if (dentries_count > dentries_capacity) {
+		SSDFS_WARN("dentries tree is corrupted: "
+			   "dentries_count %lld, dentries_capacity %lld\n",
+			   dentries_count, dentries_capacity);
+		atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_CORRUPTED);
+		return -ERANGE;
+	} else if (dentries_count == 0) {
+		SSDFS_DBG("empty tree\n");
+		return -EFAULT;
+	}
+
+	start_index = search->result.start_index;
+
+	if (start_index >= dentries_count) {
+		SSDFS_ERR("start_index %u >= dentries_count %lld\n",
+			  start_index, dentries_count);
+		return -ENODATA;
+	}
+
+	ssdfs_memcpy(tree->inline_dentries,
+		     start_index * dentry_size, ssdfs_inline_dentries_size(),
+		     &search->raw.dentry.header, 0, dentry_size,
+		     dentry_size);
+	atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_DIRTY);
+
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_tree_change_dentry() - change the generic dentry
+ * @tree: dentries tree
+ * @search: search object
+ *
+ * This method tries to change the existing generic dentry.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - dentry doesn't exist in the tree.
+ */
+static
+int ssdfs_dentries_tree_change_dentry(struct ssdfs_dentries_btree_info *tree,
+				      struct ssdfs_btree_search *search)
+{
+	struct ssdfs_raw_dentry *cur;
+	u64 hash1, hash2;
+	u64 ino1, ino2;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+	BUG_ON(!rwsem_is_locked(&tree->lock));
+
+	SSDFS_DBG("tree %p, search %p\n",
+		  tree, search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_PRIVATE_DENTRIES_BTREE:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's type %#x\n",
+			  atomic_read(&tree->type));
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_CREATED:
+	case SSDFS_DENTRIES_BTREE_INITIALIZED:
+	case SSDFS_DENTRIES_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	if (!tree->generic_tree) {
+		SSDFS_ERR("empty generic tree %p\n",
+			  tree->generic_tree);
+		return -ERANGE;
+	}
+
+	if (search->result.state != SSDFS_BTREE_SEARCH_VALID_ITEM) {
+		SSDFS_ERR("invalid search result's state %#x\n",
+			  search->result.state);
+		return -ERANGE;
+	}
+
+	if (search->result.buf_state != SSDFS_BTREE_SEARCH_INLINE_BUFFER) {
+		SSDFS_ERR("invalid buf_state %#x\n",
+			  search->result.buf_state);
+		return -ERANGE;
+	}
+
+	hash1 = search->request.start.hash;
+	ino1 = search->request.start.ino;
+
+	cur = &search->raw.dentry;
+	hash2 = le64_to_cpu(cur->header.hash_code);
+	ino2 = le64_to_cpu(cur->header.ino);
+
+	if (hash1 != hash2 || ino1 != ino2) {
+		SSDFS_ERR("hash1 %llx, hash2 %llx, "
+			  "ino1 %llu, ino2 %llu\n",
+			  hash1, hash2, ino1, ino2);
+		return -ERANGE;
+	}
+
+	err = ssdfs_btree_change_item(tree->generic_tree, search);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to change the dentry into the tree: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	err = ssdfs_btree_synchronize_root_node(tree->generic_tree,
+						tree->root);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to synchronize the root node: "
+			  "err %d\n", err);
+		return err;
+	}
+
+	atomic_set(&tree->state, SSDFS_DENTRIES_BTREE_DIRTY);
+	return 0;
+}
+
+/*
+ * ssdfs_dentries_tree_change() - change dentry in the tree
+ * @tree: dentries tree
+ * @name_hash: hash of the name
+ * @old_ino: old inode ID
+ * @new_str: new name of the file/folder
+ * @new_ii: new inode info
+ * @search: search object
+ *
+ * This method tries to change dentry in the tree.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - dentry doesn't exist in the tree.
+ */
+int ssdfs_dentries_tree_change(struct ssdfs_dentries_btree_info *tree,
+				u64 name_hash, ino_t old_ino,
+				const struct qstr *str,
+				struct ssdfs_inode_info *new_ii,
+				struct ssdfs_btree_search *search)
+{
+	struct ssdfs_shared_dict_btree_info *dict;
+	u64 new_name_hash;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!tree || !search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("tree %p, search %p, name_hash %llx\n",
+		  tree, search, name_hash);
+#else
+	SSDFS_DBG("tree %p, search %p, name_hash %llx\n",
+		  tree, search, name_hash);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	switch (atomic_read(&tree->state)) {
+	case SSDFS_DENTRIES_BTREE_CREATED:
+	case SSDFS_DENTRIES_BTREE_INITIALIZED:
+	case SSDFS_DENTRIES_BTREE_DIRTY:
+		/* expected state */
+		break;
+
+	default:
+		SSDFS_ERR("invalid dentries tree's state %#x\n",
+			  atomic_read(&tree->state));
+		return -ERANGE;
+	};
+
+	dict = tree->fsi->shdictree;
+	if (!dict) {
+		SSDFS_ERR("shared dictionary is absent\n");
+		return -ERANGE;
+	}
+
+	search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+
+	if (need_initialize_dentries_btree_search(name_hash, search)) {
+		ssdfs_btree_search_init(search);
+		search->request.type = SSDFS_BTREE_SEARCH_FIND_ITEM;
+		search->request.flags =
+			SSDFS_BTREE_SEARCH_HAS_VALID_HASH_RANGE |
+			SSDFS_BTREE_SEARCH_HAS_VALID_COUNT |
+			SSDFS_BTREE_SEARCH_HAS_VALID_INO;
+		search->request.start.hash = name_hash;
+		search->request.start.name = NULL;
+		search->request.start.name_len = U32_MAX;
+		search->request.start.ino = old_ino;
+		search->request.end.hash = name_hash;
+		search->request.end.name = NULL;
+		search->request.end.name_len = U32_MAX;
+		search->request.end.ino = old_ino;
+		search->request.count = 1;
+	}
+
+	new_name_hash = ssdfs_generate_name_hash(str);
+	if (new_name_hash == U64_MAX) {
+		SSDFS_ERR("fail to generate name hash\n");
+		return -ERANGE;
+	}
+
+	switch (atomic_read(&tree->type)) {
+	case SSDFS_INLINE_DENTRIES_ARRAY:
+		down_write(&tree->lock);
+
+		err = ssdfs_dentries_tree_find_inline_dentry(tree, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find the inline dentry: "
+				  "name_hash %llx, err %d\n",
+				  name_hash, err);
+			goto finish_change_inline_dentry;
+		}
+
+		err = ssdfs_change_dentry(str, new_ii,
+					  SSDFS_INLINE_DENTRY, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change dentry: err %d\n",
+				  err);
+			goto finish_change_inline_dentry;
+		}
+
+		search->request.type = SSDFS_BTREE_SEARCH_CHANGE_ITEM;
+
+		err = ssdfs_dentries_tree_change_inline_dentry(tree, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change inline dentry: "
+				  "name_hash %llx, err %d\n",
+				  name_hash, err);
+			goto finish_change_inline_dentry;
+		}
+
+		if (!can_name_be_inline(str)) {
+			err = ssdfs_shared_dict_save_name(dict,
+							  new_name_hash,
+							  str);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to store name: "
+					  "hash %llx, err %d\n",
+					  new_name_hash, err);
+				goto finish_change_inline_dentry;
+			}
+		}
+
+finish_change_inline_dentry:
+		up_write(&tree->lock);
+		break;
+
+	case SSDFS_PRIVATE_DENTRIES_BTREE:
+		down_read(&tree->lock);
+
+		err = ssdfs_btree_find_item(tree->generic_tree, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to find the dentry: "
+				  "name_hash %llx, err %d\n",
+				  name_hash, err);
+			goto finish_change_generic_dentry;
+		}
+
+		err = ssdfs_change_dentry(str, new_ii,
+					  SSDFS_REGULAR_DENTRY, search);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change dentry: err %d\n",
+				  err);
+			goto finish_change_generic_dentry;
+		}
+
+		search->request.type = SSDFS_BTREE_SEARCH_CHANGE_ITEM;
+
+		err = ssdfs_dentries_tree_change_dentry(tree, search);
+
+		ssdfs_btree_search_forget_parent_node(search);
+		ssdfs_btree_search_forget_child_node(search);
+
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change dentry: "
+				  "name_hash %llx, err %d\n",
+				  name_hash, err);
+			goto finish_change_generic_dentry;
+		}
+
+		if (!can_name_be_inline(str)) {
+			err = ssdfs_shared_dict_save_name(dict,
+							  new_name_hash,
+							  str);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to store name: "
+					  "hash %llx, err %d\n",
+					  new_name_hash, err);
+				goto finish_change_generic_dentry;
+			}
+		}
+
+finish_change_generic_dentry:
+		up_read(&tree->lock);
+		break;
+
+	default:
+		err = -ERANGE;
+		SSDFS_ERR("invalid dentries tree type %#x\n",
+			  atomic_read(&tree->type));
+		break;
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	ssdfs_debug_dentries_btree_object(tree);
+
+	return err;
+}
diff --git a/fs/ssdfs/dentries_tree.h b/fs/ssdfs/dentries_tree.h
new file mode 100644
index 000000000000..fb2168d511f8
--- /dev/null
+++ b/fs/ssdfs/dentries_tree.h
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/dentries_tree.h - dentries btree declarations.
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
+#ifndef _SSDFS_DENTRIES_TREE_H
+#define _SSDFS_DENTRIES_TREE_H
+
+#define SSDFS_INLINE_DENTRIES_COUNT	(2 * SSDFS_INLINE_DENTRIES_PER_AREA)
+
+/*
+ * struct ssdfs_dentries_btree_info - dentries btree info
+ * @type: dentries btree type
+ * @state: dentries btree state
+ * @dentries_count: count of the dentries in the whole dentries tree
+ * @lock: dentries btree lock
+ * @generic_tree: pointer on generic btree object
+ * @inline_dentries: pointer on inline dentries array
+ * @buffer.tree: piece of memory for generic btree object
+ * @buffer.dentries: piece of memory for the inline dentries
+ * @root: pointer on root node
+ * @root_buffer: buffer for root node
+ * @desc: b-tree descriptor
+ * @owner: pointer on owner inode object
+ * @fsi: pointer on shared file system object
+ *
+ * A newly created inode tries to store dentries into inline
+ * dentries. The raw on-disk inode has internal private area
+ * that is able to contain the four inline dentries or
+ * root node of extents btree and extended attributes btree.
+ * If inode hasn't extended attributes and the amount of dentries
+ * are lesser than four then everithing can be stored inside of
+ * inline dentries. Otherwise, the real dentries btree should
+ * be created.
+ */
+struct ssdfs_dentries_btree_info {
+	atomic_t type;
+	atomic_t state;
+	atomic64_t dentries_count;
+
+	struct rw_semaphore lock;
+	struct ssdfs_btree *generic_tree;
+	struct ssdfs_dir_entry *inline_dentries;
+	union {
+		struct ssdfs_btree tree;
+		struct ssdfs_dir_entry dentries[SSDFS_INLINE_DENTRIES_COUNT];
+	} buffer;
+	struct ssdfs_btree_inline_root_node *root;
+	struct ssdfs_btree_inline_root_node root_buffer;
+
+	struct ssdfs_dentries_btree_descriptor desc;
+	struct ssdfs_inode_info *owner;
+	struct ssdfs_fs_info *fsi;
+};
+
+/* Dentries tree types */
+enum {
+	SSDFS_DENTRIES_BTREE_UNKNOWN_TYPE,
+	SSDFS_INLINE_DENTRIES_ARRAY,
+	SSDFS_PRIVATE_DENTRIES_BTREE,
+	SSDFS_DENTRIES_BTREE_TYPE_MAX
+};
+
+/* Dentries tree states */
+enum {
+	SSDFS_DENTRIES_BTREE_UNKNOWN_STATE,
+	SSDFS_DENTRIES_BTREE_CREATED,
+	SSDFS_DENTRIES_BTREE_INITIALIZED,
+	SSDFS_DENTRIES_BTREE_DIRTY,
+	SSDFS_DENTRIES_BTREE_CORRUPTED,
+	SSDFS_DENTRIES_BTREE_STATE_MAX
+};
+
+/*
+ * Inline methods
+ */
+static inline
+size_t ssdfs_inline_dentries_size(void)
+{
+	size_t dentry_size = sizeof(struct ssdfs_dir_entry);
+	return dentry_size * SSDFS_INLINE_DENTRIES_COUNT;
+}
+
+static inline
+size_t ssdfs_area_dentries_size(void)
+{
+	size_t dentry_size = sizeof(struct ssdfs_dir_entry);
+	return dentry_size * SSDFS_INLINE_DENTRIES_PER_AREA;
+}
+
+/*
+ * Dentries tree API
+ */
+int ssdfs_dentries_tree_create(struct ssdfs_fs_info *fsi,
+				struct ssdfs_inode_info *ii);
+int ssdfs_dentries_tree_init(struct ssdfs_fs_info *fsi,
+			     struct ssdfs_inode_info *ii);
+void ssdfs_dentries_tree_destroy(struct ssdfs_inode_info *ii);
+int ssdfs_dentries_tree_flush(struct ssdfs_fs_info *fsi,
+				struct ssdfs_inode_info *ii);
+
+int ssdfs_dentries_tree_find(struct ssdfs_dentries_btree_info *tree,
+			     const char *name, size_t len,
+			     struct ssdfs_btree_search *search);
+int ssdfs_dentries_tree_add(struct ssdfs_dentries_btree_info *tree,
+			    const struct qstr *str,
+			    struct ssdfs_inode_info *ii,
+			    struct ssdfs_btree_search *search);
+int ssdfs_dentries_tree_change(struct ssdfs_dentries_btree_info *tree,
+				u64 name_hash, ino_t old_ino,
+				const struct qstr *str,
+				struct ssdfs_inode_info *new_ii,
+				struct ssdfs_btree_search *search);
+int ssdfs_dentries_tree_delete(struct ssdfs_dentries_btree_info *tree,
+				u64 name_hash, ino_t ino,
+				struct ssdfs_btree_search *search);
+int ssdfs_dentries_tree_delete_all(struct ssdfs_dentries_btree_info *tree);
+
+/*
+ * Internal dentries tree API
+ */
+u64 ssdfs_generate_name_hash(const struct qstr *str);
+int ssdfs_dentries_tree_find_leaf_node(struct ssdfs_dentries_btree_info *tree,
+					u64 name_hash,
+					struct ssdfs_btree_search *search);
+int ssdfs_dentries_tree_extract_range(struct ssdfs_dentries_btree_info *tree,
+				      u16 start_index, u16 count,
+				      struct ssdfs_btree_search *search);
+
+void ssdfs_debug_dentries_btree_object(struct ssdfs_dentries_btree_info *tree);
+
+/*
+ * Dentries btree specialized operations
+ */
+extern const struct ssdfs_btree_descriptor_operations
+						ssdfs_dentries_btree_desc_ops;
+extern const struct ssdfs_btree_operations ssdfs_dentries_btree_ops;
+extern const struct ssdfs_btree_node_operations ssdfs_dentries_btree_node_ops;
+
+#endif /* _SSDFS_DENTRIES_TREE_H */
-- 
2.34.1

