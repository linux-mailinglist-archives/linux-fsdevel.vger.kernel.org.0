Return-Path: <linux-fsdevel+bounces-59275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5949FB36EB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDBC46016F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC863002DC;
	Tue, 26 Aug 2025 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="QBarsf6+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA6034DCED
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222911; cv=none; b=fEs0tuEVOozuxQ1zyqHfbbdE/0COrg5NUUPsQYj1UbPZGW7G19s/8ez5+NkBOB/LZbjOWJ0nMNAk1iTuAM+XgUXfrrN8OJ//RmbCOdJLw17BnaMQfpXAIvK3l0EnHAkPMO6Q4iLTWW2CJ4YQ234E/gB97gECbSEfD5TD4U8rQfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222911; c=relaxed/simple;
	bh=2zYyZLHp4D2hgXiAAGibRc45yLHOvZtgp5B6E/34V4Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N551aA0kzlK5CrL7skVtOX2lg1lUV2MItPnnXLXGfQ2mKDzjEaNHYDJqbyn0c0yI/x7abUhIf36bIla100lCN6JXevPbZ8VQ5Ye1mDPRPLtzhs9OL4Z1k1M0yPq2DJZBW2Y4WSLh2p4+LC8aFMlL9XBD75L9Rqd6tm/xEa4oEZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=QBarsf6+; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e953397c16eso2354345276.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222909; x=1756827709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BE//YinxPgmUWE8hsLrFsv2AZQscov+biNx5LkG7S88=;
        b=QBarsf6+5qFf4TdDe0d3qJt9CTe1q6JApaGKRCFwzUvqQhRcE9umkfMdU6tSTYB1Ly
         GyJk22XkSTXTcDGh1XJ68x443V+YkvJ6DKF2a9rrHJ5Lot6vOpDb6hBi3SSNTy/gSECR
         5oBpg8tsiQDbgCnT2T7fqUskT3VWmcRtnRFbHtaYgxpCcTs7a++Ns2teQByV4ZWl0jkF
         9frRsgDUa9rZSfVwfXTisE2TRn4LhviWcCf5OVux/cGUZ53/Eig9dLl1C3kdZfHzaHo/
         nLRjQxJ0q5JpkChLXLguhoFUs4UH/gaYr29tmTm0AnuPxTIUZ9FlbQC23zS4V8eGcpmg
         RbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222909; x=1756827709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BE//YinxPgmUWE8hsLrFsv2AZQscov+biNx5LkG7S88=;
        b=fgd/k4H3cfWrLj8gdVIsPM443cyw3bZwSTOsOkMN08GXP47qrk5WSmLXGiV7/L7wXR
         okJe+0c2tZ7LS9Dk85pf6HjSz5RGpAOLPVKq6KGWDr2+aLaupuAWB3CTKQJVvK6G+G1+
         yJUxqJR0Q92p8SHIqDN69VzZnIfbVxpkA7z1ws1h/yK+OH1x4OD5GVnsTTASZ3OU0Yo8
         p6Su6uAsyxTHqnhODzz+ywnilvzXj3TXMHaHisA2UlzEPx34kQEFwbyen+q353H08TMs
         Sbf0EqJQ2gL051e04n1fgV2MKdGMLQSWAktXb0DYo8se1Pp48jf4BL72P3i6JgnAXzZk
         8nSA==
X-Gm-Message-State: AOJu0Yxtrlt98/9tEPniKqz6W74zUz7vNJeofRbmsSUpSvJKC31HfPQK
	epCzN8Jvyqouku4T0BTTwVotiWiyWhQcgSWWrgMDVNkGv4EsFRVh35XDs5ekqOyyzxDZr/jwwLx
	Qa4a9
X-Gm-Gg: ASbGnctgp0CGEq+A3SX9nN1TT+aVIBPFC0pv/oy8q8Vpvnu1rn7qqJ6sPpEGqlMWT3q
	E8L9KFgjsqJbJEZz9hFK/ibR9mB8Vm76Bas87ZKEKbjPoN4Df6zk2vUjYY6MafffDzeD4aHla5l
	pl/55mzcU7KBZjLgZ0LEA7m0nlfgrqXUzpfdmnu3aPmD2Z15cGNGxgN5S6xcJ0Vhd7ZDMCE/SRQ
	xzOsew2dlEpZcwM3xyFMDPGvoRXIAXF0t8bg7lJkrBlZLicf7br/DdhZtTD+qvFMHuvhcoSTCck
	givtHCj3cQjpNjy/F6VvfF/0bF4pSdV4gJO9iF7z6bWkMOb8GwK3s6IF3MVmk8uIPNwQaZkZ/5Q
	NrHse0cTAmnwe2GbWpoVXQz0fM0qBpeyOaF9e1j1fLWE4N5yH7JglaKeMd9Y=
X-Google-Smtp-Source: AGHT+IF30GxXzt31jHcfNUoY2pUyBatIJtVlXY2VZDYDljhQelnzFVQCaalCRl9Yu+PEcvaFlg6PNA==
X-Received: by 2002:a05:6902:2b10:b0:e96:c754:b4dc with SMTP id 3f1490d57ef6-e96c754b6f1mr7345665276.18.1756222908777;
        Tue, 26 Aug 2025 08:41:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96c38c8efdsm1865626276.14.2025.08.26.08.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:48 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 41/54] xfs: remove I_FREEING check
Date: Tue, 26 Aug 2025 11:39:41 -0400
Message-ID: <830cf8502686e1bafe75ec6fa7e87c68ed49bd54.1756222465.git.josef@toxicpanda.com>
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

We can simply use the reference count to see if this inode is alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/xfs_bmap_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 06ca11731e43..cf6d915e752e 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -514,7 +514,7 @@ xfs_can_free_eofblocks(
 	 * Caller must either hold the exclusive io lock; or be inactivating
 	 * the inode, which guarantees there are no other users of the inode.
 	 */
-	if (!(VFS_I(ip)->i_state & I_FREEING))
+	if (icount_read(VFS_I(ip)))
 		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 
 	/* prealloc/delalloc exists only on regular files */
-- 
2.49.0


