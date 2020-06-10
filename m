Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E201F5CB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgFJUPe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbgFJUNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0502AC008639;
        Wed, 10 Jun 2020 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=g1BN8ZEjBZSGzNik3H7y+eWzpa3p549rVRPP5tfDWW4=; b=S8TmZlwJGr4i53ZlyGiAARSx3B
        o/PTdqvC3Swsl/OTVTcOgVe3eSV6K/0lN7UW/J5JPqo+tAU8viOyJPIKIOu1hsqEeVXLnXrnUi2Vs
        YLJKG7xytHER10sJZqEc+TF9ikz4FxfiSvF3JS43qvLHLPlZ3caBAP88T39Gt9/lotHFCNCRWbwRZ
        yP+Q39vBRcNTIIwZfQUSvkyouf7jnoCZ/u2TFOE5fymJM/9gqbluTgEgio3WiJrQI6OqXs/LuecAX
        0oxXAbq9/a4ROH7pvpiQXLA3D209RsVrkiXL78R/X4E7CwcOcy1t67dxdH3a88p/G+B9aWnTMXHsf
        cCP91qEA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76a-0003XI-TB; Wed, 10 Jun 2020 20:13:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 40/51] mm: Avoid splitting THPs
Date:   Wed, 10 Jun 2020 13:13:34 -0700
Message-Id: <20200610201345.13273-41-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

If the filesystem supports THPs, then do not split them before
removing them from the page cache; remove them as a unit.
---
 mm/vmscan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 17934e03b3aa..0db62c1001f7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1277,9 +1277,9 @@ static unsigned int shrink_page_list(struct list_head *page_list,
 				/* Adding to swap updated mapping */
 				mapping = page_mapping(page);
 			}
-		} else if (unlikely(PageTransHuge(page))) {
-			/* Split file THP */
-			if (split_huge_page_to_list(page, page_list))
+		} else if (PageTransHuge(page)) {
+			if ((!mapping || !mapping_thp_support(mapping)) &&
+			    split_huge_page_to_list(page, page_list))
 				goto keep_locked;
 		}
 
-- 
2.26.2

