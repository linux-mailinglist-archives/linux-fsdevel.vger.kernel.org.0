Return-Path: <linux-fsdevel+bounces-2159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63EE7E2CBB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 20:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EDC281144
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 19:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1787B2D05F;
	Mon,  6 Nov 2023 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtS0Qzgl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17B34435;
	Mon,  6 Nov 2023 19:17:54 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C680691;
	Mon,  6 Nov 2023 11:17:52 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9c5b313b3ffso725970766b.0;
        Mon, 06 Nov 2023 11:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699298271; x=1699903071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKdtw0RWnPaU7157vLX8syX5AqvaX/ZeSjM93wnZiqA=;
        b=AtS0Qzglc9UXJ7s9raU8C0TDdanYQx4SQ30Fz1F6wVveio9zMmeq0/9wvWV3NPmcFP
         IU/qL/LByobf5tm2UoPmTNbw0s0rDsFlJJMqcuM2gDjAEarUn1jjZpFTCk2eR3wvUtyH
         xGkU3+554ZhqSG0OxasuT5QkhhuccLffHQ81huuWQDFR+rR4qMGvgbdlOgG1B3MV/9rS
         qx0qUBDewH5uwn1A/zjgHpNS9gBq27x4m6WVOuvlbKVwKrl+Mi0uQMqYGz1E5v8Orz45
         OgmgQAmow9+6rLrzBtQbFo2qZhWwTb18/EHKzrS0bw6h738DD1zXS1Z+fCQm7kvqT8g0
         BeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699298271; x=1699903071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKdtw0RWnPaU7157vLX8syX5AqvaX/ZeSjM93wnZiqA=;
        b=X30rU+gFBSeXnwllgp4RUDFJjXdP1kUjeIHq3NNgicSYoeljdw5SWr6fUW7zQPl+N9
         vzBnj92Otga/AMSZpQ4WXJg4uw5Q2JqNjnXQXQ/vc/OM1sHYCg6gociCiNU46T10MPnx
         Rmhd9FmUsJJw7Kx3NjmJ2u9y+eOSmdTsjo43szFaJC3JKRKq9eeO8ImJVKEnZ9/Sdl1E
         e7luP+QRBmSOLoGILBYMWZ3yWghBVXvZAvldWPx0TnEKt/UojF5mEE/Ej7zkQZK/tXnJ
         JfEgI/+f07FzCNiy7JFirFqUuhAYF+ZZp5gcylLgp56KiFvRyEmigk5dybyQgoE4Z31I
         z4og==
X-Gm-Message-State: AOJu0Yx5/3ZmOzmv0fOAFOpPBH2/uL0O8efZiywFF7owphc8vuLX5YHY
	jOD+ff0mZO8BM3eliJNJbXSo5Elo/T/uml3m/EY=
X-Google-Smtp-Source: AGHT+IFGFiuUOyPLkAIYdvtjUYl6S+CjJXVOy/h1GJG0AvgHnQuRk68oojxADHKqn4UhNhbRLIRrAG0gqHSpnKgCSfg=
X-Received: by 2002:a17:906:fd81:b0:9be:bf31:335f with SMTP id
 xa1-20020a170906fd8100b009bebf31335fmr15052727ejb.46.1699298271095; Mon, 06
 Nov 2023 11:17:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103190523.6353-12-andrii@kernel.org> <9d2b920cb7e59dfd56f763bdd4e53abd.paul@paul-moore.com>
In-Reply-To: <9d2b920cb7e59dfd56f763bdd4e53abd.paul@paul-moore.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Nov 2023 11:17:39 -0800
Message-ID: <CAEf4BzbGjLQV0CsTwawiqHaGf4eObMQBJT-bpDpWOoQ8hNNcVQ@mail.gmail.com>
Subject: Re: [PATCH v9 11/17] bpf,lsm: add BPF token LSM hooks
To: Paul Moore <paul@paul-moore.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 9:01=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Nov  3, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Wire up bpf_token_create and bpf_token_free LSM hooks, which allow to
> > allocate LSM security blob (we add `void *security` field to struct
> > bpf_token for that), but also control who can instantiate BPF token.
> > This follows existing pattern for BPF map and BPF prog.
> >
> > Also add security_bpf_token_allow_cmd() and security_bpf_token_capable(=
)
> > LSM hooks that allow LSM implementation to control and negate (if
> > necessary) BPF token's delegation of a specific bpf_cmd and capability,
> > respectively.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h           |  3 ++
> >  include/linux/lsm_hook_defs.h |  5 +++
> >  include/linux/security.h      | 25 +++++++++++++++
> >  kernel/bpf/bpf_lsm.c          |  4 +++
> >  kernel/bpf/token.c            | 13 ++++++--
> >  security/security.c           | 60 +++++++++++++++++++++++++++++++++++
> >  6 files changed, 107 insertions(+), 3 deletions(-)
>
> ...
>
> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 08fd777cbe94..1d6edbf45d1c 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -60,6 +60,7 @@ struct fs_parameter;
> >  enum fs_value_type;
> >  struct watch;
> >  struct watch_notification;
> > +enum bpf_cmd;
>
> Yes, I think it's fine to include bpf.h in security.h instead of the
> forward declaration.
>
> >  /* Default (no) options for the capable function */
> >  #define CAP_OPT_NONE 0x0
> > @@ -2031,6 +2032,11 @@ extern void security_bpf_map_free(struct bpf_map=
 *map);
> >  extern int security_bpf_prog_load(struct bpf_prog *prog, union bpf_att=
r *attr,
> >                                 struct bpf_token *token);
> >  extern void security_bpf_prog_free(struct bpf_prog *prog);
> > +extern int security_bpf_token_create(struct bpf_token *token, union bp=
f_attr *attr,
> > +                                  struct path *path);
> > +extern void security_bpf_token_free(struct bpf_token *token);
> > +extern int security_bpf_token_allow_cmd(const struct bpf_token *token,=
 enum bpf_cmd cmd);
> > +extern int security_bpf_token_capable(const struct bpf_token *token, i=
nt cap);
> >  #else
> >  static inline int security_bpf(int cmd, union bpf_attr *attr,
> >                                            unsigned int size)
> > @@ -2065,6 +2071,25 @@ static inline int security_bpf_prog_load(struct =
bpf_prog *prog, union bpf_attr *
> >
> >  static inline void security_bpf_prog_free(struct bpf_prog *prog)
> >  { }
> > +
> > +static inline int security_bpf_token_create(struct bpf_token *token, u=
nion bpf_attr *attr,
> > +                                  struct path *path)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline void security_bpf_token_free(struct bpf_token *token)
> > +{ }
> > +
> > +static inline int security_bpf_token_allow_cmd(const struct bpf_token =
*token, enum bpf_cmd cmd)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline int security_bpf_token_capable(const struct bpf_token *t=
oken, int cap)
> > +{
> > +     return 0;
> > +}
>
> Another nitpick, but I would prefer to shorten
> security_bpf_token_allow_cmd() renamed to security_bpf_token_cmd() both
> to shorten the name and to better fit convention.  I realize the caller
> is named bpf_token_allow_cmd() but I'd still rather see the LSM hook
> with the shorter name.

Makes sense, renamed to security_bpf_token_cmd() and updated hook name as w=
ell

>
> > diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> > index 35e6f55c2a41..5d04da54faea 100644
> > --- a/kernel/bpf/token.c
> > +++ b/kernel/bpf/token.c
> > @@ -7,11 +7,12 @@
> >  #include <linux/idr.h>
> >  #include <linux/namei.h>
> >  #include <linux/user_namespace.h>
> > +#include <linux/security.h>
> >
> >  bool bpf_token_capable(const struct bpf_token *token, int cap)
> >  {
> >       /* BPF token allows ns_capable() level of capabilities */
> > -     if (token) {
> > +     if (token && security_bpf_token_capable(token, cap) =3D=3D 0) {
> >               if (ns_capable(token->userns, cap))
> >                       return true;
> >               if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->userns, C=
AP_SYS_ADMIN))
>
> We typically perform the capability based access controls prior to the
> LSM controls, meaning if we want to the token controls to work in a
> similar way we should do something like this:
>
>   bool bpf_token_capable(...)
>   {
>     if (token) {
>       if (ns_capable(token, cap) ||
>           (cap !=3D ADMIN && ns_capable(token, ADMIN)))
>         return security_bpf_token_capable(token, cap);
>     }
>     return capable(cap) || (cap !=3D ADMIN && capable(...))
>   }

yep, makes sense, I changed it as you suggested above

>
> > @@ -28,6 +29,7 @@ void bpf_token_inc(struct bpf_token *token)
> >
> >  static void bpf_token_free(struct bpf_token *token)
> >  {
> > +     security_bpf_token_free(token);
> >       put_user_ns(token->userns);
> >       kvfree(token);
> >  }
> > @@ -172,6 +174,10 @@ int bpf_token_create(union bpf_attr *attr)
> >       token->allowed_progs =3D mnt_opts->delegate_progs;
> >       token->allowed_attachs =3D mnt_opts->delegate_attachs;
> >
> > +     err =3D security_bpf_token_create(token, attr, &path);
> > +     if (err)
> > +             goto out_token;
> > +
> >       fd =3D get_unused_fd_flags(O_CLOEXEC);
> >       if (fd < 0) {
> >               err =3D fd;
> > @@ -216,8 +222,9 @@ bool bpf_token_allow_cmd(const struct bpf_token *to=
ken, enum bpf_cmd cmd)
> >  {
> >       if (!token)
> >               return false;
> > -
> > -     return token->allowed_cmds & (1ULL << cmd);
> > +     if (!(token->allowed_cmds & (1ULL << cmd)))
> > +             return false;
> > +     return security_bpf_token_allow_cmd(token, cmd) =3D=3D 0;
>
> I'm not sure how much it really matters, but someone might prefer
> the '!!' approach/style over '=3D=3D 0'.

it would have to be !security_bpf_token_cmd(), right? And that single
negation is just very confusing when dealing with int-returning
function. I find it much easier to make sure the logic is correct when
we have explicit `=3D=3D 0`.

Like, when I see `return !security_bpf_token_cmd(...);`, my immediate
read of that is "return whether bpf_token_cmd is not allowed" or
something along those lines, giving me a huge pause... I have the same
relationship with strcmp(), btw, while people seem totally fine with
`!strcmp()` (which to me also reads backwards).

Anyways, unless you really feel strongly, I'd keep =3D=3D 0 here and above
for security_bpf_token_capable(), just because it's int-returning
function result conversion to bool-returning result.

>
> >  }
> >
> >  bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_=
map_type type)
>
> --
> paul-moore.com

