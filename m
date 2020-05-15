Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9CD1D4ED8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgEONRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbgEONRD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B985DC05BD1C;
        Fri, 15 May 2020 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZvCAGtrDAcAsja+QmzFW6sNRVbIwR7f84uLooOJs50k=; b=d7HGG80tN6Vh0xs+XPqofRQTkN
        i/9CY2TSUURCgYZW5bGV8/giGx3/aly85rxPadBm4xbWWLgM6wFvC2thkJustR6QhfFx5i7yn/Di0
        FX2ui0TDSmccfhzmkim/jmUucgw/+u5R77FPvbdTc6FC/Yvg/32pdcNVXOix4Dfe3qeM8PsCNpboJ
        cCXRrLFl0gMKfoEtilibzrFQ7gzOW6CAtNDkgmGz0dj0nMebnWH/0eWoA7U3lhpsRB/0ahj3TxCTB
        mUhR8D8RpfMS4T8ClglEYnxh9D19HReKYb+vd9cdJobXp2orwiULHG5mooly4YHOqbx7ROrcp008+
        nkjvNPQQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaD0-0005mT-Fs; Fri, 15 May 2020 13:17:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 29/36] mm: Support retrieving tail pages from the page cache
Date:   Fri, 15 May 2020 06:16:49 -0700
Message-Id: <20200515131656.12890-30-willy@infradead.org>
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

page->index is not meaningful for tail pages; we have to use
page_to_index() in this assertion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 0ec7f25a07b2..56eb086acef8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1655,7 +1655,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 			put_page(page);
 			goto repeat;
 		}
-		VM_BUG_ON_PAGE(page->index != index, page);
+		VM_BUG_ON_PAGE(page_to_index(page) != index, page);
 	}
 
 	if (fgp_flags & FGP_ACCESSED)
-- 
2.26.2

