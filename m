Return-Path: <linux-fsdevel+bounces-42480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1955DA42AA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 19:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FC23AF1B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 18:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BED265CC6;
	Mon, 24 Feb 2025 18:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NECBZsk+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616E2264FBE
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420336; cv=none; b=HbT6uuAJsWjljleN15+dzt24n11FoaMnVXIt8DYfc/6Iw58J1X0jXQUPIDnTWQqnGiE2o++tRm/gPwzo9Xe1gEGe+I9iiefhW5dz1nwqPyYC5IauLj9vkaAHmYoVvQimLbaDFhoZFZqD0c4pb4+EZydHbODuRY+sjneEV8VsV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420336; c=relaxed/simple;
	bh=Kt36AfpSBSErJTz9PYgVWAhUX3v1FgFO2qlt8NauuV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDyeDzfSgZbwKVDNCSvFuWtwP5tWG5/ZJGRJXny3j3GAA2TLRq9F4D4lFTPhWoA2CYxTd/MpyViPSOeqNRYAbxGHSvfTARCSVpbOxKLRlKL9Qjejh945d0BcJTlEnzjBxrg+159WBoijvzCuj9M6DBUJcQWinDM4EUMg21lkAqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NECBZsk+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=q9xbRWIYIPyGmMxpLr8R+u3sAtPTzGkSqEgQ21nEOZc=; b=NECBZsk+BOEjtYalZbphgp+h0x
	NiKTeDjhlCwJsXaxS2CA0Spwo1LMUwxr//IBJakCm3qifHwv7f0mZ0MJ4r/XwnNu46JQ1Yv4WAcMl
	iUAjRqX5EnJXQJwwRHRXmToDTcGDZgrVDXoCTeV7gWHROb1cJoKZjHYVBdwIclWEUGGUKDtBel8L1
	aEkzXDxlnUK+X6zfg9mNClO3IaZJrfmH88rVtj5YkLIHjBdn1SUvwHPh7BClzZq+wx3SLPubc/G11
	nWcCakbmzh8+b1gbG55yMyITseeEMIlUYRzAdpf6+874MWDsd7TfGh9fMu8KOGTFgcIJ4m8Pb6YAx
	z9TtYajQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmcpg-000000082fv-1vEp;
	Mon, 24 Feb 2025 18:05:32 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Mike Marshall <hubcap@omnibond.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Martin Brandenburg <martin@omnibond.com>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/9] orangefs: Remove orangefs_writepage()
Date: Mon, 24 Feb 2025 18:05:22 +0000
Message-ID: <20250224180529.1916812-5-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224180529.1916812-1-willy@infradead.org>
References: <20250224180529.1916812-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we add a migrate_folio operation, we can remove orangefs_writepage
(as there is already a writepages operation).  filemap_migrate_folio()
will do fine as struct orangefs_write_range does not need to be adjusted
when the folio is migrated.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/orangefs/inode.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 63d7c1ca0dfd..4ad049d5cc9c 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -64,15 +64,6 @@ static int orangefs_writepage_locked(struct page *page,
 	return ret;
 }
 
-static int orangefs_writepage(struct page *page, struct writeback_control *wbc)
-{
-	int ret;
-	ret = orangefs_writepage_locked(page, wbc);
-	unlock_page(page);
-	end_page_writeback(page);
-	return ret;
-}
-
 struct orangefs_writepages {
 	loff_t off;
 	size_t len;
@@ -605,7 +596,6 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
 
 /** ORANGEFS2 implementation of address space operations */
 static const struct address_space_operations orangefs_address_operations = {
-	.writepage = orangefs_writepage,
 	.readahead = orangefs_readahead,
 	.read_folio = orangefs_read_folio,
 	.writepages = orangefs_writepages,
@@ -615,6 +605,7 @@ static const struct address_space_operations orangefs_address_operations = {
 	.invalidate_folio = orangefs_invalidate_folio,
 	.release_folio = orangefs_release_folio,
 	.free_folio = orangefs_free_folio,
+	.migrate_folio = filemap_migrate_folio,
 	.launder_folio = orangefs_launder_folio,
 	.direct_IO = orangefs_direct_IO,
 };
-- 
2.47.2


