Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B125BB2F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 21:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiIPTog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 15:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiIPTo2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3B21C9
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 12:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663357465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VvSsjYeeLNFAKYPpqwAj5u+RJ7WyP2tyCxzAOfIw+lg=;
        b=NK2IV06MFnT7OEbBQT5yQBjUhDJowEHPhdm47iCjeZl5q3voicrZZzLkwZBx6MRAoKKYf6
        bt1tvsoB7SzJeHSj7jGpB5IXHXvT0UHegdwAx4UMDWIormGaPj4lGEtX31Izx6DuaYpcSH
        6n+66FhM0MCecU8sQt0lpbWlDMCm0XA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-4mfwCDCmPAKeH5-09D7XlA-1; Fri, 16 Sep 2022 15:44:24 -0400
X-MC-Unique: 4mfwCDCmPAKeH5-09D7XlA-1
Received: by mail-ed1-f71.google.com with SMTP id b16-20020a056402279000b0044f1102e6e2so16017927ede.20
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 12:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VvSsjYeeLNFAKYPpqwAj5u+RJ7WyP2tyCxzAOfIw+lg=;
        b=24/QjdaDl1K8VxvFSbeEDfNgqVuaOd0RHlMHSCC7IuX3TMkDPMSuwAuKvmuPxP5sI5
         0SVoYfegq4Z8JG7IJhkpjnQ6FgUHrYYgizcQbc2HrClD2oFCi+l3e3r+XVDSDCQq9Ub0
         46psDbOdOCRq5UaVGbvdqMhUeUntoMsGAnyPJ5ggWwmY3T3wXev4OIeqboBCVCZEIX7H
         upCxeainWonkpLaI1uVKcrMDBSPeUAPoNeS2g1NhO8wyalz1uqEwVkXvaPa491kllSL8
         ujn487QBfaAyyxqsk0AnEX67v+5fpKrRdhmLqA3pDzX4WGO1p0pPopWX5pQA0IvTs5uQ
         3z1g==
X-Gm-Message-State: ACrzQf2vPORm/m759WvU8juAS06hs+uBuK6D5NBBY6oyMk8p8k2TwdzQ
        pGs6dcpGKzMRS5+UFxTHIP+oQ9F9abqkvtXwEktBqZOr7irUrJNe6Gy5+DEsNJc+24sfCdp7wEn
        +W+tOI9+Mm+jmHKv6otW8K7ReIW191xa6reUBzxpgTyPG4bfcZaxTJVwDtQkXcMSM2SPZFygFDN
        JNyg==
X-Received: by 2002:a17:907:6093:b0:780:7671:2c97 with SMTP id ht19-20020a170907609300b0078076712c97mr4600703ejc.8.1663357463057;
        Fri, 16 Sep 2022 12:44:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5XmATNampbtfxyNSOTdK++04hRvOjrqT+i4Gqtk1HPZrzlL6kc3k9z0nIoRXlN/LqVuZ7wUA==
X-Received: by 2002:a17:907:6093:b0:780:7671:2c97 with SMTP id ht19-20020a170907609300b0078076712c97mr4600689ejc.8.1663357462816;
        Fri, 16 Sep 2022 12:44:22 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-212-116.pool.digikabel.hu. [193.226.212.116])
        by smtp.gmail.com with ESMTPSA id r17-20020a17090609d100b0077ce503bd77sm8348592eje.129.2022.09.16.12.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 12:44:22 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH 6/8] vfs: move open right after ->tmpfile()
Date:   Fri, 16 Sep 2022 21:44:14 +0200
Message-Id: <20220916194416.1657716-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220916194416.1657716-1-mszeredi@redhat.com>
References: <20220916194416.1657716-1-mszeredi@redhat.com>
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

Create a helper finish_tmpfile() that opens a file after the tmpfile
creation is done.  Call this helper right after ->tmpfile() is called.

Next patch will change the tmpfile API and move this call into tmpfile
instances.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namei.c         | 65 ++++++++++++++++++++--------------------------
 fs/open.c          | 11 ++++++++
 include/linux/fs.h |  1 +
 3 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index eacaf9ccbaa6..22353853651b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3583,11 +3583,12 @@ static int do_open(struct nameidata *nd,
  * On non-idmapped mounts or if permission checking is to be performed on the
  * raw inode simply passs init_user_ns.
  */
-static struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
-			   struct dentry *dentry, umode_t mode, int open_flag)
+static int vfs_tmpfile(struct user_namespace *mnt_userns,
+		       const struct path *parentpath,
+		       struct file *file, umode_t mode)
 {
-	struct dentry *child = NULL;
-	struct inode *dir = dentry->d_inode;
+	struct dentry *child;
+	struct inode *dir = d_inode(parentpath->dentry);
 	struct inode *inode;
 	int error;
 
@@ -3599,28 +3600,34 @@ static struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 	if (!dir->i_op->tmpfile)
 		goto out_err;
 	error = -ENOMEM;
-	child = d_alloc(dentry, &slash_name);
+	child = d_alloc(parentpath->dentry, &slash_name);
 	if (unlikely(!child))
 		goto out_err;
+	file->f_path.mnt = parentpath->mnt;
+	file->f_path.dentry = child;
 	mode = vfs_prepare_mode(mnt_userns, dir, mode, mode, mode);
 	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
+	error = finish_tmpfile(file, error);
+	dput(child);
+	if (error)
+		goto out_err;
+	error = may_open(mnt_userns, &file->f_path, 0, file->f_flags);
 	if (error)
 		goto out_err;
 	error = -ENOENT;
 	inode = child->d_inode;
 	if (unlikely(!inode))
 		goto out_err;
-	if (!(open_flag & O_EXCL)) {
+	if (!(file->f_flags & O_EXCL)) {
 		spin_lock(&inode->i_lock);
 		inode->i_state |= I_LINKABLE;
 		spin_unlock(&inode->i_lock);
 	}
 	ima_post_create_tmpfile(mnt_userns, inode);
-	return child;
+	return 0;
 
 out_err:
-	dput(child);
-	return ERR_PTR(error);
+	return error;
 }
 
 
@@ -3642,25 +3649,15 @@ struct file *tmpfile_open(struct user_namespace *mnt_userns,
 {
 	struct file *file;
 	int error;
-	struct path path = { .mnt = parentpath->mnt };
-
-	path.dentry = vfs_tmpfile(mnt_userns, parentpath->dentry, mode, open_flag);
-	if (IS_ERR(path.dentry))
-		return ERR_CAST(path.dentry);
-
-	error = may_open(mnt_userns, &path, 0, open_flag);
-	file = ERR_PTR(error);
-	if (error)
-		goto out_dput;
-
-	/*
-	 * This relies on the "noaccount" property of fake open, otherwise
-	 * equivalent to dentry_open().
-	 */
-	file = open_with_fake_path(&path, open_flag, d_inode(path.dentry), cred);
-out_dput:
-	dput(path.dentry);
 
+	file = alloc_empty_file_noaccount(open_flag, cred);
+	if (!IS_ERR(file)) {
+		error = vfs_tmpfile(mnt_userns, parentpath, file, mode);
+		if (error) {
+			fput(file);
+			file = ERR_PTR(error);
+		}
+	}
 	return file;
 }
 EXPORT_SYMBOL(tmpfile_open);
@@ -3671,26 +3668,20 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 		struct file *file)
 {
 	struct user_namespace *mnt_userns;
-	struct dentry *child;
 	struct path path;
 	int error = path_lookupat(nd, flags | LOOKUP_DIRECTORY, &path);
+
 	if (unlikely(error))
 		return error;
 	error = mnt_want_write(path.mnt);
 	if (unlikely(error))
 		goto out;
 	mnt_userns = mnt_user_ns(path.mnt);
-	child = vfs_tmpfile(mnt_userns, path.dentry, op->mode, op->open_flag);
-	error = PTR_ERR(child);
-	if (IS_ERR(child))
+	error = vfs_tmpfile(mnt_userns, &path, file, op->mode);
+	if (error)
 		goto out2;
-	dput(path.dentry);
-	path.dentry = child;
-	audit_inode(nd->name, child, 0);
+	audit_inode(nd->name, file->f_path.dentry, 0);
 	/* Don't check for other permissions, the inode was just created */
-	error = may_open(mnt_userns, &path, 0, op->open_flag);
-	if (!error)
-		error = vfs_open(&path, file);
 out2:
 	mnt_drop_write(path.mnt);
 out:
diff --git a/fs/open.c b/fs/open.c
index 8a813fa5ca56..90ff9d4c0d81 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -975,6 +975,17 @@ int finish_open(struct file *file, struct dentry *dentry,
 }
 EXPORT_SYMBOL(finish_open);
 
+int finish_tmpfile(struct file *file, int error)
+{
+	WARN_ON(file->f_mode & FMODE_OPENED);
+
+	if (error)
+		return error;
+
+	return do_dentry_open(file, d_inode(file->f_path.dentry), NULL);
+}
+EXPORT_SYMBOL(finish_tmpfile);
+
 /**
  * finish_no_open - finish ->atomic_open() without opening the file
  *
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a445da4842e0..8d0e11ba930c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2778,6 +2778,7 @@ extern void putname(struct filename *name);
 
 extern int finish_open(struct file *file, struct dentry *dentry,
 			int (*open)(struct inode *, struct file *));
+extern int finish_tmpfile(struct file *file, int error);
 extern int finish_no_open(struct file *file, struct dentry *dentry);
 
 /* fs/dcache.c */
-- 
2.37.3

