Return-Path: <linux-fsdevel+bounces-55902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFA7B0FB6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 22:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE2B7B6BB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 20:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E34C235BE1;
	Wed, 23 Jul 2025 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqjs5itc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5083C1F4190
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302480; cv=none; b=DLdbdbGvfRKRUFl1HFaKxzIhermfCF1sv6mGBKuW5FocjWNTsVf+iWXK0eTe+YXzXyS+rTbu/KceD7aLGJT8hraNcmU4jY4nb3B14/c9cj8UgTwZuanzs1/2F25jkI2cfmzkMmQfpvXD2Xh+sV4P3TaSLbCL6Fdg8xxzaI3Oa2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302480; c=relaxed/simple;
	bh=6sHH4y6pbmtlPuK4o/3Q6KiyP8xoESQjIMosnrRGVT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nF2/gbmRtCLwSUM2SMMCdAL91duHg+xK5wrhUJmbvCj6ny8QkyZ64yOEOJntwPcbJf13yrV/K1oItRZginZZuWMlszafAk3JNGeBnfYFNgsHu6++wV5QFileVcy5QzvqGBjDTEqbZ7UJCm//I7GRz9tD6WSfs3KvkD53Wz03DO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fqjs5itc; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab814c4f2dso6976041cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 13:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302476; x=1753907276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zup4llA5suzNHXA5nWbYBpl9Do+jaAKdKpt+Fi/54xA=;
        b=Fqjs5itc5kWxGKTVEcsNewlRUUaUmxwoKp6znZo5DhqUOVh8gxmN7MUuy/H8vVPcfg
         Yl6qb0lxRUfGWU37ASgBIxPbxuMUHO9iC+MpZzLJKTTyz1mq5/2O0HHD2n/3zS++Z7h2
         gz5x+W8ykWhYXoeDuxXPZZJa3s/jsEFfiO1H5TfAzMdiYTDEv2/P5KfejACV2rZSpIuL
         fE/2en0nE3dycMlq7H5rAiVnNL5RutBp3cgcscnvDtOiclDgIRMTJ3d2ehU0V9i1L2+D
         uaRoMLbgT8DUjCWVuy7DTvtLZwN2S0Bk6zEm8YG/gZG6fJjl57Twdjd5s5iQ8RiHfvdG
         +nZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302476; x=1753907276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zup4llA5suzNHXA5nWbYBpl9Do+jaAKdKpt+Fi/54xA=;
        b=DLoP7WIqN2sOg1t09K3QAOStMxMfVBdXhv5THap5+2I4L+pEG5Gt62ASa97M0iwjZX
         C4wa5ofnf1BtrNjIhrflD5LzIX9wyEQTPwIVkLns7wivnKuRnD0ckXdy4MqgWn+N45PX
         B/MNKzp5LjN1uUosy3saAvKlRkAaeNcZefC1ciJoCWnWQSGDQtdjfLZRoFIZo9Lu+jvX
         JekW0TgBHVX64RIUNzVah/xg+pb2zUNKvXd+NJLYELEAXeZc56oyLLAxg4G5K1TUCPPM
         CbkJGKOhpZhWK+qiXKQEDsPCo5XvZVMS8KMXYFZ8Y5W4oEhfVLHI114VRfIqESpx1+Y8
         BI7g==
X-Forwarded-Encrypted: i=1; AJvYcCUjVFUoHuLAh1ZSMZJUlOE7VgrStMw7bCzLTMxXvf2RxW5116KH+tU0rSb19jKA/pTk/eETgLtsujOvktQa@vger.kernel.org
X-Gm-Message-State: AOJu0YwrR2T4KssHv7lgsi9tVzFl0AgfyBuleuFuyRlnsrnb6w7JEYdT
	pF/cICbta8w+Lf9CmkDN73JHa3OP/G9AA14pIvQlIprbDqybTqXWS5fLuxbNhY6JRbz9SuvF8+/
	fS40zQm1BS3j7omroSAgCh+Bu7hHy8m0=
X-Gm-Gg: ASbGncvrXmzCklvEShoLXqG/8sxiruADRlwLCVu8Ttsoex5N6oSnhvHXH7WpGR2Penn
	IbsYkDPuzesTcBpnXNdUqu9z0UGRRPLXy+3iBxDimkjdAraMNvnn5HMLlt2ENOo3IeQJ3XDcRSN
	weMhwvACVwZgscWu4nBXL3E48WZlZAM7DOl3wZTMMwvxnkO29zBqFp13zCliou17I460M2Uay3O
	cQz6nQ=
X-Google-Smtp-Source: AGHT+IGEg5yw9hKmi3sUbcwcxfUZnuxF+yZKvcI/UbDaLV7bBzYNfde2uLrhbj0tA37pYp9s8ECzVSfy//UYXbhH7+A=
X-Received: by 2002:a05:622a:5c10:b0:4ab:8f1b:c033 with SMTP id
 d75a77b69052e-4ae6df55cbbmr70077681cf.30.1753302476052; Wed, 23 Jul 2025
 13:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
 <CAJnrk1YeJPdtHMDatQvg8mDPYx4fgkeUCrBgBR=8zFMpOn3q0A@mail.gmail.com>
 <CAOQ4uxj1GB_ZneEeRqUT=fc2nNL8qF6AyLmU4QCfYqoxuZauPw@mail.gmail.com>
 <CAJnrk1bE2ZHPNf-Pu+DBnOyqQWU=GZjvB+V-wvguszSwZTF0cQ@mail.gmail.com> <20250723170657.GI2672029@frogsfrogsfrogs>
In-Reply-To: <20250723170657.GI2672029@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 23 Jul 2025 13:27:44 -0700
X-Gm-Features: Ac12FXykdmA669Bm40nviUADgA2hKr0Wj7_g_b42XV2MOkl8PplRiydETPJ3B7A
Message-ID: <CAJnrk1ac=m9udDX5Jq+scbD6ktqL5icGkoAPJO9d0AmMoMRyzg@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	John@groves.net, miklos@szeredi.hu, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 10:06=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Mon, Jul 21, 2025 at 01:05:02PM -0700, Joanne Koong wrote:
> > On Sat, Jul 19, 2025 at 12:18=E2=80=AFAM Amir Goldstein <amir73il@gmail=
.com> wrote:
> > >
> > > On Sat, Jul 19, 2025 at 12:23=E2=80=AFAM Joanne Koong <joannelkoong@g=
mail.com> wrote:
> > > >
> > > > On Thu, Jul 17, 2025 at 4:26=E2=80=AFPM Darrick J. Wong <djwong@ker=
nel.org> wrote:
> > > > >
> > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > >
> > > > > generic/488 fails with fuse2fs in the following fashion:
> > > > >
> > > > > Unfortunately, the 488.full file shows that there are a lot of hi=
dden
> > > > > files left over in the filesystem, with incorrect link counts.  T=
racing
> > > > > fuse_request_* shows that there are a large number of FUSE_RELEAS=
E
> > > > > commands that are queued up on behalf of the unlinked files at th=
e time
> > > > > that fuse_conn_destroy calls fuse_abort_conn.  Had the connection=
 not
> > > > > aborted, the fuse server would have responded to the RELEASE comm=
ands by
> > > > > removing the hidden files; instead they stick around.
> > > >
> > > > Tbh it's still weird to me that FUSE_RELEASE is asynchronous instea=
d
> > > > of synchronous. For example for fuse servers that cache their data =
and
> > > > only write the buffer out to some remote filesystem when the file g=
ets
> > > > closed, it seems useful for them to (like nfs) be able to return an
> > > > error to the client for close() if there's a failure committing tha=
t
> > > > data; that also has clearer API semantics imo, eg users are guarant=
eed
> > > > that when close() returns, all the processing/cleanup for that file
> > > > has been completed.  Async FUSE_RELEASE also seems kind of racy, eg=
 if
> > > > the server holds local locks that get released in FUSE_RELEASE, if =
a
> > > > subsequent FUSE_OPEN happens before FUSE_RELEASE then depends on
> > > > grabbing that lock, then we end up deadlocked if the server is
> > > > single-threaded.
> > > >
> > >
> > > There is a very good reason for keeping FUSE_FLUSH and FUSE_RELEASE
> > > (as well as those vfs ops) separate.
> >
> > Oh interesting, I didn't realize FUSE_FLUSH gets also sent on the
> > release path. I had assumed FUSE_FLUSH was for the sync()/fsync()
>
> (That's FUSE_FSYNC)
>
> > case. But I see now that you're right, close() makes a call to
> > filp_flush() in the vfs layer. (and I now see there's FUSE_FSYNC for
> > the fsync() case)
>
> Yeah, flush-on-close (FUSE_FLUSH) is generally a good idea for
> "unreliable" filesystems -- either because they're remote, or because
> the local storage they're on could get yanked at any time.  It's slow,
> but it papers over a lot of bugs and "bad" usage.
>
> > > A filesystem can decide if it needs synchronous close() (not release)=
.
> > > And with FOPEN_NOFLUSH, the filesystem can decide that per open file,
> > > (unless it conflicts with a config like writeback cache).
> > >
> > > I have a filesystem which can do very slow io and some clients
> > > can get stuck doing open;fstat;close if close is always synchronous.
> > > I actually found the libfuse feature of async flush (FUSE_RELEASE_FLU=
SH)
> > > quite useful for my filesystem, so I carry a kernel patch to support =
it.
> > >
> > > The issue of racing that you mentioned sounds odd.
> > > First of all, who runs a single threaded fuse server?
> > > Second, what does it matter if release is sync or async,
> > > FUSE_RELEASE will not be triggered by the same
> > > task calling FUSE_OPEN, so if there is a deadlock, it will happen
> > > with sync release as well.
> >
> > If the server is single-threaded, I think the FUSE_RELEASE would have
> > to happen on the same task as FUSE_OPEN, so if the release is
> > synchronous, this would avoid the deadlock because that guarantees the
> > FUSE_RELEASE happens before the next FUSE_OPEN.
>
> On a single-threaded server(!) I would hope that the release would be
> issued to the fuse server before the open.  (I'm not sure I understand

I don't think this is 100% guaranteed if fuse sends the release
request asynchronously rather than synchronously (eg the request gets
stalled on the bg queue if active_background >=3D max_background)

> where this part of the thread went, because why would that happen?  And
> why would the fuse server hold a lock across requests?)

The fuse server holding a lock across requests example was a contrived
one to illustrate that an async release could be racy if a fuse server
implementation has the (standard?) expectation that release and opens
are always received in order.

>
> > However now that you pointed out FUSE_FLUSH gets sent on the release
> > path, that addresses my worry about async FUSE_RELEASE returning
> > before the server has gotten a chance to write out their local buffer
> > cache.
>
> <nod>
>
> --D
>
> > Thanks,
> > Joanne
> > >
> > > Thanks,
> > > Amir.
> >

