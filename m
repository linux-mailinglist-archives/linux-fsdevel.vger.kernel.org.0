Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2101D4F1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgEONRB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgEONRA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBA5C061A0C;
        Fri, 15 May 2020 06:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VHXm1L+rObZHMg/ZFaxYy0B7In8iJsSQq6tf5Ix1Zow=; b=UqUPO/AS2C7nEDmWKnfBwxvMuZ
        FRpK0JzrFPRL2ip0W/rlV4zc+quu0zhsUrETROgrrcdhcstdxlSvrVuc6TKNc00LFhLjFLzumzuAy
        6Dnmk/NQ75lXIs//uCViZIXhm1wkb5XRsibNmobrMfdjrDIla4Ew5BeWk12LiITWkMRyVPzvJ6Hd9
        zRdEjLk3Hdtf6ckuqUFfxObSB/iuajVnA2RbJ1HvZbibSIPWTsgVh98aOvTJBcSY3atAw0GEGFGDF
        bUy3XL78CHh9tr4nt9PaD/zdQFzh3lQicCf+Zrg3Lyv1MU0B+8M3ReoV5w31s2CMKQuFV1NBuNXIm
        Umkj+nnA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaCy-0005Rz-8b; Fri, 15 May 2020 13:17:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/36] mm: Move PageDoubleMap bit
Date:   Fri, 15 May 2020 06:16:21 -0700
Message-Id: <20200515131656.12890-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

PG_private_2 is defined as being PF_ANY (applicable to tail pages
as well as regular & head pages).  That means that the first tail
page of a double-map page will appear to have Private2 set.  Use the
Workingset bit instead which is defined as PF_HEAD so any attempt to
access the Workingset bit on a tail page will redirect to the head page's
Workingset bit.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 222f6f7b2bb3..de6e0696f55c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -164,7 +164,7 @@ enum pageflags {
 	PG_slob_free = PG_private,
 
 	/* Compound pages. Stored in first tail page's flags */
-	PG_double_map = PG_private_2,
+	PG_double_map = PG_workingset,
 
 	/* non-lru isolated movable page */
 	PG_isolated = PG_reclaim,
-- 
2.26.2

