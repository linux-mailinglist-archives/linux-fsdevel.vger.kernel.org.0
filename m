Return-Path: <linux-fsdevel+bounces-40182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C83A20207
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 01:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3D31882F53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175553207;
	Tue, 28 Jan 2025 00:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtFM7PXa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6329366
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738022479; cv=none; b=gGRUynB4gDxQYZuiSRvpQQLkqg/G3JYpnCc/DJS6y0aruyMruRa17W9naqGe1Bt0qbFVptWcBC4gtBzxRWXhshC98THKuxq+K6b3oZJ6zTUOgPBGewbozI1ChnKJspT+o1OP4Pa2rotgwD8vUMNnr5VjStL2iOFigH3lmLGTPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738022479; c=relaxed/simple;
	bh=h261GhpL6tc+z0Tu4ZcGolB8H2xDqbzmce19+HnVTMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dSlppkyNRbmziZFFT1mNZ7Bk28y0XtiLCoAV83AbIPUofFDiqckcZDkmrxa5cdYhKeALKCSwvf3dK+4tbuJF5r7iDMwzX0hAZvrWXUjxh7cN8atcaNIvEsc60gAQiXpTe10AIkVxr4FGXc0+3bhWdeZtgqBq76Olh1DUlVPyhJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtFM7PXa; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46783d44db0so46701181cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 16:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738022474; x=1738627274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5AL1mcWFrIz6MWWKs2fpSSNMb4QPvMixZpg5ZRQUXg=;
        b=KtFM7PXaQuOK6oosFWRaw48g9tMdAlZRRWTgMri5EGOGv+NKRLL7dg+zUdkRPljMGX
         NnDlemqqQAs65Wyn1w4GQYbXbTgD0w9FL1daxAilQ29t4Om5iP3nUEeOZkW92Xi3VlxG
         DR5dAjL6/3z8Y25yvPJlA3XBE256KQSpgWd4r9ZJZwpdLOBu+QIl8yT8qtJ1mCbtqhdw
         mcgwZsbvna+nnWItNkn/NT+6vlvyDujwVflDM4Kac01FcjoNWP+v+77fsQuFbxQkQMJk
         LKPbnI3fsB6DtfXytczMXzS+Sks3gjmNXzssimPmRkvLV5pjjcmngxm1yNYJXC2jgPN2
         33wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738022474; x=1738627274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5AL1mcWFrIz6MWWKs2fpSSNMb4QPvMixZpg5ZRQUXg=;
        b=ubqKNKwkegMnPNsZdSZ+IctH52YXqSLYF8NmfMqtuQAJ4AS1oEtQ1bTakwUyTT5yjF
         T2sy/5lbZ4Fq/bNUFHW3JmujtoltMOLUU7il5/oHh4wx+fgdu3EVMhDc27A27dFyvk12
         ZsHg6fOfMohP/cLXxHH81uf8vIUqdS5csJZcLLsOb2GqfZWg9VhKiQFBfPPTcmc0CHHq
         St0zMvS+BhAEhI2MOgwDcTFUadjJrL+eBYeChk0aXritEdz4EYT/pY9c8RB20SAaX+b6
         DE+xXXpmYDx2eE56IWPhvF9PXAS1h8Fjf4buFob7dwmN8R4khT53mrW4mZzu9TbWGn3S
         GtUA==
X-Forwarded-Encrypted: i=1; AJvYcCXUjGJ7+5RVqG3Ij1TnBAMWEE2J5UOudYDMzBdwmmpJtq5cN1xeMY9A115+Ew9PA2c/E+OCsJ2y4xrf9qog@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpnr2m9kTaBnblpF95xUckNEjl1bSaRBTVLPX+JCeK1iN6K7dA
	Y5pu/hLp37YlXaET+8g8qslGADShiQ5R9SEnoCYZedT2APiyHf/0GNwhh5SQpwvrkH0KSkLmidt
	JVyXB892VwXw0vUp98hoMjk2rbjiQw3x4
X-Gm-Gg: ASbGncssEB3onqvwrT/iWM6L3GbcXqaIQ0hwtmcycu/nJl8OlgDszEj00k/bwtGnxXK
	+AYhSX+RR+vJihbVqyj5NY99ENtLLBgGLlRx82abRoxckkFOuCUorZItaE4RissZlI7x3LQfo7O
	QVhQ==
X-Google-Smtp-Source: AGHT+IGvwzgL/nxjiQ5QiOlO8Um0BKgv/SW0FAko/zo/a8jBeIwAT4bMrRjs3FTIkVbcPDPP3fLG9IrWP9Qz7snkbdM=
X-Received: by 2002:a05:622a:1a91:b0:467:5ad8:a042 with SMTP id
 d75a77b69052e-46e12a9afffmr620399241cf.26.1738022474535; Mon, 27 Jan 2025
 16:01:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
 <20250125-optimize-fuse-uring-req-timeouts-v2-6-7771a2300343@ddn.com>
In-Reply-To: <20250125-optimize-fuse-uring-req-timeouts-v2-6-7771a2300343@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 27 Jan 2025 16:01:03 -0800
X-Gm-Features: AWEUYZm-uCvA6IF0wYPxbVpzsTD9Vf4F1DbFFhdgaPK6Jrl_Xjgt7r0JpmVm1kg
Message-ID: <CAJnrk1bG8ZUw+4CeEZdnj3mt9oz1i57WjEx-3q4oWuiqE9-DqQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] fuse: Access entries with queue lock in fuse_uring_entry_teardown
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Pavel Begunkov <asml.silence@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 9:44=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> This ensures that ent->cmd and ent->fuse_req are accessed in
> fuse_uring_entry_teardown while holding the queue lock.
>
> Fixes: a4bdb3d786c0 ("fuse: enable fuse-over-io-uring")
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/dev_uring.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index e90dd4ae5b2133e427855f1b0e60b73f008f7bc9..9af5314f63d54cb1158e9372f=
4472759f5151ac3 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -298,13 +298,8 @@ static struct fuse_ring_queue *fuse_uring_create_que=
ue(struct fuse_ring *ring,
>         return queue;
>  }
>
> -static void fuse_uring_stop_fuse_req_end(struct fuse_ring_ent *ent)
> +static void fuse_uring_stop_fuse_req_end(struct fuse_req *req)
>  {
> -       struct fuse_req *req =3D ent->fuse_req;
> -
> -       /* remove entry from fuse_pqueue->processing */
> -       list_del_init(&req->list);
> -       ent->fuse_req =3D NULL;
>         clear_bit(FR_SENT, &req->flags);
>         req->out.h.error =3D -ECONNABORTED;
>         fuse_request_end(req);
> @@ -315,14 +310,20 @@ static void fuse_uring_stop_fuse_req_end(struct fus=
e_ring_ent *ent)
>   */
>  static void fuse_uring_entry_teardown(struct fuse_ring_ent *ent)
>  {
> -       struct fuse_ring_queue *queue =3D ent->queue;
> -       if (ent->cmd) {
> -               io_uring_cmd_done(ent->cmd, -ENOTCONN, 0, IO_URING_F_UNLO=
CKED);
> -               ent->cmd =3D NULL;
> -       }
> +       struct fuse_req *req;
> +       struct io_uring_cmd *cmd;
>
> -       if (ent->fuse_req)
> -               fuse_uring_stop_fuse_req_end(ent);
> +       struct fuse_ring_queue *queue =3D ent->queue;
> +
> +       spin_lock(&queue->lock);
> +       cmd =3D ent->cmd;
> +       ent->cmd =3D NULL;
> +       req =3D ent->fuse_req;
> +       ent->fuse_req =3D NULL;
> +       if (req) {
> +               /* remove entry from queue->fpq->processing */
> +               list_del_init(&req->list);
> +       }
>
>         /*
>          * The entry must not be freed immediately, due to access of dire=
ct
> @@ -330,10 +331,15 @@ static void fuse_uring_entry_teardown(struct fuse_r=
ing_ent *ent)
>          * of race between daemon termination (which triggers IO_URING_F_=
CANCEL
>          * and accesses entries without checking the list state first
>          */
> -       spin_lock(&queue->lock);
>         list_move(&ent->list, &queue->ent_released);
>         ent->state =3D FRRS_RELEASED;
>         spin_unlock(&queue->lock);
> +
> +       if (cmd)
> +               io_uring_cmd_done(cmd, -ENOTCONN, 0, IO_URING_F_UNLOCKED)=
;
> +
> +       if (req)
> +               fuse_uring_stop_fuse_req_end(req);
>  }
>
>  static void fuse_uring_stop_list_entries(struct list_head *head,
>
> --
> 2.43.0
>

