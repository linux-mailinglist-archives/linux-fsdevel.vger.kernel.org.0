Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310DB67D637
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjAZUYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjAZUYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914B44B769;
        Thu, 26 Jan 2023 12:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UEz9pyzC/zJuznnpiO8NJUu6xULxxn7l/UWQvd4w6/o=; b=dNiswVhYSmAZ7+Adzs5mGBDDtP
        JSAB134gOg3HJqVvzcGFIn3KACowbmWe6OK43LLubznsY++TrvCorBXSY9ebwha46olxEOFioUGe2
        i/Qw+QQoygSEJKjYD2yw1BNCSAccHZWa+Oc4IIxSvjkYIeofNRSKj+J+VzDbsUmQKontZBPkpOtAW
        INGQLZNFeTUND84WTa7kEpKA6X0TSjxxwitXvVonkzbJ+1z0UEKMI8mC8NunJV/1FsLgpzx/JtRUa
        Oz38l2vGao8DQiYD+4FGnHsUWVm0PDjJ2VZ3AqVSnd6sy5cIpijvChEB9iX5cfwr95cNC72lZ+1Lx
        HQqtBaHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nE-0073l5-S6; Thu, 26 Jan 2023 20:24:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 22/31] ext4: Convert ext4_page_nomap_can_writeout() to take a folio
Date:   Thu, 26 Jan 2023 20:24:06 +0000
Message-Id: <20230126202415.1682629-23-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230126202415.1682629-1-willy@infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Its one caller is already using a folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9b2c21d0e1f3..e7e8f2946012 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2563,11 +2563,11 @@ static int ext4_da_writepages_trans_blocks(struct inode *inode)
 }
 
 /* Return true if the page needs to be written as part of transaction commit */
-static bool ext4_page_nomap_can_writeout(struct page *page)
+static bool ext4_page_nomap_can_writeout(struct folio *folio)
 {
 	struct buffer_head *bh, *head;
 
-	bh = head = page_buffers(page);
+	bh = head = folio_buffers(folio);
 	do {
 		if (buffer_dirty(bh) && buffer_mapped(bh) && !buffer_delay(bh))
 			return true;
@@ -2683,7 +2683,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 * modify metadata is simple. Just submit the page.
 			 */
 			if (!mpd->can_map) {
-				if (ext4_page_nomap_can_writeout(&folio->page)) {
+				if (ext4_page_nomap_can_writeout(folio)) {
 					err = mpage_submit_folio(mpd, folio);
 					if (err < 0)
 						goto out;
-- 
2.35.1

