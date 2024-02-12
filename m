Return-Path: <linux-fsdevel+bounces-11145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27679851A5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8291C222AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9C33E48E;
	Mon, 12 Feb 2024 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScUlzMcg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF123D565
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757199; cv=none; b=Pn0e2NGieSBOMvn3o4RrwP0nYjf74dSJZv90Puo07QFSfsFpDhzuLNtV4bxHv3Ng9/WJ0EGv3CVKC3JqeUeO3TPy+kCoxvyF/YblE4vbCnneFXgJW/OUfzgte1GgYOVOg9yxpxmXiCM2otCxzWYy2cysEzU5VH1QQbtpUdVBUKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757199; c=relaxed/simple;
	bh=9JqrbAfmSsH3ERdkRpC8IPSggMzVJkaaLqkB8F5T9EI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZB96LHhxYAjL05sQWv6QkLw64V5VWeOw6x4VNEflP+IQrayJ0x4Ae98WPaVyhf8/o9OSEGYyilXjm8vFJ+mxNObGvJtuvKpLsGirT41Jqam8mRHXgBurCJvcmOO/NKp4HZ1yXEBkFyNocys6QsgDbFsnGrxg0ELGj2FeuIxyBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ScUlzMcg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7qFP4poM8gEvIFjfXy0QwY6pOEwAMOFuQs9zumtA0Rw=;
	b=ScUlzMcguT3rRyhgE4UC+wb/I4+Y5eAcbZ6AoG7iML2hvFoHjw/Jnqvw53y+aO+TGUXmdI
	iqWdnJk9x0TJmOI81KLl7LxT0to2dOXmh0o07JuRZguWgmqnCR/nlIeELPkVv2z1TfgR+C
	EHS8xtFvWdo1h3aWXag8dEmX9NiAYxc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-qpNFLOlUM3a29jRMmra5kg-1; Mon, 12 Feb 2024 11:59:55 -0500
X-MC-Unique: qpNFLOlUM3a29jRMmra5kg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a29bb25df84so240341566b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 08:59:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757194; x=1708361994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qFP4poM8gEvIFjfXy0QwY6pOEwAMOFuQs9zumtA0Rw=;
        b=ew5cyQQIphVXGCnYEcPHXq29fQa336m67MkVb/nzyPYNDDiwIDRGiB6+nr4fCo0+9W
         MV4x6QwpzYEYXNKOrltJhUKLZfpC2JQhhBWn7mOSJE1bt2/YT/dBMK8vaCgJFD5YD9QW
         jPZnz8MiHxS49oXwEx6FWA4nZBdQIkzfKJ5AdGHIG5aMv6On14rwmdHU3Nc9FPd85mrk
         grV6Hh6jMXezk51qZCiQvjkAIdI7TIQc34lDrDkQ7xv/pBTMyDltOwm8e0k4G8HN2e0/
         XHqsGtVtbNdk/8tcOikPsgqm3DoqQWtPltIwPltr+3/RQGxgCB6sAsxxdRswFmgJaZE2
         WOCg==
X-Forwarded-Encrypted: i=1; AJvYcCUtdbF+CVmrInUMUx9bw5tegrDRPzdE0Ii5q9xUNMdU8dfC3aFiWFWckMomLGvR3zF2k2pWYBmFcSB3OIY0k0e6nK59x2e6WgqB+zQx7Q==
X-Gm-Message-State: AOJu0YzDI2TBeZUZEvck2TQtYtfsIePFh6xk6e1vYhxVjORnW6IU1xSu
	Os+8nEyab0TPhW5yvF3TEL6YlphwnEi5DEsy/DIy1nfMQBVk+W7CfJoZSkG5yQBbly1XhGwt4Mj
	CZvuV/b99Qtf7yO5dR57CN0Jj1zOMrhs8eY6FQO4yvXymhESWjgGcc1rnhmEI2w==
X-Received: by 2002:a50:f617:0:b0:561:9652:5637 with SMTP id c23-20020a50f617000000b0056196525637mr3659215edn.37.1707757194131;
        Mon, 12 Feb 2024 08:59:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyqJb1xpGFjqn3vJ1D5hirpPLDzmRKHxkeP+Sul2WzwXFn0vPfXCQQQxMCa6uPvEMMQbzT7A==
X-Received: by 2002:a50:f617:0:b0:561:9652:5637 with SMTP id c23-20020a50f617000000b0056196525637mr3659193edn.37.1707757193796;
        Mon, 12 Feb 2024 08:59:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW15t2/qN+81/gTVJVaHFlHCRoy1SV6DbG8x2VqPSugS1HhtAx2zTTQr1Q6u1PNlEg5V3nZUjaI7j76OEk8aQIdPjXyyZ97YD83BdXLq5oWzaUmPfTVHnUVDAOhBo8DD1s78Ei6+LZkX6u/4zBrMQ6IoPRwXTgJ6nyEE86RRpNBv5bhUrRADnka3myGH6mexm5lulkydp/ZHrbv/9EupTI1msGa8udBR2ij
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.08.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:59:53 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Allison Henderson <allison.henderson@oracle.com>
Subject: [PATCH v4 04/25] xfs: add parent pointer validator functions
Date: Mon, 12 Feb 2024 17:58:01 +0100
Message-Id: <20240212165821.1901300-5-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240212165821.1901300-1-aalbersh@redhat.com>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Allison Henderson <allison.henderson@oracle.com>

Attribute names of parent pointers are not strings.  So we need to
modify attr_namecheck to verify parent pointer records when the
XFS_ATTR_PARENT flag is set.  At the same time, we need to validate attr
values during log recovery if the xattr is really a parent pointer.

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: move functions to xfs_parent.c, adjust for new disk format]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/Makefile               |   1 +
 fs/xfs/libxfs/xfs_attr.c      |  10 ++-
 fs/xfs/libxfs/xfs_attr.h      |   3 +-
 fs/xfs/libxfs/xfs_da_format.h |   8 +++
 fs/xfs/libxfs/xfs_parent.c    | 113 ++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_parent.h    |  19 ++++++
 fs/xfs/scrub/attr.c           |   2 +-
 fs/xfs/xfs_attr_item.c        |   6 +-
 fs/xfs/xfs_attr_list.c        |  14 +++--
 9 files changed, 165 insertions(+), 11 deletions(-)
 create mode 100644 fs/xfs/libxfs/xfs_parent.c
 create mode 100644 fs/xfs/libxfs/xfs_parent.h

diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index fbe3cdc79036..8be90c685b0b 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -41,6 +41,7 @@ xfs-y				+= $(addprefix libxfs/, \
 				   xfs_inode_buf.o \
 				   xfs_log_rlimit.o \
 				   xfs_ag_resv.o \
+				   xfs_parent.o \
 				   xfs_rmap.o \
 				   xfs_rmap_btree.o \
 				   xfs_refcount.o \
diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index 1292ab043b4f..f9846df41669 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -26,6 +26,7 @@
 #include "xfs_trace.h"
 #include "xfs_attr_item.h"
 #include "xfs_xattr.h"
+#include "xfs_parent.h"
 
 struct kmem_cache		*xfs_attr_intent_cache;
 
@@ -1514,9 +1515,14 @@ xfs_attr_node_get(
 /* Returns true if the attribute entry name is valid. */
 bool
 xfs_attr_namecheck(
-	const void	*name,
-	size_t		length)
+	struct xfs_mount	*mp,
+	const void		*name,
+	size_t			length,
+	unsigned int		flags)
 {
+	if (flags & XFS_ATTR_PARENT)
+		return xfs_parent_namecheck(mp, name, length, flags);
+
 	/*
 	 * MAXNAMELEN includes the trailing null, but (name/length) leave it
 	 * out, so use >= for the length check.
diff --git a/fs/xfs/libxfs/xfs_attr.h b/fs/xfs/libxfs/xfs_attr.h
index 81be9b3e4004..92711c8d2a9f 100644
--- a/fs/xfs/libxfs/xfs_attr.h
+++ b/fs/xfs/libxfs/xfs_attr.h
@@ -547,7 +547,8 @@ int xfs_attr_get(struct xfs_da_args *args);
 int xfs_attr_set(struct xfs_da_args *args);
 int xfs_attr_set_iter(struct xfs_attr_intent *attr);
 int xfs_attr_remove_iter(struct xfs_attr_intent *attr);
-bool xfs_attr_namecheck(const void *name, size_t length);
+bool xfs_attr_namecheck(struct xfs_mount *mp, const void *name, size_t length,
+		unsigned int flags);
 int xfs_attr_calc_size(struct xfs_da_args *args, int *local);
 void xfs_init_attr_trans(struct xfs_da_args *args, struct xfs_trans_res *tres,
 			 unsigned int *total);
diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
index e5eacfe75021..1b79c4de90bc 100644
--- a/fs/xfs/libxfs/xfs_da_format.h
+++ b/fs/xfs/libxfs/xfs_da_format.h
@@ -746,6 +746,14 @@ xfs_attr3_leaf_name(xfs_attr_leafblock_t *leafp, int idx)
 	return &((char *)leafp)[be16_to_cpu(entries[idx].nameidx)];
 }
 
+static inline int
+xfs_attr3_leaf_flags(xfs_attr_leafblock_t *leafp, int idx)
+{
+	struct xfs_attr_leaf_entry *entries = xfs_attr3_leaf_entryp(leafp);
+
+	return entries[idx].flags;
+}
+
 static inline xfs_attr_leaf_name_remote_t *
 xfs_attr3_leaf_name_remote(xfs_attr_leafblock_t *leafp, int idx)
 {
diff --git a/fs/xfs/libxfs/xfs_parent.c b/fs/xfs/libxfs/xfs_parent.c
new file mode 100644
index 000000000000..1d45f926c13a
--- /dev/null
+++ b/fs/xfs/libxfs/xfs_parent.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022-2024 Oracle.
+ * All rights reserved.
+ */
+#include "xfs.h"
+#include "xfs_fs.h"
+#include "xfs_format.h"
+#include "xfs_da_format.h"
+#include "xfs_log_format.h"
+#include "xfs_shared.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_bmap_btree.h"
+#include "xfs_inode.h"
+#include "xfs_error.h"
+#include "xfs_trace.h"
+#include "xfs_trans.h"
+#include "xfs_da_btree.h"
+#include "xfs_attr.h"
+#include "xfs_dir2.h"
+#include "xfs_dir2_priv.h"
+#include "xfs_attr_sf.h"
+#include "xfs_bmap.h"
+#include "xfs_defer.h"
+#include "xfs_log.h"
+#include "xfs_xattr.h"
+#include "xfs_parent.h"
+#include "xfs_trans_space.h"
+
+/*
+ * Parent pointer attribute handling.
+ *
+ * Because the attribute value is a filename component, it will never be longer
+ * than 255 bytes. This means the attribute will always be a local format
+ * attribute as it is xfs_attr_leaf_entsize_local_max() for v5 filesystems will
+ * always be larger than this (max is 75% of block size).
+ *
+ * Creating a new parent attribute will always create a new attribute - there
+ * should never, ever be an existing attribute in the tree for a new inode.
+ * ENOSPC behavior is problematic - creating the inode without the parent
+ * pointer is effectively a corruption, so we allow parent attribute creation
+ * to dip into the reserve block pool to avoid unexpected ENOSPC errors from
+ * occurring.
+ */
+
+/* Return true if parent pointer EA name is valid. */
+bool
+xfs_parent_namecheck(
+	struct xfs_mount			*mp,
+	const struct xfs_parent_name_rec	*rec,
+	size_t					reclen,
+	unsigned int				attr_flags)
+{
+	if (!(attr_flags & XFS_ATTR_PARENT))
+		return false;
+
+	/* pptr updates use logged xattrs, so we should never see this flag */
+	if (attr_flags & XFS_ATTR_INCOMPLETE)
+		return false;
+
+	if (reclen != sizeof(struct xfs_parent_name_rec))
+		return false;
+
+	/* Only one namespace bit allowed. */
+	if (hweight32(attr_flags & XFS_ATTR_NSP_ONDISK_MASK) > 1)
+		return false;
+
+	return true;
+}
+
+/* Return true if parent pointer EA value is valid. */
+bool
+xfs_parent_valuecheck(
+	struct xfs_mount		*mp,
+	const void			*value,
+	size_t				valuelen)
+{
+	if (valuelen == 0 || valuelen > XFS_PARENT_DIRENT_NAME_MAX_SIZE)
+		return false;
+
+	if (value == NULL)
+		return false;
+
+	return true;
+}
+
+/* Return true if the ondisk parent pointer is consistent. */
+bool
+xfs_parent_hashcheck(
+	struct xfs_mount		*mp,
+	const struct xfs_parent_name_rec *rec,
+	const void			*value,
+	size_t				valuelen)
+{
+	struct xfs_name			dname = {
+		.name			= value,
+		.len			= valuelen,
+	};
+	xfs_ino_t			p_ino;
+
+	/* Valid dirent name? */
+	if (!xfs_dir2_namecheck(value, valuelen))
+		return false;
+
+	/* Valid inode number? */
+	p_ino = be64_to_cpu(rec->p_ino);
+	if (!xfs_verify_dir_ino(mp, p_ino))
+		return false;
+
+	/* Namehash matches name? */
+	return be32_to_cpu(rec->p_namehash) == xfs_dir2_hashname(mp, &dname);
+}
diff --git a/fs/xfs/libxfs/xfs_parent.h b/fs/xfs/libxfs/xfs_parent.h
new file mode 100644
index 000000000000..fcfeddb645f6
--- /dev/null
+++ b/fs/xfs/libxfs/xfs_parent.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022-2024 Oracle.
+ * All Rights Reserved.
+ */
+#ifndef	__XFS_PARENT_H__
+#define	__XFS_PARENT_H__
+
+/* Metadata validators */
+bool xfs_parent_namecheck(struct xfs_mount *mp,
+		const struct xfs_parent_name_rec *rec, size_t reclen,
+		unsigned int attr_flags);
+bool xfs_parent_valuecheck(struct xfs_mount *mp, const void *value,
+		size_t valuelen);
+bool xfs_parent_hashcheck(struct xfs_mount *mp,
+		const struct xfs_parent_name_rec *rec, const void *value,
+		size_t valuelen);
+
+#endif /* __XFS_PARENT_H__ */
diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 49f91cc85a65..9a1f59f7b5a4 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -195,7 +195,7 @@ xchk_xattr_listent(
 	}
 
 	/* Does this name make sense? */
-	if (!xfs_attr_namecheck(name, namelen)) {
+	if (!xfs_attr_namecheck(sx->sc->mp, name, namelen, flags)) {
 		xchk_fblock_set_corrupt(sx->sc, XFS_ATTR_FORK, args.blkno);
 		goto fail_xref;
 	}
diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index 9e02111bd890..6f6eeaaa9010 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -588,7 +588,8 @@ xfs_attr_recover_work(
 	 */
 	attrp = &attrip->attri_format;
 	if (!xfs_attri_validate(mp, attrp) ||
-	    !xfs_attr_namecheck(nv->name.i_addr, nv->name.i_len))
+	    !xfs_attr_namecheck(mp, nv->name.i_addr, nv->name.i_len,
+				attrp->alfi_attr_filter))
 		return -EFSCORRUPTED;
 
 	attr = xfs_attri_recover_work(mp, dfp, attrp, &ip, nv);
@@ -728,7 +729,8 @@ xlog_recover_attri_commit_pass2(
 		return -EFSCORRUPTED;
 	}
 
-	if (!xfs_attr_namecheck(attr_name, attri_formatp->alfi_name_len)) {
+	if (!xfs_attr_namecheck(mp, attr_name, attri_formatp->alfi_name_len,
+				attri_formatp->alfi_attr_filter)) {
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp,
 				item->ri_buf[1].i_addr, item->ri_buf[1].i_len);
 		return -EFSCORRUPTED;
diff --git a/fs/xfs/xfs_attr_list.c b/fs/xfs/xfs_attr_list.c
index e368ad671e26..1521ca2f0ce3 100644
--- a/fs/xfs/xfs_attr_list.c
+++ b/fs/xfs/xfs_attr_list.c
@@ -58,6 +58,7 @@ xfs_attr_shortform_list(
 	struct xfs_attr_sf_sort		*sbuf, *sbp;
 	struct xfs_attr_sf_hdr		*sf = dp->i_af.if_data;
 	struct xfs_attr_sf_entry	*sfe;
+	struct xfs_mount		*mp = dp->i_mount;
 	int				sbsize, nsbuf, count, i;
 	int				error = 0;
 
@@ -81,8 +82,9 @@ xfs_attr_shortform_list(
 	     (dp->i_af.if_bytes + sf->count * 16) < context->bufsize)) {
 		for (i = 0, sfe = xfs_attr_sf_firstentry(sf); i < sf->count; i++) {
 			if (XFS_IS_CORRUPT(context->dp->i_mount,
-					   !xfs_attr_namecheck(sfe->nameval,
-							       sfe->namelen)))
+					   !xfs_attr_namecheck(mp, sfe->nameval,
+							       sfe->namelen,
+							       sfe->flags)))
 				return -EFSCORRUPTED;
 			context->put_listent(context,
 					     sfe->flags,
@@ -173,8 +175,9 @@ xfs_attr_shortform_list(
 			cursor->offset = 0;
 		}
 		if (XFS_IS_CORRUPT(context->dp->i_mount,
-				   !xfs_attr_namecheck(sbp->name,
-						       sbp->namelen))) {
+				   !xfs_attr_namecheck(mp, sbp->name,
+						       sbp->namelen,
+						       sbp->flags))) {
 			error = -EFSCORRUPTED;
 			goto out;
 		}
@@ -464,7 +467,8 @@ xfs_attr3_leaf_list_int(
 		}
 
 		if (XFS_IS_CORRUPT(context->dp->i_mount,
-				   !xfs_attr_namecheck(name, namelen)))
+				   !xfs_attr_namecheck(mp, name, namelen,
+						       entry->flags)))
 			return -EFSCORRUPTED;
 		context->put_listent(context, entry->flags,
 					      name, namelen, valuelen);
-- 
2.42.0


