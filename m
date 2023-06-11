Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156B372B215
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 15:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjFKN1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 09:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjFKN1m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 09:27:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1800DE5D;
        Sun, 11 Jun 2023 06:27:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30ae61354fbso2202440f8f.3;
        Sun, 11 Jun 2023 06:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686490059; x=1689082059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kfxzl9LRZ2MI14DJ63zU3v3v8JibLJSisMbfmq5QXUg=;
        b=UPl0fkS72GpeMaE8YHUPcEbE4YQs+zQp/26Mg6+9Rfk6mXNP66flajbf2P7wtp4BIm
         Kj73LvciU35/eNsfUM8HEnZ6fRxfNNoAvSufysFfPaYcI47tgaP2P3yKUFFjffEWWo+G
         uFHqX0biroTczivddFX2C9pW/NyE8f/IXJ/j4rlz7C7bnIHePo9h423R/bqfccyypMWu
         4WidePJDoJs5T3uuhLWrg8QGzvOJWtS5NqqCZNwFN2A2TP3kyHsxvE7Rr2DGJ94609vy
         rO+vHVmR9QqLi47K9gHyHMsIbKRQexLKXZemxp8POPGyVO1iL0harVb5T0p3GlTPLHwE
         oumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686490059; x=1689082059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kfxzl9LRZ2MI14DJ63zU3v3v8JibLJSisMbfmq5QXUg=;
        b=Tv+sbwupMhvZf+zVRCJf0d/kLX7OSDxerWzZsQWpL+YYWoceqC5+H+MUpd3+gZUjGB
         aYwqzWJ0mScdPy8INCgKIda5AIyuF504VUH66TzFpewbO+bTw7A3oq1K7BAhU8lFcGO7
         gBBeVRGKY/aji0qB8rz5wg2kpr/vXjkSgexW9+9QNCNEzzX6nHMQTD0VTJV0pZN/tFfq
         zxV6ve8+BV9SmO+D90pE/9OP504F29zRx9Bq8wFGC4vMQugP3ROMG4px1F9j9LFj/YZF
         5Dp0HgxtH/NURN6/hwhdHyJjjGGPScwDQaF4WMvA4EuAHy83WMwZoV25HYPAHQoUZFzb
         NXbA==
X-Gm-Message-State: AC+VfDxCYN0MmqhorSG8qMIz2TosfxOYlqcu7kPGkHFkxY04gqgDZuR7
        vYsR3RvxuZPHKV2Plcbd+M/9aoKvw1o=
X-Google-Smtp-Source: ACHHUZ6WNBT7vt3CT3IHNQhZPGuousPrxey/5+UGiDtky+MOGq87fkoMiJFKDpSe75+qfU9enukQ0Q==
X-Received: by 2002:adf:f807:0:b0:309:5122:10a3 with SMTP id s7-20020adff807000000b00309512210a3mr2609336wrp.48.1686490059441;
        Sun, 11 Jun 2023 06:27:39 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb03000000b0030ab5ebefa8sm9593940wrr.46.2023.06.11.06.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 06:27:39 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH v2 1/3] fs: rename FMODE_NOACCOUNT to FMODE_INTERNAL
Date:   Sun, 11 Jun 2023 16:27:30 +0300
Message-Id: <20230611132732.1502040-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611132732.1502040-1-amir73il@gmail.com>
References: <20230611132732.1502040-1-amir73il@gmail.com>
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

Rename the flag FMODE_NOACCOUNT that is used to mark internal files of
overlayfs and cachefiles to the more generic name FMODE_INTERNAL, which
also indicates that the file's f_path is possibly "fake".

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/file_table.c    | 6 +++---
 fs/internal.h      | 5 +++--
 fs/namei.c         | 2 +-
 fs/open.c          | 2 +-
 include/linux/fs.h | 4 ++--
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 372653b92617..d64d3933f3e4 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -55,7 +55,7 @@ static void file_free_rcu(struct rcu_head *head)
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
-	if (!(f->f_mode & FMODE_NOACCOUNT))
+	if (!(f->f_mode & FMODE_INTERNAL))
 		percpu_counter_dec(&nr_files);
 	call_rcu(&f->f_rcuhead, file_free_rcu);
 }
@@ -205,12 +205,12 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
  *
  * Should not be used unless there's a very good reason to do so.
  */
-struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
+struct file *alloc_empty_file_internal(int flags, const struct cred *cred)
 {
 	struct file *f = __alloc_file(flags, cred);
 
 	if (!IS_ERR(f))
-		f->f_mode |= FMODE_NOACCOUNT;
+		f->f_mode |= FMODE_INTERNAL;
 
 	return f;
 }
diff --git a/fs/internal.h b/fs/internal.h
index bd3b2810a36b..018605caf597 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -97,8 +97,9 @@ extern void chroot_fs_refs(const struct path *, const struct path *);
 /*
  * file_table.c
  */
-extern struct file *alloc_empty_file(int, const struct cred *);
-extern struct file *alloc_empty_file_noaccount(int, const struct cred *);
+extern struct file *alloc_empty_file(int flags, const struct cred *cred);
+extern struct file *alloc_empty_file_internal(int flags,
+					      const struct cred *cred);
 
 static inline void put_file_access(struct file *file)
 {
diff --git a/fs/namei.c b/fs/namei.c
index e4fe0879ae55..167f5acb0acf 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3721,7 +3721,7 @@ struct file *vfs_tmpfile_open(struct mnt_idmap *idmap,
 	struct file *file;
 	int error;
 
-	file = alloc_empty_file_noaccount(open_flag, cred);
+	file = alloc_empty_file_internal(open_flag, cred);
 	if (!IS_ERR(file)) {
 		error = vfs_tmpfile(idmap, parentpath, file, mode);
 		if (error) {
diff --git a/fs/open.c b/fs/open.c
index 81444ebf6091..23f862708a4f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1124,7 +1124,7 @@ EXPORT_SYMBOL(dentry_create);
 struct file *open_with_fake_path(const struct path *path, int flags,
 				struct inode *inode, const struct cred *cred)
 {
-	struct file *f = alloc_empty_file_noaccount(flags, cred);
+	struct file *f = alloc_empty_file_internal(flags, cred);
 	if (!IS_ERR(f)) {
 		int error;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21a981680856..13eec1e8ca86 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -180,8 +180,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File represents mount that needs unmounting */
 #define FMODE_NEED_UNMOUNT	((__force fmode_t)0x10000000)
 
-/* File does not contribute to nr_files count */
-#define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
+/* File is kernel internal does not contribute to nr_files count */
+#define FMODE_INTERNAL		((__force fmode_t)0x20000000)
 
 /* File supports async buffered reads */
 #define FMODE_BUF_RASYNC	((__force fmode_t)0x40000000)
-- 
2.34.1

