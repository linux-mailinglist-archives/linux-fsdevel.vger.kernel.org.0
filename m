Return-Path: <linux-fsdevel+bounces-66940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F005C30EC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8A018C40C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7172F6164;
	Tue,  4 Nov 2025 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz3sm4zo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1892EE5FE;
	Tue,  4 Nov 2025 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258372; cv=none; b=DTPhwq397yUUccTGkbbzgMvpoREX2UXY1QODa2Xf4ibLPFODcMeGNGnETugu0Z/iLyD5EdlsbSsyWGpZ8kSgRiW9qrRgjUvqTGr2Rve8WDKmEgIpmDnxiu+a3E3I62mMe//F3eDztmUDZbenB2NiMmfwT9VL35sY3i6b59GHd9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258372; c=relaxed/simple;
	bh=AlgdlsWYiuo1+GqO+80laDAY9WFCLwtNz7Y/jeB0xHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NIIpFjDA+OXhe0rQ/J7mQ7byPIenDuGfYYOJi0uPpx9ZEVP5R2pHdK/+UNzAizzpHXGgqhmbfL8KDNTnc6BiEPpEHUup5RFusaIKqlyUzYainGim06H91jKj/PLOnCYYNzk5eN4iE046uO5aQidCCTNLc77qLntz+AiZ4eyR4AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vz3sm4zo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C428CC116B1;
	Tue,  4 Nov 2025 12:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762258371;
	bh=AlgdlsWYiuo1+GqO+80laDAY9WFCLwtNz7Y/jeB0xHU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vz3sm4zoM46y1XL/X1AmxbnYsApxo7+1M6jDIzuXijNEsIGtFoufvr29F6s11uT50
	 JIFp+FdGEYh3kyENwd9EKs22waSSMKhqSTstZruvAgoK4KJWFrrGeYcweCNFmiFCIM
	 2eJVy1wxnuBwUhmVvAg3ujRDt0ZFwHCo0+0DwjAwe0UkTuOXDkzj+gfaiusQPB4pnJ
	 Bq7W1ihnsMXutomknEulBsGSuPPwSnWt84F0qweppqWqqYWbms1Xy7ikhAL/wZsteM
	 k6y0u8uZnkmaxyrUUyArp4kvmfOISsRMH47KLTjmeoTfZ5TFIoW06kukO5e5yR9R34
	 eeD/UA40BsNLg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Nov 2025 13:12:35 +0100
Subject: [PATCH RFC 6/8] btrfs: use super write guard in
 relocating_repair_kthread()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-work-guards-v1-6-5108ac78a171@kernel.org>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
In-Reply-To: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AlgdlsWYiuo1+GqO+80laDAY9WFCLwtNz7Y/jeB0xHU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyvt3ibrKZ7dbraZ7fpxx8/0foknzMOh6nz8JMobcnl
 55gu9Be0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRM90M/wyjq2pPLOC/8b06
 z/HmlT1zvz/TP/SqPJmhwq/9ac+h/p+MDEv6D9Z/3BLeuGpx1Z7aL2tfC8T9f1ZUbXploco0SV5
 +RQYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/btrfs/volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4152b0a5537a..37b9daa14445 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -8178,7 +8178,8 @@ static int relocating_repair_kthread(void *data)
 	target = cache->start;
 	btrfs_put_block_group(cache);
 
-	sb_start_write(fs_info->sb);
+	guard(super_write)(fs_info->sb);
+
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
 		btrfs_info(fs_info,
 			   "zoned: skip relocating block group %llu to repair: EBUSY",
@@ -8211,7 +8212,6 @@ static int relocating_repair_kthread(void *data)
 		btrfs_put_block_group(cache);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
 	btrfs_exclop_finish(fs_info);
-	sb_end_write(fs_info->sb);
 
 	return ret;
 }

-- 
2.47.3


