Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A46F1BD5E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 02:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403905AbfIYAwT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 20:52:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391712AbfIYAwS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 20:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=42ILn7VMcsrJTz7O5GIB2CEUGt2gPkfqKrZQV8C0eas=; b=KBSXnigFVablb8KQbZq/Yf0TKY
        A8I7AtrNOd1ysd54G0tMobsxGWAqgz4kRXOciO7kJgO1ccogPjiHPU2VUJu1bEVmw0BL9mTF9GAYI
        dop6v15ZkD9BQD5mF1RWDh62GDWB/rz9lsS0rxjw97BaE+0YlTIqNznzf19FhudztuATJyttfvoJP
        wJQTLB+YhNze9mVsWig0hXJCk914UIj/2mzniOFv4OCttoi8RdnnPQ7KJ9eeQfhu5zO9A9sTBRpCF
        GvLPTgpX3i0DBp4/aNjAgHuxrglwKrasFt7x+z18I4EftTVwJYEh3wE3q+hWX6BMZ4U0ffoGQVvNG
        OAkd0bFg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCvXV-00077C-Nq; Wed, 25 Sep 2019 00:52:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     William Kucharski <william.kucharski@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 12/15] mm: Support removing arbitrary sized pages from mapping
Date:   Tue, 24 Sep 2019 17:52:11 -0700
Message-Id: <20190925005214.27240-13-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925005214.27240-1-willy@infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: William Kucharski <william.kucharski@oracle.com>

__remove_mapping() assumes that pages can only be either base pages
or HPAGE_PMD_SIZE.  Ask the page what size it is.

Signed-off-by: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/vmscan.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a7f9f379e523..9f44868e640b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -932,10 +932,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
 	 * Note that if SetPageDirty is always performed via set_page_dirty,
 	 * and thus under the i_pages lock, then this ordering is not required.
 	 */
-	if (unlikely(PageTransHuge(page)) && PageSwapCache(page))
-		refcount = 1 + HPAGE_PMD_NR;
-	else
-		refcount = 2;
+	refcount = 1 + compound_nr(page);
 	if (!page_ref_freeze(page, refcount))
 		goto cannot_free;
 	/* note: atomic_cmpxchg in page_ref_freeze provides the smp_rmb */
-- 
2.23.0

