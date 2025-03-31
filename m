Return-Path: <linux-fsdevel+bounces-45354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 473FDA767EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 16:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002BA16740F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A4B214A77;
	Mon, 31 Mar 2025 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiucjysO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6C6214812;
	Mon, 31 Mar 2025 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431540; cv=none; b=rjefzdtmi1tSanoz9xYvHvhjuIHrKPmiFFUlLxNlg5tZOtu6wh+obFsmmCaBg9igO2gmCnxBxbVJ43UsCJnr95iwSdRjeURFmg25X2ZV89gnugOTHKjfeENwuvaFosrKl3+JjwYhuUqxW5f/KyOsuuWAms1tb4VYU5HoYSQiSiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431540; c=relaxed/simple;
	bh=zOM8DZdAAwTvYRuEl5bCkuiPICOlbnZjGvAKYVEvcMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X5RWVoB2AKD1KZiCq7Jbb6qA958bhwSV4Lh/8gSnStmU8FOXWxmHLgFnfSpc6NXo9O8JLn8CoRZoXYtQpCYQVrRPbaPpXyg1nJmPeqkMNbAlpt76v7QgNuIuNXN7doK8yJEgAzyJTNi6ujpoW0AF/TzqNmACi69fwZ5NNhsYwVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiucjysO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BF0C4CEE9;
	Mon, 31 Mar 2025 14:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431538;
	bh=zOM8DZdAAwTvYRuEl5bCkuiPICOlbnZjGvAKYVEvcMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UiucjysOO3yIER+ZMQpyf48ZT7yAHcOvfPgGizFUk7bTJlROfdcjd/BbnzzQDKJEL
	 PcWPnPqNlLFFSCCEGdSywoUs8gybu7yaaOUWk8SGM+tx3inXXnjLRgqdSbL44L5YRi
	 gVLh6DeQb3/Zjw1c0mRgCMkuXrC9X6yBoqlBlwgsoA1W1wgMQvtSKPlDcbt+8aq77H
	 I2Ykk4hyyXTCcv+jLGr5cYTjJKgtKyx/h0XHRSFemb8XhbEpzx7zmAUCBBb02dU6YF
	 1vi4SDgodRyQTNdfU3RMmTib0ooeL9VZn2E06+eL2df7ye8TZgsGfB2cEY/9I8vvIS
	 U2ysEusFZ7ekw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 2/2] umount: Allow superblock owners to force umount
Date: Mon, 31 Mar 2025 10:32:14 -0400
Message-Id: <20250331143214.1667735-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143214.1667735-1-sashal@kernel.org>
References: <20250331143214.1667735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index cb08db40fc039..6a22882d5f54c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1986,6 +1986,7 @@ static void warn_mandlock(void)
 static int can_umount(const struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
+	struct super_block *sb = path->dentry->d_sb;
 
 	if (!may_mount())
 		return -EPERM;
@@ -1995,7 +1996,7 @@ static int can_umount(const struct path *path, int flags)
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


