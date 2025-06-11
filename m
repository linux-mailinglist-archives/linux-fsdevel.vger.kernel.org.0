Return-Path: <linux-fsdevel+bounces-51259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B25AD4D9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9F51BC055C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C49A247DEA;
	Wed, 11 Jun 2025 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="s2cH7oD8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA1F23E354
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628484; cv=none; b=geyLQP2Tr2R4gZcYa+/q2BcFQvSYdT7O7Un3LpGvsFFl7kRN9gvlsJ2nWeVDOh8bul+hcvOoedi5ZgV2JBIqMZ9mEKpOxRHDWkBqCZyFP0wR1/Xxb+MJd9vtUOzyZWRJ66LgM5IDXXuZGISw/4HpP+RYsNcZ5a65OqQgPB+Bvic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628484; c=relaxed/simple;
	bh=/BGgFpoezu5D4BuCbzArLHVIbEGBAop5P/JL/JHBYDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCYp4TeCL12Y+gH/3A9oVONaC+CSYfveVasEgj0PlTkWXPwTa8kk661PTG8YzgHg+hix3JDeBGcCKSWLf2UzxDU5qh8MxZvpfxZ85gvH5HEj/T+2FvnNOtwojdcLAVdf7ThB61Wtk4JJ1WQ2l56bv3h+8iF2qXHi9K5aSgYyRno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=s2cH7oD8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=A0TY7ZBjAdBHbqHXPXudjPIOd5hpPF19L5y1lM4xqbw=; b=s2cH7oD8wH8zm8W7g0Gt281w7j
	AjCS9vhe6t/sy8zxGeDKH0iTFcguAed7x1Cnkh0MS6ZsiSJWQaekM/iG5jjRhii2XYigGjs7OJfXF
	z2mu2ujvD7nmOzu50phqmR7qcx6n9Osf01Zg8xUk0rP4oMdI1SBbRqz/s545j7iG1kHJs4KBeqkNq
	j6j8KleIy7HhuxkgDnqGDBXLfsd0hvD22AdLDb76EAxmdq9ju6yrxlwa80fKluZKWzHjsVQeOvTQb
	SuOFKzoDl1qcCqoDs6sF3W5+pJg2gYyZuZbN3zXLrzPb/6R7vu6tpkU4/LJ15Q8l+uL0Fddhu/00I
	Clz24vxQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIC-0000000HU0E-40fA;
	Wed, 11 Jun 2025 07:54:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 20/21] configfs: use DCACHE_DONTCACHE
Date: Wed, 11 Jun 2025 08:54:36 +0100
Message-ID: <20250611075437.4166635-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
References: <20250611075023.GJ299672@ZenIV>
 <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/configfs/dir.c   | 1 -
 fs/configfs/mount.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index ebf32822e29b..f327fbb9a0ca 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -67,7 +67,6 @@ static void configfs_d_iput(struct dentry * dentry,
 
 const struct dentry_operations configfs_dentry_ops = {
 	.d_iput		= configfs_d_iput,
-	.d_delete	= always_delete_dentry,
 };
 
 #ifdef CONFIG_LOCKDEP
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 20412eaca972..740f18b60c9d 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -93,6 +93,7 @@ static int configfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	root->d_fsdata = &configfs_root;
 	sb->s_root = root;
 	set_default_d_op(sb, &configfs_dentry_ops); /* the rest get that */
+	sb->s_d_flags |= DCACHE_DONTCACHE;
 	return 0;
 }
 
-- 
2.39.5


