Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A633A5E5DCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 10:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiIVIpd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 04:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIVIpA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B21FABD47
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663836298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sCqc/9Xx1Mg6CDOhiBaD4VyKFWMPu9fiwnLMKTncAc0=;
        b=ibZIvd5xhh6ANlLwn//Kpt5jE2kJLVTC1L9IqJks9eJAyDiOmxnFHj4WP6mNKmjWIPYVTb
        jnj0k7FKhg+tyW75MKrIB2+eiZCaJxvXpElCw+57dzkqHb77OCZnh/2k4xVA0CVOoeFzoy
        o7PinL0mA6BlYvtjyTa36S7wHd5liCk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-626-JCr7Qe78O8SdGXVhS1Yk4g-1; Thu, 22 Sep 2022 04:44:57 -0400
X-MC-Unique: JCr7Qe78O8SdGXVhS1Yk4g-1
Received: by mail-ed1-f72.google.com with SMTP id h13-20020a056402280d00b004528c8400afso6078117ede.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sCqc/9Xx1Mg6CDOhiBaD4VyKFWMPu9fiwnLMKTncAc0=;
        b=65jAa2i7qI2MRPcaUZO+lF2XM2FFqchiX7wnuEDH3wJFeez0Tiq8he5f3qY0UyRBG6
         uiM0XRqYBZdxBpUhMDNi8cPcadeGiEAOzwLypQ2rZ2nH5lRT8yuIfdQ/3oEyDNCcAe0L
         +ze2BONV01CfGllPsinOsnWOhPhrcbh9FNWqG5YiRw0lQenLCA7Qgn9tGQKQo9sg1qfx
         WEjvVF9ik9L2lIpLDgHEiV6WX8QGcgLWco4fDqmjL/vI6wKE9SSTnU07Hrr9toeejSeH
         WQo4hI+W/lhSskNbNedL2qwvcvGLxZFWs1WSEnogpq9AYtLMv4kUIpKr5DRrMKwA8UUn
         2fAA==
X-Gm-Message-State: ACrzQf1iWHeVXWfrNHNAZEA06t40QvC2ocurdKQm6AisKH8Qk1yEDvqD
        UDkplsxwfLpXBkcJX5/A4M2lzgwPGZ+/vm9DA3qyLm6y6q8xVUEDJ/GT4bZ9NXTtb/uvVVFmgoP
        T5D8FcJ0IPF9oucJ2B5XVvbB2DDT1no8/3dk1/HuWYp5XXadrr1Zs32echU/iRfKW3zdLVINE7c
        DZCA==
X-Received: by 2002:a17:906:974d:b0:780:2c07:7617 with SMTP id o13-20020a170906974d00b007802c077617mr1805128ejy.707.1663836295840;
        Thu, 22 Sep 2022 01:44:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Kfio+BwfvFTeZq/Wq4V2OTvFkLsQN+9/TKY21Iueoy5yJCvYFjHbjrm04GCk4k6ZwBGXG9g==
X-Received: by 2002:a17:906:974d:b0:780:2c07:7617 with SMTP id o13-20020a170906974d00b007802c077617mr1805110ejy.707.1663836295624;
        Thu, 22 Sep 2022 01:44:55 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id h15-20020a170906718f00b00730b3bdd8d7sm2297942ejk.179.2022.09.22.01.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:44:55 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v4 10/10] fuse: implement ->tmpfile()
Date:   Thu, 22 Sep 2022 10:44:42 +0200
Message-Id: <20220922084442.2401223-11-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922084442.2401223-1-mszeredi@redhat.com>
References: <20220922084442.2401223-1-mszeredi@redhat.com>
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
 fs/fuse/dir.c             | 24 +++++++++++++++++++++---
 fs/fuse/fuse_i.h          |  3 +++
 include/uapi/linux/fuse.h |  6 +++++-
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b585b04e815e..bb97a384dc5d 100644
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
@@ -802,6 +802,23 @@ static int fuse_create(struct user_namespace *mnt_userns, struct inode *dir,
 	return fuse_mknod(&init_user_ns, dir, entry, mode, 0);
 }
 
+static int fuse_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+			struct file *file, umode_t mode)
+{
+	struct fuse_conn *fc = get_fuse_conn(dir);
+	int err;
+
+	if (fc->no_tmpfile)
+		return -EOPNOTSUPP;
+
+	err = fuse_create_open(dir, file->f_path.dentry, file, file->f_flags, mode, FUSE_TMPFILE);
+	if (err == -ENOSYS) {
+		fc->no_tmpfile = 1;
+		err = -EOPNOTSUPP;
+	}
+	return err;
+}
+
 static int fuse_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		      struct dentry *entry, umode_t mode)
 {
@@ -1913,6 +1930,7 @@ static const struct inode_operations fuse_dir_inode_operations = {
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

