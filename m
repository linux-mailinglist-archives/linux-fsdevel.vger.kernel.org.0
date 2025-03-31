Return-Path: <linux-fsdevel+bounces-45360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F58FA76801
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 16:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5EB164CD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1E4219A6B;
	Mon, 31 Mar 2025 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDIxCPZw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCA7219300;
	Mon, 31 Mar 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431551; cv=none; b=r6Ngz/Fg0DU9iH8mmTP3ah+uTvpzRXs44pHFOg4oIMPhqJu+7ybPaiQiV4bS4CuugZHrMYj+nJooVAuJmyMWNZuv9ySL0RdkhWhZmc5U1udjYHZhFM3+K7I+CMrWh8c6bgvVqXGba9XeSX6V6Kr+Xg/6LcyqcNmPhbFinvXzt8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431551; c=relaxed/simple;
	bh=HIP8+L21sV5JNynpivReBTt+q/+z9puyDqpDtq1H6W8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bgtYBipOLAx+fadHRBcT0fxht/dC5Al4ugJBduYNeCG0RNGqcATUqecFxMdnegeFLY8on/6Q1NMFzeArbQDSBfmrMKcH6yhJ05dBEzSnHaUKOD7GrCOKOZuJ1m/176Gvb1lRTNu3yxVyQzz+bkIqRL/KjHFEU7j5jv2ztra8EP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDIxCPZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571A9C4CEE9;
	Mon, 31 Mar 2025 14:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431551;
	bh=HIP8+L21sV5JNynpivReBTt+q/+z9puyDqpDtq1H6W8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TDIxCPZwKxza8onF4jkQT7cW9jBhTrkckkEsVjcozEusxJ9Z2l6HANgtUHjXOwpC8
	 5AD7vN9xgmeq6Tu0NL+uNH5HZ1F2IrnIBCOtie1vg2nGnV125Dn/A8omMKzbGBIqkA
	 VvW52p2JlMv7QIvDwOMzdjzgoYn6QUgzqsAfJe9FHOcVjS0g73UIpBho0/iV4n2n+H
	 8DussAiUEBsztbI7arX9iL1Kebevs1ejcs/atogXpLkSo9GJu1kYWD3teqF380OrFz
	 yT3DV8EC1+c3yqp0W20wf7rry4tH+lW2Z1UpuVfrICPL7ICEn3iwi61zZFij8ZPtxm
	 phAh2OoJYhDsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 2/2] umount: Allow superblock owners to force umount
Date: Mon, 31 Mar 2025 10:32:27 -0400
Message-Id: <20250331143227.1667849-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143227.1667849-1-sashal@kernel.org>
References: <20250331143227.1667849-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
index 59a9f877738b2..57166cc7e5117 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1777,6 +1777,7 @@ static void warn_mandlock(void)
 static int can_umount(const struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
+	struct super_block *sb = path->dentry->d_sb;
 
 	if (!may_mount())
 		return -EPERM;
@@ -1786,7 +1787,7 @@ static int can_umount(const struct path *path, int flags)
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


