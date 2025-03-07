Return-Path: <linux-fsdevel+bounces-43475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561F2A5705B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 19:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413A13AE2A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 18:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ADA23F29C;
	Fri,  7 Mar 2025 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VqSVwG2q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C2723C392
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371717; cv=none; b=TAg0QdkbM8ijQu6T3kUxfho0FdLDbk6n4YTqgxIkdno3hOhr7AFtnN+SypZDTX2Lx75+UWW6a26IYQ59CBKxiPHlzagGEG4QgDHuXDQr3BXcSdhJsEoSPr44edQSnxU+RB1iQRjEa79qnXT4fJM+Dr78uDbn2Y8l1QiVkz5b+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371717; c=relaxed/simple;
	bh=CEGXIWn/1l5S0j/7hNwbS5YhciyTTzqptoAUkwUhhRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fbjx75/kNjW6klgMqFo6eMokyxuEW8k2nYlxELxkn+zlTE20UGYzTcHXKw4oYFkGYa7sl2BwMLz3RM4CoLTvF9IXxvpMDZLkK5BoqP6nABv/u7w/l2ZPy4/GWhi65dYwQ0zPqHGIN8OoOzU8vAjX6WGe7KHKjtHRVcseElwfsN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VqSVwG2q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=T8fXRyaYOssoLEG59sUpr97PSMqTmPmVh2Clh/QPZVU=; b=VqSVwG2q44DQjB2VdNTLCmCUcC
	5fxZ5lK4EKJ1ka5T4Wo1HeorWt7by+y9ih2BiLpjoCR0aWZ43UZ/rPpzvW8M6FRDW4PNpQ5oPSnFD
	6Pyn7FYsRFquFHD0/dT4QJ6ZSzCAa3ylZmpXyHvIbsEENGKmTCy7rDn3fPTK903OsJJ2bNwzFFma0
	OYd8NdCM/7lag9GRtE1ZdQQGZrUB4IjAzeRzqzk2tHdUnaK402UUASWGQ0OqZ8uHIn5wxcuQ4Oi3T
	ER9qS5bxIm2dvf3kZ0InhmNfNjmlxnhyuVnTXZREnTAYrEoPLyKaV4TXYgz9Xfjn+q9rdERCe4Dxj
	pa1g+isA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqcKX-0000000EFjf-1jin;
	Fri, 07 Mar 2025 18:21:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] f2fs: Remove f2fs_write_meta_page()
Date: Fri,  7 Mar 2025 18:21:49 +0000
Message-ID: <20250307182151.3397003-4-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307182151.3397003-1-willy@infradead.org>
References: <20250307182151.3397003-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mappings which implement writepages should not implement writepage
as it can only harm writeback patterns.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/checkpoint.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index a35595f8d3f5..412282f50cbb 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -381,12 +381,6 @@ static int __f2fs_write_meta_page(struct page *page,
 	return AOP_WRITEPAGE_ACTIVATE;
 }
 
-static int f2fs_write_meta_page(struct page *page,
-				struct writeback_control *wbc)
-{
-	return __f2fs_write_meta_page(page, wbc, FS_META_IO);
-}
-
 static int f2fs_write_meta_pages(struct address_space *mapping,
 				struct writeback_control *wbc)
 {
@@ -507,7 +501,6 @@ static bool f2fs_dirty_meta_folio(struct address_space *mapping,
 }
 
 const struct address_space_operations f2fs_meta_aops = {
-	.writepage	= f2fs_write_meta_page,
 	.writepages	= f2fs_write_meta_pages,
 	.dirty_folio	= f2fs_dirty_meta_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
-- 
2.47.2


