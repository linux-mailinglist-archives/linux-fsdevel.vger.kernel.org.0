Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8001E735B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391784AbgE2DEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391632AbgE2C6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C171DC008630;
        Thu, 28 May 2020 19:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VHXm1L+rObZHMg/ZFaxYy0B7In8iJsSQq6tf5Ix1Zow=; b=W8n52b8LE5nxLydoYBIVtfH1ZU
        tBMFjhfc9Tt0nqwfopjtHDwcamUK21hySPIMzeWFETfcmmpT5mJ3jnlQPYN0JJTkp6dFLEN2ePdhM
        50hneOnuAYzy6IG+rf+59oCdf4pazbPo9rqgDwE+USp1AECfHVS+KUtaSBhafeOGNNU/H3cn2vGiL
        A65cA8q85QIDnQ1ohHqRFnzO9wZL/lcWLmbqFGudp1/xkOXZoz5DfAjwtCXcL3kY5OHO6k8EHmRq6
        kN8iuYGKZH5WdNa2ZgE8OkjTFx/ytQPUd8vhrCczL655He++h/GrysJX0lena6YOgEyPMV3TMREUa
        G0XDQk3w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE2-0008Pi-K7; Fri, 29 May 2020 02:58:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/39] mm: Move PageDoubleMap bit
Date:   Thu, 28 May 2020 19:57:46 -0700
Message-Id: <20200529025824.32296-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
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

