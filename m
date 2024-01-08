Return-Path: <linux-fsdevel+bounces-7538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D77F826D73
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 13:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71C11F229E7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 12:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBE8405F0;
	Mon,  8 Jan 2024 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HPWJVlBJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C798405EB
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C1CED3F582
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704715805;
	bh=mr8sbzdAtqXe7/XkmKXPwVfGObhH4DN7fFUmLFyq+MA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=HPWJVlBJuS2/jrNzHxbrlHJeBlg0hB9uxPmoWr1lzlCKwNhiSSUcM6lMs7R6tUzJq
	 r3dQPNXoFixG2MCxScHs/Ooh/omTc8eYp18PD6dUtFh/w3IoQwo9/pkFutETLfcgM5
	 cUWY0mBK4BZTE21tamOYrxNiW6fZmma/ZsjLUhmVN/Lp41+7Ag88rcuKBd//XA+oL6
	 aBDnL66zlZf74d5+59eXBf1nlP8aXoLxgafBMfjIgO5fFyy4QVW7ZQEjVLOf9dhwAv
	 5A/jyX0rI69gJwy2bTDYtBCGY4Ian4DzGLSCjZVDmzg9yugxM+s9NdguDQjJn07p2H
	 eYxZleO7MU/Yw==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50e7ae03f5cso1062221e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jan 2024 04:10:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704715805; x=1705320605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mr8sbzdAtqXe7/XkmKXPwVfGObhH4DN7fFUmLFyq+MA=;
        b=ejkvax3ytV5XFIp2rTql5GrJgwK/cp9TRjyWmECbpHYm9Y9GJBKXyy/jOYwBe6/1Ui
         V1usTn86MLq3na0EFirzRFa9KVJd06xGwmNIMm2stVauVSlZZ7s+JiJP2y0a5b1NcDZi
         eEmoOiGhkZoATT9Xa/3Qymll0IaIb/De2pNkXDvUrt+VCq4A5EPPx77J1vndbFoO1pME
         8A1N2rgLQpHiWmZFOT0KtXrQixKwk2gBJqERhfVkzE1Blfen5jR+gbk1D+fBSOFULlCA
         JSujUcquWAxlGBHS/aPg9yML/LUK/XsHVJrEueAOaTGIOaTd+XgozUXz/EM0Ev3DS/0h
         yaKg==
X-Gm-Message-State: AOJu0YwWccP4OhJqnKa69jbADTXpZoqUR5A5FV/jymCyu+3knKUnd5bT
	yxq3t2zaFjEEy2wowv0CaUDt7/bV66TdMB+806NoELTe6XG/RzlwlcotapzuPMQ/6h6GDHhnRoC
	u+fwzHpeZY7puAqZYl2lcWBphZvbk3DlMJNYdH/FrZKhBtia9QQ==
X-Received: by 2002:ac2:5e33:0:b0:50e:52ea:771e with SMTP id o19-20020ac25e33000000b0050e52ea771emr1121317lfg.138.1704715805167;
        Mon, 08 Jan 2024 04:10:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6BVLmg1QflPR2yuZVRfqVUwsYwwfsK2JxDahvi3YR/nFvwf+wHlCc+2CTfXr7thdLqTc/fg==
X-Received: by 2002:ac2:5e33:0:b0:50e:52ea:771e with SMTP id o19-20020ac25e33000000b0050e52ea771emr1121313lfg.138.1704715804894;
        Mon, 08 Jan 2024 04:10:04 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id fi21-20020a056402551500b005578b816f20sm1767959edb.29.2024.01.08.04.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:10:04 -0800 (PST)
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
Subject: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
Date: Mon,  8 Jan 2024 13:08:17 +0100
Message-Id: <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
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
index 6f5f9ff95380..e78ad4742aef 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -568,7 +568,33 @@ static int get_create_supp_group(struct inode *dir, struct fuse_in_arg *ext)
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
@@ -580,6 +606,8 @@ static int get_create_ext(struct fuse_args *args,
 		err = get_security_context(dentry, mode, &ext);
 	if (!err && fc->create_supp_group)
 		err = get_create_supp_group(dir, &ext);
+	if (!err && fc->owner_uid_gid_ext)
+		err = get_owner_uid_gid(idmap, fc, &ext);
 
 	if (!err && ext.size) {
 		WARN_ON(args->in_numargs >= ARRAY_SIZE(args->in_args));
@@ -662,7 +690,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	args.out_args[1].size = sizeof(outopen);
 	args.out_args[1].value = &outopen;
 
-	err = get_create_ext(&args, dir, entry, mode);
+	err = get_create_ext(&nop_mnt_idmap, &args, dir, entry, mode);
 	if (err)
 		goto out_put_forget_req;
 
@@ -790,7 +818,7 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	args->out_args[0].value = &outarg;
 
 	if (args->opcode != FUSE_LINK) {
-		err = get_create_ext(args, dir, entry, mode);
+		err = get_create_ext(&nop_mnt_idmap, args, dir, entry, mode);
 		if (err)
 			goto out_put_forget_req;
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1df83eebda92..15ec95dea276 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -806,6 +806,9 @@ struct fuse_conn {
 	/* Add supplementary group info when creating a new inode */
 	unsigned int create_supp_group:1;
 
+	/* Add owner_{u,g}id info when creating a new inode */
+	unsigned int owner_uid_gid_ext:1;
+
 	/* Does the filesystem support per inode DAX? */
 	unsigned int inode_dax:1;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ab824a8908b7..08cd3714b32d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1284,6 +1284,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->create_supp_group = 1;
 			if (flags & FUSE_DIRECT_IO_ALLOW_MMAP)
 				fc->direct_io_allow_mmap = 1;
+			if (flags & FUSE_OWNER_UID_GID_EXT)
+				fc->owner_uid_gid_ext = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1330,7 +1332,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
-		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP;
+		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP | FUSE_OWNER_UID_GID_EXT;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e7418d15fe39..ebe82104b172 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -211,6 +211,10 @@
  *  7.39
  *  - add FUSE_DIRECT_IO_ALLOW_MMAP
  *  - add FUSE_STATX and related structures
+ *
+ *  7.40
+ *  - add FUSE_EXT_OWNER_UID_GID
+ *  - add FUSE_OWNER_UID_GID_EXT
  */
 
 #ifndef _LINUX_FUSE_H
@@ -410,6 +414,8 @@ struct fuse_file_lock {
  *			symlink and mknod (single group that matches parent)
  * FUSE_HAS_EXPIRE_ONLY: kernel supports expiry-only entry invalidation
  * FUSE_DIRECT_IO_ALLOW_MMAP: allow shared mmap in FOPEN_DIRECT_IO mode.
+ * FUSE_OWNER_UID_GID_EXT: add inode owner UID/GID info to create, mkdir,
+ *			   symlink and mknod
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -452,6 +458,7 @@ struct fuse_file_lock {
 
 /* Obsolete alias for FUSE_DIRECT_IO_ALLOW_MMAP */
 #define FUSE_DIRECT_IO_RELAX	FUSE_DIRECT_IO_ALLOW_MMAP
+#define FUSE_OWNER_UID_GID_EXT	(1ULL << 37)
 
 /**
  * CUSE INIT request/reply flags
@@ -561,11 +568,13 @@ struct fuse_file_lock {
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
@@ -1153,4 +1162,14 @@ struct fuse_supp_groups {
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


