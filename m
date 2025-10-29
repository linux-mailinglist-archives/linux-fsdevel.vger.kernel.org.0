Return-Path: <linux-fsdevel+bounces-66122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EECC17D38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE5E3AE9EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0182C029A;
	Wed, 29 Oct 2025 01:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drPUjfSa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF718FDDB;
	Wed, 29 Oct 2025 01:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700576; cv=none; b=j/CX/zw85wuIfD0sy5CjVmaf7N95KD6uEeAfb4riha3cQ7lwJo04ta1LXY17BBl7M2yud8ye8jHSJYOzfZu8I56vOauGsSIMgi/S1v2BulsdwEcQQxApsVVdCaweqpzHpDkw77mBJ1MF1oE3GNekWAVakp5pAsaiygyOCSvGkkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700576; c=relaxed/simple;
	bh=EOPIf3n3A8kQi0/wGlOe/Rjo7QZqCgTDhSv/3vAE7Gg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRt/7j7DjAcaFOA7drGMrh8xZFWQSvjshK858ct1UjmDUOlkzFrxVeHppDMolpaD9hZ4olXkTAKYyLeTClQtfeBHIisu1Sn1Wth0QFDWclYyHEX5+hKzkdE5dfG64dykeytxZWa/eLQc0mKtgopcRMI0rxOExoNqkMoWtxAEg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drPUjfSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCE2C4CEE7;
	Wed, 29 Oct 2025 01:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700576;
	bh=EOPIf3n3A8kQi0/wGlOe/Rjo7QZqCgTDhSv/3vAE7Gg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=drPUjfSa3OA3CGxQkq9pYTkTukHNzY8AApBZydfO36ggjLi469gmBy/r2+WEllOYs
	 ahtSPU5g0FxX3mvUf2Y1JCJniTlqxvGtrWZ/ZNo0Pj/XTCLBjVuIS2BUJq4nBxOk7c
	 liOpUsloLJsHtnNGmooc+eCd0of3UN2ie0aXcbsXz9FOkn8/Wkc2ybfhG7b0hx+czz
	 c/ZoshpEzkTjWYvoslgY/nGdqjqtz3oT4FkTui1K3SMbVhwHODPX6bFB/wFJIXkgTr
	 usUjpIlpu692qrSJWzfqhHVkGVt2Cnz9PaENK2qefCs83PzdaSymIDid4zQMUpvH8G
	 LkqqI9pPtF5YA==
Date: Tue, 28 Oct 2025 18:16:15 -0700
Subject: [PATCH 11/11] fuse4fs: increase attribute timeout in iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818424.1430380.12074181505332544391.stgit@frogsfrogsfrogs>
In-Reply-To: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
References: <176169818170.1430380.13590456647130347042.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In iomap mode, we trust the kernel to cache file attributes, because it
is critical to keep all of the file IO permissions checking in the
kernel as part of keeping all the file IO paths in the kernel.
Therefore, increase the attribute timeout to 30 seconds to reduce the
number of upcalls even further.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index e08e127eb03563..958b3cab83a68d 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -123,7 +123,8 @@
 #endif
 #endif /* !defined(ENODATA) */
 
-#define FUSE4FS_ATTR_TIMEOUT	(0.0)
+#define FUSE4FS_IOMAP_ATTR_TIMEOUT	(0.0)
+#define FUSE4FS_ATTR_TIMEOUT		(30.0)
 
 static inline uint64_t round_up(uint64_t b, unsigned int align)
 {
@@ -2155,8 +2156,14 @@ static int fuse4fs_stat_inode(struct fuse4fs *ff, ext2_ino_t ino,
 
 	fuse4fs_ino_to_fuse(ff, &entry->ino, ino);
 	entry->generation = inodep->i_generation;
-	entry->attr_timeout = FUSE4FS_ATTR_TIMEOUT;
-	entry->entry_timeout = FUSE4FS_ATTR_TIMEOUT;
+
+	if (fuse4fs_iomap_enabled(ff)) {
+		entry->attr_timeout = FUSE4FS_IOMAP_ATTR_TIMEOUT;
+		entry->entry_timeout = FUSE4FS_IOMAP_ATTR_TIMEOUT;
+	} else {
+		entry->attr_timeout = FUSE4FS_ATTR_TIMEOUT;
+		entry->entry_timeout = FUSE4FS_ATTR_TIMEOUT;
+	}
 
 	fstat->iflags = 0;
 
@@ -2389,6 +2396,8 @@ static void op_statx(fuse_req_t req, fuse_ino_t fino, int flags, int mask,
 	fuse4fs_finish(ff, ret);
 	if (ret)
 		fuse_reply_err(req, -ret);
+	else if (fuse4fs_iomap_enabled(ff))
+		fuse_reply_statx(req, 0, &stx, FUSE4FS_IOMAP_ATTR_TIMEOUT);
 	else
 		fuse_reply_statx(req, 0, &stx, FUSE4FS_ATTR_TIMEOUT);
 }


