Return-Path: <linux-fsdevel+bounces-21553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FF0905A2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 19:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0F41B240FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 17:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7471822DE;
	Wed, 12 Jun 2024 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlK+VWVL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419C4FBF3;
	Wed, 12 Jun 2024 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718214538; cv=none; b=POet4kmikJI2W3IRPlOiCVHaaRTTL8tWI279hhaL9nr5hcLbsWU8FMBi3TsoyJn9qqbOL/5HS4EVYckOcnCV17YDsiaKIHH/BjKaI0+Vf8fUwTN4fpGHL5Q0zpCySZ6op4SrigaZBbz7HZP+AUMPj2HspLgnPr6bZp2+da/SaeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718214538; c=relaxed/simple;
	bh=6bhxDbJUU+W20aR7IgKPzHvfQW5ALys80/3bU+QOtN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5LwxPf81yuqsN5SL88RBt6hXD/MW0SWd8AOr5OP1AQYdFuuBo0JLPqJeFx31JCG10+gOqFhGFbfjs+PtsFQp/QUsyt/bMoWWlQY1xfLAINI04AcLCfxPwovrN74nFvBDeyG+QZjA6FE87RN+twBUxxGTPMHsqN73So6a9Op5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlK+VWVL; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebf961e504so463291fa.2;
        Wed, 12 Jun 2024 10:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718214534; x=1718819334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWRq3PAWFykXw/wg8pUX9HlfeUGFcprx4t2KU6HQHu8=;
        b=XlK+VWVLEAdF6mNKfj8FvjvQUEO3PpTmYYGHpo3kssMprivZ3VZ9b5BKcia3FkFFUT
         +3Z4yyoZM3ej+bwXfWpPWl2tXma6G/fHv9hUs2UNUoUsAExLb9NV0aVfQgaJzrWcR9ZS
         zaHQk03HvuI3NQmV7r+7CHsxQjsNtneEHE+I8yYWfQ8+dWz6E85pEmOUmyLFHESURMMu
         z2IVZY2Mv1NRBdgS6zF959CA0Uq3MVwDr4CteAiGvFcD8Q2NmSztJdyDSky0TbhqjGMI
         sgIHx/xYgo+PUnKN6rTYg8/AcKVhaRGL5Zbx6gCs0jMg9tGCappxGefmf6fzQIb7IqBP
         SKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718214534; x=1718819334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWRq3PAWFykXw/wg8pUX9HlfeUGFcprx4t2KU6HQHu8=;
        b=KY+h0R5j6dt/y/jt/RJW8CWTbq0EEQwt/Qiov3fUzjFGlNdADodM0Iyy8TVLMeBEQH
         iALyDVmOsxNPQudrLdhMumihAHhGoFeKlUX/oVWVWcgQuuqBfJVlQ99HjDz0IvM++T5t
         QLVUfZviavwVX5idxIeFMDQwRwdpwoV8tjCDU/rbvjI4QymIKVI6Kh66NawTmytgaHec
         beUUT0RJJtVdQiU3sjImaJLAH2UkjDIt9rysELRVelztxNHDFTqRDUhNoTsiGTLBWe//
         03mJEFwrWIAZtPUwXG9lzMQNe1Xkz3BiIjwsyZi0ctGxEtS/wpSHTzef6M/hxrrVJvaH
         MbQg==
X-Forwarded-Encrypted: i=1; AJvYcCUpjZW3zRi/m61ktaQvrd0EWh3D59SV7KGekx9c5sYmoNxA3j93eSyK0VqZ7a++rlMAXbDhB1dFjL+6IWQVvH/HIhPtAvI6N5OujTnR8UJMncuUM2nZofaqfqZQcBcdYAvRocBoqjnAkfdpX/VhiqJAQ6F4erI/r4/v1bOaX9oRCw==
X-Gm-Message-State: AOJu0YyTjt1P44MaiFg9569xqUuFPRKNd1Jjzqhq6vcVFxyl/6ful13a
	mxyfP+XiM/IQC1ufHMgCf9ikrEifTIhPcEFDHxKyXqmkD1+Ljb+v9WOJIckoGcEtQw3oQJGnZWa
	AT/wl8cqsDarvHy51am1ldEhh+jA=
X-Google-Smtp-Source: AGHT+IHA55C4BDttu7u2HKaLoMXFIz1/aGOTxtg5E/j5naZlPku4zxMaSGvkX/d3yoCc442ECzpUGWN8vYj/jbiTdss=
X-Received: by 2002:a05:651c:20c:b0:2eb:ec25:c4af with SMTP id
 38308e7fff4ca-2ebfc9499ebmr15663611fa.50.1718214534010; Wed, 12 Jun 2024
 10:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605002459.4091285-1-andrii@kernel.org> <20240605002459.4091285-4-andrii@kernel.org>
 <ZmOKMgZn_ki17UYM@gmail.com> <CAEf4BzYAQwX0AQ_fbcB9kVBj3vpx0-5pPPZNYKL4VjnX_eYKpg@mail.gmail.com>
In-Reply-To: <CAEf4BzYAQwX0AQ_fbcB9kVBj3vpx0-5pPPZNYKL4VjnX_eYKpg@mail.gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 12 Jun 2024 10:48:42 -0700
Message-ID: <CANaxB-zLkvXWS3Fg5Ps463iF7Cb1UVr+FwKb65VFRATqbgnW+A@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] fs/procfs: implement efficient VMA querying API
 for /proc/<pid>/maps
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-mm@kvack.org, liam.howlett@oracle.com, surenb@google.com, 
	rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 1:17=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jun 7, 2024 at 11:31=E2=80=AFPM Andrei Vagin <avagin@gmail.com> w=
rote:
> >
> > On Tue, Jun 04, 2024 at 05:24:48PM -0700, Andrii Nakryiko wrote:
> > > /proc/<pid>/maps file is extremely useful in practice for various tas=
ks
> > > involving figuring out process memory layout, what files are backing =
any
> > > given memory range, etc. One important class of applications that
> > > absolutely rely on this are profilers/stack symbolizers (perf tool be=
ing one
> > > of them). Patterns of use differ, but they generally would fall into =
two
> > > categories.
> > >
> > > In on-demand pattern, a profiler/symbolizer would normally capture st=
ack
> > > trace containing absolute memory addresses of some functions, and wou=
ld
> > > then use /proc/<pid>/maps file to find corresponding backing ELF file=
s
> > > (normally, only executable VMAs are of interest), file offsets within
> > > them, and then continue from there to get yet more information (ELF
> > > symbols, DWARF information) to get human-readable symbolic informatio=
n.
> > > This pattern is used by Meta's fleet-wide profiler, as one example.
> > >
> > > In preprocessing pattern, application doesn't know the set of address=
es
> > > of interest, so it has to fetch all relevant VMAs (again, probably on=
ly
> > > executable ones), store or cache them, then proceed with profiling an=
d
> > > stack trace capture. Once done, it would do symbolization based on
> > > stored VMA information. This can happen at much later point in time.
> > > This patterns is used by perf tool, as an example.
> > >
> > > In either case, there are both performance and correctness requiremen=
t
> > > involved. This address to VMA information translation has to be done =
as
> > > efficiently as possible, but also not miss any VMA (especially in the
> > > case of loading/unloading shared libraries). In practice, correctness
> > > can't be guaranteed (due to process dying before VMA data can be
> > > captured, or shared library being unloaded, etc), but any effort to
> > > maximize the chance of finding the VMA is appreciated.
> > >
> > > Unfortunately, for all the /proc/<pid>/maps file universality and
> > > usefulness, it doesn't fit the above use cases 100%.
> > >
> > > First, it's main purpose is to emit all VMAs sequentially, but in
> > > practice captured addresses would fall only into a smaller subset of =
all
> > > process' VMAs, mainly containing executable text. Yet, library would
> > > need to parse most or all of the contents to find needed VMAs, as the=
re
> > > is no way to skip VMAs that are of no use. Efficient library can do t=
he
> > > linear pass and it is still relatively efficient, but it's definitely=
 an
> > > overhead that can be avoided, if there was a way to do more targeted
> > > querying of the relevant VMA information.
> > >
> > > Second, it's a text based interface, which makes its programmatic use=
 from
> > > applications and libraries more cumbersome and inefficient due to the
> > > need to handle text parsing to get necessary pieces of information. T=
he
> > > overhead is actually payed both by kernel, formatting originally bina=
ry
> > > VMA data into text, and then by user space application, parsing it ba=
ck
> > > into binary data for further use.
> >
> > I was trying to solve all these issues in a more generic way:
> > https://lwn.net/Articles/683371/
> >
>
> Can you please provide a tl;dr summary of that effort?

task_diag is a generic interface designed to efficiently gather
information about running processes. It addresses the limitations of
traditional /proc/PID/* files. This binary interface utilizes the
netlink protocol, inspired by the socket diag interface. Input is
provided as a netlink message detailing the desired information, and the
kernel responds with a set of netlink messages containing the results.
Compared to struct-based interfaces like this one or statx, the
netlink-based approach can be more flexible, particularly when
dealing with numerous optional parameters.  BTW, David Ahern made
some adjustments in task_diag to optimize the same things that are
targeted here.

task_diag hasn't been merged to the kernel. I don't remember all the
arguments, it was some time ago. The primary concern was the
introduction of redundant functionality. It would have been the second
interface offering similar capabilities, without a plan to deprecate the
older interface. Furthermore, there wasn't sufficient demand to justify
the addition of a new interface at the time.

Thanks,
Andrei

