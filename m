Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31006624422
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 15:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiKJOVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 09:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKJOVd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:21:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA9424F3C
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 06:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668090029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7kiGzsh4g//v4awrudqMJr6V9AF9HH5RI2l8P6L7ik0=;
        b=jSKEj76P4Ox8qFYuO+L1NabeoaVmYlgVOXokPMS1nG0lJtQvgjemqE/9WdrhnkkMvseq5X
        KHVz2kLt6khh530gEZxHopdtfyMI3vOS3qS1BKKRk7btgPMF0qZkVejgg2g3U2emwhjGht
        VNlrAqJ3zyLKG4fphUmNsSyfrUw9PGQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-619-MvZZMVR8MvyyvOrmV91Upw-1; Thu, 10 Nov 2022 09:20:28 -0500
X-MC-Unique: MvZZMVR8MvyyvOrmV91Upw-1
Received: by mail-ed1-f71.google.com with SMTP id e15-20020a056402190f00b00461b0576620so1619315edz.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 06:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kiGzsh4g//v4awrudqMJr6V9AF9HH5RI2l8P6L7ik0=;
        b=Aw/mhUCtJuytnXtAj25SFb4SHCUxi9mZKilWK3SyMYHkCRlqmY58N0nfDpGq4owGJW
         Ya03PK1iX/NoJKXstcbmV+N1yRPForvWRKC1pQb7PNsA7UKMp52+FO5O0I9FpTipO3FK
         CCC3AlA2zd/z9t+BxQce/m5n+hfCSGXTT1iPWMtUyxr6HfF2LCHvgSE6xoOAlNR8HzQg
         yQ7dFkckzCgUj6C/TQKj2Risq70qIPZBNd/RMPC/u3VKoNfFV2w+fkohTclCYeD2U/vt
         +n0mVLjYsyJZZNJLP5BfIltojNZpuuo9qMhjTY0seZgi0PExGfap5vxtGJHyRBh9H42G
         W/Tg==
X-Gm-Message-State: ACrzQf3Rkbui7FATAUM3nzeUp6a3huHiuEIbnbEDnAHhgpEV8cqlpApm
        IhDV7MuMAWjqquhlY+xcbc1L+W2vguVfx3GQHa1TW8slf9onDt09KGUiSbS83lcT9lMVP4Cm4cc
        xBrZI2vfmsR0dN3RhUc+qn07k95co7CT5UtAc2eZPQfcG0PRX9MBhh56oSpW4Cg0DzuJBEobu15
        vbnQ==
X-Received: by 2002:a17:906:6808:b0:7ac:2e16:a8d3 with SMTP id k8-20020a170906680800b007ac2e16a8d3mr3006135ejr.667.1668090026158;
        Thu, 10 Nov 2022 06:20:26 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4+AUHUR5WxkyqoCmd8Wq2tLJ2LuCHslmA3IekjhTF5s0/3dcnf5aHVPEB7k4ZJSKkeUPDGbg==
X-Received: by 2002:a17:906:6808:b0:7ac:2e16:a8d3 with SMTP id k8-20020a170906680800b007ac2e16a8d3mr3006121ejr.667.1668090025855;
        Thu, 10 Nov 2022 06:20:25 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (91-83-33-160.pool.digikabel.hu. [91.83.33.160])
        by smtp.gmail.com with ESMTPSA id f27-20020a17090631db00b0073ae9ba9ba8sm7227006ejf.3.2022.11.10.06.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 06:20:24 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        German Maglione <gmaglione@redhat.com>
Subject: [PATCH 2/2] fuse: optional supplementary group in create requests
Date:   Thu, 10 Nov 2022 15:20:20 +0100
Message-Id: <20221110142020.191487-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221110142020.191487-1-mszeredi@redhat.com>
References: <20221110142020.191487-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Permission to create an object (create, mkdir, symlink, mknod) needs to
take supplementary groups into account.

Add a supplementary group request extension.  This can contain an arbitrary
number of group IDs and can be added to any request.  This extension is not
added to any request by default.

Add FUSE_CREATE_SUPP_GROUP init flag to enable supplementary group info in
creation requests.  This adds just a single supplementary group that
matches the parent group in the case described above.  In other cases the
extension is not added.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c             | 64 +++++++++++++++++++++++++++++++++++++--
 fs/fuse/fuse_i.h          |  3 ++
 fs/fuse/inode.c           |  4 ++-
 include/uapi/linux/fuse.h | 17 +++++++++++
 4 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index c227ce87b100..a99ca225c578 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -521,7 +521,63 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 	return err;
 }
 
-static int get_create_ext(struct fuse_args *args, struct dentry *dentry,
+static void *extend_arg(struct fuse_in_arg *buf, u32 bytes)
+{
+	void *p;
+	u32 newlen = buf->size + bytes;
+
+	p = krealloc(buf->value, newlen, GFP_KERNEL);
+	if (!p) {
+		kfree(buf->value);
+		buf->size = 0;
+		buf->value = NULL;
+		return NULL;
+	}
+
+	memset(p + buf->size, 0, bytes);
+	buf->value = p;
+	buf->size = newlen;
+
+	return p + newlen - bytes;
+}
+
+static u32 fuse_ext_size(size_t size)
+{
+	return FUSE_REC_ALIGN(sizeof(struct fuse_ext_header) + size);
+}
+
+/*
+ * This adds just a single supplementary group that matches the parent's group.
+ */
+static int get_create_supp_group(struct inode *dir, struct fuse_in_arg *ext)
+{
+	struct fuse_conn *fc = get_fuse_conn(dir);
+	struct fuse_ext_header *xh;
+	struct fuse_supp_groups *sg;
+	kgid_t kgid = dir->i_gid;
+	gid_t parent_gid = from_kgid(fc->user_ns, kgid);
+	u32 sg_len = fuse_ext_size(sizeof(*sg) + sizeof(sg->groups[0]));
+
+	if (parent_gid == (gid_t) -1 || gid_eq(kgid, current_fsgid()) ||
+	    !in_group_p(kgid))
+		return 0;
+
+	xh = extend_arg(ext, sg_len);
+	if (!xh)
+		return -ENOMEM;
+
+	xh->size = sg_len;
+	xh->type = FUSE_EXT_GROUPS;
+
+	sg = (struct fuse_supp_groups *) (xh + 1);
+	sg->nr_groups = 1;
+	sg->groups[0] = parent_gid;
+
+	return 0;
+}
+
+static int get_create_ext(struct fuse_args *args,
+			  struct inode *dir, struct dentry *dentry,
 			  umode_t mode)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
@@ -530,6 +586,8 @@ static int get_create_ext(struct fuse_args *args, struct dentry *dentry,
 
 	if (fc->init_security)
 		err = get_security_context(dentry, mode, &ext);
+	if (!err && fc->create_supp_group)
+		err = get_create_supp_group(dir, &ext);
 
 	if (!err && ext.size) {
 		WARN_ON(args->in_numargs >= ARRAY_SIZE(args->in_args));
@@ -612,7 +670,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	args.out_args[1].size = sizeof(outopen);
 	args.out_args[1].value = &outopen;
 
-	err = get_create_ext(&args, entry, mode);
+	err = get_create_ext(&args, dir, entry, mode);
 	if (err)
 		goto out_put_forget_req;
 
@@ -739,7 +797,7 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	args->out_args[0].value = &outarg;
 
 	if (args->opcode != FUSE_LINK) {
-		err = get_create_ext(args, entry, mode);
+		err = get_create_ext(args, dir, entry, mode);
 		if (err)
 			goto out_put_forget_req;
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 31e2ca0d2788..52ec21891180 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -783,6 +783,9 @@ struct fuse_conn {
 	/* Initialize security xattrs when creating a new inode */
 	unsigned int init_security:1;
 
+	/* Add supplementary group info when creating a new inode */
+	unsigned int create_supp_group:1;
+
 	/* Does the filesystem support per inode DAX? */
 	unsigned int inode_dax:1;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6b3beda16c1b..114bdb3f7ccb 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1201,6 +1201,8 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fc->setxattr_ext = 1;
 			if (flags & FUSE_SECURITY_CTX)
 				fc->init_security = 1;
+			if (flags & FUSE_CREATE_SUPP_GROUP)
+				fc->create_supp_group = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1246,7 +1248,7 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
-		FUSE_SECURITY_CTX;
+		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c71f12429e3d..1b9d0dfae72d 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -204,6 +204,8 @@
  *  - add total_extlen to fuse_in_header
  *  - add FUSE_MAX_NR_SECCTX
  *  - add extension header
+ *  - add FUSE_EXT_GROUPS
+ *  - add FUSE_CREATE_SUPP_GROUP
  */
 
 #ifndef _LINUX_FUSE_H
@@ -365,6 +367,8 @@ struct fuse_file_lock {
  * FUSE_SECURITY_CTX:	add security context to create, mkdir, symlink, and
  *			mknod
  * FUSE_HAS_INODE_DAX:  use per inode DAX
+ * FUSE_CREATE_SUPP_GROUP: add supplementary group info to create, mkdir,
+ *			symlink and mknod (single group that matches parent)
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -401,6 +405,7 @@ struct fuse_file_lock {
 /* bits 32..63 get shifted down 32 bits into the flags2 field */
 #define FUSE_SECURITY_CTX	(1ULL << 32)
 #define FUSE_HAS_INODE_DAX	(1ULL << 33)
+#define FUSE_CREATE_SUPP_GROUP	(1ULL << 34)
 
 /**
  * CUSE INIT request/reply flags
@@ -509,10 +514,12 @@ struct fuse_file_lock {
 /**
  * extension type
  * FUSE_MAX_NR_SECCTX: maximum value of &fuse_secctx_header.nr_secctx
+ * FUSE_EXT_GROUPS: &fuse_supp_groups extension
  */
 enum fuse_ext_type {
 	/* Types 0..31 are reserved for fuse_secctx_header */
 	FUSE_MAX_NR_SECCTX	= 31,
+	FUSE_EXT_GROUPS		= 32,
 };
 
 enum fuse_opcode {
@@ -1073,4 +1080,14 @@ struct fuse_ext_header {
 	uint32_t	type;
 };
 
+/**
+ * struct fuse_supp_groups - Supplementary group extension
+ * @nr_groups: number of supplementary groups
+ * @groups: flexible array of group IDs
+ */
+struct fuse_supp_groups {
+	uint32_t	nr_groups;
+	uint32_t	groups[];
+};
+
 #endif /* _LINUX_FUSE_H */
-- 
2.38.1

