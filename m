Return-Path: <linux-fsdevel+bounces-61463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DA1B587FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37669207651
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 23:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230352C0F64;
	Mon, 15 Sep 2025 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NH3r96l3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA32853F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977488; cv=none; b=XG3ALg4bqHXOfN8DFUOKXnmbB1urB+9CtYvi1uBuuJxISeusWJP5/ut6Fb4JhBGUtFAJGKRcKFoqp04MOKEC711tzB3ZEIlXXHm3beYfvuXktCZXUihLebwSHrCT6k65SDYZsz4jBph5/OX+899FaAhQXu1KpNP5fzzANylfbaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977488; c=relaxed/simple;
	bh=As8bGzHr3/6i2y46XwKxIhPbMiqbsN9GRPozLl+Z83o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjH/54aC4bcteYGRqNU5tmAqyh4pacXcSru7FbMGLKUzkj78iPTz+973AOsL56mNP5bVe45M+ojiMeMpqF3+YCA7fP3kFzzjjPVGsuSdqLwdiwr1mcb7PnxaDdS+nYJEmp8ywYHaUbeuOi3dOqjb0ovBcM5o9YHoaYujxMDqg7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NH3r96l3; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b5ed9d7e20so53363621cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 16:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757977486; x=1758582286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7JSogRRnXxh1Dq0QwaBCSt0Ncw8JPhTcrImYgJ+TTc=;
        b=NH3r96l3P6V4p4tYU8v0duYHzShIV7I76xkF6xMnfaxfL1P+tmX6l6xA/lje1p5gCJ
         j5VGXxaivorJbkR93XG8v0ua+WzjcWyOrkxL6MD/iyi5VXYXTt9WkP2KucAY2mnkqTOj
         sgqNfqdm7/9xYwIwDiBnF4Frvunq3xVC/IamBO7fNgkjI1w2x0m0Xc0o3KDKdSihT6fA
         kJN8wkVsMBZMREXyIx23WdySnpYKJBNigDgUM98tD+aOftnqBJzYr2czLXnyIgdA+Kpr
         cLfkDTgl4QDqDmsYkbDlRHpuuJ8J4Qy1mmOtHb76QWvksRv6nUoTYNrXHZchiwye4hE9
         Vjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977486; x=1758582286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7JSogRRnXxh1Dq0QwaBCSt0Ncw8JPhTcrImYgJ+TTc=;
        b=mfO7IOjuKx7hXATGBtO8eQTWdG/dKrm/5f+pfKcnWEedFYczC6CQcesfo3k7gLly83
         XrlfULvcaf70NEneuQT1zw5Ps3Hl0JvzJoE3fR5YsAMHhEBoAdSV0txRAM8eIkOFIJPB
         ipswEwZuPKxNi3enuVATIAEEzlVBxhbjfDSGMe9F8PZiBqyrW7uJVQbRp4YbR6OdT/BM
         jjB8v+JxPkyTZbAZpr9CryeldKEu3LorqclCbHCvR3wXxelTxjsNpH48qmMnZ8ZNv3El
         4w76FQPF1c3eKYVf3LJbkcy+vcNLYwQf+Ivy0ajVjSI6v+u+WDzyRTlgQyLsJfY6Zvnb
         R6zg==
X-Forwarded-Encrypted: i=1; AJvYcCVsv/04bBjq2ERQM4mlk9O2nhg/bnEIG90nHthExGo8iMDZz1haDpJbfTbt4w2L7egKVIq/B/BWu6O4/gL+@vger.kernel.org
X-Gm-Message-State: AOJu0YxGK5o8siFLiZ5bs2wsd3JkQAcgdD7wt79bLOUKIIZ/fpZ+Z8Ya
	c4P1LM8vaCs/lsxs3H6J6MDFCCGdDX8xJembFO+ZmiK9gK0tIp4UMULNCWQoDPZZduTB1RInLlh
	eEQoCpsjmBNxBwd+pd0FrKw2WtZnXXIk=
X-Gm-Gg: ASbGncvsDPXmApxD6oyd2mBdZxAB1wWggv5/L87b6ydJ/Pj1Xq2PXn+SmbDuZr1rMQz
	k3hEjL29xmyb1LlfddN1ls051y9SKJ1PNHY9LqQs+913LDwJI+fg9Y1uKvF4ajs2uK17qx1+wWa
	+R4u/fnOWsL7jevlbS0uBSde6h8zrH0zUovpZzCsL3k7XSQ1oQCVAdxPzPrPs01o4js0reFzSVu
	bDOMLkPbu+OcJZj2id6DF/ad2/Pr3C+t6ClXCh3Yztq/ikDrqI=
X-Google-Smtp-Source: AGHT+IGYUOe1xdkJBKnwkbQx5JUsPgb9uX0RgWlEdAsXbyBLeEzjj6wbVLkrL1/YzZRI407pM3H5b7qHasNKAAM9CLs=
X-Received: by 2002:a05:622a:288:b0:4b3:cbc:18b5 with SMTP id
 d75a77b69052e-4b77cff7521mr172853571cf.32.1757977485508; Mon, 15 Sep 2025
 16:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <94377ddf-9d04-4181-a632-d8c393dcd240@ddn.com> <CAJnrk1ZHfd3r1+s0fV209LROO1kixM=_T7Derm+GrR_hYa_wpw@mail.gmail.com>
 <99313bf9-963f-430e-a929-faa915d77202@bsbernd.com> <CAJnrk1aYqZPNg_O25Yv6d5jGdzcPv0oyQ93KwarxovBJMyymdA@mail.gmail.com>
 <4acdbba9-c4ad-4b33-b74b-2acc424cb24a@bsbernd.com> <478c4d28-e7d9-4dbd-9521-a3cea73fddde@bsbernd.com>
In-Reply-To: <478c4d28-e7d9-4dbd-9521-a3cea73fddde@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 15 Sep 2025 16:04:34 -0700
X-Gm-Features: Ac12FXw_JPa5LbPZilHmHMh9UMbw_ySK-770W7CyvquN_hWE2q0Ep91Qi0hjs-c
Message-ID: <CAJnrk1ahQf5-Rb+axFJ=yNn=AWneTtYjKMFzVeorKjQfTjc9Aw@mail.gmail.com>
Subject: Re: [PATCH v2] fs/fuse: fix potential memory leak from fuse_uring_cancel
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Jian Huang Li <ali@ddn.com>, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 2:57=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
> On 9/15/25 23:46, Bernd Schubert wrote:
> > On 9/15/25 23:23, Joanne Koong wrote:
> >> On Mon, Sep 15, 2025 at 1:15=E2=80=AFPM Bernd Schubert <bernd@bsbernd.=
com> wrote:
> >>>
> >>> Hi Joanne,
> >>>
> >>> thanks for looking into this.
> >>>
> >>> On 9/15/25 20:15, Joanne Koong wrote:
> >>>> On Thu, Sep 11, 2025 at 3:34=E2=80=AFAM Jian Huang Li <ali@ddn.com> =
wrote:
> >>>>>
> >>>>> This issue could be observed sometimes during libfuse xfstests, fro=
m
> >>>>> dmseg prints some like "kernel: WARNING: CPU: 4 PID: 0 at
> >>>>> fs/fuse/dev_uring.c:204 fuse_uring_destruct+0x1f5/0x200 [fuse]".
> >>>>>
> >>>>> The cause is, if when fuse daemon just submitted
> >>>>> FUSE_IO_URING_CMD_REGISTER SQEs, then umount or fuse daemon quits a=
t
> >>>>> this very early stage. After all uring queues stopped, might have o=
ne or
> >>>>> more unprocessed FUSE_IO_URING_CMD_REGISTER SQEs get processed then=
 some
> >>>>> new ring entities are created and added to ent_avail_queue, and
> >>>>> immediately fuse_uring_cancel moves them to ent_in_userspace after =
SQEs
> >>>>> get canceled. These ring entities will not be moved to ent_released=
, and
> >>>>> will stay in ent_in_userspace when fuse_uring_destruct is called, n=
eeded
> >>>>> be freed by the function.
> >>>>
> >>>> Hi Jian,
> >>>>
> >>>> Does it suffice to fix this race by tearing down the entries from th=
e
> >>>> available queue first before tearing down the entries in the userspa=
ce
> >>>> queue? eg something like
> >>>>
> >>>>  static void fuse_uring_teardown_entries(struct fuse_ring_queue *que=
ue)
> >>>>  {
> >>>> -       fuse_uring_stop_list_entries(&queue->ent_in_userspace, queue=
,
> >>>> -                                    FRRS_USERSPACE);
> >>>>         fuse_uring_stop_list_entries(&queue->ent_avail_queue, queue,
> >>>>                                      FRRS_AVAILABLE);
> >>>> +       fuse_uring_stop_list_entries(&queue->ent_in_userspace, queue=
,
> >>>> +                                    FRRS_USERSPACE);
> >>>>  }
> >>>>
> >>>> AFAICT, the race happens right now because when fuse_uring_cancel()
> >>>> moves the FRRS_AVAILABLE entries on the ent_avail_queue to the
> >>>> ent_in_userspace queue, fuse_uring_teardown_entries() may have alrea=
dy
> >>>> called fuse_uring_stop_list_entries() on the ent_in_userspace queue,
> >>>> thereby now missing the just-moved entries altogether, eg this logic=
al
> >>>> flow
> >>>>
> >>>> -> fuse_uring_stop_list_entries(&queue->ent_in_userspace, ...);
> >>>>     -> fuse_uring_cancel() moves entry from avail q to userspace q
> >>>> -> fuse_uring_stop_list_entries(&queue->ent_avail_queue, ...);
> >>>>
> >>>> If instead fuse_uring_teardown_entries() stops the available queue f=
irst, then
> >>>> -> fuse_uring_stop_list_entries(&queue->ent_avail_queue, ...);
> >>>>     -> fuse_uring_cancel()
> >>>> -> fuse_uring_stop_list_entries(&queue->ent_in_userspace, ...);
> >>>>
> >>>> seems fine now and fuse_uring_cancel() would basically be a no-op
> >>>> since ent->state is now FRRS_TEARDOWN.
> >>>>
> >>>
> >>> I'm not sure. Let's say we have
> >>>
> >>> task 1                                   task2
> >>> fuse_uring_cmd()
> >>>     fuse_uring_register()
> >>>          [slowness here]
> >>>                                         fuse_abort_conn()
> >>>                                           fuse_uring_teardown_entries=
()
> >>>          [slowness continue]
> >>>          fuse_uring_do_register()
> >>>             fuse_uring_prepare_cancel()
> >>>             fuse_uring_ent_avail()
> >>>
> >>>
> >>> I.e. fuse_uring_teardown_entries() might be called before
> >>> the command gets marked cancel-able and before it is
> >>> moved to the avail queue. I think we should extend the patch
> >>> and actually not set the ring to ready when fc->connected
> >>> is set to 0.
> >>>
> >>
> >> Hi Bernd,
> >>
> >> I think this is a separate race from the fuse_uring_cancel one.
> >> afaics, this race can happen even if the user doesn't call
> >> fuse_uring_cancel(). imo I think the cleanest solution to this
> >> registration vs teardown race is to check queue->stopped in
> >> fuse_uring_do_register() after we grab the queue spinlock, and if
> >> queue->stopped is true, then just clean up the entry ourselves with
> >> fuse_uring_entry_teardown()).
> >
> > What speaks against just doing as in the existing patch and freeing
> > the ent_in_userspace entries fuse_uring_destruct()?
> > IMO it covers both races, missing is just to avoid setting the ring
> > as ready.

Couldn't the entry in fuse_uring_do_register() be in the available
queue when we get to fuse_uring_destruct() which means the existing
patch would also have to iterate through the available queue too? eg
i'm imagining something like

fuse_uring_do_register()
   -> fuse_uring_prepare_cancel()
         *** fuse_uring_cancel() + teardown run on other threads
   -> fuse_uring_ent_avail()

imo, I think this scenario is its own separate race (between
registration and cancellation, that can happen irregardless of
teardown) that should be fixed by calling fuse_uring_prepare_cancel()
only after the fuse_uring_ent_avail() call, but I think this
underscores a bit that explicitly checking against torn down entries
is more robust when dealing with these races.

>
> Well, maybe cleaner, I don't have a strong opinion. We could skip the
> comment and explanation with your approach.

I don't really have a strong opinion on this either, just wanted to
share my thoughts. If you'd rather go with the existing patch, then we
should do that.

Thanks,
Joanne

>
>
> Thanks,
> Bernd

