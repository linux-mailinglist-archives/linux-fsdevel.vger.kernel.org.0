Return-Path: <linux-fsdevel+bounces-22206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C67C6913B40
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 15:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059861C208F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Jun 2024 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D0479E1;
	Sun, 23 Jun 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRGaXpQn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001719308A;
	Sun, 23 Jun 2024 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150306; cv=none; b=KhFmvaqhrlZ9NGewa3nCocwmDbAY2xrLyUQpzWWAoSTf3rf8XC7wmjvht4kN4klF0PocD1YAsg9qZsPRsD7ZoZiV5NTC81jat39wQOjyVPIUL+FjyJc57N9r27E7anAqD3bMlsF8syMS+6xJCvDx7qGxzqcoTxRg1xjWU7Emy08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150306; c=relaxed/simple;
	bh=Z0o+PpSYbQAdYjRFyAKGeoFs8grNJbIhab7koImLDDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mb7Q/nqe1G9oJ1GaRLUcCtPmuzvi7wanbkP4c8yCU0npcAmAv89Z6Lx3WpxfypqfEaVyALaRbZjnSPNlJrQN+uEOGyFcNkrARQ8rxz1OtymW9rEW8yQ7EzKo6N/T7tGOjf5LsQjVmdPr0g/tjGoGKBdIjQWijT2x/M9VfQRPFF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRGaXpQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB682C4AF09;
	Sun, 23 Jun 2024 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150306;
	bh=Z0o+PpSYbQAdYjRFyAKGeoFs8grNJbIhab7koImLDDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRGaXpQnRv4L/BaaTrO4LXefGOF0BjfTas6r7DOu11nydrTtF/O5VUxLeuf9xne6q
	 vjBR7ryC9bg4AkENdlElg4rDopWPq1B8T/DtxQKO/m9YhWrZjOGwh+VvxfCyKxI0KP
	 tN2jPM0PULhLYB9ZN6FFuAx4X+35FbvPoebtBPe2S/JCWfrLJSEhnlGZ8AH+VslaAC
	 d3MRE3P938K6jbOYMJylilTIcYdUV7VS9v8QVBQnv/HAhFtULGCD88eqIVi2vXVxOF
	 XoNQiwtfkApuZeu9pCQC9HWlH7Be4sUd/dNmPduzwFkuveM997uQhc7Vb2gxi9KRER
	 Z6EwPImT3NL0A==
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
Subject: [PATCH AUTOSEL 6.6 11/16] iomap: Fix iomap_adjust_read_range for plen calculation
Date: Sun, 23 Jun 2024 09:44:40 -0400
Message-ID: <20240623134448.809470-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134448.809470-1-sashal@kernel.org>
References: <20240623134448.809470-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.35
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
index 129a85633797a..975fd88c1f0f4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -201,6 +201,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	unsigned block_size = (1 << block_bits);
 	size_t poff = offset_in_folio(folio, *pos);
 	size_t plen = min_t(loff_t, folio_size(folio) - poff, length);
+	size_t orig_plen = plen;
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
 
@@ -237,7 +238,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	 * handle both halves separately so that we properly zero data in the
 	 * page cache for blocks that are entirely outside of i_size.
 	 */
-	if (orig_pos <= isize && orig_pos + length > isize) {
+	if (orig_pos <= isize && orig_pos + orig_plen > isize) {
 		unsigned end = offset_in_folio(folio, isize - 1) >> block_bits;
 
 		if (first <= end && last > end)
-- 
2.43.0


