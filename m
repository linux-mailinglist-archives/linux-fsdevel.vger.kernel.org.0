Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA636EE1F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 14:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjDYMe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 08:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbjDYMe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:34:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAA64EC0;
        Tue, 25 Apr 2023 05:34:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E3AE6252B;
        Tue, 25 Apr 2023 12:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DE2C433D2;
        Tue, 25 Apr 2023 12:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682426060;
        bh=2t4xcYsN2M8yGrJPi16f6TFzAubrgG7YL3QgStTHtag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DsPNhrlqvNuHz7duglot5BsuqsUzJkTkuOfbWcsu+ZtlSxeHjqhJkx0SfAdMViev5
         7tt8AHjo+LoqESm2KIaQ/sovEDS2rqh/zwHgaepf6f5JVfxmiU79o9w9XV7Bk+hkaY
         9jaKeK+kIx4+av3oKQ+OqDcx3jKK4sIFU4hKUKKJMDiAzIYttsMDLo2n1M7CJ81Cl4
         tSCwP6fx2dfcvpYBdak/i0S7fCzLiBac2QycuHNB86LH23GGJUdPXhTHLbLPPzE2bq
         R+ncbWXKud/rwMH66E1But8cNw8NU9VuShInmCLztYpfE8LDOnmjjV2xX1ef5JEoZ9
         DK5v5E0aMIQTg==
Date:   Tue, 25 Apr 2023 14:34:15 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pidfd updates
Message-ID: <20230425-sturheit-jungautor-97d92d7861e2@brauner>
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230425060427.GP3390869@ZenIV>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 25, 2023 at 07:04:27AM +0100, Al Viro wrote:
> On Mon, Apr 24, 2023 at 01:24:24PM -0700, Linus Torvalds wrote:
> 
> > But I really think a potentially much nicer model would have been to
> > extend our "get_unused_fd_flags()" model.
> > 
> > IOW, we could have instead marked the 'struct file *' in the file
> > descriptor table as being "not ready yet".
> > 
> > I wonder how nasty it would have been to have the low bit of the
> > 'struct file *' mark "not ready to be used yet" or something similar.
> > You already can't just access the 'fdt->fd[]' array willy-nilly since
> > we have both normal RCU issues _and_ the somewhat unusual spectre
> > array indexing issues.
> > 
> > So looking around with
> > 
> >     git grep -e '->fd\['
> > 
> > we seem to be pretty good about that and it probably wouldn't be too
> > horrid to add a "check low bit isn't set" to the rules.
> > 
> > Then pidfd_prepare() could actually install the file pointer in the fd
> > table, just marked as "not ready", and then instead of "fd_install()",
> > yuo'd have "fd_expose(fd)" or something.
> > 
> > I dislike interfaces that return two different things. Particularly
> > ones that are supposed to be there to make things easy for the user. I
> > think your pidfd_prepare() helper fails that "make it easy to use"
> > test.
> > 
> > Hmm?
> 
> I'm not fond of "return two things" kind of helpers, but I'm even less
> fond of "return fd, file is already there" ones, TBH.  {__,}pidfd_prepare()
> users are thankfully very limited in the things they do to the file that
> had been returned, but that really invites abuse.

It's only exposed to kernel core code for good reasons.

> 
> The deeper in call chain we mess with descriptor table, the more painful it
> gets, IME.
> 
> Speaking of {__,}pidfd_prepare(), I wonder if we wouldn't be better off
> with get_unused_fd_flags() lifted into the callers - all three of those
> (fanotify copy_event_to_user(), copy_process() and pidfd_create()).
> Switch from anon_inode_getfd() to anon_inode_getfile() certainly
> made sense, ditto for combining it with get_pid(), but mixing
> get_unused_fd_flags() into that is a mistake, IMO.

I agree with mostly everything here except for get_unused_fd_flags()
being lifted into the callers. That's what I tried to get rid of in
kernel/fork.c.

It is rife with misunderstandings just looking at what we did in
kernel/fork.c earlier:

	retval = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
        [...]
        pidfile = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
                                     O_RDWR | O_CLOEXEC);

seeing where both get_unused_fd_flags() and both *_getfile() take flag
arguments. Sure, for us this is pretty straightforward since we've seen
that code a million times. For others it's confusing why there's two
flag arguments. Sure, we could use one flags argument but it still be
weird to look at.

But with this api we also force all users to remember that they need to
cleanup the fd and the file - but definitely one - depending on where
they fail.

But conceptually the fd and the file belong together. After all it's the
file we're about to make that reserved fd refer to.

But I'm not here to lambast this api. It works nicely overall and that
reserve + install model is pretty elegant. But see for my boring
compromise proposal below...

> 
> As for your suggestion... let's see what it leads to.
> 
> 	Suppose we add such entries (reserved, hold a reference to file,
> marked "not yet available" in the LSB).  From the current tree POV those
> would be equivalent to descriptor already reserved, but fd_install() not
> done.  So behaviour of existing primitives should be the same as for this
> situation, except for fd_install() and put_unused_fd().
> 
> 	* pick_file(), __fget_files_rcu(), iterate_fd(), files_lookup_fd_raw(),
> 	  loop in dup_fd(), io_close() - treat odd pointers as NULL.
> 	* close_files() should, AFAICS, treat an odd pointer as "should never
> happen" (and that xchg() in there needs to go anyway - it's pointless, since
> we are freeing the the array immediately afterwards.
> 	* do_close_on_exec() should probably treat them as "should never happen".
> 	* do_dup2() - odd value should be treated as -EBUSY.
> 
> The interesting part, of course, is how to legitimize (or dispose of) such
> a beast.  The former is your "fd_expose()" - parallel to fd_install(),
> AFAICS.  The latter... another primitive that would
> 	grab ->files_lock
> 	pick_file() variant that *expects* an odd value
> 	drop ->files_lock
> 	clear LSB and pass to fput().
> 
> It's doable, but AFAICS doesn't make callers all that happier...

In the context of using pidfd for some networking stuff we had a similar
discussion because it's the same problem only worse. Think of a
scenario where you need to allocate the fd and file early on and
multiple function calls later you only get to install fd and file. In
that case you need to drag that fd and file around everywhere so you can
then fd_install it... Sure, we could do this "semi-install fd into
fdtable thing" but I think that's too much subtlety and the fdtable is
traumatic enough as it is.

But what about something like the following where we just expose a very
barebones api that allows and encourages callers to bundle fd and file.

Hell, you could even extend that proposal below to wrap the
put_user()...

struct fd_file {
	struct file *file;
	int fd;
	int __user *fd_user;
};

and

static inline int fd_publish_user(struct fd_file *fdf)
{
	int ret = 0;

	if (fdf->fd_user)
		ret = put_user(fdf->fd, fdf->fd_user);

	if (ret)
		fd_discard(fdf)
	else
		fd_publish(fdf)

	return 0;
}

which is also a pretty common pattern...

From d6b48884d33f9a2e4506589d9380bf2036e43b8a Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 25 Apr 2023 14:21:18 +0200
Subject: [PATCH] UNTESTED UNTESTED DRAFT DRAFT

---
 include/linux/file.h | 20 ++++++++++++++++++++
 include/linux/pid.h  |  3 ++-
 kernel/fork.c        | 35 +++++++++++++++++++----------------
 kernel/pid.c         | 14 +++++++-------
 4 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/include/linux/file.h b/include/linux/file.h
index 39704eae83e2..fdadaaa9f70b 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -39,6 +39,11 @@ struct fd {
 #define FDPUT_FPUT       1
 #define FDPUT_POS_UNLOCK 2
 
+struct fd_file {
+	struct file *file;
+	int fd;
+};
+
 static inline void fdput(struct fd fd)
 {
 	if (fd.flags & FDPUT_FPUT)
@@ -90,6 +95,21 @@ extern void put_unused_fd(unsigned int fd);
 
 extern void fd_install(unsigned int fd, struct file *file);
 
+static inline void fd_publish(struct fd_file *fdf)
+{
+	if (fdf->file)
+		fd_install(fdf->fd, fdf->file);
+}
+
+static inline void fd_discard(struct fd_file *fdf)
+{
+	if (fdf->file) {
+		fput(fdf->file);
+		put_unused_fd(fdf->fd);
+
+	}
+}
+
 extern int __receive_fd(struct file *file, int __user *ufd,
 			unsigned int o_flags);
 
diff --git a/include/linux/pid.h b/include/linux/pid.h
index b75de288a8c2..0b0695459508 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -75,12 +75,13 @@ extern struct pid init_struct_pid;
 extern const struct file_operations pidfd_fops;
 
 struct file;
+struct fd_file;
 
 extern struct pid *pidfd_pid(const struct file *file);
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
 int pidfd_create(struct pid *pid, unsigned int flags);
-int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
+int pidfd_prepare(struct pid *pid, unsigned int flags, struct fd_file *fdf);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/kernel/fork.c b/kernel/fork.c
index bfe73db1c26c..2072d8cc91d2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1989,7 +1989,8 @@ const struct file_operations pidfd_fops = {
  *         error, a negative error code is returned from the function and the
  *         last argument remains unchanged.
  */
-static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
+static int __pidfd_prepare(struct pid *pid, unsigned int flags,
+			   struct fd_file *fdf)
 {
 	int pidfd;
 	struct file *pidfd_file;
@@ -2008,8 +2009,11 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
 		return PTR_ERR(pidfd_file);
 	}
 	get_pid(pid); /* held by pidfd_file now */
-	*ret = pidfd_file;
-	return pidfd;
+
+	fdf->file = pidfd_file;
+	fdf->fd = pidfd;
+
+	return 0;
 }
 
 /**
@@ -2038,12 +2042,12 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  *         error, a negative error code is returned from the function and the
  *         last argument remains unchanged.
  */
-int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
+int pidfd_prepare(struct pid *pid, unsigned int flags, struct fd_file *fdf)
 {
 	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
 		return -EINVAL;
 
-	return __pidfd_prepare(pid, flags, ret);
+	return __pidfd_prepare(pid, flags, fdf);
 }
 
 static void __delayed_free_task(struct rcu_head *rhp)
@@ -2106,10 +2110,12 @@ __latent_entropy struct task_struct *copy_process(
 					int node,
 					struct kernel_clone_args *args)
 {
-	int pidfd = -1, retval;
+	int retval;
+	struct fd_file pidfd = {
+		.fd = -1,
+	};
 	struct task_struct *p;
 	struct multiprocess_signals delayed;
-	struct file *pidfile = NULL;
 	const u64 clone_flags = args->flags;
 	struct nsproxy *nsp = current->nsproxy;
 
@@ -2395,12 +2401,11 @@ __latent_entropy struct task_struct *copy_process(
 	 */
 	if (clone_flags & CLONE_PIDFD) {
 		/* Note that no task has been attached to @pid yet. */
-		retval = __pidfd_prepare(pid, O_RDWR | O_CLOEXEC, &pidfile);
+		retval = __pidfd_prepare(pid, O_RDWR | O_CLOEXEC, &pidfd);
 		if (retval < 0)
 			goto bad_fork_free_pid;
-		pidfd = retval;
 
-		retval = put_user(pidfd, args->pidfd);
+		retval = put_user(pidfd.fd, args->pidfd);
 		if (retval)
 			goto bad_fork_put_pidfd;
 	}
@@ -2584,8 +2589,8 @@ __latent_entropy struct task_struct *copy_process(
 	syscall_tracepoint_update(p);
 	write_unlock_irq(&tasklist_lock);
 
-	if (pidfile)
-		fd_install(pidfd, pidfile);
+	if (clone_flags & CLONE_PIDFD)
+		fd_publish(&pidfd);
 
 	proc_fork_connector(p);
 	sched_post_fork(p);
@@ -2605,10 +2610,8 @@ __latent_entropy struct task_struct *copy_process(
 	write_unlock_irq(&tasklist_lock);
 	cgroup_cancel_fork(p, args);
 bad_fork_put_pidfd:
-	if (clone_flags & CLONE_PIDFD) {
-		fput(pidfile);
-		put_unused_fd(pidfd);
-	}
+	if (clone_flags & CLONE_PIDFD)
+		fd_discard(&pidfd);
 bad_fork_free_pid:
 	if (pid != &init_struct_pid)
 		free_pid(pid);
diff --git a/kernel/pid.c b/kernel/pid.c
index f93954a0384d..6cd46002aca3 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -594,15 +594,15 @@ struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags)
  */
 int pidfd_create(struct pid *pid, unsigned int flags)
 {
-	int pidfd;
-	struct file *pidfd_file;
+	int ret;
+	struct fd_file pidfd;
 
-	pidfd = pidfd_prepare(pid, flags, &pidfd_file);
-	if (pidfd < 0)
-		return pidfd;
+	ret = pidfd_prepare(pid, flags, &pidfd);
+	if (ret < 0)
+		return ret;
 
-	fd_install(pidfd, pidfd_file);
-	return pidfd;
+	fd_publish(&pidfd);
+	return pidfd.fd;
 }
 
 /**
-- 
2.34.1

