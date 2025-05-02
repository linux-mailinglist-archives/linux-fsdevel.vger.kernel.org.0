Return-Path: <linux-fsdevel+bounces-47940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7B8AA78B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 19:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CD43AE26C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 17:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73CD1ABEAC;
	Fri,  2 May 2025 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjjjBT0A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0741A3174
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746207368; cv=none; b=qColuLhr+yPq5j0A4xdfJEC47J21+T359+RUuVhZ0epkhkqY7aTtmA5p7da1fhAPLqn9WhM6kfkeRQSgq76eBSQ39ST6wJvSXvijcUNFvlvAgD5MLMgOAPIhyR5yCiJGt/gv1STv1+Wc04S0tAuu2+QG4JhScOGysGTAgnVqb68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746207368; c=relaxed/simple;
	bh=pZaZWHeJsBXxajgLn97PcSeAAY9vGR/Lj4o47xAhLqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFph8wS8ZyPmzO3CyO7bWu054rl64daO8ujfdKj5P6XtWlewgwDkRZOutMl/AUDzffIzciEOmHZWPj+yW4EmwQNkjIrP7G+dCLjeknnd1tt38Rcuq9+/Eh3aIyXNf5MEg7P1hFQcu1Jc79oaIU4QMdcmH83uX9Vtyu1TreIiUYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjjjBT0A; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acb5ec407b1so362274166b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 May 2025 10:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746207364; x=1746812164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZaZWHeJsBXxajgLn97PcSeAAY9vGR/Lj4o47xAhLqQ=;
        b=gjjjBT0A65L2T538GwhKUKNDY6JnnSuM8tkrhnEdFFKoP3G34HTyNvQKNXrzAGfEWD
         gLM6U75vIhk+BdpwOnm5F99jknr1EF12njxIhbGpaDaUUMmQsgAbvrfE+92e+/mgB9A3
         djecWnvCOCFOte/0eUS8WGREn67y8T9eR/2fat9CQRdnXxU+AwsyMeqWVroCTQAYekwB
         OHYDw0VNePUf2p6/Lc/xPzq48YpzKWi2ouo6EOE9SBm1d4Q1qK0Dpf4zkTBZzgU48ZCy
         3eG+J2o2FBPvaX1gXMGFKlqFOQDoxoZNc7RcHAJq/Q2YTqbpmWM/2kyE02XQdN3lAP3q
         a1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746207364; x=1746812164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZaZWHeJsBXxajgLn97PcSeAAY9vGR/Lj4o47xAhLqQ=;
        b=lOnVOPGqeZeGHTtGjeHe7yEDS2bm/o8vHRDJGlUmDtfxkkdJxqY8F1ZNRQN91daZCZ
         fnzyr/eGu9rPckWZ+y4+d3YgfNqzTM4yPrfoNcbx1uQ4U1jIDG4c5MSUplrUp6raZPZ0
         UDTGX6ZhDXsDkXzpnoI9xip4k1e11RV2BKnT8Djsst1Z/kxtoyL/ZNtS+RPCNxPWL8Zw
         XguoIRfnBih1jVQle9+SxNJlg8r/C6P0Ri32g1VqZbBG8bdkpdg4xEeArQ9jS1nLesNk
         CD5vVAevreCZ2P92GBVYqNH75QAYzsqhcvt8A/AyAryh4ujeBNKPVCYwi22+RuPagLTQ
         1j2w==
X-Forwarded-Encrypted: i=1; AJvYcCXuQBCSiQUuZkrI40gDI9kq6S26eAgbJx9qbI9YMBZWXSjRXUpn9CTkwUpM2Dqh0x/JPtD1JwJ/R9BTSJQg@vger.kernel.org
X-Gm-Message-State: AOJu0YzLtM+SKe21XUcIbtEPU4euTnQD2YlWnJufadaCW3xEWQQQdeXF
	jN2gRoUfYL58QMmz2IK173b+sVHkn6cHBh4pvEs1Adc9NwyiwGu2eaW66DndPk5Wan8Vlwn240W
	2brA+1jvg1Urkufe+q5Qt9KN7ChI=
X-Gm-Gg: ASbGncvsbK86R28PBEMBTU5Ib57+QB8cHGDcIb1DY4H4I99GIngV10eliIwHD/OslEL
	QDwGouqBk1ZPRoDfk5iMbWYZr6DUP/MRKO9gMLgk+NDVlF/3/mNjlvIXwktTjODJ1kC19OLsSKp
	g+ZSMqoTFvaEL+F8DGZ48=
X-Google-Smtp-Source: AGHT+IEMhoGxlK0icl5jB+rTAuQBuPzU27i8rR6t4dro2+Sb+PGBRH3fzFH3G3mPV9j6MAlZ2YLfON4vXMcJBzkru+c=
X-Received: by 2002:a17:907:3f9d:b0:ac4:169:3664 with SMTP id
 a640c23a62f3a-ad17adaedf5mr394397866b.33.1746207363427; Fri, 02 May 2025
 10:36:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHFULfaG4h-46GG2cJG9BDCKX0YoPEpQCpgefpaSBYk4hw@mail.gmail.com>
 <idlhgryyp4336ybkmtjdxotb5agos3h44vkp2p7cg6dvc2uefg@no4dm6c6vyzd>
In-Reply-To: <idlhgryyp4336ybkmtjdxotb5agos3h44vkp2p7cg6dvc2uefg@no4dm6c6vyzd>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 2 May 2025 19:35:50 +0200
X-Gm-Features: ATxdqUEsgeNnL2BQQmRz4_5fblSvVYHrFtq54BhnDmY8UO21oh6gclvpkd7MGME
Message-ID: <CAGudoHE6kBTWa9Pqs5Dnc4JF4Oijc--eg+aXCkmcgm0o13Gt4Q@mail.gmail.com>
Subject: Re: [RFF] realpathat system call
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 2:34=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 30-04-25 22:50:23, Mateusz Guzik wrote:
> > Before I explain why the system call and how, I'm noting a significant
> > limitation upfront: in my proposal the system call is allowed to fail
> > with EAGAIN. It's not inherent, but I think it's the sane thing to do.
> > Why I think that's sensible and why it does not defeat the point is
> > explained later.
> >
> > Why the system call: realpath(3) is issued a lot for example by gcc
> > (mostly for header files). libc implements it as a series of
> > readlinks(!) and it unsurprisingly looks atrocious:
> > [pid 1096382] readlink("/usr", 0x7fffbac84f90, 1023) =3D -1 EINVAL
> > (Invalid argument)
> > [pid 1096382] readlink("/usr/local", 0x7fffbac84f90, 1023) =3D -1 EINVA=
L
> > (Invalid argument)
> > [pid 1096382] readlink("/usr/local/include", 0x7fffbac84f90, 1023) =3D
> > -1 EINVAL (Invalid argument)
> > [pid 1096382] readlink("/usr/local/include/bits", 0x7fffbac84f90,
> > 1023) =3D -1 ENOENT (No such file or directory)
> > [pid 1096382] readlink("/usr", 0x7fffbac84f90, 1023) =3D -1 EINVAL
> > (Invalid argument)
> > [pid 1096382] readlink("/usr/include", 0x7fffbac84f90, 1023) =3D -1
> > EINVAL (Invalid argument)
> > [pid 1096382] readlink("/usr/include/x86_64-linux-gnu",
> > 0x7fffbac84f90, 1023) =3D -1 EINVAL (Invalid argument)
> > [pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits",
> > 0x7fffbac84f90, 1023) =3D -1 EINVAL (Invalid argument)
> > [pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits/types",
> > 0x7fffbac84f90, 1023) =3D -1 EINVAL (Invalid argument)
> > [pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits/types/FILE.h=
",
> > 0x7fffbac84f90, 1023) =3D -1 EINVAL (Invalid argument)
> >
> > and so on. This converts one path lookup to N (by path component). Not
> > only that's terrible single-threaded, you may also notice all these
> > lookups bounce lockref-containing cachelines for every path component
> > in face of gccs running at the same time (and highly parallel
> > compilations are not rare, are they).
> >
> > One way to approach this is to construct the new path on the fly. The
> > problem with that is that it would require some rototoiling and more
> > importantly is highly error prone (notably due to symlinks). This is
> > the bit I'm trying to avoid.
> >
> > A very pleasant way out is to instead walk the path forward, then
> > backward on the found dentry et voila -- all the complexity is handled
> > for you. There is however a catch: no forward progress guarantee.
>
> So AFAIU what you describe here is doing a path lookup and then calling
> d_path() on the result - actually prepend_path() as I'm glancing in your
> POC code.
>

Ye that's the gist.

> > rename seqlock is needed to guarantee correctness, otherwise if
> > someone renamed a dir as you were resolving the path forward, by the
> > time you walk it backwards you may get a path which would not be
> > accessible to you -- a result which is not possible with userspace
> > realpath.
>
> In presence of filesystem mutations paths are always unreliable, aren't
> they? I mean even with userspace realpath() implementation the moment the
> function call is returning the path the filesystem can be modified so tha=
t
> the path stops being valid. With kernel it is the same. So I don't see an=
y
> strong reason to bother with handling parallel filesystem modifications.
> But maybe I'm missing some practically important case...
>

The concern is not that the result is stale, but that it was not
legitimately obtainable at any point by the caller doing the current
realpath walk.

Consider the following tree:
/foo/file
/bar

where foo is 755, bar is 700 and both are owned by root, while the
user issuing realpath has some other uid

if root renames /foo/file to /bar/file while racing against realpath
/foo/file, there is a time window where the user will find the dentry
and by the time they d_path the result is /bar/file. but they never
would get /bar/file with the current implementation.

--=20
Mateusz Guzik <mjguzik gmail.com>

