Return-Path: <linux-fsdevel+bounces-59581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ED7B3AE35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6BC71C808BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FCC2D12F3;
	Thu, 28 Aug 2025 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="u9BGTs79"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D502F49F6
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422498; cv=none; b=H60hB3q9SONHq3tEwAgKWCXQ5P43YRE98/IyGX5SU0cyUP781rlz24goki2bsqqjg409WhYe1pE3/Vn+WjQ5834UTQXibItcj/Iiqi+VrXa1kBjEtHMLezQQzlbWSpqs8oTGazI/n1RGClGqgzN98706QBPeokIoFvw7djcoCKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422498; c=relaxed/simple;
	bh=OWMLw4YdOxwArhH5ptjh5FAuIjFgvA+oO8InG/MmvPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhSu5oWdLomyYAcqMXQmvg1o87//61HHHLnwGuX7X3jo81896Bj2pw3kYzZqDh6uZeNPo/jIBHx60RljbRKNhdg5dmI2HzgTUldODjrAuaGzBfUBBhJbgl0iTv8ulo3MZu4Aza3RZ3sDQp6Yz8Tsl/0/LTcJ8dzeNFsQtlG9JBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=u9BGTs79; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mW1NMWRqf505Y5qJGtZXSLWDh1azLSpJjLOkVFR0zo4=; b=u9BGTs79jKE2N3h1DpipWing2j
	bqB5/7Z8k+VHxmc1NRR8YNNj87tp6Uim1NN6EAaayMIUTSiYI5y5o0Hsk4p8oP5ImilFoWD91EH9y
	tF7yoCaSjJSW4NNAg6IRtjm6v0ebGAkOPWDoK1hYmRaPnripG+GpmU0ylOFBA2ho4k8rYK2Y5RlEC
	4dQJR6jB3gdVWNw4ENmolTF2AZg7PBYBgCPw6ukiWi/aJ8eRq0dKAcDMeUKMRMVORca2VoJ+zj5Yb
	vew/846sQFpoP2g6Le1GtqwTvjHNg3z69l66VjlnDFi2scUNk9gJvsCox8zOjFbU55lf4amoZwuAi
	QccvDhYg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj4-0000000F2Ah-448W;
	Thu, 28 Aug 2025 23:08:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 58/63] copy_mnt_ns(): use guards
Date: Fri, 29 Aug 2025 00:08:01 +0100
Message-ID: <20250828230806.3582485-58-viro@zeniv.linux.org.uk>
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

* mntput() of rootmnt and pwdmnt done via __free(mntput)
* mnt_ns_tree_add() can be done within namespace_excl scope.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a418555586ef..9e16231d4561 100644
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
 
@@ -4229,14 +4228,6 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
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
-	mnt_ns_tree_add(new_ns);
 	return new_ns;
 }
 
-- 
2.47.2


