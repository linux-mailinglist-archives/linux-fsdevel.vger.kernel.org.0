Return-Path: <linux-fsdevel+bounces-7714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BFE829D0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 15:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9172A1F22AE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB65B4BAA0;
	Wed, 10 Jan 2024 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmNYZWkX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D794B5DE;
	Wed, 10 Jan 2024 14:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C086C433F1;
	Wed, 10 Jan 2024 14:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704898761;
	bh=jN81tajpui6V4eb2RtkGuuwbyaDoQFk4BXeGO/rLYtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmNYZWkXeR0H91VtxQzwsUoo2JNqq3drAToGqb1C7UjGVxyF32znhjCnYykIqDp+x
	 MuAe742LFpQqqeoK23k8hXngfBt8MPWwkoYYleaZQNg3VX1oYRTuiKTayB6FpmPWTl
	 yyemxvf3DGVpcPVHCAuAoryqJ/xTC9CP6Ya8xvrREKFdhbVPhJZxNYbrWEoPTxgt6G
	 ghF4qWns0Sg5pRbNH62pyHcl2YSpqgNYZ2sPuQGrUtxLmZcl/25YhvkbMwHB361JQd
	 cnBWdmjhm9AopnhIjtbKAwSLaFhz2JT3u9o5nX3Lc55E0/8ato7Q9iiiv8En0dsWPy
	 f/I9rZdkTe3fg==
Date: Wed, 10 Jan 2024 15:59:16 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
Message-ID: <20240110-nervt-monopol-6d307e2518f4@brauner>
References: <20240103222034.2582628-1-andrii@kernel.org>
 <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
 <CAEf4Bzb6jnJL98SLPJB7Vjxo_O33W8HjJuAsyP3+6xigZtsTkA@mail.gmail.com>
 <20240108-gasheizung-umstand-a36d89ed36b7@brauner>
 <CAEf4Bzb+7NzYs5ScggtgAJ6A5-oU5GymvdoEbpfNVOG-XmWZig@mail.gmail.com>
 <20240109-tausend-tropenhelm-2a9914326249@brauner>
 <CAEf4BzaAoXYb=qnj6rvDw8VewhvYNrs5oxe=q7VBe0jjWXivhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaAoXYb=qnj6rvDw8VewhvYNrs5oxe=q7VBe0jjWXivhg@mail.gmail.com>

On Tue, Jan 09, 2024 at 11:00:24AM -0800, Andrii Nakryiko wrote:
> On Tue, Jan 9, 2024 at 6:52 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Mon, Jan 08, 2024 at 03:58:47PM -0800, Andrii Nakryiko wrote:
> > > On Mon, Jan 8, 2024 at 4:02 AM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Fri, Jan 05, 2024 at 02:18:40PM -0800, Andrii Nakryiko wrote:
> > > > > On Fri, Jan 5, 2024 at 1:45 PM Linus Torvalds
> > > > > <torvalds@linuxfoundation.org> wrote:
> > > > > >
> > > > > > Ok, I've gone through the whole series now, and I don't find anything
> > > > > > objectionable.
> > > > >
> > > > > That's great, thanks for reviewing!
> > > > >
> > > > > >
> > > > > > Which may only mean that I didn't notice something, of course, but at
> > > > > > least there's nothing I'd consider obvious.
> > > > > >
> > > > > > I keep coming back to this 03/29 patch, because it's kind of the heart
> > > > > > of it, and I have one more small nit, but it's also purely stylistic:
> > > > > >
> > > > > > On Wed, 3 Jan 2024 at 14:21, Andrii Nakryiko <andrii@kernel.org> wrote:
> > > > > > >
> > > > > > > +bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > > > > > +{
> > > > > > > +       /* BPF token allows ns_capable() level of capabilities, but only if
> > > > > > > +        * token's userns is *exactly* the same as current user's userns
> > > > > > > +        */
> > > > > > > +       if (token && current_user_ns() == token->userns) {
> > > > > > > +               if (ns_capable(token->userns, cap))
> > > > > > > +                       return true;
> > > > > > > +               if (cap != CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN))
> > > > > > > +                       return true;
> > > > > > > +       }
> > > > > > > +       /* otherwise fallback to capable() checks */
> > > > > > > +       return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> > > > > > > +}
> > > > > >
> > > > > > This *feels* like it should be written as
> > > > > >
> > > > > >     bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > > > >     {
> > > > > >         struct user_namespace *ns = &init_ns;
> > > > > >
> > > > > >         /* BPF token allows ns_capable() level of capabilities, but only if
> > > > > >          * token's userns is *exactly* the same as current user's userns
> > > > > >          */
> > > > > >         if (token && current_user_ns() == token->userns)
> > > > > >                 ns = token->userns;
> > > > > >         return ns_capable(ns, cap) ||
> > > > > >                 (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> > > > > >     }
> > > > > >
> > > > > > And yes, I realize that the function will end up later growing a
> > > > > >
> > > > > >         security_bpf_token_capable(token, cap)
> > > > > >
> > > > > > test inside that 'if (token ..)' statement, and this would change the
> > > > > > order of that test so that the LSM hook would now be done before the
> > > > > > capability checks are done, but that all still seems just more of an
> > > > > > argument for the simplification.
> > > > > >
> > > > > > So the end result would be something like
> > > > > >
> > > > > >     bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > > > >     {
> > > > > >         struct user_namespace *ns = &init_ns;
> > > > > >
> > > > > >         if (token && current_user_ns() == token->userns) {
> > > > > >                 if (security_bpf_token_capable(token, cap) < 0)
> > > > > >                         return false;
> > > > > >                 ns = token->userns;
> > > > > >         }
> > > > > >         return ns_capable(ns, cap) ||
> > > > > >                 (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> > > > > >     }
> > > > >
> > > > > Yep, it makes sense to use ns_capable with init_ns. I'll change those
> > > > > two patches to end up with something like what you suggested here.
> > > > >
> > > > > >
> > > > > > although I feel that with that LSM hook, maybe this all should return
> > > > > > the error code (zero or negative), not a bool for success?
> > > > > >
> > > > > > Also, should "current_user_ns() != token->userns" perhaps be an error
> > > > > > condition, rather than a "fall back to init_ns" condition?
> > > > > >
> > > > > > Again, none of this is a big deal. I do think you're dropping the LSM
> > > > > > error code on the floor, and are duplicating the "ns_capable()" vs
> > > > > > "capable()" logic as-is, but none of this is a deal breaker, just more
> > > > > > of my commentary on the patch and about the logic here.
> > > > > >
> > > > > > And yeah, I don't exactly love how you say "ok, if there's a token and
> > > > > > it doesn't match, I'll not use it" rather than "if the token namespace
> > > > > > doesn't match, it's an error", but maybe there's some usability issue
> > > > > > here?
> > > > >
> > > > > Yes, usability was the primary concern. The overall idea with BPF
> > > >
> > > > NAK on not restricting this to not erroring out on current_user_ns()
> > > > != token->user_ns. I've said this multiple times before.
> > >
> > > I do restrict token usage to *exact* userns in which the token was
> > > created. See bpf_token_capable()'s
> > >
> > > if (token && current_user_ns() == token->userns) { ... }
> > >
> > > and in bpf_token_allow_cmd():
> > >
> > > if (!token || current_user_ns() != token->userns)
> > >     return false;
> > >
> > > So I followed what you asked in [1] (just like I said I will in [2]),
> > > unless I made some stupid mistake which I cannot even see.
> > >
> > >
> > > What we are discussing here is a different question. It's the
> > > difference between erroring out (that is, failing whatever BPF
> > > operation was attempted with such token, i.e., program loading or map
> > > creation) vs ignoring the token altogether and just using
> > > init_ns-based capable() checks. And the latter is vastly more user
> >
> > Look at this:
> >
> > +bool bpf_token_capable(const struct bpf_token *token, int cap)
> > +{
> > +       /* BPF token allows ns_capable() level of capabilities, but only if
> > +        * token's userns is *exactly* the same as current user's userns
> > +        */
> > +       if (token && current_user_ns() == token->userns) {
> > +               if (ns_capable(token->userns, cap))
> > +                       return true;
> > +               if (cap != CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN))
> > +                       return true;
> > +       }
> > +       /* otherwise fallback to capable() checks */
> > +       return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> > +}
> >
> > How on earth is it possible that the calling task is in a user namespace
> > aka current_user_ns() == token->userns while at the same time being
> > capable in the initial user namespace? When you enter an
> > unprivileged user namespace you lose all capabilities against your
> > ancestor user namespace and you can't reenter your ancestor user
> > namespace.
> >
> > IOW, if current_user_ns() == token->userns and token->userns !=
> > init_user_ns, then current_user_ns() != init_user_ns. And therefore that
> > thing is essentially always false for all interesting cases, no?
> >
> 
> Are you saying that this would be better?
> 
>    if (token && current_user_ns() == token->userns) {
>        if (ns_capable(token->userns, cap))
>            return true;
>        if (cap != CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN))
>            return true;
>        if (token->userns != &init_user_ns)
>            return false;
>    }
>    /* otherwise fallback to capable() checks */
>    return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> 
> 
> I.e., return false directly if token's userns is not initns (there
> will be also LSM check before this condition later on)? Falling back
> to capable() checks and letting it return false if we are not in
> init_ns or don't have capabilities seemed fine to me, that's all.
> 
> 
> > Aside from that it would be semantically completely unclean. The user
> > has specified a token and permission checking should be based on that
> > token and not magically fallback to a capable check in the inital user
> > namespace even if that worked.
> 
> I tried to explain the higher-level integration setup in [0]. The
> thing is that users most of the time won't be explicitly passing a
> token, BPF library will be passing it, if /sys/fs/bpf happens to be
> mounted with delegation options.
> 
> So I wanted to avoid potential regressions (unintended and avoidable
> failures) from using BPF token, because it might be hard to tell if a
> BPF token is "beneficial" and is granting required permissions
> (especially if you take into account LSM interactions). So I
> consistently treat BPF token as optional/add-on permissions, not the
> replacement for capable() checks.

You can always just perform the same call again without specifying the
token.

> 
> It's true that it's unlikely that BPF token will be set up in init_ns
> (except for testing, perhaps), but is it a reason to return -EPERM
> without doing the same checks that would be done if BPF token wasn't
> provided?
> 
> 
>   [0] https://lore.kernel.org/bpf/CAEf4Bzb6jnJL98SLPJB7Vjxo_O33W8HjJuAsyP3+6xigZtsTkA@mail.gmail.com/
> 
> >
> > Because the only scenario where that is maybe useful is if an
> > unprivileged container has dropped _both_ CAP_BPF and CAP_SYS_ADMIN from
> > the user namespace of the container.
> >
> > First of, why? What thread model do you have then? Second, if you do
> > stupid stuff like that then you don't get bpf in the container via bpf
> > tokens. Period.
> >
> > Restrict the meaning and validity of a bpf token to the user namespace
> > and do not include escape hatches such as this. Especially not in this
> > initial version, please.
> 
> This decision fundamentally changes how BPF loader libraries like
> libbpf will have to approach BPF token integration. It's not a small
> thing and not something that will be easy to change later.

Why? It would be relaxing permissions, not restricting it.

> 
> >
> > I'm not trying to be difficult but it's clear that the implications of
> > user namespaces aren't well understood here. And historicaly they are
> 
> I don't know why you are saying this. You haven't pointed out anything
> that is actually broken in the existing implementation. Sure, you
> might not be a fan of the approach, but is there anything
> *technically* wrong with ignoring BPF token if it doesn't provide
> necessary permissions for BPF operation and consistently using the
> checks that would be performed with BPF token?

The current check is inconsisent. It special-cases init_user_ns. The
correct thing to do for what you're intending imho is:

bool bpf_token_capable(const struct bpf_token *token, int cap)
{
        struct user_namespace *userns = &init_user_ns;

        if (token)
                userns = token->userns;
        if (ns_capable(userns, cap))
                return true;
        return cap != CAP_SYS_ADMIN && ns_capable(userns, CAP_SYS_ADMIN))

}

Because any caller located in an ancestor user namespace of
token->user_ns will be privileged wrt to the token's userns as long as
they have that capability in their user namespace.

For example, if the caller is in the init_user_ns and permissions
for CAP_WHATEVER is checked for in token->user_ns and the caller has
CAP_WHATEVER in init_user_ns then they also have it in all
descendant user namespaces.

The original intention had been to align with what we require during
token creation meaning that once a token has been created interacting
with this token is specifically confined to caller's located in the
token's user namespace.

If that's not the case then it doesn't make sense to not allow
permission checking based on regular capability semantics. IOW, why
special case init_user_ns if you're breaking the confinement restriction
anyway.

