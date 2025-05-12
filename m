Return-Path: <linux-fsdevel+bounces-48767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 192B2AB4352
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 20:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DCEA7B233B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 18:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6302BE7D1;
	Mon, 12 May 2025 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTON22JY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471A2BE7B8;
	Mon, 12 May 2025 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073128; cv=none; b=gKHJDLOu/L0AY8DiRY5nM5tRmcpcR8Q1NvXnaYkZH5PFVV2vV2s6rTCZ+Nj003WAZqTNVdT3LVpEfdtMNFsLZEuCGLf9EQMNM//TP2r3H79D5LpBKinMydOWt03ENkfKo34WqszOhUVFz6UEeCLom4Pye7rjikqcV799PGHpTaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073128; c=relaxed/simple;
	bh=5ZsYTE1uAEimh76tJAXpkRCOoVxNXGu1R/Kv4yYMaGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lWzNyi41+h/g8oPdmD64doSGBBop2+KTA5VY3xSxowg/a4kUb6IYx2EwbcWfZ5XTsv+lOuvjRlvAl3j/IcLvH6x9gCqZ6AbjkNYMptVjP30l7KoqEveKGsy4gIQlmsYeKaE6Wu6gLXBcnqpQ18TNVXOQgkK2i9gey2fcaxIFwUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTON22JY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6307C4CEF1;
	Mon, 12 May 2025 18:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073127;
	bh=5ZsYTE1uAEimh76tJAXpkRCOoVxNXGu1R/Kv4yYMaGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTON22JYxo5npQqXcRSaXaCwqPsJ/igArXPre7ZzaTJT2Id5eS1I3qpZzL+jv1x+2
	 HegtFXeOndJRane5KF4zo/onzj2j00UEdMX/fzqOOjQpLvCN/zROdj9ihwZ+VLXIEF
	 UQXzxDvFAhwLGCncweD0s8V3yh9mwGJ51ttvDGBnfdNCORON0VP0lvNwbJwSV/IHTu
	 nuReKXveikDc8mw53gVKTCaceSgGb3sYbZKkgDbgzldAUJbJCUCph6hdglYws35uX6
	 sJDBKWiFBXxAeNyNdw00Z5oAOY8l/PrwOLiRVRGKlhHqlwl/EcFB2RLBA60yZMxLNt
	 +PPRVe0R4AwNQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/3] __legitimize_mnt(): check for MNT_SYNC_UMOUNT should be under mount_lock
Date: Mon, 12 May 2025 14:05:18 -0400
Message-Id: <20250512180518.438085-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180518.438085-1-sashal@kernel.org>
References: <20250512180518.438085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.182
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
index 642baef4d9aaa..751f2f891f86b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -589,12 +589,8 @@ int __legitimize_mnt(struct vfsmount *bastard, unsigned seq)
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


