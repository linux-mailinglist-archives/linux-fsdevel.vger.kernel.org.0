Return-Path: <linux-fsdevel+bounces-49224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DA8AB9983
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 11:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B353167519
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 09:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE36B2367AF;
	Fri, 16 May 2025 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyBoMusI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BE9231836;
	Fri, 16 May 2025 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389280; cv=none; b=muGvkjV4T9Tz4IPWXGsuNdQrFo+uvDX1oCEcSLA3GOMZxdeuiWQU2YC0bw6Zsn/fKIkP2UvQIF2fZEHPh1PCkMKpn6GD0ObAQQcCW7+/vmHsQ7ZSAeBIdFZMkL64D+YP2gkf0aoMHKcTUdugkFO0otdXYRdTTBlNHTO+E+mE9rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389280; c=relaxed/simple;
	bh=cNGzEGia25lZqXsVStZ30M0Gmy1ujfz1B+xpH/pyz5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyPFDknRmyNbcDxBIHgNjRqu/00Yl6g4M4bpPvzET42JBtK/PToz+wBWnvcgugFrEqhwzY8CvZZHU1o6VFWub+DjKEwO2Y0dylOTPEM6LecOEsQUXLUr6JHQPqcgQoxw2IrnCk9JcbsC+Ec7jcCTI2cP/72FN18oUaEeH6S9W2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyBoMusI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F119C4CEEF;
	Fri, 16 May 2025 09:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747389280;
	bh=cNGzEGia25lZqXsVStZ30M0Gmy1ujfz1B+xpH/pyz5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uyBoMusII2b45lXUcrViChhqP2cU17fdLv6zVDaxw8Kajvy9Xy27efVSKrlc7/mCZ
	 rQaK+BzjNKV0+/XLrIACWcbBCkcehhGXdeuP3numrDxQ6bvbUG/NYX4jJGoK02VYL1
	 WwLFlY5IX22Jf+cGS7H+XMZLPwJIpKIKPf2FyjvmPpD+98eZ0Hop9w691xyyIGAIrL
	 jFEBwrap/t9Zwf7UkWrwJImzEvaX0/yNGFatq5AQPED4C5uBGIdSnvMmlFceoZ7qfX
	 nbZ7FR70pp159O4JwpFKLBZXp6/t05ro6vNYmjTeOS7fYtVWEq8AvlwYlWcRwIM2Ww
	 JvZZtln9UGzgw==
Date: Fri, 16 May 2025 11:54:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: linux-fsdevel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Eric Dumazet <edumazet@google.com>, 
	Oleg Nesterov <oleg@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v7 7/9] coredump: validate socket name as it is written
Message-ID: <20250516-planen-radar-2131a4b7d9b1@brauner>
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
 <20250515-work-coredump-socket-v7-7-0a1329496c31@kernel.org>
 <CAG48ez1wqbOmQMqg6rH4LNjNifHU_WciceO_SQwu8T=tA_KxLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1wqbOmQMqg6rH4LNjNifHU_WciceO_SQwu8T=tA_KxLw@mail.gmail.com>

On Thu, May 15, 2025 at 10:56:51PM +0200, Jann Horn wrote:
> On Thu, May 15, 2025 at 12:04 AM Christian Brauner <brauner@kernel.org> wrote:
> > In contrast to other parameters written into
> > /proc/sys/kernel/core_pattern that never fail we can validate enabling
> > the new AF_UNIX support. This is obviously racy as hell but it's always
> > been that way.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Reviewed-by: Jann Horn <jannh@google.com>
> 
> > ---
> >  fs/coredump.c | 37 ++++++++++++++++++++++++++++++++++---
> >  1 file changed, 34 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index 6ee38e3da108..d4ff08ef03e5 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> > @@ -1228,13 +1228,44 @@ void validate_coredump_safety(void)
> >         }
> >  }
> >
> > +static inline bool check_coredump_socket(void)
> > +{
> > +       if (core_pattern[0] != '@')
> > +               return true;
> > +
> > +       /*
> > +        * Coredump socket must be located in the initial mount
> > +        * namespace. Don't give the that impression anything else is
> > +        * supported right now.
> > +        */
> > +       if (current->nsproxy->mnt_ns != init_task.nsproxy->mnt_ns)
> > +               return false;
> 
> (Ah, dereferencing init_task.nsproxy without locks is safe because
> init_task is actually the boot cpu's swapper/idle task, which never
> switches namespaces, right?)

I would be very worried if it did. It would fsck everyone over that
relies on copying its credentials and assumes that the set of namespaces
is stable.

> 
> > +       /* Must be an absolute path. */
> > +       if (*(core_pattern + 1) != '/')
> > +               return false;
> > +
> > +       return true;
> > +}
> > +
> >  static int proc_dostring_coredump(const struct ctl_table *table, int write,
> >                   void *buffer, size_t *lenp, loff_t *ppos)
> >  {
> > -       int error = proc_dostring(table, write, buffer, lenp, ppos);
> > +       int error;
> > +       ssize_t retval;
> > +       char old_core_pattern[CORENAME_MAX_SIZE];
> > +
> > +       retval = strscpy(old_core_pattern, core_pattern, CORENAME_MAX_SIZE);
> > +
> > +       error = proc_dostring(table, write, buffer, lenp, ppos);
> > +       if (error)
> > +               return error;
> > +       if (!check_coredump_socket()) {
> 
> (non-actionable note: This is kiiinda dodgy under
> SYSCTL_WRITES_LEGACY, but I guess we can assume that new users of the
> new coredump socket feature aren't actually going to write the
> coredump path one byte at a time, so I guess it's fine.)

So this is all kinds of broken already imho. Because there's not really
mutual exclusion between multiple writers to such sysctls from what I
remember. Which means that this buffer can be trampled in all kinds of
ways if multiple tasks decide to update it at the same time. That's
super unlikely of course but whatever.

> 
> > +               strscpy(core_pattern, old_core_pattern, retval + 1);
> 
> The third strscpy() argument is semantically supposed to be the
> destination buffer size, not the amount of data to copy. For trivial
> invocations like here, strscpy() actually allows you to leave out the
> third argument.

Eeeeewww, that's really implicit behavior. I can use the destination
buffer size but given that retval will always be smaller than that I
didn't bother but ok. I'll fix that in-tree.

