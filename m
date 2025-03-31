Return-Path: <linux-fsdevel+bounces-45356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A571DA767F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 16:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6331887CDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4302153CE;
	Mon, 31 Mar 2025 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbWtXB/S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67F5215162;
	Mon, 31 Mar 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431543; cv=none; b=RfDNLZr/+QIY5Ho4snG9mV4NatgD1tFRJ/0OAD9gC+vGtRfghmiUncwFsj9OjP7ydF5SV20DDE9hRZAdBCeDlfJH7UTUm3sdeXGrRwaWIUTj3+LhkjEpOsxuRLdV5dcQreLjAKru4FUHYSMzINGLzkyWmT20qbLtQ8weeVY34qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431543; c=relaxed/simple;
	bh=gjstBgoYNngTYapNedrAIAnXCXDqbQuC/HvEERT0caU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AzEJoMSQLVD1m8ctPOkTxznFfkNpy6442hEC29UnV+LnhRq7l/Dn6L2uOyicx4AIrQ5E3uJ5/l0t5p/x91Ub9MhTmeA9Qf1NJEgDrYzHEd9UTY0Mg3jaCzOA/cz/kMpYJhq3UJo58n1UOTH9odS88wQaGof+DP/IYKhtkYnGlCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbWtXB/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AFDC4AF09;
	Mon, 31 Mar 2025 14:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431542;
	bh=gjstBgoYNngTYapNedrAIAnXCXDqbQuC/HvEERT0caU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BbWtXB/SDWZjQsgXkN7FRyqGwLFnkn3/he5/RO423Ntu1028lEoHbr7alluMaHkCw
	 RUtOGdD5CpdsRvXnEW788RRGNj3cbgIaEuy9ahpgLtlCLA5Fg0eBW1BPCUf3B81nHa
	 Z7fFAcy1koGeqjDwKmWYLdqleApxVs/vVVXSZvim2Lgn98sHZ8Pcni9hJ+szX70/ip
	 /cQbcx/uUHOyKOKhL31Mim9aJzlHM3KvLHtz/dJC593SqzsaZpdUCvD2OHLXMgJ4Z1
	 sXsJ94qSsfKDzYuWMlE710U2tg04PMwELOfmncicBfRJDGYMqK70q4twfyWM+1Hv3A
	 rnv+kRrU0hyZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 2/2] umount: Allow superblock owners to force umount
Date: Mon, 31 Mar 2025 10:32:18 -0400
Message-Id: <20250331143219.1667773-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143219.1667773-1-sashal@kernel.org>
References: <20250331143219.1667773-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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
index 73da51ac5a034..f898de3a6f705 100644
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


