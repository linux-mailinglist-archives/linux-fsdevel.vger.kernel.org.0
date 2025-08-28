Return-Path: <linux-fsdevel+bounces-59580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC30B3AE34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0141C81650
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C722FE069;
	Thu, 28 Aug 2025 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gvpLzDlR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F5E2F39B9
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422498; cv=none; b=HzBSDddDPm7gw8Yk6Ha8BRCPk/3alKtiFL5I22DhmWMepM4ncwdpo1/TM+03jEyjrQkgXx1OcX5duOeG+zWV7nYcwEfK6+/sABqBnZAhzeZ4zj93XkOKj2Sl6AIhWemdfTilVtv4TI6MYQVGf5ANmRT6Ixa18Q5DaGvQ4nmDlt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422498; c=relaxed/simple;
	bh=AWKT5TO3rj65ElYFdHFErd8GhWFRVbcnGhf3BEGojK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUrFd0o2UvF9mhT9MlgTCa3DyRygXEPAh4Zkq7PzU48hZsXAMc8njZ09p4WebRRwM/Sxrvph3cx7Ml5l5/Z7NOmrxfH/oIVUcmMrvBgWdQf31YhULRqL2oYF0AkjhiPcQUiQljFOFLKxzar8OC8CC1304IBr/lV6iqQpanfWUh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gvpLzDlR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mBJ39pTgXzz6+vZIEIUrtF43nm61CQa/M7x1BsHuZfE=; b=gvpLzDlRnrbeERi53EYHl4O9dw
	HXTy7kxYSuvE4ESKDmR4qoSxKOcQ4t9FTcQoD+fgenN2Q0O+VxyQm+tP44JIuo2Eyxa4meSvuV5zM
	xZTkGWJbLitkahKEwbhSbF9XZ7GBVAvCOt5ONAHHRclQsEu3OtF7dAM8wEGfpI+LtnYAPdSX9y9bf
	A1L1LtQV0NVaIfIamFttm6UHa61OyxpgeH8PHvmdcJf3QSc0xtr7ZfsMPbDE6p/YoxYCuUL5WzhqN
	lgC/+CQtFvjCPTeYFkyFmkkX1WbSLFn/1pSLCLsIi0Obf+1dW7lVXcZUoj+ZDUy0mKzWoEyiz6fet
	Uj5RFKog==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj4-0000000F2AD-2WF8;
	Thu, 28 Aug 2025 23:08:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 55/63] open_detached_copy(): separate creation of namespace into helper
Date: Fri, 29 Aug 2025 00:07:58 +0100
Message-ID: <20250828230806.3582485-55-viro@zeniv.linux.org.uk>
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

... and convert the helper to use of a guard(namespace_excl)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 425c33377770..c324800e770c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3053,18 +3053,17 @@ static int do_loopback(const struct path *path, const char *old_name,
 	return err;
 }
 
-static struct file *open_detached_copy(struct path *path, bool recursive)
+static struct mnt_namespace *get_detached_copy(const struct path *path, bool recursive)
 {
 	struct mnt_namespace *ns, *mnt_ns = current->nsproxy->mnt_ns, *src_mnt_ns;
 	struct user_namespace *user_ns = mnt_ns->user_ns;
 	struct mount *mnt, *p;
-	struct file *file;
 
 	ns = alloc_mnt_ns(user_ns, true);
 	if (IS_ERR(ns))
-		return ERR_CAST(ns);
+		return ns;
 
-	namespace_lock();
+	guard(namespace_excl)();
 
 	/*
 	 * Record the sequence number of the source mount namespace.
@@ -3081,8 +3080,7 @@ static struct file *open_detached_copy(struct path *path, bool recursive)
 
 	mnt = __do_loopback(path, recursive);
 	if (IS_ERR(mnt)) {
-		namespace_unlock();
-		free_mnt_ns(ns);
+		emptied_ns = ns;
 		return ERR_CAST(mnt);
 	}
 
@@ -3091,11 +3089,19 @@ static struct file *open_detached_copy(struct path *path, bool recursive)
 		ns->nr_mounts++;
 	}
 	ns->root = mnt;
-	mntget(&mnt->mnt);
-	namespace_unlock();
+	return ns;
+}
+
+static struct file *open_detached_copy(struct path *path, bool recursive)
+{
+	struct mnt_namespace *ns = get_detached_copy(path, recursive);
+	struct file *file;
+
+	if (IS_ERR(ns))
+		return ERR_CAST(ns);
 
 	mntput(path->mnt);
-	path->mnt = &mnt->mnt;
+	path->mnt = mntget(&ns->root->mnt);
 	file = dentry_open(path, O_PATH, current_cred());
 	if (IS_ERR(file))
 		dissolve_on_fput(path->mnt);
-- 
2.47.2


