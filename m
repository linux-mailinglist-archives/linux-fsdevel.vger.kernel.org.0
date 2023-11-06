Return-Path: <linux-fsdevel+bounces-2118-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C797E2B21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 18:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E65B21583
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 17:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE61B2C854;
	Mon,  6 Nov 2023 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FMhC7Kmd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0133529D0A
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 17:39:11 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DA8B7;
	Mon,  6 Nov 2023 09:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=8lLT5xkKCqdiPAnTDVlD/IYjZd/DMWn1oTzzcwjirl0=; b=FMhC7KmdIkEelN5hAo6+nA3DZs
	th8uriNh3lL0MtRwwNwuyKHP58xfRnrDxOh3DI5jSSNCPeSO3Mrya8Nu9v3gSd6vvTqe+MvhQ18fk
	re4kYrAuwr27XRpYFPxZz3Vu4hnWQ+hYyirM9AiNgolrjlOHgXaKGwZ4QvYuh9uDG3f8LUmFCo9Qm
	AsS1sYFL1jzzfdWzlGra5j+5zmfjAI9u4NIWJas2C3Ri0gAvNtjlIQ6LRsh+DdPBkYcli3qI8/mS4
	gencGaSKW/IWeaD7GRMNjwCFBWNp9p+yS+w8eHX+mqAkOlryL1VyWoRHuDSwTKsAMvHxTXbb1XkA0
	SgKSyTaw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r03Z5-007H8q-7a; Mon, 06 Nov 2023 17:39:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/35] nilfs2: Convert nilfs_mdt_create_block to use a folio
Date: Mon,  6 Nov 2023 17:38:40 +0000
Message-Id: <20231106173903.1734114-13-willy@infradead.org>
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
 fs/nilfs2/mdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 2e7952ac2f67..7e4dcff2c94b 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -97,8 +97,8 @@ static int nilfs_mdt_create_block(struct inode *inode, unsigned long block,
 	}
 
  failed_bh:
-	unlock_page(bh->b_page);
-	put_page(bh->b_page);
+	folio_unlock(bh->b_folio);
+	folio_put(bh->b_folio);
 	brelse(bh);
 
  failed_unlock:
-- 
2.42.0


