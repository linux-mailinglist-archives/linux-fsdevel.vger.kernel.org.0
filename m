Return-Path: <linux-fsdevel+bounces-54106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA65AFB4C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 15:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEA51668B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 13:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E9029B220;
	Mon,  7 Jul 2025 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAwxzTh1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2631A1E22FC;
	Mon,  7 Jul 2025 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895374; cv=none; b=fCUSl2eZeOBInNaQiL/r8j9liHyMUu3ykyEbuwSyul/IdBsg91OtbEo6ZNLbIc8KEyAY4m3B/0FiLAFudxNFVnVINz3+H8Z4hsOQcX4bO+TazE473hrxJF5fzAPPvJ+JHm5VLf9kJCQ+1rCRthbJh8YuZzzMDSqKLpS2uSZR5ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895374; c=relaxed/simple;
	bh=O377eaO+Jlj86ZSB2RpCzQcB8R9z4Xe0q5jCGof+Qtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rR6TrOD5QMBG62B5+w0TVDPhVdiakKBs3YgR+xwbQ6RUkMi32dkTOJhYdNWMXE+jg9BL6F/cY+lW67tFcYNDnf7R4VUaZstpOskNzFjmrXVcIiODv9IR7J3FNZUyzH6YX2sNlePwdVg3IKP3y1unKf630tDNF1IF10yQyw8o188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAwxzTh1; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso6028987a12.1;
        Mon, 07 Jul 2025 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751895371; x=1752500171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B67QLvyHZDkG3dCW4xDkICWa2oqhwCHUYXHYCu0rbCU=;
        b=EAwxzTh1Xn7XfEbAzHaOZtxe9G1IpVeZvi/qJGpYaHjmG7h4w9qeNeUrFt4RW/g7+y
         KNkq1WceyAM2kjZL4evwjw70CnG9GQNyUBM7GW1/U+ukrzDC5DXKwFkVna/JssTmZnT9
         zLeyoxE2XQxI3ACksvdGowUIskhdPol+hZenepBHd0Q6DMhBh3pQeGWQcBtvzRTWmYsk
         67aU5xrRf7wqHLS9An70b+7ALQRHFFzgWyBxNsIb9J4QzC13mLgoyTbIz6UgUzQXloip
         ZSNcjYRHgN8zA26kSF/kVZXTjD5WCSx074ihrjPMxog9WcrWKZiGA54g+VKQF7aA8sxJ
         3EEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751895371; x=1752500171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B67QLvyHZDkG3dCW4xDkICWa2oqhwCHUYXHYCu0rbCU=;
        b=Cml52tiOyH5yAr09JQR11baxE6QAz7aoZ+ywlCkgIX2s2S4XITCxbGI21rI8/amapB
         1zhcyQoQ5ZS7G3z1ZG6BmFKPQJfqMke5F7loj6TUgx94zZlO9FMM+tk7Xh+XCERLZZRa
         NP/nG1Wnz6MbFY2uICmSrKS2Rj352BlBCArcfj1ypaaL1fgLgaaLiWjfMy7gssdYKNvk
         GL+n5fW9Vi8hUOgUZZwWNBiJE+bqHLoVM0j3qIbwwyDPA/Us1xKBkuf2389JJm/mtbtC
         TuB7glrPnzQxnHyV5jhlsEzXN/E+eEhQGHhn50X+/PdAVX9vtSwD+2PJBZI14tojq+RC
         7bfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwgvkFOPhZodGrA61+zlqxfvn4+Gnu59SlaYVMxtUO884W8JJ2DdD6xBk2tcskKwlTiECGkEXu+S4NOqRu@vger.kernel.org, AJvYcCXdejgPR5oCjdsJnUjv+Dxdzz2tny9LuO3EmJPcSt22zdk/dM6ykXszD6Tcc6njS7sxIC4N84T2FHRYcvq/@vger.kernel.org
X-Gm-Message-State: AOJu0YzhI4KK0P442SJE2/vfaMLIB7DyhTh6CIslMlzcNEKzCX4vlinD
	8l/yGPh5PYiv5WP5A0T+XHG9n2SRhcQClzn5w1GEIGE4oBxUi6DJthOV5rw5IzduLZWGs8s108+
	cYXY1RFS5hRU+JFAFgBa6OK5YFiO3+2fKg6Fv
X-Gm-Gg: ASbGnct4LP3g6lGUc+abrHbA3xBPkCzmerH0BQ+7ivn69fkqAxyZdzFY+VQ1TEDb+UH
	5slBbarU6ik8tTOCY3+qAUws/xKUR59wOYcFUCczI+K8vykXv1rsQLww0l8QcUzIf+aCyr6N3o/
	B2ITnCLwfX303Ff9SucKMfSGpGxedcflcfvkahj+4Lq7VGpFUA4/2J1mDzR7mxyqbzkawhZBIPo
	Hb5x8JzJk97
X-Google-Smtp-Source: AGHT+IE3xKDRxiceWfgDhOqdfWXtjxPAUKmvoHmxd7No4ahz6Uels53hHP1g6tE+28lVM037geC6nzs3mFbTA+YYN6U=
X-Received: by 2002:a05:6402:280d:b0:607:19a6:9f1d with SMTP id
 4fb4d7f45d1cf-60ff388d517mr7405843a12.14.1751895371254; Mon, 07 Jul 2025
 06:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703064738.2631-1-lirongqing@baidu.com>
In-Reply-To: <20250703064738.2631-1-lirongqing@baidu.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 7 Jul 2025 09:35:58 -0400
X-Gm-Features: Ac12FXwqf0z-MDIQB81h2vm6zchf-sItAwZG0CkAA6vlslCY0d5FQLuB129JRRE
Message-ID: <CAJSP0QUcOr=1SZiMSaFXP=kh5RpAYjduy6D73QEQu9JnV1ua+Q@mail.gmail.com>
Subject: Re: [PATCH] virtio_fs: fix the hash table using in virtio_fs_enqueue_req()
To: lirongqing <lirongqing@baidu.com>
Cc: vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu, 
	eperezma@redhat.com, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fushuai Wang <wangfushuai@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 2:48=E2=80=AFAM lirongqing <lirongqing@baidu.com> wr=
ote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> The original commit be2ff42c5d6e ("fuse: Use hash table to link
> processing request") converted fuse_pqueue->processing to a hash table,
> but virtio_fs_enqueue_req() was not updated to use it correctly.
> So use fuse_pqueue->processing as a hash table, this make the code
> more coherent
>
> Co-developed-by: Fushuai Wang <wangfushuai@baidu.com>
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  fs/fuse/dev.c       | 1 +
>  fs/fuse/virtio_fs.c | 6 ++++--
>  2 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index e80cd8f..4659bc8 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -322,6 +322,7 @@ unsigned int fuse_req_hash(u64 unique)
>  {
>         return hash_long(unique & ~FUSE_INT_REQ_BIT, FUSE_PQ_HASH_BITS);
>  }
> +EXPORT_SYMBOL_GPL(fuse_req_hash);
>
>  /*
>   * A new request is available, wake fiq->waitq
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index b8a99d3..d050470 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -21,6 +21,7 @@
>  #include <linux/cleanup.h>
>  #include <linux/uio.h>
>  #include "fuse_i.h"
> +#include "fuse_dev_i.h"
>
>  /* Used to help calculate the FUSE connection's max_pages limit for a re=
quest's
>   * size. Parts of the struct fuse_req are sliced into scattergather list=
s in
> @@ -1382,7 +1383,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_v=
q *fsvq,
>         unsigned int out_sgs =3D 0;
>         unsigned int in_sgs =3D 0;
>         unsigned int total_sgs;
> -       unsigned int i;
> +       unsigned int i, hash;
>         int ret;
>         bool notify;
>         struct fuse_pqueue *fpq;
> @@ -1442,8 +1443,9 @@ static int virtio_fs_enqueue_req(struct virtio_fs_v=
q *fsvq,
>
>         /* Request successfully sent. */
>         fpq =3D &fsvq->fud->pq;
> +       hash =3D fuse_req_hash(req->in.h.unique);
>         spin_lock(&fpq->lock);
> -       list_add_tail(&req->list, fpq->processing);
> +       list_add_tail(&req->list, &fpq->processing[hash]);
>         spin_unlock(&fpq->lock);
>         set_bit(FR_SENT, &req->flags);
>         /* matches barrier in request_wait_answer() */
> --
> 2.9.4
>
>

