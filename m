Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9809F6EE262
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 15:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjDYNBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 09:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjDYNB0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:01:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DC213C1F;
        Tue, 25 Apr 2023 06:01:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-959a3e2dd27so452843366b.3;
        Tue, 25 Apr 2023 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682427676; x=1685019676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOkLkZmpqVJaFOtGQzRvhxB5greFVHBOKxzvyznomIo=;
        b=icV34QTT+Z8ylwJFCQ5iCsjQaLjsp7fJQuFvOh6EHEOYbwA4kWGDaFfv63oXxGbvpw
         cKMXU9JHCTP2eJTIb6kDfLgyRSl72SiUtCqFWC+7XAJY/fCLQkntb2tsJ2KnAjY1DtlV
         sdwqF9qFaX7VESu8IwoSG8HG/Nef8shJmgPRAt988Nrlba54dy4nTrFuiqsU0z34cqVl
         yP5GnL0b5Qdg0U00IKlogyPNAroP6qUURSGNWr9/gilE6wr1amJAudngE5SSy5EnjqCu
         eph9PmPw/WCYs+0Ql7Qlv4nMGthk7MQNl3T6GUlndRcD6ctvvBp17D8/hC4a+puv92/b
         GOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682427676; x=1685019676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOkLkZmpqVJaFOtGQzRvhxB5greFVHBOKxzvyznomIo=;
        b=c0bRCY0vlBzDuO3Z/8Qo8sfuAE0jEt9IyjRhNwMmWMCimBHhEwJBqLYwO0lRyNEEZi
         pK9m3jxMfrIM/6pFd/s0evQgnIJHQiXp6Rag3EFTGHO/mHBUPb5PbyGm2T2eN2+I91z0
         0s7Pruy6lkW7YBt3+Rn3d6l+0CXMi4HndHy1P51cp4PkIPbHbVQc5EkK/UY7zRzU5cLF
         GTPURrXF1w5wPSXpt2HbGpiL8x42LHgDXUDG/HHq1eHDt/2t9ujM5qGUzkwmdig670qI
         WotJn1svN8kg7SLSVZIEJ5WpCIM8W5Ew4Y9zcOD2QnaDGKtHjU2d70k/j6DyOWvEJy/A
         NsNg==
X-Gm-Message-State: AAQBX9fdZUHSrCSHPcLdw7dFouAyqMVw2Lx9ZPYZuPxlNLT3GmJI1GeC
        w1P7KS2WEaY3it3eUOGdqe0=
X-Google-Smtp-Source: AKy350b0HiprPeKVGEPguaUX9QYrJAeYzL0SE25NknFfr4VZazQnx4i3gLTghsrm7sXUxVFs5rlW0g==
X-Received: by 2002:a17:907:d03:b0:958:4387:5772 with SMTP id gn3-20020a1709070d0300b0095843875772mr10784917ejc.41.1682427675374;
        Tue, 25 Apr 2023 06:01:15 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id s1-20020adff801000000b00300aee6c9cesm13103447wrp.20.2023.04.25.06.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:01:14 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [RFC][PATCH 1/4] exportfs: change connectable argument to bit flags
Date:   Tue, 25 Apr 2023 16:01:02 +0300
Message-Id: <20230425130105.2606684-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425130105.2606684-1-amir73il@gmail.com>
References: <20230425130105.2606684-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the bool connectable arguemnt into a bit flags argument and
define the EXPORT_FS_CONNECTABLE flag as a requested property of the
file handle.

We are going to add a flag for requesting non-decodeable file handles.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/exportfs/expfs.c      | 11 +++++++++--
 fs/nfsd/nfsfh.c          |  5 +++--
 include/linux/exportfs.h |  6 ++++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index ab88d33d106c..bf1b4925fedd 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -393,14 +393,21 @@ int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 }
 EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
 
+/**
+ * exportfs_encode_fh - encode a file handle from dentry
+ * @dentry:  the object to encode
+ * @fid:     where to store the file handle fragment
+ * @max_len: maximum length to store there
+ * @flags:   properties of the requrested file handle
+ */
 int exportfs_encode_fh(struct dentry *dentry, struct fid *fid, int *max_len,
-		int connectable)
+		       int flags)
 {
 	int error;
 	struct dentry *p = NULL;
 	struct inode *inode = dentry->d_inode, *parent = NULL;
 
-	if (connectable && !S_ISDIR(inode->i_mode)) {
+	if ((flags & EXPORT_FH_CONNECTABLE) && !S_ISDIR(inode->i_mode)) {
 		p = dget_parent(dentry);
 		/*
 		 * note that while p might've ceased to be our parent already,
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ccd8485fee04..31e4505c0df3 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -414,10 +414,11 @@ static void _fh_update(struct svc_fh *fhp, struct svc_export *exp,
 		struct fid *fid = (struct fid *)
 			(fhp->fh_handle.fh_fsid + fhp->fh_handle.fh_size/4 - 1);
 		int maxsize = (fhp->fh_maxsize - fhp->fh_handle.fh_size)/4;
-		int subtreecheck = !(exp->ex_flags & NFSEXP_NOSUBTREECHECK);
+		int fh_flags = (exp->ex_flags & NFSEXP_NOSUBTREECHECK) ? 0 :
+				EXPORT_FH_CONNECTABLE;
 
 		fhp->fh_handle.fh_fileid_type =
-			exportfs_encode_fh(dentry, fid, &maxsize, subtreecheck);
+			exportfs_encode_fh(dentry, fid, &maxsize, fh_flags);
 		fhp->fh_handle.fh_size += maxsize * 4;
 	} else {
 		fhp->fh_handle.fh_fileid_type = FILEID_ROOT;
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 601700fedc91..2b1048238170 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -135,6 +135,8 @@ struct fid {
 	};
 };
 
+#define EXPORT_FH_CONNECTABLE	0x1
+
 /**
  * struct export_operations - for nfsd to communicate with file systems
  * @encode_fh:      encode a file handle fragment from a dentry
@@ -150,7 +152,7 @@ struct fid {
  * encode_fh:
  *    @encode_fh should store in the file handle fragment @fh (using at most
  *    @max_len bytes) information that can be used by @decode_fh to recover the
- *    file referred to by the &struct dentry @de.  If the @connectable flag is
+ *    file referred to by the &struct dentry @de.  If @flag has CONNECTABLE bit
  *    set, the encode_fh() should store sufficient information so that a good
  *    attempt can be made to find not only the file but also it's place in the
  *    filesystem.   This typically means storing a reference to de->d_parent in
@@ -226,7 +228,7 @@ struct export_operations {
 extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 				    int *max_len, struct inode *parent);
 extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
-	int *max_len, int connectable);
+			      int *max_len, int flags);
 extern struct dentry *exportfs_decode_fh_raw(struct vfsmount *mnt,
 					     struct fid *fid, int fh_len,
 					     int fileid_type,
-- 
2.34.1

