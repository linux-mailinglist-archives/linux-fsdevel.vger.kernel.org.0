Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1105364EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353518AbiE0Pu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352555AbiE0Pup (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA753134E31
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dfGfqAk8u2UgYRm1HwJBzRxe+frhR8Bp+J7CKaOOiwY=; b=BSvw+oaTsBzBEeznCI3GEV7N2c
        dA2VISpqFvg+bo01gFuZ5w/O1Tb9fmB7VmatFZz+pmkSnR6/S5OuId7wNAnip6CGq2N64kYuD94fb
        a3LHNBu3LMenov6oLxVOQC+Ed+1uMA1GVcvLq24vpoQUg21vavOgpBuuzEQdTHI2CkuyWeR8mnpWM
        5DJG5vx+KFxTvXoTGAMUjeQeKh7fAAcDPWp/q5m1DTc1kFlufw4Vwz08ziebA/0tY6neIUTcf5h75
        RUO7AJVTCXddsO8XOmK1f6vtkwWjP9O0gizv1fdb4TH/i0wRigme2cvYIheoeYhR/yyLtVioC4HQv
        ymDB3llw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEc-002CXd-1H; Fri, 27 May 2022 15:50:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 20/24] btrfs: Use a folio in wait_dev_supers()
Date:   Fri, 27 May 2022 16:50:32 +0100
Message-Id: <20220527155036.524743-21-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220527155036.524743-1-willy@infradead.org>
References: <20220527155036.524743-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove a use of PageError and optimise putting the page reference twice.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/disk-io.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 89e94ea2fef5..12b11e645c14 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4178,7 +4178,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
 
 	for (i = 0; i < max_mirrors; i++) {
-		struct page *page;
+		struct folio *folio;
 
 		ret = btrfs_sb_log_location(device, i, READ, &bytenr);
 		if (ret == -ENOENT) {
@@ -4193,27 +4193,24 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		    device->commit_total_bytes)
 			break;
 
-		page = find_get_page(device->bdev->bd_inode->i_mapping,
+		folio = filemap_get_folio(device->bdev->bd_inode->i_mapping,
 				     bytenr >> PAGE_SHIFT);
-		if (!page) {
+		if (!folio) {
 			errors++;
 			if (i == 0)
 				primary_failed = true;
 			continue;
 		}
-		/* Page is submitted locked and unlocked once the IO completes */
-		wait_on_page_locked(page);
-		if (PageError(page)) {
+		/* Folio is unlocked once the IO completes */
+		folio_wait_locked(folio);
+		if (!folio_test_uptodate(folio)) {
 			errors++;
 			if (i == 0)
 				primary_failed = true;
 		}
 
-		/* Drop our reference */
-		put_page(page);
-
-		/* Drop the reference from the writing run */
-		put_page(page);
+		/* Drop our reference and the one from the writing run */
+		folio_put_refs(folio, 2);
 	}
 
 	/* log error, force error return */
-- 
2.34.1

