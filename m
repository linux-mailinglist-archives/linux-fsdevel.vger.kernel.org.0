Return-Path: <linux-fsdevel+bounces-60103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EB2B41401
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16387681716
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FD22DAFC8;
	Wed,  3 Sep 2025 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MurR8b0G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC32DBF6E
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875353; cv=none; b=nhkomOQqdkEoxtr0HenC0dTDpFdmfwlU9W0spjd+MNl3LcZ9XIQ+R+/v/X+dX05Y7o2tioUhO9bsaCsfuuTd4/8/A3/UGbjGEBpzYkEkF5sJcyVfERJ6EO3ewjhUW8ngvN95Q5YQIBA8xG2L2E3zkrdHf/TmFPKh4fIkgjk0DRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875353; c=relaxed/simple;
	bh=Yiw2TyTMTmUL/KpBFca6WTUb+2MRpPATc9Uy3CcKsIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8PVZ4GjGKaNcQxdveZq02Ev6yMmZ/F9MHBtDIP7/GgPrdvLI9e34mLxBpQ7Q4t0HTpTosBKNw2juxnGhB7dFchA4VJe5EyeBW3TFmy6JGA3krEm2RqbU69KTDdyw2QRM3UEvMyv5MGHlBPe5jbutMm5EanDDxT+DHITHeBxMVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MurR8b0G; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/B/2u76sugdG1BmybRjBnomgRnWYOIWHrYWn/8OMCNo=; b=MurR8b0G03HYe2wUhRz/AfmyKL
	+f2u021Bb0UD5GZLsRI7Yc7Ssienju/BcuG4aGLqL0/XHTYabkTURGpA59zzmf2HA+XTCPPnKqig5
	4jv1D1QvoNdAoJRjuzNllqprZfHt9NJeEif6bnUxPUYe664ZIurPwlUQx4qwP33z/opzcN17LfPij
	0y6/Q9s2BTBjPWqBnwlcQ6olCM1B6V4ROIjBQg8uuRzKolsCRmw540Yn3DuUrM6KqvRJNH/WTGbGw
	jxpo1OhuDEFwayZ57hKQ+HRMzYDtEWAJW8Ad6NXpJ5mjiaDEkPeo5N6o3TU318+RFmg0EMeBz2Y32
	2vCwb7HA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfXC-0000000ApI6-35yo;
	Wed, 03 Sep 2025 04:55:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 56/65] open_detached_copy(): separate creation of namespace into helper
Date: Wed,  3 Sep 2025 05:55:21 +0100
Message-ID: <20250903045537.2579614-60-viro@zeniv.linux.org.uk>
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

... and convert the helper to use of a guard(namespace_excl)

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 69ef608b8c3a..5b802cd33058 100644
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


