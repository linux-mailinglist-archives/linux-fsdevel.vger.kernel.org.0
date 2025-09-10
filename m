Return-Path: <linux-fsdevel+bounces-60726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F800B50A8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 03:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F255660B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 01:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47688226D16;
	Wed, 10 Sep 2025 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqyTv0QW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C122264A3
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469227; cv=none; b=ivmohaFNs8IZKP0JlbJ2mRcA5bG5LFZKoQN+JKz+26PrmJz+QOqj7zUZxIOA8JsTUQePsBECvTL+R0LCvr8P5ozbp/+QcoHv9pCUuaHNvphULXepO6o7iLRlZwii+mj+r65N5E2fosq66gc/a184YstMweMDXzDR+d/hygnzirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469227; c=relaxed/simple;
	bh=xUQBKYzzjC0nxS0cqJlNL8bOn1he6gYcCH5JnBuH2oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqoZhteGLDXlq4+yv6NYlCe4zxba3rsUGPD6QNDsCW/dLSiU+gP0+nUFOHAj0wuGTUzPNskZcpNLwausTdWZusWhuruyQ9vlPkk6W1pR4ePZyh/B1B3MrLvBbPWgUd58ZMeqTz9VMhr1syMfdxrJm2Ks/M3hrhfWICY9SpEiT/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqyTv0QW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2836C4CEF4;
	Wed, 10 Sep 2025 01:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757469227;
	bh=xUQBKYzzjC0nxS0cqJlNL8bOn1he6gYcCH5JnBuH2oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqyTv0QWl+9Fe+LdVXpfFmnVn+yxqXrlSDhzZv6d1Qc5MQVrhuMaxlCqqW0af+nMO
	 LeHdbn1yFjESD83z3py2N8Gs4OfgfY03OYEwz6hJQ2x9G2hdxSh5LWXXWW4E48IdmM
	 yGWKZ0zM/H0Eb1VAwG0oQBHWy1VkjiTmG796oLOkZ/XdKrQqkhYG+6xtk+i99lk2zC
	 T/+3aLWvm1w7m+PZXWre7+FtmQY3cy/RRHHLIlC/OzKeO4nyqfOf31yBEmW+SlBU5F
	 0D6+/vfJSarCqbuEOtrsAiPWGpg7UIaIRYD8zliPsJIxHNlZkq+2GcOsDWdi/tVBUg
	 jeOtkTN6az62Q==
From: Trond Myklebust <trondmy@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH v5 2/3] filemap: Add a version of folio_end_writeback that ignores dropbehind
Date: Tue,  9 Sep 2025 21:53:43 -0400
Message-ID: <dd70f28822299dd60cdd9b70e606a144724813d3.1757177140.git.trond.myklebust@hammerspace.com>
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
index 66cec689bec4..d12bbb4c9d8a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1628,14 +1628,15 @@ void folio_end_dropbehind(struct folio *folio)
 EXPORT_SYMBOL_GPL(folio_end_dropbehind);
 
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
+EXPORT_SYMBOL_GPL(folio_end_writeback_no_dropbehind);
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
2.51.0


