Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D64131D2B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 23:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhBPWeL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 17:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhBPWeH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 17:34:07 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00968C0613D6;
        Tue, 16 Feb 2021 14:33:26 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z7so6299179plk.7;
        Tue, 16 Feb 2021 14:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dc52RJMFGbh/YC/FYB6BFalirRTnRGBAM9OW4sOUqhU=;
        b=X8Wdi8DyMFxzboajRfwk0u3lDGhOIqq0J3MGScpzkqZOjlDjJWdT1CC+tu0GLsMKka
         W1vAZCWhMaCFO1AXfiCvNz92ZiWIoglXjPMMMcLTpBGHU7T1QJr5jACymN+wbkJa5DgJ
         zRn3iiEWn6kRcpEmDyahTArNaOLTH8YUmV8EtmKGaY6u4beHiuQUIEmIDrJpnz6kf7sK
         AEf3oMtGHaoxa7WP/BIzBFJUB964u7HnfwnZpF5WNTCSxmpP14AaUMHEwzETa4AK+6UA
         XDB9dnAddo0H/HEOTvfMtF4p4wT9fBEwwgiiGbZWeig3zVv9nF7cqfvXTWCwLanKg57C
         ENRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dc52RJMFGbh/YC/FYB6BFalirRTnRGBAM9OW4sOUqhU=;
        b=VZ5QJd0DZUCyefW0JmPzL6eBAHaXk/z5RRp+4m2Ovy3UnD5FoeAXIKcWPL/J71nW/i
         ldeWgoXD4BfAv8DTZpeQtDxlnF1aTap6Cyw04aRWsQr/1QXp6tEc0VR7fF9tT9GGjbMt
         RKnHDWNzvhejoqQR0cJZsLsd7MhYJaGw9TZGyL2+A73oR0tOPgxayvT5e6DqcJmIdc/x
         F0WIKU4MqbWCgFpNo5b8DrTHWgOn0B8ite4AGRsRrQ2tjYncXirwRVCdU7eZQPyHqSQQ
         MsGQjlI/g/F3dPTyozJr5vyBW2m07mhBridEtmc6QNah0fPu/cvniE2vHywGSGORukUl
         rMKQ==
X-Gm-Message-State: AOAM532wLjACz2op15o11B3kyhacx5GR6aYu5BDHSkPLtaYl8ab4lp6G
        RLN8sJzqUFkfOWoFIPfY5PDVDmX8EHEg+w==
X-Google-Smtp-Source: ABdhPJwifpFQACTR14DtKpJeHLi1PN52Qwjq/xKYMZcAlSwqglpipyL3CLInWk0pfyYzHBJYiYQpqQ==
X-Received: by 2002:a17:90a:4a0a:: with SMTP id e10mr5904356pjh.112.1613514806575;
        Tue, 16 Feb 2021 14:33:26 -0800 (PST)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id w5sm579pfb.11.2021.02.16.14.33.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 14:33:26 -0800 (PST)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH v2 1/2] exfat: add initial ioctl function
Date:   Wed, 17 Feb 2021 07:33:05 +0900
Message-Id: <20210216223306.47693-2-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
In-Reply-To: <20210216223306.47693-1-hyeongseok@gmail.com>
References: <20210216223306.47693-1-hyeongseok@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Initialize empty ioctl function

Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
---
 fs/exfat/dir.c      |  5 +++++
 fs/exfat/exfat_fs.h |  3 +++
 fs/exfat/file.c     | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 916797077aad..e1d5536de948 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/compat.h>
 #include <linux/bio.h>
 #include <linux/buffer_head.h>
 
@@ -306,6 +307,10 @@ const struct file_operations exfat_dir_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_read_dir,
 	.iterate	= exfat_iterate,
+	.unlocked_ioctl = exfat_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = exfat_compat_ioctl,
+#endif
 	.fsync		= exfat_file_fsync,
 };
 
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 764bc645241e..a183021ae31d 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -420,6 +420,9 @@ int exfat_setattr(struct dentry *dentry, struct iattr *attr);
 int exfat_getattr(const struct path *path, struct kstat *stat,
 		unsigned int request_mask, unsigned int query_flags);
 int exfat_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
+long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
+long exfat_compat_ioctl(struct file *filp, unsigned int cmd,
+				unsigned long arg);
 
 /* namei.c */
 extern const struct dentry_operations exfat_dentry_ops;
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index a92478eabfa4..679828e7be07 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/compat.h>
 #include <linux/cred.h>
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
@@ -348,6 +349,22 @@ int exfat_setattr(struct dentry *dentry, struct iattr *attr)
 	return error;
 }
 
+long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	default:
+		return -ENOTTY;
+	}
+}
+
+#ifdef CONFIG_COMPAT
+long exfat_compat_ioctl(struct file *filp, unsigned int cmd,
+				unsigned long arg)
+{
+	return exfat_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 int exfat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 {
 	struct inode *inode = filp->f_mapping->host;
@@ -368,6 +385,10 @@ const struct file_operations exfat_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
 	.write_iter	= generic_file_write_iter,
+	.unlocked_ioctl = exfat_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = exfat_compat_ioctl,
+#endif
 	.mmap		= generic_file_mmap,
 	.fsync		= exfat_file_fsync,
 	.splice_read	= generic_file_splice_read,
-- 
2.27.0.83.g0313f36

