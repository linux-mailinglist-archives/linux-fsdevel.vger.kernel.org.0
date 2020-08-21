Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0E524CFBF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgHUHly (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbgHUHka (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C40BC061348
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mt12so461675pjb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GBiuBiabcY66Xi/9ClqfYhrJxdtjYE/DsOa+EGbDCM=;
        b=USCEiov+fhm+HnznZWXrt6cguny7h+jJYBPetlZjSTgkZ3qakw8LWXxjB2WHHSnoKU
         ZLPgTWqTBSFNWkKSthevTUmhwQDakKSBspZEaFjtn7TZuaMhbm4DVcdUSq0yOsoBQJpV
         dO89xgOiOXXApnnGePXKu2CDGvZFQM7NmjEO370iCdpMlFHRgeFGw1F4Gdg1bxXHRRTC
         sfWDYKkfHiG3qTjehVGQql74AgmDIKvfWj7fNHrrhur7PG4vXdrxzuevxqzwk2aO89x/
         /434lzT+xJio8JSt/2t5LriV0I1XjWqRXrTMXrKlSRx1lIVYNg3bRKcjeoth2ZwJ/4Pu
         AimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GBiuBiabcY66Xi/9ClqfYhrJxdtjYE/DsOa+EGbDCM=;
        b=HDpsctkYQCjfZzH2dAOwygqQS1n+mrpAzvANEMDevkxAzrXXlS+I/yjgRB4c2SZRD9
         IxtljKrfgia5nJvZqdXpkFFvyYIvLI954FFK2Q+wXNEntcxt+yBI1XkaKoZ9Un9Rs1aO
         ZnooT6oLtBlZ29GAKwGekaBS9ZipLkrqaZVA9TI5MxIlhiU7wNq8rTtt4K/VvM34PInT
         XRpSeYzdJPE3wfRZcchj6/X+Sodmc8pAaPuRyjSwZR0nDwTRzmQEyWRxRRbzF57nsZ0z
         LRjc4gNVvGS7JJtNTrTeGvK+A6xvP+c/JGIjX2ByehKOogYSvQhVoXp5Cswb/h50dnFw
         uU3A==
X-Gm-Message-State: AOAM530OWmUlQBsV/2zFhuJJySK8S6KO5JK9v5w46xKXIynS8k67CJaw
        ogrNhX8PC3qJVYWroYaGGp4efmrCZ4Cw5w==
X-Google-Smtp-Source: ABdhPJxItbccacYGbgmb6CD+tSwEulVyKHRbP8i53kk0o3R1tP7G2pM+vzmWSr9qOPIos0Gfu/u+Mw==
X-Received: by 2002:a17:902:8608:: with SMTP id f8mr1473957plo.66.1597995629660;
        Fri, 21 Aug 2020 00:40:29 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:28 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/9] btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
Date:   Fri, 21 Aug 2020 00:39:57 -0700
Message-Id: <d9cae7ef205a1272579fc74a39af27f50e1d9550.1597994106.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index c0f81d302f49..efa6f8f27e4d 100644
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
@@ -7072,6 +7073,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	struct btrfs_root *clone_root;
 	struct send_ctx *sctx = NULL;
 	u32 i;
+	u32 send_buf_num_pages = 0;
 	u64 *clone_sources_tmp = NULL;
 	int clone_sources_to_rollback = 0;
 	unsigned alloc_size;
@@ -7152,10 +7154,28 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
@@ -7363,7 +7383,16 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
2.28.0

