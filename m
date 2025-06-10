Return-Path: <linux-fsdevel+bounces-51143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B662AD3018
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CF63B6877
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541CC28469B;
	Tue, 10 Jun 2025 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oB3z944m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E528137F
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543716; cv=none; b=loHCSd7SdY/1TuKvK5MXVZiKf42aMxdMaDlgmchAYDwTOAtwxcpaOP5dS/Co2gSGIymlqs4lEXPCL9lah22wnTay2Kf1R41JIT4c1Ny2EQuxHoG3CABiYRFjmNHyUJPaQVwELjcr5IoAajq7ew6zXTNT85e6vfnm8hSLuh7DtWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543716; c=relaxed/simple;
	bh=yvljbmpM3HlEY/makqY5+PMnIJW5PG7qhzLxhwK4+l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnUriAoj5XOleBQcmlnrZqcRqZhUuMBwwXaH8Fy6EDiSgemNEIr4AXTiJ9LID/XMLKcbgRqXrX8NblcVTk1Sh4LpMrFbCxsfj3/94XzNxAJAK/G6kO8lZey5pNnIEky1e7Pr9pmpk7k9bzTaWBoqhPjtAEcLWdhCalOlRwJLzjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oB3z944m; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Np7Ij4Al7txwFN9eAdG6H57nh5HF9OtUV0a7Y/u7xxM=; b=oB3z944m/4w/f+SOB3DdYQlgP3
	9oXrULgIt8EbshKl+yc/yuVkr5Icuh3pUf1Pahu3MMgyzrr9sQTbyQiyqT1sa19WHPHLYVwA1n8J5
	JHevNfcOyEDHd9TuTMB0yD84kDGP+cmOTozFoGZRcUYUWofAqD4+VmMXYETpJgyY4sPHcZ8988yQf
	W0n+BfRQMC+GAd0dxm56rAS0kTtVNYPtDcBZJzdjX4EgpI906m8/w2Xn3HNUoHFqcV4mBa0SwUdX/
	2psmrQEEoX6OEZUWJjp+IA4ykmaH7ZU9a4e9GkDo/8+wPjSNfVgxR8e0T43PGxiHSMOiqhkibZkiK
	GX1hOOsw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEy-00000004jOE-08k4;
	Tue, 10 Jun 2025 08:21:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 20/26] do_move_mount(): get rid of 'attached' flag
Date: Tue, 10 Jun 2025 09:21:42 +0100
Message-ID: <20250610082148.1127550-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

'attached' serves as a proxy for "source is a subtree of our namespace
and not the entirety of anon namespace"; finish massaging it away.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5906ad173a28..7dffe9f71896 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3557,7 +3557,7 @@ static int do_move_mount(struct path *old_path,
 	struct mount *parent;
 	struct mountpoint *mp;
 	int err;
-	bool attached, beneath = flags & MNT_TREE_BENEATH;
+	bool beneath = flags & MNT_TREE_BENEATH;
 
 	mp = do_lock_mount(new_path, beneath);
 	if (IS_ERR(mp))
@@ -3566,7 +3566,6 @@ static int do_move_mount(struct path *old_path,
 	old = real_mount(old_path->mnt);
 	p = real_mount(new_path->mnt);
 	parent = old->mnt_parent;
-	attached = mnt_has_parent(old);
 	ns = old->mnt_ns;
 
 	err = -EINVAL;
@@ -3579,6 +3578,9 @@ static int do_move_mount(struct path *old_path,
 		/* ... and the target should be in our namespace */
 		if (!check_mnt(p))
 			goto out;
+		/* parent of the source should not be shared */
+		if (IS_MNT_SHARED(parent))
+			goto out;
 	} else {
 		/*
 		 * otherwise the source must be the root of some anon namespace.
@@ -3606,11 +3608,6 @@ static int do_move_mount(struct path *old_path,
 	if (d_is_dir(new_path->dentry) !=
 	    d_is_dir(old_path->dentry))
 		goto out;
-	/*
-	 * Don't move a mount residing in a shared parent.
-	 */
-	if (attached && IS_MNT_SHARED(parent))
-		goto out;
 
 	if (beneath) {
 		err = can_move_mount_beneath(old_path, new_path, mp);
@@ -3643,7 +3640,7 @@ static int do_move_mount(struct path *old_path,
 out:
 	unlock_mount(mp);
 	if (!err) {
-		if (attached) {
+		if (!is_anon_ns(ns)) {
 			mntput_no_expire(parent);
 		} else {
 			/* Make sure we notice when we leak mounts. */
-- 
2.39.5


