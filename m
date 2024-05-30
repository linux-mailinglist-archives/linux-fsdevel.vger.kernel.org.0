Return-Path: <linux-fsdevel+bounces-20583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6888D53C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA911F21450
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F78717623F;
	Thu, 30 May 2024 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N5jCjK0r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62071158A0D;
	Thu, 30 May 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100482; cv=none; b=HbL6kQ/Z0cKA/ZY6Zo0ZfhIS5XBk7Dc5+Dth5tAPGL52LHzA4o6dNJGvoLpszjGtPbxxXJBEvlB5PxxKQTJngFrfuGNqW52aci5YTPWrja5QZI7kXziamgRoMoY3uEIA1BScqApaN+BjmUev/3YKtgIGuSDqMa/sCCh4KQ23dG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100482; c=relaxed/simple;
	bh=w6GvfP62T9SLPSb2tfSEk9b9tce2HSypWFfEjPIZObQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yju2CnLav6GNJumMT+sUt6QtFeAqO9vd9us7zMr0MKB8e8w+7e0COLaO2mVhnF8l1TS0qmPBkjgdQEXvOq9t/sgQ8SUP4yyy2n4uW9/eCQpMgxk2JH9BvjMvbu1ZwvofW7vmc17WXzWmvi1/X4KKipk9DFdklYG31/IN+oUz4pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N5jCjK0r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=+YDFhLGOb+ruafHTm4Z7krNJ+BxgfPnzFmdjq0f4XNk=; b=N5jCjK0rPDkGvVQsPNgqdn6J4L
	FrlE9Q9DRg4J69uky1DS4B+LfjntCMwFE0/shvvmSMDstfWEX8zSg+anbDPCq+A/p3osKu+E0q9RO
	rXD/kduRd9LbSkAYuHpFBVU9tJA9xnUO34NcicQctEtLJnm1wtzLHOpss8axxdgx9H8jlRC7dfZQU
	htV0d4jZFsY2LgQzGIuIP4Fx4eaMhgZx4sp+aKzYpypD4637P3eW4cnYqfJgHaF2cOL2SE2rzSNHr
	mIh1OGi7U9sQsK+H9/KOEtzYhZjqfAuvBMYsfEJDmRzNTbv28Vs6iTzJHlVGLgOS6blMyFAJOJ32g
	aCTW1LBg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmH0-0000000B8Lv-3edE;
	Thu, 30 May 2024 20:21:18 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 15/16] iomap: Remove calls to set and clear folio error flag
Date: Thu, 30 May 2024 21:21:07 +0100
Message-ID: <20240530202110.2653630-16-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240530202110.2653630-1-willy@infradead.org>
References: <20240530202110.2653630-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The folio error flag is not checked anywhere, so we can remove the calls
to set and clear it.

Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-xfs@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c5802a459334..49938419fcc7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -306,8 +306,6 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
 		spin_unlock_irqrestore(&ifs->state_lock, flags);
 	}
 
-	if (error)
-		folio_set_error(folio);
 	if (finished)
 		folio_end_read(folio, uptodate);
 }
@@ -460,9 +458,6 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.processed = iomap_readpage_iter(&iter, &ctx, 0);
 
-	if (ret < 0)
-		folio_set_error(folio);
-
 	if (ctx.bio) {
 		submit_bio(ctx.bio);
 		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
@@ -697,7 +692,6 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 
 	if (folio_test_uptodate(folio))
 		return 0;
-	folio_clear_error(folio);
 
 	do {
 		iomap_adjust_read_range(iter->inode, folio, &block_start,
@@ -1543,8 +1537,6 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 
 	/* walk all folios in bio, ending page IO on them */
 	bio_for_each_folio_all(fi, bio) {
-		if (error)
-			folio_set_error(fi.folio);
 		iomap_finish_folio_write(inode, fi.folio, fi.length);
 		folio_count++;
 	}
-- 
2.43.0


