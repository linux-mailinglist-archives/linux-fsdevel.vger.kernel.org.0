Return-Path: <linux-fsdevel+bounces-47022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18DCA97DC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 06:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01C2189DF1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 04:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E10264FAA;
	Wed, 23 Apr 2025 04:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jArP88ke"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0584128F1;
	Wed, 23 Apr 2025 04:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745382335; cv=none; b=lNJ6UrdQxPgyo8tWCYujkCT1Y2w8V0WIN/O5Bx+twVqyRT6ToiRxVNhgb/WT6x1dEW75+7zPEouhg48qPAD17dRZfxJauq7CNOPX3B22fxfoCrZ9wH9nEEBGRENt3155kc4eOCb3wXFqZ7yw4hP0VUvrpE5YoDVAdMH47i7MMvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745382335; c=relaxed/simple;
	bh=5FHKJHeEbixqLbnO4ZuMe6ujdSNBN9ix/KEG8tocq48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBATl9sKCxV9AVErSWzeUrtEoFBfJ4MN/aDTv2HqVRhD668/8yy8cWVqX4c9lJvEcDa/brAq27z+liMIRW6pDCrxeAEsFC+6Q/x4HIQg7mROOXoelNlerkGArF5WyObu+e17tZ9XsczQwG0GENhQmdS7mY++KFzXfHUWRp17x5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jArP88ke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A189C4CEEC;
	Wed, 23 Apr 2025 04:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745382334;
	bh=5FHKJHeEbixqLbnO4ZuMe6ujdSNBN9ix/KEG8tocq48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jArP88keLw/3C3KciZTof3fGvk5786pJKsABiejF51rPZc1VwN+FjFtXnOqxZdHA/
	 fYzyAe9mgWxdXHjrQdrWoz66UTcZjyMzt5vHFZgrc9q7lgYaZOAmZN11aDP7zISsUR
	 PMck36yrYT/4KSyO11XrvL5rU8NZM+2vAQgR9GQZn3mpLg2Mnk+4ZeGCihxgmMiOXn
	 phpkDHeOpO9nax635m9v0AKUcI5ljkfGVwflxktkDqeSlS1TvarGVaY1eSi+akpI+f
	 +EhIsEgi0OBkrNkA6BmJx8P5ITmjI/bPmfa+cEDlMV4fvr/YuHj6IAzEPw0QKn46cH
	 PlPzJZYWvasKA==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 1/3] filemap: Add a helper for filesystems implementing dropbehind
Date: Wed, 23 Apr 2025 00:25:30 -0400
Message-ID: <5588a06f6d5a2cf6746828e2d36e7ada668b1739.1745381692.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745381692.git.trond.myklebust@hammerspace.com>
References: <cover.1745381692.git.trond.myklebust@hammerspace.com>
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
---
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 26baa78f1ca7..63e2bee9f46b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1225,6 +1225,7 @@ void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
+void folio_end_dropbehind(struct folio *folio);
 void folio_wait_stable(struct folio *folio);
 void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb);
diff --git a/mm/filemap.c b/mm/filemap.c
index b5e784f34d98..12f694880bb8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1589,6 +1589,22 @@ int folio_wait_private_2_killable(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_wait_private_2_killable);
 
+/*
+ * Helper for filesystems that want to implement dropbehind, and that
+ * need to keep the folio around after folio_end_writeback, e.g. due to
+ * the need to first commit NFS stable writes.
+ */
+void folio_end_dropbehind(struct folio *folio)
+{
+	if (folio_trylock(folio)) {
+		if (folio->mapping && !folio_test_dirty(folio) &&
+		    !folio_test_writeback(folio))
+			folio_unmap_invalidate(folio->mapping, folio, 0);
+		folio_unlock(folio);
+	}
+}
+EXPORT_SYMBOL(folio_end_dropbehind);
+
 /*
  * If folio was marked as dropbehind, then pages should be dropped when writeback
  * completes. Do that now. If we fail, it's likely because of a big folio -
-- 
2.49.0


