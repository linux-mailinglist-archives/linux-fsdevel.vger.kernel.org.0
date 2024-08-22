Return-Path: <linux-fsdevel+bounces-26793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1FE95BB06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E590B281781
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AD61CDFAD;
	Thu, 22 Aug 2024 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="E3fa+7V4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A171CCEC2;
	Thu, 22 Aug 2024 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341950; cv=none; b=Wp7Hwpt73G5JDzx9X1G4gphIkV8r6e+TBtKNDiyRVHwGU5gqmR04MX3p/jzEnwmyK9qxmWpXKLdKPLFTLD6Vt8xDHECLzCWgROdVqQeDHi1vshVOpN1t8GvPiKAlVCgZlwC8tPr5MXg3esaxPZskDNrtubO6HJf7kLD4bQBJnFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341950; c=relaxed/simple;
	bh=dUUKkj9Od9WTWcsV2PQJJV5s9Wfd07UHP2K/4wrkSVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLlyym1bAs+pP1jlWw5IYtRUblWe31Io8CFXJzmKKqnMqNkqr8KVbGMbLQzkVND7WsayNW5RH9TTOx7HeVxRrBqAZ0fnQL7LPa14Y9Lj7Zva9UtyZZwH0a3/TmIPAG7KX67vIgsiFhwvklJwS5WIiT1n7v0uBIEbBw4vh93cXTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=E3fa+7V4; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 8017C21E0;
	Thu, 22 Aug 2024 15:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1724341467;
	bh=gVnsk5R6P+G+hms8Xc2cAyDHunLW50EWJODDOSPi2ME=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=E3fa+7V4ZYakEYRl7MSZl+hzGKYzE3ZgOrzVyDWN7O/gsKvvfsGPMfR0A2WlAVoT4
	 ReSm1auWo0MGzV2OFpK31zyET/c+oMTRmbXjogihnzaPNLzgP9m1GIkDWysizTXK/P
	 CTse3nnscZNL3cMOXgz3MFadDS7WHGNc2Woe02Uk=
Received: from ntfs3vm.paragon-software.com (192.168.211.133) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 22 Aug 2024 18:52:23 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 12/14] fs/ntfs3: Add support for the compression attribute
Date: Thu, 22 Aug 2024 18:52:05 +0300
Message-ID: <20240822155207.600355-13-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
References: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Support added for empty files and directories only.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c  | 71 +++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/file.c    | 12 +++++++-
 fs/ntfs3/frecord.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/ntfs_fs.h |  2 ++
 4 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index d2a9cd963429..0763202d00c9 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2605,3 +2605,74 @@ int attr_force_nonresident(struct ntfs_inode *ni)
 
 	return err;
 }
+
+/*
+ * Change the compression of data attribute
+ */
+int attr_set_compress(struct ntfs_inode *ni, bool compr)
+{
+	struct ATTRIB *attr;
+	struct mft_inode *mi;
+
+	attr = ni_find_attr(ni, NULL, NULL, ATTR_DATA, NULL, 0, NULL, &mi);
+	if (!attr)
+		return -ENOENT;
+
+	if (is_attr_compressed(attr) == !!compr) {
+		/* Already required compressed state. */
+		return 0;
+	}
+
+	if (attr->non_res) {
+		u16 run_off;
+		u32 run_size;
+		char *run;
+
+		if (attr->nres.data_size) {
+			/*
+			 * There are rare cases when it possible to change
+			 * compress state without big changes.
+			 * TODO: Process these cases.
+			 */
+			return -EOPNOTSUPP;
+		}
+
+		run_off = le16_to_cpu(attr->nres.run_off);
+		run_size = le32_to_cpu(attr->size) - run_off;
+		run = Add2Ptr(attr, run_off);
+
+		if (!compr) {
+			/* remove field 'attr->nres.total_size'. */
+			memmove(run - 8, run, run_size);
+			run_off -= 8;
+		}
+
+		if (!mi_resize_attr(mi, attr, compr ? +8 : -8)) {
+			/*
+			 * Ignore rare case when there are no 8 bytes in record with attr.
+			 * TODO: split attribute.
+			 */
+			return -EOPNOTSUPP;
+		}
+
+		if (compr) {
+			/* Make a gap for 'attr->nres.total_size'. */
+			memmove(run + 8, run, run_size);
+			run_off += 8;
+			attr->nres.total_size = attr->nres.alloc_size;
+		}
+		attr->nres.run_off = cpu_to_le16(run_off);
+	}
+
+	/* Update data attribute flags. */
+	if (compr) {
+		attr->flags |= ATTR_FLAG_COMPRESSED;
+		attr->nres.c_unit = NTFS_LZNT_CUNIT;
+	} else {
+		attr->flags &= ~ATTR_FLAG_COMPRESSED;
+		attr->nres.c_unit = 0;
+	}
+	mi->dirty = true;
+
+	return 0;
+}
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 1cbaab1163b9..77f96665744e 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -82,13 +82,14 @@ int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 		      struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
+	struct ntfs_inode *ni = ntfs_i(inode);
 	u32 flags = fa->flags;
 	unsigned int new_fl = 0;
 
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
 
-	if (flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL))
+	if (flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_COMPR_FL))
 		return -EOPNOTSUPP;
 
 	if (flags & FS_IMMUTABLE_FL)
@@ -97,6 +98,15 @@ int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (flags & FS_APPEND_FL)
 		new_fl |= S_APPEND;
 
+	/* Allowed to change compression for empty files and for directories only. */
+	if (!is_dedup(ni) && !is_encrypted(ni) &&
+	    (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
+		/* Change compress state. */
+		int err = ni_set_compress(inode, flags & FS_COMPR_FL);
+		if (err)
+			return err;
+	}
+
 	inode_set_flags(inode, new_fl, S_IMMUTABLE | S_APPEND);
 
 	inode_set_ctime_current(inode);
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 8d801eb291e8..eab3fe1475ef 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3455,3 +3455,75 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 
 	return 0;
 }
+
+/*
+ * ni_set_compress
+ *
+ * Helper for 'ntfs_fileattr_set'.
+ * Changes compression for empty files and directories only.
+ */
+int ni_set_compress(struct inode *inode, bool compr)
+{
+	int err;
+	struct ntfs_inode *ni = ntfs_i(inode);
+	struct ATTR_STD_INFO *std;
+	const char *bad_inode;
+
+	if (is_compressed(ni) == !!compr)
+		return 0;
+
+	if (is_sparsed(ni)) {
+		/* sparse and compress not compatible. */
+		return -EOPNOTSUPP;
+	}
+
+	if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode)) {
+		/*Skip other inodes. (symlink,fifo,...) */
+		return -EOPNOTSUPP;
+	}
+
+	bad_inode = NULL;
+
+	ni_lock(ni);
+
+	std = ni_std(ni);
+	if (!std) {
+		bad_inode = "no std";
+		goto out;
+	}
+
+	if (S_ISREG(inode->i_mode)) {
+		err = attr_set_compress(ni, compr);
+		if (err) {
+			if (err == -ENOENT) {
+				/* Fix on the fly? */
+				/* Each file must contain data attribute. */
+				bad_inode = "no data attribute";
+			}
+			goto out;
+		}
+	}
+
+	ni->std_fa = std->fa;
+	if (compr)
+		std->fa |= FILE_ATTRIBUTE_COMPRESSED;
+	else
+		std->fa &= ~FILE_ATTRIBUTE_COMPRESSED;
+
+	if (ni->std_fa != std->fa) {
+		ni->std_fa = std->fa;
+		ni->mi.dirty = true;
+	}
+	/* update duplicate information and directory entries in ni_write_inode.*/
+	ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
+	err = 0;
+
+out:
+	ni_unlock(ni);
+	if (bad_inode) {
+		ntfs_bad_inode(inode, bad_inode);
+		err = -EINVAL;
+	}
+
+	return err;
+}
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 898c742fca14..d8d71a211194 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -453,6 +453,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes);
 int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes);
 int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size);
 int attr_force_nonresident(struct ntfs_inode *ni);
+int attr_set_compress(struct ntfs_inode *ni, bool compr);
 
 /* Functions from attrlist.c */
 void al_destroy(struct ntfs_inode *ni);
@@ -588,6 +589,7 @@ int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
 	      bool *is_bad);
 
 bool ni_is_dirty(struct inode *inode);
+int ni_set_compress(struct inode *inode, bool compr);
 
 /* Globals from fslog.c */
 bool check_index_header(const struct INDEX_HDR *hdr, size_t bytes);
-- 
2.34.1


