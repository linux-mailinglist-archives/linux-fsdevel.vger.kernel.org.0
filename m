Return-Path: <linux-fsdevel+bounces-36563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A62F39E5E8F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 20:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DFC9283580
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 19:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB80D224B1C;
	Thu,  5 Dec 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCmDpNOB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224E12EB1F;
	Thu,  5 Dec 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733425421; cv=none; b=e1Eunch+0I3KmX/8d4haot4yTqvtYIsHSXwuJTmferQt2cQwhvPRsp+C5/5329rQ/AdZTIwWDvxekkymOD/olXK1mj6AY7rUqr7hn9FUHud2gfqs1KLqysSGSYiKKx2TwMvgThYiVc3+iXc+4v9QBUGA96O7y1oeEjTBFrneeHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733425421; c=relaxed/simple;
	bh=fnra3pDYyycuRXdGV5ggjxlBES+vlmcZ1SPoWbxDvD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOpin5kzXPTVyjdggWuEzREtobTIz0N70v5oLuHF8CInB+qvHhiuqGwjix7Vg5V3xlDNc1VzuANfPdGnrn9E/o4nRSw+NvDO/Ibuo5i6Ly5q7wec8uPJoeR6tnzviiXckDtyEY0wSloI+6k0/gIhuZ9sGsbM0+T52uBg/MGM850=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCmDpNOB; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso1412360a12.2;
        Thu, 05 Dec 2024 11:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733425417; x=1734030217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7teAgGLMiEHKk4bLfOCW1Tciut/MdO0P89L7oVMg55U=;
        b=kCmDpNOBGyALRl38aa4fuoO/EZ3iyXzwxhhmnbvMdQUw0iAqiFVMzneE6NBcH0PvuG
         L8xi+NzO9ig4qfrNDWKvqLg49rld+5W0WBiDrlOoiWfM7fMiB5/mKIX9efByfb66NAr4
         wBjOIxA2D9CC2/vZMB8d9vNYf0Ywq8JT+WTAj69sOA+Z8wtKWHIXre9Vx9H0e7cv+XsK
         tF11+1gCLafpqsyP8/K3oi5PNO72qABdXMv4z+gplLbMzlDI6U+QXyyWMjCbY4kDXxCr
         hG3nKFqhg28uGO/KFddzKBND8hekYgL6LO+J2+QsAXLHABrhrMVc1sVmjz7Bm7j1ROo8
         ceig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733425417; x=1734030217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7teAgGLMiEHKk4bLfOCW1Tciut/MdO0P89L7oVMg55U=;
        b=xHBjPfzfi3jxcqZJQLC44HZ9J4p1jTcBhCEjj23M622I7GrNCkxZNmH6vuQKgbJROM
         A6TTMFsf3ZzSIKmQcwqz+Wcv4q2JauKJiy/9SxWE9P+diN1FLIvsrFjI9CkbtNbPv9bw
         URrYSXmdAHSgKCSXF6nmH3MWc6WwiA+eg+VeviLjrVF7VL9H2lFsFLOYAqEENLteDfTF
         C8HMyr2FfR1X8wAjsHeBszPM4FoJ87noFsNHstXrA7oroW9u9kTi/L/uRXiF7p4ThcyK
         XYutKw1FPZTmZlADIyO+9yc52mXIFlgjclIiDnowTHRvcda9JsLrB67TzqY7yaNO3iDL
         O9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5MaF3ZhnSgBO1+XA5kv6SlBMMrZLHgBf1cwvRC7ium+JNkvLM34T0XWWdnPqmj+6qsMlLPqRYYjt6JH8V@vger.kernel.org, AJvYcCXjBDlxE74cCgEZkgJDWiDjX1lvmnrpJWF2f5rRkYOVv8MyvTEVlxvAysrSEJKdwefxBiAQABqIynQ7NAHb@vger.kernel.org
X-Gm-Message-State: AOJu0YwuxBQQNWVFgffVOtrEP19q80TPeqq1epp1kKwqMeebVMJ2Rkbf
	cEqPDKH4j3IFzIGIeMx1aGBTBB6l2JArYtXv7oc5GuSQGHEUTLyLEoktPtvZ2Cn47naT6IksCgZ
	ckqtFTyQeMK8fA4FaOod8v1h6eDI=
X-Gm-Gg: ASbGnct5EV3kYPTVPIHR58KNKKEzVd9hq54rAxwzPCPDualCNWFB0IGar9foxlTIT6l
	XBIFkqRQLWPZ8edH6ASi9+Co62OZ8ig==
X-Google-Smtp-Source: AGHT+IEpPqt6j29pROHSQPqxzplPJ7oY5EV7C/O1OcibRNyMI3CYF5rPnSKYl6WVbfhCspZQ++e+SfwcK29+yVHQGsY=
X-Received: by 2002:a05:6402:254e:b0:5d0:bcdd:ff9c with SMTP id
 4fb4d7f45d1cf-5d3be69656cmr169503a12.2.1733425416889; Thu, 05 Dec 2024
 11:03:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com> <20241205141850.GS3387508@ZenIV>
 <CAGudoHH3HFDgu61S4VW2H2DXj1GMJzFRstTWhDx=jjHcb-ArwQ@mail.gmail.com> <a9b7f0a0-bd15-4990-b67b-48986c2eb31d@paulmck-laptop>
In-Reply-To: <a9b7f0a0-bd15-4990-b67b-48986c2eb31d@paulmck-laptop>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 5 Dec 2024 20:03:24 +0100
Message-ID: <CAGudoHGRaJZWM5s7s7bxXrDFyTEaZd1zEJOPX15yAdqEYr07eA@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
To: paulmck@kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	edumazet@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 7:41=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Thu, Dec 05, 2024 at 03:43:41PM +0100, Mateusz Guzik wrote:
> > On Thu, Dec 5, 2024 at 3:18=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk=
> wrote:
> > >
> > > On Thu, Dec 05, 2024 at 01:03:32PM +0100, Mateusz Guzik wrote:
> > > >  void fd_install(unsigned int fd, struct file *file)
> > > >  {
> > > > -     struct files_struct *files =3D current->files;
> > > > +     struct files_struct *files;
> > > >       struct fdtable *fdt;
> > > >
> > > >       if (WARN_ON_ONCE(unlikely(file->f_mode & FMODE_BACKING)))
> > > >               return;
> > > >
> > > > +     /*
> > > > +      * Synchronized with expand_fdtable(), see that routine for a=
n
> > > > +      * explanation.
> > > > +      */
> > > >       rcu_read_lock_sched();
> > > > +     files =3D READ_ONCE(current->files);
> > >
> > > What are you trying to do with that READ_ONCE()?  current->files
> > > itself is *not* changed by any of that code; current->files->fdtab is=
.
> >
> > To my understanding this is the idiomatic way of spelling out the
> > non-existent in Linux smp_consume_load, for the resize_in_progress
> > flag.
>
> In Linus, "smp_consume_load()" is named rcu_dereference().
>

ok

> > Anyway to elaborate I'm gunning for a setup where the code is
> > semantically equivalent to having a lock around the work.
>
> Except that rcu_read_lock_sched() provides mutual-exclusion guarantees
> only with later RCU grace periods, such as those implemented by
> synchronize_rcu().
>

To my understanding the pre-case is already with the flag set upfront
and waiting for everyone to finish (which is already taking place in
stock code) + looking at it within the section.

> > Pretend ->resize_lock exists, then:
> > fd_install:
> > files =3D current->files;
> > read_lock(files->resize_lock);
> > fdt =3D rcu_dereference_sched(files->fdt);
> > rcu_assign_pointer(fdt->fd[fd], file);
> > read_unlock(files->resize_lock);
> >
> > expand_fdtable:
> > write_lock(files->resize_lock);
> > [snip]
> > rcu_assign_pointer(files->fdt, new_fdt);
> > write_unlock(files->resize_lock);
> >
> > Except rcu_read_lock_sched + appropriately fenced resize_in_progress +
> > synchronize_rcu do it.
>
> OK, good, you did get the grace-period part of the puzzle.
>
> Howver, please keep in mind that synchronize_rcu() has significant
> latency by design.  There is a tradeoff between CPU consumption and
> latency, and synchronize_rcu() therefore has latencies ranging upwards of
> several milliseconds (not microseconds or nanoseconds).  I would be very
> surprised if expand_fdtable() users would be happy with such a long delay=
.

The call is already there since 2015 and I only know of one case where
someone took an issue with it (and it could have been sorted out with
dup2 upfront to grow the table to the desired size). Amusingly I see
you patched it in 2018 from synchronize_sched to synchronize_rcu.
Bottom line though is that I'm not *adding* it. latency here. :)

So assuming the above can be ignored, do you confirm the patch works
(even if it needs some cosmetic changes)?

The entirety of the patch is about removing smp_rmb in fd_install with
small code rearrangement, while relying on the machinery which is
already there.

--=20
Mateusz Guzik <mjguzik gmail.com>

