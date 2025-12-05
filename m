Return-Path: <linux-fsdevel+bounces-70742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF738CA5BF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 01:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BABE311BA12
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 00:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC8A1EFFB4;
	Fri,  5 Dec 2025 00:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkP6Mfo+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFEB19006B
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 00:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764894395; cv=none; b=Pp8chiYaXJT2KkWKDQYXtF1dBB/JClH3jGmXRcsDtnmqeLV7JsXO9o4B63fBv5iNY3lwQZ+5xzhqyhKdhMYTgGJTtb1594c0MRXs/b8QHBnsff+30Vy0dcloiQIOF8qJ65OCaP2qd/ALJHCnb1umzApOTeE2ZDX1xRGFSHP1x94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764894395; c=relaxed/simple;
	bh=WiIYP9y/tMJy5RszXug/7TOPOWKN8C/8TwqAYELzFkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpDgLqAoAHMV9hF4nh3zSmR+PnIjw5R8jmrYDZeXp1r7vsiVeKens1CthBxgar7zpyGxkr+qtfKZGsS7ql0ME6HsJlvRiC50UD+/if2dlwhWxaDaORNHPy9FCYIvPjwy4IfpmXoUIS0ohKdKl2jENU25G0s0CvfJo6JeyUy8gvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkP6Mfo+; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4edb7c8232aso19214851cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 16:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764894392; x=1765499192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBiu8bh2NMu9RquOd9C64Em1EyJ/vlaZUWpKiAuzn9c=;
        b=jkP6Mfo+aQltofcq8ct2rGuRXxHx5jiFbCFQEC28qZsHhlzywWZplcck+oqmaCzOie
         JkHlFkotewYpZ2gZMw2QyzqRmGj5Or0N4Q5sH06GwmgW9PlH6halxNROXphGjO6bml6Z
         XaedL75d9JcvqDwSWRfyGAbvph66oPXlbVU31+AF3ph88Vy03AGCGu47U0geBODQmv3S
         2t9Yzl2bu16VUSjx31c8hxSWD3tO1cjb89iSYLHUUJZkE5zJlhm4EjODfrhYNUyaEPol
         DLh/i4T44jfXx+ADilbxrDRKUNpqPf1aPDAaZdR7T44fY2iuqiBbBL6oGekroZ2Bthtg
         IMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764894392; x=1765499192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBiu8bh2NMu9RquOd9C64Em1EyJ/vlaZUWpKiAuzn9c=;
        b=n6Eotg/9l5F7ehNJdmnucRur1jP8QdXERzajV/5C9GqxPP72t8nMTX6dJFvAkfwg3X
         5fYo9vb6P5XYWz8cNum9ZYB9cGyBaQtkR4U+602CCxcJFCBZey22cmPbrsUJ55MZx/Vw
         C7c+aNyXjRjDfX4D4ZBgtJGNI/KtC79gkHDpUtmmNtXwFNDEk4dhITVpz1GbjZoyeBXp
         ODmmeT9XVlDl0mMeq0G/dUGxbzZZxpQhC8cNwV5cmFwl49tNzJlN5bPalhwKO3Jnd9mP
         L+1PwwNEjKlvyLWAplgR/FWdoygWwxrAu3afb8WnbSb+9PoHBL7fkqY5JG0lXxQNPVjW
         MKfA==
X-Forwarded-Encrypted: i=1; AJvYcCXsx2TAk3ncj08qWOL2Sq8sd/kdzKejLOGTy75Z51qXqGOVjVuBR/xaWHqVh8hEgnX/1J3dfMvzc4rY+ACk@vger.kernel.org
X-Gm-Message-State: AOJu0YxXxh6ZPKS9PnyfOAqYJwPZIYJWc63eS1T9K++2eXhUUpkB+fY8
	gEODRPjOPudt1ZvIf7QbAwvGorA6BNMV6iRYkNMKRyZKJxcWKrgSX4kg5uqAlcwXEe91RBvXill
	Rzt7YS/infgSyPcqvQjRudZDAtRVi/08=
X-Gm-Gg: ASbGncv/uFwhSy6ySs+PA+HB4XZjS9KI/M3MI6HiBEWZG1bku6Q6RlmeY7PiEI1PrHa
	Ss2S2g6GJJz8zgxex1rTafJUQ87Q7X9PLmbWHYnfIIIRusDATFQnXNpskrULYUv3ElcOGAQvUxT
	aw5pSDCLP+sEH+5bTPonpC60Ar6xb6P8sJ/kYmpDotmTOnNew/jihg4k2co0nDcHfb8V7uNJMTg
	8GXrFgC11SPcsPJB4eVEuFG1uyqWPJVUC/XZGfrKHrni7DDC4qjD2LSHPNsh2cU60qXNXl5v29h
	rC/jxGQqz1w=
X-Google-Smtp-Source: AGHT+IHPDETwvshawZzZfiRtZb+42gaUC+rid3WOgFdOIN1x5w69rRypHWzKOMCFQJhL6Ha/9uRApG/iHoZtvq0fyjI=
X-Received: by 2002:ac8:5812:0:b0:4ee:26ef:7f4c with SMTP id
 d75a77b69052e-4f01757c740mr116784221cf.17.1764894392494; Thu, 04 Dec 2025
 16:26:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20251204083010epcas5p2735e829064ff592b67e88c41fb1e44b3@epcas5p2.samsung.com>
 <20251204082536.17349-1-xiaobing.li@samsung.com>
In-Reply-To: <20251204082536.17349-1-xiaobing.li@samsung.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Dec 2025 16:26:21 -0800
X-Gm-Features: AWmQ_bleKty1Eunnw_O2YLaKlj-z6LQ2dskUv9qAJrhndmMIlG326iwvvudv2D0
Message-ID: <CAJnrk1ZH9wJmdXBKjRnFEPhyocwdX=v=7tsrFjfqN1+FZqRDeQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: add zero-copy to fuse-over-io_uring
To: Xiaobing Li <xiaobing.li@samsung.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, bschubert@ddn.com, asml.silence@gmail.com, 
	dw@davidwei.uk, josef@toxicpanda.com, kbusch@kernel.org, 
	peiwei.li@samsung.com, joshi.k@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 12:57=E2=80=AFAM Xiaobing Li <xiaobing.li@samsung.co=
m> wrote:
>
> Joanne has submitted a patch for adding a zero-copy solution.
>
> We have also done some research and testing before, and
> the test data shows improved performance. This patch is
> submitted for discussion.

Hi Xiaobing,

I think the logic in this patch uses fixed buffers for the request
payloads to reduce the per-I/O overhead of pinning/unpinning the user
pages for the payload but I don't think this helps with zero-copying,
as the pages still need to get copied from the registered buffer the
server provided back to the client's pages (or vice versa). In the
implementation in [1], the client's pages are registered into the
sparse buffer by the kernel such that the server reads/writes to those
client pages directly.

I think your patch is doing a similar thing to what the patch from
last month for registered buffers [2] did, except [2] also implemented
fixed buffers for the headers to eliminate that per-I/O overhead too.
However, when I thought about this design some more, I realized if we
used kernel-managed ring buffers instead, we pretty much get the same
wins on reducing I/O overhead but also can significantly reduce the
memory footprint used by each queue, by allowing the buffers to be
incrementally consumed and thus sharable across requests, as well as
allowing more flexibility in the future if we want to do things like
add multiple ring-pools for different categories of requests, etc.
Some more thoughts on this can be found on this thread here [3].

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20251203003526.2889477-1-joannelk=
oong@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20251027222808.2332692-9-joannelk=
oong@gmail.com/
[3] https://lore.kernel.org/linux-fsdevel/CAJnrk1bG7fAX8MfwJL_D2jzMNv5Rj9=
=3D1cgQvVpqC1=3DmGaeAwOg@mail.gmail.com/

>
> libfuse section:
> https://github.com/lreeze123/libfuse/tree/zero-copy
>
> Signed-off-by: Xiaobing Li <xiaobing.li@samsung.com>
> ---
>  fs/fuse/dev_uring.c   | 44 +++++++++++++++++++++++++++++++------------
>  fs/fuse/dev_uring_i.h |  4 ++++
>  2 files changed, 36 insertions(+), 12 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index f6b12aebb8bb..23790ae78853 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -584,15 +584,20 @@ static int fuse_uring_copy_from_ring(struct fuse_ri=
ng *ring,
>         int err;
>         struct fuse_uring_ent_in_out ring_in_out;
>
> -       err =3D copy_from_user(&ring_in_out, &ent->headers->ring_ent_in_o=
ut,
> -                            sizeof(ring_in_out));
> -       if (err)
> -               return -EFAULT;
> +       if (ent->zero_copy) {
> +               iter =3D ent->payload_iter;
> +               ring_in_out.payload_sz =3D ent->cmd->sqe->len;
> +       } else {
> +               err =3D copy_from_user(&ring_in_out, &ent->headers->ring_=
ent_in_out,
> +                                       sizeof(ring_in_out));
> +               if (err)
> +                       return -EFAULT;
>
> -       err =3D import_ubuf(ITER_SOURCE, ent->payload, ring->max_payload_=
sz,
> -                         &iter);
> -       if (err)
> -               return err;
> +               err =3D import_ubuf(ITER_SOURCE, ent->payload, ring->max_=
payload_sz,
> +                                &iter);
> +               if (err)
> +                       return err;
> +       }
>
>         fuse_copy_init(&cs, false, &iter);
>         cs.is_uring =3D true;
> @@ -618,10 +623,14 @@ static int fuse_uring_args_to_ring(struct fuse_ring=
 *ring, struct fuse_req *req,
>                 .commit_id =3D req->in.h.unique,
>         };
>
> -       err =3D import_ubuf(ITER_DEST, ent->payload, ring->max_payload_sz=
, &iter);
> -       if (err) {
> -               pr_info_ratelimited("fuse: Import of user buffer failed\n=
");
> -               return err;
> +       if (ent->zero_copy) {
> +               iter =3D ent->payload_iter;
> +       } else {
> +               err =3D import_ubuf(ITER_DEST, ent->payload, ring->max_pa=
yload_sz, &iter);
> +               if (err) {
> +                       pr_info_ratelimited("fuse: Import of user buffer =
failed\n");
> +                       return err;
> +               }
>         }
>
>         fuse_copy_init(&cs, true, &iter);
> @@ -1068,6 +1077,17 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cm=
d,
>         ent->headers =3D iov[0].iov_base;
>         ent->payload =3D iov[1].iov_base;
>
> +       if (READ_ONCE(cmd->sqe->uring_cmd_flags) & IORING_URING_CMD_FIXED=
) {
> +               ent->zero_copy =3D true;
> +               err =3D io_uring_cmd_import_fixed((u64)ent->payload, payl=
oad_size, ITER_DEST,
> +                                               &ent->payload_iter, cmd, =
0);
> +
> +               if (err) {
> +                       kfree(ent);
> +                       return ERR_PTR(err);
> +               }
> +       }
> +
>         atomic_inc(&ring->queue_refs);
>         return ent;
>  }
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 51a563922ce1..cb5de6e7a262 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -38,6 +38,10 @@ enum fuse_ring_req_state {
>
>  /** A fuse ring entry, part of the ring queue */
>  struct fuse_ring_ent {
> +       bool zero_copy;
> +
> +       struct iov_iter payload_iter;
> +
>         /* userspace buffer */
>         struct fuse_uring_req_header __user *headers;
>         void __user *payload;
> --
> 2.34.1
>

