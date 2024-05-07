Return-Path: <linux-fsdevel+bounces-18943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE8B8BEC1B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 21:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AD51F23E20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 19:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567F516D9C9;
	Tue,  7 May 2024 19:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+eHcQj4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9A16D9A7;
	Tue,  7 May 2024 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108457; cv=none; b=dR+BN/Z87aqPl4CURGeKet1K2zUUPrq7ug+PzBk8RYQDtULZM0TRkSHT0S48UR68O0h89zLBadKcyhfMLWOW1hKZFmTjUWprhthWiXwwd5Va2+OhweexNhTF97ZjJNnl765esanPExiZNN6O65P8AB1TwsmHDFN7fVaxIG4Urhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108457; c=relaxed/simple;
	bh=rjW0aJYCQXlLoIVRfa20c0SWs8WgYyCfnharYbOdUC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ltrj+TEy/cci047hGHWP0yNDzhVMAtZSxTP6MBYbbq7boEOxq9s+XgKTkfXHrEeSJwwCUHvtFGkEZIkLHu6UxQD3ODH13xHDU1n2T2KZ33j8t8JSejeS6kZF4yr38peWv/HT4a14RSUHVAQ2iV5iKqdbGFHcOngOIdyYjFiIaG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+eHcQj4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2b537cd50f9so2056195a91.3;
        Tue, 07 May 2024 12:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715108456; x=1715713256; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OvlLYZXntZzsYVWsX3vkaZCqsGmHPgXcCmkgTW2W9E=;
        b=V+eHcQj44/xMBJE+vR56QVmQK0b+Yu2UwJNH+wk2H1ZQwe06GecTh3mF5ZYPgHoVHT
         53G7BdYcPF17L7CWBYb/jI1LA+jB9EQ2oCr/GTjQ3x7xLOjWUOypIrv6t3ju3Ujf3bNV
         2PdhJRTaMBdCVvVWd6XwtoNYPm+RKgHa8UbudCcegHr0OpKfz6+9SBTn2+Cdh2KRcvmx
         /8j88Jm72/Cso1PGhtwqR68tg6OBF/2Cky4zDVSOxCy7vCiIjFr7qpOkh8EFF5TqqR1O
         vZmkBMWB5tKX2kog2gsBguigZbVYRk2dm8HeSw/1N5+OZXSC0zacaylF29c+eqhwzDkX
         zTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715108456; x=1715713256;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OvlLYZXntZzsYVWsX3vkaZCqsGmHPgXcCmkgTW2W9E=;
        b=qi6Nq4LvjdN1zwERDve3tHU4Ia068fxXEMTiCtC43iJdblscUhckJuiUbaNelnPOrn
         8mpg694f9qIfBYWXqGJlj8jp7oKOWVTm2W1McwZsD47p3LjL6X2acm5yle+uU73rDpHJ
         7cykdAWRhq9BQR9ly/ZTscRPQMjv/sppj2r8hhiC4QO5dfbdyMPaTLo2UmAk1tl3U2XA
         Rh3DWLf9RnRmqXiu10MLlYYap2QXZhSOVwW/YNWGGZAMyVJeV+n+d7WNjbcs14tDwkZG
         bEruv1G6o6xow8E+GGm/7/0oCsOgBXkBTVt85dE86+STZrtzjvWAFmwpzqKdVwZXt6LX
         QR0g==
X-Forwarded-Encrypted: i=1; AJvYcCUmenXmVuPN5+4gybI59IMRZ4utVQdNDKRa8e45tSG2NF+ZTWIyS/eEW0R0yFhCGzw/P2uFe0ZukERR4lhEG6oVYTefH65d6c3cDOwWyHzjrnBWKGllp5OaTT0N3NxSgDu0tOFalJMmewOXlNRkGvirtM9/jU/zL48bJMp/QvgMZw==
X-Gm-Message-State: AOJu0YxqSBJND/C8DSVl0D48S9EEqX3g55u0zXqFyPmdjJmDxXVoGzpV
	0TCThkwF1rua7Xg+G0TyXSjpv4zN99ckLS3n6YP4hQtdoFHG3a/TcSDNMD8Ni029oE7tDW4H+UO
	i9uRTtF3ozvQ5zTRi2epk20Vbjr8=
X-Google-Smtp-Source: AGHT+IHVOh+tTSIletV6uuObJeEpe5Vf6lzC+JSmOXbOZaf7RJB/Yn/F9mCqn8ZACFRRLCBq0s8A4fvmflw4nxbjKzI=
X-Received: by 2002:a17:90b:b17:b0:2b4:36d7:b6ad with SMTP id
 98e67ed59e1d1-2b61639c45dmr482630a91.4.1715108455583; Tue, 07 May 2024
 12:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504003006.3303334-1-andrii@kernel.org> <20240504003006.3303334-6-andrii@kernel.org>
 <2024050425-setting-enhance-3bcd@gregkh> <CAEf4BzbiTQk6pLPQj=p9d18YW4fgn9k2V=zk6nUYAOK975J=xg@mail.gmail.com>
 <cgpi2vaxveiytrtywsd4qynxnm3qqur3xlmbzcqqgoap6oxcjv@wjxukapfjowc>
 <CAEf4BzZQexjTvROUMkNb2MMB2scmjJHNRunA-NqeNzfo-yYh9g@mail.gmail.com> <qa3ffj62mrdrskqg33atupnphc6il6ygdzbtknpky4xfhilqg2@mqojpw2vwbul>
In-Reply-To: <qa3ffj62mrdrskqg33atupnphc6il6ygdzbtknpky4xfhilqg2@mqojpw2vwbul>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 12:00:43 -0700
Message-ID: <CAEf4Bzap9QkdQqxwE4_yjYJ4V-QVnwyCXaOChDswFwmaGJUvig@mail.gmail.com>
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

On Tue, May 7, 2024 at 11:06=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Andrii Nakryiko <andrii.nakryiko@gmail.com> [240507 12:28]:
> > On Tue, May 7, 2024 at 8:49=E2=80=AFAM Liam R. Howlett <Liam.Howlett@or=
acle.com> wrote:
> > >
> > > .. Adding Suren & Willy to the Cc
> > >
> > > * Andrii Nakryiko <andrii.nakryiko@gmail.com> [240504 18:14]:
> > > > On Sat, May 4, 2024 at 8:32=E2=80=AFAM Greg KH <gregkh@linuxfoundat=
ion.org> wrote:
> > > > >
> > > > > On Fri, May 03, 2024 at 05:30:06PM -0700, Andrii Nakryiko wrote:
> > > > > > I also did an strace run of both cases. In text-based one the t=
ool did
> > > > > > 68 read() syscalls, fetching up to 4KB of data in one go.
> > > > >
> > > > > Why not fetch more at once?
> > > > >
> > > >
> > > > I didn't expect to be interrogated so much on the performance of th=
e
> > > > text parsing front, sorry. :) You can probably tune this, but where=
 is
> > > > the reasonable limit? 64KB? 256KB? 1MB? See below for some more
> > > > production numbers.
> > >
> > > The reason the file reads are limited to 4KB is because this file is
> > > used for monitoring processes.  We have a significant number of
> > > organisations polling this file so frequently that the mmap lock
> > > contention becomes an issue. (reading a file is free, right?)  People
> > > also tend to try to figure out why a process is slow by reading this
> > > file - which amplifies the lock contention.
> > >
> > > What happens today is that the lock is yielded after 4KB to allow tim=
e
> > > for mmap writes to happen.  This also means your data may be
> > > inconsistent from one 4KB block to the next (the write may be around
> > > this boundary).
> > >
> > > This new interface also takes the lock in do_procmap_query() and does
> > > the 4kb blocks as well.  Extending this size means more time spent
> > > blocking mmap writes, but a more consistent view of the world (less
> > > "tearing" of the addresses).
> >
> > Hold on. There is no 4KB in the new ioctl-based API I'm adding. It
> > does a single VMA look up (presumably O(logN) operation) using a
> > single vma_iter_init(addr) + vma_next() call on vma_iterator.
>
> Sorry, I read this:
>
> +       if (usize > PAGE_SIZE)
> +               return -E2BIG;
>
> And thought you were going to return many vmas in that buffer.  I see
> now that you are doing one copy at a time.
>
> >
> > As for the mmap_read_lock_killable() (is that what we are talking
> > about?), I'm happy to use anything else available, please give me a
> > pointer. But I suspect given how fast and small this new API is,
> > mmap_read_lock_killable() in it is not comparable to holding it for
> > producing /proc/<pid>/maps contents.
>
> Yes, mmap_read_lock_killable() is the mmap lock (formally known as the
> mmap sem).
>
> You can see examples of avoiding the mmap lock by use of rcu in
> mm/memory.c lock_vma_under_rcu() which is used in the fault path.
> userfaultfd has an example as well. But again, remember that not all
> archs have this functionality, so you'd need to fall back to full mmap
> locking.

Thanks for the pointer (didn't see email when replying on the other thread)=
.

I looked at lock_vma_under_rcu() quickly, and seems like it's designed
to find VMA that covers given address, but not the next closest one.
So it's a bit problematic for the API I'm adding, as
PROCFS_PROCMAP_EXACT_OR_NEXT_VMA (which I can rename to
COVERING_OR_NEXT_VMA, if necessary), is quite important for the use
cases we have. But maybe some variation of lock_vma_under_rcu() can be
added that would fit this case?

>
> Certainly a single lookup and copy will be faster than a 4k buffer
> filling copy, but you will be walking the tree O(n) times, where n is
> the vma count.  This isn't as efficient as multiple lookups in a row as
> we will re-walk from the top of the tree. You will also need to contend
> with the fact that the chance of the vmas changing between calls is much
> higher here too - if that's an issue. Neither of these issues go away
> with use of the rcu locking instead of the mmap lock, but we can be
> quite certain that we won't cause locking contention.

You are right about O(n) times, but note that for symbolization cases
I'm describing, this n will be, generally, *much* smaller than a total
number of VMAs within the process. It's a huge speed up in practice.
This is because we pre-sort addresses in user-space, and then we query
VMA for the first address, but then we quickly skip all the other
addresses that are already covered by this VMA, and so the next
request will query a new VMA that covers another subset of addresses.
This way we'll get the minimal number of VMAs that cover captured
addresses (which in the case of stack traces would be a few VMAs
belonging to executable sections of process' binary plus a bunch of
shared libraries).

>
> Thanks,
> Liam
>

