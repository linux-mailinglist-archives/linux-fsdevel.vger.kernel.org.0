Return-Path: <linux-fsdevel+bounces-60777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0478DB519A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3E0565751
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C54334709;
	Wed, 10 Sep 2025 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9QziZBd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB888334379;
	Wed, 10 Sep 2025 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515043; cv=none; b=S98zORo53TaZKC8EQIlT32Im3fIN63OoVbWQykkiVCDWSYv7zJ5SDvAnUkRL4LtxZePSYubEZevGZRYCTTlYhn5rRPxwo+psGy6IdLOogbHkOsyeGsNOcckLRoPgBLv2eFONjyzEt7WMT24FgWyoSI9bGV1jI4CiBcikYnBN5AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515043; c=relaxed/simple;
	bh=hlPdSkw0/u4fF427i2FMAlYZXzvrtzVNFa+EeyOD1Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TeBPlimcRFi0c5x4cHRcVLBvXDNo/BBobtPDdqvt1Whu6eg5lo2i7JknewU/YPe1Aqa8udIIvODl2ldTiWe3Coy1SAbj96OEvw3EdP+jt53w9Lr9Gcdn2YLvbTXmwuFANy+Ew2RjL/c6lZuGTLt9UaPax8f/UUqZNEoBlSYnuGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9QziZBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44E2C4CEEB;
	Wed, 10 Sep 2025 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515043;
	bh=hlPdSkw0/u4fF427i2FMAlYZXzvrtzVNFa+EeyOD1Bk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y9QziZBd0Xfzc0k/r5hAFGohisjw14iJaQyLCxbG5+1s/fTXCFtLFrLkkSq/eTlX5
	 O8p1ntOjYorqNP/nX8D96b7puZvl/zp+aOknGEY8LFIGuw7WKeV/kB2UcfW/neieYF
	 sY27AFZhq7pTCwQTSQRbqWcEwaDYAXuavdYjed5c0nu/stMgUtOZhS/rR3o1a8T+dp
	 EtcvePxTOhVaXUE7F/BfWmGfZ5QcQMerTkv0rLWHC6jKoRi3a8Ir6SWM1XqfW3OECo
	 3WG+YdVlHw1eUVW7XQiXssh53X7Z2MCBjy6YeE6b8v1MnQrRgtEyMzOlLNqn/l7CoL
	 ocXG37wpvE+/g==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:36:48 +0200
Subject: [PATCH 03/32] block: use extensible_ioctl_valid()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-3-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
In-Reply-To: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hlPdSkw0/u4fF427i2FMAlYZXzvrtzVNFa+EeyOD1Bk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7GVnSFA6qy+kdChh/aztN45MnV18JMfglArXv9Llq
 dvYtxRe6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE9gQLk4BmMjTdQz/q7+z7Gab/uWn4s45
 2bKdB1M1nC8E8yVOFe/7/2iNeaGWDiND+/W3R+zcPizMLtrO4b56+4Y/DDzLp5YWmvPaHZBmiOF
 jBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the new extensible_ioctl_valid() helper which is equivalent to what
is done here.

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


