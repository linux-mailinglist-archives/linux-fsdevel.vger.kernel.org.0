Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63BD5BCE1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 16:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiISOKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 10:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiISOKq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720FA32060
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663596642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HtGv9+3gS2D85s/eedKc+SrnAeSzRrunAfJn42YF+SQ=;
        b=R/wU+UxahGFbSBgRcl0U3kvtrOIpXIBc0RVK1DkCC/5FaLK6uyqvcX7tVcYI8Y0mrhabKU
        fiFVBGS3vex7OsEMs30mHpUrtqJASmHe0lPCJIS50YeJ1MHmKtO9Y8yVWEUmXNm+etK9Nb
        BrGKzDGz1+pCfNuivaClN+tGhlPzJCk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-304-bu10oB5CO0m2WKke6vF-2g-1; Mon, 19 Sep 2022 10:10:41 -0400
X-MC-Unique: bu10oB5CO0m2WKke6vF-2g-1
Received: by mail-ej1-f70.google.com with SMTP id xj11-20020a170906db0b00b0077b6ecb23fcso8757107ejb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HtGv9+3gS2D85s/eedKc+SrnAeSzRrunAfJn42YF+SQ=;
        b=6/umAkjfm/+i6JEsl4YYcTYzUu+scsXwiZNbj5ZRk2cd+F0YhQnwfIFjYnGmmM3PK0
         5QwvRWoPTHICh1rIyr/vaucww443cf/309stRtMnVZ83rDOsgcpuwI12zaBEQisxc2aE
         OSdUADMo/gt23YJVt9rkmFuAnLCFPGFK/DUdCfbe1Pjfj1/RAXokKLSftbnKTqZN+ZBU
         AOElAkMQ7itBrU4gPCuXe1AIVhq5TMCiLTS6Iau9kh74aE8T+xrx/tGz1DtGCUoMOg07
         XMZvmFHKMlQvnlbZy8yHmgqLu6/Ck4mAjqrsOBY7lkW6IAmTgykoqQBBlwhLiCf2EdPg
         oQug==
X-Gm-Message-State: ACrzQf1276UbMKnn0La5l1COeP0BAqMd4skueDU94GPUwrGDXAyplswC
        UfwZqnma7n6VSDLmBht76X0hWLl5UZ7Hqum3ZwZeaL8O4I0h6xZq7vI2MD6o3vFoqa7WxGnit9C
        81tZ84AubnqVGj0801lkOH11rroWJbR5bCczbUE3NIsZoq3RkiDLlwAHUX793Ps1OkGNspC9TC8
        pzZA==
X-Received: by 2002:a50:fe91:0:b0:43d:c97d:1b93 with SMTP id d17-20020a50fe91000000b0043dc97d1b93mr15940168edt.67.1663596639576;
        Mon, 19 Sep 2022 07:10:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM61DVDd8dZUkVyi6GvPHJ9UUUJbpAWAdYR9a3TMnGr6dfcYTI2lRzC+CeVpgSyx8c/rtDEqFw==
X-Received: by 2002:a50:fe91:0:b0:43d:c97d:1b93 with SMTP id d17-20020a50fe91000000b0043dc97d1b93mr15940121edt.67.1663596638998;
        Mon, 19 Sep 2022 07:10:38 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id lb22-20020a170907785600b0073bdf71995dsm9849951ejc.139.2022.09.19.07.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:10:38 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v2 4/8] ovl: use tmpfile_open() helper
Date:   Mon, 19 Sep 2022 16:10:27 +0200
Message-Id: <20220919141031.1834447-5-mszeredi@redhat.com>
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

If tmpfile is used for copy up, then use this helper to create the tmpfile
and open it at the same time.  This will later allow filesystems such as
fuse to do this operation atomically.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/copy_up.c   | 49 ++++++++++++++++++++++------------------
 fs/overlayfs/overlayfs.h | 12 ++++++----
 fs/overlayfs/super.c     | 10 ++++----
 3 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index fdde6c56cc3d..ac087b48b5da 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -194,16 +194,16 @@ static int ovl_copy_fileattr(struct inode *inode, struct path *old,
 }
 
 static int ovl_copy_up_data(struct ovl_fs *ofs, struct path *old,
-			    struct path *new, loff_t len)
+			    struct path *new, struct file *new_file, loff_t len)
 {
 	struct file *old_file;
-	struct file *new_file;
 	loff_t old_pos = 0;
 	loff_t new_pos = 0;
 	loff_t cloned;
 	loff_t data_pos = -1;
 	loff_t hole_len;
 	bool skip_hole = false;
+	bool fput_new = false;
 	int error = 0;
 
 	if (len == 0)
@@ -213,10 +213,13 @@ static int ovl_copy_up_data(struct ovl_fs *ofs, struct path *old,
 	if (IS_ERR(old_file))
 		return PTR_ERR(old_file);
 
-	new_file = ovl_path_open(new, O_LARGEFILE | O_WRONLY);
-	if (IS_ERR(new_file)) {
-		error = PTR_ERR(new_file);
-		goto out_fput;
+	if (!new_file) {
+		new_file = ovl_path_open(new, O_LARGEFILE | O_WRONLY);
+		if (IS_ERR(new_file)) {
+			error = PTR_ERR(new_file);
+			goto out_fput;
+		}
+		fput_new = true;
 	}
 
 	/* Try to use clone_file_range to clone up within the same fs */
@@ -285,7 +288,8 @@ static int ovl_copy_up_data(struct ovl_fs *ofs, struct path *old,
 out:
 	if (!error && ovl_should_sync(ofs))
 		error = vfs_fsync(new_file, 0);
-	fput(new_file);
+	if (fput_new)
+		fput(new_file);
 out_fput:
 	fput(old_file);
 	return error;
@@ -556,7 +560,8 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 	return err;
 }
 
-static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c, struct dentry *temp)
+static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c, struct dentry *temp,
+			     struct file *tmpfile)
 {
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct inode *inode = d_inode(c->dentry);
@@ -575,7 +580,7 @@ static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c, struct dentry *temp)
 	 */
 	if (S_ISREG(c->stat.mode) && !c->metacopy) {
 		ovl_path_lowerdata(c->dentry, &datapath);
-		err = ovl_copy_up_data(ofs, &datapath, &upperpath,
+		err = ovl_copy_up_data(ofs, &datapath, &upperpath, tmpfile,
 				       c->stat.size);
 		if (err)
 			return err;
@@ -688,7 +693,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (IS_ERR(temp))
 		goto unlock;
 
-	err = ovl_copy_up_inode(c, temp);
+	err = ovl_copy_up_inode(c, temp, NULL);
 	if (err)
 		goto cleanup;
 
@@ -732,6 +737,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct inode *udir = d_inode(c->destdir);
 	struct dentry *temp, *upper;
+	struct file *tmpfile;
 	struct ovl_cu_creds cc;
 	int err;
 
@@ -739,15 +745,16 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 	if (err)
 		return err;
 
-	temp = ovl_do_tmpfile(ofs, c->workdir, c->stat.mode);
+	tmpfile = ovl_do_tmpfile(ofs, c->workdir, c->stat.mode);
 	ovl_revert_cu_creds(&cc);
 
-	if (IS_ERR(temp))
-		return PTR_ERR(temp);
+	if (IS_ERR(tmpfile))
+		return PTR_ERR(tmpfile);
 
-	err = ovl_copy_up_inode(c, temp);
+	temp = tmpfile->f_path.dentry;
+	err = ovl_copy_up_inode(c, temp, tmpfile);
 	if (err)
-		goto out_dput;
+		goto out_fput;
 
 	inode_lock_nested(udir, I_MUTEX_PARENT);
 
@@ -761,16 +768,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 	inode_unlock(udir);
 
 	if (err)
-		goto out_dput;
+		goto out_fput;
 
 	if (!c->metacopy)
 		ovl_set_upperdata(d_inode(c->dentry));
-	ovl_inode_update(d_inode(c->dentry), temp);
+	ovl_inode_update(d_inode(c->dentry), dget(temp));
 
-	return 0;
-
-out_dput:
-	dput(temp);
+out_fput:
+	fput(tmpfile);
 	return err;
 }
 
@@ -919,7 +924,7 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 			goto out;
 	}
 
-	err = ovl_copy_up_data(ofs, &datapath, &upperpath, c->stat.size);
+	err = ovl_copy_up_data(ofs, &datapath, &upperpath, NULL, c->stat.size);
 	if (err)
 		goto out_free;
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 87759165d32b..259a6e73d0c4 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -310,14 +310,16 @@ static inline int ovl_do_whiteout(struct ovl_fs *ofs,
 	return err;
 }
 
-static inline struct dentry *ovl_do_tmpfile(struct ovl_fs *ofs,
-					    struct dentry *dentry, umode_t mode)
+static inline struct file *ovl_do_tmpfile(struct ovl_fs *ofs,
+					  struct dentry *dentry, umode_t mode)
 {
-	struct dentry *ret = vfs_tmpfile(ovl_upper_mnt_userns(ofs), dentry, mode, 0);
-	int err = PTR_ERR_OR_ZERO(ret);
+	struct path path = { .mnt = ovl_upper_mnt(ofs), .dentry = dentry };
+	struct file *file = tmpfile_open(ovl_upper_mnt_userns(ofs), &path, mode,
+					O_LARGEFILE | O_WRONLY, current_cred());
+	int err = PTR_ERR_OR_ZERO(file);
 
 	pr_debug("tmpfile(%pd2, 0%o) = %i\n", dentry, mode, err);
-	return ret;
+	return file;
 }
 
 static inline struct dentry *ovl_lookup_upper(struct ovl_fs *ofs,
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index ec746d447f1b..7837223689c1 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/exportfs.h>
+#include <linux/file.h>
 #include "overlayfs.h"
 
 MODULE_AUTHOR("Miklos Szeredi <miklos@szeredi.hu>");
@@ -1356,7 +1357,8 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 			    struct path *workpath)
 {
 	struct vfsmount *mnt = ovl_upper_mnt(ofs);
-	struct dentry *temp, *workdir;
+	struct dentry *workdir;
+	struct file *tmpfile;
 	bool rename_whiteout;
 	bool d_type;
 	int fh_type;
@@ -1392,10 +1394,10 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 		pr_warn("upper fs needs to support d_type.\n");
 
 	/* Check if upper/work fs supports O_TMPFILE */
-	temp = ovl_do_tmpfile(ofs, ofs->workdir, S_IFREG | 0);
-	ofs->tmpfile = !IS_ERR(temp);
+	tmpfile = ovl_do_tmpfile(ofs, ofs->workdir, S_IFREG | 0);
+	ofs->tmpfile = !IS_ERR(tmpfile);
 	if (ofs->tmpfile)
-		dput(temp);
+		fput(tmpfile);
 	else
 		pr_warn("upper fs does not support tmpfile.\n");
 
-- 
2.37.3

