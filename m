Return-Path: <linux-fsdevel+bounces-71203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3B5CB9856
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 19:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D94793009126
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 18:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8762F6902;
	Fri, 12 Dec 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="scpjwKKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E11C860B;
	Fri, 12 Dec 2025 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765563195; cv=none; b=d6bO++LOTjixgxWC7wBIFjzQMBLdBcRe9n38p1M+PJQDnavuKjM7oaLV1tKIXQFtxNyQ2JJhc4kNV8PTzdSDfGlHRRlLHFEqMCaRn4ra7x9/x9G/7G56B6TX5vkVByzdYSVfX0HuHR89SxDnY8AlZzm5I8PFR5cm5oZn22k4SpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765563195; c=relaxed/simple;
	bh=QgPc7rTiFtExsyCw6e54RWJk8iRZfxNb4KhYrBVHGXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HTgmSSfqKxnwY+5KOxBebhQKqcwDr69lyrXYB3x5envlY25c3Anufn0fSkk16a/w2HIiPhcLpsAXhUUC20cZ9wugjmTEZZD2+or4JiH+3jACMfSGFB24k6Zzyictwtxlcb7nFu6/XCzyvO15Qn35mLUkkohGDqmyG4bHJFmaRyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=scpjwKKT; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bzHcDz2DUIi7I/EbwBbO3JlJ8/P5L8jnGcFP6eoP2ug=; b=scpjwKKTSzBjQ/i1xsHvQnUQEW
	q03/af846pzOfF602y6O/y74+1LEHSx0LUZpNJwT4LXMK9AL+YEXy2YvU0a4NFz9CPiV4pgAWBGWM
	pm+7voaKlQ2OzevL9o7eUwXyBmGTMqPPBVFO8DtXw4Qcs7NoDiZCImaoab65+6xFoHUtWKGDjz3J7
	GVSjplRFjAmC8C1EQEghFlXuX6EC5p+P4ES348z1gsWgIVa9B8uFT+9IyXgdfp27G+cmeu3Lv/apC
	r5byNOaCKDtnAJt9pXvopgRlIaVAwqkDQF4nhpjGJnZDUhd58fxd61XDV1ZQYBKY+Jy5/cgI9MPuF
	3ulRn6Bg==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vU7dU-00C79U-4N; Fri, 12 Dec 2025 19:13:00 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Bernd Schubert <bschubert@ddn.com>,
	Kevin Chen <kchen@ddn.com>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v2 6/6] fuse: implementation of export_operations with FUSE_LOOKUP_HANDLE
Date: Fri, 12 Dec 2025 18:12:54 +0000
Message-ID: <20251212181254.59365-7-luis@igalia.com>
In-Reply-To: <20251212181254.59365-1-luis@igalia.com>
References: <20251212181254.59365-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch allows the NFS handle to use the new file handle provided by the
LOOKUP_HANDLE operation.  It still allows the usage of nodeid+generation as
an handle if this operation is not supported by the FUSE server or if no
handle is available for a specific inode.  I.e. it can mix both file handle
types FILEID_INO64_GEN{_PARENT} and FILEID_FUSE_WITH{OUT}_PARENT.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/export.c         | 162 ++++++++++++++++++++++++++++++++++++---
 include/linux/exportfs.h |   7 ++
 2 files changed, 160 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/export.c b/fs/fuse/export.c
index 4a9c95fe578e..b40d146a32f2 100644
--- a/fs/fuse/export.c
+++ b/fs/fuse/export.c
@@ -3,6 +3,7 @@
  * FUSE NFS export support.
  *
  * Copyright (C) 2001-2008  Miklos Szeredi <miklos@szeredi.hu>
+ * Copyright (C) 2025 Jump Trading LLC, author: Luis Henriques <luis@igalia.com>
  */
 
 #include "fuse_i.h"
@@ -10,7 +11,8 @@
 
 struct fuse_inode_handle {
 	u64 nodeid;
-	u32 generation;
+	u32 generation; /* XXX change to u64, and use fid->i64.ino in encode/decode? */
+	struct fuse_file_handle fh;
 };
 
 static struct dentry *fuse_get_dentry(struct super_block *sb,
@@ -67,8 +69,8 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 	return ERR_PTR(err);
 }
 
-static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
-			   struct inode *parent)
+static int fuse_encode_gen_fh(struct inode *inode, u32 *fh, int *max_len,
+			      struct inode *parent)
 {
 	int len = parent ? 6 : 3;
 	u64 nodeid;
@@ -96,38 +98,180 @@ static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	}
 
 	*max_len = len;
+
 	return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
 }
 
-static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
-		struct fid *fid, int fh_len, int fh_type)
+static int fuse_encode_fuse_fh(struct inode *inode, u32 *fh, int *max_len,
+			       struct inode *parent)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_inode *fip = NULL;
+	struct fuse_inode_handle *handle = (void *)fh;
+	int type = FILEID_FUSE_WITHOUT_PARENT;
+	int len, lenp = 0;
+	int buflen = *max_len << 2; /* max_len: number of words */
+
+	len = sizeof(struct fuse_inode_handle) + fi->fh->size;
+	if (parent) {
+		fip = get_fuse_inode(parent);
+		if (fip->fh && fip->fh->size) {
+			lenp = sizeof(struct fuse_inode_handle) +
+				fip->fh->size;
+			type = FILEID_FUSE_WITH_PARENT;
+		}
+	}
+
+	if (buflen < (len + lenp)) {
+		*max_len = (len + lenp) >> 2;
+		return  FILEID_INVALID;
+	}
+
+	handle[0].nodeid = fi->nodeid;
+	handle[0].generation = inode->i_generation;
+	memcpy(&handle[0].fh, fi->fh, len);
+	if (lenp) {
+		handle[1].nodeid = fip->nodeid;
+		handle[1].generation = parent->i_generation;
+		memcpy(&handle[1].fh, fip->fh, lenp);
+	}
+
+	*max_len = (len + lenp) >> 2;
+
+	return type;
+}
+
+static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
+			   struct inode *parent)
+{
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	if (fc->lookup_handle && fi->fh && fi->fh->size)
+		return fuse_encode_fuse_fh(inode, fh, max_len, parent);
+
+	return fuse_encode_gen_fh(inode, fh, max_len, parent);
+}
+
+static struct dentry *fuse_fh_gen_to_dentry(struct super_block *sb,
+					    struct fid *fid, int fh_len)
 {
 	struct fuse_inode_handle handle;
 
-	if ((fh_type != FILEID_INO64_GEN &&
-	     fh_type != FILEID_INO64_GEN_PARENT) || fh_len < 3)
+	if (fh_len < 3)
 		return NULL;
 
 	handle.nodeid = (u64) fid->raw[0] << 32;
 	handle.nodeid |= (u64) fid->raw[1];
 	handle.generation = fid->raw[2];
+
 	return fuse_get_dentry(sb, &handle);
 }
 
-static struct dentry *fuse_fh_to_parent(struct super_block *sb,
+static struct dentry *fuse_fh_fuse_to_dentry(struct super_block *sb,
+					     struct fid *fid, int fh_len)
+{
+	struct fuse_inode_handle *handle;
+	struct dentry *dentry;
+	int len = sizeof(struct fuse_file_handle);
+
+	handle = (void *)fid;
+	len += handle->fh.size;
+
+	if ((fh_len << 2) < len)
+		return NULL;
+
+	handle = kzalloc(len, GFP_KERNEL);
+	if (!handle)
+		return NULL;
+
+	memcpy(handle, fid, len);
+
+	dentry = fuse_get_dentry(sb, handle);
+	kfree(handle);
+
+	return dentry;
+}
+
+static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
 		struct fid *fid, int fh_len, int fh_type)
+{
+	switch (fh_type) {
+	case FILEID_INO64_GEN:
+	case FILEID_INO64_GEN_PARENT:
+		return fuse_fh_gen_to_dentry(sb, fid, fh_len);
+	case FILEID_FUSE_WITHOUT_PARENT:
+	case FILEID_FUSE_WITH_PARENT:
+		return fuse_fh_fuse_to_dentry(sb, fid, fh_len);
+	}
+
+	return NULL;
+
+}
+
+static struct dentry *fuse_fh_gen_to_parent(struct super_block *sb,
+					    struct fid *fid, int fh_len)
 {
 	struct fuse_inode_handle parent;
 
-	if (fh_type != FILEID_INO64_GEN_PARENT || fh_len < 6)
+	if (fh_len < 6)
 		return NULL;
 
 	parent.nodeid = (u64) fid->raw[3] << 32;
 	parent.nodeid |= (u64) fid->raw[4];
 	parent.generation = fid->raw[5];
+
 	return fuse_get_dentry(sb, &parent);
 }
 
+static struct dentry *fuse_fh_fuse_to_parent(struct super_block *sb,
+					     struct fid *fid, int fh_len)
+{
+	struct fuse_inode_handle *handle;
+	struct dentry *dentry;
+	int total_len;
+	int len;
+
+	handle = (void *)fid;
+	total_len = len = sizeof(struct fuse_inode_handle) + handle->fh.size;
+
+	if ((fh_len << 2) < total_len)
+		return NULL;
+
+	handle = (void *)(fid + len);
+	len = sizeof(struct fuse_file_handle) + handle->fh.size;
+	total_len += len;
+
+	if ((fh_len << 2) < total_len)
+		return NULL;
+	
+	handle = kzalloc(len, GFP_KERNEL);
+	if (!handle)
+		return NULL;
+
+	memcpy(handle, fid, len);
+
+	dentry = fuse_get_dentry(sb, handle);
+	kfree(handle);
+
+	return dentry;
+}
+
+static struct dentry *fuse_fh_to_parent(struct super_block *sb,
+		struct fid *fid, int fh_len, int fh_type)
+{
+	switch (fh_type) {
+	case FILEID_INO64_GEN:
+	case FILEID_INO64_GEN_PARENT:
+		return fuse_fh_gen_to_parent(sb, fid, fh_len);
+	case FILEID_FUSE_WITHOUT_PARENT:
+	case FILEID_FUSE_WITH_PARENT:
+		return fuse_fh_fuse_to_parent(sb, fid, fh_len);
+	}
+
+	return NULL;
+}
+
 static struct dentry *fuse_get_parent(struct dentry *child)
 {
 	struct inode *child_inode = d_inode(child);
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index f0cf2714ec52..db783f6b28bc 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -110,6 +110,13 @@ enum fid_type {
 	 */
 	FILEID_INO64_GEN_PARENT = 0x82,
 
+	/*
+	 * 64 bit nodeid number, 32 bit generation number,
+	 * variable length handle.
+	 */
+	FILEID_FUSE_WITHOUT_PARENT = 0x91,
+	FILEID_FUSE_WITH_PARENT = 0x92,
+
 	/*
 	 * 128 bit child FID (struct lu_fid)
 	 * 128 bit parent FID (struct lu_fid)

