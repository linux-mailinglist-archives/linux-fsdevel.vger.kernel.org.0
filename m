Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E0446CC79
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbhLHE2z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240269AbhLHE0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C13DC0698D2
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=R0LtaHX+Nty2s7UBxTeFk5sP72cAhoO4NqqGhAST8A0=; b=bf4bCUp3zS1a+WG54pBkLY+ZTG
        yjbb50yIBv+0/xSJNVl/oepDXVAF0DloEfg4QJnMc2jArGc1q47spasIf0KIrKG1tDLRG69IwCtNP
        QlrLbFVPbV0HhHqASRhPcZRVHfhhAKShi4XVMlqHCADqG8DlRma+bAnk0c2reZLnJk0LuEMQoF4Ix
        Ra3l6/Xwu/kwqCp2eLAbO3W97w8A9DKHl827qZIqFKVrjn7viaXgtwarqGsRsmZPJ7Ca3CxZX68Mx
        4PBnnswWljYP1wMpUAbGzqqV1vug9aF4CiHxqprASXEtRoZXJR+cyfrzKY9IIoPiEn4zpYSbJDUHm
        +37gaQcg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU6-0084bf-HN; Wed, 08 Dec 2021 04:23:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 36/48] truncate: Skip known-truncated indices
Date:   Wed,  8 Dec 2021 04:22:44 +0000
Message-Id: <20211208042256.1923824-37-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we've truncated an entire folio, we can skip over all the indices
covered by this folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/truncate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/truncate.c b/mm/truncate.c
index 0000424fc56b..0df420c1cf5b 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -408,6 +408,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 			folio_wait_writeback(folio);
 			truncate_inode_folio(mapping, folio);
 			folio_unlock(folio);
+			index = folio_index(folio) + folio_nr_pages(folio) - 1;
 		}
 		truncate_exceptional_pvec_entries(mapping, &pvec, indices);
 		pagevec_release(&pvec);
-- 
2.33.0

