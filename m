Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8023129955B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 19:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789827AbgJZSbn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 14:31:43 -0400
Received: from casper.infradead.org ([90.155.50.34]:47256 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1789823AbgJZSbn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2GAXeQp+qAGjuy9bKsT7VgfxgDveHwfLIaFkncYVm0o=; b=UPOocnwbI4TisiKum357PRYSKj
        XxutU7joMqEKT/ihMp6W48etMOMVqcEPp8snpREsxUA7e9Z5nfUhsRiNC2BKNl+4pLwYjRrOU4Xwv
        0fmiymHr+J0JPI4xGlMP+OyTceZsTzmWpRL3aeSxSsCeebqYX8vZbu7NEMy8LMnHJ/U5bX9QZOvSE
        XrvzzesWuAOGt7mWXs2X9PLk1jRJiYwLLVw83sArkcGv4Ppn5EqFJYcgG1ExexRoKZ0RmqXTy3uLB
        UkRSWDMEdkF+udy7xYRav7I63Iz3qQ3dAJTijTnSl5vZVPkBuhpUOAoASUl/RSZ+ZmIVXeFChzVx7
        IDm+feIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX7HR-0002jK-9n; Mon, 26 Oct 2020 18:31:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/9] mm/page-flags: Allow accessing PageError on tail pages
Date:   Mon, 26 Oct 2020 18:31:29 +0000
Message-Id: <20201026183136.10404-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026183136.10404-1-willy@infradead.org>
References: <20201026183136.10404-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We track whether a page has had a read error for the entire THP, just like
we track Uptodate and Dirty.  This lets, eg, generic_file_buffered_read()
continue to work on the appropriate subpage of the THP without
modification.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4f6ba9379112..eb3a9796de8e 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -328,7 +328,8 @@ static inline int TestClearPage##uname(struct page *page) { return 0; }
 
 __PAGEFLAG(Locked, locked, PF_NO_TAIL)
 PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD) __CLEARPAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
-PAGEFLAG(Error, error, PF_NO_TAIL) TESTCLEARFLAG(Error, error, PF_NO_TAIL)
+PAGEFLAG(Error, error, PF_HEAD)
+	TESTCLEARFLAG(Error, error, PF_HEAD)
 PAGEFLAG(Referenced, referenced, PF_HEAD)
 	TESTCLEARFLAG(Referenced, referenced, PF_HEAD)
 	__SETPAGEFLAG(Referenced, referenced, PF_HEAD)
-- 
2.28.0

