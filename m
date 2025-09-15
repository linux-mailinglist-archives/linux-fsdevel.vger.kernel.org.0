Return-Path: <linux-fsdevel+bounces-61452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D28AB586AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 23:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 557014E2253
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 21:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0024A283CB8;
	Mon, 15 Sep 2025 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dToTMSfl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75D71E9B1C
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971447; cv=none; b=ddjT2rDKwEp8FjUH8afPKqm4R33XpJ16CRebqAe7ivRjTm9jomdotOolp4nx/CTbs3E1W8ovlgMPS0zagJfkjAy6TCjDuYFz0oyXNuz+i7657AwbVvOYGduuKnQRE0WG7zlsYEtZStorpx0LdyfgDVFUIIHCOSeI/N3zzt3yYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971447; c=relaxed/simple;
	bh=tJ07IjjkN6LfRKRaknf3GSKd5airO6VA/4CYAh6JTuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zv44BTpPC+SxeeZtCj4jwtN+OJDLzy/x3PLbCpm2SYTGaZBMeov4OIpcPPUj15TX2hBcGEAwBj4LD/y5W8GKOgM4aVoyTOgtFUSDE7QvacnGv3L6YmD4691p898Omc+wuuJK1VoyDhVFKC82rKpL0HWWwAhNvWreEF2zRNFdF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dToTMSfl; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b7b3202dceso849741cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 14:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757971444; x=1758576244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8eIrrll5+Z7MtFeluZJcqZlVksz8aXT9U18MrDs6co=;
        b=dToTMSflO/qB2WIJmpi3c067nj5Fg8XIgu4Q6f8E7YsFu3bCnY+8O0IMj1hyfpsXWI
         trW9sISbsXwprL/8j/KeIKDCXSAUnw68e4/gFdZvThOGvZoa3H8hlo0ySohFBlFvV49G
         H0BeaM2F5nc66dK//cfomHoJlVgqdkW0Ch+DOdEe7O/OU65B553m0cBai85XNKl/5Dz5
         b8oF+fLV+N0c6fM3F00ijkhBuFtVhBCawcc/pCDQxmdHns1Bw87Ato0Q7qCPQC3vo9bI
         kk3QmK/5KaHl1mW8r8GtfSdtI3nactdD8qil1KnLICFdMhN0eHOUaHSSBDpYthJB2sjh
         uwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757971444; x=1758576244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8eIrrll5+Z7MtFeluZJcqZlVksz8aXT9U18MrDs6co=;
        b=wgahJiOQOk4B9MlvoilRZsy6JpoMbSdZwvZxKSNk/5MMFqKAgW7qJe/yW/L51P/ht8
         5kVC+VF7q03eCu/Ze2n1Z7U9bbSAt3kjMFutM2ozR3ZzddUeCLWWYmaQKfc+C7B1jk+e
         7gYLGK4FIZlHhMUVmNKLuf39IAUfe8i/LQIY0lGr2qPKlj/1ztpRTSHcPLzc1uT6Jksc
         WLXLtHlLO7sV30QMNEpp8n4Xqlj6o6nnGF89B2FfrG0HOiFvnBUWAHV/L6Rv4pdMeb20
         0rQWf95mUXhobNnm4AEkMY7pvbBYkwSQM6mzZ/pX5odbR+TF51x2YBhvks5b+pygepXq
         o7HA==
X-Forwarded-Encrypted: i=1; AJvYcCVOIIBV9TLf3qObarqU7wfiNmdGwUXheyNxh/7zaLVNoqoQzMT/H2XO4D/cBUtE+Jw7kmN95/w9rUZp1eqv@vger.kernel.org
X-Gm-Message-State: AOJu0YwqO3yk1FN3b6QiHw9SW4tm/IMvEWKFgoSxIGb5uhbLQKAoAOph
	XrHzcF2wJxIbZS8nms+/8m9J7EScYkvtXhTyQTpshv8HCP/4fTr9WA+tYzqebQTrRz/lCL5S/KX
	AGwm/WMXL4dDA4WdNGeFZk8UpuY5Qe24+5IEnhwA=
X-Gm-Gg: ASbGncsuNipjLd8aEIGl4L2jMS/5hVsQjIX6qgeGvQkVTa2BmZ4lL8XXBop15V5Q9/C
	YskadGiAlHzD2rzZ7g14v+v7sDoPYd54RHm/ItvRTatFOqIG4wtZkrEUsPRc6S6panvLAtq46RX
	Ped4TKN2me8UFJysSXYJz9th0xgDElASfjMcXrR76j8pTP39JD9x1Ghgzr8gaNzveiGcz0DRxuu
	ypB0oMTgZ1R6q/P/Azm9SBVXfUvT5WK6X57+Y7q6bypjIU7UCE=
X-Google-Smtp-Source: AGHT+IFIJ9IhF6jAqpzmUJSL4+hl3zu40fVnXzpJZy4e9IdU9ix0Q8B2yicBUKZoOLwFU8I4rb9++IF/GUV4oE5/nKI=
X-Received: by 2002:ac8:5d51:0:b0:4b5:e38f:7497 with SMTP id
 d75a77b69052e-4b77cfcb815mr211857271cf.25.1757971444333; Mon, 15 Sep 2025
 14:24:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <94377ddf-9d04-4181-a632-d8c393dcd240@ddn.com> <CAJnrk1ZHfd3r1+s0fV209LROO1kixM=_T7Derm+GrR_hYa_wpw@mail.gmail.com>
 <99313bf9-963f-430e-a929-faa915d77202@bsbernd.com>
In-Reply-To: <99313bf9-963f-430e-a929-faa915d77202@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 15 Sep 2025 14:23:53 -0700
X-Gm-Features: Ac12FXycsRvy3zln-ukMwkGq2UQ3GMzjiBIxKIz-WjR4rCZIZeKXbx0tjrMhuSw
Message-ID: <CAJnrk1aYqZPNg_O25Yv6d5jGdzcPv0oyQ93KwarxovBJMyymdA@mail.gmail.com>
Subject: Re: [PATCH v2] fs/fuse: fix potential memory leak from fuse_uring_cancel
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Jian Huang Li <ali@ddn.com>, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 1:15=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> Hi Joanne,
>
> thanks for looking into this.
>
> On 9/15/25 20:15, Joanne Koong wrote:
> > On Thu, Sep 11, 2025 at 3:34=E2=80=AFAM Jian Huang Li <ali@ddn.com> wro=
te:
> >>
> >> This issue could be observed sometimes during libfuse xfstests, from
> >> dmseg prints some like "kernel: WARNING: CPU: 4 PID: 0 at
> >> fs/fuse/dev_uring.c:204 fuse_uring_destruct+0x1f5/0x200 [fuse]".
> >>
> >> The cause is, if when fuse daemon just submitted
> >> FUSE_IO_URING_CMD_REGISTER SQEs, then umount or fuse daemon quits at
> >> this very early stage. After all uring queues stopped, might have one =
or
> >> more unprocessed FUSE_IO_URING_CMD_REGISTER SQEs get processed then so=
me
> >> new ring entities are created and added to ent_avail_queue, and
> >> immediately fuse_uring_cancel moves them to ent_in_userspace after SQE=
s
> >> get canceled. These ring entities will not be moved to ent_released, a=
nd
> >> will stay in ent_in_userspace when fuse_uring_destruct is called, need=
ed
> >> be freed by the function.
> >
> > Hi Jian,
> >
> > Does it suffice to fix this race by tearing down the entries from the
> > available queue first before tearing down the entries in the userspace
> > queue? eg something like
> >
> >  static void fuse_uring_teardown_entries(struct fuse_ring_queue *queue)
> >  {
> > -       fuse_uring_stop_list_entries(&queue->ent_in_userspace, queue,
> > -                                    FRRS_USERSPACE);
> >         fuse_uring_stop_list_entries(&queue->ent_avail_queue, queue,
> >                                      FRRS_AVAILABLE);
> > +       fuse_uring_stop_list_entries(&queue->ent_in_userspace, queue,
> > +                                    FRRS_USERSPACE);
> >  }
> >
> > AFAICT, the race happens right now because when fuse_uring_cancel()
> > moves the FRRS_AVAILABLE entries on the ent_avail_queue to the
> > ent_in_userspace queue, fuse_uring_teardown_entries() may have already
> > called fuse_uring_stop_list_entries() on the ent_in_userspace queue,
> > thereby now missing the just-moved entries altogether, eg this logical
> > flow
> >
> > -> fuse_uring_stop_list_entries(&queue->ent_in_userspace, ...);
> >     -> fuse_uring_cancel() moves entry from avail q to userspace q
> > -> fuse_uring_stop_list_entries(&queue->ent_avail_queue, ...);
> >
> > If instead fuse_uring_teardown_entries() stops the available queue firs=
t, then
> > -> fuse_uring_stop_list_entries(&queue->ent_avail_queue, ...);
> >     -> fuse_uring_cancel()
> > -> fuse_uring_stop_list_entries(&queue->ent_in_userspace, ...);
> >
> > seems fine now and fuse_uring_cancel() would basically be a no-op
> > since ent->state is now FRRS_TEARDOWN.
> >
>
> I'm not sure. Let's say we have
>
> task 1                                   task2
> fuse_uring_cmd()
>     fuse_uring_register()
>          [slowness here]
>                                         fuse_abort_conn()
>                                           fuse_uring_teardown_entries()
>          [slowness continue]
>          fuse_uring_do_register()
>             fuse_uring_prepare_cancel()
>             fuse_uring_ent_avail()
>
>
> I.e. fuse_uring_teardown_entries() might be called before
> the command gets marked cancel-able and before it is
> moved to the avail queue. I think we should extend the patch
> and actually not set the ring to ready when fc->connected
> is set to 0.
>

Hi Bernd,

I think this is a separate race from the fuse_uring_cancel one.
afaics, this race can happen even if the user doesn't call
fuse_uring_cancel(). imo I think the cleanest solution to this
registration vs teardown race is to check queue->stopped in
fuse_uring_do_register() after we grab the queue spinlock, and if
queue->stopped is true, then just clean up the entry ourselves with
fuse_uring_entry_teardown()).

Thanks,
Joanne

>
> Thanks,
> Bernd

