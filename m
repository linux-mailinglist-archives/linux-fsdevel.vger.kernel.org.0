Return-Path: <linux-fsdevel+bounces-22204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13965913B0B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 15:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985B0B20E32
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 13:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE84185E45;
	Sun, 23 Jun 2024 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuO2VDL2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D29E18509C;
	Sun, 23 Jun 2024 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150268; cv=none; b=P6z2fiBp0L/GWHqPHSdPzAvPK+ffjdZ0QbbD8XRj8XnT/k4c4/D3IIimGXgtwtjGLd0V0h3ONGFvVD3oBqd4RSSJ+nTYeUwzq9YQcEAZX9E8HYgYiAYmTC+04ab+pie/T+Jx0pHHEyrSHSEySnp3tr3MpirdsRs60D2XNeflIvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150268; c=relaxed/simple;
	bh=IdgYiV42Nt1zZJ2w6LGmyiX8+CN1IJdt0YLmcF1eiuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kvz83k/Qxq6tWKmkAL40ACDMtZRfT63Gpisx3cMJtoCHu7vAV4kMuaU4EDFv6O3bPmDAkpx/47RHSaTyi8IKIJydoUbd+rFat5s96Va5gub5GQyGJglydXjpZBUlDgMeaolt6mMoLnZF2Pj9eNtv3hDBDsORon6ZKNgsqXzx7O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuO2VDL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E48BC2BD10;
	Sun, 23 Jun 2024 13:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150267;
	bh=IdgYiV42Nt1zZJ2w6LGmyiX8+CN1IJdt0YLmcF1eiuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uuO2VDL24AVqpG6F/pYTQU7Qh87fgQgvPVLx9xvghWSdTs8zjSvlKgA3M3j7If8oU
	 XKaqrRyfUWULTQrzkmb/9Hk+DIk+Q1Aq9ueaKtfLS8W4BT0lRlZYo4AxBit//C/dGu
	 PUgsw+l5oeBf00usMjmTMJ2rwp5gx3XVWxv9Tl1QAy3ZClHMyQz+cKVr9Y+Q9Hr2ZW
	 blvV14at/fovbEAPbfU1xof7Eonktib7d6hM41gTKnCDrNSNGeTO0ckgbb9q3VsH94
	 vx/r2LvOx3rhcb64wvVDSH7YPi/AzX7eEO8vc3eRhPVCCIY1TzqNxen2gKvyH1J41k
	 AWiRh/T/kHPrg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 13/21] iomap: Fix iomap_adjust_read_range for plen calculation
Date: Sun, 23 Jun 2024 09:43:46 -0400
Message-ID: <20240623134405.809025-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134405.809025-1-sashal@kernel.org>
References: <20240623134405.809025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.6
Content-Transfer-Encoding: 8bit

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

[ Upstream commit f5ceb1bbc98c69536d4673a97315e8427e67de1b ]

If the extent spans the block that contains i_size, we need to handle
both halves separately so that we properly zero data in the page cache
for blocks that are entirely outside of i_size. But this is needed only
when i_size is within the current folio under processing.
"orig_pos + length > isize" can be true for all folios if the mapped
extent length is greater than the folio size. That is making plen to
break for every folio instead of only the last folio.

So use orig_plen for checking if "orig_pos + orig_plen > isize".

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Link: https://lore.kernel.org/r/a32e5f9a4fcfdb99077300c4020ed7ae61d6e0f9.1715067055.git.ritesh.list@gmail.com
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4ac6c8c403c26..248e615270ff7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -241,6 +241,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	unsigned block_size = (1 << block_bits);
 	size_t poff = offset_in_folio(folio, *pos);
 	size_t plen = min_t(loff_t, folio_size(folio) - poff, length);
+	size_t orig_plen = plen;
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
 
@@ -277,7 +278,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	 * handle both halves separately so that we properly zero data in the
 	 * page cache for blocks that are entirely outside of i_size.
 	 */
-	if (orig_pos <= isize && orig_pos + length > isize) {
+	if (orig_pos <= isize && orig_pos + orig_plen > isize) {
 		unsigned end = offset_in_folio(folio, isize - 1) >> block_bits;
 
 		if (first <= end && last > end)
-- 
2.43.0


