Return-Path: <linux-fsdevel+bounces-2120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 298747E2B2D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE15DB216A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506232C862;
	Mon,  6 Nov 2023 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SO28Zj4N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0122D29D09
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 17:39:11 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E33910C1;
	Mon,  6 Nov 2023 09:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=7t3zYAQvCkvirdJu4c4Q9fMP5+7V3p76B5YGNYy1k74=; b=SO28Zj4NA5VaNVuNsb6c0KEeMO
	fpEih//rVqdmeIPyFGObhgj8twtgy3oytVduPiNEGv+StD3t4bu7FxMhJ92QVE6z+8PSvuOaXs5Tk
	5YYeDxEVUy9EEybmJb98XXOQ/XVQ/HZTLDzqcsu4XjYymhTUipGfj0ZEWIjnpGhswPft3D6pF601v
	tw0Xh0ayBb6XjXS3FgVJb6mZ/1spO2olubqWjhwirFqpoRb6NCBHwVlU9iUp1eIAp7Dh49v79pWcl
	+2P9xXtZMAbNbWK016Mow6Rs8uLL5H/4RjYQmhr0z49NzUg61VXldeIbSVYEBrpG9FvapCm8YNWbj
	7AmW1Sig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r03Z5-007H98-H1; Mon, 06 Nov 2023 17:39:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/35] nilfs2: Convert nilfs_gccache_submit_read_data to use a folio
Date: Mon,  6 Nov 2023 17:38:42 +0000
Message-Id: <20231106173903.1734114-15-willy@infradead.org>
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
 fs/nilfs2/gcinode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index 8beb2730929d..bf9a11d58817 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -98,8 +98,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
 	*out_bh = bh;
 
  failed:
-	unlock_page(bh->b_page);
-	put_page(bh->b_page);
+	folio_unlock(bh->b_folio);
+	folio_put(bh->b_folio);
 	if (unlikely(err))
 		brelse(bh);
 	return err;
-- 
2.42.0


