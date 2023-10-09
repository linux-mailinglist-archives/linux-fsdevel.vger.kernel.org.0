Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA9E7BE51B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 17:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377782AbjJIPiG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 11:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377751AbjJIPhs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:37:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EB7118;
        Mon,  9 Oct 2023 08:37:23 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-317c3ac7339so4267950f8f.0;
        Mon, 09 Oct 2023 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696865841; x=1697470641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eM1OSmtDtyF8GeGW0x9Xn9UOfECU3ud42rTCodUc13c=;
        b=WFkBm6tFNbUdWk5zfSk7N+/Rxey8nhTnJrKypACRj1lRKMyfxA2ASo20aMgUW6rkcY
         0y3NTFu2pM99ndlvssgjfHSs96PlGd7VHHIvErucezX1779oeJAJtKbXKT4gy0wqhcDQ
         UIoxUXaQRiB1sxUM2SU6P6EaOYoR5b1WOZD8Y2C3ktFkoW2qMz4IGjFg7diZr8i2PX1u
         UHHZ2t7D8TKab5spk7gA3dDWMrg63LEOv25qgbVuULllUsE0OCXEfmYu414BsoR/QhaI
         JJgNUbQaASzo0lHMrjvR8T/osyva7es1wBqJtYYs/0wihlHccMp2M8AgRuggxNJN7hIv
         16ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865841; x=1697470641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eM1OSmtDtyF8GeGW0x9Xn9UOfECU3ud42rTCodUc13c=;
        b=oz2WAVUGqGoZZ0DZQ46lpa4fGrSBRoXdpYxO2mLNCItDqUsuo/uiUkWBg3CmrNI1FY
         1jp87GFBRkVsnTJNvNRjp3D2/QpFI2sWMhDbeZ8YI3g7StZq5buKpkjTXCDj6Xw7KyOk
         +rMOBATeMchHij0kplrT7q88zDR8MirUk0VNJnD9GpcLdgIh9bM5U2GZ8gxRVCyn2bvx
         LSTUeyVI0OhLm9rpqUV2yZ9Kc3S93R5mf3vzut6Vxcz48b/vg6Q085yU6fmMgZt4pd2r
         V7IqZoskx6EueKnsOrPcwM/tQi9/doHFkLXPKMe4nNfewJcCJ7InLunXJ2ERCnejhfx9
         l1AQ==
X-Gm-Message-State: AOJu0YwI/JAUQ671OxpTzbvBm6MhxvU07whi67afKF6KtH9TTuBe+HFf
        C2l6GizNO1PjXdxUBF1WBXc=
X-Google-Smtp-Source: AGHT+IEjo40c7ABpyweLzb+IRmIO9TJ0M4VFvozW0BLoKKQybFjyK5y9N492KUS6NbkBkwFw3ygCvg==
X-Received: by 2002:a5d:5908:0:b0:317:6c19:6445 with SMTP id v8-20020a5d5908000000b003176c196445mr12745808wrd.39.1696865841232;
        Mon, 09 Oct 2023 08:37:21 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id g7-20020a056000118700b003143c9beeaesm9939924wrx.44.2023.10.09.08.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:37:20 -0700 (PDT)
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
Subject: [PATCH v3 1/3] fs: get mnt_writers count for an open backing file's real path
Date:   Mon,  9 Oct 2023 18:37:10 +0300
Message-Id: <20231009153712.1566422-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009153712.1566422-1-amir73il@gmail.com>
References: <20231009153712.1566422-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 fs/internal.h | 11 +++++++++--
 fs/open.c     | 31 +++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index f08d8fe3ae5e..4e93a685bdaa 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -96,13 +96,20 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred);
 struct file *alloc_empty_backing_file(int flags, const struct cred *cred);
 void release_empty_file(struct file *f);
 
+static inline void file_put_write_access(struct file *file)
+{
+	put_write_access(file->f_inode);
+	mnt_put_write_access(file->f_path.mnt);
+	if (unlikely(file->f_mode & FMODE_BACKING))
+		mnt_put_write_access(backing_file_real_path(file)->mnt);
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
index a65ce47810cf..fe63e236da22 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -870,6 +870,30 @@ SYSCALL_DEFINE3(fchown, unsigned int, fd, uid_t, user, gid_t, group)
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
+		error = mnt_get_write_access(backing_file_real_path(f)->mnt);
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
@@ -892,14 +916,9 @@ static int do_dentry_open(struct file *f,
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

