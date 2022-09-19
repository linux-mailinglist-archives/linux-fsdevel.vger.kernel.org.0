Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06A35BCE1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 16:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiISOLM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 10:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiISOLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FE031EF9
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663596649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGsSwi5yFIWxEALJ9auZ58Wh8GXaKXFvqfjaGSnnGHs=;
        b=Yn7ykJuyCmfzyrtGGuEPUgweYKlEMpkvwrtC5lfOH+gLVOiSgNMWna5kX9a0QWEqrI19V+
        ZVdoWFVD/cqbL282Ak3E2AOjJMN4N0ztOvlE/w7gf9pKPresVu1zAuoD5RxCAf+sOJ+ChI
        isYuyI8T3Tor4byjy+f5hk31yF/lhjo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-1VWcHAo9NVSdzLktCqM2RA-1; Mon, 19 Sep 2022 10:10:47 -0400
X-MC-Unique: 1VWcHAo9NVSdzLktCqM2RA-1
Received: by mail-ed1-f72.google.com with SMTP id dz21-20020a0564021d5500b0045217702048so14884316edb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wGsSwi5yFIWxEALJ9auZ58Wh8GXaKXFvqfjaGSnnGHs=;
        b=7JUyCzAyWk2iobRwZA3z0yFh9S3aQwN6cTkPFjro/CkJ1gAQH+DN8RKmhm5lk/8Jro
         BZc6sOXCxJ0ZeKf0+eR5+tmrwx5mJFk6h83Yz9bJjrenIBj/ZIMWO8daUbr0yMWlTWO7
         Twbg4r6os1R8H174lNcwGxRMQ6USvhrw6Gjz4/b3KimFwW6DElCyaqIFto5S9Ek2QrBn
         wlie4OB7dWXmmpcWLzcaJM4H2FIYh5NOBF+BULmXxWs6wYT2sYzhke6WsbERh60A4aXX
         hto3XsgQsUNe3gQ2+e0uDY1pCtK0Ww2OaDHVAxvK+Vl5mOScf5bnEqNIwA+anCNLGP16
         FiPA==
X-Gm-Message-State: ACrzQf3s33qHbf1995csN5lqyy6EMhMpwsGUvWAyWgM+IZdE7YIFB8U8
        hKipl0zb4vNbMuisMi5F+ln/ChPjqDF8c7wsBK7SEtNdFwC3vx0qWCLKVt1S2vIPamXC5z6hVD/
        gO7LpRbiSVu42kocCwo84cQAp52yaxhfnpGngTSQOIHpSzFYi8KBlDNRSQ7y/5cCCFXYXtKHkPc
        dOJA==
X-Received: by 2002:a17:907:320b:b0:780:280:7b72 with SMTP id xg11-20020a170907320b00b0078002807b72mr13612402ejb.146.1663596646541;
        Mon, 19 Sep 2022 07:10:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5DFGni3UCjR9m4/XHAIxZjoMSqSM8V0Q8vdUp0LLKhI13xy312vPXfJgSKG9i9RyI69u09gw==
X-Received: by 2002:a17:907:320b:b0:780:280:7b72 with SMTP id xg11-20020a170907320b00b0078002807b72mr13612385ejb.146.1663596646263;
        Mon, 19 Sep 2022 07:10:46 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id lb22-20020a170907785600b0073bdf71995dsm9849951ejc.139.2022.09.19.07.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:10:45 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v2 8/8] fuse: implement ->tmpfile()
Date:   Mon, 19 Sep 2022 16:10:31 +0200
Message-Id: <20220919141031.1834447-9-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220919141031.1834447-1-mszeredi@redhat.com>
References: <20220919141031.1834447-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is basically equivalent to the FUSE_CREATE operation which creates and
opens a regular file.

Add a new FUSE_TMPFILE operation, otherwise just reuse the protocol and the
code for FUSE_CREATE.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c             | 25 ++++++++++++++++++++++---
 fs/fuse/fuse_i.h          |  3 +++
 include/uapi/linux/fuse.h |  6 +++++-
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b585b04e815e..01b2d5c5a64a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -529,7 +529,7 @@ static int get_security_context(struct dentry *entry, umode_t mode,
  */
 static int fuse_create_open(struct inode *dir, struct dentry *entry,
 			    struct file *file, unsigned int flags,
-			    umode_t mode)
+			    umode_t mode, u32 opcode)
 {
 	int err;
 	struct inode *inode;
@@ -573,7 +573,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 		inarg.open_flags |= FUSE_OPEN_KILL_SUIDGID;
 	}
 
-	args.opcode = FUSE_CREATE;
+	args.opcode = opcode;
 	args.nodeid = get_node_id(dir);
 	args.in_numargs = 2;
 	args.in_args[0].size = sizeof(inarg);
@@ -676,7 +676,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fc->no_create)
 		goto mknod;
 
-	err = fuse_create_open(dir, entry, file, flags, mode);
+	err = fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
@@ -802,6 +802,24 @@ static int fuse_create(struct user_namespace *mnt_userns, struct inode *dir,
 	return fuse_mknod(&init_user_ns, dir, entry, mode, 0);
 }
 
+static int fuse_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+			struct file *file, umode_t mode)
+{
+	struct fuse_conn *fc = get_fuse_conn(dir);
+	int err;
+
+	if (fc->no_tmpfile)
+		goto no_tmpfile;
+
+	err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
+	if (err == -ENOSYS) {
+		fc->no_tmpfile = 1;
+no_tmpfile:
+		err = -EOPNOTSUPP;
+	}
+	return err;
+}
+
 static int fuse_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		      struct dentry *entry, umode_t mode)
 {
@@ -1913,6 +1931,7 @@ static const struct inode_operations fuse_dir_inode_operations = {
 	.setattr	= fuse_setattr,
 	.create		= fuse_create,
 	.atomic_open	= fuse_atomic_open,
+	.tmpfile	= fuse_tmpfile,
 	.mknod		= fuse_mknod,
 	.permission	= fuse_permission,
 	.getattr	= fuse_getattr,
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 488b460e046f..98a9cf531873 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -784,6 +784,9 @@ struct fuse_conn {
 	/* Does the filesystem support per inode DAX? */
 	unsigned int inode_dax:1;
 
+	/* Is tmpfile not implemented by fs? */
+	unsigned int no_tmpfile:1;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d6ccee961891..76ee8f9e024a 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -194,6 +194,9 @@
  *  - add FUSE_SECURITY_CTX init flag
  *  - add security context to create, mkdir, symlink, and mknod requests
  *  - add FUSE_HAS_INODE_DAX, FUSE_ATTR_DAX
+ *
+ *  7.37
+ *  - add FUSE_TMPFILE
  */
 
 #ifndef _LINUX_FUSE_H
@@ -229,7 +232,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 36
+#define FUSE_KERNEL_MINOR_VERSION 37
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -537,6 +540,7 @@ enum fuse_opcode {
 	FUSE_SETUPMAPPING	= 48,
 	FUSE_REMOVEMAPPING	= 49,
 	FUSE_SYNCFS		= 50,
+	FUSE_TMPFILE		= 51,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
-- 
2.37.3

