Return-Path: <linux-fsdevel+bounces-48763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4615FAB4196
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 20:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0DB16D722
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 18:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29761298C2D;
	Mon, 12 May 2025 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIy+h3cG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E27B298C1B;
	Mon, 12 May 2025 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073066; cv=none; b=AE2hJyGNdd+i3N1upwih4Y9EShEQjEChDTq2BnP3q0Ek2Zm5FHPaFgvGMRpTCK7xN0QGGlsE7LWcRhSwPiDGZpsj1yrjGEypR/VCx3XKXT6MDHAJSOf8Usd/II4NbhNBsVH8+4A/euvtPSSWhvGnkyzseHYUFb16jDdP2o//Iks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073066; c=relaxed/simple;
	bh=UHCXy9jR8dSGqVN48aTVRaYvNMr8ifTKeSKvOn17H8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IWJ0kwNXnOf2DAA27UogijYyEZToXkxD+Y/xCLsa7jvi/7Bg7JukGlJfBX7Le7QK/+50HydBMOM1wCXC/i157JXwnG5TZ7p+JEOii2pBtdfVHchNeWgX38RJx6lt/11YsPnQlIizg44QBpy617c46j3pGkSX6X5Apk6A27PEJgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIy+h3cG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A3CC4CEF0;
	Mon, 12 May 2025 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073066;
	bh=UHCXy9jR8dSGqVN48aTVRaYvNMr8ifTKeSKvOn17H8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GIy+h3cGV028lDKoKPOQt8neYjnSnCIfJZL23jzQ2stNM3JIKGOIaG3qSXiQfRZM4
	 NE8qeKGSAParA1fkMHvjPHOhwuyDESiRRCGoSdfdFMVq/vc+cqaI5PKmN6N83HZ6Mm
	 K0wPGu8coC+QHd334uMmognyvfpr8vW+JC9nzocYlTq5qxFOabDsc5jj6CfLrJjCQF
	 THcrcSZtpXr+0Sp8lA/2BP0OoylpEC0X0+6cQn1TaNCvWKpp0HbAG65wV5tKE+RtIk
	 n8OhnCuYpe3oo4w4Xw9tKIKtPWFdRq7Pckp/5R5lIs+Smq9F9jGYk0NURyUK2mFlx0
	 kBYIBi3Q9vVEQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 15/15] __legitimize_mnt(): check for MNT_SYNC_UMOUNT should be under mount_lock
Date: Mon, 12 May 2025 14:03:50 -0400
Message-Id: <20250512180352.437356-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180352.437356-1-sashal@kernel.org>
References: <20250512180352.437356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.6
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 250cf3693060a5f803c5f1ddc082bb06b16112a9 ]

... or we risk stealing final mntput from sync umount - raising mnt_count
after umount(2) has verified that victim is not busy, but before it
has set MNT_SYNC_UMOUNT; in that case __legitimize_mnt() doesn't see
that it's safe to quietly undo mnt_count increment and leaves dropping
the reference to caller, where it'll be a full-blown mntput().

Check under mount_lock is needed; leaving the current one done before
taking that makes no sense - it's nowhere near common enough to bother
with.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 280a6ebc46d93..6730ffb03da5b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -781,12 +781,8 @@ int __legitimize_mnt(struct vfsmount *bastard, unsigned seq)
 	smp_mb();			// see mntput_no_expire()
 	if (likely(!read_seqretry(&mount_lock, seq)))
 		return 0;
-	if (bastard->mnt_flags & MNT_SYNC_UMOUNT) {
-		mnt_add_count(mnt, -1);
-		return 1;
-	}
 	lock_mount_hash();
-	if (unlikely(bastard->mnt_flags & MNT_DOOMED)) {
+	if (unlikely(bastard->mnt_flags & (MNT_SYNC_UMOUNT | MNT_DOOMED))) {
 		mnt_add_count(mnt, -1);
 		unlock_mount_hash();
 		return 1;
-- 
2.39.5


