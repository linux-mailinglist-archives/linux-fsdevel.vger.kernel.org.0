Return-Path: <linux-fsdevel+bounces-48765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E414AB41E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 20:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AFCC1B60142
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 18:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571FD29E068;
	Mon, 12 May 2025 18:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5lzzYKi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB029E04F;
	Mon, 12 May 2025 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073107; cv=none; b=ID0znEOeBdlycLUOJcyLGqx/fZLpD+zgZMDDMT7FhUtfBqUlD2nTUKEB8WW/2G6sFx1hja3pgx0hjRcs0Z1ZcIXsU0zjlWS3G41BnhPjzYJQprrK1UnR3jblO08ji3ieCJCdrZDE0hedKaIEH9/AMP3X/uJa3qd/V36qRYS/icQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073107; c=relaxed/simple;
	bh=9QrrgY5oyHOR4ZrZYG/jcgKZ5o5VjCPPovTFlnkkskE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Abv8tbu/toH2pmrcp6Sj2qp/STT6AX3KM2pHID7cJKtlf6f5ISN2E9EF6JJNiHOaHN128N5wHzd6+cco20zNll8uj5BvU+kJo7SyOgZx+s1jppA5PQOCdLh69I2RO+qgyFVPZmwVQ7vi98sNKOtHCmhZm6OHEfYHfKaWQBS1HHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5lzzYKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FD0C4CEF2;
	Mon, 12 May 2025 18:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073107;
	bh=9QrrgY5oyHOR4ZrZYG/jcgKZ5o5VjCPPovTFlnkkskE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C5lzzYKioc6py107GqX2V+8T3Q/6802eo9ZLDwnMJExh+ncHyXsI1McQpmRu9YHok
	 CcNg0q1So1qGA7mpoZnUxtlq84hUO3DZVmYm2/6grz7iSHeT7yF0vao+wIN4NZX8XE
	 j3hork+dKzw+HrUebEDFeA8c5+nsXbjzYIJw+YJoCBDKf0olHt0SBvibxuE5YJ3gks
	 6o4MqRwOLchye/rV4e1A3Sl1zOj5PEJtr8uTtRqu+oOTG40zErnjzgQURjrrkz++Qc
	 Pw5bx31qxScC8ovc4Cfm+m1CD6s8baB5sI83OyPh2i0p/MeVaZZILW8ABtwjSkmy9V
	 40gEP+tuFvgsQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 6/6] __legitimize_mnt(): check for MNT_SYNC_UMOUNT should be under mount_lock
Date: Mon, 12 May 2025 14:04:52 -0400
Message-Id: <20250512180452.437844-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250512180452.437844-1-sashal@kernel.org>
References: <20250512180452.437844-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.90
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
index 5a885d35efe93..207fc2f1321dc 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -636,12 +636,8 @@ int __legitimize_mnt(struct vfsmount *bastard, unsigned seq)
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


