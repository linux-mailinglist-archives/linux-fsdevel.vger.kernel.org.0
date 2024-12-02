Return-Path: <linux-fsdevel+bounces-36260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F259E052C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 15:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91170167377
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 14:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F282205E2F;
	Mon,  2 Dec 2024 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPfnKFDv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74644205E0C;
	Mon,  2 Dec 2024 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149883; cv=none; b=brsKwAY2Bi8aKgCe/QFzFBkn9aEbJehNppDy+kqULg8o3k1pdVPmFVmY07+GqQRP6CsdYPOmiYZFVMJT7ncWs4RtOJ+4qAsb/1HKRhhj001EJMCVFd72/T7XKFoZCRmiUySEQBV5suz2TDyZRamcCYONas86CshIUQdOo4uhGzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149883; c=relaxed/simple;
	bh=ZtGu6SK5aFdAysupqz7NhzQdEnEBx5d8JsncaclV628=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFDGZyg4ejqhroyWC8YaByzXn2O3/TFbWXxHupd2Qz7n2szaIpN/eTIOtBAaNfFnhEwGZ7YEG7aVV6N+Vnvh55UGfzry9vkUT9unz/HRyYwEPO90egAreoHDNvPP9PDorWMygFxnTIx8ohWn6ZMDbhpvkgiirJ58kGhIcJl4yZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPfnKFDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E961C4CED2;
	Mon,  2 Dec 2024 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149883;
	bh=ZtGu6SK5aFdAysupqz7NhzQdEnEBx5d8JsncaclV628=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPfnKFDvxZ8vA6jFBhYtrwkOi+RmM6F3HfRS7e8R+fjzPQ0G6pX7hqSlqjNexBJdP
	 kLhua83Sb3v8k1JGVAU+kmGvQCH0YgzOhObmI11ZJ0Pw3n64slRqA70YrowK54qM+K
	 eWnyxl4kVUdhxevMp7hLqFu2qr9vP5NLdKYkzxainIXOpjvSEXjHAiJvr8/mwCQnvO
	 FlCRqDqOZpK0ho/hECjl7tdWFM8F2UVs6p/fpGfILPJJvO86FnPUnTCrpSRjgpfEo3
	 AM1L0ijv+lSidizSMfnMlgLjsZDsz9EPwFsoiUgp+T7llYXsihPCE8FRO81T2UeH/Y
	 tXtmDr6i2/z0w==
Date: Mon, 2 Dec 2024 15:31:13 +0100
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
Message-ID: <20241202-wahrnehmen-mitten-e330cbd1eaf0@brauner>
References: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
 <8eceec08eb64b744b24bf2aa09d4535e77e1ba47.1729926229.git.lorenzo.stoakes@oracle.com>
 <20241028-gesoffen-drehmoment-5314faba9731@brauner>
 <c96df57a-fa1b-4301-9556-94a6b8c93a31@lucifer.local>
 <b8f4664c-b8f0-46ca-b9a3-8d73e398b5ca@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8f4664c-b8f0-46ca-b9a3-8d73e398b5ca@lucifer.local>

On Wed, Oct 30, 2024 at 04:37:37PM +0000, Lorenzo Stoakes wrote:
> On Mon, Oct 28, 2024 at 04:06:07PM +0000, Lorenzo Stoakes wrote:
> > I guess I'll try to adapt that and respin a v7 when I get a chance.
> 
> Hm looking at this draft patch, it seems like a total rework of pidfd's
> across the board right (now all pidfd's will need to be converted to
> pid_fd)? Correct me if I'm wrong.
> 
> If only for the signal case, it seems like overkill to define a whole
> pid_fd and to use this CLASS() wrapper just for this one instance.
> 
> If the intent is to convert _all_ pidfd's to use this type, it feels really
> out of scope for this series and I think we'd probably instead want to go
> off and do that as a separate series and put this on hold until that is
> done.
> 
> If instead you mean that we ought to do something like this just for the
> signal case, it feels like it'd be quite a bit of extra abstraction just
> used in this one case but nowhere else, I think if you did an abstraction
> like this it would _have_ to be across the board right?
> 
> I agree that the issue is with this one signal case that pins only the fd
> (rather than this pid) where this 'pinning' doesn't _necessary_ mess around
> with reference counts.
> 
> So we definitely must address this, but the issue you had with the first
> approach was that I think (correct me if I'm wrong) I was passing a pointer
> to a struct fd which is not permitted right?
> 
> Could we pass the struct fd by value to avoid this? I think we'd have to
> unfortunately special-case this and probably duplicate some code which is a
> pity as I liked the idea of abstracting everything to one place, but we can
> obviously do that.
> 
> So I guess to TL;DR it, the options are:
> 
> 1. Implement pid_fd everywhere, in which case I will leave off on
>    this series and I guess, if I have time I could look at trying to
>    implement that or perhaps you'd prefer to?
> 
> 2. We are good for the sake of this series to special-case a pidfd_to_pid()
>    implementation (used only by the pidfd_send_signal() syscall)
> 
> 3. Something else, or I am misunderstanding your point :)
> 
> Let me know how you want me to proceed on this as we're at v6 already and I
> want to be _really_ sure I'm doing what you want here.

I don't think we get away with abstracting it in one place without this
ending up a pretty janky api. I need to go back and think about calling
conventions for all this stuff. For now I think I'm fine with something
like the below that abstracts the api to handle mm/ cleanly and then a
special-case for pidfd_send_signal():

diff --git a/kernel/pid.c b/kernel/pid.c
index 6131543e7c09..c1857c44d1a3 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -564,15 +564,29 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
  */
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags)
 {
-       unsigned int f_flags;
+       unsigned int f_flags = 0;
        struct pid *pid;
        struct task_struct *task;
+       enum pid_type type;

-       pid = pidfd_get_pid(pidfd, &f_flags);
-       if (IS_ERR(pid))
-               return ERR_CAST(pid);
+       switch (pidfd) {
+       case PIDFD_SELF_THREAD:
+               type = PIDTYPE_PID;
+               pid = get_task_pid(current, type);
+               break;
+       case PIDFD_SELF_THREAD_GROUP:
+               type = PIDTYPE_TGID;
+               pid = get_task_pid(current, type);
+               break;
+       default:
+               pid = pidfd_get_pid(pidfd, &f_flags);
+               if (IS_ERR(pid))
+                       return ERR_CAST(pid);
+               type = PIDTYPE_TGID;
+               break;
+       }

-       task = get_pid_task(pid, PIDTYPE_TGID);
+       task = get_pid_task(pid, type);
        put_pid(pid);
        if (!task)
                return ERR_PTR(-ESRCH);

That would get you support for PIDFD_SELF_THREAD and
PIDFD_SELF_THREAD_GROUP for process_madvise() and process_mrelease().

And for pidfd_send_signal() we could just open code this for now:

diff --git a/kernel/signal.c b/kernel/signal.c
index 989b1cc9116a..a2e4e3a5ee42 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3990,6 +3990,45 @@ static struct pid *pidfd_to_pid(const struct file *file)
 	(PIDFD_SIGNAL_THREAD | PIDFD_SIGNAL_THREAD_GROUP | \
 	 PIDFD_SIGNAL_PROCESS_GROUP)
 
+static int do_pidfd_send_signal(struct pid *pid, int sig, enum pid_type type,
+				siginfo_t __user *info, unsigned int flags)
+{
+	kernel_siginfo_t kinfo;
+
+	switch (flags) {
+	case PIDFD_SIGNAL_THREAD:
+		type = PIDTYPE_PID;
+		break;
+	case PIDFD_SIGNAL_THREAD_GROUP:
+		type = PIDTYPE_TGID;
+		break;
+	case PIDFD_SIGNAL_PROCESS_GROUP:
+		type = PIDTYPE_PGID;
+		break;
+	}
+
+	if (info) {
+		int ret = copy_siginfo_from_user_any(&kinfo, info);
+		if (unlikely(ret))
+			return ret;
+
+		if (unlikely(sig != kinfo.si_signo))
+			return -EINVAL;
+
+		/* Only allow sending arbitrary signals to yourself. */
+		if ((task_pid(current) != pid || type > PIDTYPE_TGID) &&
+		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
+			return -EPERM;
+	} else {
+		prepare_kill_siginfo(sig, &kinfo, type);
+	}
+
+	if (type == PIDTYPE_PGID)
+		return kill_pgrp_info(sig, &kinfo, pid);
+
+	return kill_pid_info_type(sig, &kinfo, pid, type);
+}
+
 /**
  * sys_pidfd_send_signal - Signal a process through a pidfd
  * @pidfd:  file descriptor of the process
@@ -4009,7 +4048,6 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 {
 	int ret;
 	struct pid *pid;
-	kernel_siginfo_t kinfo;
 	enum pid_type type;
 
 	/* Enforce flags be set to 0 until we add an extension. */
@@ -4021,56 +4059,39 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		return -EINVAL;
 
 	CLASS(fd, f)(pidfd);
-	if (fd_empty(f))
-		return -EBADF;
 
-	/* Is this a pidfd? */
-	pid = pidfd_to_pid(fd_file(f));
-	if (IS_ERR(pid))
-		return PTR_ERR(pid);
+	switch (pidfd) {
+	case PIDFD_SELF_THREAD:
+		pid = get_task_pid(current, PIDTYPE_PID);
+		type = PIDTYPE_PID;
+		break;
+	case PIDFD_SELF_THREAD_GROUP:
+		pid = get_task_pid(current, PIDTYPE_TGID);
+		type = PIDTYPE_TGID;
+		break;
+	default:
+		if (fd_empty(f))
+			return -EBADF;
 
-	if (!access_pidfd_pidns(pid))
-		return -EINVAL;
+		/* Is this a pidfd? */
+		pid = pidfd_to_pid(fd_file(f));
+		if (IS_ERR(pid))
+			return PTR_ERR(pid);
 
-	switch (flags) {
-	case 0:
+		if (!access_pidfd_pidns(pid))
+			return -EINVAL;
 		/* Infer scope from the type of pidfd. */
 		if (fd_file(f)->f_flags & PIDFD_THREAD)
 			type = PIDTYPE_PID;
 		else
 			type = PIDTYPE_TGID;
 		break;
-	case PIDFD_SIGNAL_THREAD:
-		type = PIDTYPE_PID;
-		break;
-	case PIDFD_SIGNAL_THREAD_GROUP:
-		type = PIDTYPE_TGID;
-		break;
-	case PIDFD_SIGNAL_PROCESS_GROUP:
-		type = PIDTYPE_PGID;
-		break;
 	}
 
-	if (info) {
-		ret = copy_siginfo_from_user_any(&kinfo, info);
-		if (unlikely(ret))
-			return ret;
-
-		if (unlikely(sig != kinfo.si_signo))
-			return -EINVAL;
-
-		/* Only allow sending arbitrary signals to yourself. */
-		if ((task_pid(current) != pid || type > PIDTYPE_TGID) &&
-		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
-			return -EPERM;
-	} else {
-		prepare_kill_siginfo(sig, &kinfo, type);
-	}
-
-	if (type == PIDTYPE_PGID)
-		return kill_pgrp_info(sig, &kinfo, pid);
-	else
-		return kill_pid_info_type(sig, &kinfo, pid, type);
+	ret = do_pidfd_send_signal(pid, sig, type, info, flags);
+	if (fd_empty(f))
+		put_pid(pid);
+	return ret;
 }
 
 static int

