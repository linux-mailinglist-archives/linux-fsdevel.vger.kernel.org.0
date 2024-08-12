Return-Path: <linux-fsdevel+bounces-25643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8E494E709
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D7F1F210AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E871607A0;
	Mon, 12 Aug 2024 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WUq2OssD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C94152DF5
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445072; cv=none; b=KRA3w0e4tRcmt5bxJCqY5oukvEX80dUi/4pFVQTwDyZL2cNffYkjyz0UswOAdQM08PHI0Jz1t4++tG2PhgqnbsN7gMlQWf3jMjIBZWn8RtL2FfCLvR8ACioICeii9qmJ8gz7jGcngLphKMjOt3F2lo+b0v0yu0B0qih2fs70P/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445072; c=relaxed/simple;
	bh=+RpMTmmO7c3bUnDElBDipk4sspVP+DpZqrtJtd2P6BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vv3jAdn3xm3jUn0/lmAh6O+r19Ns9iBH4JCg8zT4DgBTlsBee/O6wA+8QOolxCJRUMMnHnJ69mgL1PSfBfXjH5ulkddTyW3laUenbDCqKuFJSjUkrzc9gs9SNgN/u+hwDnJ1KV4LFdNT5SHaYaDk2tPa78oLt3gyzghKtnLW4ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WUq2OssD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=99b7UZHUl91kNq0APruQ+TjL5+upTiM8P8+AlXXDai0=; b=WUq2OssD2ARl035NDXquR6j00h
	9mJRdBUjR9MCSzOYy2QWAyl/pZmAp5r1w/alkZuA2EO2yl/v1ShonFiqiPjecIRg5vII8z/qryPA7
	qOPxEt750qDlA25EX39HoU1EqLv5wNPvjgXHmW2PZyaJkDinfTlx3zto5gLCxujOtdHTgExXvt8dM
	+v5HsuXC/ofT/ssZ1paVWeSVE57jfpbUf/SHmGF6IirBh71no7ewtcVd+0+CUX0Oe7mvglzAUcR4j
	JTt7knZzWAbAdJvl79k00YGlNyYyNkJRrHzq0cuL/9ECvaYO35Z+s3s70kBhL1G+q811CgctBj28d
	KFVAo+yw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdOn6-000000010VC-3iX4;
	Mon, 12 Aug 2024 06:44:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/11] dup_fd(): change calling conventions
Date: Mon, 12 Aug 2024 07:44:27 +0100
Message-ID: <20240812064427.240190-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812064427.240190-1-viro@zeniv.linux.org.uk>
References: <20240812064214.GH13701@ZenIV>
 <20240812064427.240190-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

return ERR_PTR() on failure, get rid of errorp

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c               | 14 ++++----------
 include/linux/fdtable.h |  2 +-
 kernel/fork.c           | 26 ++++++++++++--------------
 3 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 01cef75ef132..b8b5b615d116 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -306,17 +306,16 @@ static unsigned int sane_fdtable_size(struct fdtable *fdt, unsigned int max_fds)
  * passed in files structure.
  * errorp will be valid only when the returned files_struct is NULL.
  */
-struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int *errorp)
+struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds)
 {
 	struct files_struct *newf;
 	struct file **old_fds, **new_fds;
 	unsigned int open_files, i;
 	struct fdtable *old_fdt, *new_fdt;
 
-	*errorp = -ENOMEM;
 	newf = kmem_cache_alloc(files_cachep, GFP_KERNEL);
 	if (!newf)
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	atomic_set(&newf->count, 1);
 
@@ -346,8 +345,8 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 
 		new_fdt = alloc_fdtable(open_files);
 		if (IS_ERR(new_fdt)) {
-			*errorp = PTR_ERR(new_fdt);
-			goto out_release;
+			kmem_cache_free(files_cachep, newf);
+			return ERR_CAST(new_fdt);
 		}
 
 		/*
@@ -388,11 +387,6 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 	rcu_assign_pointer(newf->fdt, new_fdt);
 
 	return newf;
-
-out_release:
-	kmem_cache_free(files_cachep, newf);
-out:
-	return NULL;
 }
 
 static struct fdtable *close_files(struct files_struct * files)
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 42cadad89f99..b1a913a17d04 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -102,7 +102,7 @@ struct task_struct;
 
 void put_files_struct(struct files_struct *fs);
 int unshare_files(void);
-struct files_struct *dup_fd(struct files_struct *, unsigned, int *) __latent_entropy;
+struct files_struct *dup_fd(struct files_struct *, unsigned) __latent_entropy;
 void do_close_on_exec(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
diff --git a/kernel/fork.c b/kernel/fork.c
index cc760491f201..67ab37db6400 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1754,33 +1754,30 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
 		      int no_files)
 {
 	struct files_struct *oldf, *newf;
-	int error = 0;
 
 	/*
 	 * A background process may not have any files ...
 	 */
 	oldf = current->files;
 	if (!oldf)
-		goto out;
+		return 0;
 
 	if (no_files) {
 		tsk->files = NULL;
-		goto out;
+		return 0;
 	}
 
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
-		goto out;
+		return 0;
 	}
 
-	newf = dup_fd(oldf, NR_OPEN_MAX, &error);
-	if (!newf)
-		goto out;
+	newf = dup_fd(oldf, NR_OPEN_MAX);
+	if (IS_ERR(newf))
+		return PTR_ERR(newf);
 
 	tsk->files = newf;
-	error = 0;
-out:
-	return error;
+	return 0;
 }
 
 static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
@@ -3236,13 +3233,14 @@ int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
 	       struct files_struct **new_fdp)
 {
 	struct files_struct *fd = current->files;
-	int error = 0;
 
 	if ((unshare_flags & CLONE_FILES) &&
 	    (fd && atomic_read(&fd->count) > 1)) {
-		*new_fdp = dup_fd(fd, max_fds, &error);
-		if (!*new_fdp)
-			return error;
+		*new_fdp = dup_fd(fd, max_fds);
+		if (IS_ERR(*new_fdp)) {
+			*new_fdp = NULL;
+			return PTR_ERR(new_fdp);
+		}
 	}
 
 	return 0;
-- 
2.39.2


