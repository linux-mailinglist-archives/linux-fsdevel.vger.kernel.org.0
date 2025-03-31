Return-Path: <linux-fsdevel+bounces-45362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072E1A76809
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 16:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBC2188CEE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8FE21ABBA;
	Mon, 31 Mar 2025 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0ce2Nax"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2F21A44A;
	Mon, 31 Mar 2025 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431557; cv=none; b=fkIhQO1ujETJ2c6KIMt3eigNRcer+9KgKXKlNEJVzTti1Ot2J7yFlxDl+VJHG98ihldP45W/KoMDBw+1gTWMsDYBkvIc6So/p9dQ38SZMmxlFxY3ZzlxkOlLvRo/q/4spykxIvmd2v6HjNXOZaAmc/mqEpJFLzwddSOBHxEIWcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431557; c=relaxed/simple;
	bh=zORTvlJlx+KkHe9iE94PcQMRLf91J3RmqhTq+NrHcuc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uWBonV202xZP8Nzh7wZFyomNKpe6vSn06diR08p3GibS4KfUslF+AcaOuUwHS9K1+c/Wj08qiPxzEea7tZM9L+7W6FWgGbFlQwGt/wKlguKUHhSSefFVvDHqopJIPKEs2TEGxR8GjZJ71ntlIzU/7VRclSxzCA0YeNh7QRuadcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0ce2Nax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228E1C4CEE3;
	Mon, 31 Mar 2025 14:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431557;
	bh=zORTvlJlx+KkHe9iE94PcQMRLf91J3RmqhTq+NrHcuc=;
	h=From:To:Cc:Subject:Date:From;
	b=I0ce2NaxfAUE+95c2CalerRnYZYJ/LQRXtaEntm11+ElidZ6iEgyvEUdoccGxM/Yz
	 cEWk6CVYAFYqoQLEKatEopkOp4+MHPpZqUAK8rwE4KM0FxMxdCqfFiHtBCnaE8lOdg
	 DIraEJvuHZcZ+llv5pxMdJNCsdB1bqas8AcvXkQp5EBvHDE52IPajtFzSpJNmwyc7A
	 W+M1qZsAIgJsPw19uuOfbpkbz8jdQGK96jQJxKhBOIOB4rjPVPNbVSZGC9YLO/fTgE
	 F4/ut5NK/PS4v3ocu6bVjqjP6gazGpeP87B73KDCI1bEPiVL9pYL1Cx27tkBgcPkbN
	 zx61MRMB63ODQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10] umount: Allow superblock owners to force umount
Date: Mon, 31 Mar 2025 10:32:34 -0400
Message-Id: <20250331143234.1667913-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.235
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit e1ff7aa34dec7e650159fd7ca8ec6af7cc428d9f ]

Loosen the permission check on forced umount to allow users holding
CAP_SYS_ADMIN privileges in namespaces that are privileged with respect
to the userns that originally mounted the filesystem.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Link: https://lore.kernel.org/r/12f212d4ef983714d065a6bb372fbb378753bf4c.1742315194.git.trond.myklebust@hammerspace.com
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7e67db7456b3d..2f97112657adc 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1716,6 +1716,7 @@ static inline bool may_mandlock(void)
 static int can_umount(const struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
+	struct super_block *sb = path->dentry->d_sb;
 
 	if (!may_mount())
 		return -EPERM;
@@ -1725,7 +1726,7 @@ static int can_umount(const struct path *path, int flags)
 		return -EINVAL;
 	if (mnt->mnt.mnt_flags & MNT_LOCKED) /* Check optimistically */
 		return -EINVAL;
-	if (flags & MNT_FORCE && !capable(CAP_SYS_ADMIN))
+	if (flags & MNT_FORCE && !ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 	return 0;
 }
-- 
2.39.5


