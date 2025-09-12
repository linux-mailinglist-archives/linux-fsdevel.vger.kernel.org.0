Return-Path: <linux-fsdevel+bounces-61049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DD7B54BBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C047188877A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF363019BD;
	Fri, 12 Sep 2025 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UL65M9My"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C79A3019A4;
	Fri, 12 Sep 2025 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678003; cv=none; b=lpAo4qu42zx+++RggS03y5ax1mXy7MmYaxBCVQQ5vUP5bOqdVWGCQ+u6/yw9KIIcg2whnqnni5axxrv1xECTjHvE5im7b5rsfM1+ggd8GlzPhXsdcka0htV9KZoHvH6iyY5f2QGGCPXq++xMPWbr8Sj+MUyN6p5PC8R6J7/p9XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678003; c=relaxed/simple;
	bh=4TrrGhkDl8cVInpL/zoiUoeW6yQ/INmYgdreh+8f+J4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ox1OKvYbXve8TRVR3aZNnpLRdIZyO09B5brib/iYaxkM1Y9ltJfmBvyJCVff4ghERDRaVqK2O3F02rHh2gbsqr9Yf63JtHINjyh4m5PwJ/WZ2iNbfIb9Ucw3okYlg+yLdTv6iORq/eHJe8lc8cscyLZgZoXn2xOBjBUl7rsc02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UL65M9My; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EA5C4CEF1;
	Fri, 12 Sep 2025 11:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678003;
	bh=4TrrGhkDl8cVInpL/zoiUoeW6yQ/INmYgdreh+8f+J4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UL65M9MyR31l64FuqysOs0sI4sYvxTIudeRCstGmHjT9X5iqnBEvH6HcQbL0qD7Oi
	 +vCevhE/HzX5Dpz22KfnVkzsotGsqNRFpEI9l+sK7LSHumZ7+3CwqY2pCn46ka+ZeF
	 VIuafE+BajOls8KdA67HEpwdBVOGFB31w4tqwIy5flR3qad2Pzroo7EQXn/vYDPTL2
	 8hEtcqcgs+7WSF1Av7U/RHI89aZv0X2a8+U+07Sz3jAC/g2YUeOAM1qnJ9eyuRTWQU
	 MEvlGC4PhP+laSINuZdlzFxd+xCFKeDaGRsGo7dLz9FZ5Op8R2mmL/SdPpxw8XbiGD
	 1x9oROgeNMDDw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:27 +0200
Subject: [PATCH v2 04/33] block: use extensible_ioctl_valid()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-4-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4TrrGhkDl8cVInpL/zoiUoeW6yQ/INmYgdreh+8f+J4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4ZziVPHtk9wXNyvvW59W/7r3cdYT64uTpzS+05krd
 S7l6JWz8R2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQAT6dzJyNBsn3vLTn7fmvlG
 M9bwcMYm2iQWPqhSMp8YYHn+qVNdLzsjw3/GM5PXdf3ZOnt6jlVm5OUHTaeqD/+9WS2m2a9W9Pr
 xXk4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the new extensible_ioctl_valid() helper which is equivalent to what
is done here.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/blk-integrity.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 056b8948369d..609d75d6a39b 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -58,16 +58,14 @@ int blk_rq_count_integrity_sg(struct request_queue *q, struct bio *bio)
 int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
 		     struct logical_block_metadata_cap __user *argp)
 {
-	struct blk_integrity *bi = blk_get_integrity(bdev->bd_disk);
+	struct blk_integrity *bi;
 	struct logical_block_metadata_cap meta_cap = {};
 	size_t usize = _IOC_SIZE(cmd);
 
-	if (_IOC_DIR(cmd)  != _IOC_DIR(FS_IOC_GETLBMD_CAP) ||
-	    _IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_GETLBMD_CAP) ||
-	    _IOC_NR(cmd)   != _IOC_NR(FS_IOC_GETLBMD_CAP) ||
-	    _IOC_SIZE(cmd) < LBMD_SIZE_VER0)
+	if (extensible_ioctl_valid(cmd, FS_IOC_GETLBMD_CAP, LBMD_SIZE_VER0))
 		return -ENOIOCTLCMD;
 
+	bi = blk_get_integrity(bdev->bd_disk);
 	if (!bi)
 		goto out;
 

-- 
2.47.3


