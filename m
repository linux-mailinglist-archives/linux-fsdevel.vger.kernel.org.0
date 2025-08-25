Return-Path: <linux-fsdevel+bounces-58920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1AEB3357E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39503A5E69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0542820CB;
	Mon, 25 Aug 2025 04:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YKbcVXNH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667D2777E5
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097041; cv=none; b=XrxrvuoVSyxL2q+82D547M3+Rnu9hJVD8/jmz9pgmr+d0jnFZ1ACuWXcE6fBHfg5Mjp7ldiyPVHCmpG3FJw04cSlVgboiwqlPs1TenLf0vxNRlsM8scfVr1KfsGS1edlJngOCDeedXngC7HIQ+SkF8Um+3QSWXfrSjt2azUG7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097041; c=relaxed/simple;
	bh=aiQC7wPd5DzaAbt5r8rpK7HO7RCjRtsV4qU29s+2K9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhWoUeDTN2g9HxCu3hNKbJ6TidrbqJzpciavhW+0KOGl/laq2uAzYuwyK07gsyBcv84oSMt+p6en5JSN1j8q5SGo3uSfoLGuEWWXUvLaI1YzQchCQ8LmAC1fccvSHbYrpVidZr8xcWlPZbdjMGvlRVhEs9fNmURjOfN7o4+sI9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YKbcVXNH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fFYXxfqIZOueQGFa1OIEmZtL+3/cX0/FHEvnRBb7Tys=; b=YKbcVXNHpJ7xzHrt31WaTxVr4D
	TG/QtWy8eWf8j0m6W3EnBcw0dfI4+fQthzQBfY2SkeoFQehEnWIOE6IRTP5Tx0Jv7WuvEegwHvx18
	VdegIB18ERWlhrJIWetYindhU6sDAv+H7kcvUQSpcyTgK68nyk6Go+opOcwwCO6Y1/O197ePCR5Si
	9Ns3XwO/x0IJfpn5+aJMTVij8gjEDLbEaf/LUPRA6h3qsUn/g8FTEwFey/y0xA+xPKzvxM+MHudVR
	uwNDIUyNGNKB3j0RJHCtNQ/veSo/7FoGpccFbJeDhmV5z/d/kcPX9MfIn1obfa4HV84UPmIBMH/cd
	odAEEDow==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3l-00000006TAU-1wNY;
	Mon, 25 Aug 2025 04:43:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 17/52] current_chrooted(): use guards
Date: Mon, 25 Aug 2025 05:43:20 +0100
Message-ID: <20250825044355.1541941-17-viro@zeniv.linux.org.uk>
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

here a use of __free(path_put) for dropping fs_root is enough to
make guard(mount_locked_reader) fit...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 107da30b408c..a8b586e635d8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6195,23 +6195,20 @@ bool our_mnt(struct vfsmount *mnt)
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


