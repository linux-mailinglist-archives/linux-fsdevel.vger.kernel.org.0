Return-Path: <linux-fsdevel+bounces-41402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FB5A2EE67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 14:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D44F1889EE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 13:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E509231A46;
	Mon, 10 Feb 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HGb77Oi/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D7F22FF43;
	Mon, 10 Feb 2025 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194498; cv=none; b=ggPLBWEp3pUQpT8fcabFzvZG/qYPZfwAJDUfmDTilygkK6xCdNh+unN5JzlIoRvurl9366FO8wr8o683tNpJsydFZwx2Q9tHRflAK+DISmPXs3v+HjtcJtC/crSWSVi4k+j8tkteNE5/pAJYa2TVf0VQCqal2W+DySOCfuT56fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194498; c=relaxed/simple;
	bh=w7bxwAnZv/QEliC18ASKViHZm3n46+jYgCt/nHSde4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5OQs3L6GvO0MPnS721xxIItTGylRAklgsk3nBVBnl2YUmrmcpndHpHshFqOWf+BpqVxaiIqVb3ulrn0HpdgdbHmZedmpbsrvWHIl2gE2MZKI99P7yyKqEAQkxjVyUZK4Zko0mWUBqevWpMXf7IDNH8gmBFxm0bc/xUcoQgTBW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HGb77Oi/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=fyUQp+uL/ZgVZNc447UUj9/Z9HHRPY2gBHROD633lhM=; b=HGb77Oi/Q64MLlVu489bi6gLRT
	OhVCXsFEqSguLZOKiqcpV8H872uQEbSLfd/JB/5LEUIrDWY3gsM+68UU+wdd/8HINk/XRFrO3+IIJ
	h3NZHBBhCI6CV9Un0TtRjLSBhTABsApT4jsQtY6s+BjIYiJ+o5QLAQndEy87tx91kGqRkVrklSzly
	7pWW+v9+7i3ZVEZU2EfCxc2Sfm6lzmuyDYTx4nIfss3dkmhulJriNwalJVToTGh/N709qDtvIu/DE
	08vc24jhaWXOb4kf3e0Jy+E/BvRKyJJAMbVWzar3EnBF3Wm+cjRA7+lSQIV6vEDyudbwVelPcGhjE
	Z/eVgJ7w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thTw6-0000000FvZu-01mc;
	Mon, 10 Feb 2025 13:34:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/8] gfs2: Use b_folio in gfs2_check_magic()
Date: Mon, 10 Feb 2025 13:34:42 +0000
Message-ID: <20250210133448.3796209-5-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133448.3796209-1-willy@infradead.org>
References: <20250210133448.3796209-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are preparing to remove bh->b_page.  Use kmap_local_folio() instead
of kmap_local_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/lops.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index d27f34688ff5..4123bfc16680 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -615,15 +615,13 @@ static struct page *gfs2_get_log_desc(struct gfs2_sbd *sdp, u32 ld_type,
 
 static void gfs2_check_magic(struct buffer_head *bh)
 {
-	void *kaddr;
 	__be32 *ptr;
 
 	clear_buffer_escaped(bh);
-	kaddr = kmap_local_page(bh->b_page);
-	ptr = kaddr + bh_offset(bh);
+	ptr = kmap_local_folio(bh->b_folio, bh_offset(bh));
 	if (*ptr == cpu_to_be32(GFS2_MAGIC))
 		set_buffer_escaped(bh);
-	kunmap_local(kaddr);
+	kunmap_local(ptr);
 }
 
 static int blocknr_cmp(void *priv, const struct list_head *a,
-- 
2.47.2


