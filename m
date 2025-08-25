Return-Path: <linux-fsdevel+bounces-58917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289B0B33576
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A2117C267
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5504A27FB0E;
	Mon, 25 Aug 2025 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DFoDXuJx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68BE270551
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097041; cv=none; b=XiOvi2pAf1R+/NHfs9BdgdealUU7InXZNdf+DXdd+75HoDh7sFkRD8liZihxKsCDEsmVOUs3Ju4/tNMHqEhChzBfknIoiF9PDGipZ7zH1bjrO78ebzvLpPVCmMXENQfi3rulShdwnc54+hRpsEismvAhV1J4XUUYuAIkuAhR0Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097041; c=relaxed/simple;
	bh=PnZN9wCvx4FdCym+pYNmJxrHqHIJRLI9gdWIStolvm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXAI/bDKeS1+XIXm0ElkyseuF9SU/eHni/UWQEpW8Gdmwp/EMwoJ/Gi6a1FgE1XuqBfwc8DGunl79gk84mJ+EhQpPYwdhzNRAa1AjV7pSy+v5phoZQK02NKRcSpDok6Zh5w/W17ufhHtBMbc1ueP/gTmprYz1QiK/fdhqTOSbOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DFoDXuJx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=N5Dx+VVr1bvuW0TalWYZ20+SDWmNhn6vrjGupbUX5QU=; b=DFoDXuJxSQOl3dPbQuTqdi2ci5
	XShvm5VNZxM8AKcFCrESGCfmh0g0rA+HoCm1y2hQBaaqHNx5OPd/2JnX6TPF3QmyChrwO+Y2vVFLY
	iIZ+sLM5BXlMF18Ce2Re5N0ZOGveAGc2mJh0IG9wto2rCKfaNmA5jIYZdbIqsqx+vwr7Zmt8Kig1i
	l8CMQh9GXF4rONn+/c6xVJf+No47vAvJ1iRHsuhzQOkXNl2R+j3pNSG0SA/hc5fhbrtYvluABepyf
	PEElIY2MklTvsra/iZEZ65crSirbHz1eu1JGRPKRgVmEPZ6Arc93HRpLCOjZU8MDm7lSeiso98bcH
	k6Og4oDw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3l-00000006TAN-1iRo;
	Mon, 25 Aug 2025 04:43:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 16/52] current_chrooted(): don't bother with follow_down_one()
Date: Mon, 25 Aug 2025 05:43:19 +0100
Message-ID: <20250825044355.1541941-16-viro@zeniv.linux.org.uk>
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

All we need here is to follow ->overmount on root mount of namespace...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index bf9a3a644faa..107da30b408c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6195,24 +6195,22 @@ bool our_mnt(struct vfsmount *mnt)
 bool current_chrooted(void)
 {
 	/* Does the current process have a non-standard root */
-	struct path ns_root;
+	struct mount *root = current->nsproxy->mnt_ns->root;
 	struct path fs_root;
 	bool chrooted;
 
+	get_fs_root(current->fs, &fs_root);
+
 	/* Find the namespace root */
-	ns_root.mnt = &current->nsproxy->mnt_ns->root->mnt;
-	ns_root.dentry = ns_root.mnt->mnt_root;
-	path_get(&ns_root);
-	while (d_mountpoint(ns_root.dentry) && follow_down_one(&ns_root))
-		;
+	read_seqlock_excl(&mount_lock);
 
-	get_fs_root(current->fs, &fs_root);
+	while (unlikely(root->overmount))
+		root = root->overmount;
 
-	chrooted = !path_equal(&fs_root, &ns_root);
+	chrooted = fs_root.mnt != &root->mnt || !path_mounted(&fs_root);
 
+	read_sequnlock_excl(&mount_lock);
 	path_put(&fs_root);
-	path_put(&ns_root);
-
 	return chrooted;
 }
 
-- 
2.47.2


