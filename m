Return-Path: <linux-fsdevel+bounces-32625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07479ABA45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 01:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71539282626
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 23:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19761CEEA8;
	Tue, 22 Oct 2024 23:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpIho9le"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F91BD50D;
	Tue, 22 Oct 2024 23:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729641375; cv=none; b=B/n2dBwd77L8BNCG6oyrIxpI8AbVGi/kx3dPZ9j/tSU6+gbYu0B+zUYkaDKT6B/h3bFkaEr6A/JeSvC+PbhHlgHXj5uYKv3F6Esdg+IgKvPE+JkjddQkpT7sVYU6GAeWXS0BacIXsKf4y/QGRldMCWIxulEkryslvWdVUjd8XTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729641375; c=relaxed/simple;
	bh=e2hAaQM0XX6PjQAwxGQKXiU/PpBnZNCFNDfx+tjBkCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qswZhvgXwFx06Ph9HQlLOtyM+Ip+HOxWYzgY8sKjFnKrQWa/0A3ToB8+5YVBW57dq9nOh9L8t6TF3Ivu9yl60AEffBp0JGgj2jdgVce7ecafhJoGNZTd3JhFZhd+D8tp3ftGok4v/4o0jYYtSEyjwTufzc5bD5eR+SyF7yBL2z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpIho9le; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e5e5c43497so28148027b3.3;
        Tue, 22 Oct 2024 16:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729641373; x=1730246173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCQfmesisgkdQENbkAFngac7Vdn97CRauegzzavyEn8=;
        b=dpIho9leI2pjNcIR83t/jrAG4pVphsu4tnRrzOs/aPWak5ztg06X22JV6+JStVS74o
         zllTXbp+tizGVZWnWCd3/yxZaICN9oxHjRay3keRiGNv4vykiHkggbPP/QUBla9KbDwi
         Y436Sg8dtH4fukk3nujDV1Ijfwv8Tqy+pHG6T+P3oQQ1VxsoZJA31Bt4PLrBqqNr0Mk+
         eArRSH4zYYSYz8xiPHzvcNSyWU/LDUm5vVQ4UQHs8H4nduFBK05lSA1uFZ6wS6LkRjh1
         c1F2PQEZjeOUOJkxpXEWyYlTqLS6j/hQi5ff7Pw3gy4zP9OajLZYC7tOHZS9QaCyV41K
         Mmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729641373; x=1730246173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCQfmesisgkdQENbkAFngac7Vdn97CRauegzzavyEn8=;
        b=i9siBJmU0MvouNZm9yj2hNeTO+K3+tmZcBj+GBcEU6Hydm2K/xFBA6e92BvLrk2RqS
         Sq2itO5+442SBYXpvSjYLg+cXani+N+NmMuMmwuhyAGVb9KpyOCBu3k7gDhevXl/MYpB
         kuVNNFThlmcVfvWQtcr6/MzRYSpkgou0C1Lu1NcToICp8wHhN6J/fAQXeXB4LUi5pQ0r
         CxYjJGj+oD6g/b6UcnjNuvUPaDBpRFBDBBU9rksvu/5BTB1vZwQetF8abZq2kcUSpwla
         AAVNol2HnIfa9b6q/JdGVF9HCvIo6r4pJHZBDO9IJ+EvWWmMt6H5SA/20daW8C4p0FTS
         GEBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH+w7bbK0jcOFwVTUzmBvuXyGaf/vleAauw2wZJX09kFp5TMd3zrvkgqs7GxURWNaA0FSOeeWdOIRxmYfR@vger.kernel.org, AJvYcCW8qWRjqtWVa2WRnv1NioCQ01tI/N3exaHFt4Hd0AB4d12uprThZyRqFgB556U2fHCpFIck8H2S+qEXTc4y0ER359kxI4WC@vger.kernel.org
X-Gm-Message-State: AOJu0YyE9fl+7oyOa1kyII7siO6vYZE0OsnYHwo9+J9lvDIzzxUt1SNK
	UmTJKCGDG8qDmLbGuj5BfEafi956YizDSP7DAt5JvcjX30XdNs54VLcA1zecnu+AMSsoMasoOwV
	W+d6b6em/r5RNzvaqUbzVtFXXmjs=
X-Google-Smtp-Source: AGHT+IEN/G2bT/7jBH2AxNMZ5hUtZocZ3uvl5liobuvYVI5bWSIKgcmMHAlkt5rev48ra2x7D2iMq8QnP7XCqnvIoxk=
X-Received: by 2002:a05:690c:62c5:b0:6e5:aaf7:68d0 with SMTP id
 00721157ae682-6e7f0e3fffamr9118637b3.18.1729641372712; Tue, 22 Oct 2024
 16:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002142516.110567-1-luca.boccassi@gmail.com>
 <CAHC9VhRV3KcNGRw6_c-97G6w=HKNuEQoUGrfKhsQdWywzDDnBQ@mail.gmail.com>
 <CAMw=ZnSkm1U-gBEy9MBbjo2gP2+WHV2LyCsKmwYu2cUJqSUeXg@mail.gmail.com>
 <CAHC9VhRY81Wp-=jC6-G=6y4e=TSe-dznO=j87i-i+t6GVq4m3w@mail.gmail.com> <5fe2d1fea417a2b0a28193d5641ab8144a4df9a5.camel@gmail.com>
In-Reply-To: <5fe2d1fea417a2b0a28193d5641ab8144a4df9a5.camel@gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Wed, 23 Oct 2024 00:56:01 +0100
Message-ID: <CAMw=ZnSz8irtte09duVxGjmWRJq-cp=VYSzt6YHgYrvbSEzVDw@mail.gmail.com>
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
To: Paul Moore <paul@paul-moore.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Oct 2024 at 00:45, <luca.boccassi@gmail.com> wrote:
>
> On Sat, 5 Oct 2024 at 17:06, Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Fri, Oct 4, 2024 at 2:48=E2=80=AFPM Luca Boccassi <luca.boccassi@gma=
il.com> wrote:
> > > On Wed, 2 Oct 2024 at 15:48, Paul Moore <paul@paul-moore.com> wrote:
> > > > On Wed, Oct 2, 2024 at 10:25=E2=80=AFAM <luca.boccassi@gmail.com> w=
rote:
> >
> > ...
> >
> > > > [NOTE: please CC the LSM list on changes like this]
> > > >
> > > > Thanks Luca :)
> > > >
> > > > With the addition of the LSM syscalls we've created a lsm_ctx struc=
t
> > > > (see include/uapi/linux/lsm.h) that properly supports multiple LSMs=
.
> > > > The original char ptr "secctx" approach worked back when only a sin=
gle
> > > > LSM was supported at any given time, but now that multiple LSMs are
> > > > supported we need something richer, and it would be good to use thi=
s
> > > > new struct in any new userspace API.
> > > >
> > > > See the lsm_get_self_attr(2) syscall for an example (defined in
> > > > security/lsm_syscalls.c but effectively implemented via
> > > > security_getselfattr() in security/security.c).
> > >
> > > Thanks for the review, makes sense to me - I had a look at those
> > > examples but unfortunately it is getting a bit beyond my (very low)
> > > kernel skills, so I've dropped the string-based security_context from
> > > v2 but without adding something else, is there someone more familiar
> > > with the LSM world that could help implementing that side?
> >
> > We are running a little short on devs/time in LSM land right now so I
> > guess I'm the only real option (not that I have any time, but you know
> > how it goes).  If you can put together the ioctl side of things I can
> > likely put together the LSM side fairly quickly - sound good?
>
> Here's a skeleton ioctl, needs lsm-specific fields to be added to the new=
 struct, and filled in the new function:

Forgot to mention, this is based on the vfs.pidfs branch of
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git

