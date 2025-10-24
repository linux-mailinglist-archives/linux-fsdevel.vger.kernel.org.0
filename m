Return-Path: <linux-fsdevel+bounces-65544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9DAC0779F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 465B93462F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 17:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCC7341AC3;
	Fri, 24 Oct 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kTA1Aece"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E8331B823;
	Fri, 24 Oct 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325709; cv=none; b=LegOV5qGpGfQ1oGPxssKqHAyfET1KCAAqOkkUBD5G0UWkVTlaIlaSwjbou+odBVn3+KLFSvM0KE0aFlCrLQSIkBmlgGoGUjsF3FJHbdiAU++OK9f/hEwvzwbAca4l1KOGIqfoyxjeBsKzKAGynWJv9FE4kGUt8Id7eJI6vjouFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325709; c=relaxed/simple;
	bh=I7OjZrLdjidz41pmeu7Dm9TTl+FjpxbES6Ucq9SnT7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XL5Y2zU4oejri5kVN9ywvc7wP/LrWipd9gto9YkM4Wmp2txmZy+mhCD/gFo4rmmdmZEuH7reFy9ndjsmIIGxwWBrN9nQ9IJhegzUex0jsOUMy5llORp0ohsOVymbFcUMM/JgR3wi0moPLmxOZQAv1vUjb0ogHlFDfd56++oSJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kTA1Aece; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=gQbEbtMk4xvLDHo+EQ/7L08bZxRCeN5TdFAqCaiobLc=; b=kTA1Aecet/k8QLMAeVRfeooriL
	CsP1JsoAW4AvUxBG9n71lSRpultlv4tVmLre/sI7nZt69o+pRvvmmsEcSEzS3meLMWx+Ly/pP3HDa
	kZYJy4ng3L05g8Ip2G9XSsxgOOeiB/9V0l4DecgUKYsV58hsQtURCGq6A5qxeDiyseb0dmIBle3N5
	bLjA6ICgujOfUrZAuJW7r/xinSYPRNCoCVq9i91+jsoB5udSMi9IvHYpYGqs2logsk+311wyGFogR
	F1g93+7bxJlbbnoG7jWOlbtpqh96T+7ONRzLCyNsuXqJGYl17qoB0N++rqaoxylj1G7+V0+L+1JVw
	KHUe0nyw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCLH7-00000005zLr-1h1F;
	Fri, 24 Oct 2025 17:08:25 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev
Subject: [PATCH 08/10] netfs: Use folio_next_pos()
Date: Fri, 24 Oct 2025 18:08:16 +0100
Message-ID: <20251024170822.1427218-9-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024170822.1427218-1-willy@infradead.org>
References: <20251024170822.1427218-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is one instruction more efficient than open-coding folio_pos() +
folio_size().  It's the equivalent of (x + y) << z rather than
x << z + y << z.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>
Cc: netfs@lists.linux.dev
---
 fs/netfs/buffered_write.c | 2 +-
 fs/netfs/misc.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 09394ac2c180..f9d62abef2ac 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -535,7 +535,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 		folio_unlock(folio);
 		err = filemap_fdatawrite_range(mapping,
 					       folio_pos(folio),
-					       folio_pos(folio) + folio_size(folio));
+					       folio_next_pos(folio));
 		switch (err) {
 		case 0:
 			ret = VM_FAULT_RETRY;
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 486166460e17..82342c6d22cb 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -298,7 +298,7 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp)
 	if (folio_test_dirty(folio))
 		return false;
 
-	end = umin(folio_pos(folio) + folio_size(folio), i_size_read(&ctx->inode));
+	end = umin(folio_next_pos(folio), i_size_read(&ctx->inode));
 	if (end > ctx->zero_point)
 		ctx->zero_point = end;
 
-- 
2.47.2


