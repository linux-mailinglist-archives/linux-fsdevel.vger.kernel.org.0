Return-Path: <linux-fsdevel+bounces-25695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A994F46D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 18:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499941C20E4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 16:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084B5187543;
	Mon, 12 Aug 2024 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DHQSnxT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1317186E5E
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480217; cv=none; b=Q6E+0Xxt9cHb5fF7l8hZTZQcPeT7IZUq38y9JBTR0ryHkbTSbFpE9UYq0NoLjA1+SOf/ZOyS28ya1cPIWw0lc+9ZEj6R7Jv8l+8+BSJfALeIgItG+c2Oy5mQolF/chbsFeaGiOcZG4be2lM13FSHhe7pBUpgsNWkAPK9inB2Cng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480217; c=relaxed/simple;
	bh=pI3b2F23yTc0ZJIxRjaRPML+T+3j/qumlRnHsT3WJjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jk9gniM6vbGQKbjGH901tXNIFLlHTwEqiGLShefFCXt5mj90WNBG3I1dzVSUbPIgwayAwfmTf5wvhIpDwaLgis+fTRoy6yS5qu7neGyZUe9s/uPJ6nQC7yRjhPTqc873A290DgjqH/Tpe/BLIFcet3TnydUhaUjKp0Yz6Q0ojgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DHQSnxT7; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so4264036276.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 09:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723480215; x=1724085015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIeK2Fg1hKXf5ChuuEo0tuaD3odgjAn6dYDI3lZpdhs=;
        b=DHQSnxT7leWutgYlBn34fhynViNeDJnxWxuCaGxu928RAGcsEFkAg/9B3+USU0cCqh
         hy+QcFfGZxav43Y7GxPHCSiYTA1BsRRgRfUwSno5VW0hNgyUyHtb4jmoy5XOCEPV7YIf
         xL/rrPHPGlvWI4vEUiw+qCK2Le633KNDn0pnGqA0e5Jffw30ZQdhg/sDH08Jm48iD/GI
         K2qRpr5h23WXOYKFY/YI7KZNKUJOayWcnZ1mMBgROD5lG6YwPrv9b2+uPdJpeE6ofuZf
         y/N3H2VF9OFtoiixVMcBzyX+bJvx2HpVQaRAshBTV05tFa4Riv3RD9glq/DkzdLfbvqS
         upxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723480215; x=1724085015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIeK2Fg1hKXf5ChuuEo0tuaD3odgjAn6dYDI3lZpdhs=;
        b=U7He09esWxVaIaAStsNdq9HT4aOwfQibxlE9JgDHcuu4+nShhn8ZaEgxq3ldX/pSCh
         eFgJdOEXaQaql5r/T1IEMfzXQ52vxZwqS9ibBVBNkyCjsxVfubqvWr5vGFtAwlKT3ELl
         U5kyffI5nRcDPdgOM1Dhf2UOwzzdhaBSmJv+qotQwfEtuKSGlmMmgPhOLcWMgKw+GRdC
         NXYCd5Tl68Du7cGzUamhoXD07W3X1zvGU3cmFkSFOA/QkMgvH87aec+H4cXlwhWK2TzM
         0H3VqRDPtTUXTh+doUbg9/iTnNuHb6+omFJlUhq5S0n0k7Y4tJcN0ACDjh4JwMhAIXCP
         H2ig==
X-Forwarded-Encrypted: i=1; AJvYcCV+nlwldU2KUR3iz4wmzLROo/Hcn4oKtzw24OcWx0hzHdupMMIUCAcK4l66su+qb8EaxnZAYnKneWlZWp8KvnHCwHzil93J0O2pDOiIXQ==
X-Gm-Message-State: AOJu0YyK+c4Mdj2Ni4m0lvb2fRCT4irYPL4m4yLpeSajUUi0QfObu+tD
	AMNII3L5Pu7IXWaTgXxKdkHzqlAXjtf5/x5ngYqlZ45QHMrf5J7AAD/zWuaJA/55Jy2xkqRKaHg
	fYKhzZX561TixHOo6vVetergLUoDKnZjhQn4u
X-Google-Smtp-Source: AGHT+IGpVnCsdmUNUi7WGZpBIrJoz8yIa/TuWZlTMslOadKwxRt1BZeiXT7E9WrMn4XRsUdmhp7XHnN8BgL4SH5U/nM=
X-Received: by 2002:a05:6902:18d0:b0:e03:5bca:aee6 with SMTP id
 3f1490d57ef6-e113d2bdac8mr1514498276.54.1723480214767; Mon, 12 Aug 2024
 09:30:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <49557e48c1904d2966b8aa563215d2e1733dad95.1722966592.git.fahimitahera@gmail.com>
 <CAG48ez3o9fmqz5FkFh3YoJs_jMdtDq=Jjj-qMj7v=CxFROq+Ew@mail.gmail.com>
 <CAG48ez1jufy8iwP=+DDY662veqBdv9VbMxJ69Ohwt8Tns9afOw@mail.gmail.com>
 <20240807.Yee4al2lahCo@digikod.net> <ZrQE+d2b/FWxIPoA@tahera-OptiPlex-5000>
 <CAG48ez1q80onUxoDrFFvGmoWzOhjRaXzYpu+e8kNAHzPADvAAg@mail.gmail.com>
 <20240808.kaiyaeZoo1ha@digikod.net> <CAG48ez34C2pv7qugcYHeZgp5P=hOLyk4p5RRgKwhU5OA4Dcnuw@mail.gmail.com>
 <20240809.eejeekoo4Quo@digikod.net> <CAG48ez2Cd3sjzv5rKT1YcMi1AzBxwN8r-jTbWy0Lv89iik-Y4Q@mail.gmail.com>
 <20240809.se0ha8tiuJai@digikod.net> <CAG48ez3HSE3WcvA6Yn9vZp_GzutLwAih-gyYM0QF5udRvefwxg@mail.gmail.com>
 <CAHC9VhQsTH4Q8uWfk=SLwQ0LWJDK5od9OdhQ2UBUzxBx+6O8Gg@mail.gmail.com>
 <CAG48ez1fVS=Hg0szXxQym9Yfw4Pgs1THeviXO7wLXbC2-YrLEg@mail.gmail.com>
 <CAHC9VhS6=s9o4niaLzkDG6Egir4WL=ieDdyeKk4qzQo1WFi=WQ@mail.gmail.com> <CAG48ez2tvHgv7sOVP14gCF1MAGE-UzJoMCfZqdmY1nXX4FFV4Q@mail.gmail.com>
In-Reply-To: <CAG48ez2tvHgv7sOVP14gCF1MAGE-UzJoMCfZqdmY1nXX4FFV4Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 Aug 2024 12:30:03 -0400
Message-ID: <CAHC9VhQY+H7n2zCn8ST0Vu672UA=_eiUikRDW2sUDSN3c=gVQw@mail.gmail.com>
Subject: Re: f_modown and LSM inconsistency (was [PATCH v2 1/4] Landlock: Add
 signal control)
To: Jann Horn <jannh@google.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tahera Fahimi <fahimitahera@gmail.com>, gnoack@google.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 11:06=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
> On Mon, Aug 12, 2024 at 4:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Mon, Aug 12, 2024 at 9:09=E2=80=AFAM Jann Horn <jannh@google.com> wr=
ote:
> > > On Mon, Aug 12, 2024 at 12:04=E2=80=AFAM Paul Moore <paul@paul-moore.=
com> wrote:
> >
> > ...
> >
> > > > From a LSM perspective I suspect we are always going to need some s=
ort
> > > > of hook in the F_SETOWN code path as the LSM needs to potentially
> > > > capture state/attributes/something-LSM-specific at that
> > > > context/point-in-time.
> > >
> > > The only thing LSMs currently do there is capture state from
> > > current->cred. So if the VFS takes care of capturing current->cred
> > > there, we should be able to rip out all the file_set_fowner stuff.
> > > Something like this (totally untested):
> >
> > I've very hesitant to drop the LSM hook from the F_SETOWN path both
> > because it is reasonable that other LSMs may want to do other things
> > here,
>
> What is an example for other things an LSM might want to do there? As
> far as I understand, the whole point of this hook is to record the
> identity of the sender of signals - are you talking about an LSM that
> might not be storing credentials in struct cred, or something like
> that?

Sure.  The LSM framework is intentionally very vague and limited on
what restrictions it places on individual LSMs; we want to be able to
support a wide range of security models and concepts.  I view the
F_SETOWN hook are important because it is a control point that is used
to set/copy/transfer/whatever security attributes from the current
process to a file/fd for the purpose of managing signals on the fd.

> > and adding a LSM hook to the kernel, even if it is re-adding a
> > hook that was previously removed, is a difficult and painful process
> > with an uncertain outcome.
>
> Do you mean that even if the LSM hook ends up with zero users
> remaining, you'd still want to keep it around in case it's needed
> again later?

I want the security_file_set_fowner() hook to remain a viable hook for
capturing the current task's security attributes, regardless of what
security attributes the LSM is interested in capturing and where those
attributes are stored.

--=20
paul-moore.com

