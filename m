Return-Path: <linux-fsdevel+bounces-30899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB6A98F231
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 17:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD77A1C21572
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 15:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C7C1A0719;
	Thu,  3 Oct 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5hrQQIc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AE51B969;
	Thu,  3 Oct 2024 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968189; cv=none; b=OrunVc/l2vbMZc0Pjt4of2f9RuXVYSgmsFdHJ9lKaah/U9u4erELf1MrreiovtM0eMnKGQ+9U72Q1/Tqkpqle9MvfmqrKtCfiGcrCq7NxsDwbWTcyfwxGOuPn+rvLdniw47nw1ZaJ/6ah9+TKqBdpqHmBBIpdcBmfCt63MxVAqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968189; c=relaxed/simple;
	bh=t1erP4051fKxjeO5bhlf4vXNm9QCAZdEkniTTG/tkWU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvkXmRsqPu68mzhO1cF2xANpK4xwS76BMTfkAqRnU+CJThBuWVtvmfOVL3JzKRnQcoSvbbALt5i6z2LCqsZtjqnElqmO/fcXAbbfixM6KSELy4m3q/BJ7p8Z4kucDzdx5Q8mFbhxJN0IDiYe9YREyQ0HNBqVLRAPHL3o7PTn4s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5hrQQIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C88C4CEC7;
	Thu,  3 Oct 2024 15:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727968188;
	bh=t1erP4051fKxjeO5bhlf4vXNm9QCAZdEkniTTG/tkWU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=b5hrQQIc8tWiAxg1Dl9aDiFL6H9CqgDR/NzOUCbzp8PhFSRxed4dL4kotgU0kUvs3
	 KzvijsmaSQ/y1xmRxX8AxU5R39B+rDrZQYw0Ps/yYWlM+u+nAydKFxUVYW9r+o1ZVz
	 MBlRIC0ZFppfw2K88UbOqY/bwg8fmpFRHPX4T86Bo5AKfZ2Ydjkb/UIC2c1EQ7IfBG
	 9I19KQpcm4/RGxErLe3uQrlPBksjCWZejM2746ByhpdyROZqPfaf62WNT8eqDmISQV
	 Kd2tM8G21oRzwzWLi8gAZgNFGjaZtw/RpDDDYOIspFr2lTK8Pjp5kvVEJaZ9XHfSMR
	 2lsMz57LzArZQ==
Date: Thu, 03 Oct 2024 08:09:48 -0700
Subject: [PATCH 4/4] fsdax: dax_unshare_iter needs to copy entire blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: willy@infradead.org, brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: ruansy.fnst@fujitsu.com, ruansy.fnst@fujitsu.com,
 linux-fsdevel@vger.kernel.org, hch@lst.de, linux-xfs@vger.kernel.org
Message-ID: <172796813328.1131942.16777025316348797355.stgit@frogsfrogsfrogs>
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

The code that copies data from srcmap to iomap in dax_unshare_iter is
very very broken, which bfoster's recent fsx changes have exposed.

If the pos and len passed to dax_file_unshare are not aligned to an
fsblock boundary, the iter pos and length in the _iter function will
reflect this unalignment.

dax_iomap_direct_access always returns a pointer to the start of the
kmapped fsdax page, even if its pos argument is in the middle of that
page.  This is catastrophic for data integrity when iter->pos is not
aligned to a page, because daddr/saddr do not point to the same byte in
the file as iter->pos.  Hence we corrupt user data by copying it to the
wrong place.

If iter->pos + iomap_length() in the _iter function not aligned to a
page, then we fail to copy a full block, and only partially populate the
destination block.  This is catastrophic for data confidentiality
because we expose stale pmem contents.

Fix both of these issues by aligning copy_pos/copy_len to a page
boundary (remember, this is fsdax so 1 fsblock == 1 base page) so that
we always copy full blocks.

We're not done yet -- there's no call to invalidate_inode_pages2_range,
so programs that have the file range mmap'd will continue accessing the
old memory mapping after the file metadata updates have completed.

Be careful with the return value -- if the unshare succeeds, we still
need to return the number of bytes that the iomap iter thinks we're
operating on.

Cc: ruansy.fnst@fujitsu.com
Fixes: d984648e428b ("fsdax,xfs: port unshare to fsdax")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c |   34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)


diff --git a/fs/dax.c b/fs/dax.c
index 9fbbdaa784b4..21b47402b3dc 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1262,26 +1262,46 @@ static s64 dax_unshare_iter(struct iomap_iter *iter)
 {
 	struct iomap *iomap = &iter->iomap;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	loff_t pos = iter->pos;
-	loff_t length = iomap_length(iter);
+	loff_t copy_pos = iter->pos;
+	u64 copy_len = iomap_length(iter);
+	u32 mod;
 	int id = 0;
 	s64 ret = 0;
 	void *daddr = NULL, *saddr = NULL;
 
 	if (!iomap_want_unshare_iter(iter))
-		return length;
+		return iomap_length(iter);
+
+	/*
+	 * Extend the file range to be aligned to fsblock/pagesize, because
+	 * we need to copy entire blocks, not just the byte range specified.
+	 * Invalidate the mapping because we're about to CoW.
+	 */
+	mod = offset_in_page(copy_pos);
+	if (mod) {
+		copy_len += mod;
+		copy_pos -= mod;
+	}
+
+	mod = offset_in_page(copy_pos + copy_len);
+	if (mod)
+		copy_len += PAGE_SIZE - mod;
+
+	invalidate_inode_pages2_range(iter->inode->i_mapping,
+				      copy_pos >> PAGE_SHIFT,
+				      (copy_pos + copy_len - 1) >> PAGE_SHIFT);
 
 	id = dax_read_lock();
-	ret = dax_iomap_direct_access(iomap, pos, length, &daddr, NULL);
+	ret = dax_iomap_direct_access(iomap, copy_pos, copy_len, &daddr, NULL);
 	if (ret < 0)
 		goto out_unlock;
 
-	ret = dax_iomap_direct_access(srcmap, pos, length, &saddr, NULL);
+	ret = dax_iomap_direct_access(srcmap, copy_pos, copy_len, &saddr, NULL);
 	if (ret < 0)
 		goto out_unlock;
 
-	if (copy_mc_to_kernel(daddr, saddr, length) == 0)
-		ret = length;
+	if (copy_mc_to_kernel(daddr, saddr, copy_len) == 0)
+		ret = iomap_length(iter);
 	else
 		ret = -EIO;
 


