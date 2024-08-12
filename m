Return-Path: <linux-fsdevel+bounces-25645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D0294E70B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970331C21C16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 06:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3D4165EF0;
	Mon, 12 Aug 2024 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gMpLmwOV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8A15218A
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 06:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445073; cv=none; b=eYQBf5d9Z1vrm82Bn5K+TvWD86t8Tv1bEYa7LFBGy763myUEy9Ea9/kRncexgptLm6FRhv9IzyCJoawWZOD0tqPhJpgAizdW7yBnPxuYRbq2/elZCLoCq5sxBmhqH2QVUoNboOjUsDJDxjxjWz+cA04WLQfntzTkbll03UBaluo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445073; c=relaxed/simple;
	bh=F2Se9N03hfe05pzZiZXkcIav7w4FXbX5uM2r7BRXFac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTWPo/o5Ojnwq/Iwq+r2Zl1bjKxuXm8iMsg2sic+Jpeq+RbnMERZIIeQZNoFgxqTyoUte6/qQqJNZDH6sOyKFj4cDt2cFLcHbPNdf5ujwTtTG9ywxgA09yin/qACgbYmoPj5tfb0VjUG46Jgcw9lBlHRBQJLg3i0SBRJbbz3+N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gMpLmwOV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TW7pzd/pIyAH5wSkVfNt/lP9fBHMkFTso88usI0Achc=; b=gMpLmwOVcdPX0SmUnX2chvgCDJ
	zRI+DcNSCTmagFFncnm9lAlaLQA7cAsnGDWIqgEVzfGuKPBOA/3HhiP2sfqsXsEgzVntFBON3ou6z
	7q7RNhK5+zAgJWAhxxR2sNgiYzpEEy/rrJZ5P9fRdZ2YOBUfZrSClcDpjW8BYEY4VzDmcl97hihRz
	PFwWS7VP4vtQWQOLyx0oC5605j/FJ3Y1Iqho2em0BWW6kbYRFiHu93Mw9rle3T5FqP2VkUcovPCGw
	RZlznJDOp8oGaZA5hHXiMhE2aL6aY5LaQj/z2GJig4JSvPpuqCEdF8zvI4aQ2bPvvvU2Jf5J7otiF
	ZSrG4cHg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdOn6-000000010V5-3BMF;
	Mon, 12 Aug 2024 06:44:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/11] alloc_fdtable(): change calling conventions.
Date: Mon, 12 Aug 2024 07:44:26 +0100
Message-ID: <20240812064427.240190-10-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file.c | 58 ++++++++++++++++++-------------------------------------
 1 file changed, 19 insertions(+), 39 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 1ee85e061ade..01cef75ef132 100644
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
@@ -110,20 +103,22 @@ static struct fdtable * alloc_fdtable(unsigned int nr)
 	 * the fdarray into comfortable page-tuned chunks: starting at 1024B
 	 * and growing in powers of two from there on.
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
@@ -152,7 +147,7 @@ static struct fdtable * alloc_fdtable(unsigned int nr)
 out_fdt:
 	kfree(fdt);
 out:
-	return NULL;
+	return ERR_PTR(-ENOMEM);
 }
 
 /*
@@ -169,7 +164,7 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 	struct fdtable *new_fdt, *cur_fdt;
 
 	spin_unlock(&files->file_lock);
-	new_fdt = alloc_fdtable(nr);
+	new_fdt = alloc_fdtable(nr + 1);
 
 	/* make sure all fd_install() have seen resize_in_progress
 	 * or have finished their rcu_read_lock_sched() section.
@@ -178,16 +173,8 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
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
@@ -357,16 +344,9 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 		if (new_fdt != &newf->fdtab)
 			__free_fdtable(new_fdt);
 
-		new_fdt = alloc_fdtable(open_files - 1);
-		if (!new_fdt) {
-			*errorp = -ENOMEM;
-			goto out_release;
-		}
-
-		/* beyond sysctl_nr_open; nothing to do */
-		if (unlikely(new_fdt->max_fds < open_files)) {
-			__free_fdtable(new_fdt);
-			*errorp = -EMFILE;
+		new_fdt = alloc_fdtable(open_files);
+		if (IS_ERR(new_fdt)) {
+			*errorp = PTR_ERR(new_fdt);
 			goto out_release;
 		}
 
-- 
2.39.2


