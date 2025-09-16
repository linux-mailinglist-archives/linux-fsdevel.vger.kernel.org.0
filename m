Return-Path: <linux-fsdevel+bounces-61502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ED4B58941
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEF4A189DBE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FE81A2545;
	Tue, 16 Sep 2025 00:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ka3X8xdo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F441A3172;
	Tue, 16 Sep 2025 00:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982401; cv=none; b=Bxv5PLAEGvn5EPscFwP37gz0cDZ42QM/VpBEEzSOhTdGQ4bTI+VuECHNIXvQucamFWq0Jic7E+1p8+luoPBLm5CJk8n32q04TyGlZ/cj8xf5kWmUW50D+3tzxYzU5lA9rqXysdrdb41XQrEP3v1vwoqkq1PF/fXSF2z8E47GwkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982401; c=relaxed/simple;
	bh=Y8fhQtPSHD6eLfhNHO10Ngyi9+k9dHUH0jLtn63n5NQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erOgQg+Y8MxFJDxlqviqIWP5nJn9tXX7W6iEp0HbZetHyeDmM3kxMK0LEKVZsPkxSTQVsNnivMmMcBPP6+QAm7apOXjsUI7lMZJxY2qQyUf3BCJCLzDZbl9upH3Wj5MVazIe/mxt+DHpZpQ6JPPLXj/5NobMrJ3jD1LoXPRgYv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ka3X8xdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF414C4CEF1;
	Tue, 16 Sep 2025 00:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982400;
	bh=Y8fhQtPSHD6eLfhNHO10Ngyi9+k9dHUH0jLtn63n5NQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Ka3X8xdoQhzzr0fRNUY6RyAlguVpeElHbAsRXmK23pSHo+Gy1S6O0otvvisoDow9p
	 1R6zMasJy6Vq4jqC/UTZ+wiSA55pOsggUbdhq8094SknqO20VrEHIRylEu5u+nV3JC
	 DlRx2zLesEGw9GGXrdkBPmqbOGmb0bY9FwQillPd9rwMngXi9iG5CuZeRe3ZIdiqT+
	 VtNwd4h0aGeP+o35IYITTzzdAX0HIBJNAgDQA5SWInBudOyQ//iE5eyyMy1yJwZ0/4
	 02arYjJQg0fByva+RF7WsVOeQx9dHaEqq/bVsUDmi+VrMUEjGUMX1DYprGhlLWtgal
	 +LZO11fl5BbOQ==
Date: Mon, 15 Sep 2025 17:26:40 -0700
Subject: [PATCH 2/2] iomap: error out on file IO when there is no inline_data
 buffer
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798150460.382342.6574514049895510791.stgit@frogsfrogsfrogs>
In-Reply-To: <175798150409.382342.12419127054800541532.stgit@frogsfrogsfrogs>
References: <175798150409.382342.12419127054800541532.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Return IO errors if an ->iomap_begin implementation returns an
IOMAP_INLINE buffer but forgets to set the inline_data pointer.
Filesystems should never do this, but we could help fs developers (me)
fix their bugs by handling this more gracefully than crashing the
kernel.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c |   15 ++++++++++-----
 fs/iomap/direct-io.c   |    3 +++
 2 files changed, 13 insertions(+), 5 deletions(-)


diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 741f1f6001e1ff..869f178aea28d3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -312,6 +312,9 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	size_t size = i_size_read(iter->inode) - iomap->offset;
 	size_t offset = offset_in_folio(folio, iomap->offset);
 
+	if (WARN_ON_ONCE(iomap->inline_data == NULL))
+		return -EIO;
+
 	if (folio_test_uptodate(folio))
 		return 0;
 
@@ -913,7 +916,7 @@ static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	return true;
 }
 
-static void iomap_write_end_inline(const struct iomap_iter *iter,
+static bool iomap_write_end_inline(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t copied)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -922,12 +925,16 @@ static void iomap_write_end_inline(const struct iomap_iter *iter,
 	WARN_ON_ONCE(!folio_test_uptodate(folio));
 	BUG_ON(!iomap_inline_data_valid(iomap));
 
+	if (WARN_ON_ONCE(iomap->inline_data == NULL))
+		return false;
+
 	flush_dcache_folio(folio);
 	addr = kmap_local_folio(folio, pos);
 	memcpy(iomap_inline_data(iomap, pos), addr, copied);
 	kunmap_local(addr);
 
 	mark_inode_dirty(iter->inode);
+	return true;
 }
 
 /*
@@ -940,10 +947,8 @@ static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 
-	if (srcmap->type == IOMAP_INLINE) {
-		iomap_write_end_inline(iter, folio, pos, copied);
-		return true;
-	}
+	if (srcmap->type == IOMAP_INLINE)
+		return iomap_write_end_inline(iter, folio, pos, copied);
 
 	if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
 		size_t bh_written;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 6dc4e18f93a40a..a992130a1cb6dd 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -523,6 +523,9 @@ static int iomap_dio_inline_iter(struct iomap_iter *iomi, struct iomap_dio *dio)
 	loff_t pos = iomi->pos;
 	u64 copied;
 
+	if (WARN_ON_ONCE(inline_data == NULL))
+		return -EIO;
+
 	if (WARN_ON_ONCE(!iomap_inline_data_valid(iomap)))
 		return -EIO;
 


