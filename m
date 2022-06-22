Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A2F55416E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356973AbiFVEQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356766AbiFVEQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E05C6565
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=E8nxIBtz4fKhoonh4VerKpPAu/2XUoouy95LORnjtug=; b=UkzwhRuvLPguJ1zKWS5P+8tkAN
        c3AyUjTZiFEgUtuOx7Ag9yalu5I0S5q8UjTHz12len+7E8nGOJygeAD+5sR9KZ62wFS93fmqRxf3u
        I9h4wbe9bZMvEHDIASuMEVF2ieTElLYB38os5JjkQPFokM74lI7pIrnr/aPAdvzpCDH0TFmBDB+ez
        ndaRs+f0FjOpxsLMKgM/FzAIsJhYoWtBaNuAV0RtR6BfKJImA7f+l56AU1m7OdenCF5Aj9SFtLujj
        2n20ul+M503/LW+rHy2hFJXGt09BjG7Uqi1JpV2e8glKEEJtXB2ql8BdmXjlddWtgRSLSONn8XpVF
        yvyke8Gg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rmX-0035yQ-GS;
        Wed, 22 Jun 2022 04:15:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 29/44] ITER_XARRAY: don't open-code DIV_ROUND_UP()
Date:   Wed, 22 Jun 2022 05:15:37 +0100
Message-Id: <20220622041552.737754-29-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622041552.737754-1-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 811fa09515d8..92a566f839f9 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1289,15 +1289,7 @@ static ssize_t iter_xarray_get_pages(struct iov_iter *i,
 	offset = pos & ~PAGE_MASK;
 	*_start_offset = offset;
 
-	count = 1;
-	if (size > PAGE_SIZE - offset) {
-		size -= PAGE_SIZE - offset;
-		count += size >> PAGE_SHIFT;
-		size &= ~PAGE_MASK;
-		if (size)
-			count++;
-	}
-
+	count = DIV_ROUND_UP(size + offset, PAGE_SIZE);
 	if (count > maxpages)
 		count = maxpages;
 
-- 
2.30.2

