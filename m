Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BED7300E42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 21:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbhAVUyw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 15:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730955AbhAVUxS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:53:18 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FFCC0698CB
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:48:29 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id w14so4620790pfi.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q4vux4IYhSQov6A9+C6Myiq5tzHRUo+ynvL8O+spikA=;
        b=FtQK/Ex98Udoo0JgrYnOxaWjiBAr0SUdekYO08i2VPqcHA9yPjVUClsbZ/WviMwv8Y
         +p1hUeVVXWIxMAvHq4dNI1e0e1s533mhvwNE/R0YggWX0fZ0ACQXe++8vy6JOMfWL+HQ
         o+GjzfQxfps8Znl4D533Z079K9xy6ZPPJnPypdPF18xKXimJpaubpNZip0JbksmkYo3G
         SkE74aNRPI8khThssP2c4LuxG8cbxswuLQhn/HtxbuyOgEbD4yroD+gqZZBC4URVn29T
         iV6+i5PD+Qp7DUp2VK9cQJdqtpfRZukQK5netS4xzG6uNZebvWlqCCx0C9sdLACHrWXW
         MQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q4vux4IYhSQov6A9+C6Myiq5tzHRUo+ynvL8O+spikA=;
        b=XvKjVQI8gv+lHsOq7K2jTWK4taWpfzfE+6Crz+ErQcO4iVhmyuo+s349Br3sprogHi
         qBQbGIq6SDsPSbdEoycq3HDMMrP6OijnRuIHwBYsaWUc87tBsOsqu+Z0+wB3QsR84r6S
         OQaGLFyFQwHikP8DWhd1kWuf2lqUPHwKUDPiGov8Ss009yvBoaLbNQhNn1T/lq3sW6Id
         cZpTE/PKEXoe9DxMG7epuuD6bNlGbXGj+x3ZR9RAZWd6m6D3snSsd/4X+swDVDjG84UI
         ONLu+U4a40qYa6eZh9RuHG/6idHPMBFTwK9QRSF4JQq61016yPqoHgEGbrWaCWzf1k2P
         c9aA==
X-Gm-Message-State: AOAM531V/SpOhquqQnKSUClnWsk7hOn5md1FBQ0U/f9h3+QCmvPTM05I
        TmqSuxL1T3lO7aYe9mJCRg1P1g==
X-Google-Smtp-Source: ABdhPJzZ1HsZX1cU2xhF6PbWv2y9bIqjHhnJdl3FzEkorWh7g+QDH17IHpZEhy9WVu6ooMHTwLJsGg==
X-Received: by 2002:a62:36c3:0:b029:1b9:e110:e126 with SMTP id d186-20020a6236c30000b02901b9e110e126mr6602582pfa.64.1611348509200;
        Fri, 22 Jan 2021 12:48:29 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id y16sm9865617pfb.83.2021.01.22.12.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:48:28 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 3/5] btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
Date:   Fri, 22 Jan 2021 12:47:48 -0800
Message-Id: <41449ae28ca4133f7aa27e6ec477d0c60586b3d4.1611347187.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611347187.git.osandov@fb.com>
References: <cover.1611347187.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

For encoded writes, we need the raw pages for reading compressed data
directly via a bio. So, replace kvmalloc() with vmap() so we have access
to the raw pages. 144k is large enough that it usually gets allocated
with vmalloc(), anyways.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 98948568017c..25b1a60a568c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -81,6 +81,7 @@ struct send_ctx {
 	char *send_buf;
 	u32 send_size;
 	u32 send_max_size;
+	struct page **send_buf_pages;
 	u64 total_send_size;
 	u64 cmd_send_size[BTRFS_SEND_C_MAX + 1];
 	u64 flags;	/* 'flags' member of btrfs_ioctl_send_args is u64 */
@@ -7203,6 +7204,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	struct btrfs_root *clone_root;
 	struct send_ctx *sctx = NULL;
 	u32 i;
+	u32 send_buf_num_pages = 0;
 	u64 *clone_sources_tmp = NULL;
 	int clone_sources_to_rollback = 0;
 	size_t alloc_size;
@@ -7283,10 +7285,28 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2) {
 		sctx->send_max_size = ALIGN(SZ_16K + BTRFS_MAX_COMPRESSED,
 					    PAGE_SIZE);
+		send_buf_num_pages = sctx->send_max_size >> PAGE_SHIFT;
+		sctx->send_buf_pages = kcalloc(send_buf_num_pages,
+					       sizeof(*sctx->send_buf_pages),
+					       GFP_KERNEL);
+		if (!sctx->send_buf_pages) {
+			send_buf_num_pages = 0;
+			ret = -ENOMEM;
+			goto out;
+		}
+		for (i = 0; i < send_buf_num_pages; i++) {
+			sctx->send_buf_pages[i] = alloc_page(GFP_KERNEL);
+			if (!sctx->send_buf_pages[i]) {
+				ret = -ENOMEM;
+				goto out;
+			}
+		}
+		sctx->send_buf = vmap(sctx->send_buf_pages, send_buf_num_pages,
+				      VM_MAP, PAGE_KERNEL);
 	} else {
 		sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
+		sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
 	}
-	sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
 	if (!sctx->send_buf) {
 		ret = -ENOMEM;
 		goto out;
@@ -7495,7 +7515,16 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 			fput(sctx->send_filp);
 
 		kvfree(sctx->clone_roots);
-		kvfree(sctx->send_buf);
+		if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2) {
+			vunmap(sctx->send_buf);
+			for (i = 0; i < send_buf_num_pages; i++) {
+				if (sctx->send_buf_pages[i])
+					__free_page(sctx->send_buf_pages[i]);
+			}
+			kfree(sctx->send_buf_pages);
+		} else {
+			kvfree(sctx->send_buf);
+		}
 
 		name_cache_free(sctx);
 
-- 
2.30.0

