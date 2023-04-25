Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED5C6EE265
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 15:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjDYNBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 09:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbjDYNBa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:01:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0EC12C92;
        Tue, 25 Apr 2023 06:01:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-2efbaad9d76so5200376f8f.0;
        Tue, 25 Apr 2023 06:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682427679; x=1685019679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9xUvPIR9YLXLpI8s4IyvOwHGU7lC6DMVY6LhbyQcis=;
        b=c5H83O/dyY5rC/DsQGMeqwhHXKeC/QN7H1Ob2bVTEa/3nmZ5Fu6KL+GvNcNWu8AfPB
         O6YMtVZ7158Q96U++43T3qi216gF6cBN9QwrGixG1TtVk8GCoSwSJJmuaeS+p4zy/rgk
         tIIs2ZjVytOHd5/jf5Jr+/jtZ7OtMpzyqcoWqvhlJCXX5wyRVdws59VCIkm1STpcV/cr
         AuBHbOqYVdvZ+D3EZAifWU1HNMefh7BCnB8/yZAj5WjNIVKCB34w5ilvE+aqrqQZW0eE
         KTMvmSGVzaA1waKf20jk5903/q8YpTWhSHC+vyBvXEDQde5EGUd9HFoaqBW8Z4bGNWYw
         17sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682427679; x=1685019679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9xUvPIR9YLXLpI8s4IyvOwHGU7lC6DMVY6LhbyQcis=;
        b=ZVmL1yI8EXpJqT7F1R6WPrbtUJA662X3yL02w/VzWIVKXI3rkp72VnlDekW3zSZ7wx
         t+h3cwSaZfz9orcOm6Aw4b2IsDqFcV/vfblFuDezgmLKQZ5ZJ03O3iOcMAYduBqA1ohA
         3GrApcL8upnUbkT930lj9y70f1I/N/1vVW0vL6CkclMH9LF3ZkXIqAl9OUmJG3dNeMxQ
         cxnVhaXzFibnKSwWoqoEZX+VTP7WSQ9ZDnwRnwsQJ2xcSWge4CvrhPNB2ngD2en0OQe1
         I5ciwRePethelxtIFZCS8GbMQpfCO5Xl5SV5oka5w6+XuU1vk5Wg6/j1PEuPWCHnY5lo
         HkrQ==
X-Gm-Message-State: AAQBX9dL1V52xtu7H4BavxgFFfIG6rYh+/6YKpOW8RDvi4dBRaOImeLd
        LBG3N5py+ikX5dxhogG9Ny4=
X-Google-Smtp-Source: AKy350boXxmZ1Hl1nBkanykNzW4O2lCZ0w2JwT/XslcgA/2RCJGB8XJapXvDUDlM6KWtau7OX429Eg==
X-Received: by 2002:adf:dfc3:0:b0:2fe:f2d1:dcab with SMTP id q3-20020adfdfc3000000b002fef2d1dcabmr12046518wrn.58.1682427678361;
        Tue, 25 Apr 2023 06:01:18 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id s1-20020adff801000000b00300aee6c9cesm13103447wrp.20.2023.04.25.06.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:01:18 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [RFC][PATCH 3/4] exportfs: allow exporting non-decodeable file handles to userspace
Date:   Tue, 25 Apr 2023 16:01:04 +0300
Message-Id: <20230425130105.2606684-4-amir73il@gmail.com>
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

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fhandle.c               | 20 ++++++++++++--------
 include/uapi/linux/fcntl.h |  5 +++++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index f2bc27d1975e..131c23ae77d8 100644
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
@@ -24,11 +24,12 @@ static long do_sys_name_to_handle(const struct path *path,
 	struct file_handle *handle = NULL;
 
 	/*
-	 * We need to make sure whether the file system
-	 * support decoding of the file handle
+	 * We need to make sure whether the file system support decoding of
+	 * the file handle if decodeable file handle was requested.
 	 */
 	if (!path->dentry->d_sb->s_export_op ||
-	    !path->dentry->d_sb->s_export_op->fh_to_dentry)
+	    (!(fh_flags & EXPORT_FH_FID) &&
+	     !path->dentry->d_sb->s_export_op->fh_to_dentry))
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle)))
@@ -45,10 +46,10 @@ static long do_sys_name_to_handle(const struct path *path,
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
@@ -84,6 +85,7 @@ static long do_sys_name_to_handle(const struct path *path,
  * @handle: resulting file handle
  * @mnt_id: mount id of the file system containing the file
  * @flag: flag value to indicate whether to follow symlink or not
+ *        and whether a decodable file handle is required.
  *
  * @handle->handle_size indicate the space available to store the
  * variable part of the file handle in bytes. If there is not
@@ -96,17 +98,19 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
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

