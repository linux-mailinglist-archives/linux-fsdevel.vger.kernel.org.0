Return-Path: <linux-fsdevel+bounces-60725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2F6B50A8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 03:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34157561265
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 01:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42F1226165;
	Wed, 10 Sep 2025 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0T0Zk4s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFED224AFA
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 01:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469227; cv=none; b=YxsRVukXTmvrzrf1GX7cE27Ih4nfrUDgwjk5LEmFYLe6DsaRn2JZnkgfiH7POLqfu3SKNdf4QYcCn2NCJIVNs/90p7+/E2bAx0PHrC6mul4wXgN8534+5ZKjWjw5XGZNX0184iTK9BNveRg2hYbcjfPcYpUFHAfSiTmHEaYd7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469227; c=relaxed/simple;
	bh=nKahzqIz83XaT+uPapT7Ju252SMX0ytFHAmEB6DhmoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qld0cGodIRit3q0xpZJjh6Kneh1p9eGkyQsdpTy2u5zvh6TeZtFdSe3oj4upiig3jISnU71QLoJnN5Xmnl8/ywUtAM1N/4H4/uDKosdxPTrqvyJrl9O4p8b3kR4cAi+aA8eTAmdVG/oEVHLKyXgca1OxX/RfjjQ4wuewn88aO0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0T0Zk4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C798C4CEF8;
	Wed, 10 Sep 2025 01:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757469226;
	bh=nKahzqIz83XaT+uPapT7Ju252SMX0ytFHAmEB6DhmoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r0T0Zk4sz/7O/k41dYETUNlJtNEETk2nMUh/GJ2GgQMA3Z8B1EgGqXmBcF57A5T3T
	 klxvDQN91r2YMa/9kLm5XwfDsUwPWY4GNSnsRpqGKtomKiwp3PTDaoOvfU8sD/ofN2
	 uyYLlMKPC/AlZAtqy4wtw2x7YImjSZBK+BigGrH2HuqUCBAMshAm0awiuaslQ22TN5
	 4QNdzEQPr39ytgKYtmVWjsRADkatNnfQmsYw35h6Dkj7FgU4J691PlSWfHGrpoeVGe
	 Qpxb2rXSESIP5Qg5rpInEnlngMGov77/288utJddyk/Qf1ICCXlqctTGYQmlE31qSy
	 24CC9whlbNL5w==
From: Trond Myklebust <trondmy@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH v5 1/3] filemap: Add a helper for filesystems implementing dropbehind
Date: Tue,  9 Sep 2025 21:53:42 -0400
Message-ID: <ea24b487cd83da3f69f6f358d2d7a167a1dd7687.1757177140.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757177140.git.trond.myklebust@hammerspace.com>
References: <cover.1755612705.git.trond.myklebust@hammerspace.com> <cover.1757177140.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add a helper to allow filesystems to attempt to free the 'dropbehind'
folio.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Link: https://lore.kernel.org/all/5588a06f6d5a2cf6746828e2d36e7ada668b1739.1745381692.git.trond.myklebust@hammerspace.com/
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
---
 include/linux/pagemap.h | 1 +
 mm/filemap.c            | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 12a12dae727d..201b7c6f6441 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1221,6 +1221,7 @@ void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
+void folio_end_dropbehind(struct folio *folio);
 void folio_wait_stable(struct folio *folio);
 void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb);
diff --git a/mm/filemap.c b/mm/filemap.c
index 751838ef05e5..66cec689bec4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1608,7 +1608,7 @@ static void filemap_end_dropbehind(struct folio *folio)
  * completes. Do that now. If we fail, it's likely because of a big folio -
  * just reset dropbehind for that case and latter completions should invalidate.
  */
-static void filemap_end_dropbehind_write(struct folio *folio)
+void folio_end_dropbehind(struct folio *folio)
 {
 	if (!folio_test_dropbehind(folio))
 		return;
@@ -1625,6 +1625,7 @@ static void filemap_end_dropbehind_write(struct folio *folio)
 		folio_unlock(folio);
 	}
 }
+EXPORT_SYMBOL_GPL(folio_end_dropbehind);
 
 /**
  * folio_end_writeback - End writeback against a folio.
@@ -1660,7 +1661,7 @@ void folio_end_writeback(struct folio *folio)
 	if (__folio_end_writeback(folio))
 		folio_wake_bit(folio, PG_writeback);
 
-	filemap_end_dropbehind_write(folio);
+	folio_end_dropbehind(folio);
 	acct_reclaim_writeback(folio);
 	folio_put(folio);
 }
-- 
2.51.0


