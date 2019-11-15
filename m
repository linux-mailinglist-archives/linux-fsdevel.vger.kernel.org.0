Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6C2FDC53
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 12:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfKOLdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 06:33:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46120 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfKOLdR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:33:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id b3so10585195wrs.13;
        Fri, 15 Nov 2019 03:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/DT9err042ycXFenTq86xoN8HJYFi+xxriAtLSh237I=;
        b=qHALQD2BeLTOChq2PkIM0vroEgybjdwp0Dq/gT6wfKQ3kCdgZJ8ZXtT3Jf2ZeS5jeK
         d6sod2Z4pqL0+VHx3I4pFmxhNGfoexup7/Ge1WwWyuXhnpGvSBNfIC6/hb5fnjWZsIcj
         QGADxhguT1kNyVxRL8wq5yRX6fJyLhB0Ehkr1F7GUiE7Qd+COtwQhfltJu0/v73k81Ck
         xLm7GBg9WfVKV7C+1eAWpghBLccT0N4v8V9NFlOqq0dwHEJqsEpRizPDx5QhxpHEGWeu
         a+iroawOMLYzvLjECHoYjSR8Im9tce21WHIDC2lv3wBFXP1NDsXvsjRfAacKbXj6x1GP
         MA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/DT9err042ycXFenTq86xoN8HJYFi+xxriAtLSh237I=;
        b=KZ7amqPJpReNENHHowUvPA9SpeeaYTX2MnSaNORdmcCtek8NbmVaXb7N3sZY9o9Eeq
         oEOPwIk3N3PgD24o2jzugoSj/hk6QjeGkmYDWaCO3CuOUcOyyHCqN23FjYjcNJ8OHqF9
         D9vc0H6TxKIxxBY2ypKUO3/+18AgdcjLgxP0nyNvbl8EJsqxX0YA+awLM9FR9l/UEBfu
         cz5mwkkjBB/D1Dm8b5QoiNTGoxWcRJrGhcGVLYe2fJuvXXr6tTMK3JN1AqJPld2KKTzH
         mjzEpBrPpYaGV6MXRQ1AHBh7bSaStWnjQXdBtgY8rZjk3ZbfMQmqlxBtgeEFla5JQMsb
         Wr0g==
X-Gm-Message-State: APjAAAUaDgs8Ug6o/g5CuJEPtYDms1wmGNFNiB1TyjLbUL2UqV8GHKgq
        0WEoIylNj5XGrXZe2Q22OAk=
X-Google-Smtp-Source: APXvYqzvHdPqh3sDrlC8RGUXbD+wo3zShKFiBWX+c8XKOth5eK2f+LtcqT1YdgPIPbAzjQUfO3v9Ug==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr11887554wrm.106.1573817592968;
        Fri, 15 Nov 2019 03:33:12 -0800 (PST)
Received: from localhost.localdomain ([94.230.83.228])
        by smtp.gmail.com with ESMTPSA id l4sm9225181wme.4.2019.11.15.03.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 03:33:12 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] ovl: make sure that real fid is 32bit aligned in memory
Date:   Fri, 15 Nov 2019 13:33:03 +0200
Message-Id: <20191115113304.16209-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115113304.16209-1-amir73il@gmail.com>
References: <20191115113304.16209-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Seprate on-disk encoding from in-memory and on-wire resresentation
of overlay file handle.

In-memory and on-wire we only ever pass around pointers to struct
ovl_fh, which encapsulates at offset 3 the on-disk format struct
ovl_fb. struct ovl_fb encapsulates at offset 21 the real file handle.
That makes sure that the real file handle is always 32bit aligned
in-memory when passed down to the underlying filesystem.

On-disk format remains the same and store/load are done into
correctly aligned buffer.

New nfs exported file handles are exported with aligned real fid.
Old nfs file handles are copied to an aligned buffer before being
decoded.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c   | 30 ++++++++-------
 fs/overlayfs/export.c    | 80 ++++++++++++++++++++++++----------------
 fs/overlayfs/namei.c     | 44 +++++++++++-----------
 fs/overlayfs/overlayfs.h | 34 ++++++++++++++---
 4 files changed, 115 insertions(+), 73 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b801c6353100..7f744a9541e5 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -251,18 +251,20 @@ struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper)
 	    WARN_ON(fh_type == FILEID_INVALID))
 		goto out;
 
-	BUILD_BUG_ON(MAX_HANDLE_SZ + offsetof(struct ovl_fh, fid) > 255);
-	fh_len = offsetof(struct ovl_fh, fid) + buflen;
-	fh = kmalloc(fh_len, GFP_KERNEL);
+	/* Make sure the real fid stays 32bit aligned */
+	BUILD_BUG_ON(OVL_FH_FID_OFFSET % 4);
+	BUILD_BUG_ON(MAX_HANDLE_SZ + OVL_FH_FID_OFFSET > 255);
+	fh_len = OVL_FH_FID_OFFSET + buflen;
+	fh = kzalloc(fh_len, GFP_KERNEL);
 	if (!fh) {
 		fh = ERR_PTR(-ENOMEM);
 		goto out;
 	}
 
-	fh->version = OVL_FH_VERSION;
-	fh->magic = OVL_FH_MAGIC;
-	fh->type = fh_type;
-	fh->flags = OVL_FH_FLAG_CPU_ENDIAN;
+	fh->fb.version = OVL_FH_VERSION;
+	fh->fb.magic = OVL_FH_MAGIC;
+	fh->fb.type = fh_type;
+	fh->fb.flags = OVL_FH_FLAG_CPU_ENDIAN;
 	/*
 	 * When we will want to decode an overlay dentry from this handle
 	 * and all layers are on the same fs, if we get a disconncted real
@@ -270,10 +272,10 @@ struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper)
 	 * it to upperdentry or to lowerstack is by checking this flag.
 	 */
 	if (is_upper)
-		fh->flags |= OVL_FH_FLAG_PATH_UPPER;
-	fh->len = fh_len;
-	fh->uuid = *uuid;
-	memcpy(fh->fid, buf, buflen);
+		fh->fb.flags |= OVL_FH_FLAG_PATH_UPPER;
+	fh->fb.len = fh_len - OVL_FH_WIRE_OFFSET;
+	fh->fb.uuid = *uuid;
+	memcpy(fh->fb.fid, buf, buflen);
 
 out:
 	kfree(buf);
@@ -300,8 +302,8 @@ int ovl_set_origin(struct dentry *dentry, struct dentry *lower,
 	/*
 	 * Do not fail when upper doesn't support xattrs.
 	 */
-	err = ovl_check_setxattr(dentry, upper, OVL_XATTR_ORIGIN, fh,
-				 fh ? fh->len : 0, 0);
+	err = ovl_check_setxattr(dentry, upper, OVL_XATTR_ORIGIN, fh->buf,
+				 fh ? fh->fb.len : 0, 0);
 	kfree(fh);
 
 	return err;
@@ -317,7 +319,7 @@ static int ovl_set_upper_fh(struct dentry *upper, struct dentry *index)
 	if (IS_ERR(fh))
 		return PTR_ERR(fh);
 
-	err = ovl_do_setxattr(index, OVL_XATTR_UPPER, fh, fh->len, 0);
+	err = ovl_do_setxattr(index, OVL_XATTR_UPPER, fh->buf, fh->fb.len, 0);
 
 	kfree(fh);
 	return err;
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 73c9775215b3..70e55588aedc 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -211,10 +211,11 @@ static int ovl_check_encode_origin(struct dentry *dentry)
 	return 1;
 }
 
-static int ovl_d_to_fh(struct dentry *dentry, char *buf, int buflen)
+static int ovl_dentry_to_fid(struct dentry *dentry, u32 *fid, int buflen)
 {
 	struct ovl_fh *fh = NULL;
 	int err, enc_lower;
+	int len;
 
 	/*
 	 * Check if we should encode a lower or upper file handle and maybe
@@ -231,11 +232,12 @@ static int ovl_d_to_fh(struct dentry *dentry, char *buf, int buflen)
 		return PTR_ERR(fh);
 
 	err = -EOVERFLOW;
-	if (fh->len > buflen)
+	len = OVL_FH_LEN(fh);
+	if (len > buflen)
 		goto fail;
 
-	memcpy(buf, (char *)fh, fh->len);
-	err = fh->len;
+	memcpy(fid, fh, len);
+	err = len;
 
 out:
 	kfree(fh);
@@ -243,31 +245,16 @@ static int ovl_d_to_fh(struct dentry *dentry, char *buf, int buflen)
 
 fail:
 	pr_warn_ratelimited("overlayfs: failed to encode file handle (%pd2, err=%i, buflen=%d, len=%d, type=%d)\n",
-			    dentry, err, buflen, fh ? (int)fh->len : 0,
-			    fh ? fh->type : 0);
+			    dentry, err, buflen, fh ? (int)fh->fb.len : 0,
+			    fh ? fh->fb.type : 0);
 	goto out;
 }
 
-static int ovl_dentry_to_fh(struct dentry *dentry, u32 *fid, int *max_len)
-{
-	int res, len = *max_len << 2;
-
-	res = ovl_d_to_fh(dentry, (char *)fid, len);
-	if (res <= 0)
-		return FILEID_INVALID;
-
-	len = res;
-
-	/* Round up to dwords */
-	*max_len = (len + 3) >> 2;
-	return OVL_FILEID;
-}
-
 static int ovl_encode_fh(struct inode *inode, u32 *fid, int *max_len,
 			 struct inode *parent)
 {
 	struct dentry *dentry;
-	int type;
+	int bytes = *max_len << 2;
 
 	/* TODO: encode connectable file handles */
 	if (parent)
@@ -277,10 +264,14 @@ static int ovl_encode_fh(struct inode *inode, u32 *fid, int *max_len,
 	if (WARN_ON(!dentry))
 		return FILEID_INVALID;
 
-	type = ovl_dentry_to_fh(dentry, fid, max_len);
-
+	bytes = ovl_dentry_to_fid(dentry, fid, bytes);
 	dput(dentry);
-	return type;
+	if (bytes <= 0)
+		return FILEID_INVALID;
+
+	*max_len = bytes >> 2;
+
+	return OVL_FILEID_V1;
 }
 
 /*
@@ -777,24 +768,45 @@ static struct dentry *ovl_lower_fh_to_d(struct super_block *sb,
 	goto out;
 }
 
+static struct ovl_fh *ovl_fid_to_fh(struct fid *fid, int buflen, int fh_type)
+{
+	struct ovl_fh *fh;
+
+	/* If on-wire inner fid is aligned - nothing to do */
+	if (fh_type == OVL_FILEID_V1)
+		return (struct ovl_fh *)fid;
+
+	if (fh_type != OVL_FILEID_V0)
+		return ERR_PTR(-EINVAL);
+
+	fh = kzalloc(buflen, GFP_KERNEL);
+	if (!fh)
+		return ERR_PTR(-ENOMEM);
+
+	/* Copy unaligned inner fh into aligned buffer */
+	memcpy(&fh->fb, fid, buflen - OVL_FH_WIRE_OFFSET);
+	return fh;
+}
+
 static struct dentry *ovl_fh_to_dentry(struct super_block *sb, struct fid *fid,
 				       int fh_len, int fh_type)
 {
 	struct dentry *dentry = NULL;
-	struct ovl_fh *fh = (struct ovl_fh *) fid;
+	struct ovl_fh *fh = NULL;
 	int len = fh_len << 2;
 	unsigned int flags = 0;
 	int err;
 
-	err = -EINVAL;
-	if (fh_type != OVL_FILEID)
+	fh = ovl_fid_to_fh(fid, len, fh_type);
+	err = PTR_ERR(fh);
+	if (IS_ERR(fh))
 		goto out_err;
 
 	err = ovl_check_fh_len(fh, len);
 	if (err)
 		goto out_err;
 
-	flags = fh->flags;
+	flags = fh->fb.flags;
 	dentry = (flags & OVL_FH_FLAG_PATH_UPPER) ?
 		 ovl_upper_fh_to_d(sb, fh) :
 		 ovl_lower_fh_to_d(sb, fh);
@@ -802,12 +814,18 @@ static struct dentry *ovl_fh_to_dentry(struct super_block *sb, struct fid *fid,
 	if (IS_ERR(dentry) && err != -ESTALE)
 		goto out_err;
 
+out:
+	/* We may have needed to re-align OVL_FILEID_V0 */
+	if (!IS_ERR_OR_NULL(fh) && fh != (void *)fid)
+		kfree(fh);
+
 	return dentry;
 
 out_err:
 	pr_warn_ratelimited("overlayfs: failed to decode file handle (len=%d, type=%d, flags=%x, err=%i)\n",
-			    len, fh_type, flags, err);
-	return ERR_PTR(err);
+			    fh_len, fh_type, flags, err);
+	dentry = ERR_PTR(err);
+	goto out;
 }
 
 static struct dentry *ovl_fh_to_parent(struct super_block *sb, struct fid *fid,
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index f47c591402d7..80fbca5219d4 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -84,21 +84,21 @@ static int ovl_acceptable(void *ctx, struct dentry *dentry)
  * Return -ENODATA for "origin unknown".
  * Return <0 for an invalid file handle.
  */
-int ovl_check_fh_len(struct ovl_fh *fh, int fh_len)
+int ovl_check_fb_len(struct ovl_fb *fb, int fb_len)
 {
-	if (fh_len < sizeof(struct ovl_fh) || fh_len < fh->len)
+	if (fb_len < sizeof(struct ovl_fb) || fb_len < fb->len)
 		return -EINVAL;
 
-	if (fh->magic != OVL_FH_MAGIC)
+	if (fb->magic != OVL_FH_MAGIC)
 		return -EINVAL;
 
 	/* Treat larger version and unknown flags as "origin unknown" */
-	if (fh->version > OVL_FH_VERSION || fh->flags & ~OVL_FH_FLAG_ALL)
+	if (fb->version > OVL_FH_VERSION || fb->flags & ~OVL_FH_FLAG_ALL)
 		return -ENODATA;
 
 	/* Treat endianness mismatch as "origin unknown" */
-	if (!(fh->flags & OVL_FH_FLAG_ANY_ENDIAN) &&
-	    (fh->flags & OVL_FH_FLAG_BIG_ENDIAN) != OVL_FH_FLAG_CPU_ENDIAN)
+	if (!(fb->flags & OVL_FH_FLAG_ANY_ENDIAN) &&
+	    (fb->flags & OVL_FH_FLAG_BIG_ENDIAN) != OVL_FH_FLAG_CPU_ENDIAN)
 		return -ENODATA;
 
 	return 0;
@@ -119,15 +119,15 @@ static struct ovl_fh *ovl_get_fh(struct dentry *dentry, const char *name)
 	if (res == 0)
 		return NULL;
 
-	fh = kzalloc(res, GFP_KERNEL);
+	fh = kzalloc(res + OVL_FH_WIRE_OFFSET, GFP_KERNEL);
 	if (!fh)
 		return ERR_PTR(-ENOMEM);
 
-	res = vfs_getxattr(dentry, name, fh, res);
+	res = vfs_getxattr(dentry, name, fh->buf, res);
 	if (res < 0)
 		goto fail;
 
-	err = ovl_check_fh_len(fh, res);
+	err = ovl_check_fb_len(&fh->fb, res);
 	if (err < 0) {
 		if (err == -ENODATA)
 			goto out;
@@ -158,12 +158,12 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
 	 * Make sure that the stored uuid matches the uuid of the lower
 	 * layer where file handle will be decoded.
 	 */
-	if (!uuid_equal(&fh->uuid, &mnt->mnt_sb->s_uuid))
+	if (!uuid_equal(&fh->fb.uuid, &mnt->mnt_sb->s_uuid))
 		return NULL;
 
-	bytes = (fh->len - offsetof(struct ovl_fh, fid));
-	real = exportfs_decode_fh(mnt, (struct fid *)fh->fid,
-				  bytes >> 2, (int)fh->type,
+	bytes = (fh->fb.len - offsetof(struct ovl_fb, fid));
+	real = exportfs_decode_fh(mnt, (struct fid *)fh->fb.fid,
+				  bytes >> 2, (int)fh->fb.type,
 				  connected ? ovl_acceptable : NULL, mnt);
 	if (IS_ERR(real)) {
 		/*
@@ -173,7 +173,7 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
 		 * index entries correctly.
 		 */
 		if (real == ERR_PTR(-ESTALE) &&
-		    !(fh->flags & OVL_FH_FLAG_PATH_UPPER))
+		    !(fh->fb.flags & OVL_FH_FLAG_PATH_UPPER))
 			real = NULL;
 		return real;
 	}
@@ -410,7 +410,7 @@ static int ovl_verify_fh(struct dentry *dentry, const char *name,
 	if (IS_ERR(ofh))
 		return PTR_ERR(ofh);
 
-	if (fh->len != ofh->len || memcmp(fh, ofh, fh->len))
+	if (fh->fb.len != ofh->fb.len || memcmp(&fh->fb, &ofh->fb, fh->fb.len))
 		err = -ESTALE;
 
 	kfree(ofh);
@@ -441,7 +441,7 @@ int ovl_verify_set_fh(struct dentry *dentry, const char *name,
 
 	err = ovl_verify_fh(dentry, name, fh);
 	if (set && err == -ENODATA)
-		err = ovl_do_setxattr(dentry, name, fh, fh->len, 0);
+		err = ovl_do_setxattr(dentry, name, fh->buf, fh->fb.len, 0);
 	if (err)
 		goto fail;
 
@@ -515,20 +515,20 @@ int ovl_verify_index(struct ovl_fs *ofs, struct dentry *index)
 		goto fail;
 
 	err = -EINVAL;
-	if (index->d_name.len < sizeof(struct ovl_fh)*2)
+	if (index->d_name.len < sizeof(struct ovl_fb)*2)
 		goto fail;
 
 	err = -ENOMEM;
 	len = index->d_name.len / 2;
-	fh = kzalloc(len, GFP_KERNEL);
+	fh = kzalloc(len + OVL_FH_WIRE_OFFSET, GFP_KERNEL);
 	if (!fh)
 		goto fail;
 
 	err = -EINVAL;
-	if (hex2bin((u8 *)fh, index->d_name.name, len))
+	if (hex2bin(fh->buf, index->d_name.name, len))
 		goto fail;
 
-	err = ovl_check_fh_len(fh, len);
+	err = ovl_check_fb_len(&fh->fb, len);
 	if (err)
 		goto fail;
 
@@ -607,11 +607,11 @@ static int ovl_get_index_name_fh(struct ovl_fh *fh, struct qstr *name)
 {
 	char *n, *s;
 
-	n = kcalloc(fh->len, 2, GFP_KERNEL);
+	n = kcalloc(fh->fb.len, 2, GFP_KERNEL);
 	if (!n)
 		return -ENOMEM;
 
-	s  = bin2hex(n, fh, fh->len);
+	s  = bin2hex(n, fh->buf, fh->fb.len);
 	*name = (struct qstr) QSTR_INIT(n, s - n);
 
 	return 0;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 6934bcf030f0..f283b1d69a9e 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -71,20 +71,36 @@ enum ovl_entry_flag {
 #error Endianness not defined
 #endif
 
-/* The type returned by overlay exportfs ops when encoding an ovl_fh handle */
-#define OVL_FILEID	0xfb
+/* The type used to be returned by overlay exportfs for misaligned fid */
+#define OVL_FILEID_V0	0xfb
+/* The type returned by overlay exportfs for 32bit aligned fid */
+#define OVL_FILEID_V1	0xf8
 
-/* On-disk and in-memeory format for redirect by file handle */
-struct ovl_fh {
+/* On-disk format for "origin" file handle */
+struct ovl_fb {
 	u8 version;	/* 0 */
 	u8 magic;	/* 0xfb */
 	u8 len;		/* size of this header + size of fid */
 	u8 flags;	/* OVL_FH_FLAG_* */
 	u8 type;	/* fid_type of fid */
 	uuid_t uuid;	/* uuid of filesystem */
-	u8 fid[0];	/* file identifier */
+	u32 fid[0];	/* file identifier should be 32bit aligned in-memory */
 } __packed;
 
+/* In-memory and on-wire format for overlay file handle */
+struct ovl_fh {
+	u8 padding[3];	/* make sure fb.fid is 32bit aligned */
+	union {
+		struct ovl_fb fb;
+		u8 buf[0];
+	};
+} __packed;
+
+#define OVL_FH_WIRE_OFFSET	offsetof(struct ovl_fh, fb)
+#define OVL_FH_LEN(fh)		(OVL_FH_WIRE_OFFSET + (fh)->fb.len)
+#define OVL_FH_FID_OFFSET	(OVL_FH_WIRE_OFFSET + \
+				 offsetof(struct ovl_fb, fid))
+
 static inline int ovl_do_rmdir(struct inode *dir, struct dentry *dentry)
 {
 	int err = vfs_rmdir(dir, dentry);
@@ -302,7 +318,13 @@ static inline void ovl_inode_unlock(struct inode *inode)
 
 
 /* namei.c */
-int ovl_check_fh_len(struct ovl_fh *fh, int fh_len);
+int ovl_check_fb_len(struct ovl_fb *fb, int fb_len);
+
+static inline int ovl_check_fh_len(struct ovl_fh *fh, int fh_len)
+{
+	return ovl_check_fb_len(&fh->fb, fh_len - OVL_FH_WIRE_OFFSET);
+}
+
 struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
 				  bool connected);
 int ovl_check_origin_fh(struct ovl_fs *ofs, struct ovl_fh *fh, bool connected,
-- 
2.17.1

