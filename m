Return-Path: <linux-fsdevel+bounces-39072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B34A0C01A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C973A69D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8A51FA169;
	Mon, 13 Jan 2025 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb8w4+YE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C151FA14B;
	Mon, 13 Jan 2025 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793307; cv=none; b=HEkLbnxNUejkmntW9VBjILgRIxWRabCya0Ay/nuK1e2pT9xrmBFzJdD4IX0trSIX8IFANS8uxYvanYWjDEfsPpXm8iY6K0UjoUvsy1FCVptqBst8gDswJV+LozpZGe0nvMHUX1qPe9AQtVdBcT2HNX4bfFgngIV+6MRUCooDoik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793307; c=relaxed/simple;
	bh=Ysprb739drFzTtogLb4Hu958yP+s7LORgliv06VIJlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C4S2HthaTaONW4eQGf798RmeQ/f9yzxlUDiZn/zrO731O108pM4llznF1a5XQoQcDLzzewuIx64KdbCFSe8SFN08CA5eey8M/3gQVxaxMFCA09ELQfzGCQBTDOLBaCNxJCvcShzg82bBXEmA7pssHE5zra4fKwLSyMd0ab2mWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nb8w4+YE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38317C4CEE2;
	Mon, 13 Jan 2025 18:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793307;
	bh=Ysprb739drFzTtogLb4Hu958yP+s7LORgliv06VIJlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nb8w4+YEUJ2zLJvGt8s63F7wdhafrfaNwbOZOcBcKDnlyELsmJuuG/d55VRSiBhbO
	 1Tjg+qCj325X22pqTEECJUWQ+MYJEVAAeSiQFri1aLUoMMhM6wf4zTQl82AlF/hbk/
	 WkBRsL340D7auTXKWR0y/rF44/S3erZOx+JC7FT1PBxP3yBoDyw+WixlnadxBEn+20
	 X7JQRLu0SBxhb8BsshDwulBGsQOee7XjmwPs9Hduk76tDznA4XoCGSpaX+mZfjCN8p
	 bpLX5Be6RWJ2W/hITwfdyH1RMaI2cdrqCQOu53f3TfrU4s1OrqRGBicB7lW0IXSoMh
	 fwysefMvCqPhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marco Nelissen <marco.nelissen@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 18/20] iomap: avoid avoid truncating 64-bit offset to 32 bits
Date: Mon, 13 Jan 2025 13:34:23 -0500
Message-Id: <20250113183425.1783715-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183425.1783715-1-sashal@kernel.org>
References: <20250113183425.1783715-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.9
Content-Transfer-Encoding: 8bit

From: Marco Nelissen <marco.nelissen@gmail.com>

[ Upstream commit c13094b894de289514d84b8db56d1f2931a0bade ]

on 32-bit kernels, iomap_write_delalloc_scan() was inadvertently using a
32-bit position due to folio_next_index() returning an unsigned long.
This could lead to an infinite loop when writing to an xfs filesystem.

Signed-off-by: Marco Nelissen <marco.nelissen@gmail.com>
Link: https://lore.kernel.org/r/20250109041253.2494374-1-marco.nelissen@gmail.com
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3ffd9937dd51..49da74539fb3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1138,7 +1138,7 @@ static void iomap_write_delalloc_scan(struct inode *inode,
 				start_byte, end_byte, iomap, punch);
 
 		/* move offset to start of next folio in range */
-		start_byte = folio_next_index(folio) << PAGE_SHIFT;
+		start_byte = folio_pos(folio) + folio_size(folio);
 		folio_unlock(folio);
 		folio_put(folio);
 	}
-- 
2.39.5


