Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6486625C3C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgICO56 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbgICOJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:09:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741F9C06123D
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2020 07:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1TI7kACnKxAs6qyYap9xlbLVdTcx6qiJPDK16lGE/14=; b=cSoGBSPbnuffhKTuR6ByVVm8jh
        rsZIgH5Vbd342Njwdho5/jI3BDrjbkQK9gKFbJup0oMBn7yWk4Hu04lSvzIerxKjcaBbp1f+HYwmg
        IX78vx0ftWJsUQN3k60D7C13HFwEWOyzsuPVuTdZf5Fhi6z+y6P8YxMqv7vMFH0EAVD9HsnK3iakQ
        Cu7HDRiGK46D+VzLQwdirObYxsp2kmv49scHObW4EjTE1HMtWxpYex8hhJfI6MHnR4+4qvcW74DCE
        9j1WUzFGIHxCcsR76IyRIPi6hQUoxXxK4lPcbebE3vZs2ArMXmcRJ5wLHuyxO5Cx6id4Ni8/JKI8O
        gkg6psYA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDpv1-0003hz-Gs; Thu, 03 Sep 2020 14:08:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 2/9] mm/readahead: Add DEFINE_READAHEAD
Date:   Thu,  3 Sep 2020 15:08:37 +0100
Message-Id: <20200903140844.14194-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200903140844.14194-1-willy@infradead.org>
References: <20200903140844.14194-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow for a more concise definition of a struct readahead_control.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 7 +++++++
 mm/readahead.c          | 6 +-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7de11dcd534d..19bba4360436 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -749,6 +749,13 @@ struct readahead_control {
 	unsigned int _batch_count;
 };
 
+#define DEFINE_READAHEAD(rac, f, m, i)					\
+	struct readahead_control rac = {				\
+		.file = f,						\
+		.mapping = m,						\
+		._index = i,						\
+	}
+
 /**
  * readahead_page - Get the next page to read.
  * @rac: The current readahead request.
diff --git a/mm/readahead.c b/mm/readahead.c
index 3c9a8dd7c56c..2126a2754e22 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -179,11 +179,7 @@ void page_cache_readahead_unbounded(struct address_space *mapping,
 {
 	LIST_HEAD(page_pool);
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
-	struct readahead_control rac = {
-		.mapping = mapping,
-		.file = file,
-		._index = index,
-	};
+	DEFINE_READAHEAD(rac, file, mapping, index);
 	unsigned long i;
 
 	/*
-- 
2.28.0

