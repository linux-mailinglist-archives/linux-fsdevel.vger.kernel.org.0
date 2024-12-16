Return-Path: <linux-fsdevel+bounces-37490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A58A9F313B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 14:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CACEB162A62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E293205AAD;
	Mon, 16 Dec 2024 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN4l+szc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517C6148FF2;
	Mon, 16 Dec 2024 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734354409; cv=none; b=hX9UQkIGoK1oGj3ohhfqGfLb/lp53n2zevb5NLu62Ys8/G9ksiK/64M2HHpZ4jvKPk22x3wTaPdqbilxhHyV+mGzqDVIJNnE8HrwysU/I3oIMIMJwiBLrBVlnC1gNOz9eNczSqSdBMx+WAG/Kf6JGliA6c6qZTXZBl2DfI4gJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734354409; c=relaxed/simple;
	bh=kEaMspLIRrrFhRiFyKDmcVMmgoYWb1T3m2H/SlJmZj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQeP8PMM7QDI1tanWg7pyygJIFiZhUiPKp+aIz2GZUqDu8EYLGEtg+KOTyqR2IS5+ohoRGym8mCfHTITSpkIjcINhsPuupbooQVGeWNKy8jRCiSDNNpofXA07q5QQZsGE/Sh9XJztINb17Xz5S8c4wp2n7hiAKOhboIbAFdqsKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dN4l+szc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725ee27e905so5243742b3a.2;
        Mon, 16 Dec 2024 05:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734354407; x=1734959207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+JzeXaCBZ8Q0UvE6DTJsJh3vIeyP4Z/j9o/+bvB6LY=;
        b=dN4l+szcfj5/lEbT91nzKGR1FeHCIPPHeyO5ZxHCyCZpUP1IQve+rBcaIkOzaPNWBS
         H7+5KCfvUcNjGEJwcL+iFKRLL4uTTItulgVKE1Z6pZOkhOoYK9DsxBZyy+CmYao/Fhwb
         rwQ/5dJyGIl8L73oY9hPedzFL88jvKSuONjvMLoIco2w+aFkqCC/0PxSt5eQCcipAfQZ
         nf+YEW8smOiBuz3oZOntaC5ofBzuIyiKJyLl35+P4iwuigcP/Sy0wjJNB9LzEczTt2Lt
         cCGT8MpKGN2Gm5qtLoRupE2G3pNx6RZEOQGFYL4eKcARSJldZYz5yQj0uYQ3LRAfCn52
         /lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734354407; x=1734959207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+JzeXaCBZ8Q0UvE6DTJsJh3vIeyP4Z/j9o/+bvB6LY=;
        b=tczU0P6coS3RmgE/jLnsaImbdoxncrZaGgdusa6nS0tK85HXAXp8FtKkDTrXRQEwkO
         fi5uZSa/RikRLTXqh53j+HUis2XdvsXk6u+mTrdG0aVjv65dGWqfiRU3y6oh5sB0yVz7
         1u7P/xgYg5ge3lrqZvsJJpbIzTEUy2tuUeX94hAmZ/yipKrBlFzBDk3/r2HtdgOEHugM
         fGOi0uxfed07YFkbh22Qe7m9ON3sn7akIhKYU3SWqZgTjLTEB2jGrcBMm2dv/DBXzS0h
         pIhi9SXtitEmtVaVXSjTc36E8wr0CR/UMzzbwRoUuw/v9GR7QMOxwP9FWvkbym1y6PJJ
         qC8A==
X-Forwarded-Encrypted: i=1; AJvYcCVy0j+cMi6/XZGHVqjtk1igBSoYU5rUMDkUainqkfPq1HkjeOekjNAnOcV0c1QIIVx62V+bJbY+Tkx+UJyv@vger.kernel.org, AJvYcCXMcbNkgQdiqW66nzo7Nw0/+BZv0gZKu3QaMQRSA2qP4lqAfyXUMI7r0kwGz7Xg9EjBFF1M4zJ0BW/6@vger.kernel.org, AJvYcCXiY8jHq8MxwyrTjp/zH7GtAMoApU2jfcZTy6sXR1F4vqO5Gm0W9ABQH/jfXn4f0Nn60EghkzguLHEm6yp+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6g8ttZM2/CWgTHbnO7y8PIZ9cHH0UNKbcSUHHwtrkfqq8w2Gr
	KWklG0IihjSGtWdwSRlXhu+kUOk4alSvWTEubOj3NYWUQ6+BXhOI
X-Gm-Gg: ASbGncv5hPVIWtv1Hml3skX0nhH/oVsE4EWnrY2980l6554GThoiQM8vSECTK1LrZ9N
	PbWrItkzwtH3bc5Bz42ZTDG67Nm61TsxltlEZVjFC5iG+SuQRXWiLtz8DiPOkefoIvF4bCu+Eol
	x0QvYvxhp9noEwyuE09e0Av8jG9mksyTkVtN1x0z6C86yEUtEV+X8drbYlllmefeibEV8v8a+hT
	BXZUIaARQl3F5yheO/cRAdBtLsuWrxXrpZGqLVeBCBz4LouA30sj3HFTZA+ke+9XP3km2titcOP
	BAXBoWUZzysdaBM=
X-Google-Smtp-Source: AGHT+IH0es7NhMLXx74mVVyAti+SehWLoqo9cBImyHUIQ5+dUc6ZqcHnuPAZNQ0Njgwj+5RsawsQug==
X-Received: by 2002:a05:6a20:db0a:b0:1e1:a885:3e21 with SMTP id adf61e73a8af0-1e1dfc18486mr18496775637.7.1734354407304;
        Mon, 16 Dec 2024 05:06:47 -0800 (PST)
Received: from localhost.localdomain ([180.101.244.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad5ad0sm4651803b3a.56.2024.12.16.05.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:06:46 -0800 (PST)
From: Tianxiang Peng <luminosity1999@gmail.com>
X-Google-Original-From: Tianxiang Peng <txpeng@tencent.com>
To: chandan.babu@oracle.com,
	djwong@kernel.org,
	p.raghav@samsung.com,
	mcgrof@kernel.org,
	brauner@kernel.org,
	dchinner@redhat.com
Cc: Tianxiang Peng <txpeng@tencent.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	allexjlzheng@tencent.com,
	flyingpeng@tencent.com
Subject: [PATCH 2/2] mkfs: make cluster size tunnable when sparse alloc enabled
Date: Mon, 16 Dec 2024 21:05:49 +0800
Message-ID: <20241216130551.811305-3-txpeng@tencent.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241216130551.811305-1-txpeng@tencent.com>
References: <20241216130551.811305-1-txpeng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clustersize parameter for -i(inode size) switch. When sparse
inode allocation is enabled, use clustersize from cmdline if it's
provided and fallback to XFS_INODE_BIG_CLUSTER_SIZE if not.

Signed-off-by: Tianxiang Peng <txpeng@tencent.com>
Reviewed-by: Jinliang Zheng <allexjlzheng@tencent.com>
Reviewed-by: Hao Peng <flyingpeng@tencent.com>
---
 mkfs/xfs_mkfs.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/mkfs/xfs_mkfs.c b/mkfs/xfs_mkfs.c
index bbd0dbb6..b8a597d4 100644
--- a/mkfs/xfs_mkfs.c
+++ b/mkfs/xfs_mkfs.c
@@ -92,6 +92,7 @@ enum {
 	I_SPINODES,
 	I_NREXT64,
 	I_EXCHANGE,
+	I_CLUSTERSIZE,
 	I_MAX_OPTS,
 };
 
@@ -474,6 +475,7 @@ static struct opt_params iopts = {
 		[I_SPINODES] = "sparse",
 		[I_NREXT64] = "nrext64",
 		[I_EXCHANGE] = "exchange",
+		[I_CLUSTERSIZE] = "clustersize",
 		[I_MAX_OPTS] = NULL,
 	},
 	.subopt_params = {
@@ -535,6 +537,13 @@ static struct opt_params iopts = {
 		  .maxval = 1,
 		  .defaultval = 1,
 		},
+		{ .index = I_CLUSTERSIZE,
+		  .conflicts = { { NULL, LAST_CONFLICT } },
+		  .is_power_2 = true,
+		  .minval = XFS_DINODE_MIN_SIZE,
+		  .maxval = XFS_DINODE_MIN_SIZE << XFS_INODES_PER_CHUNK_LOG,
+		  .defaultval = XFS_INODE_BIG_CLUSTER_SIZE,
+		},
 	},
 };
 
@@ -956,6 +965,7 @@ struct cli_params {
 	int	inopblock;
 	int	imaxpct;
 	int	lsectorsize;
+	int	clustersize;
 	uuid_t	uuid;
 
 	/* feature flags that are set */
@@ -993,6 +1003,7 @@ struct mkfs_params {
 	int		inodesize;
 	int		inodelog;
 	int		inopblock;
+	int		clustersize;
 
 	uint64_t	dblocks;
 	uint64_t	logblocks;
@@ -1055,7 +1066,7 @@ usage( void )
 /* force overwrite */	[-f]\n\
 /* inode size */	[-i perblock=n|size=num,maxpct=n,attr=0|1|2,\n\
 			    projid32bit=0|1,sparse=0|1,nrext64=0|1,\n\
-			    exchange=0|1]\n\
+			    exchange=0|1,clustersize=num]\n\
 /* no discard */	[-K]\n\
 /* log subvol */	[-l agnum=n,internal,size=num,logdev=xxx,version=n\n\
 			    sunit=value|su=num,sectsize=num,lazy-count=0|1,\n\
@@ -1756,6 +1767,9 @@ inode_opts_parser(
 	case I_EXCHANGE:
 		cli->sb_feat.exchrange = getnum(value, opts, subopt);
 		break;
+	case I_CLUSTERSIZE:
+		cli->clustersize = getnum(value, opts, subopt);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -2594,6 +2608,17 @@ validate_inodesize(
 	}
 }
 
+static void
+validate_clustersize(
+	struct mkfs_params	*cfg,
+	struct cli_params	*cli)
+{
+	if (cli->sb_feat.spinodes && cli->clustersize)
+		cfg->clustersize = cli->clustersize;
+	else
+		cfg->clustersize = XFS_INODE_BIG_CLUSTER_SIZE;
+}
+
 static xfs_rfsblock_t
 calc_dev_size(
 	char			*size,
@@ -3517,12 +3542,10 @@ sb_set_features(
 		sbp->sb_versionnum |= XFS_SB_VERSION_4;
 
 	if (fp->inode_align) {
-		int     cluster_size = XFS_INODE_BIG_CLUSTER_SIZE;
-
 		sbp->sb_versionnum |= XFS_SB_VERSION_ALIGNBIT;
 		if (cfg->sb_feat.crcs_enabled)
-			cluster_size *= cfg->inodesize / XFS_DINODE_MIN_SIZE;
-		sbp->sb_inoalignmt = cluster_size >> cfg->blocklog;
+			cfg->clustersize *= cfg->inodesize / XFS_DINODE_MIN_SIZE;
+		sbp->sb_inoalignmt = cfg->clustersize >> cfg->blocklog;
 	} else
 		sbp->sb_inoalignmt = 0;
 
@@ -4634,6 +4657,7 @@ main(
 	 */
 	validate_dirblocksize(&cfg, &cli);
 	validate_inodesize(&cfg, &cli);
+	validate_clustersize(&cfg, &cli);
 
 	/*
 	 * if the device size was specified convert it to a block count
-- 
2.43.5


