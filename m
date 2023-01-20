Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506F0675879
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 16:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjATPY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 10:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjATPYw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:24:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A762DDA109
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 07:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674228235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s0/zcIGGKTApHMlSGG+YoMBJsFSTCsxQiIWlkpTWtTU=;
        b=RxLzr/GBcDkhRQNpV1giYdp6AQtQBLimVPaEQh2bf/hqmq0U7jQQcmnxAHPACBnRO22ZqG
        AcgXpLBLXG7XZZBSUsvKNqLWlpdqH1sW7iqTLqc8a4Xjz8IcdA2EVsjlGOgcoXTiRHyuGB
        81j5DSdajWhEj8qZEN20sMnEAd4+odY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-490-gWFgwewLMBSMYsoVeyOV8Q-1; Fri, 20 Jan 2023 10:23:54 -0500
X-MC-Unique: gWFgwewLMBSMYsoVeyOV8Q-1
Received: by mail-ed1-f71.google.com with SMTP id v8-20020a056402348800b0049e1913bd43so4157011edc.20
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 07:23:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0/zcIGGKTApHMlSGG+YoMBJsFSTCsxQiIWlkpTWtTU=;
        b=oc6npOOyLCldFru36r5uzFRrDPgJiH//E3tNu383MfWjgBdK9Ye8tc/PD7DGcAbZdS
         xA6Sa1S+aF52bq4fsX/WH/D9j2MDAMpCwodvyQjxmhKf6L2kP6phRRGc7v0XJ8r1f/F9
         qCZiPgn9yleVoMZOBi63w0gx1vUYzTKxtoZA4yltxfHFwTP4051lqyKnl6417iQqgzQr
         pmKefojBXVQDYiTdUSITmHaQGS3vlG2T/fsnLMrUO9cCjrfB4CdjYirGl+WcGx042IzK
         bY8WZeHcDCNtUVS8pFqjFJRPbXLtmGRXC+JBmShDNaGltYXYg8ySERNmjOs9e8v/iNoV
         g+mw==
X-Gm-Message-State: AFqh2krWVFGB03ntMyS443y9ibXGNHUGlEsMam8l5lKOX0dAWx8RQwmG
        zCD56mBiV6Zcd8hTdREYqrq1BSNNnq5NR1MvE/VuA/8Xhc70ONJxc0XxuZjfwIFFcykt745gspk
        55KJQeVfXThWasrzPBPJTsn3iayI+w9yCH19h/Tl2kgVgEXP5gdRD9vHJV2sAyZLWDsU85j8usA
        ==
X-Received: by 2002:a17:906:9e91:b0:84d:373b:39da with SMTP id fx17-20020a1709069e9100b0084d373b39damr13328826ejc.40.1674228233263;
        Fri, 20 Jan 2023 07:23:53 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsGcjWh87mhq41m34RJBZCY0zxbnw4W+rrq6YeNlwMvN/YQDsv7qURkx8RZ7LeLkM4j6fTfSA==
X-Received: by 2002:a17:906:9e91:b0:84d:373b:39da with SMTP id fx17-20020a1709069e9100b0084d373b39damr13328796ejc.40.1674228232739;
        Fri, 20 Jan 2023 07:23:52 -0800 (PST)
Received: from localhost.localdomain (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.googlemail.com with ESMTPSA id s16-20020a1709067b9000b00872eb47f46dsm5706976ejo.19.2023.01.20.07.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:23:52 -0800 (PST)
From:   Alexander Larsson <alexl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com,
        david@fromorbit.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v3 3/6] composefs: Add descriptor parsing code
Date:   Fri, 20 Jan 2023 16:23:31 +0100
Message-Id: <a00ce4b1ade35ba1cb44daa358443689022fa770.1674227308.git.alexl@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1674227308.git.alexl@redhat.com>
References: <cover.1674227308.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the code to load and decode the filesystem descriptor file
format.

We open the descriptor at mount time and keep the struct file *
around. Most accesses to it happens via cfs_get_buf() which reads the
descriptor data directly from the page cache. Although in a few cases
(like when we need to directly copy data) we use kernel_read()
instead.

Signed-off-by: Alexander Larsson <alexl@redhat.com>
Co-developed-by: Giuseppe Scrivano <gscrivan@redhat.com>
Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 fs/composefs/cfs-internals.h |  55 +++
 fs/composefs/cfs-reader.c    | 720 +++++++++++++++++++++++++++++++++++
 2 files changed, 775 insertions(+)
 create mode 100644 fs/composefs/cfs-internals.h
 create mode 100644 fs/composefs/cfs-reader.c

diff --git a/fs/composefs/cfs-internals.h b/fs/composefs/cfs-internals.h
new file mode 100644
index 000000000000..3524b977c8a8
--- /dev/null
+++ b/fs/composefs/cfs-internals.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _CFS_INTERNALS_H
+#define _CFS_INTERNALS_H
+
+#include "cfs.h"
+
+#define EFSCORRUPTED EUCLEAN /* Filesystem is corrupted */
+
+struct cfs_inode_extra_data {
+	char *path_payload; /* Real pathname for files, target for symlinks */
+
+	u64 xattrs_offset;
+	u32 xattrs_len;
+
+	u64 dirents_offset;
+	u32 dirents_len;
+
+	bool has_digest;
+	u8 digest[SHA256_DIGEST_SIZE]; /* fs-verity digest */
+};
+
+struct cfs_context {
+	struct file *descriptor;
+	u64 vdata_offset;
+	u32 num_inodes;
+
+	u64 descriptor_len;
+};
+
+int cfs_init_ctx(const char *descriptor_path, const u8 *required_digest,
+		 struct cfs_context *ctx);
+
+void cfs_ctx_put(struct cfs_context *ctx);
+
+int cfs_init_inode(struct cfs_context *ctx, u32 inode_num, struct inode *inode,
+		   struct cfs_inode_extra_data *data);
+
+ssize_t cfs_list_xattrs(struct cfs_context *ctx,
+			struct cfs_inode_extra_data *inode_data, char *names,
+			size_t size);
+int cfs_get_xattr(struct cfs_context *ctx, struct cfs_inode_extra_data *inode_data,
+		  const char *name, void *value, size_t size);
+
+typedef bool (*cfs_dir_iter_cb)(void *private, const char *name, int namelen,
+				u64 ino, unsigned int dtype);
+
+int cfs_dir_iterate(struct cfs_context *ctx, u64 index,
+		    struct cfs_inode_extra_data *inode_data, loff_t first,
+		    cfs_dir_iter_cb cb, void *private);
+
+int cfs_dir_lookup(struct cfs_context *ctx, u64 index,
+		   struct cfs_inode_extra_data *inode_data, const char *name,
+		   size_t name_len, u64 *index_out);
+
+#endif
diff --git a/fs/composefs/cfs-reader.c b/fs/composefs/cfs-reader.c
new file mode 100644
index 000000000000..6ff7d3e70d39
--- /dev/null
+++ b/fs/composefs/cfs-reader.c
@@ -0,0 +1,720 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * composefs
+ *
+ * Copyright (C) 2021 Giuseppe Scrivano
+ * Copyright (C) 2022 Alexander Larsson
+ *
+ * This file is released under the GPL.
+ */
+
+#include "cfs-internals.h"
+
+#include <linux/file.h>
+#include <linux/fsverity.h>
+#include <linux/pagemap.h>
+#include <linux/vmalloc.h>
+
+/* When mapping buffers via page arrays this is an "arbitrary" limit
+ * to ensure we're not ballooning memory use for the page array and
+ * mapping. On a 4k page, 64bit machine this limit will make the page
+ * array fit in one page, and will allow a mapping of 2MB. When
+ * applied to e.g. dirents this will allow more than 27000 filenames
+ * of length 64, which seems ok. If we need to support more, at that
+ * point we should probably fall back to an approach that maps pages
+ * incrementally.
+ */
+#define CFS_BUF_MAXPAGES 512
+
+#define CFS_BUF_PREALLOC_SIZE 4
+
+/* Check if the element, which is supposed to be offset from section_start
+ * actually fits in the section starting at section_start ending at section_end,
+ * and doesn't wrap.
+ */
+static bool cfs_is_in_section(u64 section_start, u64 section_end,
+			      u64 element_offset, u64 element_size)
+{
+	u64 element_end;
+	u64 element_start;
+
+	element_start = section_start + element_offset;
+	if (element_start < section_start || element_start >= section_end)
+		return false;
+
+	element_end = element_start + element_size;
+	if (element_end < element_start || element_end > section_end)
+		return false;
+
+	return true;
+}
+
+struct cfs_buf {
+	struct page **pages;
+	size_t n_pages;
+	void *base;
+
+	/* Used as "pages" above to avoid allocation for small buffers */
+	struct page *prealloc[CFS_BUF_PREALLOC_SIZE];
+};
+
+static void cfs_buf_put(struct cfs_buf *buf)
+{
+	if (buf->pages) {
+		if (buf->n_pages == 1)
+			kunmap_local(buf->base);
+		else
+			vm_unmap_ram(buf->base, buf->n_pages);
+		for (size_t i = 0; i < buf->n_pages; i++)
+			put_page(buf->pages[i]);
+		if (buf->n_pages > CFS_BUF_PREALLOC_SIZE)
+			kfree(buf->pages);
+		buf->pages = NULL;
+	}
+}
+
+/* Map data from anywhere in the descriptor */
+static void *cfs_get_buf(struct cfs_context *ctx, u64 offset, u32 size,
+			 struct cfs_buf *buf)
+{
+	struct inode *inode = ctx->descriptor->f_inode;
+	struct address_space *const mapping = inode->i_mapping;
+	size_t n_pages, read_pages;
+	u64 index, last_index;
+	struct page **pages;
+	void *base;
+
+	if (buf->pages)
+		return ERR_PTR(-EINVAL);
+
+	if (!cfs_is_in_section(0, ctx->descriptor_len, offset, size) || size == 0)
+		return ERR_PTR(-EFSCORRUPTED);
+
+	index = offset >> PAGE_SHIFT;
+	last_index = (offset + size - 1) >> PAGE_SHIFT;
+	n_pages = last_index - index + 1;
+
+	if (n_pages > CFS_BUF_MAXPAGES)
+		return ERR_PTR(-ENOMEM);
+
+	if (n_pages > CFS_BUF_PREALLOC_SIZE) {
+		pages = kmalloc_array(n_pages, sizeof(struct page *), GFP_KERNEL);
+		if (!pages)
+			return ERR_PTR(-ENOMEM);
+	} else {
+		/* Avoid allocation in common (small) cases */
+		pages = buf->prealloc;
+	}
+
+	for (read_pages = 0; read_pages < n_pages; read_pages++) {
+		struct page *page =
+			read_cache_page(mapping, index + read_pages, NULL, NULL);
+		if (IS_ERR(page))
+			goto nomem;
+		pages[read_pages] = page;
+	}
+
+	if (n_pages == 1) {
+		base = kmap_local_page(pages[0]);
+	} else {
+		base = vm_map_ram(pages, n_pages, -1);
+		if (!base)
+			goto nomem;
+	}
+
+	buf->pages = pages;
+	buf->n_pages = n_pages;
+	buf->base = base;
+
+	return base + (offset & (PAGE_SIZE - 1));
+
+nomem:
+	for (size_t i = 0; i < read_pages; i++)
+		put_page(pages[i]);
+	if (n_pages > CFS_BUF_PREALLOC_SIZE)
+		kfree(pages);
+
+	return ERR_PTR(-ENOMEM);
+}
+
+/* Map data from the inode table */
+static void *cfs_get_inode_buf(struct cfs_context *ctx, u64 offset, u32 len,
+			       struct cfs_buf *buf)
+{
+	if (!cfs_is_in_section(CFS_INODE_TABLE_OFFSET, ctx->vdata_offset, offset, len))
+		return ERR_PTR(-EINVAL);
+
+	return cfs_get_buf(ctx, CFS_INODE_TABLE_OFFSET + offset, len, buf);
+}
+
+/* Map data from the variable data section */
+static void *cfs_get_vdata_buf(struct cfs_context *ctx, u64 offset, u32 len,
+			       struct cfs_buf *buf)
+{
+	if (!cfs_is_in_section(ctx->vdata_offset, ctx->descriptor_len, offset, len))
+		return ERR_PTR(-EINVAL);
+
+	return cfs_get_buf(ctx, ctx->vdata_offset + offset, len, buf);
+}
+
+/* Read data from anywhere in the descriptor */
+static void *cfs_read_data(struct cfs_context *ctx, u64 offset, u32 size, u8 *dest)
+{
+	loff_t pos = offset;
+	size_t copied;
+
+	if (!cfs_is_in_section(0, ctx->descriptor_len, offset, size))
+		return ERR_PTR(-EFSCORRUPTED);
+
+	copied = 0;
+	while (copied < size) {
+		ssize_t bytes;
+
+		bytes = kernel_read(ctx->descriptor, dest + copied,
+				    size - copied, &pos);
+		if (bytes < 0)
+			return ERR_PTR(bytes);
+		if (bytes == 0)
+			return ERR_PTR(-EINVAL);
+
+		copied += bytes;
+	}
+
+	if (copied != size)
+		return ERR_PTR(-EFSCORRUPTED);
+	return dest;
+}
+
+/* Read data from the variable data section */
+static void *cfs_read_vdata(struct cfs_context *ctx, u64 offset, u32 len, char *buf)
+{
+	void *res;
+
+	if (!cfs_is_in_section(ctx->vdata_offset, ctx->descriptor_len, offset, len))
+		return ERR_PTR(-EINVAL);
+
+	res = cfs_read_data(ctx, ctx->vdata_offset + offset, len, buf);
+	if (IS_ERR(res))
+		return ERR_CAST(res);
+
+	return buf;
+}
+
+/* Allocate, read and null-terminate paths from the variable data section */
+static char *cfs_read_vdata_path(struct cfs_context *ctx, u64 offset, u32 len)
+{
+	char *path;
+	void *res;
+
+	if (len > PATH_MAX)
+		return ERR_PTR(-EINVAL);
+
+	path = kmalloc(len + 1, GFP_KERNEL);
+	if (!path)
+		return ERR_PTR(-ENOMEM);
+
+	res = cfs_read_vdata(ctx, offset, len, path);
+	if (IS_ERR(res)) {
+		kfree(path);
+		return ERR_CAST(res);
+	}
+
+	/* zero terminate */
+	path[len] = 0;
+
+	return path;
+}
+
+int cfs_init_ctx(const char *descriptor_path, const u8 *required_digest,
+		 struct cfs_context *ctx_out)
+{
+	u8 verity_digest[FS_VERITY_MAX_DIGEST_SIZE];
+	struct cfs_superblock superblock_buf;
+	struct cfs_superblock *superblock;
+	enum hash_algo verity_algo;
+	struct cfs_context ctx;
+	struct file *descriptor;
+	u64 num_inodes;
+	loff_t i_size;
+	int res;
+
+	descriptor = filp_open(descriptor_path, O_RDONLY, 0);
+	if (IS_ERR(descriptor))
+		return PTR_ERR(descriptor);
+
+	if (required_digest) {
+		res = fsverity_get_digest(d_inode(descriptor->f_path.dentry),
+					  verity_digest, &verity_algo);
+		if (res < 0) {
+			pr_err("ERROR: composefs descriptor has no fs-verity digest\n");
+			goto fail;
+		}
+		if (verity_algo != HASH_ALGO_SHA256 ||
+		    memcmp(required_digest, verity_digest, SHA256_DIGEST_SIZE) != 0) {
+			pr_err("ERROR: composefs descriptor has wrong fs-verity digest\n");
+			res = -EINVAL;
+			goto fail;
+		}
+	}
+
+	i_size = i_size_read(file_inode(descriptor));
+	if (i_size <= CFS_DESCRIPTOR_MIN_SIZE) {
+		res = -EINVAL;
+		goto fail;
+	}
+
+	/* Need this temporary ctx for cfs_read_data() */
+	ctx.descriptor = descriptor;
+	ctx.descriptor_len = i_size;
+
+	superblock = cfs_read_data(&ctx, CFS_SUPERBLOCK_OFFSET,
+				   sizeof(struct cfs_superblock),
+				   (u8 *)&superblock_buf);
+	if (IS_ERR(superblock)) {
+		res = PTR_ERR(superblock);
+		goto fail;
+	}
+
+	ctx.vdata_offset = le64_to_cpu(superblock->vdata_offset);
+
+	/* Some basic validation of the format */
+	if (le32_to_cpu(superblock->version) != CFS_VERSION ||
+	    le32_to_cpu(superblock->magic) != CFS_MAGIC ||
+	    /* vdata is in file */
+	    ctx.vdata_offset > ctx.descriptor_len ||
+	    ctx.vdata_offset <= CFS_INODE_TABLE_OFFSET ||
+	    /* vdata is aligned */
+	    ctx.vdata_offset % 4 != 0) {
+		res = -EFSCORRUPTED;
+		goto fail;
+	}
+
+	num_inodes = (ctx.vdata_offset - CFS_INODE_TABLE_OFFSET) / CFS_INODE_SIZE;
+	if (num_inodes > U32_MAX) {
+		res = -EFSCORRUPTED;
+		goto fail;
+	}
+	ctx.num_inodes = num_inodes;
+
+	*ctx_out = ctx;
+	return 0;
+
+fail:
+	fput(descriptor);
+	return res;
+}
+
+void cfs_ctx_put(struct cfs_context *ctx)
+{
+	if (ctx->descriptor) {
+		fput(ctx->descriptor);
+		ctx->descriptor = NULL;
+	}
+}
+
+static bool cfs_validate_filename(const char *name, size_t name_len)
+{
+	if (name_len == 0)
+		return false;
+
+	if (name_len == 1 && name[0] == '.')
+		return false;
+
+	if (name_len == 2 && name[0] == '.' && name[1] == '.')
+		return false;
+
+	if (memchr(name, '/', name_len))
+		return false;
+
+	return true;
+}
+
+int cfs_init_inode(struct cfs_context *ctx, u32 inode_num, struct inode *inode,
+		   struct cfs_inode_extra_data *inode_data)
+{
+	struct cfs_buf vdata_buf = { NULL };
+	struct cfs_inode_data *disk_data;
+	char *path_payload = NULL;
+	void *res;
+	int ret = 0;
+	u64 variable_data_off;
+	u32 variable_data_len;
+	u64 digest_off;
+	u32 digest_len;
+	u32 st_type;
+	u64 size;
+
+	if (inode_num >= ctx->num_inodes)
+		return -EFSCORRUPTED;
+
+	disk_data = cfs_get_inode_buf(ctx, inode_num * CFS_INODE_SIZE,
+				      CFS_INODE_SIZE, &vdata_buf);
+	if (IS_ERR(disk_data))
+		return PTR_ERR(disk_data);
+
+	inode->i_ino = inode_num;
+
+	inode->i_mode = le32_to_cpu(disk_data->st_mode);
+	set_nlink(inode, le32_to_cpu(disk_data->st_nlink));
+	inode->i_uid = make_kuid(current_user_ns(), le32_to_cpu(disk_data->st_uid));
+	inode->i_gid = make_kgid(current_user_ns(), le32_to_cpu(disk_data->st_gid));
+	inode->i_rdev = le32_to_cpu(disk_data->st_rdev);
+
+	size = le64_to_cpu(disk_data->st_size);
+	i_size_write(inode, size);
+	inode_set_bytes(inode, size);
+
+	inode->i_mtime.tv_sec = le64_to_cpu(disk_data->st_mtim_sec);
+	inode->i_mtime.tv_nsec = le32_to_cpu(disk_data->st_mtim_nsec);
+	inode->i_ctime.tv_sec = le64_to_cpu(disk_data->st_ctim_sec);
+	inode->i_ctime.tv_nsec = le32_to_cpu(disk_data->st_ctim_nsec);
+	inode->i_atime = inode->i_mtime;
+
+	variable_data_off = le64_to_cpu(disk_data->variable_data.off);
+	variable_data_len = le32_to_cpu(disk_data->variable_data.len);
+
+	st_type = inode->i_mode & S_IFMT;
+	if (st_type == S_IFDIR) {
+		inode_data->dirents_offset = variable_data_off;
+		inode_data->dirents_len = variable_data_len;
+	} else if ((st_type == S_IFLNK || st_type == S_IFREG) &&
+		   variable_data_len > 0) {
+		path_payload = cfs_read_vdata_path(ctx, variable_data_off,
+						   variable_data_len);
+		if (IS_ERR(path_payload)) {
+			ret = PTR_ERR(path_payload);
+			goto fail;
+		}
+		inode_data->path_payload = path_payload;
+	}
+
+	if (st_type == S_IFLNK) {
+		/* Symbolic link must have a non-empty target */
+		if (!inode_data->path_payload || *inode_data->path_payload == 0) {
+			ret = -EFSCORRUPTED;
+			goto fail;
+		}
+	} else if (st_type == S_IFREG) {
+		/* Regular file must have backing file except empty files */
+		if ((inode_data->path_payload && size == 0) ||
+		    (!inode_data->path_payload && size > 0)) {
+			ret = -EFSCORRUPTED;
+			goto fail;
+		}
+	}
+
+	inode_data->xattrs_offset = le64_to_cpu(disk_data->xattrs.off);
+	inode_data->xattrs_len = le32_to_cpu(disk_data->xattrs.len);
+
+	if (inode_data->xattrs_len != 0) {
+		/* Validate xattr size */
+		if (inode_data->xattrs_len < sizeof(struct cfs_xattr_header)) {
+			ret = -EFSCORRUPTED;
+			goto fail;
+		}
+	}
+
+	digest_off = le64_to_cpu(disk_data->digest.off);
+	digest_len = le32_to_cpu(disk_data->digest.len);
+
+	if (digest_len > 0) {
+		if (digest_len != SHA256_DIGEST_SIZE) {
+			ret = -EFSCORRUPTED;
+			goto fail;
+		}
+
+		res = cfs_read_vdata(ctx, digest_off, digest_len, inode_data->digest);
+		if (IS_ERR(res)) {
+			ret = PTR_ERR(res);
+			goto fail;
+		}
+		inode_data->has_digest = true;
+	}
+
+	cfs_buf_put(&vdata_buf);
+	return 0;
+
+fail:
+	cfs_buf_put(&vdata_buf);
+	return ret;
+}
+
+ssize_t cfs_list_xattrs(struct cfs_context *ctx,
+			struct cfs_inode_extra_data *inode_data, char *names,
+			size_t size)
+{
+	const struct cfs_xattr_header *xattrs;
+	struct cfs_buf vdata_buf = { NULL };
+	size_t n_xattrs = 0;
+	u8 *data, *data_end;
+	ssize_t copied = 0;
+
+	if (inode_data->xattrs_len == 0)
+		return 0;
+
+	/* xattrs_len basic size req was verified in cfs_init_inode_data */
+
+	xattrs = cfs_get_vdata_buf(ctx, inode_data->xattrs_offset,
+				   inode_data->xattrs_len, &vdata_buf);
+	if (IS_ERR(xattrs))
+		return PTR_ERR(xattrs);
+
+	n_xattrs = le16_to_cpu(xattrs->n_attr);
+	if (n_xattrs == 0 || n_xattrs > CFS_MAX_XATTRS ||
+	    inode_data->xattrs_len < cfs_xattr_header_size(n_xattrs)) {
+		copied = -EFSCORRUPTED;
+		goto exit;
+	}
+
+	data = ((u8 *)xattrs) + cfs_xattr_header_size(n_xattrs);
+	data_end = ((u8 *)xattrs) + inode_data->xattrs_len;
+
+	for (size_t i = 0; i < n_xattrs; i++) {
+		const struct cfs_xattr_element *e = &xattrs->attr[i];
+		u16 this_value_len = le16_to_cpu(e->value_length);
+		u16 this_key_len = le16_to_cpu(e->key_length);
+		const char *this_key;
+
+		if (this_key_len > XATTR_NAME_MAX ||
+		    /* key and data needs to fit in data */
+		    data_end - data < this_key_len + this_value_len) {
+			copied = -EFSCORRUPTED;
+			goto exit;
+		}
+
+		this_key = data;
+		data += this_key_len + this_value_len;
+
+		if (size) {
+			if (size - copied < this_key_len + 1) {
+				copied = -E2BIG;
+				goto exit;
+			}
+
+			memcpy(names + copied, this_key, this_key_len);
+			names[copied + this_key_len] = '\0';
+		}
+
+		copied += this_key_len + 1;
+	}
+
+exit:
+	cfs_buf_put(&vdata_buf);
+
+	return copied;
+}
+
+int cfs_get_xattr(struct cfs_context *ctx, struct cfs_inode_extra_data *inode_data,
+		  const char *name, void *value, size_t size)
+{
+	struct cfs_xattr_header *xattrs;
+	struct cfs_buf vdata_buf = { NULL };
+	size_t name_len = strlen(name);
+	size_t n_xattrs = 0;
+	u8 *data, *data_end;
+	int res;
+
+	if (inode_data->xattrs_len == 0)
+		return -ENODATA;
+
+	/* xattrs_len minimal size req was verified in cfs_init_inode_data */
+
+	xattrs = cfs_get_vdata_buf(ctx, inode_data->xattrs_offset,
+				   inode_data->xattrs_len, &vdata_buf);
+	if (IS_ERR(xattrs))
+		return PTR_ERR(xattrs);
+
+	n_xattrs = le16_to_cpu(xattrs->n_attr);
+	if (n_xattrs == 0 || n_xattrs > CFS_MAX_XATTRS ||
+	    inode_data->xattrs_len < cfs_xattr_header_size(n_xattrs)) {
+		res = -EFSCORRUPTED;
+		goto exit;
+	}
+
+	data = ((u8 *)xattrs) + cfs_xattr_header_size(n_xattrs);
+	data_end = ((u8 *)xattrs) + inode_data->xattrs_len;
+
+	for (size_t i = 0; i < n_xattrs; i++) {
+		const struct cfs_xattr_element *e = &xattrs->attr[i];
+		u16 this_value_len = le16_to_cpu(e->value_length);
+		u16 this_key_len = le16_to_cpu(e->key_length);
+		const char *this_key, *this_value;
+
+		if (this_key_len > XATTR_NAME_MAX ||
+		    /* key and data needs to fit in data */
+		    data_end - data < this_key_len + this_value_len) {
+			res = -EFSCORRUPTED;
+			goto exit;
+		}
+
+		this_key = data;
+		this_value = data + this_key_len;
+		data += this_key_len + this_value_len;
+
+		if (this_key_len != name_len || memcmp(this_key, name, name_len) != 0)
+			continue;
+
+		if (size > 0) {
+			if (size < this_value_len) {
+				res = -E2BIG;
+				goto exit;
+			}
+			memcpy(value, this_value, this_value_len);
+		}
+
+		res = this_value_len;
+		goto exit;
+	}
+
+	res = -ENODATA;
+
+exit:
+	cfs_buf_put(&vdata_buf);
+	return res;
+}
+
+/* This is essentially strmcp() for non-null-terminated strings */
+static inline int memcmp2(const void *a, const size_t a_size, const void *b,
+			  size_t b_size)
+{
+	size_t common_size = min(a_size, b_size);
+	int res;
+
+	res = memcmp(a, b, common_size);
+	if (res != 0 || a_size == b_size)
+		return res;
+
+	return a_size < b_size ? -1 : 1;
+}
+
+int cfs_dir_iterate(struct cfs_context *ctx, u64 index,
+		    struct cfs_inode_extra_data *inode_data, loff_t first,
+		    cfs_dir_iter_cb cb, void *private)
+{
+	struct cfs_buf vdata_buf = { NULL };
+	const struct cfs_dir_header *dir;
+	u32 n_dirents;
+	char *namedata, *namedata_end;
+	loff_t pos;
+	int res;
+
+	if (inode_data->dirents_len == 0)
+		return 0;
+
+	dir = cfs_get_vdata_buf(ctx, inode_data->dirents_offset,
+				inode_data->dirents_len, &vdata_buf);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	n_dirents = le32_to_cpu(dir->n_dirents);
+	if (n_dirents == 0 || n_dirents > CFS_MAX_DIRENTS ||
+	    inode_data->dirents_len < cfs_dir_header_size(n_dirents)) {
+		res = -EFSCORRUPTED;
+		goto exit;
+	}
+
+	if (first >= n_dirents) {
+		res = 0;
+		goto exit;
+	}
+
+	namedata = ((u8 *)dir) + cfs_dir_header_size(n_dirents);
+	namedata_end = ((u8 *)dir) + inode_data->dirents_len;
+	pos = 0;
+	for (size_t i = 0; i < n_dirents; i++) {
+		const struct cfs_dirent *dirent = &dir->dirents[i];
+		char *dirent_name =
+			(char *)namedata + le32_to_cpu(dirent->name_offset);
+		size_t dirent_name_len = dirent->name_len;
+
+		/* name needs to fit in namedata */
+		if (dirent_name >= namedata_end ||
+		    namedata_end - dirent_name < dirent_name_len) {
+			res = -EFSCORRUPTED;
+			goto exit;
+		}
+
+		if (!cfs_validate_filename(dirent_name, dirent_name_len)) {
+			res = -EFSCORRUPTED;
+			goto exit;
+		}
+
+		if (pos++ < first)
+			continue;
+
+		if (!cb(private, dirent_name, dirent_name_len,
+			le32_to_cpu(dirent->inode_num), dirent->d_type)) {
+			break;
+		}
+	}
+
+	res = 0;
+exit:
+	cfs_buf_put(&vdata_buf);
+	return res;
+}
+
+int cfs_dir_lookup(struct cfs_context *ctx, u64 index,
+		   struct cfs_inode_extra_data *inode_data, const char *name,
+		   size_t name_len, u64 *index_out)
+{
+	struct cfs_buf vdata_buf = { NULL };
+	const struct cfs_dir_header *dir;
+	u32 start_dirent, end_dirent, n_dirents;
+	char *namedata, *namedata_end;
+	int cmp, res;
+
+	if (inode_data->dirents_len == 0)
+		return 0;
+
+	dir = cfs_get_vdata_buf(ctx, inode_data->dirents_offset,
+				inode_data->dirents_len, &vdata_buf);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	n_dirents = le32_to_cpu(dir->n_dirents);
+	if (n_dirents == 0 || n_dirents > CFS_MAX_DIRENTS ||
+	    inode_data->dirents_len < cfs_dir_header_size(n_dirents)) {
+		res = -EFSCORRUPTED;
+		goto exit;
+	}
+
+	namedata = ((u8 *)dir) + cfs_dir_header_size(n_dirents);
+	namedata_end = ((u8 *)dir) + inode_data->dirents_len;
+
+	start_dirent = 0;
+	end_dirent = n_dirents - 1;
+	while (start_dirent <= end_dirent) {
+		int mid_dirent = start_dirent + (end_dirent - start_dirent) / 2;
+		const struct cfs_dirent *dirent = &dir->dirents[mid_dirent];
+		char *dirent_name =
+			(char *)namedata + le32_to_cpu(dirent->name_offset);
+		size_t dirent_name_len = dirent->name_len;
+
+		/* name needs to fit in namedata */
+		if (dirent_name >= namedata_end ||
+		    namedata_end - dirent_name < dirent_name_len) {
+			res = -EFSCORRUPTED;
+			goto exit;
+		}
+
+		cmp = memcmp2(name, name_len, dirent_name, dirent_name_len);
+		if (cmp == 0) {
+			*index_out = le32_to_cpu(dirent->inode_num);
+			res = 1;
+			goto exit;
+		}
+
+		if (cmp > 0)
+			start_dirent = mid_dirent + 1;
+		else
+			end_dirent = mid_dirent - 1;
+	}
+
+	/* not found */
+	res = 0;
+
+exit:
+	cfs_buf_put(&vdata_buf);
+	return res;
+}
-- 
2.39.0

