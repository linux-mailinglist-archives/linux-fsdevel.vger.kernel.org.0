Return-Path: <linux-fsdevel+bounces-78243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOESH4SJnWnBQQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:20:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29590186161
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C97D131822B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B150137C0FC;
	Tue, 24 Feb 2026 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wxf1lCXl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA46137BE91;
	Tue, 24 Feb 2026 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931936; cv=none; b=Ldl3Iq5xQJ5pc55x5JMuVhJ5bhp7oDGHXZvDED4pPscpgAt9JJhNSD2W+iQrz9utC8vndy+N7Q9y32EKv2aoigXY3myLQIj4Qccd1xhzNDTKGp4TsXoh6TprJLGoc0YjqkiSJvBGrdpqwy4O/OTM+XYeEoTkipsLbOwrFRd43z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931936; c=relaxed/simple;
	bh=CATKDKa2uGpd7sHZMSNUih88RUZlznJauHdO/GUeTF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjWew3+v3xljY8KSLFkqd3i6TazsdCwMefn3Pws/rRjkbKaNDXt1224rrhkWTGB4hYGRRxshDgi3rJUz73UiFT6a5PmoeEx4N3xoNKXNIsDfg1AB3oXTmgUG0HeLIEtgFvGhYELUfcGeu730HOnhBP/Sb+7PoPnl9RSkqGy5Z6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wxf1lCXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C26C19424;
	Tue, 24 Feb 2026 11:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771931936;
	bh=CATKDKa2uGpd7sHZMSNUih88RUZlznJauHdO/GUeTF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wxf1lCXl+lJ0Co7kXivrfwAqGXijzoffhjR9eZU+NmPDftcplF9o3Qsw5NFAiBIhR
	 0kIMnNjSYLlwFUxNvP9VY0YhI0gn06UvM2j05Z5DYQeDJJfkYTrB0xoAin3gEKBNeJ
	 UvoI7s+Rvujr5r/TOT9tKA5/v+VslFKJXjdQCzobvuGAfg1Ggw9ezB1Z8/ZICGQAFd
	 bwhMnOqnAK7amG7auTuDHZ6m+D4WfEgI54SYKfP1d3mCn6NYw4EmvNnIqmdjKDulx2
	 4QpTGbSOdVsr8mHI3+zrBbM4Yar3zCS2W5f0rTEfJwIS+YZjalFEh+7IZo/2drV9HZ
	 UiaoNkcmBtyEA==
Date: Tue, 24 Feb 2026 12:18:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Daniel Durning <danieldurning.work@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, paul@paul-moore.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH] fs/pidfs: Add permission check to pidfd_info()
Message-ID: <20260224-wohle-abarbeiten-25effeed0479@brauner>
References: <20260206180248.12418-1-danieldurning.work@gmail.com>
 <20260209-spanplatten-zerrt-73851db30f18@brauner>
 <CAKrb_fEXR0uQnX5iK-ACH=amKMQ8qBSPGXmJb=1PgvEq8qsDEQ@mail.gmail.com>
 <20260217-abgedankt-eilte-2386c98b3ef7@brauner>
 <CAKrb_fFEvf5VzY_-zcc800wjVGOFbiGrpzC7S6Ghy9qhYJrZ1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKrb_fFEvf5VzY_-zcc800wjVGOFbiGrpzC7S6Ghy9qhYJrZ1w@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78243-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,suse.cz,paul-moore.com,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29590186161
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 03:45:00PM -0500, Daniel Durning wrote:
> On Tue, Feb 17, 2026 at 7:01 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Wed, Feb 11, 2026 at 02:43:21PM -0500, Daniel Durning wrote:
> > > On Mon, Feb 9, 2026 at 9:01 AM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Fri, Feb 06, 2026 at 06:02:48PM +0000, danieldurning.work@gmail.com wrote:
> > > > > From: Daniel Durning <danieldurning.work@gmail.com>
> > > > >
> > > > > Added a permission check to pidfd_info(). Originally, process info
> > > > > could be retrieved with a pidfd even if proc was mounted with hidepid
> > > > > enabled, allowing pidfds to be used to bypass those protections. We
> > > > > now call ptrace_may_access() to perform some DAC checking as well
> > > > > as call the appropriate LSM hook.
> > > > >
> > > > > The downside to this approach is that there are now more restrictions
> > > > > on accessing this info from a pidfd than when just using proc (without
> > > > > hidepid). I am open to suggestions if anyone can think of a better way
> > > > > to handle this.
> > > >
> > > > This isn't really workable since this would regress userspace quite a
> > > > bit. I think we need a different approach. I've given it some thought
> > > > and everything's kinda ugly but this might work.
> > > >
> > > > In struct pid_namespace record whether anyone ever mounted a procfs
> > > > with hidepid turned on for this pidns. In pidfd_info() we check whether
> > > > hidepid was ever turned on. If it wasn't we're done and can just return
> > > > the info. This will be the common case. If hidepid was ever turned on
> > > > use kern_path("/proc") to lookup procfs. If not found check
> > > > ptrace_may_access() to decide whether to return the info or not. If
> > > > /proc is found check it's hidepid settings and make a decision based on
> > > > that.
> > > >
> > > > You can probably reorder this to call ptrace_may_access() first and then
> > > > do the procfs lookup dance. Thoughts?
> > >
> > > Thanks for the feedback. I think your solution makes sense.
> > >
> > > Unfortunately, it seems like systemd mounts procfs with hidepid enabled on
> > > boot for services with the ProtectProc option enabled. This means that
> > > procfs will always have been mounted with hidepid in the init pid namespace.
> > > Do you think it would be viable to record whether or not procfs was mounted
> > > with hidepid enabled in the mount namespace instead?
> >
> > I guess we can see what it looks like.
> 
> Having looked into this some more I am not sure if the mount
> namespace is viable either since a single proc instance could be in
> multiple mount namespaces. In addition the mount namespace
> does not seem to be easily accessible in the function where proc
> mount options are applied. I also considered adding an option
> similar to hidepid to pidfs, but since pidfs is not userspace-mounted
> I do not think that is possible without some significant changes.
> 
> Doing a proc lookup with kern_path() does work, but it does not seem
> practical in terms of performance unless we had some other way to
> skip it in the common case.
> 
> Curious if anyone else has any ideas or suggestions on how this
> could be implemented.

Ok, so there's another series that adds support for allowing to mount
procfs with subset=pid. That series currently uses an arcane mechanism
where it walks all mounts in the caller mounts namespace to find procfs
mounts and check its mount options (mount_too_revealing()). To get away
from this barbaric hack I proposed recording all fully visible procfs
mounts in a separate list on struct mnt_namespace that it can walk
whenever a new procfs mount gets plugged in. Once we've done that work
we effectively track whenever a procfs mount comes and goes from a given
mount namespace. When we plug in that mount we simply remember the
option used for the least restrictive procfs mount in that namespace in
a per-mntns "proc_visiblity" field or something.

Then in pidfs we simply do a:

visibility_restricted = READ_ONCE(current->ns_proxy->mnt_ns);

and be done with it. No locks, no lookup, no perf hit. Thoughts?

