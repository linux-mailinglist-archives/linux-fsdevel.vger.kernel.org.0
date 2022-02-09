Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D004AFE45
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiBIUWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiBIUWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45CEE039C65
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+e3plOK/9AG7k4sZHKr4xjvY4pza4uqMoRO32/OLmLo=; b=HLw8vbAlsfHJkC0OmNOjDS9nqr
        zIbyjpyNoYRdEjDxeHV6fF6mO8uRh7FcgMfn34Kf9+92lxgqO9Q7ITOUvJSnxemdgxKO2dR+F1NgS
        cCVNhCDGPF+N8X1ItI3TDhN9T190mJKpYkBNt/i6+7oW/+9gUwvF8MFzsWwm4/WXPq5YFFAfF1VHE
        99GZJ983MRzw9XPBThGeO7VRf3wAuo+GNagU3p1IXE/R+3YbU6YRR0cFMP74Aj8iPTNDtj4hoqB+L
        TiJg3RcMPCS9h7Sl1nTlCkRWOw/84Z7i4SNS1vdVdjiJArOb1LXu8/0Jjss1OM1RuOm5aU3wuqbPQ
        sVj00Xbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTr-008cpG-6I; Wed, 09 Feb 2022 20:22:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 06/56] scsicam: Fix use of page cache
Date:   Wed,  9 Feb 2022 20:21:25 +0000
Message-Id: <20220209202215.2055748-7-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
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

Filesystems do not necessarily set PageError; instead they will leave
PageUptodate clear on errors.  We should also kmap() the page before
accessing it in case the page is allocated from HIGHMEM.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/scsi/scsicam.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
index 0ffdb8f2995f..cfa86348d868 100644
--- a/drivers/scsi/scsicam.c
+++ b/drivers/scsi/scsicam.c
@@ -41,8 +41,12 @@ unsigned char *scsi_bios_ptable(struct block_device *dev)
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

