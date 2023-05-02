Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E314D6F4421
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 14:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjEBMsf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 08:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjEBMs2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 08:48:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF1359E1;
        Tue,  2 May 2023 05:48:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3062b101ae1so1650003f8f.2;
        Tue, 02 May 2023 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683031705; x=1685623705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjYpK+xxCL8lt/8cmLRqktVRJYxjE9M35ggTsbeXktw=;
        b=PtNnZDgcd4JaXJYhROzvogPEYsP/mjQAagAXmMeTaE71zXMHmzbrpJbxU8aZxVbfGu
         uqRQO75241GPJSW1gi+ZrXnSxSg80SGiEJTU1xl+YgaWNa/3X+MWvBysFq/x4YzJrZaC
         9RvVlvNLGdfkTWhXujejwbqkoafdEHXOpbgZoOxKTGMYspF2J07PkThFrzq+9bXPELvq
         J2kMg5y//H53h/SSqKxHJre1ABFgDiA76v6zWNCmdxYMlGBj7fF2jqay1kr+RbKkOo0B
         d/33RRtNS7nl3ZBXOTbKqbsyy3xp0T5KFok7kh51s2X5w0KXV4bz+U4XDGqdDlIp1BE2
         aObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683031705; x=1685623705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjYpK+xxCL8lt/8cmLRqktVRJYxjE9M35ggTsbeXktw=;
        b=Ew424nCy2noHV9n72bE2Q3GgMtN9oCy/wCk+BdoqbY39av7uV550iIazHK2u3M3cNo
         nHLRA05iqMuIPaQ3LBw7tZQjIbUhbUzCfvceHd9SiU+TsA9Wnxe2YxTYbAQLwlPk0463
         rcxN4bV0RVqFzcycoI1+dHA66QBqN3sOEjRms0U4h1kuuMHCTH3BN1lKm0qAyPK8Lydk
         rNbOY1NTI2UWPHI8YbDDhIt3kVApF+J6gqaNFFCpQjE+nvf/P3A4jhe9oPYhHcdD272s
         J/3SAVzFH7DQ4Le/+Ar71lRh5AOPLG2n+tgnQ2tuoj8Jv3F9sJJjMlKtkgxDgaYG5qTU
         bEdQ==
X-Gm-Message-State: AC+VfDzaKtGgqyVyD1RplXaqt0Y4wMC/qTOZ/i79MlJZqNikWy37ebOb
        EaxUrjABhnfTAH1afhJAPyM=
X-Google-Smtp-Source: ACHHUZ46pAdh5nrXUz4ensPQsgGhFbH8llcw3yjTXdNKf7VhKZW+HE5WyNeR1pBXIPnhY9qeQOfLqg==
X-Received: by 2002:adf:ff91:0:b0:2d7:4c98:78fe with SMTP id j17-20020adfff91000000b002d74c9878femr11739176wrr.34.1683031704851;
        Tue, 02 May 2023 05:48:24 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d6dc9000000b00304adbeeabbsm14226259wrz.99.2023.05.02.05.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 05:48:24 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 1/4] exportfs: change connectable argument to bit flags
Date:   Tue,  2 May 2023 15:48:14 +0300
Message-Id: <20230502124817.3070545-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230502124817.3070545-1-amir73il@gmail.com>
References: <20230502124817.3070545-1-amir73il@gmail.com>
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

Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/exportfs/expfs.c      | 13 +++++++++++--
 fs/nfsd/nfsfh.c          |  5 +++--
 include/linux/exportfs.h |  6 ++++--
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index ab88d33d106c..ab7feffe2d19 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -393,14 +393,23 @@ int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 }
 EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
 
+/**
+ * exportfs_encode_fh - encode a file handle from dentry
+ * @dentry:  the object to encode
+ * @fid:     where to store the file handle fragment
+ * @max_len: maximum length to store there
+ * @flags:   properties of the requested file handle
+ *
+ * Returns an enum fid_type or a negative errno.
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
index 601700fedc91..66e16022cc3d 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -135,6 +135,8 @@ struct fid {
 	};
 };
 
+#define EXPORT_FH_CONNECTABLE	0x1 /* Encode file handle with parent */
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

