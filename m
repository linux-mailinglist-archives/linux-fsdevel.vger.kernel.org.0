Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6572059AF6D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 20:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiHTSNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 14:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiHTSNA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:13:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C63402E4
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 11:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
        Cc:Content-Type:Content-ID:Content-Description;
        bh=NVFIlRHS1mQXkCTXMpYD4h/KcIIjPqHuwQ+73guKeUA=; b=E+cX3XJoWNAkwRjdEURgTAqxnk
        guvxgHAIwSFH41nvPnKCpu3POrUOvXGmMheK73h/6UQS22VjcSfr2+1DGfG5y5VRiIvNLKKMpmD3u
        w+SaEhTLM/ZFTPsV9UW4i4uyMlJ8p8c86t1npS/y2gQHvKE0JIuzeqxihsdOr0zZLA02oo62vNXc7
        EjCIpSQzYQ9WNKA5Rar4Hb4Y+Wu3T2yg3t6yMUDwGrI3Hc+pB7kusVAkUSBONz12YoheoYF8m99kx
        UtIl/yFlMRZlnPPj5o5e8L/caYo2ftxqehZScNtlVXoYzVc/rqJNmdtTrIQE43eKQgKCjbkQQHT2W
        AKzVum8A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPSxt-006RW9-QT
        for linux-fsdevel@vger.kernel.org;
        Sat, 20 Aug 2022 18:12:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/11] ecryptfs: constify path
Date:   Sat, 20 Aug 2022 19:12:56 +0100
Message-Id: <20220820181256.1535714-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181256.1535714-1-viro@zeniv.linux.org.uk>
References: <YwEjnoTgi7K6iijN@ZenIV>
 <20220820181256.1535714-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ecryptfs/ecryptfs_kernel.h | 2 +-
 fs/ecryptfs/file.c            | 2 +-
 fs/ecryptfs/inode.c           | 2 +-
 fs/ecryptfs/main.c            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index 5f2b49e13731..f2ed0c0266cb 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -506,7 +506,7 @@ ecryptfs_dentry_to_lower(struct dentry *dentry)
 	return ((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path.dentry;
 }
 
-static inline struct path *
+static inline const struct path *
 ecryptfs_dentry_to_lower_path(struct dentry *dentry)
 {
 	return &((struct ecryptfs_dentry_info *)dentry->d_fsdata)->lower_path;
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 18d5b91cb573..195f7c2a16e8 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -33,7 +33,7 @@ static ssize_t ecryptfs_read_update_atime(struct kiocb *iocb,
 				struct iov_iter *to)
 {
 	ssize_t rc;
-	struct path *path;
+	const struct path *path;
 	struct file *file = iocb->ki_filp;
 
 	rc = generic_file_read_iter(iocb, to);
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 16d50dface59..c214fe0981bd 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -317,7 +317,7 @@ static int ecryptfs_i_size_read(struct dentry *dentry, struct inode *inode)
 static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
 				     struct dentry *lower_dentry)
 {
-	struct path *path = ecryptfs_dentry_to_lower_path(dentry->d_parent);
+	const struct path *path = ecryptfs_dentry_to_lower_path(dentry->d_parent);
 	struct inode *inode, *lower_inode;
 	struct ecryptfs_dentry_info *dentry_info;
 	int rc = 0;
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 2dd23a82e0de..2dc927ba067f 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -105,7 +105,7 @@ static int ecryptfs_init_lower_file(struct dentry *dentry,
 				    struct file **lower_file)
 {
 	const struct cred *cred = current_cred();
-	struct path *path = ecryptfs_dentry_to_lower_path(dentry);
+	const struct path *path = ecryptfs_dentry_to_lower_path(dentry);
 	int rc;
 
 	rc = ecryptfs_privileged_open(lower_file, path->dentry, path->mnt,
-- 
2.30.2

