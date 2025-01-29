Return-Path: <linux-fsdevel+bounces-40286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C2AA21AEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 11:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 259B73A532F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 10:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF85E1B0435;
	Wed, 29 Jan 2025 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20230601.gappssmtp.com header.i=@owltronix-com.20230601.gappssmtp.com header.b="vcwYiBEa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5644316C854
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738146195; cv=none; b=CQvjDjFzdLkzahLhkLpMjd88p4lw787NWqc10ZhxXE+uD8b5RfAqLlMG9u9vL9XDgf3ulAt3v9vs1uugJS3pFXNDA4jLq3h/EV6F64Vvw7C7I2LzPKddFxQmloiHGAdRxCSolW+uVa7L9kMBzlnzGu8nW8n9dPBt79Y55UEsaHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738146195; c=relaxed/simple;
	bh=xgwRc/1ONSozeehQ8z3TORPSjFcNWEWiOPwPnGU/SB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2ZaNk1pwbtr58PhCXMMVxkiQko3Sgvv28ZPNPlzERpn/pMHy/Tv2Jk7GQeaKKDSyyCSukXyQtwfLsgoHTRuWeNaTNJRmbNte3qkjUM01GfABJ0D6mJfE0GEATdb72LIdmyndUnfWuj6K3z8SYHgJMK3Q+kjTDcrBW52fGD45D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com; spf=none smtp.mailfrom=owltronix.com; dkim=pass (2048-bit key) header.d=owltronix-com.20230601.gappssmtp.com header.i=@owltronix-com.20230601.gappssmtp.com header.b=vcwYiBEa; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=owltronix.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaef00ab172so1042739266b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 02:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20230601.gappssmtp.com; s=20230601; t=1738146191; x=1738750991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgwRc/1ONSozeehQ8z3TORPSjFcNWEWiOPwPnGU/SB0=;
        b=vcwYiBEamZNhpZTtknPzd6skzIwKDnVtQYHN+VtxtHaFRvLZ2JcOdsZFj9je1GsrRP
         DDyJFJZRofv38i+1FWh5dpnItiN3qS6yWly1/QK4cMm3kgC5jhla9obmhZWdKBNZ7rnT
         A/Ysg/kxZ5pORyX2eACd4TtXMQpeeKpkGwACZqQERiEwHhKy0miVC16z8JuZC45Q9YHf
         zCzw6anr8jbScwKJs88iF8Gpc7h2YvHrZdMO0sxyDbgAitCOvl63WK4tDmWcRWKvvQYj
         2m1nIEe0d5aZhSEGo4qHbIyhGQFKULTrUVaYUHsiBVlox5eLHg0UG0GNfltyl90+SJav
         Gm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738146191; x=1738750991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgwRc/1ONSozeehQ8z3TORPSjFcNWEWiOPwPnGU/SB0=;
        b=L0iUwx547DmV8vP4IN/YpJe+K4/Hz5u8oJVqg0EreLn62s2NyNRkNopiCaWvqIiHlK
         Da5Xw9xSjLsa+dr7OOMT1oijc9RwTwn+X4kTlVnoh/OKT6bPv9K7xnBBMvTaXUEGMk+P
         sNGlLDgpEJnjD+sOMu8FyYanoxjoNkhiU1k2mpJWATHUqU0UTHCAlmhbgpSZeDPsxzNP
         cDm9BpHeumalSFtPFWqOQQoFO9cxdiwVtzUS/wqgaG3bGKXZrWaxd99q4yXwu0dzhEAa
         z6JLnWM04jMym5z8Wq9dsA7UYNCOIskhCkRv1Rue6gcgxOkoBK5zcZ3vhCLM6ntBciOe
         r6gQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9e4TZubZzie117MT5h6Wgc9fG4355hVjAHFNR0g3j88z0ChKwa+F4DzrBVYnGESHvWOKpR7rAtHoViYjc@vger.kernel.org
X-Gm-Message-State: AOJu0YxtJZVoOuOuQIoW7W9EkWpaqbyBZJmmAp6kbUFrST/DrLpPn4VI
	5MZOntWZLdT1LsJTLgYbOZjp1VNs4NUcQm2TifoVZ2T8Yz9ib3zRhjHMneTQKoCv8NcktcjgQVG
	8yhYk88lj9MyxC9OGlmBvftAKLFuqbI9BTbeHDQ==
X-Gm-Gg: ASbGnctQvdNgY7KcP1xyzZSJYGVblR9N1gXzTTJdszFNqlFh7bf0Usa77vla+UD544h
	+0pUn2CVK4Khceg+glcYkd4IVbyhuGl6O/0pCTIGV/srqc2yrk28cqqUrEVFGTJR05y8JHvo=
X-Google-Smtp-Source: AGHT+IE9d6LfbcU0wDNpEcTGDR9ln7RBsLHKBWG3fVvfG4lMTfyh+rEGVDJcsyB23DOFtvLGf0bQ9pubsFprQiPoUFc=
X-Received: by 2002:a05:6402:4311:b0:5db:f5e9:6760 with SMTP id
 4fb4d7f45d1cf-5dc5efa8bcdmr5710865a12.2.1738146191373; Wed, 29 Jan 2025
 02:23:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123202455.11338-1-slava@dubeyko.com> <fd012640-5107-4d44-9572-4dffb2fd4665@wdc.com>
 <f44878932fd26bb273c7948710b23b0e2768852a.camel@ibm.com> <CANr-nt2+Yk5fVVjU2zs+F1ZrLZGBBy3HwNOuYOK9smDeoZV9Rg@mail.gmail.com>
 <063856b9c67289b1dd979a12c8cfe8d203786acc.camel@ibm.com> <CANr-nt2bbienm=L48uEgjmuLqMnFBXUfHVZfEo3VBFwUsutE6A@mail.gmail.com>
 <a09665a84d11c3d184346b1f55515ac912b061c3.camel@ibm.com>
In-Reply-To: <a09665a84d11c3d184346b1f55515ac912b061c3.camel@ibm.com>
From: Hans Holmberg <hans@owltronix.com>
Date: Wed, 29 Jan 2025 11:23:00 +0100
X-Gm-Features: AWEUYZnrsXzP2Xt_ZlJzA9oa1fTRpVosixwgwed2gSRg-PlOoBVS6lq-K17iGac
Message-ID: <CANr-nt0nRZp=g2kbUqd5PoNbH-m9MWd_4x+LmR6x-gTT92MoVQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce generalized data temperature estimation framework
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"javier.gonz@samsung.com" <javier.gonz@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 11:31=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Tue, 2025-01-28 at 09:45 +0100, Hans Holmberg wrote:
> > On Mon, Jan 27, 2025 at 9:59=E2=80=AFPM Viacheslav Dubeyko
> > <Slava.Dubeyko@ibm.com> wrote:
> > >
> > > On Mon, 2025-01-27 at 15:19 +0100, Hans Holmberg wrote:
> > > > On Fri, Jan 24, 2025 at 10:03=E2=80=AFPM Viacheslav Dubeyko
> > > > <Slava.Dubeyko@ibm.com> wrote:
> > > > >
> > > > >
> > >
> > > > So what I am asking myself is if this framework is added, who would
> > > > benefit? Without any benchmark results it's a bit hard to tell :)
> > > >
> > >
> > > Which benefits would you like to see? I assume we would like: (1) pro=
long device
> > > lifetime, (2) improve performance, (3) decrease GC burden. Do you mea=
n these
> > > benefits?
> >
> > Yep, decreased write amplification essentially.
> >
>
> The important point here that the suggested framework offers only means t=
o
> estimate temperature. But only file system technique can decrease or incr=
ease
> write amplification. So, we need to compare apples with apples. As far as=
 I
> know, F2FS has algorithm of estimation and employing temperature. Do you =
imply
> F2FS or how do you see the way of estimation the write amplification decr=
easing?
> Because, every file system should have own way to employ temperature.

If you could show that this framework can decrease write amplification
in ssdfs, f2fs or
any other file system, I think that would be a good start.

Compare using your generated temperatures vs not using the temperature info=
.

>
> > >
> > > As far as I can see, different file systems can use temperature in di=
fferent
> > > way. And this is slightly complicates the benchmarking. So, how can w=
e define
> > > the effectiveness here and how can we measure it? Do you have a visio=
n here? I
> > > am happy to make more benchmarking.
> > >
> > > My point is that the calculated file's temperature gives the quantita=
tive way to
> > > distribute even user data among several temperature groups ("baskets"=
). And
> > > these baskets/segments/anything-else gives the way to properly group =
data. File
> > > systems can employ the temperature in various ways, but it can defini=
tely helps
> > > to elaborate proper data placement policy. As a result, GC burden can=
 be
> > > decreased, performance can be improved, and lifetime device can be pr=
olong. So,
> > > how can we benchmark these points? And which approaches make sense to=
 compare?
> > >
> >
> > To start off, it would be nice to demonstrate that write amplification
> > decreases for some workload when the temperature is taken into
> > account. It would be great if the workload would be an actual
> > application workload or a synthetic one mimicking some real-world-like
> > use case.
> > Run the same workload twice, measure write amplification and compare re=
sults.
> >
>
> Another trouble here. What is the way to measure write amplification, fro=
m your
> point of view? Which benchmarking tool or framework do you suggest for wr=
ite
> amplification estimation?

FDP drives expose this information. You can retrieve the stats using
the nvme cli.
If you are using zoned storage, you can add write amp metrics inside
the file system
or just measure the amount of blocks written to the device using iostat.

> > > > Also, is there a good reason for only supporting buffered io? Direc=
t
> > > > IO could benefit in the same way, right?
> > > >
> > >
> > > I think that Direct IO could benefit too. The question here how to ac=
count dirty
> > > memory pages and updated memory pages. Currently, I am using
> > > folio_account_dirtied() and folio_clear_dirty_for_io() to implement t=
he
> > > calculation the temperature. As far as I can see, Direct IO requires =
another
> > > methods of doing this. The rest logic can be the same.
> >
> > It's probably a good idea to cover direct IO as well then as this is
> > intended to be a generalized framework.
>
> To cover Direct IO is a good point. But even page cache based approach ma=
kes
> sense because LFS and GC based file systems needs to manage data in effic=
ient
> way. By the way, do you have a vision which methods can be used for the c=
ase of
> Direct IO to account dirty and updated memory pages?
>

Temperature feedback could instead be provided by file systems that
would actually
care about using the information.

