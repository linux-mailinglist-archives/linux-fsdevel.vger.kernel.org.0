Return-Path: <linux-fsdevel+bounces-60056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43409B413C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5234D168677
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228FD2D6E72;
	Wed,  3 Sep 2025 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="neV/PGKv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D912D4B61
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875344; cv=none; b=ftUqZNEI6UcoYe+cfFH1gNVbNhSRFphON2prtPWmQ2z9MoNLCo9yapeYlQhjC5BLsqZJQPdnARFIJOXAfxxvx+to/XKXj0HtQVEAiGwAT7KxGV3Cbtj3w9ZSDUXUHeXHU94QblaSiJTDC/nFR6oreRWXQ1m0VYRsUWs5vNdjwgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875344; c=relaxed/simple;
	bh=gsSUOZw7jNMxBkUk+4lpSubWwvIP/F2PKDiEfZ3N5B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoZdWEL/Hoobh8yaPVdfCro3AtsjYEExDIxwMNHslEV1fAINtj+6Q9hCU4Xnz+CvWolzmOw5Kz/NH4FwNx+vWKmOWGBaxwj0jzbonNjZBtcuklP2y0CDWGiCL3GafFVMr6Tj3T71DU0Hj6970KnkGfjKUT8Iz8pxlMT0asvWtek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=neV/PGKv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZKWxMF9T2R2ZoDUVhm++vq7dmv8Wicqkw+jSTFohJJI=; b=neV/PGKv5jMIkDU81ApzmmAWDL
	YOCSKex5mb3CDIaiIuKqQHf0xyEkMfLtLFlHUyaElG/Ml+ljb4Ho2oY+nwdlAq+A6pRKE9PjgqvOZ
	p3vxWBZ33JXHmKdYhT1Go2x0NiDThDSjYwK2jpV4yJ2Rqp8fSs6tvCwd81gNiX9xQ8ppbZ+syrTAr
	sQ6gf66ooVHwyl8qkH7R8HvfOEJpIUmVN7G5X920GB2RfUvL2uMjPUCC3UIj8Il45tP3g75PZBZpw
	bd7TxYelxatmeXCJ6VXDU+SlwWL1uUEqV/1TRlIVxTEVb0LH9bh4l3sj4rPWJOAzVhWST9qooorqo
	Gp4nCazQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX2-0000000Ap7p-34Pi;
	Wed, 03 Sep 2025 04:55:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 16/65] current_chrooted(): don't bother with follow_down_one()
Date: Wed,  3 Sep 2025 05:54:37 +0100
Message-ID: <20250903045537.2579614-16-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

All we need here is to follow ->overmount on root mount of namespace...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 6aabf0045389..cf680fbf015e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6194,24 +6194,22 @@ bool our_mnt(struct vfsmount *mnt)
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


