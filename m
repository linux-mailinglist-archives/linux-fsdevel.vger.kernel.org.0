Return-Path: <linux-fsdevel+bounces-26092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2950953FF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 05:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E740F1C2226C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 03:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332E355898;
	Fri, 16 Aug 2024 03:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OEpBkw44"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084A626AC3
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 03:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723777658; cv=none; b=cc4exKHSm0e4WnogkMaLFtoWSdlot1+Ni923WjwTHrY1P9Pwn0C1KYu8OVo6V6gq1VZuLLPYqrsUydI9dsAdH1E/wtCjaBbUTyN1Umv8BvpOXz/xG+/LznlB8KRGpvzdFY5vGFE1rM1S8FlNvq1Obq0rIIBj1/NB9W9/NTz5r7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723777658; c=relaxed/simple;
	bh=2AS6i8E50HO1I0rIGPTQKotWvbeM3PXlHYbq8SisDMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMhbQks6N0uTl2BhnpFrJukTQ98jvlkb0//ktgsEVuFr8ItSdxbykJA3uKbTyJR+8Q7JfWkIsYlw1NyNpGqrehEDeCshqZFHLTOpODF0+De2lQt5cBfkY3FKGGs/xf0bI4r+GZOmmBm8zKPUlC4e15e33q44gYMJiInRYsExW98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OEpBkw44; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sdtNm+SOjxRoJfa703Oa//ouhBHz6H5oi86u5eiUjTs=; b=OEpBkw446v6LxzkgNf8inv6CaP
	PzuZ60JODGX9Oeqh24GvmuM73PbmBIRmGD+aCUJiNEXQABRLGLcwNlblRNtx/TmzKUEZFlbaycgIZ
	eF2nKg4vFAENhFNv2AUD3tfHQJL/hTq0WrSezCyls6rO9vKebCsZjOxZcHlJHUrgp/9CRub9mYy4c
	bB5mENIbwsVHBQfhytuVUp29AH52DJtUattvbx98EAr1AqdXQWuMQa/LHq5xVYs3KsyTp6WXHaU1V
	bGe+I+CQovbtnH/g/mTjA9C4/k+bt+3xoXqtk0iJrfVJn618j9zw1nS9kH6c5JDiY46h+SVDH7IR5
	06J/0axA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1senJO-000000025OW-1QdX;
	Fri, 16 Aug 2024 03:07:34 +0000
Date: Fri, 16 Aug 2024 04:07:34 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC] more close_range() fun
Message-ID: <20240816030734.GX13701@ZenIV>
References: <20240816030341.GW13701@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816030341.GW13701@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 16, 2024 at 04:03:41AM +0100, Al Viro wrote:
> Thread 1:
> 	if (dup2(0, 1023) >= 0)
> 		dup2(0, 10);
> 
> Thread 2:
> 	if (close_range(64, 127, CLOSE_RANGE_UNSHARE) == 0 &&
> 	    fcntl(10, F_GETFD) >= 0 &&
> 	    fcntl(1023, F_GETFD) == -1)
> 		printf("broken");
> 
> 
> Note that close_range() call in the second thread does not
> affect any of the descriptors we work with in the first thread
> and at no point does thread 1 have descriptor 10 opened without
> descriptor 1023 also being opened.
> 
> It *can* actually happen - all it takes is close_range(2) decision
> to trim the copied descriptor table made before the first dup2()
> and actual copying done after both dup2() are done.
> 
> I would not expect that printf to trigger - not without having
> looked through the close_range(2) implementation.  Note that
> manpage doesn't even hint at anything of that sort.
> 
> IMO it's a QoI issue at the very least, and arguably an outright
> bug.
> 
> Note that there is a case where everything works fine, and I suspect
> that most of the callers where we want trimming are of that sort -
> if the second argument of close_range() is above the INT_MAX.
> 
> If that's the only case where we want trimming to happen, the
> fix is trivial; if not... also doable.  We just need to pass the
> range to be punched out all way down to sane_fdtable_size()
> (e.g. as a pointer, NULL meaning "no holes to punch").  I wouldn't
> bother with unshare_fd() - it's not hard for __close_range() to
> use dup_fd() instead.
> 
> Something like this (completely untested), perhaps?

or, with a braino fixed, this:

diff --git a/fs/file.c b/fs/file.c
index 655338effe9c..312574fda320 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -272,20 +272,6 @@ static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
 	return test_bit(fd, fdt->open_fds);
 }
 
-static unsigned int count_open_files(struct fdtable *fdt)
-{
-	unsigned int size = fdt->max_fds;
-	unsigned int i;
-
-	/* Find the last open fd */
-	for (i = size / BITS_PER_LONG; i > 0; ) {
-		if (fdt->open_fds[--i])
-			break;
-	}
-	i = (i + 1) * BITS_PER_LONG;
-	return i;
-}
-
 /*
  * Note that a sane fdtable size always has to be a multiple of
  * BITS_PER_LONG, since we have bitmaps that are sized by this.
@@ -299,14 +285,18 @@ static unsigned int count_open_files(struct fdtable *fdt)
  * just make that BITS_PER_LONG alignment be part of a sane
  * fdtable size. Becuase that's really what it is.
  */
-static unsigned int sane_fdtable_size(struct fdtable *fdt, unsigned int max_fds)
+static unsigned int sane_fdtable_size(struct fdtable *fdt, unsigned int *punch_hole)
 {
-	unsigned int count;
-
-	count = count_open_files(fdt);
-	if (max_fds < NR_OPEN_DEFAULT)
-		max_fds = NR_OPEN_DEFAULT;
-	return ALIGN(min(count, max_fds), BITS_PER_LONG);
+	unsigned int last = find_last_bit(fdt->open_fds, fdt->max_fds);
+
+	if (last == fdt->max_fds)	// empty
+		return NR_OPEN_DEFAULT;
+	if (punch_hole && punch_hole[1] >= last && punch_hole[0] <= last) {
+		last = find_last_bit(fdt->open_fds, punch_hole[0]);
+		if (last == punch_hole[0])
+			return NR_OPEN_DEFAULT;
+	}
+	return ALIGN(last + 1, BITS_PER_LONG);
 }
 
 /*
@@ -314,7 +304,7 @@ static unsigned int sane_fdtable_size(struct fdtable *fdt, unsigned int max_fds)
  * passed in files structure.
  * errorp will be valid only when the returned files_struct is NULL.
  */
-struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int *errorp)
+struct files_struct *dup_fd(struct files_struct *oldf, unsigned int *punch_hole, int *errorp)
 {
 	struct files_struct *newf;
 	struct file **old_fds, **new_fds;
@@ -341,7 +331,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 
 	spin_lock(&oldf->file_lock);
 	old_fdt = files_fdtable(oldf);
-	open_files = sane_fdtable_size(old_fdt, max_fds);
+	open_files = sane_fdtable_size(old_fdt, punch_hole);
 
 	/*
 	 * Check whether we need to allocate a larger fd array and fd set.
@@ -372,7 +362,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
 		 */
 		spin_lock(&oldf->file_lock);
 		old_fdt = files_fdtable(oldf);
-		open_files = sane_fdtable_size(old_fdt, max_fds);
+		open_files = sane_fdtable_size(old_fdt, punch_hole);
 	}
 
 	copy_fd_bitmaps(new_fdt, old_fdt, open_files / BITS_PER_LONG);
@@ -748,37 +738,26 @@ int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
 	if (fd > max_fd)
 		return -EINVAL;
 
-	if (flags & CLOSE_RANGE_UNSHARE) {
+	if ((flags & CLOSE_RANGE_UNSHARE) && atomic_read(&cur_fds->count) > 1) {
 		int ret;
-		unsigned int max_unshare_fds = NR_OPEN_MAX;
+		unsigned int range[2] = {fd, max_fd}, *punch_hole = range;
 
 		/*
 		 * If the caller requested all fds to be made cloexec we always
 		 * copy all of the file descriptors since they still want to
 		 * use them.
 		 */
-		if (!(flags & CLOSE_RANGE_CLOEXEC)) {
-			/*
-			 * If the requested range is greater than the current
-			 * maximum, we're closing everything so only copy all
-			 * file descriptors beneath the lowest file descriptor.
-			 */
-			rcu_read_lock();
-			if (max_fd >= last_fd(files_fdtable(cur_fds)))
-				max_unshare_fds = fd;
-			rcu_read_unlock();
-		}
+		if (flags & CLOSE_RANGE_CLOEXEC)
+			punch_hole = NULL;
 
-		ret = unshare_fd(CLONE_FILES, max_unshare_fds, &fds);
-		if (ret)
+		fds = dup_fd(cur_fds, punch_hole, &ret);
+		if (!fds)
 			return ret;
-
 		/*
 		 * We used to share our file descriptor table, and have now
 		 * created a private one, make sure we're using it below.
 		 */
-		if (fds)
-			swap(cur_fds, fds);
+		swap(cur_fds, fds);
 	}
 
 	if (flags & CLOSE_RANGE_CLOEXEC)
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 2944d4aa413b..6bc4353f919e 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -22,7 +22,6 @@
  * as this is the granularity returned by copy_fdset().
  */
 #define NR_OPEN_DEFAULT BITS_PER_LONG
-#define NR_OPEN_MAX ~0U
 
 struct fdtable {
 	unsigned int max_fds;
@@ -106,7 +105,7 @@ struct task_struct;
 
 void put_files_struct(struct files_struct *fs);
 int unshare_files(void);
-struct files_struct *dup_fd(struct files_struct *, unsigned, int *) __latent_entropy;
+struct files_struct *dup_fd(struct files_struct *, unsigned *, int *) __latent_entropy;
 void do_close_on_exec(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
@@ -115,8 +114,7 @@ int iterate_fd(struct files_struct *, unsigned,
 extern int close_fd(unsigned int fd);
 extern int __close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
 extern struct file *file_close_fd(unsigned int fd);
-extern int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
-		      struct files_struct **new_fdp);
+extern int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp);
 
 extern struct kmem_cache *files_cachep;
 
diff --git a/kernel/fork.c b/kernel/fork.c
index cc760491f201..a7c905f06048 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1773,7 +1773,7 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
 		goto out;
 	}
 
-	newf = dup_fd(oldf, NR_OPEN_MAX, &error);
+	newf = dup_fd(oldf, NULL, &error);
 	if (!newf)
 		goto out;
 
@@ -3232,15 +3232,14 @@ static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
 /*
  * Unshare file descriptor table if it is being shared
  */
-int unshare_fd(unsigned long unshare_flags, unsigned int max_fds,
-	       struct files_struct **new_fdp)
+int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp)
 {
 	struct files_struct *fd = current->files;
 	int error = 0;
 
 	if ((unshare_flags & CLONE_FILES) &&
 	    (fd && atomic_read(&fd->count) > 1)) {
-		*new_fdp = dup_fd(fd, max_fds, &error);
+		*new_fdp = dup_fd(fd, NULL, &error);
 		if (!*new_fdp)
 			return error;
 	}
@@ -3300,7 +3299,7 @@ int ksys_unshare(unsigned long unshare_flags)
 	err = unshare_fs(unshare_flags, &new_fs);
 	if (err)
 		goto bad_unshare_out;
-	err = unshare_fd(unshare_flags, NR_OPEN_MAX, &new_fd);
+	err = unshare_fd(unshare_flags, &new_fd);
 	if (err)
 		goto bad_unshare_cleanup_fs;
 	err = unshare_userns(unshare_flags, &new_cred);
@@ -3392,7 +3391,7 @@ int unshare_files(void)
 	struct files_struct *old, *copy = NULL;
 	int error;
 
-	error = unshare_fd(CLONE_FILES, NR_OPEN_MAX, &copy);
+	error = unshare_fd(CLONE_FILES, &copy);
 	if (error || !copy)
 		return error;
 

