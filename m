Return-Path: <linux-fsdevel+bounces-64638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 455F4BEF0E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 04:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEAC44E91F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 02:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3D51F463F;
	Mon, 20 Oct 2025 02:09:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32DA1EF09D
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 02:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926152; cv=none; b=Pd03MuZQFRhMvAr6NbuRr5324G05O+2uKQ3uwrz4EjSIycTYSD9V5KCzSyDJ0ufOoYXOqSArDVIDYNkRQKzNr9iO/3H8DJe0CaW1gIRL1Pf5HwDt8DIdTWZXojQ4mZlXwVER/6mAF6u2jp+Vq6/8xYv+nFblwnoXEoNnjDK03gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926152; c=relaxed/simple;
	bh=436U4BfPdhQK9YHtSKlvXZVwcmpFx50XOWlYjoOchR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oIpwixGK9yt5c0Wl6JBpzg1fvcoC2kKZG2p/fmuK7EX1r+FXN7X35FXeAHNX8qXR/ceUMuoZwpQzwyedxladDFXHsh+Q8H7WwVnb41IVPJYW4hxTGpO9SCUVI2sH5YuKqLAOluFP2CY1lJ09RtYWnASQtxaLS+o0S9zfrIWjlTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7930132f59aso5223025b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 19:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760926146; x=1761530946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQ8ZV4fflZtCMsaeSBES1TwqTBvZyYtOk67WAVDXbl4=;
        b=I07VJM3OAEBW0ZPw0Xo/VAfuSpTNazcsxmPpRuH/0IHMS2sDLLxQGbtkHXMvlNM9RN
         WBFwrBCob1ek9IwhStIY+ug5asW7pjaYEgCPCtkXL1yskASw+nUklPmQN2UY+tFYf3wZ
         7zd0CMopd38gdOczLoXq2EcJf7mziVceA+HUcJW1Qy05ZO5yk7ZzKUKQ99emDKsbJ8Gj
         aSMeBVEz5ndyypF4ERlQ6M7t8+s5wTHHVGge/uQc1xPYnkuZwfgIorMrh17VzJzodAk5
         +BJMYvslZWIj5qZF8X5w105h0rCrAUGp8NiHnBSqfIbwHe6OCGCTYhzKqGhLxjY+6brH
         Jq/A==
X-Gm-Message-State: AOJu0YwMggGO0x97cYstXldsevRSPh0U6PvXwFdp448tE16vkZ+KirIw
	2zbF1hI40cV/bFSvaRpcxrm8NhO/z8a8o6qgGcws9YMMWdjT4um+ZOsx
X-Gm-Gg: ASbGncv/9Fb1xmJLUqSh2djhaIm7Ng+I+SyX8v/lM27NYAi2ezwMt9yu7/gzkCCiTjs
	6u8xRYUMfdYe7p0EhyHJKTnAJMAz3JNcC5TNVUuRTiDGNnJEgjTFtv7r8fUzFMya2OkMwOZArs0
	6iLVNTqEVRDphanDngWF3cikwQUHjsmeF/2iZq8ZmD5m79JepCmSjGoFG6HtVMx5LrIg9S4HAcd
	rW/XAtuwjgLzEZ5HbYWQqGZya8EfuBkMzeNmzkiyAfO/h6uhMt39/G9PnIN97JdAUqtCT2cI7t7
	Ly+H1yrtvOzlBopWodYM112O0nlzYUjLwg6e64j+V1HAcfBGR3vqJz2h+vxL+A4vWMIOrjwssKS
	CxivMOhQ4cFLzOR9gtlkDspQ71jSnKvyz7PaYkCEtjMrn/4elxGKB6IlVfTFeDAtS07UttSH/G8
	LfBV/EF54AiTLNsSw=
X-Google-Smtp-Source: AGHT+IH8TIDuRydNGWlVTavAFn+GAL0nVnU5AB7jiGxBw0jK9xdsjfiR9a3E69bFSRfe5kJSkttKYw==
X-Received: by 2002:a05:6a00:1706:b0:77f:1d7a:b97f with SMTP id d2e1a72fcca58-7a220d55b41mr14069962b3a.28.1760926145344;
        Sun, 19 Oct 2025 19:09:05 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010df83sm6722300b3a.59.2025.10.19.19.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 19:09:04 -0700 (PDT)
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
Subject: [PATCH 04/11] ntfsplus: add directory operations
Date: Mon, 20 Oct 2025 11:07:42 +0900
Message-Id: <20251020020749.5522-5-linkinjeon@kernel.org>
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

This adds the implementation of directory operations for ntfsplus.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfsplus/dir.c   | 1226 +++++++++++++++++++++++++
 fs/ntfsplus/index.c | 2114 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 3340 insertions(+)
 create mode 100644 fs/ntfsplus/dir.c
 create mode 100644 fs/ntfsplus/index.c

diff --git a/fs/ntfsplus/dir.c b/fs/ntfsplus/dir.c
new file mode 100644
index 000000000000..9a97eeaf8a4c
--- /dev/null
+++ b/fs/ntfsplus/dir.c
@@ -0,0 +1,1226 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/**
+ * NTFS kernel directory operations. Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2001-2007 Anton Altaparmakov
+ * Copyright (c) 2002 Richard Russon
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#include <linux/blkdev.h>
+
+#include "dir.h"
+#include "mft.h"
+#include "ntfs.h"
+#include "index.h"
+#include "reparse.h"
+
+/**
+ * The little endian Unicode string $I30 as a global constant.
+ */
+__le16 I30[5] = { cpu_to_le16('$'), cpu_to_le16('I'),
+		cpu_to_le16('3'),	cpu_to_le16('0'), 0 };
+
+/**
+ * ntfs_lookup_inode_by_name - find an inode in a directory given its name
+ * @dir_ni:	ntfs inode of the directory in which to search for the name
+ * @uname:	Unicode name for which to search in the directory
+ * @uname_len:	length of the name @uname in Unicode characters
+ * @res:	return the found file name if necessary (see below)
+ *
+ * Look for an inode with name @uname in the directory with inode @dir_ni.
+ * ntfs_lookup_inode_by_name() walks the contents of the directory looking for
+ * the Unicode name. If the name is found in the directory, the corresponding
+ * inode number (>= 0) is returned as a mft reference in cpu format, i.e. it
+ * is a 64-bit number containing the sequence number.
+ *
+ * On error, a negative value is returned corresponding to the error code. In
+ * particular if the inode is not found -ENOENT is returned. Note that you
+ * can't just check the return value for being negative, you have to check the
+ * inode number for being negative which you can extract using MREC(return
+ * value).
+ *
+ * Note, @uname_len does not include the (optional) terminating NULL character.
+ *
+ * Note, we look for a case sensitive match first but we also look for a case
+ * insensitive match at the same time. If we find a case insensitive match, we
+ * save that for the case that we don't find an exact match, where we return
+ * the case insensitive match and setup @res (which we allocate!) with the mft
+ * reference, the file name type, length and with a copy of the little endian
+ * Unicode file name itself. If we match a file name which is in the DOS name
+ * space, we only return the mft reference and file name type in @res.
+ * ntfs_lookup() then uses this to find the long file name in the inode itself.
+ * This is to avoid polluting the dcache with short file names. We want them to
+ * work but we don't care for how quickly one can access them. This also fixes
+ * the dcache aliasing issues.
+ *
+ * Locking:  - Caller must hold i_mutex on the directory.
+ *	     - Each page cache page in the index allocation mapping must be
+ *	       locked whilst being accessed otherwise we may find a corrupt
+ *	       page due to it being under ->writepage at the moment which
+ *	       applies the mst protection fixups before writing out and then
+ *	       removes them again after the write is complete after which it
+ *	       unlocks the page.
+ */
+u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir_ni, const __le16 *uname,
+		const int uname_len, struct ntfs_name **res)
+{
+	struct ntfs_volume *vol = dir_ni->vol;
+	struct super_block *sb = vol->sb;
+	struct inode *ia_vi = NULL;
+	struct mft_record *m;
+	struct index_root *ir;
+	struct index_entry *ie;
+	struct index_block *ia;
+	u8 *index_end;
+	u64 mref;
+	struct ntfs_attr_search_ctx *ctx;
+	int err, rc;
+	s64 vcn, old_vcn;
+	struct address_space *ia_mapping;
+	struct folio *folio;
+	u8 *kaddr = NULL;
+	struct ntfs_name *name = NULL;
+
+	BUG_ON(!S_ISDIR(VFS_I(dir_ni)->i_mode));
+	BUG_ON(NInoAttr(dir_ni));
+	/* Get hold of the mft record for the directory. */
+	m = map_mft_record(dir_ni);
+	if (IS_ERR(m)) {
+		ntfs_error(sb, "map_mft_record() failed with error code %ld.",
+				-PTR_ERR(m));
+		return ERR_MREF(PTR_ERR(m));
+	}
+	ctx = ntfs_attr_get_search_ctx(dir_ni, m);
+	if (unlikely(!ctx)) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+	/* Find the index root attribute in the mft record. */
+	err = ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL,
+			0, ctx);
+	if (unlikely(err)) {
+		if (err == -ENOENT) {
+			ntfs_error(sb,
+				"Index root attribute missing in directory inode 0x%lx.",
+				dir_ni->mft_no);
+			err = -EIO;
+		}
+		goto err_out;
+	}
+	/* Get to the index root value (it's been verified in read_inode). */
+	ir = (struct index_root *)((u8 *)ctx->attr +
+			le16_to_cpu(ctx->attr->data.resident.value_offset));
+	index_end = (u8 *)&ir->index + le32_to_cpu(ir->index.index_length);
+	/* The first index entry. */
+	ie = (struct index_entry *)((u8 *)&ir->index +
+			le32_to_cpu(ir->index.entries_offset));
+	/*
+	 * Loop until we exceed valid memory (corruption case) or until we
+	 * reach the last entry.
+	 */
+	for (;; ie = (struct index_entry *)((u8 *)ie + le16_to_cpu(ie->length))) {
+		/* Bounds checks. */
+		if ((u8 *)ie < (u8 *)ctx->mrec ||
+		    (u8 *)ie + sizeof(struct index_entry_header) > index_end ||
+		    (u8 *)ie + sizeof(struct index_entry_header) + le16_to_cpu(ie->key_length) >
+				index_end || (u8 *)ie + le16_to_cpu(ie->length) > index_end)
+			goto dir_err_out;
+		/*
+		 * The last entry cannot contain a name. It can however contain
+		 * a pointer to a child node in the B+tree so we just break out.
+		 */
+		if (ie->flags & INDEX_ENTRY_END)
+			break;
+		/* Key length should not be zero if it is not last entry. */
+		if (!ie->key_length)
+			goto dir_err_out;
+		/* Check the consistency of an index entry */
+		if (ntfs_index_entry_inconsistent(NULL, vol, ie, COLLATION_FILE_NAME,
+				dir_ni->mft_no))
+			goto dir_err_out;
+		/*
+		 * We perform a case sensitive comparison and if that matches
+		 * we are done and return the mft reference of the inode (i.e.
+		 * the inode number together with the sequence number for
+		 * consistency checking). We convert it to cpu format before
+		 * returning.
+		 */
+		if (ntfs_are_names_equal(uname, uname_len,
+				(__le16 *)&ie->key.file_name.file_name,
+				ie->key.file_name.file_name_length,
+				CASE_SENSITIVE, vol->upcase, vol->upcase_len)) {
+found_it:
+			/*
+			 * We have a perfect match, so we don't need to care
+			 * about having matched imperfectly before, so we can
+			 * free name and set *res to NULL.
+			 * However, if the perfect match is a short file name,
+			 * we need to signal this through *res, so that
+			 * ntfs_lookup() can fix dcache aliasing issues.
+			 * As an optimization we just reuse an existing
+			 * allocation of *res.
+			 */
+			if (ie->key.file_name.file_name_type == FILE_NAME_DOS) {
+				if (!name) {
+					name = kmalloc(sizeof(struct ntfs_name),
+							GFP_NOFS);
+					if (!name) {
+						err = -ENOMEM;
+						goto err_out;
+					}
+				}
+				name->mref = le64_to_cpu(
+						ie->data.dir.indexed_file);
+				name->type = FILE_NAME_DOS;
+				name->len = 0;
+				*res = name;
+			} else {
+				kfree(name);
+				*res = NULL;
+			}
+			mref = le64_to_cpu(ie->data.dir.indexed_file);
+			ntfs_attr_put_search_ctx(ctx);
+			unmap_mft_record(dir_ni);
+			return mref;
+		}
+		/*
+		 * For a case insensitive mount, we also perform a case
+		 * insensitive comparison (provided the file name is not in the
+		 * POSIX namespace). If the comparison matches, and the name is
+		 * in the WIN32 namespace, we cache the filename in *res so
+		 * that the caller, ntfs_lookup(), can work on it. If the
+		 * comparison matches, and the name is in the DOS namespace, we
+		 * only cache the mft reference and the file name type (we set
+		 * the name length to zero for simplicity).
+		 */
+		if (!NVolCaseSensitive(vol) &&
+				ie->key.file_name.file_name_type &&
+				ntfs_are_names_equal(uname, uname_len,
+				(__le16 *)&ie->key.file_name.file_name,
+				ie->key.file_name.file_name_length,
+				IGNORE_CASE, vol->upcase, vol->upcase_len)) {
+			int name_size = sizeof(struct ntfs_name);
+			u8 type = ie->key.file_name.file_name_type;
+			u8 len = ie->key.file_name.file_name_length;
+
+			/* Only one case insensitive matching name allowed. */
+			if (name) {
+				ntfs_error(sb,
+					"Found already allocated name in phase 1. Please run chkdsk");
+				goto dir_err_out;
+			}
+
+			if (type != FILE_NAME_DOS)
+				name_size += len * sizeof(__le16);
+			name = kmalloc(name_size, GFP_NOFS);
+			if (!name) {
+				err = -ENOMEM;
+				goto err_out;
+			}
+			name->mref = le64_to_cpu(ie->data.dir.indexed_file);
+			name->type = type;
+			if (type != FILE_NAME_DOS) {
+				name->len = len;
+				memcpy(name->name, ie->key.file_name.file_name,
+						len * sizeof(__le16));
+			} else
+				name->len = 0;
+			*res = name;
+		}
+		/*
+		 * Not a perfect match, need to do full blown collation so we
+		 * know which way in the B+tree we have to go.
+		 */
+		rc = ntfs_collate_names(uname, uname_len,
+				(__le16 *)&ie->key.file_name.file_name,
+				ie->key.file_name.file_name_length, 1,
+				IGNORE_CASE, vol->upcase, vol->upcase_len);
+		/*
+		 * If uname collates before the name of the current entry, there
+		 * is definitely no such name in this index but we might need to
+		 * descend into the B+tree so we just break out of the loop.
+		 */
+		if (rc == -1)
+			break;
+		/* The names are not equal, continue the search. */
+		if (rc)
+			continue;
+		/*
+		 * Names match with case insensitive comparison, now try the
+		 * case sensitive comparison, which is required for proper
+		 * collation.
+		 */
+		rc = ntfs_collate_names(uname, uname_len,
+				(__le16 *)&ie->key.file_name.file_name,
+				ie->key.file_name.file_name_length, 1,
+				CASE_SENSITIVE, vol->upcase, vol->upcase_len);
+		if (rc == -1)
+			break;
+		if (rc)
+			continue;
+		/*
+		 * Perfect match, this will never happen as the
+		 * ntfs_are_names_equal() call will have gotten a match but we
+		 * still treat it correctly.
+		 */
+		goto found_it;
+	}
+	/*
+	 * We have finished with this index without success. Check for the
+	 * presence of a child node and if not present return -ENOENT, unless
+	 * we have got a matching name cached in name in which case return the
+	 * mft reference associated with it.
+	 */
+	if (!(ie->flags & INDEX_ENTRY_NODE)) {
+		if (name) {
+			ntfs_attr_put_search_ctx(ctx);
+			unmap_mft_record(dir_ni);
+			return name->mref;
+		}
+		ntfs_debug("Entry not found.");
+		err = -ENOENT;
+		goto err_out;
+	} /* Child node present, descend into it. */
+
+	/* Get the starting vcn of the index_block holding the child node. */
+	vcn = le64_to_cpup((__le64 *)((u8 *)ie + le16_to_cpu(ie->length) - 8));
+
+	/*
+	 * We are done with the index root and the mft record. Release them,
+	 * otherwise we deadlock with ntfs_read_mapping_folio().
+	 */
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(dir_ni);
+	m = NULL;
+	ctx = NULL;
+
+	ia_vi = ntfs_index_iget(VFS_I(dir_ni), I30, 4);
+	if (IS_ERR(ia_vi)) {
+		err = PTR_ERR(ia_vi);
+		goto err_out;
+	}
+
+	ia_mapping = ia_vi->i_mapping;
+descend_into_child_node:
+	/*
+	 * Convert vcn to index into the index allocation attribute in units
+	 * of PAGE_SIZE and map the page cache page, reading it from
+	 * disk if necessary.
+	 */
+	folio = ntfs_read_mapping_folio(ia_mapping, vcn <<
+			dir_ni->itype.index.vcn_size_bits >> PAGE_SHIFT);
+	if (IS_ERR(folio)) {
+		ntfs_error(sb, "Failed to map directory index page, error %ld.",
+				-PTR_ERR(folio));
+		err = PTR_ERR(folio);
+		goto err_out;
+	}
+
+	folio_lock(folio);
+	kaddr = kmalloc(PAGE_SIZE, GFP_NOFS);
+	if (!kaddr) {
+		err = -ENOMEM;
+		folio_unlock(folio);
+		folio_put(folio);
+		goto unm_err_out;
+	}
+
+	memcpy_from_folio(kaddr, folio, 0, PAGE_SIZE);
+	post_read_mst_fixup((struct ntfs_record *)kaddr, PAGE_SIZE);
+	folio_unlock(folio);
+	folio_put(folio);
+fast_descend_into_child_node:
+	/* Get to the index allocation block. */
+	ia = (struct index_block *)(kaddr + ((vcn <<
+			dir_ni->itype.index.vcn_size_bits) & ~PAGE_MASK));
+	/* Bounds checks. */
+	if ((u8 *)ia < kaddr || (u8 *)ia > kaddr + PAGE_SIZE) {
+		ntfs_error(sb,
+			"Out of bounds check failed. Corrupt directory inode 0x%lx or driver bug.",
+			dir_ni->mft_no);
+		goto unm_err_out;
+	}
+	/* Catch multi sector transfer fixup errors. */
+	if (unlikely(!ntfs_is_indx_record(ia->magic))) {
+		ntfs_error(sb,
+			"Directory index record with vcn 0x%llx is corrupt.  Corrupt inode 0x%lx.  Run chkdsk.",
+			(unsigned long long)vcn, dir_ni->mft_no);
+		goto unm_err_out;
+	}
+	if (le64_to_cpu(ia->index_block_vcn) != vcn) {
+		ntfs_error(sb,
+			"Actual VCN (0x%llx) of index buffer is different from expected VCN (0x%llx). Directory inode 0x%lx is corrupt or driver bug.",
+			(unsigned long long)le64_to_cpu(ia->index_block_vcn),
+			(unsigned long long)vcn, dir_ni->mft_no);
+		goto unm_err_out;
+	}
+	if (le32_to_cpu(ia->index.allocated_size) + 0x18 !=
+			dir_ni->itype.index.block_size) {
+		ntfs_error(sb,
+			"Index buffer (VCN 0x%llx) of directory inode 0x%lx has a size (%u) differing from the directory specified size (%u). Directory inode is corrupt or driver bug.",
+			(unsigned long long)vcn, dir_ni->mft_no,
+			le32_to_cpu(ia->index.allocated_size) + 0x18,
+			dir_ni->itype.index.block_size);
+		goto unm_err_out;
+	}
+	index_end = (u8 *)ia + dir_ni->itype.index.block_size;
+	if (index_end > kaddr + PAGE_SIZE) {
+		ntfs_error(sb,
+			"Index buffer (VCN 0x%llx) of directory inode 0x%lx crosses page boundary. Impossible! Cannot access! This is probably a bug in the driver.",
+			(unsigned long long)vcn, dir_ni->mft_no);
+		goto unm_err_out;
+	}
+	index_end = (u8 *)&ia->index + le32_to_cpu(ia->index.index_length);
+	if (index_end > (u8 *)ia + dir_ni->itype.index.block_size) {
+		ntfs_error(sb,
+			"Size of index buffer (VCN 0x%llx) of directory inode 0x%lx exceeds maximum size.",
+			(unsigned long long)vcn, dir_ni->mft_no);
+		goto unm_err_out;
+	}
+	/* The first index entry. */
+	ie = (struct index_entry *)((u8 *)&ia->index +
+			le32_to_cpu(ia->index.entries_offset));
+	/*
+	 * Iterate similar to above big loop but applied to index buffer, thus
+	 * loop until we exceed valid memory (corruption case) or until we
+	 * reach the last entry.
+	 */
+	for (;; ie = (struct index_entry *)((u8 *)ie + le16_to_cpu(ie->length))) {
+		/* Bounds checks. */
+		if ((u8 *)ie < (u8 *)ia ||
+		    (u8 *)ie + sizeof(struct index_entry_header) > index_end ||
+		    (u8 *)ie + sizeof(struct index_entry_header) + le16_to_cpu(ie->key_length) >
+				index_end || (u8 *)ie + le16_to_cpu(ie->length) > index_end) {
+			ntfs_error(sb, "Index entry out of bounds in directory inode 0x%lx.",
+					dir_ni->mft_no);
+			goto unm_err_out;
+		}
+		/*
+		 * The last entry cannot contain a name. It can however contain
+		 * a pointer to a child node in the B+tree so we just break out.
+		 */
+		if (ie->flags & INDEX_ENTRY_END)
+			break;
+		/* Key length should not be zero if it is not last entry. */
+		if (!ie->key_length)
+			goto unm_err_out;
+		/* Check the consistency of an index entry */
+		if (ntfs_index_entry_inconsistent(NULL, vol, ie, COLLATION_FILE_NAME,
+				dir_ni->mft_no))
+			goto unm_err_out;
+		/*
+		 * We perform a case sensitive comparison and if that matches
+		 * we are done and return the mft reference of the inode (i.e.
+		 * the inode number together with the sequence number for
+		 * consistency checking). We convert it to cpu format before
+		 * returning.
+		 */
+		if (ntfs_are_names_equal(uname, uname_len,
+				(__le16 *)&ie->key.file_name.file_name,
+				ie->key.file_name.file_name_length,
+				CASE_SENSITIVE, vol->upcase, vol->upcase_len)) {
+found_it2:
+			/*
+			 * We have a perfect match, so we don't need to care
+			 * about having matched imperfectly before, so we can
+			 * free name and set *res to NULL.
+			 * However, if the perfect match is a short file name,
+			 * we need to signal this through *res, so that
+			 * ntfs_lookup() can fix dcache aliasing issues.
+			 * As an optimization we just reuse an existing
+			 * allocation of *res.
+			 */
+			if (ie->key.file_name.file_name_type == FILE_NAME_DOS) {
+				if (!name) {
+					name = kmalloc(sizeof(struct ntfs_name),
+							GFP_NOFS);
+					if (!name) {
+						err = -ENOMEM;
+						goto unm_err_out;
+					}
+				}
+				name->mref = le64_to_cpu(
+						ie->data.dir.indexed_file);
+				name->type = FILE_NAME_DOS;
+				name->len = 0;
+				*res = name;
+			} else {
+				kfree(name);
+				*res = NULL;
+			}
+			mref = le64_to_cpu(ie->data.dir.indexed_file);
+			kfree(kaddr);
+			iput(ia_vi);
+			return mref;
+		}
+		/*
+		 * For a case insensitive mount, we also perform a case
+		 * insensitive comparison (provided the file name is not in the
+		 * POSIX namespace). If the comparison matches, and the name is
+		 * in the WIN32 namespace, we cache the filename in *res so
+		 * that the caller, ntfs_lookup(), can work on it. If the
+		 * comparison matches, and the name is in the DOS namespace, we
+		 * only cache the mft reference and the file name type (we set
+		 * the name length to zero for simplicity).
+		 */
+		if (!NVolCaseSensitive(vol) &&
+				ie->key.file_name.file_name_type &&
+				ntfs_are_names_equal(uname, uname_len,
+				(__le16 *)&ie->key.file_name.file_name,
+				ie->key.file_name.file_name_length,
+				IGNORE_CASE, vol->upcase, vol->upcase_len)) {
+			int name_size = sizeof(struct ntfs_name);
+			u8 type = ie->key.file_name.file_name_type;
+			u8 len = ie->key.file_name.file_name_length;
+
+			/* Only one case insensitive matching name allowed. */
+			if (name) {
+				ntfs_error(sb,
+					"Found already allocated name in phase 2. Please run chkdsk");
+				kfree(kaddr);
+				goto dir_err_out;
+			}
+
+			if (type != FILE_NAME_DOS)
+				name_size += len * sizeof(__le16);
+			name = kmalloc(name_size, GFP_NOFS);
+			if (!name) {
+				err = -ENOMEM;
+				goto unm_err_out;
+			}
+			name->mref = le64_to_cpu(ie->data.dir.indexed_file);
+			name->type = type;
+			if (type != FILE_NAME_DOS) {
+				name->len = len;
+				memcpy(name->name, ie->key.file_name.file_name,
+						len * sizeof(__le16));
+			} else
+				name->len = 0;
+			*res = name;
+		}
+		/*
+		 * Not a perfect match, need to do full blown collation so we
+		 * know which way in the B+tree we have to go.
+		 */
+		rc = ntfs_collate_names(uname, uname_len,
+				(__le16 *)&ie->key.file_name.file_name,
+				ie->key.file_name.file_name_length, 1,
+				IGNORE_CASE, vol->upcase, vol->upcase_len);
+		/*
+		 * If uname collates before the name of the current entry, there
+		 * is definitely no such name in this index but we might need to
+		 * descend into the B+tree so we just break out of the loop.
+		 */
+		if (rc == -1)
+			break;
+		/* The names are not equal, continue the search. */
+		if (rc)
+			continue;
+		/*
+		 * Names match with case insensitive comparison, now try the
+		 * case sensitive comparison, which is required for proper
+		 * collation.
+		 */
+		rc = ntfs_collate_names(uname, uname_len,
+				(__le16 *)&ie->key.file_name.file_name,
+				ie->key.file_name.file_name_length, 1,
+				CASE_SENSITIVE, vol->upcase, vol->upcase_len);
+		if (rc == -1)
+			break;
+		if (rc)
+			continue;
+		/*
+		 * Perfect match, this will never happen as the
+		 * ntfs_are_names_equal() call will have gotten a match but we
+		 * still treat it correctly.
+		 */
+		goto found_it2;
+	}
+	/*
+	 * We have finished with this index buffer without success. Check for
+	 * the presence of a child node.
+	 */
+	if (ie->flags & INDEX_ENTRY_NODE) {
+		if ((ia->index.flags & NODE_MASK) == LEAF_NODE) {
+			ntfs_error(sb,
+				"Index entry with child node found in a leaf node in directory inode 0x%lx.",
+				dir_ni->mft_no);
+			goto unm_err_out;
+		}
+		/* Child node present, descend into it. */
+		old_vcn = vcn;
+		vcn = le64_to_cpup((__le64 *)((u8 *)ie +
+				le16_to_cpu(ie->length) - 8));
+		if (vcn >= 0) {
+			/*
+			 * If vcn is in the same page cache page as old_vcn we
+			 * recycle the mapped page.
+			 */
+			if ((old_vcn << vol->cluster_size_bits >> PAGE_SHIFT) ==
+			    (vcn << vol->cluster_size_bits >> PAGE_SHIFT))
+				goto fast_descend_into_child_node;
+			kfree(kaddr);
+			kaddr = NULL;
+			goto descend_into_child_node;
+		}
+		ntfs_error(sb, "Negative child node vcn in directory inode 0x%lx.",
+				dir_ni->mft_no);
+		goto unm_err_out;
+	}
+	/*
+	 * No child node present, return -ENOENT, unless we have got a matching
+	 * name cached in name in which case return the mft reference
+	 * associated with it.
+	 */
+	if (name) {
+		kfree(kaddr);
+		iput(ia_vi);
+		return name->mref;
+	}
+	ntfs_debug("Entry not found.");
+	err = -ENOENT;
+unm_err_out:
+	kfree(kaddr);
+err_out:
+	if (!err)
+		err = -EIO;
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+	if (m)
+		unmap_mft_record(dir_ni);
+	kfree(name);
+	*res = NULL;
+	if (ia_vi && !IS_ERR(ia_vi))
+		iput(ia_vi);
+	return ERR_MREF(err);
+dir_err_out:
+	ntfs_error(sb, "Corrupt directory.  Aborting lookup.");
+	goto err_out;
+}
+
+/**
+ * ntfs_filldir - ntfs specific filldir method
+ * @vol:	current ntfs volume
+ * @ndir:	ntfs inode of current directory
+ * @ia_page:	page in which the index allocation buffer @ie is in resides
+ * @ie:		current index entry
+ * @name:	buffer to use for the converted name
+ * @actor:	what to feed the entries to
+ *
+ * Convert the Unicode @name to the loaded NLS and pass it to the @filldir
+ * callback.
+ *
+ * If @ia_page is not NULL it is the locked page containing the index
+ * allocation block containing the index entry @ie.
+ *
+ * Note, we drop (and then reacquire) the page lock on @ia_page across the
+ * @filldir() call otherwise we would deadlock with NFSd when it calls ->lookup
+ * since ntfs_lookup() will lock the same page.  As an optimization, we do not
+ * retake the lock if we are returning a non-zero value as ntfs_readdir()
+ * would need to drop the lock immediately anyway.
+ */
+static inline int ntfs_filldir(struct ntfs_volume *vol,
+		struct ntfs_inode *ndir, struct page *ia_page, struct index_entry *ie,
+		u8 *name, struct dir_context *actor)
+{
+	unsigned long mref;
+	int name_len;
+	unsigned int dt_type;
+	u8 name_type;
+
+	name_type = ie->key.file_name.file_name_type;
+	if (name_type == FILE_NAME_DOS) {
+		ntfs_debug("Skipping DOS name space entry.");
+		return 0;
+	}
+	if (MREF_LE(ie->data.dir.indexed_file) == FILE_root) {
+		ntfs_debug("Skipping root directory self reference entry.");
+		return 0;
+	}
+	if (MREF_LE(ie->data.dir.indexed_file) < FILE_first_user &&
+			!NVolShowSystemFiles(vol)) {
+		ntfs_debug("Skipping system file.");
+		return 0;
+	}
+
+	name_len = ntfs_ucstonls(vol, (__le16 *)&ie->key.file_name.file_name,
+			ie->key.file_name.file_name_length, &name,
+			NTFS_MAX_NAME_LEN * NLS_MAX_CHARSET_SIZE + 1);
+	if (name_len <= 0) {
+		ntfs_warning(vol->sb, "Skipping unrepresentable inode 0x%llx.",
+				(long long)MREF_LE(ie->data.dir.indexed_file));
+		return 0;
+	}
+
+	mref = MREF_LE(ie->data.dir.indexed_file);
+	if (ie->key.file_name.file_attributes &
+			FILE_ATTR_DUP_FILE_NAME_INDEX_PRESENT)
+		dt_type = DT_DIR;
+	else if (ie->key.file_name.file_attributes & FILE_ATTR_REPARSE_POINT)
+		dt_type = ntfs_reparse_tag_dt_types(vol, mref);
+	else
+		dt_type = DT_REG;
+
+	/*
+	 * Drop the page lock otherwise we deadlock with NFS when it calls
+	 * ->lookup since ntfs_lookup() will lock the same page.
+	 */
+	if (ia_page)
+		unlock_page(ia_page);
+	ntfs_debug("Calling filldir for %s with len %i, fpos 0x%llx, inode 0x%lx, DT_%s.",
+		name, name_len, actor->pos, mref, dt_type == DT_DIR ? "DIR" : "REG");
+	if (!dir_emit(actor, name, name_len, mref, dt_type))
+		return 1;
+	/* Relock the page but not if we are aborting ->readdir. */
+	if (ia_page)
+		lock_page(ia_page);
+	return 0;
+}
+
+struct ntfs_file_private {
+	void *key;
+	__le16 key_length;
+	bool end_in_iterate;
+	loff_t curr_pos;
+};
+
+struct ntfs_index_ra {
+	unsigned long start_index;
+	unsigned int count;
+	struct rb_node rb_node;
+};
+
+static void ntfs_insert_rb(struct ntfs_index_ra *nir, struct rb_root *root)
+{
+	struct rb_node **new = &root->rb_node, *parent = NULL;
+	struct ntfs_index_ra *cnir;
+
+	while (*new) {
+		parent = *new;
+		cnir = rb_entry(parent, struct ntfs_index_ra, rb_node);
+		if (nir->start_index < cnir->start_index)
+			new = &parent->rb_left;
+		else if (nir->start_index >= cnir->start_index + cnir->count)
+			new = &parent->rb_right;
+		else {
+			pr_err("nir start index : %ld, count : %d, cnir start_index : %ld, count : %d\n",
+				nir->start_index, nir->count, cnir->start_index, cnir->count);
+			BUG_ON(1);
+		}
+	}
+
+	rb_link_node(&nir->rb_node, parent, new);
+	rb_insert_color(&nir->rb_node, root);
+}
+
+static int ntfs_ia_blocks_readahead(struct ntfs_inode *ia_ni, loff_t pos)
+{
+	unsigned long dir_start_index, dir_end_index;
+	struct inode *ia_vi = VFS_I(ia_ni);
+	struct file_ra_state *dir_ra;
+
+	dir_end_index = (i_size_read(ia_vi) + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	dir_start_index = (pos + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	if (dir_start_index >= dir_end_index)
+		return 0;
+
+	dir_ra = kzalloc(sizeof(*dir_ra), GFP_NOFS);
+	if (!dir_ra)
+		return -ENOMEM;
+
+	file_ra_state_init(dir_ra, ia_vi->i_mapping);
+	dir_end_index = (i_size_read(ia_vi) + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	dir_start_index = (pos + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	dir_ra->ra_pages = dir_end_index - dir_start_index;
+	page_cache_sync_readahead(ia_vi->i_mapping, dir_ra, NULL,
+			dir_start_index, dir_end_index - dir_start_index);
+	kfree(dir_ra);
+
+	return 0;
+}
+
+static int ntfs_readdir(struct file *file, struct dir_context *actor)
+{
+	struct inode *vdir = file_inode(file);
+	struct super_block *sb = vdir->i_sb;
+	struct ntfs_inode *ndir = NTFS_I(vdir);
+	struct ntfs_volume *vol = NTFS_SB(sb);
+	struct ntfs_attr_search_ctx *ctx = NULL;
+	struct ntfs_index_context *ictx = NULL;
+	u8 *name;
+	struct index_root *ir;
+	struct index_entry *next = NULL;
+	struct ntfs_file_private *private = NULL;
+	int err = 0;
+	loff_t ie_pos = 2; /* initialize it with dot and dotdot size */
+	struct ntfs_index_ra *nir = NULL;
+	unsigned long index;
+	struct rb_root ra_root = RB_ROOT;
+	struct file_ra_state *ra;
+
+	ntfs_debug("Entering for inode 0x%lx, fpos 0x%llx.",
+			vdir->i_ino, actor->pos);
+
+	if (file->private_data) {
+		private = file->private_data;
+
+		if (actor->pos != private->curr_pos) {
+			/*
+			 * If actor->pos is different from the previous passed
+			 * one, Discard the private->key and fill dirent buffer
+			 * with linear lookup.
+			 */
+			kfree(private->key);
+			private->key = NULL;
+			private->end_in_iterate = false;
+		} else if (private->end_in_iterate) {
+			kfree(private->key);
+			kfree(file->private_data);
+			file->private_data = NULL;
+			return 0;
+		}
+	}
+
+	/* Emulate . and .. for all directories. */
+	if (!dir_emit_dots(file, actor))
+		return 0;
+
+	/*
+	 * Allocate a buffer to store the current name being processed
+	 * converted to format determined by current NLS.
+	 */
+	name = kmalloc(NTFS_MAX_NAME_LEN * NLS_MAX_CHARSET_SIZE + 1, GFP_NOFS);
+	if (unlikely(!name))
+		return -ENOMEM;
+
+	mutex_lock_nested(&ndir->mrec_lock, NTFS_INODE_MUTEX_PARENT);
+	ictx = ntfs_index_ctx_get(ndir, I30, 4);
+	if (!ictx) {
+		kfree(name);
+		mutex_unlock(&ndir->mrec_lock);
+		return -ENOMEM;
+	}
+
+	ra = kzalloc(sizeof(struct file_ra_state), GFP_NOFS);
+	if (!ra) {
+		kfree(name);
+		ntfs_index_ctx_put(ictx);
+		mutex_unlock(&ndir->mrec_lock);
+		return -ENOMEM;
+	}
+	file_ra_state_init(ra, vol->mft_ino->i_mapping);
+
+	if (private && private->key) {
+		/*
+		 * Find index witk private->key using ntfs_index_lookup()
+		 * instead of linear index lookup.
+		 */
+		err = ntfs_index_lookup(private->key,
+					le16_to_cpu(private->key_length),
+					ictx);
+		if (!err) {
+			next = ictx->entry;
+			/*
+			 * Update ie_pos with private->curr_pos
+			 * to make next d_off of dirent correct.
+			 */
+			ie_pos = private->curr_pos;
+
+			if (actor->pos > vol->mft_record_size && ictx->ia_ni) {
+				err = ntfs_ia_blocks_readahead(ictx->ia_ni, actor->pos);
+				if (err)
+					goto out;
+			}
+
+			goto nextdir;
+		} else {
+			goto out;
+		}
+	} else if (!private) {
+		private = kzalloc(sizeof(struct ntfs_file_private), GFP_KERNEL);
+		if (!private) {
+			err = -ENOMEM;
+			goto out;
+		}
+		file->private_data = private;
+	}
+
+	ctx = ntfs_attr_get_search_ctx(ndir, NULL);
+	if (!ctx) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* Find the index root attribute in the mft record. */
+	if (ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL, 0,
+				ctx)) {
+		ntfs_error(sb, "Index root attribute missing in directory inode %ld",
+				ndir->mft_no);
+		ntfs_attr_put_search_ctx(ctx);
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* Get to the index root value. */
+	ir = (struct index_root *)((u8 *)ctx->attr +
+			le16_to_cpu(ctx->attr->data.resident.value_offset));
+
+	ictx->ir = ir;
+	ictx->actx = ctx;
+	ictx->parent_vcn[ictx->pindex] = VCN_INDEX_ROOT_PARENT;
+	ictx->is_in_root = true;
+	ictx->parent_pos[ictx->pindex] = 0;
+
+	ictx->block_size = le32_to_cpu(ir->index_block_size);
+	if (ictx->block_size < NTFS_BLOCK_SIZE) {
+		ntfs_error(sb, "Index block size (%d) is smaller than the sector size (%d)",
+				ictx->block_size, NTFS_BLOCK_SIZE);
+		err = -EIO;
+		goto out;
+	}
+
+	if (vol->cluster_size <= ictx->block_size)
+		ictx->vcn_size_bits = vol->cluster_size_bits;
+	else
+		ictx->vcn_size_bits = NTFS_BLOCK_SIZE_BITS;
+
+	/* The first index entry. */
+	next = (struct index_entry *)((u8 *)&ir->index +
+			le32_to_cpu(ir->index.entries_offset));
+
+	if (next->flags & INDEX_ENTRY_NODE) {
+		ictx->ia_ni = ntfs_ia_open(ictx, ictx->idx_ni);
+		if (!ictx->ia_ni) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		err = ntfs_ia_blocks_readahead(ictx->ia_ni, actor->pos);
+		if (err)
+			goto out;
+	}
+
+	if (next->flags & INDEX_ENTRY_NODE) {
+		next = ntfs_index_walk_down(next, ictx);
+		if (!next) {
+			err = -EIO;
+			goto out;
+		}
+	}
+
+	if (next && !(next->flags & INDEX_ENTRY_END))
+		goto nextdir;
+
+	while ((next = ntfs_index_next(next, ictx)) != NULL) {
+nextdir:
+		/* Check the consistency of an index entry */
+		if (ntfs_index_entry_inconsistent(ictx, vol, next, COLLATION_FILE_NAME,
+					ndir->mft_no)) {
+			err = -EIO;
+			goto out;
+		}
+
+		if (ie_pos < actor->pos) {
+			ie_pos += next->length;
+			continue;
+		}
+
+		actor->pos = ie_pos;
+
+		index = (MREF_LE(next->data.dir.indexed_file) <<
+				vol->mft_record_size_bits) >> PAGE_SHIFT;
+		if (nir) {
+			struct ntfs_index_ra *cnir;
+			struct rb_node *node = ra_root.rb_node;
+
+			if (nir->start_index <= index &&
+			    index < nir->start_index + nir->count) {
+				/* No behavior */
+				goto filldir;
+			}
+
+			while (node) {
+				cnir = rb_entry(node, struct ntfs_index_ra, rb_node);
+				if (cnir->start_index <= index &&
+				    index < cnir->start_index + cnir->count) {
+					goto filldir;
+				} else if (cnir->start_index + cnir->count == index) {
+					cnir->count++;
+					goto filldir;
+				} else if (!cnir->start_index && cnir->start_index - 1 == index) {
+					cnir->start_index = index;
+					goto filldir;
+				}
+
+				if (index < cnir->start_index)
+					node = node->rb_left;
+				else if (index >= cnir->start_index + cnir->count)
+					node = node->rb_right;
+			}
+
+			if (nir->start_index + nir->count == index) {
+				nir->count++;
+			} else if (!nir->start_index && nir->start_index - 1 == index) {
+				nir->start_index = index;
+			} else if (nir->count > 2) {
+				ntfs_insert_rb(nir, &ra_root);
+				nir = NULL;
+			} else {
+				nir->start_index = index;
+				nir->count = 1;
+			}
+		}
+
+		if (!nir) {
+			nir = kzalloc(sizeof(struct ntfs_index_ra), GFP_KERNEL);
+			if (nir) {
+				nir->start_index = index;
+				nir->count = 1;
+			}
+		}
+
+filldir:
+		/* Submit the name to the filldir callback. */
+		err = ntfs_filldir(vol, ndir, NULL, next, name, actor);
+		if (err) {
+			/*
+			 * Store index key value to file private_data to start
+			 * from current index offset on next round.
+			 */
+			private = file->private_data;
+			kfree(private->key);
+			private->key = kmalloc(le16_to_cpu(next->key_length), GFP_KERNEL);
+			if (!private->key) {
+				err = -ENOMEM;
+				goto out;
+			}
+
+			memcpy(private->key, &next->key.file_name, le16_to_cpu(next->key_length));
+			private->key_length = next->key_length;
+			break;
+		}
+		ie_pos += next->length;
+	}
+
+	if (!err)
+		private->end_in_iterate = true;
+	else
+		err = 0;
+
+	private->curr_pos = actor->pos = ie_pos;
+out:
+	while (!RB_EMPTY_ROOT(&ra_root)) {
+		struct ntfs_index_ra *cnir;
+		struct rb_node *node;
+
+		node = rb_first(&ra_root);
+		cnir = rb_entry(node, struct ntfs_index_ra, rb_node);
+		ra->ra_pages = cnir->count;
+		page_cache_sync_readahead(vol->mft_ino->i_mapping, ra, NULL,
+				cnir->start_index, cnir->count);
+		rb_erase(node, &ra_root);
+		kfree(cnir);
+	}
+
+	if (err) {
+		private->curr_pos = actor->pos;
+		private->end_in_iterate = true;
+		err = 0;
+	}
+	ntfs_index_ctx_put(ictx);
+	kfree(name);
+	kfree(nir);
+	kfree(ra);
+	mutex_unlock(&ndir->mrec_lock);
+	return err;
+}
+
+int ntfs_check_empty_dir(struct ntfs_inode *ni, struct mft_record *ni_mrec)
+{
+	struct ntfs_attr_search_ctx *ctx;
+	int ret = 0;
+
+	if (!(ni_mrec->flags & MFT_RECORD_IS_DIRECTORY))
+		return 0;
+
+	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!ctx) {
+		ntfs_error(ni->vol->sb, "Failed to get search context");
+		return -ENOMEM;
+	}
+
+	/* Find the index root attribute in the mft record. */
+	ret = ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL,
+				0, ctx);
+	if (ret) {
+		ntfs_error(ni->vol->sb, "Index root attribute missing in directory inode %lld",
+				(unsigned long long)ni->mft_no);
+		ntfs_attr_put_search_ctx(ctx);
+		return ret;
+	}
+
+	/* Non-empty directory? */
+	if (ctx->attr->data.resident.value_length !=
+	    sizeof(struct index_root) + sizeof(struct index_entry_header)) {
+		/* Both ENOTEMPTY and EEXIST are ok. We use the more common. */
+		ret = -ENOTEMPTY;
+		ntfs_debug("Directory is not empty\n");
+	}
+
+	ntfs_attr_put_search_ctx(ctx);
+
+	return ret;
+}
+
+/**
+ * ntfs_dir_open - called when an inode is about to be opened
+ * @vi:		inode to be opened
+ * @filp:	file structure describing the inode
+ *
+ * Limit directory size to the page cache limit on architectures where unsigned
+ * long is 32-bits. This is the most we can do for now without overflowing the
+ * page cache page index. Doing it this way means we don't run into problems
+ * because of existing too large directories. It would be better to allow the
+ * user to read the accessible part of the directory but I doubt very much
+ * anyone is going to hit this check on a 32-bit architecture, so there is no
+ * point in adding the extra complexity required to support this.
+ *
+ * On 64-bit architectures, the check is hopefully optimized away by the
+ * compiler.
+ */
+static int ntfs_dir_open(struct inode *vi, struct file *filp)
+{
+	if (sizeof(unsigned long) < 8) {
+		if (i_size_read(vi) > MAX_LFS_FILESIZE)
+			return -EFBIG;
+	}
+	return 0;
+}
+
+static int ntfs_dir_release(struct inode *vi, struct file *filp)
+{
+	if (filp->private_data) {
+		kfree(((struct ntfs_file_private *)filp->private_data)->key);
+		kfree(filp->private_data);
+		filp->private_data = NULL;
+	}
+	return 0;
+}
+
+/**
+ * ntfs_dir_fsync - sync a directory to disk
+ * @filp:	file describing the directory to be synced
+ * @start:	start offset to be synced
+ * @end:	end offset to be synced
+ * @datasync:	if non-zero only flush user data and not metadata
+ *
+ * Data integrity sync of a directory to disk.  Used for fsync, fdatasync, and
+ * msync system calls.  This function is based on file.c::ntfs_file_fsync().
+ *
+ * Write the mft record and all associated extent mft records as well as the
+ * $INDEX_ALLOCATION and $BITMAP attributes and then sync the block device.
+ *
+ * If @datasync is true, we do not wait on the inode(s) to be written out
+ * but we always wait on the page cache pages to be written out.
+ *
+ * Note: In the past @filp could be NULL so we ignore it as we don't need it
+ * anyway.
+ *
+ * Locking: Caller must hold i_mutex on the inode.
+ */
+static int ntfs_dir_fsync(struct file *filp, loff_t start, loff_t end,
+			  int datasync)
+{
+	struct inode *bmp_vi, *vi = filp->f_mapping->host;
+	struct ntfs_volume *vol = NTFS_I(vi)->vol;
+	struct ntfs_inode *ni = NTFS_I(vi);
+	struct ntfs_attr_search_ctx *ctx;
+	struct inode *parent_vi, *ia_vi;
+	int err, ret;
+	struct ntfs_attr na;
+
+	ntfs_debug("Entering for inode 0x%lx.", vi->i_ino);
+
+	if (NVolShutdown(vol))
+		return -EIO;
+
+	ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!ctx)
+		return -ENOMEM;
+
+	mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL_2);
+	while (!(err = ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, 0, 0, NULL, 0, ctx))) {
+		struct file_name_attr *fn = (struct file_name_attr *)((u8 *)ctx->attr +
+				le16_to_cpu(ctx->attr->data.resident.value_offset));
+
+		parent_vi = ntfs_iget(vi->i_sb, MREF_LE(fn->parent_directory));
+		if (IS_ERR(parent_vi))
+			continue;
+		mutex_lock_nested(&NTFS_I(parent_vi)->mrec_lock, NTFS_INODE_MUTEX_PARENT_2);
+		ia_vi = ntfs_index_iget(parent_vi, I30, 4);
+		mutex_unlock(&NTFS_I(parent_vi)->mrec_lock);
+		if (IS_ERR(ia_vi)) {
+			iput(parent_vi);
+			continue;
+		}
+		write_inode_now(ia_vi, 1);
+		iput(ia_vi);
+		write_inode_now(parent_vi, 1);
+		iput(parent_vi);
+	}
+	mutex_unlock(&ni->mrec_lock);
+	ntfs_attr_put_search_ctx(ctx);
+
+	err = file_write_and_wait_range(filp, start, end);
+	if (err)
+		return err;
+	inode_lock(vi);
+
+	BUG_ON(!S_ISDIR(vi->i_mode));
+	/* If the bitmap attribute inode is in memory sync it, too. */
+	na.mft_no = vi->i_ino;
+	na.type = AT_BITMAP;
+	na.name = I30;
+	na.name_len = 4;
+	bmp_vi = ilookup5(vi->i_sb, vi->i_ino, ntfs_test_inode, &na);
+	if (bmp_vi) {
+		write_inode_now(bmp_vi, !datasync);
+		iput(bmp_vi);
+	}
+	ret = __ntfs_write_inode(vi, 1);
+
+	write_inode_now(vi, !datasync);
+
+	write_inode_now(vol->mftbmp_ino, 1);
+	down_write(&vol->lcnbmp_lock);
+	write_inode_now(vol->lcnbmp_ino, 1);
+	up_write(&vol->lcnbmp_lock);
+	write_inode_now(vol->mft_ino, 1);
+
+	err = sync_blockdev(vi->i_sb->s_bdev);
+	if (unlikely(err && !ret))
+		ret = err;
+	if (likely(!ret))
+		ntfs_debug("Done.");
+	else
+		ntfs_warning(vi->i_sb,
+			"Failed to f%ssync inode 0x%lx.  Error %u.",
+			datasync ? "data" : "", vi->i_ino, -ret);
+	inode_unlock(vi);
+	return ret;
+}
+
+const struct file_operations ntfs_dir_ops = {
+	.llseek		= generic_file_llseek,	/* Seek inside directory. */
+	.read		= generic_read_dir,	/* Return -EISDIR. */
+	.iterate_shared	= ntfs_readdir,		/* Read directory contents. */
+	.fsync		= ntfs_dir_fsync,	/* Sync a directory to disk. */
+	.open		= ntfs_dir_open,	/* Open directory. */
+	.release	= ntfs_dir_release,
+	.unlocked_ioctl	= ntfs_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ntfs_compat_ioctl,
+#endif
+};
diff --git a/fs/ntfsplus/index.c b/fs/ntfsplus/index.c
new file mode 100644
index 000000000000..dce7602ccb03
--- /dev/null
+++ b/fs/ntfsplus/index.c
@@ -0,0 +1,2114 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NTFS kernel index handling. Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2004-2005 Anton Altaparmakov
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ *
+ * Part of this file is based on code from the NTFS-3G project.
+ * and is copyrighted by the respective authors below:
+ * Copyright (c) 2004-2005 Anton Altaparmakov
+ * Copyright (c) 2004-2005 Richard Russon
+ * Copyright (c) 2005-2006 Yura Pakhuchiy
+ * Copyright (c) 2005-2008 Szabolcs Szakacsits
+ * Copyright (c) 2007-2021 Jean-Pierre Andre
+ */
+
+#include "collate.h"
+#include "index.h"
+#include "ntfs.h"
+#include "misc.h"
+#include "attrlist.h"
+
+/*
+ * ntfs_index_entry_inconsistent - Check the consistency of an index entry
+ *
+ * Make sure data and key do not overflow from entry.
+ * As a side effect, an entry with zero length is rejected.
+ * This entry must be a full one (no INDEX_ENTRY_END flag), and its
+ * length must have been checked beforehand to not overflow from the
+ * index record.
+ */
+int ntfs_index_entry_inconsistent(struct ntfs_index_context *icx,
+		struct ntfs_volume *vol, const struct index_entry *ie,
+		__le32 collation_rule, u64 inum)
+{
+	if (icx) {
+		struct index_header *ih;
+		u8 *ie_start, *ie_end;
+
+		if (icx->is_in_root)
+			ih = &icx->ir->index;
+		else
+			ih = &icx->ib->index;
+
+		if ((le32_to_cpu(ih->index_length) > le32_to_cpu(ih->allocated_size)) ||
+				(le32_to_cpu(ih->index_length) > icx->block_size)) {
+			ntfs_error(vol->sb, "%s Index entry(0x%p)'s length is too big.",
+					icx->is_in_root ? "Index root" : "Index block",
+					(u8 *)icx->entry);
+			return -EINVAL;
+		}
+
+		ie_start = (u8 *)ih + le32_to_cpu(ih->entries_offset);
+		ie_end = (u8 *)ih + le32_to_cpu(ih->index_length);
+
+		if (ie_start > (u8 *)ie ||
+		    ie_end <= ((u8 *)ie + ie->length) ||
+		    ie->length > le32_to_cpu(ih->allocated_size) ||
+		    ie->length > icx->block_size) {
+			ntfs_error(vol->sb, "Index entry(0x%p) is out of range from %s",
+					(u8 *)icx->entry,
+					icx->is_in_root ? "index root" : "index block");
+			return -EIO;
+		}
+	}
+
+	if (ie->key_length &&
+	    ((le16_to_cpu(ie->key_length) + offsetof(struct index_entry, key)) >
+	     le16_to_cpu(ie->length))) {
+		ntfs_error(vol->sb, "Overflow from index entry in inode %lld\n",
+				(long long)inum);
+		return -EIO;
+
+	} else {
+		if (collation_rule == COLLATION_FILE_NAME) {
+			if ((offsetof(struct index_entry, key.file_name.file_name) +
+			     ie->key.file_name.file_name_length	* sizeof(__le16)) >
+					le16_to_cpu(ie->length)) {
+				ntfs_error(vol->sb,
+					"File name overflow from index entry in inode %lld\n",
+					(long long)inum);
+				return -EIO;
+			}
+		} else {
+			if (ie->data.vi.data_length &&
+			    ((le16_to_cpu(ie->data.vi.data_offset) +
+			      le16_to_cpu(ie->data.vi.data_length)) >
+			     le16_to_cpu(ie->length))) {
+				ntfs_error(vol->sb,
+					"Data overflow from index entry in inode %lld\n",
+					(long long)inum);
+				return -EIO;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * ntfs_index_entry_mark_dirty - mark an index entry dirty
+ * @ictx:	ntfs index context describing the index entry
+ *
+ * Mark the index entry described by the index entry context @ictx dirty.
+ *
+ * If the index entry is in the index root attribute, simply mark the inode
+ * containing the index root attribute dirty.  This ensures the mftrecord, and
+ * hence the index root attribute, will be written out to disk later.
+ *
+ * If the index entry is in an index block belonging to the index allocation
+ * attribute, set ib_dirty to true, thus index block will be updated during
+ * ntfs_index_ctx_put.
+ */
+void ntfs_index_entry_mark_dirty(struct ntfs_index_context *ictx)
+{
+	if (ictx->is_in_root)
+		mark_mft_record_dirty(ictx->actx->ntfs_ino);
+	else if (ictx->ib)
+		ictx->ib_dirty = true;
+}
+
+static s64 ntfs_ib_vcn_to_pos(struct ntfs_index_context *icx, s64 vcn)
+{
+	return vcn << icx->vcn_size_bits;
+}
+
+static s64 ntfs_ib_pos_to_vcn(struct ntfs_index_context *icx, s64 pos)
+{
+	return pos >> icx->vcn_size_bits;
+}
+
+static int ntfs_ib_write(struct ntfs_index_context *icx, struct index_block *ib)
+{
+	s64 ret, vcn = le64_to_cpu(ib->index_block_vcn);
+
+	ntfs_debug("vcn: %lld\n", vcn);
+
+	ret = pre_write_mst_fixup((struct ntfs_record *)ib, icx->block_size);
+	if (ret)
+		return -EIO;
+
+	ret = ntfs_inode_attr_pwrite(VFS_I(icx->ia_ni),
+			ntfs_ib_vcn_to_pos(icx, vcn), icx->block_size,
+			(u8 *)ib, icx->sync_write);
+	if (ret != icx->block_size) {
+		ntfs_debug("Failed to write index block %lld, inode %llu",
+				vcn, (unsigned long long)icx->idx_ni->mft_no);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ntfs_icx_ib_write(struct ntfs_index_context *icx)
+{
+	int err;
+
+	err = ntfs_ib_write(icx, icx->ib);
+	if (err)
+		return err;
+
+	icx->ib_dirty = false;
+
+	return 0;
+}
+
+int ntfs_icx_ib_sync_write(struct ntfs_index_context *icx)
+{
+	int ret;
+
+	if (icx->ib_dirty == false)
+		return 0;
+
+	icx->sync_write = true;
+
+	ret = ntfs_ib_write(icx, icx->ib);
+	if (!ret) {
+		ntfs_free(icx->ib);
+		icx->ib = NULL;
+		icx->ib_dirty = false;
+	} else {
+		post_write_mst_fixup((struct ntfs_record *)icx->ib);
+		icx->sync_write = false;
+	}
+
+	return ret;
+}
+
+/**
+ * ntfs_index_ctx_get - allocate and initialize a new index context
+ * @ni:		ntfs inode with which to initialize the context
+ * @name:	name of the which context describes
+ * @name_len:	length of the index name
+ *
+ * Allocate a new index context, initialize it with @ni and return it.
+ * Return NULL if allocation failed.
+ */
+struct ntfs_index_context *ntfs_index_ctx_get(struct ntfs_inode *ni,
+		__le16 *name, u32 name_len)
+{
+	struct ntfs_index_context *icx;
+
+	ntfs_debug("Entering\n");
+
+	if (!ni)
+		return NULL;
+
+	if (ni->nr_extents == -1)
+		ni = ni->ext.base_ntfs_ino;
+
+	icx = kmem_cache_alloc(ntfs_index_ctx_cache, GFP_NOFS);
+	if (icx)
+		*icx = (struct ntfs_index_context) {
+			.idx_ni = ni,
+			.name = name,
+			.name_len = name_len,
+		};
+	return icx;
+}
+
+static void ntfs_index_ctx_free(struct ntfs_index_context *icx)
+{
+	ntfs_debug("Entering\n");
+
+	if (icx->actx) {
+		ntfs_attr_put_search_ctx(icx->actx);
+		icx->actx = NULL;
+	}
+
+	if (!icx->is_in_root) {
+		if (icx->ib_dirty)
+			ntfs_ib_write(icx, icx->ib);
+		ntfs_free(icx->ib);
+		icx->ib = NULL;
+	}
+
+	if (icx->ia_ni) {
+		iput(VFS_I(icx->ia_ni));
+		icx->ia_ni = NULL;
+	}
+}
+
+/**
+ * ntfs_index_ctx_put - release an index context
+ * @icx:	index context to free
+ *
+ * Release the index context @icx, releasing all associated resources.
+ */
+void ntfs_index_ctx_put(struct ntfs_index_context *icx)
+{
+	ntfs_index_ctx_free(icx);
+	kmem_cache_free(ntfs_index_ctx_cache, icx);
+}
+
+/**
+ * ntfs_index_ctx_reinit - reinitialize an index context
+ * @icx:	index context to reinitialize
+ *
+ * Reinitialize the index context @icx so it can be used for ntfs_index_lookup.
+ */
+void ntfs_index_ctx_reinit(struct ntfs_index_context *icx)
+{
+	ntfs_debug("Entering\n");
+
+	ntfs_index_ctx_free(icx);
+
+	*icx = (struct ntfs_index_context) {
+		.idx_ni = icx->idx_ni,
+		.name = icx->name,
+		.name_len = icx->name_len,
+	};
+}
+
+static __le64 *ntfs_ie_get_vcn_addr(struct index_entry *ie)
+{
+	return (__le64 *)((u8 *)ie + le16_to_cpu(ie->length) - sizeof(s64));
+}
+
+/**
+ *  Get the subnode vcn to which the index entry refers.
+ */
+static s64 ntfs_ie_get_vcn(struct index_entry *ie)
+{
+	return le64_to_cpup(ntfs_ie_get_vcn_addr(ie));
+}
+
+static struct index_entry *ntfs_ie_get_first(struct index_header *ih)
+{
+	return (struct index_entry *)((u8 *)ih + le32_to_cpu(ih->entries_offset));
+}
+
+static struct index_entry *ntfs_ie_get_next(struct index_entry *ie)
+{
+	return (struct index_entry *)((char *)ie + le16_to_cpu(ie->length));
+}
+
+static u8 *ntfs_ie_get_end(struct index_header *ih)
+{
+	return (u8 *)ih + le32_to_cpu(ih->index_length);
+}
+
+static int ntfs_ie_end(struct index_entry *ie)
+{
+	return ie->flags & INDEX_ENTRY_END || !ie->length;
+}
+
+/**
+ *  Find the last entry in the index block
+ */
+static struct index_entry *ntfs_ie_get_last(struct index_entry *ie, char *ies_end)
+{
+	ntfs_debug("Entering\n");
+
+	while ((char *)ie < ies_end && !ntfs_ie_end(ie))
+		ie = ntfs_ie_get_next(ie);
+
+	return ie;
+}
+
+static struct index_entry *ntfs_ie_get_by_pos(struct index_header *ih, int pos)
+{
+	struct index_entry *ie;
+
+	ntfs_debug("pos: %d\n", pos);
+
+	ie = ntfs_ie_get_first(ih);
+
+	while (pos-- > 0)
+		ie = ntfs_ie_get_next(ie);
+
+	return ie;
+}
+
+static struct index_entry *ntfs_ie_prev(struct index_header *ih, struct index_entry *ie)
+{
+	struct index_entry *ie_prev = NULL;
+	struct index_entry *tmp;
+
+	ntfs_debug("Entering\n");
+
+	tmp = ntfs_ie_get_first(ih);
+
+	while (tmp != ie) {
+		ie_prev = tmp;
+		tmp = ntfs_ie_get_next(tmp);
+	}
+
+	return ie_prev;
+}
+
+static int ntfs_ih_numof_entries(struct index_header *ih)
+{
+	int n;
+	struct index_entry *ie;
+	u8 *end;
+
+	ntfs_debug("Entering\n");
+
+	end = ntfs_ie_get_end(ih);
+	ie = ntfs_ie_get_first(ih);
+	for (n = 0; !ntfs_ie_end(ie) && (u8 *)ie < end; n++)
+		ie = ntfs_ie_get_next(ie);
+	return n;
+}
+
+static int ntfs_ih_one_entry(struct index_header *ih)
+{
+	return (ntfs_ih_numof_entries(ih) == 1);
+}
+
+static int ntfs_ih_zero_entry(struct index_header *ih)
+{
+	return (ntfs_ih_numof_entries(ih) == 0);
+}
+
+static void ntfs_ie_delete(struct index_header *ih, struct index_entry *ie)
+{
+	u32 new_size;
+
+	ntfs_debug("Entering\n");
+
+	new_size = le32_to_cpu(ih->index_length) - le16_to_cpu(ie->length);
+	ih->index_length = cpu_to_le32(new_size);
+	memmove(ie, (u8 *)ie + le16_to_cpu(ie->length),
+			new_size - ((u8 *)ie - (u8 *)ih));
+}
+
+static void ntfs_ie_set_vcn(struct index_entry *ie, s64 vcn)
+{
+	*ntfs_ie_get_vcn_addr(ie) = cpu_to_le64(vcn);
+}
+
+/**
+ *  Insert @ie index entry at @pos entry. Used @ih values should be ok already.
+ */
+static void ntfs_ie_insert(struct index_header *ih, struct index_entry *ie,
+		struct index_entry *pos)
+{
+	int ie_size = le16_to_cpu(ie->length);
+
+	ntfs_debug("Entering\n");
+
+	ih->index_length = cpu_to_le32(le32_to_cpu(ih->index_length) + ie_size);
+	memmove((u8 *)pos + ie_size, pos,
+			le32_to_cpu(ih->index_length) - ((u8 *)pos - (u8 *)ih) - ie_size);
+	memcpy(pos, ie, ie_size);
+}
+
+static struct index_entry *ntfs_ie_dup(struct index_entry *ie)
+{
+	struct index_entry *dup;
+
+	ntfs_debug("Entering\n");
+
+	dup = ntfs_malloc_nofs(le16_to_cpu(ie->length));
+	if (dup)
+		memcpy(dup, ie, le16_to_cpu(ie->length));
+
+	return dup;
+}
+
+static struct index_entry *ntfs_ie_dup_novcn(struct index_entry *ie)
+{
+	struct index_entry *dup;
+	int size = le16_to_cpu(ie->length);
+
+	ntfs_debug("Entering\n");
+
+	if (ie->flags & INDEX_ENTRY_NODE)
+		size -= sizeof(s64);
+
+	dup = ntfs_malloc_nofs(size);
+	if (dup) {
+		memcpy(dup, ie, size);
+		dup->flags &= ~INDEX_ENTRY_NODE;
+		dup->length = cpu_to_le16(size);
+	}
+	return dup;
+}
+
+/*
+ * Check the consistency of an index block
+ *
+ * Make sure the index block does not overflow from the index record.
+ * The size of block is assumed to have been checked to be what is
+ * defined in the index root.
+ *
+ * Returns 0 if no error was found -1 otherwise (with errno unchanged)
+ *
+ * |<--->|  offsetof(struct index_block, index)
+ * |     |<--->|  sizeof(struct index_header)
+ * |     |     |
+ * |     |     | seq          index entries         unused
+ * |=====|=====|=====|===========================|==============|
+ * |     |           |                           |              |
+ * |     |<--------->| entries_offset            |              |
+ * |     |<---------------- index_length ------->|              |
+ * |     |<--------------------- allocated_size --------------->|
+ * |<--------------------------- block_size ------------------->|
+ *
+ * size(struct index_header) <= ent_offset < ind_length <= alloc_size < bk_size
+ */
+static int ntfs_index_block_inconsistent(struct ntfs_index_context *icx,
+		struct index_block *ib, s64 vcn)
+{
+	u32 ib_size = (unsigned int)le32_to_cpu(ib->index.allocated_size) +
+		offsetof(struct index_block, index);
+	struct super_block *sb = icx->idx_ni->vol->sb;
+	unsigned long long inum = icx->idx_ni->mft_no;
+
+	ntfs_debug("Entering\n");
+
+	if (!ntfs_is_indx_record(ib->magic)) {
+
+		ntfs_error(sb, "Corrupt index block signature: vcn %lld inode %llu\n",
+				vcn, (unsigned long long)icx->idx_ni->mft_no);
+		return -1;
+	}
+
+	if (le64_to_cpu(ib->index_block_vcn) != vcn) {
+		ntfs_error(sb,
+			"Corrupt index block: s64 (%lld) is different from expected s64 (%lld) in inode %llu\n",
+			(long long)le64_to_cpu(ib->index_block_vcn),
+			vcn, inum);
+		return -1;
+	}
+
+	if (ib_size != icx->block_size) {
+		ntfs_error(sb,
+			"Corrupt index block : s64 (%lld) of inode %llu has a size (%u) differing from the index specified size (%u)\n",
+			vcn, inum, ib_size, icx->block_size);
+		return -1;
+	}
+
+	if (le32_to_cpu(ib->index.entries_offset) < sizeof(struct index_header)) {
+		ntfs_error(sb, "Invalid index entry offset in inode %lld\n", inum);
+		return -1;
+	}
+	if (le32_to_cpu(ib->index.index_length) <=
+	    le32_to_cpu(ib->index.entries_offset)) {
+		ntfs_error(sb, "No space for index entries in inode %lld\n", inum);
+		return -1;
+	}
+	if (le32_to_cpu(ib->index.allocated_size) <
+	    le32_to_cpu(ib->index.index_length)) {
+		ntfs_error(sb, "Index entries overflow in inode %lld\n", inum);
+		return -1;
+	}
+
+	return 0;
+}
+
+static struct index_root *ntfs_ir_lookup(struct ntfs_inode *ni, __le16 *name,
+		u32 name_len, struct ntfs_attr_search_ctx **ctx)
+{
+	struct attr_record *a;
+	struct index_root *ir = NULL;
+
+	ntfs_debug("Entering\n");
+	*ctx = ntfs_attr_get_search_ctx(ni, NULL);
+	if (!*ctx) {
+		ntfs_error(ni->vol->sb, "%s, Failed to get search context", __func__);
+		return NULL;
+	}
+
+	if (ntfs_attr_lookup(AT_INDEX_ROOT, name, name_len, CASE_SENSITIVE,
+				0, NULL, 0, *ctx)) {
+		ntfs_error(ni->vol->sb, "Failed to lookup $INDEX_ROOT");
+		goto err_out;
+	}
+
+	a = (*ctx)->attr;
+	if (a->non_resident) {
+		ntfs_error(ni->vol->sb, "Non-resident $INDEX_ROOT detected");
+		goto err_out;
+	}
+
+	ir = (struct index_root *)((char *)a + le16_to_cpu(a->data.resident.value_offset));
+err_out:
+	if (!ir) {
+		ntfs_attr_put_search_ctx(*ctx);
+		*ctx = NULL;
+	}
+	return ir;
+}
+
+static struct index_root *ntfs_ir_lookup2(struct ntfs_inode *ni, __le16 *name, u32 len)
+{
+	struct ntfs_attr_search_ctx *ctx;
+	struct index_root *ir;
+
+	ir = ntfs_ir_lookup(ni, name, len, &ctx);
+	if (ir)
+		ntfs_attr_put_search_ctx(ctx);
+	return ir;
+}
+
+/**
+ * Find a key in the index block.
+ */
+static int ntfs_ie_lookup(const void *key, const int key_len,
+		struct ntfs_index_context *icx, struct index_header *ih,
+		s64 *vcn, struct index_entry **ie_out)
+{
+	struct index_entry *ie;
+	u8 *index_end;
+	int rc, item = 0;
+
+	ntfs_debug("Entering\n");
+
+	index_end = ntfs_ie_get_end(ih);
+
+	/*
+	 * Loop until we exceed valid memory (corruption case) or until we
+	 * reach the last entry.
+	 */
+	for (ie = ntfs_ie_get_first(ih); ; ie = ntfs_ie_get_next(ie)) {
+		/* Bounds checks. */
+		if ((u8 *)ie + sizeof(struct index_entry_header) > index_end ||
+				(u8 *)ie + le16_to_cpu(ie->length) > index_end) {
+			ntfs_error(icx->idx_ni->vol->sb,
+					"Index entry out of bounds in inode %llu.\n",
+					(unsigned long long)icx->idx_ni->mft_no);
+			return -ERANGE;
+		}
+
+		/*
+		 * The last entry cannot contain a key.  It can however contain
+		 * a pointer to a child node in the B+tree so we just break out.
+		 */
+		if (ntfs_ie_end(ie))
+			break;
+
+		/*
+		 * Not a perfect match, need to do full blown collation so we
+		 * know which way in the B+tree we have to go.
+		 */
+		rc = ntfs_collate(icx->idx_ni->vol, icx->cr, key, key_len, &ie->key,
+				le16_to_cpu(ie->key_length));
+		if (rc == -2) {
+			ntfs_error(icx->idx_ni->vol->sb,
+				"Collation error. Perhaps a filename contains invalid characters?\n");
+			return -ERANGE;
+		}
+		/*
+		 * If @key collates before the key of the current entry, there
+		 * is definitely no such key in this index but we might need to
+		 * descend into the B+tree so we just break out of the loop.
+		 */
+		if (rc == -1)
+			break;
+
+		if (!rc) {
+			*ie_out = ie;
+			icx->parent_pos[icx->pindex] = item;
+			return 0;
+		}
+
+		item++;
+	}
+	/*
+	 * We have finished with this index block without success. Check for the
+	 * presence of a child node and if not present return with errno ENOENT,
+	 * otherwise we will keep searching in another index block.
+	 */
+	if (!(ie->flags & INDEX_ENTRY_NODE)) {
+		ntfs_debug("Index entry wasn't found.\n");
+		*ie_out = ie;
+		return -ENOENT;
+	}
+
+	/* Get the starting vcn of the index_block holding the child node. */
+	*vcn = ntfs_ie_get_vcn(ie);
+	if (*vcn < 0) {
+		ntfs_error(icx->idx_ni->vol->sb, "Negative vcn in inode %llu\n",
+				(unsigned long long)icx->idx_ni->mft_no);
+		return -EINVAL;
+	}
+
+	ntfs_debug("Parent entry number %d\n", item);
+	icx->parent_pos[icx->pindex] = item;
+
+	return -EAGAIN;
+}
+
+struct ntfs_inode *ntfs_ia_open(struct ntfs_index_context *icx, struct ntfs_inode *ni)
+{
+	struct inode *ia_vi;
+
+	ia_vi = ntfs_index_iget(VFS_I(ni), icx->name, icx->name_len);
+	if (IS_ERR(ia_vi)) {
+		ntfs_error(icx->idx_ni->vol->sb,
+				"Failed to open index allocation of inode %llu",
+				(unsigned long long)ni->mft_no);
+		return NULL;
+	}
+
+	return NTFS_I(ia_vi);
+}
+
+static int ntfs_ib_read(struct ntfs_index_context *icx, s64 vcn, struct index_block *dst)
+{
+	s64 pos, ret;
+
+	ntfs_debug("vcn: %lld\n", vcn);
+
+	pos = ntfs_ib_vcn_to_pos(icx, vcn);
+
+	ret = ntfs_inode_attr_pread(VFS_I(icx->ia_ni), pos, icx->block_size, (u8 *)dst);
+	if (ret != icx->block_size) {
+		if (ret == -1)
+			ntfs_error(icx->idx_ni->vol->sb, "Failed to read index block");
+		else
+			ntfs_error(icx->idx_ni->vol->sb,
+				"Failed to read full index block at %lld\n", pos);
+		return -1;
+	}
+
+	post_read_mst_fixup((struct ntfs_record *)((u8 *)dst), icx->block_size);
+	if (ntfs_index_block_inconsistent(icx, dst, vcn))
+		return -1;
+
+	return 0;
+}
+
+static int ntfs_icx_parent_inc(struct ntfs_index_context *icx)
+{
+	icx->pindex++;
+	if (icx->pindex >= MAX_PARENT_VCN) {
+		ntfs_error(icx->idx_ni->vol->sb, "Index is over %d level deep", MAX_PARENT_VCN);
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int ntfs_icx_parent_dec(struct ntfs_index_context *icx)
+{
+	icx->pindex--;
+	if (icx->pindex < 0) {
+		ntfs_error(icx->idx_ni->vol->sb, "Corrupt index pointer (%d)", icx->pindex);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/**
+ * ntfs_index_lookup - find a key in an index and return its index entry
+ * @key:	key for which to search in the index
+ * @key_len:	length of @key in bytes
+ * @icx:	context describing the index and the returned entry
+ *
+ * Before calling ntfs_index_lookup(), @icx must have been obtained from a
+ * call to ntfs_index_ctx_get().
+ *
+ * Look for the @key in the index specified by the index lookup context @icx.
+ * ntfs_index_lookup() walks the contents of the index looking for the @key.
+ *
+ * If the @key is found in the index, 0 is returned and @icx is setup to
+ * describe the index entry containing the matching @key.  @icx->entry is the
+ * index entry and @icx->data and @icx->data_len are the index entry data and
+ * its length in bytes, respectively.
+ *
+ * If the @key is not found in the index, -ENOENT is returned and
+ * @icx is setup to describe the index entry whose key collates immediately
+ * after the search @key, i.e. this is the position in the index at which
+ * an index entry with a key of @key would need to be inserted.
+ *
+ * When finished with the entry and its data, call ntfs_index_ctx_put() to free
+ * the context and other associated resources.
+ *
+ * If the index entry was modified, call ntfs_index_entry_mark_dirty() before
+ * the call to ntfs_index_ctx_put() to ensure that the changes are written
+ * to disk.
+ */
+int ntfs_index_lookup(const void *key, const int key_len, struct ntfs_index_context *icx)
+{
+	s64 old_vcn, vcn;
+	struct ntfs_inode *ni = icx->idx_ni;
+	struct super_block *sb = ni->vol->sb;
+	struct index_root *ir;
+	struct index_entry *ie;
+	struct index_block *ib = NULL;
+	int err = 0;
+
+	ntfs_debug("Entering\n");
+
+	if (!key || key_len <= 0) {
+		ntfs_error(sb, "key: %p  key_len: %d", key, key_len);
+		return -EINVAL;
+	}
+
+	ir = ntfs_ir_lookup(ni, icx->name, icx->name_len, &icx->actx);
+	if (!ir)
+		return -EIO;
+
+	icx->block_size = le32_to_cpu(ir->index_block_size);
+	if (icx->block_size < NTFS_BLOCK_SIZE) {
+		err = -EINVAL;
+		ntfs_error(sb,
+			"Index block size (%d) is smaller than the sector size (%d)",
+			icx->block_size, NTFS_BLOCK_SIZE);
+		goto err_out;
+	}
+
+	if (ni->vol->cluster_size <= icx->block_size)
+		icx->vcn_size_bits = ni->vol->cluster_size_bits;
+	else
+		icx->vcn_size_bits = ni->vol->sector_size_bits;
+
+	icx->cr = ir->collation_rule;
+	if (!ntfs_is_collation_rule_supported(icx->cr)) {
+		err = -EOPNOTSUPP;
+		ntfs_error(sb, "Unknown collation rule 0x%x",
+				(unsigned int)le32_to_cpu(icx->cr));
+		goto err_out;
+	}
+
+	old_vcn = VCN_INDEX_ROOT_PARENT;
+	err = ntfs_ie_lookup(key, key_len, icx, &ir->index, &vcn, &ie);
+	if (err == -ERANGE || err == -EINVAL)
+		goto err_out;
+
+	icx->ir = ir;
+	if (err != -EAGAIN) {
+		icx->is_in_root = true;
+		icx->parent_vcn[icx->pindex] = old_vcn;
+		goto done;
+	}
+
+	/* Child node present, descend into it. */
+	icx->ia_ni = ntfs_ia_open(icx, ni);
+	if (!icx->ia_ni) {
+		err = -ENOENT;
+		goto err_out;
+	}
+
+	ib = ntfs_malloc_nofs(icx->block_size);
+	if (!ib) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+descend_into_child_node:
+	icx->parent_vcn[icx->pindex] = old_vcn;
+	if (ntfs_icx_parent_inc(icx)) {
+		err = -EIO;
+		goto err_out;
+	}
+	old_vcn = vcn;
+
+	ntfs_debug("Descend into node with s64 %lld.\n", vcn);
+
+	if (ntfs_ib_read(icx, vcn, ib)) {
+		err = -EIO;
+		goto err_out;
+	}
+	err = ntfs_ie_lookup(key, key_len, icx, &ib->index, &vcn, &ie);
+	if (err != -EAGAIN) {
+		if (err == -EINVAL || err == -ERANGE)
+			goto err_out;
+
+		icx->is_in_root = false;
+		icx->ib = ib;
+		icx->parent_vcn[icx->pindex] = vcn;
+		goto done;
+	}
+
+	if ((ib->index.flags & NODE_MASK) == LEAF_NODE) {
+		ntfs_error(icx->idx_ni->vol->sb,
+			"Index entry with child node found in a leaf node in inode 0x%llx.\n",
+			(unsigned long long)ni->mft_no);
+		goto err_out;
+	}
+
+	goto descend_into_child_node;
+err_out:
+	if (icx->actx) {
+		ntfs_attr_put_search_ctx(icx->actx);
+		icx->actx = NULL;
+	}
+	ntfs_free(ib);
+	if (!err)
+		err = -EIO;
+	return err;
+done:
+	icx->entry = ie;
+	icx->data = (u8 *)ie + offsetof(struct index_entry, key);
+	icx->data_len = le16_to_cpu(ie->key_length);
+	ntfs_debug("Done.\n");
+	return err;
+
+}
+
+static struct index_block *ntfs_ib_alloc(s64 ib_vcn, u32 ib_size,
+		u8 node_type)
+{
+	struct index_block *ib;
+	int ih_size = sizeof(struct index_header);
+
+	ntfs_debug("Entering ib_vcn = %lld ib_size = %u\n", ib_vcn, ib_size);
+
+	ib = ntfs_malloc_nofs(ib_size);
+	if (!ib)
+		return NULL;
+
+	ib->magic = magic_INDX;
+	ib->usa_ofs = cpu_to_le16(sizeof(struct index_block));
+	ib->usa_count = cpu_to_le16(ib_size / NTFS_BLOCK_SIZE + 1);
+	/* Set USN to 1 */
+	*(__le16 *)((char *)ib + le16_to_cpu(ib->usa_ofs)) = cpu_to_le16(1);
+	ib->lsn = 0;
+	ib->index_block_vcn = cpu_to_le64(ib_vcn);
+	ib->index.entries_offset = cpu_to_le32((ih_size +
+				le16_to_cpu(ib->usa_count) * 2 + 7) & ~7);
+	ib->index.index_length = 0;
+	ib->index.allocated_size = cpu_to_le32(ib_size -
+			(sizeof(struct index_block) - ih_size));
+	ib->index.flags = node_type;
+
+	return ib;
+}
+
+/**
+ *  Find the median by going through all the entries
+ */
+static struct index_entry *ntfs_ie_get_median(struct index_header *ih)
+{
+	struct index_entry *ie, *ie_start;
+	u8 *ie_end;
+	int i = 0, median;
+
+	ntfs_debug("Entering\n");
+
+	ie = ie_start = ntfs_ie_get_first(ih);
+	ie_end = (u8 *)ntfs_ie_get_end(ih);
+
+	while ((u8 *)ie < ie_end && !ntfs_ie_end(ie)) {
+		ie = ntfs_ie_get_next(ie);
+		i++;
+	}
+	/*
+	 * NOTE: this could be also the entry at the half of the index block.
+	 */
+	median = i / 2 - 1;
+
+	ntfs_debug("Entries: %d  median: %d\n", i, median);
+
+	for (i = 0, ie = ie_start; i <= median; i++)
+		ie = ntfs_ie_get_next(ie);
+
+	return ie;
+}
+
+static s64 ntfs_ibm_vcn_to_pos(struct ntfs_index_context *icx, s64 vcn)
+{
+	return ntfs_ib_vcn_to_pos(icx, vcn) / icx->block_size;
+}
+
+static s64 ntfs_ibm_pos_to_vcn(struct ntfs_index_context *icx, s64 pos)
+{
+	return ntfs_ib_pos_to_vcn(icx, pos * icx->block_size);
+}
+
+static int ntfs_ibm_add(struct ntfs_index_context *icx)
+{
+	u8 bmp[8];
+
+	ntfs_debug("Entering\n");
+
+	if (ntfs_attr_exist(icx->idx_ni, AT_BITMAP, icx->name, icx->name_len))
+		return 0;
+	/*
+	 * AT_BITMAP must be at least 8 bytes.
+	 */
+	memset(bmp, 0, sizeof(bmp));
+	if (ntfs_attr_add(icx->idx_ni, AT_BITMAP, icx->name, icx->name_len,
+				bmp, sizeof(bmp))) {
+		ntfs_error(icx->idx_ni->vol->sb, "Failed to add AT_BITMAP");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ntfs_ibm_modify(struct ntfs_index_context *icx, s64 vcn, int set)
+{
+	u8 byte;
+	u64 pos = (u64)ntfs_ibm_vcn_to_pos(icx, vcn);
+	u32 bpos = pos / 8;
+	u32 bit = 1 << (pos % 8);
+	struct ntfs_inode *bmp_ni;
+	struct inode *bmp_vi;
+	int ret = 0;
+
+	ntfs_debug("%s vcn: %lld\n", set ? "set" : "clear", vcn);
+
+	bmp_vi = ntfs_attr_iget(VFS_I(icx->idx_ni), AT_BITMAP, icx->name, icx->name_len);
+	if (IS_ERR(bmp_vi)) {
+		ntfs_error(icx->idx_ni->vol->sb, "Failed to open $BITMAP attribute");
+		return PTR_ERR(bmp_vi);
+	}
+
+	bmp_ni = NTFS_I(bmp_vi);
+
+	if (set) {
+		if (bmp_ni->data_size < bpos + 1) {
+			ret = ntfs_attr_truncate(bmp_ni, (bmp_ni->data_size + 8) & ~7);
+			if (ret) {
+				ntfs_error(icx->idx_ni->vol->sb, "Failed to truncate AT_BITMAP");
+				goto err;
+			}
+			i_size_write(bmp_vi, (loff_t)bmp_ni->data_size);
+		}
+	}
+
+	if (ntfs_inode_attr_pread(bmp_vi, bpos, 1, &byte) != 1) {
+		ret = -EIO;
+		ntfs_error(icx->idx_ni->vol->sb, "Failed to read $BITMAP");
+		goto err;
+	}
+
+	if (set)
+		byte |= bit;
+	else
+		byte &= ~bit;
+
+	if (ntfs_inode_attr_pwrite(bmp_vi, bpos, 1, &byte, false) != 1) {
+		ret = -EIO;
+		ntfs_error(icx->idx_ni->vol->sb, "Failed to write $Bitmap");
+		goto err;
+	}
+
+err:
+	iput(bmp_vi);
+	return ret;
+}
+
+static int ntfs_ibm_set(struct ntfs_index_context *icx, s64 vcn)
+{
+	return ntfs_ibm_modify(icx, vcn, 1);
+}
+
+static int ntfs_ibm_clear(struct ntfs_index_context *icx, s64 vcn)
+{
+	return ntfs_ibm_modify(icx, vcn, 0);
+}
+
+static s64 ntfs_ibm_get_free(struct ntfs_index_context *icx)
+{
+	u8 *bm;
+	int bit;
+	s64 vcn, byte, size;
+
+	ntfs_debug("Entering\n");
+
+	bm = ntfs_attr_readall(icx->idx_ni, AT_BITMAP,  icx->name, icx->name_len,
+			&size);
+	if (!bm)
+		return (s64)-1;
+
+	for (byte = 0; byte < size; byte++) {
+		if (bm[byte] == 255)
+			continue;
+
+		for (bit = 0; bit < 8; bit++) {
+			if (!(bm[byte] & (1 << bit))) {
+				vcn = ntfs_ibm_pos_to_vcn(icx, byte * 8 + bit);
+				goto out;
+			}
+		}
+	}
+
+	vcn = ntfs_ibm_pos_to_vcn(icx, size * 8);
+out:
+	ntfs_debug("allocated vcn: %lld\n", vcn);
+
+	if (ntfs_ibm_set(icx, vcn))
+		vcn = (s64)-1;
+
+	ntfs_free(bm);
+	return vcn;
+}
+
+static struct index_block *ntfs_ir_to_ib(struct index_root *ir, s64 ib_vcn)
+{
+	struct index_block *ib;
+	struct index_entry *ie_last;
+	char *ies_start, *ies_end;
+	int i;
+
+	ntfs_debug("Entering\n");
+
+	ib = ntfs_ib_alloc(ib_vcn, le32_to_cpu(ir->index_block_size), LEAF_NODE);
+	if (!ib)
+		return NULL;
+
+	ies_start = (char *)ntfs_ie_get_first(&ir->index);
+	ies_end   = (char *)ntfs_ie_get_end(&ir->index);
+	ie_last   = ntfs_ie_get_last((struct index_entry *)ies_start, ies_end);
+	/*
+	 * Copy all entries, including the termination entry
+	 * as well, which can never have any data.
+	 */
+	i = (char *)ie_last - ies_start + le16_to_cpu(ie_last->length);
+	memcpy(ntfs_ie_get_first(&ib->index), ies_start, i);
+
+	ib->index.flags = ir->index.flags;
+	ib->index.index_length = cpu_to_le32(i +
+			le32_to_cpu(ib->index.entries_offset));
+	return ib;
+}
+
+static void ntfs_ir_nill(struct index_root *ir)
+{
+	struct index_entry *ie_last;
+	char *ies_start, *ies_end;
+
+	ntfs_debug("Entering\n");
+
+	ies_start = (char *)ntfs_ie_get_first(&ir->index);
+	ies_end   = (char *)ntfs_ie_get_end(&ir->index);
+	ie_last   = ntfs_ie_get_last((struct index_entry *)ies_start, ies_end);
+	/*
+	 * Move the index root termination entry forward
+	 */
+	if ((char *)ie_last > ies_start) {
+		memmove((char *)ntfs_ie_get_first(&ir->index),
+			(char *)ie_last, le16_to_cpu(ie_last->length));
+		ie_last = (struct index_entry *)ies_start;
+	}
+}
+
+static int ntfs_ib_copy_tail(struct ntfs_index_context *icx, struct index_block *src,
+		struct index_entry *median, s64 new_vcn)
+{
+	u8 *ies_end;
+	struct index_entry *ie_head;		/* first entry after the median */
+	int tail_size, ret;
+	struct index_block *dst;
+
+	ntfs_debug("Entering\n");
+
+	dst = ntfs_ib_alloc(new_vcn, icx->block_size,
+			src->index.flags & NODE_MASK);
+	if (!dst)
+		return -ENOMEM;
+
+	ie_head = ntfs_ie_get_next(median);
+
+	ies_end = (u8 *)ntfs_ie_get_end(&src->index);
+	tail_size = ies_end - (u8 *)ie_head;
+	memcpy(ntfs_ie_get_first(&dst->index), ie_head, tail_size);
+
+	dst->index.index_length = cpu_to_le32(tail_size +
+			le32_to_cpu(dst->index.entries_offset));
+	ret = ntfs_ib_write(icx, dst);
+
+	ntfs_free(dst);
+	return ret;
+}
+
+static int ntfs_ib_cut_tail(struct ntfs_index_context *icx, struct index_block *ib,
+		struct index_entry *ie)
+{
+	char *ies_start, *ies_end;
+	struct index_entry *ie_last;
+	int ret;
+
+	ntfs_debug("Entering\n");
+
+	ies_start = (char *)ntfs_ie_get_first(&ib->index);
+	ies_end   = (char *)ntfs_ie_get_end(&ib->index);
+
+	ie_last   = ntfs_ie_get_last((struct index_entry *)ies_start, ies_end);
+	if (ie_last->flags & INDEX_ENTRY_NODE)
+		ntfs_ie_set_vcn(ie_last, ntfs_ie_get_vcn(ie));
+
+	unsafe_memcpy(ie, ie_last, le16_to_cpu(ie_last->length),
+			/* alloc is larger than ie_last->length, see ntfs_ie_get_last() */);
+
+	ib->index.index_length = cpu_to_le32(((char *)ie - ies_start) +
+			le16_to_cpu(ie->length) + le32_to_cpu(ib->index.entries_offset));
+
+	ret = ntfs_ib_write(icx, ib);
+	return ret;
+}
+
+static int ntfs_ia_add(struct ntfs_index_context *icx)
+{
+	int ret;
+
+	ntfs_debug("Entering\n");
+
+	ret = ntfs_ibm_add(icx);
+	if (ret)
+		return ret;
+
+	if (!ntfs_attr_exist(icx->idx_ni, AT_INDEX_ALLOCATION, icx->name, icx->name_len)) {
+		ret = ntfs_attr_add(icx->idx_ni, AT_INDEX_ALLOCATION, icx->name,
+					icx->name_len, NULL, 0);
+		if (ret) {
+			ntfs_error(icx->idx_ni->vol->sb, "Failed to add AT_INDEX_ALLOCATION");
+			return ret;
+		}
+	}
+
+	icx->ia_ni = ntfs_ia_open(icx, icx->idx_ni);
+	if (!icx->ia_ni)
+		return -ENOENT;
+
+	return 0;
+}
+
+static int ntfs_ir_reparent(struct ntfs_index_context *icx)
+{
+	struct ntfs_attr_search_ctx *ctx = NULL;
+	struct index_root *ir;
+	struct index_entry *ie;
+	struct index_block *ib = NULL;
+	s64 new_ib_vcn;
+	int ix_root_size;
+	int ret = 0;
+
+	ntfs_debug("Entering\n");
+
+	ir = ntfs_ir_lookup2(icx->idx_ni, icx->name, icx->name_len);
+	if (!ir) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	if ((ir->index.flags & NODE_MASK) == SMALL_INDEX) {
+		ret = ntfs_ia_add(icx);
+		if (ret)
+			goto out;
+	}
+
+	new_ib_vcn = ntfs_ibm_get_free(icx);
+	if (new_ib_vcn < 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ir = ntfs_ir_lookup2(icx->idx_ni, icx->name, icx->name_len);
+	if (!ir) {
+		ret = -ENOENT;
+		goto clear_bmp;
+	}
+
+	ib = ntfs_ir_to_ib(ir, new_ib_vcn);
+	if (ib == NULL) {
+		ret = -EIO;
+		ntfs_error(icx->idx_ni->vol->sb, "Failed to move index root to index block");
+		goto clear_bmp;
+	}
+
+	ret = ntfs_ib_write(icx, ib);
+	if (ret)
+		goto clear_bmp;
+
+retry:
+	ir = ntfs_ir_lookup(icx->idx_ni, icx->name, icx->name_len, &ctx);
+	if (!ir) {
+		ret = -ENOENT;
+		goto clear_bmp;
+	}
+
+	ntfs_ir_nill(ir);
+
+	ie = ntfs_ie_get_first(&ir->index);
+	ie->flags |= INDEX_ENTRY_NODE;
+	ie->length = cpu_to_le16(sizeof(struct index_entry_header) + sizeof(s64));
+
+	ir->index.flags = LARGE_INDEX;
+	NInoSetIndexAllocPresent(icx->idx_ni);
+	ir->index.index_length = cpu_to_le32(le32_to_cpu(ir->index.entries_offset) +
+			le16_to_cpu(ie->length));
+	ir->index.allocated_size = ir->index.index_length;
+
+	ix_root_size = sizeof(struct index_root) - sizeof(struct index_header) +
+		le32_to_cpu(ir->index.allocated_size);
+	ret  = ntfs_resident_attr_value_resize(ctx->mrec, ctx->attr, ix_root_size);
+	if (ret) {
+		/*
+		 * When there is no space to build a non-resident
+		 * index, we may have to move the root to an extent
+		 */
+		if ((ret == -ENOSPC) && (ctx->al_entry || !ntfs_inode_add_attrlist(icx->idx_ni))) {
+			ntfs_attr_put_search_ctx(ctx);
+			ctx = NULL;
+			ir = ntfs_ir_lookup(icx->idx_ni, icx->name, icx->name_len, &ctx);
+			if (ir && !ntfs_attr_record_move_away(ctx, ix_root_size -
+					le32_to_cpu(ctx->attr->data.resident.value_length))) {
+				if (ntfs_attrlist_update(ctx->base_ntfs_ino ?
+							 ctx->base_ntfs_ino : ctx->ntfs_ino))
+					goto clear_bmp;
+				ntfs_attr_put_search_ctx(ctx);
+				ctx = NULL;
+				goto retry;
+			}
+		}
+		goto clear_bmp;
+	} else {
+		icx->idx_ni->data_size = icx->idx_ni->initialized_size = ix_root_size;
+		icx->idx_ni->allocated_size = (ix_root_size  + 7) & ~7;
+	}
+	ntfs_ie_set_vcn(ie, new_ib_vcn);
+
+err_out:
+	ntfs_free(ib);
+	if (ctx)
+		ntfs_attr_put_search_ctx(ctx);
+out:
+	return ret;
+clear_bmp:
+	ntfs_ibm_clear(icx, new_ib_vcn);
+	goto err_out;
+}
+
+/**
+ * ntfs_ir_truncate - Truncate index root attribute
+ */
+static int ntfs_ir_truncate(struct ntfs_index_context *icx, int data_size)
+{
+	int ret;
+
+	ntfs_debug("Entering\n");
+
+	/*
+	 *  INDEX_ROOT must be resident and its entries can be moved to
+	 *  struct index_block, so ENOSPC isn't a real error.
+	 */
+	ret = ntfs_attr_truncate(icx->idx_ni, data_size + offsetof(struct index_root, index));
+	if (!ret) {
+		i_size_write(VFS_I(icx->idx_ni), icx->idx_ni->initialized_size);
+		icx->ir = ntfs_ir_lookup2(icx->idx_ni, icx->name, icx->name_len);
+		if (!icx->ir)
+			return -ENOENT;
+
+		icx->ir->index.allocated_size = cpu_to_le32(data_size);
+	} else if (ret != -ENOSPC)
+		ntfs_error(icx->idx_ni->vol->sb, "Failed to truncate INDEX_ROOT");
+
+	return ret;
+}
+
+/**
+ * ntfs_ir_make_space - Make more space for the index root attribute
+ */
+static int ntfs_ir_make_space(struct ntfs_index_context *icx, int data_size)
+{
+	int ret;
+
+	ntfs_debug("Entering\n");
+
+	ret = ntfs_ir_truncate(icx, data_size);
+	if (ret == -ENOSPC) {
+		ret = ntfs_ir_reparent(icx);
+		if (!ret)
+			ret = -EAGAIN;
+		else
+			ntfs_error(icx->idx_ni->vol->sb, "Failed to modify INDEX_ROOT");
+	}
+
+	return ret;
+}
+
+/*
+ * NOTE: 'ie' must be a copy of a real index entry.
+ */
+static int ntfs_ie_add_vcn(struct index_entry **ie)
+{
+	struct index_entry *p, *old = *ie;
+
+	old->length = cpu_to_le16(le16_to_cpu(old->length) + sizeof(s64));
+	p = ntfs_realloc_nofs(old, le16_to_cpu(old->length),
+			le16_to_cpu(old->length) - sizeof(s64));
+	if (!p)
+		return -ENOMEM;
+
+	p->flags |= INDEX_ENTRY_NODE;
+	*ie = p;
+	return 0;
+}
+
+static int ntfs_ih_insert(struct index_header *ih, struct index_entry *orig_ie, s64 new_vcn,
+		int pos)
+{
+	struct index_entry *ie_node, *ie;
+	int ret = 0;
+	s64 old_vcn;
+
+	ntfs_debug("Entering\n");
+	ie = ntfs_ie_dup(orig_ie);
+	if (!ie)
+		return -ENOMEM;
+
+	if (!(ie->flags & INDEX_ENTRY_NODE)) {
+		ret = ntfs_ie_add_vcn(&ie);
+		if (ret)
+			goto out;
+	}
+
+	ie_node = ntfs_ie_get_by_pos(ih, pos);
+	old_vcn = ntfs_ie_get_vcn(ie_node);
+	ntfs_ie_set_vcn(ie_node, new_vcn);
+
+	ntfs_ie_insert(ih, ie, ie_node);
+	ntfs_ie_set_vcn(ie_node, old_vcn);
+out:
+	ntfs_free(ie);
+	return ret;
+}
+
+static s64 ntfs_icx_parent_vcn(struct ntfs_index_context *icx)
+{
+	return icx->parent_vcn[icx->pindex];
+}
+
+static s64 ntfs_icx_parent_pos(struct ntfs_index_context *icx)
+{
+	return icx->parent_pos[icx->pindex];
+}
+
+static int ntfs_ir_insert_median(struct ntfs_index_context *icx, struct index_entry *median,
+		s64 new_vcn)
+{
+	u32 new_size;
+	int ret;
+
+	ntfs_debug("Entering\n");
+
+	icx->ir = ntfs_ir_lookup2(icx->idx_ni, icx->name, icx->name_len);
+	if (!icx->ir)
+		return -ENOENT;
+
+	new_size = le32_to_cpu(icx->ir->index.index_length) +
+		le16_to_cpu(median->length);
+	if (!(median->flags & INDEX_ENTRY_NODE))
+		new_size += sizeof(s64);
+
+	ret = ntfs_ir_make_space(icx, new_size);
+	if (ret)
+		return ret;
+
+	icx->ir = ntfs_ir_lookup2(icx->idx_ni, icx->name, icx->name_len);
+	if (!icx->ir)
+		return -ENOENT;
+
+	return ntfs_ih_insert(&icx->ir->index, median, new_vcn,
+			ntfs_icx_parent_pos(icx));
+}
+
+static int ntfs_ib_split(struct ntfs_index_context *icx, struct index_block *ib);
+
+struct split_info {
+	struct list_head entry;
+	s64 new_vcn;
+	struct index_block *ib;
+};
+
+static int ntfs_ib_insert(struct ntfs_index_context *icx, struct index_entry *ie, s64 new_vcn,
+		struct split_info *si)
+{
+	struct index_block *ib;
+	u32 idx_size, allocated_size;
+	int err;
+	s64 old_vcn;
+
+	ntfs_debug("Entering\n");
+
+	ib = ntfs_malloc_nofs(icx->block_size);
+	if (!ib)
+		return -ENOMEM;
+
+	old_vcn = ntfs_icx_parent_vcn(icx);
+
+	err = ntfs_ib_read(icx, old_vcn, ib);
+	if (err)
+		goto err_out;
+
+	idx_size = le32_to_cpu(ib->index.index_length);
+	allocated_size = le32_to_cpu(ib->index.allocated_size);
+	if (idx_size + le16_to_cpu(ie->length) + sizeof(s64) > allocated_size) {
+		si->ib = ib;
+		si->new_vcn = new_vcn;
+		return -EAGAIN;
+	}
+
+	err = ntfs_ih_insert(&ib->index, ie, new_vcn, ntfs_icx_parent_pos(icx));
+	if (err)
+		goto err_out;
+
+	err = ntfs_ib_write(icx, ib);
+
+err_out:
+	ntfs_free(ib);
+	return err;
+}
+
+/**
+ * ntfs_ib_split - Split an index block
+ */
+static int ntfs_ib_split(struct ntfs_index_context *icx, struct index_block *ib)
+{
+	struct index_entry *median;
+	s64 new_vcn;
+	int ret;
+	struct split_info *si;
+	LIST_HEAD(ntfs_cut_tail_list);
+
+	ntfs_debug("Entering\n");
+
+resplit:
+	ret = ntfs_icx_parent_dec(icx);
+	if (ret)
+		goto out;
+
+	median  = ntfs_ie_get_median(&ib->index);
+	new_vcn = ntfs_ibm_get_free(icx);
+	if (new_vcn < 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = ntfs_ib_copy_tail(icx, ib, median, new_vcn);
+	if (ret) {
+		ntfs_ibm_clear(icx, new_vcn);
+		goto out;
+	}
+
+	if (ntfs_icx_parent_vcn(icx) == VCN_INDEX_ROOT_PARENT) {
+		ret = ntfs_ir_insert_median(icx, median, new_vcn);
+		if (ret) {
+			ntfs_ibm_clear(icx, new_vcn);
+			goto out;
+		}
+	} else {
+		si = kzalloc(sizeof(struct split_info), GFP_NOFS);
+		if (!si) {
+			ntfs_ibm_clear(icx, new_vcn);
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ret = ntfs_ib_insert(icx, median, new_vcn, si);
+		if (ret == -EAGAIN) {
+			list_add_tail(&si->entry, &ntfs_cut_tail_list);
+			ib = si->ib;
+			goto resplit;
+		} else if (ret) {
+			ntfs_free(si->ib);
+			kfree(si);
+			ntfs_ibm_clear(icx, new_vcn);
+			goto out;
+		}
+		kfree(si);
+	}
+
+	ret = ntfs_ib_cut_tail(icx, ib, median);
+
+out:
+	while (!list_empty(&ntfs_cut_tail_list)) {
+		si = list_last_entry(&ntfs_cut_tail_list, struct split_info, entry);
+		ntfs_ibm_clear(icx, si->new_vcn);
+		ntfs_free(si->ib);
+		list_del(&si->entry);
+		kfree(si);
+		if (!ret)
+			ret = -EAGAIN;
+	}
+
+	return ret;
+}
+
+int ntfs_ie_add(struct ntfs_index_context *icx, struct index_entry *ie)
+{
+	struct index_header *ih;
+	int allocated_size, new_size;
+	int ret;
+
+	while (1) {
+		ret = ntfs_index_lookup(&ie->key, le16_to_cpu(ie->key_length), icx);
+		if (!ret) {
+			ret = -EEXIST;
+			ntfs_error(icx->idx_ni->vol->sb, "Index already have such entry");
+			goto err_out;
+		}
+		if (ret != -ENOENT) {
+			ntfs_error(icx->idx_ni->vol->sb, "Failed to find place for new entry");
+			goto err_out;
+		}
+		ret = 0;
+
+		if (icx->is_in_root)
+			ih = &icx->ir->index;
+		else
+			ih = &icx->ib->index;
+
+		allocated_size = le32_to_cpu(ih->allocated_size);
+		new_size = le32_to_cpu(ih->index_length) + le16_to_cpu(ie->length);
+
+		if (new_size <= allocated_size)
+			break;
+
+		ntfs_debug("index block sizes: allocated: %d  needed: %d\n",
+				allocated_size, new_size);
+
+		if (icx->is_in_root)
+			ret = ntfs_ir_make_space(icx, new_size);
+		else
+			ret = ntfs_ib_split(icx, icx->ib);
+		if (ret && ret != -EAGAIN)
+			goto err_out;
+
+		mark_mft_record_dirty(icx->actx->ntfs_ino);
+		ntfs_index_ctx_reinit(icx);
+	}
+
+	ntfs_ie_insert(ih, ie, icx->entry);
+	ntfs_index_entry_mark_dirty(icx);
+
+err_out:
+	ntfs_debug("%s\n", ret ? "Failed" : "Done");
+	return ret;
+}
+
+/**
+ * ntfs_index_add_filename - add filename to directory index
+ * @ni:		ntfs inode describing directory to which index add filename
+ * @fn:		FILE_NAME attribute to add
+ * @mref:	reference of the inode which @fn describes
+ */
+int ntfs_index_add_filename(struct ntfs_inode *ni, struct file_name_attr *fn, u64 mref)
+{
+	struct index_entry *ie;
+	struct ntfs_index_context *icx;
+	int fn_size, ie_size, err;
+
+	ntfs_debug("Entering\n");
+
+	if (!ni || !fn)
+		return -EINVAL;
+
+	fn_size = (fn->file_name_length * sizeof(__le16)) +
+		sizeof(struct file_name_attr);
+	ie_size = (sizeof(struct index_entry_header) + fn_size + 7) & ~7;
+
+	ie = ntfs_malloc_nofs(ie_size);
+	if (!ie)
+		return -ENOMEM;
+
+	ie->data.dir.indexed_file = cpu_to_le64(mref);
+	ie->length	 = cpu_to_le16(ie_size);
+	ie->key_length	 = cpu_to_le16(fn_size);
+
+	unsafe_memcpy(&ie->key, fn, fn_size,
+		      /* "fn_size" was correctly calculated above */);
+
+	icx = ntfs_index_ctx_get(ni, I30, 4);
+	if (!icx) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = ntfs_ie_add(icx, ie);
+	ntfs_index_ctx_put(icx);
+out:
+	ntfs_free(ie);
+	return err;
+}
+
+static int ntfs_ih_takeout(struct ntfs_index_context *icx, struct index_header *ih,
+		struct index_entry *ie, struct index_block *ib)
+{
+	struct index_entry *ie_roam;
+	int freed_space;
+	bool full;
+	int ret = 0;
+
+	ntfs_debug("Entering\n");
+
+	full = ih->index_length == ih->allocated_size;
+	ie_roam = ntfs_ie_dup_novcn(ie);
+	if (!ie_roam)
+		return -ENOMEM;
+
+	ntfs_ie_delete(ih, ie);
+
+	if (ntfs_icx_parent_vcn(icx) == VCN_INDEX_ROOT_PARENT) {
+		/*
+		 * Recover the space which may have been freed
+		 * while deleting an entry from root index
+		 */
+		freed_space = le32_to_cpu(ih->allocated_size) -
+			le32_to_cpu(ih->index_length);
+		if (full && (freed_space > 0) && !(freed_space & 7)) {
+			ntfs_ir_truncate(icx, le32_to_cpu(ih->index_length));
+			/* do nothing if truncation fails */
+		}
+
+		mark_mft_record_dirty(icx->actx->ntfs_ino);
+	} else {
+		ret = ntfs_ib_write(icx, ib);
+		if (ret)
+			goto out;
+	}
+
+	ntfs_index_ctx_reinit(icx);
+
+	ret = ntfs_ie_add(icx, ie_roam);
+out:
+	ntfs_free(ie_roam);
+	return ret;
+}
+
+/**
+ *  Used if an empty index block to be deleted has END entry as the parent
+ *  in the INDEX_ROOT which is the only one there.
+ */
+static void ntfs_ir_leafify(struct ntfs_index_context *icx, struct index_header *ih)
+{
+	struct index_entry *ie;
+
+	ntfs_debug("Entering\n");
+
+	ie = ntfs_ie_get_first(ih);
+	ie->flags &= ~INDEX_ENTRY_NODE;
+	ie->length = cpu_to_le16(le16_to_cpu(ie->length) - sizeof(s64));
+
+	ih->index_length = cpu_to_le32(le32_to_cpu(ih->index_length) - sizeof(s64));
+	ih->flags &= ~LARGE_INDEX;
+	NInoClearIndexAllocPresent(icx->idx_ni);
+
+	/* Not fatal error */
+	ntfs_ir_truncate(icx, le32_to_cpu(ih->index_length));
+}
+
+/**
+ *  Used if an empty index block to be deleted has END entry as the parent
+ *  in the INDEX_ROOT which is not the only one there.
+ */
+static int ntfs_ih_reparent_end(struct ntfs_index_context *icx, struct index_header *ih,
+		struct index_block *ib)
+{
+	struct index_entry *ie, *ie_prev;
+
+	ntfs_debug("Entering\n");
+
+	ie = ntfs_ie_get_by_pos(ih, ntfs_icx_parent_pos(icx));
+	ie_prev = ntfs_ie_prev(ih, ie);
+	if (!ie_prev)
+		return -EIO;
+	ntfs_ie_set_vcn(ie, ntfs_ie_get_vcn(ie_prev));
+
+	return ntfs_ih_takeout(icx, ih, ie_prev, ib);
+}
+
+static int ntfs_index_rm_leaf(struct ntfs_index_context *icx)
+{
+	struct index_block *ib = NULL;
+	struct index_header *parent_ih;
+	struct index_entry *ie;
+	int ret;
+
+	ntfs_debug("pindex: %d\n", icx->pindex);
+
+	ret = ntfs_icx_parent_dec(icx);
+	if (ret)
+		return ret;
+
+	ret = ntfs_ibm_clear(icx, icx->parent_vcn[icx->pindex + 1]);
+	if (ret)
+		return ret;
+
+	if (ntfs_icx_parent_vcn(icx) == VCN_INDEX_ROOT_PARENT)
+		parent_ih = &icx->ir->index;
+	else {
+		ib = ntfs_malloc_nofs(icx->block_size);
+		if (!ib)
+			return -ENOMEM;
+
+		ret = ntfs_ib_read(icx, ntfs_icx_parent_vcn(icx), ib);
+		if (ret)
+			goto out;
+
+		parent_ih = &ib->index;
+	}
+
+	ie = ntfs_ie_get_by_pos(parent_ih, ntfs_icx_parent_pos(icx));
+	if (!ntfs_ie_end(ie)) {
+		ret = ntfs_ih_takeout(icx, parent_ih, ie, ib);
+		goto out;
+	}
+
+	if (ntfs_ih_zero_entry(parent_ih)) {
+		if (ntfs_icx_parent_vcn(icx) == VCN_INDEX_ROOT_PARENT) {
+			ntfs_ir_leafify(icx, parent_ih);
+			goto out;
+		}
+
+		ret = ntfs_index_rm_leaf(icx);
+		goto out;
+	}
+
+	ret = ntfs_ih_reparent_end(icx, parent_ih, ib);
+out:
+	ntfs_free(ib);
+	return ret;
+}
+
+static int ntfs_index_rm_node(struct ntfs_index_context *icx)
+{
+	int entry_pos, pindex;
+	s64 vcn;
+	struct index_block *ib = NULL;
+	struct index_entry *ie_succ, *ie, *entry = icx->entry;
+	struct index_header *ih;
+	u32 new_size;
+	int delta, ret;
+
+	ntfs_debug("Entering\n");
+
+	if (!icx->ia_ni) {
+		icx->ia_ni = ntfs_ia_open(icx, icx->idx_ni);
+		if (!icx->ia_ni)
+			return -EINVAL;
+	}
+
+	ib = ntfs_malloc_nofs(icx->block_size);
+	if (!ib)
+		return -ENOMEM;
+
+	ie_succ = ntfs_ie_get_next(icx->entry);
+	entry_pos = icx->parent_pos[icx->pindex]++;
+	pindex = icx->pindex;
+descend:
+	vcn = ntfs_ie_get_vcn(ie_succ);
+	ret = ntfs_ib_read(icx, vcn, ib);
+	if (ret)
+		goto out;
+
+	ie_succ = ntfs_ie_get_first(&ib->index);
+
+	ret = ntfs_icx_parent_inc(icx);
+	if (ret)
+		goto out;
+
+	icx->parent_vcn[icx->pindex] = vcn;
+	icx->parent_pos[icx->pindex] = 0;
+
+	if ((ib->index.flags & NODE_MASK) == INDEX_NODE)
+		goto descend;
+
+	if (ntfs_ih_zero_entry(&ib->index)) {
+		ret = -EIO;
+		ntfs_error(icx->idx_ni->vol->sb, "Empty index block");
+		goto out;
+	}
+
+	ie = ntfs_ie_dup(ie_succ);
+	if (!ie) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = ntfs_ie_add_vcn(&ie);
+	if (ret)
+		goto out2;
+
+	ntfs_ie_set_vcn(ie, ntfs_ie_get_vcn(icx->entry));
+
+	if (icx->is_in_root)
+		ih = &icx->ir->index;
+	else
+		ih = &icx->ib->index;
+
+	delta = le16_to_cpu(ie->length) - le16_to_cpu(icx->entry->length);
+	new_size = le32_to_cpu(ih->index_length) + delta;
+	if (delta > 0) {
+		if (icx->is_in_root) {
+			ret = ntfs_ir_make_space(icx, new_size);
+			if (ret != 0)
+				goto out2;
+
+			ih = &icx->ir->index;
+			entry = ntfs_ie_get_by_pos(ih, entry_pos);
+
+		} else if (new_size > le32_to_cpu(ih->allocated_size)) {
+			icx->pindex = pindex;
+			ret = ntfs_ib_split(icx, icx->ib);
+			if (!ret)
+				ret = -EAGAIN;
+			goto out2;
+		}
+	}
+
+	ntfs_ie_delete(ih, entry);
+	ntfs_ie_insert(ih, ie, entry);
+
+	if (icx->is_in_root)
+		ret = ntfs_ir_truncate(icx, new_size);
+	else
+		ret = ntfs_icx_ib_write(icx);
+	if (ret)
+		goto out2;
+
+	ntfs_ie_delete(&ib->index, ie_succ);
+
+	if (ntfs_ih_zero_entry(&ib->index))
+		ret = ntfs_index_rm_leaf(icx);
+	else
+		ret = ntfs_ib_write(icx, ib);
+
+out2:
+	ntfs_free(ie);
+out:
+	ntfs_free(ib);
+	return ret;
+}
+
+/**
+ * ntfs_index_rm - remove entry from the index
+ * @icx:	index context describing entry to delete
+ *
+ * Delete entry described by @icx from the index. Index context is always
+ * reinitialized after use of this function, so it can be used for index
+ * lookup once again.
+ */
+int ntfs_index_rm(struct ntfs_index_context *icx)
+{
+	struct index_header *ih;
+	int ret = 0;
+
+	ntfs_debug("Entering\n");
+
+	if (!icx || (!icx->ib && !icx->ir) || ntfs_ie_end(icx->entry)) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+	if (icx->is_in_root)
+		ih = &icx->ir->index;
+	else
+		ih = &icx->ib->index;
+
+	if (icx->entry->flags & INDEX_ENTRY_NODE) {
+		ret = ntfs_index_rm_node(icx);
+		if (ret)
+			goto err_out;
+	} else if (icx->is_in_root || !ntfs_ih_one_entry(ih)) {
+		ntfs_ie_delete(ih, icx->entry);
+
+		if (icx->is_in_root)
+			ret = ntfs_ir_truncate(icx, le32_to_cpu(ih->index_length));
+		else
+			ret = ntfs_icx_ib_write(icx);
+		if (ret)
+			goto err_out;
+	} else {
+		ret = ntfs_index_rm_leaf(icx);
+		if (ret)
+			goto err_out;
+	}
+
+	return 0;
+err_out:
+	return ret;
+}
+
+int ntfs_index_remove(struct ntfs_inode *dir_ni, const void *key, const int keylen)
+{
+	int ret = 0;
+	struct ntfs_index_context *icx;
+
+	icx = ntfs_index_ctx_get(dir_ni, I30, 4);
+	if (!icx)
+		return -EINVAL;
+
+	while (1) {
+		ret = ntfs_index_lookup(key, keylen, icx);
+		if (ret)
+			goto err_out;
+
+		ret = ntfs_index_rm(icx);
+		if (ret && ret != -EAGAIN)
+			goto err_out;
+		else if (!ret)
+			break;
+
+		mark_mft_record_dirty(icx->actx->ntfs_ino);
+		ntfs_index_ctx_reinit(icx);
+	}
+
+	mark_mft_record_dirty(icx->actx->ntfs_ino);
+
+	ntfs_index_ctx_put(icx);
+	return 0;
+err_out:
+	ntfs_index_ctx_put(icx);
+	ntfs_error(dir_ni->vol->sb, "Delete failed");
+	return ret;
+}
+
+/*
+ * ntfs_index_walk_down - walk down the index tree (leaf bound)
+ * until there are no subnode in the first index entry returns
+ * the entry at the bottom left in subnode
+ */
+struct index_entry *ntfs_index_walk_down(struct index_entry *ie, struct ntfs_index_context *ictx)
+{
+	struct index_entry *entry;
+	s64 vcn;
+
+	entry = ie;
+	do {
+		vcn = ntfs_ie_get_vcn(entry);
+		if (ictx->is_in_root) {
+			/* down from level zero */
+			ictx->ir = NULL;
+			ictx->ib = (struct index_block *)ntfs_malloc_nofs(ictx->block_size);
+			ictx->pindex = 1;
+			ictx->is_in_root = false;
+		} else {
+			/* down from non-zero level */
+			ictx->pindex++;
+		}
+
+		ictx->parent_pos[ictx->pindex] = 0;
+		ictx->parent_vcn[ictx->pindex] = vcn;
+		if (!ntfs_ib_read(ictx, vcn, ictx->ib)) {
+			ictx->entry = ntfs_ie_get_first(&ictx->ib->index);
+			entry = ictx->entry;
+		} else
+			entry = NULL;
+	} while (entry && (entry->flags & INDEX_ENTRY_NODE));
+
+	return entry;
+}
+
+/**
+ * ntfs_index_walk_up - walk up the index tree (root bound) until
+ * there is a valid data entry in parent returns the parent entry
+ * or NULL if no more parent.
+ */
+static struct index_entry *ntfs_index_walk_up(struct index_entry *ie,
+		struct ntfs_index_context *ictx)
+{
+	struct index_entry *entry;
+	s64 vcn;
+
+	entry = ie;
+	if (ictx->pindex > 0) {
+		do {
+			ictx->pindex--;
+			if (!ictx->pindex) {
+				/* we have reached the root */
+				kfree(ictx->ib);
+				ictx->ib = NULL;
+				ictx->is_in_root = true;
+				/* a new search context is to be allocated */
+				if (ictx->actx)
+					ntfs_attr_put_search_ctx(ictx->actx);
+				ictx->ir = ntfs_ir_lookup(ictx->idx_ni, ictx->name,
+						ictx->name_len, &ictx->actx);
+				if (ictx->ir)
+					entry = ntfs_ie_get_by_pos(&ictx->ir->index,
+							ictx->parent_pos[ictx->pindex]);
+				else
+					entry = NULL;
+			} else {
+					/* up into non-root node */
+				vcn = ictx->parent_vcn[ictx->pindex];
+				if (!ntfs_ib_read(ictx, vcn, ictx->ib)) {
+					entry = ntfs_ie_get_by_pos(&ictx->ib->index,
+							ictx->parent_pos[ictx->pindex]);
+				} else
+					entry = NULL;
+			}
+		ictx->entry = entry;
+		} while (entry && (ictx->pindex > 0) &&
+				(entry->flags & INDEX_ENTRY_END));
+	} else
+		entry = NULL;
+
+	return entry;
+}
+
+/**
+ * ntfs_index_next - get next entry in an index according to collating sequence.
+ * Returns next entry or NULL if none.
+ *
+ * Sample layout :
+ *
+ *                 +---+---+---+---+---+---+---+---+    n ptrs to subnodes
+ *                 |   |   | 10| 25| 33|   |   |   |    n-1 keys in between
+ *                 +---+---+---+---+---+---+---+---+    no key in last entry
+ *                              | A | A
+ *                              | | | +-------------------------------+
+ *   +--------------------------+ | +-----+                           |
+ *   |                            +--+    |                           |
+ *   V                               |    V                           |
+ * +---+---+---+---+---+---+---+---+ |  +---+---+---+---+---+---+---+---+
+ * | 11| 12| 13| 14| 15| 16| 17|   | |  | 26| 27| 28| 29| 30| 31| 32|   |
+ * +---+---+---+---+---+---+---+---+ |  +---+---+---+---+---+---+---+---+
+ *                               |   |
+ *       +-----------------------+   |
+ *       |                           |
+ *     +---+---+---+---+---+---+---+---+
+ *     | 18| 19| 20| 21| 22| 23| 24|   |
+ *     +---+---+---+---+---+---+---+---+
+ */
+struct index_entry *ntfs_index_next(struct index_entry *ie, struct ntfs_index_context *ictx)
+{
+	struct index_entry *next;
+	__le16 flags;
+
+	/*
+	 * lookup() may have returned an invalid node
+	 * when searching for a partial key
+	 * if this happens, walk up
+	 */
+	if (ie->flags & INDEX_ENTRY_END)
+		next = ntfs_index_walk_up(ie, ictx);
+	else {
+		/*
+		 * get next entry in same node
+		 * there is always one after any entry with data
+		 */
+		next = (struct index_entry *)((char *)ie + le16_to_cpu(ie->length));
+		++ictx->parent_pos[ictx->pindex];
+		flags = next->flags;
+
+		/* walk down if it has a subnode */
+		if (flags & INDEX_ENTRY_NODE) {
+			if (!ictx->ia_ni) {
+				ictx->ia_ni = ntfs_ia_open(ictx, ictx->idx_ni);
+				BUG_ON(!ictx->ia_ni);
+			}
+
+			next = ntfs_index_walk_down(next, ictx);
+		} else {
+
+			/* walk up it has no subnode, nor data */
+			if (flags & INDEX_ENTRY_END)
+				next = ntfs_index_walk_up(next, ictx);
+		}
+	}
+
+	/* return NULL if stuck at end of a block */
+	if (next && (next->flags & INDEX_ENTRY_END))
+		next = NULL;
+
+	return next;
+}
-- 
2.34.1


