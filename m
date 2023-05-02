Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5425D6F4424
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 14:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjEBMsg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 08:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbjEBMsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 08:48:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128965FD9;
        Tue,  2 May 2023 05:48:28 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-2f7db354092so2284658f8f.2;
        Tue, 02 May 2023 05:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683031706; x=1685623706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5eU89oHST/7fvITjEeMaKb7E2zwQgt9tUDlip0QRSg=;
        b=o+UEpohY74fcEJiG8P+67E+mLiuCU2d0fV84RfcfQJkM0uOfetuuTHO8b67SK2e2Xp
         DsUbGzgc2TDvomNaYWa7xvpqmlBorBf9s0dcWVw8nK12EWMnukS0POs9sBoJb35fS9Du
         Yuj9FeAmC+ZfA+nZ1cpdNtBQCCOtwXuHrD7WJ9TzYZqDh921wFNVkCZbchpTeyy9qIbC
         pyW93PTkMarctKPhvCafJCh2CGYNCU9ch8Ww1fVBatBhvV6dXecbF3judlWwtzO94l9C
         nQvbSmy8rJxX56ElHdJbDsRQDR84lcNC8Vm4Cc0osU5BRiQRVMDnB38xYMQhWoAu+Rsa
         QqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683031706; x=1685623706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5eU89oHST/7fvITjEeMaKb7E2zwQgt9tUDlip0QRSg=;
        b=Hk/OP4/364WucQlukhxY8GUtZ3H6S4qoDnDYEwMAgg3Ur8JI3V9J9QhNF8ilb4Zdk6
         G00FOyFuV5keZ3XRi3qhcnMWafL/u4SCD47UU1fcebiDqUBfjZHcRFUiE7vlL9Lf9rtt
         5vW6yOHf0I7iywe033E02m9Dz3Iqbk2NSo74DlvsiX7gCqdhPB2CAECOO4Xaqn/7rXb/
         Z3UZ4UDP7CjBk4FQp+hb5izjUoemys03j+YpAjs9aVtAwSgc58/c3EbGatfNwLIb/Fam
         hMUGGPyMXn8mnFIyChbh6xtLS07Rkrv6w52Knoe0bqShcje2t/RbJzp53z19I02kAc4H
         5gRw==
X-Gm-Message-State: AC+VfDzscwTToZVe1DZwX8YPpou8BpLjjE/vTrAzgNPPAJnAGGARzKYX
        IL0cqToH/dlCtm2d8PUYtcKUaLMgCEQ=
X-Google-Smtp-Source: ACHHUZ5IJscLTLN+QUx5LvObb1s7wrOlbQnauB/Od2TkLY9KPcJA7WL/v56SFC0m3dxVitK+cNM2lw==
X-Received: by 2002:adf:e647:0:b0:306:3153:d2fe with SMTP id b7-20020adfe647000000b003063153d2femr3170243wrn.27.1683031706531;
        Tue, 02 May 2023 05:48:26 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d6dc9000000b00304adbeeabbsm14226259wrz.99.2023.05.02.05.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 05:48:26 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 2/4] exportfs: add explicit flag to request non-decodeable file handles
Date:   Tue,  2 May 2023 15:48:15 +0300
Message-Id: <20230502124817.3070545-3-amir73il@gmail.com>
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

So far, all callers of exportfs_encode_inode_fh(), except for fsnotify's
show_mark_fhandle(), check that filesystem can decode file handles, but
we would like to add more callers that do not require a file handle that
can be decoded.

Introduce a flag to explicitly request a file handle that may not to be
decoded later and a wrapper exportfs_encode_fid() that sets this flag
and convert show_mark_fhandle() to use the new wrapper.

This will be used to allow adding fanotify support to filesystems that
do not support NFS export.

Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 Documentation/filesystems/nfs/exporting.rst |  4 ++--
 fs/exportfs/expfs.c                         | 20 ++++++++++++++++++--
 fs/notify/fanotify/fanotify.c               |  4 ++--
 fs/notify/fdinfo.c                          |  2 +-
 include/linux/exportfs.h                    | 12 +++++++++++-
 5 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index 0e98edd353b5..3d97b8d8f735 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -122,8 +122,8 @@ are exportable by setting the s_export_op field in the struct
 super_block.  This field must point to a "struct export_operations"
 struct which has the following members:
 
- encode_fh  (optional)
-    Takes a dentry and creates a filehandle fragment which can later be used
+  encode_fh (optional)
+    Takes a dentry and creates a filehandle fragment which may later be used
     to find or create a dentry for the same object.  The default
     implementation creates a filehandle fragment that encodes a 32bit inode
     and generation number for the inode encoded, and if necessary the
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index ab7feffe2d19..40e624cf7e92 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -381,11 +381,27 @@ static int export_encode_fh(struct inode *inode, struct fid *fid,
 	return type;
 }
 
+/**
+ * exportfs_encode_inode_fh - encode a file handle from inode
+ * @inode:   the object to encode
+ * @fid:     where to store the file handle fragment
+ * @max_len: maximum length to store there
+ * @flags:   properties of the requested file handle
+ *
+ * Returns an enum fid_type or a negative errno.
+ */
 int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
-			     int *max_len, struct inode *parent)
+			     int *max_len, struct inode *parent, int flags)
 {
 	const struct export_operations *nop = inode->i_sb->s_export_op;
 
+	/*
+	 * If a decodeable file handle was requested, we need to make sure that
+	 * filesystem can decode file handles.
+	 */
+	if (nop && !(flags & EXPORT_FH_FID) && !nop->fh_to_dentry)
+		return -EOPNOTSUPP;
+
 	if (nop && nop->encode_fh)
 		return nop->encode_fh(inode, fid->raw, max_len, parent);
 
@@ -418,7 +434,7 @@ int exportfs_encode_fh(struct dentry *dentry, struct fid *fid, int *max_len,
 		parent = p->d_inode;
 	}
 
-	error = exportfs_encode_inode_fh(inode, fid, max_len, parent);
+	error = exportfs_encode_inode_fh(inode, fid, max_len, parent, flags);
 	dput(p);
 
 	return error;
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 29bdd99b29fa..d1a49f5b6e6d 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -380,7 +380,7 @@ static int fanotify_encode_fh_len(struct inode *inode)
 	if (!inode)
 		return 0;
 
-	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
+	exportfs_encode_inode_fh(inode, NULL, &dwords, NULL, 0);
 	fh_len = dwords << 2;
 
 	/*
@@ -443,7 +443,7 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	}
 
 	dwords = fh_len >> 2;
-	type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
+	type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL, 0);
 	err = -EINVAL;
 	if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
 		goto out_err;
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 55081ae3a6ec..5c430736ec12 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -50,7 +50,7 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 	f.handle.handle_bytes = sizeof(f.pad);
 	size = f.handle.handle_bytes >> 2;
 
-	ret = exportfs_encode_inode_fh(inode, (struct fid *)f.handle.f_handle, &size, NULL);
+	ret = exportfs_encode_fid(inode, (struct fid *)f.handle.f_handle, &size);
 	if ((ret == FILEID_INVALID) || (ret < 0)) {
 		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
 		return;
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 66e16022cc3d..ec86ea4fa5c1 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -136,6 +136,7 @@ struct fid {
 };
 
 #define EXPORT_FH_CONNECTABLE	0x1 /* Encode file handle with parent */
+#define EXPORT_FH_FID		0x2 /* File handle may be non-decodeable */
 
 /**
  * struct export_operations - for nfsd to communicate with file systems
@@ -226,9 +227,18 @@ struct export_operations {
 };
 
 extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
-				    int *max_len, struct inode *parent);
+				    int *max_len, struct inode *parent,
+				    int flags);
 extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
 			      int *max_len, int flags);
+
+static inline int exportfs_encode_fid(struct inode *inode, struct fid *fid,
+				      int *max_len)
+{
+	return exportfs_encode_inode_fh(inode, fid, max_len, NULL,
+					EXPORT_FH_FID);
+}
+
 extern struct dentry *exportfs_decode_fh_raw(struct vfsmount *mnt,
 					     struct fid *fid, int fh_len,
 					     int fileid_type,
-- 
2.34.1

