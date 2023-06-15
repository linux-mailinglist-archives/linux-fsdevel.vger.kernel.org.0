Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6856373166B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 13:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343820AbjFOLWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 07:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239118AbjFOLWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:22:44 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7761F268C;
        Thu, 15 Jun 2023 04:22:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f769c37d26so2343078e87.1;
        Thu, 15 Jun 2023 04:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686828162; x=1689420162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpZu3AzfDONf2ZeTTGU/Q/7Z9wDaizjBTr2YR+1aWi8=;
        b=El8facWjF93Z9DrdTlJkuexnlIw6XkHhCE2XT9fdAf/2i1T6TTYYz5GfaVERiLDvY5
         G6+XucIfrauaWiMTYK5lKU0zKQWPCsWcR0lMMU5Yby3ouK7j3NHHgFV6a7Yi3FGoTVrq
         5V+Zro33gXSgpa6NxU4JohDEWpURZmjRSd9PLS7OaAg9HH2Yc/OuRvecHZNL/8KHwfTT
         hMxVIpdFKFgyRdQJSHO8u88LKMzu8e/M/YnFn3B8idPKJd+E4br2j1jKBQD/zNHgVMvo
         3y64F7peMY6szwttP1tqtavx6/vo3PECyaabMQhZJFH7+Slp0X2S4EFrMNTu5g5PCUG0
         I2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686828162; x=1689420162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpZu3AzfDONf2ZeTTGU/Q/7Z9wDaizjBTr2YR+1aWi8=;
        b=h6TI2wX8hxLz/bHVSRv9Tz8nYVbuv9ZU/l30HpvOsfG3dl694XIEDCc+cTsIdo7dIV
         RExYcLzTalfj2GW/O8bXh3T9SCHmyyEJIgtxu9kaLKumqXE+F5OfrDPeVOSP6FYNyU/+
         JlbnHhk2+abdVkpxJH/YtlCQGaqTbdT987bVaDU2DPy7NS7WDcSUXuIVIJQW6+qmg/c8
         hwZWYgT7qk3oIJ8r3zq2f+8DiUYMFoTSEN+5rsYx2t423IyNBrTbjG6cfVfEmp4QEio3
         T1YPb+vDCWU7w0ZVT3Ld2kveVQlcOXCPH87IavOVWpNZX3FkL0a0FuCjkYQcuGewR3+i
         CIyw==
X-Gm-Message-State: AC+VfDxhCBtOrO/krR0mYMVRC8UT1JjWPXMMt7eoHXu3y/q30uys8no9
        lXC0ppEUkgUl2iDqkJ7BFeU=
X-Google-Smtp-Source: ACHHUZ50f1odv8a8kBfhGJZ6zkzR49Ys2kno/jVqCqtz+fxxYTCg6xDYW9QgN+mfuiHaOAwPt1GV9w==
X-Received: by 2002:a19:505b:0:b0:4f6:14d1:596d with SMTP id z27-20020a19505b000000b004f614d1596dmr9732589lfj.61.1686828161660;
        Thu, 15 Jun 2023 04:22:41 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id h25-20020a197019000000b004f80f03d990sm355089lfc.259.2023.06.15.04.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 04:22:41 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH v5 2/5] fs: use a helper for opening kernel internal files
Date:   Thu, 15 Jun 2023 14:22:26 +0300
Message-Id: <20230615112229.2143178-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615112229.2143178-1-amir73il@gmail.com>
References: <20230615112229.2143178-1-amir73il@gmail.com>
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

cachefiles uses kernel_open_tmpfile() to open kernel internal tmpfile
without accounting for nr_files.

cachefiles uses open_with_fake_path() for the same reason without the
need for a fake path.

Fork open_with_fake_path() to kernel_file_open() which only does the
noaccount part and use it in cachefiles.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/cachefiles/namei.c |  4 ++--
 fs/open.c             | 31 +++++++++++++++++++++++++++++++
 include/linux/fs.h    |  2 ++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 6c7d4e97c219..499cf73f097b 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -560,8 +560,8 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	 */
 	path.mnt = cache->mnt;
 	path.dentry = dentry;
-	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
-				   d_backing_inode(dentry), cache->cache_cred);
+	file = kernel_file_open(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
+				d_backing_inode(dentry), cache->cache_cred);
 	if (IS_ERR(file)) {
 		trace_cachefiles_vfs_error(object, d_backing_inode(dentry),
 					   PTR_ERR(file),
diff --git a/fs/open.c b/fs/open.c
index 005ca91a173b..c5da2b3eb105 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1121,6 +1121,37 @@ struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 }
 EXPORT_SYMBOL(dentry_create);
 
+/**
+ * kernel_file_open - open a file for kernel internal use
+ * @path:	path of the file to open
+ * @flags:	open flags
+ * @inode:	the inode
+ * @cred:	credentials for open
+ *
+ * Open a file that is not accounted in nr_files.
+ * This is only for kernel internal use, and must not be installed into
+ * file tables or such.
+ */
+struct file *kernel_file_open(const struct path *path, int flags,
+				struct inode *inode, const struct cred *cred)
+{
+	struct file *f;
+	int error;
+
+	f = alloc_empty_file_noaccount(flags, cred);
+	if (IS_ERR(f))
+		return f;
+
+	f->f_path = *path;
+	error = do_dentry_open(f, inode, NULL);
+	if (error) {
+		fput(f);
+		f = ERR_PTR(error);
+	}
+	return f;
+}
+EXPORT_SYMBOL_GPL(kernel_file_open);
+
 struct file *open_with_fake_path(const struct path *path, int flags,
 				struct inode *inode, const struct cred *cred)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 62237beeac2a..1f8486e773af 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1676,6 +1676,8 @@ struct file *kernel_tmpfile_open(struct mnt_idmap *idmap,
 				 const struct path *parentpath,
 				 umode_t mode, int open_flag,
 				 const struct cred *cred);
+struct file *kernel_file_open(const struct path *path, int flags,
+			      struct inode *inode, const struct cred *cred);
 
 int vfs_mkobj(struct dentry *, umode_t,
 		int (*f)(struct dentry *, umode_t, void *),
-- 
2.34.1

