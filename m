Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF4A5357F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 04:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbiE0Czq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 22:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbiE0Czm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 22:55:42 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8840EEAD13
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 19:55:40 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id g3so3959847qtb.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 19:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ySBNZU6lTetRSaVW2fEw2gpViA/ZXifxYmfC+h6QNCw=;
        b=cUeNnxsRG8t2Qzja4DgxxM1AK7sikwqYFTt3KXNyL4gP/pZf6DkawTnReOw+19ZKHg
         GhvXpFpkN6ImwQTJuQANnzTQWTXa1cZlKIhJ75EOhY+ycqi7LxV2riuaRCDuQQ4d2aHy
         Zt+Izf1V5ozjavOPXzVHtJYwKa8Bzb8eD5vyAeL1VLaZbMMBAAlxDTogm9AKxWJ/qTPX
         H8ASzCQCqkhd1ALBs7zfI/ft4Awy2kaRLeNf4LxTbBxZ7OLEZMNC1FjwimmIrjWzJbCf
         y1pRVKENcyFRHoHSGT0H1/BA0Vb6PhUsREKRwuCqMNbZu8QuXIUY9kXhPW8pZFPz7f0h
         /NfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySBNZU6lTetRSaVW2fEw2gpViA/ZXifxYmfC+h6QNCw=;
        b=uonqVXe51T+Dw9/MynjTwa70sVJgYZs+kDtHDcVI02mst/5ocFYaZLUJAaojCnUZ7m
         JL0964nQn2a/EXrTKWKmRfx/Ir44e3cBtVjQZVXkR4cr1kH7l+eSXaJoadv4ATVLCepV
         /SGGMQsf2qjvQ11xKBAQxYbaggPWMflaZvFJv4fwlCE46fII1seJ38hO5I8eUA2o2Ms8
         f4ywJMfC/NGXZ6+xobKiF9w7tiLn9XlNtXaBBnTZ7HC8tug4lO1KnU49v2gABZ5pa1iz
         uiGewuRZK4w/Wu7jHY/E/J+nMkV1af50+j6r79mJYwkE1vy9zcWW9kdQWaSqiGzR1nEA
         JBsw==
X-Gm-Message-State: AOAM531DYxzmJtq7OTHczwnNDuYrAWT9MzVU56u2ksHEPF3J4mUEQ6yd
        ibuweWcOkc4u0emtfXYI8Kda6g==
X-Google-Smtp-Source: ABdhPJy5SYLrs5scVJFU4c2Qdqz78Vt3mFRyKorqBBppImNA97SE4MLqXAllLhM09+vh74Kd/8pZXA==
X-Received: by 2002:ac8:5b15:0:b0:2f3:ea22:d265 with SMTP id m21-20020ac85b15000000b002f3ea22d265mr31701014qtw.453.1653620139658;
        Thu, 26 May 2022 19:55:39 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id r129-20020ae9dd87000000b0069fc13ce224sm2129672qkf.85.2022.05.26.19.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:55:39 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, sashal@kernel.org,
        ebiederm@xmission.com, rburanyi@google.com, gthelen@google.com,
        viro@zeniv.linux.org.uk, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] fs/kernel_read_file: Allow to read files up-to ssize_t
Date:   Fri, 27 May 2022 02:55:34 +0000
Message-Id: <20220527025535.3953665-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
References: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, the maximum file size that is supported is 2G. This may be
too small in some cases. For example, kexec_file_load() system call
loads initramfs. In some netboot cases initramfs can be rather large.

Allow to use up-to ssize_t bytes. The callers still can limit the
maximum file size via buf_size.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 fs/kernel_read_file.c            | 38 ++++++++++++++++----------------
 include/linux/kernel_read_file.h | 32 +++++++++++++--------------
 include/linux/limits.h           |  1 +
 3 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 1b07550485b9..5d826274570c 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -29,15 +29,15 @@
  * change between calls to kernel_read_file().
  *
  * Returns number of bytes read (no single read will be bigger
- * than INT_MAX), or negative on error.
+ * than SSIZE_MAX), or negative on error.
  *
  */
-int kernel_read_file(struct file *file, loff_t offset, void **buf,
-		     size_t buf_size, size_t *file_size,
-		     enum kernel_read_file_id id)
+ssize_t kernel_read_file(struct file *file, loff_t offset, void **buf,
+			 size_t buf_size, size_t *file_size,
+			 enum kernel_read_file_id id)
 {
 	loff_t i_size, pos;
-	size_t copied;
+	ssize_t copied;
 	void *allocated = NULL;
 	bool whole_file;
 	int ret;
@@ -58,7 +58,7 @@ int kernel_read_file(struct file *file, loff_t offset, void **buf,
 		goto out;
 	}
 	/* The file is too big for sane activities. */
-	if (i_size > INT_MAX) {
+	if (i_size > SSIZE_MAX) {
 		ret = -EFBIG;
 		goto out;
 	}
@@ -124,12 +124,12 @@ int kernel_read_file(struct file *file, loff_t offset, void **buf,
 }
 EXPORT_SYMBOL_GPL(kernel_read_file);
 
-int kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
-			       size_t buf_size, size_t *file_size,
-			       enum kernel_read_file_id id)
+ssize_t kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
+				   size_t buf_size, size_t *file_size,
+				   enum kernel_read_file_id id)
 {
 	struct file *file;
-	int ret;
+	ssize_t ret;
 
 	if (!path || !*path)
 		return -EINVAL;
@@ -144,14 +144,14 @@ int kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
 
-int kernel_read_file_from_path_initns(const char *path, loff_t offset,
-				      void **buf, size_t buf_size,
-				      size_t *file_size,
-				      enum kernel_read_file_id id)
+ssize_t kernel_read_file_from_path_initns(const char *path, loff_t offset,
+					  void **buf, size_t buf_size,
+					  size_t *file_size,
+					  enum kernel_read_file_id id)
 {
 	struct file *file;
 	struct path root;
-	int ret;
+	ssize_t ret;
 
 	if (!path || !*path)
 		return -EINVAL;
@@ -171,12 +171,12 @@ int kernel_read_file_from_path_initns(const char *path, loff_t offset,
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
 
-int kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
-			     size_t buf_size, size_t *file_size,
-			     enum kernel_read_file_id id)
+ssize_t kernel_read_file_from_fd(int fd, loff_t offset, void **buf,
+				 size_t buf_size, size_t *file_size,
+				 enum kernel_read_file_id id)
 {
 	struct fd f = fdget(fd);
-	int ret = -EBADF;
+	ssize_t ret = -EBADF;
 
 	if (!f.file || !(f.file->f_mode & FMODE_READ))
 		goto out;
diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 575ffa1031d3..90451e2e12bd 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -35,21 +35,21 @@ static inline const char *kernel_read_file_id_str(enum kernel_read_file_id id)
 	return kernel_read_file_str[id];
 }
 
-int kernel_read_file(struct file *file, loff_t offset,
-		     void **buf, size_t buf_size,
-		     size_t *file_size,
-		     enum kernel_read_file_id id);
-int kernel_read_file_from_path(const char *path, loff_t offset,
-			       void **buf, size_t buf_size,
-			       size_t *file_size,
-			       enum kernel_read_file_id id);
-int kernel_read_file_from_path_initns(const char *path, loff_t offset,
-				      void **buf, size_t buf_size,
-				      size_t *file_size,
-				      enum kernel_read_file_id id);
-int kernel_read_file_from_fd(int fd, loff_t offset,
-			     void **buf, size_t buf_size,
-			     size_t *file_size,
-			     enum kernel_read_file_id id);
+ssize_t kernel_read_file(struct file *file, loff_t offset,
+			 void **buf, size_t buf_size,
+			 size_t *file_size,
+			 enum kernel_read_file_id id);
+ssize_t kernel_read_file_from_path(const char *path, loff_t offset,
+				   void **buf, size_t buf_size,
+				   size_t *file_size,
+				   enum kernel_read_file_id id);
+ssize_t kernel_read_file_from_path_initns(const char *path, loff_t offset,
+					  void **buf, size_t buf_size,
+					  size_t *file_size,
+					  enum kernel_read_file_id id);
+ssize_t kernel_read_file_from_fd(int fd, loff_t offset,
+				 void **buf, size_t buf_size,
+				 size_t *file_size,
+				 enum kernel_read_file_id id);
 
 #endif /* _LINUX_KERNEL_READ_FILE_H */
diff --git a/include/linux/limits.h b/include/linux/limits.h
index b568b9c30bbf..f6bcc9369010 100644
--- a/include/linux/limits.h
+++ b/include/linux/limits.h
@@ -7,6 +7,7 @@
 #include <vdso/limits.h>
 
 #define SIZE_MAX	(~(size_t)0)
+#define SSIZE_MAX	((ssize_t)(SIZE_MAX >> 1))
 #define PHYS_ADDR_MAX	(~(phys_addr_t)0)
 
 #define U8_MAX		((u8)~0U)
-- 
2.36.1.124.g0e6072fb45-goog

