Return-Path: <linux-fsdevel+bounces-30897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFBD98F22D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 17:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCEC1C20CA3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8333A1A071E;
	Thu,  3 Oct 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3UYHQDc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AD9823C3;
	Thu,  3 Oct 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968158; cv=none; b=SoLHFi+2zRfDRDRHygQVJvgcfQWpW1yGbxQ5dtwFIExwJqCtTUwSSgcG/7RWSISYRhI/c3D7zZ++c+21HqF9w1WrbYFxvuVBZCMX6g53CzKb9ARxLCyJVw0/GX4tLcguD+LA4uq2UOgJVURiwXQX1wpPAs77bxe/GNA9mLraZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968158; c=relaxed/simple;
	bh=ajmpiaefvtvuMEdWdelFDJpcrfXyWlkxsRWBtS4oBNU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YeiKCG5EYSkDkpQyqPwaPa/450TxKok7ZqOSEf1VzBNt28IjmWYco427ReAdjIiAw3tOIRffVb4UUegWzLgzW7QDgNUDLDFEetsC6kmcBNK0ssBXWO+4ajUo4QL5rKvIVIETtxRCAHKkdg2Z5jL7SU6urUS/VwUUa9Ug7fvgerk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3UYHQDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48583C4CEC5;
	Thu,  3 Oct 2024 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727968157;
	bh=ajmpiaefvtvuMEdWdelFDJpcrfXyWlkxsRWBtS4oBNU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=W3UYHQDcP9nlpZiLbuWbmGakoiEWTGrr1Ofn1hueY43/sC36QO85ZRMZt1eUEb8CK
	 gWJVeNqvyIDP3dNMs2LzJLpni7nSH2dgjSWEGniYOdJLTxRvALBHsczAkl4UY9yzjt
	 9ai2f49KBG67qbRXGOO3hEOoewUktoexsm12j8Q28zYOlb5p1/Ct/08f7GkVgozKFL
	 O4NAlvGcC102Wp3ZvPCQwQJmn6p9ZDkzhKooHHyph8hfciKNUvIG0sHQ31UxoMxPhO
	 Od4ZQbEpCvaSbM8vLSDgZAzFslnfg7keYQl5oueBlE9214UMSnfwFR8Nx5jj/Olc4O
	 QGGQqKwucggTA==
Date: Thu, 03 Oct 2024 08:09:16 -0700
Subject: [PATCH 2/4] iomap: share iomap_unshare_iter predicate code with fsdax
From: "Darrick J. Wong" <djwong@kernel.org>
To: willy@infradead.org, brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: ruansy.fnst@fujitsu.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
 linux-xfs@vger.kernel.org
Message-ID: <172796813294.1131942.15762084021076932620.stgit@frogsfrogsfrogs>
In-Reply-To: <172796813251.1131942.12184885574609980777.stgit@frogsfrogsfrogs>
References: <172796813251.1131942.12184885574609980777.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The predicate code that iomap_unshare_iter uses to decide if it's really
needs to unshare a file range mapping should be shared with the fsdax
version, because right now they're opencoded and inconsistent.

Note that we simplify the predicate logic a bit -- we no longer allow
unsharing of inline data mappings, but there aren't any filesystems that
allow shared inline data currently.

This is a fix in the sense that it should have been ported to fsdax.

Fixes: b53fdb215d13 ("iomap: improve shared block detection in iomap_unshare_iter")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c               |    3 +--
 fs/iomap/buffered-io.c |   30 ++++++++++++++++--------------
 include/linux/iomap.h  |    1 +
 3 files changed, 18 insertions(+), 16 deletions(-)


diff --git a/fs/dax.c b/fs/dax.c
index c62acd2812f8..5064eefb1c1e 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1268,8 +1268,7 @@ static s64 dax_unshare_iter(struct iomap_iter *iter)
 	s64 ret = 0;
 	void *daddr = NULL, *saddr = NULL;
 
-	/* don't bother with blocks that are not shared to start with */
-	if (!(iomap->flags & IOMAP_F_SHARED))
+	if (!iomap_want_unshare_iter(iter))
 		return length;
 
 	id = dax_read_lock();
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 78ebd265f425..3899169b2cf7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1309,19 +1309,12 @@ void iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
 
-static loff_t iomap_unshare_iter(struct iomap_iter *iter)
+bool iomap_want_unshare_iter(const struct iomap_iter *iter)
 {
-	struct iomap *iomap = &iter->iomap;
-	loff_t pos = iter->pos;
-	loff_t length = iomap_length(iter);
-	loff_t written = 0;
-
-	/* Don't bother with blocks that are not shared to start with. */
-	if (!(iomap->flags & IOMAP_F_SHARED))
-		return length;
-
 	/*
-	 * Don't bother with delalloc reservations, holes or unwritten extents.
+	 * Don't bother with blocks that are not shared to start with; or
+	 * mappings that cannot be shared, such as inline data, delalloc
+	 * reservations, holes or unwritten extents.
 	 *
 	 * Note that we use srcmap directly instead of iomap_iter_srcmap as
 	 * unsharing requires providing a separate source map, and the presence
@@ -1329,9 +1322,18 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 	 * IOMAP_F_SHARED which can be set for any data that goes into the COW
 	 * fork for XFS.
 	 */
-	if (iter->srcmap.type == IOMAP_HOLE ||
-	    iter->srcmap.type == IOMAP_DELALLOC ||
-	    iter->srcmap.type == IOMAP_UNWRITTEN)
+	return (iter->iomap.flags & IOMAP_F_SHARED) &&
+		iter->srcmap.type == IOMAP_MAPPED;
+}
+
+static loff_t iomap_unshare_iter(struct iomap_iter *iter)
+{
+	struct iomap *iomap = &iter->iomap;
+	loff_t pos = iter->pos;
+	loff_t length = iomap_length(iter);
+	loff_t written = 0;
+
+	if (!iomap_want_unshare_iter(iter))
 		return length;
 
 	do {
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4ad12a3c8bae..d8a7fc84348c 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -267,6 +267,7 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
 bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio);
 int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops);
+bool iomap_want_unshare_iter(const struct iomap_iter *iter);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
 		bool *did_zero, const struct iomap_ops *ops);
 int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,


