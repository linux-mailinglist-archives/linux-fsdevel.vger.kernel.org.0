Return-Path: <linux-fsdevel+bounces-77556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFxcBaeOlWl7SQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 11:04:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C14155152
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 11:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F833029789
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 10:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E918C33A9EF;
	Wed, 18 Feb 2026 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ws1aFXsg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F6211A14;
	Wed, 18 Feb 2026 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408838; cv=none; b=J09btQ46i2LzKhLjqonyhc+qUijF4fcr3AMrRYgrop8C1BBMccEW9Eq0G9nswiQryfXz5tsyIkkzbgvJ/F1kDu7I0KuYwozttOzA1WQD9X4k25PzIDdCVfIekMTsNE3kV6WP+B0ImtB/fjlkfvnTVxscg+xWqIT8vuJo9Oruyyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408838; c=relaxed/simple;
	bh=Bvdgrk8F1oPr4SzPe8KgFqDW6CjcaHb8TjxbKGlIK0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pc4QOeUT9jEy60ly94G89Cnamtd9ioU2PzQsZELBsNuiQRAMaDiEPA6UR6bi2XD/JJhbbyctwIPkn8J4S43MSE9cbJ/GNWGII9Tf1SDrGxv4zubj02wOZQ0ajqEmAvQHS1uYwj/vCp10f064tKe+9yaBwtHJXbmENtwQqwKw/co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ws1aFXsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDB9C19421;
	Wed, 18 Feb 2026 10:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771408838;
	bh=Bvdgrk8F1oPr4SzPe8KgFqDW6CjcaHb8TjxbKGlIK0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ws1aFXsgI7ji3pN71/TBbN90pbb8d33w1E2L3mHsZmQBojJd+wmNEsbTNcwTd58rx
	 pAmaeAOObLcyjPhEI0pqxg5m72bUmi8HMy8Xa4FO5C9E+HbK46AVcNAiiCi1dsRHig
	 CqV+z5/fU100+xB/o5JH8QuTCpU6ocYXl4GQX5VAgNLjvUC3O7uQd3Fzypy2PmdIFS
	 86IqE3hp7OIj4ptjiVWWIO2VPH3uQR2G+IvBfXMHZ2MevCe6sumljPIOpkV3czTVFH
	 SynwIjm5N4MM7PSdvxLu1V3vhbd6oaYpP42bObe/SIVu0s3U4jzpsZm/8P24JBAkL+
	 Pahm7j5dUh4AQ==
Date: Wed, 18 Feb 2026 11:00:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/4] pidfd: add CLONE_PIDFD_AUTOKILL
Message-ID: <20260218-liefen-prost-1455830e3759@brauner>
References: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
 <20260217-work-pidfs-autoreap-v3-2-33a403c20111@kernel.org>
 <CAG48ez0RcW2uChBsQOxrQ7ngvJbE_8mDfcXRb5=FCdkQJwKd+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0RcW2uChBsQOxrQ7ngvJbE_8mDfcXRb5=FCdkQJwKd+Q@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77556-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82C14155152
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:43:59AM +0100, Jann Horn wrote:
> On Tue, Feb 17, 2026 at 11:36 PM Christian Brauner <brauner@kernel.org> wrote:
> > Add a new clone3() flag CLONE_PIDFD_AUTOKILL that ties a child's
> > lifetime to the pidfd returned from clone3(). When the last reference to
> > the struct file created by clone3() is closed the kernel sends SIGKILL
> > to the child. A pidfd obtained via pidfd_open() for the same process
> > does not keep the child alive and does not trigger autokill - only the
> > specific struct file from clone3() has this property.
> >
> > This is useful for container runtimes, service managers, and sandboxed
> > subprocess execution - any scenario where the child must die if the
> > parent crashes or abandons the pidfd.
> 
> Idle thought, feel free to ignore:
> In those scenarios, I guess what you'd ideally want would be a way to
> kill the entire process hierarchy, not just the one process that was
> spawned? Unless the process is anyway PID 1 of its own pid namespace.
> But that would probably be more invasive and kind of an orthogonal
> feature...

It's something that I have as an exploration item on a ToDo. :)

> 
> [...]
> > +static int pidfs_file_release(struct inode *inode, struct file *file)
> > +{
> > +       struct pid *pid = inode->i_private;
> > +       struct task_struct *task;
> > +
> > +       guard(rcu)();
> > +       task = pid_task(pid, PIDTYPE_TGID);
> > +       if (task && READ_ONCE(task->signal->autokill_pidfd) == file)
> 
> Can you maybe also clear out the task->signal->autokill_pidfd pointer
> here? It should be fine in practice either way, but theoretically,

Yes, of course.

> with the current code, this equality check could wrongly match if the
> actual autokill file has been released and a new pidfd file has been
> reallocated at the same address... Of course, at worst that would kill
> a task that has already been killed, so it wouldn't be particularly
> bad, but still it's ugly.
> 
> > +               do_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_TGID);
> > +
> > +       return 0;
> > +}
> [...]
> > @@ -2470,8 +2479,11 @@ __latent_entropy struct task_struct *copy_process(
> >         syscall_tracepoint_update(p);
> >         write_unlock_irq(&tasklist_lock);
> >
> > -       if (pidfile)
> > +       if (pidfile) {
> > +               if (clone_flags & CLONE_PIDFD_AUTOKILL)
> > +                       p->signal->autokill_pidfd = pidfile;
> 
> WRITE_ONCE() to match the READ_ONCE() in pidfs_file_release()?

Agreed.

