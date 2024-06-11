Return-Path: <linux-fsdevel+bounces-21477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 156649046D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 00:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957DA1F25638
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 22:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1AA15534F;
	Tue, 11 Jun 2024 22:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="Pq9rjGAS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ISNh/oJu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wflow2-smtp.messagingengine.com (wflow2-smtp.messagingengine.com [64.147.123.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F87438DC8;
	Tue, 11 Jun 2024 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718144134; cv=none; b=O0BnY08yVEVn0WAAJx0Tgfo7wIF7syl5/PfW76t90Vh5T0ZVboPxLzyRiBLo6Krze168JGofkzXjuk6nUBtuOxiQA3IGN18RsB9LkjaoXGuoYMgKXumRL2qgZWGnFyOEQ0E8/v5gwOeXbPS1+QzF/qEcKZd1ZDdCS1G5toluK5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718144134; c=relaxed/simple;
	bh=GdAkFK62RY/EebkDCQaRIl7vglLd8+Mimrq9+Eb15nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhzmLOoOn31Z6acsu8IcW5TFA2ETxenJS4iEYTKdjnONyPHnh1I6GixBrbY0WphqExCjdX0jiXGJyceOYsHDZ7tVDcRtwNT+NND655CM89iHjYe4Eo5RhhgGz97tJ5oZsp/V4l8xz7vZvPLpzn4VnKfLrXWvWzLdx56saFYDGoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=Pq9rjGAS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ISNh/oJu; arc=none smtp.client-ip=64.147.123.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.west.internal (Postfix) with ESMTP id C97482CC0169;
	Tue, 11 Jun 2024 18:15:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 11 Jun 2024 18:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1718144127;
	 x=1718147727; bh=hLoyDphzPvoA7UYBfDpLVZId/MwW/v8vWSAXuFf49/w=; b=
	Pq9rjGAS1w/Bgo5vWiHK4C9GSmw8UEqW23zxfC6CU+LFTqGfGsPAhKcyrwHoj90O
	2g7tjpvdho680sZED5/2pEYwnSPHE6Nyuowy4t+liSKxQFrggVMMiqon8nSX9UYe
	oVBsXm4b6ZW6z97l0uDDa5lkmqrKrNH3jKXI/kXAvkXXFnrHwG6oKoSy/6j3AF1Y
	8cm9z2VOiKm0Y60hTybScXH/pn1OM/r/TpGNjtGS43aretvWB4MzGA3unImRVifY
	913jLZ1dcL0oU2fUqcd35OHYcKeVnIiStKNnfKqAViqm85MfWYGX9m8CAyZAGKTa
	iabR1CZR/u5ovgrtmgo/zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718144127; x=
	1718147727; bh=hLoyDphzPvoA7UYBfDpLVZId/MwW/v8vWSAXuFf49/w=; b=I
	SNh/oJu/e8FBFK91pEhdVzPaxeoy0vJBcCYsFR5dTBa0eTNI52Mh6vmtzoNEnGGo
	0nk1m7ki7/In22P/dp/EXcSDHlAz5BfLVF+KTy5T2BmEdmd9GgekK0iKTSeHoXrF
	qgiz+C959oucHJqv+TsGRpUAUjs2GCWmVT1rVLthx5HBkCDuetmM/I23iDS5r0tT
	W6HmZFu74Tm8QZns/LE00Y7Nh3h6HK7WrxdV+ExaadRJAJwmM9Qv5H0pqfa0EnHA
	Pq+gmx9IfmHP/NPUS88TJZaod19sMGo6bD1rEZ6UeYk8d3P1h816uGx3p9eTi7ne
	VZ5GqWvsh5NKbZvAPyg3A==
X-ME-Sender: <xms:fsxoZqoVnHB2uGoc7C0A7BixBJXGpc11qlCUk3a6hvFctlK7PdBKkA>
    <xme:fsxoZooRmtozI0oKjoRwzZnuKSw8qtfaYL--1NQiRvpNaw-gFmHdFKZpfzO16EY2q
    Wz6KAFCvBXQU1xOAYA>
X-ME-Received: <xmr:fsxoZvPL801GFa0JdYFCAOHyDF4GcEcnIZ4r8mQNRH4NDIvzS9R2KSXWHk7HkTFFGFWEcogO8cqqGrkZ0AEzTiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedufedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddttdejnecuhfhrohhmpeflohhn
    rghthhgrnhcuvegrlhhmvghlshcuoehjtggrlhhmvghlshesfeiggidtrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpeetgedutdfggeetleefhfeuhedtheduteekieduvdeigeegvdev
    vddtieekiedvheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjtggrlhhmvghlshesfeiggidtrdhnvght
X-ME-Proxy: <xmx:f8xoZp6U8TxIwbBdIkAUIulkUDaDRV4oFBo0EBVqjfd1jc3IUfHrRw>
    <xmx:f8xoZp7_TUBZagIfh40y2sdsDedvT-h5VXVtRjmhUKH4ThdVyvjDuw>
    <xmx:f8xoZphmbJ-AsduE8UunEraJ_Nu6pDRX9sPBXVa9qb7iygs6fiB0gg>
    <xmx:f8xoZj7QERyBvlOn4w7jLMGtV-DEUFk1T2Viw9CMO6OeJGkw-uv4eA>
    <xmx:f8xoZkIrhrrTIB3VBMJkOqlUb0VXeh5tcuzeAhLiHln_J1A0uzp3N8Xe>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 18:15:23 -0400 (EDT)
Date: Tue, 11 Jun 2024 15:20:33 -0700
From: Jonathan Calmels <jcalmels@3xx0.net>
To: Paul Moore <paul@paul-moore.com>
Cc: John Johansen <john.johansen@canonical.com>, brauner@kernel.org,
 	ebiederm@xmission.com, Jonathan Corbet <corbet@lwn.net>,
 	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 	KP Singh <kpsingh@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 	Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 	Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 	Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, 	Luis Chamberlain <mcgrof@kernel.org>,
 Kees Cook <kees@kernel.org>, 	Joel Granados <j.granados@samsung.com>,
 David Howells <dhowells@redhat.com>,
 	Jarkko Sakkinen <jarkko@kernel.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 	Ondrej Mosnacek <omosnace@redhat.com>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, 	containers@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, 	apparmor@lists.ubuntu.com,
 keyrings@vger.kernel.org, selinux@vger.kernel.org,
 	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] bpf,lsm: Allow editing capabilities in BPF-LSM
 hooks
Message-ID: <uuvwcdsy7o4ulmrdzwffr6uywfacmlkjrontmjdj44luantpok@dtatxaa6tzyv>
References: <20240609104355.442002-1-jcalmels@3xx0.net>
 <20240609104355.442002-5-jcalmels@3xx0.net>
 <CAHC9VhT5XWbhoY2Nw5jQz4GxpDriUdHw=1YsQ4xLVUtSnFxciA@mail.gmail.com>
 <z2bgjrzeq7crqx24chdbxnaanuhczbjnq6da3xw6al6omjj5xz@mqbzzzfva5sw>
 <887a3658-2d8d-4f9e-98f2-27124bb6f8e6@canonical.com>
 <CAHC9VhQFNPJTOct5rUv3HT6Z2S20mYdW75seiG8no5=fZd7JjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQFNPJTOct5rUv3HT6Z2S20mYdW75seiG8no5=fZd7JjA@mail.gmail.com>

On Tue, Jun 11, 2024 at 03:01:01PM GMT, Paul Moore wrote:
> On Tue, Jun 11, 2024 at 6:32 AM John Johansen
> <john.johansen@canonical.com> wrote:
> >
> > On 6/11/24 01:09, Jonathan Calmels wrote:
> > > On Sun, Jun 09, 2024 at 08:18:48PM GMT, Paul Moore wrote:
> > >> On Sun, Jun 9, 2024 at 6:40 AM Jonathan Calmels <jcalmels@3xx0.net> wrote:
> > >>>
> > >>> This patch allows modifying the various capabilities of the struct cred
> > >>> in BPF-LSM hooks. More specifically, the userns_create hook called
> > >>> prior to creating a new user namespace.
> > >>>
> > >>> With the introduction of userns capabilities, this effectively provides
> > >>> a simple way for LSMs to control the capabilities granted to a user
> > >>> namespace and all its descendants.
> > >>>
> > >>> Update the selftests accordingly by dropping CAP_SYS_ADMIN in
> > >>> namespaces and checking the resulting task's bounding set.
> > >>>
> > >>> Signed-off-by: Jonathan Calmels <jcalmels@3xx0.net>
> > >>> ---
> > >>>   include/linux/lsm_hook_defs.h                 |  2 +-
> > >>>   include/linux/security.h                      |  4 +-
> > >>>   kernel/bpf/bpf_lsm.c                          | 55 +++++++++++++++++++
> > >>>   security/apparmor/lsm.c                       |  2 +-
> > >>>   security/security.c                           |  6 +-
> > >>>   security/selinux/hooks.c                      |  2 +-
> > >>>   .../selftests/bpf/prog_tests/deny_namespace.c | 12 ++--
> > >>>   .../selftests/bpf/progs/test_deny_namespace.c |  7 ++-
> > >>>   8 files changed, 76 insertions(+), 14 deletions(-)
> > >>
> > >> I'm not sure we want to go down the path of a LSM modifying the POSIX
> > >> capabilities of a task, other than the capabilities/commoncap LSM.  It
> > >> sets a bad precedent and could further complicate issues around LSM
> > >> ordering.
> > >
> > > Well unless I'm misunderstanding, this does allow modifying the
> > > capabilities/commoncap LSM through BTF. The reason for allowing
> > > `userns_create` to be modified is that it is functionally very similar
> > > to `cred_prepare` in that it operates with new creds (but specific to
> > > user namespaces because of reasons detailed in [1]).
> >
> > yes
> >
> > > There were some concerns in previous threads that the userns caps by
> > > themselves wouldn't be granular enough, hence the LSM integration.
> >
> > > Ubuntu for example, currently has to resort to a hardcoded profile
> > > transition to achieve this [2].
> > >
> >
> > The hard coded profile transition, is because the more generic solution
> > as part of policy just wasn't ready. The hard coding will go away before
> > it is upstreamed.
> >
> > But yes, updating the cred really is necessary for the flexibility needed
> > whether it is modifying the POSIX capabilities of the task or the LSM
> > modifying its own security blob.
> >
> > I do share some of Paul's concerns about the LSM modifying the POSIX
> > capabilities of the task, but also thing the LSM here needs to be
> > able to modify its own blob.
> 
> To be clear, this isn't about a generic LSM needing to update its own
> blob (LSM state), it is about the BPF LSM updating the capability
> sets.  While we obviously must support a LSM updating its own state,
> I'm currently of the opinion that allowing one LSM to update the state
> of another LSM is only going to lead to problems.  We wouldn't want to
> allow Smack to update AppArmor state, and from my current perspective
> allowing the BPF LSM to update the capability state is no different.
> 
> It's also important to keep in mind that if we allow one LSM to do
> something, we need to allow all LSMs to do something.  If we allow
> multiple LSMs to manipulate the capability sets, how do we reconcile
> differences in the desired capability state?  Does that resolution
> change depending on what LSMs are enabled at build time?  Enabled at
> boot?  Similarly, what about custom LSM ordering?
> 
> What about those LSMs that use a task's capabilities as an input to an
> access control decision?  If those LSMs allow an access based on a
> given capability set only to have a LSM later in the ordering modify
> that capability set to something which would have resulted in an
> access denial, do we risk a security regression?

I understand the concerns, what I fail to understand however, is how is
it any different from say the `cred_prepare` hook today?

> Our current approach to handling multiple LSMs is that each LSM is
> limited to modifying its own state, and I'm pretty confident that we
> stick to this model if we have any hope of preserving the sanity of
> the LSM layer as a whole.  If you want to modify the capability set
> you need to do so within the confines of the capability LSM and/or
> modify the other related kernel subsystems (which I'm guessing will
> likely necessitate a change in the LSMs, but that avenue is very
> unclear if such an option even exists).

What do you mean by "within the confines of the capability LSM" here?

Arguably, if we do want fine-grained userns policies, we need LSMs to
influence the userns capset at some point. Regardless of how or where we
do this, it will always be subject to some sort of ordering. We could
come up with some rules to limit surprises (e.g. caps can only be
dropped, only possible through some hooks, etc), but at the end of the
day, something needs to have the final word when it comes to deciding
what the creds should be.

