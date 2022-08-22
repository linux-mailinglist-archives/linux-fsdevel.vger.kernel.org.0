Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5DB59CB36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 23:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbiHVV6q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 17:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbiHVV6p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:58:45 -0400
X-Greylist: delayed 165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 14:58:44 PDT
Received: from p3plwbeout16-06.prod.phx3.secureserver.net (p3plsmtp16-06-2.prod.phx3.secureserver.net [173.201.193.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A2D17E3C
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 14:58:43 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.144])
        by :WBEOUT: with ESMTP
        id QFOloDwIMMXmVQFOloILK8; Mon, 22 Aug 2022 14:55:56 -0700
X-CMAE-Analysis: v=2.4 cv=EYgN/NqC c=1 sm=1 tr=0 ts=6303fb6d
 a=wXHyRMViKMYRd//SnbHIqA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=biHskzXt2R4A:10 a=lZFbU4aQAAAA:8 a=FXvPX3liAAAA:8
 a=gbRoYUdNN1fX-E31I0kA:9 a=yKZbCDypxrTF-tGext6c:22 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  QFOloDwIMMXmV
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=phoenix.fritz.box)
        by smtp02.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1oQFOk-000Clp-BD; Mon, 22 Aug 2022 22:55:54 +0100
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Chris Murphy <lists@colorremedies.com>
Subject: [PATCH] Squashfs: don't call kmalloc in decompressors
Date:   Mon, 22 Aug 2022 22:54:30 +0100
Message-Id: <20220822215430.15933-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfMRATBo/usai2DMDrUc9NVuRYTs+FFi3XKWOVn8r9gUPMPN5qf4mXY3WN22x1jhvAeo795SsByAcPzp5YGNA5LK6fjx7vrcju0IYOFHlC+r2C6WDvASM
 XXPXczRVuVkCgTvfRgOTTP5p3ISplnMhnY1QDt9HGME0JjpBzyN/8CyonBlbbYKAiPg5uyqNgXY6H/yS3ZM0V6Y5oenWYZxbEWU0JmX9rxDsTUONY9kJZfem
 9jY/vkpThTDI97f9HH/wXw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The decompressors may be called while in an atomic section.
So move the kmalloc() out of this path, and into the "page actor"
init function.

This fixes a regression introduced by commit
f268eedddf35 ("squashfs: extend "page actor" to handle missing pages")

Reported-by: Chris Murphy <lists@colorremedies.com>
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/file.c        |  2 +-
 fs/squashfs/file_direct.c |  2 +-
 fs/squashfs/page_actor.c  | 34 +++++++++++++++-------------------
 fs/squashfs/page_actor.h  |  5 +++++
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 98e64fec75b7..e56510964b22 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -593,7 +593,7 @@ static void squashfs_readahead(struct readahead_control *ractl)
 
 		res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
 
-		kfree(actor);
+		squashfs_page_actor_free(actor);
 
 		if (res == expected) {
 			int bytes;
diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index be4b12d31e0c..f1ccad519e28 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -74,7 +74,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	/* Decompress directly into the page cache buffers */
 	res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
 
-	kfree(actor);
+	squashfs_page_actor_free(actor);
 
 	if (res < 0)
 		goto mark_errored;
diff --git a/fs/squashfs/page_actor.c b/fs/squashfs/page_actor.c
index b23b780d8f42..54b93bf4a25c 100644
--- a/fs/squashfs/page_actor.c
+++ b/fs/squashfs/page_actor.c
@@ -52,6 +52,7 @@ struct squashfs_page_actor *squashfs_page_actor_init(void **buffer,
 	actor->buffer = buffer;
 	actor->pages = pages;
 	actor->next_page = 0;
+	actor->tmp_buffer = NULL;
 	actor->squashfs_first_page = cache_first_page;
 	actor->squashfs_next_page = cache_next_page;
 	actor->squashfs_finish_page = cache_finish_page;
@@ -68,20 +69,9 @@ static void *handle_next_page(struct squashfs_page_actor *actor)
 
 	if ((actor->next_page == actor->pages) ||
 			(actor->next_index != actor->page[actor->next_page]->index)) {
-		if (actor->alloc_buffer) {
-			void *tmp_buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
-
-			if (tmp_buffer) {
-				actor->tmp_buffer = tmp_buffer;
-				actor->next_index++;
-				actor->returned_pages++;
-				return tmp_buffer;
-			}
-		}
-
 		actor->next_index++;
 		actor->returned_pages++;
-		return ERR_PTR(-ENOMEM);
+		return actor->alloc_buffer ? actor->tmp_buffer : ERR_PTR(-ENOMEM);
 	}
 
 	actor->next_index++;
@@ -96,11 +86,10 @@ static void *direct_first_page(struct squashfs_page_actor *actor)
 
 static void *direct_next_page(struct squashfs_page_actor *actor)
 {
-	if (actor->pageaddr)
+	if (actor->pageaddr) {
 		kunmap_local(actor->pageaddr);
-
-	kfree(actor->tmp_buffer);
-	actor->pageaddr = actor->tmp_buffer = NULL;
+		actor->pageaddr = NULL;
+	}
 
 	return handle_next_page(actor);
 }
@@ -109,8 +98,6 @@ static void direct_finish_page(struct squashfs_page_actor *actor)
 {
 	if (actor->pageaddr)
 		kunmap_local(actor->pageaddr);
-
-	kfree(actor->tmp_buffer);
 }
 
 struct squashfs_page_actor *squashfs_page_actor_init_special(struct squashfs_sb_info *msblk,
@@ -121,6 +108,16 @@ struct squashfs_page_actor *squashfs_page_actor_init_special(struct squashfs_sb_
 	if (actor == NULL)
 		return NULL;
 
+	if (msblk->decompressor->alloc_buffer) {
+		actor->tmp_buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
+
+		if (actor->tmp_buffer == NULL) {
+			kfree(actor);
+			return NULL;
+		}
+	} else
+		actor->tmp_buffer = NULL;
+
 	actor->length = length ? : pages * PAGE_SIZE;
 	actor->page = page;
 	actor->pages = pages;
@@ -128,7 +125,6 @@ struct squashfs_page_actor *squashfs_page_actor_init_special(struct squashfs_sb_
 	actor->returned_pages = 0;
 	actor->next_index = page[0]->index & ~((1 << (msblk->block_log - PAGE_SHIFT)) - 1);
 	actor->pageaddr = NULL;
-	actor->tmp_buffer = NULL;
 	actor->alloc_buffer = msblk->decompressor->alloc_buffer;
 	actor->squashfs_first_page = direct_first_page;
 	actor->squashfs_next_page = direct_next_page;
diff --git a/fs/squashfs/page_actor.h b/fs/squashfs/page_actor.h
index 24841d28bc0f..95ffbb543d91 100644
--- a/fs/squashfs/page_actor.h
+++ b/fs/squashfs/page_actor.h
@@ -29,6 +29,11 @@ extern struct squashfs_page_actor *squashfs_page_actor_init(void **buffer,
 extern struct squashfs_page_actor *squashfs_page_actor_init_special(
 				struct squashfs_sb_info *msblk,
 				struct page **page, int pages, int length);
+static inline void squashfs_page_actor_free(struct squashfs_page_actor *actor)
+{
+	kfree(actor->tmp_buffer);
+	kfree(actor);
+}
 static inline void *squashfs_first_page(struct squashfs_page_actor *actor)
 {
 	return actor->squashfs_first_page(actor);
-- 
2.35.1

