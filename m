Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2B311204
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 06:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbfEBED5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 00:03:57 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:45824 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfEBED4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 00:03:56 -0400
Received: by mail-pl1-f201.google.com with SMTP id d10so596792plo.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 21:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FTGJtpVoTjeu1V1Sw0UdbZGuFv52q6kQBSEgglatuTk=;
        b=ojgUBfSkkB1EETF4JXueOdQcmbS8HjBujrtSDHxPDCf/ZqMOM6qUPj/8IAvJm19VDZ
         VIZoGEpKPVbJvKx+HD+paaba3HvEfJ0fvzxF+tVyEsLVp6AjceaOe+JiU5QbhZwJbYA8
         LB9M9NDgVLBv/7HbT5eGvrw0kmIcJYh/05991XLfOJZF4mtRKittNVwLmxgZ+X1+632g
         f4sQz+RSAiVP66cLrYJxh6D7+WXgcHXwM5EKcEOizFTVdEI6roppOdYP7zZP6Zd6Vq7y
         fkkMKUIu7pgR0R3FvNI3+HexvrLFe5Cq46mzHX/ezqvW69br60h0EMtD/bmwt5tM1pu7
         /LbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FTGJtpVoTjeu1V1Sw0UdbZGuFv52q6kQBSEgglatuTk=;
        b=Pai6HlJ9BU5RFUkm6eJ3+4b43hlwhHetzYlccGZyIoyg4qOLdBQgtFpDgixWMnnPIu
         cXFXsaIPYcJ1VPvomZX9ZOcAjgAK5x7tr/h8ipwyeDCOb9PY8PNKxM4LIjQ+h1zgTgbr
         k1ENOuWSzYS2qdyvReAr5sHLMurSFchyQPntR8DN+EEKnc6fnGmzxU+wrsAr4YHqecU6
         3mZub9TfU98ofXHBSulK7lDsuyOeGmjQfF3CG628W08xB+/exKq/SRzyvuY/dyhNAbCC
         /c6C8PW8FF3byNFj3ZDJqvIb3hVBB2pHNV4K9bdj9l9K53aFs6DnXR5LUZwGytYYxz3v
         G/DA==
X-Gm-Message-State: APjAAAUBdcNuJc8jN4bMaM6ZeMPfdydYlX9EW9m6YTRpJMmfBH8eCcY5
        YXw9KiD1bLCq8Dxomrv7PIn7l67mcdOQPewnHzqsmJ9v0TJKIBDoyYk2sPn0dEftoGOWJtdvNUM
        rSv04y/AmHGPTKvYeNZbRj1KAnFxyRve2i8g4QDjFBte7s+5DjQ6XmTJO8GKSob3WVBPPvXgrqX
        4=
X-Google-Smtp-Source: APXvYqySRqeEjTOAPzRJ+gU/lQ/xFzfML7D151OmhWDCXMnfN0v1+UOfkzATDrgpkOlK2sGB2RkMsQnWGoKwfQ==
X-Received: by 2002:a63:4c26:: with SMTP id z38mr1595233pga.425.1556769835838;
 Wed, 01 May 2019 21:03:55 -0700 (PDT)
Date:   Wed,  1 May 2019 21:03:27 -0700
In-Reply-To: <20190502040331.81196-1-ezemtsov@google.com>
Message-Id: <20190502040331.81196-3-ezemtsov@google.com>
Mime-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH 2/6] incfs: Backing file format
From:   ezemtsov@google.com
To:     linux-fsdevel@vger.kernel.org
Cc:     tytso@mit.edu, Eugene Zemtsov <ezemtsov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eugene Zemtsov <ezemtsov@google.com>

- Read and write logic for ondisk backing file format (aka incfs image)
- Add format.c and format.h
- Utils in internal.h

Signed-off-by: Eugene Zemtsov <ezemtsov@google.com>
---
 fs/incfs/Makefile   |   2 +-
 fs/incfs/format.c   | 554 ++++++++++++++++++++++++++++++++++++++++++++
 fs/incfs/format.h   | 294 +++++++++++++++++++++++
 fs/incfs/internal.h |  31 +++
 4 files changed, 880 insertions(+), 1 deletion(-)
 create mode 100644 fs/incfs/format.c
 create mode 100644 fs/incfs/format.h
 create mode 100644 fs/incfs/internal.h

diff --git a/fs/incfs/Makefile b/fs/incfs/Makefile
index 7892196c634f..cdea18c7213e 100644
--- a/fs/incfs/Makefile
+++ b/fs/incfs/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_INCREMENTAL_FS)	+= incrementalfs.o

-incrementalfs-y := main.o vfs.o
\ No newline at end of file
+incrementalfs-y := main.o vfs.o format.o
diff --git a/fs/incfs/format.c b/fs/incfs/format.c
new file mode 100644
index 000000000000..a0e6ecec09d3
--- /dev/null
+++ b/fs/incfs/format.c
@@ -0,0 +1,554 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 Google LLC
+ */
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/mm.h>
+#include <linux/falloc.h>
+#include <linux/slab.h>
+#include <linux/crc32.h>
+
+#include "format.h"
+
+struct backing_file_context *incfs_alloc_bfc(struct file *backing_file)
+{
+	struct backing_file_context *result = NULL;
+
+	result = kzalloc(sizeof(*result), GFP_NOFS);
+	if (!result)
+		return ERR_PTR(-ENOMEM);
+
+	result->bc_file = backing_file;
+	mutex_init(&result->bc_mutex);
+	return result;
+}
+
+void incfs_free_bfc(struct backing_file_context *bfc)
+{
+	if (!bfc)
+		return;
+
+	if (bfc->bc_file)
+		fput(bfc->bc_file);
+
+	mutex_destroy(&bfc->bc_mutex);
+	kfree(bfc);
+}
+
+loff_t incfs_get_end_offset(struct file *f)
+{
+	/*
+	 * This function assumes that file size and the end-offset
+	 * are the same. This is not always true.
+	 */
+	return i_size_read(file_inode(f));
+}
+
+/*
+ * Truncate the tail of the file to the given length.
+ * Used to rollback partially successful multistep writes.
+ */
+static int truncate_backing_file(struct backing_file_context *bfc,
+				loff_t new_end)
+{
+	struct inode *inode = NULL;
+	struct dentry *dentry = NULL;
+	loff_t old_end = 0;
+	struct iattr attr;
+	int result = 0;
+
+	if (!bfc)
+		return -EFAULT;
+
+	LOCK_REQUIRED(bfc->bc_mutex);
+
+	if (!bfc->bc_file)
+		return -EFAULT;
+
+	old_end = incfs_get_end_offset(bfc->bc_file);
+	if (old_end == new_end)
+		return 0;
+	if (old_end < new_end)
+		return -EINVAL;
+
+	inode = bfc->bc_file->f_inode;
+	dentry = bfc->bc_file->f_path.dentry;
+
+	attr.ia_size = new_end;
+	attr.ia_valid = ATTR_SIZE;
+
+	inode_lock(inode);
+	result = notify_change(dentry, &attr, NULL);
+	inode_unlock(inode);
+
+	return result;
+}
+
+/* Append a given number of zero bytes to the end of the backing file. */
+static int append_zeros(struct backing_file_context *bfc, size_t len)
+{
+	loff_t file_size = 0;
+	loff_t new_last_byte_offset = 0;
+	int res = 0;
+
+	if (!bfc)
+		return -EFAULT;
+
+	if (len == 0)
+		return -EINVAL;
+
+	LOCK_REQUIRED(bfc->bc_mutex);
+
+	/*
+	 * Allocate only one byte at the new desired end of the file.
+	 * It will increase file size and create a zeroed area of
+	 * a given size.
+	 */
+	file_size = incfs_get_end_offset(bfc->bc_file);
+	new_last_byte_offset = file_size + len - 1;
+	res = vfs_fallocate(bfc->bc_file, 0, new_last_byte_offset, 1);
+	if (res)
+		return res;
+
+	res = vfs_fsync_range(bfc->bc_file, file_size, file_size + len, 1);
+	return res;
+}
+
+static int write_to_bf(struct backing_file_context *bfc, const void *buf,
+			size_t count, loff_t pos, bool sync)
+{
+	ssize_t res = 0;
+	loff_t p = pos;
+
+	res = kernel_write(bfc->bc_file, buf, count, &p);
+	if (res < 0)
+		return res;
+	if (res != count)
+		return -EIO;
+
+	if (sync)
+		return vfs_fsync_range(bfc->bc_file, pos, pos + count, 1);
+
+	return 0;
+}
+
+static u32 calc_md_crc(struct incfs_md_header *record)
+{
+	u32 result = 0;
+	__le32 saved_crc = record->h_record_crc;
+	__le64 saved_md_offset = record->h_next_md_offset;
+	size_t record_size = min_t(size_t, le16_to_cpu(record->h_record_size),
+				INCFS_MAX_METADATA_RECORD_SIZE);
+
+	/* Zero fields which needs to be excluded from CRC calculation. */
+	record->h_record_crc = 0;
+	record->h_next_md_offset = 0;
+	result = crc32(0, record, record_size);
+
+	/* Restore excluded fields. */
+	record->h_record_crc = saved_crc;
+	record->h_next_md_offset = saved_md_offset;
+
+	return result;
+}
+
+/*
+ * Append a given metadata record to the backing file and update a previous
+ * record to add the new record the the metadata list.
+ */
+static int append_md_to_backing_file(struct backing_file_context *bfc,
+			      struct incfs_md_header *record)
+{
+	int result = 0;
+	loff_t record_offset;
+	loff_t file_pos;
+	__le64 new_md_offset;
+	size_t record_size;
+
+	if (!bfc || !record)
+		return -EFAULT;
+
+	if (bfc->bc_last_md_record_offset < 0)
+		return -EINVAL;
+
+	LOCK_REQUIRED(bfc->bc_mutex);
+
+	record_size = le16_to_cpu(record->h_record_size);
+	file_pos = incfs_get_end_offset(bfc->bc_file);
+	record->h_prev_md_offset = bfc->bc_last_md_record_offset;
+	record->h_next_md_offset = 0;
+	record->h_record_crc = cpu_to_le32(calc_md_crc(record));
+
+	/* Write the metadata record to the end of the backing file */
+	record_offset = file_pos;
+	new_md_offset = cpu_to_le64(record_offset);
+	result = write_to_bf(bfc, record, record_size, file_pos, true);
+	if (result)
+		return result;
+
+	/* Update next metadata offset in a previous record or a superblock. */
+	if (bfc->bc_last_md_record_offset) {
+		/*
+		 * Find a place in the previous md record where new record's
+		 * offset needs to be saved.
+		 */
+		file_pos = bfc->bc_last_md_record_offset +
+			offsetof(struct incfs_md_header, h_next_md_offset);
+	} else {
+		/* No metadata yet, file a place to update in the superblock. */
+		file_pos = offsetof(struct incfs_super_block,
+				s_first_md_offset);
+	}
+	result = write_to_bf(bfc, &new_md_offset, sizeof(new_md_offset),
+				file_pos, true);
+	if (result)
+		return result;
+
+	bfc->bc_last_md_record_offset = record_offset;
+	return result;
+}
+
+/* Append incfs_inode metadata record to the backing file. */
+int incfs_write_inode_to_backing_file(struct backing_file_context *bfc, u64 ino,
+				u64 size, u16 mode)
+{
+	struct incfs_inode disk_inode = {};
+
+	if (!bfc)
+		return -EFAULT;
+
+	LOCK_REQUIRED(bfc->bc_mutex);
+	disk_inode.i_header.h_md_entry_type = INCFS_MD_INODE;
+	disk_inode.i_header.h_record_size = cpu_to_le16(sizeof(disk_inode));
+	disk_inode.i_header.h_next_md_offset = cpu_to_le64(0);
+	disk_inode.i_no = cpu_to_le64(ino);
+	disk_inode.i_size = cpu_to_le64(size);
+	disk_inode.i_mode = cpu_to_le16(mode);
+	disk_inode.i_flags = cpu_to_le32(0);
+
+	return append_md_to_backing_file(bfc, &disk_inode.i_header);
+}
+
+/* Append incfs_dir_action metadata record to the backing file. */
+int incfs_write_dir_action(struct backing_file_context *bfc, u64 dir_ino,
+		     u64 dentry_ino, enum incfs_dir_action_type type,
+		     struct mem_range name)
+{
+	struct incfs_dir_action action = {};
+	u8 name_len = min_t(u8, INCFS_MAX_NAME_LEN, name.len);
+
+	if (!bfc)
+		return -EFAULT;
+
+	LOCK_REQUIRED(bfc->bc_mutex);
+	action.da_header.h_md_entry_type = INCFS_MD_DIR_ACTION;
+	action.da_header.h_record_size = cpu_to_le16(sizeof(action));
+	action.da_header.h_next_md_offset = cpu_to_le64(0);
+	action.da_dir_inode = cpu_to_le64(dir_ino);
+	action.da_entry_inode = cpu_to_le64(dentry_ino);
+	action.da_type = (__u8)type;
+	action.da_name_len = name_len;
+	memcpy(action.da_name, name.data, name_len);
+
+	return append_md_to_backing_file(bfc, &action.da_header);
+}
+
+/*
+ * Reserve 0-filled space for the blockmap body, and append
+ * incfs_blockmap metadata record pointing to it.
+ */
+int incfs_write_blockmap_to_backing_file(struct backing_file_context *bfc,
+				u64 ino, u32 block_count, loff_t *map_base_off)
+{
+	struct incfs_blockmap blockmap = {};
+	int result = 0;
+	loff_t file_end = 0;
+	size_t map_size = block_count * sizeof(struct incfs_blockmap_entry);
+
+	if (!bfc)
+		return -EFAULT;
+
+	blockmap.m_header.h_md_entry_type = INCFS_MD_BLOCK_MAP;
+	blockmap.m_header.h_record_size = cpu_to_le16(sizeof(blockmap));
+	blockmap.m_header.h_next_md_offset = cpu_to_le64(0);
+	blockmap.m_inode = cpu_to_le64(ino);
+	blockmap.m_block_count = cpu_to_le32(block_count);
+
+	LOCK_REQUIRED(bfc->bc_mutex);
+
+	/* Reserve 0-filled space for the blockmap body in the backing file. */
+	file_end = incfs_get_end_offset(bfc->bc_file);
+	result = append_zeros(bfc, map_size);
+	if (result)
+		return result;
+
+	/* Write blockmap metadata record pointing to the body written above. */
+	blockmap.m_base_offset = cpu_to_le64(file_end);
+	result = append_md_to_backing_file(bfc, &blockmap.m_header);
+	if (result) {
+		/* Error, rollback file changes */
+		truncate_backing_file(bfc, file_end);
+	} else if (map_base_off) {
+		*map_base_off = file_end;
+	}
+
+	return result;
+}
+
+/*
+ * Write a backing file header (superblock).
+ * It should always be called only on empty file.
+ * incfs_super_block.s_first_md_offset is 0 for now, but will be updated
+ * once first metadata record is added.
+ */
+int incfs_write_sb_to_backing_file(struct backing_file_context *bfc)
+{
+	struct incfs_super_block sb = {};
+	loff_t file_pos = 0;
+
+	if (!bfc)
+		return -EFAULT;
+
+	sb.s_magic = cpu_to_le64(INCFS_MAGIC_NUMBER);
+	sb.s_version = cpu_to_le64(INCFS_FORMAT_CURRENT_VER);
+	sb.s_super_block_size = cpu_to_le16(sizeof(sb));
+	sb.s_first_md_offset = cpu_to_le64(0);
+	sb.s_data_block_size = cpu_to_le16(INCFS_DATA_FILE_BLOCK_SIZE);
+
+	LOCK_REQUIRED(bfc->bc_mutex);
+
+	file_pos = incfs_get_end_offset(bfc->bc_file);
+	if (file_pos != 0)
+		return -EEXIST;
+
+	return write_to_bf(bfc, &sb, sizeof(sb), file_pos, true);
+}
+
+/* Write a given data block and update file's blockmap to point it. */
+int incfs_write_data_block_to_backing_file(struct backing_file_context *bfc,
+				     struct mem_range block, int block_index,
+				     loff_t bm_base_off, u16 flags, u32 crc)
+{
+	struct incfs_blockmap_entry bm_entry = {};
+	int result = 0;
+	loff_t data_offset = 0;
+	loff_t bm_entry_off =
+		bm_base_off + sizeof(struct incfs_blockmap_entry) * block_index;
+
+	if (!bfc)
+		return -EFAULT;
+
+	if (block.len >= (1 << 16) || block_index < 0)
+		return -EINVAL;
+
+	LOCK_REQUIRED(bfc->bc_mutex);
+
+	data_offset = incfs_get_end_offset(bfc->bc_file);
+	if (data_offset <= bm_entry_off) {
+		/* Blockmap entry is beyond the file's end. It is not normal. */
+		return -EINVAL;
+	}
+
+	/* Write the block data at the end of the backing file. */
+	result = write_to_bf(bfc, block.data, block.len, data_offset, false);
+	if (result)
+		return result;
+
+	/* Update the blockmap to point to the newly written data. */
+	bm_entry.me_data_offset_lo = cpu_to_le32((u32)data_offset);
+	bm_entry.me_data_offset_hi = cpu_to_le16((u16)(data_offset >> 32));
+	bm_entry.me_data_size = cpu_to_le16((u16)block.len);
+	bm_entry.me_flags = cpu_to_le16(flags);
+	bm_entry.me_data_crc = cpu_to_le32(crc);
+
+	result = write_to_bf(bfc, &bm_entry, sizeof(bm_entry),
+				bm_entry_off, false);
+
+	return result;
+}
+
+/* Initialize a new image in a given backing file. */
+int incfs_make_empty_backing_file(struct backing_file_context *bfc)
+{
+	int result = 0;
+
+	if (!bfc || !bfc->bc_file)
+		return -EFAULT;
+
+	result = mutex_lock_interruptible(&bfc->bc_mutex);
+	if (result)
+		goto out;
+
+	result = truncate_backing_file(bfc, 0);
+	if (result)
+		goto out;
+
+	result = incfs_write_sb_to_backing_file(bfc);
+out:
+	mutex_unlock(&bfc->bc_mutex);
+	return result;
+}
+
+int incfs_read_blockmap_entry(struct backing_file_context *bfc, int block_index,
+			loff_t bm_base_off,
+			struct incfs_blockmap_entry *bm_entry)
+{
+	loff_t bm_entry_off =
+		bm_base_off + sizeof(struct incfs_blockmap_entry) * block_index;
+	const size_t bytes_to_read = sizeof(struct incfs_blockmap_entry);
+	int result = 0;
+
+	if (!bfc || !bm_entry)
+		return -EFAULT;
+
+	if (block_index < 0 || bm_base_off <= 0)
+		return -ENODATA;
+
+	result = kernel_read(bfc->bc_file, bm_entry, bytes_to_read,
+			     &bm_entry_off);
+	if (result < 0)
+		return result;
+	if (result < bytes_to_read)
+		return -EIO;
+	return 0;
+}
+
+int incfs_read_superblock(struct backing_file_context *bfc,
+				loff_t *first_md_off)
+{
+	loff_t pos = 0;
+	ssize_t bytes_read = 0;
+	struct incfs_super_block sb = {};
+
+	if (!bfc || !first_md_off)
+		return -EFAULT;
+
+	LOCK_REQUIRED(bfc->bc_mutex);
+	bytes_read = kernel_read(bfc->bc_file, &sb, sizeof(sb), &pos);
+	if (bytes_read < 0)
+		return bytes_read;
+
+	if (bytes_read < sizeof(sb))
+		return -EBADMSG;
+
+	if (le64_to_cpu(sb.s_magic) != INCFS_MAGIC_NUMBER)
+		return -EILSEQ;
+
+	if (le64_to_cpu(sb.s_version) > INCFS_FORMAT_CURRENT_VER)
+		return -EILSEQ;
+
+	if (le16_to_cpu(sb.s_data_block_size) != INCFS_DATA_FILE_BLOCK_SIZE)
+		return -EILSEQ;
+
+	if (le16_to_cpu(sb.s_super_block_size) > sizeof(sb))
+		return -EILSEQ;
+
+	*first_md_off = le64_to_cpu(sb.s_first_md_offset);
+	return 0;
+}
+
+/*
+ * Read through metadata records from the backing file one by one
+ * and call provided metadata handlers.
+ */
+int incfs_read_next_metadata_record(struct backing_file_context *bfc,
+			      struct metadata_handler *handler)
+{
+	loff_t pos = 0;
+	const ssize_t max_md_size = INCFS_MAX_METADATA_RECORD_SIZE;
+	ssize_t bytes_read = 0;
+	size_t md_record_size = 0;
+	loff_t next_record = 0;
+	loff_t prev_record = 0;
+	int res = 0;
+	struct incfs_md_header *md_hdr = NULL;
+
+	if (!bfc || !handler)
+		return -EFAULT;
+
+	LOCK_REQUIRED(bfc->bc_mutex);
+
+	if (handler->md_record_offset == 0)
+		return -EPERM;
+
+	memset(&handler->md_buffer, 0, max_md_size);
+	pos = handler->md_record_offset;
+	bytes_read = kernel_read(bfc->bc_file, (u8 *)&handler->md_buffer,
+				 max_md_size, &pos);
+	if (bytes_read < 0)
+		return bytes_read;
+	if (bytes_read < sizeof(*md_hdr))
+		return -EBADMSG;
+
+	md_hdr = &handler->md_buffer.md_header;
+	next_record = le64_to_cpu(md_hdr->h_next_md_offset);
+	prev_record = le64_to_cpu(md_hdr->h_prev_md_offset);
+	md_record_size = le16_to_cpu(md_hdr->h_record_size);
+
+	if (md_record_size > max_md_size) {
+		pr_warn("incfs: The record is too large. Size: %ld",
+				md_record_size);
+		return -EBADMSG;
+	}
+
+	if (bytes_read < md_record_size) {
+		pr_warn("incfs: The record hasn't been fully read.");
+		return -EBADMSG;
+	}
+
+	if (next_record <= handler->md_record_offset && next_record != 0) {
+		pr_warn("incfs: Next record (%lld) points back in file.",
+			next_record);
+		return -EBADMSG;
+	}
+
+	if (prev_record != handler->md_prev_record_offset) {
+		pr_warn("incfs: Metadata chain has been corrupted.");
+		return -EBADMSG;
+	}
+
+	if (le32_to_cpu(md_hdr->h_record_crc) != calc_md_crc(md_hdr)) {
+		pr_warn("incfs: Metadata CRC mismatch.");
+		return -EBADMSG;
+	}
+
+	switch (md_hdr->h_md_entry_type) {
+	case INCFS_MD_NONE:
+		break;
+	case INCFS_MD_INODE:
+		if (handler->handle_inode)
+			res = handler->handle_inode(&handler->md_buffer.inode,
+						    handler);
+		break;
+	case INCFS_MD_BLOCK_MAP:
+		if (handler->handle_blockmap)
+			res = handler->handle_blockmap(
+				&handler->md_buffer.blockmap, handler);
+		break;
+	case INCFS_MD_DIR_ACTION:
+		if (handler->handle_dir_action)
+			res = handler->handle_dir_action(
+				&handler->md_buffer.dir_action, handler);
+		break;
+	default:
+		res = -ENOTSUPP;
+		break;
+	}
+
+	if (!res) {
+		if (next_record == 0) {
+			/*
+			 * Zero offset for the next record means that the last
+			 * metadata record has just been processed.
+			 */
+			bfc->bc_last_md_record_offset =
+				handler->md_record_offset;
+		}
+		handler->md_prev_record_offset = handler->md_record_offset;
+		handler->md_record_offset = next_record;
+	}
+	return res;
+}
diff --git a/fs/incfs/format.h b/fs/incfs/format.h
new file mode 100644
index 000000000000..2c2114bdd08f
--- /dev/null
+++ b/fs/incfs/format.h
@@ -0,0 +1,294 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2018 Google LLC
+ */
+
+/*
+ * Overview
+ * --------
+ * The backbone of the incremental-fs ondisk format is an append only linked
+ * list of metadata blocks. Each metadata block contains an offset of the next
+ * one. These blocks describe files and directories on the
+ * file system. They also represent actions of adding and removing file names
+ * (hard links).
+ *
+ * Every time incremental-fs instance is mounted, it reads through this list
+ * to recreate filesystem's state in memory. An offset of the first record in
+ * the metadata list is stored in the superblock at the beginning of the backing
+ * file.
+ *
+ * Most of the backing file is taken by data areas and blockmaps.
+ * Since data blocks can be compressed and have different sizes,
+ * single per-file data area can't be pre-allocated. That's why blockmaps are
+ * needed in order to find a location and size of each data block in
+ * the backing file. Each time a file is created, a corresponding block map is
+ * allocated to store future offsets of data blocks.
+ *
+ * Whenever a data block is given by data loader to incremental-fs:
+ *   - A data area with the given block is appended to the end of
+ *     the backing file.
+ *   - A record in the blockmap for the given block index is updated to reflect
+ *     its location, size, and compression algorithm.
+
+ * Metadata records
+ * ----------------
+ * incfs_inode - metadata record to declare a file or a directory.
+ *                    incfs_inode.i_mode determents if it is a file
+ *                    or a directory.
+ * incfs_blockmap_entry - metadata record that specifies size and location
+ *                           of a blockmap area for a given file. This area
+ *                           contains an array of incfs_blockmap_entry-s.
+ * incfs_dir_action - metadata record that specifies changes made to a
+ *                   to a directory structure, e.g. add or remove a hardlink.
+ *
+ * Metadata header
+ * ---------------
+ * incfs_md_header - header of a metadata record. It's always a part
+ *                   of other structures and served purpose of metadata
+ *                   bookkeeping.
+ *
+ *              +-----------------------------------------------+       ^
+ *              |            incfs_md_header                    |       |
+ *              | 1. type of body(INODE, BLOCKMAP, DIR ACTION..)|       |
+ *              | 2. size of the whole record header + body     |       |
+ *              | 3. CRC the whole record header + body         |       |
+ *              | 4. offset of the previous md record           |]------+
+ *              | 5. offset of the next md record (md link)     |]---+
+ *              +-----------------------------------------------+    |
+ *              |  Metadata record body with useful data        |    |
+ *              +-----------------------------------------------+    |
+ *                                                                   +--->
+ *
+ * Other ondisk structures
+ * -----------------------
+ * incfs_super_block - backing file header
+ * incfs_blockmap_entry - a record in a blockmap area that describes size
+ *                       and location of a data block.
+ * Data blocks dont have any particular structure, they are written to the
+ * backing file in a raw form as they come from a data loader.
+ *
+ * Backing file layout
+ * -------------------
+ *
+ *
+ *              +-------------------------------------------+
+ *              |            incfs_super_block              |]---+
+ *              +-------------------------------------------+    |
+ *              |                 metadata                  |<---+
+ *              |                incfs_inode                |]---+
+ *              +-------------------------------------------+    |
+ *                        .........................              |
+ *              +-------------------------------------------+    |   metadata
+ *     +------->|               blockmap area               |    |  list links
+ *     |        |          [incfs_blockmap_entry]           |    |
+ *     |        |          [incfs_blockmap_entry]           |    |
+ *     |        |          [incfs_blockmap_entry]           |    |
+ *     |    +--[|          [incfs_blockmap_entry]           |    |
+ *     |    |   |          [incfs_blockmap_entry]           |    |
+ *     |    |   |          [incfs_blockmap_entry]           |    |
+ *     |    |   +-------------------------------------------+    |
+ *     |    |             .........................              |
+ *     |    |   +-------------------------------------------+    |
+ *     |    |   |                 metadata                  |<---+
+ *     +----|--[|               incfs_blockmap              |]---+
+ *          |   +-------------------------------------------+    |
+ *          |             .........................              |
+ *          |   +-------------------------------------------+    |
+ *          +-->|                 data block                |    |
+ *              +-------------------------------------------+    |
+ *                        .........................              |
+ *              +-------------------------------------------+    |
+ *              |                 metadata                  |<---+
+ *              |             incfs_dir_action              |
+ *              +-------------------------------------------+
+ */
+#ifndef _INCFS_FORMAT_H
+#define _INCFS_FORMAT_H
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <uapi/linux/incrementalfs.h>
+
+#include "internal.h"
+
+#define INCFS_MAX_NAME_LEN 255
+#define INCFS_FORMAT_V1 1
+#define INCFS_FORMAT_CURRENT_VER INCFS_FORMAT_V1
+
+enum incfs_metadata_type {
+	INCFS_MD_NONE = 0,
+	INCFS_MD_INODE = 1,
+	INCFS_MD_BLOCK_MAP = 2,
+	INCFS_MD_DIR_ACTION = 3
+};
+
+/* Header included at the beginning of all metadata records on the disk. */
+struct incfs_md_header {
+	__u8 h_md_entry_type;
+
+	/*
+	 * Size of the metadata record.
+	 * (e.g. inode, dir entry etc) not just this struct.
+	 */
+	__le16 h_record_size;
+
+	/*
+	 * CRC32 of the metadata record.
+	 * (e.g. inode, dir entry etc) not just this struct.
+	 */
+	__le32 h_record_crc;
+
+	/* Offset of the next metadata entry if any */
+	__le64 h_next_md_offset;
+
+	/* Offset of the previous metadata entry if any */
+	__le64 h_prev_md_offset;
+
+} __packed;
+
+/* Backing file header */
+struct incfs_super_block {
+	__le64 s_magic; /* Magic signature: INCFS_MAGIC_NUMBER */
+	__le64 s_version; /* Format version: INCFS_FORMAT_CURRENT_VER */
+	__le16 s_super_block_size; /* sizeof(incfs_super_block) */
+	__le32 s_flags; /* Reserved for future use. */
+	__le64 s_first_md_offset; /* Offset of the first metadata record */
+	__le16 s_data_block_size; /* INCFS_DATA_FILE_BLOCK_SIZE */
+} __packed;
+
+/* Metadata record for files and directories. Type = INCFS_MD_INODE */
+struct incfs_inode {
+	struct incfs_md_header i_header;
+	__le64 i_no; /* inode number */
+	__le64 i_size; /* Full size of the file's content */
+	__le16 i_mode; /* File mode */
+	__le32 i_flags; /* Reserved for future use. */
+} __packed;
+
+enum incfs_block_map_entry_flags {
+	INCFS_BLOCK_COMPRESSED_LZ4 = (1 << 0),
+};
+
+/* Block map entry pointing to an actual location of the data block. */
+struct incfs_blockmap_entry {
+	/* Offset of the actual data block. Lower 32 bits */
+	__le32 me_data_offset_lo;
+
+	/* Offset of the actual data block. Higher 16 bits */
+	__le16 me_data_offset_hi;
+
+	/* How many bytes the data actually occupies in the backing file */
+	__le16 me_data_size;
+
+	/* Block flags from incfs_block_map_entry_flags */
+	__u16 me_flags;
+
+	/* CRC32 of the block's data */
+	__le32 me_data_crc;
+} __packed;
+
+/* Metadata record for locations of file blocks. Type = INCFS_MD_BLOCK_MAP */
+struct incfs_blockmap {
+	struct incfs_md_header m_header;
+	/* inode of a file this map belongs to */
+	__le64 m_inode;
+
+	/* Base offset of the array of incfs_blockmap_entry */
+	__le64 m_base_offset;
+
+	/* Size of the map entry array in blocks */
+	__le32 m_block_count;
+} __packed;
+
+enum incfs_dir_action_type {
+	INCFS_DIRA_NONE = 0,
+	INCFS_DIRA_ADD_ENTRY = 1,
+	INCFS_DIRA_REMOVE_ENTRY = 2,
+};
+
+/* Metadata record of directory content change. Type = INCFS_MD_DIR_ACTION */
+struct incfs_dir_action {
+	struct incfs_md_header da_header;
+	__le64 da_dir_inode; /* Parent directory inode number */
+	__le64 da_entry_inode; /* File/subdirectory inode number */
+	__u8 da_type; /* One of enums incfs_dir_action_type */
+	__u8 da_name_len; /* Name length */
+	char da_name[INCFS_MAX_NAME_LEN]; /* File name */
+} __packed;
+
+/* State of the backing file. */
+struct backing_file_context {
+	/* Protects writes to bc_file */
+	struct mutex bc_mutex;
+
+	/* File object to read data from */
+	struct file *bc_file;
+
+	/*
+	 * Offset of the last known metadata record in the backing file.
+	 * 0 means there are no metadata records.
+	 */
+	loff_t bc_last_md_record_offset;
+};
+
+struct metadata_handler {
+	loff_t md_record_offset;
+	loff_t md_prev_record_offset;
+	void *context;
+
+	union {
+		struct incfs_md_header md_header;
+		struct incfs_inode inode;
+		struct incfs_blockmap blockmap;
+		struct incfs_dir_action dir_action;
+	} md_buffer;
+
+	int (*handle_inode)(struct incfs_inode *inode,
+			    struct metadata_handler *handler);
+	int (*handle_blockmap)(struct incfs_blockmap *bm,
+			       struct metadata_handler *handler);
+	int (*handle_dir_action)(struct incfs_dir_action *da,
+				 struct metadata_handler *handler);
+};
+#define INCFS_MAX_METADATA_RECORD_SIZE \
+	FIELD_SIZEOF(struct metadata_handler, md_buffer)
+
+loff_t incfs_get_end_offset(struct file *f);
+
+/* Backing file context management */
+struct backing_file_context *incfs_alloc_bfc(struct file *backing_file);
+
+void incfs_free_bfc(struct backing_file_context *bfc);
+
+/* Writing stuff */
+int incfs_write_inode_to_backing_file(struct backing_file_context *bfc, u64 ino,
+				      u64 size, u16 mode);
+
+int incfs_write_dir_action(struct backing_file_context *bfc, u64 dir_ino,
+			   u64 dentry_ino, enum incfs_dir_action_type type,
+			   struct mem_range name);
+
+int incfs_write_blockmap_to_backing_file(struct backing_file_context *bfc,
+					 u64 ino, u32 block_count,
+					 loff_t *map_base_off);
+
+int incfs_write_sb_to_backing_file(struct backing_file_context *bfc);
+
+int incfs_write_data_block_to_backing_file(struct backing_file_context *bfc,
+					   struct mem_range block,
+					   int block_index, loff_t bm_base_off,
+					   u16 flags, u32 crc);
+
+int incfs_make_empty_backing_file(struct backing_file_context *bfc);
+
+/* Reading stuff */
+int incfs_read_superblock(struct backing_file_context *bfc,
+			  loff_t *first_md_off);
+
+int incfs_read_blockmap_entry(struct backing_file_context *bfc, int block_index,
+			      loff_t bm_base_off,
+			      struct incfs_blockmap_entry *bm_entry);
+
+int incfs_read_next_metadata_record(struct backing_file_context *bfc,
+				    struct metadata_handler *handler);
+
+#endif /* _INCFS_FORMAT_H */
diff --git a/fs/incfs/internal.h b/fs/incfs/internal.h
new file mode 100644
index 000000000000..de8b6240e347
--- /dev/null
+++ b/fs/incfs/internal.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2018 Google LLC
+ */
+#ifndef _INCFS_INTERNAL_H
+#define _INCFS_INTERNAL_H
+#include <linux/types.h>
+
+struct mem_range {
+	u8 *data;
+	size_t len;
+};
+
+static inline struct mem_range range(u8 *data, size_t len)
+{
+	return (struct mem_range){ .data = data, .len = len };
+}
+
+#ifdef DEBUG
+#define LOCK_REQUIRED(lock)                                                    \
+	do {                                                                   \
+		if (!mutex_is_locked(&(lock))) {                               \
+			pr_err(#lock " must be taken");                        \
+			panic("Lock not taken.");                              \
+		}                                                              \
+	} while (0)
+#else
+#define LOCK_REQUIRED(lock)
+#endif
+
+#endif /* _INCFS_INTERNAL_H */
--
2.21.0.593.g511ec345e18-goog

