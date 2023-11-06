Return-Path: <linux-fsdevel+bounces-2139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82C07E2B50
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D15282232
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8482DF9B;
	Mon,  6 Nov 2023 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j/u3rT8O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501CA2C879
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 17:39:18 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A180910DB;
	Mon,  6 Nov 2023 09:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=TgmUIUcJvy4zgyjRhv0niN+gofsFTMFSxbjhNAOTL9Q=; b=j/u3rT8OZvCzrc1Ql619YCcG4g
	sZhAqEy+ytTKBXt941J6a1j71tkAZtLovN7tOYnOqMIQJmKnw9ncS+y+9hYybqK3ZHufDurfrgIc+
	Ce+MmL1vS8TxFQH7sI+frFVKsasHg/tgBC9Qbr+u0soRwW3fw7hsCFTb86evmc0zTg5PFXOZsZDHE
	F2QtZe/XH3qaVH1pXA5w1jWs1sRniOF3XXbuWf4caGrJOShgORtqcT6E++DVUrEv92ZeLDvi1clyI
	/E/Bn+mYidURczrP+Gn7joj7N0uwC+1EkbhJ4VOltEJUXswlQUftuGDeVtwZTYlRJS1B2VyEq/EpX
	jGfbZmuw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r03Z6-007H9w-CV; Mon, 06 Nov 2023 17:39:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 20/35] nilfs2: Convert nilfs_btnode_abort_change_key to use a folio
Date: Mon,  6 Nov 2023 17:38:48 +0000
Message-Id: <20231106173903.1734114-21-willy@infradead.org>
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

Saves one call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/btnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index fb1638765d54..1204dd06ead8 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -284,7 +284,7 @@ void nilfs_btnode_abort_change_key(struct address_space *btnc,
 
 	if (nbh == NULL) {	/* blocksize == pagesize */
 		xa_erase_irq(&btnc->i_pages, newkey);
-		unlock_page(ctxt->bh->b_page);
+		folio_unlock(ctxt->bh->b_folio);
 	} else {
 		/*
 		 * When canceling a buffer that a prepare operation has
-- 
2.42.0


