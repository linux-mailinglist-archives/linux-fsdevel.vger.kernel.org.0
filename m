Return-Path: <linux-fsdevel+bounces-36569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8099E5F51
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 21:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C50B28317F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 20:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57D019B3E2;
	Thu,  5 Dec 2024 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxIypQJI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C68A193;
	Thu,  5 Dec 2024 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733429731; cv=none; b=c2e2byGCiZXf+JWfxpTSHRoAnJtEwV9J5qlK5in4ZKkILj1lvAzY5jjWT0XDS3ZLwwzV+E280fTXQn6WDDCRTaLA0wkAcEK9YV+TqenqtzuCrtOOAKSbKAD6d6VhGQWpuVB2a2C/95qojouDqWZ43Aju/sHw4Ymr0o1QKiLUy2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733429731; c=relaxed/simple;
	bh=ETmomcGJZ6M7hfG150AP73WVEB6pwR+tUEid5iG9mTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sT+oovlNDPGSmxn60i7HeTCpIRmq4NdJFhTiXpx0tNYVQ/2c72r4T4v6o56mKnCNPyC9frOtHbdDjMaW+DA6Eu3SO/k+15b/jYXwpIFdjUc0QKUU36n1AJ70IBnR3verpAF/Az5fVkevf6BLvXa9L66Gga5yKawPC/M32bCYh4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxIypQJI; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so204656566b.1;
        Thu, 05 Dec 2024 12:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733429727; x=1734034527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6op1dKhn8YhOS0CwEaru1rUThYWcZr6wiyWvxx+pgTw=;
        b=fxIypQJIgHWKVvbkT5nsOTVRR6CTbZRQQBE4THE2pSIk1/6zodTf2ZH56ODRNVu6j9
         IF6UwbVhcPYAj1Oof1HcSsD7f+tGE+LrWIQJFW0kaa2j30kWXQ+ZYFcu9/nrg/6wdajJ
         0BNTUL36iiEizBy6xh17wfW/So/u72HaAhQw05Xbizf0AU5n3EuROwfSh12DvGJ+hK6S
         oNbplqU9RL/4e0p5/bb7yMtHSoQQOKYpRGT92CV5/rWzRXDlPXRl9beAJfXn845+tLEP
         TYP5CUkYp0KTF0dHciqEj3fmfBZc6MzH/6+ppZgV69CVu7IDBYqK4snMvv2BvuzS0IU9
         ksbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733429727; x=1734034527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6op1dKhn8YhOS0CwEaru1rUThYWcZr6wiyWvxx+pgTw=;
        b=aQVOI8ArM8cSLXNaQApTy4yW9Atq3Pg43uEi7YV3aX5IKkY5Ui2lv9tKU2skgzrj1p
         jh0EQ25YtM0Q9yzJRWdpNsKsgq+lVAlBDWAeb8p6khenvnwQyaLQKjC+A89/ancv72g6
         QLf1FVDjphR5FClOYvBdSXRMjrB1bVYuEHf+hINPMdFq2O/3hJ3pnaYLMSmSjAVPkkbh
         XUAPXwt5h3QPlKrqT2YwGyoIvcSCleZJ8idVqQ6B670SWN420unNNWucJia9t5bhi0mO
         a1OkJ8wRH3dxTViEISMCKYlqGFMTfZgNd54zZUN0WLqFoK/F4BF7qszIA9vjrVwRAw4f
         Z2hg==
X-Forwarded-Encrypted: i=1; AJvYcCVR6BtBMjVHkWjZ/JMdk72TVP4n0BbkYgYw0HihBeJLlXLFZN98uU254pO350gr+xcB9o8IPxNIVkPU53Ld@vger.kernel.org, AJvYcCXKF862865eUdyxehjcMT2a5arOxmRmYpLc+DDAjb23tnfoFwS9j19Uk81ajPVh3R0rIH1xYmf/yPElnqmz@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaez8lzQR05J0DprU4ABLgdamrv3iqfDq2df50/42pw5XyXrWb
	eHerqo2oe2kAmYWFT4DwKOhnSiHU7ieBHtkaarE5BG7v6T8NeSKrmQsjsXsb7J0WYQ52AVng8eW
	qIc52LB5ITxME/SHb31XVAylbwck=
X-Gm-Gg: ASbGnctFqjlUzrWt6cyVV57Ie8YJfY/qiE7I5u+pVuu2/T5pjMQGR2ZvW/nmZTQ9k6F
	jZgZtKD7M/Vl3Y5j6OTyPclLG6ZPQiMerqw==
X-Google-Smtp-Source: AGHT+IEHTTEf/K5pm0y5Abjbs1ZmK6EfVod6CtwoyiRuZ4H0zpUQiu1AGIkChm/7uZL5+t4toa4xq5uR4IDcXuxg9YU=
X-Received: by 2002:a05:6402:4005:b0:5d3:ba42:e9e3 with SMTP id
 4fb4d7f45d1cf-5d3be680ec5mr1062727a12.13.1733429726329; Thu, 05 Dec 2024
 12:15:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com> <20241205141850.GS3387508@ZenIV>
 <CAGudoHH3HFDgu61S4VW2H2DXj1GMJzFRstTWhDx=jjHcb-ArwQ@mail.gmail.com>
 <a9b7f0a0-bd15-4990-b67b-48986c2eb31d@paulmck-laptop> <CAGudoHGRaJZWM5s7s7bxXrDFyTEaZd1zEJOPX15yAdqEYr07eA@mail.gmail.com>
 <5a5bda20-f53f-40fe-96ab-a5ae4b39a746@paulmck-laptop>
In-Reply-To: <5a5bda20-f53f-40fe-96ab-a5ae4b39a746@paulmck-laptop>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 5 Dec 2024 21:15:14 +0100
Message-ID: <CAGudoHEU_Qkg=SwuFvv=C3cJqDwA_YPxJmwjRWMbgVGdybCMYw@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
To: paulmck@kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	edumazet@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 9:01=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Thu, Dec 05, 2024 at 08:03:24PM +0100, Mateusz Guzik wrote:
> > On Thu, Dec 5, 2024 at 7:41=E2=80=AFPM Paul E. McKenney <paulmck@kernel=
.org> wrote:
> > >
> > > On Thu, Dec 05, 2024 at 03:43:41PM +0100, Mateusz Guzik wrote:
> > > > On Thu, Dec 5, 2024 at 3:18=E2=80=AFPM Al Viro <viro@zeniv.linux.or=
g.uk> wrote:
> > > > >
> > > > > On Thu, Dec 05, 2024 at 01:03:32PM +0100, Mateusz Guzik wrote:
> > > > > >  void fd_install(unsigned int fd, struct file *file)
> > > > > >  {
> > > > > > -     struct files_struct *files =3D current->files;
> > > > > > +     struct files_struct *files;
> > > > > >       struct fdtable *fdt;
> > > > > >
> > > > > >       if (WARN_ON_ONCE(unlikely(file->f_mode & FMODE_BACKING)))
> > > > > >               return;
> > > > > >
> > > > > > +     /*
> > > > > > +      * Synchronized with expand_fdtable(), see that routine f=
or an
> > > > > > +      * explanation.
> > > > > > +      */
> > > > > >       rcu_read_lock_sched();
> > > > > > +     files =3D READ_ONCE(current->files);
> > > > >
> > > > > What are you trying to do with that READ_ONCE()?  current->files
> > > > > itself is *not* changed by any of that code; current->files->fdta=
b is.
> > > >
> > > > To my understanding this is the idiomatic way of spelling out the
> > > > non-existent in Linux smp_consume_load, for the resize_in_progress
> > > > flag.
> > >
> > > In Linus, "smp_consume_load()" is named rcu_dereference().
> >
> > ok
>
> And rcu_dereference(), and for that matter memory_order_consume, only
> orders the load of the pointer against subsequent dereferences of that
> same pointer against dereferences of that same pointer preceding the
> store of that pointer.
>
>         T1                              T2
>         a: p->a =3D 1;                    d: q =3D rcu_dereference(gp);
>         b: r1 =3D p->b;                   e: r2 =3D p->a;
>         c: rcu_assign_pointer(gp, p);   f: p->b =3D 42;
>
> Here, if (and only if!) T2's load into q gets the value stored by
> T1, then T1's statements e and f are guaranteed to happen after T2's
> statements a and b.  In your patch, I do not see this pattern for the
> files->resize_in_progress flag.
>
> > > > Anyway to elaborate I'm gunning for a setup where the code is
> > > > semantically equivalent to having a lock around the work.
> > >
> > > Except that rcu_read_lock_sched() provides mutual-exclusion guarantee=
s
> > > only with later RCU grace periods, such as those implemented by
> > > synchronize_rcu().
> >
> > To my understanding the pre-case is already with the flag set upfront
> > and waiting for everyone to finish (which is already taking place in
> > stock code) + looking at it within the section.
>
> I freely confess that I do not understand the purpose of assigning to
> files->resize_in_progress both before (pre-existing) and within (added)
> expand_fdtable().  If the assignments before and after the call to
> expand_fdtable() and the checks were under that lock, that could work,
> but removing that lockless check might have performance and scalability
> consequences.
>
> > > > Pretend ->resize_lock exists, then:
> > > > fd_install:
> > > > files =3D current->files;
> > > > read_lock(files->resize_lock);
> > > > fdt =3D rcu_dereference_sched(files->fdt);
> > > > rcu_assign_pointer(fdt->fd[fd], file);
> > > > read_unlock(files->resize_lock);
> > > >
> > > > expand_fdtable:
> > > > write_lock(files->resize_lock);
> > > > [snip]
> > > > rcu_assign_pointer(files->fdt, new_fdt);
> > > > write_unlock(files->resize_lock);
> > > >
> > > > Except rcu_read_lock_sched + appropriately fenced resize_in_progres=
s +
> > > > synchronize_rcu do it.
> > >
> > > OK, good, you did get the grace-period part of the puzzle.
> > >
> > > Howver, please keep in mind that synchronize_rcu() has significant
> > > latency by design.  There is a tradeoff between CPU consumption and
> > > latency, and synchronize_rcu() therefore has latencies ranging upward=
s of
> > > several milliseconds (not microseconds or nanoseconds).  I would be v=
ery
> > > surprised if expand_fdtable() users would be happy with such a long d=
elay.
> >
> > The call is already there since 2015 and I only know of one case where
> > someone took an issue with it (and it could have been sorted out with
> > dup2 upfront to grow the table to the desired size). Amusingly I see
> > you patched it in 2018 from synchronize_sched to synchronize_rcu.
> > Bottom line though is that I'm not *adding* it. latency here. :)
>
> Are you saying that the smp_rmb() is unnecessary?  It doesn't seem like
> you are saying that, because otherwise your patch could simply remove
> it without additional code changes.  On the other hand, if it is a key
> component of the synchronization, I don't see how that smp_rmb() can be
> removed while still preserving that synchronization without adding anothe=
r
> synchronize_rcu() to that function to compensate.
>
> Now, it might be that you are somehow cleverly reusing the pre-existing
> synchronize_rcu(), but I am not immediately seeing how this would work.
>
> And no, I do not recall making that particular change back in the
> day, only that I did change all the calls to synchronize_sched() to
> synchronize_rcu().  Please accept my apologies for my having failed
> to meet your expectations.  And do not be too surprised if others have
> similar expectations of you at some point in the future.  ;-)
>
> > So assuming the above can be ignored, do you confirm the patch works
> > (even if it needs some cosmetic changes)?
> >
> > The entirety of the patch is about removing smp_rmb in fd_install with
> > small code rearrangement, while relying on the machinery which is
> > already there.
>
> The code to be synchronized is fairly small.  So why don't you
> create a litmus test and ask herd7?  Please see tools/memory-model for
> documentation and other example litmus tests.  This tool does the moral
> equivalent of a full state-space search of the litmus tests, telling you
> whether your "exists" condition is always, sometimes, or never satisfied.
>

I think there is quite a degree of talking past each other in this thread.

I was not aware of herd7. Testing the thing with it sounds like a plan
to get out of it, so I'm going to do it and get back to you in a day
or two. Worst case the patch is a bust, best case the fence is already
of no use.

--=20
Mateusz Guzik <mjguzik gmail.com>

