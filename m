Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB6F3EF47D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 23:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhHQVIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 17:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbhHQVIF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 17:08:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E549EC0613A4
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:31 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so7405093pjn.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8/y368u+b0cKBJ8i6xV8bO2WQ3c9lOKFHW+lrogDRc0=;
        b=qgFprzxNjNCpyQxDQvYMNMToO1wFKV2eRtKV9mrjKAWB/Q07nE+72GCXuF84z0udm+
         XKl6W8HMOTefcQapdbNwvoqvzZOJhPXADskaOM6UDZtDsjwI6CB8gQN0RUCCINPqHBgE
         OZDZQQxFS8gAvj/bTtrvT7d2c0KfuVGBZaF16QjXfQyivD9OiXe10EczJ+vG5pKytQgV
         IdEItZlDn1QCqjUgSHw8XuhbUvGu+jvwFPrF5s22y/fC8CTdNpYsSVnnXlsw/T2QoMfC
         nfYvYbD7LoHiw5hkjxUsJM0of4qYsraASYpm4QTLbuA5GwEygO+DJ/9ib7yITmKrNaEV
         ecDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/y368u+b0cKBJ8i6xV8bO2WQ3c9lOKFHW+lrogDRc0=;
        b=HqhQiUvqNPnVJDTTDRSPrbrJlfTA+DXghESgNa2ZCnF76tFL9/BKGy9ELMewWM1LdT
         m7CNGMSMB8R+JU2cEbRyClIo/qBpOlClN9wgrcIiDZOqnp7FOsCLV6IihKRti15CojRC
         ROpQd/3qP8nteEhYOokDeEOglNG+li4aXfe6fwtx6fjTJHz+oMt2fA3pD2kXMhT1e8Am
         XxtMqoexaHnt+8yfAOh30+N2+9R2mnLN2ouovtHYUCuSARp7Em9St0L+abhsZtHy7xNm
         E1bfGtUUFsn5dW6FiqoCngp8IOBYySan0jCvAUdZUqXI7WnIQsDPtzAOohJZSUUj5h5t
         risQ==
X-Gm-Message-State: AOAM532nedX+K8E68Q9qhkM+s4JbwdbeZ6P0qXbAH0l/sqm1NuYCk8bT
        LNJDjH3UW4psdMe2jpO1KjxQUA==
X-Google-Smtp-Source: ABdhPJx2QJEHbvSgUUhCX5KQryvh3A9rlpieB0JM99o0M/B1PtxC5ZB6MHC+ypPR8ov3iR7WuT7TJw==
X-Received: by 2002:aa7:8685:0:b0:3e1:76d8:922e with SMTP id d5-20020aa78685000000b003e176d8922emr5473852pfo.45.1629234451244;
        Tue, 17 Aug 2021 14:07:31 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:df70])
        by smtp.gmail.com with ESMTPSA id c9sm4205194pgq.58.2021.08.17.14.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:07:30 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: [PATCH v10 12/14] btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
Date:   Tue, 17 Aug 2021 14:06:44 -0700
Message-Id: <5ea052d103ec66ef1f782839c5e21d4f6574fcc1.1629234193.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629234193.git.osandov@fb.com>
References: <cover.1629234193.git.osandov@fb.com>
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
index dfe598d12b8c..7242362ecb23 100644
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
@@ -7230,6 +7231,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	struct btrfs_root *clone_root;
 	struct send_ctx *sctx = NULL;
 	u32 i;
+	u32 send_buf_num_pages = 0;
 	u64 *clone_sources_tmp = NULL;
 	int clone_sources_to_rollback = 0;
 	size_t alloc_size;
@@ -7310,10 +7312,28 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
@@ -7520,7 +7540,16 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
2.32.0

