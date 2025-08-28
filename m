Return-Path: <linux-fsdevel+bounces-59544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C017B3AE05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA5057A3827
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA3F2EACEF;
	Thu, 28 Aug 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="py/yyIjS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234DB2D12F3
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422492; cv=none; b=ULRxo2qzazNPAAwfEyguNLrxN1PyrN3JylPUU4JNm7Z2NtVZyHjGcWA7zIdZpL/t0KUvysO5a9nm2MPdko2leK/bkzYrjSehcCrMSY7NM46deYeItxRe0B2jH62oHKz5ewdjuFxMgdr0zou1D5NXtHc6TG69gwSuOQi+Qfughgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422492; c=relaxed/simple;
	bh=MXQWzuW1WmSeb9MPu7QtHMw+0vcfBwVX3xuPrCnkL5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0u9xg5dMZ6YL9/p4+8lHkptXoHHQm5bt8fU8MYuGPomCyFo8pmHjrIEnaYviupUXA3LdueD4SYdTPs6h0PwhvuSH2smdZxjF/wH98PLmgC2fJD0uCLeEY5EO/w6ao6TMmjaJ0ds8P3vo6Fs+JPk+lOZQsff3p94rUDTrAFupDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=py/yyIjS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0VkZeDTjynuJ95Jat/uo/FBXOaMJYoUoalB+0my5x9c=; b=py/yyIjSoyTjO7wKuFieNnHuK6
	VTLYWdA3JIP2ZD8pp1eqysafJZtYZIAjY9tdZddDEdhvKQ7If0n/Q3dq+HY7FxtPWSkmBG2eChT/f
	aGU44hjtZnlhDYbydbLxsCq+18McbWjcal0E+qO24GEAZQG935LpyY5AkNGxso5d99SgLXXXNGT+z
	Cu6qG/enKFyNxD4k/kxrad++J8Mch6YkFJ5Dtge21pHAqoEKgnJhr3NP+f5NWVeEwgUSde51c2gfK
	2fN6sWTVkIveYESeFBsy2Q17VwbJ2NYnjzFaEU9ZkfoDSgmzC6T0yT6+9scv32PKAmkl7AWtllRsn
	Qpx+c5xw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliy-0000000F232-2T1J;
	Thu, 28 Aug 2025 23:08:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 17/63] current_chrooted(): use guards
Date: Fri, 29 Aug 2025 00:07:20 +0100
Message-ID: <20250828230806.3582485-17-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

here a use of __free(path_put) for dropping fs_root is enough to
make guard(mount_locked_reader) fit...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index cf680fbf015e..0474b3a93dbf 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6194,23 +6194,20 @@ bool our_mnt(struct vfsmount *mnt)
 bool current_chrooted(void)
 {
 	/* Does the current process have a non-standard root */
-	struct mount *root = current->nsproxy->mnt_ns->root;
-	struct path fs_root;
-	bool chrooted;
+	struct path fs_root __free(path_put) = {};
+	struct mount *root;
 
 	get_fs_root(current->fs, &fs_root);
 
 	/* Find the namespace root */
-	read_seqlock_excl(&mount_lock);
 
+	guard(mount_locked_reader)();
+
+	root = current->nsproxy->mnt_ns->root;
 	while (unlikely(root->overmount))
 		root = root->overmount;
 
-	chrooted = fs_root.mnt != &root->mnt || !path_mounted(&fs_root);
-
-	read_sequnlock_excl(&mount_lock);
-	path_put(&fs_root);
-	return chrooted;
+	return fs_root.mnt != &root->mnt || !path_mounted(&fs_root);
 }
 
 static bool mnt_already_visible(struct mnt_namespace *ns,
-- 
2.47.2


