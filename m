Return-Path: <linux-fsdevel+bounces-71770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0201ECD14E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 19:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4594730F6C1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 18:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D19734D910;
	Fri, 19 Dec 2025 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="EKmKx6cq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E38B34D914
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166237; cv=none; b=uj7zYeWSVtGPJ2Fdu9X1V/moy8pxXO8zeaWdfRRIft2t1siWbL8zPiD+cmx+aKpYezKxhkEjHkIFir+bnyFI5oqun2hy4Jw59q4WedTW7uKCCol+MZE48l+65UQM3NEz+oBnIKAKaKy8otIXwEp+BSp8/7paSG6hF5my2LbZkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166237; c=relaxed/simple;
	bh=clJOmcKBoIw88yyLKoGsGuFZz1HxZegEl+3YdMQFKMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpdkWuWx0ShuBpsr3lZWtzWZ2hULMp+cX7T2Vmz6WYj9Hy8VwO2VtqBOwQHvQvDp6eBXO4CTSTENXGasNf35mglvVNoVU7iDQLnO/yOHDo11PQIiA3kgsZg1r+N3yLBrXWg6dcEQrt90q7009vtW4X0M9UbkZ6fTnuV/1hRcTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=EKmKx6cq; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59577c4c7c1so2726606e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 09:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1766166233; x=1766771033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVixkaXTuKtHeBsxOi4jAc7JBev7bh1+nWIb2RYC3oo=;
        b=EKmKx6cqr0SKapJQjrfCqcQiCJxEOFpQA2bZrGPDQusRExrdzSg3O1cg8J1T1F5dq7
         HfCYi7J/PCL7b89wyYON+ZJtrp0ohFzsJ8hliEHDNCzVeYT5ZR0FjaJWmw7z0gVZBU3k
         VnTbSjiBfsG/mkpXxhBFIuh7WkNMfIwF4nezT0CJsdUN0d4XeZTbWOfHDA8FIeSWrc8s
         RCR14tbgbCqSiu8h291hp+zTNA7OyazxxPQXPQzBRL+XH9iNXpLbD+XsXJzjiinRm6lz
         SFv16SuySrm8CfnZOQbaWnQ2bxvm/ieh3XeW5U2AhEvwt6eKDtoJOOQdAfsVxotyzUda
         lWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766166233; x=1766771033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NVixkaXTuKtHeBsxOi4jAc7JBev7bh1+nWIb2RYC3oo=;
        b=PNcKchOuiYb/M86asck04MJJHHFHAuFrrMDtg2toJapgiUBoVLu4PFuQvWQswV2w1F
         CfLCV7rqDZ5wwJE+LqHlrfaF86Aeza66/+YyuNQQehCZMYJtTy6WjwjfGuHK4RgaPaeA
         HRXANTYavxHA9wq7VqUFRrvsw5XEVwdbILsZcRXIYFu4f23/YUlr1jJE5s/CBhzM5y8f
         uTSI5lD2kywzJcS1Rk2wi3bX6IGwz2/vVJS+Us6h493o5z+ujcjZT+8NPc5+mGG59NJ/
         b4k3EVWwAhlz9yRqRYSkqiF2EjHX1vtWeCtjIXQ+47o6KaQWFfdmzMwhOy/nb/xbL5k9
         dj5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhy5dKSR8lvsXg75iF+kgUHjseBUv574hwk+ShIh3ANNcNbQZ/7JJJHXRH/czBZ7Hir+yDyd53199iDmNA@vger.kernel.org
X-Gm-Message-State: AOJu0YzugFTGLabAGZrNoDRNNcUz5KbNslKRF21kYPpPVbM99uH4vjny
	mkq3BWDnpex0HGS/p9VvacM3mI2cBVuDlvbhuCWYkqlhOPszFc05j4db/w3NwkIl9eS6HQerLJl
	XoyzWxqENnLnKttl+AEeAcvmdW67n3c8=
X-Gm-Gg: AY/fxX6ubyqGCSQjapsJDfCws9C7Mg3BZLQKB6qJdwlpAXyAHplhhtnOGJUnILmCzsY
	jT9AgzcJv34Sr4g/uY3wH2HMk20Vt4ZSOeVZtkr+18HLz6QZ5GKz92TvXqrvPzZwq0SM61AzZx3
	LW4pVtAyWJofKcyQBKys4j3Ob/vACb6aRo3PZviHHAWYGOGZ1ErieNVwV14DRR349q5+B9mWtO6
	Sv0hHgFx7mAGLW+tqIGBOE21nVWVu0YoGDuvOZ6ABgDwwkQx/9K/CZEgeV+K571tt3TqreT/iGC
	GLyV3rbxiA99tr7Lj5YeHLOPNO5ROA==
X-Google-Smtp-Source: AGHT+IGBTzirJN0UMNYnb3SF06ff10PRsmk6ZfxGaQEVs2SJVv9RMQ8FyELJ0lDv89cOigRB7MBj/ZxfRIZYQuecn6E=
X-Received: by 2002:a2e:be1b:0:b0:37b:9674:f480 with SMTP id
 38308e7fff4ca-38113248ba3mr22256161fa.11.1766166232887; Fri, 19 Dec 2025
 09:43:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
 <20250730-nfsd-testing-v4-8-7f5730570a52@kernel.org> <CAN-5tyEjYRFrJ7Gc4S8KwAZUuF-uz6ovPa4-_ynt+GGVqJHN_A@mail.gmail.com>
 <ca86b70c1a4a25c2f084bfce53ed864a557ebfed.camel@kernel.org>
In-Reply-To: <ca86b70c1a4a25c2f084bfce53ed864a557ebfed.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 19 Dec 2025 12:43:41 -0500
X-Gm-Features: AQt7F2o2e0WOyiUDgBbJV-UEiZdMnMvYpMz7N-BnEynBqDbI0To7sXd0rYxMHwc
Message-ID: <CAN-5tyE1YazMhYJX5qT-YM=+h_rcQ+C9PZBNEEvwWRnWZtLXGQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] nfsd: freeze c/mtime updates with outstanding
 WRITE_ATTRS delegation
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Chuck Lever <chuck.lever@oracle.com>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@hammerspace.com>, 
	Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 12:25=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Fri, 2025-12-19 at 10:58 -0500, Olga Kornievskaia wrote:
> > Hi Jeff,
> >
> > I narrowed down the upstream failure for generic/215 and generic/407
> > to this commit.
> >
> > Let's consider first where the kernel is compiled with delegated
> > attributes off (but it also fails just the same if the delegated
> > attributes are compiled in).
> >
> > I don't understand why the code unconditionally changed to call
> > nfsd4_finalize_deleg_timestamps() which I think the main driver behind
> > the failure.
> >
> > Running generic/407 there is an OPEN (which gives out a write
> > delegation) and returns a change id, then on this filehandle there is
> > a SETATTR (with a getattr) which returns a new changeid. Then there is
> > a CLONE where the filehandle is the destination filehandle on which
> > there is a getattr which returns unchanged changeid/modify time (bad).
> > Then there is a DELEGRETURN (with a getattr) which again returns same
> > change id. Test fails.
> >
> > Prior to this commit. The changeid/modify time is different in CLONE
> > and DELEGRETURN -- test passes.
> >
> > Now let me describe what happens with delegated attributes enabled.
> > OPEN returns delegated attributes delegation, included getattr return
> > a changeid. Then CLONE is done, the included gettattr returns a
> > different (from open's) changeid (different time_modify). Then there
> > is SETATTR+GEATTR+DELEGRETURN compound from the client (which carries
> > a time_deleg_modify value different from above). Server in getattr
> > replies with changeid same as in clone and mtime with the value client
> > provided. So I'm not sure exactly why the test fails here but that's a
> > different problem as my focus is on "delegation attribute off option"
> > at the moment.
> >
> > I don't know if this is the correct fix or not but perhaps we
> > shouldn't unconditionally be setting this mode? (note this fix only
> > fixes the delegattributes off. however i have no claims that this
> > patch is what broke 215/407 for delegated attributes on. Something
> > else is in play there). If this solution is acceptable, I can send a
> > patch.
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 81fa7cc6c77b..624cc6ab2802 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -6318,7 +6318,8 @@ nfs4_open_delegation(struct svc_rqst *rqstp,
> > struct nfsd4_open *open,
> >                 dp->dl_ctime =3D stat.ctime;
> >                 dp->dl_mtime =3D stat.mtime;
> >                 spin_lock(&f->f_lock);
> > -               f->f_mode |=3D FMODE_NOCMTIME;
> > +               if (deleg_ts)
> > +                       f->f_mode |=3D FMODE_NOCMTIME;
> >                 spin_unlock(&f->f_lock);
> >                 trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> >         } else {
> >
> >
>
> That patch does look correct to me -- nice catch. Have you validated
> that it fixes 215 and 407?

Yes, it does fix 215 and 407 for me.

>
> Thanks,
> Jeff
> --
> Jeff Layton <jlayton@kernel.org>

