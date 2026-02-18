Return-Path: <linux-fsdevel+bounces-77558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH2BEbmWlWk1SgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 11:38:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 733CC1558B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 11:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA13630B47B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 10:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053EF2FE05B;
	Wed, 18 Feb 2026 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsgwTny/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E101F239B;
	Wed, 18 Feb 2026 10:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771410076; cv=none; b=aOmHleHn8IyioeRG+ButBzXBRbh+sNr2RhNbTrU9N7jQTLXe7aNWJG7sgGisOEVowcGyCNAoe33FO8ONJjJuFaqd3PKJc6LZdd29dLYmofXfCgJJEPaCO2+a/YANEFSH0CX/VMXZpbHZN1dE5Jq1MU5xUftTmQvxFSuEo+55aYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771410076; c=relaxed/simple;
	bh=hv0749+TPn0XaEpNvtWBOh7j3r+GNA5F74vffeJDUBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehp/IwZ/b8FIjObe6x56v3kuVJuOHVUITtcYuUiiJaPTGbqtas2LK9VJM66Y5Abg2I+8i4YMe3/NFbuaXX9L2D1AyCKDwuAUJ9OcHOxmimAcDWWaJBk2j+cLgvxpBi6g6O0V7bp0oi9T/Ma6ouXX/TwCbCE1JDcsRTd6sKVx6jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsgwTny/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CA4C19421;
	Wed, 18 Feb 2026 10:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771410076;
	bh=hv0749+TPn0XaEpNvtWBOh7j3r+GNA5F74vffeJDUBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RsgwTny/0fZdrwtYDFxjJxHxPRaUb6XHMeP2v/qR3xTnBjCr1oYGlxm6EyqYpmsk8
	 mdRfaZHOa0mPW7ZTyYby8+EiCP17G/SF5ppWRilvWidIkgd/9fzWXBxayqTFgV6DsS
	 tasXiYKosi0KlHZItB7ZQ7LUqQXUn79inKUBf9X0K0FeUzm/O3T+zKLb2wgl+GLBaM
	 E3kCoUuEChu2HN5GvWxSP4eFUMdXv6P5M491zuozgYG4+wHavXsjiYWJ4in27+cnVD
	 2ifFiABTOufYC2czklFfX+nLd1IUmqVTGoAM+gPxI+sJa+5+5s//tdmYBzD7NuPhDc
	 jeCbSRMvsx7kg==
Date: Wed, 18 Feb 2026 11:21:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/4] pidfd: add CLONE_PIDFD_AUTOKILL
Message-ID: <20260218-festhalle-rohstoff-8b1a92750c1c@brauner>
References: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
 <20260217-work-pidfs-autoreap-v3-2-33a403c20111@kernel.org>
 <CAHk-=wj80zwxy=5jp5SAi64cqCZgRjY1cRokVuDPd9_t3XMvUw@mail.gmail.com>
 <CAG48ez2YiL7RZ1fm9vwOCDGr9OsDrCHrCmkyRRoGRMWUZjyyBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2YiL7RZ1fm9vwOCDGr9OsDrCHrCmkyRRoGRMWUZjyyBg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77558-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 733CC1558B1
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:38:02AM +0100, Jann Horn wrote:
> On Wed, Feb 18, 2026 at 12:18 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Tue, 17 Feb 2026 at 14:36, Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > Add a new clone3() flag CLONE_PIDFD_AUTOKILL that ties a child's
> > > lifetime to the pidfd returned from clone3(). When the last reference to
> > > the struct file created by clone3() is closed the kernel sends SIGKILL
> > > to the child.
> >
> > Did I read this right? You can now basically kill suid binaries that
> > you started but don't have rights to kill any other way.
> >
> > If I'm right, this is completely broken. Please explain.
> 
> You can already send SIGHUP to such binaries through things like job
> control, right?
> Do we know if there are setuid binaries out there that change their
> ruid and suid to prevent being killable via kill_ok_by_cred(), then
> set SIGHUP to SIG_IGN to not be killable via job control, and then do
> some work that shouldn't be interrupted?
> 
> Also, on a Linux system with systemd, I believe a normal user, when
> running in the context of a user session (but not when running in the
> context of a system service), can already SIGKILL anything they launch
> by launching it in a systemd user service, then doing something like
> "echo 1 > /sys/fs/cgroup/user.slice/user-$UID.slice/user@$UID.service/app.slice/<servicename>.scope/cgroup.kill"
> because systemd delegates cgroups for anything a user runs to that
> user; and cgroup.kill goes through the codepath
> cgroup_kill_write -> cgroup_kill -> __cgroup_kill -> send_sig(SIGKILL,
> task, 0) -> send_sig_info -> do_send_sig_info
> which, as far as I know, bypasses the normal signal sending permission
> checks. (For comparison, group_send_sig_info() first calls
> check_kill_permission(), then do_send_sig_info().)
> 
> I agree that this would be a change to the security model, but I'm not
> sure if it would be that big a change. I guess an alternative might be
> to instead gate the clone() flag on a `task_no_new_privs(current) ||
> ns_capable()` check like in seccomp, but that might be too restrictive
> for the usecases Christian has in mind...

So I'm going to briefly reiterate what I wrote in my other replies because
I really don't want to get anyone the impression that I don't understand
that this is a change in the security model - It's what I explicitly
wanted to discuss:

  I'm very aware that as written this will allow users to kill setuid
  binaries. I explictly wrote the first RFC so autokill isn't reset during
  bprm->secureexec nor during commit_creds() - in contrast to pdeath
  signal.

I did indeed think of simply using the seccomp model. I have a long
document about all of the different implications for all of this.

Ideally we'd not have to use the seccomp model but if we have to I'm
fine with it. There are two problems I would want to avoid though. Right
now pdeath_signal is reset on _any_ set*id() transition via
commit_creds(). Which makes it really useless.

For example, if you setup a container the child sets pdeath_signal so it
gets auto-killed when the container setup process dies. But as soon as
the child uses set*id() calls to become privileged over the container's
namespaces pdeath_signal magically gets reset. So all container runtimes
have this annoying code in some form:

static int do_start(void *data) /* container workload that gets setup */
{

<snip>

        /* This prctl must be before the synchro, so if the parent dies before
         * we set the parent death signal, we will detect its death with the
         * synchro right after, otherwise we have a window where the parent can
         * exit before we set the pdeath signal leading to a unsupervized
         * container.
         */
        ret = lxc_set_death_signal(SIGKILL, handler->monitor_pid, status_fd);
        if (ret < 0) {
                SYSERROR("Failed to set PR_SET_PDEATHSIG to SIGKILL");
                goto out_warn_father;
        }

<snip>

        /* If we are in a new user namespace, become root there to have
         * privilege over our namespace.
         */
        if (!list_empty(&handler->conf->id_map)) {

<snip>

                /* Drop groups only after we switched to a valid gid in the new
                 * user namespace.
                 */
                if (!lxc_drop_groups() &&
                    (handler->am_root || errno != EPERM))
                        goto out_warn_father;

                if (!lxc_switch_uid_gid(nsuid, nsgid))
                        goto out_warn_father;

                ret = prctl(PR_SET_DUMPABLE, prctl_arg(1), prctl_arg(0),
                            prctl_arg(0), prctl_arg(0));
                if (ret < 0)
                        goto out_warn_father;

                /* set{g,u}id() clears deathsignal */
                ret = lxc_set_death_signal(SIGKILL, handler->monitor_pid, status_fd);
                if (ret < 0) {
                        SYSERROR("Failed to set PR_SET_PDEATHSIG to SIGKILL");
                        goto out_warn_father;
                }

<sip>

I can't stress how useless this often makes pdeath_signal. Let alone
that the child must set it so there's always a race with the parent
dying while the child is setting it. And obviously it isn't just
containers. It's anything that deprivileges itself including some
services.

If we require the seccomp task_no_new_privs() thing I really really
would like to not have to reset autokill during commit_creds().

Because then it is at least consistent for task_no_new_privs() without
magic resets.

TL;DR as long as we can come up with a model where there are no magical
resets of the property by the kernel this is useful.

