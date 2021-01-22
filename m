Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1461A300E9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 22:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbhAVVLv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 16:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730487AbhAVUwC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:52:02 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8FEC061BD1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:52 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id m6so4614539pfm.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q4vux4IYhSQov6A9+C6Myiq5tzHRUo+ynvL8O+spikA=;
        b=gvca7qDrqZ0Wa1VjQTiJmUBdws/Y0o9mE18jDgN7CDCZaAAUCsb/qFM1f3i1E31Srk
         ofFEvh30Fe8DM4awZja1cgieHfWVVM/xeKKW2g2psoWHbPzzjCbNHsKb19SHaqiypIxH
         OKd+8cLL/r4v6pP5i0wnNjTQeN7Izl/Wm4qsgc4wXc9aPgnk7vUARGtzFN+4gq2psJUn
         yTQ7hp72UNpC9JUQcs7EGSPbMvpKS+isi+/jaAkFR2P75mqqF79Oih6vjVFgAhynJouv
         9DUz9kaHdo7eERNVHsTwPD+/q9jT/xLgbEaE0h2uBJUFCkH9lqFssUqXWdV7YMwHfuN4
         OSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q4vux4IYhSQov6A9+C6Myiq5tzHRUo+ynvL8O+spikA=;
        b=Hepx1PYsYk28PBK4TVjicc0ySDv6L8+g68JbI3rNkQMxPfQYuOqNnHRJkpZFHtW89T
         pcmgAMUrUrbnA+IndQlCaNSNFiUqSyqMO/BS3pVasnePCko38eCtAKS2W1UBdAiyxiCn
         Ot2IEN+/dI+kDLrkOFQc5LGrXCZAmInQeb72lQg5Doru/te3R+n1yTqkMty0zhHuiKCU
         S+5Dm3bGixQ2pWBwLTVO4w36L4ZPdJMnRb0SFpnnVZm47GsFn7cHgOtYNGxjyjOQ7/Wa
         sFP7EBV7mzb5VuD4G1/qONTHtgc9LFF/VEiWURmDFD6s5sgMy3539y+mn4S6Nxjoguqw
         Pqww==
X-Gm-Message-State: AOAM5326Es0rD1EzgpXtVKlSlfqSpeFCpY95ilgD9d49pOjcTeISxWVR
        FC6eYIbRKMfSYqWSYrPn0tl7DNuLYPNzDQ==
X-Google-Smtp-Source: ABdhPJxi2I6deG2+BmNH0RU39zwTIM5ZJrtytwUwCnMqIqiCxMNYjOOKUVZ+Bbz/HQuEmXpcyrQGKQ==
X-Received: by 2002:a63:b550:: with SMTP id u16mr6365796pgo.448.1611348471960;
        Fri, 22 Jan 2021 12:47:51 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id j18sm4092900pfc.99.2021.01.22.12.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:47:50 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v7 13/15] btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
Date:   Fri, 22 Jan 2021 12:47:00 -0800
Message-Id: <1f0903a7762e9bf7381584251d0d22c0ae684402.1611346574.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611346574.git.osandov@fb.com>
References: <cover.1611346574.git.osandov@fb.com>
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

