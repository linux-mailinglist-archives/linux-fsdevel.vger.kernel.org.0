Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52F346CC66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbhLHE1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240153AbhLHE0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65827C0698C7
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5xJN0Ke/RBge8yAC47u5+/emcH/Klxeoku8OPLSI/Ow=; b=ThqWMSkjkUDbbxstIeqTv1Ubuf
        YwM7nhdVERRrxUd7hMYHiDCuTMAe3Qkwf2qXobZiRQ8jl7+ZpNH/k3CwZCfUe7WbJ9gK2VREnO25I
        NEMUuF9ffXWnT7K1N1Q6sh4/PZ6stwtg7KkYVmCIQDAzqayz2Hu3kdembJY/vlMePJiWy0ddt9luT
        n1UUTM07y2l3x4YlQ28qFh++SVppLXo57Em+jMpxFyrPrCpWYf0CJcHG8Hvx/94hhJjwYMoyu7uI/
        HOGQb5/sxBCFE0jBZ+zbWDgeGvmYzP29HmVskZDmCo0Sgx9yCJdwxngSSIX7QxjFtNwtdMguhN3sz
        GfHrv3Ow==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU1-0084Wh-Hg; Wed, 08 Dec 2021 04:23:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 01/48] filemap: Remove PageHWPoison check from next_uptodate_page()
Date:   Wed,  8 Dec 2021 04:22:09 +0000
Message-Id: <20211208042256.1923824-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pages are individually marked as suffering from hardware poisoning.
Checking that the head page is not hardware poisoned doesn't make
sense; we might be after a subpage.  We check each page individually
before we use it, so this was an optimisation gone wrong.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index daa0e23a6ee6..39c4c46c6133 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3253,8 +3253,6 @@ static struct page *next_uptodate_page(struct page *page,
 			goto skip;
 		if (!PageUptodate(page) || PageReadahead(page))
 			goto skip;
-		if (PageHWPoison(page))
-			goto skip;
 		if (!trylock_page(page))
 			goto skip;
 		if (page->mapping != mapping)
-- 
2.33.0

