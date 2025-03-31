Return-Path: <linux-fsdevel+bounces-45358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B049FA767FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 16:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D0F1885A1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5739B216E23;
	Mon, 31 Mar 2025 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mU/UswAK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0847215F7F;
	Mon, 31 Mar 2025 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431547; cv=none; b=Cv7v6k1JGqU8FgdW/ytm6mkUyaR4E+TwgaRgpmJQ9ktTqZmUV7X2yljz0j2nQD4YhfGrbX3NVA4wvwnst6Ahq6yMBMhZ2w0H6+cvW5eImB0XBL5HagliRBs7Uv7yikB4SwVBUIk+1lKi+2kBIRBSCIys2vwJl34SnZzC8bSeZSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431547; c=relaxed/simple;
	bh=nfOJ7M6/DsjiaF56Sd22XSbBYSAea00dkazAji2TdN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KcizFfxQ+McGXewvpjM3Gab7P6DeTKU1novE4vIiadSHrp8K518wDUEuC3SYuGpctyxqDmoD/xNnr/ZaTVCEs4KI++G4fBCwZVudI1Xoz6zTtmvNg/PzUqtSgtHdJ99oh0GzIwcSI2w0t5xtS6JOeyRtZyas7sLCXklAW5rd3Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mU/UswAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD07C4CEE4;
	Mon, 31 Mar 2025 14:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431547;
	bh=nfOJ7M6/DsjiaF56Sd22XSbBYSAea00dkazAji2TdN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mU/UswAKc5ibZwyp4dt8F562HmseM0wY5Gr7M680ZZhNDFTm/k9SxpFKnYGcvol4b
	 Mx50s7MvFbSN07XEtwBh0eJn0UjNwnRrWjM5VLVxp17kQ8y/SADn8jfxMSyg2uUPd9
	 TY+jRz6qNGycAvljI8do5HahHKb9zxjZwj+O0vmOTN0x6SpRWu/amtuAzkCSNCM5Qr
	 pe6nCWaJiKaj2o3JSPk2Vu64XytrpPZ8JE8vHg7ve34niH9pGmdrTPz/qdBTT4UOXg
	 2SK9mQMOJEQuZtYYSS6MgBWpVdLlaJlEVoP4YbRQ6KhqJicsjyRGPvDq/updVK9MEr
	 AarmaJaCKvJMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 2/2] umount: Allow superblock owners to force umount
Date: Mon, 31 Mar 2025 10:32:23 -0400
Message-Id: <20250331143223.1667811-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143223.1667811-1-sashal@kernel.org>
References: <20250331143223.1667811-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index b4385e2413d59..671e266b8fc5d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1869,6 +1869,7 @@ static void warn_mandlock(void)
 static int can_umount(const struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
+	struct super_block *sb = path->dentry->d_sb;
 
 	if (!may_mount())
 		return -EPERM;
@@ -1878,7 +1879,7 @@ static int can_umount(const struct path *path, int flags)
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


