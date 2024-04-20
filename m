Return-Path: <linux-fsdevel+bounces-17337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27B18AB8F3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DF31F21532
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE7D1757D;
	Sat, 20 Apr 2024 02:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LGSiBxAf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415EF749F;
	Sat, 20 Apr 2024 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581457; cv=none; b=pDLfdKKSNLiwCNofkBDLEIg3rMromkaR3AKybYMCGenfJcmcAgG+Rmry7oNeWXWmPUhYD2MvkZRoc+8BbUAH1W2FT4J3LoYkze494PRyrG04LmJp7E5DrVBJq9VQk6JZaU+DRDz0RLgP0sDZyUYF8aeVaunBKNbAC2ldqJA+lt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581457; c=relaxed/simple;
	bh=HVnd1Mb1/NtwBa6Eu186EYKmXaLq3nEiepFrZcGeTKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRHp1zUkNeAtIDiXYVx1ICWC660c7nFdhYhNEaPNq1wyWsefheSt4jLrj+op8mLLCnobF9tZTfU4oJnh006dRRyiA0tAJSO2oD82apawwUww/ox9geeyUO+TtgfWyuConB7F8OyxvysSycpVPuyT7NBt4sI+Jw4dxvDBXrDVYzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LGSiBxAf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=pz9w8m7kq9s1LgGwb6slhtsGeQaR9Xa1bpf2LLmcF2Y=; b=LGSiBxAf99cBeq/5kf7Xr3Yctw
	aMigaedfRr+YowO/XpaLlasyDEeXgnd9tOAByYq5kc8jLEGInTpykYfR6uRNonBcL3wo9auxywHV5
	+TFYHCkcHMDbwJWUiuopBgZrwZ0QKgqD0fPuoLJN6+uLFP4SeuYIeA0KzhAJQU8fm7iDrKvf6PhPB
	b048TR3vVxpb6Tx9mj4kq2WHUxtvw5XLKYSSIp+5W+Zzf936HlzhuTjgGL2Vv6E/ZUWp3yduoptOs
	iDykDs6XMTweLCaN6ypNG5BVwxNghM0y+sr2L9/sqV6zi0468hNVTNg+xUmQZjDLEb/BCHc9S1lS6
	3i3YouEg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oX-000000095fb-3quP;
	Sat, 20 Apr 2024 02:50:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org
Subject: [PATCH 16/30] nilfs2: Remove calls to folio_set_error() and folio_clear_error()
Date: Sat, 20 Apr 2024 03:50:11 +0100
Message-ID: <20240420025029.2166544-17-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody checks this flag on nilfs2 folios, stop setting and clearing it.
That lets us simplify nilfs_end_folio_io() slightly.

Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/dir.c     | 1 -
 fs/nilfs2/segment.c | 8 +-------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index aee40db7a036..a002a44ff161 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -174,7 +174,6 @@ static bool nilfs_check_folio(struct folio *folio, char *kaddr)
 		    dir->i_ino, (folio->index << PAGE_SHIFT) + offs,
 		    (unsigned long)le64_to_cpu(p->inode));
 fail:
-	folio_set_error(folio);
 	return false;
 }
 
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index aa5290cb7467..8654ab8ad534 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1725,14 +1725,8 @@ static void nilfs_end_folio_io(struct folio *folio, int err)
 		return;
 	}
 
-	if (!err) {
-		if (!nilfs_folio_buffers_clean(folio))
-			filemap_dirty_folio(folio->mapping, folio);
-		folio_clear_error(folio);
-	} else {
+	if (err || !nilfs_folio_buffers_clean(folio))
 		filemap_dirty_folio(folio->mapping, folio);
-		folio_set_error(folio);
-	}
 
 	folio_end_writeback(folio);
 }
-- 
2.43.0


