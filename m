Return-Path: <linux-fsdevel+bounces-61827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B2AB5A216
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 22:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E10E3B0AE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 20:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6582E2E717B;
	Tue, 16 Sep 2025 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtiXqV5Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92862DE1E3
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053577; cv=none; b=UNwFvZe+XxSyJlZdaaJRZCyMcjSqCZm1jh8nvbXyNjVWKEY0BNq3u2lUOsTUdZjCJJjLJodEBIXlZd6UFVV8EUhkLsUq8UTGH2RCFayzaQwouaor5Gde/e1Su0K4Tn3VMyJPalYpkXXM5N1ICuH3pmm/DjdtWf89CRJpcOGCSFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053577; c=relaxed/simple;
	bh=Zl7WWAxPDhMCPt947WDJQVJXx+PbyWgGERLioKRvZoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+h8HuPqe6w3c8crX/UxDj7kCXQqLQ5rizK7zoleBl40D7rFTS4E7Yskf7yUf0nclUtH0yh8t3r4BZtwc2MkTodlucXAjIsDKUpTSyl5PHWYAD4UgH92Sz3fJl1fcZqvJ9WH/O8O/4hLrnIi6pLq+NWLrG1SHQK0y1P5wqRwp2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtiXqV5Z; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b61161c32eso73914951cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 13:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758053574; x=1758658374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wtqq+W9rzFtsdCRHqz+3WMQzOHoQqtCSBZODtPuWGws=;
        b=QtiXqV5ZfU2s5ph5wDVVr9XOCiNWisSpQ7PdWj1vG7JYuTwIzgt97Pz+qL0hBZ8SaU
         jV0FWsfN241JzZdXsNh9qdmuj+cV1n/lmsL1c6lezvI/bBBipxaRrKKeFHQlw2VLQCD4
         RCuwifrAdRK8a4+imflXtyj042Fr0TUFjtDb3ZPnioyBGRlLcO3DvnFeZC4CkZsS9fTr
         vEA2fKV8Fre8WXW54PJ0aRBqicXAV+qf5rma0wKxg6lL7sq97h5u802gECZYokiKMTMv
         93Szy7AZRbaFIHTRuuYU7xzFTNYtNBKxDttWegFfqw4E/SefaobgY+PsywW4K9BjMDuF
         1Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758053574; x=1758658374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wtqq+W9rzFtsdCRHqz+3WMQzOHoQqtCSBZODtPuWGws=;
        b=o+NfJypQQAUQi784VOJ9eAtroi2eca0M/FUtVot8GO9g83mSddecQSj0lYrh5DX92c
         Zx+En7qicCWvHDKYSSr/y1JqvxFAL7kV4CJRr7JPG7wUYOf5NJme9uMy9qOTZbigswSU
         IcP8DK22mm+KrhqYmlQdTDfjMyS63eFdJdf9QdBWTzmKI3TxdJZY+fXGPdXxI88ean/H
         2S8Do07LMUixsmjD3peHS3h8nSDrhQ8ASZuclZRtYN1+nt9fYuA6VXupxyNMcKB4JxaC
         S6umXtlWxItExEHC+o8T7j51qAAS2okMMn0h6+op3+KvWpfa3E8oGlGaLr6vytV4VYZ8
         jHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSay3G6W2ENqcJIW2lEQwPngbga5GHez80ZCkpc4kBbGYvnrLwAq8ULNgMcjQR8vxPs3Gr+tRZBA4IqtQP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4s6KwWjn3RAPYC+b6cQJyde6TksNRgMET2KsnfeTxuEvERZMd
	QPjFvc2qOADFSPmJDiNLmOauahBi6QbbuMIQoTYfC3GJjq8tq1i0jsvQ/4Np1LK7DoF3zxSr1T6
	S3nfTFdjXXpuLWpAqyFaQYZsvSWhioYA=
X-Gm-Gg: ASbGncsvjadMaNShK4ejM2a1DnQtmF4xOJb18mgswZ022I28tI2sqpKqJzqAJI0mgKX
	+JnSAcimTn5AmONz2PxqXgJKN5+Uq2g8BQZPP6HUv6smBbl+DR0mdv2ZgNwuyYVYw1FxO35s3jQ
	1m31GkcZMga63J2k5WMjEMOWKo2pTptq9zpg1NybLxTJ2wv6kXcZvuvyPSLLMfNhd4gwiXR7JZi
	tJihVAZuKWk38jwOwXxnyK1+J2BJqdehEUCiPx4
X-Google-Smtp-Source: AGHT+IFx3MKkRNNBBKDNN+Y8JIWJQQeLjnFQ7Osa/gTKOPlFMrA6glLl4tuTmbi5GLkJQfCoJmOdcO9VZrjgO4bcaLs=
X-Received: by 2002:a05:622a:256:b0:4b5:ecc3:694b with SMTP id
 d75a77b69052e-4b77d014426mr184119281cf.10.1758053574136; Tue, 16 Sep 2025
 13:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <94377ddf-9d04-4181-a632-d8c393dcd240@ddn.com> <CAJnrk1ZHfd3r1+s0fV209LROO1kixM=_T7Derm+GrR_hYa_wpw@mail.gmail.com>
 <99313bf9-963f-430e-a929-faa915d77202@bsbernd.com> <CAJnrk1aYqZPNg_O25Yv6d5jGdzcPv0oyQ93KwarxovBJMyymdA@mail.gmail.com>
 <4acdbba9-c4ad-4b33-b74b-2acc424cb24a@bsbernd.com> <478c4d28-e7d9-4dbd-9521-a3cea73fddde@bsbernd.com>
 <CAJnrk1ahQf5-Rb+axFJ=yNn=AWneTtYjKMFzVeorKjQfTjc9Aw@mail.gmail.com> <e5793dc4-94f8-4216-aa0c-463331d3092b@bsbernd.com>
In-Reply-To: <e5793dc4-94f8-4216-aa0c-463331d3092b@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 16 Sep 2025 13:12:41 -0700
X-Gm-Features: AS18NWD6mPyG_SiaZcu1ZMCHG-5OCJ4hPV97RwatOB43B-UxTXxhOxhu40D92tc
Message-ID: <CAJnrk1YaRRKHA-jVPAKZYpydaKcdswLG0XO7pUQZZ4-pTewkHQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs/fuse: fix potential memory leak from fuse_uring_cancel
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Jian Huang Li <ali@ddn.com>, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:17=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 9/16/25 01:04, Joanne Koong wrote:
> > On Mon, Sep 15, 2025 at 2:57=E2=80=AFPM Bernd Schubert <bernd@bsbernd.c=
om> wrote:
> >> On 9/15/25 23:46, Bernd Schubert wrote:
> >>> On 9/15/25 23:23, Joanne Koong wrote:
> >>>> On Mon, Sep 15, 2025 at 1:15=E2=80=AFPM Bernd Schubert <bernd@bsbern=
d.com> wrote:
> >>>>>
> >>>>> Hi Joanne,
> >>>>>
> >>>>> thanks for looking into this.
> >>>>>
> >>>>> On 9/15/25 20:15, Joanne Koong wrote:
> >>>>>> On Thu, Sep 11, 2025 at 3:34=E2=80=AFAM Jian Huang Li <ali@ddn.com=
> wrote:
> >>>>>>>
> >>>>>>> This issue could be observed sometimes during libfuse xfstests, f=
rom
> >>>>>>> dmseg prints some like "kernel: WARNING: CPU: 4 PID: 0 at
> >>>>>>> fs/fuse/dev_uring.c:204 fuse_uring_destruct+0x1f5/0x200 [fuse]".
> >>>>>>>
> >>>>>>> The cause is, if when fuse daemon just submitted
> >>>>>>> FUSE_IO_URING_CMD_REGISTER SQEs, then umount or fuse daemon quits=
 at
> >>>>>>> this very early stage. After all uring queues stopped, might have=
 one or
> >>>>>>> more unprocessed FUSE_IO_URING_CMD_REGISTER SQEs get processed th=
en some
> >>>>>>> new ring entities are created and added to ent_avail_queue, and
> >>>>>>> immediately fuse_uring_cancel moves them to ent_in_userspace afte=
r SQEs
> >>>>>>> get canceled. These ring entities will not be moved to ent_releas=
ed, and
> >>>>>>> will stay in ent_in_userspace when fuse_uring_destruct is called,=
 needed
> >>>>>>> be freed by the function.
> >>>>>>
> >>>>>> Hi Jian,
> >>>>>>
> >>>>>> Does it suffice to fix this race by tearing down the entries from =
the
> >>>>>> available queue first before tearing down the entries in the users=
pace
> >>>>>> queue? eg something like
> >>>>>>
> >>>>>>  static void fuse_uring_teardown_entries(struct fuse_ring_queue *q=
ueue)
> >>>>>>  {
> >>>>>> -       fuse_uring_stop_list_entries(&queue->ent_in_userspace, que=
ue,
> >>>>>> -                                    FRRS_USERSPACE);
> >>>>>>         fuse_uring_stop_list_entries(&queue->ent_avail_queue, queu=
e,
> >>>>>>                                      FRRS_AVAILABLE);
> >>>>>> +       fuse_uring_stop_list_entries(&queue->ent_in_userspace, que=
ue,
> >>>>>> +                                    FRRS_USERSPACE);
> >>>>>>  }
> >>>>>>
> >>>>>> AFAICT, the race happens right now because when fuse_uring_cancel(=
)
> >>>>>> moves the FRRS_AVAILABLE entries on the ent_avail_queue to the
> >>>>>> ent_in_userspace queue, fuse_uring_teardown_entries() may have alr=
eady
> >>>>>> called fuse_uring_stop_list_entries() on the ent_in_userspace queu=
e,
> >>>>>> thereby now missing the just-moved entries altogether, eg this log=
ical
> >>>>>> flow
> >>>>>>
> >>>>>> -> fuse_uring_stop_list_entries(&queue->ent_in_userspace, ...);
> >>>>>>     -> fuse_uring_cancel() moves entry from avail q to userspace q
> >>>>>> -> fuse_uring_stop_list_entries(&queue->ent_avail_queue, ...);
> >>>>>>
> >>>>>> If instead fuse_uring_teardown_entries() stops the available queue=
 first, then
> >>>>>> -> fuse_uring_stop_list_entries(&queue->ent_avail_queue, ...);
> >>>>>>     -> fuse_uring_cancel()
> >>>>>> -> fuse_uring_stop_list_entries(&queue->ent_in_userspace, ...);
> >>>>>>
> >>>>>> seems fine now and fuse_uring_cancel() would basically be a no-op
> >>>>>> since ent->state is now FRRS_TEARDOWN.
> >>>>>>
> >>>>>
> >>>>> I'm not sure. Let's say we have
> >>>>>
> >>>>> task 1                                   task2
> >>>>> fuse_uring_cmd()
> >>>>>     fuse_uring_register()
> >>>>>          [slowness here]
> >>>>>                                         fuse_abort_conn()
> >>>>>                                           fuse_uring_teardown_entri=
es()
> >>>>>          [slowness continue]
> >>>>>          fuse_uring_do_register()
> >>>>>             fuse_uring_prepare_cancel()
> >>>>>             fuse_uring_ent_avail()
> >>>>>
> >>>>>
> >>>>> I.e. fuse_uring_teardown_entries() might be called before
> >>>>> the command gets marked cancel-able and before it is
> >>>>> moved to the avail queue. I think we should extend the patch
> >>>>> and actually not set the ring to ready when fc->connected
> >>>>> is set to 0.
> >>>>>
> >>>>
> >>>> Hi Bernd,
> >>>>
> >>>> I think this is a separate race from the fuse_uring_cancel one.
> >>>> afaics, this race can happen even if the user doesn't call
> >>>> fuse_uring_cancel(). imo I think the cleanest solution to this
> >>>> registration vs teardown race is to check queue->stopped in
> >>>> fuse_uring_do_register() after we grab the queue spinlock, and if
> >>>> queue->stopped is true, then just clean up the entry ourselves with
> >>>> fuse_uring_entry_teardown()).
> >>>
> >>> What speaks against just doing as in the existing patch and freeing
> >>> the ent_in_userspace entries fuse_uring_destruct()?
> >>> IMO it covers both races, missing is just to avoid setting the ring
> >>> as ready.
> >
> > Couldn't the entry in fuse_uring_do_register() be in the available
> > queue when we get to fuse_uring_destruct() which means the existing
>
> We would never go into fuse_uring_destruct(), because io-uring would
> still hold references on the fuse device / fuse_conn.
>
> > patch would also have to iterate through the available queue too? eg
> > i'm imagining something like
> >
> > fuse_uring_do_register()
> >    -> fuse_uring_prepare_cancel()
> >          *** fuse_uring_cancel() + teardown run on other threads
> >    -> fuse_uring_ent_avail()
>
> Up to hear it is right, but then see io_ring_exit_work() in io_uring.c.
> I.e. it will run io_uring_try_cancel_requests() in a loop.
> fuse_uring_cancel() is a noop as long as ent->state !=3D FRRS_AVAILABLE
>
> If commands are not cancelled at all, io_ring_exit_work() will print
> warnings in intervals - initially I hadn't figured out about
> IO_URING_F_CANCEL (and maybe it also didn't exist in earlier kernel
> versions) and then had added workarounds into fuse_dev_release(),
> because of the io-uring references.

I took a look at the io-uring code (thanks for the pointer to
io_ring_exit_work()) and now imo I think fuse_uring_cancel() should
tear down the entry directly instead of moving it to the userspace
queue. If I'm understanding it correctly, IO_URING_F_CANCEL is only
sent on io-uring or process teardown (eg when the last refcount on the
io-uring fd is dropped, or when a process exits) so the intended
behavior with the cancel is to tear down the entry. imo the cleanest
approach here is to just tear down the entry on cancel instead of
moving it to the userspace queue to have fuse_uring_teardown_entries()
try to handle it. Unless I'm missing some other reason it needs to be
moved to the userspace queue?

Thanks,
Joanne

>
> >
> > imo, I think this scenario is its own separate race (between
> > registration and cancellation, that can happen irregardless of
> > teardown) that should be fixed by calling fuse_uring_prepare_cancel()
> > only after the fuse_uring_ent_avail() call, but I think this
> > underscores a bit that explicitly checking against torn down entries
> > is more robust when dealing with these races.
> >
> >>
> >> Well, maybe cleaner, I don't have a strong opinion. We could skip the
> >> comment and explanation with your approach.
> >
> > I don't really have a strong opinion on this either, just wanted to
> > share my thoughts. If you'd rather go with the existing patch, then we
> > should do that.
>
>
> I still think Jians patch works as it is, although there is a bit magic
> behind it. The mere fact that we have the discussion above it probably
> reason enough to at least try to find a way to make easier to read.
>
>
> Thanks,
> Bernd

