Return-Path: <linux-fsdevel+bounces-45352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B158A767E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 16:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84ECF3A34D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470422144CC;
	Mon, 31 Mar 2025 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uxbacla2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD7212FAC;
	Mon, 31 Mar 2025 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431536; cv=none; b=KphGZ/neY/AVQlSzfEByzKo5YOejQ7zOr5tBjo6jyzWKaK5RC/WneWKyTTxlOxibpYAWeuJrTemad5IFIRa/93NkIfjKjbQVwZiRoPoRET2dvINYZ/zpb/wWTXfDRNh16jK4DcsEVAoFuhWSMkBganCyBCCG/LlgnTeL2pj+LEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431536; c=relaxed/simple;
	bh=TgWhC3jL1Ynyv8LidwtUPqrQRKLG5DSk1rK1MM7zNHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DrVUzeemfxl7cpke8d0WH4ZHBQyS3SAmSyUmk/PtNhwilYLsIMq9TudD00VU2fsSgr1ZzlVmO6OBIrbNB8KVHdlC0D9HQd96VW38jGxIFbpgvB8PbuPI5fpcBiqbcXHBspc+qJWuXmZQKONEYwnuuuLgqbfoBb7y/fnpv5ucmwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uxbacla2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33865C4CEE9;
	Mon, 31 Mar 2025 14:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431534;
	bh=TgWhC3jL1Ynyv8LidwtUPqrQRKLG5DSk1rK1MM7zNHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uxbacla2bc9IRLmNDqcX/6vWWdz4zqfOUhz86+OO8V/9hVOrcigL71Gfc06eCMbba
	 aky+aHTvI8x29M2FEH3DtQylh8FEMrWH1G7FknGTOTWc5PGy30oHsr94zaBKnCYgJI
	 y2KpXuC4WYjerKIGWFXByVG7Nr1PnADkmSBdc1bnhl19Av689PWjhwyzpFyLONC6+B
	 D2wfIRaxrkU0T2sX+yUjtj6Em2ryUw/2tbEgr/t6XW5o5LjyiddOVJmyAx/lf+RArM
	 79YVqHCCMrDE0cgNdSRrtM+iBexmHCV267iQJQbgsehxVWvpW0/hFJC9cbtoXfHtT5
	 vw8P017kDzhfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 2/2] umount: Allow superblock owners to force umount
Date: Mon, 31 Mar 2025 10:32:10 -0400
Message-Id: <20250331143210.1667697-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143210.1667697-1-sashal@kernel.org>
References: <20250331143210.1667697-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index 8f1000f9f3df1..d401486fe95d1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2026,6 +2026,7 @@ static void warn_mandlock(void)
 static int can_umount(const struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
+	struct super_block *sb = path->dentry->d_sb;
 
 	if (!may_mount())
 		return -EPERM;
@@ -2035,7 +2036,7 @@ static int can_umount(const struct path *path, int flags)
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


