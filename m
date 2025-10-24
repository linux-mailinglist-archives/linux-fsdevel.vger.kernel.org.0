Return-Path: <linux-fsdevel+bounces-65543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CA9C07796
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD510344F89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 17:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E7133FE08;
	Fri, 24 Oct 2025 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GXCqLlKQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584C631CA5A;
	Fri, 24 Oct 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325709; cv=none; b=dgAyZG6LiouEcZrU8rz9gLGGADi3W9s84RDWC6T+i6dZRLz0CIl4wRVTNoYKBvviNMbQKm7bCslnDY4rqNBbHWb9zyf6JnmCTqaljCq5o5BPyrj5bp3DeOwXRaDgoUKsT0imupCK+5R4CnaHXdJAFI60wNe24gyJfR9LSbdePLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325709; c=relaxed/simple;
	bh=5rxqm28jInhTvPZlo7Lb7NdtJBvFNa54w/E+WCxDquU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaZ5ju055K4bWvqCSVt8fqv6zMac9qD5qXXmnjEatXvwFCQBMEqa80XSCKy81BUyLQUK08qB0rRbYkGGpdzc/pj0xccJgpYnTJKN3PQhsNaNuC6+GX4LtQXjOVQ9eeJRYLaGBwClghuoVi7C+GkO8U3ZpsZx6R2cEa3ZE5PCogg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GXCqLlKQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=mdl7H6EKP/Vg6RTNb5AbJQkDdWcRFyzVVD++tdHodzA=; b=GXCqLlKQSm4gD6aaAm5fyLbXaL
	RWlS1YFhYrt7Iliey66+/QuH7PQ2cqgUsIwwczY8/McUkzKyydljNphLURSRa+xuWoVKspmTxxIb2
	/+zKSujY5wh7eBFgtm8+/WJMTZ+X9t4MPkbHRK7ANfCIz28raqB8DsHmaX3gH2Nq4i0CkW8UHboo7
	W0e5IuX6IHxcjQflT+dYhQVgEs752seseloQExTwVceEBn+74lQMAono0e/lEG+F4jVXYKnLRtznR
	6JW/Gi6FimjD8O93xqxnSSbirDm8juOeWfzhUZIkEEhPKH6OMoJuiBrcmpF7NWd58XI5I1t91FCPV
	B+/RiRfA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCLH7-00000005zM5-2PCb;
	Fri, 24 Oct 2025 17:08:25 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org
Subject: [PATCH 09/10] xfs: Use folio_next_pos()
Date: Fri, 24 Oct 2025 18:08:17 +0100
Message-ID: <20251024170822.1427218-10-willy@infradead.org>
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
Cc: Carlos Maiolino <cem@kernel.org>
Cc: linux-xfs@vger.kernel.org
---
 fs/xfs/scrub/xfarray.c | 2 +-
 fs/xfs/xfs_aops.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/scrub/xfarray.c b/fs/xfs/scrub/xfarray.c
index cdd13ed9c569..ed2e8c64b1a8 100644
--- a/fs/xfs/scrub/xfarray.c
+++ b/fs/xfs/scrub/xfarray.c
@@ -834,7 +834,7 @@ xfarray_sort_scan(
 		si->first_folio_idx = xfarray_idx(si->array,
 				folio_pos(si->folio) + si->array->obj_size - 1);
 
-		next_pos = folio_pos(si->folio) + folio_size(si->folio);
+		next_pos = folio_next_pos(si->folio);
 		si->last_folio_idx = xfarray_idx(si->array, next_pos - 1);
 		if (xfarray_pos(si->array, si->last_folio_idx + 1) > next_pos)
 			si->last_folio_idx--;
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index a26f79815533..ad76d5d01dd1 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -271,7 +271,7 @@ xfs_discard_folio(
 	 * folio itself and not the start offset that is passed in.
 	 */
 	xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK, pos,
-				folio_pos(folio) + folio_size(folio), NULL);
+				folio_next_pos(folio), NULL);
 }
 
 /*
-- 
2.47.2


