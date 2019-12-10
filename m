Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC89B119257
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 21:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfLJUnQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 15:43:16 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:41745 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfLJUnP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:43:15 -0500
Received: by mail-pj1-f66.google.com with SMTP id ca19so7854935pjb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 12:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8zjCrJz5ZRdYBpdQDfhxTslxtlYCGJ1G+7YBvhVfgI=;
        b=HGjXuSZDF3axBxNT/QjLCDTfAqLBCNpQfhwYI/TjCKP2dQ/MEGys303w9KaIczarqP
         yrZYv4OjTlQfuXcYAvq+B1r2WcD8M/nPc0RZSSS1/n7Qksr/V/TnNC4j9k6tsMgd6dxM
         KWjzNC4rxCjVawKY/QPY7gsRQSh8LYNSwbLjnKEvWIb1SHV9e10lMT0MsbzFOxpXc1oR
         /O0B8OL5eO9eskXvMMs3vsIImxL8q2TTrxw3D39K+0XaYjTSOiKIb5Xy45zlRT6VkdRD
         3YLxA0gd7eCDp2JjqqepRbeT//52RFw+BCyFcNrlyc1QnWtvJXclPmNM7B7+NRBCtt56
         Y03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8zjCrJz5ZRdYBpdQDfhxTslxtlYCGJ1G+7YBvhVfgI=;
        b=Dy0jlwZiA0N/CQW/BRqq8RoDI2ps2xnunusuNtdmg0qcihmCPPEVlAnGiW1hN4I5YJ
         2fHh46AX1fJVRTLkb04+aXSS65iSzBg37ahEEy95ouHwTCspZ4uwmhBxh9u/rpCV3M1M
         FGwtTnPqXoOq/C7O8Zzl0orqOkqG4TIw0agclPjP1x+mFXmZdTGGpev53ekFtAu4Jv90
         0xiSIejNZyghBO8QkWTEYD9ktQ6jdF/35wn7EbOBzohDZJN2irlM1MvAu2j6D6NKVSht
         h10zls6KhhyATPqfDYbYHYMpansq5miOt2VkPnOiVsaGexzSbYZLvgDuQFhiXWi4C3FE
         b6Qg==
X-Gm-Message-State: APjAAAWzMVPROrY9HFCMFNPpy+MZYsYb5sxPp2TFuquB0vP4kLt20uiI
        xMZ5u78Cmc5d6lMFetKBZo4u9g==
X-Google-Smtp-Source: APXvYqz/nKj4F50ntF4Ahb9soGllQFWo9v5PBhImARi6o+FPTyF80X6YSOcIfh1N49SIvw2s2ELUMA==
X-Received: by 2002:a17:90a:86c7:: with SMTP id y7mr7645320pjv.102.1576010595105;
        Tue, 10 Dec 2019 12:43:15 -0800 (PST)
Received: from x1.thefacebook.com ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id o15sm4387829pgf.2.2019.12.10.12.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:43:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     willy@infradead.org, clm@fb.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/5] iomap: pass in the write_begin/write_end flags to iomap_actor
Date:   Tue, 10 Dec 2019 13:43:03 -0700
Message-Id: <20191210204304.12266-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210204304.12266-1-axboe@kernel.dk>
References: <20191210204304.12266-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is in preparation for passing in a flag to the iomap_actor, which
currently doesn't support that.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/dax.c               |  2 +-
 fs/iomap/apply.c       |  2 +-
 fs/iomap/buffered-io.c | 17 ++++++++++-------
 fs/iomap/direct-io.c   |  3 ++-
 fs/iomap/fiemap.c      |  5 +++--
 fs/iomap/seek.c        |  6 ++++--
 fs/iomap/swapfile.c    |  2 +-
 include/linux/iomap.h  |  5 +++--
 8 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 1f1f0201cad1..30a20b994140 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1091,7 +1091,7 @@ EXPORT_SYMBOL_GPL(__dax_zero_page_range);
 
 static loff_t
 dax_iomap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	struct block_device *bdev = iomap->bdev;
 	struct dax_device *dax_dev = iomap->dax_dev;
diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 76925b40b5fd..562536da8a13 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -77,7 +77,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	 * iomap into the actors so that they don't need to have special
 	 * handling for the two cases.
 	 */
-	written = actor(inode, pos, length, data, &iomap,
+	written = actor(inode, pos, length, data, flags, &iomap,
 			srcmap.type != IOMAP_HOLE ? &srcmap : &iomap);
 
 	/*
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 828444e14d09..9b5b770ca4c7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -249,7 +249,7 @@ static inline bool iomap_block_needs_zeroing(struct inode *inode,
 
 static loff_t
 iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	struct iomap_readpage_ctx *ctx = data;
 	struct page *page = ctx->cur_page;
@@ -397,7 +397,8 @@ iomap_next_page(struct inode *inode, struct list_head *pages, loff_t pos,
 
 static loff_t
 iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+		void *data, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	struct iomap_readpage_ctx *ctx = data;
 	loff_t done, ret;
@@ -417,7 +418,7 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
 			ctx->cur_page_in_bio = false;
 		}
 		ret = iomap_readpage_actor(inode, pos + done, length - done,
-				ctx, iomap, srcmap);
+				ctx, 0, iomap, srcmap);
 	}
 
 	return done;
@@ -797,7 +798,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len, unsigned copied,
 
 static loff_t
 iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	struct iov_iter *i = data;
 	long status = 0;
@@ -897,7 +898,7 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 
 static loff_t
 iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	long status = 0;
 	ssize_t written = 0;
@@ -983,7 +984,8 @@ static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
 
 static loff_t
 iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+		void *data, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	bool *did_zero = data;
 	loff_t written = 0;
@@ -1053,7 +1055,8 @@ EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
 static loff_t
 iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+		void *data, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	struct page *page = data;
 	int ret;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 23837926c0c5..2525997b09aa 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -365,7 +365,8 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 
 static loff_t
 iomap_dio_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+		void *data, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	struct iomap_dio *dio = data;
 
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index bccf305ea9ce..04de960259d0 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -44,7 +44,7 @@ static int iomap_to_fiemap(struct fiemap_extent_info *fi,
 
 static loff_t
 iomap_fiemap_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap, struct iomap *srcmap)
+		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
 {
 	struct fiemap_ctx *ctx = data;
 	loff_t ret = length;
@@ -111,7 +111,8 @@ EXPORT_SYMBOL_GPL(iomap_fiemap);
 
 static loff_t
 iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap, struct iomap *srcmap)
+		void *data, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	sector_t *bno = data, addr;
 
diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index 89f61d93c0bc..a5cbf04e8cb3 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -119,7 +119,8 @@ page_cache_seek_hole_data(struct inode *inode, loff_t offset, loff_t length,
 
 static loff_t
 iomap_seek_hole_actor(struct inode *inode, loff_t offset, loff_t length,
-		      void *data, struct iomap *iomap, struct iomap *srcmap)
+		      void *data, unsigned flags, struct iomap *iomap,
+		      struct iomap *srcmap)
 {
 	switch (iomap->type) {
 	case IOMAP_UNWRITTEN:
@@ -165,7 +166,8 @@ EXPORT_SYMBOL_GPL(iomap_seek_hole);
 
 static loff_t
 iomap_seek_data_actor(struct inode *inode, loff_t offset, loff_t length,
-		      void *data, struct iomap *iomap, struct iomap *srcmap)
+		      void *data, unsigned flags, struct iomap *iomap,
+		      struct iomap *srcmap)
 {
 	switch (iomap->type) {
 	case IOMAP_HOLE:
diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index a648dbf6991e..774bfc3e59e1 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -76,7 +76,7 @@ static int iomap_swapfile_add_extent(struct iomap_swapfile_info *isi)
  * distinction between written and unwritten extents.
  */
 static loff_t iomap_swapfile_activate_actor(struct inode *inode, loff_t pos,
-		loff_t count, void *data, struct iomap *iomap,
+		loff_t count, void *data, unsigned flags, struct iomap *iomap,
 		struct iomap *srcmap)
 {
 	struct iomap_swapfile_info *isi = data;
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b09463dae0d..61fcaa3904d4 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -113,7 +113,7 @@ struct iomap_page_ops {
 };
 
 /*
- * Flags for iomap_begin / iomap_end.  No flag implies a read.
+ * Flags for iomap_begin / iomap_end / factor.  No flag implies a read.
  */
 #define IOMAP_WRITE		(1 << 0) /* writing, must allocate blocks */
 #define IOMAP_ZERO		(1 << 1) /* zeroing operation, may skip holes */
@@ -146,7 +146,8 @@ struct iomap_ops {
  * Main iomap iterator function.
  */
 typedef loff_t (*iomap_actor_t)(struct inode *inode, loff_t pos, loff_t len,
-		void *data, struct iomap *iomap, struct iomap *srcmap);
+		void *data, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap);
 
 loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
 		unsigned flags, const struct iomap_ops *ops, void *data,
-- 
2.24.0

