Return-Path: <linux-fsdevel+bounces-7578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70683827BC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 00:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A02D28523D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 23:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B43B56B60;
	Mon,  8 Jan 2024 23:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIs1jj4S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481A56767;
	Mon,  8 Jan 2024 23:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-557ad92cabbso1715190a12.0;
        Mon, 08 Jan 2024 15:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704758339; x=1705363139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9dmLqXnMpQvHPtNzHoIxZ8R6iQOUKJQ2rKO4S9XxmA=;
        b=LIs1jj4SxSy72qzA9J6rNoxcp7NMjHo6k3eJbif1RaKZNusHFsjprkcUFwd2rC/Ri2
         t2rqX3vwPL1xV5tCjgbKdmZhyImMVB2/PoOL4+0rrJLs6eGTfyHlxDvWDp+y8Tp7gznm
         DUVtxhJuFGDVj18T9yjYaIqH0/v3gS4NgCgHIG1KeEDbwKXNjlHdLY/GZI+fmBhYzM62
         5Xwo8/NvZbg6gHcKBdo7b5EmPCsGQnJpURHleMbCKG65AK4iuR8Hu+BX/iJXloK4kqAB
         FmqGO3Vp7R/LUv93H5VTA8iGqK0DVPWeKyVaWiN8YpowxsW5vCsObt3L270+5B6zdkY1
         wsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704758339; x=1705363139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9dmLqXnMpQvHPtNzHoIxZ8R6iQOUKJQ2rKO4S9XxmA=;
        b=ugF8qWZGh12t//AYgxnVovdOBK2zGbLrsKEYptL4y4rvidYuSyNZmpLay7aWKjwPv4
         j1Wm2tvXSLcDAh/cyzv2SYdvkfd9Q7iTRpgWriCB1TDvjJALFr1qZHcyEwK9OSmgwZ8j
         071bku2AvUjmrTA4CprcSymCzJ7j7AwupiTln238H/VZJBlcYubDIT1VwW0TZ+OUb0Aw
         YJGiKmBcZnV9SxS7TP82fo0q4tsTi/eLZRy3zW4ST7E9mqE1ejc1iRmOwpjrEuPa2JRg
         opOtKlRSeMlGQfViKObdbIoU5EoErxF7LW5RPzIHtezjRBglDI2cpNwa7+xGjt4nh9FS
         ZOcA==
X-Gm-Message-State: AOJu0Yz504dCa6XE9ZUnsuiIwzhIugyymmJUR3wxqdmMg760+0Jr6AZe
	LTjJtdSKlooJe0uSluVtwQulC2O/4q+0xoOlaNY=
X-Google-Smtp-Source: AGHT+IGl1gayTPK+Bdixc0YMyuQ3Si3vU1RHCRlTmUm8Y/TK4PsZd9KEE3NpI9ANDeCOiTp/p20koyg04MioT8ILScI=
X-Received: by 2002:aa7:cd0c:0:b0:557:4a13:db62 with SMTP id
 b12-20020aa7cd0c000000b005574a13db62mr1448453edw.119.1704758339513; Mon, 08
 Jan 2024 15:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
 <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
 <CAEf4Bzb6jnJL98SLPJB7Vjxo_O33W8HjJuAsyP3+6xigZtsTkA@mail.gmail.com> <20240108-gasheizung-umstand-a36d89ed36b7@brauner>
In-Reply-To: <20240108-gasheizung-umstand-a36d89ed36b7@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jan 2024 15:58:47 -0800
Message-ID: <CAEf4Bzb+7NzYs5ScggtgAJ6A5-oU5GymvdoEbpfNVOG-XmWZig@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 4:02=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Jan 05, 2024 at 02:18:40PM -0800, Andrii Nakryiko wrote:
> > On Fri, Jan 5, 2024 at 1:45=E2=80=AFPM Linus Torvalds
> > <torvalds@linuxfoundation.org> wrote:
> > >
> > > Ok, I've gone through the whole series now, and I don't find anything
> > > objectionable.
> >
> > That's great, thanks for reviewing!
> >
> > >
> > > Which may only mean that I didn't notice something, of course, but at
> > > least there's nothing I'd consider obvious.
> > >
> > > I keep coming back to this 03/29 patch, because it's kind of the hear=
t
> > > of it, and I have one more small nit, but it's also purely stylistic:
> > >
> > > On Wed, 3 Jan 2024 at 14:21, Andrii Nakryiko <andrii@kernel.org> wrot=
e:
> > > >
> > > > +bool bpf_token_capable(const struct bpf_token *token, int cap)
> > > > +{
> > > > +       /* BPF token allows ns_capable() level of capabilities, but=
 only if
> > > > +        * token's userns is *exactly* the same as current user's u=
serns
> > > > +        */
> > > > +       if (token && current_user_ns() =3D=3D token->userns) {
> > > > +               if (ns_capable(token->userns, cap))
> > > > +                       return true;
> > > > +               if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->use=
rns, CAP_SYS_ADMIN))
> > > > +                       return true;
> > > > +       }
> > > > +       /* otherwise fallback to capable() checks */
> > > > +       return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(C=
AP_SYS_ADMIN));
> > > > +}
> > >
> > > This *feels* like it should be written as
> > >
> > >     bool bpf_token_capable(const struct bpf_token *token, int cap)
> > >     {
> > >         struct user_namespace *ns =3D &init_ns;
> > >
> > >         /* BPF token allows ns_capable() level of capabilities, but o=
nly if
> > >          * token's userns is *exactly* the same as current user's use=
rns
> > >          */
> > >         if (token && current_user_ns() =3D=3D token->userns)
> > >                 ns =3D token->userns;
> > >         return ns_capable(ns, cap) ||
> > >                 (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> > >     }
> > >
> > > And yes, I realize that the function will end up later growing a
> > >
> > >         security_bpf_token_capable(token, cap)
> > >
> > > test inside that 'if (token ..)' statement, and this would change the
> > > order of that test so that the LSM hook would now be done before the
> > > capability checks are done, but that all still seems just more of an
> > > argument for the simplification.
> > >
> > > So the end result would be something like
> > >
> > >     bool bpf_token_capable(const struct bpf_token *token, int cap)
> > >     {
> > >         struct user_namespace *ns =3D &init_ns;
> > >
> > >         if (token && current_user_ns() =3D=3D token->userns) {
> > >                 if (security_bpf_token_capable(token, cap) < 0)
> > >                         return false;
> > >                 ns =3D token->userns;
> > >         }
> > >         return ns_capable(ns, cap) ||
> > >                 (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> > >     }
> >
> > Yep, it makes sense to use ns_capable with init_ns. I'll change those
> > two patches to end up with something like what you suggested here.
> >
> > >
> > > although I feel that with that LSM hook, maybe this all should return
> > > the error code (zero or negative), not a bool for success?
> > >
> > > Also, should "current_user_ns() !=3D token->userns" perhaps be an err=
or
> > > condition, rather than a "fall back to init_ns" condition?
> > >
> > > Again, none of this is a big deal. I do think you're dropping the LSM
> > > error code on the floor, and are duplicating the "ns_capable()" vs
> > > "capable()" logic as-is, but none of this is a deal breaker, just mor=
e
> > > of my commentary on the patch and about the logic here.
> > >
> > > And yeah, I don't exactly love how you say "ok, if there's a token an=
d
> > > it doesn't match, I'll not use it" rather than "if the token namespac=
e
> > > doesn't match, it's an error", but maybe there's some usability issue
> > > here?
> >
> > Yes, usability was the primary concern. The overall idea with BPF
>
> NAK on not restricting this to not erroring out on current_user_ns()
> !=3D token->user_ns. I've said this multiple times before.

I do restrict token usage to *exact* userns in which the token was
created. See bpf_token_capable()'s

if (token && current_user_ns() =3D=3D token->userns) { ... }

and in bpf_token_allow_cmd():

if (!token || current_user_ns() !=3D token->userns)
    return false;

So I followed what you asked in [1] (just like I said I will in [2]),
unless I made some stupid mistake which I cannot even see.


What we are discussing here is a different question. It's the
difference between erroring out (that is, failing whatever BPF
operation was attempted with such token, i.e., program loading or map
creation) vs ignoring the token altogether and just using
init_ns-based capable() checks. And the latter is vastly more user
friendly when considering end-to-end integration with user-space
applications and tooling. And doesn't seem to open any security holes.

  [1] https://lore.kernel.org/r/20231130-katzen-anhand-7ad530f187da@brauner
  [2] https://lore.kernel.org/all/CAEf4BzZA2or352VkAaBsr+fsWAGO1Cs_gonH7Ffm=
5emXGE+2Ug@mail.gmail.com/

