Return-Path: <linux-fsdevel+bounces-45153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 725C1A73A39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 18:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576583AF437
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 17:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E974B1AF0D6;
	Thu, 27 Mar 2025 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCbVyf/M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0CE1A8F71;
	Thu, 27 Mar 2025 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743095653; cv=none; b=RggmqXJAqv3TuIuXr+UQI1S8Dl0g0E39UQjcJlje6CcFtHfOOmBJ9eCtR0SARXRYD50VPTJFFYo76dG5bBTQKuaUW7mSuRBzH9PTEYNaMfZUaKevMamWFaXR8dttA3JeIgA2w6RKqrlV38idr47/XePfj070vqZV/EqWZtzHdoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743095653; c=relaxed/simple;
	bh=rQMinX0XNjR7/a5iErmX7qGW1+nEYEwP5Qn/aB+I7EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLM/kI82x2pNtcBjTv6Q/BRDgIlfEvKG3+jGrusAgAE0uyNqihBedrbXBBkaN79CnmmZliOIsx8gsEVh6puEkCfEFu0FY0O9LQ/9/R2xPsITz8EJ8RZ+jHCY9zKQUEeY4NgKyQlvqjCz6CgmV3dt+khTuYj87ZACyyBZjoxtrJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCbVyf/M; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5eb92df4fcbso2205804a12.0;
        Thu, 27 Mar 2025 10:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743095648; x=1743700448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lysXTHavxcrjFY0zeQndTG+44zUJzwOCDCJjIjy0GQ=;
        b=QCbVyf/MslSsl6aEI5IjYMS+A6QuxsrOcRSho/KlCaS0Tnn1bqUmRfNp6VwkbyU928
         jbzYqDuECDQj5wmd/q3NZNgk4pphYLWTaX7DeEEZhuijt7Bsw444STOXqVTo90OAlNBo
         LaiFK+SPj3IeKulUeAsIvCjU2iMq68Ox5lWlBp7re6qtiRGaaIl20HhVJCHXVig0ll6z
         VJUsRbXBhdyygiWf9vI2vxF4alwtKYFy69XZFJi7TlM3TFwlAnc74bnqHrRMs3rNmoLr
         jep8dHaDBxrTNnUaPE0Fny1qYWoHqyGkVOwgmZbD9WRmfoIlU2Sd4ih6OCcoURI8XEqN
         wkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743095648; x=1743700448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lysXTHavxcrjFY0zeQndTG+44zUJzwOCDCJjIjy0GQ=;
        b=L8Emb1NhMq8OE3IuUZRKM1jQ5OII3XZ/buqOYGkGDhlM98n7Ma7vY2T6Fl1xDbSogt
         PRVbvGWKQardgv9EirmIhlglTBvwY07ULrft6QxE4bTLOXZBAPixfhxKWmimuxSgFzb7
         9QkWn5GKOT5cD5vRUW+0tH1LZqi5z3rHzcIIesWWqMMQLFIdIclA2WcASHJkV+1iOxXP
         /DNbfxvQeV2xrnOe6+nu3IDPvd8Gian6BbVYmVsjvzn8WMsgPP73uowd6ZZgl5juIKae
         frkVL4je1Mx6IVuv6lk33VJERHxf1CgeeB5LVyFqShqQ72r4L+2UP05Fv86tc56JsJM2
         euDw==
X-Forwarded-Encrypted: i=1; AJvYcCUtw9kd/bhIFpdZ4Undpw/hr6Q154GrqRURjjf7aIfmI3X4vSqw/I8YomGOVX9FJfCezPHCsp+biedqWC4F@vger.kernel.org, AJvYcCWlODFjsBN1bgQ/nkn50869LAlKDI2WjG+7YWwpB937kNiIFRxAmE6Kyq3Z4Yn76MdxAvwrvqHdygfCPz8/FQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2I2seQOenUjtgTpppyiH4XgAs1kWslN2wFbq5XZq0x6hkSiiC
	+GnBTRbVw2mV8uJ9P6clshyXMsxtZcCjwx+XT7zG5ZxGNwgkQENPqaZ5ID493SsvJmTHDG1MvLL
	SV7Bg+/kQJwdo00ym0qOldj278S4=
X-Gm-Gg: ASbGnctH/eZydt8ZvE2n0iibPJ8QaaugSVMpjkA6i9sWmYxJ8s2rnhVkl+AZLe6Vn+O
	iBTyrZYHO9d7fdjSVHRhz12XwzuWePjq9Js5eUCs4KFWSB8sOfYvJVV3V5BcjCwFBZuCwb0AsZV
	vH+wLCihANDoousZ4enfL5KOHlhA==
X-Google-Smtp-Source: AGHT+IHbpru8Tj0zrG0oJ2U5WZgDrB2Aj4vF55eI7meboejILkjuZ4uyLjjgCvPjFyzdxNggRnGNtwZ55PxxXigo9BM=
X-Received: by 2002:a17:907:9729:b0:ac3:b3a3:f19d with SMTP id
 a640c23a62f3a-ac6fb0ff0a1mr462776566b.43.1743095647616; Thu, 27 Mar 2025
 10:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-3-mszeredi@redhat.com>
 <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
 <CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
 <CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
 <CAJfpegsuN+C4YiA9PAuY3+-BJ959aSAaXTYBwKNCjEnhXVw0pg@mail.gmail.com>
 <CAOQ4uxjkBQP=x6+2YPYw4pCfaNy0=x48McLCMPJdEJYEb85f-A@mail.gmail.com>
 <CAJfpegvUdaCeBcPPc_Qe6vK4ELz7NXWCxuDcVHLpbzZJazXsqA@mail.gmail.com>
 <87a5ahdjrd.fsf@redhat.com> <CAJfpeguv2+bRiatynX2wzJTjWpUYY5AS897-Tc4EBZZXq976qQ@mail.gmail.com>
 <875xl4etgk.fsf@redhat.com> <CAJfpeguhVYAp5aKeKDXDwip-Z0hc=3W4t=TMLr+-cbEUODf2vA@mail.gmail.com>
 <CAOQ4uxgenjB-TQ4rT9JH3wk+q6Qb8b4TgoPxA0P3G8R-gVm+WA@mail.gmail.com> <CAJfpegu6mJ2NZr2rkCVexrayUt=wwNSyYv5AE694D04EH2vx2w@mail.gmail.com>
In-Reply-To: <CAJfpegu6mJ2NZr2rkCVexrayUt=wwNSyYv5AE694D04EH2vx2w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 27 Mar 2025 18:13:56 +0100
X-Gm-Features: AQ5f1Jqjxtaof17FlUIXZAKebrFWQrvGLIKi3qHR7MVEsEgv33GU_zWnOTnFn3c
Message-ID: <CAOQ4uxjad0hm10F1hMFX8uqZr+kJT-GibFNe9hAv_v971sb97A@mail.gmail.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Giuseppe Scrivano <gscrivan@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 4:28=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 25 Mar 2025 at 13:16, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, Feb 20, 2025 at 12:48=E2=80=AFPM Miklos Szeredi <miklos@szeredi=
.hu> wrote:
> > >
> > > On Thu, 20 Feb 2025 at 12:39, Giuseppe Scrivano <gscrivan@redhat.com>=
 wrote:
> > > >
> > > > Miklos Szeredi <miklos@szeredi.hu> writes:
> > > >
> > > > > On Thu, 20 Feb 2025 at 10:54, Giuseppe Scrivano <gscrivan@redhat.=
com> wrote:
> > > > >>
> > > > >> Miklos Szeredi <miklos@szeredi.hu> writes:
> > > > >>
> > > > >> > On Tue, 11 Feb 2025 at 16:52, Amir Goldstein <amir73il@gmail.c=
om> wrote:
> > > > >
> > > > >> >> The short version - for lazy data lookup we store the lowerda=
ta
> > > > >> >> redirect absolute path in the ovl entry stack, but we do not =
store
> > > > >> >> the verity digest, we just store OVL_HAS_DIGEST inode flag if=
 there
> > > > >> >> is a digest in metacopy xattr.
> > > > >> >>
> > > > >> >> If we store the digest from lookup time in ovl entry stack, y=
our changes
> > > > >> >> may be easier.
> > > > >> >
> > > > >> > Sorry, I can't wrap my head around this issue.  Cc-ing Giusepp=
e.
> > > > >
> > > > > Giuseppe, can you describe what should happen when verity is enab=
led
> > > > > and a file on a composefs setup is copied up?
> > > >
> > > > we don't care much about this case since the composefs metadata is =
in
> > > > the EROFS file system.  Once copied up it is fine to discard this
> > > > information.  Adding Alex to the discussion as he might have a diff=
erent
> > > > opinion/use case in mind.
> > >
> > > Okay.
> > >
> > > Amir, do I understand correctly that your worry is that after copy-up
> > > verity digest is still being used?  If that's the case, we just need
> > > to make sure that OVL_HAS_DIGEST is cleared on copy-up?
> > >
> > > Or am I still misunderstanding this completely?
> >
> > Sorry, I have somehow missed this email.
> >
> > TBH, I am not sure what is expected to happen in the use case in questi=
on
> > on copy up - that is if a full copy up on any metadata change is accept=
able.
> >
> > Technically, we could allow a metacopy upper as long as we take the md5=
digest
> > from the middle layer but that complicates things and I am not sure if =
we need
> > to care - can't wrap my head around this case either.
>
> I've been thinking.  If a lower file has verity enabled, and it is
> meta-copied up on ovl with verity=3Don (or verity=3Drequire), then it wil=
l
> have the digest stored in the .overlay.metacopy xattr. What this
> ensures is that the lower file cannot be swapped out without ovl
> noticing.

Do you mean the lowerdata file?

> However the .overlay.origin xattr ensures the same thing,

origin xattr only checks from upper to uppermost lower layer IIRC,
do definitely not all the way to lowerdata inode.

> so as long as the user is unable to change the origin integrity should
> be guaranteed.  IOW, what we need is just to always check origin on
> metacopy regardless of the index option.
>
> But I'm not even sure this is used at all, since the verity code was
> added for the composefs use case, which does not use this path AFAICS.
> Alex, can you clarify?

I am not sure how composefs lowerdata layer is being deployed,
but but I am pretty sure that the composefs erofs layers are
designed to be migratable to any fs where the lowerdata repo
exists, so I think hard coding the lowerdata inode is undesired.
But probably I did not understand what you meant?

Thanks,
Amir.

