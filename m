Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C63E5BB4E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Sep 2022 02:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiIQALX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 20:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIQALW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 20:11:22 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949C7A7A8C
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 17:11:20 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id y11so5568918pjv.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 17:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9Hg3WExcsAga0Qhwnt0s+/w+FgE+Fu4QOFI0odH5wLw=;
        b=acmLYJB90z6yu5lwsEGqpEGUuyqXxuAyLieS/i0RxF4QVKRLADMm6JnV+XBMbU9EAA
         elQkBbIz+sad/CGZx42A8rsnunF+Xok/Oqr7xqReyHCAX/3ws4pKA49/ldpiPL6yTaRg
         pzUxrW7n2Qf4rg8ztazly0c1K+osu8H2CEbhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9Hg3WExcsAga0Qhwnt0s+/w+FgE+Fu4QOFI0odH5wLw=;
        b=4j2V1BsoaDOsDecYIsjrLQ9dQvZk2rE2ORnSbyyOU4k/m3j7W833eFvU+Q63wM0Ht5
         S9fdgDm+biA2OL6g9lq23/Sr5ycFx7LQE3WMT9m6WZlVFnVQxvjuQNzgsMlWBE3sZbVu
         GR2BfVufLuAM2+DLW8wjv+0b2JBVIsGvCw5QwQDLRj9O0elnBu7CZfKMZkG/4ovgxWHe
         OH4gE6/ehbOogwd6yYJp6FOPUZb9Lza4xg373lu1PlbB9IB1rUp/j3D1lu+3zic8gnx2
         vCTJ5mG1HtztBKfVZ07vs6KsTq9nQFWspANXNitFdZLp6bu0DdKEKaihIN1+AWCN5YW1
         RCjw==
X-Gm-Message-State: ACrzQf3fl5LPFXgQhSuSiFXbvdwbM0vAzhdkljsLX/Ly+RqaqCZ3dmGP
        tLwB1JrqBcTadBcGZeAdghbqEBTmwKL3xzCE
X-Google-Smtp-Source: AMsMyM7yb8IkuA2CaVot0t/bvM6dtkqaItFJcFVr0dj47HvZl5Zkqje37Lxyoo/sQLSBjvgXpodG4Q==
X-Received: by 2002:a17:902:e40c:b0:176:9543:883 with SMTP id m12-20020a170902e40c00b0017695430883mr2207448ple.169.1663373479992;
        Fri, 16 Sep 2022 17:11:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u126-20020a626084000000b005385e2e86eesm15525980pfb.18.2022.09.16.17.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 17:11:19 -0700 (PDT)
Date:   Fri, 16 Sep 2022 17:11:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
Message-ID: <202209161637.9EDAF6B18@keescook>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
 <202209160727.5FC78B735@keescook>
 <YyTY+OaClK+JHCOw@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyTY+OaClK+JHCOw@localhost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Hi Peter, apologies for dumping you into the middle of this thread.
I've got a question about sched_exec() below...]

On Fri, Sep 16, 2022 at 09:13:44PM +0100, Josh Triplett wrote:
> musl does the same thing, as do python and perl (likely via execvp or
> posix_spawnp). As does gcc when it executes `as`. And I've seen more
> than a few programs hand-implement a PATH search the same way. Seems
> worth optimizing for.

Yeah, it does seem like a simple way to eliminate needless work, though
I'd really like to see some kind of perf count of "in a given kernel
build, how many execve() system calls fail due to path search vs succeed",
just to get a better sense of the scale of the problem.

I don't like the idea of penalizing the _succeeding_ case, though, which
happens if we do the path walk twice. So, I went and refactoring the setup
order, moving the do_open_execat() up into alloc_bprm() instead of where
it was in bprm_exec(). The result makes it so it is, as you observed,
before the mm creation and generally expensive argument copying. The
difference to your patch seems to only be the allocation of the file
table entry, but avoids the double lookup, so I'm hoping the result is
actually even faster.

This cleanup is actually quite satisfying organizationally too -- the
fd and filename were passed around rather oddly.

The interaction with sched_exec() should be no worse (the file is opened
before it in either case), but in reading that function, it talks about
taking the opportunity to move the process to another CPU (IIUC) since,
paraphrasing, "it is at its lowest memory/cache size." But I wonder if
there is an existing accidental pessimistic result in that the process
stack has already been allocated. I am only passingly familiar with how
tasks get moved around under NUMA -- is the scheduler going to move
this process onto a different NUMA node and now it will be forced to
have the userspace process stack on one node and the program text and
heap on another? Or is that totally lost in the noise?

More specifically, I was wondering if processes would benefit from having
sched_exec() moved before the mm creation?

Regardless, here's a very lightly tested patch. Can you take this for a
spin and check your benchmark? Thanks!

-Kees

diff --git a/fs/exec.c b/fs/exec.c
index 9a5ca7b82bfc..5534301d67ca 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -898,6 +898,10 @@ EXPORT_SYMBOL(transfer_args_to_stack);
 
 #endif /* CONFIG_MMU */
 
+/*
+ * On success, callers must call do_close_execat() on the returned
+ * struct file.
+ */
 static struct file *do_open_execat(int fd, struct filename *name, int flags)
 {
 	struct file *file;
@@ -945,6 +949,16 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	return ERR_PTR(err);
 }
 
+/**
+ * open_exec - Open a path name for execution
+ *
+ * @name: path name to open with the intent of executing it.
+ *
+ * Returns ERR_PTR on failure or allocated struct file on success.
+ *
+ * As this is a wrapper for the internal do_open_execat(), callers
+ * must call allow_write_access() before fput() on release.
+ */
 struct file *open_exec(const char *name)
 {
 	struct filename *filename = getname_kernel(name);
@@ -1485,6 +1499,15 @@ static int prepare_bprm_creds(struct linux_binprm *bprm)
 	return -ENOMEM;
 }
 
+/* Matches do_open_execat() */
+static void do_close_execat(struct file *file)
+{
+	if (!file)
+		return;
+	allow_write_access(file);
+	fput(file);
+}
+
 static void free_bprm(struct linux_binprm *bprm)
 {
 	if (bprm->mm) {
@@ -1496,10 +1519,7 @@ static void free_bprm(struct linux_binprm *bprm)
 		mutex_unlock(&current->signal->cred_guard_mutex);
 		abort_creds(bprm->cred);
 	}
-	if (bprm->file) {
-		allow_write_access(bprm->file);
-		fput(bprm->file);
-	}
+	do_close_execat(bprm->file);
 	if (bprm->executable)
 		fput(bprm->executable);
 	/* If a binfmt changed the interp, free it. */
@@ -1509,12 +1529,26 @@ static void free_bprm(struct linux_binprm *bprm)
 	kfree(bprm);
 }
 
-static struct linux_binprm *alloc_bprm(int fd, struct filename *filename)
+static struct linux_binprm *alloc_bprm(int fd, struct filename *filename,
+				       int flags)
 {
-	struct linux_binprm *bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
-	int retval = -ENOMEM;
-	if (!bprm)
+	struct linux_binprm *bprm;
+	struct file *file;
+	int retval;
+
+	file = do_open_execat(fd, filename, flags);
+	if (IS_ERR(file)) {
+		retval = PTR_ERR(file);
 		goto out;
+	}
+
+	retval = -ENOMEM;
+	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
+	if (!bprm) {
+		do_close_execat(file);
+		goto out;
+	}
+	bprm->file = file;
 
 	if (fd == AT_FDCWD || filename->name[0] == '/') {
 		bprm->filename = filename->name;
@@ -1531,6 +1565,18 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename)
 	}
 	bprm->interp = bprm->filename;
 
+	/*
+	 * Record that a name derived from an O_CLOEXEC fd will be
+	 * inaccessible after exec.  This allows the code in exec to
+	 * choose to fail when the executable is not mmaped into the
+	 * interpreter and an open file descriptor is not passed to
+	 * the interpreter.  This makes for a better user experience
+	 * than having the interpreter start and then immediately fail
+	 * when it finds the executable is inaccessible.
+	 */
+	if (bprm->fdpath && get_close_on_exec(fd))
+		bprm->interp_flags |= BINPRM_FLAGS_PATH_INACCESSIBLE;
+
 	retval = bprm_mm_init(bprm);
 	if (retval)
 		goto out_free;
@@ -1803,10 +1849,8 @@ static int exec_binprm(struct linux_binprm *bprm)
 /*
  * sys_execve() executes a new program.
  */
-static int bprm_execve(struct linux_binprm *bprm,
-		       int fd, struct filename *filename, int flags)
+static int bprm_execve(struct linux_binprm *bprm)
 {
-	struct file *file;
 	int retval;
 
 	retval = prepare_bprm_creds(bprm);
@@ -1816,26 +1860,8 @@ static int bprm_execve(struct linux_binprm *bprm,
 	check_unsafe_exec(bprm);
 	current->in_execve = 1;
 
-	file = do_open_execat(fd, filename, flags);
-	retval = PTR_ERR(file);
-	if (IS_ERR(file))
-		goto out_unmark;
-
 	sched_exec();
 
-	bprm->file = file;
-	/*
-	 * Record that a name derived from an O_CLOEXEC fd will be
-	 * inaccessible after exec.  This allows the code in exec to
-	 * choose to fail when the executable is not mmaped into the
-	 * interpreter and an open file descriptor is not passed to
-	 * the interpreter.  This makes for a better user experience
-	 * than having the interpreter start and then immediately fail
-	 * when it finds the executable is inaccessible.
-	 */
-	if (bprm->fdpath && get_close_on_exec(fd))
-		bprm->interp_flags |= BINPRM_FLAGS_PATH_INACCESSIBLE;
-
 	/* Set the unchanging part of bprm->cred */
 	retval = security_bprm_creds_for_exec(bprm);
 	if (retval)
@@ -1863,7 +1889,6 @@ static int bprm_execve(struct linux_binprm *bprm,
 	if (bprm->point_of_no_return && !fatal_signal_pending(current))
 		force_fatal_sig(SIGSEGV);
 
-out_unmark:
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 
@@ -1897,7 +1922,7 @@ static int do_execveat_common(int fd, struct filename *filename,
 	 * further execve() calls fail. */
 	current->flags &= ~PF_NPROC_EXCEEDED;
 
-	bprm = alloc_bprm(fd, filename);
+	bprm = alloc_bprm(fd, filename, flags);
 	if (IS_ERR(bprm)) {
 		retval = PTR_ERR(bprm);
 		goto out_ret;
@@ -1946,7 +1971,7 @@ static int do_execveat_common(int fd, struct filename *filename,
 		bprm->argc = 1;
 	}
 
-	retval = bprm_execve(bprm, fd, filename, flags);
+	retval = bprm_execve(bprm);
 out_free:
 	free_bprm(bprm);
 
@@ -1971,7 +1996,7 @@ int kernel_execve(const char *kernel_filename,
 	if (IS_ERR(filename))
 		return PTR_ERR(filename);
 
-	bprm = alloc_bprm(fd, filename);
+	bprm = alloc_bprm(fd, filename, 0);
 	if (IS_ERR(bprm)) {
 		retval = PTR_ERR(bprm);
 		goto out_ret;
@@ -2006,7 +2031,7 @@ int kernel_execve(const char *kernel_filename,
 	if (retval < 0)
 		goto out_free;
 
-	retval = bprm_execve(bprm, fd, filename, 0);
+	retval = bprm_execve(bprm);
 out_free:
 	free_bprm(bprm);
 out_ret:


-- 
Kees Cook
