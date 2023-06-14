Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A71072F6AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 09:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbjFNHtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 03:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbjFNHtU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:49:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C380E62;
        Wed, 14 Jun 2023 00:49:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f7fcdc7f7fso2310425e9.0;
        Wed, 14 Jun 2023 00:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686728957; x=1689320957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuSy8wXUbf/6j6CFnkKPtXBPF5U0DhX4e/efa8UVyQ4=;
        b=GtUy9NkGAlkATlHHuFTfBqYx65e7Xddv5PPymNqxK0lBizoak2AYTQSfSvXDYVgMpS
         cvN4hYvIsuGVWzWi05evBH4wKgajAjwKjHQ9bVq2gczJ/PcghE7i4zMVRbEMxcdS1sBX
         cu/z+N2tPgnu0P3FRcMlApjMdoC0Mzz8eR2WPfbZgTLRWeC9a35p3GJOnRDKFhQPfaOn
         X8vJc5THBXYbHsrN74lszUEgqHI6bDsbgOxGtVCsBRyVgFKHcrssj2jdn8OB7SHA4HTK
         xaxQU4W5jqcaQcvFu8Z2q1GNalxwZSHrLGfhyEMoo1bi4oMlvNnCYIu4gKGmHKbgq8ed
         MdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686728957; x=1689320957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuSy8wXUbf/6j6CFnkKPtXBPF5U0DhX4e/efa8UVyQ4=;
        b=KzizhZzAaG8D811lfsz3XSpxnGNcfdqizotU7dyrgv4u01AStNvfO2gcpphPPhxkvm
         esOxYfdqPbcOO3zJ/cnPiZRAB+N7CqlUd+UngbHFNnE+k0KcOiyUVST9UqMLKCiuO7ph
         soFiLlSG3CisYYs9yD+E36Wo+d5szbpSa3L7edqWP9QQUdWZzmpAun7ThpvD28nCsnPi
         p3OszjjS0udgYSyUDGTJcSQhS1G4OagP2+kLUvNrb9uQBTl/l7r8Qjnl3H21jnc1tJQk
         L6djur0W+zcnCpuFAGlCn1ZCS58VohH6YHxDlT/dPx+n3A7taJFiXVXO02ly4MZqbIHZ
         +CGw==
X-Gm-Message-State: AC+VfDxUwjBEkt4CBXZ1+y+IoUZWIVUVMHfnngJP0nX6NXO6cueMzvg4
        iqMQtCcitHSCnt2+GIt1nn4=
X-Google-Smtp-Source: ACHHUZ5fKRR9zh3lHGvibg9eyZEQfNouEGJmVKiHTdyaF0PdNbcY3VeKtp5M5atkIzLPBQPcX+duGg==
X-Received: by 2002:a7b:cb04:0:b0:3f7:ecdf:ab2d with SMTP id u4-20020a7bcb04000000b003f7ecdfab2dmr647903wmj.20.1686728957536;
        Wed, 14 Jun 2023 00:49:17 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id a4-20020a056000050400b0030ae3a6be4asm17588257wrf.72.2023.06.14.00.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 00:49:17 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH v4 2/2] ovl: enable fsnotify events on underlying real files
Date:   Wed, 14 Jun 2023 10:49:07 +0300
Message-Id: <20230614074907.1943007-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614074907.1943007-1-amir73il@gmail.com>
References: <20230614074907.1943007-1-amir73il@gmail.com>
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

Overlayfs creates the real underlying files with fake f_path, whose
f_inode is on the underlying fs and f_path on overlayfs.

Those real files were open with FMODE_NONOTIFY, because fsnotify code was
not prapared to handle fsnotify hooks on files with fake path correctly
and fanotify would report unexpected event->fd with fake overlayfs path,
when the underlying fs was being watched.

Teach fsnotify to handle events on the real files, and do not set real
files to FMODE_NONOTIFY to allow operations on real file (e.g. open,
access, modify, close) to generate async and permission events.

Because fsnotify does not have notifications on address space
operations, we do not need to worry about ->vm_file not reporting
events to a watched overlayfs when users are accessing a mapped
overlayfs file.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c      | 4 ++--
 include/linux/fsnotify.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 8cf099aa97de..1fdfc53f1207 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -34,8 +34,8 @@ static char ovl_whatisit(struct inode *inode, struct inode *realinode)
 		return 'm';
 }
 
-/* No atime modification nor notify on underlying */
-#define OVL_OPEN_FLAGS (O_NOATIME | FMODE_NONOTIFY)
+/* No atime modification on underlying */
+#define OVL_OPEN_FLAGS (O_NOATIME)
 
 static struct file *ovl_open_realfile(const struct file *file,
 				      const struct path *realpath)
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index bb8467cd11ae..6f6cbc2dc49b 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -91,7 +91,8 @@ static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
 
 static inline int fsnotify_file(struct file *file, __u32 mask)
 {
-	const struct path *path = &file->f_path;
+	/* Overlayfs internal files have fake f_path */
+	const struct path *path = f_real_path(file);
 
 	if (file->f_mode & FMODE_NONOTIFY)
 		return 0;
-- 
2.34.1

