Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80181C09B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 23:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgD3Vwn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 17:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgD3Vwl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:52:41 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F36CC08E859
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:41 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id nv1so6003604ejb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A09pnxCtmHNFxtu5/7SWNRBZ57kuvjkQtubB+do4qv0=;
        b=coBxNrXxFKfsgd7ezmeRSMXArxrt4d5nG71g2m2wa3tS/g6U6HEWU9BoF6/hkAXZoG
         577qwNithCoeR1JzQnF6A6JRGXpAqNL/fRuja5anAhDdJq+TkHUONmaDVzJlSNgkhc2I
         dk1pmVRAlGg9aVQ8aELP8PYAzHz0JrF3DN9gQryz1pVoAsJMJVIRe1Pd1N3gCghHC9yL
         yqSQiDQ4el0qSc//QT9+h3Ogegpsh3a/5yhPvrkMTmpnw7OE+Mow6HAZhgv8VOKOTUyE
         IIQVwnF5yomS1DIMau0s9YDJqLuIR0w15xpkZXu6XOffLWkGdQhWNRbqXSNiibl6KsAh
         vDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A09pnxCtmHNFxtu5/7SWNRBZ57kuvjkQtubB+do4qv0=;
        b=ADQ2eke7UXex1HdRf/ew4Hzty050xMEGrS4HOlBNep7dFLQRQKYcoGKkoopDXXIIYh
         uZUDHJox+kcVIGFzDi1p9CX6jEVypVQcfii7jkaMPqbCqCEM+Ob7JB6T0rNJeNkR86ki
         wCa/1iE7BZ8DFS1NyMwfA35h1dFjv7tK0SseW8REMY7X/NyX6StBR9mjTBqXO3vB285n
         ybpLZ0h0RPCzVmHDHh03VX2cDB4GPnnkToV/yZtVVs6d1K+ppI9fuLfUZvoBisseI4pK
         2K+kXHg0CHwB63Po5qkiF1Xptma5ZVdYYW4Y+48ykf+tR4MPVmzMTJR2gXfxdKbQoP1r
         YDTg==
X-Gm-Message-State: AGi0PuYsCpDnVOAXXIv3XkhSnfbnd1nRytuBo7/e0Lgq9MyA6kJ42KMo
        3HA7XU333mTAo+Ho+3WiypDCH4Xtuodp/w==
X-Google-Smtp-Source: APiQypK91YmJ/zypDwWYeiUGGTtRcY3r6jBUkl5+7k4v01U2o6zcWTEhskl4b2aH+/9BYKgT54UQQw==
X-Received: by 2002:a17:906:90cc:: with SMTP id v12mr504911ejw.211.1588283559260;
        Thu, 30 Apr 2020 14:52:39 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b82f:dfc:5e2a:e7cc])
        by smtp.gmail.com with ESMTPSA id f13sm92022ejd.2.2020.04.30.14.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:52:38 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [RFC PATCH V2 3/9] btrfs: use attach/clear_page_private
Date:   Thu, 30 Apr 2020 23:44:44 +0200
Message-Id: <20200430214450.10662-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the new pair function is introduced, we can call them to clean the
code in btrfs.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.
2. call attach_page_private(newpage, clear_page_private(page)) to
   cleanup code further as suggested by Dave Chinner.

 fs/btrfs/disk-io.c   |  4 +---
 fs/btrfs/extent_io.c | 21 ++++++---------------
 fs/btrfs/inode.c     | 23 +++++------------------
 3 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a6cb5cbbdb9f..fe4acf821110 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -980,9 +980,7 @@ static void btree_invalidatepage(struct page *page, unsigned int offset,
 		btrfs_warn(BTRFS_I(page->mapping->host)->root->fs_info,
 			   "page private not zero on page %llu",
 			   (unsigned long long)page_offset(page));
-		ClearPagePrivate(page);
-		set_page_private(page, 0);
-		put_page(page);
+		clear_page_private(page);
 	}
 }
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 39e45b8a5031..095a5e83e660 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3076,22 +3076,16 @@ static int submit_extent_page(unsigned int opf,
 static void attach_extent_buffer_page(struct extent_buffer *eb,
 				      struct page *page)
 {
-	if (!PagePrivate(page)) {
-		SetPagePrivate(page);
-		get_page(page);
-		set_page_private(page, (unsigned long)eb);
-	} else {
+	if (!PagePrivate(page))
+		attach_page_private(page, eb);
+	else
 		WARN_ON(page->private != (unsigned long)eb);
-	}
 }
 
 void set_page_extent_mapped(struct page *page)
 {
-	if (!PagePrivate(page)) {
-		SetPagePrivate(page);
-		get_page(page);
-		set_page_private(page, EXTENT_PAGE_PRIVATE);
-	}
+	if (!PagePrivate(page))
+		attach_page_private(page, (void *)EXTENT_PAGE_PRIVATE);
 }
 
 static struct extent_map *
@@ -4929,10 +4923,7 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 			 * We need to make sure we haven't be attached
 			 * to a new eb.
 			 */
-			ClearPagePrivate(page);
-			set_page_private(page, 0);
-			/* One for the page private */
-			put_page(page);
+			clear_page_private(page);
 		}
 
 		if (mapped)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 320d1062068d..34b09ab2c32a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8303,11 +8303,8 @@ btrfs_readpages(struct file *file, struct address_space *mapping,
 static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
 {
 	int ret = try_release_extent_mapping(page, gfp_flags);
-	if (ret == 1) {
-		ClearPagePrivate(page);
-		set_page_private(page, 0);
-		put_page(page);
-	}
+	if (ret == 1)
+		clear_page_private(page);
 	return ret;
 }
 
@@ -8329,14 +8326,8 @@ static int btrfs_migratepage(struct address_space *mapping,
 	if (ret != MIGRATEPAGE_SUCCESS)
 		return ret;
 
-	if (page_has_private(page)) {
-		ClearPagePrivate(page);
-		get_page(newpage);
-		set_page_private(newpage, page_private(page));
-		set_page_private(page, 0);
-		put_page(page);
-		SetPagePrivate(newpage);
-	}
+	if (page_has_private(page))
+		attach_page_private(newpage, clear_page_private(page));
 
 	if (PagePrivate2(page)) {
 		ClearPagePrivate2(page);
@@ -8458,11 +8449,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	}
 
 	ClearPageChecked(page);
-	if (PagePrivate(page)) {
-		ClearPagePrivate(page);
-		set_page_private(page, 0);
-		put_page(page);
-	}
+	clear_page_private(page);
 }
 
 /*
-- 
2.17.1

