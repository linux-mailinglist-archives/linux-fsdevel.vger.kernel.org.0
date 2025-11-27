Return-Path: <linux-fsdevel+bounces-69973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB57C8CD54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 06:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6EFE534F434
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 05:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7094330F929;
	Thu, 27 Nov 2025 05:01:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF532D837E
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764219679; cv=none; b=K+ixiPBzpcbbYlVZx9umSHsmWUrOWPer0sw2b19xGjCkIO3O1QKyqgn2EHo0wsGXwVyorCtPkfngk10QG/F0xjQtBn77cSSW6/gdP9HhE/y14SB7SpsT8Ht/pFAV0atuE5wriN4v7S7Pmzs9H09N/Li4mJEwDbIe0K1bxdAblnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764219679; c=relaxed/simple;
	bh=pI+On5GdqcEs5aHYmirxT5SGTUya+MorhDzdQz3HuVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ek1XF+/jayPdSjzEmtXy+jmxgQDEfzsKmIIY3iiuqqlfgeVLAh5Y53GvRrajV2JBZeWxvfcbviC7LBF/KLdXmy4sZm+RV8wOJo8FzldRNDcmku+czqs+gmZtuhhhXHcW8XYUcw4+NpadSs1xa5aZLUAMjFCILKKiRZW77dIqHaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-298456bb53aso6078615ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 21:01:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764219675; x=1764824475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mouh1zOCUbfadzpLEOEbIEAA0r6eO7W7vXcgNNx0w5Y=;
        b=eKiRo+oIVe/opDbIOSm/DDU2xm9zNldzRm3/JPY+nJi+9s2Zo9LqlgPTPO5nPSkssd
         bCFr4opHvMf95H8d4739FJF8TlS4oF9/uGar3BkjvotpxA9fcc4e5jdfcd9lo8Wngfji
         rhXv5st3W7XVB+zK5h5AKxmzOUsJI7A1plbIXQWdwBiCjROnQplMuB6guYjBqVio++u8
         AA3REy0gPcU01PIG9iBlaTC7Dx/y/aI8EMcIwiEPxALTbhw05VJYX5NmV4LPbcLB5VR9
         r0hFiBR4Pie7Ydmf6acSMVTVXeirwWfJ6Wmzl8+THCeOewPAbDIPh2oJLU8kgLV23mXR
         JeCA==
X-Gm-Message-State: AOJu0YxIwwbn7ijxdwkUnuOGsUmcx8Doiob4m8YFcHKjbPgQBil2Vv/A
	SlxAuIc6gwoTu73/KZeAfjkoDaX+LqMTTlkwmMFF4cTptcgCOrRjxcu2
X-Gm-Gg: ASbGncthtucxyEL1WZbdlZtFrWW8vT+3c71iFJk10d5IpqN1NI6K8adfq2w6HdYJEXO
	DWb6iNh3oVPoVBOnHs3onHBvb/iCS3eAZh30vW3KWgU8PdW1ewvzpvid6I8iOgmniU7HQ+w9lc3
	8O8u3ULiYgjdeWzpODS2pZj0Pz7VSJhd6qaVmgYPcb3DgRpulKMPH1Bw6pnGi/gfHZ5gpvsTD1j
	LKDeeEf7zlnDs54t71+l32u3fon2NiX3cSrga97b6Df4Arq3KCBiCuqfqAe0dp9kEyys00/UkHY
	VJYmgUbRUhDBZtdADGL8p9ujZ+bxZXYgMxjjX9cFBP/nq1nwr3nPBvWD2VFrPFM55rySbf1UImc
	IJejoGKPS7FNOwLHY3zzYGYog5gPubUy/4hCPeDAN1HvQTKnmFD2Mc/7551Hi/3hs5bnKGfwLDG
	vPOx6I5mhD4nUA6YP7271nHuQHWK/xbcPe8qoo
X-Google-Smtp-Source: AGHT+IHaGxRUrrwuK9dVchyFDrYPvs/urspVektlGChbF85OiYpnR3GGUFxa2CbABeDkrsltZQns+Q==
X-Received: by 2002:a17:903:1b2b:b0:298:43f4:cc49 with SMTP id d9443c01a7336-29b6c5225f0mr270246795ad.24.1764219675055;
        Wed, 26 Nov 2025 21:01:15 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb54454sm2719825ad.84.2025.11.26.21.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 21:01:14 -0800 (PST)
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
Subject: [PATCH v2 09/11] ntfsplus: add reparse and ea operations
Date: Thu, 27 Nov 2025 13:59:42 +0900
Message-Id: <20251127045944.26009-10-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251127045944.26009-1-linkinjeon@kernel.org>
References: <20251127045944.26009-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the implementation of reparse and ea operations for ntfsplus.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfsplus/ea.c      | 931 ++++++++++++++++++++++++++++++++++++++++++
 fs/ntfsplus/reparse.c | 550 +++++++++++++++++++++++++
 2 files changed, 1481 insertions(+)
 create mode 100644 fs/ntfsplus/ea.c
 create mode 100644 fs/ntfsplus/reparse.c

diff --git a/fs/ntfsplus/ea.c b/fs/ntfsplus/ea.c
new file mode 100644
index 000000000000..5658aa0e21ea
--- /dev/null
+++ b/fs/ntfsplus/ea.c
@@ -0,0 +1,931 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/**
+ * Pocessing of EA's
+ *
+ * Part of this file is based on code from the NTFS-3G project.
+ *
+ * Copyright (c) 2014-2021 Jean-Pierre Andre
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#include <linux/fs.h>
+#include <linux/posix_acl.h>
+#include <linux/posix_acl_xattr.h>
+#include <linux/xattr.h>
+
+#include "layout.h"
+#include "attrib.h"
+#include "index.h"
+#include "dir.h"
+#include "ea.h"
+#include "misc.h"
+
+static int ntfs_write_ea(struct ntfs_inode *ni, int type, char *value, s64 ea_off,
+		s64 ea_size, bool need_truncate)
+{
+	struct inode *ea_vi;
+	int err = 0;
+	s64 written;
+
+	ea_vi = ntfs_attr_iget(VFS_I(ni), type, AT_UNNAMED, 0);
+	if (IS_ERR(ea_vi))
+		return PTR_ERR(ea_vi);
+
+	written = ntfs_inode_attr_pwrite(ea_vi, ea_off, ea_size, value, false);
+	if (written != ea_size)
+		err = -EIO;
+	else {
+		struct ntfs_inode *ea_ni = NTFS_I(ea_vi);
+
+		if (need_truncate && ea_ni->data_size > ea_off + ea_size)
+			ntfs_attr_truncate(ea_ni, ea_off + ea_size);
+		mark_mft_record_dirty(ni);
+	}
+
+	iput(ea_vi);
+	return err;
+}
+
+static int ntfs_ea_lookup(char *ea_buf, s64 ea_buf_size, const char *name,
+		int name_len, s64 *ea_offset, s64 *ea_size)
+{
+	const struct ea_attr *p_ea;
+	s64 offset;
+	unsigned int next;
+
+	if (ea_buf_size < sizeof(struct ea_attr))
+		goto out;
+
+	offset = 0;
+	do {
+		p_ea = (const struct ea_attr *)&ea_buf[offset];
+		next = le32_to_cpu(p_ea->next_entry_offset);
+
+		if (offset + next > ea_buf_size ||
+		    ((1 + p_ea->ea_name_length) > (ea_buf_size - offset)))
+			break;
+
+		if (p_ea->ea_name_length == name_len &&
+		    !memcmp(p_ea->ea_name, name, name_len)) {
+			*ea_offset = offset;
+			if (next)
+				*ea_size = next;
+			else {
+				unsigned int ea_len = 1 + p_ea->ea_name_length +
+						le16_to_cpu(p_ea->ea_value_length);
+
+				if ((ea_buf_size - offset) < ea_len)
+					goto out;
+
+				*ea_size = ALIGN(struct_size(p_ea, ea_name,
+							1 + p_ea->ea_name_length +
+							le16_to_cpu(p_ea->ea_value_length)), 4);
+			}
+
+			if (ea_buf_size < *ea_offset + *ea_size)
+				goto out;
+
+			return 0;
+		}
+		offset += next;
+	} while (next > 0 && offset < ea_buf_size &&
+		 sizeof(struct ea_attr) < (ea_buf_size - offset));
+
+out:
+	return -ENOENT;
+}
+
+/*
+ * Return the existing EA
+ *
+ * The EA_INFORMATION is not examined and the consistency of the
+ * existing EA is not checked.
+ *
+ * If successful, the full attribute is returned unchanged
+ * and its size is returned.
+ * If the designated buffer is too small, the needed size is
+ * returned, and the buffer is left unchanged.
+ * If there is an error, a negative value is returned and errno
+ * is set according to the error.
+ */
+static int ntfs_get_ea(struct inode *inode, const char *name, size_t name_len,
+		void *buffer, size_t size)
+{
+	struct ntfs_inode *ni = NTFS_I(inode);
+	const struct ea_attr *p_ea;
+	char *ea_buf;
+	s64 ea_off, ea_size, all_ea_size, ea_info_size;
+	int err;
+	unsigned short int ea_value_len, ea_info_qlen;
+	struct ea_information *p_ea_info;
+
+	if (!NInoHasEA(ni))
+		return -ENODATA;
+
+	p_ea_info = ntfs_attr_readall(ni, AT_EA_INFORMATION, NULL, 0,
+			&ea_info_size);
+	if (!p_ea_info || ea_info_size != sizeof(struct ea_information)) {
+		ntfs_free(p_ea_info);
+		return -ENODATA;
+	}
+
+	ea_info_qlen = le16_to_cpu(p_ea_info->ea_query_length);
+	ntfs_free(p_ea_info);
+
+	ea_buf = ntfs_attr_readall(ni, AT_EA, NULL, 0, &all_ea_size);
+	if (!ea_buf)
+		return -ENODATA;
+
+	err = ntfs_ea_lookup(ea_buf, ea_info_qlen, name, name_len, &ea_off,
+			&ea_size);
+	if (!err) {
+		p_ea = (struct ea_attr *)&ea_buf[ea_off];
+		ea_value_len = le16_to_cpu(p_ea->ea_value_length);
+		if (!buffer) {
+			ntfs_free(ea_buf);
+			return ea_value_len;
+		}
+
+		if (ea_value_len > size) {
+			err = -ERANGE;
+			goto free_ea_buf;
+		}
+
+		memcpy(buffer, &p_ea->ea_name[p_ea->ea_name_length + 1],
+				ea_value_len);
+		ntfs_free(ea_buf);
+		return ea_value_len;
+	}
+
+	err = -ENODATA;
+free_ea_buf:
+	ntfs_free(ea_buf);
+	return err;
+}
+
+static inline int ea_packed_size(const struct ea_attr *p_ea)
+{
+	/*
+	 * 4 bytes for header (flags and lengths) + name length + 1 +
+	 * value length.
+	 */
+	return 5 + p_ea->ea_name_length + le16_to_cpu(p_ea->ea_value_length);
+}
+
+/*
+ * Set a new EA, and set EA_INFORMATION accordingly
+ *
+ * This is roughly the same as ZwSetEaFile() on Windows, however
+ * the "offset to next" of the last EA should not be cleared.
+ *
+ * Consistency of the new EA is first checked.
+ *
+ * EA_INFORMATION is set first, and it is restored to its former
+ * state if setting EA fails.
+ */
+static int ntfs_set_ea(struct inode *inode, const char *name, size_t name_len,
+		const void *value, size_t val_size, int flags,
+		__le16 *packed_ea_size)
+{
+	struct ntfs_inode *ni = NTFS_I(inode);
+	struct ea_information *p_ea_info = NULL;
+	int ea_packed, err = 0;
+	struct ea_attr *p_ea;
+	unsigned short int ea_info_qsize;
+	char *ea_buf = NULL;
+	size_t new_ea_size = ALIGN(struct_size(p_ea, ea_name, 1 + name_len + val_size), 4);
+	s64 ea_off, ea_info_size, all_ea_size, ea_size;
+
+	if (name_len > 255)
+		return -ENAMETOOLONG;
+
+	if (ntfs_attr_exist(ni, AT_EA_INFORMATION, AT_UNNAMED, 0)) {
+		p_ea_info = ntfs_attr_readall(ni, AT_EA_INFORMATION, NULL, 0,
+						&ea_info_size);
+		if (!p_ea_info || ea_info_size != sizeof(struct ea_information))
+			goto out;
+
+		ea_buf = ntfs_attr_readall(ni, AT_EA, NULL, 0, &all_ea_size);
+		if (!ea_buf) {
+			ea_info_qsize = 0;
+			ntfs_free(p_ea_info);
+			goto create_ea_info;
+		}
+
+		ea_info_qsize = le32_to_cpu(p_ea_info->ea_query_length);
+	} else {
+create_ea_info:
+		p_ea_info = ntfs_malloc_nofs(sizeof(struct ea_information));
+		if (!p_ea_info)
+			return -ENOMEM;
+
+		ea_info_qsize = 0;
+		err = ntfs_attr_add(ni, AT_EA_INFORMATION, AT_UNNAMED, 0,
+				(char *)p_ea_info, sizeof(struct ea_information));
+		if (err)
+			goto out;
+
+		if (ntfs_attr_exist(ni, AT_EA, AT_UNNAMED, 0)) {
+			err = ntfs_attr_remove(ni, AT_EA, AT_UNNAMED, 0);
+			if (err)
+				goto out;
+		}
+
+		goto alloc_new_ea;
+	}
+
+	if (ea_info_qsize > all_ea_size) {
+		err = -EIO;
+		goto out;
+	}
+
+	err = ntfs_ea_lookup(ea_buf, ea_info_qsize, name, name_len, &ea_off,
+			&ea_size);
+	if (ea_info_qsize && !err) {
+		if (flags & XATTR_CREATE) {
+			err = -EEXIST;
+			goto out;
+		}
+
+		p_ea = (struct ea_attr *)(ea_buf + ea_off);
+
+		if (val_size &&
+		    le16_to_cpu(p_ea->ea_value_length) == val_size &&
+		    !memcmp(p_ea->ea_name + p_ea->ea_name_length + 1, value,
+			    val_size))
+			goto out;
+
+		le16_add_cpu(&p_ea_info->ea_length, 0 - ea_packed_size(p_ea));
+
+		if (p_ea->flags & NEED_EA)
+			le16_add_cpu(&p_ea_info->need_ea_count, -1);
+
+		memmove((char *)p_ea, (char *)p_ea + ea_size, ea_info_qsize - (ea_off + ea_size));
+		ea_info_qsize -= ea_size;
+		p_ea_info->ea_query_length = cpu_to_le16(ea_info_qsize);
+
+		err = ntfs_write_ea(ni, AT_EA_INFORMATION, (char *)p_ea_info, 0,
+				sizeof(struct ea_information), false);
+		if (err)
+			goto out;
+
+		err = ntfs_write_ea(ni, AT_EA, ea_buf, 0, ea_info_qsize, true);
+		if (err)
+			goto out;
+
+		if ((flags & XATTR_REPLACE) && !val_size) {
+			/* Remove xattr. */
+			goto out;
+		}
+	} else {
+		if (flags & XATTR_REPLACE) {
+			err = -ENODATA;
+			goto out;
+		}
+	}
+	ntfs_free(ea_buf);
+
+alloc_new_ea:
+	ea_buf = kzalloc(new_ea_size, GFP_NOFS);
+	if (!ea_buf) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * EA and REPARSE_POINT compatibility not checked any more,
+	 * required by Windows 10, but having both may lead to
+	 * problems with earlier versions.
+	 */
+	p_ea = (struct ea_attr *)ea_buf;
+	memcpy(p_ea->ea_name, name, name_len);
+	p_ea->ea_name_length = name_len;
+	p_ea->ea_name[name_len] = 0;
+	memcpy(p_ea->ea_name + name_len + 1, value, val_size);
+	p_ea->ea_value_length = cpu_to_le16(val_size);
+	p_ea->next_entry_offset = cpu_to_le32(new_ea_size);
+
+	ea_packed = le16_to_cpu(p_ea_info->ea_length) + ea_packed_size(p_ea);
+	p_ea_info->ea_length = cpu_to_le16(ea_packed);
+	p_ea_info->ea_query_length = cpu_to_le32(ea_info_qsize + new_ea_size);
+
+	if (ea_packed > 0xffff ||
+	    ntfs_attr_size_bounds_check(ni->vol, AT_EA, new_ea_size)) {
+		err = -EFBIG;
+		goto out;
+	}
+
+	/*
+	 * no EA or EA_INFORMATION : add them
+	 */
+	if (!ntfs_attr_exist(ni, AT_EA, AT_UNNAMED, 0)) {
+		err = ntfs_attr_add(ni, AT_EA, AT_UNNAMED, 0, (char *)p_ea,
+				new_ea_size);
+		if (err)
+			goto out;
+	} else {
+		err = ntfs_write_ea(ni, AT_EA, (char *)p_ea, ea_info_qsize,
+				new_ea_size, false);
+		if (err)
+			goto out;
+	}
+
+	err = ntfs_write_ea(ni, AT_EA_INFORMATION, (char *)p_ea_info, 0,
+			sizeof(struct ea_information), false);
+	if (err)
+		goto out;
+
+	if (packed_ea_size)
+		*packed_ea_size = p_ea_info->ea_length;
+	mark_mft_record_dirty(ni);
+out:
+	if (ea_info_qsize > 0)
+		NInoSetHasEA(ni);
+	else
+		NInoClearHasEA(ni);
+
+	ntfs_free(ea_buf);
+	ntfs_free(p_ea_info);
+
+	return err;
+}
+
+/*
+ * Check for the presence of an EA "$LXDEV" (used by WSL)
+ * and return its value as a device address
+ */
+int ntfs_ea_get_wsl_inode(struct inode *inode, dev_t *rdevp, unsigned int flags)
+{
+	int err;
+	__le32 v;
+
+	if (!(flags & NTFS_VOL_UID)) {
+		/* Load uid to lxuid EA */
+		err = ntfs_get_ea(inode, "$LXUID", sizeof("$LXUID") - 1, &v,
+				sizeof(v));
+		if (err < 0)
+			return err;
+		i_uid_write(inode, le32_to_cpu(v));
+	}
+
+	if (!(flags & NTFS_VOL_UID)) {
+		/* Load gid to lxgid EA */
+		err = ntfs_get_ea(inode, "$LXGID", sizeof("$LXGID") - 1, &v,
+				sizeof(v));
+		if (err < 0)
+			return err;
+		i_gid_write(inode, le32_to_cpu(v));
+	}
+
+	/* Load mode to lxmod EA */
+	err = ntfs_get_ea(inode, "$LXMOD", sizeof("$LXMOD") - 1, &v, sizeof(v));
+	if (err > 0) {
+		inode->i_mode = le32_to_cpu(v);
+	} else {
+		/* Everyone gets all permissions. */
+		inode->i_mode |= 0777;
+	}
+
+	/* Load mode to lxdev EA */
+	err = ntfs_get_ea(inode, "$LXDEV", sizeof("$LXDEV") - 1, &v, sizeof(v));
+	if (err > 0)
+		*rdevp = le32_to_cpu(v);
+	err = 0;
+
+	return err;
+}
+
+int ntfs_ea_set_wsl_inode(struct inode *inode, dev_t rdev, __le16 *ea_size,
+		unsigned int flags)
+{
+	__le32 v;
+	int err;
+
+	if (flags & NTFS_EA_UID) {
+		/* Store uid to lxuid EA */
+		v = cpu_to_le32(i_uid_read(inode));
+		err = ntfs_set_ea(inode, "$LXUID", sizeof("$LXUID") - 1, &v,
+				sizeof(v), 0, ea_size);
+		if (err)
+			return err;
+	}
+
+	if (flags & NTFS_EA_GID) {
+		/* Store gid to lxgid EA */
+		v = cpu_to_le32(i_gid_read(inode));
+		err = ntfs_set_ea(inode, "$LXGID", sizeof("$LXGID") - 1, &v,
+				sizeof(v), 0, ea_size);
+		if (err)
+			return err;
+	}
+
+	if (flags & NTFS_EA_MODE) {
+		/* Store mode to lxmod EA */
+		v = cpu_to_le32(inode->i_mode);
+		err = ntfs_set_ea(inode, "$LXMOD", sizeof("$LXMOD") - 1, &v,
+				sizeof(v), 0, ea_size);
+		if (err)
+			return err;
+	}
+
+	if (rdev) {
+		v = cpu_to_le32(rdev);
+		err = ntfs_set_ea(inode, "$LXDEV", sizeof("$LXDEV") - 1, &v, sizeof(v),
+				0, ea_size);
+	}
+
+	return err;
+}
+
+ssize_t ntfsp_listxattr(struct dentry *dentry, char *buffer, size_t size)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ntfs_inode *ni = NTFS_I(inode);
+	const struct ea_attr *p_ea;
+	s64 offset, ea_buf_size, ea_info_size;
+	int next, err = 0, ea_size;
+	unsigned int ea_info_qsize;
+	char *ea_buf = NULL;
+	ssize_t ret = 0;
+	struct ea_information *ea_info;
+
+	if (!NInoHasEA(ni))
+		return 0;
+
+	mutex_lock(&NTFS_I(inode)->mrec_lock);
+	ea_info = ntfs_attr_readall(ni, AT_EA_INFORMATION, NULL, 0,
+			&ea_info_size);
+	if (!ea_info || ea_info_size != sizeof(struct ea_information))
+		goto out;
+
+	ea_info_qsize = le16_to_cpu(ea_info->ea_query_length);
+
+	ea_buf = ntfs_attr_readall(ni, AT_EA, NULL, 0, &ea_buf_size);
+	if (!ea_buf)
+		goto out;
+
+	if (ea_info_qsize > ea_buf_size)
+		goto out;
+
+	if (ea_buf_size < sizeof(struct ea_attr))
+		goto out;
+
+	offset = 0;
+	do {
+		p_ea = (const struct ea_attr *)&ea_buf[offset];
+		next = le32_to_cpu(p_ea->next_entry_offset);
+		if (next)
+			ea_size = next;
+		else
+			ea_size = ALIGN(struct_size(p_ea, ea_name,
+						1 + p_ea->ea_name_length +
+						le16_to_cpu(p_ea->ea_value_length)),
+					4);
+		if (buffer) {
+			if (offset + ea_size > ea_info_qsize)
+				break;
+
+			if (ret + p_ea->ea_name_length + 1 > size) {
+				err = -ERANGE;
+				goto out;
+			}
+
+			if (p_ea->ea_name_length + 1 > (ea_info_qsize - offset))
+				break;
+
+			memcpy(buffer + ret, p_ea->ea_name, p_ea->ea_name_length);
+			buffer[ret + p_ea->ea_name_length] = 0;
+		}
+
+		ret += p_ea->ea_name_length + 1;
+		offset += ea_size;
+	} while (next > 0 && offset < ea_info_qsize &&
+		 sizeof(struct ea_attr) < (ea_info_qsize - offset));
+
+out:
+	mutex_unlock(&NTFS_I(inode)->mrec_lock);
+	ntfs_free(ea_info);
+	ntfs_free(ea_buf);
+
+	return err ? err : ret;
+}
+
+// clang-format off
+#define SYSTEM_DOS_ATTRIB     "system.dos_attrib"
+#define SYSTEM_NTFS_ATTRIB    "system.ntfs_attrib"
+#define SYSTEM_NTFS_ATTRIB_BE "system.ntfs_attrib_be"
+// clang-format on
+
+static int ntfs_getxattr(const struct xattr_handler *handler,
+		struct dentry *unused, struct inode *inode, const char *name,
+		void *buffer, size_t size)
+{
+	struct ntfs_inode *ni = NTFS_I(inode);
+	int err;
+
+	if (NVolShutdown(ni->vol))
+		return -EIO;
+
+	if (!strcmp(name, SYSTEM_DOS_ATTRIB)) {
+		if (!buffer) {
+			err = sizeof(u8);
+		} else if (size < sizeof(u8)) {
+			err = -ENODATA;
+		} else {
+			err = sizeof(u8);
+			*(u8 *)buffer = ni->flags;
+		}
+		goto out;
+	}
+
+	if (!strcmp(name, SYSTEM_NTFS_ATTRIB) ||
+	    !strcmp(name, SYSTEM_NTFS_ATTRIB_BE)) {
+		if (!buffer) {
+			err = sizeof(u32);
+		} else if (size < sizeof(u32)) {
+			err = -ENODATA;
+		} else {
+			err = sizeof(u32);
+			*(u32 *)buffer = le32_to_cpu(ni->flags);
+			if (!strcmp(name, SYSTEM_NTFS_ATTRIB_BE))
+				*(__be32 *)buffer = cpu_to_be32(*(u32 *)buffer);
+		}
+		goto out;
+	}
+
+	mutex_lock(&ni->mrec_lock);
+	err = ntfs_get_ea(inode, name, strlen(name), buffer, size);
+	mutex_unlock(&ni->mrec_lock);
+
+out:
+	return err;
+}
+
+static int ntfs_new_attr_flags(struct ntfs_inode *ni, __le32 fattr)
+{
+	struct ntfs_attr_search_ctx *ctx;
+	struct mft_record *m;
+	struct attr_record *a;
+	__le16 new_aflags;
+	int mp_size, mp_ofs, name_ofs, arec_size, err;
+
+	m = map_mft_record(ni);
+	if (IS_ERR(m))
+		return PTR_ERR(m);
+
+	ctx = ntfs_attr_get_search_ctx(ni, m);
+	if (!ctx) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	err = ntfs_attr_lookup(ni->type, ni->name, ni->name_len,
+			CASE_SENSITIVE, 0, NULL, 0, ctx);
+	if (err) {
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	a = ctx->attr;
+	new_aflags = ctx->attr->flags;
+
+	if (fattr & FILE_ATTR_SPARSE_FILE)
+		new_aflags |= ATTR_IS_SPARSE;
+	else
+		new_aflags &= ~ATTR_IS_SPARSE;
+
+	if (fattr & FILE_ATTR_COMPRESSED)
+		new_aflags |= ATTR_IS_COMPRESSED;
+	else
+		new_aflags &= ~ATTR_IS_COMPRESSED;
+
+	if (new_aflags == a->flags)
+		return 0;
+
+	if ((new_aflags & (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED)) ==
+			  (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED)) {
+		pr_err("file can't be sparsed and compressed\n");
+		err = -EOPNOTSUPP;
+		goto err_out;
+	}
+
+	if (!a->non_resident)
+		goto out;
+
+	if (a->data.non_resident.data_size) {
+		pr_err("Can't change sparsed/compressed for non-empty file");
+		err = -EOPNOTSUPP;
+		goto err_out;
+	}
+
+	if (new_aflags & (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED))
+		name_ofs = (offsetof(struct attr_record,
+				     data.non_resident.compressed_size) +
+					sizeof(a->data.non_resident.compressed_size) + 7) & ~7;
+	else
+		name_ofs = (offsetof(struct attr_record,
+				     data.non_resident.compressed_size) + 7) & ~7;
+
+	mp_size = ntfs_get_size_for_mapping_pairs(ni->vol, ni->runlist.rl, 0, -1, -1);
+	if (unlikely(mp_size < 0)) {
+		err = mp_size;
+		ntfs_debug("Failed to get size for mapping pairs array, error code %i.\n", err);
+		goto err_out;
+	}
+
+	mp_ofs = (name_ofs + a->name_length * sizeof(__le16) + 7) & ~7;
+	arec_size = (mp_ofs + mp_size + 7) & ~7;
+
+	err = ntfs_attr_record_resize(m, a, arec_size);
+	if (unlikely(err))
+		goto err_out;
+
+	if (new_aflags & (ATTR_IS_SPARSE | ATTR_IS_COMPRESSED)) {
+		a->data.non_resident.compression_unit = 0;
+		if (new_aflags & ATTR_IS_COMPRESSED || ni->vol->major_ver < 3)
+			a->data.non_resident.compression_unit = 4;
+		a->data.non_resident.compressed_size = 0;
+		ni->itype.compressed.size = 0;
+		if (a->data.non_resident.compression_unit) {
+			ni->itype.compressed.block_size = 1U <<
+				(a->data.non_resident.compression_unit +
+				 ni->vol->cluster_size_bits);
+			ni->itype.compressed.block_size_bits =
+					ffs(ni->itype.compressed.block_size) -
+					1;
+			ni->itype.compressed.block_clusters = 1U <<
+					a->data.non_resident.compression_unit;
+		} else {
+			ni->itype.compressed.block_size = 0;
+			ni->itype.compressed.block_size_bits = 0;
+			ni->itype.compressed.block_clusters = 0;
+		}
+
+		if (new_aflags & ATTR_IS_SPARSE) {
+			NInoSetSparse(ni);
+			ni->flags |= FILE_ATTR_SPARSE_FILE;
+		}
+
+		if (new_aflags & ATTR_IS_COMPRESSED) {
+			NInoSetCompressed(ni);
+			ni->flags |= FILE_ATTR_COMPRESSED;
+			VFS_I(ni)->i_mapping->a_ops = &ntfs_compressed_aops;
+		}
+	} else {
+		ni->flags &= ~(FILE_ATTR_SPARSE_FILE | FILE_ATTR_COMPRESSED);
+		a->data.non_resident.compression_unit = 0;
+		VFS_I(ni)->i_mapping->a_ops = &ntfs_normal_aops;
+		NInoClearSparse(ni);
+		NInoClearCompressed(ni);
+	}
+
+	a->name_offset = cpu_to_le16(name_ofs);
+	a->data.non_resident.mapping_pairs_offset = cpu_to_le16(mp_ofs);
+
+out:
+	a->flags = new_aflags;
+	mark_mft_record_dirty(ctx->ntfs_ino);
+err_out:
+	ntfs_attr_put_search_ctx(ctx);
+	unmap_mft_record(ni);
+	return err;
+}
+
+static int ntfs_setxattr(const struct xattr_handler *handler,
+		struct mnt_idmap *idmap, struct dentry *unused,
+		struct inode *inode, const char *name, const void *value,
+		size_t size, int flags)
+{
+	struct ntfs_inode *ni = NTFS_I(inode);
+	int err;
+	__le32 fattr;
+
+	if (NVolShutdown(ni->vol))
+		return -EIO;
+
+	if (!strcmp(name, SYSTEM_DOS_ATTRIB)) {
+		if (sizeof(u8) != size)
+			goto out;
+		fattr = cpu_to_le32(*(u8 *)value);
+		goto set_fattr;
+	}
+
+	if (!strcmp(name, SYSTEM_NTFS_ATTRIB) ||
+	    !strcmp(name, SYSTEM_NTFS_ATTRIB_BE)) {
+		if (size != sizeof(u32))
+			goto out;
+		if (!strcmp(name, SYSTEM_NTFS_ATTRIB_BE))
+			fattr = cpu_to_le32(be32_to_cpu(*(__be32 *)value));
+		else
+			fattr = cpu_to_le32(*(u32 *)value);
+
+		if (S_ISREG(inode->i_mode)) {
+			mutex_lock(&ni->mrec_lock);
+			err = ntfs_new_attr_flags(ni, fattr);
+			mutex_unlock(&ni->mrec_lock);
+			if (err)
+				goto out;
+		}
+
+set_fattr:
+		if (S_ISDIR(inode->i_mode))
+			fattr |= FILE_ATTR_DIRECTORY;
+		else
+			fattr &= ~FILE_ATTR_DIRECTORY;
+
+		if (ni->flags != fattr) {
+			ni->flags = fattr;
+			if (fattr & FILE_ATTR_READONLY)
+				inode->i_mode &= ~0222;
+			else
+				inode->i_mode |= 0222;
+			NInoSetFileNameDirty(ni);
+			mark_inode_dirty(inode);
+		}
+		err = 0;
+		goto out;
+	}
+
+	mutex_lock(&ni->mrec_lock);
+	err = ntfs_set_ea(inode, name, strlen(name), value, size, flags, NULL);
+	mutex_unlock(&ni->mrec_lock);
+
+out:
+	inode_set_ctime_current(inode);
+	mark_inode_dirty(inode);
+	return err;
+}
+
+static bool ntfs_xattr_user_list(struct dentry *dentry)
+{
+	return true;
+}
+
+// clang-format off
+static const struct xattr_handler ntfs_other_xattr_handler = {
+	.prefix	= "",
+	.get	= ntfs_getxattr,
+	.set	= ntfs_setxattr,
+	.list	= ntfs_xattr_user_list,
+};
+
+const struct xattr_handler * const ntfsp_xattr_handlers[] = {
+	&ntfs_other_xattr_handler,
+	NULL,
+};
+// clang-format on
+
+#ifdef CONFIG_NTFSPLUS_FS_POSIX_ACL
+struct posix_acl *ntfsp_get_acl(struct mnt_idmap *idmap, struct dentry *dentry,
+			       int type)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ntfs_inode *ni = NTFS_I(inode);
+	const char *name;
+	size_t name_len;
+	struct posix_acl *acl;
+	int err;
+	void *buf;
+
+	/* Allocate PATH_MAX bytes. */
+	buf = __getname();
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	/* Possible values of 'type' was already checked above. */
+	if (type == ACL_TYPE_ACCESS) {
+		name = XATTR_NAME_POSIX_ACL_ACCESS;
+		name_len = sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1;
+	} else {
+		name = XATTR_NAME_POSIX_ACL_DEFAULT;
+		name_len = sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1;
+	}
+
+	mutex_lock(&ni->mrec_lock);
+	err = ntfs_get_ea(inode, name, name_len, buf, PATH_MAX);
+	mutex_unlock(&ni->mrec_lock);
+
+	/* Translate extended attribute to acl. */
+	if (err >= 0)
+		acl = posix_acl_from_xattr(&init_user_ns, buf, err);
+	else if (err == -ENODATA)
+		acl = NULL;
+	else
+		acl = ERR_PTR(err);
+
+	if (!IS_ERR(acl))
+		set_cached_acl(inode, type, acl);
+
+	__putname(buf);
+
+	return acl;
+}
+
+static noinline int ntfs_set_acl_ex(struct mnt_idmap *idmap,
+				    struct inode *inode, struct posix_acl *acl,
+				    int type, bool init_acl)
+{
+	const char *name;
+	size_t size, name_len;
+	void *value;
+	int err;
+	int flags;
+	umode_t mode;
+
+	if (S_ISLNK(inode->i_mode))
+		return -EOPNOTSUPP;
+
+	mode = inode->i_mode;
+	switch (type) {
+	case ACL_TYPE_ACCESS:
+		/* Do not change i_mode if we are in init_acl */
+		if (acl && !init_acl) {
+			err = posix_acl_update_mode(idmap, inode, &mode, &acl);
+			if (err)
+				return err;
+		}
+		name = XATTR_NAME_POSIX_ACL_ACCESS;
+		name_len = sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1;
+		break;
+
+	case ACL_TYPE_DEFAULT:
+		if (!S_ISDIR(inode->i_mode))
+			return acl ? -EACCES : 0;
+		name = XATTR_NAME_POSIX_ACL_DEFAULT;
+		name_len = sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (!acl) {
+		/* Remove xattr if it can be presented via mode. */
+		size = 0;
+		value = NULL;
+		flags = XATTR_REPLACE;
+	} else {
+		size = posix_acl_xattr_size(acl->a_count);
+		value = kmalloc(size, GFP_NOFS);
+		if (!value)
+			return -ENOMEM;
+		err = posix_acl_to_xattr(&init_user_ns, acl, value, size);
+		if (err < 0)
+			goto out;
+		flags = 0;
+	}
+
+	mutex_lock(&NTFS_I(inode)->mrec_lock);
+	err = ntfs_set_ea(inode, name, name_len, value, size, flags, NULL);
+	mutex_unlock(&NTFS_I(inode)->mrec_lock);
+	if (err == -ENODATA && !size)
+		err = 0; /* Removing non existed xattr. */
+	if (!err) {
+		set_cached_acl(inode, type, acl);
+		inode->i_mode = mode;
+		inode_set_ctime_current(inode);
+		mark_inode_dirty(inode);
+	}
+
+out:
+	kfree(value);
+
+	return err;
+}
+
+int ntfsp_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
+		 struct posix_acl *acl, int type)
+{
+	return ntfs_set_acl_ex(idmap, d_inode(dentry), acl, type, false);
+}
+
+int ntfsp_init_acl(struct mnt_idmap *idmap, struct inode *inode,
+		  struct inode *dir)
+{
+	struct posix_acl *default_acl, *acl;
+	int err;
+
+	err = posix_acl_create(dir, &inode->i_mode, &default_acl, &acl);
+	if (err)
+		return err;
+
+	if (default_acl) {
+		err = ntfs_set_acl_ex(idmap, inode, default_acl,
+				      ACL_TYPE_DEFAULT, true);
+		posix_acl_release(default_acl);
+	} else {
+		inode->i_default_acl = NULL;
+	}
+
+	if (acl) {
+		if (!err)
+			err = ntfs_set_acl_ex(idmap, inode, acl,
+					      ACL_TYPE_ACCESS, true);
+		posix_acl_release(acl);
+	} else {
+		inode->i_acl = NULL;
+	}
+
+	return err;
+}
+#endif
diff --git a/fs/ntfsplus/reparse.c b/fs/ntfsplus/reparse.c
new file mode 100644
index 000000000000..ff46ef07178a
--- /dev/null
+++ b/fs/ntfsplus/reparse.c
@@ -0,0 +1,550 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/**
+ * Processing of reparse points
+ *
+ * Part of this file is based on code from the NTFS-3G project.
+ *
+ * Copyright (c) 2008-2021 Jean-Pierre Andre
+ * Copyright (c) 2025 LG Electronics Co., Ltd.
+ */
+
+#include "ntfs.h"
+#include "layout.h"
+#include "attrib.h"
+#include "inode.h"
+#include "dir.h"
+#include "volume.h"
+#include "mft.h"
+#include "index.h"
+#include "lcnalloc.h"
+#include "reparse.h"
+#include "misc.h"
+
+struct WSL_LINK_REPARSE_DATA {
+	__le32	type;
+	char	link[];
+};
+
+struct REPARSE_INDEX {			/* index entry in $Extend/$Reparse */
+	struct index_entry_header header;
+	struct reparse_index_key key;
+	__le32 filling;
+};
+
+__le16 reparse_index_name[] = { cpu_to_le16('$'),
+				  cpu_to_le16('R') };
+
+/*
+ * Do some sanity checks on reparse data
+ *
+ * Microsoft reparse points have an 8-byte header whereas
+ * non-Microsoft reparse points have a 24-byte header.  In each case,
+ * 'reparse_data_length' must equal the number of non-header bytes.
+ *
+ * If the reparse data looks like a junction point or symbolic
+ * link, more checks can be done.
+ */
+static bool valid_reparse_data(struct ntfs_inode *ni,
+		const struct reparse_point *reparse_attr, size_t size)
+{
+	bool ok;
+	const struct WSL_LINK_REPARSE_DATA *wsl_reparse_data;
+
+	ok = ni && reparse_attr && (size >= sizeof(struct reparse_point)) &&
+		(reparse_attr->reparse_tag != IO_REPARSE_TAG_RESERVED_ZERO) &&
+		(((size_t)le16_to_cpu(reparse_attr->reparse_data_length) +
+		  sizeof(struct reparse_point) +
+		  ((reparse_attr->reparse_tag & IO_REPARSE_TAG_IS_MICROSOFT) ?
+		   0 : sizeof(struct guid))) == size);
+	if (ok) {
+		switch (reparse_attr->reparse_tag) {
+		case IO_REPARSE_TAG_LX_SYMLINK:
+			wsl_reparse_data = (const struct WSL_LINK_REPARSE_DATA *)
+						reparse_attr->reparse_data;
+			if ((le16_to_cpu(reparse_attr->reparse_data_length) <=
+			     sizeof(wsl_reparse_data->type)) ||
+			    (wsl_reparse_data->type != cpu_to_le32(2)))
+				ok = false;
+			break;
+		case IO_REPARSE_TAG_AF_UNIX:
+		case IO_REPARSE_TAG_LX_FIFO:
+		case IO_REPARSE_TAG_LX_CHR:
+		case IO_REPARSE_TAG_LX_BLK:
+			if (reparse_attr->reparse_data_length ||
+			    !(ni->flags & FILE_ATTRIBUTE_RECALL_ON_OPEN))
+				ok = false;
+			break;
+		default:
+			break;
+		}
+	}
+	return ok;
+}
+
+static unsigned int ntfs_reparse_tag_mode(struct reparse_point *reparse_attr)
+{
+	unsigned int mode = 0;
+
+	switch (reparse_attr->reparse_tag) {
+	case IO_REPARSE_TAG_SYMLINK:
+	case IO_REPARSE_TAG_LX_SYMLINK:
+		mode = S_IFLNK;
+		break;
+	case IO_REPARSE_TAG_AF_UNIX:
+		mode = S_IFSOCK;
+		break;
+	case IO_REPARSE_TAG_LX_FIFO:
+		mode = S_IFIFO;
+		break;
+	case IO_REPARSE_TAG_LX_CHR:
+		mode = S_IFCHR;
+		break;
+	case IO_REPARSE_TAG_LX_BLK:
+		mode = S_IFBLK;
+	}
+
+	return mode;
+}
+
+/*
+ * Get the target for symbolic link
+ */
+unsigned int ntfs_make_symlink(struct ntfs_inode *ni)
+{
+	s64 attr_size = 0;
+	unsigned int lth;
+	struct reparse_point *reparse_attr;
+	struct WSL_LINK_REPARSE_DATA *wsl_link_data;
+	unsigned int mode = 0;
+
+	reparse_attr = ntfs_attr_readall(ni, AT_REPARSE_POINT, NULL, 0,
+					 &attr_size);
+	if (reparse_attr && attr_size &&
+	    valid_reparse_data(ni, reparse_attr, attr_size)) {
+		switch (reparse_attr->reparse_tag) {
+		case IO_REPARSE_TAG_LX_SYMLINK:
+			wsl_link_data = (struct WSL_LINK_REPARSE_DATA *)reparse_attr->reparse_data;
+			if (wsl_link_data->type == cpu_to_le32(2)) {
+				lth = le16_to_cpu(reparse_attr->reparse_data_length) -
+						  sizeof(wsl_link_data->type);
+				ni->target = ntfs_malloc_nofs(lth + 1);
+				if (ni->target) {
+					memcpy(ni->target, wsl_link_data->link, lth);
+					ni->target[lth] = 0;
+					mode = ntfs_reparse_tag_mode(reparse_attr);
+				}
+			}
+			break;
+		default:
+			mode = ntfs_reparse_tag_mode(reparse_attr);
+		}
+	} else
+		ni->flags &= ~FILE_ATTR_REPARSE_POINT;
+
+	if (reparse_attr)
+		ntfs_free(reparse_attr);
+
+	return mode;
+}
+
+unsigned int ntfs_reparse_tag_dt_types(struct ntfs_volume *vol, unsigned long mref)
+{
+	s64 attr_size = 0;
+	struct reparse_point *reparse_attr;
+	unsigned int dt_type = DT_UNKNOWN;
+	struct inode *vi;
+
+	vi = ntfs_iget(vol->sb, mref);
+	if (IS_ERR(vi))
+		return PTR_ERR(vi);
+
+	reparse_attr = (struct reparse_point *)ntfs_attr_readall(NTFS_I(vi),
+			AT_REPARSE_POINT, NULL, 0, &attr_size);
+
+	if (reparse_attr && attr_size) {
+		switch (reparse_attr->reparse_tag) {
+		case IO_REPARSE_TAG_SYMLINK:
+		case IO_REPARSE_TAG_LX_SYMLINK:
+			dt_type = DT_LNK;
+			break;
+		case IO_REPARSE_TAG_AF_UNIX:
+			dt_type = DT_SOCK;
+			break;
+		case IO_REPARSE_TAG_LX_FIFO:
+			dt_type = DT_FIFO;
+			break;
+		case IO_REPARSE_TAG_LX_CHR:
+			dt_type = DT_CHR;
+			break;
+		case IO_REPARSE_TAG_LX_BLK:
+			dt_type = DT_BLK;
+		}
+	}
+
+	if (reparse_attr)
+		ntfs_free(reparse_attr);
+
+	iput(vi);
+	return dt_type;
+}
+
+/*
+ * Set the index for new reparse data
+ */
+static int set_reparse_index(struct ntfs_inode *ni, struct ntfs_index_context *xr,
+		__le32 reparse_tag)
+{
+	struct REPARSE_INDEX indx;
+	u64 file_id_cpu;
+	__le64 file_id;
+
+	file_id_cpu = MK_MREF(ni->mft_no, ni->seq_no);
+	file_id = cpu_to_le64(file_id_cpu);
+	indx.header.data.vi.data_offset =
+		cpu_to_le16(sizeof(struct index_entry_header) + sizeof(struct reparse_index_key));
+	indx.header.data.vi.data_length = 0;
+	indx.header.data.vi.reservedV = 0;
+	indx.header.length = cpu_to_le16(sizeof(struct REPARSE_INDEX));
+	indx.header.key_length = cpu_to_le16(sizeof(struct reparse_index_key));
+	indx.header.flags = 0;
+	indx.header.reserved = 0;
+	indx.key.reparse_tag = reparse_tag;
+	/* danger on processors which require proper alignment! */
+	memcpy(&indx.key.file_id, &file_id, 8);
+	indx.filling = 0;
+	ntfs_index_ctx_reinit(xr);
+
+	return ntfs_ie_add(xr, (struct index_entry *)&indx);
+}
+
+/*
+ * Remove a reparse data index entry if attribute present
+ */
+static int remove_reparse_index(struct inode *rp, struct ntfs_index_context *xr,
+				__le32 *preparse_tag)
+{
+	struct reparse_index_key key;
+	u64 file_id_cpu;
+	__le64 file_id;
+	s64 size;
+	struct ntfs_inode *ni = NTFS_I(rp);
+	int err = 0, ret = ni->data_size;
+
+	if (ni->data_size == 0)
+		return 0;
+
+	/* read the existing reparse_tag */
+	size = ntfs_inode_attr_pread(rp, 0, 4, (char *)preparse_tag);
+	if (size != 4)
+		return -ENODATA;
+
+	file_id_cpu = MK_MREF(ni->mft_no, ni->seq_no);
+	file_id = cpu_to_le64(file_id_cpu);
+	key.reparse_tag = *preparse_tag;
+	/* danger on processors which require proper alignment! */
+	memcpy(&key.file_id, &file_id, 8);
+	if (!ntfs_index_lookup(&key, sizeof(struct reparse_index_key), xr)) {
+		err = ntfs_index_rm(xr);
+		if (err)
+			ret = err;
+	}
+	return ret;
+}
+
+/*
+ * Open the $Extend/$Reparse file and its index
+ */
+static struct ntfs_index_context *open_reparse_index(struct ntfs_volume *vol)
+{
+	struct ntfs_index_context *xr = NULL;
+	u64 mref;
+	__le16 *uname;
+	struct ntfs_name *name = NULL;
+	int uname_len;
+	struct inode *vi, *dir_vi;
+
+	/* do not use path_name_to inode - could reopen root */
+	dir_vi = ntfs_iget(vol->sb, FILE_Extend);
+	if (IS_ERR(dir_vi))
+		return NULL;
+
+	uname_len = ntfs_nlstoucs(vol, "$Reparse", 8, &uname,
+				  NTFS_MAX_NAME_LEN);
+	if (uname_len < 0) {
+		iput(dir_vi);
+		return NULL;
+	}
+
+	mutex_lock_nested(&NTFS_I(dir_vi)->mrec_lock, NTFS_REPARSE_MUTEX_PARENT);
+	mref = ntfs_lookup_inode_by_name(NTFS_I(dir_vi), uname, uname_len,
+					 &name);
+	mutex_unlock(&NTFS_I(dir_vi)->mrec_lock);
+	kfree(name);
+	kmem_cache_free(ntfs_name_cache, uname);
+	if (IS_ERR_MREF(mref))
+		goto put_dir_vi;
+
+	vi = ntfs_iget(vol->sb, MREF(mref));
+	if (IS_ERR(vi))
+		goto put_dir_vi;
+
+	xr = ntfs_index_ctx_get(NTFS_I(vi), reparse_index_name, 2);
+	if (!xr)
+		iput(vi);
+put_dir_vi:
+	iput(dir_vi);
+	return xr;
+}
+
+
+/*
+ * Update the reparse data and index
+ *
+ * The reparse data attribute should have been created, and
+ * an existing index is expected if there is an existing value.
+ *
+ */
+static int update_reparse_data(struct ntfs_inode *ni, struct ntfs_index_context *xr,
+		char *value, size_t size)
+{
+	struct inode *rp_inode;
+	int err = 0;
+	s64 written;
+	int oldsize;
+	__le32 reparse_tag;
+	struct ntfs_inode *rp_ni;
+
+	rp_inode = ntfs_attr_iget(VFS_I(ni), AT_REPARSE_POINT, AT_UNNAMED, 0);
+	if (IS_ERR(rp_inode))
+		return -EINVAL;
+	rp_ni = NTFS_I(rp_inode);
+
+	/* remove the existing reparse data */
+	oldsize = remove_reparse_index(rp_inode, xr, &reparse_tag);
+	if (oldsize < 0) {
+		err = oldsize;
+		goto put_rp_inode;
+	}
+
+	/* overwrite value if any */
+	written = ntfs_inode_attr_pwrite(rp_inode, 0, size, value, false);
+	if (written != size) {
+		ntfs_error(ni->vol->sb, "Failed to update reparse data\n");
+		err = -EIO;
+		goto put_rp_inode;
+	}
+
+	if (set_reparse_index(ni, xr, ((const struct reparse_point *)value)->reparse_tag) &&
+	    oldsize > 0) {
+		/*
+		 * If cannot index, try to remove the reparse
+		 * data and log the error. There will be an
+		 * inconsistency if removal fails.
+		 */
+		ntfs_attr_rm(rp_ni);
+		ntfs_error(ni->vol->sb,
+			   "Failed to index reparse data. Possible corruption.\n");
+	}
+
+	mark_mft_record_dirty(ni);
+put_rp_inode:
+	iput(rp_inode);
+
+	return err;
+}
+
+/*
+ * Delete a reparse index entry
+ */
+int ntfs_delete_reparse_index(struct ntfs_inode *ni)
+{
+	struct inode *vi;
+	struct ntfs_index_context *xr;
+	struct ntfs_inode *xrni;
+	__le32 reparse_tag;
+	int err = 0;
+
+	if (!(ni->flags & FILE_ATTR_REPARSE_POINT))
+		return 0;
+
+	vi = ntfs_attr_iget(VFS_I(ni), AT_REPARSE_POINT, AT_UNNAMED, 0);
+	if (IS_ERR(vi))
+		return PTR_ERR(vi);
+
+	/*
+	 * read the existing reparse data (the tag is enough)
+	 * and un-index it
+	 */
+	xr = open_reparse_index(ni->vol);
+	if (xr) {
+		xrni = xr->idx_ni;
+		mutex_lock_nested(&xrni->mrec_lock, NTFS_REPARSE_MUTEX_PARENT);
+		err = remove_reparse_index(vi, xr, &reparse_tag);
+		if (err < 0) {
+			ntfs_index_ctx_put(xr);
+			mutex_unlock(&xrni->mrec_lock);
+			iput(VFS_I(xrni));
+			goto out;
+		}
+		mark_mft_record_dirty(xrni);
+		ntfs_index_ctx_put(xr);
+		mutex_unlock(&xrni->mrec_lock);
+		iput(VFS_I(xrni));
+	}
+
+	ni->flags &= ~FILE_ATTR_REPARSE_POINT;
+	NInoSetFileNameDirty(ni);
+	mark_mft_record_dirty(ni);
+
+out:
+	iput(vi);
+	return err;
+}
+
+/*
+ * Set the reparse data from an extended attribute
+ */
+static int ntfs_set_ntfs_reparse_data(struct ntfs_inode *ni, char *value, size_t size)
+{
+	int err = 0;
+	struct ntfs_inode *xrni;
+	struct ntfs_index_context *xr;
+
+	if (!ni)
+		return -EINVAL;
+
+	/*
+	 * reparse data compatibily with EA is not checked
+	 * any more, it is required by Windows 10, but may
+	 * lead to problems with earlier versions.
+	 */
+	if (valid_reparse_data(ni, (const struct reparse_point *)value, size) == false)
+		return -EINVAL;
+
+	xr = open_reparse_index(ni->vol);
+	if (!xr)
+		return -EINVAL;
+	xrni = xr->idx_ni;
+
+	if (!ntfs_attr_exist(ni, AT_REPARSE_POINT, AT_UNNAMED, 0)) {
+		u8 dummy = 0;
+
+		/*
+		 * no reparse data attribute : add one,
+		 * apparently, this does not feed the new value in
+		 * Note : NTFS version must be >= 3
+		 */
+		if (ni->vol->major_ver < 3) {
+			err = -EOPNOTSUPP;
+			ntfs_index_ctx_put(xr);
+			goto out;
+		}
+
+		err = ntfs_attr_add(ni, AT_REPARSE_POINT, AT_UNNAMED, 0, &dummy, 0);
+		if (err) {
+			ntfs_index_ctx_put(xr);
+			goto out;
+		}
+		ni->flags |= FILE_ATTR_REPARSE_POINT;
+		NInoSetFileNameDirty(ni);
+		mark_mft_record_dirty(ni);
+	}
+
+	/* update value and index */
+	mutex_lock_nested(&xrni->mrec_lock, NTFS_REPARSE_MUTEX_PARENT);
+	err = update_reparse_data(ni, xr, value, size);
+	if (err) {
+		ni->flags &= ~FILE_ATTR_REPARSE_POINT;
+		NInoSetFileNameDirty(ni);
+		mark_mft_record_dirty(ni);
+	}
+	ntfs_index_ctx_put(xr);
+	mutex_unlock(&xrni->mrec_lock);
+
+out:
+	if (!err)
+		mark_mft_record_dirty(xrni);
+	iput(VFS_I(xrni));
+
+	return err;
+}
+
+/*
+ * Set reparse data for a WSL type symlink
+ */
+int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *ni,
+		const __le16 *target, int target_len)
+{
+	int err = 0;
+	int len;
+	int reparse_len;
+	unsigned char *utarget = NULL;
+	struct reparse_point *reparse;
+	struct WSL_LINK_REPARSE_DATA *data;
+
+	utarget = (char *)NULL;
+	len = ntfs_ucstonls(ni->vol, target, target_len, &utarget, 0);
+	if (len <= 0)
+		return -EINVAL;
+
+	reparse_len = sizeof(struct reparse_point) + sizeof(data->type) + len;
+	reparse = (struct reparse_point *)ntfs_malloc_nofs(reparse_len);
+	if (!reparse) {
+		err = -ENOMEM;
+		ntfs_free(utarget);
+	} else {
+		data = (struct WSL_LINK_REPARSE_DATA *)reparse->reparse_data;
+		reparse->reparse_tag = IO_REPARSE_TAG_LX_SYMLINK;
+		reparse->reparse_data_length =
+			cpu_to_le16(sizeof(data->type) + len);
+		reparse->reserved = 0;
+		data->type = cpu_to_le32(2);
+		memcpy(data->link, utarget, len);
+		err = ntfs_set_ntfs_reparse_data(ni,
+				(char *)reparse, reparse_len);
+		ntfs_free(reparse);
+		if (!err)
+			ni->target = utarget;
+	}
+	return err;
+}
+
+/*
+ * Set reparse data for a WSL special file other than a symlink
+ * (socket, fifo, character or block device)
+ */
+int ntfs_reparse_set_wsl_not_symlink(struct ntfs_inode *ni, mode_t mode)
+{
+	int err;
+	int len;
+	int reparse_len;
+	__le32 reparse_tag;
+	struct reparse_point *reparse;
+
+	len = 0;
+	if (S_ISSOCK(mode))
+		reparse_tag = IO_REPARSE_TAG_AF_UNIX;
+	else if (S_ISFIFO(mode))
+		reparse_tag = IO_REPARSE_TAG_LX_FIFO;
+	else if (S_ISCHR(mode))
+		reparse_tag = IO_REPARSE_TAG_LX_CHR;
+	else if (S_ISBLK(mode))
+		reparse_tag = IO_REPARSE_TAG_LX_BLK;
+	else
+		return -EOPNOTSUPP;
+
+	reparse_len = sizeof(struct reparse_point) + len;
+	reparse = (struct reparse_point *)ntfs_malloc_nofs(reparse_len);
+	if (!reparse)
+		err = -ENOMEM;
+	else {
+		reparse->reparse_tag = reparse_tag;
+		reparse->reparse_data_length = cpu_to_le16(len);
+		reparse->reserved = cpu_to_le16(0);
+		err = ntfs_set_ntfs_reparse_data(ni, (char *)reparse,
+						 reparse_len);
+		ntfs_free(reparse);
+	}
+
+	return err;
+}
-- 
2.25.1


