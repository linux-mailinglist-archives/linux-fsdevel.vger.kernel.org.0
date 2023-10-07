Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249B67BC625
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Oct 2023 10:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjJGIoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Oct 2023 04:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjJGIom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:44:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8529B9C;
        Sat,  7 Oct 2023 01:44:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-307d58b3efbso2581399f8f.0;
        Sat, 07 Oct 2023 01:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696668280; x=1697273080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9zty6feyT9bIEnH+Zx66cAwWs1o3qUaVJu27Ykhp5s=;
        b=QPBnGHI7sS/U3qifuXpUfIXKlpdqdUc3UMHGFSGyQ5CsWb8LwD9y/msRnfd/jN/vZP
         2JNkok4IIWfYCPlFhyvR06PhIDcIZfKvbp0cmHDP00U9exIGxCzbtzMra/2JaMXDkdKt
         V4TG3sDy/pGqz9eGJk6siq4X3Yy6xpzsurZpsb/ekhYlKJjHK+HJLeVJRV/HoppOY92C
         c7q1VC7HCkqkZXSp/diqdA0hqfw4DJxQMd9TYaiyyMKjGoRXxyr3HDKSSizejfsYtgXO
         kv2zo8O50vz+uV7vgVyvlqagCZMznlGZRfaZw+nlMh8Yss+EhnEcDLWs/avM8ym2/sV7
         5sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696668280; x=1697273080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9zty6feyT9bIEnH+Zx66cAwWs1o3qUaVJu27Ykhp5s=;
        b=Vox+kd9zqD/Yze0ZhffVAYNQ7FVUeCvv+yu9jlkE5hl/ObGcK8EVC2UUR46x096WuJ
         bMeiIX35bhqeT6B4xt1BTty1nQujPEmmv3xq40FC0gsyQMbuv75YlLsWU8V6hASQuYTw
         XpQclK2qJwq7tTFxh/XrLGitYquF/ye5ZYKojqi9HvxINjLHDywSkrXqoBSkcjgYxLBW
         tW4AwkbVkxOZSgv+y2CFvqYy6k7X1zyUFwNopjiTXz0lU8+OKab0ZTcK6/0+spuY8OmN
         oLZiDDjfeQRz0iaF58bhdT3Ddisb5WvSuSIkydVjezy0Bgm2H4sQUGDaxGRHzuCOfttk
         7aig==
X-Gm-Message-State: AOJu0YwKKU+dMSUf83oGMuaI2gHGNwtB9gpgMADPgLAcgKgtEHLWBzyL
        1Sd3TlTzBdrZ89Jwu8B0UpA=
X-Google-Smtp-Source: AGHT+IFyYTJvL+MJISM4tGj+EZ/JB9L3NTY87UPGmuTu8Bkgiut8bg68s57cRMDbsMC3qYeoaNWaeQ==
X-Received: by 2002:adf:f20c:0:b0:320:77f:a982 with SMTP id p12-20020adff20c000000b00320077fa982mr9498244wro.45.1696668280008;
        Sat, 07 Oct 2023 01:44:40 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id a12-20020adff7cc000000b0031423a8f4f7sm3677850wrq.56.2023.10.07.01.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 01:44:39 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/3] fs: get mnt_writers count for an open backing file's real path
Date:   Sat,  7 Oct 2023 11:44:31 +0300
Message-Id: <20231007084433.1417887-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231007084433.1417887-1-amir73il@gmail.com>
References: <20231007084433.1417887-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A writeable mapped backing file can perform writes to the real inode.
Therefore, the real path mount must be kept writable so long as the
writable map exists.

This may not be strictly needed for ovelrayfs private upper mount,
but it is correct to take the mnt_writers count in the vfs helper.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/internal.h | 15 +++++++++++++--
 fs/open.c     | 34 ++++++++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index f08d8fe3ae5e..846d5133dd9c 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -96,13 +96,24 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
 struct file *alloc_empty_backing_file(int flags, const struct cred *cred);
 void release_empty_file(struct file *f);
 
+static inline void file_put_write_access(struct file *file)
+{
+	put_write_access(file->f_inode);
+	mnt_put_write_access(file->f_path.mnt);
+	if (unlikely(file->f_mode & FMODE_BACKING)) {
+		struct path *real_path = backing_file_real_path(file);
+
+		if (real_path->mnt)
+			mnt_put_write_access(real_path->mnt);
+	}
+}
+
 static inline void put_file_access(struct file *file)
 {
 	if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
 		i_readcount_dec(file->f_inode);
 	} else if (file->f_mode & FMODE_WRITER) {
-		put_write_access(file->f_inode);
-		mnt_put_write_access(file->f_path.mnt);
+		file_put_write_access(file);
 	}
 }
 
diff --git a/fs/open.c b/fs/open.c
index a65ce47810cf..2f3e28512663 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -870,6 +870,33 @@ SYSCALL_DEFINE3(fchown, unsigned int, fd, uid_t, user, gid_t, group)
 	return ksys_fchown(fd, user, group);
 }
 
+static inline int file_get_write_access(struct file *f)
+{
+	int error;
+
+	error = get_write_access(f->f_inode);
+	if (unlikely(error))
+		return error;
+	error = mnt_get_write_access(f->f_path.mnt);
+	if (unlikely(error))
+		goto cleanup_inode;
+	if (unlikely(f->f_mode & FMODE_BACKING)) {
+		struct path *real_path = backing_file_real_path(f);
+
+		if (real_path->mnt)
+			error = mnt_get_write_access(real_path->mnt);
+		if (unlikely(error))
+			goto cleanup_mnt;
+	}
+	return 0;
+
+cleanup_mnt:
+	mnt_put_write_access(f->f_path.mnt);
+cleanup_inode:
+	put_write_access(f->f_inode);
+	return error;
+}
+
 static int do_dentry_open(struct file *f,
 			  struct inode *inode,
 			  int (*open)(struct inode *, struct file *))
@@ -892,14 +919,9 @@ static int do_dentry_open(struct file *f,
 	if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
 		i_readcount_inc(inode);
 	} else if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode)) {
-		error = get_write_access(inode);
+		error = file_get_write_access(f);
 		if (unlikely(error))
 			goto cleanup_file;
-		error = mnt_get_write_access(f->f_path.mnt);
-		if (unlikely(error)) {
-			put_write_access(inode);
-			goto cleanup_file;
-		}
 		f->f_mode |= FMODE_WRITER;
 	}
 
-- 
2.34.1

