Return-Path: <linux-fsdevel+bounces-58307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 347D2B2C6E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 16:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699DF5631BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 14:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A5F273803;
	Tue, 19 Aug 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAVEgD20"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EF224BD03;
	Tue, 19 Aug 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613116; cv=none; b=OOJUA1T0rcK+dEVY/IcRslBU8vwSN+Mo5CLNeAvGT636rKDI3ZMNjvrm8iYc/CXocBT1C0GlS0hxhmU+i8KC/sTbKfrvOQVT4H/F0CIJodXdja92CuZX8rhm3BxuuVvKFY0S5a0nGrMzdP/RcgOX96h63Y3UlvlEB/8D05X92rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613116; c=relaxed/simple;
	bh=KVsjEGJWGqVE5/nKYNCOY5h2mBt5VmM+qExcMUD44ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxNgeEnvvPiK9/YeJQJDQSw7/VPiiy4ttb8y6Rf14ArcprZPaWl1wrXITvVL0EwKbiv8kwbj84fEych+O5E7ukZ1UcYOhjuRViDsv+DlL6APUbMZTc4Re8+Z0CW759IbnOjHoAdv4/zIFbdR4nBiCpI1R6sbi1e65yV3xKKbd9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAVEgD20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC8BC4AF09;
	Tue, 19 Aug 2025 14:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755613115;
	bh=KVsjEGJWGqVE5/nKYNCOY5h2mBt5VmM+qExcMUD44ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CAVEgD20BaB/EBaB+LZILtO+ycP8ABmOVm2/SBRqOx6XYcTtROjU4qU6DIccBoMTT
	 IKQ51BrLs/mtaJ9L1bdVuYDFR84VwVLY0ONEMoxSMu1Z9bhPyHU/eXph4BKhjKJYZA
	 ne1kp/7/iHKzo3VhWsfxLUwPfo5Tnd5ZHJFCz369ZNp1iwY2vLaPpNzykK56W6gPlg
	 ob8wqkD+Zok44MBFFnW9Wa9iIy+dfXcCMiHO3TSciw9rk7h8X3/eps85ijk7LTeV7p
	 0Pl/rhv+xaFqcHO8ZowmpT6hDdlCdcYZgK/H9IGkd+RS+WTcvzSSIbYPA6PNnd5B0G
	 gDcWEXUFAGKSw==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 2/3] filemap: Add a version of folio_end_writeback that ignores dropbehind
Date: Tue, 19 Aug 2025 07:18:31 -0700
Message-ID: <260859ca7da2036c8c3be39b198c78f9ef4d0e3b.1755612705.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755612705.git.trond.myklebust@hammerspace.com>
References: <cover.1755612705.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Filesystems such as NFS may need to defer dropbehind until after their
2-stage writes are done. This adds a helper
folio_end_writeback_no_dropbehind() that allows them to release the
writeback flag without immediately dropping the folio.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 29 +++++++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 201b7c6f6441..5b26465358ce 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1221,6 +1221,7 @@ void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
+void folio_end_writeback_no_dropbehind(struct folio *folio);
 void folio_end_dropbehind(struct folio *folio);
 void folio_wait_stable(struct folio *folio);
 void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
diff --git a/mm/filemap.c b/mm/filemap.c
index 71209ebbcc36..0cf147ca7c16 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1628,14 +1628,15 @@ void folio_end_dropbehind(struct folio *folio)
 EXPORT_SYMBOL(folio_end_dropbehind);
 
 /**
- * folio_end_writeback - End writeback against a folio.
+ * folio_end_writeback_no_dropbehind - End writeback against a folio.
  * @folio: The folio.
  *
  * The folio must actually be under writeback.
+ * This call is intended for filesystems that need to defer dropbehind.
  *
  * Context: May be called from process or interrupt context.
  */
-void folio_end_writeback(struct folio *folio)
+void folio_end_writeback_no_dropbehind(struct folio *folio)
 {
 	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
 
@@ -1651,6 +1652,25 @@ void folio_end_writeback(struct folio *folio)
 		folio_rotate_reclaimable(folio);
 	}
 
+	if (__folio_end_writeback(folio))
+		folio_wake_bit(folio, PG_writeback);
+
+	acct_reclaim_writeback(folio);
+}
+EXPORT_SYMBOL(folio_end_writeback_no_dropbehind);
+
+/**
+ * folio_end_writeback - End writeback against a folio.
+ * @folio: The folio.
+ *
+ * The folio must actually be under writeback.
+ *
+ * Context: May be called from process or interrupt context.
+ */
+void folio_end_writeback(struct folio *folio)
+{
+	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
+
 	/*
 	 * Writeback does not hold a folio reference of its own, relying
 	 * on truncation to wait for the clearing of PG_writeback.
@@ -1658,11 +1678,8 @@ void folio_end_writeback(struct folio *folio)
 	 * reused before the folio_wake_bit().
 	 */
 	folio_get(folio);
-	if (__folio_end_writeback(folio))
-		folio_wake_bit(folio, PG_writeback);
-
+	folio_end_writeback_no_dropbehind(folio);
 	folio_end_dropbehind(folio);
-	acct_reclaim_writeback(folio);
 	folio_put(folio);
 }
 EXPORT_SYMBOL(folio_end_writeback);
-- 
2.50.1


