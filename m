Return-Path: <linux-fsdevel+bounces-60058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0455BB413D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFFEB681656
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C692D73A3;
	Wed,  3 Sep 2025 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FD692uAN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D82D540D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875344; cv=none; b=kJdKUmav0ih1fjJV1whSF1yjagatUpgVFhFgMUye+wsuEshl3qiPWPDCAckgGQyyFkrppAZAvtp4yTs1656eaRBjUu0tT0mZsp6XtpJFKHhDZEAwAWu6l+DNIP2EEl8jIgvq/It8vLDi3BNOBJIAPi5wh5wsYxBJz+AsX7l2FPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875344; c=relaxed/simple;
	bh=MXQWzuW1WmSeb9MPu7QtHMw+0vcfBwVX3xuPrCnkL5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aO2IATOxs/Fwtn4MUFrMo/k6dqycpWKsB9LT9dyr+IH8/93JFmmKKTFyLksB4Vp3PIa6yYbsgl9MbeKtKQlWDM5vijIoRhcs9u0eNTpBc9mmk/4BiGe74o6msAZjKIJuRiPv/i5/vZnfymQF2o67cCBl2Rm4eDyastWtS4DQcWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FD692uAN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0VkZeDTjynuJ95Jat/uo/FBXOaMJYoUoalB+0my5x9c=; b=FD692uANT/SNsdNmYmPfwjvKJX
	EVFBw6g0sPK7VSnBG+zqgfVEAZqOYvrDyud5i0K/fTjQwIImErraN/koxU3BJ8cOUPbQzMvsb/KrE
	wrlYiHZb6jyb80FscYq6CrOqp7I9DyZ0YQrFoQuzB/Pnve01P2YHC1++nOBuXjJf+RpfokfecvTxT
	U1P5/or3CLbKZA00l9Oejh4ci0UrnS7eYHGPbYG2NtjRlXm1ql3sBv4i+NSl/ghNFeYtYI4WRp7M8
	t5Jv6Kqi63zV0aJue4hwFy/U67FkSaM4iLBpaMmYVEpEGhiL61qnGkcmitXntqGuU7gGMrbKK5uuE
	2ZPCZIXw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX2-0000000Ap7x-3PxC;
	Wed, 03 Sep 2025 04:55:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 17/65] current_chrooted(): use guards
Date: Wed,  3 Sep 2025 05:54:38 +0100
Message-ID: <20250903045537.2579614-17-viro@zeniv.linux.org.uk>
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


