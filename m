Return-Path: <linux-fsdevel+bounces-7790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AE582AC22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 11:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3FFC286CC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 10:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BA514ABB;
	Thu, 11 Jan 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUhIsvrg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F94B1426C;
	Thu, 11 Jan 2024 10:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1BAC433F1;
	Thu, 11 Jan 2024 10:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704969504;
	bh=9EOmjQDZJMOYZwBf+zTXWPSyzLoE/NShKnrhD8OO7DE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tUhIsvrg5aXxGvXXwrEA9wo6mFfRrfgoUpw+tzGcgBNt28jf9FKh6y1+hW3Y6xD0w
	 Rq/9cm6LgR4AM5v2qhxHvAYPkHhkfWca1isGUKc+YlGUXwk7YektpOONrnG/syt6GH
	 SNg8pweDObB/uZVA9kpCQXqpV6C2Uqyp+FLHz0NSOyr2PgTFWIUB560TX//8TohfhU
	 0UwApFT9GpRjvtwKiN61o3zwxpyAa3FokRCFfinHwgEbxnb9aYwVHYkrIUEHep9y4m
	 7d2NRotXBA3bHHWIAvO7y7aAyrmL1JMos7o5GhawxHDwkm42WyFkEJkmzYvVPfGboK
	 3dZiQddmHgwKA==
Date: Thu, 11 Jan 2024 11:38:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
Message-ID: <20240111-amten-stiefel-043027f9520f@brauner>
References: <20240103222034.2582628-1-andrii@kernel.org>
 <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
 <CAEf4Bzb6jnJL98SLPJB7Vjxo_O33W8HjJuAsyP3+6xigZtsTkA@mail.gmail.com>
 <20240108-gasheizung-umstand-a36d89ed36b7@brauner>
 <CAEf4Bzb+7NzYs5ScggtgAJ6A5-oU5GymvdoEbpfNVOG-XmWZig@mail.gmail.com>
 <20240109-tausend-tropenhelm-2a9914326249@brauner>
 <CAEf4BzaAoXYb=qnj6rvDw8VewhvYNrs5oxe=q7VBe0jjWXivhg@mail.gmail.com>
 <20240110-nervt-monopol-6d307e2518f4@brauner>
 <CAEf4BzYOU5ZVqnTDTEmrHL-+tYY76kz4LO_0XauWibnhtzCFXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzYOU5ZVqnTDTEmrHL-+tYY76kz4LO_0XauWibnhtzCFXg@mail.gmail.com>

> > The current check is inconsisent. It special-cases init_user_ns. The
> > correct thing to do for what you're intending imho is:
> >
> > bool bpf_token_capable(const struct bpf_token *token, int cap)
> > {
> >         struct user_namespace *userns = &init_user_ns;
> >
> >         if (token)
> >                 userns = token->userns;
> >         if (ns_capable(userns, cap))
> >                 return true;
> >         return cap != CAP_SYS_ADMIN && ns_capable(userns, CAP_SYS_ADMIN))
> >
> > }
> 
> Unfortunately the above becomes significantly more hairy when LSM
> (security_bpf_token_capable) gets involved, while preserving the rule
> "if token doesn't give rights, fall back to init userns checks".

Why? Please explain your reasoning in detail.

> 
> I'm happy to accommodate any implementation of bpf_token_capable() as
> long as it behaves as discussed above and also satisfies Paul's
> requirement that capability checks should happen before LSM checks.
> 
> >
> > Because any caller located in an ancestor user namespace of
> > token->user_ns will be privileged wrt to the token's userns as long as
> > they have that capability in their user namespace.
> 
> And with `current_user_ns() == token->userns` check we won't be using
> token->userns while the caller is in ancestor user namespace, we'll
> use capable() check, which will succeed only in init user_ns, assuming
> corresponding CAP_xxx is actually set.

Why? This isn't how any of our ns_capable() logic works.

This basically argues that anyone in an ancestor user namespace is not
allowed to operate on any of their descendant child namespaces unless
they are in the init_user_ns.

But that's nonsense as I'm trying to tell you. Any process in an
ancestor user namespace that is privileged over the child namespace can
just setns() into it and then pass that bpf_token_capable() check by
supplying the token.

At this point just do it properly and allow callers that are privileged
in the token user namespace to load bpf programs. It also means you get
user namespace nesting done properly.

> 
> >
> > For example, if the caller is in the init_user_ns and permissions
> > for CAP_WHATEVER is checked for in token->user_ns and the caller has
> > CAP_WHATEVER in init_user_ns then they also have it in all
> > descendant user namespaces.
> 
> Right, so if they didn't use a token they would still pass
> capable(CAP_WHATEVER), right?

Yes, I'm trying to accomodate your request but making it work
consistently.

> 
> >
> > The original intention had been to align with what we require during
> > token creation meaning that once a token has been created interacting
> > with this token is specifically confined to caller's located in the
> > token's user namespace.
> >
> > If that's not the case then it doesn't make sense to not allow
> > permission checking based on regular capability semantics. IOW, why
> > special case init_user_ns if you're breaking the confinement restriction
> > anyway.
> 
> I'm sorry, perhaps I'm dense, but with `current_user_ns() ==
> token->userns` check I think we do fulfill the intention to not allow
> using a token in a userns different from the one in which it was
> created. If that condition isn't satisfied, the token is immediately

My request originally was about never being able to interact with a
token outside of that userns. This is different as you provide an escape
hatch to init_user_ns. But if you need that and ignore the token then
please do it properly. That's what I'm trying to tell you. See below.

> ignored. So you can't use a token from another userns for anything,
> it's just not there, effectively.
> 
> And as I tried to explain above, I do think that ignoring the token
> instead of erroring out early is what we want to provide good
> user-space ecosystem integration of BPF token.

There is no erroring out early in. It's:

(1) Has a token been provided and is the caller capable wrt to the
    namespace of the token? Any caller in an ancestor user namespace
    that has the capability in that user namespace is capable wrt to
    that token. That __includes__ a callers in the init_user_ns. IOW,
    you don't need to fallback to any special checking for init_user_ns.
    It is literally covered in the if (token) branch with the added
    consistency that a process in an ancestor user namespace is
    privileged wrt to that token as well.

(2) No token has been provided. Then do what we always did and perform
    the capability checks based on the initial user namespace.

The only thing that you then still need is add that token_capable() hook
in there:

bool bpf_token_capable(const struct bpf_token *token, int cap)
{
	bool has_cap;
        struct user_namespace *userns = &init_user_ns;

        if (token)
                userns = token->userns;
        if (ns_capable(userns, cap))
                return true;
        if (cap != CAP_SYS_ADMIN && ns_capable(userns, CAP_SYS_ADMIN))
		return token ? security_bpf_token_capable(token, cap) == 0 : true;
	return false;
}

Or write it however you like. I think this is way more consistent and
gives you a more flexible permission model.

