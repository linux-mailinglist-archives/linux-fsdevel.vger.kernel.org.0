Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434F136AF9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 10:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhDZIRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 04:17:46 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:59229 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232185AbhDZIRp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:17:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UWnOySz_1619425013;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UWnOySz_1619425013)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 26 Apr 2021 16:17:02 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Anton Altaparmakov <anton@tuxera.com>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH 2/2] ntfs: remove redundant check buffer_uptodate()
Date:   Mon, 26 Apr 2021 16:16:53 +0800
Message-Id: <1619425013-130530-3-git-send-email-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1619425013-130530-1-git-send-email-haoxu@linux.alibaba.com>
References: <1619425013-130530-1-git-send-email-haoxu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now set_buffer_uptodate() will test first and then set, so we don't have
to check buffer_uptodate() first, remove it to simplify code.

Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---
 fs/ntfs/file.c    | 9 +++------
 fs/ntfs/logfile.c | 3 +--
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index e5aab265dff1..08b6bdf2cc2f 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -719,8 +719,7 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 			 * error recovery.
 			 */
 			if (PageUptodate(page)) {
-				if (!buffer_uptodate(bh))
-					set_buffer_uptodate(bh);
+				set_buffer_uptodate(bh);
 				if (unlikely(was_hole)) {
 					/* We allocated the buffer. */
 					clean_bdev_bh_alias(bh);
@@ -814,8 +813,7 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 		read_unlock_irqrestore(&ni->size_lock, flags);
 		if (bh_pos > initialized_size) {
 			if (PageUptodate(page)) {
-				if (!buffer_uptodate(bh))
-					set_buffer_uptodate(bh);
+				set_buffer_uptodate(bh);
 			} else if (!buffer_uptodate(bh)) {
 				zero_user(page, bh_offset(bh), blocksize);
 				set_buffer_uptodate(bh);
@@ -938,8 +936,7 @@ static int ntfs_prepare_pages_for_non_resident_write(struct page **pages,
 				 * debatable and this could be removed.
 				 */
 				if (PageUptodate(page)) {
-					if (!buffer_uptodate(bh))
-						set_buffer_uptodate(bh);
+					set_buffer_uptodate(bh);
 				} else if (!buffer_uptodate(bh)) {
 					zero_user(page, bh_offset(bh),
 						blocksize);
diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
index bc1bf217b38e..9695540ce581 100644
--- a/fs/ntfs/logfile.c
+++ b/fs/ntfs/logfile.c
@@ -796,8 +796,7 @@ bool ntfs_empty_logfile(struct inode *log_vi)
 			get_bh(bh);
 			/* Set the entire contents of the buffer to 0xff. */
 			memset(bh->b_data, -1, block_size);
-			if (!buffer_uptodate(bh))
-				set_buffer_uptodate(bh);
+			set_buffer_uptodate(bh);
 			if (buffer_dirty(bh))
 				clear_buffer_dirty(bh);
 			/*
-- 
1.8.3.1

