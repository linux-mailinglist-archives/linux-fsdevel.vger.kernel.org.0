Return-Path: <linux-fsdevel+bounces-15988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257D2896697
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 09:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02D91F26D1C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 07:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195DE823DF;
	Wed,  3 Apr 2024 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="hcaS2gkR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369B680C1C;
	Wed,  3 Apr 2024 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129609; cv=none; b=N0go0bLR5uEGvcwSdob1+jDMHOwXTdqRBMVxWwF9cho8irsiobN+OhBg3Tq2yRMp1fEphvc1q5CIAuiel1WV+dfyhX0f3ymTYld7N5i2N2vqQWkG3ca9tRfSKu7fDYeaJrmxvggXscNCTxR7+XdeqCNneO/K8tAStaF6CCf3LNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129609; c=relaxed/simple;
	bh=F4ceUdWui/mdlAkWe1dY+ZhhuS2I1dZLc64k4/7Uo2Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtVzZC3iW2pTHVanA0bYOZMWy08C+Oz7qfp7H1Cb8cvERk4oBywWrAtkkM1+2uWnYFI9IEtP0ie0a097/JIVisinAx62mAk0LIS5TS7moDZVOJAPKWFb7g1amA3iswPWetfSA064hSnsDREODoV/g52PuPYS4o1E/GzZ2SgvZpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=hcaS2gkR; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 2C7F680892;
	Wed,  3 Apr 2024 03:33:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712129607; bh=F4ceUdWui/mdlAkWe1dY+ZhhuS2I1dZLc64k4/7Uo2Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hcaS2gkRusKnpHkC/vbijCe7K6kF9RnpgEZv+Yk/8S8mIdGMFNwTXjeMXk6Lzd5UC
	 Hi6eke4x6kTY5FTxTcqF9nhsH8Hr3kFTQUa72oYAdA2naZe/2JZk8LMUs8EZmhcKSY
	 k/lGHBMstPOaB75DA6K8YXP0rh0o1c3RFZhWnNym3ibZiv3ynGaWsJBeOu7qdzY3TA
	 kYfAZI95Huok41dLHVC+Ns1ZqhWUMwMY3vTUK+9A3S3+JnYeD8Y4AY5Ve0v1vt+t1v
	 /GbaAWudyNoOzpYQuXbt5o9acwJnV+NKZdaow2b6f9Pu+wdl7RXj4U/v8OpFOXiJXJ
	 MGXyDIMLsHiBQ==
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To: Jonathan Corbet <corbet@lwn.net>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 10/13] ocfs2: fiemap: return correct extent physical length
Date: Wed,  3 Apr 2024 03:22:51 -0400
Message-ID: <0b492e10a9034c8fb08ca654c06471575e8bb96d.1712126039.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1712126039.git.sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/ocfs2/extent_map.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index eabdf97cd685..229ea45df37b 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -705,7 +705,9 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
 	unsigned int id_count;
 	struct ocfs2_dinode *di;
 	u64 phys;
-	u32 flags = FIEMAP_EXTENT_DATA_INLINE|FIEMAP_EXTENT_LAST;
+	u32 flags = (FIEMAP_EXTENT_DATA_INLINE|
+		     FIEMAP_EXTENT_HAS_PHYS_LEN|
+		     FIEMAP_EXTENT_LAST);
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 
 	di = (struct ocfs2_dinode *)di_bh->b_data;
@@ -782,7 +784,7 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			continue;
 		}
 
-		fe_flags = 0;
+		fe_flags = FIEMAP_EXTENT_HAS_PHYS_LEN;
 		if (rec.e_flags & OCFS2_EXT_UNWRITTEN)
 			fe_flags |= FIEMAP_EXTENT_UNWRITTEN;
 		if (rec.e_flags & OCFS2_EXT_REFCOUNTED)
-- 
2.43.0


