Return-Path: <linux-fsdevel+bounces-30078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A74985E45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 15:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D811C253E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 13:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DE620EDE1;
	Wed, 25 Sep 2024 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGaB6LLH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454EF20EDC8;
	Wed, 25 Sep 2024 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266154; cv=none; b=cmtSgyKNi8xm3D8gtZFyWYIk+AUzasKhrqo1iXZefDj54eKXj/vda2btm8c4jKZr3PS7/gZaKBO0/h38umjUh9oZBNE45pR0chgkAVCFUVhaXN6zMDgaUBgYqB9yjqBlySXexXr1+hxkZ4qISrPWrRuJWWQ2C54FuR4C0jXCtGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266154; c=relaxed/simple;
	bh=DLRwwhJALq3terZc9vA18D/Jwar7g4IeRYQBGkk+6nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0S6cUifDyAp9Xh4FDyT7NXMSUTg7wOYeVyhdLjOvNTQftZl0T4DlNQd0YLgNwjao79y9Ml2AtvmuALpBX7Jvl0y9fneemyv9HWsmNynqOrVTZ3KejIe6O3X73VNTwlpgiVHgSyntvyHReEUP98gVnjAOL7VvzGGLISSpNXQoKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGaB6LLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194C3C4CEC3;
	Wed, 25 Sep 2024 12:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266154;
	bh=DLRwwhJALq3terZc9vA18D/Jwar7g4IeRYQBGkk+6nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SGaB6LLH34joF/KfpkTUQxJVGDVtb3mmAb0szlobqPH/kFL9gARHK1haG0JBYawtM
	 Bu6f6nWDx3ine/2L4dMbR44iHCyAdngGL88XMv6jmt9w3NC4f69GgGwHqsB5qdVoEG
	 kqfQyN3X1H4z10MIyml1qVIaLX8MNO+mISkw9pp3q0glnD/5tMYCWsZV3ogIJM6spk
	 57NqP2YEY3z5+r09ezVw+HBN+7AgseBByNxVWImQbiSyw5gTNUQs6qNSqlKT173qhU
	 RZobSuRJiUAW8XrAMYcbaIoteEBUJBeYL4702vjEQMouELiToP+GZ6jrzvEQL4hzFq
	 CmUAWCn1Gb+dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 195/197] iomap: handle a post-direct I/O invalidate race in iomap_write_delalloc_release
Date: Wed, 25 Sep 2024 07:53:34 -0400
Message-ID: <20240925115823.1303019-195-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 7a9d43eace888a0ee6095035997bb138425844d3 ]

When direct I/O completions invalidates the page cache it holds neither the
i_rwsem nor the invalidate_lock so it can be racing with
iomap_write_delalloc_release.  If the search for the end of the region that
contains data returns the start offset we hit such a race and just need to
look for the end of the newly created hole instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20240910043949.3481298-2-hch@lst.de
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/iomap/buffered-io.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d505636035af3..74ee76f772d86 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1226,7 +1226,15 @@ static int iomap_write_delalloc_release(struct inode *inode,
 			error = data_end;
 			goto out_unlock;
 		}
-		WARN_ON_ONCE(data_end <= start_byte);
+
+		/*
+		 * If we race with post-direct I/O invalidation of the page cache,
+		 * there might be no data left at start_byte.
+		 */
+		if (data_end == start_byte)
+			continue;
+
+		WARN_ON_ONCE(data_end < start_byte);
 		WARN_ON_ONCE(data_end > scan_end_byte);
 
 		error = iomap_write_delalloc_scan(inode, &punch_start_byte,
-- 
2.43.0


