Return-Path: <linux-fsdevel+bounces-21479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1824F904725
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 00:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F341F23E16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 22:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5239155C80;
	Tue, 11 Jun 2024 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dM+ClF+P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57937153BF9
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145526; cv=none; b=IG4OIWBHo5uMsdGLIbjIfw9lQ9ruywLbGtMk7lgDgEowYqEiJp+y1n8EqaOh9PI6l0v7oFoVioTPL3wMhXUZod+Quc9hCcnD1PAUSl+ovnBPtkDkpVIfVJWaVE6mBD9cXIg1deaT1Ru7RSSW2yzgf07o35uLfH8grLh9sISGgK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145526; c=relaxed/simple;
	bh=9Njb1QFUfo0wbmyt1RFmIM5BrHWuvMLeu82oSPr0buU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZSDFWpEe7dTz+sf5vzaYJMWSUUnjxN1EteoksjNW6LxfeR8v+PcJkhNENA15uy5FuSdXdS2HHeIs46VFBNpnPrt8j7xWjK0kypRM9Dwz5inZpz9MSViEm3hl1jNXbYPq/Zkivw2951oJCms63nUZP+hfKlbtyUtnrT+Kz1NwRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dM+ClF+P; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-62a08092c4dso18245957b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jun 2024 15:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718145523; x=1718750323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plZlLULbEPZ4CPINB2iX4W5eyj0ufYBE504Q1QyZ288=;
        b=dM+ClF+PxazyNTapsEd1uyA6O2r4SlarCGevqA1wr135PJ6jjT3C63n/dAoXlKKNni
         k/EykW2WxSKnglGup8fJJWYSyhRHq+5JM+aOuExMTaI4OyzeKaISp+u/bDdiryl11EgA
         178Z37EAx0TE5nO/YjK8v09GgzL8pBjJ3hhpYg9NaXxPSfS/5gNjQSb4BXA4jZGZrmK0
         7OXVOtu1yhmxs8CTNioxG07GMVuvY9uk6TZD2sbJq1YhVcx2t0uzLynhsfRxMTYoOMCC
         s8LStSl+pn9ydn2EcPRl6H3zCzJ+1FZHjUfPaDDLumwje/Usw3WghuBUKJmmiSvr9cu4
         6sdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718145523; x=1718750323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plZlLULbEPZ4CPINB2iX4W5eyj0ufYBE504Q1QyZ288=;
        b=iIZmlW1LZ6PBMFbnXb8C4rl6H8zLA8WaWoQZz5NdQy4Vu0YGCgvBA1Oy1muYHKpZ+t
         Y9nU56OaOmKyu/lad7PwuNu2GWmHfnVtlem4HaJZUFJ2F1zE8nE069ibDq68cwj1+3Y9
         9OPym97qW9FdgCgso8VJuNXn/2ZSqVenMg2mU0v4H2zeAU43MWg3iq1xy8ywkLZlARqO
         fxd2VJDDaa2XyOFJCksBcwR0qjSCq3yULTL2jYsifgX/CA2XQg6sTKCLS4gBrNOK4pWB
         HzdT48Zpfh42kb0Rnfn800hAXNRfqOTK9n05eb+wAbR6u5Ou4+QXtrIyin8qe4Km9rZI
         Ph+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7YvrZ58lHen7H7LCHTukPMdXdm2XZnANCaCmPnfqnjlE3NpVClEpSj1+dJ54BGmgrETlbNS05Hiced6tt7kj8kbFEJqNzugHMSXCoQA==
X-Gm-Message-State: AOJu0YzNdx39vs6/nDyPULMOEqqlYgsZYcQjiSU2ppFr9JrFfSujrvX8
	cXIgfcuqrX9eMyqPccwVkj2YSvVDdWpbuwZF3cihybVLz2P7W+j8JjtGeXamYX3z0Hn3+pwNcTn
	X+iGdN4byGeLg88qmN1snXaaFyI3IL3yHrjis
X-Google-Smtp-Source: AGHT+IGifaChWdPoqDKcu/zG1sPFHu3t29KGAok0VPBFpp8xy1nbzv00PRW17G/CBEF/tR53qSOD+uWyF14JleQj9nU=
X-Received: by 2002:a81:7283:0:b0:62f:518b:ba53 with SMTP id
 00721157ae682-62fba943427mr1376147b3.49.1718145522756; Tue, 11 Jun 2024
 15:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609104355.442002-1-jcalmels@3xx0.net> <20240609104355.442002-5-jcalmels@3xx0.net>
 <CAHC9VhT5XWbhoY2Nw5jQz4GxpDriUdHw=1YsQ4xLVUtSnFxciA@mail.gmail.com>
 <z2bgjrzeq7crqx24chdbxnaanuhczbjnq6da3xw6al6omjj5xz@mqbzzzfva5sw>
 <887a3658-2d8d-4f9e-98f2-27124bb6f8e6@canonical.com> <CAHC9VhQFNPJTOct5rUv3HT6Z2S20mYdW75seiG8no5=fZd7JjA@mail.gmail.com>
 <uuvwcdsy7o4ulmrdzwffr6uywfacmlkjrontmjdj44luantpok@dtatxaa6tzyv>
In-Reply-To: <uuvwcdsy7o4ulmrdzwffr6uywfacmlkjrontmjdj44luantpok@dtatxaa6tzyv>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 11 Jun 2024 18:38:31 -0400
Message-ID: <CAHC9VhRnthf8+KgfuzFHXWEAc9RShDO0G_g0kc1OJ-UTih1ywg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] bpf,lsm: Allow editing capabilities in BPF-LSM hooks
To: Jonathan Calmels <jcalmels@3xx0.net>
Cc: John Johansen <john.johansen@canonical.com>, brauner@kernel.org, ebiederm@xmission.com, 
	Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Joel Granados <j.granados@samsung.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	containers@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	apparmor@lists.ubuntu.com, keyrings@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 6:15=E2=80=AFPM Jonathan Calmels <jcalmels@3xx0.net=
> wrote:
> On Tue, Jun 11, 2024 at 03:01:01PM GMT, Paul Moore wrote:
> > On Tue, Jun 11, 2024 at 6:32=E2=80=AFAM John Johansen
> > <john.johansen@canonical.com> wrote:
> > >
> > > On 6/11/24 01:09, Jonathan Calmels wrote:
> > > > On Sun, Jun 09, 2024 at 08:18:48PM GMT, Paul Moore wrote:
> > > >> On Sun, Jun 9, 2024 at 6:40=E2=80=AFAM Jonathan Calmels <jcalmels@=
3xx0.net> wrote:
> > > >>>
> > > >>> This patch allows modifying the various capabilities of the struc=
t cred
> > > >>> in BPF-LSM hooks. More specifically, the userns_create hook calle=
d
> > > >>> prior to creating a new user namespace.
> > > >>>
> > > >>> With the introduction of userns capabilities, this effectively pr=
ovides
> > > >>> a simple way for LSMs to control the capabilities granted to a us=
er
> > > >>> namespace and all its descendants.
> > > >>>
> > > >>> Update the selftests accordingly by dropping CAP_SYS_ADMIN in
> > > >>> namespaces and checking the resulting task's bounding set.
> > > >>>
> > > >>> Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>
> > > >>> ---
> > > >>>   include/linux/lsm_hook_defs.h                 |  2 +-
> > > >>>   include/linux/security.h                      |  4 +-
> > > >>>   kernel/bpf/bpf_lsm.c                          | 55 ++++++++++++=
+++++++
> > > >>>   security/apparmor/lsm.c                       |  2 +-
> > > >>>   security/security.c                           |  6 +-
> > > >>>   security/selinux/hooks.c                      |  2 +-
> > > >>>   .../selftests/bpf/prog_tests/deny_namespace.c | 12 ++--
> > > >>>   .../selftests/bpf/progs/test_deny_namespace.c |  7 ++-
> > > >>>   8 files changed, 76 insertions(+), 14 deletions(-)
> > > >>
> > > >> I'm not sure we want to go down the path of a LSM modifying the PO=
SIX
> > > >> capabilities of a task, other than the capabilities/commoncap LSM.=
  It
> > > >> sets a bad precedent and could further complicate issues around LS=
M
> > > >> ordering.
> > > >
> > > > Well unless I'm misunderstanding, this does allow modifying the
> > > > capabilities/commoncap LSM through BTF. The reason for allowing
> > > > `userns_create` to be modified is that it is functionally very simi=
lar
> > > > to `cred_prepare` in that it operates with new creds (but specific =
to
> > > > user namespaces because of reasons detailed in [1]).
> > >
> > > yes
> > >
> > > > There were some concerns in previous threads that the userns caps b=
y
> > > > themselves wouldn't be granular enough, hence the LSM integration.
> > >
> > > > Ubuntu for example, currently has to resort to a hardcoded profile
> > > > transition to achieve this [2].
> > > >
> > >
> > > The hard coded profile transition, is because the more generic soluti=
on
> > > as part of policy just wasn't ready. The hard coding will go away bef=
ore
> > > it is upstreamed.
> > >
> > > But yes, updating the cred really is necessary for the flexibility ne=
eded
> > > whether it is modifying the POSIX capabilities of the task or the LSM
> > > modifying its own security blob.
> > >
> > > I do share some of Paul's concerns about the LSM modifying the POSIX
> > > capabilities of the task, but also thing the LSM here needs to be
> > > able to modify its own blob.
> >
> > To be clear, this isn't about a generic LSM needing to update its own
> > blob (LSM state), it is about the BPF LSM updating the capability
> > sets.  While we obviously must support a LSM updating its own state,
> > I'm currently of the opinion that allowing one LSM to update the state
> > of another LSM is only going to lead to problems.  We wouldn't want to
> > allow Smack to update AppArmor state, and from my current perspective
> > allowing the BPF LSM to update the capability state is no different.
> >
> > It's also important to keep in mind that if we allow one LSM to do
> > something, we need to allow all LSMs to do something.  If we allow
> > multiple LSMs to manipulate the capability sets, how do we reconcile
> > differences in the desired capability state?  Does that resolution
> > change depending on what LSMs are enabled at build time?  Enabled at
> > boot?  Similarly, what about custom LSM ordering?
> >
> > What about those LSMs that use a task's capabilities as an input to an
> > access control decision?  If those LSMs allow an access based on a
> > given capability set only to have a LSM later in the ordering modify
> > that capability set to something which would have resulted in an
> > access denial, do we risk a security regression?
>
> I understand the concerns, what I fail to understand however, is how is
> it any different from say the `cred_prepare` hook today?

The existing cred_prepare hooks only operate on their own small
portion of the cred::security blob.  What you are proposing would be
the BPF LSM operating on the capability sets that it does not "own"
(they belong to the capability LSM).

If you see that as a minor difference, please understand that if you
skip past that you have all the issues I mentioned in my previous
message to deal with.

> > Our current approach to handling multiple LSMs is that each LSM is
> > limited to modifying its own state, and I'm pretty confident that we
> > stick to this model if we have any hope of preserving the sanity of
> > the LSM layer as a whole.  If you want to modify the capability set
> > you need to do so within the confines of the capability LSM and/or
> > modify the other related kernel subsystems (which I'm guessing will
> > likely necessitate a change in the LSMs, but that avenue is very
> > unclear if such an option even exists).
>
> What do you mean by "within the confines of the capability LSM" here?

Basically security/commoncap.c.  One could make a lot of arguments
about if it is, or isn't, a LSM, but commoncap.c registers LSM hooks
which is pretty much the definition of a LSM from an implementation
point of view.

> Arguably, if we do want fine-grained userns policies, we need LSMs to
> influence the userns capset at some point.

One could always use, or develop, a LSM that offers additional
controls around exercising capabilities.  There are currently four
in-tree LSMs, including the capabilities LSM, which supply a
security_capable() hook that is used by the capability-based access
controls in the kernel; all of these hook implementations work
together within the LSM framework and provide an additional level of
control/granularity beyond the existing capabilities.

--=20
paul-moore.com

