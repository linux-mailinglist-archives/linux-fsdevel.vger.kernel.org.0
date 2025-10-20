Return-Path: <linux-fsdevel+bounces-64635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D984BEF0D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 04:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42FC51899534
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 02:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89161EE7C6;
	Mon, 20 Oct 2025 02:08:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236181DF269
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 02:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926128; cv=none; b=P5IpCkeJ4Bgd4m45vrtbCzfdBGOZqVTom/jyC9Jrq3YbIThzPuhmbCCeLhz3kbp+33nAaFfv2cZJK9iNQ2BdVaRBrcQ1pQH73YWeD4xVNmbW3554E2KkmnfBPPg7tQprOBwedb/wB7rGYvkBp3VZ4USympjACUKtIaIyn1yMkIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926128; c=relaxed/simple;
	bh=ksWB5SCvOzZmxY+jBYU17u4BkSqbC4ISa/QdfLCKwPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s0R3k/lwnQgiqo9HtBtMyDoqSD+vZZb6KWCZuMto9IgzDe28wzI0Ago2glQ4YBnPy00GPUNLt0AjIm7cNOdkbVcx/vv+m+HGqJJL/7xn2kpWHaFtrIN28ZyPosaoIssUhQ295gvTJUsS+TfLs/mcww8qLt34a14a/YydKdvb7no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso3402992b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 19:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760926120; x=1761530920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oU8FsCdSRe6kWhniaY+u65ahdL+FKYQj4L2x0aKlGbo=;
        b=bHARY+Ueyq2Z5dVb/ABZi3IFwYuy3q760od6swDqN1Iu7NUA2V2xeSLPLW+Dw6F4Hp
         PeO1KmIE4SP/eTmynPbNVT0sMBPCyOdRFJo1s8zG8fLjeknZP5zrx9XGALbTRUCJDudk
         cZ79DFcQKP/I/3IfqwZhLdIM+X90iPUUPTJ1VJDm1HATyA8fkOIlNRExwArpm3fV9xy3
         mB+q+geq/MDY/yXhHtIXuqtdHMdXrm2YibTWOa2QckVid+9KR1sOj8Ypcfp1p8RrtSNx
         m73iwW8WSBAHF65FiF0i87NDbtsZOjNSqNNqSWo9/ZUJoqGaC+xZch73SIvKbYe1hmA2
         gYZw==
X-Gm-Message-State: AOJu0YwnJq+9jKLq4KbGd7RgXrijeLecev7yvFAi3W1ca4RTL1seGfsn
	a6R6SuPsNO0aaIpgmVRS/RN/ex1jFopGs17QzeKolnauuCjgwMjixTqw
X-Gm-Gg: ASbGncvzy1fq+3ozAk/dhV7YOu2vFKLBzR17i8q+pFDZeO5CbO9DLhNTBVk7F47vz+4
	TU8zeTxpaGg9BXw8N5SN6gN9WyB7w1phsUiCoeLrwm7dWU/3v94DepC+oobS8J5b6OjXAQtGSEK
	2fltSh2SICIxsJMS5KDwAGmKrbFt6simKmAARTkPM32dkP+cTblV4dQsoCHxM1CevHaGhO4RjUo
	eoj5UQ0tzape6zjZLeTKStKUs//XJm40txCbiV84ii9NXcVFQf5lnI9lOH5Wq48AN859iLI3n5m
	j8BKUi9HbFmYhYe9YIEQFd0uYnDUOUwdMNGg5rZgE3f/mcboftfLx3NWZWgauVP1ZFtug5zz6/p
	XwhhBrz6Uyqqw0EjTTrIQgQD0MPtqAjKWQ2DBfHdKctL/D8Vjk0Ym/0ARA5FFWGlZyzfxjFXiET
	HMEVX+7XHomFWBbRIQ35ekvHv9uA==
X-Google-Smtp-Source: AGHT+IGgoj5qQKLc4WS8eCO4hF/PHItgPeX/aAs9VQ/3pN2zWZI43Z015rqRmE+KkIk4j4SATR/EUA==
X-Received: by 2002:a05:6a00:b8d:b0:781:15b0:bed9 with SMTP id d2e1a72fcca58-7a220ab6c38mr14163241b3a.17.1760926118712;
        Sun, 19 Oct 2025 19:08:38 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010df83sm6722300b3a.59.2025.10.19.19.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 19:08:37 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@infradead.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 01/11] ntfsplus: in-memory, on-disk structures and headers
Date: Mon, 20 Oct 2025 11:07:39 +0900
Message-Id: <20251020020749.5522-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251020020749.5522-1-linkinjeon@kernel.org>
References: <20251020020749.5522-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds in-memory and on-disk structures and headers.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfsplus/aops.h        |   92 ++
 fs/ntfsplus/attrib.h      |  159 +++
 fs/ntfsplus/attrlist.h    |   21 +
 fs/ntfsplus/bitmap.h      |   90 ++
 fs/ntfsplus/collate.h     |   37 +
 fs/ntfsplus/dir.h         |   33 +
 fs/ntfsplus/ea.h          |   25 +
 fs/ntfsplus/index.h       |  127 ++
 fs/ntfsplus/inode.h       |  354 ++++++
 fs/ntfsplus/layout.h      | 2288 +++++++++++++++++++++++++++++++++++++
 fs/ntfsplus/lcnalloc.h    |  127 ++
 fs/ntfsplus/logfile.h     |  316 +++++
 fs/ntfsplus/mft.h         |   93 ++
 fs/ntfsplus/misc.h        |  218 ++++
 fs/ntfsplus/ntfs.h        |  172 +++
 fs/ntfsplus/ntfs_iomap.h  |   22 +
 fs/ntfsplus/reparse.h     |   15 +
 fs/ntfsplus/runlist.h     |   91 ++
 fs/ntfsplus/volume.h      |  241 ++++
 include/uapi/linux/ntfs.h |   23 +
 20 files changed, 4544 insertions(+)
 create mode 100644 fs/ntfsplus/aops.h
 create mode 100644 fs/ntfsplus/attrib.h
 create mode 100644 fs/ntfsplus/attrlist.h
 create mode 100644 fs/ntfsplus/bitmap.h
 create mode 100644 fs/ntfsplus/collate.h
 create mode 100644 fs/ntfsplus/dir.h
 create mode 100644 fs/ntfsplus/ea.h
 create mode 100644 fs/ntfsplus/index.h
 create mode 100644 fs/ntfsplus/inode.h
 create mode 100644 fs/ntfsplus/layout.h
 create mode 100644 fs/ntfsplus/lcnalloc.h
 create mode 100644 fs/ntfsplus/logfile.h
 create mode 100644 fs/ntfsplus/mft.h
 create mode 100644 fs/ntfsplus/misc.h
 create mode 100644 fs/ntfsplus/ntfs.h
 create mode 100644 fs/ntfsplus/ntfs_iomap.h
 create mode 100644 fs/ntfsplus/reparse.h
 create mode 100644 fs/ntfsplus/runlist.h
 create mode 100644 fs/ntfsplus/volume.h
 create mode 100644 include/uapi/linux/ntfs.h

diff --git a/fs/ntfsplus/aops.h b/fs/ntfsplus/aops.h
new file mode 100644
index 000000000000..333bbae8c566
--- /dev/null
+++ b/fs/ntfsplus/aops.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/**
+ * Defines for NTFS kernel address space operations and page cache
+ * handling.
+ *
+ * Copyright (c) 2001-2004 Anton Altaparmakov
+ * Copyright (c) 2002 Richard Russon
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#ifndef _LINUX_NTFS_AOPS_H
+#define _LINUX_NTFS_AOPS_H
+
+#include <linux/pagemap.h>
+#include <linux/iomap.h>
+
+#include "volume.h"
+#include "inode.h"
+
+/**
+ * ntfs_unmap_folio - release a folio that was mapped using ntfs_folio_page()
+ * @folio:	the folio to release
+ *
+ * Unpin, unmap and release a folio that was obtained from ntfs_folio_page().
+ */
+static inline void ntfs_unmap_folio(struct folio *folio, void *addr)
+{
+	if (addr)
+		kunmap_local(addr);
+	folio_put(folio);
+}
+
+/**
+ * ntfs_read_mapping_folio - map a folio into accessible memory, reading it if necessary
+ * @mapping:	address space for which to obtain the page
+ * @index:	index into the page cache for @mapping of the page to map
+ *
+ * Read a page from the page cache of the address space @mapping at position
+ * @index, where @index is in units of PAGE_SIZE, and not in bytes.
+ *
+ * If the page is not in memory it is loaded from disk first using the
+ * read_folio method defined in the address space operations of @mapping
+ * and the page is added to the page cache of @mapping in the process.
+ *
+ * If the page belongs to an mst protected attribute and it is marked as such
+ * in its ntfs inode (NInoMstProtected()) the mst fixups are applied but no
+ * error checking is performed.  This means the caller has to verify whether
+ * the ntfs record(s) contained in the page are valid or not using one of the
+ * ntfs_is_XXXX_record{,p}() macros, where XXXX is the record type you are
+ * expecting to see.  (For details of the macros, see fs/ntfs/layout.h.)
+ *
+ * If the page is in high memory it is mapped into memory directly addressible
+ * by the kernel.
+ *
+ * Finally the page count is incremented, thus pinning the page into place.
+ *
+ * The above means that page_address(page) can be used on all pages obtained
+ * with ntfs_map_page() to get the kernel virtual address of the page.
+ *
+ * When finished with the page, the caller has to call ntfs_unmap_page() to
+ * unpin, unmap and release the page.
+ *
+ * Note this does not grant exclusive access. If such is desired, the caller
+ * must provide it independently of the ntfs_{un}map_page() calls by using
+ * a {rw_}semaphore or other means of serialization. A spin lock cannot be
+ * used as ntfs_map_page() can block.
+ *
+ * The unlocked and uptodate page is returned on success or an encoded error
+ * on failure. Caller has to test for error using the IS_ERR() macro on the
+ * return value. If that evaluates to 'true', the negative error code can be
+ * obtained using PTR_ERR() on the return value of ntfs_map_page().
+ */
+static inline struct folio *ntfs_read_mapping_folio(struct address_space *mapping,
+		unsigned long index)
+{
+	struct folio *folio;
+
+retry:
+	folio = read_mapping_folio(mapping, index, NULL);
+	if (PTR_ERR(folio) == -EINTR)
+		goto retry;
+
+	return folio;
+}
+
+void mark_ntfs_record_dirty(struct folio *folio);
+struct bio *ntfs_setup_bio(struct ntfs_volume *vol, unsigned int opf, s64 lcn,
+		unsigned int pg_ofs);
+int ntfs_dev_read(struct super_block *sb, void *buf, loff_t start, loff_t end);
+int ntfs_dev_write(struct super_block *sb, void *buf, loff_t start,
+			loff_t size, bool wait);
+#endif /* _LINUX_NTFS_AOPS_H */
diff --git a/fs/ntfsplus/attrib.h b/fs/ntfsplus/attrib.h
new file mode 100644
index 000000000000..e7991851dc9a
--- /dev/null
+++ b/fs/ntfsplus/attrib.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Defines for attribute handling in NTFS Linux kernel driver.
+ * Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2001-2005 Anton Altaparmakov
+ * Copyright (c) 2002 Richard Russon
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#ifndef _LINUX_NTFS_ATTRIB_H
+#define _LINUX_NTFS_ATTRIB_H
+
+#include "ntfs.h"
+#include "dir.h"
+
+extern __le16 AT_UNNAMED[];
+
+/**
+ * ntfs_attr_search_ctx - used in attribute search functions
+ * @mrec:	buffer containing mft record to search
+ * @attr:	attribute record in @mrec where to begin/continue search
+ * @is_first:	if true ntfs_attr_lookup() begins search with @attr, else after
+ *
+ * Structure must be initialized to zero before the first call to one of the
+ * attribute search functions. Initialize @mrec to point to the mft record to
+ * search, and @attr to point to the first attribute within @mrec (not necessary
+ * if calling the _first() functions), and set @is_first to 'true' (not necessary
+ * if calling the _first() functions).
+ *
+ * If @is_first is 'true', the search begins with @attr. If @is_first is 'false',
+ * the search begins after @attr. This is so that, after the first call to one
+ * of the search attribute functions, we can call the function again, without
+ * any modification of the search context, to automagically get the next
+ * matching attribute.
+ */
+struct ntfs_attr_search_ctx {
+	struct mft_record *mrec;
+	bool mapped_mrec;
+	struct attr_record *attr;
+	bool is_first;
+	struct ntfs_inode *ntfs_ino;
+	struct attr_list_entry *al_entry;
+	struct ntfs_inode *base_ntfs_ino;
+	struct mft_record *base_mrec;
+	bool mapped_base_mrec;
+	struct attr_record *base_attr;
+};
+
+enum {                  /* ways of processing holes when expanding */
+	HOLES_NO,
+	HOLES_OK,
+};
+
+int ntfs_map_runlist_nolock(struct ntfs_inode *ni, s64 vcn,
+		struct ntfs_attr_search_ctx *ctx);
+int ntfs_map_runlist(struct ntfs_inode *ni, s64 vcn);
+s64 ntfs_attr_vcn_to_lcn_nolock(struct ntfs_inode *ni, const s64 vcn,
+		const bool write_locked);
+struct runlist_element *ntfs_attr_find_vcn_nolock(struct ntfs_inode *ni,
+		const s64 vcn, struct ntfs_attr_search_ctx *ctx);
+struct runlist_element *__ntfs_attr_find_vcn_nolock(struct runlist *runlist,
+		const s64 vcn);
+int ntfs_attr_map_whole_runlist(struct ntfs_inode *ni);
+int ntfs_attr_lookup(const __le32 type, const __le16 *name,
+		const u32 name_len, const u32 ic,
+		const s64 lowest_vcn, const u8 *val, const u32 val_len,
+		struct ntfs_attr_search_ctx *ctx);
+int load_attribute_list(struct ntfs_inode *base_ni,
+			       u8 *al_start, const s64 size);
+
+static inline s64 ntfs_attr_size(const struct attr_record *a)
+{
+	if (!a->non_resident)
+		return (s64)le32_to_cpu(a->data.resident.value_length);
+	return le64_to_cpu(a->data.non_resident.data_size);
+}
+
+void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx);
+struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inode *ni,
+		struct mft_record *mrec);
+void ntfs_attr_put_search_ctx(struct ntfs_attr_search_ctx *ctx);
+int ntfs_attr_size_bounds_check(const struct ntfs_volume *vol,
+		const __le32 type, const s64 size);
+int ntfs_attr_can_be_resident(const struct ntfs_volume *vol,
+		const __le32 type);
+int ntfs_attr_map_cluster(struct ntfs_inode *ni, s64 vcn_start, s64 *lcn_start,
+		s64 *lcn_count, s64 max_clu_count, bool *balloc, bool update_mp, bool skip_holes);
+int ntfs_attr_record_resize(struct mft_record *m, struct attr_record *a, u32 new_size);
+int ntfs_resident_attr_value_resize(struct mft_record *m, struct attr_record *a,
+		const u32 new_size);
+int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size);
+int ntfs_attr_set(struct ntfs_inode *ni, const s64 ofs, const s64 cnt,
+		const u8 val);
+int ntfs_attr_set_initialized_size(struct ntfs_inode *ni, loff_t new_size);
+int ntfs_attr_open(struct ntfs_inode *ni, const __le32 type,
+		__le16 *name, u32 name_len);
+void ntfs_attr_close(struct ntfs_inode *n);
+int ntfs_attr_fallocate(struct ntfs_inode *ni, loff_t start, loff_t byte_len, bool keep_size);
+int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 start_vcn, s64 len);
+int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 start_vcn, s64 len);
+int ntfs_non_resident_attr_punch_hole(struct ntfs_inode *ni, s64 start_vcn, s64 len);
+int __ntfs_attr_truncate_vfs(struct ntfs_inode *ni, const s64 newsize,
+		const s64 i_size);
+int ntfs_attr_expand(struct ntfs_inode *ni, const s64 newsize, const s64 prealloc_size);
+int ntfs_attr_truncate_i(struct ntfs_inode *ni, const s64 newsize, unsigned int holes);
+int ntfs_attr_truncate(struct ntfs_inode *ni, const s64 newsize);
+int ntfs_attr_rm(struct ntfs_inode *ni);
+int ntfs_attr_exist(struct ntfs_inode *ni, const __le32 type, __le16 *name,
+		u32 name_len);
+int ntfs_attr_remove(struct ntfs_inode *ni, const __le32 type, __le16 *name,
+		u32 name_len);
+int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx);
+int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct ntfs_inode *ni);
+int ntfs_attr_add(struct ntfs_inode *ni, __le32 type,
+		__le16 *name, u8 name_len, u8 *val, s64 size);
+int ntfs_attr_record_move_away(struct ntfs_attr_search_ctx *ctx, int extra);
+char *ntfs_attr_name_get(const struct ntfs_volume *vol, const __le16 *uname,
+		const int uname_len);
+void ntfs_attr_name_free(unsigned char **name);
+void *ntfs_attr_readall(struct ntfs_inode *ni, const __le32 type,
+		__le16 *name, u32 name_len, s64 *data_size);
+int ntfs_resident_attr_record_add(struct ntfs_inode *ni, __le32 type,
+		__le16 *name, u8 name_len, u8 *val, u32 size,
+		__le16 flags);
+int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn);
+struct runlist_element *ntfs_attr_vcn_to_rl(struct ntfs_inode *ni, s64 vcn, s64 *lcn);
+
+/**
+ * ntfs_attrs_walk - syntactic sugar for walking all attributes in an inode
+ * @ctx:	initialised attribute search context
+ *
+ * Syntactic sugar for walking attributes in an inode.
+ *
+ * Return 0 on success and -1 on error with errno set to the error code from
+ * ntfs_attr_lookup().
+ *
+ * Example: When you want to enumerate all attributes in an open ntfs inode
+ *	    @ni, you can simply do:
+ *
+ *	int err;
+ *	struct ntfs_attr_search_ctx *ctx = ntfs_attr_get_search_ctx(ni, NULL);
+ *	if (!ctx)
+ *		// Error code is in errno. Handle this case.
+ *	while (!(err = ntfs_attrs_walk(ctx))) {
+ *		struct attr_record *attr = ctx->attr;
+ *		// attr now contains the next attribute. Do whatever you want
+ *		// with it and then just continue with the while loop.
+ *	}
+ *	if (err && errno != ENOENT)
+ *		// Ooops. An error occurred! You should handle this case.
+ *	// Now finished with all attributes in the inode.
+ */
+static inline int ntfs_attrs_walk(struct ntfs_attr_search_ctx *ctx)
+{
+	return ntfs_attr_lookup(AT_UNUSED, NULL, 0, CASE_SENSITIVE, 0,
+			NULL, 0, ctx);
+}
+#endif /* _LINUX_NTFS_ATTRIB_H */
diff --git a/fs/ntfsplus/attrlist.h b/fs/ntfsplus/attrlist.h
new file mode 100644
index 000000000000..d0eadc5db1b0
--- /dev/null
+++ b/fs/ntfsplus/attrlist.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Exports for attribute list attribute handling.
+ * Originated from Linux-NTFS project.
+ *
+ * Copyright (c) 2004 Anton Altaparmakov
+ * Copyright (c) 2004 Yura Pakhuchiy
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#ifndef _NTFS_ATTRLIST_H
+#define _NTFS_ATTRLIST_H
+
+#include "attrib.h"
+
+int ntfs_attrlist_need(struct ntfs_inode *ni);
+int ntfs_attrlist_entry_add(struct ntfs_inode *ni, struct attr_record *attr);
+int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx);
+int ntfs_attrlist_update(struct ntfs_inode *base_ni);
+
+#endif /* defined _NTFS_ATTRLIST_H */
diff --git a/fs/ntfsplus/bitmap.h b/fs/ntfsplus/bitmap.h
new file mode 100644
index 000000000000..9d8c3c5b16ac
--- /dev/null
+++ b/fs/ntfsplus/bitmap.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Defines for NTFS kernel bitmap handling.  Part of the Linux-NTFS
+ * project.
+ *
+ * Copyright (c) 2004 Anton Altaparmakov
+ */
+
+#ifndef _LINUX_NTFS_BITMAP_H
+#define _LINUX_NTFS_BITMAP_H
+
+#include <linux/fs.h>
+
+int __ntfs_bitmap_set_bits_in_run(struct inode *vi, const s64 start_bit,
+		const s64 count, const u8 value, const bool is_rollback);
+
+/**
+ * ntfs_bitmap_set_bits_in_run - set a run of bits in a bitmap to a value
+ * @vi:			vfs inode describing the bitmap
+ * @start_bit:		first bit to set
+ * @count:		number of bits to set
+ * @value:		value to set the bits to (i.e. 0 or 1)
+ *
+ * Set @count bits starting at bit @start_bit in the bitmap described by the
+ * vfs inode @vi to @value, where @value is either 0 or 1.
+ */
+static inline int ntfs_bitmap_set_bits_in_run(struct inode *vi,
+		const s64 start_bit, const s64 count, const u8 value)
+{
+	return __ntfs_bitmap_set_bits_in_run(vi, start_bit, count, value,
+			false);
+}
+
+/**
+ * ntfs_bitmap_set_run - set a run of bits in a bitmap
+ * @vi:		vfs inode describing the bitmap
+ * @start_bit:	first bit to set
+ * @count:	number of bits to set
+ *
+ * Set @count bits starting at bit @start_bit in the bitmap described by the
+ * vfs inode @vi.
+ *
+ * Return 0 on success and -errno on error.
+ */
+static inline int ntfs_bitmap_set_run(struct inode *vi, const s64 start_bit,
+		const s64 count)
+{
+	return ntfs_bitmap_set_bits_in_run(vi, start_bit, count, 1);
+}
+
+/**
+ * ntfs_bitmap_clear_run - clear a run of bits in a bitmap
+ * @vi:		vfs inode describing the bitmap
+ * @start_bit:	first bit to clear
+ * @count:	number of bits to clear
+ *
+ * Clear @count bits starting at bit @start_bit in the bitmap described by the
+ * vfs inode @vi.
+ */
+static inline int ntfs_bitmap_clear_run(struct inode *vi, const s64 start_bit,
+		const s64 count)
+{
+	return ntfs_bitmap_set_bits_in_run(vi, start_bit, count, 0);
+}
+
+/**
+ * ntfs_bitmap_set_bit - set a bit in a bitmap
+ * @vi:		vfs inode describing the bitmap
+ * @bit:	bit to set
+ *
+ * Set bit @bit in the bitmap described by the vfs inode @vi.
+ */
+static inline int ntfs_bitmap_set_bit(struct inode *vi, const s64 bit)
+{
+	return ntfs_bitmap_set_run(vi, bit, 1);
+}
+
+/**
+ * ntfs_bitmap_clear_bit - clear a bit in a bitmap
+ * @vi:		vfs inode describing the bitmap
+ * @bit:	bit to clear
+ *
+ * Clear bit @bit in the bitmap described by the vfs inode @vi.
+ */
+static inline int ntfs_bitmap_clear_bit(struct inode *vi, const s64 bit)
+{
+	return ntfs_bitmap_clear_run(vi, bit, 1);
+}
+
+#endif /* defined _LINUX_NTFS_BITMAP_H */
diff --git a/fs/ntfsplus/collate.h b/fs/ntfsplus/collate.h
new file mode 100644
index 000000000000..cf04508340f0
--- /dev/null
+++ b/fs/ntfsplus/collate.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Defines for NTFS kernel collation handling.
+ * Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2004 Anton Altaparmakov
+ *
+ * Part of this file is based on code from the NTFS-3G project.
+ * and is copyrighted by the respective authors below:
+ * Copyright (c) 2004 Anton Altaparmakov
+ * Copyright (c) 2005 Yura Pakhuchiy
+ */
+
+#ifndef _LINUX_NTFS_COLLATE_H
+#define _LINUX_NTFS_COLLATE_H
+
+#include "volume.h"
+
+static inline bool ntfs_is_collation_rule_supported(__le32 cr)
+{
+	int i;
+
+	if (unlikely(cr != COLLATION_BINARY && cr != COLLATION_NTOFS_ULONG &&
+		     cr != COLLATION_FILE_NAME) && cr != COLLATION_NTOFS_ULONGS)
+		return false;
+	i = le32_to_cpu(cr);
+	if (likely(((i >= 0) && (i <= 0x02)) ||
+			((i >= 0x10) && (i <= 0x13))))
+		return true;
+	return false;
+}
+
+int ntfs_collate(struct ntfs_volume *vol, __le32 cr,
+		const void *data1, const int data1_len,
+		const void *data2, const int data2_len);
+
+#endif /* _LINUX_NTFS_COLLATE_H */
diff --git a/fs/ntfsplus/dir.h b/fs/ntfsplus/dir.h
new file mode 100644
index 000000000000..5abe21c3d938
--- /dev/null
+++ b/fs/ntfsplus/dir.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Defines for directory handling in NTFS Linux kernel driver.
+ * Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2002-2004 Anton Altaparmakov
+ */
+
+#ifndef _LINUX_NTFS_DIR_H
+#define _LINUX_NTFS_DIR_H
+
+#include "inode.h"
+
+/*
+ * ntfs_name is used to return the file name to the caller of
+ * ntfs_lookup_inode_by_name() in order for the caller (namei.c::ntfs_lookup())
+ * to be able to deal with dcache aliasing issues.
+ */
+struct ntfs_name {
+	u64 mref;
+	u8 type;
+	u8 len;
+	__le16 name[];
+} __packed;
+
+/* The little endian Unicode string $I30 as a global constant. */
+extern __le16 I30[5];
+
+u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir_ni,
+		const __le16 *uname, const int uname_len, struct ntfs_name **res);
+int ntfs_check_empty_dir(struct ntfs_inode *ni, struct mft_record *ni_mrec);
+
+#endif /* _LINUX_NTFS_FS_DIR_H */
diff --git a/fs/ntfsplus/ea.h b/fs/ntfsplus/ea.h
new file mode 100644
index 000000000000..b2e678566eb0
--- /dev/null
+++ b/fs/ntfsplus/ea.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#define NTFS_EA_UID	BIT(1)
+#define NTFS_EA_GID	BIT(2)
+#define NTFS_EA_MODE	BIT(3)
+
+extern const struct xattr_handler *const ntfs_xattr_handlers[];
+
+int ntfs_ea_set_wsl_not_symlink(struct ntfs_inode *ni, mode_t mode, dev_t dev);
+int ntfs_ea_get_wsl_inode(struct inode *inode, dev_t *rdevp, unsigned int flags);
+int ntfs_ea_set_wsl_inode(struct inode *inode, dev_t rdev, __le16 *ea_size,
+		unsigned int flags);
+ssize_t ntfs_listxattr(struct dentry *dentry, char *buffer, size_t size);
+
+#ifdef CONFIG_NTFSPLUS_FS_POSIX_ACL
+struct posix_acl *ntfs_get_acl(struct mnt_idmap *idmap, struct dentry *dentry,
+			       int type);
+int ntfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
+		 struct posix_acl *acl, int type);
+int ntfs_init_acl(struct mnt_idmap *idmap, struct inode *inode,
+		  struct inode *dir);
+#else
+#define ntfs_get_acl NULL
+#define ntfs_set_acl NULL
+#endif
diff --git a/fs/ntfsplus/index.h b/fs/ntfsplus/index.h
new file mode 100644
index 000000000000..b5c719910ab6
--- /dev/null
+++ b/fs/ntfsplus/index.h
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Defines for NTFS kernel index handling.  Part of the Linux-NTFS
+ * project.
+ *
+ * Copyright (c) 2004 Anton Altaparmakov
+ */
+
+#ifndef _LINUX_NTFS_INDEX_H
+#define _LINUX_NTFS_INDEX_H
+
+#include <linux/fs.h>
+
+#include "attrib.h"
+#include "mft.h"
+#include "aops.h"
+
+#define  VCN_INDEX_ROOT_PARENT  ((s64)-2)
+
+#define MAX_PARENT_VCN	32
+
+/**
+ * @idx_ni:	index inode containing the @entry described by this context
+ * @entry:	index entry (points into @ir or @ia)
+ * @data:	index entry data (points into @entry)
+ * @data_len:	length in bytes of @data
+ * @is_in_root:	'true' if @entry is in @ir and 'false' if it is in @ia
+ * @ir:		index root if @is_in_root and NULL otherwise
+ * @actx:	attribute search context if @is_in_root and NULL otherwise
+ * @base_ni:	base inode if @is_in_root and NULL otherwise
+ * @ia:		index block if @is_in_root is 'false' and NULL otherwise
+ * @page:	page if @is_in_root is 'false' and NULL otherwise
+ *
+ * @idx_ni is the index inode this context belongs to.
+ *
+ * @entry is the index entry described by this context.  @data and @data_len
+ * are the index entry data and its length in bytes, respectively.  @data
+ * simply points into @entry.  This is probably what the user is interested in.
+ *
+ * If @is_in_root is 'true', @entry is in the index root attribute @ir described
+ * by the attribute search context @actx and the base inode @base_ni.  @ia and
+ * @page are NULL in this case.
+ *
+ * If @is_in_root is 'false', @entry is in the index allocation attribute and @ia
+ * and @page point to the index allocation block and the mapped, locked page it
+ * is in, respectively.  @ir, @actx and @base_ni are NULL in this case.
+ *
+ * To obtain a context call ntfs_index_ctx_get().
+ *
+ * We use this context to allow ntfs_index_lookup() to return the found index
+ * @entry and its @data without having to allocate a buffer and copy the @entry
+ * and/or its @data into it.
+ *
+ * When finished with the @entry and its @data, call ntfs_index_ctx_put() to
+ * free the context and other associated resources.
+ *
+ * If the index entry was modified, call flush_dcache_index_entry_page()
+ * immediately after the modification and either ntfs_index_entry_mark_dirty()
+ * or ntfs_index_entry_write() before the call to ntfs_index_ctx_put() to
+ * ensure that the changes are written to disk.
+ */
+struct ntfs_index_context {
+	struct ntfs_inode *idx_ni;
+	__le16 *name;
+	u32 name_len;
+	struct index_entry *entry;
+	__le32 cr;
+	void *data;
+	u16 data_len;
+	bool is_in_root;
+	struct index_root *ir;
+	struct ntfs_attr_search_ctx *actx;
+	struct index_block *ib;
+	struct ntfs_inode *base_ni;
+	struct index_block *ia;
+	struct page *page;
+	struct ntfs_inode *ia_ni;
+	int parent_pos[MAX_PARENT_VCN];  /* parent entries' positions */
+	s64 parent_vcn[MAX_PARENT_VCN]; /* entry's parent nodes */
+	int pindex;          /* maximum it's the number of the parent nodes  */
+	bool ib_dirty;
+	u32 block_size;
+	u8 vcn_size_bits;
+	bool sync_write;
+};
+
+int ntfs_index_entry_inconsistent(struct ntfs_index_context *icx, struct ntfs_volume *vol,
+		const struct index_entry *ie, __le32 collation_rule, u64 inum);
+struct ntfs_index_context *ntfs_index_ctx_get(struct ntfs_inode *ni, __le16 *name,
+		u32 name_len);
+void ntfs_index_ctx_put(struct ntfs_index_context *ictx);
+int ntfs_index_lookup(const void *key, const int key_len,
+		struct ntfs_index_context *ictx);
+
+/**
+ * ntfs_index_entry_flush_dcache_page - flush_dcache_page() for index entries
+ * @ictx:	ntfs index context describing the index entry
+ *
+ * Call flush_dcache_page() for the page in which an index entry resides.
+ *
+ * This must be called every time an index entry is modified, just after the
+ * modification.
+ *
+ * If the index entry is in the index root attribute, simply flush the page
+ * containing the mft record containing the index root attribute.
+ *
+ * If the index entry is in an index block belonging to the index allocation
+ * attribute, simply flush the page cache page containing the index block.
+ */
+static inline void ntfs_index_entry_flush_dcache_page(struct ntfs_index_context *ictx)
+{
+	if (!ictx->is_in_root)
+		flush_dcache_page(ictx->page);
+}
+
+void ntfs_index_entry_mark_dirty(struct ntfs_index_context *ictx);
+int ntfs_index_add_filename(struct ntfs_inode *ni, struct file_name_attr *fn, u64 mref);
+int ntfs_index_remove(struct ntfs_inode *ni, const void *key, const int keylen);
+struct ntfs_inode *ntfs_ia_open(struct ntfs_index_context *icx, struct ntfs_inode *ni);
+struct index_entry *ntfs_index_walk_down(struct index_entry *ie, struct ntfs_index_context *ictx);
+struct index_entry *ntfs_index_next(struct index_entry *ie, struct ntfs_index_context *ictx);
+int ntfs_index_rm(struct ntfs_index_context *icx);
+void ntfs_index_ctx_reinit(struct ntfs_index_context *icx);
+int ntfs_ie_add(struct ntfs_index_context *icx, struct index_entry *ie);
+int ntfs_icx_ib_sync_write(struct ntfs_index_context *icx);
+
+#endif /* _LINUX_NTFS_INDEX_H */
diff --git a/fs/ntfsplus/inode.h b/fs/ntfsplus/inode.h
new file mode 100644
index 000000000000..0966f59160df
--- /dev/null
+++ b/fs/ntfsplus/inode.h
@@ -0,0 +1,354 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Defines for inode structures NTFS Linux kernel driver. Part of
+ * the Linux-NTFS project.
+ *
+ * Copyright (c) 2001-2007 Anton Altaparmakov
+ * Copyright (c) 2002 Richard Russon
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#ifndef _LINUX_NTFS_INODE_H
+#define _LINUX_NTFS_INODE_H
+
+#include "misc.h"
+#include <linux/version.h> // jnj Remove it for upstream
+
+enum ntfs_inode_mutex_lock_class {
+	NTFS_INODE_MUTEX_PARENT,
+	NTFS_INODE_MUTEX_NORMAL,
+	NTFS_INODE_MUTEX_PARENT_2,
+	NTFS_INODE_MUTEX_NORMAL_2,
+	NTFS_REPARSE_MUTEX_PARENT,
+	NTFS_EA_MUTEX_NORMAL
+};
+
+/*
+ * The NTFS in-memory inode structure. It is just used as an extension to the
+ * fields already provided in the VFS inode.
+ */
+struct ntfs_inode {
+	rwlock_t size_lock;	/* Lock serializing access to inode sizes. */
+	unsigned long state;	/*
+				 * NTFS specific flags describing this inode.
+				 * See ntfs_inode_state_bits below.
+				 */
+	__le32 flags;		/* Flags describing the file. (Copy from STANDARD_INFORMATION) */
+	unsigned long mft_no;	/* Number of the mft record / inode. */
+	u16 seq_no;		/* Sequence number of the mft record. */
+	atomic_t count;		/* Inode reference count for book keeping. */
+	struct ntfs_volume *vol; /* Pointer to the ntfs volume of this inode. */
+
+	/*
+	 * If NInoAttr() is true, the below fields describe the attribute which
+	 * this fake inode belongs to. The actual inode of this attribute is
+	 * pointed to by base_ntfs_ino and nr_extents is always set to -1 (see
+	 * below). For real inodes, we also set the type (AT_DATA for files and
+	 * AT_INDEX_ALLOCATION for directories), with the name = NULL and
+	 * name_len = 0 for files and name = I30 (global constant) and
+	 * name_len = 4 for directories.
+	 */
+	__le32 type;		/* Attribute type of this fake inode. */
+	__le16 *name;		/* Attribute name of this fake inode. */
+	u32 name_len;		/* Attribute name length of this fake inode. */
+	struct runlist runlist;	/*
+				 * If state has the NI_NonResident bit set,
+				 * the runlist of the unnamed data attribute
+				 * (if a file) or of the index allocation
+				 * attribute (directory) or of the attribute
+				 * described by the fake inode (if NInoAttr()).
+				 * If runlist.rl is NULL, the runlist has not
+				 * been read in yet or has been unmapped. If
+				 * NI_NonResident is clear, the attribute is
+				 * resident (file and fake inode) or there is
+				 * no $I30 index allocation attribute
+				 * (small directory). In the latter case
+				 * runlist.rl is always NULL.
+				 */
+	s64 lcn_seek_trunc;
+
+	s64 data_size;		/* Copy from the attribute record. */
+	s64 initialized_size;	/* Copy from the attribute record. */
+	s64 allocated_size;	/* Copy from the attribute record. */
+
+	struct timespec64 i_crtime;
+
+	/*
+	 * The following fields are only valid for real inodes and extent
+	 * inodes.
+	 */
+	void *mrec;
+	struct mutex mrec_lock;	/*
+				 * Lock for serializing access to the
+				 * mft record belonging to this inode.
+				 */
+	struct folio *folio;	/*
+				 * The folio containing the mft record of the
+				 * inode. This should only be touched by the
+				 * (un)map_mft_record*() functions.
+				 */
+	int folio_ofs;		/*
+				 * Offset into the folio at which the mft record
+				 * begins. This should only be touched by the
+				 * (un)map_mft_record*() functions.
+				 */
+	s64 mft_lcn[2];		/* s64 number containing the mft record */
+	unsigned int mft_lcn_count;
+
+	/*
+	 * Attribute list support (only for use by the attribute lookup
+	 * functions). Setup during read_inode for all inodes with attribute
+	 * lists. Only valid if NI_AttrList is set in state.
+	 */
+	u32 attr_list_size;	/* Length of attribute list value in bytes. */
+	u8 *attr_list;		/* Attribute list value itself. */
+
+	union {
+		struct { /* It is a directory, $MFT, or an index inode. */
+			u32 block_size;		/* Size of an index block. */
+			u32 vcn_size;		/* Size of a vcn in this index. */
+			__le32 collation_rule;	/* The collation rule for the index. */
+			u8 block_size_bits;	/* Log2 of the above. */
+			u8 vcn_size_bits;	/* Log2 of the above. */
+		} index;
+		struct { /* It is a compressed/sparse file/attribute inode. */
+			s64 size;		/* Copy of compressed_size from $DATA. */
+			u32 block_size;		/* Size of a compression block (cb). */
+			u8 block_size_bits;	/* Log2 of the size of a cb. */
+			u8 block_clusters;	/* Number of clusters per cb. */
+		} compressed;
+	} itype;
+	struct mutex extent_lock;	/* Lock for accessing/modifying the below . */
+	s32 nr_extents;	/*
+			 * For a base mft record, the number of attached extent\
+			 * inodes (0 if none), for extent records and for fake
+			 * inodes describing an attribute this is -1.
+			 */
+	union {		/* This union is only used if nr_extents != 0. */
+		struct ntfs_inode **extent_ntfs_inos;	/*
+							 * For nr_extents > 0, array of
+							 * the ntfs inodes of the extent
+							 * mft records belonging to
+							 * this base inode which have
+							 * been loaded.
+							 */
+		struct ntfs_inode *base_ntfs_ino;	/*
+							 * For nr_extents == -1, the
+							 * ntfs inode of the base mft
+							 * record. For fake inodes, the
+							 * real (base) inode to which
+							 * the attribute belongs.
+							 */
+	} ext;
+
+	unsigned int i_dealloc_clusters;
+	char *target;
+};
+
+/*
+ * Defined bits for the state field in the ntfs_inode structure.
+ * (f) = files only, (d) = directories only, (a) = attributes/fake inodes only
+ */
+enum {
+	NI_Dirty,		/* 1: Mft record needs to be written to disk. */
+	NI_AttrListDirty,	/* 1: Mft record contains an attribute list. */
+	NI_AttrList,		/* 1: Mft record contains an attribute list. */
+	NI_AttrListNonResident,	/*
+				 * 1: Attribute list is non-resident. Implies
+				 *    NI_AttrList is set.
+				 */
+
+	NI_Attr,		/*
+				 * 1: Fake inode for attribute i/o.
+				 * 0: Real inode or extent inode.
+				 */
+
+	NI_MstProtected,	/*
+				 * 1: Attribute is protected by MST fixups.
+				 * 0: Attribute is not protected by fixups.
+				 */
+	NI_NonResident,		/*
+				 * 1: Unnamed data attr is non-resident (f).
+				 * 1: Attribute is non-resident (a).
+				 */
+	NI_IndexAllocPresent,	/* 1: $I30 index alloc attr is present (d). */
+	NI_Compressed,		/*
+				 * 1: Unnamed data attr is compressed (f).
+				 * 1: Create compressed files by default (d).
+				 * 1: Attribute is compressed (a).
+				 */
+	NI_Encrypted,		/*
+				 * 1: Unnamed data attr is encrypted (f).
+				 * 1: Create encrypted files by default (d).
+				 * 1: Attribute is encrypted (a).
+				 */
+	NI_Sparse,		/*
+				 * 1: Unnamed data attr is sparse (f).
+				 * 1: Create sparse files by default (d).
+				 * 1: Attribute is sparse (a).
+				 */
+	NI_SparseDisabled,	/* 1: May not create sparse regions. */
+	NI_FullyMapped,
+	NI_FileNameDirty,
+	NI_BeingDeleted,
+	NI_BeingCreated,
+	NI_HasEA,
+	NI_RunlistDirty,
+};
+
+/*
+ * NOTE: We should be adding dirty mft records to a list somewhere and they
+ * should be independent of the (ntfs/vfs) inode structure so that an inode can
+ * be removed but the record can be left dirty for syncing later.
+ */
+
+/*
+ * Macro tricks to expand the NInoFoo(), NInoSetFoo(), and NInoClearFoo()
+ * functions.
+ */
+#define NINO_FNS(flag)						\
+static inline int NIno##flag(struct ntfs_inode *ni)		\
+{								\
+	return test_bit(NI_##flag, &(ni)->state);		\
+}								\
+static inline void NInoSet##flag(struct ntfs_inode *ni)		\
+{								\
+	set_bit(NI_##flag, &(ni)->state);			\
+}								\
+static inline void NInoClear##flag(struct ntfs_inode *ni)	\
+{								\
+	clear_bit(NI_##flag, &(ni)->state);			\
+}
+
+/*
+ * As above for NInoTestSetFoo() and NInoTestClearFoo().
+ */
+#define TAS_NINO_FNS(flag)						\
+static inline int NInoTestSet##flag(struct ntfs_inode *ni)		\
+{									\
+	return test_and_set_bit(NI_##flag, &(ni)->state);		\
+}									\
+static inline int NInoTestClear##flag(struct ntfs_inode *ni)		\
+{									\
+	return test_and_clear_bit(NI_##flag, &(ni)->state);		\
+}
+
+/* Emit the ntfs inode bitops functions. */
+NINO_FNS(Dirty)
+TAS_NINO_FNS(Dirty)
+NINO_FNS(AttrList)
+NINO_FNS(AttrListDirty)
+NINO_FNS(AttrListNonResident)
+NINO_FNS(Attr)
+NINO_FNS(MstProtected)
+NINO_FNS(NonResident)
+NINO_FNS(IndexAllocPresent)
+NINO_FNS(Compressed)
+NINO_FNS(Encrypted)
+NINO_FNS(Sparse)
+NINO_FNS(SparseDisabled)
+NINO_FNS(FullyMapped)
+NINO_FNS(FileNameDirty)
+TAS_NINO_FNS(FileNameDirty)
+NINO_FNS(BeingDeleted)
+NINO_FNS(HasEA)
+NINO_FNS(RunlistDirty)
+
+/*
+ * The full structure containing a ntfs_inode and a vfs struct inode. Used for
+ * all real and fake inodes but not for extent inodes which lack the vfs struct
+ * inode.
+ */
+struct big_ntfs_inode {
+	struct ntfs_inode ntfs_inode;
+	struct inode vfs_inode;		/* The vfs inode structure. */
+};
+
+/**
+ * NTFS_I - return the ntfs inode given a vfs inode
+ * @inode:	VFS inode
+ *
+ * NTFS_I() returns the ntfs inode associated with the VFS @inode.
+ */
+static inline struct ntfs_inode *NTFS_I(struct inode *inode)
+{
+	return (struct ntfs_inode *)container_of(inode, struct big_ntfs_inode, vfs_inode);
+}
+
+static inline struct inode *VFS_I(struct ntfs_inode *ni)
+{
+	return &((struct big_ntfs_inode *)ni)->vfs_inode;
+}
+
+/**
+ * ntfs_attr - ntfs in memory attribute structure
+ *
+ * This structure exists only to provide a small structure for the
+ * ntfs_{attr_}iget()/ntfs_test_inode()/ntfs_init_locked_inode() mechanism.
+ *
+ * NOTE: Elements are ordered by size to make the structure as compact as
+ * possible on all architectures.
+ */
+struct ntfs_attr {
+	unsigned long mft_no;
+	__le16 *name;
+	u32 name_len;
+	__le32 type;
+	unsigned long state;
+};
+
+int ntfs_test_inode(struct inode *vi, void *data);
+struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no);
+struct inode *ntfs_attr_iget(struct inode *base_vi, __le32 type,
+		__le16 *name, u32 name_len);
+struct inode *ntfs_index_iget(struct inode *base_vi, __le16 *name,
+		u32 name_len);
+struct inode *ntfs_alloc_big_inode(struct super_block *sb);
+void ntfs_free_big_inode(struct inode *inode);
+int ntfs_drop_big_inode(struct inode *inode);
+void ntfs_evict_big_inode(struct inode *vi);
+void __ntfs_init_inode(struct super_block *sb, struct ntfs_inode *ni);
+
+static inline void ntfs_init_big_inode(struct inode *vi)
+{
+	struct ntfs_inode *ni = NTFS_I(vi);
+
+	ntfs_debug("Entering.");
+	__ntfs_init_inode(vi->i_sb, ni);
+	ni->mft_no = vi->i_ino;
+}
+
+struct ntfs_inode *ntfs_new_extent_inode(struct super_block *sb,
+		unsigned long mft_no);
+void ntfs_clear_extent_inode(struct ntfs_inode *ni);
+int ntfs_read_inode_mount(struct inode *vi);
+int ntfs_show_options(struct seq_file *sf, struct dentry *root);
+int ntfs_truncate_vfs(struct inode *vi, loff_t new_size, loff_t i_size);
+
+int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		 struct iattr *attr);
+int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
+		struct kstat *stat, unsigned int request_mask,
+		unsigned int query_flags);
+
+int __ntfs_write_inode(struct inode *vi, int sync);
+int ntfs_inode_attach_all_extents(struct ntfs_inode *ni);
+int ntfs_inode_add_attrlist(struct ntfs_inode *ni);
+void ntfs_destroy_ext_inode(struct ntfs_inode *ni);
+int ntfs_inode_free_space(struct ntfs_inode *ni, int size);
+s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *buf);
+s64 ntfs_inode_attr_pwrite(struct inode *vi, s64 pos, s64 count, u8 *buf,
+		bool sync);
+int ntfs_inode_close(struct ntfs_inode *ni);
+
+static inline void ntfs_commit_inode(struct inode *vi)
+{
+	__ntfs_write_inode(vi, 1);
+}
+
+int ntfs_inode_sync_filename(struct ntfs_inode *ni);
+int ntfs_extend_initialized_size(struct inode *vi, const loff_t offset,
+		const loff_t new_size);
+void ntfs_set_vfs_operations(struct inode *inode, mode_t mode, dev_t dev);
+
+#endif /* _LINUX_NTFS_INODE_H */
diff --git a/fs/ntfsplus/layout.h b/fs/ntfsplus/layout.h
new file mode 100644
index 000000000000..d0067e4c975a
--- /dev/null
+++ b/fs/ntfsplus/layout.h
@@ -0,0 +1,2288 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * All NTFS associated on-disk structures. Part of the Linux-NTFS
+ * project.
+ *
+ * Copyright (c) 2001-2005 Anton Altaparmakov
+ * Copyright (c) 2002 Richard Russon
+ */
+
+#ifndef _LINUX_NTFS_LAYOUT_H
+#define _LINUX_NTFS_LAYOUT_H
+
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/list.h>
+#include <asm/byteorder.h>
+
+/* The NTFS oem_id "NTFS    " */
+#define magicNTFS	cpu_to_le64(0x202020205346544eULL)
+
+/*
+ * Location of bootsector on partition:
+ *	The standard NTFS_BOOT_SECTOR is on sector 0 of the partition.
+ *	On NT4 and above there is one backup copy of the boot sector to
+ *	be found on the last sector of the partition (not normally accessible
+ *	from within Windows as the bootsector contained number of sectors
+ *	value is one less than the actual value!).
+ *	On versions of NT 3.51 and earlier, the backup copy was located at
+ *	number of sectors/2 (integer divide), i.e. in the middle of the volume.
+ */
+
+/*
+ * BIOS parameter block (bpb) structure.
+ */
+struct bios_parameter_block {
+	__le16 bytes_per_sector;	/* Size of a sector in bytes. */
+	u8  sectors_per_cluster;	/* Size of a cluster in sectors. */
+	__le16 reserved_sectors;	/* zero */
+	u8  fats;			/* zero */
+	__le16 root_entries;		/* zero */
+	__le16 sectors;			/* zero */
+	u8  media_type;			/* 0xf8 = hard disk */
+	__le16 sectors_per_fat;		/* zero */
+	__le16 sectors_per_track;		/* irrelevant */
+	__le16 heads;			/* irrelevant */
+	__le32 hidden_sectors;		/* zero */
+	__le32 large_sectors;		/* zero */
+} __packed;
+
+/*
+ * NTFS boot sector structure.
+ */
+struct ntfs_boot_sector {
+	u8  jump[3];			/* Irrelevant (jump to boot up code).*/
+	__le64 oem_id;			/* Magic "NTFS    ". */
+	struct bios_parameter_block bpb;	/* See BIOS_PARAMETER_BLOCK. */
+	u8  unused[4];			/*
+					 * zero, NTFS diskedit.exe states that
+					 * this is actually:
+					 *	__u8 physical_drive;	// 0x80
+					 *	__u8 current_head;	// zero
+					 *	__u8 extended_boot_signature;
+					 *				// 0x80
+					 *	__u8 unused;		// zero
+					 */
+	__le64 number_of_sectors;	/*
+					 * Number of sectors in volume. Gives
+					 * maximum volume size of 2^63 sectors.
+					 * Assuming standard sector size of 512
+					 * bytes, the maximum byte size is
+					 * approx. 4.7x10^21 bytes. (-;
+					 */
+	__le64 mft_lcn;			/* Cluster location of mft data. */
+	__le64 mftmirr_lcn;		/* Cluster location of copy of mft. */
+	s8  clusters_per_mft_record;	/* Mft record size in clusters. */
+	u8  reserved0[3];		/* zero */
+	s8  clusters_per_index_record;	/* Index block size in clusters. */
+	u8  reserved1[3];		/* zero */
+	__le64 volume_serial_number;	/* Irrelevant (serial number). */
+	__le32 checksum;			/* Boot sector checksum. */
+	u8  bootstrap[426];		/* Irrelevant (boot up code). */
+	__le16 end_of_sector_marker;	/*
+					 * End of bootsector magic. Always is
+					 * 0xaa55 in little endian.
+					 */
+/* sizeof() = 512 (0x200) bytes */
+} __packed;
+
+/*
+ * Magic identifiers present at the beginning of all ntfs record containing
+ * records (like mft records for example).
+ */
+enum {
+	/* Found in $MFT/$DATA. */
+	magic_FILE = cpu_to_le32(0x454c4946), /* Mft entry. */
+	magic_INDX = cpu_to_le32(0x58444e49), /* Index buffer. */
+	magic_HOLE = cpu_to_le32(0x454c4f48), /* ? (NTFS 3.0+?) */
+
+	/* Found in LogFile/DATA. */
+	magic_RSTR = cpu_to_le32(0x52545352), /* Restart page. */
+	magic_RCRD = cpu_to_le32(0x44524352), /* Log record page. */
+
+	/* Found in LogFile/DATA.  (May be found in $MFT/$DATA, also?) */
+	magic_CHKD = cpu_to_le32(0x444b4843), /* Modified by chkdsk. */
+
+	/* Found in all ntfs record containing records. */
+	magic_BAAD = cpu_to_le32(0x44414142), /*
+					       * Failed multi sector
+					       * transfer was detected.
+					       */
+	/*
+	 * Found in LogFile/DATA when a page is full of 0xff bytes and is
+	 * thus not initialized.  Page must be initialized before using it.
+	 */
+	magic_empty = cpu_to_le32(0xffffffff) /* Record is empty. */
+};
+
+/*
+ * Generic magic comparison macros. Finally found a use for the ## preprocessor
+ * operator! (-8
+ */
+
+static inline bool __ntfs_is_magic(__le32 x, __le32 r)
+{
+	return (x == r);
+}
+#define ntfs_is_magic(x, m)	__ntfs_is_magic(x, magic_##m)
+
+static inline bool __ntfs_is_magicp(__le32 *p, __le32 r)
+{
+	return (*p == r);
+}
+#define ntfs_is_magicp(p, m)	__ntfs_is_magicp(p, magic_##m)
+
+/*
+ * Specialised magic comparison macros for the NTFS_RECORD_TYPEs defined above.
+ */
+#define ntfs_is_file_record(x)		(ntfs_is_magic(x, FILE))
+#define ntfs_is_file_recordp(p)		(ntfs_is_magicp(p, FILE))
+#define ntfs_is_mft_record(x)		(ntfs_is_file_record(x))
+#define ntfs_is_mft_recordp(p)		(ntfs_is_file_recordp(p))
+#define ntfs_is_indx_record(x)		(ntfs_is_magic(x, INDX))
+#define ntfs_is_indx_recordp(p)		(ntfs_is_magicp(p, INDX))
+#define ntfs_is_hole_record(x)		(ntfs_is_magic(x, HOLE))
+#define ntfs_is_hole_recordp(p)		(ntfs_is_magicp(p, HOLE))
+
+#define ntfs_is_rstr_record(x)		(ntfs_is_magic(x, RSTR))
+#define ntfs_is_rstr_recordp(p)		(ntfs_is_magicp(p, RSTR))
+#define ntfs_is_rcrd_record(x)		(ntfs_is_magic(x, RCRD))
+#define ntfs_is_rcrd_recordp(p)		(ntfs_is_magicp(p, RCRD))
+
+#define ntfs_is_chkd_record(x)		(ntfs_is_magic(x, CHKD))
+#define ntfs_is_chkd_recordp(p)		(ntfs_is_magicp(p, CHKD))
+
+#define ntfs_is_baad_record(x)		(ntfs_is_magic(x, BAAD))
+#define ntfs_is_baad_recordp(p)		(ntfs_is_magicp(p, BAAD))
+
+#define ntfs_is_empty_record(x)		(ntfs_is_magic(x, empty))
+#define ntfs_is_empty_recordp(p)	(ntfs_is_magicp(p, empty))
+
+/*
+ * The Update Sequence Array (usa) is an array of the __le16 values which belong
+ * to the end of each sector protected by the update sequence record in which
+ * this array is contained. Note that the first entry is the Update Sequence
+ * Number (usn), a cyclic counter of how many times the protected record has
+ * been written to disk. The values 0 and -1 (ie. 0xffff) are not used. All
+ * last le16's of each sector have to be equal to the usn (during reading) or
+ * are set to it (during writing). If they are not, an incomplete multi sector
+ * transfer has occurred when the data was written.
+ * The maximum size for the update sequence array is fixed to:
+ *	maximum size = usa_ofs + (usa_count * 2) = 510 bytes
+ * The 510 bytes comes from the fact that the last __le16 in the array has to
+ * (obviously) finish before the last __le16 of the first 512-byte sector.
+ * This formula can be used as a consistency check in that usa_ofs +
+ * (usa_count * 2) has to be less than or equal to 510.
+ */
+struct ntfs_record {
+	__le32 magic;		/*
+				 * A four-byte magic identifying the record
+				 * type and/or status.
+				 */
+	__le16 usa_ofs;		/*
+				 * Offset to the Update Sequence Array (usa)
+				 * from the start of the ntfs record.
+				 */
+	__le16 usa_count;	/*
+				 * Number of __le16 sized entries in the usa
+				 * including the Update Sequence Number (usn),
+				 * thus the number of fixups is the usa_count
+				 * minus 1.
+				 */
+} __packed;
+
+/*
+ * System files mft record numbers. All these files are always marked as used
+ * in the bitmap attribute of the mft; presumably in order to avoid accidental
+ * allocation for random other mft records. Also, the sequence number for each
+ * of the system files is always equal to their mft record number and it is
+ * never modified.
+ */
+enum {
+	FILE_MFT       = 0,	/*
+				 * Master file table (mft). Data attribute
+				 * contains the entries and bitmap attribute
+				 * records which ones are in use (bit==1).
+				 */
+	FILE_MFTMirr   = 1,	/* Mft mirror: copy of first four mft records
+				 * in data attribute. If cluster size > 4kiB,
+				 * copy of first N mft records, with
+				 *     N = cluster_size / mft_record_size.
+				 */
+	FILE_LogFile   = 2,	/* Journalling log in data attribute. */
+	FILE_Volume    = 3,	/*
+				 * Volume name attribute and volume information
+				 * attribute (flags and ntfs version). Windows
+				 * refers to this file as volume DASD (Direct
+				 * Access Storage Device).
+				 */
+	FILE_AttrDef   = 4,	/*
+				 * Array of attribute definitions in data
+				 * attribute.
+				 */
+	FILE_root      = 5,	/* Root directory. */
+	FILE_Bitmap    = 6,	/*
+				 * Allocation bitmap of all clusters (lcns) in
+				 * data attribute.
+				 */
+	FILE_Boot      = 7,	/*
+				 * Boot sector (always at cluster 0) in data
+				 * attribute.
+				 */
+	FILE_BadClus   = 8,	/*
+				 * Contains all bad clusters in the non-resident
+				 * data attribute.
+				 */
+	FILE_Secure    = 9,	/*
+				 * Shared security descriptors in data attribute
+				 * and two indexes into the descriptors.
+				 * Appeared in Windows 2000. Before that, this
+				 * file was named $Quota but was unused.
+				 */
+	FILE_UpCase    = 10,	/*
+				 * Uppercase equivalents of all 65536 Unicode
+				 * characters in data attribute.
+				 */
+	FILE_Extend    = 11,	/*
+				 * Directory containing other system files (eg.
+				 * $ObjId, $Quota, $Reparse and $UsnJrnl). This
+				 * is new to NTFS3.0.
+				 */
+	FILE_reserved12 = 12,	/* Reserved for future use (records 12-15). */
+	FILE_reserved13 = 13,
+	FILE_reserved14 = 14,
+	FILE_reserved15 = 15,
+	FILE_first_user = 16,	/*
+				 * First user file, used as test limit for
+				 * whether to allow opening a file or not.
+				 */
+};
+
+/*
+ * These are the so far known MFT_RECORD_* flags (16-bit) which contain
+ * information about the mft record in which they are present.
+ */
+enum {
+	MFT_RECORD_IN_USE		= cpu_to_le16(0x0001),
+	MFT_RECORD_IS_DIRECTORY		= cpu_to_le16(0x0002),
+	MFT_RECORD_IS_4			= cpu_to_le16(0x0004),
+	MFT_RECORD_IS_VIEW_INDEX	= cpu_to_le16(0x0008),
+	MFT_REC_SPACE_FILLER		= 0xffff, /*Just to make flags 16-bit.*/
+} __packed;
+
+/*
+ * mft references (aka file references or file record segment references) are
+ * used whenever a structure needs to refer to a record in the mft.
+ *
+ * A reference consists of a 48-bit index into the mft and a 16-bit sequence
+ * number used to detect stale references.
+ *
+ * For error reporting purposes we treat the 48-bit index as a signed quantity.
+ *
+ * The sequence number is a circular counter (skipping 0) describing how many
+ * times the referenced mft record has been (re)used. This has to match the
+ * sequence number of the mft record being referenced, otherwise the reference
+ * is considered stale and removed.
+ *
+ * If the sequence number is zero it is assumed that no sequence number
+ * consistency checking should be performed.
+ */
+
+/*
+ * Define two unpacking macros to get to the reference (MREF) and
+ * sequence number (MSEQNO) respectively.
+ * The _LE versions are to be applied on little endian MFT_REFs.
+ * Note: The _LE versions will return a CPU endian formatted value!
+ */
+#define MFT_REF_MASK_CPU 0x0000ffffffffffffULL
+#define MFT_REF_MASK_LE cpu_to_le64(MFT_REF_MASK_CPU)
+
+#define MK_MREF(m, s)	((u64)(((u64)(s) << 48) |		\
+					((u64)(m) & MFT_REF_MASK_CPU)))
+#define MK_LE_MREF(m, s) cpu_to_le64(MK_MREF(m, s))
+
+#define MREF(x)		((unsigned long)((x) & MFT_REF_MASK_CPU))
+#define MSEQNO(x)	((u16)(((x) >> 48) & 0xffff))
+#define MREF_LE(x)	((unsigned long)(le64_to_cpu(x) & MFT_REF_MASK_CPU))
+#define MREF_INO(x)	((unsigned long)MREF_LE(x))
+#define MSEQNO_LE(x)	((u16)((le64_to_cpu(x) >> 48) & 0xffff))
+
+#define IS_ERR_MREF(x)	(((x) & 0x0000800000000000ULL) ? true : false)
+#define ERR_MREF(x)	((u64)((s64)(x)))
+#define MREF_ERR(x)	((int)((s64)(x)))
+
+/*
+ * The mft record header present at the beginning of every record in the mft.
+ * This is followed by a sequence of variable length attribute records which
+ * is terminated by an attribute of type AT_END which is a truncated attribute
+ * in that it only consists of the attribute type code AT_END and none of the
+ * other members of the attribute structure are present.
+ */
+struct mft_record {
+	__le32 magic;		/* Usually the magic is "FILE". */
+	__le16 usa_ofs;		/* See ntfs_record struct definition above. */
+	__le16 usa_count;		/* See ntfs_record struct  definition above. */
+
+	__le64 lsn;		/*
+				 * LogFile sequence number for this record.
+				 * Changed every time the record is modified.
+				 */
+	__le16 sequence_number;	/*
+				 * Number of times this mft record has been
+				 * reused. (See description for MFT_REF
+				 * above.) NOTE: The increment (skipping zero)
+				 * is done when the file is deleted. NOTE: If
+				 * this is zero it is left zero.
+				 */
+	__le16 link_count;	/*
+				 * Number of hard links, i.e. the number of
+				 * directory entries referencing this record.
+				 * NOTE: Only used in mft base records.
+				 * NOTE: When deleting a directory entry we
+				 * check the link_count and if it is 1 we
+				 * delete the file. Otherwise we delete the
+				 * struct file_name_attr being referenced by the
+				 * directory entry from the mft record and
+				 * decrement the link_count.
+				 */
+	__le16 attrs_offset;	/*
+				 * Byte offset to the first attribute in this
+				 * mft record from the start of the mft record.
+				 * NOTE: Must be aligned to 8-byte boundary.
+				 */
+	__le16 flags;		/*
+				 * Bit array of MFT_RECORD_FLAGS. When a file
+				 * is deleted, the MFT_RECORD_IN_USE flag is
+				 * set to zero.
+				 */
+	__le32 bytes_in_use;	/*
+				 * Number of bytes used in this mft record.
+				 * NOTE: Must be aligned to 8-byte boundary.
+				 */
+	__le32 bytes_allocated;	/*
+				 * Number of bytes allocated for this mft
+				 * record. This should be equal to the mft
+				 * record size.
+				 */
+	__le64 base_mft_record;	  /*
+				   * This is zero for base mft records.
+				   * When it is not zero it is a mft reference
+				   * pointing to the base mft record to which
+				   * this record belongs (this is then used to
+				   * locate the attribute list attribute present
+				   * in the base record which describes this
+				   * extension record and hence might need
+				   * modification when the extension record
+				   * itself is modified, also locating the
+				   * attribute list also means finding the other
+				   * potential extents, belonging to the non-base
+				   * mft record).
+				   */
+	__le16 next_attr_instance; /*
+				    * The instance number that will be assigned to
+				    * the next attribute added to this mft record.
+				    * NOTE: Incremented each time after it is used.
+				    * NOTE: Every time the mft record is reused
+				    * this number is set to zero.  NOTE: The first
+				    * instance number is always 0.
+				    */
+/* The below fields are specific to NTFS 3.1+ (Windows XP and above): */
+	__le16 reserved;		/* Reserved/alignment. */
+	__le32 mft_record_number;	/* Number of this mft record. */
+/* sizeof() = 48 bytes */
+/*
+ * When (re)using the mft record, we place the update sequence array at this
+ * offset, i.e. before we start with the attributes.  This also makes sense,
+ * otherwise we could run into problems with the update sequence array
+ * containing in itself the last two bytes of a sector which would mean that
+ * multi sector transfer protection wouldn't work.  As you can't protect data
+ * by overwriting it since you then can't get it back...
+ * When reading we obviously use the data from the ntfs record header.
+ */
+} __packed;
+
+/* This is the version without the NTFS 3.1+ specific fields. */
+struct mft_record_old {
+	__le32 magic;		/* Usually the magic is "FILE". */
+	__le16 usa_ofs;		/* See ntfs_record struct definition above. */
+	__le16 usa_count;	/* See ntfs_record struct  definition above. */
+
+	__le64 lsn;		/*
+				 * LogFile sequence number for this record.
+				 * Changed every time the record is modified.
+				 */
+	__le16 sequence_number;	/*
+				 * Number of times this mft record has been
+				 * reused. (See description for MFT_REF
+				 * above.) NOTE: The increment (skipping zero)
+				 * is done when the file is deleted. NOTE: If
+				 * this is zero it is left zero.
+				 */
+	__le16 link_count;	/*
+				 * Number of hard links, i.e. the number of
+				 * directory entries referencing this record.
+				 * NOTE: Only used in mft base records.
+				 * NOTE: When deleting a directory entry we
+				 * check the link_count and if it is 1 we
+				 * delete the file. Otherwise we delete the
+				 * struct file_name_attr being referenced by the
+				 * directory entry from the mft record and
+				 * decrement the link_count.
+				 */
+	__le16 attrs_offset;	/*
+				 * Byte offset to the first attribute in this
+				 * mft record from the start of the mft record.
+				 * NOTE: Must be aligned to 8-byte boundary.
+				 */
+	__le16 flags;		/*
+				 * Bit array of MFT_RECORD_FLAGS. When a file
+				 * is deleted, the MFT_RECORD_IN_USE flag is
+				 * set to zero.
+				 */
+	__le32 bytes_in_use;	/*
+				 * Number of bytes used in this mft record.
+				 * NOTE: Must be aligned to 8-byte boundary.
+				 */
+	__le32 bytes_allocated;	/*
+				 * Number of bytes allocated for this mft
+				 * record. This should be equal to the mft
+				 * record size.
+				 */
+	__le64 base_mft_record;	  /*
+				   * This is zero for base mft records.
+				   * When it is not zero it is a mft reference
+				   * pointing to the base mft record to which
+				   * this record belongs (this is then used to
+				   * locate the attribute list attribute present
+				   * in the base record which describes this
+				   * extension record and hence might need
+				   * modification when the extension record
+				   * itself is modified, also locating the
+				   * attribute list also means finding the other
+				   * potential extents, belonging to the non-base
+				   * mft record).
+				   */
+	__le16 next_attr_instance; /*
+				    * The instance number that will be assigned to
+				    * the next attribute added to this mft record.
+				    * NOTE: Incremented each time after it is used.
+				    * NOTE: Every time the mft record is reused
+				    * this number is set to zero.  NOTE: The first
+				    * instance number is always 0.
+				    */
+/* sizeof() = 42 bytes */
+/*
+ * When (re)using the mft record, we place the update sequence array at this
+ * offset, i.e. before we start with the attributes.  This also makes sense,
+ * otherwise we could run into problems with the update sequence array
+ * containing in itself the last two bytes of a sector which would mean that
+ * multi sector transfer protection wouldn't work.  As you can't protect data
+ * by overwriting it since you then can't get it back...
+ * When reading we obviously use the data from the ntfs record header.
+ */
+} __packed;
+
+/*
+ * System defined attributes (32-bit).  Each attribute type has a corresponding
+ * attribute name (Unicode string of maximum 64 character length) as described
+ * by the attribute definitions present in the data attribute of the $AttrDef
+ * system file.  On NTFS 3.0 volumes the names are just as the types are named
+ * in the below defines exchanging AT_ for the dollar sign ($).  If that is not
+ * a revealing choice of symbol I do not know what is... (-;
+ */
+enum {
+	AT_UNUSED			= cpu_to_le32(0),
+	AT_STANDARD_INFORMATION		= cpu_to_le32(0x10),
+	AT_ATTRIBUTE_LIST		= cpu_to_le32(0x20),
+	AT_FILE_NAME			= cpu_to_le32(0x30),
+	AT_OBJECT_ID			= cpu_to_le32(0x40),
+	AT_SECURITY_DESCRIPTOR		= cpu_to_le32(0x50),
+	AT_VOLUME_NAME			= cpu_to_le32(0x60),
+	AT_VOLUME_INFORMATION		= cpu_to_le32(0x70),
+	AT_DATA				= cpu_to_le32(0x80),
+	AT_INDEX_ROOT			= cpu_to_le32(0x90),
+	AT_INDEX_ALLOCATION		= cpu_to_le32(0xa0),
+	AT_BITMAP			= cpu_to_le32(0xb0),
+	AT_REPARSE_POINT		= cpu_to_le32(0xc0),
+	AT_EA_INFORMATION		= cpu_to_le32(0xd0),
+	AT_EA				= cpu_to_le32(0xe0),
+	AT_PROPERTY_SET			= cpu_to_le32(0xf0),
+	AT_LOGGED_UTILITY_STREAM	= cpu_to_le32(0x100),
+	AT_FIRST_USER_DEFINED_ATTRIBUTE	= cpu_to_le32(0x1000),
+	AT_END				= cpu_to_le32(0xffffffff)
+};
+
+/*
+ * The collation rules for sorting views/indexes/etc (32-bit).
+ *
+ * COLLATION_BINARY - Collate by binary compare where the first byte is most
+ *	significant.
+ * COLLATION_UNICODE_STRING - Collate Unicode strings by comparing their binary
+ *	Unicode values, except that when a character can be uppercased, the
+ *	upper case value collates before the lower case one.
+ * COLLATION_FILE_NAME - Collate file names as Unicode strings. The collation
+ *	is done very much like COLLATION_UNICODE_STRING. In fact I have no idea
+ *	what the difference is. Perhaps the difference is that file names
+ *	would treat some special characters in an odd way (see
+ *	unistr.c::ntfs_collate_names() and unistr.c::legal_ansi_char_array[]
+ *	for what I mean but COLLATION_UNICODE_STRING would not give any special
+ *	treatment to any characters at all, but this is speculation.
+ * COLLATION_NTOFS_ULONG - Sorting is done according to ascending __le32 key
+ *	values. E.g. used for $SII index in FILE_Secure, which sorts by
+ *	security_id (le32).
+ * COLLATION_NTOFS_SID - Sorting is done according to ascending SID values.
+ *	E.g. used for $O index in FILE_Extend/$Quota.
+ * COLLATION_NTOFS_SECURITY_HASH - Sorting is done first by ascending hash
+ *	values and second by ascending security_id values. E.g. used for $SDH
+ *	index in FILE_Secure.
+ * COLLATION_NTOFS_ULONGS - Sorting is done according to a sequence of ascending
+ *	__le32 key values. E.g. used for $O index in FILE_Extend/$ObjId, which
+ *	sorts by object_id (16-byte), by splitting up the object_id in four
+ *	__le32 values and using them as individual keys. E.g. take the following
+ *	two security_ids, stored as follows on disk:
+ *		1st: a1 61 65 b7 65 7b d4 11 9e 3d 00 e0 81 10 42 59
+ *		2nd: 38 14 37 d2 d2 f3 d4 11 a5 21 c8 6b 79 b1 97 45
+ *	To compare them, they are split into four __le32 values each, like so:
+ *		1st: 0xb76561a1 0x11d47b65 0xe0003d9e 0x59421081
+ *		2nd: 0xd2371438 0x11d4f3d2 0x6bc821a5 0x4597b179
+ *	Now, it is apparent why the 2nd object_id collates after the 1st: the
+ *	first __le32 value of the 1st object_id is less than the first __le32 of
+ *	the 2nd object_id. If the first __le32 values of both object_ids were
+ *	equal then the second __le32 values would be compared, etc.
+ */
+enum {
+	COLLATION_BINARY		= cpu_to_le32(0x00),
+	COLLATION_FILE_NAME		= cpu_to_le32(0x01),
+	COLLATION_UNICODE_STRING	= cpu_to_le32(0x02),
+	COLLATION_NTOFS_ULONG		= cpu_to_le32(0x10),
+	COLLATION_NTOFS_SID		= cpu_to_le32(0x11),
+	COLLATION_NTOFS_SECURITY_HASH	= cpu_to_le32(0x12),
+	COLLATION_NTOFS_ULONGS		= cpu_to_le32(0x13),
+};
+
+/*
+ * The flags (32-bit) describing attribute properties in the attribute
+ * definition structure.
+ * The INDEXABLE flag is fairly certainly correct as only the file
+ * name attribute has this flag set and this is the only attribute indexed in
+ * NT4.
+ */
+enum {
+	ATTR_DEF_INDEXABLE	= cpu_to_le32(0x02), /* Attribute can be indexed. */
+	ATTR_DEF_MULTIPLE	= cpu_to_le32(0x04), /*
+						      * Attribute type can be present
+						      * multiple times in the mft records
+						      * of an inode.
+						      */
+	ATTR_DEF_NOT_ZERO	= cpu_to_le32(0x08), /*
+						      * Attribute value must contain
+						      * at least one non-zero byte.
+						      */
+	ATTR_DEF_INDEXED_UNIQUE	= cpu_to_le32(0x10), /*
+						      * Attribute must be indexed and
+						      * the attribute value must be unique
+						      * for the attribute type in all of
+						      * the mft records of an inode.
+						      */
+	ATTR_DEF_NAMED_UNIQUE	= cpu_to_le32(0x20), /*
+						      * Attribute must be named and
+						      * the name must be unique for
+						      * the attribute type in all of the mft
+						      * records of an inode.
+						      */
+	ATTR_DEF_RESIDENT	= cpu_to_le32(0x40), /* Attribute must be resident. */
+	ATTR_DEF_ALWAYS_LOG	= cpu_to_le32(0x80), /*
+						      * Always log modifications to this attribute,
+						      * regardless of whether it is resident or
+						      * non-resident.  Without this, only log
+						      * modifications if the attribute is resident.
+						      */
+};
+
+/*
+ * The data attribute of FILE_AttrDef contains a sequence of attribute
+ * definitions for the NTFS volume. With this, it is supposed to be safe for an
+ * older NTFS driver to mount a volume containing a newer NTFS version without
+ * damaging it (that's the theory. In practice it's: not damaging it too much).
+ * Entries are sorted by attribute type. The flags describe whether the
+ * attribute can be resident/non-resident and possibly other things, but the
+ * actual bits are unknown.
+ */
+struct attr_def {
+	__le16 name[0x40];		/* Unicode name of the attribute. Zero terminated. */
+	__le32 type;			/* Type of the attribute. */
+	__le32 display_rule;		/* Default display rule. */
+	__le32 collation_rule;		/* Default collation rule. */
+	__le32 flags;			/* Flags describing the attribute. */
+	__le64 min_size;			/* Optional minimum attribute size. */
+	__le64 max_size;			/* Maximum size of attribute. */
+/* sizeof() = 0xa0 or 160 bytes */
+} __packed;
+
+/*
+ * Attribute flags (16-bit).
+ */
+enum {
+	ATTR_IS_COMPRESSED    = cpu_to_le16(0x0001),
+	ATTR_COMPRESSION_MASK = cpu_to_le16(0x00ff), /*
+						      * Compression method mask.
+						      * Also, first illegal value.
+						      */
+	ATTR_IS_ENCRYPTED     = cpu_to_le16(0x4000),
+	ATTR_IS_SPARSE	      = cpu_to_le16(0x8000),
+} __packed;
+
+/*
+ * Attribute compression.
+ *
+ * Only the data attribute is ever compressed in the current ntfs driver in
+ * Windows. Further, compression is only applied when the data attribute is
+ * non-resident. Finally, to use compression, the maximum allowed cluster size
+ * on a volume is 4kib.
+ *
+ * The compression method is based on independently compressing blocks of X
+ * clusters, where X is determined from the compression_unit value found in the
+ * non-resident attribute record header (more precisely: X = 2^compression_unit
+ * clusters). On Windows NT/2k, X always is 16 clusters (compression_unit = 4).
+ *
+ * There are three different cases of how a compression block of X clusters
+ * can be stored:
+ *
+ *   1) The data in the block is all zero (a sparse block):
+ *	  This is stored as a sparse block in the runlist, i.e. the runlist
+ *	  entry has length = X and lcn = -1. The mapping pairs array actually
+ *	  uses a delta_lcn value length of 0, i.e. delta_lcn is not present at
+ *	  all, which is then interpreted by the driver as lcn = -1.
+ *	  NOTE: Even uncompressed files can be sparse on NTFS 3.0 volumes, then
+ *	  the same principles apply as above, except that the length is not
+ *	  restricted to being any particular value.
+ *
+ *   2) The data in the block is not compressed:
+ *	  This happens when compression doesn't reduce the size of the block
+ *	  in clusters. I.e. if compression has a small effect so that the
+ *	  compressed data still occupies X clusters, then the uncompressed data
+ *	  is stored in the block.
+ *	  This case is recognised by the fact that the runlist entry has
+ *	  length = X and lcn >= 0. The mapping pairs array stores this as
+ *	  normal with a run length of X and some specific delta_lcn, i.e.
+ *	  delta_lcn has to be present.
+ *
+ *   3) The data in the block is compressed:
+ *	  The common case. This case is recognised by the fact that the run
+ *	  list entry has length L < X and lcn >= 0. The mapping pairs array
+ *	  stores this as normal with a run length of X and some specific
+ *	  delta_lcn, i.e. delta_lcn has to be present. This runlist entry is
+ *	  immediately followed by a sparse entry with length = X - L and
+ *	  lcn = -1. The latter entry is to make up the vcn counting to the
+ *	  full compression block size X.
+ *
+ * In fact, life is more complicated because adjacent entries of the same type
+ * can be coalesced. This means that one has to keep track of the number of
+ * clusters handled and work on a basis of X clusters at a time being one
+ * block. An example: if length L > X this means that this particular runlist
+ * entry contains a block of length X and part of one or more blocks of length
+ * L - X. Another example: if length L < X, this does not necessarily mean that
+ * the block is compressed as it might be that the lcn changes inside the block
+ * and hence the following runlist entry describes the continuation of the
+ * potentially compressed block. The block would be compressed if the
+ * following runlist entry describes at least X - L sparse clusters, thus
+ * making up the compression block length as described in point 3 above. (Of
+ * course, there can be several runlist entries with small lengths so that the
+ * sparse entry does not follow the first data containing entry with
+ * length < X.)
+ *
+ * NOTE: At the end of the compressed attribute value, there most likely is not
+ * just the right amount of data to make up a compression block, thus this data
+ * is not even attempted to be compressed. It is just stored as is, unless
+ * the number of clusters it occupies is reduced when compressed in which case
+ * it is stored as a compressed compression block, complete with sparse
+ * clusters at the end.
+ */
+
+/*
+ * Flags of resident attributes (8-bit).
+ */
+enum {
+	RESIDENT_ATTR_IS_INDEXED = 0x01, /*
+					  * Attribute is referenced in an index
+					  * (has implications for deleting and
+					  * modifying the attribute).
+					  */
+} __packed;
+
+/*
+ * Attribute record header. Always aligned to 8-byte boundary.
+ */
+struct attr_record {
+	__le32 type;		/* The (32-bit) type of the attribute. */
+	__le32 length;		/*
+				 * Byte size of the resident part of the
+				 * attribute (aligned to 8-byte boundary).
+				 * Used to get to the next attribute.
+				 */
+	u8 non_resident;	/*
+				 * If 0, attribute is resident.
+				 * If 1, attribute is non-resident.
+				 */
+	u8 name_length;		/* Unicode character size of name of attribute. 0 if unnamed. */
+	__le16 name_offset;	/*
+				 * If name_length != 0, the byte offset to the
+				 * beginning of the name from the attribute
+				 * record. Note that the name is stored as a
+				 * Unicode string. When creating, place offset
+				 * just at the end of the record header. Then,
+				 * follow with attribute value or mapping pairs
+				 * array, resident and non-resident attributes
+				 * respectively, aligning to an 8-byte
+				 * boundary.
+				 */
+	__le16 flags;	/* Flags describing the attribute. */
+	__le16 instance;	/*
+				 * The instance of this attribute record. This
+				 * number is unique within this mft record (see
+				 * MFT_RECORD/next_attribute_instance notes in
+				 * mft.h for more details).
+				 */
+	union {
+		/* Resident attributes. */
+		struct {
+			__le32 value_length; /* Byte size of attribute value. */
+			__le16 value_offset; /*
+					      * Byte offset of the attribute
+					      * value from the start of the
+					      * attribute record. When creating,
+					      * align to 8-byte boundary if we
+					      * have a name present as this might
+					      * not have a length of a multiple
+					      * of 8-bytes.
+					      */
+			u8 flags;	/* See above. */
+			s8 reserved;	  /* Reserved/alignment to 8-byte boundary. */
+		} __packed resident;
+		/* Non-resident attributes. */
+		struct {
+			__le64 lowest_vcn; /*
+					    * Lowest valid virtual cluster number
+					    * for this portion of the attribute value or
+					    * 0 if this is the only extent (usually the
+					    * case). - Only when an attribute list is used
+					    * does lowest_vcn != 0 ever occur.
+					    */
+			__le64 highest_vcn; /*
+					     * Highest valid vcn of this extent of
+					     * the attribute value. - Usually there is only one
+					     * portion, so this usually equals the attribute
+					     * value size in clusters minus 1. Can be -1 for
+					     * zero length files. Can be 0 for "single extent"
+					     * attributes.
+					     */
+			__le16 mapping_pairs_offset; /*
+						      * Byte offset from the beginning of
+						      * the structure to the mapping pairs
+						      * array which contains the mappings
+						      * between the vcns and the logical cluster
+						      * numbers (lcns).
+						      * When creating, place this at the end of
+						      * this record header aligned to 8-byte
+						      * boundary.
+						      */
+			u8 compression_unit; /*
+					      * The compression unit expressed as the log
+					      * to the base 2 of the number of
+					      * clusters in a compression unit.  0 means not
+					      * compressed.  (This effectively limits the
+					      * compression unit size to be a power of two
+					      * clusters.)  WinNT4 only uses a value of 4.
+					      * Sparse files have this set to 0 on XPSP2.
+					      */
+			u8 reserved[5];		/* Align to 8-byte boundary. */
+/*
+ * The sizes below are only used when lowest_vcn is zero, as otherwise it would
+ * be difficult to keep them up-to-date.
+ */
+			__le64 allocated_size;	/*
+						 * Byte size of disk space allocated
+						 * to hold the attribute value. Always
+						 * is a multiple of the cluster size.
+						 * When a file is compressed, this field
+						 * is a multiple of the compression block
+						 * size (2^compression_unit) and it represents
+						 * the logically allocated space rather than
+						 * the actual on disk usage. For this use
+						 * the compressed_size (see below).
+						 */
+			__le64 data_size;	/*
+						 * Byte size of the attribute value. Can be
+						 * larger than allocated_size if attribute value
+						 * is compressed or sparse.
+						 */
+			__le64 initialized_size; /*
+						  * Byte size of initialized portion of
+						  * the attribute value. Usually equals data_size.
+						  */
+/* sizeof(uncompressed attr) = 64*/
+			__le64 compressed_size;	/*
+						 * Byte size of the attribute value after
+						 * compression.  Only present when compressed
+						 * or sparse.  Always is a multiple of the cluster
+						 * size.  Represents the actual amount of disk
+						 * space being used on the disk.
+						 */
+/* sizeof(compressed attr) = 72*/
+		} __packed non_resident;
+	} __packed data;
+} __packed;
+
+/*
+ * File attribute flags (32-bit) appearing in the file_attributes fields of the
+ * STANDARD_INFORMATION attribute of MFT_RECORDs and the FILENAME_ATTR
+ * attributes of MFT_RECORDs and directory index entries.
+ *
+ * All of the below flags appear in the directory index entries but only some
+ * appear in the STANDARD_INFORMATION attribute whilst only some others appear
+ * in the FILENAME_ATTR attribute of MFT_RECORDs.  Unless otherwise stated the
+ * flags appear in all of the above.
+ */
+enum {
+	FILE_ATTR_READONLY		= cpu_to_le32(0x00000001),
+	FILE_ATTR_HIDDEN		= cpu_to_le32(0x00000002),
+	FILE_ATTR_SYSTEM		= cpu_to_le32(0x00000004),
+	/* Old DOS volid. Unused in NT.	= cpu_to_le32(0x00000008), */
+
+	FILE_ATTR_DIRECTORY		= cpu_to_le32(0x00000010),
+	/*
+	 * Note, FILE_ATTR_DIRECTORY is not considered valid in NT.  It is
+	 * reserved for the DOS SUBDIRECTORY flag.
+	 */
+	FILE_ATTR_ARCHIVE		= cpu_to_le32(0x00000020),
+	FILE_ATTR_DEVICE		= cpu_to_le32(0x00000040),
+	FILE_ATTR_NORMAL		= cpu_to_le32(0x00000080),
+
+	FILE_ATTR_TEMPORARY		= cpu_to_le32(0x00000100),
+	FILE_ATTR_SPARSE_FILE		= cpu_to_le32(0x00000200),
+	FILE_ATTR_REPARSE_POINT		= cpu_to_le32(0x00000400),
+	FILE_ATTR_COMPRESSED		= cpu_to_le32(0x00000800),
+
+	FILE_ATTR_OFFLINE		= cpu_to_le32(0x00001000),
+	FILE_ATTR_NOT_CONTENT_INDEXED	= cpu_to_le32(0x00002000),
+	FILE_ATTR_ENCRYPTED		= cpu_to_le32(0x00004000),
+
+	FILE_ATTR_VALID_FLAGS		= cpu_to_le32(0x00007fb7),
+	/*
+	 * Note, FILE_ATTR_VALID_FLAGS masks out the old DOS VolId and the
+	 * FILE_ATTR_DEVICE and preserves everything else.  This mask is used
+	 * to obtain all flags that are valid for reading.
+	 */
+	FILE_ATTR_VALID_SET_FLAGS	= cpu_to_le32(0x000031a7),
+	/*
+	 * Note, FILE_ATTR_VALID_SET_FLAGS masks out the old DOS VolId, the
+	 * F_A_DEVICE, F_A_DIRECTORY, F_A_SPARSE_FILE, F_A_REPARSE_POINT,
+	 * F_A_COMPRESSED, and F_A_ENCRYPTED and preserves the rest.  This mask
+	 * is used to obtain all flags that are valid for setting.
+	 */
+	/* Supposed to mean no data locally, possibly repurposed */
+	FILE_ATTRIBUTE_RECALL_ON_OPEN	= cpu_to_le32(0x00040000),
+	/*
+	 * The flag FILE_ATTR_DUP_FILENAME_INDEX_PRESENT is present in all
+	 * FILENAME_ATTR attributes but not in the STANDARD_INFORMATION
+	 * attribute of an mft record.
+	 */
+	FILE_ATTR_DUP_FILE_NAME_INDEX_PRESENT	= cpu_to_le32(0x10000000),
+	/*
+	 * Note, this is a copy of the corresponding bit from the mft record,
+	 * telling us whether this is a directory or not, i.e. whether it has
+	 * an index root attribute or not.
+	 */
+	FILE_ATTR_DUP_VIEW_INDEX_PRESENT	= cpu_to_le32(0x20000000),
+	/*
+	 * Note, this is a copy of the corresponding bit from the mft record,
+	 * telling us whether this file has a view index present (eg. object id
+	 * index, quota index, one of the security indexes or the encrypting
+	 * filesystem related indexes).
+	 */
+};
+
+/*
+ * NOTE on times in NTFS: All times are in MS standard time format, i.e. they
+ * are the number of 100-nanosecond intervals since 1st January 1601, 00:00:00
+ * universal coordinated time (UTC). (In Linux time starts 1st January 1970,
+ * 00:00:00 UTC and is stored as the number of 1-second intervals since then.)
+ */
+
+/*
+ * Attribute: Standard information (0x10).
+ *
+ * NOTE: Always resident.
+ * NOTE: Present in all base file records on a volume.
+ * NOTE: There is conflicting information about the meaning of each of the time
+ *	 fields but the meaning as defined below has been verified to be
+ *	 correct by practical experimentation on Windows NT4 SP6a and is hence
+ *	 assumed to be the one and only correct interpretation.
+ */
+struct standard_information {
+	__le64 creation_time;		/*
+					 * Time file was created. Updated when
+					 * a filename is changed(?).
+					 */
+	__le64 last_data_change_time;	/* Time the data attribute was last modified. */
+	__le64 last_mft_change_time;	/* Time this mft record was last modified. */
+	__le64 last_access_time;	/*
+					 * Approximate time when the file was
+					 * last accessed (obviously this is not
+					 * updated on read-only volumes). In
+					 * Windows this is only updated when
+					 * accessed if some time delta has
+					 * passed since the last update. Also,
+					 * last access time updates can be
+					 * disabled altogether for speed.
+					 */
+	__le32 file_attributes; /* Flags describing the file. */
+	union {
+	/* NTFS 1.2 */
+		struct {
+			u8 reserved12[12];	/* Reserved/alignment to 8-byte boundary. */
+		} __packed v1;
+	/* sizeof() = 48 bytes */
+	/* NTFS 3.x */
+		struct {
+/*
+ * If a volume has been upgraded from a previous NTFS version, then these
+ * fields are present only if the file has been accessed since the upgrade.
+ * Recognize the difference by comparing the length of the resident attribute
+ * value. If it is 48, then the following fields are missing. If it is 72 then
+ * the fields are present. Maybe just check like this:
+ *	if (resident.ValueLength < sizeof(struct standard_information)) {
+ *		Assume NTFS 1.2- format.
+ *		If (volume version is 3.x)
+ *			Upgrade attribute to NTFS 3.x format.
+ *		else
+ *			Use NTFS 1.2- format for access.
+ *	} else
+ *		Use NTFS 3.x format for access.
+ * Only problem is that it might be legal to set the length of the value to
+ * arbitrarily large values thus spoiling this check. - But chkdsk probably
+ * views that as a corruption, assuming that it behaves like this for all
+ * attributes.
+ */
+			__le32 maximum_versions; /*
+						  * Maximum allowed versions for
+						  * file. Zero if version numbering
+						  * is disabled.
+						  */
+			__le32 version_number;	/*
+						 * This file's version (if any).
+						 * Set to zero if maximum_versions
+						 * is zero.
+						 */
+			__le32 class_id;	/*
+						 * Class id from bidirectional
+						 * class id index (?).
+						 */
+			__le32 owner_id;	/*
+						 * Owner_id of the user owning
+						 * the file. Translate via $Q index
+						 * in FILE_Extend /$Quota to the quota
+						 * control entry for the user owning
+						 * the file. Zero if quotas are disabled.
+						 */
+			__le32 security_id;	/*
+						 * Security_id for the file. Translate via
+						 * $SII index and $SDS data stream in
+						 * FILE_Secure to the security descriptor.
+						 */
+			__le64 quota_charged;	/*
+						 * Byte size of the charge to the quota for
+						 * all streams of the file. Note: Is zero
+						 * if quotas are disabled.
+						 */
+			__le64 usn;		/*
+						 * Last update sequence number of the file.
+						 * This is a direct index into the transaction
+						 * log file ($UsnJrnl).  It is zero if the usn
+						 * journal is disabled or this file has not been
+						 * subject to logging yet.  See usnjrnl.h
+						 * for details.
+						 */
+		} __packed v3;
+	/* sizeof() = 72 bytes (NTFS 3.x) */
+	} __packed ver;
+} __packed;
+
+/*
+ * Attribute: Attribute list (0x20).
+ *
+ * - Can be either resident or non-resident.
+ * - Value consists of a sequence of variable length, 8-byte aligned,
+ * ATTR_LIST_ENTRY records.
+ * - The list is not terminated by anything at all! The only way to know when
+ * the end is reached is to keep track of the current offset and compare it to
+ * the attribute value size.
+ * - The attribute list attribute contains one entry for each attribute of
+ * the file in which the list is located, except for the list attribute
+ * itself. The list is sorted: first by attribute type, second by attribute
+ * name (if present), third by instance number. The extents of one
+ * non-resident attribute (if present) immediately follow after the initial
+ * extent. They are ordered by lowest_vcn and have their instance set to zero.
+ * It is not allowed to have two attributes with all sorting keys equal.
+ * - Further restrictions:
+ *	- If not resident, the vcn to lcn mapping array has to fit inside the
+ *	  base mft record.
+ *	- The attribute list attribute value has a maximum size of 256kb. This
+ *	  is imposed by the Windows cache manager.
+ * - Attribute lists are only used when the attributes of mft record do not
+ * fit inside the mft record despite all attributes (that can be made
+ * non-resident) having been made non-resident. This can happen e.g. when:
+ *	- File has a large number of hard links (lots of file name
+ *	  attributes present).
+ *	- The mapping pairs array of some non-resident attribute becomes so
+ *	  large due to fragmentation that it overflows the mft record.
+ *	- The security descriptor is very complex (not applicable to
+ *	  NTFS 3.0 volumes).
+ *	- There are many named streams.
+ */
+struct attr_list_entry {
+	__le32 type;		/* Type of referenced attribute. */
+	__le16 length;		/* Byte size of this entry (8-byte aligned). */
+	u8 name_length;		/*
+				 * Size in Unicode chars of the name of the
+				 * attribute or 0 if unnamed.
+				 */
+	u8 name_offset;		/*
+				 * Byte offset to beginning of attribute name
+				 * (always set this to where the name would
+				 * start even if unnamed).
+				 */
+	__le64 lowest_vcn;	/*
+				 * Lowest virtual cluster number of this portion
+				 * of the attribute value. This is usually 0. It
+				 * is non-zero for the case where one attribute
+				 * does not fit into one mft record and thus
+				 * several mft records are allocated to hold
+				 * this attribute. In the latter case, each mft
+				 * record holds one extent of the attribute and
+				 * there is one attribute list entry for each
+				 * extent. NOTE: This is DEFINITELY a signed
+				 * value! The windows driver uses cmp, followed
+				 * by jg when comparing this, thus it treats it
+				 * as signed.
+				 */
+	__le64 mft_reference;	/*
+				 * The reference of the mft record holding
+				 * the attr record for this portion of the
+				 * attribute value.
+				 */
+	__le16 instance;	/*
+				 * If lowest_vcn = 0, the instance of the
+				 * attribute being referenced; otherwise 0.
+				 */
+	__le16 name[];		/*
+				 * Use when creating only. When reading use
+				 * name_offset to determine the location of the name.
+				 */
+/* sizeof() = 26 + (attribute_name_length * 2) bytes */
+} __packed;
+
+/*
+ * The maximum allowed length for a file name.
+ */
+#define MAXIMUM_FILE_NAME_LENGTH	255
+
+/*
+ * Possible namespaces for filenames in ntfs (8-bit).
+ */
+enum {
+	FILE_NAME_POSIX		= 0x00,
+	/*
+	 * This is the largest namespace. It is case sensitive and allows all
+	 * Unicode characters except for: '\0' and '/'.  Beware that in
+	 * WinNT/2k/2003 by default files which eg have the same name except
+	 * for their case will not be distinguished by the standard utilities
+	 * and thus a "del filename" will delete both "filename" and "fileName"
+	 * without warning.  However if for example Services For Unix (SFU) are
+	 * installed and the case sensitive option was enabled at installation
+	 * time, then you can create/access/delete such files.
+	 * Note that even SFU places restrictions on the filenames beyond the
+	 * '\0' and '/' and in particular the following set of characters is
+	 * not allowed: '"', '/', '<', '>', '\'.  All other characters,
+	 * including the ones no allowed in WIN32 namespace are allowed.
+	 * Tested with SFU 3.5 (this is now free) running on Windows XP.
+	 */
+	FILE_NAME_WIN32		= 0x01,
+	/*
+	 * The standard WinNT/2k NTFS long filenames. Case insensitive.  All
+	 * Unicode chars except: '\0', '"', '*', '/', ':', '<', '>', '?', '\',
+	 * and '|'.  Further, names cannot end with a '.' or a space.
+	 */
+	FILE_NAME_DOS		= 0x02,
+	/*
+	 * The standard DOS filenames (8.3 format). Uppercase only.  All 8-bit
+	 * characters greater space, except: '"', '*', '+', ',', '/', ':', ';',
+	 * '<', '=', '>', '?', and '\'.\
+	 */
+	FILE_NAME_WIN32_AND_DOS	= 0x03,
+	/*
+	 * 3 means that both the Win32 and the DOS filenames are identical and
+	 * hence have been saved in this single filename record.
+	 */
+} __packed;
+
+/*
+ * Attribute: Filename (0x30).
+ *
+ * NOTE: Always resident.
+ * NOTE: All fields, except the parent_directory, are only updated when the
+ *	 filename is changed. Until then, they just become out of sync with
+ *	 reality and the more up to date values are present in the standard
+ *	 information attribute.
+ * NOTE: There is conflicting information about the meaning of each of the time
+ *	 fields but the meaning as defined below has been verified to be
+ *	 correct by practical experimentation on Windows NT4 SP6a and is hence
+ *	 assumed to be the one and only correct interpretation.
+ */
+struct file_name_attr {
+/*hex ofs*/
+	__le64 parent_directory;		/* Directory this filename is referenced from. */
+	__le64 creation_time;		/* Time file was created. */
+	__le64 last_data_change_time;	/* Time the data attribute was last modified. */
+	__le64 last_mft_change_time;	/* Time this mft record was last modified. */
+	__le64 last_access_time;		/* Time this mft record was last accessed. */
+	__le64 allocated_size;		/*
+					 * Byte size of on-disk allocated space
+					 * for the unnamed data attribute.  So for normal
+					 * $DATA, this is the allocated_size from
+					 * the unnamed $DATA attribute and for compressed
+					 * and/or sparse $DATA, this is the
+					 * compressed_size from the unnamed
+					 * $DATA attribute.  For a directory or
+					 * other inode without an unnamed $DATA attribute,
+					 * this is always 0.  NOTE: This is a multiple of
+					 * the cluster size.
+					 */
+	__le64 data_size;		/*
+					 * Byte size of actual data in unnamed
+					 * data attribute.  For a directory or
+					 * other inode without an unnamed $DATA
+					 * attribute, this is always 0.
+					 */
+	__le32 file_attributes;		/* Flags describing the file. */
+	union {
+		struct {
+			__le16 packed_ea_size;	/*
+						 * Size of the buffer needed to
+						 * pack the extended attributes
+						 * (EAs), if such are present.
+						 */
+			__le16 reserved;	/* Reserved for alignment. */
+		} __packed ea;
+		struct {
+			__le32 reparse_point_tag; /*
+						   * Type of reparse point,
+						   * present only in reparse
+						   * points and only if there are
+						   * no EAs.
+						   */
+		} __packed rp;
+	} __packed type;
+	u8 file_name_length;			/* Length of file name in (Unicode) characters. */
+	u8 file_name_type;			/* Namespace of the file name.*/
+	__le16 file_name[];			/* File name in Unicode. */
+} __packed;
+
+/*
+ * GUID structures store globally unique identifiers (GUID). A GUID is a
+ * 128-bit value consisting of one group of eight hexadecimal digits, followed
+ * by three groups of four hexadecimal digits each, followed by one group of
+ * twelve hexadecimal digits. GUIDs are Microsoft's implementation of the
+ * distributed computing environment (DCE) universally unique identifier (UUID).
+ * Example of a GUID:
+ *	1F010768-5A73-BC91-0010A52216A7
+ */
+struct guid {
+	__le32 data1;	/* The first eight hexadecimal digits of the GUID. */
+	__le16 data2;	/* The first group of four hexadecimal digits. */
+	__le16 data3;	/* The second group of four hexadecimal digits. */
+	u8 data4[8];	/*
+			 * The first two bytes are the third group of four
+			 * hexadecimal digits. The remaining six bytes are the
+			 * final 12 hexadecimal digits.
+			 */
+} __packed;
+
+/*
+ * These relative identifiers (RIDs) are used with the above identifier
+ * authorities to make up universal well-known SIDs.
+ *
+ * Note: The relative identifier (RID) refers to the portion of a SID, which
+ * identifies a user or group in relation to the authority that issued the SID.
+ * For example, the universal well-known SID Creator Owner ID (S-1-3-0) is
+ * made up of the identifier authority SECURITY_CREATOR_SID_AUTHORITY (3) and
+ * the relative identifier SECURITY_CREATOR_OWNER_RID (0).
+ */
+enum {					/* Identifier authority. */
+	SECURITY_NULL_RID			= 0,	/* S-1-0 */
+	SECURITY_WORLD_RID			= 0,	/* S-1-1 */
+	SECURITY_LOCAL_RID			= 0,	/* S-1-2 */
+
+	SECURITY_CREATOR_OWNER_RID		= 0,	/* S-1-3 */
+	SECURITY_CREATOR_GROUP_RID		= 1,	/* S-1-3 */
+
+	SECURITY_CREATOR_OWNER_SERVER_RID	= 2,	/* S-1-3 */
+	SECURITY_CREATOR_GROUP_SERVER_RID	= 3,	/* S-1-3 */
+
+	SECURITY_DIALUP_RID			= 1,
+	SECURITY_NETWORK_RID			= 2,
+	SECURITY_BATCH_RID			= 3,
+	SECURITY_INTERACTIVE_RID		= 4,
+	SECURITY_SERVICE_RID			= 6,
+	SECURITY_ANONYMOUS_LOGON_RID		= 7,
+	SECURITY_PROXY_RID			= 8,
+	SECURITY_ENTERPRISE_CONTROLLERS_RID	= 9,
+	SECURITY_SERVER_LOGON_RID		= 9,
+	SECURITY_PRINCIPAL_SELF_RID		= 0xa,
+	SECURITY_AUTHENTICATED_USER_RID		= 0xb,
+	SECURITY_RESTRICTED_CODE_RID		= 0xc,
+	SECURITY_TERMINAL_SERVER_RID		= 0xd,
+
+	SECURITY_LOGON_IDS_RID			= 5,
+	SECURITY_LOGON_IDS_RID_COUNT		= 3,
+
+	SECURITY_LOCAL_SYSTEM_RID		= 0x12,
+
+	SECURITY_NT_NON_UNIQUE			= 0x15,
+
+	SECURITY_BUILTIN_DOMAIN_RID		= 0x20,
+
+	/*
+	 * Well-known domain relative sub-authority values (RIDs).
+	 */
+
+	/* Users. */
+	DOMAIN_USER_RID_ADMIN			= 0x1f4,
+	DOMAIN_USER_RID_GUEST			= 0x1f5,
+	DOMAIN_USER_RID_KRBTGT			= 0x1f6,
+
+	/* Groups. */
+	DOMAIN_GROUP_RID_ADMINS			= 0x200,
+	DOMAIN_GROUP_RID_USERS			= 0x201,
+	DOMAIN_GROUP_RID_GUESTS			= 0x202,
+	DOMAIN_GROUP_RID_COMPUTERS		= 0x203,
+	DOMAIN_GROUP_RID_CONTROLLERS		= 0x204,
+	DOMAIN_GROUP_RID_CERT_ADMINS		= 0x205,
+	DOMAIN_GROUP_RID_SCHEMA_ADMINS		= 0x206,
+	DOMAIN_GROUP_RID_ENTERPRISE_ADMINS	= 0x207,
+	DOMAIN_GROUP_RID_POLICY_ADMINS		= 0x208,
+
+	/* Aliases. */
+	DOMAIN_ALIAS_RID_ADMINS			= 0x220,
+	DOMAIN_ALIAS_RID_USERS			= 0x221,
+	DOMAIN_ALIAS_RID_GUESTS			= 0x222,
+	DOMAIN_ALIAS_RID_POWER_USERS		= 0x223,
+
+	DOMAIN_ALIAS_RID_ACCOUNT_OPS		= 0x224,
+	DOMAIN_ALIAS_RID_SYSTEM_OPS		= 0x225,
+	DOMAIN_ALIAS_RID_PRINT_OPS		= 0x226,
+	DOMAIN_ALIAS_RID_BACKUP_OPS		= 0x227,
+
+	DOMAIN_ALIAS_RID_REPLICATOR		= 0x228,
+	DOMAIN_ALIAS_RID_RAS_SERVERS		= 0x229,
+	DOMAIN_ALIAS_RID_PREW2KCOMPACCESS	= 0x22a,
+};
+
+/*
+ * The universal well-known SIDs:
+ *
+ *	NULL_SID			S-1-0-0
+ *	WORLD_SID			S-1-1-0
+ *	LOCAL_SID			S-1-2-0
+ *	CREATOR_OWNER_SID		S-1-3-0
+ *	CREATOR_GROUP_SID		S-1-3-1
+ *	CREATOR_OWNER_SERVER_SID	S-1-3-2
+ *	CREATOR_GROUP_SERVER_SID	S-1-3-3
+ *
+ *	(Non-unique IDs)		S-1-4
+ *
+ * NT well-known SIDs:
+ *
+ *	NT_AUTHORITY_SID	S-1-5
+ *	DIALUP_SID		S-1-5-1
+ *
+ *	NETWORD_SID		S-1-5-2
+ *	BATCH_SID		S-1-5-3
+ *	INTERACTIVE_SID		S-1-5-4
+ *	SERVICE_SID		S-1-5-6
+ *	ANONYMOUS_LOGON_SID	S-1-5-7		(aka null logon session)
+ *	PROXY_SID		S-1-5-8
+ *	SERVER_LOGON_SID	S-1-5-9		(aka domain controller account)
+ *	SELF_SID		S-1-5-10	(self RID)
+ *	AUTHENTICATED_USER_SID	S-1-5-11
+ *	RESTRICTED_CODE_SID	S-1-5-12	(running restricted code)
+ *	TERMINAL_SERVER_SID	S-1-5-13	(running on terminal server)
+ *
+ *	(Logon IDs)		S-1-5-5-X-Y
+ *
+ *	(NT non-unique IDs)	S-1-5-0x15-...
+ *
+ *	(Built-in domain)	S-1-5-0x20
+ */
+
+/*
+ * The SID structure is a variable-length structure used to uniquely identify
+ * users or groups. SID stands for security identifier.
+ *
+ * The standard textual representation of the SID is of the form:
+ *	S-R-I-S-S...
+ * Where:
+ *    - The first "S" is the literal character 'S' identifying the following
+ *	digits as a SID.
+ *    - R is the revision level of the SID expressed as a sequence of digits
+ *	either in decimal or hexadecimal (if the later, prefixed by "0x").
+ *    - I is the 48-bit identifier_authority, expressed as digits as R above.
+ *    - S... is one or more sub_authority values, expressed as digits as above.
+ *
+ * Example SID; the domain-relative SID of the local Administrators group on
+ * Windows NT/2k:
+ *	S-1-5-32-544
+ * This translates to a SID with:
+ *	revision = 1,
+ *	sub_authority_count = 2,
+ *	identifier_authority = {0,0,0,0,0,5},	// SECURITY_NT_AUTHORITY
+ *	sub_authority[0] = 32,			// SECURITY_BUILTIN_DOMAIN_RID
+ *	sub_authority[1] = 544			// DOMAIN_ALIAS_RID_ADMINS
+ */
+struct ntfs_sid {
+	u8 revision;
+	u8 sub_authority_count;
+	union {
+		struct {
+			u16 high_part;  /* High 16-bits. */
+			u32 low_part;   /* Low 32-bits. */
+		} __packed parts;
+		u8 value[6];            /* Value as individual bytes. */
+	} identifier_authority;
+	__le32 sub_authority[];		/* At least one sub_authority. */
+} __packed;
+
+/*
+ * The predefined ACE types (8-bit, see below).
+ */
+enum {
+	ACCESS_MIN_MS_ACE_TYPE			= 0,
+	ACCESS_ALLOWED_ACE_TYPE			= 0,
+	ACCESS_DENIED_ACE_TYPE			= 1,
+	SYSTEM_AUDIT_ACE_TYPE			= 2,
+	SYSTEM_ALARM_ACE_TYPE			= 3, /* Not implemented as of Win2k. */
+	ACCESS_MAX_MS_V2_ACE_TYPE		= 3,
+
+	ACCESS_ALLOWED_COMPOUND_ACE_TYPE	= 4,
+	ACCESS_MAX_MS_V3_ACE_TYPE		= 4,
+
+	/* The following are Win2k only. */
+	ACCESS_MIN_MS_OBJECT_ACE_TYPE		= 5,
+	ACCESS_ALLOWED_OBJECT_ACE_TYPE		= 5,
+	ACCESS_DENIED_OBJECT_ACE_TYPE		= 6,
+	SYSTEM_AUDIT_OBJECT_ACE_TYPE		= 7,
+	SYSTEM_ALARM_OBJECT_ACE_TYPE		= 8,
+	ACCESS_MAX_MS_OBJECT_ACE_TYPE		= 8,
+
+	ACCESS_MAX_MS_V4_ACE_TYPE		= 8,
+
+	/* This one is for WinNT/2k. */
+	ACCESS_MAX_MS_ACE_TYPE			= 8,
+} __packed;
+
+/*
+ * The ACE flags (8-bit) for audit and inheritance (see below).
+ *
+ * SUCCESSFUL_ACCESS_ACE_FLAG is only used with system audit and alarm ACE
+ * types to indicate that a message is generated (in Windows!) for successful
+ * accesses.
+ *
+ * FAILED_ACCESS_ACE_FLAG is only used with system audit and alarm ACE types
+ * to indicate that a message is generated (in Windows!) for failed accesses.
+ */
+enum {
+	/* The inheritance flags. */
+	OBJECT_INHERIT_ACE		= 0x01,
+	CONTAINER_INHERIT_ACE		= 0x02,
+	NO_PROPAGATE_INHERIT_ACE	= 0x04,
+	INHERIT_ONLY_ACE		= 0x08,
+	INHERITED_ACE			= 0x10,	/* Win2k only. */
+	VALID_INHERIT_FLAGS		= 0x1f,
+
+	/* The audit flags. */
+	SUCCESSFUL_ACCESS_ACE_FLAG	= 0x40,
+	FAILED_ACCESS_ACE_FLAG		= 0x80,
+} __packed;
+
+/*
+ * The access mask (32-bit). Defines the access rights.
+ *
+ * The specific rights (bits 0 to 15).  These depend on the type of the object
+ * being secured by the ACE.
+ */
+enum {
+	/* Specific rights for files and directories are as follows: */
+
+	/* Right to read data from the file. (FILE) */
+	FILE_READ_DATA			= cpu_to_le32(0x00000001),
+	/* Right to list contents of a directory. (DIRECTORY) */
+	FILE_LIST_DIRECTORY		= cpu_to_le32(0x00000001),
+
+	/* Right to write data to the file. (FILE) */
+	FILE_WRITE_DATA			= cpu_to_le32(0x00000002),
+	/* Right to create a file in the directory. (DIRECTORY) */
+	FILE_ADD_FILE			= cpu_to_le32(0x00000002),
+
+	/* Right to append data to the file. (FILE) */
+	FILE_APPEND_DATA		= cpu_to_le32(0x00000004),
+	/* Right to create a subdirectory. (DIRECTORY) */
+	FILE_ADD_SUBDIRECTORY		= cpu_to_le32(0x00000004),
+
+	/* Right to read extended attributes. (FILE/DIRECTORY) */
+	FILE_READ_EA			= cpu_to_le32(0x00000008),
+
+	/* Right to write extended attributes. (FILE/DIRECTORY) */
+	FILE_WRITE_EA			= cpu_to_le32(0x00000010),
+
+	/* Right to execute a file. (FILE) */
+	FILE_EXECUTE			= cpu_to_le32(0x00000020),
+	/* Right to traverse the directory. (DIRECTORY) */
+	FILE_TRAVERSE			= cpu_to_le32(0x00000020),
+
+	/*
+	 * Right to delete a directory and all the files it contains (its
+	 * children), even if the files are read-only. (DIRECTORY)
+	 */
+	FILE_DELETE_CHILD		= cpu_to_le32(0x00000040),
+
+	/* Right to read file attributes. (FILE/DIRECTORY) */
+	FILE_READ_ATTRIBUTES		= cpu_to_le32(0x00000080),
+
+	/* Right to change file attributes. (FILE/DIRECTORY) */
+	FILE_WRITE_ATTRIBUTES		= cpu_to_le32(0x00000100),
+
+	/*
+	 * The standard rights (bits 16 to 23).  These are independent of the
+	 * type of object being secured.
+	 */
+
+	/* Right to delete the object. */
+	DELETE				= cpu_to_le32(0x00010000),
+
+	/*
+	 * Right to read the information in the object's security descriptor,
+	 * not including the information in the SACL, i.e. right to read the
+	 * security descriptor and owner.
+	 */
+	READ_CONTROL			= cpu_to_le32(0x00020000),
+
+	/* Right to modify the DACL in the object's security descriptor. */
+	WRITE_DAC			= cpu_to_le32(0x00040000),
+
+	/* Right to change the owner in the object's security descriptor. */
+	WRITE_OWNER			= cpu_to_le32(0x00080000),
+
+	/*
+	 * Right to use the object for synchronization.  Enables a process to
+	 * wait until the object is in the signalled state.  Some object types
+	 * do not support this access right.
+	 */
+	SYNCHRONIZE			= cpu_to_le32(0x00100000),
+
+	/*
+	 * The following STANDARD_RIGHTS_* are combinations of the above for
+	 * convenience and are defined by the Win32 API.
+	 */
+
+	/* These are currently defined to READ_CONTROL. */
+	STANDARD_RIGHTS_READ		= cpu_to_le32(0x00020000),
+	STANDARD_RIGHTS_WRITE		= cpu_to_le32(0x00020000),
+	STANDARD_RIGHTS_EXECUTE		= cpu_to_le32(0x00020000),
+
+	/* Combines DELETE, READ_CONTROL, WRITE_DAC, and WRITE_OWNER access. */
+	STANDARD_RIGHTS_REQUIRED	= cpu_to_le32(0x000f0000),
+
+	/*
+	 * Combines DELETE, READ_CONTROL, WRITE_DAC, WRITE_OWNER, and
+	 * SYNCHRONIZE access.
+	 */
+	STANDARD_RIGHTS_ALL		= cpu_to_le32(0x001f0000),
+
+	/*
+	 * The access system ACL and maximum allowed access types (bits 24 to
+	 * 25, bits 26 to 27 are reserved).
+	 */
+	ACCESS_SYSTEM_SECURITY		= cpu_to_le32(0x01000000),
+	MAXIMUM_ALLOWED			= cpu_to_le32(0x02000000),
+
+	/*
+	 * The generic rights (bits 28 to 31).  These map onto the standard and
+	 * specific rights.
+	 */
+
+	/* Read, write, and execute access. */
+	GENERIC_ALL			= cpu_to_le32(0x10000000),
+
+	/* Execute access. */
+	GENERIC_EXECUTE			= cpu_to_le32(0x20000000),
+
+	/*
+	 * Write access.  For files, this maps onto:
+	 *	FILE_APPEND_DATA | FILE_WRITE_ATTRIBUTES | FILE_WRITE_DATA |
+	 *	FILE_WRITE_EA | STANDARD_RIGHTS_WRITE | SYNCHRONIZE
+	 * For directories, the mapping has the same numerical value.  See
+	 * above for the descriptions of the rights granted.
+	 */
+	GENERIC_WRITE			= cpu_to_le32(0x40000000),
+
+	/*
+	 * Read access.  For files, this maps onto:
+	 *	FILE_READ_ATTRIBUTES | FILE_READ_DATA | FILE_READ_EA |
+	 *	STANDARD_RIGHTS_READ | SYNCHRONIZE
+	 * For directories, the mapping has the same numberical value.  See
+	 * above for the descriptions of the rights granted.
+	 */
+	GENERIC_READ			= cpu_to_le32(0x80000000),
+};
+
+/*
+ * The predefined ACE type structures are as defined below.
+ */
+
+struct ntfs_ace {
+	u8 type;		/* Type of the ACE. */
+	u8 flags;		/* Flags describing the ACE. */
+	__le16 size;		/* Size in bytes of the ACE. */
+	__le32 mask;	/* Access mask associated with the ACE. */
+	struct ntfs_sid sid;	/* The SID associated with the ACE. */
+} __packed;
+
+/*
+ * The object ACE flags (32-bit).
+ */
+enum {
+	ACE_OBJECT_TYPE_PRESENT			= cpu_to_le32(1),
+	ACE_INHERITED_OBJECT_TYPE_PRESENT	= cpu_to_le32(2),
+};
+
+/*
+ * An ACL is an access-control list (ACL).
+ * An ACL starts with an ACL header structure, which specifies the size of
+ * the ACL and the number of ACEs it contains. The ACL header is followed by
+ * zero or more access control entries (ACEs). The ACL as well as each ACE
+ * are aligned on 4-byte boundaries.
+ */
+struct ntfs_acl {
+	u8 revision;	/* Revision of this ACL. */
+	u8 alignment1;
+	__le16 size;	/*
+			 * Allocated space in bytes for ACL. Includes this
+			 * header, the ACEs and the remaining free space.
+			 */
+	__le16 ace_count;	/* Number of ACEs in the ACL. */
+	__le16 alignment2;
+/* sizeof() = 8 bytes */
+} __packed;
+
+/*
+ * The security descriptor control flags (16-bit).
+ *
+ * SE_OWNER_DEFAULTED - This boolean flag, when set, indicates that the SID
+ *	pointed to by the Owner field was provided by a defaulting mechanism
+ *	rather than explicitly provided by the original provider of the
+ *	security descriptor.  This may affect the treatment of the SID with
+ *	respect to inheritance of an owner.
+ *
+ * SE_GROUP_DEFAULTED - This boolean flag, when set, indicates that the SID in
+ *	the Group field was provided by a defaulting mechanism rather than
+ *	explicitly provided by the original provider of the security
+ *	descriptor.  This may affect the treatment of the SID with respect to
+ *	inheritance of a primary group.
+ *
+ * SE_DACL_PRESENT - This boolean flag, when set, indicates that the security
+ *	descriptor contains a discretionary ACL.  If this flag is set and the
+ *	Dacl field of the SECURITY_DESCRIPTOR is null, then a null ACL is
+ *	explicitly being specified.
+ *
+ * SE_DACL_DEFAULTED - This boolean flag, when set, indicates that the ACL
+ *	pointed to by the Dacl field was provided by a defaulting mechanism
+ *	rather than explicitly provided by the original provider of the
+ *	security descriptor.  This may affect the treatment of the ACL with
+ *	respect to inheritance of an ACL.  This flag is ignored if the
+ *	DaclPresent flag is not set.
+ *
+ * SE_SACL_PRESENT - This boolean flag, when set,  indicates that the security
+ *	descriptor contains a system ACL pointed to by the Sacl field.  If this
+ *	flag is set and the Sacl field of the SECURITY_DESCRIPTOR is null, then
+ *	an empty (but present) ACL is being specified.
+ *
+ * SE_SACL_DEFAULTED - This boolean flag, when set, indicates that the ACL
+ *	pointed to by the Sacl field was provided by a defaulting mechanism
+ *	rather than explicitly provided by the original provider of the
+ *	security descriptor.  This may affect the treatment of the ACL with
+ *	respect to inheritance of an ACL.  This flag is ignored if the
+ *	SaclPresent flag is not set.
+ *
+ * SE_SELF_RELATIVE - This boolean flag, when set, indicates that the security
+ *	descriptor is in self-relative form.  In this form, all fields of the
+ *	security descriptor are contiguous in memory and all pointer fields are
+ *	expressed as offsets from the beginning of the security descriptor.
+ */
+enum {
+	SE_OWNER_DEFAULTED		= cpu_to_le16(0x0001),
+	SE_GROUP_DEFAULTED		= cpu_to_le16(0x0002),
+	SE_DACL_PRESENT			= cpu_to_le16(0x0004),
+	SE_DACL_DEFAULTED		= cpu_to_le16(0x0008),
+
+	SE_SACL_PRESENT			= cpu_to_le16(0x0010),
+	SE_SACL_DEFAULTED		= cpu_to_le16(0x0020),
+
+	SE_DACL_AUTO_INHERIT_REQ	= cpu_to_le16(0x0100),
+	SE_SACL_AUTO_INHERIT_REQ	= cpu_to_le16(0x0200),
+	SE_DACL_AUTO_INHERITED		= cpu_to_le16(0x0400),
+	SE_SACL_AUTO_INHERITED		= cpu_to_le16(0x0800),
+
+	SE_DACL_PROTECTED		= cpu_to_le16(0x1000),
+	SE_SACL_PROTECTED		= cpu_to_le16(0x2000),
+	SE_RM_CONTROL_VALID		= cpu_to_le16(0x4000),
+	SE_SELF_RELATIVE		= cpu_to_le16(0x8000)
+} __packed;
+
+/*
+ * Self-relative security descriptor. Contains the owner and group SIDs as well
+ * as the sacl and dacl ACLs inside the security descriptor itself.
+ */
+struct security_descriptor_relative {
+	u8 revision;	/* Revision level of the security descriptor. */
+	u8 alignment;
+	__le16 control;	/*
+			 * Flags qualifying the type of * the descriptor as well as
+			 * the following fields.
+			 */
+	__le32 owner;	/*
+			 * Byte offset to a SID representing an object's
+			 * owner. If this is NULL, no owner SID is present in
+			 * the descriptor.
+			 */
+	__le32 group;	/*
+			 * Byte offset to a SID representing an object's
+			 * primary group. If this is NULL, no primary group
+			 * SID is present in the descriptor.
+			 */
+	__le32 sacl;	/*
+			 * Byte offset to a system ACL. Only valid, if
+			 * SE_SACL_PRESENT is set in the control field. If
+			 * SE_SACL_PRESENT is set but sacl is NULL, a NULL ACL
+			 * is specified.
+			 */
+	__le32 dacl;	/*
+			 * Byte offset to a discretionary ACL. Only valid, if
+			 * SE_DACL_PRESENT is set in the control field. If
+			 * SE_DACL_PRESENT is set but dacl is NULL, a NULL ACL
+			 * (unconditionally granting access) is specified.
+			 */
+/* sizeof() = 0x14 bytes */
+} __packed;
+
+/*
+ * On NTFS 3.0+, all security descriptors are stored in FILE_Secure. Only one
+ * referenced instance of each unique security descriptor is stored.
+ *
+ * FILE_Secure contains no unnamed data attribute, i.e. it has zero length. It
+ * does, however, contain two indexes ($SDH and $SII) as well as a named data
+ * stream ($SDS).
+ *
+ * Every unique security descriptor is assigned a unique security identifier
+ * (security_id, not to be confused with a SID). The security_id is unique for
+ * the NTFS volume and is used as an index into the $SII index, which maps
+ * security_ids to the security descriptor's storage location within the $SDS
+ * data attribute. The $SII index is sorted by ascending security_id.
+ *
+ * A simple hash is computed from each security descriptor. This hash is used
+ * as an index into the $SDH index, which maps security descriptor hashes to
+ * the security descriptor's storage location within the $SDS data attribute.
+ * The $SDH index is sorted by security descriptor hash and is stored in a B+
+ * tree. When searching $SDH (with the intent of determining whether or not a
+ * new security descriptor is already present in the $SDS data stream), if a
+ * matching hash is found, but the security descriptors do not match, the
+ * search in the $SDH index is continued, searching for a next matching hash.
+ *
+ * When a precise match is found, the security_id coresponding to the security
+ * descriptor in the $SDS attribute is read from the found $SDH index entry and
+ * is stored in the $STANDARD_INFORMATION attribute of the file/directory to
+ * which the security descriptor is being applied. The $STANDARD_INFORMATION
+ * attribute is present in all base mft records (i.e. in all files and
+ * directories).
+ *
+ * If a match is not found, the security descriptor is assigned a new unique
+ * security_id and is added to the $SDS data attribute. Then, entries
+ * referencing the this security descriptor in the $SDS data attribute are
+ * added to the $SDH and $SII indexes.
+ *
+ * Note: Entries are never deleted from FILE_Secure, even if nothing
+ * references an entry any more.
+ */
+
+/*
+ * The index entry key used in the $SII index. The collation type is
+ * COLLATION_NTOFS_ULONG.
+ */
+struct sii_index_key {
+	__le32 security_id; /* The security_id assigned to the descriptor. */
+} __packed;
+
+/*
+ * The index entry key used in the $SDH index. The keys are sorted first by
+ * hash and then by security_id. The collation rule is
+ * COLLATION_NTOFS_SECURITY_HASH.
+ */
+struct sdh_index_key {
+	__le32 hash;	  /* Hash of the security descriptor. */
+	__le32 security_id; /* The security_id assigned to the descriptor. */
+} __packed;
+
+/*
+ * Possible flags for the volume (16-bit).
+ */
+enum {
+	VOLUME_IS_DIRTY			= cpu_to_le16(0x0001),
+	VOLUME_RESIZE_LOG_FILE		= cpu_to_le16(0x0002),
+	VOLUME_UPGRADE_ON_MOUNT		= cpu_to_le16(0x0004),
+	VOLUME_MOUNTED_ON_NT4		= cpu_to_le16(0x0008),
+
+	VOLUME_DELETE_USN_UNDERWAY	= cpu_to_le16(0x0010),
+	VOLUME_REPAIR_OBJECT_ID		= cpu_to_le16(0x0020),
+
+	VOLUME_CHKDSK_UNDERWAY		= cpu_to_le16(0x4000),
+	VOLUME_MODIFIED_BY_CHKDSK	= cpu_to_le16(0x8000),
+
+	VOLUME_FLAGS_MASK		= cpu_to_le16(0xc03f),
+
+	/* To make our life easier when checking if we must mount read-only. */
+	VOLUME_MUST_MOUNT_RO_MASK	= cpu_to_le16(0xc027),
+} __packed;
+
+/*
+ * Attribute: Volume information (0x70).
+ *
+ * NOTE: Always resident.
+ * NOTE: Present only in FILE_Volume.
+ * NOTE: Windows 2000 uses NTFS 3.0 while Windows NT4 service pack 6a uses
+ *	 NTFS 1.2. I haven't personally seen other values yet.
+ */
+struct volume_information {
+	__le64 reserved;		/* Not used (yet?). */
+	u8 major_ver;		/* Major version of the ntfs format. */
+	u8 minor_ver;		/* Minor version of the ntfs format. */
+	__le16 flags;		/* Bit array of VOLUME_* flags. */
+} __packed;
+
+/*
+ * Index header flags (8-bit).
+ */
+enum {
+	/*
+	 * When index header is in an index root attribute:
+	 */
+	SMALL_INDEX = 0, /*
+			  * The index is small enough to fit inside the index
+			  * root attribute and there is no index allocation
+			  * attribute present.
+			  */
+	LARGE_INDEX = 1, /*
+			  * The index is too large to fit in the index root
+			  * attribute and/or an index allocation attribute is
+			  * present.
+			  */
+	/*
+	 * When index header is in an index block, i.e. is part of index
+	 * allocation attribute:
+	 */
+	LEAF_NODE  = 0, /*
+			 * This is a leaf node, i.e. there are no more nodes
+			 * branching off it.
+			 */
+	INDEX_NODE = 1, /*
+			 * This node indexes other nodes, i.e. it is not a leaf
+			 * node.
+			 */
+	NODE_MASK  = 1, /* Mask for accessing the *_NODE bits. */
+} __packed;
+
+/*
+ * This is the header for indexes, describing the INDEX_ENTRY records, which
+ * follow the index_header. Together the index header and the index entries
+ * make up a complete index.
+ *
+ * IMPORTANT NOTE: The offset, length and size structure members are counted
+ * relative to the start of the index header structure and not relative to the
+ * start of the index root or index allocation structures themselves.
+ */
+struct index_header {
+	__le32 entries_offset;		/*
+					 * Byte offset to first INDEX_ENTRY
+					 * aligned to 8-byte boundary.
+					 */
+	__le32 index_length;		/*
+					 * Data size of the index in bytes,
+					 * i.e. bytes used from allocated
+					 * size, aligned to 8-byte boundary.
+					 */
+	__le32 allocated_size;		/*
+					 * Byte size of this index (block),
+					 * multiple of 8 bytes.
+					 */
+	/*
+	 * NOTE: For the index root attribute, the above two numbers are always
+	 * equal, as the attribute is resident and it is resized as needed. In
+	 * the case of the index allocation attribute the attribute is not
+	 * resident and hence the allocated_size is a fixed value and must
+	 * equal the index_block_size specified by the INDEX_ROOT attribute
+	 * corresponding to the INDEX_ALLOCATION attribute this INDEX_BLOCK
+	 * belongs to.
+	 */
+	u8 flags;			/* Bit field of INDEX_HEADER_FLAGS. */
+	u8 reserved[3];			/* Reserved/align to 8-byte boundary. */
+} __packed;
+
+/*
+ * Attribute: Index root (0x90).
+ *
+ * NOTE: Always resident.
+ *
+ * This is followed by a sequence of index entries (INDEX_ENTRY structures)
+ * as described by the index header.
+ *
+ * When a directory is small enough to fit inside the index root then this
+ * is the only attribute describing the directory. When the directory is too
+ * large to fit in the index root, on the other hand, two additional attributes
+ * are present: an index allocation attribute, containing sub-nodes of the B+
+ * directory tree (see below), and a bitmap attribute, describing which virtual
+ * cluster numbers (vcns) in the index allocation attribute are in use by an
+ * index block.
+ *
+ * NOTE: The root directory (FILE_root) contains an entry for itself. Other
+ * directories do not contain entries for themselves, though.
+ */
+struct index_root {
+	__le32 type;			/*
+					 * Type of the indexed attribute. Is
+					 * $FILE_NAME for directories, zero
+					 * for view indexes. No other values
+					 * allowed.
+					 */
+	__le32 collation_rule;		/*
+					 * Collation rule used to sort the index
+					 * entries. If type is $FILE_NAME, this
+					 * must be COLLATION_FILE_NAME.
+					 */
+	__le32 index_block_size;	/*
+					 * Size of each index block in bytes (in
+					 * the index allocation attribute).
+					 */
+	u8 clusters_per_index_block;	/*
+					 * Cluster size of each index block (in
+					 * the index allocation attribute), when
+					 * an index block is >= than a cluster,
+					 * otherwise this will be the log of
+					 * the size (like how the encoding of
+					 * the mft record size and the index
+					 * record size found in the boot sector
+					 * work). Has to be a power of 2.
+					 */
+	u8 reserved[3];			/* Reserved/align to 8-byte boundary. */
+	struct index_header index;	/* Index header describing the following index entries. */
+} __packed;
+
+/*
+ * Attribute: Index allocation (0xa0).
+ *
+ * NOTE: Always non-resident (doesn't make sense to be resident anyway!).
+ *
+ * This is an array of index blocks. Each index block starts with an
+ * index_block structure containing an index header, followed by a sequence of
+ * index entries (INDEX_ENTRY structures), as described by the struct index_header.
+ */
+struct index_block {
+	__le32 magic;		/* Magic is "INDX". */
+	__le16 usa_ofs;		/* See ntfs_record struct definition. */
+	__le16 usa_count;	/* See ntfs_record struct  definition. */
+
+	__le64 lsn;		/*
+				 * LogFile sequence number of the last
+				 * modification of this index block.
+				 */
+	__le64 index_block_vcn;	/*
+				 * Virtual cluster number of the index block.
+				 * If the cluster_size on the volume is <= the
+				 * index_block_size of the directory,
+				 * index_block_vcn counts in units of clusters,
+				 * and in units of sectors otherwise.
+				 */
+	struct index_header index;	/* Describes the following index entries. */
+/* sizeof()= 40 (0x28) bytes */
+/*
+ * When creating the index block, we place the update sequence array at this
+ * offset, i.e. before we start with the index entries. This also makes sense,
+ * otherwise we could run into problems with the update sequence array
+ * containing in itself the last two bytes of a sector which would mean that
+ * multi sector transfer protection wouldn't work. As you can't protect data
+ * by overwriting it since you then can't get it back...
+ * When reading use the data from the ntfs record header.
+ */
+} __packed;
+
+/*
+ * The system file FILE_Extend/$Reparse contains an index named $R listing
+ * all reparse points on the volume. The index entry keys are as defined
+ * below. Note, that there is no index data associated with the index entries.
+ *
+ * The index entries are sorted by the index key file_id. The collation rule is
+ * COLLATION_NTOFS_ULONGS.
+ */
+struct reparse_index_key {
+	__le32 reparse_tag;	/* Reparse point type (inc. flags). */
+	__le64 file_id;		/*
+				 * Mft record of the file containing
+				 * the reparse point attribute.
+				 */
+} __packed;
+
+/*
+ * Quota flags (32-bit).
+ *
+ * The user quota flags.  Names explain meaning.
+ */
+enum {
+	QUOTA_FLAG_DEFAULT_LIMITS	= cpu_to_le32(0x00000001),
+	QUOTA_FLAG_LIMIT_REACHED	= cpu_to_le32(0x00000002),
+	QUOTA_FLAG_ID_DELETED		= cpu_to_le32(0x00000004),
+
+	QUOTA_FLAG_USER_MASK		= cpu_to_le32(0x00000007),
+	/* This is a bit mask for the user quota flags. */
+
+	/*
+	 * These flags are only present in the quota defaults index entry, i.e.
+	 * in the entry where owner_id = QUOTA_DEFAULTS_ID.
+	 */
+	QUOTA_FLAG_TRACKING_ENABLED	= cpu_to_le32(0x00000010),
+	QUOTA_FLAG_ENFORCEMENT_ENABLED	= cpu_to_le32(0x00000020),
+	QUOTA_FLAG_TRACKING_REQUESTED	= cpu_to_le32(0x00000040),
+	QUOTA_FLAG_LOG_THRESHOLD	= cpu_to_le32(0x00000080),
+
+	QUOTA_FLAG_LOG_LIMIT		= cpu_to_le32(0x00000100),
+	QUOTA_FLAG_OUT_OF_DATE		= cpu_to_le32(0x00000200),
+	QUOTA_FLAG_CORRUPT		= cpu_to_le32(0x00000400),
+	QUOTA_FLAG_PENDING_DELETES	= cpu_to_le32(0x00000800),
+};
+
+/*
+ * The system file FILE_Extend/$Quota contains two indexes $O and $Q. Quotas
+ * are on a per volume and per user basis.
+ *
+ * The $Q index contains one entry for each existing user_id on the volume. The
+ * index key is the user_id of the user/group owning this quota control entry,
+ * i.e. the key is the owner_id. The user_id of the owner of a file, i.e. the
+ * owner_id, is found in the standard information attribute. The collation rule
+ * for $Q is COLLATION_NTOFS_ULONG.
+ *
+ * The $O index contains one entry for each user/group who has been assigned
+ * a quota on that volume. The index key holds the SID of the user_id the
+ * entry belongs to, i.e. the owner_id. The collation rule for $O is
+ * COLLATION_NTOFS_SID.
+ *
+ * The $O index entry data is the user_id of the user corresponding to the SID.
+ * This user_id is used as an index into $Q to find the quota control entry
+ * associated with the SID.
+ *
+ * The $Q index entry data is the quota control entry and is defined below.
+ */
+struct quota_control_entry {
+	__le32 version;		/* Currently equals 2. */
+	__le32 flags;		/* Flags describing this quota entry. */
+	__le64 bytes_used;	/* How many bytes of the quota are in use. */
+	__le64 change_time;	/* Last time this quota entry was changed. */
+	__le64 threshold;	/* Soft quota (-1 if not limited). */
+	__le64 limit;		/* Hard quota (-1 if not limited). */
+	__le64 exceeded_time;	/* How long the soft quota has been exceeded. */
+	struct ntfs_sid sid;	/*
+				 * The SID of the user/object associated with
+				 * this quota entry.  Equals zero for the quota
+				 * defaults entry (and in fact on a WinXP
+				 * volume, it is not present at all).
+				 */
+} __packed;
+
+/*
+ * Predefined owner_id values (32-bit).
+ */
+enum {
+	QUOTA_INVALID_ID	= cpu_to_le32(0x00000000),
+	QUOTA_DEFAULTS_ID	= cpu_to_le32(0x00000001),
+	QUOTA_FIRST_USER_ID	= cpu_to_le32(0x00000100),
+};
+
+/*
+ * Current constants for quota control entries.
+ */
+enum {
+	/* Current version. */
+	QUOTA_VERSION	= 2,
+};
+
+/*
+ * Index entry flags (16-bit).
+ */
+enum {
+	INDEX_ENTRY_NODE = cpu_to_le16(1), /*
+					    * This entry contains a sub-node,
+					    * i.e. a reference to an index block
+					    * in form of a virtual cluster number
+					    * (see below).
+					    */
+	INDEX_ENTRY_END  = cpu_to_le16(2), /*
+					    * This signifies the last entry in an
+					    * index block.  The index entry does not
+					    * represent a file but it can point
+					    * to a sub-node.
+					    */
+
+	INDEX_ENTRY_SPACE_FILLER = cpu_to_le16(0xffff), /* gcc: Force enum bit width to 16-bit. */
+} __packed;
+
+/*
+ * This the index entry header (see below).
+ */
+struct index_entry_header {
+/*  0*/	union {
+		struct { /* Only valid when INDEX_ENTRY_END is not set. */
+			__le64 indexed_file;	/*
+						 * The mft reference of the file
+						 * described by this index entry.
+						 * Used for directory indexes.
+						 */
+		} __packed dir;
+		struct {
+			/* Used for views/indexes to find the entry's data. */
+			__le16 data_offset;	/*
+						 * Data byte offset from this
+						 * INDEX_ENTRY. Follows the index key.
+						 */
+			__le16 data_length;	/* Data length in bytes. */
+			__le32 reservedV;		/* Reserved (zero). */
+		} __packed vi;
+	} __packed data;
+	__le16 length;		/* Byte size of this index entry, multiple of 8-bytes. */
+	__le16 key_length;	/*
+				 * Byte size of the key value, which is in the index entry.
+				 * It follows field reserved. Not multiple of 8-bytes.
+				 */
+	__le16 flags; /* Bit field of INDEX_ENTRY_* flags. */
+	__le16 reserved;		 /* Reserved/align to 8-byte boundary. */
+/* sizeof() = 16 bytes */
+} __packed;
+
+/*
+ * This is an index entry. A sequence of such entries follows each index_header
+ * structure. Together they make up a complete index. The index follows either
+ * an index root attribute or an index allocation attribute.
+ *
+ * NOTE: Before NTFS 3.0 only filename attributes were indexed.
+ */
+struct index_entry {
+	union {
+		struct { /* Only valid when INDEX_ENTRY_END is not set. */
+			__le64 indexed_file;	/*
+						 * The mft reference of the file
+						 * described by this index entry.
+						 * Used for directory indexes.
+						 */
+		} __packed dir;
+		struct { /* Used for views/indexes to find the entry's data. */
+			__le16 data_offset;	/*
+						 * Data byte offset from this INDEX_ENTRY.
+						 * Follows the index key.
+						 */
+			__le16 data_length;	/* Data length in bytes. */
+			__le32 reservedV;		/* Reserved (zero). */
+		} __packed vi;
+	} __packed data;
+	__le16 length;		 /* Byte size of this index entry, multiple of 8-bytes. */
+	__le16 key_length;	 /*
+				  * Byte size of the key value, which is in the index entry.
+				  * It follows field reserved. Not multiple of 8-bytes.
+				  */
+	__le16 flags;		/* Bit field of INDEX_ENTRY_* flags. */
+	__le16 reserved;		 /* Reserved/align to 8-byte boundary. */
+
+	union {
+		/*
+		 * The key of the indexed attribute. NOTE: Only present
+		 * if INDEX_ENTRY_END bit in flags is not set. NOTE: On
+		 * NTFS versions before 3.0 the only valid key is the
+		 * struct file_name_attr. On NTFS 3.0+ the following
+		 * additional index keys are defined:
+		 */
+		struct file_name_attr file_name;	/* $I30 index in directories. */
+		struct sii_index_key sii;	/* $SII index in $Secure. */
+		struct sdh_index_key sdh;	/* $SDH index in $Secure. */
+		struct guid object_id;	/*
+					 * $O index in FILE_Extend/$ObjId: The object_id
+					 * of the mft record found in the data part of
+					 * the index.
+					 */
+		struct reparse_index_key reparse;	/* $R index in FILE_Extend/$Reparse. */
+		struct ntfs_sid sid;	/*
+					 * $O index in FILE_Extend/$Quota:
+					 * SID of the owner of the user_id.
+					 */
+		__le32 owner_id;	/*
+					 * $Q index in FILE_Extend/$Quota:
+					 * user_id of the owner of the quota
+					 * control entry in the data part of
+					 * the index.
+					 */
+	} __packed key;
+	/*
+	 * The (optional) index data is inserted here when creating.
+	 * __le64 vcn;	   If INDEX_ENTRY_NODE bit in flags is set, the last
+	 *		   eight bytes of this index entry contain the virtual
+	 *		   cluster number of the index block that holds the
+	 *		   entries immediately preceding the current entry (the
+	 *		   vcn references the corresponding cluster in the data
+	 *		   of the non-resident index allocation attribute). If
+	 *		   the key_length is zero, then the vcn immediately
+	 *		   follows the INDEX_ENTRY_HEADER. Regardless of
+	 *		   key_length, the address of the 8-byte boundary
+	 *		   aligned vcn of INDEX_ENTRY{_HEADER} *ie is given by
+	 *		   (char*)ie + le16_to_cpu(ie*)->length) - sizeof(VCN),
+	 *		   where sizeof(VCN) can be hardcoded as 8 if wanted.
+	 */
+} __packed;
+
+/*
+ * The reparse point tag defines the type of the reparse point. It also
+ * includes several flags, which further describe the reparse point.
+ *
+ * The reparse point tag is an unsigned 32-bit value divided in three parts:
+ *
+ * 1. The least significant 16 bits (i.e. bits 0 to 15) specify the type of
+ *    the reparse point.
+ * 2. The 12 bits after this (i.e. bits 16 to 27) are reserved for future use.
+ * 3. The most significant four bits are flags describing the reparse point.
+ *    They are defined as follows:
+ *	bit 28: Directory bit. If set, the directory is not a surrogate
+ *		and can be used the usual way.
+ *	bit 29: Name surrogate bit. If set, the filename is an alias for
+ *		another object in the system.
+ *	bit 30: High-latency bit. If set, accessing the first byte of data will
+ *		be slow. (E.g. the data is stored on a tape drive.)
+ *	bit 31: Microsoft bit. If set, the tag is owned by Microsoft. User
+ *		defined tags have to use zero here.
+ * 4. Moreover, on Windows 10 :
+ *	Some flags may be used in bits 12 to 15 to further describe the
+ *	reparse point.
+ */
+enum {
+	IO_REPARSE_TAG_DIRECTORY	= cpu_to_le32(0x10000000),
+	IO_REPARSE_TAG_IS_ALIAS		= cpu_to_le32(0x20000000),
+	IO_REPARSE_TAG_IS_HIGH_LATENCY	= cpu_to_le32(0x40000000),
+	IO_REPARSE_TAG_IS_MICROSOFT	= cpu_to_le32(0x80000000),
+
+	IO_REPARSE_TAG_RESERVED_ZERO	= cpu_to_le32(0x00000000),
+	IO_REPARSE_TAG_RESERVED_ONE	= cpu_to_le32(0x00000001),
+	IO_REPARSE_TAG_RESERVED_RANGE	= cpu_to_le32(0x00000001),
+
+	IO_REPARSE_TAG_CSV		= cpu_to_le32(0x80000009),
+	IO_REPARSE_TAG_DEDUP		= cpu_to_le32(0x80000013),
+	IO_REPARSE_TAG_DFS		= cpu_to_le32(0x8000000A),
+	IO_REPARSE_TAG_DFSR		= cpu_to_le32(0x80000012),
+	IO_REPARSE_TAG_HSM		= cpu_to_le32(0xC0000004),
+	IO_REPARSE_TAG_HSM2		= cpu_to_le32(0x80000006),
+	IO_REPARSE_TAG_MOUNT_POINT	= cpu_to_le32(0xA0000003),
+	IO_REPARSE_TAG_NFS		= cpu_to_le32(0x80000014),
+	IO_REPARSE_TAG_SIS		= cpu_to_le32(0x80000007),
+	IO_REPARSE_TAG_SYMLINK		= cpu_to_le32(0xA000000C),
+	IO_REPARSE_TAG_WIM		= cpu_to_le32(0x80000008),
+	IO_REPARSE_TAG_DFM		= cpu_to_le32(0x80000016),
+	IO_REPARSE_TAG_WOF		= cpu_to_le32(0x80000017),
+	IO_REPARSE_TAG_WCI		= cpu_to_le32(0x80000018),
+	IO_REPARSE_TAG_CLOUD		= cpu_to_le32(0x9000001A),
+	IO_REPARSE_TAG_APPEXECLINK	= cpu_to_le32(0x8000001B),
+	IO_REPARSE_TAG_GVFS		= cpu_to_le32(0x9000001C),
+	IO_REPARSE_TAG_LX_SYMLINK	= cpu_to_le32(0xA000001D),
+	IO_REPARSE_TAG_AF_UNIX		= cpu_to_le32(0x80000023),
+	IO_REPARSE_TAG_LX_FIFO		= cpu_to_le32(0x80000024),
+	IO_REPARSE_TAG_LX_CHR		= cpu_to_le32(0x80000025),
+	IO_REPARSE_TAG_LX_BLK		= cpu_to_le32(0x80000026),
+
+	IO_REPARSE_TAG_VALID_VALUES	= cpu_to_le32(0xf000ffff),
+	IO_REPARSE_PLUGIN_SELECT	= cpu_to_le32(0xffff0fff),
+};
+
+/*
+ * Attribute: Reparse point (0xc0).
+ *
+ * NOTE: Can be resident or non-resident.
+ */
+struct reparse_point {
+	__le32 reparse_tag;		/* Reparse point type (inc. flags). */
+	__le16 reparse_data_length;	/* Byte size of reparse data. */
+	__le16 reserved;			/* Align to 8-byte boundary. */
+	u8 reparse_data[0];		/* Meaning depends on reparse_tag. */
+} __packed;
+
+/*
+ * Attribute: Extended attribute (EA) information (0xd0).
+ *
+ * NOTE: Always resident. (Is this true???)
+ */
+struct ea_information {
+	__le16 ea_length;		/* Byte size of the packed extended attributes. */
+	__le16 need_ea_count;	/*
+				 * The number of extended attributes which have
+				 * the NEED_EA bit set.
+				 */
+	__le32 ea_query_length;	/*
+				 * Byte size of the buffer required to query
+				 * the extended attributes when calling
+				 * ZwQueryEaFile() in Windows NT/2k. I.e.
+				 * the byte size of the unpacked extended attributes.
+				 */
+} __packed;
+
+/*
+ * Extended attribute flags (8-bit).
+ */
+enum {
+	NEED_EA	= 0x80		/*
+				 * If set the file to which the EA belongs
+				 * cannot be interpreted without understanding
+				 * the associates extended attributes.
+				 */
+} __packed;
+
+/*
+ * Attribute: Extended attribute (EA) (0xe0).
+ *
+ * NOTE: Can be resident or non-resident.
+ *
+ * Like the attribute list and the index buffer list, the EA attribute value is
+ * a sequence of EA_ATTR variable length records.
+ */
+struct ea_attr {
+	__le32 next_entry_offset;	/* Offset to the next EA_ATTR. */
+	u8 flags;		/* Flags describing the EA. */
+	u8 ea_name_length;	/*
+				 * Length of the name of the EA in bytes
+				 * excluding the '\0' byte terminator.
+				 */
+	__le16 ea_value_length;	/* Byte size of the EA's value. */
+	u8 ea_name[];		/*
+				 * Name of the EA.  Note this is ASCII, not
+				 * Unicode and it is zero terminated.
+				 */
+	/* u8 ea_value[]; */	/* The value of the EA.  Immediately follows the name. */
+} __packed;
+
+#endif /* _LINUX_NTFS_LAYOUT_H */
diff --git a/fs/ntfsplus/lcnalloc.h b/fs/ntfsplus/lcnalloc.h
new file mode 100644
index 000000000000..a1c66b8b73ac
--- /dev/null
+++ b/fs/ntfsplus/lcnalloc.h
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Exports for NTFS kernel cluster (de)allocation.
+ * Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2004-2005 Anton Altaparmakov
+ */
+
+#ifndef _LINUX_NTFS_LCNALLOC_H
+#define _LINUX_NTFS_LCNALLOC_H
+
+#include <linux/sched/mm.h>
+
+#include "attrib.h"
+
+enum {
+	FIRST_ZONE	= 0,	/* For sanity checking. */
+	MFT_ZONE	= 0,	/* Allocate from $MFT zone. */
+	DATA_ZONE	= 1,	/* Allocate from $DATA zone. */
+	LAST_ZONE	= 1,	/* For sanity checking. */
+};
+
+struct runlist_element *ntfs_cluster_alloc(struct ntfs_volume *vol,
+		const s64 start_vcn, const s64 count, const s64 start_lcn,
+		const int zone,
+		const bool is_extension,
+		const bool is_contig,
+		const bool is_dealloc);
+s64 __ntfs_cluster_free(struct ntfs_inode *ni, const s64 start_vcn,
+		s64 count, struct ntfs_attr_search_ctx *ctx, const bool is_rollback);
+
+/**
+ * ntfs_cluster_free - free clusters on an ntfs volume
+ * @ni:		ntfs inode whose runlist describes the clusters to free
+ * @start_vcn:	vcn in the runlist of @ni at which to start freeing clusters
+ * @count:	number of clusters to free or -1 for all clusters
+ * @ctx:	active attribute search context if present or NULL if not
+ *
+ * Free @count clusters starting at the cluster @start_vcn in the runlist
+ * described by the ntfs inode @ni.
+ *
+ * If @count is -1, all clusters from @start_vcn to the end of the runlist are
+ * deallocated.  Thus, to completely free all clusters in a runlist, use
+ * @start_vcn = 0 and @count = -1.
+ *
+ * If @ctx is specified, it is an active search context of @ni and its base mft
+ * record.  This is needed when ntfs_cluster_free() encounters unmapped runlist
+ * fragments and allows their mapping.  If you do not have the mft record
+ * mapped, you can specify @ctx as NULL and ntfs_cluster_free() will perform
+ * the necessary mapping and unmapping.
+ *
+ * Note, ntfs_cluster_free() saves the state of @ctx on entry and restores it
+ * before returning.  Thus, @ctx will be left pointing to the same attribute on
+ * return as on entry.  However, the actual pointers in @ctx may point to
+ * different memory locations on return, so you must remember to reset any
+ * cached pointers from the @ctx, i.e. after the call to ntfs_cluster_free(),
+ * you will probably want to do:
+ *	m = ctx->mrec;
+ *	a = ctx->attr;
+ * Assuming you cache ctx->attr in a variable @a of type ATTR_RECORD * and that
+ * you cache ctx->mrec in a variable @m of type MFT_RECORD *.
+ *
+ * Note, ntfs_cluster_free() does not modify the runlist, so you have to remove
+ * from the runlist or mark sparse the freed runs later.
+ *
+ * Return the number of deallocated clusters (not counting sparse ones) on
+ * success and -errno on error.
+ *
+ * WARNING: If @ctx is supplied, regardless of whether success or failure is
+ *	    returned, you need to check IS_ERR(@ctx->mrec) and if 'true' the @ctx
+ *	    is no longer valid, i.e. you need to either call
+ *	    ntfs_attr_reinit_search_ctx() or ntfs_attr_put_search_ctx() on it.
+ *	    In that case PTR_ERR(@ctx->mrec) will give you the error code for
+ *	    why the mapping of the old inode failed.
+ *
+ * Locking: - The runlist described by @ni must be locked for writing on entry
+ *	      and is locked on return.  Note the runlist may be modified when
+ *	      needed runlist fragments need to be mapped.
+ *	    - The volume lcn bitmap must be unlocked on entry and is unlocked
+ *	      on return.
+ *	    - This function takes the volume lcn bitmap lock for writing and
+ *	      modifies the bitmap contents.
+ *	    - If @ctx is NULL, the base mft record of @ni must not be mapped on
+ *	      entry and it will be left unmapped on return.
+ *	    - If @ctx is not NULL, the base mft record must be mapped on entry
+ *	      and it will be left mapped on return.
+ */
+static inline s64 ntfs_cluster_free(struct ntfs_inode *ni, const s64 start_vcn,
+		s64 count, struct ntfs_attr_search_ctx *ctx)
+{
+	return __ntfs_cluster_free(ni, start_vcn, count, ctx, false);
+}
+
+int ntfs_cluster_free_from_rl_nolock(struct ntfs_volume *vol,
+		const struct runlist_element *rl);
+
+/**
+ * ntfs_cluster_free_from_rl - free clusters from runlist
+ * @vol:	mounted ntfs volume on which to free the clusters
+ * @rl:		runlist describing the clusters to free
+ *
+ * Free all the clusters described by the runlist @rl on the volume @vol.  In
+ * the case of an error being returned, at least some of the clusters were not
+ * freed.
+ *
+ * Return 0 on success and -errno on error.
+ *
+ * Locking: - This function takes the volume lcn bitmap lock for writing and
+ *	      modifies the bitmap contents.
+ *	    - The caller must have locked the runlist @rl for reading or
+ *	      writing.
+ */
+static inline int ntfs_cluster_free_from_rl(struct ntfs_volume *vol,
+		const struct runlist_element *rl)
+{
+	int ret;
+	unsigned int memalloc_flags;
+
+	memalloc_flags = memalloc_nofs_save();
+	down_write(&vol->lcnbmp_lock);
+	ret = ntfs_cluster_free_from_rl_nolock(vol, rl);
+	up_write(&vol->lcnbmp_lock);
+	memalloc_nofs_restore(memalloc_flags);
+	return ret;
+}
+
+#endif /* defined _LINUX_NTFS_LCNALLOC_H */
diff --git a/fs/ntfsplus/logfile.h b/fs/ntfsplus/logfile.h
new file mode 100644
index 000000000000..3c7e42425503
--- /dev/null
+++ b/fs/ntfsplus/logfile.h
@@ -0,0 +1,316 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Defines for NTFS kernel journal (LogFile) handling.
+ * Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2000-2005 Anton Altaparmakov
+ */
+
+#ifndef _LINUX_NTFS_LOGFILE_H
+#define _LINUX_NTFS_LOGFILE_H
+
+#include "layout.h"
+
+/*
+ * Journal (LogFile) organization:
+ *
+ * Two restart areas present in the first two pages (restart pages, one restart
+ * area in each page).  When the volume is dismounted they should be identical,
+ * except for the update sequence array which usually has a different update
+ * sequence number.
+ *
+ * These are followed by log records organized in pages headed by a log record
+ * header going up to log file size.  Not all pages contain log records when a
+ * volume is first formatted, but as the volume ages, all records will be used.
+ * When the log file fills up, the records at the beginning are purged (by
+ * modifying the oldest_lsn to a higher value presumably) and writing begins
+ * at the beginning of the file.  Effectively, the log file is viewed as a
+ * circular entity.
+ *
+ * NOTE: Windows NT, 2000, and XP all use log file version 1.1 but they accept
+ * versions <= 1.x, including 0.-1.  (Yes, that is a minus one in there!)  We
+ * probably only want to support 1.1 as this seems to be the current version
+ * and we don't know how that differs from the older versions.  The only
+ * exception is if the journal is clean as marked by the two restart pages
+ * then it doesn't matter whether we are on an earlier version.  We can just
+ * reinitialize the logfile and start again with version 1.1.
+ */
+
+/* Some LogFile related constants. */
+#define MaxLogFileSize		0x100000000ULL
+#define DefaultLogPageSize	4096
+#define MinLogRecordPages	48
+
+/*
+ * Log file restart page header (begins the restart area).
+ */
+struct restart_page_header {
+	__le32 magic;		/* The magic is "RSTR". */
+	__le16 usa_ofs;		/*
+				 * See ntfs_record struct definition in layout.h.
+				 * When creating, set this to be immediately after
+				 * this header structure (without any alignment).
+				 */
+	__le16 usa_count;	/* See ntfs_record struct definition in layout.h. */
+
+	__le64 chkdsk_lsn;	/*
+				 * The last log file sequence number found by chkdsk.
+				 * Only used when the magic is changed to "CHKD".
+				 * Otherwise this is zero.
+				 */
+	__le32 system_page_size; /*
+				  * Byte size of system pages when the log file was created,
+				  * has to be >= 512 and a power of 2.  Use this to calculate
+				  * the required size of the usa (usa_count) and add it to
+				  * usa_ofs. Then verify that the result is less than
+				  * the value of the restart_area_offset.
+				  */
+	__le32 log_page_size;	/*
+				 * Byte size of log file pages, has to be >= 512 and
+				 * a power of 2.  The default is 4096 and is used
+				 * when the system page size is between 4096 and 8192.
+				 * Otherwise this is set to the system page size instead.
+				 */
+	__le16 restart_area_offset; /*
+				     * Byte offset from the start of this header to
+				     * the RESTART_AREA. Value has to be aligned to 8-byte
+				     * boundary.  When creating, set this to be after the usa.
+				     */
+	__le16 minor_ver;	/* Log file minor version.  Only check if major version is 1. */
+	__le16 major_ver;	/* Log file major version.  We only support version 1.1. */
+/* sizeof() = 30 (0x1e) bytes */
+} __packed;
+
+/*
+ * Constant for the log client indices meaning that there are no client records
+ * in this particular client array.  Also inside the client records themselves,
+ * this means that there are no client records preceding or following this one.
+ */
+#define LOGFILE_NO_CLIENT	cpu_to_le16(0xffff)
+#define LOGFILE_NO_CLIENT_CPU	0xffff
+
+/*
+ * These are the so far known RESTART_AREA_* flags (16-bit) which contain
+ * information about the log file in which they are present.
+ */
+enum {
+	RESTART_VOLUME_IS_CLEAN	= cpu_to_le16(0x0002),
+	RESTART_SPACE_FILLER	= cpu_to_le16(0xffff), /* gcc: Force enum bit width to 16. */
+} __packed;
+
+/*
+ * Log file restart area record.  The offset of this record is found by adding
+ * the offset of the RESTART_PAGE_HEADER to the restart_area_offset value found
+ * in it.  See notes at restart_area_offset above.
+ */
+struct restart_area {
+	__le64 current_lsn;		/*
+					 * The current, i.e. last LSN inside the log
+					 * when the restart area was last written.
+					 * This happens often but what is the interval?
+					 * Is it just fixed time or is it every time a
+					 * check point is written or somethine else?
+					 * On create set to 0.
+					 */
+	__le16 log_clients;		/*
+					 * Number of log client records in the array of
+					 * log client records which follows this
+					 * restart area.  Must be 1.
+					 */
+	__le16 client_free_list;	/*
+					 * The index of the first free log client record
+					 * in the array of log client records.
+					 * LOGFILE_NO_CLIENT means that there are no
+					 * free log client records in the array.
+					 * If != LOGFILE_NO_CLIENT, check that
+					 * log_clients > client_free_list.  On Win2k
+					 * and presumably earlier, on a clean volume
+					 * this is != LOGFILE_NO_CLIENT, and it should
+					 * be 0, i.e. the first (and only) client
+					 * record is free and thus the logfile is
+					 * closed and hence clean.  A dirty volume
+					 * would have left the logfile open and hence
+					 * this would be LOGFILE_NO_CLIENT.  On WinXP
+					 * and presumably later, the logfile is always
+					 * open, even on clean shutdown so this should
+					 * always be LOGFILE_NO_CLIENT.
+					 */
+	__le16 client_in_use_list;	/*
+					 * The index of the first in-use log client
+					 * record in the array of log client records.
+					 * LOGFILE_NO_CLIENT means that there are no
+					 * in-use log client records in the array.  If
+					 * != LOGFILE_NO_CLIENT check that log_clients
+					 * > client_in_use_list.  On Win2k and
+					 * presumably earlier, on a clean volume this
+					 * is LOGFILE_NO_CLIENT, i.e. there are no
+					 * client records in use and thus the logfile
+					 * is closed and hence clean.  A dirty volume
+					 * would have left the logfile open and hence
+					 * this would be != LOGFILE_NO_CLIENT, and it
+					 * should be 0, i.e. the first (and only)
+					 * client record is in use.  On WinXP and
+					 * presumably later, the logfile is always
+					 * open, even on clean shutdown so this should
+					 * always be 0.
+					 */
+	__le16 flags;			/*
+					 * Flags modifying LFS behaviour.  On Win2k
+					 * and presumably earlier this is always 0.  On
+					 * WinXP and presumably later, if the logfile
+					 * was shutdown cleanly, the second bit,
+					 * RESTART_VOLUME_IS_CLEAN, is set.  This bit
+					 * is cleared when the volume is mounted by
+					 * WinXP and set when the volume is dismounted,
+					 * thus if the logfile is dirty, this bit is
+					 * clear.  Thus we don't need to check the
+					 * Windows version to determine if the logfile
+					 * is clean.  Instead if the logfile is closed,
+					 * we know it must be clean.  If it is open and
+					 * this bit is set, we also know it must be
+					 * clean.  If on the other hand the logfile is
+					 * open and this bit is clear, we can be almost
+					 * certain that the logfile is dirty.
+					 */
+	__le32 seq_number_bits;		/*
+					 * How many bits to use for the sequence
+					 * number.  This is calculated as 67 - the
+					 * number of bits required to store the logfile
+					 * size in bytes and this can be used in with
+					 * the specified file_size as a consistency
+					 * check.
+					 */
+	__le16 restart_area_length;	/*
+					 * Length of the restart area including the
+					 * client array.  Following checks required if
+					 * version matches.  Otherwise, skip them.
+					 * restart_area_offset + restart_area_length
+					 * has to be <= system_page_size.  Also,
+					 * restart_area_length has to be >=
+					 * client_array_offset + (log_clients *
+					 * sizeof(log client record)).
+					 */
+	__le16 client_array_offset;	/*
+					 * Offset from the start of this record to
+					 * the first log client record if versions are
+					 * matched.  When creating, set this to be
+					 * after this restart area structure, aligned
+					 * to 8-bytes boundary.  If the versions do not
+					 * match, this is ignored and the offset is
+					 * assumed to be (sizeof(RESTART_AREA) + 7) &
+					 * ~7, i.e. rounded up to first 8-byte
+					 * boundary.  Either way, client_array_offset
+					 * has to be aligned to an 8-byte boundary.
+					 * Also, restart_area_offset +
+					 * client_array_offset has to be <= 510.
+					 * Finally, client_array_offset + (log_clients
+					 * sizeof(log client record)) has to be <=
+					 * system_page_size.  On Win2k and presumably
+					 * earlier, this is 0x30, i.e. immediately
+					 * following this record.  On WinXP and
+					 * presumably later, this is 0x40, i.e. there
+					 * are 16 extra bytes between this record and
+					 * the client array.  This probably means that
+					 * the RESTART_AREA record is actually bigger
+					 * in WinXP and later.
+					 */
+	__le64 file_size;		/*
+					 * Usable byte size of the log file.  If the
+					 * restart_area_offset + the offset of the
+					 * file_size are > 510 then corruption has
+					 * occurred.  This is the very first check when
+					 * starting with the restart_area as if it
+					 * fails it means that some of the above values
+					 * will be corrupted by the multi sector
+					 * transfer protection.  The file_size has to
+					 * be rounded down to be a multiple of the
+					 * log_page_size in the RESTART_PAGE_HEADER and
+					 * then it has to be at least big enough to
+					 * store the two restart pages and 48 (0x30)
+					 * log record pages.
+					 */
+	__le32 last_lsn_data_length;	/*
+					 * Length of data of last LSN, not including
+					 * the log record header.  On create set to 0.
+					 */
+	__le16 log_record_header_length; /*
+					  * Byte size of the log record header.
+					  * If the version matches then check that the
+					  * value of log_record_header_length is a
+					  * multiple of 8,
+					  * i.e. (log_record_header_length + 7) & ~7 ==
+					  * log_record_header_length.  When creating set
+					  * it to sizeof(LOG_RECORD_HEADER), aligned to
+					  * 8 bytes.
+					  */
+	__le16 log_page_data_offset;	/*
+					 * Offset to the start of data in a log record
+					 * page.  Must be a multiple of 8.  On create
+					 * set it to immediately after the update sequence
+					 * array of the log record page.
+					 */
+	__le32 restart_log_open_count;	/*
+					 * A counter that gets incremented every time
+					 * the logfile is restarted which happens at mount
+					 * time when the logfile is opened. When creating
+					 * set to a random value.  Win2k sets it to the low
+					 * 32 bits of the current system time in NTFS format
+					 * (see time.h).
+					 */
+	__le32 reserved;		/* Reserved/alignment to 8-byte boundary. */
+/* sizeof() = 48 (0x30) bytes */
+} __packed;
+
+/*
+ * Log client record.  The offset of this record is found by adding the offset
+ * of the RESTART_AREA to the client_array_offset value found in it.
+ */
+struct log_client_record {
+	__le64 oldest_lsn;	/*
+				 * Oldest LSN needed by this client.  On create
+				 * set to 0.
+				 */
+	__le64 client_restart_lsn;	/*
+					 * LSN at which this client needs to restart
+					 * the volume, i.e. the current position within
+					 * the log file.  At present, if clean this
+					 * should = current_lsn in restart area but it
+					 * probably also = current_lsn when dirty most
+					 * of the time.  At create set to 0.
+					 */
+	__le16 prev_client;	/*
+				 * The offset to the previous log client record
+				 * in the array of log client records.
+				 * LOGFILE_NO_CLIENT means there is no previous
+				 * client record, i.e. this is the first one.
+				 * This is always LOGFILE_NO_CLIENT.
+				 */
+	__le16 next_client;	/*
+				 * The offset to the next log client record in
+				 * the array of log client records.
+				 * LOGFILE_NO_CLIENT means there are no next
+				 * client records, i.e. this is the last one.
+				 * This is always LOGFILE_NO_CLIENT.
+				 */
+	__le16 seq_number;	/*
+				 * On Win2k and presumably earlier, this is set
+				 * to zero every time the logfile is restarted
+				 * and it is incremented when the logfile is
+				 * closed at dismount time.  Thus it is 0 when
+				 * dirty and 1 when clean.  On WinXP and
+				 * presumably later, this is always 0.
+				 */
+	u8 reserved[6];		/* Reserved/alignment. */
+	__le32 client_name_length;	/* Length of client name in bytes.  Should always be 8. */
+	__le16 client_name[64];		/*
+					 * Name of the client in Unicode.
+					 * Should always be "NTFS" with the remaining bytes
+					 * set to 0.
+					 */
+/* sizeof() = 160 (0xa0) bytes */
+} __packed;
+
+bool ntfs_check_logfile(struct inode *log_vi,
+		struct restart_page_header **rp);
+bool ntfs_empty_logfile(struct inode *log_vi);
+#endif /* _LINUX_NTFS_LOGFILE_H */
diff --git a/fs/ntfsplus/mft.h b/fs/ntfsplus/mft.h
new file mode 100644
index 000000000000..19c05ec2f278
--- /dev/null
+++ b/fs/ntfsplus/mft.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Defines for mft record handling in NTFS Linux kernel driver.
+ * Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2001-2004 Anton Altaparmakov
+ */
+
+#ifndef _LINUX_NTFS_MFT_H
+#define _LINUX_NTFS_MFT_H
+
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+
+#include "inode.h"
+
+struct mft_record *map_mft_record(struct ntfs_inode *ni);
+void unmap_mft_record(struct ntfs_inode *ni);
+struct mft_record *map_extent_mft_record(struct ntfs_inode *base_ni, u64 mref,
+		struct ntfs_inode **ntfs_ino);
+
+static inline void unmap_extent_mft_record(struct ntfs_inode *ni)
+{
+	unmap_mft_record(ni);
+}
+
+void __mark_mft_record_dirty(struct ntfs_inode *ni);
+
+/**
+ * mark_mft_record_dirty - set the mft record and the page containing it dirty
+ * @ni:		ntfs inode describing the mapped mft record
+ *
+ * Set the mapped (extent) mft record of the (base or extent) ntfs inode @ni,
+ * as well as the page containing the mft record, dirty.  Also, mark the base
+ * vfs inode dirty.  This ensures that any changes to the mft record are
+ * written out to disk.
+ *
+ * NOTE:  Do not do anything if the mft record is already marked dirty.
+ */
+static inline void mark_mft_record_dirty(struct ntfs_inode *ni)
+{
+	if (!NInoTestSetDirty(ni))
+		__mark_mft_record_dirty(ni);
+}
+
+int ntfs_sync_mft_mirror(struct ntfs_volume *vol, const unsigned long mft_no,
+		struct mft_record *m);
+int write_mft_record_nolock(struct ntfs_inode *ni, struct mft_record *m, int sync);
+
+/**
+ * write_mft_record - write out a mapped (extent) mft record
+ * @ni:		ntfs inode describing the mapped (extent) mft record
+ * @m:		mapped (extent) mft record to write
+ * @sync:	if true, wait for i/o completion
+ *
+ * This is just a wrapper for write_mft_record_nolock() (see mft.c), which
+ * locks the page for the duration of the write.  This ensures that there are
+ * no race conditions between writing the mft record via the dirty inode code
+ * paths and via the page cache write back code paths or between writing
+ * neighbouring mft records residing in the same page.
+ *
+ * Locking the page also serializes us against ->read_folio() if the page is not
+ * uptodate.
+ *
+ * On success, clean the mft record and return 0.  On error, leave the mft
+ * record dirty and return -errno.
+ */
+static inline int write_mft_record(struct ntfs_inode *ni, struct mft_record *m, int sync)
+{
+	struct folio *folio = ni->folio;
+	int err;
+
+	BUG_ON(!folio);
+	folio_lock(folio);
+	err = write_mft_record_nolock(ni, m, sync);
+	folio_unlock(folio);
+
+	return err;
+}
+
+bool ntfs_may_write_mft_record(struct ntfs_volume *vol,
+		const unsigned long mft_no, const struct mft_record *m,
+		struct ntfs_inode **locked_ni);
+int ntfs_mft_record_alloc(struct ntfs_volume *vol, const int mode,
+		struct ntfs_inode **ni, struct ntfs_inode *base_ni,
+		struct mft_record **ni_mrec);
+int ntfs_mft_record_free(struct ntfs_volume *vol, struct ntfs_inode *ni);
+int ntfs_mft_records_write(const struct ntfs_volume *vol, const u64 mref,
+		const s64 count, struct mft_record *b);
+int ntfs_mft_record_check(const struct ntfs_volume *vol, struct mft_record *m,
+			  unsigned long mft_no);
+
+#endif /* _LINUX_NTFS_MFT_H */
diff --git a/fs/ntfsplus/misc.h b/fs/ntfsplus/misc.h
new file mode 100644
index 000000000000..3952c6c18bd0
--- /dev/null
+++ b/fs/ntfsplus/misc.h
@@ -0,0 +1,218 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * NTFS kernel debug support. Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2001-2004 Anton Altaparmakov
+ */
+
+#ifndef _LINUX_NTFS_MISC_H
+#define _LINUX_NTFS_MISC_H
+
+#include <linux/fs.h>
+#include <linux/vmalloc.h>
+#include <linux/highmem.h>
+
+#include "runlist.h"
+
+#ifdef DEBUG
+
+extern int debug_msgs;
+
+extern __printf(4, 5)
+void __ntfs_debug(const char *file, int line, const char *function,
+		  const char *format, ...);
+/**
+ * ntfs_debug - write a debug level message to syslog
+ * @f:		a printf format string containing the message
+ * @...:	the variables to substitute into @f
+ *
+ * ntfs_debug() writes a DEBUG level message to the syslog but only if the
+ * driver was compiled with -DDEBUG. Otherwise, the call turns into a NOP.
+ */
+#define ntfs_debug(f, a...)						\
+	__ntfs_debug(__FILE__, __LINE__, __func__, f, ##a)
+
+void ntfs_debug_dump_runlist(const struct runlist_element *rl);
+
+#else	/* !DEBUG */
+
+#define ntfs_debug(fmt, ...)						\
+do {									\
+	if (0)								\
+		no_printk(fmt, ##__VA_ARGS__);				\
+} while (0)
+
+#define ntfs_debug_dump_runlist(rl)					\
+do {									\
+	if (0)								\
+		(void)rl;						\
+} while (0)
+
+#endif	/* !DEBUG */
+
+extern  __printf(3, 4)
+void __ntfs_warning(const char *function, const struct super_block *sb,
+		    const char *fmt, ...);
+#define ntfs_warning(sb, f, a...)	__ntfs_warning(__func__, sb, f, ##a)
+
+extern  __printf(3, 4)
+void __ntfs_error(const char *function, struct super_block *sb,
+		  const char *fmt, ...);
+#define ntfs_error(sb, f, a...)		__ntfs_error(__func__, sb, f, ##a)
+
+void ntfs_handle_error(struct super_block *sb);
+
+#if defined(DEBUG) && defined(CONFIG_SYSCTL)
+int ntfs_sysctl(int add);
+#else
+/* Just return success. */
+static inline int ntfs_sysctl(int add)
+{
+	return 0;
+}
+#endif
+
+#define NTFS_TIME_OFFSET ((s64)(369 * 365 + 89) * 24 * 3600 * 10000000)
+
+/**
+ * utc2ntfs - convert Linux UTC time to NTFS time
+ * @ts:		Linux UTC time to convert to NTFS time
+ *
+ * Convert the Linux UTC time @ts to its corresponding NTFS time and return
+ * that in little endian format.
+ *
+ * Linux stores time in a struct timespec64 consisting of a time64_t tv_sec
+ * and a long tv_nsec where tv_sec is the number of 1-second intervals since
+ * 1st January 1970, 00:00:00 UTC and tv_nsec is the number of 1-nano-second
+ * intervals since the value of tv_sec.
+ *
+ * NTFS uses Microsoft's standard time format which is stored in a s64 and is
+ * measured as the number of 100-nano-second intervals since 1st January 1601,
+ * 00:00:00 UTC.
+ */
+static inline __le64 utc2ntfs(const struct timespec64 ts)
+{
+	/*
+	 * Convert the seconds to 100ns intervals, add the nano-seconds
+	 * converted to 100ns intervals, and then add the NTFS time offset.
+	 */
+	return cpu_to_le64((s64)ts.tv_sec * 10000000 + ts.tv_nsec / 100 +
+			NTFS_TIME_OFFSET);
+}
+
+/**
+ * ntfs2utc - convert NTFS time to Linux time
+ * @time:	NTFS time (little endian) to convert to Linux UTC
+ *
+ * Convert the little endian NTFS time @time to its corresponding Linux UTC
+ * time and return that in cpu format.
+ *
+ * Linux stores time in a struct timespec64 consisting of a time64_t tv_sec
+ * and a long tv_nsec where tv_sec is the number of 1-second intervals since
+ * 1st January 1970, 00:00:00 UTC and tv_nsec is the number of 1-nano-second
+ * intervals since the value of tv_sec.
+ *
+ * NTFS uses Microsoft's standard time format which is stored in a s64 and is
+ * measured as the number of 100 nano-second intervals since 1st January 1601,
+ * 00:00:00 UTC.
+ */
+static inline struct timespec64 ntfs2utc(const __le64 time)
+{
+	struct timespec64 ts;
+
+	/* Subtract the NTFS time offset. */
+	u64 t = (u64)(le64_to_cpu(time) - NTFS_TIME_OFFSET);
+	/*
+	 * Convert the time to 1-second intervals and the remainder to
+	 * 1-nano-second intervals.
+	 */
+	ts.tv_nsec = do_div(t, 10000000) * 100;
+	ts.tv_sec = t;
+	return ts;
+}
+
+/**
+ * __ntfs_malloc - allocate memory in multiples of pages
+ * @size:	number of bytes to allocate
+ * @gfp_mask:	extra flags for the allocator
+ *
+ * Internal function.  You probably want ntfs_malloc_nofs()...
+ *
+ * Allocates @size bytes of memory, rounded up to multiples of PAGE_SIZE and
+ * returns a pointer to the allocated memory.
+ *
+ * If there was insufficient memory to complete the request, return NULL.
+ * Depending on @gfp_mask the allocation may be guaranteed to succeed.
+ */
+static inline void *__ntfs_malloc(unsigned long size, gfp_t gfp_mask)
+{
+	if (likely(size <= PAGE_SIZE)) {
+		if (!size)
+			return NULL;
+		/* kmalloc() has per-CPU caches so is faster for now. */
+		return kmalloc(PAGE_SIZE, gfp_mask & ~__GFP_HIGHMEM);
+		/* return (void *)__get_free_page(gfp_mask); */
+	}
+	if (likely((size >> PAGE_SHIFT) < totalram_pages()))
+		return __vmalloc(size, gfp_mask);
+	return NULL;
+}
+
+/**
+ * ntfs_malloc_nofs - allocate memory in multiples of pages
+ * @size:	number of bytes to allocate
+ *
+ * Allocates @size bytes of memory, rounded up to multiples of PAGE_SIZE and
+ * returns a pointer to the allocated memory.
+ *
+ * If there was insufficient memory to complete the request, return NULL.
+ */
+static inline void *ntfs_malloc_nofs(unsigned long size)
+{
+	return __ntfs_malloc(size, GFP_NOFS | __GFP_HIGHMEM | __GFP_ZERO);
+}
+
+/**
+ * ntfs_malloc_nofs_nofail - allocate memory in multiples of pages
+ * @size:	number of bytes to allocate
+ *
+ * Allocates @size bytes of memory, rounded up to multiples of PAGE_SIZE and
+ * returns a pointer to the allocated memory.
+ *
+ * This function guarantees that the allocation will succeed.  It will sleep
+ * for as long as it takes to complete the allocation.
+ *
+ * If there was insufficient memory to complete the request, return NULL.
+ */
+static inline void *ntfs_malloc_nofs_nofail(unsigned long size)
+{
+	return __ntfs_malloc(size, GFP_NOFS | __GFP_HIGHMEM | __GFP_NOFAIL);
+}
+
+static inline void ntfs_free(void *addr)
+{
+	kvfree(addr);
+}
+
+static inline void *ntfs_realloc_nofs(void *addr, unsigned long new_size,
+		unsigned long cpy_size)
+{
+	void *pnew_addr;
+
+	if (new_size == 0) {
+		ntfs_free(addr);
+		return NULL;
+	}
+
+	pnew_addr = ntfs_malloc_nofs(new_size);
+	if (pnew_addr == NULL)
+		return NULL;
+	if (addr) {
+		cpy_size = min(cpy_size, new_size);
+		if (cpy_size)
+			memcpy(pnew_addr, addr, cpy_size);
+		ntfs_free(addr);
+	}
+	return pnew_addr;
+}
+#endif /* _LINUX_NTFS_MISC_H */
diff --git a/fs/ntfsplus/ntfs.h b/fs/ntfsplus/ntfs.h
new file mode 100644
index 000000000000..abcd65860de7
--- /dev/null
+++ b/fs/ntfsplus/ntfs.h
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Defines for NTFS Linux kernel driver.
+ *
+ * Copyright (c) 2001-2014 Anton Altaparmakov and Tuxera Inc.
+ * Copyright (C) 2002 Richard Russon
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#ifndef _LINUX_NTFS_H
+#define _LINUX_NTFS_H
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/nls.h>
+#include <linux/smp.h>
+#include <linux/pagemap.h>
+#include <linux/uidgid.h>
+
+#include "volume.h"
+#include "layout.h"
+#include "inode.h"
+
+#define NTFS_DEF_PREALLOC_SIZE		(64*1024*1024)
+
+#define STANDARD_COMPRESSION_UNIT	4
+#define MAX_COMPRESSION_CLUSTER_SIZE 4096
+
+#define UCHAR_T_SIZE_BITS 1
+
+enum {
+	NTFS_BLOCK_SIZE		= 512,
+	NTFS_BLOCK_SIZE_BITS	= 9,
+	NTFS_SB_MAGIC		= 0x5346544e,	/* 'NTFS' */
+	NTFS_MAX_NAME_LEN	= 255,
+};
+
+enum {
+	CASE_SENSITIVE = 0,
+	IGNORE_CASE = 1,
+};
+
+/* Global variables. */
+
+/* Slab caches (from super.c). */
+extern struct kmem_cache *ntfs_name_cache;
+extern struct kmem_cache *ntfs_inode_cache;
+extern struct kmem_cache *ntfs_big_inode_cache;
+extern struct kmem_cache *ntfs_attr_ctx_cache;
+extern struct kmem_cache *ntfs_index_ctx_cache;
+
+/* The various operations structs defined throughout the driver files. */
+extern const struct address_space_operations ntfs_normal_aops;
+extern const struct address_space_operations ntfs_compressed_aops;
+extern const struct address_space_operations ntfs_mst_aops;
+
+extern const struct  file_operations ntfs_file_ops;
+extern const struct inode_operations ntfs_file_inode_ops;
+extern const  struct inode_operations ntfs_symlink_inode_operations;
+extern const struct inode_operations ntfs_special_inode_operations;
+
+extern const struct  file_operations ntfs_dir_ops;
+extern const struct inode_operations ntfs_dir_inode_ops;
+
+extern const struct  file_operations ntfs_empty_file_ops;
+extern const struct inode_operations ntfs_empty_inode_ops;
+
+extern const struct export_operations ntfs_export_ops;
+
+/**
+ * NTFS_SB - return the ntfs volume given a vfs super block
+ * @sb:		VFS super block
+ *
+ * NTFS_SB() returns the ntfs volume associated with the VFS super block @sb.
+ */
+static inline struct ntfs_volume *NTFS_SB(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
+/* Declarations of functions and global variables. */
+
+/* From fs/ntfs/compress.c */
+int ntfs_read_compressed_block(struct folio *folio);
+int allocate_compression_buffers(void);
+void free_compression_buffers(void);
+int ntfs_compress_write(struct ntfs_inode *ni, loff_t pos, size_t count,
+		struct iov_iter *from);
+
+/* From fs/ntfs/super.c */
+#define default_upcase_len 0x10000
+extern struct mutex ntfs_lock;
+
+struct option_t {
+	int val;
+	char *str;
+};
+extern const struct option_t on_errors_arr[];
+int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags);
+int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags);
+
+/* From fs/ntfs/mst.c */
+int post_read_mst_fixup(struct ntfs_record *b, const u32 size);
+int pre_write_mst_fixup(struct ntfs_record *b, const u32 size);
+void post_write_mst_fixup(struct ntfs_record *b);
+
+/* From fs/ntfs/unistr.c */
+bool ntfs_are_names_equal(const __le16 *s1, size_t s1_len,
+		const __le16 *s2, size_t s2_len,
+		const u32 ic,
+		const __le16 *upcase, const u32 upcase_size);
+int ntfs_collate_names(const __le16 *name1, const u32 name1_len,
+		const __le16 *name2, const u32 name2_len,
+		const int err_val, const u32 ic,
+		const __le16 *upcase, const u32 upcase_len);
+int ntfs_ucsncmp(const __le16 *s1, const __le16 *s2, size_t n);
+int ntfs_ucsncasecmp(const __le16 *s1, const __le16 *s2, size_t n,
+		const __le16 *upcase, const u32 upcase_size);
+int ntfs_file_compare_values(const struct file_name_attr *file_name_attr1,
+		const struct file_name_attr *file_name_attr2,
+		const int err_val, const u32 ic,
+		const __le16 *upcase, const u32 upcase_len);
+int ntfs_nlstoucs(const struct ntfs_volume *vol, const char *ins,
+		const int ins_len, __le16 **outs, int max_name_len);
+int ntfs_ucstonls(const struct ntfs_volume *vol, const __le16 *ins,
+		const int ins_len, unsigned char **outs, int outs_len);
+__le16 *ntfs_ucsndup(const __le16 *s, u32 maxlen);
+bool ntfs_names_are_equal(const __le16 *s1, size_t s1_len,
+		const __le16 *s2, size_t s2_len,
+		const u32 ic,
+		const __le16 *upcase, const u32 upcase_size);
+int ntfs_force_shutdown(struct super_block *sb, u32 flags);
+long ntfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
+#ifdef CONFIG_COMPAT
+long ntfs_compat_ioctl(struct file *filp, unsigned int cmd,
+		unsigned long arg);
+#endif
+
+/* From fs/ntfs/upcase.c */
+__le16 *generate_default_upcase(void);
+
+static inline int ntfs_ffs(int x)
+{
+	int r = 1;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff)) {
+		x >>= 16;
+		r += 16;
+	}
+	if (!(x & 0xff)) {
+		x >>= 8;
+		r += 8;
+	}
+	if (!(x & 0xf)) {
+		x >>= 4;
+		r += 4;
+	}
+	if (!(x & 3)) {
+		x >>= 2;
+		r += 2;
+	}
+	if (!(x & 1))
+		r += 1;
+	return r;
+}
+
+#endif /* _LINUX_NTFS_H */
diff --git a/fs/ntfsplus/ntfs_iomap.h b/fs/ntfsplus/ntfs_iomap.h
new file mode 100644
index 000000000000..b1a5d55fa077
--- /dev/null
+++ b/fs/ntfsplus/ntfs_iomap.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/**
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#ifndef _LINUX_NTFS_IOMAP_H
+#define _LINUX_NTFS_IOMAP_H
+
+#include <linux/pagemap.h>
+#include <linux/iomap.h>
+
+#include "volume.h"
+#include "inode.h"
+
+extern const struct iomap_ops ntfs_write_iomap_ops;
+extern const struct iomap_ops ntfs_read_iomap_ops;
+extern const struct iomap_ops ntfs_page_mkwrite_iomap_ops;
+extern const struct iomap_ops ntfs_dio_iomap_ops;
+extern const struct iomap_writeback_ops ntfs_writeback_ops;
+extern const struct iomap_write_ops ntfs_iomap_folio_ops;
+int ntfs_zeroed_clusters(struct inode *vi, s64 lcn, s64 num);
+#endif /* _LINUX_NTFS_IOMAP_H */
diff --git a/fs/ntfsplus/reparse.h b/fs/ntfsplus/reparse.h
new file mode 100644
index 000000000000..a1f3829a89da
--- /dev/null
+++ b/fs/ntfsplus/reparse.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/**
+ * Copyright (c) 2008-2021 Jean-Pierre Andre
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+extern __le16 reparse_index_name[];
+
+unsigned int ntfs_make_symlink(struct ntfs_inode *ni);
+unsigned int ntfs_reparse_tag_dt_types(struct ntfs_volume *vol, unsigned long mref);
+int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *ni,
+			const __le16 *target, int target_len);
+int ntfs_reparse_set_wsl_not_symlink(struct ntfs_inode *ni, mode_t mode);
+int ntfs_delete_reparse_index(struct ntfs_inode *ni);
+int ntfs_remove_ntfs_reparse_data(struct ntfs_inode *ni);
diff --git a/fs/ntfsplus/runlist.h b/fs/ntfsplus/runlist.h
new file mode 100644
index 000000000000..c9d88116371d
--- /dev/null
+++ b/fs/ntfsplus/runlist.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Defines for runlist handling in NTFS Linux kernel driver.
+ * Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2001-2005 Anton Altaparmakov
+ * Copyright (c) 2002 Richard Russon
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#ifndef _LINUX_NTFS_RUNLIST_H
+#define _LINUX_NTFS_RUNLIST_H
+
+#include "volume.h"
+
+/**
+ * runlist_element - in memory vcn to lcn mapping array element
+ * @vcn:	starting vcn of the current array element
+ * @lcn:	starting lcn of the current array element
+ * @length:	length in clusters of the current array element
+ *
+ * The last vcn (in fact the last vcn + 1) is reached when length == 0.
+ *
+ * When lcn == -1 this means that the count vcns starting at vcn are not
+ * physically allocated (i.e. this is a hole / data is sparse).
+ */
+struct runlist_element { /* In memory vcn to lcn mapping structure element. */
+	s64 vcn;	/* vcn = Starting virtual cluster number. */
+	s64 lcn;	/* lcn = Starting logical cluster number. */
+	s64 length;	/* Run length in clusters. */
+};
+
+/**
+ * runlist - in memory vcn to lcn mapping array including a read/write lock
+ * @rl:		pointer to an array of runlist elements
+ * @lock:	read/write spinlock for serializing access to @rl
+ *
+ */
+struct runlist {
+	struct runlist_element *rl;
+	struct rw_semaphore lock;
+	size_t count;
+};
+
+static inline void ntfs_init_runlist(struct runlist *rl)
+{
+	rl->rl = NULL;
+	init_rwsem(&rl->lock);
+	rl->count = 0;
+}
+
+enum {
+	LCN_DELALLOC		= -1,
+	LCN_HOLE		= -2,
+	LCN_RL_NOT_MAPPED	= -3,
+	LCN_ENOENT		= -4,
+	LCN_ENOMEM		= -5,
+	LCN_EIO			= -6,
+	LCN_EINVAL		= -7,
+};
+
+struct runlist_element *ntfs_runlists_merge(struct runlist *d_runlist,
+		struct runlist_element *srl, size_t s_rl_count,
+		size_t *new_rl_count);
+struct runlist_element *ntfs_mapping_pairs_decompress(const struct ntfs_volume *vol,
+		const struct attr_record *attr, struct runlist *old_runlist,
+		size_t *new_rl_count);
+s64 ntfs_rl_vcn_to_lcn(const struct runlist_element *rl, const s64 vcn);
+struct runlist_element *ntfs_rl_find_vcn_nolock(struct runlist_element *rl, const s64 vcn);
+int ntfs_get_size_for_mapping_pairs(const struct ntfs_volume *vol,
+		const struct runlist_element *rl, const s64 first_vcn,
+		const s64 last_vcn, int max_mp_size);
+int ntfs_mapping_pairs_build(const struct ntfs_volume *vol, s8 *dst,
+		const int dst_len, const struct runlist_element *rl,
+		const s64 first_vcn, const s64 last_vcn, s64 *const stop_vcn,
+		struct runlist_element **stop_rl, unsigned int *de_cluster_count);
+int ntfs_rl_truncate_nolock(const struct ntfs_volume *vol,
+		struct runlist *const runlist, const s64 new_length);
+int ntfs_rl_sparse(struct runlist_element *rl);
+s64 ntfs_rl_get_compressed_size(struct ntfs_volume *vol, struct runlist_element *rl);
+struct runlist_element *ntfs_rl_insert_range(struct runlist_element *dst_rl, int dst_cnt,
+		struct runlist_element *src_rl, int src_cnt, size_t *new_cnt);
+struct runlist_element *ntfs_rl_punch_hole(struct runlist_element *dst_rl, int dst_cnt,
+		s64 start_vcn, s64 len, struct runlist_element **punch_rl,
+		size_t *new_rl_cnt);
+struct runlist_element *ntfs_rl_collapse_range(struct runlist_element *dst_rl, int dst_cnt,
+		s64 start_vcn, s64 len, struct runlist_element **punch_rl,
+		size_t *new_rl_cnt);
+struct runlist_element *ntfs_rl_realloc(struct runlist_element *rl, int old_size,
+		int new_size);
+#endif /* _LINUX_NTFS_RUNLIST_H */
diff --git a/fs/ntfsplus/volume.h b/fs/ntfsplus/volume.h
new file mode 100644
index 000000000000..0bc8df650225
--- /dev/null
+++ b/fs/ntfsplus/volume.h
@@ -0,0 +1,241 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Defines for volume structures in NTFS Linux kernel driver.
+ * Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2001-2006 Anton Altaparmakov
+ * Copyright (c) 2002 Richard Russon
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#ifndef _LINUX_NTFS_VOLUME_H
+#define _LINUX_NTFS_VOLUME_H
+
+#include <linux/rwsem.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/uidgid.h>
+#include <linux/workqueue.h>
+#include <linux/errseq.h>
+
+#include "layout.h"
+
+#define NTFS_VOL_UID	BIT(1)
+#define NTFS_VOL_GID	BIT(2)
+
+/*
+ * The NTFS in memory super block structure.
+ */
+struct ntfs_volume {
+	/* Device specifics. */
+	struct super_block *sb;		/* Pointer back to the super_block. */
+	s64 nr_blocks;			/*
+					 * Number of sb->s_blocksize bytes
+					 * sized blocks on the device.
+					 */
+	/* Configuration provided by user at mount time. */
+	unsigned long flags;		/* Miscellaneous flags, see below. */
+	kuid_t uid;			/* uid that files will be mounted as. */
+	kgid_t gid;			/* gid that files will be mounted as. */
+	umode_t fmask;			/* The mask for file permissions. */
+	umode_t dmask;			/* The mask for directory permissions. */
+	u8 mft_zone_multiplier;		/* Initial mft zone multiplier. */
+	u8 on_errors;			/* What to do on filesystem errors. */
+	errseq_t wb_err;
+	/* NTFS bootsector provided information. */
+	u16 sector_size;		/* in bytes */
+	u8 sector_size_bits;		/* log2(sector_size) */
+	u32 cluster_size;		/* in bytes */
+	u32 cluster_size_mask;		/* cluster_size - 1 */
+	u8 cluster_size_bits;		/* log2(cluster_size) */
+	u32 mft_record_size;		/* in bytes */
+	u32 mft_record_size_mask;	/* mft_record_size - 1 */
+	u8 mft_record_size_bits;	/* log2(mft_record_size) */
+	u32 index_record_size;		/* in bytes */
+	u32 index_record_size_mask;	/* index_record_size - 1 */
+	u8 index_record_size_bits;	/* log2(index_record_size) */
+	s64 nr_clusters;		/*
+					 * Volume size in clusters == number of
+					 * bits in lcn bitmap.
+					 */
+	s64 mft_lcn;			/* Cluster location of mft data. */
+	s64 mftmirr_lcn;		/* Cluster location of copy of mft. */
+	u64 serial_no;			/* The volume serial number. */
+	/* Mount specific NTFS information. */
+	u32 upcase_len;			/* Number of entries in upcase[]. */
+	__le16 *upcase;		/* The upcase table. */
+
+	s32 attrdef_size;		/* Size of the attribute definition table in bytes. */
+	struct attr_def *attrdef;	/*
+					 * Table of attribute definitions.
+					 * Obtained from FILE_AttrDef.
+					 */
+
+	/* Variables used by the cluster and mft allocators. */
+	s64 mft_data_pos;		/*
+					 * Mft record number at which to
+					 * allocate the next mft record.
+					 */
+	s64 mft_zone_start;		/* First cluster of the mft zone. */
+	s64 mft_zone_end;		/* First cluster beyond the mft zone. */
+	s64 mft_zone_pos;		/* Current position in the mft zone. */
+	s64 data1_zone_pos;		/* Current position in the first data zone. */
+	s64 data2_zone_pos;		/* Current position in the second data zone. */
+
+	struct inode *mft_ino;		/* The VFS inode of $MFT. */
+
+	struct inode *mftbmp_ino;	/* Attribute inode for $MFT/$BITMAP. */
+	struct rw_semaphore mftbmp_lock; /*
+					  *  Lock for serializing accesses to the
+					  * mft record bitmap ($MFT/$BITMAP).
+					  */
+	struct inode *mftmirr_ino;	/* The VFS inode of $MFTMirr. */
+	int mftmirr_size;		/* Size of mft mirror in mft records. */
+
+	struct inode *logfile_ino;	/* The VFS inode of LogFile. */
+
+	struct inode *lcnbmp_ino;	/* The VFS inode of $Bitmap. */
+	struct rw_semaphore lcnbmp_lock; /*
+					  * Lock for serializing accesses to the
+					  * cluster bitmap ($Bitmap/$DATA).
+					  */
+
+	struct inode *vol_ino;		/* The VFS inode of $Volume. */
+	__le16 vol_flags;			/* Volume flags. */
+	u8 major_ver;			/* Ntfs major version of volume. */
+	u8 minor_ver;			/* Ntfs minor version of volume. */
+
+	struct inode *root_ino;		/* The VFS inode of the root directory. */
+	struct inode *secure_ino;	/*
+					 * The VFS inode of $Secure (NTFS3.0+
+					 * only, otherwise NULL).
+					 */
+	struct inode *extend_ino;	/*
+					 * The VFS inode of $Extend (NTFS3.0+
+					 * only, otherwise NULL).
+					 */
+	/* $Quota stuff is NTFS3.0+ specific.  Unused/NULL otherwise. */
+	struct inode *quota_ino;	/* The VFS inode of $Quota. */
+	struct inode *quota_q_ino;	/* Attribute inode for $Quota/$Q. */
+	struct nls_table *nls_map;
+	bool nls_utf8;
+	wait_queue_head_t free_waitq;
+
+	atomic64_t free_clusters;	/* Track the number of free clusters */
+	atomic64_t free_mft_records;		/* Track the free mft records */
+	atomic64_t dirty_clusters;
+	u8 sparse_compression_unit;
+	unsigned int *lcn_empty_bits_per_page;
+	struct work_struct precalc_work;
+	loff_t preallocated_size;
+};
+
+/*
+ * Defined bits for the flags field in the ntfs_volume structure.
+ */
+enum {
+	NV_Errors,		/* 1: Volume has errors, prevent remount rw. */
+	NV_ShowSystemFiles,	/* 1: Return system files in ntfs_readdir(). */
+	NV_CaseSensitive,	/*
+				 * 1: Treat file names as case sensitive and
+				 *    create filenames in the POSIX namespace.
+				 *    Otherwise be case insensitive but still
+				 *    create file names in POSIX namespace.
+				 */
+	NV_LogFileEmpty,	/* 1: LogFile journal is empty. */
+	NV_QuotaOutOfDate,	/* 1: Quota is out of date. */
+	NV_UsnJrnlStamped,	/* 1: UsnJrnl has been stamped. */
+	NV_ReadOnly,
+	NV_Compression,
+	NV_FreeClusterKnown,
+	NV_Shutdown,
+};
+
+/*
+ * Macro tricks to expand the NVolFoo(), NVolSetFoo(), and NVolClearFoo()
+ * functions.
+ */
+#define DEFINE_NVOL_BIT_OPS(flag)					\
+static inline int NVol##flag(struct ntfs_volume *vol)		\
+{								\
+	return test_bit(NV_##flag, &(vol)->flags);		\
+}								\
+static inline void NVolSet##flag(struct ntfs_volume *vol)	\
+{								\
+	set_bit(NV_##flag, &(vol)->flags);			\
+}								\
+static inline void NVolClear##flag(struct ntfs_volume *vol)	\
+{								\
+	clear_bit(NV_##flag, &(vol)->flags);			\
+}
+
+/* Emit the ntfs volume bitops functions. */
+DEFINE_NVOL_BIT_OPS(Errors)
+DEFINE_NVOL_BIT_OPS(ShowSystemFiles)
+DEFINE_NVOL_BIT_OPS(CaseSensitive)
+DEFINE_NVOL_BIT_OPS(LogFileEmpty)
+DEFINE_NVOL_BIT_OPS(QuotaOutOfDate)
+DEFINE_NVOL_BIT_OPS(UsnJrnlStamped)
+DEFINE_NVOL_BIT_OPS(ReadOnly)
+DEFINE_NVOL_BIT_OPS(Compression)
+DEFINE_NVOL_BIT_OPS(FreeClusterKnown)
+DEFINE_NVOL_BIT_OPS(Shutdown)
+
+static inline void ntfs_inc_free_clusters(struct ntfs_volume *vol, s64 nr)
+{
+	if (!NVolFreeClusterKnown(vol))
+		wait_event(vol->free_waitq, NVolFreeClusterKnown(vol));
+	atomic64_add(nr, &vol->free_clusters);
+}
+
+static inline void ntfs_dec_free_clusters(struct ntfs_volume *vol, s64 nr)
+{
+	if (!NVolFreeClusterKnown(vol))
+		wait_event(vol->free_waitq, NVolFreeClusterKnown(vol));
+	atomic64_sub(nr, &vol->free_clusters);
+}
+
+static inline void ntfs_inc_free_mft_records(struct ntfs_volume *vol, s64 nr)
+{
+	if (!NVolFreeClusterKnown(vol))
+		return;
+
+	atomic64_add(nr, &vol->free_mft_records);
+}
+
+static inline void ntfs_dec_free_mft_records(struct ntfs_volume *vol, s64 nr)
+{
+	if (!NVolFreeClusterKnown(vol))
+		return;
+
+	atomic64_sub(nr, &vol->free_mft_records);
+}
+
+static inline void ntfs_set_lcn_empty_bits(struct ntfs_volume *vol, unsigned long index,
+		u8 val, unsigned int count)
+{
+	if (!NVolFreeClusterKnown(vol))
+		wait_event(vol->free_waitq, NVolFreeClusterKnown(vol));
+
+	if (val)
+		vol->lcn_empty_bits_per_page[index] -= count;
+	else
+		vol->lcn_empty_bits_per_page[index] += count;
+}
+
+static __always_inline void ntfs_hold_dirty_clusters(struct ntfs_volume *vol, s64 nr_clusters)
+{
+	atomic64_add(nr_clusters, &vol->dirty_clusters);
+}
+
+static __always_inline void ntfs_release_dirty_clusters(struct ntfs_volume *vol, s64 nr_clusters)
+{
+	if (atomic64_read(&vol->dirty_clusters) < nr_clusters)
+		atomic64_set(&vol->dirty_clusters, 0);
+	else
+		atomic64_sub(nr_clusters, &vol->dirty_clusters);
+}
+
+s64 ntfs_available_clusters_count(struct ntfs_volume *vol, s64 nr_clusters);
+s64 get_nr_free_clusters(struct ntfs_volume *vol);
+#endif /* _LINUX_NTFS_VOLUME_H */
diff --git a/include/uapi/linux/ntfs.h b/include/uapi/linux/ntfs.h
new file mode 100644
index 000000000000..e76957285280
--- /dev/null
+++ b/include/uapi/linux/ntfs.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#ifndef _UAPI_LINUX_NTFS_H
+#define _UAPI_LINUX_NTFS_H
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/*
+ * ntfs-specific ioctl commands
+ */
+#define NTFS_IOC_SHUTDOWN _IOR('X', 125, __u32)
+
+/*
+ * Flags used by NTFS_IOC_SHUTDOWN
+ */
+#define NTFS_GOING_DOWN_DEFAULT        0x0     /* default with full sync */
+#define NTFS_GOING_DOWN_FULLSYNC       0x1     /* going down with full sync*/
+#define NTFS_GOING_DOWN_NOSYNC         0x2     /* going down */
+
+#endif /* _UAPI_LINUX_NTFS_H */
-- 
2.34.1


