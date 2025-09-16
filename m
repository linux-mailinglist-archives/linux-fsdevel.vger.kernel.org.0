Return-Path: <linux-fsdevel+bounces-61774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8D7B59B77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 17:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B6D461E0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE08E34DCFD;
	Tue, 16 Sep 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYxv0nmp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56573340DBF
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034846; cv=none; b=l3ODxiJxeLKX5+FjnGpaG4PtZAlGz5GKAQ6i8cVXD6ftwb25xssrJuBCrQ8242/NSSw5B2PSb6FuM24osfGSBPvCD3iquM4HyD0v8n4Ji0417MxE4ubwdij0/O4SAqHqRUkAvFiR+fp3C0cLwoGo/N2UlBqUcIh3Ubrw3dkre/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034846; c=relaxed/simple;
	bh=YvvK/lE+Hg1E/Jth9zP2tR/ES3bgGECS8BWMtmMKWio=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LS/8LQSmuSIuHV2Zj52vafUyVAb6O1Z0gchlB6uXb79i7ak9YW8jeY6m8k436cN3glox4z8oyt6IBkqkH5uTRzFDXhjeFLzJZnuw01G7N04ZUizerrzSfzIFj2UddUJAtFvwrSxvgAuENU9j6idevBRx0tBpRtwQ6oNgV81auPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYxv0nmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEE0C4CEEB;
	Tue, 16 Sep 2025 15:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758034845;
	bh=YvvK/lE+Hg1E/Jth9zP2tR/ES3bgGECS8BWMtmMKWio=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FYxv0nmp4pSZVx0fpzmKLSBhqt+NfCrQu/0sZy17nNPM19fjQzh3sfvLRmnnCZALm
	 xMpuvac3Q0E1Fgxi9HIIs63MldPLhL9KRiTtf9+KpF4W9oz7y2vK6xqpGYtZHZoAkc
	 y9UDCMpOukgaFiI8eFgaKDVEvq3GAnuDMYopFah1XUOXj5JsXrdM7uwuFD9xh6mV42
	 kfLJDpH8yhHRfKxMkpM51IUXVQeHw3o3zG5qmbQDAdSL5z+mlR9tUK86l7um577VL5
	 9zJLgBtygL+ZAe3LoLdqUEqpF+U6MyA01+TYBz9w3RS3UXTGFKvzEo6/HZ7RS7Z3LK
	 34vvCHmSgmoOA==
Date: Tue, 16 Sep 2025 08:00:45 -0700
Subject: [PATCH 2/2] iomap: error out on file IO when there is no inline_data
 buffer
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de
Message-ID: <175803480324.966383.7414345025943296442.stgit@frogsfrogsfrogs>
In-Reply-To: <175803480273.966383.16598493355913871794.stgit@frogsfrogsfrogs>
References: <175803480273.966383.16598493355913871794.stgit@frogsfrogsfrogs>
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
index 741f1f6001e1ff..8dd5421cb910b5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -312,6 +312,9 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	size_t size = i_size_read(iter->inode) - iomap->offset;
 	size_t offset = offset_in_folio(folio, iomap->offset);
 
+	if (WARN_ON_ONCE(!iomap->inline_data))
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
 
+	if (WARN_ON_ONCE(!iomap->inline_data))
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
index 6dc4e18f93a40a..efb684bdb2cc10 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -523,6 +523,9 @@ static int iomap_dio_inline_iter(struct iomap_iter *iomi, struct iomap_dio *dio)
 	loff_t pos = iomi->pos;
 	u64 copied;
 
+	if (WARN_ON_ONCE(!inline_data))
+		return -EIO;
+
 	if (WARN_ON_ONCE(!iomap_inline_data_valid(iomap)))
 		return -EIO;
 


