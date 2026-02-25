Return-Path: <linux-fsdevel+bounces-78383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAqrEUgWn2nWYwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 16:33:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC91199AA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 16:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40FE730518D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDF734EF05;
	Wed, 25 Feb 2026 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phikrZyf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CE33C196C;
	Wed, 25 Feb 2026 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033580; cv=none; b=L7QmKn/wrUAN8t9nf6YVedLroEhMW6s8+Pb+Raw+kDY/AdLzxo2JMWpdymhqoJIYHGEMUBAKtKBjhgzJJmxdZNVwIqMcXYIsgk1R8xoDpBwAeajlQpoxUddBdregsb2CIH+HirWSMvfydzvXYxGtx7Ea4D+9jMF+VstbNy8XkGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033580; c=relaxed/simple;
	bh=ejv/mRfUbXF468CIc489ioG34KPLb26wLd92zAG+CRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dn95FXsYULZsf/gqE4CFfZJNByyILt76VpusO6sB1dJ5hWV1P3lkTzqIPaltwA5jS6WBP8wnWnoW99RcfpPZu6Zf1IeskRHU5a9kmhblFUnf6lrX2ob5Lxc/OCe0OY+XTHqzktqQu7yH2zpefLwlleL3o3kMpXsCSc77HB/Ost8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phikrZyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C07BC2BC86;
	Wed, 25 Feb 2026 15:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772033580;
	bh=ejv/mRfUbXF468CIc489ioG34KPLb26wLd92zAG+CRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=phikrZyfZDggoQS1T8Y7FHRJn2vB0PtL7Mx8GSnanznYzwl59wcufHUR+Uvem8pzG
	 ECfzYgh06RpyfJ6RbAyTch0dEAbSWf1aJIxKX4/MxM9kfdPkXG97PT/GXSRl8uNgwM
	 TylyHHBx1sxbH5MFCZeCY+tmUJaYrJenXII/rTmlCYBujnX5dTQxFIYu7nN/QwvEcu
	 l9uLmRGuiRIgQo52U2aOuiOrfoHbb06XGfqPTu3+5EPXspiUiXdX+8nwVTzZmNhcJ6
	 mWQWirc7iJme5Kw0OLEh2F7llId+1+JU9vswl8GQfigZIgbL6FJwoD7J7eog1RezRt
	 laSlpriqu5MXg==
Date: Wed, 25 Feb 2026 16:32:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 1/2] pidfs: add inode ownership and permission
 checks
Message-ID: <20260225-ziellinie-albatros-b589b713de8a@brauner>
References: <20260223-work-pidfs-inode-owner-v3-0-490855c59999@kernel.org>
 <20260223-work-pidfs-inode-owner-v3-1-490855c59999@kernel.org>
 <CAG48ez10oDKLBRfM-Tc9Bj6AXEEY+PECPSP=Dr96vAu9GnWELQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez10oDKLBRfM-Tc9Bj6AXEEY+PECPSP=Dr96vAu9GnWELQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78383-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BEC91199AA2
X-Rspamd-Action: no action

> > +static int pidfs_permission(struct mnt_idmap *idmap, struct inode *inode,
> > +                           int mask)
> > +{
> > +       struct pid *pid = inode->i_private;
> > +       struct task_struct *task;
> > +       const struct cred *cred;
> > +       u64 pid_tg_ino;
> > +
> > +       scoped_guard(rcu) {
> > +               task = pid_task(pid, PIDTYPE_PID);
> > +               if (task) {
> > +                       if (unlikely(task->flags & PF_KTHREAD))
> > +                               return -EPERM;
> > +
> > +                       cred = __task_cred(task);
> > +                       pid_tg_ino = task_tgid(task)->ino;
> 
> Can this NULL deref if the task concurrently gets reaped and has
> detach_pid() called on it?

So the thread-group leader task/pid is kept around until all subthreads
have exited. That's what delay_group_leader() does. So two cases:

(1) So if @task wasn't a thread-group leader but a subthread then
    task_tgid(task) cannot be NULL.

(2) If @task is itself a thread-group leader then yes, it's possible via
    __unhash_process().

So yeah, this needs handling.

> > +               } else {
> > +                       struct pidfs_attr *attr;
> > +
> > +                       attr = READ_ONCE(pid->attr);
> > +                       VFS_WARN_ON_ONCE(!attr);
> > +                       /*
> > +                        * During copy_process() with CLONE_PIDFD the
> > +                        * task hasn't been attached to the pid yet so
> > +                        * pid_task() returns NULL and there's no
> > +                        * exit_cred as the task obviously hasn't
> > +                        * exited. Use the parent's credentials.
> > +                        */
> > +                       cred = attr->exit_cred;
> > +                       if (!cred)
> > +                               cred = current_cred();
> > +                       pid_tg_ino = attr->exit_tgid_ino;
> > +               }
> > +
> > +               /*
> > +                * If the caller and the target are in the same
> > +                * thread-group or the caller can signal the target
> > +                * we're good.
> > +                */
> > +               if (pid_tg_ino != task_tgid(current)->ino &&
> > +                   !may_signal_creds(current_cred(), cred))
> > +                       return -EPERM;
> > +
> > +               /*
> > +                * This is racy but not more racy then what we generally
> > +                * do for permission checking.
> > +                */
> > +               WRITE_ONCE(inode->i_uid, cred->euid);
> > +               WRITE_ONCE(inode->i_gid, cred->egid);
> 
> I realize that using ->euid here matches what procfs does in
> task_dump_owner(), but it doesn't make sense to me. The EUID is kinda
> inherently "subjective" and doesn't really make sense in a context
> like this where we're treating the process as an object. See also how,
> when sending a signal to a process, kill_ok_by_cred() doesn't care
> about the EUID of the target process, because it would be silly to
> allow a user to send signals to a fileserver that happens to briefly
> call seteuid() to access the filesystem in the name of the user, or
> something like that.
> 
> The thing that IMO most expresses the objective identity of a process
> is the RUID (notably that includes that it stays the same across
> setuid execution unless the process explicitly changes RUID).
> 
> I think this should be using cred->uid and cred->gid so that the
> permission check below makes more sense. That said, if you want to
> instead follow the precedent of procfs and rely on the more explicit
> permission checks above to actually provide security, I guess that
> works too...
> 
> > +       }
> > +       return generic_permission(&nop_mnt_idmap, inode, mask);
> > +}
> [...]
> >  {
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index d65d0fe24bfb..e20dabf143c2 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -777,19 +777,22 @@ static inline bool si_fromuser(const struct kernel_siginfo *info)
> >                 (!is_si_special(info) && SI_FROMUSER(info));
> >  }
> >
> > +bool may_signal_creds(const struct cred *signaler_cred,
> > +                     const struct cred *signalee_cred)
> > +{
> > +       return uid_eq(signaler_cred->euid, signalee_cred->suid) ||
> > +              uid_eq(signaler_cred->euid, signalee_cred->uid) ||
> > +              uid_eq(signaler_cred->uid, signalee_cred->suid) ||
> > +              uid_eq(signaler_cred->uid, signalee_cred->uid) ||
> > +              ns_capable(signalee_cred->user_ns, CAP_KILL);
> > +}
> 
> I don't like reusing the signal sending permission checks here - in my
> opinion, filesystem operations shouldn't be allowed based on the
> caller's *RUID*. They should ideally be using the caller's FSUID.

Ok, a combined model sounds great to me based on ruid/rgid of the target
task and the fsuid/fsgid of the caller.

