Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB1C624421
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 15:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiKJOV2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Nov 2022 09:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiKJOV1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:21:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C78165AF
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 06:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668090027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aIhimHh+D2tOb+mPy5ru9+z8fekBFGOxfA+OyP0/Xto=;
        b=f876sSCdXO4sW9wdls4d/clz1JHXqB3dVih2ZQl/u6/5uMjypvBJyY4df3nhFnfStYrlV/
        /ZYniSUfM+TJDckG0OP6udkr5KaxoCzsb6Lh3eTCNgtTwxUzOOSp4NDzLTCpol+3GJmyD6
        ExPzWw2fP9B/qkFaMfywb/O5HH1+ufE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-400-bJK4ejspOWiahfoF2AXNWw-1; Thu, 10 Nov 2022 09:20:26 -0500
X-MC-Unique: bJK4ejspOWiahfoF2AXNWw-1
Received: by mail-ej1-f70.google.com with SMTP id hs34-20020a1709073ea200b007ad86f91d39so1302906ejc.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Nov 2022 06:20:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIhimHh+D2tOb+mPy5ru9+z8fekBFGOxfA+OyP0/Xto=;
        b=oLIGh9839BLrVa4JPvS7MPNkXaoSKxIy+QRYZkBG+vS9/JBKgxLiOyee8wbWGVmk5R
         j7AsfSkwKFqW9TlR6kvE2N7jMVdh6e0n71okJr2GhbLNGiTS3OfrpuXVudWidaI59M8N
         aiYdO6NaKpF8OCK2ZZN0jzvnzcHrW9WEfSD5GKcbaMsDKWqh7x7UYOi+7nMprAIEp/hF
         wT1kZ1f4HYkk5Js9gR6HfwV2tYgzMWhejkjG7SShuS5EPm8ngPKqp4cwN/fDatvAYCEH
         P7sYt4S57KOwlONyky8SQ5Q62b0XwK0eSdFI+QRFGaMeY6it5MYYikXwqd6KlktXeNIX
         1z2Q==
X-Gm-Message-State: ACrzQf32wNr8Oejy+fox5UB18LEmd9L+HNrBxLxJeiiLIasDZc2UqI8b
        84qGrrw6iv+/nHe39WaPd+cKkEHz63O+WEOWctAOfzduKxjnl7RmA/zYTdtlRWHz6FPME5MhPfe
        oQxcHTKIV/PeGgTI7edq3Z0HvMG+MD4Gs5iMwGcW65P7uQ8UoEoVXHFx9i2mwMcjqEg2ajLbArt
        TFFg==
X-Received: by 2002:a05:6402:2156:b0:458:c11e:46de with SMTP id bq22-20020a056402215600b00458c11e46demr2342986edb.237.1668090024372;
        Thu, 10 Nov 2022 06:20:24 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5B3f+lNdVZGxM4ZRj2RIm3z+r8PL27Pp8nz0RyQDcX/tG1W1DL8M++78WkWlYFkzb4L04rGw==
X-Received: by 2002:a05:6402:2156:b0:458:c11e:46de with SMTP id bq22-20020a056402215600b00458c11e46demr2342968edb.237.1668090023956;
        Thu, 10 Nov 2022 06:20:23 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (91-83-33-160.pool.digikabel.hu. [91.83.33.160])
        by smtp.gmail.com with ESMTPSA id f27-20020a17090631db00b0073ae9ba9ba8sm7227006ejf.3.2022.11.10.06.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 06:20:23 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        German Maglione <gmaglione@redhat.com>
Subject: [PATCH 1/2] fuse: add request extension
Date:   Thu, 10 Nov 2022 15:20:19 +0100
Message-Id: <20221110142020.191487-2-mszeredi@redhat.com>
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


Will need to add supplementary groups to create messages, so add the
general concept of a request extension.  A request extension is appended to
the end of the main request.  It has a header indicating the size and type
of the extension.

The create security context (fuse_secctx_*) is simplar to the generic
request extension, so incude that as well in a backward compatible manner.

Add the total extension length to the request header.  The offset of the
extension block within the request can be calculated by:

  inh->len - inh->total_extlen * 8

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c             |  2 ++
 fs/fuse/dir.c             | 66 ++++++++++++++++++++++-----------------
 fs/fuse/fuse_i.h          |  6 ++--
 include/uapi/linux/fuse.h | 28 ++++++++++++++++-
 4 files changed, 71 insertions(+), 31 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c73d9c4132f6..c77eea4f636b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -476,6 +476,8 @@ static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
 	req->in.h.opcode = args->opcode;
 	req->in.h.nodeid = args->nodeid;
 	req->args = args;
+	if (args->is_ext)
+		req->in.h.total_extlen = args->in_args[args->ext_idx].size / 8;
 	if (args->end)
 		__set_bit(FR_ASYNC, &req->flags);
 }
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index aa67869e3444..c227ce87b100 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -466,7 +466,7 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 }
 
 static int get_security_context(struct dentry *entry, umode_t mode,
-				void **security_ctx, u32 *security_ctxlen)
+				struct fuse_in_arg *ext)
 {
 	struct fuse_secctx *fctx;
 	struct fuse_secctx_header *header;
@@ -513,14 +513,42 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 
 		memcpy(ptr, ctx, ctxlen);
 	}
-	*security_ctxlen = total_len;
-	*security_ctx = header;
+	ext->size = total_len;
+	ext->value = header;
 	err = 0;
 out_err:
 	kfree(ctx);
 	return err;
 }
 
+static int get_create_ext(struct fuse_args *args, struct dentry *dentry,
+			  umode_t mode)
+{
+	struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
+	struct fuse_in_arg ext = { .size = 0, .value = NULL };
+	int err = 0;
+
+	if (fc->init_security)
+		err = get_security_context(dentry, mode, &ext);
+
+	if (!err && ext.size) {
+		WARN_ON(args->in_numargs >= ARRAY_SIZE(args->in_args));
+		args->is_ext = true;
+		args->ext_idx = args->in_numargs++;
+		args->in_args[args->ext_idx] = ext;
+	} else {
+		kfree(ext.value);
+	}
+
+	return err;
+}
+
+static void free_ext_value(struct fuse_args *args)
+{
+	if (args->is_ext)
+		kfree(args->in_args[args->ext_idx].value);
+}
+
 /*
  * Atomic create+open operation
  *
@@ -541,8 +569,6 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	struct fuse_entry_out outentry;
 	struct fuse_inode *fi;
 	struct fuse_file *ff;
-	void *security_ctx = NULL;
-	u32 security_ctxlen;
 	bool trunc = flags & O_TRUNC;
 
 	/* Userspace expects S_IFREG in create mode */
@@ -586,19 +612,12 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	args.out_args[1].size = sizeof(outopen);
 	args.out_args[1].value = &outopen;
 
-	if (fm->fc->init_security) {
-		err = get_security_context(entry, mode, &security_ctx,
-					   &security_ctxlen);
-		if (err)
-			goto out_put_forget_req;
-
-		args.in_numargs = 3;
-		args.in_args[2].size = security_ctxlen;
-		args.in_args[2].value = security_ctx;
-	}
+	err = get_create_ext(&args, entry, mode);
+	if (err)
+		goto out_put_forget_req;
 
 	err = fuse_simple_request(fm, &args);
-	kfree(security_ctx);
+	free_ext_value(&args);
 	if (err)
 		goto out_free_ff;
 
@@ -705,8 +724,6 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	struct dentry *d;
 	int err;
 	struct fuse_forget_link *forget;
-	void *security_ctx = NULL;
-	u32 security_ctxlen;
 
 	if (fuse_is_bad(dir))
 		return -EIO;
@@ -721,21 +738,14 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	args->out_args[0].size = sizeof(outarg);
 	args->out_args[0].value = &outarg;
 
-	if (fm->fc->init_security && args->opcode != FUSE_LINK) {
-		err = get_security_context(entry, mode, &security_ctx,
-					   &security_ctxlen);
+	if (args->opcode != FUSE_LINK) {
+		err = get_create_ext(args, entry, mode);
 		if (err)
 			goto out_put_forget_req;
-
-		BUG_ON(args->in_numargs != 2);
-
-		args->in_numargs = 3;
-		args->in_args[2].size = security_ctxlen;
-		args->in_args[2].value = security_ctx;
 	}
 
 	err = fuse_simple_request(fm, args);
-	kfree(security_ctx);
+	free_ext_value(args);
 	if (err)
 		goto out_put_forget_req;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d339b1ace887..31e2ca0d2788 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -249,8 +249,9 @@ struct fuse_page_desc {
 struct fuse_args {
 	uint64_t nodeid;
 	uint32_t opcode;
-	unsigned short in_numargs;
-	unsigned short out_numargs;
+	uint8_t in_numargs;
+	uint8_t out_numargs;
+	uint8_t ext_idx;
 	bool force:1;
 	bool noreply:1;
 	bool nocreds:1;
@@ -261,6 +262,7 @@ struct fuse_args {
 	bool page_zeroing:1;
 	bool page_replace:1;
 	bool may_block:1;
+	bool is_ext:1;
 	struct fuse_in_arg in_args[3];
 	struct fuse_arg out_args[2];
 	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e3c54109bae9..c71f12429e3d 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -201,6 +201,9 @@
  *  7.38
  *  - add FUSE_EXPIRE_ONLY flag to fuse_notify_inval_entry
  *  - add FOPEN_PARALLEL_DIRECT_WRITES
+ *  - add total_extlen to fuse_in_header
+ *  - add FUSE_MAX_NR_SECCTX
+ *  - add extension header
  */
 
 #ifndef _LINUX_FUSE_H
@@ -503,6 +506,15 @@ struct fuse_file_lock {
  */
 #define FUSE_EXPIRE_ONLY		(1 << 0)
 
+/**
+ * extension type
+ * FUSE_MAX_NR_SECCTX: maximum value of &fuse_secctx_header.nr_secctx
+ */
+enum fuse_ext_type {
+	/* Types 0..31 are reserved for fuse_secctx_header */
+	FUSE_MAX_NR_SECCTX	= 31,
+};
+
 enum fuse_opcode {
 	FUSE_LOOKUP		= 1,
 	FUSE_FORGET		= 2,  /* no reply */
@@ -886,7 +898,8 @@ struct fuse_in_header {
 	uint32_t	uid;
 	uint32_t	gid;
 	uint32_t	pid;
-	uint32_t	padding;
+	uint16_t	total_extlen; /* length of extensions in 8byte units */
+	uint16_t	padding;
 };
 
 struct fuse_out_header {
@@ -1047,4 +1060,17 @@ struct fuse_secctx_header {
 	uint32_t	nr_secctx;
 };
 
+/**
+ * struct fuse_ext_header - extension header
+ * @size: total size of this extension including this header
+ * @type: type of extension
+ *
+ * This is made compatible with fuse_secctx_header by using type values >
+ * FUSE_MAX_NR_SECCTX
+ */
+struct fuse_ext_header {
+	uint32_t	size;
+	uint32_t	type;
+};
+
 #endif /* _LINUX_FUSE_H */
-- 
2.38.1

