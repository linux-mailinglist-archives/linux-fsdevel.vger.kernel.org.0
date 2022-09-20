Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3F65BEDE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 21:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiITTg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 15:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiITTgt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FBF76450
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663702607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGsSwi5yFIWxEALJ9auZ58Wh8GXaKXFvqfjaGSnnGHs=;
        b=PTmuIrw2IJXvQatID03BLp2gMfYhfZRzWuf01j319s55Z0tkoHfUVBK1fuHz83fCnE4auj
        /rYxXZjgJkW8KqmDUmPJaMrO4SBlPpoeRGSXx037/Xy9o2LQSBo/Cfz39jVfugdqfKH68A
        +37ha5fJ4BF0rgblxQbF3R8WFYVPz1Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-647-Lcdr66gLMDOfWrDrodSu8g-1; Tue, 20 Sep 2022 15:36:46 -0400
X-MC-Unique: Lcdr66gLMDOfWrDrodSu8g-1
Received: by mail-ed1-f70.google.com with SMTP id b17-20020a056402351100b00453b19d9bd0so2593436edd.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wGsSwi5yFIWxEALJ9auZ58Wh8GXaKXFvqfjaGSnnGHs=;
        b=HDHw593pX+LjQPsNXzjU8g2FBReD7ObR0ijBdAVfdtCT6OA9rBpnHFisRH7PzbKXFT
         yN/VyS2mP0Kw4EHsyLFnbS7vTPVW++ddzwdYbScSi53o5EwonaKeAqybMImgZPTIbV0/
         UwvAQm79JtBQdDp1oyWhTNkom78PdAczZJ/DlaQehhFUtoGL0d0aAohBa9fAVfZ6u+2l
         hO8daZEElQyzwaewLJDRIJQBV7oVueetxyUFYWU4/umNs3VTEIr30LdhqbscsyWW75bT
         BZR5/0pTnLMRCHlRwYN+TPT+A0g67aHOMxiDUF4f0T0fe7xTFoU5AhH8uRORFB+Eomts
         QVJQ==
X-Gm-Message-State: ACrzQf0O6S1a/BaRxZVNvRDtI3svXx9/9nqBq/JKgkbkQqViPhHMcZyi
        bBz0MoSozQlMhNAyByuwirg0hDPkO5Qe3lQ81XNu8jIrTZtlskSt4YKnwlzmAvUjbMPAedQkKbo
        Ll/aVSi1hbU2vyKAzyKOCCgrEEhho0pgXRCGPk+7QuMuCgfC37/KC5qvKX9Z4wrCRbgijNGJofb
        5xFg==
X-Received: by 2002:a17:907:708:b0:77e:ff47:34b1 with SMTP id xb8-20020a170907070800b0077eff4734b1mr17154646ejb.493.1663702604645;
        Tue, 20 Sep 2022 12:36:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5UaQvrzWJtu2BDP/KeufmLupRj2KtmYxBCUP0ksAIPqvqP2Wez9QuHmYSeBUPu076mBS6K+Q==
X-Received: by 2002:a17:907:708:b0:77e:ff47:34b1 with SMTP id xb8-20020a170907070800b0077eff4734b1mr17154628ejb.493.1663702604370;
        Tue, 20 Sep 2022 12:36:44 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id p5-20020aa7d305000000b0045184540cecsm391821edq.36.2022.09.20.12.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:36:44 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v3 9/9] fuse: implement ->tmpfile()
Date:   Tue, 20 Sep 2022 21:36:32 +0200
Message-Id: <20220920193632.2215598-10-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920193632.2215598-1-mszeredi@redhat.com>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
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

