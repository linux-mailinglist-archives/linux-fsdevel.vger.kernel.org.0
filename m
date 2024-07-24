Return-Path: <linux-fsdevel+bounces-24208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7C193B597
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 19:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F4B1F220E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DAD15EFBF;
	Wed, 24 Jul 2024 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IplZgqFw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2A1C693
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840979; cv=none; b=JfriaOeCWVylCqhd/oNKBojIstKTXrfCwNAtN2CDzc90Q2bgfLzUPW21ikkwDd5wQ6vAux3YhQfIX7nMLDKDu/PxeQL1FP34cq4VeN0yncdEwuo4a4zRerCrEzl20TId/mk9X1/I06S/l3yF8QoXrf+LSWhaqCyCf2BiiX2h7iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840979; c=relaxed/simple;
	bh=IBU6pVTboCgRV4GjBQiAh75xPJs0Jco+qiWyjLHYrio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSYFA9ST/V7A68E2utriPT6NI0SD9XwwmBwtx+UuPCAEi7FEtMEqIr3iT/g6r2SNTyriI1Zrs80pTTltrGsNKd/fwoXFpUClf3uU72d1mcLgwrskWrpQWO7ECqOjtDBWfHFL587NG0kGGkJSy8PMskfgDz76u/BdHB255Y5znWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IplZgqFw; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so6188667276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 10:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721840976; x=1722445776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LG09yq42SwONWc+V2tSKX/RI5Aq+BQWZD5CuBUXZCg=;
        b=IplZgqFwQ7I8+1Le898SHWAZ86GZkmchFcqJC3QHhmIVg5naLU7KAlg911pr0FUM1+
         BwhgJYdRB8TMsxDusSykMfTYsmAMzPlYXnknwsTz7s2tgQngJyWqgjBqYTu7OQ1MBaQp
         S1htzPLOFgcqYV6HuZjAiC1vqXE4Njdzpsc/8Mej638z5RwTNJ/hYKM0tRBH85RAokSY
         irRm45p3UuCEB8tWxSIC5UAiq3dAng5sdIPOhoRL630aM0Ha8DTwT51z/1rRZdQhKiwm
         ZItXS9rERQc9zVWR6QEqaixb3qLqOckbtnMUH/1xQlvFcdNjoT9E9SR2gsaGte2nLgfQ
         jdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721840976; x=1722445776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LG09yq42SwONWc+V2tSKX/RI5Aq+BQWZD5CuBUXZCg=;
        b=ZDqxsVoOLLrH+vkeLEwLZ6A832Sk6adkW1xzdidcLQHTqYCSUqr1xbqljIGEiIg3qz
         eZm5uh7Yvmz7VWK/QP2DMUP8Vs0TbkFC2P2JWzp/RXoaH3lT9xb6FIEKk0OkXa/vSVed
         PCWJETzGCQ5K3cTcww7ncTwvkjE3A54my0i8fvG/gxUUoxPk/fYMcpy6m//9M9oOUOgL
         x0SDgChZB49wY4EEmgyw/GBnjRwEQkUvhJJpUYReXf7oSTXMqYi5m27+MASB6X0zVgGd
         sow/HBWF0LsfLOLOkKOh7PZ/pOT3D0Ve7SnjJ6POY/rQAxy9gRkOUFrbnNkIBFJNSvMs
         FTAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCTKP4poUqvNLGGQFXgmePwYSP55yDVKscJViHm1URhyJZWe1/sZh3q5g+lixZVhzUbtL/HkR8Gx/IzCiiRynl76EyN30BdTX6CXA4vg==
X-Gm-Message-State: AOJu0YxIapoz5xcH+hL4dIb2n4qIL9MNgwce2EkF4fiZ56jnSH+8pl01
	FaWglooBKaLr1QCmVOy7dBzCmP3AErHxFOWiwTn82ZYMbcCn1B2mX3cCv2CQlLxYyKKizCZM2os
	6YygJh4zS8CssG2tpRwrBz4Rs1Vv/sZLG
X-Google-Smtp-Source: AGHT+IFz8ASbDlY/uXjLkydvvwzffdD1X1M6z+s1NbMoMGkOJzeOz10OmOY4smWtwP21tPWbWeGTqo21bDcZpPR/8Hg=
X-Received: by 2002:a05:6902:27c8:b0:e05:fd7c:9cfa with SMTP id
 3f1490d57ef6-e0b22f4cce4mr178204276.11.1721840976470; Wed, 24 Jul 2024
 10:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724071156.97188-1-laoar.shao@gmail.com> <20240724071156.97188-3-laoar.shao@gmail.com>
In-Reply-To: <20240724071156.97188-3-laoar.shao@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 24 Jul 2024 10:09:25 -0700
Message-ID: <CAJnrk1a7pb3XoDWCAXV5131gbf_EzULtCaXKn-4-jnGaCrKxKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] fuse: Enhance each fuse connection with timeout support
To: Yafang Shao <laoar.shao@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 12:12=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> In our experience with fuse.hdfs, we encountered a challenge where, if th=
e
> HDFS server encounters an issue, the fuse.hdfs daemon=E2=80=94responsible=
 for
> sending requests to the HDFS server=E2=80=94can get stuck indefinitely.
> Consequently, access to the fuse.hdfs directory becomes unresponsive.
> The current workaround involves manually aborting the fuse connection,
> which is unreliable in automatically addressing the abnormal connection
> issue. To alleviate this pain point, we have implemented a timeout
> mechanism that automatically handles such abnormal cases, thereby
> streamlining the process and enhancing reliability.
>
> The timeout value is configurable by the user, allowing them to tailor it
> according to their specific workload requirements.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Hi Yafang,

There was a similar thread/conversation about timeouts started in this
link from last week
https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joannelkoong=
@gmail.com/#t

The core idea is the same but also handles cleanup for requests that
time out, to avoid memory leaks in cases where the server never
replies to the request. For v2, I am going to add timeouts for
background requests as well.


Thanks,
Joanne

> ---
>  fs/fuse/dev.c    | 57 +++++++++++++++++++++++++++++++++++++++++-------
>  fs/fuse/fuse_i.h |  2 ++
>  2 files changed, 51 insertions(+), 8 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 9eb191b5c4de..ff9c55bcfb3d 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -369,10 +369,27 @@ static void request_wait_answer(struct fuse_req *re=
q)
>
>         if (!fc->no_interrupt) {
>                 /* Any signal may interrupt this */
> -               err =3D wait_event_interruptible(req->waitq,
> -                                       test_bit(FR_FINISHED, &req->flags=
));
> -               if (!err)
> -                       return;
> +               if (!fc->timeout) {
> +                       err =3D wait_event_interruptible(req->waitq,
> +                                                      test_bit(FR_FINISH=
ED, &req->flags));
> +                       if (!err)
> +                               return;
> +               } else {
> +                       err =3D wait_event_interruptible_timeout(req->wai=
tq,
> +                                                              test_bit(F=
R_FINISHED, &req->flags),
> +                                                              (long)fc->=
timeout * HZ);
> +                       if (err > 0)
> +                               return;
> +
> +                       /* timeout */
> +                       if (!err) {
> +                               req->out.h.error =3D -EAGAIN;
> +                               set_bit(FR_TIMEOUT, &req->flags);
> +                               /* matches barrier in fuse_dev_do_write()=
 */
> +                               smp_mb__after_atomic();
> +                               return;
> +                       }
> +               }
>
>                 set_bit(FR_INTERRUPTED, &req->flags);
>                 /* matches barrier in fuse_dev_do_read() */
> @@ -383,10 +400,27 @@ static void request_wait_answer(struct fuse_req *re=
q)
>
>         if (!test_bit(FR_FORCE, &req->flags)) {
>                 /* Only fatal signals may interrupt this */
> -               err =3D wait_event_killable(req->waitq,
> -                                       test_bit(FR_FINISHED, &req->flags=
));
> -               if (!err)
> -                       return;
> +               if (!fc->timeout) {
> +                       err =3D wait_event_killable(req->waitq,
> +                                                 test_bit(FR_FINISHED, &=
req->flags));
> +                       if (!err)
> +                               return;
> +               } else {
> +                       err =3D wait_event_killable_timeout(req->waitq,
> +                                                         test_bit(FR_FIN=
ISHED, &req->flags),
> +                                                         (long)fc->timeo=
ut * HZ);
> +                       if (err > 0)
> +                               return;
> +
> +                       /* timeout */
> +                       if (!err) {
> +                               req->out.h.error =3D -EAGAIN;
> +                               set_bit(FR_TIMEOUT, &req->flags);
> +                               /* matches barrier in fuse_dev_do_write()=
 */
> +                               smp_mb__after_atomic();
> +                               return;
> +                       }
> +               }
>
>                 spin_lock(&fiq->lock);
>                 /* Request is not yet in userspace, bail out */
> @@ -1951,6 +1985,13 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *=
fud,
>                 goto copy_finish;
>         }
>
> +       /* matches barrier in request_wait_answer() */
> +       smp_mb__after_atomic();
> +       if (test_and_clear_bit(FR_TIMEOUT, &req->flags)) {
> +               spin_unlock(&fpq->lock);
> +               goto copy_finish;
> +       }
> +
>         /* Is it an interrupt reply ID? */
>         if (oh.unique & FUSE_INT_REQ_BIT) {
>                 __fuse_get_request(req);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 367601bf7285..c1467eb8c2e9 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -375,6 +375,7 @@ struct fuse_io_priv {
>   * FR_FINISHED:                request is finished
>   * FR_PRIVATE:         request is on private list
>   * FR_ASYNC:           request is asynchronous
> + * FR_TIMEOUT:         request is timeout
>   */
>  enum fuse_req_flag {
>         FR_ISREPLY,
> @@ -389,6 +390,7 @@ enum fuse_req_flag {
>         FR_FINISHED,
>         FR_PRIVATE,
>         FR_ASYNC,
> +       FR_TIMEOUT,
>  };
>
>  /**
> --
> 2.43.5
>
>

