Return-Path: <linux-fsdevel+bounces-55320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C823B097E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32876A60E8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC72726CE05;
	Thu, 17 Jul 2025 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQXjuWVX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00326B2B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794890; cv=none; b=K0PdBHwQ6tedmeL26bN06KAmhprW6loA9TarLEV0sueBfZeXnwSIFabZKpvTbV6qxHQlUBv4N6RgtOLqJBCaO3AKJId65JmUlaBi0xi9txTPFISyw32HnroYJOOQRBQvnm0IstScid5nhPl4F3xfOl8sN/RGDRfSc2jZ16LSpdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794890; c=relaxed/simple;
	bh=ZtDpd3mTupaLEDudE0a0huJE+oyGcITOhyWUepJo5m4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSD2hTVDR22tU5H3tIEFlawOth7j5uNNxsEne9QKwMuO4oXU7VkjE8kJpxipXkdFciSTyCvww3Kzey5ejQfc1DKQSYcvXYAc7u5/5aRwKQKMFuD5KIlNpecCcFu/Y60UI6yatdN6fonL8qNcr0NfPnUdzoLYirLfLl/Pxqk5ZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQXjuWVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB990C4CEE3;
	Thu, 17 Jul 2025 23:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794890;
	bh=ZtDpd3mTupaLEDudE0a0huJE+oyGcITOhyWUepJo5m4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YQXjuWVXixf7vjy51DDDqCbwBIOuS2NlJkkoGSVxXgccawrZbM0E1Hn4XYRSnnNDj
	 6yB8piU99uiwJNqsd2pTTKAlIJdHd3LzemZIeLS38ScOUwvy/4+Wv2DxK2/JTofB9o
	 ZLr8UybZe3E8cMZV25B2iPNt1GJ1jxLP8ZShaZMn6X+ZGXCooqy92SY5rTI9ep+qHZ
	 d7rbBMQv+cFDwwxZzLyWrID+UMlvSmW8dOyxHIYHjAWxMqyWx4/PDJSG+RI8yoTNCI
	 XKyFyz+c0H+iIZDbCWtJAqF57Mezedg5nBrIxbFpcmDkDs6kP6wf2TPtrflS+X5/d+
	 NOrpPvvMalo1Q==
Date: Thu, 17 Jul 2025 16:28:09 -0700
Subject: [PATCH 7/7] iomap: error out on file IO when there is no inline_data
 buffer
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279449604.710975.8347313559801400701.stgit@frogsfrogsfrogs>
In-Reply-To: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
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
index 53324b0222de6b..2e5ed4d8fa6a81 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -351,6 +351,9 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	size_t size = i_size_read(iter->inode) - iomap->offset;
 	size_t offset = offset_in_folio(folio, iomap->offset);
 
+	if (WARN_ON_ONCE(iomap->inline_data == NULL))
+		return -EIO;
+
 	if (folio_test_uptodate(folio))
 		return 0;
 
@@ -905,7 +908,7 @@ static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	return true;
 }
 
-static void iomap_write_end_inline(const struct iomap_iter *iter,
+static bool iomap_write_end_inline(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t copied)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -914,12 +917,16 @@ static void iomap_write_end_inline(const struct iomap_iter *iter,
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
@@ -932,10 +939,8 @@ static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
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
index 1bf450f00f01c3..03fc68eaa16c6c 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -528,6 +528,9 @@ static int iomap_dio_inline_iter(struct iomap_iter *iomi, struct iomap_dio *dio)
 	loff_t pos = iomi->pos;
 	u64 copied;
 
+	if (WARN_ON_ONCE(inline_data == NULL))
+		return -EIO;
+
 	if (WARN_ON_ONCE(!iomap_inline_data_valid(iomap)))
 		return -EIO;
 


