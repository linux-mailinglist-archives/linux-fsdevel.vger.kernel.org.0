Return-Path: <linux-fsdevel+bounces-66677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 216E2C283E9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 18:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B20423497AC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 17:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C002F9DA0;
	Sat,  1 Nov 2025 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bmKcNf3b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07E92C0286
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Nov 2025 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762018580; cv=none; b=IdZyyHLnl04Dmr+UD/VAonit6opdBEB9SmJ0BX9Tvtf9NWTvZc8U83cQq3wSGtfHyr/voyE1tHU5p00GjICAQFzJgEmO+fc+sUOX8h6XYx8t8UzBTIGhs5vx4WuAaIQ9p1BF3Jm5a79XCP4+Xs2VepG9tuzxxvNnvLRh1UDHZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762018580; c=relaxed/simple;
	bh=qf+ePpzEwV0T+sTFpqMnaKsTkQ7S334BUUkS2amf07A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3w27TwGThhZEouj2bFwwudV9FkUtWkG+THWKNknnJp8yHzFIyMytTO1J0cia7rGsnwzJEAe7uDpQf+9EnlU/ZieSKnyaz4jw8beT1CS/Y6iHjD+t6iAWeMqWht3Gp2Yro1wdfOHfqYRZu+FyKUHSsdius/P8naOFs5jwPs6dnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bmKcNf3b; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-793021f348fso2767540b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Nov 2025 10:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762018578; x=1762623378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyP1MTVcSsvaltoQodpw/+JP577TbPxpgLTVd2irWKs=;
        b=bmKcNf3b0d51rp7vCe1Z1Y4WfxolfO5r0F3dejGvegs0J0dN0FVs/E5qvNHJTrj3oq
         78TBpuYuAPzjkDiisX91VxNPNJoY3faYPhpLTCcnQnYn82PpiG8MaAVSF2k0+GxWLs2i
         j6vSd8TuV0NLXQ9MkMAOJZaLJiBL78WzxgsKv/fuPylMiGSk3KzArc7o2GWeSrKh4z8t
         FzcTdLpWom/hL2tr7wQ4W6wDC9uqkGmZIgzruWhyJK1UTM8zgutp8QZNL+IgitPjffFH
         490vYogFhehf/3LleDmma1Nngh31HHFPGJ8JClzTmp4JJSSmmMSks2/SkaBDDYSyklTp
         7rGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762018578; x=1762623378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyP1MTVcSsvaltoQodpw/+JP577TbPxpgLTVd2irWKs=;
        b=L3Fbq2FZYK+Qnp90mv6L1SGwZwsKD0Ax4qqv6+S4yJCA8cenK8pWNFev0S/nNuVoXj
         MkGfTk45OVD4w9A/36L1dzh/EKz/ZAHYhn8js8SK/d4+bdQJ6TJs+Aa6OB2PstuRC2x7
         UM0nwon4Vxb5wWXR0ikrCFNLbk573HFWRZmxVoAA0HoL7U5pS1zjfm6Ur0IJbgkozw09
         5N+VgcYDaTkaoGyLC66YCk/hCjmI1eMbNXJQq4DOgVMh7iMXOPQKOK7w3Xfcar68xttT
         FjGh6rSXQCQudiQnmSuQSZ6XMfgpP3USpjl1Kw1t+ACCbIb1rXBpF7OlrYUEqp74YCN4
         82Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWG+9tg6jr8exer0Xcv2xvHJRHBOHSAeyLYSLXksdXAXYUwQObpv/Wgswk6UvQ8TbZO9BYpKbQSLytwrPs7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ZIi2TnFkOn9M2VFlABWwe5GOstc6xvQ9Ep1LhgflcZnguFno
	f+hSz/yJNrUvy/02/eTbjC6xa0ZQsaztyyEQpq4Ps7hGIWjeyNaxHCxVLzMmx50hgwYg+JArrsW
	b9btNFOEezlx+p1pPCF7qU5+b+B4G+AgzfG8yjNQZ
X-Gm-Gg: ASbGncuLeZMd2mLyxwfprVYUa3M2sLLQGuuoJ4LKQlPXlafxnvAuRJBpLsqQ16h669l
	UCzN3Phw1yd8D2deLiDqmN8h5FRXHIIPd832YNCntTUhpS6j7aWxYmfj9cJpGGycK6XiQSrd131
	6HDNeMdSA+29IAAXMqDE2PQe578NJAmvtOU/Rlo92XYgD8YDC2/AkHOvF73ND39uGCkZXT/TB88
	KwVw5OMDk6K5Ihiq8/M9R0LY7hlnTLmZew7WKEedeY4MQ9A/lrAQgglh2njkyuQu7iBLQI=
X-Google-Smtp-Source: AGHT+IHJixs3LJQKqZ6RgM4jbxOe6M9rOVhd3EkrJ5bmspsc9xawkZoiw/W6biXQ+gB/NK1xJYNE4PeS+rXwIu/l6zQ=
X-Received: by 2002:a05:6a20:6a0b:b0:334:9b5d:3876 with SMTP id
 adf61e73a8af0-348c9d69d6cmr9955170637.4.1762018577974; Sat, 01 Nov 2025
 10:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031080615.GB2441659@ZenIV>
In-Reply-To: <20251031080615.GB2441659@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 1 Nov 2025 13:36:06 -0400
X-Gm-Features: AWmQ_bkElVTmY1Q6A1T5hxRqSk7rkRDygri652wrM2uBDucqgiGJyvzOlz080g4
Message-ID: <CAHC9VhTqhGCPJ37mAhKRE2SEnHup5+gSPoZV-SZkoszfcUk0xw@mail.gmail.com>
Subject: Re: [viro@zeniv.linux.org.uk: [RFC] audit reporting (or not
 reporting) pathnames on early failures in syscalls]
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: audit@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 4:06=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>         FWIW, I've just noticed that a patch in the series I'd been
> reordering had the following chunk:
> @@ -1421,20 +1421,16 @@ static int do_sys_openat2(int dfd, const char __u=
ser *filename,
>                           struct open_how *how)
>  {
>         struct open_flags op;
> -       struct filename *tmp;
>         int err, fd;
>
>         err =3D build_open_flags(how, &op);
>         if (unlikely(err))
>                 return err;
>
> -       tmp =3D getname(filename);
> -       if (IS_ERR(tmp))
> -               return PTR_ERR(tmp);
> -
>         fd =3D get_unused_fd_flags(how->flags);
>         if (likely(fd >=3D 0)) {
> -               struct file *f =3D do_filp_open(dfd, tmp, &op);
> +               struct filename *name __free(putname) =3D getname(filenam=
e);
> +               struct file *f =3D do_filp_open(dfd, name, &op);
>                 if (IS_ERR(f)) {
>                         put_unused_fd(fd);
>                         fd =3D PTR_ERR(f);
>
>         From the VFS or userland POV there's no problem - we would get a
> different error reported e.g. in case when *both* EMFILE and ENAMETOOLONG
> would be applicable, but that's perfectly fine.  However, from the audit
> POV it changes behaviour.
>
>         Consider behaviour of openat2(2).
> 1.  we do sanity checks on the last ('usize') argument.  If they
> fail, we are done.
> 2.  we copy struct open_how from userland ('how' argument).
> If copyin fails, we are done.
> 3.  we do sanity checks on how->flags, how->resolve and how->mode.
> If they fail, we are done.
> 4.  we copy the pathname to be opened from userland ('filename' argument)=
.
> If that fails, or if the pathname is either empty or too long, we are don=
e.
> 5.  we reserve an unused file descriptor.  If that fails, we are done.
> 6.  we allocate an empty struct file.  If that fails, we are done.
> 7.  we finally get around to the business - finding and opening the damn =
thing.
> Which also can fail, of course.
>
>         We are expected to be able to produce a record of failing
> syscall.  If we fail on step 4, well, the lack of pathname to come with
> the record is to be expected - we have failed to get it, after all.
> The same goes for failures on steps 1..3 - we hadn't gotten around to
> looking at the pathname yet, so there's no pathname to report.  What (if
> anything) makes "insane how->flags" different from "we have too many
> descriptors opened already"?  The contents of the pathname is equally
> irrelevant in both cases.  Yet in the latter case (failure at step 5)
> the pathname would get reported.  Do we need to preserve that behaviour?

With the only real difference, from an audit perspective, between the
current behavior and the proposed reordering being audit doesn't
record a pathname in the case a fd can't be allocated, I'm not too
bothered by the change.

Based on discussions with people that actually use audit on real
systems, on open failure the pathname is most interesting when the
failure is caused by a permission failure somewhere along the path
walk, the you're-trying-to-access-things-you-shouldn't-be-accessing
case.  Even with the reordering we still do the getname() call before
the do_filp_open() (duh) so we are fine in that regard.

I suppose one could make an argument about someone possibly trying to
do something "bad" and bumping into the open file limit, either as a
test or the exploit itself, and wanting to audit that.  However, in
this case I think the pathname is probably the least interesting thing
here, the goal would likely be to successfully open the file (or hit
the limit) in which case the user would surely pick a file they know
they would be able to open, making the pathname a bit boring and not
very useful as an indicator of bad behavior.

>         Because the patch quoted above would change it.  It puts the fail=
ure
> to allocate a descriptor into the same situation as failures on steps 1..=
3.
>
>         As far as I can see, there are three possible approaches:
>
> 1) if the current kernel imports the pathname before some check, that sha=
ll
> always remain that way, no matter what.  Audit might be happy, but nobody
> else would - we'll need to document that constraint and watch out for suc=
h
> regressions.  And I'm pretty sure that over the years there had been
> other such changes that went into mainline unnoticed.

Re: regressions ... sadly we don't have great audit test coverage at
this point.  We used to have a pretty good test suite thanks to the
security certification work, but I never could get the distros to do
the maintenance/upkeep of the test suite outside the scope of the
certification effort so it has fallen out of use.  We've got a
smaller, easier to run and maintain test suite which is "okay" but it
still has a number of gaps; thankfully we're starting to see some
renewed effort there which makes me happy.

> 2) reordering is acceptable.  Of course, the pathname import must happen
> before we start using it, but that's the only real constraint.  That woul=
d
> mean the least headache for everyone other than audit folks.

I'm not sure it really bothers me at this point in time.  Can we make
an agreement that reordering is okay right now, but if we have a
certification requirement in the future about having a pathname if
earlier we can revisit/rework this?

... and yes, I know people hate security certifications, and just
"security" in general.  Fine, whatever, good for you.  However, like
it or not, these certifications make or break the use of Linux in a
number of situations that are important to a lot of users.  If we want
to ensure that Linux continues to be a viable solution across a large
number of use cases, and not just the small handful of hyperscalers,
one of the things we need to do is make sure Linux can continue to
meet these security certifications.

> 3) import the pathnames as early as possible.  It would mean a non-trivia=
l
> amount of churn, but it's at least a definite policy - validity of change
> depends only on the resulting code, not the comparison with the earlier
> state, as it would in case (1).  From QoI POV it's as nice as audit folks
> could possibly ask, but it would cause quite a bit of churn to get there.
> Not impossible to do, but I would rather not go there without a need.
> Said that, struct filename handling is mostly a decent match to CLASS()
> machinery, and all required churn wouldn't be hard to fold into conversio=
n
> to that.
>
>         My preference would be (2), obviously.  However, it really depend=
s
> upon the kind of requirements audit users have.  Note that currently the
> position of pathname import in the sequence is not documented anywhere,
> so there's not much audit users can rely upon other than "the current
> behaviour is such-and-such, let's hope it doesn't change"... ;-/

Like I said above, I'm okay with option #2 so long as we can move the
pathname capture earlier if needed at some point in the future.  I
don't want to inflict pain on the kernel if it isn't needed, but I've
also grown very weary of having to fight with every subsystem out
there to claw things back that are necessary for adoption.  If you
need a hard and fast policy now, then it would have to be option #3,
but if we all promise to be reasonable adults I'm okay with option #2.

--=20
paul-moore.com

