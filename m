Return-Path: <linux-fsdevel+bounces-44232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143B8A66457
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 01:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10E617630B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 00:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1798D148857;
	Tue, 18 Mar 2025 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfE4Z+B2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B8014900F
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742259531; cv=none; b=jFTgNy/P+KdrbYbqcq7AlRWwZ22oivJdM2QZdpBV0s02OBengRt8L7ZTLdfYk5Vdfw/2v0lLCtkGi4ulg6rsVS452uK5He5YiXaua0qmX/BXVhZVoZu3R/99uGOlfcKN0DdUeD59LRB5xefApZhoANaVKMayFQ/ogqbYMPyajrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742259531; c=relaxed/simple;
	bh=JArG/FDKVIGg1WdApBI17kFY9NtdLhjfSUP4vEYwZgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zkb/yxeh0W824Z6Y1sUaRM3MO3/LmBWchYgNyzIjNaG+lczb1l8FsCsVSnHyNtphXJ/UsivDBrfpdF2Mxsd6fytpDaphtEl8307Uirh/EF78McvvAgHByaglKpKfc8quYExLrkUPaPD2Rd/nVMmigEjWM3jPgOFLwpogtLcJSwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfE4Z+B2; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476a1acf61eso38327541cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 17:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742259529; x=1742864329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNDHqFWFN2WCqWVf7Urwvc/Ca8TW/bBl0QNzkF/yjDI=;
        b=BfE4Z+B21GyazDc/galjnWnaLfvRmxaJiuwK58y4wi0SVbo2gAzt0EwUL1v+Vbb3XT
         iFPvedx1UgMxKK1pcuni53aSi1H56FgydFe0j9VG4C9su9U9evfL0pMMWl1u2cewsxY0
         ddcBhbIS150r90it1jBST1UcgwLVZnqr3rQ2e+0HeY1IwxDoeDOBqL/Bp+j1aXKj3/Wh
         kfi24n/MIk1ywDi72YlKMQpv4IyZTAch/D+keWwh8xQUgUtuU3L8r28FIhY4jY6q0M7x
         I8DafJd8fmtj708MgKkaYFZgFJOSrpPYD1a5mUgoj/rswQdxoDyxPb+rh8WZUYrV9XFw
         4CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742259529; x=1742864329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNDHqFWFN2WCqWVf7Urwvc/Ca8TW/bBl0QNzkF/yjDI=;
        b=dUzt1Zxmo7pjfertDMcb62eIf12T1eHDDcT+y3dq1E4hJT287phSChD4uGQ2TXikbQ
         hN4S1J0g3CERzjtgaKs6zh/rQmseu/OjfOIjIsVNPYHQVUM6y5mi+Kn/3SsQjppmSggk
         6CV1v03DErblfqt6+p9+KfKjYSZ02sCcNRjL7HpuF/3FXWf5XzCiaPUgx900dEJr0YPW
         yoQA3bijrK4sHERcqGusS3M8wA7o65p4PGfqK/N681YM7W2g8PIeJQ3RHm9Uenl+Gw/9
         XRqBILQvnIzRtwmuP5xa3wUCeMx6RnugDpGmEiKAUqMBrxp7xXxBslfzWc/7GxrGUY0q
         IqRw==
X-Forwarded-Encrypted: i=1; AJvYcCXujUhbzLUZtH0+o5PwX4wWKrImKPfro5InZa2kuVKcRvCNoLzk7sShZDl+AB219yvP2jUjf9wJ9xXHrxg8@vger.kernel.org
X-Gm-Message-State: AOJu0YybR51C8G3urjUtEYsBrI9jxJjw1skpIgtJO79ZUOSZV0W43tNm
	b0hCaGC4bmQkFOcXjPQ78YgstGGORGJVnd0IsvEvGqrXhs/R5kd9V1iV6IInbwJZNo3O/KTaTbd
	RoBNgO6UdHAQ2I04PWSJsy6XuZ3M=
X-Gm-Gg: ASbGncti4STx2kMgvJQDpaND3QkDPQAeT3om6IUjUq+yX3pWz4sHmRvgDSyQxOQn/q7
	kdmyToRy6mP/RtYGYsnhHcfL7FwoEgRMSjDbuiuoNbkpBZJ/O463/Kx7DLpcv6lb021+y4RxrPn
	a/AjUMrtNfEJDaPwYZQicf9IIx5ewdb3MCGLZECz86Bw==
X-Google-Smtp-Source: AGHT+IGsjiV4qMDwX9AMvN4mKX40Npc8sPjUxe3EYI4b5QsleMIOO/HVY+FhGdPfznDegBwaXym55nXtCC3PmD40Foo=
X-Received: by 2002:a05:622a:1f06:b0:476:b02d:2b4a with SMTP id
 d75a77b69052e-476fc9ad9e7mr35215261cf.27.1742259528707; Mon, 17 Mar 2025
 17:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203193022.2583830-1-joannelkoong@gmail.com>
 <CAJnrk1a9zdW2GfcEHmM=QMouMV8m_huUzZao+SsMgtK7Anx=BQ@mail.gmail.com> <bdb3980b-65e3-4bd5-aa5b-0a48d6d6e7a0@bsbernd.com>
In-Reply-To: <bdb3980b-65e3-4bd5-aa5b-0a48d6d6e7a0@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 17 Mar 2025 17:58:37 -0700
X-Gm-Features: AQ5f1JpghgpfcOTm8EQBoln4dR4A6b_vwjb50iwH7iqNt0L83Zv6ng9IeEY-PKw
Message-ID: <CAJnrk1ayas2dsGx_u6+xayvHh4FWRSU_EBek2K5PvUm+7t7kOQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: optimize over-io-uring request expiration check
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 3:16=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 2/3/25 20:37, Joanne Koong wrote:
> > On Mon, Feb 3, 2025 at 11:30=E2=80=AFAM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> >>
> >> Currently, when checking whether a request has timed out, we check
> >> fpq processing, but fuse-over-io-uring has one fpq per core and 256
> >> entries in the processing table. For systems where there are a
> >> large number of cores, this may be too much overhead.
> >>
> >> Instead of checking the fpq processing list, check ent_w_req_queue
> >> and ent_in_userspace.
> >>
> >> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >> ---
> >>  fs/fuse/dev.c        |  2 +-
> >>  fs/fuse/dev_uring.c  | 26 +++++++++++++++++++++-----
> >>  fs/fuse/fuse_dev_i.h |  1 -
> >>  3 files changed, 22 insertions(+), 7 deletions(-)
> >>
> >
> > v1: https://lore.kernel.org/linux-fsdevel/20250123235251.1139078-1-joan=
nelkoong@gmail.com/
> > Changes from v1 -> v2:
> > * Remove commit queue check, which should be fine since if the request
> > has expired while on this queue, it will be shortly processed anyways
> >
> >> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> >> index 3c03aac480a4..80a11ef4b69a 100644
> >> --- a/fs/fuse/dev.c
> >> +++ b/fs/fuse/dev.c
> >> @@ -45,7 +45,7 @@ bool fuse_request_expired(struct fuse_conn *fc, stru=
ct list_head *list)
> >>         return time_is_before_jiffies(req->create_time + fc->timeout.r=
eq_timeout);
> >>  }
> >>
> >> -bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_he=
ad *processing)
> >> +static bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct =
list_head *processing)
> >>  {
> >>         int i;
> >>
> >> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> >> index ab8c26042aa8..50f5b4e32ed5 100644
> >> --- a/fs/fuse/dev_uring.c
> >> +++ b/fs/fuse/dev_uring.c
> >> @@ -140,6 +140,21 @@ void fuse_uring_abort_end_requests(struct fuse_ri=
ng *ring)
> >>         }
> >>  }
> >>
> >> +static bool ent_list_request_expired(struct fuse_conn *fc, struct lis=
t_head *list)
> >> +{
> >> +       struct fuse_ring_ent *ent;
> >> +       struct fuse_req *req;
> >> +
> >> +       ent =3D list_first_entry_or_null(list, struct fuse_ring_ent, l=
ist);
> >> +       if (!ent)
> >> +               return false;
> >> +
> >> +       req =3D ent->fuse_req;
> >> +
> >> +       return time_is_before_jiffies(req->create_time +
> >> +                                     fc->timeout.req_timeout);
> >> +}
> >> +
> >>  bool fuse_uring_request_expired(struct fuse_conn *fc)
> >>  {
> >>         struct fuse_ring *ring =3D fc->ring;
> >> @@ -157,7 +172,8 @@ bool fuse_uring_request_expired(struct fuse_conn *=
fc)
> >>                 spin_lock(&queue->lock);
> >>                 if (fuse_request_expired(fc, &queue->fuse_req_queue) |=
|
> >>                     fuse_request_expired(fc, &queue->fuse_req_bg_queue=
) ||
> >> -                   fuse_fpq_processing_expired(fc, queue->fpq.process=
ing)) {
> >> +                   ent_list_request_expired(fc, &queue->ent_w_req_que=
ue) ||
> >> +                   ent_list_request_expired(fc, &queue->ent_in_usersp=
ace)) {
> >>                         spin_unlock(&queue->lock);
> >>                         return true;
> >>                 }
> >> @@ -495,7 +511,7 @@ static void fuse_uring_cancel(struct io_uring_cmd =
*cmd,
> >>         spin_lock(&queue->lock);
> >>         if (ent->state =3D=3D FRRS_AVAILABLE) {
> >>                 ent->state =3D FRRS_USERSPACE;
> >> -               list_move(&ent->list, &queue->ent_in_userspace);
> >> +               list_move_tail(&ent->list, &queue->ent_in_userspace);
> >>                 need_cmd_done =3D true;
> >>                 ent->cmd =3D NULL;
> >>         }
> >> @@ -715,7 +731,7 @@ static int fuse_uring_send_next_to_ring(struct fus=
e_ring_ent *ent,
> >>         cmd =3D ent->cmd;
> >>         ent->cmd =3D NULL;
> >>         ent->state =3D FRRS_USERSPACE;
> >> -       list_move(&ent->list, &queue->ent_in_userspace);
> >> +       list_move_tail(&ent->list, &queue->ent_in_userspace);
> >>         spin_unlock(&queue->lock);
> >>
> >>         io_uring_cmd_done(cmd, 0, 0, issue_flags);
> >> @@ -769,7 +785,7 @@ static void fuse_uring_add_req_to_ring_ent(struct =
fuse_ring_ent *ent,
> >>         spin_unlock(&fiq->lock);
> >>         ent->fuse_req =3D req;
> >>         ent->state =3D FRRS_FUSE_REQ;
> >> -       list_move(&ent->list, &queue->ent_w_req_queue);
> >> +       list_move_tail(&ent->list, &queue->ent_w_req_queue);
> >>         fuse_uring_add_to_pq(ent, req);
> >>  }
> >>
> >> @@ -1185,7 +1201,7 @@ static void fuse_uring_send(struct fuse_ring_ent=
 *ent, struct io_uring_cmd *cmd,
> >>
> >>         spin_lock(&queue->lock);
> >>         ent->state =3D FRRS_USERSPACE;
> >> -       list_move(&ent->list, &queue->ent_in_userspace);
> >> +       list_move_tail(&ent->list, &queue->ent_in_userspace);
> >>         ent->cmd =3D NULL;
> >>         spin_unlock(&queue->lock);
> >>
> >> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> >> index 3c4ae4d52b6f..19c29c6000a7 100644
> >> --- a/fs/fuse/fuse_dev_i.h
> >> +++ b/fs/fuse/fuse_dev_i.h
> >> @@ -63,7 +63,6 @@ void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
> >>  void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_re=
q *req);
> >>
> >>  bool fuse_request_expired(struct fuse_conn *fc, struct list_head *lis=
t);
> >> -bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_he=
ad *processing);
> >>
> >>  #endif
> >>
> >> --
> >> 2.43.5
> >>
> >
>
>
> Reviewed-by: Bernd Schubert <bernd@bsbernd.com>

Hi Miklos,

Is this patch acceptable to be merged into your tree?

Thanks,
Joanne

