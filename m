Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9C65151D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379511AbiD2R3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376592AbiD2R3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E131C972F5
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vbsx+quejBFeLn9wOCiR2ga53RNajVJdqgmVEXZMboY=; b=b8oGoj6wVBJub8eSoP8yBLt8Ol
        rVsP718EmtPw0YpCM2P1WLPZ7j5u5gOhGb1vcEV5naEPw1hlU7n2PIi7oWay1GNO8y/HpNGbJQT7+
        KARPkmuk6LCD5xTqOL426E/UaX5/vOusQ5o8CVM76gLOQOVeBfONkbCBQtV+fqstNl2n4NI2nr2xL
        yXRORK/1GHPLt0le6PJ6QdNkliFVcoLcDWfTPQR7sfGAkcHzmdRuFNBqDQ5/q1dCc3aomrbQsy17S
        ogST8abjnPG7zb8WPuakbIKPa3Bo7PPNj47ndvGGNba1Z6ExvCK3MruHFdsZ1V0pFygiopjeuQ0ho
        Jm5ZbC3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNW-00CdX1-4R; Fri, 29 Apr 2022 17:26:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 01/69] scsicam: Fix use of page cache
Date:   Fri, 29 Apr 2022 18:24:48 +0100
Message-Id: <20220429172556.3011843-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
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

Filesystems do not necessarily set PageError; instead they will leave
PageUptodate clear on errors.  We should also kmap() the page before
accessing it in case the page is allocated from HIGHMEM.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/scsi/scsicam.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
index acdc0aceca5e..baba801895df 100644
--- a/drivers/scsi/scsicam.c
+++ b/drivers/scsi/scsicam.c
@@ -40,8 +40,12 @@ unsigned char *scsi_bios_ptable(struct block_device *dev)
 	if (IS_ERR(page))
 		return NULL;
 
-	if (!PageError(page))
-		res = kmemdup(page_address(page) + 0x1be, 66, GFP_KERNEL);
+	if (PageUptodate(page)) {
+		char *addr = kmap_local_page(page);
+
+		res = kmemdup(addr + 0x1be, 66, GFP_KERNEL);
+		kunmap_local(addr);
+	}
 	put_page(page);
 	return res;
 }
-- 
2.34.1

