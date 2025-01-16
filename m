Return-Path: <linux-fsdevel+bounces-39399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FACA139B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 13:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780D6188A151
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 12:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC0B1DE4D7;
	Thu, 16 Jan 2025 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2JcY/en"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA1A24A7C2;
	Thu, 16 Jan 2025 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737029098; cv=none; b=VzT2Jw9Lgl70PO6ZZLS61hrbXcEm0SrIKgrsKILWFC7Zrm9PbUj6j6kv6P8sFZNeaixKAAL+eo5tk+U2+LQ9lNuH9Q+JDOMCATYH4wO1z9c3vLDeJ0XHhdIdvzB+DPW4p5rNTL/7a68m60OPxTijM4QUKyq2NPrMxnz6HaHNmdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737029098; c=relaxed/simple;
	bh=WRKcBrc9oLkV83bccyC5QHkyLyIAR4h86BkVAoZgLsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQENQMbMXkm5sshsmL0QZNmiEgDOfxhZWAyRgCmS/afZPTSf3u95nSDVF82PqHz+b7DZggI75GLCeYVbFV/NELYhei0w5xwFG4/SyhHIUcVARnexMcqRgwii3bqSeMVuBybmpmUc+ji0Bah8KKF/+lLMJt8RkccSa5dRqDPBG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2JcY/en; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5db6921ad3dso752736a12.2;
        Thu, 16 Jan 2025 04:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737029095; x=1737633895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHNpYGsjuL1p9B3DqvTgdGJ0uRwqhFcJCkZULgYXRBY=;
        b=j2JcY/enhRahOVWMqV8FGXAw85n40MjIV8paEsKO5oGTR0rKkvecq4qyUKlgXBKb2n
         fPL3f2LDalOz59anz8cLZDbHy73V8qEtmL2shyI9O7pXYahV5c4UWfQg/tvBZFgd827N
         VsMAaQs8rUEYNC+WjfJijbCmYFM8ixrDH8LLtWKFRjZdNzbhxJjSf6+rxkg4im6UNqka
         nktZNJIuVBzbOsj3IimXkmd0zkg7kiDVzXyz7dZaJxLRF2PHnqtnmFLTRrJa3Y4cVnhc
         v+435++IDz9MlU9djZ/wXars0dYNQ9KqCmq56JFh28sbuXKLMCwgiIz1dUGAWkFabHXl
         mABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737029095; x=1737633895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHNpYGsjuL1p9B3DqvTgdGJ0uRwqhFcJCkZULgYXRBY=;
        b=VyXE/i69THniPlH7bURO1ev+aBZ4RaFu118i8gQqQSNsHTT81D5rY+SPxA2GuR0mDi
         NynTUnZKwi7vtrzTBQk9mNd6bf7h+Ah2rvRAlEJqbpAG+ke1ffmirKMfsy6eg+Hfro3I
         g+66C2SEQl8+ood61mdHjcu+Sd86Jpd81ZdA2DzVht+ksgqGkAckiqufy4LoVs6LbMwR
         T18u/wOj4Va64yNyJvMBl9ERjXiEWag+MpHm1e6ToAt/YiShiQoJSwxinJqgj5IMuiNX
         42pRygDzuCPR8oUXkpMwsAdta/HYh2oIVHrixYJadlJ4YGzGISSTA1slOHkxe/qPMIUa
         7FIw==
X-Forwarded-Encrypted: i=1; AJvYcCWG2taiPRoCTMLtd1KzfK5/EkV9wTO8nWR8mZFtUwnltCKpLU5djtJB8CQQdjIz1+tqfgAV4du0bc2DgGJX@vger.kernel.org, AJvYcCXZ00lW9istC1RcN58DnBc1jrq03tWst7D4xu+zxpnIXnsqt7nGF17rpllDzY7vCPZjNSEH3S13zwyaHiIw@vger.kernel.org
X-Gm-Message-State: AOJu0YwqknTWM4w2dn7qlFH79RNZS22eZBNxh3abvMGhmixx2tTR630p
	6Qt8gmMHpiCtkjv9QZxrI3XbfUkbBjJbdFDx90tGAV9G7B5X0M5a4bWPqRDRg1zOa5WVI1f/XSy
	YxZgXlgunn1P8l2qeYyRrwnyBae4=
X-Gm-Gg: ASbGncsVmeAaF8YraBjqi7iBNshca2uv/1q9mZX+UMbi4LKgroVxgYg+j2y0rc3vJWm
	JsQyetytadYfPa9ZKUcKEdKcOIhgb6iLjS3ssLA==
X-Google-Smtp-Source: AGHT+IEOwAtfd0TYcSWLJWzicQQaKXtoOtZQwsBpXJnF5jGIAgKblkSQ1oBMmYhOa7TB6ERO6IykQWxhRYjk9n+1oMg=
X-Received: by 2002:a05:6402:274c:b0:5d3:e766:6143 with SMTP id
 4fb4d7f45d1cf-5d972e7247cmr32515470a12.30.1737029094593; Thu, 16 Jan 2025
 04:04:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <049f0da40ed76d94c419f83dd42deb413d6afb44.1737000287.git.tavianator@tavianator.com>
 <t2cucclkkxj65fk7nknzogbeobyq7tgx4klep77ptnnlfrv34e@vjkzxymgnr4r> <63wvjel64hsft4clgeayaorx3v7txvqh264mw7ionlbmmve7pj@eblpknd677zf>
In-Reply-To: <63wvjel64hsft4clgeayaorx3v7txvqh264mw7ionlbmmve7pj@eblpknd677zf>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 16 Jan 2025 13:04:42 +0100
X-Gm-Features: AbW1kvYInUQnO_di3u-ws_OVaWs8W-sjqZtDsf4DS9wuucoRN9qyXOifTVN4gFw
Message-ID: <CAGudoHFg4BgeygyKV8tY_2Dk4cv9zwQnU6-n7jSxjwyyXzau6g@mail.gmail.com>
Subject: Re: [PATCH] coredump: allow interrupting dumps of large anonymous regions
To: Jan Kara <jack@suse.cz>
Cc: Tavian Barnes <tavianator@tavianator.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 10:56=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 16-01-25 08:46:48, Mateusz Guzik wrote:
> > On Wed, Jan 15, 2025 at 11:05:38PM -0500, Tavian Barnes wrote:
> > > dump_user_range() supports sparse core dumps by skipping anonymous pa=
ges
> > > which have not been modified.  If get_dump_page() returns NULL, the p=
age
> > > is skipped rather than written to the core dump with dump_emit_page()=
.
> > >
> > > Sadly, dump_emit_page() contains the only check for dump_interrupted(=
),
> > > so when dumping a very large sparse region, the core dump becomes
> > > effectively uninterruptible.  This can be observed with the following
> > > test program:
> > >
> > >     #include <stdlib.h>
> > >     #include <stdio.h>
> > >     #include <sys/mman.h>
> > >
> > >     int main(void) {
> > >         char *mem =3D mmap(NULL, 1ULL << 40, PROT_READ | PROT_WRITE,
> > >                 MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE, -1, 0);
> > >         printf("%p %m\n", mem);
> > >         if (mem !=3D MAP_FAILED) {
> > >                 mem[0] =3D 1;
> > >         }
> > >         abort();
> > >     }
> > >
> > > The program allocates 1 TiB of anonymous memory, touches one page of =
it,
> > > and aborts.  During the core dump, SIGKILL has no effect.  It takes
> > > about 30 seconds to finish the dump, burning 100% CPU.
> > >
> >
> > While the patch makes sense to me, this should not be taking anywhere
> > near this much time and plausibly after unscrewing it will stop being a
> > factor.
> >
> > So I had a look with a profiler:
> > -   99.89%     0.00%  a.out
> >      entry_SYSCALL_64_after_hwframe
> >      do_syscall_64
> >      syscall_exit_to_user_mode
> >      arch_do_signal_or_restart
> >    - get_signal
> >       - 99.89% do_coredump
> >          - 99.88% elf_core_dump
> >             - dump_user_range
> >                - 98.12% get_dump_page
> >                   - 64.19% __get_user_pages
> >                      - 40.92% gup_vma_lookup
> >                         - find_vma
> >                            - mt_find
> >                                 4.21% __rcu_read_lock
> >                                 1.33% __rcu_read_unlock
> >                      - 3.14% check_vma_flags
> >                           0.68% vma_is_secretmem
> >                        0.61% __cond_resched
> >                        0.60% vma_pgtable_walk_end
> >                        0.59% vma_pgtable_walk_begin
> >                        0.58% no_page_table
> >                   - 15.13% down_read_killable
> >                        0.69% __cond_resched
> >                     13.84% up_read
> >                  0.58% __cond_resched
> >
> >
> > Almost 29% of time is spent relocking the mmap semaphore in
> > __get_user_pages. This most likely can operate locklessly in the fast
> > path. Even if somehow not, chances are the lock can be held across
> > multiple calls.
> >
> > mt_find spends most of it's time issuing a rep stos of 48 bytes (would
> > be faster to rep mov 6 times instead). This is the compiler being nasty=
,
> > I'll maybe look into it.
> >
> > However, I strongly suspect the current iteration method is just slow
> > due to repeat mt_find calls and The Right Approach(tm) would make this
> > entire thing finish within miliseconds by iterating the maple tree
> > instead, but then the mm folk would have to be consulted on how to
> > approach this and it may be time consuming to implement.
> >
> > Sorting out relocking should be an easily achievable & measurable win
> > (no interest on my end).
>
> As much as I agree the code is dumb, doing what you suggest with mmap_sem
> isn't going to be easy. You cannot call dump_emit_page() with mmap_sem he=
ld
> as that will cause lock inversion between mmap_sem and whatever filesyste=
m
> locks we have to take. So the fix would have to involve processing larger
> batches of address space at once (which should also somewhat amortize the
> __get_user_pages() setup costs). Not that hard to do but I wanted to spel=
l
> it out in case someone wants to pick up this todo item :)
>

Is the lock really needed to begin with?

Suppose it is.

In this context there are next to no pages found, but there is a
gazillion relocks as the entire VA is being walked.

Bare minimum patch which would already significantly help would start
with the lock held and only relock if there is a page to dump, should
be very easy to add.

I however vote for someone mm-savvy to point out an easy way (if any)
to just iterate pages which are there instead.
--=20
Mateusz Guzik <mjguzik gmail.com>

