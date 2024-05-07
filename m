Return-Path: <linux-fsdevel+bounces-18924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F78BE914
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 18:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81721C23DCC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 16:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178AF16C852;
	Tue,  7 May 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBMwDUYA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3F316C447;
	Tue,  7 May 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099283; cv=none; b=fLUIhsFmVC/gSKOO2nDxIBY043tJw93y/ZZrcuFaKkq06OBvfnV+ZAhLw7B9U30+PrJ3rmJ3YFO0h03Xpem4RMvzbnezRQDx0bwHz6Dv2eJqBvXnXf4mDRxkWxTL06ggqBFOkNn8An8qyA+5TNHZy/g9O3YTJVfhYotjQ0IniGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099283; c=relaxed/simple;
	bh=hD+M8iZyRZ2U9jnt01xrNmHVdD1Kc6oVV4hfl9YcSjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=r2IdKelf98fJTD4rxOepQwLJtlhRh2Ii59hAO1mAZqmC077Gb9L++NtqLYBHQ0m9SkKqFMU8NWbT45RSl3oodkPuIS3LZFY3K7EfaKGKVocZ/E+dJ3qdfK4o/orC2ACDK3lCp+yMIzUSELi8XDANA0TZl8uqMB0Poxe9rI/XVNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBMwDUYA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so726402966b.0;
        Tue, 07 May 2024 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715099280; x=1715704080; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rICwxurU6A+ycOmFzrxmjMEY+vAR/gQDdccoIGBtMqA=;
        b=bBMwDUYAyCNo3SnY7dqiYWGUDAvA5KOLaMSiryJybhsYi6F3uv8Dk1M503llh38mDi
         HIgw8yvrsBjKH1NCuwmy4VO6VuR1keoV7U0KfmGiM4fcjPwaNyvSi++I7Utb/B8Knpz1
         n5d1HVwXE4Moa3MzBmlh3nunz1R3I9EDHHlxEQtZejf4zCbGFOMQR0qhVydp9YbSw1qh
         ++QsvpHuvU2mNYohr+R71VP4K0qusnci6AHhqG4yMKnJX3DzsaJE3gEKuDgGA9ADDTTF
         NF6cZWDsEOYSz4ul7WzUnSeHxRVwuvHQYaEsFgQobQwmtmNDYhz2+cXxjC4lKvqnSHx+
         qESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099280; x=1715704080;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rICwxurU6A+ycOmFzrxmjMEY+vAR/gQDdccoIGBtMqA=;
        b=uvjLqg/D1zzLa7UnQK+qUpfKKyW1p6XrvMNCi/egzMMEqF8iVvJjaXFgGrrKyeSDbN
         jx947CcEYNwBb2zW3+k/oJlW/5j1kk2Wq+jMN4JCZFC4AWfefszUsXlwWe1iOJnMmxkS
         sq6VEqW2aLE9WEBaaoMdnqwpSyM6s1hAReYig72oV9coPTsddNeN2ILymeW7yxsNe1LB
         djGaJZl/WuqzhbcYDWYSX0GBQHidEg2J/1//OJW8beQuMXQlNNu7wyrH5ra/x8CvSlSE
         c41YVN6MHDCSj/3GOQ+0ztRl9uaC6Nt4zyCMszCwSbDpfR77WMI+Hl+jn8Qk7gRK0Lvy
         uZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/S9cMRb/1qZlxyNA7JLDHukaAvAecZPcIVUKxj5wAEHfyDeJfhecT7M8OmenhDopbxf072CFSHxnzcE+dRUmnroLe+GNoh7S6clgjR039gxAS76ij57C/qzAJoX9iowlpOfgTNPiO74wcHN5DFxK5mf6igbBBoiPnE+qnfj08GA==
X-Gm-Message-State: AOJu0YyfMgjkZ6H3IjrIxEAt1oa9K+fij8zYzj0lnjEHTpeBTaj8VJT9
	Ve+t2L7cZiYlO7KMG9508x0vegDlkrDpaoiZznt4s3oOFQcypwUcRUpvSx61Lx9uzQKixQsSLaL
	wOECtEdA66lfHU+BJpmyEsIkE7R0=
X-Google-Smtp-Source: AGHT+IFn3p6+IU8MNAx4QtWppQukiCZTYwwesAVqUICe2KaycZuCykzGNsekqL7kux4xcd7LRFMUFDcyPHBLQ7Tec6w=
X-Received: by 2002:a17:907:3f9a:b0:a59:c5c2:a31c with SMTP id
 hr26-20020a1709073f9a00b00a59c5c2a31cmr8176135ejc.33.1715099279965; Tue, 07
 May 2024 09:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504003006.3303334-6-andrii@kernel.org>
 <2024050425-setting-enhance-3bcd@gregkh> <CAEf4BzbiTQk6pLPQj=p9d18YW4fgn9k2V=zk6nUYAOK975J=xg@mail.gmail.com>
 <cgpi2vaxveiytrtywsd4qynxnm3qqur3xlmbzcqqgoap6oxcjv@wjxukapfjowc>
In-Reply-To: <cgpi2vaxveiytrtywsd4qynxnm3qqur3xlmbzcqqgoap6oxcjv@wjxukapfjowc>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 09:27:44 -0700
Message-ID: <CAEf4BzZQexjTvROUMkNb2MMB2scmjJHNRunA-NqeNzfo-yYh9g@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: a simple benchmark tool for
 /proc/<pid>/maps APIs
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 8:49=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> .. Adding Suren & Willy to the Cc
>
> * Andrii Nakryiko <andrii.nakryiko@gmail.com> [240504 18:14]:
> > On Sat, May 4, 2024 at 8:32=E2=80=AFAM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Fri, May 03, 2024 at 05:30:06PM -0700, Andrii Nakryiko wrote:
> > > > I also did an strace run of both cases. In text-based one the tool =
did
> > > > 68 read() syscalls, fetching up to 4KB of data in one go.
> > >
> > > Why not fetch more at once?
> > >
> >
> > I didn't expect to be interrogated so much on the performance of the
> > text parsing front, sorry. :) You can probably tune this, but where is
> > the reasonable limit? 64KB? 256KB? 1MB? See below for some more
> > production numbers.
>
> The reason the file reads are limited to 4KB is because this file is
> used for monitoring processes.  We have a significant number of
> organisations polling this file so frequently that the mmap lock
> contention becomes an issue. (reading a file is free, right?)  People
> also tend to try to figure out why a process is slow by reading this
> file - which amplifies the lock contention.
>
> What happens today is that the lock is yielded after 4KB to allow time
> for mmap writes to happen.  This also means your data may be
> inconsistent from one 4KB block to the next (the write may be around
> this boundary).
>
> This new interface also takes the lock in do_procmap_query() and does
> the 4kb blocks as well.  Extending this size means more time spent
> blocking mmap writes, but a more consistent view of the world (less
> "tearing" of the addresses).

Hold on. There is no 4KB in the new ioctl-based API I'm adding. It
does a single VMA look up (presumably O(logN) operation) using a
single vma_iter_init(addr) + vma_next() call on vma_iterator.

As for the mmap_read_lock_killable() (is that what we are talking
about?), I'm happy to use anything else available, please give me a
pointer. But I suspect given how fast and small this new API is,
mmap_read_lock_killable() in it is not comparable to holding it for
producing /proc/<pid>/maps contents.

>
> We are working to reduce these issues by switching the /proc/<pid>/maps
> file to use rcu lookup.  I would recommend we do not proceed with this
> interface using the old method and instead, implement it using rcu from
> the start - if it fits your use case (or we can make it fit your use
> case).
>
> At least, for most page faults, we can work around the lock contention
> (since v6.6), but not all and not on all archs.
>
> ...
>
> >
> > > > In comparison,
> > > > ioctl-based implementation had to do only 6 ioctl() calls to fetch =
all
> > > > relevant VMAs.
> > > >
> > > > It is projected that savings from processing big production applica=
tions
> > > > would only widen the gap in favor of binary-based querying ioctl AP=
I, as
> > > > bigger applications will tend to have even more non-executable VMA
> > > > mappings relative to executable ones.
> > >
> > > Define "bigger applications" please.  Is this some "large database
> > > company workload" type of thing, or something else?
> >
> > I don't have a definition. But I had in mind, as one example, an
> > ads-serving service we use internally (it's a pretty large application
> > by pretty much any metric you can come up with). I just randomly
> > picked one of the production hosts, found one instance of that
> > service, and looked at its /proc/<pid>/maps file. Hopefully it will
> > satisfy your need for specifics.
> >
> > # cat /proc/1126243/maps | wc -c
> > 1570178
> > # cat /proc/1126243/maps | wc -l
> > 28875
> > # cat /proc/1126243/maps | grep ' ..x. ' | wc -l
> > 7347
>
> We have distributions increasing the map_count to an insane number to
> allow games to work [1].  It is, unfortunately, only a matter of time unt=
il
> this is regularly an issue as it is being normalised and allowed by an
> increased number of distributions (fedora, arch, ubuntu).  So, despite
> my email address, I am not talking about large database companies here.
>
> Also, note that applications that use guard VMAs double the number for
> the guards.  Fun stuff.
>
> We are really doing a lot in the VMA area to reduce the mmap locking
> contention and it seems you have a use case for a new interface that can
> leverage these changes.
>
> We have at least two talks around this area at LSF if you are attending.

I am attending LSFMM, yes, I'll try to not miss them.

>
> Thanks,
> Liam
>
> [1] https://lore.kernel.org/linux-mm/8f6e2d69-b4df-45f3-aed4-5190966e2dea=
@valvesoftware.com/
>

