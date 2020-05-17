Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1681D6DA2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 23:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgEQVsI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 May 2020 17:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgEQVr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 May 2020 17:47:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB4FC05BD09
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 14:47:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id m12so7391995wmc.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 14:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+NNOaVE9c9xGGuOYwwS94f/tcLOCL8JkmWYJIg2IYGE=;
        b=W4RlgQDEM4dTeXyi2mptdIu5T2CvqwRG+TKlWVbkMelzNIfaff9Wmw0PAXMiyfwhWW
         yJAe47ZFLz3pYPOG9I3Il9qsRPlFq0oKinV6U9c1odAv8brONkSKQKblNq8dfw6SdEge
         qERSqJUwmaypO56h4G7DMc66bvjPx0fvQO9yOAmgusWYGI4DsNcSBiA08ndHk8UDn9Eo
         BkGzmsf7dVh1lNVUwGgJCxs9MRBYBkgb+9Jlka1rcfFw+IHqrgMTQk554+4nG7sZ8+fl
         d4ekX1CRU5P96jm1pxMRkllf8WkXhLbACTVHqQvDLQ36sdL8tVIO1XW7/hkyyr3mri9G
         tS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+NNOaVE9c9xGGuOYwwS94f/tcLOCL8JkmWYJIg2IYGE=;
        b=cE7L8LN7wiMI1wIHTFSEdjB8+XmE93SJ2LRbCaErawA5eu7kLMHvPBDyb5m7+PkaUE
         IeSXjuJL6xk+63EX4MwRXSG2tP855oH1ZfZSjwKPv9qsNC+2UctBj0vOML2rwIPWJp+D
         EZyBk8nQ3CNz52m2CoOQIAKorBCvVmxQjeS5iQ/42EbIq71beAtSGfZT4+BUJProoyNi
         dna6ayWiaGP1T2CtcFMu8AKs2XILh5YqmTptSd5XTbSKli+VVAfhR8pQ8a/2KPRX4gch
         YbpFLikBlfwESgKfp50ieV7DM4ewpyMorqORtoSZ4x907e1abYDkJfYVkQVMRjaYZCeG
         ylXQ==
X-Gm-Message-State: AOAM532Nhxik4RWcbgYJ5eT4ci8X6eL4zN6R1ajBNVXqZrbmf8RJ/6rd
        DeHRmOFzDnnruqL+skXBL0xIRQ==
X-Google-Smtp-Source: ABdhPJwFvf8yPjIIkLewjmPunGXmJjDmpB+fcd9N0uP58czfZv7ot6xefo997dox8kuTcZtlMepuSQ==
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr4221199wmc.116.1589752046199;
        Sun, 17 May 2020 14:47:26 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:bc3e:92a1:7010:2763])
        by smtp.gmail.com with ESMTPSA id v126sm14441244wmb.4.2020.05.17.14.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 14:47:25 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 03/10] btrfs: use attach/detach_page_private
Date:   Sun, 17 May 2020 23:47:11 +0200
Message-Id: <20200517214718.468-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
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
No change since RFC V3.

RFC V2 -> RFC V3
1. rename clear_page_private to detach_page_private.

RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.
2. call attach_page_private(newpage, clear_page_private(page)) to
   cleanup code further as suggested by Dave Chinner.

 fs/btrfs/disk-io.c   |  4 +---
 fs/btrfs/extent_io.c | 21 ++++++---------------
 fs/btrfs/inode.c     | 23 +++++------------------
 3 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 714b57553ed6..44745d5e05cf 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -976,9 +976,7 @@ static void btree_invalidatepage(struct page *page, unsigned int offset,
 		btrfs_warn(BTRFS_I(page->mapping->host)->root->fs_info,
 			   "page private not zero on page %llu",
 			   (unsigned long long)page_offset(page));
-		ClearPagePrivate(page);
-		set_page_private(page, 0);
-		put_page(page);
+		detach_page_private(page);
 	}
 }
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 451d17bfafd8..704239546093 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3099,22 +3099,16 @@ static int submit_extent_page(unsigned int opf,
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
@@ -4935,10 +4929,7 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 			 * We need to make sure we haven't be attached
 			 * to a new eb.
 			 */
-			ClearPagePrivate(page);
-			set_page_private(page, 0);
-			/* One for the page private */
-			put_page(page);
+			detach_page_private(page);
 		}
 
 		if (mapped)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 037efc25d993..6c2d6ecedd6a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7927,11 +7927,8 @@ static void btrfs_readahead(struct readahead_control *rac)
 static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
 {
 	int ret = try_release_extent_mapping(page, gfp_flags);
-	if (ret == 1) {
-		ClearPagePrivate(page);
-		set_page_private(page, 0);
-		put_page(page);
-	}
+	if (ret == 1)
+		detach_page_private(page);
 	return ret;
 }
 
@@ -7953,14 +7950,8 @@ static int btrfs_migratepage(struct address_space *mapping,
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
+		attach_page_private(newpage, detach_page_private(page));
 
 	if (PagePrivate2(page)) {
 		ClearPagePrivate2(page);
@@ -8082,11 +8073,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	}
 
 	ClearPageChecked(page);
-	if (PagePrivate(page)) {
-		ClearPagePrivate(page);
-		set_page_private(page, 0);
-		put_page(page);
-	}
+	detach_page_private(page);
 }
 
 /*
-- 
2.17.1

