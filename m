Return-Path: <linux-fsdevel+bounces-58939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68F2B3357C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E6397A8ED3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D75285061;
	Mon, 25 Aug 2025 04:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="diierz5F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF2227FB12
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097044; cv=none; b=MbSXScHO0VJp1KArJwxk6M/1qCvgPdW3Usnm/EvLxPYDXN5HSJJuZvulSrKFy0xNUf6u6lJDnOoxkMSJzXvsNInj5wW0o+NeY5MDRDc/+loEtwA2Jp71EjV7d8oLUj/hhruRR4APcCFiYlQtgRD0Ar/f0WeH3gEel1u9+GPOt5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097044; c=relaxed/simple;
	bh=RaxYPsx3nkp/PC+l8fQBtuIvNUDy/tyRQYNrbP9g1zM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZtyPK2w6P+YAZyT9Zc2xga6jw+3Ef73tT79zB0FJNu2PXHZ/ZS/s/P5hQ7Kwyd/5NHXlW47kYjd19sq+RIoDpcHKBQkcDGxbhI/Gvsm5cZmtB/uoJNWX3j63TyVdhtKbi5oanmF8Fpys+/grMez/nq+8vkzKiLWp6ZRTBN7D9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=diierz5F; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TKt/Bmm7oD7C3aqhKkMoBeNDX5d15iC7vKTaa7ihrhc=; b=diierz5FPrMwBFMHCUjv7zn8Wx
	1ed3Mtf88KMB/FOt9gfdoRDXG7RQp/ULrWUagm+THffoRif+GpbCBdPVyrVfvjAgKyr6rknsYkyfI
	qyGh2Bktmr7Lq0UmIg90jlWbctLda1uQd76sky4a4UqkuuqedCQmykHX7gSfRCVKOmG0+jq+NO0xv
	mzJ50AucUeEkzA396I2oM1L7qTVlZkkGSyAkMpEdWm6z8Ac+/q5Ampouf++URy36+KAqyg55Vhint
	lQYEure+/9Y30Fh7bGEzcMWBcAIkDRcdn1GMWM7/sqtJpYecN6XYjuoYIkn2lJvEjvfxlN/OCg//s
	qanRZ1Tg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3o-00000006TEK-3UWV;
	Mon, 25 Aug 2025 04:44:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 40/52] do_move_mount(), vfs_move_mount(), do_move_mount_old(): constify struct path argument(s)
Date: Mon, 25 Aug 2025 05:43:43 +0100
Message-ID: <20250825044355.1541941-40-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index cc4e18040506..4704630847af 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3573,8 +3573,9 @@ static inline bool may_use_mount(struct mount *mnt)
 	return check_anonymous_mnt(mnt);
 }
 
-static int do_move_mount(struct path *old_path,
-			 struct path *new_path, enum mnt_tree_flags_t flags)
+static int do_move_mount(const struct path *old_path,
+			 const struct path *new_path,
+			 enum mnt_tree_flags_t flags)
 {
 	struct mount *old = real_mount(old_path->mnt);
 	int err;
@@ -3646,7 +3647,7 @@ static int do_move_mount(struct path *old_path,
 	return attach_recursive_mnt(old, &mp);
 }
 
-static int do_move_mount_old(struct path *path, const char *old_name)
+static int do_move_mount_old(const struct path *path, const char *old_name)
 {
 	struct path old_path;
 	int err;
@@ -4481,7 +4482,8 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	return ret;
 }
 
-static inline int vfs_move_mount(struct path *from_path, struct path *to_path,
+static inline int vfs_move_mount(const struct path *from_path,
+				 const struct path *to_path,
 				 enum mnt_tree_flags_t mflags)
 {
 	int ret;
-- 
2.47.2


