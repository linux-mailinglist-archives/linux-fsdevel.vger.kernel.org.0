Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A8B6F442E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 14:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjEBMsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 08:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbjEBMsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 08:48:31 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C35759E5;
        Tue,  2 May 2023 05:48:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f199696149so23104855e9.0;
        Tue, 02 May 2023 05:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683031708; x=1685623708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8BXJ75gYzzYprFFZm4HHrpNV5bb1uDaD8X/yAOq6xE=;
        b=Vej277/uvg5RtQa7PfkAJ+kQyYGnCl/VM/mlzVewXkVZX5bK/5RECW12tqaon7FHfc
         xxj99UwAfDgh89FtLZuvt9zFkZYN3t3dUZp9RVx6iBX0EDpEDTViMiIs5BhFUh0FNZ7C
         p7BvE01KWlL8GTleGJHiAfytwUyqbzIspLU0qutOyWmcNtREhCBvdXGqZgSqSj95jqz/
         6+toPvturMJBjhMzDuSdJiTjfHSMxCz+dMCDE+Z/Ywe2agm5xJmJOc7UseofNGN45b1w
         hvX0/SO48kkX4UhLUY7JshpNWz7qc44sL8ByZ9yW77RUszLaWPqtpjxe+0V17rWwAqdx
         GQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683031708; x=1685623708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8BXJ75gYzzYprFFZm4HHrpNV5bb1uDaD8X/yAOq6xE=;
        b=g4jTTpMTiIh0xqGmEOkTy6d1cgZNMqiiRssv9i8a1hIz7Ii41FbwBG5fk4byPT3ekS
         L3tzcuYqEPyEzkBhL02Cq4/pwNqR37N6WUyK8+DyJg4QiDR+00DMVrOmtoYLhrGL6QwG
         2S7ZyzHS9UEkT2/H5oRFhaoYWA8+aj+14d8LBcNzPzy2bus/K+wjW4Hs6sxZtVQ/rmjA
         i2WRiun6tem90TNyaGPqUJPY3a3xj3RaOdsV6Ky0/3kAm7BRIWKL7OTFyhtQ1HMQ3kYs
         eikMOlUCIn88TIESnnrN8Lw6KGdsOeSl0Ih9G4ke1u2UWzeZhf/UtZHIM6O7ykWKNo+O
         Ba+w==
X-Gm-Message-State: AC+VfDyPVrbSkQydBkLbA/NwCZNvjrnbz4TkUletOp377r9DjYX1IZCC
        xQGItuUy8lii3Wd3/la+QrU=
X-Google-Smtp-Source: ACHHUZ56mV1h2noLhrpy/lUrHlFJl3n9dlxIoFIg3BmoUKvwGkC67UZ83WZ4LmMv/hkbK5kUXT+iYw==
X-Received: by 2002:a05:600c:257:b0:3f0:5887:bea3 with SMTP id 23-20020a05600c025700b003f05887bea3mr12229044wmj.27.1683031707995;
        Tue, 02 May 2023 05:48:27 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d6dc9000000b00304adbeeabbsm14226259wrz.99.2023.05.02.05.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 05:48:27 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 3/4] exportfs: allow exporting non-decodeable file handles to userspace
Date:   Tue,  2 May 2023 15:48:16 +0300
Message-Id: <20230502124817.3070545-4-amir73il@gmail.com>
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

Some userspace programs use st_ino as a unique object identifier, even
though inode numbers may be recycable.

This issue has been addressed for NFS export long ago using the exportfs
file handle API and the unique file handle identifiers are also exported
to userspace via name_to_handle_at(2).

fanotify also uses file handles to identify objects in events, but only
for filesystems that support NFS export.

Relax the requirement for NFS export support and allow more filesystems
to export a unique object identifier via name_to_handle_at(2) with the
flag AT_HANDLE_FID.

A file handle requested with the AT_HANDLE_FID flag, may or may not be
usable as an argument to open_by_handle_at(2).

To allow filesystems to opt-in to supporting AT_HANDLE_FID, a struct
export_operations is required, but even an empty struct is sufficient
for encoding FIDs.

Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fhandle.c               | 22 ++++++++++++++--------
 include/uapi/linux/fcntl.h |  5 +++++
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index f2bc27d1975e..4a635cf787fc 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -16,7 +16,7 @@
 
 static long do_sys_name_to_handle(const struct path *path,
 				  struct file_handle __user *ufh,
-				  int __user *mnt_id)
+				  int __user *mnt_id, int fh_flags)
 {
 	long retval;
 	struct file_handle f_handle;
@@ -24,11 +24,14 @@ static long do_sys_name_to_handle(const struct path *path,
 	struct file_handle *handle = NULL;
 
 	/*
-	 * We need to make sure whether the file system
-	 * support decoding of the file handle
+	 * We need to make sure whether the file system support decoding of
+	 * the file handle if decodeable file handle was requested.
+	 * Otherwise, even empty export_operations are sufficient to opt-in
+	 * to encoding FIDs.
 	 */
 	if (!path->dentry->d_sb->s_export_op ||
-	    !path->dentry->d_sb->s_export_op->fh_to_dentry)
+	    (!(fh_flags & EXPORT_FH_FID) &&
+	     !path->dentry->d_sb->s_export_op->fh_to_dentry))
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle)))
@@ -45,10 +48,10 @@ static long do_sys_name_to_handle(const struct path *path,
 	/* convert handle size to multiple of sizeof(u32) */
 	handle_dwords = f_handle.handle_bytes >> 2;
 
-	/* we ask for a non connected handle */
+	/* we ask for a non connectable maybe decodeable file handle */
 	retval = exportfs_encode_fh(path->dentry,
 				    (struct fid *)handle->f_handle,
-				    &handle_dwords,  0);
+				    &handle_dwords, fh_flags);
 	handle->handle_type = retval;
 	/* convert handle size to bytes */
 	handle_bytes = handle_dwords * sizeof(u32);
@@ -84,6 +87,7 @@ static long do_sys_name_to_handle(const struct path *path,
  * @handle: resulting file handle
  * @mnt_id: mount id of the file system containing the file
  * @flag: flag value to indicate whether to follow symlink or not
+ *        and whether a decodable file handle is required.
  *
  * @handle->handle_size indicate the space available to store the
  * variable part of the file handle in bytes. If there is not
@@ -96,17 +100,19 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
 {
 	struct path path;
 	int lookup_flags;
+	int fh_flags;
 	int err;
 
-	if ((flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0)
+	if (flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH | AT_HANDLE_FID))
 		return -EINVAL;
 
 	lookup_flags = (flag & AT_SYMLINK_FOLLOW) ? LOOKUP_FOLLOW : 0;
+	fh_flags = (flag & AT_HANDLE_FID) ? EXPORT_FH_FID : 0;
 	if (flag & AT_EMPTY_PATH)
 		lookup_flags |= LOOKUP_EMPTY;
 	err = user_path_at(dfd, name, lookup_flags, &path);
 	if (!err) {
-		err = do_sys_name_to_handle(&path, handle, mnt_id);
+		err = do_sys_name_to_handle(&path, handle, mnt_id, fh_flags);
 		path_put(&path);
 	}
 	return err;
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index e8c07da58c9f..3091080db069 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -112,4 +112,9 @@
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 
+/* Flags for name_to_handle_at(2) */
+#define AT_HANDLE_FID		0x10000	/* file handle is needed to compare
+					   object indentity and may not be
+					   usable to open_by_handle_at(2) */
+
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.34.1

