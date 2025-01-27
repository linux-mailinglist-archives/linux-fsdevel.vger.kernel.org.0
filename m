Return-Path: <linux-fsdevel+bounces-40176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9346AA201DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69EB1886356
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FC11DE8AE;
	Mon, 27 Jan 2025 23:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzyyBiBX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9A1DE8A7
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021645; cv=none; b=CRE9F6NvJ10kqvCwMz18xP8Q8JPu5/na/DN/nB2sVUxoBtaPt8sMtXNE40WKkA4tL31tSjkvILH9hM0yzhVruyLDaRM3EDQCVN9kxPZ3kngKkiO9BicLHmtmHKEJajJO7NldoFxMKTfWSVT781b/a1u7L6g7gAgWCxIW9gS4KD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021645; c=relaxed/simple;
	bh=SBJ31GzooZ0H8KM7WtKxaOkq3Zck3oj40VwTZ/6b7vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBvb3BAYQkksgJopnfM+MbHClHqsDtCpjN7ozIlG9twHt2509ZQErLNc50pG7mmxgoFgYRFjy1+vex9jfPxk2hAvle65n23AFGRMleXRSzQ1KVUHzYSO/cGr8fsyWhawTaCdsreL9aizwVs0ahscBP7kBjnP5w+E8gRdgyG+8LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzyyBiBX; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46e28597955so42314971cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 15:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738021642; x=1738626442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n5/yL8Rky1ZRgNds0ckyibkjoB+8HuXhMPhCJUIXTE=;
        b=IzyyBiBXFZ4xQ+9FcTXbbCQFH2uJzH4rxQfnjT6MiUbH5waNhc+SDhdt3FbKsIoHds
         LvrhLnurUYuPXVssG7fIOsCr7KsA5aq8NZL8ULKb+Q8/GKneoWxAVL4472ynqF3oia4W
         vMxVdDR0wZq0vPs/pO64a1wDlzdQcZc1z+0GI+4BJidB+3+PIg1ODCq3zM+ha1FpdSCs
         jdK3q4shD+roPr11HXeEry7qYrjLhoMiMc07Qw/4Cbwr+fR0y/c5GH0awFLuCPiEe1p8
         xXX6g7JGMbE7xM+iTB/4TkrebbS8Rv0RhG6KlRZ56xtBHIdz+iDIWRC4KoZi2OUYvapS
         rakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738021642; x=1738626442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4n5/yL8Rky1ZRgNds0ckyibkjoB+8HuXhMPhCJUIXTE=;
        b=PS19/7m2kN0lFO3L99oIjx6AqhiA2jiZj3QGBEi/jMkpl68MVNsNbMkwJsyrY5FTfj
         vmGy2GpGL42z421JFYosHCZZgBqfeRQiwr5QNugIY1H7asz4i1mQtMvDN693tDXX96lG
         dILXy9fjurkogKdgbgo2CENU3plI0Dl065dlfZysK7VH3AtIQ5RWqKLQmkRCj69xH6mc
         enN4T4WGNatuW1V3vD+ZzKOG/gEeNMEIxH4E/OQZBnsWyGopXRevb/IaCNXdXGUuGWOW
         9em/pFt46WFOGW4/YbE1m1WgIrEo5I7n50wdY4z15wJSteDfkGAtAgAwV0qn06ncxN+7
         OZDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUksSP3Oc+q6fHZWA4dWzYZArLBUN+9AWr5ityVn6YEzM+Eh0hrFr7z0ztM7/3QOKwLQlCUSEOZzDu1EUPW@vger.kernel.org
X-Gm-Message-State: AOJu0YwlVavwAotzERyhCEuAISK/uApOgXLdH4t+J/eFsnwUgx5JgjDk
	jcTe5AWPTfaLOUDosixF7aOuYfS8wrugdEKsDpYOVRLAD+gu49P25t9re9X02m/6uYn9zL93kad
	AiepSOFeY9PYQjAVWkqkMiuuOFMMLEJsl
X-Gm-Gg: ASbGncsaYHqq0eqomnYLnN97YtM5kAVX6GKQR4loflvzAZRZsTz4jKTxKdSg2HaYmJS
	Pv9Mh9jRGaRO2iPn3X0hsDWs4PI4O3i9VsQzotGd7U6qx2nw5FgbrdbOt5ymNWk2e53eEVSk6a5
	FNbg==
X-Google-Smtp-Source: AGHT+IG/GLg4iUlptZhARSACzUvqdLDbQi+ZRb+g2SJHE6+PWfXSgCArStV9MHwOWMR5z+1dlLnOV5iaqtJMiJKzyS0=
X-Received: by 2002:a05:622a:201:b0:467:5ea8:83df with SMTP id
 d75a77b69052e-46e12a9a0a9mr571192751cf.30.1738021642312; Mon, 27 Jan 2025
 15:47:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125-optimize-fuse-uring-req-timeouts-v2-0-7771a2300343@ddn.com>
 <20250125-optimize-fuse-uring-req-timeouts-v2-5-7771a2300343@ddn.com>
In-Reply-To: <20250125-optimize-fuse-uring-req-timeouts-v2-5-7771a2300343@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 27 Jan 2025 15:47:11 -0800
X-Gm-Features: AWEUYZkO9nZfHiPZvK6yH9O9bmAqr9GbTQQqNkqNg3Q9oB6t0yXOCAd3AX1xgu4
Message-ID: <CAJnrk1byUjpcWmdw--xjmm3THD2dxUtc6zwf6G_aCvMQDqWBWQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] fuse: use locked req consistently in fuse_uring_next_fuse_req()
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Pavel Begunkov <asml.silence@gmail.com>, 
	Luis Henriques <luis@igalia.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 9:44=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> This changes fuse_uring_next_fuse_req() and subfunctions
> to use req obtained with a lock to avoid possible issues by
> compiler induced re-ordering.
>
> Also fix a function comment, that was missed during previous
> code refactoring.
>
> Fixes: a4bdb3d786c0 ("fuse: enable fuse-over-io-uring")
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/dev_uring.c | 32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 80bb7396a8410022bbef1efa0522974bda77c81a..e90dd4ae5b2133e427855f1b0=
e60b73f008f7bc9 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -75,16 +75,15 @@ static void fuse_uring_flush_bg(struct fuse_ring_queu=
e *queue)
>         }
>  }
>
> -static void fuse_uring_req_end(struct fuse_ring_ent *ent, int error)
> +static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_re=
q *req,
> +                              int error)
>  {
>         struct fuse_ring_queue *queue =3D ent->queue;
> -       struct fuse_req *req;
>         struct fuse_ring *ring =3D queue->ring;
>         struct fuse_conn *fc =3D ring->fc;
>
>         lockdep_assert_not_held(&queue->lock);
>         spin_lock(&queue->lock);

Maybe also worth adding a WARN here to ensure that ent->fuse_req =3D=3D req

> -       req =3D ent->fuse_req;
>         ent->fuse_req =3D NULL;
>         if (test_bit(FR_BACKGROUND, &req->flags)) {
>                 queue->active_background--;
> @@ -684,7 +683,7 @@ static int fuse_uring_prepare_send(struct fuse_ring_e=
nt *ent,
>         if (!err)
>                 set_bit(FR_SENT, &req->flags);
>         else
> -               fuse_uring_req_end(ent, err);
> +               fuse_uring_req_end(ent, req, err);
>
>         return err;
>  }
> @@ -768,12 +767,8 @@ static void fuse_uring_add_req_to_ring_ent(struct fu=
se_ring_ent *ent,
>         fuse_uring_add_to_pq(ent, req);
>  }
>
> -/*
> - * Release the ring entry and fetch the next fuse request if available
> - *
> - * @return true if a new request has been fetched
> - */
> -static bool fuse_uring_ent_assign_req(struct fuse_ring_ent *ent)
> +/* Fetch the next fuse request if available */
> +static struct fuse_req *fuse_uring_ent_assign_req(struct fuse_ring_ent *=
ent)
>         __must_hold(&queue->lock)
>  {
>         struct fuse_req *req;
> @@ -784,12 +779,10 @@ static bool fuse_uring_ent_assign_req(struct fuse_r=
ing_ent *ent)
>
>         /* get and assign the next entry while it is still holding the lo=
ck */
>         req =3D list_first_entry_or_null(req_queue, struct fuse_req, list=
);
> -       if (req) {
> +       if (req)
>                 fuse_uring_add_req_to_ring_ent(ent, req);
> -               return true;
> -       }
>
> -       return false;
> +       return req;
>  }
>
>  /*
> @@ -819,7 +812,7 @@ static void fuse_uring_commit(struct fuse_ring_ent *e=
nt, struct fuse_req *req,
>
>         err =3D fuse_uring_copy_from_ring(ring, req, ent);
>  out:
> -       fuse_uring_req_end(ent, err);
> +       fuse_uring_req_end(ent, req, err);
>  }
>
>  /*
> @@ -830,17 +823,16 @@ static void fuse_uring_next_fuse_req(struct fuse_ri=
ng_ent *ent,
>                                      unsigned int issue_flags)
>  {
>         int err;
> -       bool has_next;
> +       struct fuse_req *req;
>
>  retry:
>         spin_lock(&queue->lock);
>         fuse_uring_ent_avail(ent, queue);
> -       has_next =3D fuse_uring_ent_assign_req(ent);
> +       req =3D fuse_uring_ent_assign_req(ent);
>         spin_unlock(&queue->lock);
>
> -       if (has_next) {
> -               err =3D fuse_uring_send_next_to_ring(ent, ent->fuse_req,
> -                                                  issue_flags);
> +       if (req) {
> +               err =3D fuse_uring_send_next_to_ring(ent, req, issue_flag=
s);
>                 if (err)
>                         goto retry;
>         }
>
> --
> 2.43.0
>

