Return-Path: <linux-fsdevel+bounces-40654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CECD4A263D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 20:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5374A162F27
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 19:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDAA1482F2;
	Mon,  3 Feb 2025 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrGSvDC4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49F625A656
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738611461; cv=none; b=gCsbA4pjRQMHwrqc03+x/BtEddjE+a2H35lxoixmV48cX3+ZhPpRP21RRkcxjbapPxdalv5t0IRE7L0W29qqoLsKZor8e0avIq2RRUf+cP5HwfPIUIcGqi9NasDibWSZL/YFSUQPVSlHb8Ppcbg1MeWDvm5rUjRUBjK2pKyPvSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738611461; c=relaxed/simple;
	bh=Vpr47+xBHCt/x2KPNrMA63LvW/oEMzOUnZJ+l5iZcV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipaQKAzWZNyffgZuCsRtuct4nTgjPwZ9NpIo1yS1SFyC9C6/zugqe0XYArWpe7lCbKbYUmusHEdoX/zX4td/08n4ojixlQVl/mtEqVJtVl+FXlzUtKiDI/M0PyJh9DxolQEoU9rO6sqk1h8hTpjwoMPjVSG9vRoejWUsgjLzUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrGSvDC4; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46c8474d8daso34692941cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 11:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738611458; x=1739216258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8OR/GkGdn+6H3Zu1muNrl0eC/I+F4edERCTUOXPbsE=;
        b=WrGSvDC4bHzX2s0hQYZS+6tITHq2CfnyDQ97CvPi9JWodvMikVESyHUjQ+M5ngX7KY
         xS00uWrn7FdcBRojrUHRfQv3BtQvRiQMUAYwJCklq0lpApY8iXHHZnBTs4wIWmMJrowP
         6rSRxh6pbAh5IoNxtGuWGRRz4Pa0AHM/gryRTmZDPUmZ73UQO0xL9eMcJbwn42caAt6o
         OhEPHFf5MHkGEpAXOkgKd5v4Z883CRyn1pFCzjBqCtqkE/qc1rajor0tzZDe/neXlb9A
         li7QcAbGlO8nnYMTBuAKd6KFWa+H8OMUsv1uq4/HMpBj0wRr73cC6F4hCpv+3I8byFZl
         aG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738611458; x=1739216258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8OR/GkGdn+6H3Zu1muNrl0eC/I+F4edERCTUOXPbsE=;
        b=kCLQ4E36UiV9ZVK69fgyF8uyPcbBZo02DpQktztvJmyxNU9u2Ns5IL35Nd8YFX23W2
         yVueMnAOZH9Z9IcFy55QBLHCb8BquLRb5ETxESSJp6jqc0xc+TzfqSgA3FYUj1Sakf+3
         7nBd1IYGtmjYqrv0hz/F+1gOrZyC1Lf+vpA/6QWLMbWshXh8NDqbRn6AwTOIzCqMzOQi
         40K7hXRmm589vlEjnREvwpGVcSJty4h7durX+eJdpVTGz2DVNu5PrKorL5oCi1888oDn
         ajlLCtEuLWFJp5nFj8DyodfM6t41TkpMX+F9w3qUej3UNOvF8ozQxSAARloYez4qH4wN
         /sWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjYndtdOkK0H5L/wQn48TIOCZcFRjSyEqFRpiqOSJWKctaik2PsjfFG8y/s/De0pTDD2p8HGb9N1dOn0Eg@vger.kernel.org
X-Gm-Message-State: AOJu0YwwZMcuUhrwXLPyGe4yUBIUOKywsPnQeP71o09mSHqXQjosYCL5
	watzAMI4sARyf0BJBsl5wD6l23T/i862uyEqDuOYzHq5fRwL47Y51ch9FpvqGVP/SlQE5hwpMNi
	4Z0KTfnQgognRi95nawx6wR4VnkQ=
X-Gm-Gg: ASbGncvu0h0OJRZk/PP6OMm19o6ODVer5LtLn2iAzuiPRg5KGdU+pdNkNSfglurxpUa
	yiyT625KfKbrwrgh27IgbJ6ORFh2txcTBMVtlzcKU7npUE5Iv+GcFwWPfyyLI3mtTjFlPUimWPI
	l2GJ25h1l8MLsQ
X-Google-Smtp-Source: AGHT+IE3FIqnfnVczP3gtCd8u1FCshp+PJUd34W3CZ2/REAggnhx6ycWRSQrp/f7tFKZAWIyWMah7CRZlu07nMQR/6U=
X-Received: by 2002:ac8:5802:0:b0:467:4b94:cfaf with SMTP id
 d75a77b69052e-46fd0b974bfmr271082851cf.51.1738611458438; Mon, 03 Feb 2025
 11:37:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203193022.2583830-1-joannelkoong@gmail.com>
In-Reply-To: <20250203193022.2583830-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 3 Feb 2025 11:37:27 -0800
X-Gm-Features: AWEUYZnku4zL-hm02Qd55W3QWLnBTq3YphbcgipUxIGcEYfJH2cDZqIsY72csB8
Message-ID: <CAJnrk1a9zdW2GfcEHmM=QMouMV8m_huUzZao+SsMgtK7Anx=BQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: optimize over-io-uring request expiration check
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 11:30=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Currently, when checking whether a request has timed out, we check
> fpq processing, but fuse-over-io-uring has one fpq per core and 256
> entries in the processing table. For systems where there are a
> large number of cores, this may be too much overhead.
>
> Instead of checking the fpq processing list, check ent_w_req_queue
> and ent_in_userspace.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c        |  2 +-
>  fs/fuse/dev_uring.c  | 26 +++++++++++++++++++++-----
>  fs/fuse/fuse_dev_i.h |  1 -
>  3 files changed, 22 insertions(+), 7 deletions(-)
>

v1: https://lore.kernel.org/linux-fsdevel/20250123235251.1139078-1-joannelk=
oong@gmail.com/
Changes from v1 -> v2:
* Remove commit queue check, which should be fine since if the request
has expired while on this queue, it will be shortly processed anyways

> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 3c03aac480a4..80a11ef4b69a 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -45,7 +45,7 @@ bool fuse_request_expired(struct fuse_conn *fc, struct =
list_head *list)
>         return time_is_before_jiffies(req->create_time + fc->timeout.req_=
timeout);
>  }
>
> -bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_head =
*processing)
> +static bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct lis=
t_head *processing)
>  {
>         int i;
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index ab8c26042aa8..50f5b4e32ed5 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -140,6 +140,21 @@ void fuse_uring_abort_end_requests(struct fuse_ring =
*ring)
>         }
>  }
>
> +static bool ent_list_request_expired(struct fuse_conn *fc, struct list_h=
ead *list)
> +{
> +       struct fuse_ring_ent *ent;
> +       struct fuse_req *req;
> +
> +       ent =3D list_first_entry_or_null(list, struct fuse_ring_ent, list=
);
> +       if (!ent)
> +               return false;
> +
> +       req =3D ent->fuse_req;
> +
> +       return time_is_before_jiffies(req->create_time +
> +                                     fc->timeout.req_timeout);
> +}
> +
>  bool fuse_uring_request_expired(struct fuse_conn *fc)
>  {
>         struct fuse_ring *ring =3D fc->ring;
> @@ -157,7 +172,8 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
>                 spin_lock(&queue->lock);
>                 if (fuse_request_expired(fc, &queue->fuse_req_queue) ||
>                     fuse_request_expired(fc, &queue->fuse_req_bg_queue) |=
|
> -                   fuse_fpq_processing_expired(fc, queue->fpq.processing=
)) {
> +                   ent_list_request_expired(fc, &queue->ent_w_req_queue)=
 ||
> +                   ent_list_request_expired(fc, &queue->ent_in_userspace=
)) {
>                         spin_unlock(&queue->lock);
>                         return true;
>                 }
> @@ -495,7 +511,7 @@ static void fuse_uring_cancel(struct io_uring_cmd *cm=
d,
>         spin_lock(&queue->lock);
>         if (ent->state =3D=3D FRRS_AVAILABLE) {
>                 ent->state =3D FRRS_USERSPACE;
> -               list_move(&ent->list, &queue->ent_in_userspace);
> +               list_move_tail(&ent->list, &queue->ent_in_userspace);
>                 need_cmd_done =3D true;
>                 ent->cmd =3D NULL;
>         }
> @@ -715,7 +731,7 @@ static int fuse_uring_send_next_to_ring(struct fuse_r=
ing_ent *ent,
>         cmd =3D ent->cmd;
>         ent->cmd =3D NULL;
>         ent->state =3D FRRS_USERSPACE;
> -       list_move(&ent->list, &queue->ent_in_userspace);
> +       list_move_tail(&ent->list, &queue->ent_in_userspace);
>         spin_unlock(&queue->lock);
>
>         io_uring_cmd_done(cmd, 0, 0, issue_flags);
> @@ -769,7 +785,7 @@ static void fuse_uring_add_req_to_ring_ent(struct fus=
e_ring_ent *ent,
>         spin_unlock(&fiq->lock);
>         ent->fuse_req =3D req;
>         ent->state =3D FRRS_FUSE_REQ;
> -       list_move(&ent->list, &queue->ent_w_req_queue);
> +       list_move_tail(&ent->list, &queue->ent_w_req_queue);
>         fuse_uring_add_to_pq(ent, req);
>  }
>
> @@ -1185,7 +1201,7 @@ static void fuse_uring_send(struct fuse_ring_ent *e=
nt, struct io_uring_cmd *cmd,
>
>         spin_lock(&queue->lock);
>         ent->state =3D FRRS_USERSPACE;
> -       list_move(&ent->list, &queue->ent_in_userspace);
> +       list_move_tail(&ent->list, &queue->ent_in_userspace);
>         ent->cmd =3D NULL;
>         spin_unlock(&queue->lock);
>
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index 3c4ae4d52b6f..19c29c6000a7 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -63,7 +63,6 @@ void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
>  void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *=
req);
>
>  bool fuse_request_expired(struct fuse_conn *fc, struct list_head *list);
> -bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_head =
*processing);
>
>  #endif
>
> --
> 2.43.5
>

