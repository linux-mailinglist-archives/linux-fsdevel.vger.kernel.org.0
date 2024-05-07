Return-Path: <linux-fsdevel+bounces-18959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7988BEF41
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 23:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39994286DAC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 21:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784E816D324;
	Tue,  7 May 2024 21:56:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C179CF;
	Tue,  7 May 2024 21:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715118967; cv=none; b=Sn/EJ+YK1AwL+SKrEI6Fvigk9+3q+NUqDhrc4EhDw/mnIj21W3bEbzTU6F27vkqVkm8lGT5vC9lGHRWrliN0nxBtRmEW1b6uH0+xlnbYR/m6SYJaDKs/kaHOnhF/aZ4Ti5BpLQFyvkTOBDKN+x0EC34XNKKWag1q2OcrtC3X11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715118967; c=relaxed/simple;
	bh=c6YHGEYmPjpO9D/p2b9v83LdrifgicmhUFUwgBtopaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqB9NJMJed0H5VWmyvBmYQeBPETNrrHfGS6+YvXFhofXbaiMSCaLH3jYaZTs1+6u/FOJkqHMJn6ra3UVJpDOE190kpYaDSDxRxcasKd833pOZa8h6oORUWfLDnOKfqikXwBPaUhPr1AZyI36D6h+Xm+4CMnSopF/vMb1jjv5Lus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-61aef9901deso2510504a12.1;
        Tue, 07 May 2024 14:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715118965; x=1715723765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXTaPie4n8q7aWd8lKqdehPO2SNuKWmtizpezocD5H4=;
        b=g9QpDvlOJwdxgjipCk2RplWsuZ+Vn4tRzRNZavLWVZiQ4mUsjpGo14ZsauiboTAuAK
         aaAPPjWSF+hxSNG2/K/ls/xgrk/e55xXm5tG2Lo84DR0DaLRIZlnPyfsBH+7Yz/frfTC
         Y4VfYwBf5Dsg5wNlF/LjveB+5FVO4q9b/6/W6WjknS4bHXIewBDTchpFiabzoYOgasJP
         t765XvcjWLvWy/JKnHmi3OcSOiqEqLeNCVrP9PmdYg2xI2oh7ywtkyvqJ0ImQqV0TeXY
         BhaNM8H9mrefaByESrkCo8TV8L5veV2Ih0vhvcWP9thVtjvV0sbSSiGSHaDRTgGMMuCb
         JHCA==
X-Forwarded-Encrypted: i=1; AJvYcCXH8RFDpuyLH27tlWpjwdQbHU3tDCAPG5DH/MbMV0vIOXTPaUQ+VKgNB6tMyENoYJOt7fg1FYD2rp9OgJiXQJDAj+VB8oyqeirLfUZ0zAbnHO03s83h9GqZkQhhPE8BSn0fvqU3q2ZQbJR7KYWEiUkorQbRqpTTXtliKm9Le+EPqiFAhLxVtb0lvGhHFMKdDTFazLTfqj2UKtdFLBbLRIZZC7o=
X-Gm-Message-State: AOJu0YxVMaZ4zQXlFdcoZ+Lvh5OhNQ7cOhrpQp4uNs4sgJIFMW+/F11R
	XOAOkn/x/vVo1HT2vEPMi1uGyq1bAmtkOtyk7Z7NaP1wmyHf/Of6ga0kzBUm89jCcQE4yVi3H59
	bR8i1PhBpcvMPiSLAvNd+UAS71HI=
X-Google-Smtp-Source: AGHT+IFXpLdBXP0wh3twnNJnWEDW8JXUqluwb5PZEvCJy86sy4dMIzPSzZ/Bo27vj60SVq+hRMSHToV6/VUrIXVJVlQ=
X-Received: by 2002:a17:90a:cf14:b0:2b3:ed2:1a91 with SMTP id
 98e67ed59e1d1-2b616ae2ca0mr732222a91.45.1715118965098; Tue, 07 May 2024
 14:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504003006.3303334-3-andrii@kernel.org>
 <2024050439-janitor-scoff-be04@gregkh> <CAEf4BzZ6CaMrqRR1Rah7=HnTpU5-zw5HUnSH9NWCzAZZ55ZXFQ@mail.gmail.com>
 <ZjjiFnNRbwsMJ3Gj@x1> <CAM9d7cgvCB8CBFGhMB_-4tCm6+jzoPBNg4CR7AEyMNo8pF9QKg@mail.gmail.com>
 <ZjknNJSFcKaxGDS4@x1> <Zjksc3yqvkocS18M@x1>
In-Reply-To: <Zjksc3yqvkocS18M@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 7 May 2024 14:55:53 -0700
Message-ID: <CAM9d7cj=zadZzQakNC7PeKWd5hfL83jvCRu-BuZ4EOzF2WPb-w@mail.gmail.com>
Subject: Re: [PATCH 2/5] fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 12:16=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, May 06, 2024 at 03:53:40PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, May 06, 2024 at 11:05:17AM -0700, Namhyung Kim wrote:
> > > On Mon, May 6, 2024 at 6:58=E2=80=AFAM Arnaldo Carvalho de Melo <acme=
@kernel.org> wrote:
> > > > On Sat, May 04, 2024 at 02:50:31PM -0700, Andrii Nakryiko wrote:
> > > > > On Sat, May 4, 2024 at 8:28=E2=80=AFAM Greg KH <gregkh@linuxfound=
ation.org> wrote:
> > > > > > On Fri, May 03, 2024 at 05:30:03PM -0700, Andrii Nakryiko wrote=
:
> > > > > > > Note also, that fetching VMA name (e.g., backing file path, o=
r special
> > > > > > > hard-coded or user-provided names) is optional just like buil=
d ID. If
> > > > > > > user sets vma_name_size to zero, kernel code won't attempt to=
 retrieve
> > > > > > > it, saving resources.
> >
> > > > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > > > > > Where is the userspace code that uses this new api you have cre=
ated?
> >
> > > > > So I added a faithful comparison of existing /proc/<pid>/maps vs =
new
> > > > > ioctl() API to solve a common problem (as described above) in pat=
ch
> > > > > #5. The plan is to put it in mentioned blazesym library at the ve=
ry
> > > > > least.
> > > > >
> > > > > I'm sure perf would benefit from this as well (cc'ed Arnaldo and
> > > > > linux-perf-user), as they need to do stack symbolization as well.
> >
> > > I think the general use case in perf is different.  This ioctl API is=
 great
> > > for live tracing of a single (or a small number of) process(es).  And
> > > yes, perf tools have those tracing use cases too.  But I think the
> > > major use case of perf tools is system-wide profiling.
> >
> > > For system-wide profiling, you need to process samples of many
> > > different processes at a high frequency.  Now perf record doesn't
> > > process them and just save it for offline processing (well, it does
> > > at the end to find out build-ID but it can be omitted).
> >
> > Since:
> >
> >   Author: Jiri Olsa <jolsa@kernel.org>
> >   Date:   Mon Dec 14 11:54:49 2020 +0100
> >   1ca6e80254141d26 ("perf tools: Store build id when available in PERF_=
RECORD_MMAP2 metadata events")
> >
> > We don't need to to process the events to find the build ids. I haven't
> > checked if we still do it to find out which DSOs had hits, but we
> > shouldn't need to do it for build-ids (unless they were not in memory
> > when the kernel tried to stash them in the PERF_RECORD_MMAP2, which I
> > haven't checked but IIRC is a possibility if that ELF part isn't in
> > memory at the time we want to copy it).
>
> > If we're still traversing it like that I guess we can have a knob and
> > make it the default to not do that and instead create the perf.data
> > build ID header table with all the build-ids we got from
> > PERF_RECORD_MMAP2, a (slightly) bigger perf.data file but no event
> > processing at the end of a 'perf record' session.
>
> But then we don't process the PERF_RECORD_MMAP2 in 'perf record', it
> just goes on directly to the perf.data file :-\

Yep, we don't process build-IDs at the end if --buildid-mmap
option is given.  It won't have build-ID header table but it's
not needed anymore and perf report can know build-ID from
MMAP2 directly.

Thanks,
Namhyung

