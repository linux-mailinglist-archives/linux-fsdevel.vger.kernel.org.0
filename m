Return-Path: <linux-fsdevel+bounces-46246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D23A85B54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 13:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E86188B5C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 11:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521F3238C1D;
	Fri, 11 Apr 2025 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="J69WFbgD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B77278E65
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744370121; cv=none; b=a+ZFHdAcskkZ/ZheIOqiVHRqExrhdhruSRk+DoOqPjt///Nk303P5r32EgI17/nbz4BLqAH1ouGi2QRXarsU3hsowV71c2bzBgVt25Z/LHicTsf0QyDdctZhZ2ygwewXixdD7hIPa868bHXWSre/uFJLOlVTADqluHZEZnN2qyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744370121; c=relaxed/simple;
	bh=8S4Jk9iscNFCKf+wuNW/E0AgL/WAW1VtRt+gKX41yYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=In4s/RB9Go8QRxeFckdQNqSQRMLGYTQ23ZuxvgbcfkUhmQdgR2wPER762NoTeJGoavahEomcgzamwzHTxUE43ZFvaF25YGk3zTeOIW3nw656ogV0XtwYOG5u+zTWQqplKuUYVpgZuxZfIQa8ikvkhWlECPtnLWhI0rChYN5/420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=J69WFbgD; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZYtrQ2wlJzBpd;
	Fri, 11 Apr 2025 12:55:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1744368934;
	bh=EA36yU94bkXA5d/tEsOH0wBIh/yRqDzhGCFcHdU0PrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J69WFbgDmZeN8ZvS26/OSqFyhbCzx6qd7MItslOhgoSlvu68ufYVwlZykzLcOts+Y
	 Tv+XcWYksrjjDa8evLqcxpvWuOB7C1DzqbZGeqOErRY7lRypML3ljwN/MR37Pp3nH1
	 fi+a887bneDqeCLerhrnQaVT1nEzS9Z4BrWuKvBM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZYtrP3GzZzjxh;
	Fri, 11 Apr 2025 12:55:33 +0200 (CEST)
Date: Fri, 11 Apr 2025 12:55:32 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Andy Lutomirski <luto@amacapital.net>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Subject: Re: [RFC PATCH 4/9] User-space API for creating a supervisor-fd
Message-ID: <20250411.aim5yoox5Que@digikod.net>
References: <cover.1741047969.git.m@maowtm.org>
 <03d822634936f4c3ac8e4843f9913d1b1fa9d081.1741047969.git.m@maowtm.org>
 <20250305.peiLairahj3A@digikod.net>
 <8f4abea4-d453-4dfe-be02-7a712f90d1a0@maowtm.org>
 <20250311.ieX5eex4ieka@digikod.net>
 <c96a0cc8-6231-4ca9-94a7-2dbf8de9cdaf@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c96a0cc8-6231-4ca9-94a7-2dbf8de9cdaf@maowtm.org>
X-Infomaniak-Routing: alpha

On Wed, Mar 26, 2025 at 12:06:11AM +0000, Tingmao Wang wrote:
> On 3/11/25 19:28, Mickaël Salaün wrote:
> > On Mon, Mar 10, 2025 at 12:41:28AM +0000, Tingmao Wang wrote:
> > > On 3/5/25 16:09, Mickaël Salaün wrote:
> > > > On Tue, Mar 04, 2025 at 01:13:00AM +0000, Tingmao Wang wrote:
> > > > > We allow the user to pass in an additional flag to landlock_create_ruleset
> > > > > which will make the ruleset operate in "supervise" mode, with a supervisor
> > > > > attached. We create additional space in the landlock_ruleset_attr
> > > > > structure to pass the newly created supervisor fd back to user-space.
> > > > > 
> > > > > The intention, while not implemented yet, is that the user-space will read
> > > > > events from this fd and write responses back to it.
> > > > > 
> > > > > Note: need to investigate if fd clone on fork() is handled correctly, but
> > > > > should be fine if it shares the struct file. We might also want to let the
> > > > > user customize the flags on this fd, so that they can request no
> > > > > O_CLOEXEC.
> > > > > 
> > > > > NOTE: despite this patch having a new uapi, I'm still very open to e.g.
> > > > > re-using fanotify stuff instead (if that makes sense in the end). This is
> > > > > just a PoC.
> > > > 
> > > > The main security risk of this feature is for this FD to leak and be
> > > > used by a sandboxed process to bypass all its restrictions.  This should
> > > > be highlighted in the UAPI documentation.
> 
> In particular, if for some reason the supervisor does a fork without exec,
> it must close this fd in the "about-to-be-untrusted" child.

Yes...

> 
> (I wonder if it would be worth enforcing that the child calling
> landlock_restrict_self must not have any open supervisor fd that can
> supervise its own domain (returning an error if it does), but that can be
> difficult to implement so nevermind)

That would mean that a call can fail according to the caller's context
(e.g. FDs), which is not good for reproducibility (i.e. not idempotent).

Being able to tie a supervisor FD to a set of rulesets and then to a set
of domains is interesting too.  We might want to also add a "cookie"
value when creating a ruleset for the supervisor to identify which
ruleset it received a request from.

I was also thinking about pidfd, but they do not refer to a domain but
to a process (which may be sandboxed several times).  I found a better
idea, see below.

> 
> > > > 
> > > > > 
> > > > > Signed-off-by: Tingmao Wang <m@maowtm.org>
> > > > > ---
> > > > >    include/uapi/linux/landlock.h |  10 ++++
> > > > >    security/landlock/syscalls.c  | 102 +++++++++++++++++++++++++++++-----
> > > > >    2 files changed, 98 insertions(+), 14 deletions(-)
> > > > > 
> > > > > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > > > > index e1d2c27533b4..7bc1eb4859fb 100644
> > > > > --- a/include/uapi/linux/landlock.h
> > > > > +++ b/include/uapi/linux/landlock.h
> > > > > @@ -50,6 +50,15 @@ struct landlock_ruleset_attr {
> > > > >    	 * resources (e.g. IPCs).
> > > > >    	 */
> > > > >    	__u64 scoped;
> > > > > +	/**
> > > > > +	 * @supervisor_fd: Placeholder to store the supervisor file
> > > > > +	 * descriptor when %LANDLOCK_CREATE_RULESET_SUPERVISE is set.
> > > > > +	 */
> > > > > +	__s32 supervisor_fd;
> > > > 
> > > > This interface would require the ruleset_attr becoming updatable by the
> > > > kernel, which might be OK in theory but requires current syscall wrapper
> > > > signature update, see sandboxer.c change.  It also creates a FD which
> > > > might not be useful (e.g. if an error occurs before the actual
> > > > enforcement).
> > > > 
> > > > I see a few alternatives.  We could just use/extend the ruleset FD
> > > > instead of creating a new one, but because leaking current rulesets is
> > > > not currently a security risk, we should be careful to not change that.
> > > > 
> > > > Another approach, similar to seccomp unotify, is to get a
> > > > "[landlock-domain]" FD returned by the landlock_restrict_self(2) when a
> > > > new LANDLOCK_RESTRICT_SELF_DOMAIN_FD flag is set.  This FD would be a
> > > > reference to the newly created domain, which is more specific than the
> > > > ruleset used to created this domain (and that can be used to create
> > > > other domains).  This domain FD could be used for introspection (i.e.
> > > > to get read-only properties such as domain ID), but being able to
> > > > directly supervise the referenced domain only with this FD would be a
> > > > risk that we should limit.
> > > > 
> > > > What we can do is to implement an IOCTL command for such domain FD that
> > > > would return a supervisor FD (if the LANDLOCK_RESTRICT_SELF_SUPERVISED
> > > > flag was also set).  The key point is to check (one time) that the
> > > > process calling this IOCTL is not restricted by the related domain (see
> > > > the scope helpers).
> > > 
> > > Is LANDLOCK_RESTRICT_SELF_DOMAIN_FD part of your (upcoming?) introspection
> > > patch? (thinking about when will someone pass that only and not
> > > LANDLOCK_RESTRICT_SELF_SUPERVISED, or vice versa)
> > 
> > I don't plan to work on such LANDLOCK_RESTRICT_SELF_DOMAIN_FD flag for
> > now, but the introspection feature(s) would help for this supervisor
> > feature.
> > 
> > > 
> > > By the way, is it alright to conceptually relate the supervisor to a domain?
> > > It really would be a layer inside a domain - the domain could have earlier
> > > or later layers which can deny access without supervision, or the supervisor
> > > for earlier layers can deny access first. Therefore having supervisor fd
> > > coming out of the ruleset felt sensible to me at first.
> > 
> > Good question.  I've been using the name "domain" to refer to the set of
> > restrictions enforced on a set of processes, but these restrictions are
> > composed of inherited ones plus the latest layer.  In this case, a
> > domain FD should refer to all the restrictions, but the supervisor FD
> > should indeed only refer to the latest layer of a domain (created by
> > landlock_restrict_self).
> > 
> > > 
> > > Also, isn't "check that process calling this IOCTL is not restricted by the
> > > related domain" and the fact that the IOCTL is on the domain fd, which is a
> > > return value of landlock_restrict_self, kind of contradictory?  I mean it is
> > > a sensible check, but that kind of highlights that this interface is
> > > slightly awkward - basically all callers are forced to have a setup where
> > > the child sends the domain fd back to the parent.
> > 
> > I agree that its confusing.  I'd like to avoid the ruleset to gain any
> > control on domains after they are created.
> > 
> > Another approach would be to create a supervisor FD with the
> > landlock_create_ruleset() syscall, and pass this FD to the ruleset,
> > potentially with landlock_add_rule() calls to only request this
> > supervisor when matching specific rules (that could potentially be
> > catch-all rules)?
> 
> Maybe passing in a fd per landlock_add_rule calls, and thus potentially
> allowing different supervisor fd tied to different rules in the same
> ruleset, is a bit overkill (as now each rule needs to store a supervisor
> pointer?) and I don't really see the use of it.

I though about this approach too but being able to update the domain
with new rules would be more useful and powerful.

> I think it would be better
> to just pass it once in the landlock_ruleset_attr, which gets around the
> signature having const for the ruleset_attr problem. (I'm also open to the
> ioctl on domain fd idea, but I'm slightly wary of making this more
> complicated then necessary for the user space, as it now has to set up a
> socket (?) and pass a fd with scm_rights (?))

OK, here is another proposal: supervisor rulesets and supervisee FDs.
The idea is to add a new flag to landlock_restrict_self(2) to created a
ruleset marked as "supervisor".  This ruleset could not be passed to
landlock_restrict_self(2), but a dedicated IOCTL would create a
supervisee file descriptor.  This supervisee could be passed to a
landlock_ruleset_attr to created a supervised ruleset.

This approach is interesting because it makes it explicit the access
rights which are handled by the supervisor, which enables us to only
supervise a set of actions and update the supervisor ruleset with
landlock_add_rule(2).

Another interesting property is that because we have at least two file
descriptors for a supervisor, it's easy to create a ruleset supervisor
in process A and then only pass a supervisee FD to process B.  A leaked
supervisee FD could not give more privileges, and it is unlikely that a
supervisor FD is passed to process B because it could not be usable as a
supervisee and should then be detected early in the development cycle.

> 
> The other aspect of this is whether we want to have the supervisor mark
> specific rules as supervised, rather than having all denied access (from
> this layer) result in a supervisor invocation.  I also don't think this is
> necessary, as denials are supposed to be "abnormal" in some sense, and I
> would imagine most supervisors would want to find out about these (at least
> to print/show a warning of some sort, if it knows that the requested access
> is bad).  If a supervisor really wants to have the kernel just "silently"
> (from its perspective, but maybe there would be audit logs) deny any access
> outside of some known rules, it can also create a nested, unsupervised
> landlock domain that has the right effect. Avoiding having some sort of
> tri-state rules would simplify implementation, I imagine.

Because this supervisor use case is mainly about sandboxing programs
which may not be aware of such restrictions, they could legitimately
request a lot of time the same denied actions.  To avoid overloading the
supervisor, we need a way to filter such requests.  But being able to
initially get these request would be useful too, which is why being able
to dynamically update the supervisor ruleset is interesting.

> 
> > 
> > Overall, my main concern about this patch series is that the supervisor
> > could get a lot of requests, which will make the sandbox unusable
> > because always blocked by some thread/process.  This latest approach and
> > the ability to update the domain somehow could make it workable.
> > 
> > > 
> > > > 
> > > > Relying on IOCTL commands (for all these FD types) instead of read/write
> > > > operations should also limit the risk of these FDs being misused through
> > > > a confused deputy attack (because such IOCTL command would convey an
> > > > explicit intent):
> > > > https://docs.kernel.org/security/credentials.html#open-file-credentials
> > > > https://lore.kernel.org/all/CAG48ez0HW-nScxn4G5p8UHtYy=T435ZkF3Tb1ARTyyijt_cNEg@mail.gmail.com/
> > > > We should get inspiration from seccomp unotify for this too:
> > > > https://lore.kernel.org/all/20181209182414.30862-1-tycho@tycho.ws/
> > > 
> > > I think in the seccomp unotify case the problem arises from what the setuid
> > > binary thinks is just normal data getting interpreted by the kernel as a fd,
> > > and thus having different effect if the attacker writes it vs. if the suid
> > > app writes it.  In our case I *think* we should be alright, but maybe we
> > > should go with ioctl anyway...
> > 
> > I don't see why Jann's attack scenario could work for this Landlock
> > supervisor too.  The main point that it the read/write interfaces are
> > used by a lot of different FDs, and we may not need them.
> > 
> > > However, how does using netlink messages (a
> > > suggestion from a different thread) affect this (if we do end up using it)?
> > > Would we have to do netlink msgs via IOCTL?
> > 
> > Because all requests should be synchronous, one IOCTL could be used to
> > both acknowledge a previous event (or just start) and read the next one.
> > 
> > I was thinking about an IOCTL with these arguments:
> > 1. supervisor FD
> > 2. (extensible) IOCTL command (see PIDFD_GET_INFO for instance)
> > 3. pointer to a fixed-size control structure
> > 
> > The fixed-size control structure could contain:
> > - handled access rights, used to only get event related to specific
> >    access.
> > - flags, to specify which kind of FD we would like to get (e.g. only
> >    directory FD, pidfd...)
> > - fd[6]: an array of received file descriptors.
> > - pointer to a variable-size data buffer that would contain all the
> >    records (e.g. source dir FD, source file name, destination dir FD,
> >    destination file name) for one event, potentially formatted with NLA.
> > - the size of this buffer
> > 
> > I'm not sure about the content of this buffer and the NLA format, and
> > the related API might not be usable without netlink sockets though.
> > Taking inspiration from the fanotify message format is another option.
> > 
> > > 
> > > 
> > > > > +	/**
> > > > > +	 * @pad: Unused, must be zero.
> > > > > +	 */
> > > > > +	__u32 pad;
> > > > 
> > > > In this case we should pack the struct instead.
> > > > 
> > > > >    };
> > > > >    /*
> > > > > @@ -60,6 +69,7 @@ struct landlock_ruleset_attr {
> > > > >     */
> > > > >    /* clang-format off */
> > > > >    #define LANDLOCK_CREATE_RULESET_VERSION			(1U << 0)
> > > > > +#define LANDLOCK_CREATE_RULESET_SUPERVISE		(1U << 1)
> > > > >    /* clang-format on */
> > > > >    /**
> > > > 
> > > > [...]
> > > 
> > > 
> 
> 

