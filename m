Return-Path: <linux-fsdevel+bounces-26586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C3595A8BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD2DB22355
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B9D1078B;
	Thu, 22 Aug 2024 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TjXGozMV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B1524F
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286174; cv=none; b=RKE6vqU6tWpQpJUZrNMYaw1tsQseQqSBeKyZ1p8d+8dvsDF/h/t9dSjPoEAqMNkGJv7Wr1q4Jj78vKlrrgHyJntaaC8yrHKZrqVve6TKUFA5EsIcZU8ZLo0nZ46xyHdlVYGMwxGzFqhwwxlB1n9eghCU7Fn4qp+HQQENu176i8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286174; c=relaxed/simple;
	bh=HP33SVmFHfIeP+Uy2Wk8Im96EGi/oNzTnNY9Z6ZfqvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbJw1pojYAxcoaiJlScka1WRM+klu2V791sUT4pjbvnLv5Z/bwUISFzbhsJRMdsClOaSv8/iWUXsN0AD2VRBxR1MysgzkWFBHoz1v05lq+yvh9Ci30Y0+xLVR64sT8EFIvFAIOaLS+1I8SF1jJckQWgVBG/pHnC2K153JMhcaOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TjXGozMV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zY55Tg3z8MSilH32l4DJcduxOjnlWV57aFoujWq9BV8=; b=TjXGozMVnb8kEBHWu8UH1ELMd6
	SmIe4fwADLixT6ngeQRGTk5Ok8igGfbr1o/E59gv358umdfUBjhVEfeJFBR+Fn6/o56ol3TewT0eZ
	7Qao9g5zF+K1IYWEevQHb5fAxfsQnHwJ1XDEoZdvsSgHnj5L04ysfncZhIRiylDKxQ98j/vUKeifX
	QCLLA382ArdvcnInwMEfHwyzJ+1WZm2JpmtEVH9Te3xJgF7RoOr6x1oVF0okrBOEAicPCqxqW8JCS
	TD+ApaUaJIZvx2oJdxzV5BIwlX4AluNbP7iHgj0AGYxIgQydPaU1WjBonOpjewrDG9GJPWDi8Acxy
	9aNFRvig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvbH-00000003w89-1N8P;
	Thu, 22 Aug 2024 00:22:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 09/12] alloc_fdtable(): change calling conventions.
Date: Thu, 22 Aug 2024 01:22:47 +0100
Message-ID: <20240822002250.938396-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822002250.938396-1-viro@zeniv.linux.org.uk>
References: <20240822002012.GM504335@ZenIV>
 <20240822002250.938396-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

First of all, tell it how many slots do we want, not which slot
is wanted.  It makes one caller (dup_fd()) more straightforward
and doesn't harm another (expand_fdtable()).

Furthermore, make it return ERR_PTR() on failure rather than
returning NULL.  Simplifies the callers.

Simplify the size calculation, while we are at it - note that we
always have slots_wanted greater than BITS_PER_LONG.  What the
rules boil down to is
	* use the smallest power of two large enough to give us
that many slots
	* on 32bit skip 64 and 128 - the minimal capacity we want
there is 256 slots (i.e. 1Kb fd array).
	* on 64bit don't skip anything, the minimal capacity is
128 - and we'll never be asked for 64 or less.  128 slots means
1Kb fd array, again.
	* on 128bit, if that ever happens, don't skip anything -
we'll never be asked for 128 or less, so the fd array allocation
will be at least 2Kb.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c | 75 +++++++++++++++++++++----------------------------------
 1 file changed, 29 insertions(+), 46 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index b94ee8270867..4fbd4e323f6c 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -89,18 +89,11 @@ static void copy_fdtable(struct fdtable *nfdt, struct fdtable *ofdt)
  * 'unsigned long' in some places, but simply because that is how the Linux
  * kernel bitmaps are defined to work: they are not "bits in an array of bytes",
  * they are very much "bits in an array of unsigned long".
- *
- * The ALIGN(nr, BITS_PER_LONG) here is for clarity: since we just multiplied
- * by that "1024/sizeof(ptr)" before, we already know there are sufficient
- * clear low bits. Clang seems to realize that, gcc ends up being confused.
- *
- * On a 128-bit machine, the ALIGN() would actually matter. In the meantime,
- * let's consider it documentation (and maybe a test-case for gcc to improve
- * its code generation ;)
  */
-static struct fdtable * alloc_fdtable(unsigned int nr)
+static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
 {
 	struct fdtable *fdt;
+	unsigned int nr;
 	void *data;
 
 	/*
@@ -108,22 +101,32 @@ static struct fdtable * alloc_fdtable(unsigned int nr)
 	 * Allocation steps are keyed to the size of the fdarray, since it
 	 * grows far faster than any of the other dynamic data. We try to fit
 	 * the fdarray into comfortable page-tuned chunks: starting at 1024B
-	 * and growing in powers of two from there on.
+	 * and growing in powers of two from there on.  Since we called only
+	 * with slots_wanted > BITS_PER_LONG (embedded instance in files->fdtab
+	 * already gives BITS_PER_LONG slots), the above boils down to
+	 * 1.  use the smallest power of two large enough to give us that many
+	 * slots.
+	 * 2.  on 32bit skip 64 and 128 - the minimal capacity we want there is
+	 * 256 slots (i.e. 1Kb fd array).
+	 * 3.  on 64bit don't skip anything, 1Kb fd array means 128 slots there
+	 * and we are never going to be asked for 64 or less.
 	 */
-	nr /= (1024 / sizeof(struct file *));
-	nr = roundup_pow_of_two(nr + 1);
-	nr *= (1024 / sizeof(struct file *));
-	nr = ALIGN(nr, BITS_PER_LONG);
+	if (IS_ENABLED(CONFIG_32BIT) && slots_wanted < 256)
+		nr = 256;
+	else
+		nr = roundup_pow_of_two(slots_wanted);
 	/*
 	 * Note that this can drive nr *below* what we had passed if sysctl_nr_open
-	 * had been set lower between the check in expand_files() and here.  Deal
-	 * with that in caller, it's cheaper that way.
+	 * had been set lower between the check in expand_files() and here.
 	 *
 	 * We make sure that nr remains a multiple of BITS_PER_LONG - otherwise
 	 * bitmaps handling below becomes unpleasant, to put it mildly...
 	 */
-	if (unlikely(nr > sysctl_nr_open))
-		nr = ((sysctl_nr_open - 1) | (BITS_PER_LONG - 1)) + 1;
+	if (unlikely(nr > sysctl_nr_open)) {
+		nr = round_down(sysctl_nr_open, BITS_PER_LONG);
+		if (nr < slots_wanted)
+			return ERR_PTR(-EMFILE);
+	}
 
 	fdt = kmalloc(sizeof(struct fdtable), GFP_KERNEL_ACCOUNT);
 	if (!fdt)
@@ -152,7 +155,7 @@ static struct fdtable * alloc_fdtable(unsigned int nr)
 out_fdt:
 	kfree(fdt);
 out:
-	return NULL;
+	return ERR_PTR(-ENOMEM);
 }
 
 /*
@@ -169,7 +172,7 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 	struct fdtable *new_fdt, *cur_fdt;
 
 	spin_unlock(&files->file_lock);
-	new_fdt = alloc_fdtable(nr);
+	new_fdt = alloc_fdtable(nr + 1);
 
 	/* make sure all fd_install() have seen resize_in_progress
 	 * or have finished their rcu_read_lock_sched() section.
@@ -178,16 +181,8 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 		synchronize_rcu();
 
 	spin_lock(&files->file_lock);
-	if (!new_fdt)
-		return -ENOMEM;
-	/*
-	 * extremely unlikely race - sysctl_nr_open decreased between the check in
-	 * caller and alloc_fdtable().  Cheaper to catch it here...
-	 */
-	if (unlikely(new_fdt->max_fds <= nr)) {
-		__free_fdtable(new_fdt);
-		return -EMFILE;
-	}
+	if (IS_ERR(new_fdt))
+		return PTR_ERR(new_fdt);
 	cur_fdt = files_fdtable(files);
 	BUG_ON(nr < cur_fdt->max_fds);
 	copy_fdtable(new_fdt, cur_fdt);
@@ -308,7 +303,6 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 	struct file **old_fds, **new_fds;
 	unsigned int open_files, i;
 	struct fdtable *old_fdt, *new_fdt;
-	int error;
 
 	newf = kmem_cache_alloc(files_cachep, GFP_KERNEL);
 	if (!newf)
@@ -340,17 +334,10 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 		if (new_fdt != &newf->fdtab)
 			__free_fdtable(new_fdt);
 
-		new_fdt = alloc_fdtable(open_files - 1);
-		if (!new_fdt) {
-			error = -ENOMEM;
-			goto out_release;
-		}
-
-		/* beyond sysctl_nr_open; nothing to do */
-		if (unlikely(new_fdt->max_fds < open_files)) {
-			__free_fdtable(new_fdt);
-			error = -EMFILE;
-			goto out_release;
+		new_fdt = alloc_fdtable(open_files);
+		if (IS_ERR(new_fdt)) {
+			kmem_cache_free(files_cachep, newf);
+			return ERR_CAST(new_fdt);
 		}
 
 		/*
@@ -391,10 +378,6 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 	rcu_assign_pointer(newf->fdt, new_fdt);
 
 	return newf;
-
-out_release:
-	kmem_cache_free(files_cachep, newf);
-	return ERR_PTR(error);
 }
 
 static struct fdtable *close_files(struct files_struct * files)
-- 
2.39.2


