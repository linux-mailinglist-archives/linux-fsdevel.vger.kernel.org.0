Return-Path: <linux-fsdevel+bounces-58647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE2FB30648
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B99A176D41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1544338B671;
	Thu, 21 Aug 2025 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="HJIyusrn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA5F38B64C
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807633; cv=none; b=DGtD73VIuLKBH3DURtPzrq1AbTxMCO4oO/lxTbcNhGtN/BFeIs2TMr8qRNswYjRn5cUk7KyplVKpuYKZXqt/eZ+frrP5izmbegtrEXC2vGxsYKyk1wGfzQrH17U3dUV1Az1B4bk2ztwhKAOzH7qjIOl/9ACO7lU9BhF401dUBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807633; c=relaxed/simple;
	bh=ai2oUzPAcRJzj4bWGdjdsYHnumyQaMH/ub0qR04Gbgw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3tjFcoSsA07ELrDyxgL+okDjb0LIjwXzt1T3zAoOKWR3ficOQ26oSK5cEGD7osJmohJ+X18UYiLcBrx/2upchpXcjM+3x6KhMxSETJxFEKErRiyvF6fTltkfcIb1S55f0Y9ZJ67HMr/gxJua2PeKCM8AutTiDmbGCaQAg2whko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=HJIyusrn; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e932ded97easo1379573276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807630; x=1756412430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opvoMbW1BQLT38gew8BsXyJcIC3tejqT6ZRE2IoYWVw=;
        b=HJIyusrn5p0YqzySCgPuwSXTOrj7WUWgzNcKljJ2uIU1Qr6qdPlsRaXxP0hgg5d1fY
         2GeN+mvpFQiaS0E6lymLMIlFUTHaB+Mbk7WNMGMCOq5QKW1pxr3F9zb0r77rLPUfw2mh
         ZOZwSh3R6+VhSC1+PxMeHs+KRTjW3F7tJqUH7dZ6ehPRmvjtMej4e8eo3tPV1VjB4Smc
         T+ulJHIQlNFYGdNtM7VW/VM/nMAqJbp1vKYAYBfCRt4IIdlbvCX8aK0TMloY6rRtk0x4
         i/FVeln2imLP8DO36EUzBkLJK9I82l3G0SyhpNc5H15Pf8j3nV/2fEqVSA21ScSdJP5S
         p25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807630; x=1756412430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opvoMbW1BQLT38gew8BsXyJcIC3tejqT6ZRE2IoYWVw=;
        b=hBECUmNsiA8zURbzcu1X8FE1F8QCJOTMebZsRtQzh5y4QZo73sUd/REPp7zI+c2DQf
         ifBjUePYhEkVeUfHghCov5NinmWqaU+Hu7zcMQoq4mbYf7VPsyf2/ql74J42ZFoJij1S
         AVmhr7DxjfYC7lVdGnjSfZzntoQbC+2LvE9vU2zMGbobzj0l8ikgE3KquK/yPGKw5px4
         pHHP4XAOlW0iuRkV4z3ot3e+9pnzW3/088a02AW/431nAm503yvr1BSsUUKoz0k9vK0Q
         vqifq0G8f6vx82ETI/EkQfSYayPMKHwPImTruThjLG4sA9COd/HdszALGDKHY29yoZpe
         qF/g==
X-Gm-Message-State: AOJu0YylT0WOCnbFbszsM+8q9ZhtbGPPl5VEaxPpOnnuBvLP0/blJLWG
	Az0cfcySVERdKn4zLI1eshP5fVCPO0Yerj4Ce1WugHa5qXiazjUAdSIqGM6XrGowTwjs6estFFK
	eAnA+azVScmBD
X-Gm-Gg: ASbGncvq40SdaLL+oma2XieRqK5495YKSXZlusYkd8wOwpQ/a0fdJI9rqgJAje3gqyJ
	VAueCYUBvRRrfMRU/bdWZeJn32dke+ySOfkKuiOpQzb2mLguJy2+UhP+7RRAQKd9Nzs/MzcJaOA
	aS9OLj4gI11M0mhvDYm8j0YoQuGk+IyIhhf9MiEiVjofumZnctltzWLXjjNYS31JB0BBZ5bYdf8
	KnEQ6KAId0aGGvWTqt/23iPQMAGNZGacuGcFeh9voPg+PbsL+8lt16Lnz3bwegfXukuDYmqxNo+
	VQbG5XqPvtNJrwhuHHZEYvmVweWGCgi3WO4DFxeKY/1tlfi8h0+1mrbnZOLjIg3NcI4VGwxQlti
	NXBkeWa7Ixrlh/mCNuJk4/qhNXoiJ64bMZRNpPC/K2XmRMzkTyXGcNeza7cw=
X-Google-Smtp-Source: AGHT+IHyIwzTgpEWg8XzW3K6HAoMrfMJMt75D5zXrJVqgdg8vv7vwKweBunmDYNPDq3GubatUhjj2Q==
X-Received: by 2002:a05:6902:6b07:b0:e93:3e42:63ca with SMTP id 3f1490d57ef6-e951c3c4751mr826219276.30.1755807630352;
        Thu, 21 Aug 2025 13:20:30 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e951c976124sm141967276.34.2025.08.21.13.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:29 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 10/50] fs: stop accessing ->i_count directly in f2fs and gfs2
Date: Thu, 21 Aug 2025 16:18:21 -0400
Message-ID: <b8e6eb8a3e690ce082828d3580415bf70dfa93aa.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of accessing ->i_count directly in these file systems, use the
appropriate __iget and iput helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/f2fs/super.c      | 4 ++--
 fs/gfs2/ops_fstype.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1db024b20e29..2045642cfe3b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1750,7 +1750,7 @@ static int f2fs_drop_inode(struct inode *inode)
 	if ((!inode_unhashed(inode) && inode->i_state & I_SYNC)) {
 		if (!inode->i_nlink && !is_bad_inode(inode)) {
 			/* to avoid evict_inode call simultaneously */
-			atomic_inc(&inode->i_count);
+			__iget(inode);
 			spin_unlock(&inode->i_lock);
 
 			/* should remain fi->extent_tree for writepage */
@@ -1769,7 +1769,7 @@ static int f2fs_drop_inode(struct inode *inode)
 			sb_end_intwrite(inode->i_sb);
 
 			spin_lock(&inode->i_lock);
-			atomic_dec(&inode->i_count);
+			iput(inode);
 		}
 		trace_f2fs_drop_inode(inode, 0);
 		return 0;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index efe99b732551..c770006f8889 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1754,7 +1754,7 @@ static void gfs2_evict_inodes(struct super_block *sb)
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		atomic_inc(&inode->i_count);
+		__iget(inode);
 		spin_unlock(&inode->i_lock);
 		spin_unlock(&sb->s_inode_list_lock);
 
-- 
2.49.0


