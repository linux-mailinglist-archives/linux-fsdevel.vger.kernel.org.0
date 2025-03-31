Return-Path: <linux-fsdevel+bounces-45361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29349A76802
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 16:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51FC77A134B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F30321A451;
	Mon, 31 Mar 2025 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB7WSdXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC12144C1;
	Mon, 31 Mar 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431554; cv=none; b=J3Fw1e6WJ1V1Z3ZUU6YGyAmKPw6BoyQahu3BI1EJq18Ege06gDftQc2ZFmJKmkf4w3qX2Q7Cttl9fllIu/a5B5Z55t6bClP+b64lVDJzBEuLkLgGTvN0+SkISxcJOoj7HUMu4GuQhsR97UKpJQFWmcv/pAggqjl/BK814NdUDy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431554; c=relaxed/simple;
	bh=NPMu5PMOc2IS2Cbsuk893FEO4aCVyIvnT+PYZF8LVlk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hSTJg9mS4+k4xzdCzjcxdHjyYGhEFClzKjVAdGOvYYR3j0edXkn+sfTbZX8UfZPo1FXaz5WXYRYfUOZGQzV+96pbJcDoM9mfseyVkuv0NwQd3lSkYm5l8dJvkHir73oFR8XZLnS6ZzC99KzFemX9hNbFUfp9GtkiK5Pyop0c8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB7WSdXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BCAC4CEE3;
	Mon, 31 Mar 2025 14:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431554;
	bh=NPMu5PMOc2IS2Cbsuk893FEO4aCVyIvnT+PYZF8LVlk=;
	h=From:To:Cc:Subject:Date:From;
	b=XB7WSdXpEpx65ST4Ebd3RbB1NORz4hTLN368ms92xvIS5Ao+xcHayd2cSCrIpsbbZ
	 QGcWvwnY8QiBOKpFrtJuJcQyygvipU0AOVWOIQ9CIy0Ot27kpCFuiC/okWJ0iQhu++
	 7HllqZFUdCr1wyxdIn8ACD4ao9CWO1KiHk0qqvtqiXHEWv0Jcuo9fhIcGKeUH0w/IF
	 rfB5pHqoCkcsbSfRjxs1XEMuLzMKmUlSFYG1IUyxJC0r7ULk+dlggu13S2Xprt4Cuv
	 XPdrCL//fAOt3YtWGtrckRllTVAj2Sn3ueedWlMYyYbNlRQRgZO2XS6MGj2uD1/H5d
	 5GzKntabjx36g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15] umount: Allow superblock owners to force umount
Date: Mon, 31 Mar 2025 10:32:31 -0400
Message-Id: <20250331143231.1667887-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index 22af4b6c737f4..642baef4d9aaa 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1734,6 +1734,7 @@ static void warn_mandlock(void)
 static int can_umount(const struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
+	struct super_block *sb = path->dentry->d_sb;
 
 	if (!may_mount())
 		return -EPERM;
@@ -1743,7 +1744,7 @@ static int can_umount(const struct path *path, int flags)
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


