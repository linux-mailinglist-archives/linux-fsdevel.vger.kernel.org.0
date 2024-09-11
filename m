Return-Path: <linux-fsdevel+bounces-29064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E82D1974760
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 02:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13FA288717
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 00:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43FAF9F8;
	Wed, 11 Sep 2024 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rs1AqrJ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DA5B65C;
	Wed, 11 Sep 2024 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726014481; cv=none; b=QZ1iscR9PVGSHKdti+nj076z/UfllCFACjOtzOaWWGoL/4icV6SpBO7/0ZvhlDIuONkWacU14bxF4NrExPF9ni+8KL0RFu7HNx88wWxMsFpY87uYnEEIqhuC5SFZZXJjYC/L/Jr4kpLO215rjYfqg740sX81lizaSAstzn0lrGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726014481; c=relaxed/simple;
	bh=NrJDu9mEpFS1AmpGjH0DyXRmAqRkxkvNYWJ+v29pVBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcJme+M1CC42GeGOSS9zGDCF44GEJLDjpAy61rMpMMGMgak7189Q5fCb8ZIjPy64uxTswUXATHLZJaL0u6z3o1TpXe7AFql51Bl9kQfIlqf8WM664JtIEFm334C+HbJ3hzC8aOs0a4feh1XucDHmkr6SkjOtaFTnxKJtCfEVs+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rs1AqrJ2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so32245695e9.1;
        Tue, 10 Sep 2024 17:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726014478; x=1726619278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4G6htZmT/2OcXeGPBRBMMe5AADfAbOwvpNDLSDJ2pR0=;
        b=Rs1AqrJ237+S7ChFiwAH/esxmNk4lp+2QRBf+D8lRd51WI3aKMalh3yXCdwQFtNG5j
         oJUHDHUXdjSAwx0nNQXdmkE9JA4kOMaARUUa2KabvJPfbe5yWKnDLwFJ5QxnJAnjDqR8
         rsYEb18CLB5KwU6ulfwfOUNkXEdrIFw9BFQhLM7SEVG1B8APTbd4mzAj9GaJ7887zToS
         mLnZyYNtlSJwMOyISpq99wV8fcDlvpWiupUbogEbor8RYMSbOSeZFXf+4I0w8PNCdiC8
         HE2q+EN8QaVmUdluhFdxYNQ9pgzAJInB3hr73Hr2gAQ/RLQFmn1LqX/822aCSxI0dNDB
         1pRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726014478; x=1726619278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4G6htZmT/2OcXeGPBRBMMe5AADfAbOwvpNDLSDJ2pR0=;
        b=LtmK/0OO9C2HeePqu7Ul3CnAg/CE63hXShBps2NdrA99M0H/4vFKQLJVrEqIwnbhmy
         Z6V6dHyth+HLvmzvj39Cj7F25S6ahRXgk1jY8hSLC79L/1h4E0tLEkJ5kxsUbU5D8H1S
         GsfE1t4IiKS5XipkjEYeFbsmwKYaWAk07dz3///MhYBLLW9pdrqdQ5ZoA9mFC00Wf+VY
         M0OaloOce0UhxR/Aea8YJ14eHRN/grVV8qhseVVRu4oRAxHU+G+S+Pu2HhqqMDPEj4ds
         ypjZt12cMYgryhN0NK1oPpaQ1EX7ykaFh6ifoBfHNIlZLvbiK5Gxaytnd0MysZmBvuWo
         ejfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3keSs2QaTYfRn0vknJnmvpAlb3P6rxNS2y0gZ3XN777LKqGZHxHewgT2g3T7SZdvrVps=@vger.kernel.org, AJvYcCXbKCH/bA+EfC4fBrqI+fhI7dLkYdSnVcwkMUSch7xRQ81vhzxHORmMH2SeYgpG8H90qYmz3BQWQhIWIUARcg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/1voAbGwFGQfGx3g2YiEgOC+QQqR32GDFa2kYaadcSMr52SLQ
	hq0nF+FVJqrOGkXZlOwTCh+oOK+Jz8DJIpGHWZMGbWIG+yNjQP5ayv6jJ3waDKxlZ0pqfkOPz+A
	2jAfza0KYN27rmHXPBdVSgtDP47Q=
X-Google-Smtp-Source: AGHT+IHwJFWF6RxNiu9vVCXQmuzDa865/DIVQv/Pt4mgdRYAXkfoTXIAxRs5nhL80CtYqi67RErDr704Zfs90RK9RUA=
X-Received: by 2002:a05:600c:4451:b0:426:6308:e2f0 with SMTP id
 5b1f17b1804b1-42cae76cfa5mr91418565e9.26.1726014477550; Tue, 10 Sep 2024
 17:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829174232.3133883-1-andrii@kernel.org> <CAEf4BzYdP_6L1bT5bEwp5GAwM-rKOA36C-Cwv4i8h-3pKp-nkQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYdP_6L1bT5bEwp5GAwM-rKOA36C-Cwv4i8h-3pKp-nkQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Sep 2024 17:27:45 -0700
Message-ID: <CAADnVQLCh=D5vFTPQfYai3pW9EFGGjYwG9s+T-r-5a2-rj7kBw@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 00/10] Harden and extend ELF build ID parsing logic
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Alexey Dobriyan <adobriyan@gmail.com>, shakeel.butt@linux.dev, 
	Johannes Weiner <hannes@cmpxchg.org>, Andi Kleen <ak@linux.intel.com>, 
	Omar Sandoval <osandov@osandov.com>, Song Liu <song@kernel.org>, Jann Horn <jannh@google.com>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 3:39=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Aug 29, 2024 at 10:42=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> >
> > The goal of this patch set is to extend existing ELF build ID parsing l=
ogic,
> > currently mostly used by BPF subsystem, with support for working in sle=
epable
> > mode in which memory faults are allowed and can be relied upon to fetch
> > relevant parts of ELF file to find and fetch .note.gnu.build-id informa=
tion.
> >
> > This is useful and important for BPF subsystem itself, but also for
> > PROCMAP_QUERY ioctl(), built atop of /proc/<pid>/maps functionality (se=
e [0]),
> > which makes use of the same build_id_parse() functionality. PROCMAP_QUE=
RY is
> > always called from sleepable user process context, so it doesn't have t=
o
> > suffer from current restrictions of build_id_parse() which are due to t=
he NMI
> > context assumption.
> >
> > Along the way, we harden the logic to avoid TOCTOU, overflow, out-of-bo=
unds
> > access problems.  This is the very first patch, which can be backported=
 to
> > older releases, if necessary.
> >
> > We also lift existing limitations of only working as long as ELF progra=
m
> > headers and build ID note section is contained strictly within the very=
 first
> > page of ELF file.
> >
> > We achieve all of the above without duplication of logic between sleepa=
ble and
> > non-sleepable modes through freader abstraction that manages underlying=
 folio
> > from page cache (on demand) and gives a simple to use direct memory acc=
ess
> > interface. With that, single page restrictions and adding sleepable mod=
e
> > support is rather straightforward.
> >
> > We also extend existing set of BPF selftests with a few tests targeting=
 build
> > ID logic across sleepable and non-sleepabe contexts (we utilize sleepab=
le and
> > non-sleepable uprobes for that).
> >
> >    [0] https://lore.kernel.org/linux-mm/20240627170900.1672542-4-andrii=
@kernel.org/
> >
> > v6->v7:
> >   - added filemap_invalidate_{lock,unlock}_shared() around read_cache_f=
olio
> >     and kept Eduard's Reviewed-by (Eduard);
> > v5->v6:
> >   - use local phnum variable in get_build_id_32() (Jann);
> >   - switch memcmp() instead of strcmp() in parse_build_id() (Jann);
> > v4->v5:
> >   - pass proper file reference to read_cache_folio() (Shakeel);
> >   - fix another potential overflow due to two u32 additions (Andi);
> >   - add PageUptodate() check to patch #1 (Jann);
> > v3->v4:
> >   - fix few more potential overflow and out-of-bounds access issues (An=
di);
> >   - use purely folio-based implementation for freader (Matthew);
>
> Ok, so I'm not sure what one needs to do to get Matthew's attention
> nowadays, but hopefully yet another ping might do the trick.
>
> Matthew,
>
> Can you please take another look and provide your ack or nack? I did
> the conversion to folio as you requested. It would be nice if you can
> give me a courtesy of acking my patch set, if there is nothing wrong
> with it, so it can finally go in.

Looks like no further comments from Matthew or anyone else.

I'll take another look through the set before applying to bpf-next.

