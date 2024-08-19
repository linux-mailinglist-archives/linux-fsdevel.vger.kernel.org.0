Return-Path: <linux-fsdevel+bounces-26237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD919565CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 10:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363E11F23CEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 08:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E138E15B986;
	Mon, 19 Aug 2024 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow8gNcp6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B747C125;
	Mon, 19 Aug 2024 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056881; cv=none; b=cayC6RjMX0UFIajyMQ8pok/eFmjUFtPfBqiDJ7bOPXFxtT19JokiX3DCgdak3GRfefsfJ2Z1Qnm0JvD+0srdY0P3aYcEqjDqKOxNDpzR37QZH/vmbZkU2ik+r0WExLddDcBjW3MpBW1ErRHt8/txt0kwFdm3DB4hCC6Lw+BKegU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056881; c=relaxed/simple;
	bh=QmA14CcItYXW//LCVYvE0WOp2qeBSdVeMt7bClS3avg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThtP2/0T6+ds1cO218wSULJo7PlGHq4T3lbSVpCQ5aPTdxDTmnhPbPAeB//fEshlyNFmIk4C4z149mAoE7keYHdWfcKK0Cr4EeVhzv8HqsTCdNo17u4PGyU6D5U0JBiTIqcFUsUSNsIv6vN6yyMW+Cqy3cGyrw3MHGCuvJQVxKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ow8gNcp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BCAC4AF0C;
	Mon, 19 Aug 2024 08:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724056880;
	bh=QmA14CcItYXW//LCVYvE0WOp2qeBSdVeMt7bClS3avg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ow8gNcp66/tcw5rt2sDiBXQaOIUeb2iAknf+tT6+FOH9ZH4uy0gam/xQX2HNZHLkK
	 zVJd6EhupJJ2Lp1HLrzGLAxiryIIFrtdfQhVOWswT+GkqywG13vO4+PYIoEKE0M/QA
	 Q4Ra4apzS619NYrlOH/kkeCuUck5AU/rKf205E5QBX7Jb23x0dN5ik0jSja23190lF
	 7tBkrV/SBae+XHGJ40TJVXtpbfubY0bMoqCAyxYYlRQccbODpJdfLnJ5kjbFx8i/Y5
	 VeEPTEoaAK2g/USs7uw2xAQhCRoUO4gbBVHPA0rD5pqMn+uAC7g1zCM0nhN3k4Suxp
	 gJ79o6ONM6ZRg==
Date: Mon, 19 Aug 2024 10:41:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Tycho Andersen <tandersen@netflix.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Tejun Heo <tj@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] pidfd: prevent creation of pidfds for kthreads
Message-ID: <20240819-staudamm-rederei-cb7092f54e76@brauner>
References: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>
 <20240818035818.GA1929@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="iq3ob3y54mfyyhoy"
Content-Disposition: inline
In-Reply-To: <20240818035818.GA1929@sol.localdomain>


--iq3ob3y54mfyyhoy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sat, Aug 17, 2024 at 08:58:18PM GMT, Eric Biggers wrote:
> Hi Christian,
> 
> On Wed, Jul 31, 2024 at 12:01:12PM +0200, Christian Brauner wrote:
> > It's currently possible to create pidfds for kthreads but it is unclear
> > what that is supposed to mean. Until we have use-cases for it and we
> > figured out what behavior we want block the creation of pidfds for
> > kthreads.
> > 
> > Fixes: 32fcb426ec00 ("pid: add pidfd_open()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  kernel/fork.c | 25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> Unfortunately this commit broke systemd-shutdown's ability to kill processes,
> which makes some filesystems no longer get unmounted at shutdown.
> 
> It looks like systemd-shutdown relies on being able to create a pidfd for any
> process listed in /proc (even a kthread), and if it gets EINVAL it treats it a
> fatal error and stops looking for more processes...

Thanks for the report!
I talked to Daan De Meyer who made that change and he said that this
must a systemd version that hasn't gotten his fixes yet. In any case, if
this causes regression then I'll revert it right now. See the appended
revert.

--iq3ob3y54mfyyhoy
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-Revert-pidfd-prevent-creation-of-pidfds-for-kthreads.patch"

From 780d60bac21ebee5c2465d21fe51b67bb9b054db Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 19 Aug 2024 10:38:23 +0200
Subject: [PATCH] Revert "pidfd: prevent creation of pidfds for kthreads"

This reverts commit 3b5bbe798b2451820e74243b738268f51901e7d0.

Eric reported that systemd-shutdown gets broken by blocking the creating
of pidfds for kthreads as older versions seems to rely on being able to
create a pidfd for any process in /proc.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Link: https://lore.kernel.org/r/20240818035818.GA1929@sol.localdomain
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/fork.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 18bdc87209d0..cc760491f201 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2053,23 +2053,10 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  */
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
 {
-	if (!pid)
-		return -EINVAL;
-
-	scoped_guard(rcu) {
-		struct task_struct *tsk;
-
-		if (flags & PIDFD_THREAD)
-			tsk = pid_task(pid, PIDTYPE_PID);
-		else
-			tsk = pid_task(pid, PIDTYPE_TGID);
-		if (!tsk)
-			return -EINVAL;
+	bool thread = flags & PIDFD_THREAD;
 
-		/* Don't create pidfds for kernel threads for now. */
-		if (tsk->flags & PF_KTHREAD)
-			return -EINVAL;
-	}
+	if (!pid || !pid_has_task(pid, thread ? PIDTYPE_PID : PIDTYPE_TGID))
+		return -EINVAL;
 
 	return __pidfd_prepare(pid, flags, ret);
 }
@@ -2416,12 +2403,6 @@ __latent_entropy struct task_struct *copy_process(
 	if (clone_flags & CLONE_PIDFD) {
 		int flags = (clone_flags & CLONE_THREAD) ? PIDFD_THREAD : 0;
 
-		/* Don't create pidfds for kernel threads for now. */
-		if (args->kthread) {
-			retval = -EINVAL;
-			goto bad_fork_free_pid;
-		}
-
 		/* Note that no task has been attached to @pid yet. */
 		retval = __pidfd_prepare(pid, flags, &pidfile);
 		if (retval < 0)
-- 
2.43.0


--iq3ob3y54mfyyhoy--

