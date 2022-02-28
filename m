Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA1B4C7EB5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 00:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiB1Xtp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 18:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiB1Xto (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:49:44 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2034411986E;
        Mon, 28 Feb 2022 15:49:05 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id gl14-20020a17090b120e00b001bc2182c3d5so544932pjb.1;
        Mon, 28 Feb 2022 15:49:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6IFOdR6oIw+0+bym/I6BpLocSpdMrP1ts6sQvK7wP9w=;
        b=2907BNVjHutRMMsB8oFgQ02drEJEhRC8zN5oBOh0piyCJXuSazxXn1MbtTB5j9DqqF
         B/huGxWpGz2igcaZzsP09sH91PoF1ZGJPebbZG7ZcBE+C5qYHBx5grwaSflpLlZe4K39
         mcr5nROHUSZgg1RusW/n0QdejQ6lJuPJfWOZzuItT1S1JYc9Isy3FrdqKC6fLplGF/k5
         WofrBiY97S6NjYIxyTRR5oCuHS6I/13fJbahci38CcH4CIiW3QR8EMst82ZtJPhrYs6C
         5Xhygr/SNaKS3JHs//rdwfLMsjqW5hnhkOA+WJOLn9l7IdPVIiq/PnEjhJ0Eb4PAK33o
         8ZmQ==
X-Gm-Message-State: AOAM530I8QR5rernBsigW5mDMGIHL3fqiQ0G5k4uIf+qGBXRbOzgaRYl
        TqEnQuAEF7Ck1ir8Ao2HSaik0JZUL8U=
X-Google-Smtp-Source: ABdhPJwn7N6ymFHQzd68+zzNifhwJr+WI0b3WOfyU9IjYPtsRWoye2OwUAmX5/Nb5IyfofipFAYgTA==
X-Received: by 2002:a17:90a:550b:b0:1bd:1e3a:a407 with SMTP id b11-20020a17090a550b00b001bd1e3aa407mr12801053pji.112.1646092144205;
        Mon, 28 Feb 2022 15:49:04 -0800 (PST)
Received: from localhost.localdomain ([61.74.27.164])
        by smtp.gmail.com with ESMTPSA id t27-20020aa7939b000000b004ce11b956absm13829905pfe.186.2022.02.28.15.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:49:03 -0800 (PST)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 2/4] ksmbd: remove filename in ksmbd_file
Date:   Tue,  1 Mar 2022 08:48:31 +0900
Message-Id: <20220228234833.10434-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228234833.10434-1-linkinjeon@kernel.org>
References: <20220228234833.10434-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the filename is change by underlying rename the server, fp->filename
and real filename can be different. This patch remove the uses of
fp->filename in ksmbd and replace it with d_path().

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ksmbd/misc.c      | 40 +++++++++++++++++++++++++++++++---------
 fs/ksmbd/misc.h      |  3 ++-
 fs/ksmbd/oplock.c    | 30 ------------------------------
 fs/ksmbd/oplock.h    |  2 --
 fs/ksmbd/smb2pdu.c   | 21 +++++++--------------
 fs/ksmbd/vfs.c       |  6 ++----
 fs/ksmbd/vfs_cache.c |  1 -
 fs/ksmbd/vfs_cache.h |  1 -
 8 files changed, 42 insertions(+), 62 deletions(-)

diff --git a/fs/ksmbd/misc.c b/fs/ksmbd/misc.c
index 60e7ac62c917..bca29b2a190d 100644
--- a/fs/ksmbd/misc.c
+++ b/fs/ksmbd/misc.c
@@ -158,19 +158,41 @@ int parse_stream_name(char *filename, char **stream_name, int *s_type)
  * Return : windows path string or error
  */
 
-char *convert_to_nt_pathname(char *filename)
+char *convert_to_nt_pathname(struct ksmbd_share_config *share,
+			     struct path *path)
 {
-	char *ab_pathname;
+	char *pathname, *ab_pathname, *nt_pathname = NULL;
+	int share_path_len = strlen(share->path);
 
-	if (strlen(filename) == 0)
-		filename = "\\";
+	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!pathname)
+		return ERR_PTR(-EACCES);
 
-	ab_pathname = kstrdup(filename, GFP_KERNEL);
-	if (!ab_pathname)
-		return NULL;
+	ab_pathname = d_path(path, pathname, PATH_MAX);
+	if (IS_ERR(ab_pathname)) {
+		nt_pathname = ERR_PTR(-EACCES);
+		goto free_pathname;
+	}
+
+	if (strncmp(ab_pathname, share->path, share_path_len)) {
+		nt_pathname = ERR_PTR(-EACCES);
+		goto free_pathname;
+	}
+
+	nt_pathname = kzalloc(strlen(&ab_pathname[share_path_len]) + 1, GFP_KERNEL);
+	if (!nt_pathname) {
+		nt_pathname = ERR_PTR(-ENOMEM);
+		goto free_pathname;
+	}
+	if (ab_pathname[share_path_len] == '\0')
+		strcpy(nt_pathname, "/");
+	strcat(nt_pathname, &ab_pathname[share_path_len]);
+
+	ksmbd_conv_path_to_windows(nt_pathname);
 
-	ksmbd_conv_path_to_windows(ab_pathname);
-	return ab_pathname;
+free_pathname:
+	kfree(pathname);
+	return nt_pathname;
 }
 
 int get_nlink(struct kstat *st)
diff --git a/fs/ksmbd/misc.h b/fs/ksmbd/misc.h
index 253366bd0951..aae2a252945f 100644
--- a/fs/ksmbd/misc.h
+++ b/fs/ksmbd/misc.h
@@ -14,7 +14,8 @@ struct ksmbd_file;
 int match_pattern(const char *str, size_t len, const char *pattern);
 int ksmbd_validate_filename(char *filename);
 int parse_stream_name(char *filename, char **stream_name, int *s_type);
-char *convert_to_nt_pathname(char *filename);
+char *convert_to_nt_pathname(struct ksmbd_share_config *share,
+			     struct path *path);
 int get_nlink(struct kstat *st);
 void ksmbd_conv_path_to_unix(char *path);
 void ksmbd_strip_last_slash(char *path);
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index 077b8761d099..5db5cba67d62 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -1694,33 +1694,3 @@ struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
 	read_unlock(&lease_list_lock);
 	return ret_op;
 }
-
-int smb2_check_durable_oplock(struct ksmbd_file *fp,
-			      struct lease_ctx_info *lctx, char *name)
-{
-	struct oplock_info *opinfo = opinfo_get(fp);
-	int ret = 0;
-
-	if (opinfo && opinfo->is_lease) {
-		if (!lctx) {
-			pr_err("open does not include lease\n");
-			ret = -EBADF;
-			goto out;
-		}
-		if (memcmp(opinfo->o_lease->lease_key, lctx->lease_key,
-			   SMB2_LEASE_KEY_SIZE)) {
-			pr_err("invalid lease key\n");
-			ret = -EBADF;
-			goto out;
-		}
-		if (name && strcmp(fp->filename, name)) {
-			pr_err("invalid name reconnect %s\n", name);
-			ret = -EINVAL;
-			goto out;
-		}
-	}
-out:
-	if (opinfo)
-		opinfo_put(opinfo);
-	return ret;
-}
diff --git a/fs/ksmbd/oplock.h b/fs/ksmbd/oplock.h
index 0cf7a2b5bbc0..09753448f779 100644
--- a/fs/ksmbd/oplock.h
+++ b/fs/ksmbd/oplock.h
@@ -124,6 +124,4 @@ struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
 int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
 			struct lease_ctx_info *lctx);
 void destroy_lease_table(struct ksmbd_conn *conn);
-int smb2_check_durable_oplock(struct ksmbd_file *fp,
-			      struct lease_ctx_info *lctx, char *name);
 #endif /* __KSMBD_OPLOCK_H */
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 67e8e28e3fc3..3151ab7d7410 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2922,7 +2922,6 @@ int smb2_open(struct ksmbd_work *work)
 		goto err_out;
 	}
 
-	fp->filename = name;
 	fp->cdoption = req->CreateDisposition;
 	fp->daccess = daccess;
 	fp->saccess = req->ShareAccess;
@@ -3274,14 +3273,13 @@ int smb2_open(struct ksmbd_work *work)
 		if (!rsp->hdr.Status)
 			rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
 
-		if (!fp || !fp->filename)
-			kfree(name);
 		if (fp)
 			ksmbd_fd_put(work, fp);
 		smb2_set_err_rsp(work);
 		ksmbd_debug(SMB, "Error response: %x\n", rsp->hdr.Status);
 	}
 
+	kfree(name);
 	kfree(lc);
 
 	return 0;
@@ -3901,8 +3899,6 @@ int smb2_query_dir(struct ksmbd_work *work)
 		ksmbd_debug(SMB, "Search pattern is %s\n", srch_ptr);
 	}
 
-	ksmbd_debug(SMB, "Directory name is %s\n", dir_fp->filename);
-
 	if (srch_flag & SMB2_REOPEN || srch_flag & SMB2_RESTART_SCANS) {
 		ksmbd_debug(SMB, "Restart directory scan\n");
 		generic_file_llseek(dir_fp->filp, 0, SEEK_SET);
@@ -4396,9 +4392,9 @@ static int get_file_all_info(struct ksmbd_work *work,
 		return -EACCES;
 	}
 
-	filename = convert_to_nt_pathname(fp->filename);
-	if (!filename)
-		return -ENOMEM;
+	filename = convert_to_nt_pathname(work->tcon->share_conf, &fp->filp->f_path);
+	if (IS_ERR(filename))
+		return PTR_ERR(filename);
 
 	inode = file_inode(fp->filp);
 	generic_fillattr(file_mnt_user_ns(fp->filp), inode, &stat);
@@ -5689,8 +5685,7 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 		size = i_size_read(inode);
 		rc = ksmbd_vfs_truncate(work, fp, alloc_blks * 512);
 		if (rc) {
-			pr_err("truncate failed! filename : %s, err %d\n",
-			       fp->filename, rc);
+			pr_err("truncate failed!, err %d\n", rc);
 			return rc;
 		}
 		if (size < alloc_blks * 512)
@@ -5720,12 +5715,10 @@ static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 	 * truncated range.
 	 */
 	if (inode->i_sb->s_magic != MSDOS_SUPER_MAGIC) {
-		ksmbd_debug(SMB, "filename : %s truncated to newsize %lld\n",
-			    fp->filename, newsize);
+		ksmbd_debug(SMB, "truncated to newsize %lld\n", newsize);
 		rc = ksmbd_vfs_truncate(work, fp, newsize);
 		if (rc) {
-			ksmbd_debug(SMB, "truncate failed! filename : %s err %d\n",
-				    fp->filename, rc);
+			ksmbd_debug(SMB, "truncate failed!, err %d\n", rc);
 			if (rc != -EAGAIN)
 				rc = -EBADF;
 			return rc;
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index a1ab0aaceba5..487617f729ec 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -397,8 +397,7 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
 
 	nbytes = kernel_read(filp, rbuf, count, pos);
 	if (nbytes < 0) {
-		pr_err("smb read failed for (%s), err = %zd\n",
-		       fp->filename, nbytes);
+		pr_err("smb read failed, err = %zd\n", nbytes);
 		return nbytes;
 	}
 
@@ -874,8 +873,7 @@ int ksmbd_vfs_truncate(struct ksmbd_work *work,
 
 	err = vfs_truncate(&filp->f_path, size);
 	if (err)
-		pr_err("truncate failed for filename : %s err %d\n",
-		       fp->filename, err);
+		pr_err("truncate failed, err %d\n", err);
 	return err;
 }
 
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index 29c1db66bd0f..0974d2e972b9 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -328,7 +328,6 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 		kfree(smb_lock);
 	}
 
-	kfree(fp->filename);
 	if (ksmbd_stream_fd(fp))
 		kfree(fp->stream.name);
 	kmem_cache_free(filp_cache, fp);
diff --git a/fs/ksmbd/vfs_cache.h b/fs/ksmbd/vfs_cache.h
index 36239ce31afd..fcb13413fa8d 100644
--- a/fs/ksmbd/vfs_cache.h
+++ b/fs/ksmbd/vfs_cache.h
@@ -62,7 +62,6 @@ struct ksmbd_inode {
 
 struct ksmbd_file {
 	struct file			*filp;
-	char				*filename;
 	u64				persistent_id;
 	u64				volatile_id;
 
-- 
2.25.1

