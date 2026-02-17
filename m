Return-Path: <linux-fsdevel+bounces-77358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H9cCaVYlGkXDAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 13:01:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDCE14BB59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 13:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2302301F167
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 12:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9578E336EFE;
	Tue, 17 Feb 2026 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSF4Dk0o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5C32C33D;
	Tue, 17 Feb 2026 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329697; cv=none; b=eYc6IJn7PSswlf6bBd9lZyg3iXWPXReEq7SgPpUxzkSOs+AoX4rMqr9eXmMr1pFFJveRibTHbw6ztoCVqcvN5WEvlViC+jZwGmNM1ajrsbekJE18Ebfkdz8puGihM2ryHmsJFIzWCgp0NV+KKRtAkTPtXGlRmq76tC7Jnr5xlok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329697; c=relaxed/simple;
	bh=87110GAXLqxdBCfG4XAbyUPM+jV4Yr/SrlSTRgKoWfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZ0si+hht5Y0dHKxX8pduvq7jb67DWUOBBQ4q3K5Eke+OEtnoyZJlyvJ+BLDPqX2WNliXqAV7AfvnN9pzKq0QpplTiYtCBUeB2ICCFSIGJyNR5vwD0UOqrvHItvwKlq4eakeCpm+df3RGpPJew7/brWCzC0pIH5SzWpKvFCmepw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSF4Dk0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBF1C4CEF7;
	Tue, 17 Feb 2026 12:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771329696;
	bh=87110GAXLqxdBCfG4XAbyUPM+jV4Yr/SrlSTRgKoWfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSF4Dk0ouulB3cq0WIY+q9T9iqcGGzYebmI8MIRNB2OGqzK5YZm7DwqCxatf9JXrz
	 B2ev5fDIrI7xEDQvmHxbCHSL1juJ4xIk769kkcmXvJjMlxbUu+4eN991G+RF9W2CFF
	 ES5ItpPvf90w5K9ogzdXnEkRBPx3UEgm/9U11C3mtJouO5P0pATiEXkGlgUZ2vj5/K
	 416KGlIX5BQxc/DUlv61Ze25otA2I6m4WP4wDYthPC13977XfhJbZqnEBtf0e+GoNw
	 6Tjpcce+stT2IBHiwfu24s78mXpUREB2PyJTGYgfzzTRYtfiXhKf8oZb+F+QA/LYCm
	 o9M8lz/SWOhoA==
Date: Tue, 17 Feb 2026 13:01:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Daniel Durning <danieldurning.work@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, paul@paul-moore.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH] fs/pidfs: Add permission check to pidfd_info()
Message-ID: <20260217-abgedankt-eilte-2386c98b3ef7@brauner>
References: <20260206180248.12418-1-danieldurning.work@gmail.com>
 <20260209-spanplatten-zerrt-73851db30f18@brauner>
 <CAKrb_fEXR0uQnX5iK-ACH=amKMQ8qBSPGXmJb=1PgvEq8qsDEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKrb_fEXR0uQnX5iK-ACH=amKMQ8qBSPGXmJb=1PgvEq8qsDEQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77358-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,suse.cz,paul-moore.com,gmail.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFDCE14BB59
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 02:43:21PM -0500, Daniel Durning wrote:
> On Mon, Feb 9, 2026 at 9:01 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Feb 06, 2026 at 06:02:48PM +0000, danieldurning.work@gmail.com wrote:
> > > From: Daniel Durning <danieldurning.work@gmail.com>
> > >
> > > Added a permission check to pidfd_info(). Originally, process info
> > > could be retrieved with a pidfd even if proc was mounted with hidepid
> > > enabled, allowing pidfds to be used to bypass those protections. We
> > > now call ptrace_may_access() to perform some DAC checking as well
> > > as call the appropriate LSM hook.
> > >
> > > The downside to this approach is that there are now more restrictions
> > > on accessing this info from a pidfd than when just using proc (without
> > > hidepid). I am open to suggestions if anyone can think of a better way
> > > to handle this.
> >
> > This isn't really workable since this would regress userspace quite a
> > bit. I think we need a different approach. I've given it some thought
> > and everything's kinda ugly but this might work.
> >
> > In struct pid_namespace record whether anyone ever mounted a procfs
> > with hidepid turned on for this pidns. In pidfd_info() we check whether
> > hidepid was ever turned on. If it wasn't we're done and can just return
> > the info. This will be the common case. If hidepid was ever turned on
> > use kern_path("/proc") to lookup procfs. If not found check
> > ptrace_may_access() to decide whether to return the info or not. If
> > /proc is found check it's hidepid settings and make a decision based on
> > that.
> >
> > You can probably reorder this to call ptrace_may_access() first and then
> > do the procfs lookup dance. Thoughts?
> 
> Thanks for the feedback. I think your solution makes sense.
> 
> Unfortunately, it seems like systemd mounts procfs with hidepid enabled on
> boot for services with the ProtectProc option enabled. This means that
> procfs will always have been mounted with hidepid in the init pid namespace.
> Do you think it would be viable to record whether or not procfs was mounted
> with hidepid enabled in the mount namespace instead?

I guess we can see what it looks like.

