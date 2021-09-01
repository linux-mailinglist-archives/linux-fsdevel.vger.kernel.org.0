Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8F93FE0B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345632AbhIARCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 13:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345572AbhIARCl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:02:41 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B192C061760
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Sep 2021 10:01:44 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s11so42610pgr.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 10:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H4mqyz+VHmVtbXHcMEv44uByT200A+1BRqo8V2YXL9M=;
        b=ialasvKUQPgOdb9gSUFy4RIzHHMAG9xOJVL+WDq6GPsl8hcZSIS4udMgU+azX2lzxL
         ddw/BYi+O19RPnhWZJCtLk0rMyZcp22oDAUYwKgpWuXIkbOrB5fkkPcSEsM9SCjAwEOZ
         AlLqDLcZfuRHOHJZ9KtDnKlbfD78Ij2qArVhsqXEObvR/h+yDaLoZ3aZLrsd/1R7+RuV
         fflqtpbtjfT+h7d6D6Qth76Ty5uCLuHuJv10bg3ddE2mAGD4zjcvgzj70iRvxv3pVmLu
         KQX9GfZqp3/cQ4phABt3lYSELkgFl9LZB4WgOO/9qOqkYm003XFDSwf0oG57eyDaQdCT
         eoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H4mqyz+VHmVtbXHcMEv44uByT200A+1BRqo8V2YXL9M=;
        b=KxBcF7wHYiTnuAfhauynlzbHgSWlTj5nRZoYg6C/tobs1gSNZ6WknxGVjK4EeVLIep
         qh7W3RVWVrQsCK4Ld3bNPCtXP2pKpRCTwi+nPeYWSInXfnzORJb1pfTTOIHassz05mDK
         cVTNbYtfvjQFej///AmNxWPAh3ToJIBbNSswr8nUU6JKkzZodPiA8NdoND5uakISNiv/
         oQCfBYXlWCHunF+iNy2vnuKuhu4/nvgzYI+KzR8oCjzqfMLl58A+oeCS+r9ip5E+it5O
         92BS8sdnQo7PmnvTHBSse8hxucXPs/qP8HTVteBJrQr6khoCwE84ttk3NisJmjQtxhZy
         +QEg==
X-Gm-Message-State: AOAM533HlQpAHVJyV9SgDq8OalH7fpG3r+a4x+NF0ceNOi1PToseZIYt
        msydrxeAFTvTbd45nbZJTwicBg==
X-Google-Smtp-Source: ABdhPJzFMqjmOiGBLzuZ4kF6o5QUswSvkhGEtqlF8lvwUm62lLRgqWAdN/kIMk/L5J5VfMAyDeyNKQ==
X-Received: by 2002:a05:6a00:234f:b0:3eb:3ffd:6da2 with SMTP id j15-20020a056a00234f00b003eb3ffd6da2mr345536pfj.15.1630515703587;
        Wed, 01 Sep 2021 10:01:43 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:42 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 12/14] btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
Date:   Wed,  1 Sep 2021 10:01:07 -0700
Message-Id: <74a9595599ad41fa5b843473ce6e9d436def210f.1630514529.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
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
index 80736e2670eb..a000efe2658a 100644
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
@@ -7223,6 +7224,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	struct btrfs_root *clone_root;
 	struct send_ctx *sctx = NULL;
 	u32 i;
+	u32 send_buf_num_pages = 0;
 	u64 *clone_sources_tmp = NULL;
 	int clone_sources_to_rollback = 0;
 	size_t alloc_size;
@@ -7303,10 +7305,28 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
@@ -7513,7 +7533,16 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
2.33.0

