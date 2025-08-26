Return-Path: <linux-fsdevel+bounces-59278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A362B36EC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F8B983455
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A4B350D43;
	Tue, 26 Aug 2025 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xN5y2SSr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A543705B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222916; cv=none; b=brtmOTgx3dQTla5shsKEud6hEAHtAJNqpPJx5itTSXKAy2Kt3jqrXiJLGy8wr3PO8waNuQ10NpNLp2RITtTnx5IBNNvP8GCtwLOGq69HBHJn1OKgO50nPjAOvuQ5aJFsP2H3tH2iV20QlvJ9r5gWuJPk5530sKoNnXjWTs1uKqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222916; c=relaxed/simple;
	bh=15ZHaqifmUtXWBqCOA5JgpHFW/qiYG0R+Rgr6AbrTT0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JM30xFtY0jHOmaSrDe4T2yfAX1KOQfQsJHYfY/1PWe1uCs4STtZEHB4BPK6U7xn5/lEMf0faauetRsRzla/EtHKHeU48bguB/d/uQChpd6fAvycBCSFjO5U8aF1nIjQncOq+lB0eIL7SeiKizJr9BN1nZhbv/bkH6xAjqTh9H8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xN5y2SSr; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e96e45e47daso349470276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222913; x=1756827713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVly6FxrnKPpCOutqFXtYnP9ubQ0AZJgXeTB84dIAZo=;
        b=xN5y2SSrcEr+y4YFjJrz/CqWqxmKDdbxvfMtq+eNSmraeQTtt3+Blc7gLZ4VUS2Ppo
         dXq8glu6chYeLj14rqGrlouI3msT7/+wS/zWRMPA5fnCC6t8TWqd+Kclk+kMeBZCls+k
         iyl+zHki8wuQKgexcSE7zDjRqFSuni6vOga+TRELBJly2hcT8ssQekSAjKYAQYuYZd6L
         ApYMSYho0CKC74ifJqUS5sznHVHfDPEam/CIcuxr56csfYc4ZQcKWS/9UPgkkx+V13ge
         4dQeTroBSNGpHdzYrUpIhn3jqO1wryoE8XdSTfefRSF/4zap7NRUe6gkNmpW9qjJpPlO
         CgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222913; x=1756827713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVly6FxrnKPpCOutqFXtYnP9ubQ0AZJgXeTB84dIAZo=;
        b=snBf/jXtcMNqMGVkRdXM73kT7c0ed7T5JHRJnCnAoZNtB3zrtgLJASumT0GGtxHW1X
         wkKPorpJHPTX68qORdz9Tpg/U1SY1GrXx8PJgQ+J3o5nZJoq4BQrU02Xs3cDRsTCnaj9
         AzCM8JUEqa9vnNJqtSmIx5supjc40DUkK3jHPR6YyaEj83Eh//lAfxjPWlNRKwM89dRG
         JLEXKE0WdKIcyW7Pzu9YdshU/IhCX/+lNI+SgF74WF8oh0waC3JZ1okF+utAdcZuaeFh
         P9s4oqDktt0K7WOGDUcEwxo41N7WuoucWlneWUBtVzRITHi/tCpnqcsakDiHKLRGddYx
         IWUA==
X-Gm-Message-State: AOJu0YyNHsURa/khe/zkWqYUi7xOtKlhd9uE+Cy5aTXmSLgYbvEX75Jk
	WROYHZqjA54VQ4EoqRmgaIIvFtrXfgO8/N4OuwwDbYT3Z/zXCI/0s97Ln0PJrvgoNU72y1IqKay
	c9Unk
X-Gm-Gg: ASbGncu6s2zKfdypQHAfEJfa6rFfGJ71//sjbN9GcxXdq9h44n40oSewGqjhVxttk1T
	orJKAX3fGl5up2Q4DmkVrfXEdxmgTTaRCP2LCQS3xv5rmHXA9CFDvVi9V7kom3rHf/IMimAXA7K
	0v2Xw3FnI6c1iSofdBK7afO75hJaThwT8ixPhYVvxG4pMElWIL5kx27tCS9nw+sASlkKUxzUk73
	Q6yLIwgpXKU7+jiBUefP3wrfkGmYcL1RyBXY0ii187ERv+4pKsX3ubEI8AvpoFz1XOOD7wgfFDy
	PANH3J3tFvyRf31QXQwMDITMiTWLhdFObF3bpG5dgPPUfQsatngOggqaRzq6C+d049EYIU9PD3h
	RHFcmsEVQl097dnghSVLxyPnGrgnQ623OtL4GJeG+l3N65qG2SPH3cuiMpmAim2ttvuMVLA==
X-Google-Smtp-Source: AGHT+IHs9eajH2WM3NXgIzvKjebg01fyf2ACuZ9khHqmbOf6soY9xqnUvsrLiHhUDAZayHz34q7R/A==
X-Received: by 2002:a05:6902:f82:b0:e95:7f3:4c7d with SMTP id 3f1490d57ef6-e951c37dcf7mr18808774276.47.1756222913189;
        Tue, 26 Aug 2025 08:41:53 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96db453574sm890302276.9.2025.08.26.08.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 44/54] btrfs: remove references to I_FREEING
Date: Tue, 26 Aug 2025 11:39:44 -0400
Message-ID: <9bc7048e07162c9169f9b098b0bb7577749ce11e.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not need the BUG_ON in our evict truncate code, and in the
invalidate path we can simply check for the i_count == 0 to see if we're
evicting the inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 69aab55648b9..ea6884e5c791 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5338,7 +5338,6 @@ static void evict_inode_truncate_pages(struct inode *inode)
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct rb_node *node;
 
-	ASSERT(inode->i_state & I_FREEING);
 	truncate_inode_pages_final(&inode->i_data);
 
 	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
@@ -7448,7 +7447,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	u64 page_start = folio_pos(folio);
 	u64 page_end = page_start + folio_size(folio) - 1;
 	u64 cur;
-	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
+	int inode_evicting = icount_read(&inode->vfs_inode) == 0;
 
 	/*
 	 * We have folio locked so no new ordered extent can be created on this
-- 
2.49.0


