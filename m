Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F071C9DAE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 23:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgEGVoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 17:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbgEGVoW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 17:44:22 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEDBC05BD0B
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 14:44:22 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id s9so5896239eju.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5bOWsbby9E+qmMGJsuMwgUAgEfU2kO6P0jdaZ6pAtUk=;
        b=byF7VyPnLI+nh2I1eprmmNFINZ+NJ5pkCzxdpNRuekTuNjT51vhh3CkV59wkiwN6XH
         krwChNxiVaVptfaH/K+bCu0LY0cnQl5xilBXoOas9PauRDAkXOKPqe01yfPQuPx1XduZ
         A0TAiHE+AOTm+JRQPZP2nACr3Ul4ObfdoQGrxi+Cpr1bPzmZoE1CWkqpf+/r3ex3IIW2
         yZD1J7LPkidCeei/H6Hf6xaOAj2urjtMyLqyv0kw8rUdyUIpSq2wMms6dl/9ktOCl4VB
         9T6Fo6/2uYHMb6SPeVBuh+nwu7QH+Z1b83muCKIBcRYEGskyNZwNJKFacUigra42hXmQ
         eB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5bOWsbby9E+qmMGJsuMwgUAgEfU2kO6P0jdaZ6pAtUk=;
        b=AYls3Ihl9BhM0eqlQOaR/i/TCyBDktw7/kgyCEm3oNlqxbuQKz1AwvPsAlYTnXwj7y
         w+GI7pNUoLhHco8Pqx4AGHsEzLkLIRPLc4LIrzamj3RhgKflzYhPDe4R7PUEkqKkXd40
         VGDI3KlUBhQmjQgaKL93cNSTTAqQNPSk9EP8dc0z8o53y3msA7pchGN1Ors8DxtX2P+l
         7Ue2snWNtdS5wSSgVEEB1Tbb/T28H7FCWxBW1ZndlTVfrAf60kIqwdVdWpn3fb6jGCDU
         fccv9c4nxuFRi8JxeSKzC585mcnqUghZo41d8zUJY03Wv2AMM2xhGi9HNDFUmIti06Nm
         qiMQ==
X-Gm-Message-State: AGi0PuYtDLooNsqwWVtB0GKhtwMs5y+qU+HYR/OFkeYwonTOkgfilql7
        ObcqwiaCXOqaPRIzsenJyuG/7BaN70hCkA==
X-Google-Smtp-Source: APiQypKvd5mkRt0RGmY7O6yLJA3U6CWrKQQMB1yksU+oUQ9QxRNgVpW7n33l2Cd6M0LU0va+oSuwEA==
X-Received: by 2002:a17:906:3952:: with SMTP id g18mr14340273eje.191.1588887860372;
        Thu, 07 May 2020 14:44:20 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ee:a39a:b93a:c084])
        by smtp.gmail.com with ESMTPSA id k3sm613530edi.60.2020.05.07.14.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:19 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: [RFC PATCH V3 03/10] btrfs: use attach/detach_page_private
Date:   Thu,  7 May 2020 23:43:53 +0200
Message-Id: <20200507214400.15785-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
References: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
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
index d10c7be10f3b..7278789ff8a7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -980,9 +980,7 @@ static void btree_invalidatepage(struct page *page, unsigned int offset,
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
index 39e45b8a5031..bf816387715b 100644
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
+			detach_page_private(page);
 		}
 
 		if (mapped)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 320d1062068d..a7f7ff0a8b7c 100644
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
+		detach_page_private(page);
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
+		attach_page_private(newpage, detach_page_private(page));
 
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
+	detach_page_private(page);
 }
 
 /*
-- 
2.17.1

