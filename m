Return-Path: <linux-fsdevel+bounces-57586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C365FB23AD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 23:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD577B02C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 21:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A292D73AA;
	Tue, 12 Aug 2025 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KowhFhkm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C27081F;
	Tue, 12 Aug 2025 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034816; cv=none; b=eK6qF6jYYVLz6cUTLOiBUAp0hAbglnuaG9RznzHpSap1eiGe8pY1mxXDx8uf0pK8qwpMlicrFIVirzTHjD7MtIumVfgrJHlJnf1LH7CrC+mtxEMLcCOSZqOHoz4igYfHsoqTekPzlZm2bueWHfz70r63F40WU8UmTk/jgqCoI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034816; c=relaxed/simple;
	bh=MmucjoIAbZijRirg5K/BlEIIXsiI3kg4uYe2mYiuTWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnH+SlhFvWConRIk+haXe3F+DB1nk9ybDT8V8/Yp+ocDqrPSlmxb5CT+RjtqjDuAS4bouNgE0a3df7iTsP2y9tazCaMSbFxgJl9cSxJGIYbmVR2yaTR0DQqe1QXc2J+XdbwKuP3LpplRYNQWzn3enJH58P0jClj9IFB1aaXsQi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KowhFhkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8A5C4CEF7;
	Tue, 12 Aug 2025 21:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755034815;
	bh=MmucjoIAbZijRirg5K/BlEIIXsiI3kg4uYe2mYiuTWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KowhFhkm6Qw5LByEW9wUSh1u25UK4iHrcK2CCO17quFkNjd5gkynrw9QqZbslAdwC
	 wRaEM/kKZW9rdPRScPbDlLWaIevLUNjwDKBXIpKHXMt72XXlLFHePSvq54/j5j1wQ8
	 Ci3dZhgBAonjoRPkdguQmZIdc2teM9BHC9mbMhh7O8gvukhRnwwDnV950IxVRADDLe
	 YFuW4iDEyUmtUJAtKNsAFiMDrpxKZgroZHzisbI9xXgPpQqcDWOZtEugmH0tMlXTvr
	 AVaWy/gfNWum3rErw9qxg1L2I6vjNC74BC8axv78wgxLDH6QGuwwXn9KF8Z6eHMsHK
	 e03Yxdno635yA==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 1/2] filemap: Add a helper for filesystems implementing dropbehind
Date: Tue, 12 Aug 2025 14:40:06 -0700
Message-ID: <0c9d6cdd4dec9cb40ca69f41cb445e57923a6ad5.1755034536.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755034536.git.trond.myklebust@hammerspace.com>
References: <cover.1755034536.git.trond.myklebust@hammerspace.com>
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
 include/linux/pagemap.h |  1 +
 mm/filemap.c            | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

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
index 751838ef05e5..9878ab702e54 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1603,6 +1603,22 @@ static void filemap_end_dropbehind(struct folio *folio)
 		folio_unmap_invalidate(mapping, folio, 0);
 }
 
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
2.50.1


