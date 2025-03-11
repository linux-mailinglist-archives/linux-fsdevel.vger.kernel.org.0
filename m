Return-Path: <linux-fsdevel+bounces-43731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2905FA5CF5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 20:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0D73ACD79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 19:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770672253AB;
	Tue, 11 Mar 2025 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="OGqAXqyj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5EF264620
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721329; cv=none; b=huINCECf+YzY/T9SbuuLmPu/VAPA0mKmyi+umcUgiSMtsRaP1bKgJuTA+XdTSPQD05fKgm5/+MqZH2UNIigtEcpLoACAb3UR8dxf1VpXlJmcnv+kW63vn4MhG7aPnogQ47HdByVzTcXRexNxdWywKQ01G3Fl+dE8a0LIOehufCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721329; c=relaxed/simple;
	bh=L9WVmmrByJmMkHLyMSjyaSkStTm2YZ66waDHD/4RYoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mb2pVRshHfVDFs4a94Np7K3B/gerqm52/7tqw1uHJ0X8EkooiG6cT50yUAdaP42uk8VfEyQfMpnIlkyBRnEdjZ7KEb63M/8mojlgQ6DGV2zoay3Cd9lYQrp4vNMvTuY3RkrYh26E0cM4hy8RM0C3PZKQ1g5+pH4lYyK1/sM9QfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OGqAXqyj; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZC3hl18v6zDdF;
	Tue, 11 Mar 2025 20:28:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741721319;
	bh=i/pW/+9QjqfvVwGRotMSP8Tl2NV5WZ1ZVJQMlUM6+j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGqAXqyjApZqnwHSY8vhcs/BHqKKeN+61XvBang/xfF7N4ztAMFRKau55hbZazGJ5
	 mhtBg47i4bjckgYuhZgMxVndjfIV0RymhozpKkyPWpLQqAYDs1WM9EfDV4HxUDbIsh
	 XsHJjPjDrAra3B6A7NQ1mMri7+50gOazVlVxk6tc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZC3hk4jryz9Bh;
	Tue, 11 Mar 2025 20:28:38 +0100 (CET)
Date: Tue, 11 Mar 2025 20:28:38 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>, Jann Horn <jannh@google.com>, 
	Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH 4/9] User-space API for creating a supervisor-fd
Message-ID: <20250311.ieX5eex4ieka@digikod.net>
References: <cover.1741047969.git.m@maowtm.org>
 <03d822634936f4c3ac8e4843f9913d1b1fa9d081.1741047969.git.m@maowtm.org>
 <20250305.peiLairahj3A@digikod.net>
 <8f4abea4-d453-4dfe-be02-7a712f90d1a0@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f4abea4-d453-4dfe-be02-7a712f90d1a0@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, Mar 10, 2025 at 12:41:28AM +0000, Tingmao Wang wrote:
> On 3/5/25 16:09, Mickaël Salaün wrote:
> > On Tue, Mar 04, 2025 at 01:13:00AM +0000, Tingmao Wang wrote:
> > > We allow the user to pass in an additional flag to landlock_create_ruleset
> > > which will make the ruleset operate in "supervise" mode, with a supervisor
> > > attached. We create additional space in the landlock_ruleset_attr
> > > structure to pass the newly created supervisor fd back to user-space.
> > > 
> > > The intention, while not implemented yet, is that the user-space will read
> > > events from this fd and write responses back to it.
> > > 
> > > Note: need to investigate if fd clone on fork() is handled correctly, but
> > > should be fine if it shares the struct file. We might also want to let the
> > > user customize the flags on this fd, so that they can request no
> > > O_CLOEXEC.
> > > 
> > > NOTE: despite this patch having a new uapi, I'm still very open to e.g.
> > > re-using fanotify stuff instead (if that makes sense in the end). This is
> > > just a PoC.
> > 
> > The main security risk of this feature is for this FD to leak and be
> > used by a sandboxed process to bypass all its restrictions.  This should
> > be highlighted in the UAPI documentation.
> > 
> > > 
> > > Signed-off-by: Tingmao Wang <m@maowtm.org>
> > > ---
> > >   include/uapi/linux/landlock.h |  10 ++++
> > >   security/landlock/syscalls.c  | 102 +++++++++++++++++++++++++++++-----
> > >   2 files changed, 98 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > > index e1d2c27533b4..7bc1eb4859fb 100644
> > > --- a/include/uapi/linux/landlock.h
> > > +++ b/include/uapi/linux/landlock.h
> > > @@ -50,6 +50,15 @@ struct landlock_ruleset_attr {
> > >   	 * resources (e.g. IPCs).
> > >   	 */
> > >   	__u64 scoped;
> > > +	/**
> > > +	 * @supervisor_fd: Placeholder to store the supervisor file
> > > +	 * descriptor when %LANDLOCK_CREATE_RULESET_SUPERVISE is set.
> > > +	 */
> > > +	__s32 supervisor_fd;
> > 
> > This interface would require the ruleset_attr becoming updatable by the
> > kernel, which might be OK in theory but requires current syscall wrapper
> > signature update, see sandboxer.c change.  It also creates a FD which
> > might not be useful (e.g. if an error occurs before the actual
> > enforcement).
> > 
> > I see a few alternatives.  We could just use/extend the ruleset FD
> > instead of creating a new one, but because leaking current rulesets is
> > not currently a security risk, we should be careful to not change that.
> > 
> > Another approach, similar to seccomp unotify, is to get a
> > "[landlock-domain]" FD returned by the landlock_restrict_self(2) when a
> > new LANDLOCK_RESTRICT_SELF_DOMAIN_FD flag is set.  This FD would be a
> > reference to the newly created domain, which is more specific than the
> > ruleset used to created this domain (and that can be used to create
> > other domains).  This domain FD could be used for introspection (i.e.
> > to get read-only properties such as domain ID), but being able to
> > directly supervise the referenced domain only with this FD would be a
> > risk that we should limit.
> > 
> > What we can do is to implement an IOCTL command for such domain FD that
> > would return a supervisor FD (if the LANDLOCK_RESTRICT_SELF_SUPERVISED
> > flag was also set).  The key point is to check (one time) that the
> > process calling this IOCTL is not restricted by the related domain (see
> > the scope helpers).
> 
> Is LANDLOCK_RESTRICT_SELF_DOMAIN_FD part of your (upcoming?) introspection
> patch? (thinking about when will someone pass that only and not
> LANDLOCK_RESTRICT_SELF_SUPERVISED, or vice versa)

I don't plan to work on such LANDLOCK_RESTRICT_SELF_DOMAIN_FD flag for
now, but the introspection feature(s) would help for this supervisor
feature.

> 
> By the way, is it alright to conceptually relate the supervisor to a domain?
> It really would be a layer inside a domain - the domain could have earlier
> or later layers which can deny access without supervision, or the supervisor
> for earlier layers can deny access first. Therefore having supervisor fd
> coming out of the ruleset felt sensible to me at first.

Good question.  I've been using the name "domain" to refer to the set of
restrictions enforced on a set of processes, but these restrictions are
composed of inherited ones plus the latest layer.  In this case, a
domain FD should refer to all the restrictions, but the supervisor FD
should indeed only refer to the latest layer of a domain (created by
landlock_restrict_self).

> 
> Also, isn't "check that process calling this IOCTL is not restricted by the
> related domain" and the fact that the IOCTL is on the domain fd, which is a
> return value of landlock_restrict_self, kind of contradictory?  I mean it is
> a sensible check, but that kind of highlights that this interface is
> slightly awkward - basically all callers are forced to have a setup where
> the child sends the domain fd back to the parent.

I agree that its confusing.  I'd like to avoid the ruleset to gain any
control on domains after they are created.

Another approach would be to create a supervisor FD with the
landlock_create_ruleset() syscall, and pass this FD to the ruleset,
potentially with landlock_add_rule() calls to only request this
supervisor when matching specific rules (that could potentially be
catch-all rules)?

Overall, my main concern about this patch series is that the supervisor
could get a lot of requests, which will make the sandbox unusable
because always blocked by some thread/process.  This latest approach and
the ability to update the domain somehow could make it workable.

> 
> > 
> > Relying on IOCTL commands (for all these FD types) instead of read/write
> > operations should also limit the risk of these FDs being misused through
> > a confused deputy attack (because such IOCTL command would convey an
> > explicit intent):
> > https://docs.kernel.org/security/credentials.html#open-file-credentials
> > https://lore.kernel.org/all/CAG48ez0HW-nScxn4G5p8UHtYy=T435ZkF3Tb1ARTyyijt_cNEg@mail.gmail.com/
> > We should get inspiration from seccomp unotify for this too:
> > https://lore.kernel.org/all/20181209182414.30862-1-tycho@tycho.ws/
> 
> I think in the seccomp unotify case the problem arises from what the setuid
> binary thinks is just normal data getting interpreted by the kernel as a fd,
> and thus having different effect if the attacker writes it vs. if the suid
> app writes it.  In our case I *think* we should be alright, but maybe we
> should go with ioctl anyway...

I don't see why Jann's attack scenario could work for this Landlock
supervisor too.  The main point that it the read/write interfaces are
used by a lot of different FDs, and we may not need them.

> However, how does using netlink messages (a
> suggestion from a different thread) affect this (if we do end up using it)?
> Would we have to do netlink msgs via IOCTL?

Because all requests should be synchronous, one IOCTL could be used to
both acknowledge a previous event (or just start) and read the next one.

I was thinking about an IOCTL with these arguments:
1. supervisor FD
2. (extensible) IOCTL command (see PIDFD_GET_INFO for instance)
3. pointer to a fixed-size control structure

The fixed-size control structure could contain:
- handled access rights, used to only get event related to specific
  access.
- flags, to specify which kind of FD we would like to get (e.g. only
  directory FD, pidfd...)
- fd[6]: an array of received file descriptors.
- pointer to a variable-size data buffer that would contain all the
  records (e.g. source dir FD, source file name, destination dir FD,
  destination file name) for one event, potentially formatted with NLA.
- the size of this buffer

I'm not sure about the content of this buffer and the NLA format, and
the related API might not be usable without netlink sockets though.
Taking inspiration from the fanotify message format is another option.

> 
> 
> > > +	/**
> > > +	 * @pad: Unused, must be zero.
> > > +	 */
> > > +	__u32 pad;
> > 
> > In this case we should pack the struct instead.
> > 
> > >   };
> > >   /*
> > > @@ -60,6 +69,7 @@ struct landlock_ruleset_attr {
> > >    */
> > >   /* clang-format off */
> > >   #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
> > > +#define LANDLOCK_CREATE_RULESET_SUPERVISE		(1U << 1)
> > >   /* clang-format on */
> > >   /**
> > 
> > [...]
> 
> 

