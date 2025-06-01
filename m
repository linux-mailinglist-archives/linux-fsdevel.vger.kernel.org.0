Return-Path: <linux-fsdevel+bounces-50264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5A6AC9D6A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jun 2025 02:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B4017906D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Jun 2025 00:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5BA4A08;
	Sun,  1 Jun 2025 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ttPlAFWF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AA6184E
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Jun 2025 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748737639; cv=none; b=i2doJ56KWAD8RPSXgJKVHVmItwIjW9q0uHMnTA0d/VeOXUAgrvUlIrGlZCraLOQyCXevDZNppOQgwttodo7lcn2oJEPHOCMRaZwPUZtMEeteU4QfDF6r2+u/yjiI5MF4DyHKXJfyRM5vDztVxMIGot0Hy9FogqODThHlEXjCE0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748737639; c=relaxed/simple;
	bh=2Z1cicdkzkzP2UKO48mQJ04lyB+ffSDQexDu9AdSTdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=INkqfzGn32Sah6Y/asTbBOLhFrt4A6ZHVIKUfapBJ43rsI7J9JgT/LbqPBkDZT99M8bS75QaPN0bBFRHf0UHXokU4f8YJAQspJuyNQqLoGNOIp5/QC4rW5AczJxDrSDxxEi5a1xkzTMfHWZraCm30eq+QvSkP1shNwDT+8tIudQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ttPlAFWF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=dJ73w8fLMRnc9WwrkETVXIt20fRxZ2OdwHbOXHE1IX8=; b=ttPlAFWF/PQAuDqGB1ab+Oi6on
	uc1bj1glNlrKuwbDED39eam8A+RST2oOAcW2RX+jKMx6abDzHPjiEFxsqjWWXhOE/sROXV0//kWXN
	LasZSBQdC8HLzP8dZIJuIQruaiNxcFqlebRPycEpNADXdkZASmskhEyvGFrpUJ1PNIaUkKzGvXib5
	E+NMePC6UqtsvlYix8bRkqSS7yTMjaKQzL2UmE9n3y4M1PBxOn7zAC65Ky+Ogg5SL/vkPgfYnWCkI
	JEaM2TTh+rArWIVBCVgqeOyQvJfh3QfuCj0AP3FQ3qp+ySOX1Ck5PhsFWx+Gx6iXnUeJ9UWqCwiYi
	FWkSZ7QA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLWXi-0000000HB9q-2XDj;
	Sun, 01 Jun 2025 00:27:14 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: Fix __write_node_folio() conversion
Date: Sun,  1 Jun 2025 01:26:54 +0100
Message-ID: <20250601002709.4094344-1-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This conversion moved the folio_unlock() to inside __write_node_folio(),
but missed one caller so we had a double-unlock on this path.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Reported-by: syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com
Fixes: 80f31d2a7e5f (f2fs: return bool from __write_node_folio)
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/node.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1cb4cba7f961..bfe104db284e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2078,7 +2078,6 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 
 			if (!__write_node_folio(folio, false, &submitted,
 					wbc, do_balance, io_type, NULL)) {
-				folio_unlock(folio);
 				folio_batch_release(&fbatch);
 				ret = -EIO;
 				goto out;
-- 
2.47.2


