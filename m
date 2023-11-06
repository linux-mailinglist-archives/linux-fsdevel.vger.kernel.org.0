Return-Path: <linux-fsdevel+bounces-2125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE057E2B40
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E32C1C20D13
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20062D043;
	Mon,  6 Nov 2023 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P5wi36f2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8052C85D
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 17:39:16 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF9510C3;
	Mon,  6 Nov 2023 09:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=RXBHu05/D+Bl9yrdetqm4iOS2E2N7VhXyiJElbk3dHk=; b=P5wi36f21cyyVWtagm3vBAOIYL
	rwdmTYDgKIVntaaXY3yZZ0G38KT9qTiKosU4eO2vByb/vh+DIBIqIWoSUyVugfr8XD5m+Yka3YvA0
	cJscc1GfGV5j8CKnXIh+G5cwkWcIpWLFMpKi8NGccNCfMPC6PkpKguDvLYUCzS2v+qNVUXG1PE6bN
	VX9c6p7Rq/XyueI2MwXxd8Utyj5ki+Xindfb/Sr42B80L4BryBbGqHZ1i/PYSHSv953cQcr01nGjp
	XJqbYp+OIBgu7oWVMyUinwg1E8n0/jcs+2BGQ5yZ4X9bRMZSGoJNY1Z5vp5QFpxUjyzbnDQhr+4y7
	F2J33VmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r03Z5-007H9G-Ka; Mon, 06 Nov 2023 17:39:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/35] nilfs2: Convert nilfs_btnode_create_block to use a folio
Date: Mon,  6 Nov 2023 17:38:43 +0000
Message-Id: <20231106173903.1734114-16-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106173903.1734114-1-willy@infradead.org>
References: <20231106173903.1734114-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Saves two calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/btnode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 5710833ac1cc..691a50410ea9 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -64,8 +64,8 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 	set_buffer_mapped(bh);
 	set_buffer_uptodate(bh);
 
-	unlock_page(bh->b_page);
-	put_page(bh->b_page);
+	folio_unlock(bh->b_folio);
+	folio_put(bh->b_folio);
 	return bh;
 }
 
-- 
2.42.0


