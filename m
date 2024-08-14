Return-Path: <linux-fsdevel+bounces-25901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A72CB951A40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 13:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1241C215E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 11:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5E91B3F3E;
	Wed, 14 Aug 2024 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="n2yyGUrO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE71B3F2A
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635686; cv=none; b=HLZQ8OH/76PbSUnpMJfshLqpWtjHJZ7aERlGsVDqjnAWJuODqUDnbgI3lFWFlOrzVVn0c1QN0/keimuimFZT2UJYBnTQ+t6fXXaMItJut26caEjKVuEvrKCNPyqAG3xySpzyg36bOspAqGcXO3onDdiF1m3nWJl6yIwMs7YZ6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635686; c=relaxed/simple;
	bh=3sKR5heXsN3+PDmKkyp9ATdAOr7cyhuezAbCen+o5+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HtdO1Hca1lfwl0NVcJJVu23BAzgbp1kpVFrfAPgGNdiFhDXi9m4dyJgPlS8ORxKqMMr4CKZBdgVaw+t2fjuwzipu1SIeKAgzP4eTa1D/VgcZ5uNgEhTrh0IRXrANIBr00+W2By6/GhT32G8UZn4lFtQ0nZFbrTBpPsQlU0iCS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=n2yyGUrO; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3CDCD3F6B5
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723635682;
	bh=m96HZWLn8OKWP/L3it/bQmtO6VIcFcKI507cIhh46m0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=n2yyGUrO1q4hgX6FjiqQpkHG23CAwCAuBtVRDoSPss2LEnj/vFxyBX2qMP2yQEqdz
	 /AwPYoTcb0pXs1AB71nKId7XUk+xSrs2ovTaMD5f7PINtQYIk3Y5b797gqxn6eJXz3
	 SzMYZ0BPtt3H+k8MIH+5xgLo5MO588vPxHacooE8opH69p6Cb4mCQ2h+jk34NpgYvx
	 iij70I/pZ6Drdfty1D/yG25RWDQqu4eAU1fqp1+BsxsIl3CnAyyq5T6SE2A92j6HCW
	 hn+vZQNZH3lBTnVoUEkTLYgsjwRWoeBZ4Yn8UGufJMKERkarkxmKEsHiMk/BF4xdsk
	 vcfc+eOv9BQ/g==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a7aa26f342cso498662966b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 04:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635682; x=1724240482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m96HZWLn8OKWP/L3it/bQmtO6VIcFcKI507cIhh46m0=;
        b=xAnq7kkBYNi4BhoE41zt4qMNEbKzIev2FzrqaQLgCGGNKaQBtmu76vqsfPPfCYgqKT
         IDdtDmhMng90z8XoJuuBvXzmBRtUv/NyAU5MVUN6z4cNl5L/GLHKEas4+KlJof3loQhY
         vR0Hn8fpHPsbHWhY867hgxP7khqTqsXJbeO7N5NdiME0wVW3PwntIxmHUa9MReEruIOo
         yH6LRrdNH7yXX6CTNyJwC9LmaayGcTpWB31awDcYt4umWz918tcXSCSo70gTozaZCJK/
         laLPikruu3LuMGGtD6xKFG0xfFdEzBKaWhhi5rCrSvvkc9dOGQSD8HBPkqlVTFWLpO2L
         MADA==
X-Forwarded-Encrypted: i=1; AJvYcCVdK+lVpYhOIzaBNsUMR/A+yE5uPAtCu0YAuYpcfpksn61Uub+P9mltdGPH8XN8cN5197KnmjnQO1+S/+SX3HDF69LhE1vcbRvNakUNtA==
X-Gm-Message-State: AOJu0Yw2OBdcN5xfsXh/lI4XYqJe7RCwaPP62ebSaipJUpjI4QJ6V8Xo
	vu+ayqO5H2WYjQGUVwmMQXvttn7Da+eWWcIGeucdZHiXNOkgNwLyzB2o6r8KVsgu96h6XUdnkb0
	EgLEbBHY7kDJKqbIkLhmMQPdGvSb64puFXBjKutUjbfARQr3aLgpHNTWEYE0FfAUIECaeCoZnWA
	FjUlw=
X-Received: by 2002:a17:907:e6e9:b0:a7a:bae8:f292 with SMTP id a640c23a62f3a-a8366d5d5bfmr158202866b.41.1723635681728;
        Wed, 14 Aug 2024 04:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlthGC9YqBA7AhyDAumby6ziF6nCxsMV3VHlphvXCxY4n73dzJQ2uZULnAELI07tonD3Wd3A==
X-Received: by 2002:a17:907:e6e9:b0:a7a:bae8:f292 with SMTP id a640c23a62f3a-a8366d5d5bfmr158200266b.41.1723635681200;
        Wed, 14 Aug 2024 04:41:21 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa782csm162586166b.60.2024.08.14.04.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:41:20 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Seth Forshee <sforshee@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
Date: Wed, 14 Aug 2024 13:40:26 +0200
Message-Id: <20240814114034.113953-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To properly support vfs idmappings we need to provide
a fuse daemon with the correct owner uid/gid for
inode creation requests like mkdir, mknod, atomic_open,
symlink.

Right now, fuse daemons use req->in.h.uid/req->in.h.gid
to set inode owner. These fields contain fsuid/fsgid of the
syscall's caller. And that's perfectly fine, because inode
owner have to be set to these values. But, for idmapped mounts
it's not the case and caller fsuid/fsgid != inode owner, because
idmapped mounts do nothing with the caller fsuid/fsgid, but
affect inode owner uid/gid. It means that we can't apply vfsid
mapping to caller fsuid/fsgid, but instead we have to introduce
a new fields to store inode owner uid/gid which will be appropriately
transformed.

Christian and I have done the same to support idmapped mounts in
the cephfs recently [1].

[1] 5ccd8530 ("ceph: handle idmapped mounts in create_request_message()")

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dir.c             | 34 +++++++++++++++++++++++++++++++---
 fs/fuse/fuse_i.h          |  3 +++
 fs/fuse/inode.c           |  4 +++-
 include/uapi/linux/fuse.h | 19 +++++++++++++++++++
 4 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 2b0d4781f394..30d27d4f3b5a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -572,7 +572,33 @@ static int get_create_supp_group(struct inode *dir, struct fuse_in_arg *ext)
 	return 0;
 }
 
-static int get_create_ext(struct fuse_args *args,
+static int get_owner_uid_gid(struct mnt_idmap *idmap, struct fuse_conn *fc, struct fuse_in_arg *ext)
+{
+	struct fuse_ext_header *xh;
+	struct fuse_owner_uid_gid *owner_creds;
+	u32 owner_creds_len = fuse_ext_size(sizeof(*owner_creds));
+	kuid_t owner_fsuid;
+	kgid_t owner_fsgid;
+
+	xh = extend_arg(ext, owner_creds_len);
+	if (!xh)
+		return -ENOMEM;
+
+	xh->size = owner_creds_len;
+	xh->type = FUSE_EXT_OWNER_UID_GID;
+
+	owner_creds = (struct fuse_owner_uid_gid *) &xh[1];
+
+	owner_fsuid = mapped_fsuid(idmap, fc->user_ns);
+	owner_fsgid = mapped_fsgid(idmap, fc->user_ns);
+	owner_creds->uid = from_kuid(fc->user_ns, owner_fsuid);
+	owner_creds->gid = from_kgid(fc->user_ns, owner_fsgid);
+
+	return 0;
+}
+
+static int get_create_ext(struct mnt_idmap *idmap,
+			  struct fuse_args *args,
 			  struct inode *dir, struct dentry *dentry,
 			  umode_t mode)
 {
@@ -584,6 +610,8 @@ static int get_create_ext(struct fuse_args *args,
 		err = get_security_context(dentry, mode, &ext);
 	if (!err && fc->create_supp_group)
 		err = get_create_supp_group(dir, &ext);
+	if (!err && fc->owner_uid_gid_ext)
+		err = get_owner_uid_gid(idmap, fc, &ext);
 
 	if (!err && ext.size) {
 		WARN_ON(args->in_numargs >= ARRAY_SIZE(args->in_args));
@@ -668,7 +696,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	args.out_args[1].size = sizeof(*outopenp);
 	args.out_args[1].value = outopenp;
 
-	err = get_create_ext(&args, dir, entry, mode);
+	err = get_create_ext(&nop_mnt_idmap, &args, dir, entry, mode);
 	if (err)
 		goto out_put_forget_req;
 
@@ -798,7 +826,7 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	args->out_args[0].value = &outarg;
 
 	if (args->opcode != FUSE_LINK) {
-		err = get_create_ext(args, dir, entry, mode);
+		err = get_create_ext(&nop_mnt_idmap, args, dir, entry, mode);
 		if (err)
 			goto out_put_forget_req;
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..d06934e70cc5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -845,6 +845,9 @@ struct fuse_conn {
 	/* Add supplementary group info when creating a new inode */
 	unsigned int create_supp_group:1;
 
+	/* Add owner_{u,g}id info when creating a new inode */
+	unsigned int owner_uid_gid_ext:1;
+
 	/* Does the filesystem support per inode DAX? */
 	unsigned int inode_dax:1;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d8ab4e93916f..6c205731c844 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1343,6 +1343,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			}
 			if (flags & FUSE_NO_EXPORT_SUPPORT)
 				fm->sb->s_export_op = &fuse_export_fid_operations;
+			if (flags & FUSE_OWNER_UID_GID_EXT)
+				fc->owner_uid_gid_ext = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1390,7 +1392,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
-		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND;
+		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_OWNER_UID_GID_EXT;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d08b99d60f6f..d9ecc17fd13b 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -217,6 +217,10 @@
  *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
  *  - add FUSE_NO_EXPORT_SUPPORT init flag
  *  - add FUSE_NOTIFY_RESEND, add FUSE_HAS_RESEND init flag
+ *
+ *  7.41
+ *  - add FUSE_EXT_OWNER_UID_GID
+ *  - add FUSE_OWNER_UID_GID_EXT
  */
 
 #ifndef _LINUX_FUSE_H
@@ -421,6 +425,8 @@ struct fuse_file_lock {
  * FUSE_NO_EXPORT_SUPPORT: explicitly disable export support
  * FUSE_HAS_RESEND: kernel supports resending pending requests, and the high bit
  *		    of the request ID indicates resend requests
+ * FUSE_OWNER_UID_GID_EXT: add inode owner UID/GID info to create, mkdir,
+ *			   symlink and mknod
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -466,6 +472,7 @@ struct fuse_file_lock {
 
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
+#define FUSE_OWNER_UID_GID_EXT	(1ULL << 40)
 
 /**
  * CUSE INIT request/reply flags
@@ -575,11 +582,13 @@ struct fuse_file_lock {
  * extension type
  * FUSE_MAX_NR_SECCTX: maximum value of &fuse_secctx_header.nr_secctx
  * FUSE_EXT_GROUPS: &fuse_supp_groups extension
+ * FUSE_EXT_OWNER_UID_GID: &fuse_owner_uid_gid extension
  */
 enum fuse_ext_type {
 	/* Types 0..31 are reserved for fuse_secctx_header */
 	FUSE_MAX_NR_SECCTX	= 31,
 	FUSE_EXT_GROUPS		= 32,
+	FUSE_EXT_OWNER_UID_GID	= 33,
 };
 
 enum fuse_opcode {
@@ -1186,4 +1195,14 @@ struct fuse_supp_groups {
 	uint32_t	groups[];
 };
 
+/**
+ * struct fuse_owner_uid_gid - Inode owner UID/GID extension
+ * @uid: inode owner UID
+ * @gid: inode owner GID
+ */
+struct fuse_owner_uid_gid {
+	uint32_t	uid;
+	uint32_t	gid;
+};
+
 #endif /* _LINUX_FUSE_H */
-- 
2.34.1


