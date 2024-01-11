Return-Path: <linux-fsdevel+bounces-7760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0F182A549
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 01:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949041F23508
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 00:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04741A4D;
	Thu, 11 Jan 2024 00:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhIDcMNt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBCE65B;
	Thu, 11 Jan 2024 00:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28e31563ebso507765866b.2;
        Wed, 10 Jan 2024 16:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704933761; x=1705538561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZx2/g2S7g9cGX18pcRfBDPf6+hwHhctQ6sE2WrmWEQ=;
        b=VhIDcMNtlvsQ7IVu89TkxkfklBiSoB3Xr7gTnWU8a/UQ7ZeUcW8bFfIIsLJ+206bgI
         OZ07SmOsTvIU7lkOrJbGg1Oz+fF1g7xnreMNfmYBBuQHb/+r+1vTZ7ygBDzOL9D8ZGZm
         PTi7mxHK6dNFRpBTaRVXDv8ebOG2HfhCOJpi+I7+UlkmxfOQeayzEodAryyWyAbxFY4i
         kXO03+ChmI95e4Dh26xfGG4PbFcV6lbqNqndYsxkyzv0QtmzJUWz3oBBkrGbZK1Ox53b
         YOVb5RSDmdBsDUY3kXinGxC/YyoShSzpIlWod5cxTpiwxoaHl7SOQy2b6AexFLz8LdXR
         pmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704933761; x=1705538561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZx2/g2S7g9cGX18pcRfBDPf6+hwHhctQ6sE2WrmWEQ=;
        b=jG8yQlGGq/u7ZWLIi+DKEiOv6Lw0XY8CD9qAk62bvLKARDIoE0y8ZMmeVoHjJ2SO2T
         bTh7aCosQpWy0uea+tMi794kC57CQQXiyRqOQUiZZX5j2ndj/CmSnhs31DZTQRMP042O
         YZZzczMoJ9MjfmMEEgI92x9ueccKukwOzx6qCU9tFhFkNUwMwV0U6rPzSJHUYuIxSGoZ
         hV4+j2JOHKR19OqhN7l2m2S3BSLqsUPAfh41+/mwmcqMFDjTYinH/pMXM/BocmwxU7HI
         kkMxPoHEtx4O7t6KLADVH9PmMTqPXxF1+qhIDhcbGv1amgK+VSgnc57zy53nL9LUmrre
         UBJA==
X-Gm-Message-State: AOJu0YwTnQ2Hh7wSkPCCbXnKJfOkVnDlvQzK0pRkXTkSfpIXncGORUfB
	K5B+/S9U8VGCbtNnO2giJwVqfhTaK01xCOPYGUY=
X-Google-Smtp-Source: AGHT+IFhaQkWMRg3UMQdT3hr1NolEjKfu/lfM+bwAYtHORK1nxn3BfccSAbiHTfQacbs/IKEKVp9C9GF0a7zXPfiwQk=
X-Received: by 2002:a17:907:a4b:b0:a28:cc34:39be with SMTP id
 be11-20020a1709070a4b00b00a28cc3439bemr176333ejc.36.1704933761221; Wed, 10
 Jan 2024 16:42:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
 <CAEf4Bzb6jnJL98SLPJB7Vjxo_O33W8HjJuAsyP3+6xigZtsTkA@mail.gmail.com>
 <20240108-gasheizung-umstand-a36d89ed36b7@brauner> <CAEf4Bzb+7NzYs5ScggtgAJ6A5-oU5GymvdoEbpfNVOG-XmWZig@mail.gmail.com>
 <20240109-tausend-tropenhelm-2a9914326249@brauner> <CAEf4BzaAoXYb=qnj6rvDw8VewhvYNrs5oxe=q7VBe0jjWXivhg@mail.gmail.com>
 <20240110-nervt-monopol-6d307e2518f4@brauner>
In-Reply-To: <20240110-nervt-monopol-6d307e2518f4@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 10 Jan 2024 16:42:28 -0800
Message-ID: <CAEf4BzYOU5ZVqnTDTEmrHL-+tYY76kz4LO_0XauWibnhtzCFXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 6:59=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Jan 09, 2024 at 11:00:24AM -0800, Andrii Nakryiko wrote:
> > On Tue, Jan 9, 2024 at 6:52=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > >
> > > On Mon, Jan 08, 2024 at 03:58:47PM -0800, Andrii Nakryiko wrote:
> > > > On Mon, Jan 8, 2024 at 4:02=E2=80=AFAM Christian Brauner <brauner@k=
ernel.org> wrote:
> > > > >
> > > > > On Fri, Jan 05, 2024 at 02:18:40PM -0800, Andrii Nakryiko wrote:
> > > > > > On Fri, Jan 5, 2024 at 1:45=E2=80=AFPM Linus Torvalds
> > > > > > <torvalds@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > Ok, I've gone through the whole series now, and I don't find =
anything
> > > > > > > objectionable.
> > > > > >
> > > > > > That's great, thanks for reviewing!
> > > > > >
> > > > > > >
> > > > > > > Which may only mean that I didn't notice something, of course=
, but at
> > > > > > > least there's nothing I'd consider obvious.
> > > > > > >
> > > > > > > I keep coming back to this 03/29 patch, because it's kind of =
the heart
> > > > > > > of it, and I have one more small nit, but it's also purely st=
ylistic:
> > > > > > >
> > > > > > > On Wed, 3 Jan 2024 at 14:21, Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > > > > > > >
> > > > > > > > +bool bpf_token_capable(const struct bpf_token *token, int =
cap)
> > > > > > > > +{
> > > > > > > > +       /* BPF token allows ns_capable() level of capabilit=
ies, but only if
> > > > > > > > +        * token's userns is *exactly* the same as current =
user's userns
> > > > > > > > +        */
> > > > > > > > +       if (token && current_user_ns() =3D=3D token->userns=
) {
> > > > > > > > +               if (ns_capable(token->userns, cap))
> > > > > > > > +                       return true;
> > > > > > > > +               if (cap !=3D CAP_SYS_ADMIN && ns_capable(to=
ken->userns, CAP_SYS_ADMIN))
> > > > > > > > +                       return true;
> > > > > > > > +       }
> > > > > > > > +       /* otherwise fallback to capable() checks */
> > > > > > > > +       return capable(cap) || (cap !=3D CAP_SYS_ADMIN && c=
apable(CAP_SYS_ADMIN));
> > > > > > > > +}
> > > > > > >
> > > > > > > This *feels* like it should be written as
> > > > > > >
> > > > > > >     bool bpf_token_capable(const struct bpf_token *token, int=
 cap)
> > > > > > >     {
> > > > > > >         struct user_namespace *ns =3D &init_ns;
> > > > > > >
> > > > > > >         /* BPF token allows ns_capable() level of capabilitie=
s, but only if
> > > > > > >          * token's userns is *exactly* the same as current us=
er's userns
> > > > > > >          */
> > > > > > >         if (token && current_user_ns() =3D=3D token->userns)
> > > > > > >                 ns =3D token->userns;
> > > > > > >         return ns_capable(ns, cap) ||
> > > > > > >                 (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_AD=
MIN));
> > > > > > >     }
> > > > > > >
> > > > > > > And yes, I realize that the function will end up later growin=
g a
> > > > > > >
> > > > > > >         security_bpf_token_capable(token, cap)
> > > > > > >
> > > > > > > test inside that 'if (token ..)' statement, and this would ch=
ange the
> > > > > > > order of that test so that the LSM hook would now be done bef=
ore the
> > > > > > > capability checks are done, but that all still seems just mor=
e of an
> > > > > > > argument for the simplification.
> > > > > > >
> > > > > > > So the end result would be something like
> > > > > > >
> > > > > > >     bool bpf_token_capable(const struct bpf_token *token, int=
 cap)
> > > > > > >     {
> > > > > > >         struct user_namespace *ns =3D &init_ns;
> > > > > > >
> > > > > > >         if (token && current_user_ns() =3D=3D token->userns) =
{
> > > > > > >                 if (security_bpf_token_capable(token, cap) < =
0)
> > > > > > >                         return false;
> > > > > > >                 ns =3D token->userns;
> > > > > > >         }
> > > > > > >         return ns_capable(ns, cap) ||
> > > > > > >                 (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_AD=
MIN));
> > > > > > >     }
> > > > > >
> > > > > > Yep, it makes sense to use ns_capable with init_ns. I'll change=
 those
> > > > > > two patches to end up with something like what you suggested he=
re.
> > > > > >
> > > > > > >
> > > > > > > although I feel that with that LSM hook, maybe this all shoul=
d return
> > > > > > > the error code (zero or negative), not a bool for success?
> > > > > > >
> > > > > > > Also, should "current_user_ns() !=3D token->userns" perhaps b=
e an error
> > > > > > > condition, rather than a "fall back to init_ns" condition?
> > > > > > >
> > > > > > > Again, none of this is a big deal. I do think you're dropping=
 the LSM
> > > > > > > error code on the floor, and are duplicating the "ns_capable(=
)" vs
> > > > > > > "capable()" logic as-is, but none of this is a deal breaker, =
just more
> > > > > > > of my commentary on the patch and about the logic here.
> > > > > > >
> > > > > > > And yeah, I don't exactly love how you say "ok, if there's a =
token and
> > > > > > > it doesn't match, I'll not use it" rather than "if the token =
namespace
> > > > > > > doesn't match, it's an error", but maybe there's some usabili=
ty issue
> > > > > > > here?
> > > > > >
> > > > > > Yes, usability was the primary concern. The overall idea with B=
PF
> > > > >
> > > > > NAK on not restricting this to not erroring out on current_user_n=
s()
> > > > > !=3D token->user_ns. I've said this multiple times before.
> > > >
> > > > I do restrict token usage to *exact* userns in which the token was
> > > > created. See bpf_token_capable()'s
> > > >
> > > > if (token && current_user_ns() =3D=3D token->userns) { ... }
> > > >
> > > > and in bpf_token_allow_cmd():
> > > >
> > > > if (!token || current_user_ns() !=3D token->userns)
> > > >     return false;
> > > >
> > > > So I followed what you asked in [1] (just like I said I will in [2]=
),
> > > > unless I made some stupid mistake which I cannot even see.
> > > >
> > > >
> > > > What we are discussing here is a different question. It's the
> > > > difference between erroring out (that is, failing whatever BPF
> > > > operation was attempted with such token, i.e., program loading or m=
ap
> > > > creation) vs ignoring the token altogether and just using
> > > > init_ns-based capable() checks. And the latter is vastly more user
> > >
> > > Look at this:
> > >
> > > +bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > +{
> > > +       /* BPF token allows ns_capable() level of capabilities, but o=
nly if
> > > +        * token's userns is *exactly* the same as current user's use=
rns
> > > +        */
> > > +       if (token && current_user_ns() =3D=3D token->userns) {
> > > +               if (ns_capable(token->userns, cap))
> > > +                       return true;
> > > +               if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->usern=
s, CAP_SYS_ADMIN))
> > > +                       return true;
> > > +       }
> > > +       /* otherwise fallback to capable() checks */
> > > +       return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP=
_SYS_ADMIN));
> > > +}
> > >
> > > How on earth is it possible that the calling task is in a user namesp=
ace
> > > aka current_user_ns() =3D=3D token->userns while at the same time bei=
ng
> > > capable in the initial user namespace? When you enter an
> > > unprivileged user namespace you lose all capabilities against your
> > > ancestor user namespace and you can't reenter your ancestor user
> > > namespace.
> > >
> > > IOW, if current_user_ns() =3D=3D token->userns and token->userns !=3D
> > > init_user_ns, then current_user_ns() !=3D init_user_ns. And therefore=
 that
> > > thing is essentially always false for all interesting cases, no?
> > >
> >
> > Are you saying that this would be better?
> >
> >    if (token && current_user_ns() =3D=3D token->userns) {
> >        if (ns_capable(token->userns, cap))
> >            return true;
> >        if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_=
ADMIN))
> >            return true;
> >        if (token->userns !=3D &init_user_ns)
> >            return false;
> >    }
> >    /* otherwise fallback to capable() checks */
> >    return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_AD=
MIN));
> >
> >
> > I.e., return false directly if token's userns is not initns (there
> > will be also LSM check before this condition later on)? Falling back
> > to capable() checks and letting it return false if we are not in
> > init_ns or don't have capabilities seemed fine to me, that's all.
> >
> >
> > > Aside from that it would be semantically completely unclean. The user
> > > has specified a token and permission checking should be based on that
> > > token and not magically fallback to a capable check in the inital use=
r
> > > namespace even if that worked.
> >
> > I tried to explain the higher-level integration setup in [0]. The
> > thing is that users most of the time won't be explicitly passing a
> > token, BPF library will be passing it, if /sys/fs/bpf happens to be
> > mounted with delegation options.
> >
> > So I wanted to avoid potential regressions (unintended and avoidable
> > failures) from using BPF token, because it might be hard to tell if a
> > BPF token is "beneficial" and is granting required permissions
> > (especially if you take into account LSM interactions). So I
> > consistently treat BPF token as optional/add-on permissions, not the
> > replacement for capable() checks.
>
> You can always just perform the same call again without specifying the
> token.

This has a bunch of problematic implications.

Retrying on any EPERM leads to inefficiency and potential confusion
for users. EPERM can be returned somewhere deeply in the verifier
after spending tons of memory and CPU doing verification. So it's a
waste to try with a token and then try without. And also, retrying
without a token can change specific failure reasons. E.g., for a BPF
program with token we can get deep enough into the verification
process and the verifier will provide log with details about what the
program is doing wrong (allowing the user to fix it relatively
easily), while without token we can bail out much earlier but with not
details what's wrong.

Similarly for other operations (map, BTF), token can provide log
details, etc, but retrying without token will strip users of these
helpful details. That's just to say that dropping a token
automatically doesn't necessarily provide the same user experience
compared to if the token is ignored, if it's not effective (besides
the performance and resource waste implications above).

We have a similar precedent with optional BTF. Libbpf will silently
retry map creation/program loading without BTF automatically. And we
had enough pain with this and invested a lot of work to prevent the
need for retry. We preventively sanitize or drop BTF, etc. For similar
reasons as above (performance and user experience with debugging).

So in short, it's a significant regression in usability and user
experience if the token isn't treated as an add-on permissions,
forcing (otherwise avoidable) complications into user-space libraries
and applications.

>
> >
> > It's true that it's unlikely that BPF token will be set up in init_ns
> > (except for testing, perhaps), but is it a reason to return -EPERM
> > without doing the same checks that would be done if BPF token wasn't
> > provided?
> >
> >
> >   [0] https://lore.kernel.org/bpf/CAEf4Bzb6jnJL98SLPJB7Vjxo_O33W8HjJuAs=
yP3+6xigZtsTkA@mail.gmail.com/
> >
> > >
> > > Because the only scenario where that is maybe useful is if an
> > > unprivileged container has dropped _both_ CAP_BPF and CAP_SYS_ADMIN f=
rom
> > > the user namespace of the container.
> > >
> > > First of, why? What thread model do you have then? Second, if you do
> > > stupid stuff like that then you don't get bpf in the container via bp=
f
> > > tokens. Period.
> > >
> > > Restrict the meaning and validity of a bpf token to the user namespac=
e
> > > and do not include escape hatches such as this. Especially not in thi=
s
> > > initial version, please.
> >
> > This decision fundamentally changes how BPF loader libraries like
> > libbpf will have to approach BPF token integration. It's not a small
> > thing and not something that will be easy to change later.
>
> Why? It would be relaxing permissions, not restricting it.

See above, I tried to highlight some implications, though I realize
it's a bit hard to go over these intricate libbpf implications in a
succinct email without going into excessive details about how BPF
development and debugging is done nowadays with libbpf and
libbpf-based tooling.

>
> >
> > >
> > > I'm not trying to be difficult but it's clear that the implications o=
f
> > > user namespaces aren't well understood here. And historicaly they are
> >
> > I don't know why you are saying this. You haven't pointed out anything
> > that is actually broken in the existing implementation. Sure, you
> > might not be a fan of the approach, but is there anything
> > *technically* wrong with ignoring BPF token if it doesn't provide
> > necessary permissions for BPF operation and consistently using the
> > checks that would be performed with BPF token?
>
> The current check is inconsisent. It special-cases init_user_ns. The
> correct thing to do for what you're intending imho is:
>
> bool bpf_token_capable(const struct bpf_token *token, int cap)
> {
>         struct user_namespace *userns =3D &init_user_ns;
>
>         if (token)
>                 userns =3D token->userns;
>         if (ns_capable(userns, cap))
>                 return true;
>         return cap !=3D CAP_SYS_ADMIN && ns_capable(userns, CAP_SYS_ADMIN=
))
>
> }

Unfortunately the above becomes significantly more hairy when LSM
(security_bpf_token_capable) gets involved, while preserving the rule
"if token doesn't give rights, fall back to init userns checks".

I'm happy to accommodate any implementation of bpf_token_capable() as
long as it behaves as discussed above and also satisfies Paul's
requirement that capability checks should happen before LSM checks.

>
> Because any caller located in an ancestor user namespace of
> token->user_ns will be privileged wrt to the token's userns as long as
> they have that capability in their user namespace.

And with `current_user_ns() =3D=3D token->userns` check we won't be using
token->userns while the caller is in ancestor user namespace, we'll
use capable() check, which will succeed only in init user_ns, assuming
corresponding CAP_xxx is actually set.

>
> For example, if the caller is in the init_user_ns and permissions
> for CAP_WHATEVER is checked for in token->user_ns and the caller has
> CAP_WHATEVER in init_user_ns then they also have it in all
> descendant user namespaces.

Right, so if they didn't use a token they would still pass
capable(CAP_WHATEVER), right?

>
> The original intention had been to align with what we require during
> token creation meaning that once a token has been created interacting
> with this token is specifically confined to caller's located in the
> token's user namespace.
>
> If that's not the case then it doesn't make sense to not allow
> permission checking based on regular capability semantics. IOW, why
> special case init_user_ns if you're breaking the confinement restriction
> anyway.

I'm sorry, perhaps I'm dense, but with `current_user_ns() =3D=3D
token->userns` check I think we do fulfill the intention to not allow
using a token in a userns different from the one in which it was
created. If that condition isn't satisfied, the token is immediately
ignored. So you can't use a token from another userns for anything,
it's just not there, effectively.

And as I tried to explain above, I do think that ignoring the token
instead of erroring out early is what we want to provide good
user-space ecosystem integration of BPF token.

