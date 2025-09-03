Return-Path: <linux-fsdevel+bounces-60108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E8CB41406
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61319681AF8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EAD2DD5F6;
	Wed,  3 Sep 2025 04:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mDUO6ePg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB92DC33F
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875355; cv=none; b=uavMImxw9Xi5vBXjeUiHfJsp3PgZYvi23qU3517TdNx/dom45cZYHNLIvxN+kOeOMzU+0ltH75yAuRfG447pVVQxbY2EEgY3/io43EDSB7OiNhVZbodts71hdHunGbO4wnU3hJBfoNV8j289PE+e1D4vM1uQ4F3rqea8S4nhLwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875355; c=relaxed/simple;
	bh=qH03pntXnGzcVm/njRtWz4TUOGhn3Wy00Q0HS4U92Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TieHpgUWowKjCXEyuMCfnrRgetYMnUEvYDgd2CEYLTVK5H4iwVu+VXXTeerrwxT/I59eCrb8AnUmke65J++huEnDqD9rVkZOaRgRnbMvbdX/Sdfa6BOl5rDUVJ3txibkMtg2XDHEZu7FwmccPfqmlQDubV+tKXu/K1+HgvQeOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mDUO6ePg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fNHznvV8XR8NSXqXSIjna0li0Du3XjdbFCNokJahI4E=; b=mDUO6ePg7TezA85qPCsLKJzed9
	BbvbtL0gyORRCj1qLlRUhmSGZte3VAG6l+iCV5szrnBsKoGu3qJ9LAFT5ZcLfvw+F483tpfydGWXm
	1wh4jJY6WiNtOkH4OGgFe9YEMAWE/Ccsec0/HG2cBkfFnHnstZWqIZT+ShprX3nIrXMJMELZfcY7Y
	rjuGvRhmjeLylK7VR7VdJW9B79x3342xjf4qL/vl2ab9o8W/eaKmlzawfXSTvp6QVym6OegTZZWNy
	mMQAQuWAga6eQCFdSDpeLhdPvPXicJ2EllGT6zTr6fz1KJAsussDPqXO5U4JT69i7R5y8yCCG9ygh
	PDNZvKWw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfXE-0000000ApJY-0BxW;
	Wed, 03 Sep 2025 04:55:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 59/65] copy_mnt_ns(): use guards
Date: Wed,  3 Sep 2025 05:55:26 +0100
Message-ID: <20250903045537.2579614-65-viro@zeniv.linux.org.uk>
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

* mntput() of rootmnt and pwdmnt done via __free(mntput)
* mnt_ns_tree_add() can be done within namespace_excl scope.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 0cd62478ff36..3bb9f7ac4be6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4164,7 +4164,8 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 		struct user_namespace *user_ns, struct fs_struct *new_fs)
 {
 	struct mnt_namespace *new_ns;
-	struct vfsmount *rootmnt = NULL, *pwdmnt = NULL;
+	struct vfsmount *rootmnt __free(mntput) = NULL;
+	struct vfsmount *pwdmnt __free(mntput) = NULL;
 	struct mount *p, *q;
 	struct mount *old;
 	struct mount *new;
@@ -4183,7 +4184,7 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	if (IS_ERR(new_ns))
 		return new_ns;
 
-	namespace_lock();
+	guard(namespace_excl)();
 	/* First pass: copy the tree topology */
 	copy_flags = CL_COPY_UNBINDABLE | CL_EXPIRE;
 	if (user_ns != ns->user_ns)
@@ -4191,13 +4192,11 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
 		emptied_ns = new_ns;
-		namespace_unlock();
 		return ERR_CAST(new);
 	}
 	if (user_ns != ns->user_ns) {
-		lock_mount_hash();
+		guard(mount_writer)();
 		lock_mnt_tree(new);
-		unlock_mount_hash();
 	}
 	new_ns->root = new;
 
@@ -4229,13 +4228,6 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 		while (p->mnt.mnt_root != q->mnt.mnt_root)
 			p = next_mnt(skip_mnt_tree(p), old);
 	}
-	namespace_unlock();
-
-	if (rootmnt)
-		mntput(rootmnt);
-	if (pwdmnt)
-		mntput(pwdmnt);
-
 	mnt_ns_tree_add(new_ns);
 	return new_ns;
 }
-- 
2.47.2


