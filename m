Return-Path: <linux-fsdevel+bounces-18749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9494F8BBF47
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 07:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD641C20A16
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 05:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0AC2914;
	Sun,  5 May 2024 05:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mrn1xhBN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5C15A8
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 05:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714885792; cv=none; b=RvqVxdwkqy05hirZYRncrUBvxHF11CUsKSgi3msmxC2HKrBXr84L9u6QV5cIN5m5PsdNP5wJ3fVJzSPsHsaD7NFspaOU0f5VMflKOE4iqRPq3yfy9AuHfjTTavjdQZpYkvzp055m+2oGsGJzg24avK7MVQ4M7zhUGRYwPfZDu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714885792; c=relaxed/simple;
	bh=olH7hQHHDHDp2bsomJmiSdHdXsNU4KXMYOJHnmgtMxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qu0H5qffKLdhw+Q3rJpx/utattk4eFcUKiKxzNyvSAIKTSd/xAFnPRlOY3PqoJi25KvIQRfGoBPfdKpfWI9S1VJR3/yGw+/Q1gMMIeeOAVlPbmDujWWqmHOykay06ICY3m39pp+/vSO7ubVtQ6FG8iqcO6Z7wr9Xxa3OZQSemSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mrn1xhBN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ec76185cb3so128225ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 May 2024 22:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714885791; x=1715490591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LFEOHbhdT8xlmXAZ79el6d0XvgZNSArYbb5H09rUb4=;
        b=Mrn1xhBNBqxCE5yPD5OVx+e8FNRV17ekqQA2aKdNnVNULq8zWnwENBgC+uQl92OwtH
         N8CSJy84/hyjZZjR6nTlf5NZYZVbhQvn0/s2xcrqoxO6hcBF9TVX8NkzWKg8cm25W1+0
         0boxYbJxSq21MoP1RTNS/2jad52AnDomuT+zNIfSYmC0RsvYFALNXf3ssOYQmEWycu/e
         65ZT8SB/V25cyTrikHt5DWMwAVwYH6IyNvxza9ZVNbcMQw9AFRxRAhIG+o9VGHsv1vms
         R1I7anqnYCubCZwrkOusYF3KwLWw5hEqWk5W3DxnebOzRvc3dshcmd4SvE+TLp67Rn1T
         rG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714885791; x=1715490591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LFEOHbhdT8xlmXAZ79el6d0XvgZNSArYbb5H09rUb4=;
        b=s4rLDSUjXKFnLqNmeeFhReQC4e7D0Ni4WyseKt0EjSJGmOae9kWhBruE0w1/Az89IT
         kVryYAmNqSKd2sSofnl/dIYiuvkeLVXV6S0C9l6jRYnAKpotnOSCXlJVLZBuhFGE0ZWT
         /1j2Q3cOuOchjhXczaIZRXrgEJZ3zhnYYHYYk9sx+uVzAdJ5E93++0QoAvp2uXLbv4JJ
         VNCK958lSBkr5/b5kU70SzLYa2OjyADaFovLYr+T0+P6Voo5yNrPQ1TCkhFI/8NwMiYZ
         XO6B1NLvTkYa75KcaCHsK8Auq51LnBOeoxDRDYEaXdc5ToawMUbV3IY6ySpxz4jy0+P8
         xScw==
X-Forwarded-Encrypted: i=1; AJvYcCV9PM/BQWpPPoYLd1rxyrXVkJdFQus4GnEiCIocG016GWek+Gg+Iinx1gh84BLMLalYG7okQk++2KDu/XN8/zGU3N4TXjZdy/KnZscKmw==
X-Gm-Message-State: AOJu0YzbfGZCG/DZQ7aI2VSRSwOwOHOi/JN3/moemwQ85v0hMDrcMuZC
	oSt7sukB9dzxr7XPKBoCHVrEd7jwAua2Ol6Ih577gKdUoL6ESyiSt8m8dztgBGgcuX31IzY+QeY
	RtA1WEhhOnQVwiUDGS8IYSOTE0IruqPCmdZ6N
X-Google-Smtp-Source: AGHT+IHGBa7tMMleiZKIyfq04qQxdw3xbaO8yY7nGHAFS1LwAn2FIimhO36Sml74NHR419/S58AeVS848bcSO81YVbs=
X-Received: by 2002:a17:902:f789:b0:1e0:c571:d652 with SMTP id
 d9443c01a7336-1ed851171f3mr1404605ad.1.1714885790351; Sat, 04 May 2024
 22:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504003006.3303334-6-andrii@kernel.org>
 <2024050404-rectify-romp-4fdb@gregkh> <CAEf4BzaUgGJVqw_yWOXASHManHQWGQV905Bd-wiaHj-mRob9gw@mail.gmail.com>
In-Reply-To: <CAEf4BzaUgGJVqw_yWOXASHManHQWGQV905Bd-wiaHj-mRob9gw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 4 May 2024 22:09:39 -0700
Message-ID: <CAP-5=fWPig8-CLLBJ_rb3D6eNAKVY7KX_n_HcpGqL7gfe-=XXg@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: a simple benchmark tool for
 /proc/<pid>/maps APIs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 2:57=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, May 4, 2024 at 8:29=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
> >
> > On Fri, May 03, 2024 at 05:30:06PM -0700, Andrii Nakryiko wrote:
> > > Implement a simple tool/benchmark for comparing address "resolution"
> > > logic based on textual /proc/<pid>/maps interface and new binary
> > > ioctl-based PROCFS_PROCMAP_QUERY command.
> >
> > Of course an artificial benchmark of "read a whole file" vs. "a tiny
> > ioctl" is going to be different, but step back and show how this is
> > going to be used in the real world overall.  Pounding on this file is
> > not a normal operation, right?
> >
>
> It's not artificial at all. It's *exactly* what, say, blazesym library
> is doing (see [0], it's Rust and part of the overall library API, I
> think C code in this patch is way easier to follow for someone not
> familiar with implementation of blazesym, but both implementations are
> doing exactly the same sequence of steps). You can do it even less
> efficiently by parsing the whole file, building an in-memory lookup
> table, then looking up addresses one by one. But that's even slower
> and more memory-hungry. So I didn't even bother implementing that, it
> would put /proc/<pid>/maps at even more disadvantage.
>
> Other applications that deal with stack traces (including perf) would
> be doing one of those two approaches, depending on circumstances and
> level of sophistication of code (and sensitivity to performance).

The code in perf doing this is here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/util/synthetic-events.c#n440
The code is using the api/io.h code:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/lib/api/io.h
Using perf to profile perf it was observed time was spent allocating
buffers and locale related activities when using stdio, so io is a
lighter weight alternative, albeit with more verbose code than fscanf.
You could add this as an alternate /proc/<pid>/maps reader, we have a
similar benchmark in `perf bench internals synthesize`.

Thanks,
Ian

>   [0] https://github.com/libbpf/blazesym/blob/ee9b48a80c0b4499118a1e8e5d9=
01cddb2b33ab1/src/normalize/user.rs#L193
>
> > thanks,
> >
> > greg k-h
>

