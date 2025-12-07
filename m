Return-Path: <linux-fsdevel+bounces-70951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3210ECAB2CA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 07 Dec 2025 09:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AC543064BF0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Dec 2025 08:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944F22D8384;
	Sun,  7 Dec 2025 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LzHQ7Um2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8104023B62B
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Dec 2025 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765096923; cv=none; b=F5ZPBJr/5i2pCxSfRaS/nPYc53a4qHbBGvWA6h3ClqmEoQi/y8IDI6ra1acFfdOFo75zOmsg+j/nE12gY03tXUwCsCItzQIwO6YmsJtUrP3OFe3bQXrS1XwQ9Qri1q1aJx66fIRc05NJnmX/7CCkKXWSAj2ErCu2jllxcWP3Ed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765096923; c=relaxed/simple;
	bh=nyjQTVztnCKCqsMmkboPdKWXhwfOytC4RFrkR02i/PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQ8R49CX7WvB0OlKOJuH66au2+2p4uiF6Ip5Peh6+QXcjK6UGefVaQI8CoIi8J+rLPFCR3lGEwlFnimKXL6IBu4dugCv0hCWm4dWHTgezcYmr7/Y+8d4IsscWRqaKZkcQSqJzBF6fMW8MpfcbdA1o4RPgb2Y+sngSLPu3XLZdrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LzHQ7Um2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297ea4c2933so3992585ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Dec 2025 00:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765096921; x=1765701721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbawJtjeKUAThYNAyCmR+VaFQ5nO7wvqMlXy88jbeK8=;
        b=LzHQ7Um2wAmS0USNc/ekvhSxlAr7oV0RFXKAMshkJ6lgtAN623hdWHNCRJ83cfsctY
         ngs5MnnNLsNvE5dGpiSKdXn7qktPK7howm0QwWkyiEYg2Xie0PmHcPWHy8VsVWrf0FGU
         iiUVj0LBHCTuJyguT+Mkdtn/q/0bhV9WymgNc3Wi9T7LYISBTM8jdgj6dh4j1oL2NDmB
         E4hORlcNKQPlixvtpNkLnjgA++7fxKHu3KNQo9zuDPGeggnF/N4zDyV/iLqTva0KxkD1
         rv/N9adey4SXkURwOZcQFlwKpnE3ZGZg4fSMU9BYrsfx9Fol+LNtyyGIPMvLykDZ7lLW
         kHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765096921; x=1765701721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mbawJtjeKUAThYNAyCmR+VaFQ5nO7wvqMlXy88jbeK8=;
        b=wee6mGQ/JbkYJl96Lta2WfZhUTO8JzPvG5oiJp6xkjAk8ZltKcR5vdut04Hljyu/hP
         BY5DXVZ25o44hDi4hY83cq/WWliNN1UMaHpsnfvhVmfPFNBIJk25iFMiUOqUr0uCwekd
         jQonX5OFqe6FUIoUxnQ8Gw0OPFLoFcUIrJudOf8rLe8RBu8MuDJtyTVNW1HdCTjey8D5
         e0S8DX2pzwsy/PIQc4/6PTmH/QG7zYFG4N4riFVhcv5TEDSSPKMgTMaa/In+x99wY8nV
         0WKDDAGEx3WUB8D5wa47jcEcUanntGpramNyZMVkBs2/3kLeoEc7IlykBuzHkGq3QPFd
         S/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrHJEf0koWp+f78lLSzOuyYU7pCV9rIEemVJW/SDY0N63U1DpW9KjsKw/AdbVoBi7PwEgDMduTkWerZRrd@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7JbOEj5ywHWectLfYOvI9miSfZEYSqWKWkHGvMWhX/XQxLMEf
	B/Wk9GOQyDeEqGsLkobf2QCf19DuRXu3oUUH/9RbxB1UI2KKzuMPKGrfIYww4VGv2b4vhFOccIO
	6niV/siZKoD8/ykze8vJrM99JqzFzJ+hi8yCHVn0mSw==
X-Gm-Gg: ASbGnct3f8GZz4MM16+D7nJSZnUgjwaCn5TBPPk9MPQ+pBNsokgfcTOPsmfjZaptUrN
	Dhel40DCi6tnDP97hsCs2wNETvFnJzl7QDRoXf+9sPDUalRqNz9kPH+Aw3gHck2o/46JCGLXDhN
	f72xrjdrjfdO4qf+gCFAEi4Ncc7RthgQrWIRBGSLx39Dy8+ZYynn8tNVTTAw3735G3snq4W6pDn
	zevLVWsGtWVdMnU7Ff3EI5ue9SAbo1Imaq9EkROO7YRxvPPeqvSqtrjSwG45CplDpYY2882
X-Google-Smtp-Source: AGHT+IExUZKMgZJbR4tzF8ByNnUCjWOlvdw0Y2sl2NZpc+lesdMUrezV+UzYb+S7SHDmUPFPJ5RTFFMQEHhN5nAqnJM=
X-Received: by 2002:a05:7022:2584:b0:11d:faef:21c2 with SMTP id
 a92af1059eb24-11e03166671mr2113710c88.2.1765096920544; Sun, 07 Dec 2025
 00:42:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203003526.2889477-1-joannelkoong@gmail.com> <20251203003526.2889477-24-joannelkoong@gmail.com>
In-Reply-To: <20251203003526.2889477-24-joannelkoong@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sun, 7 Dec 2025 00:41:49 -0800
X-Gm-Features: AQt7F2oFJjC1bFKtQGQ2ScWDF8BKHA3OIbCE-hyMJGdHIEwesO7CEjmdBlMGefc
Message-ID: <CADUfDZp9u8D8shxK1BQ=O4cMWeE7w4wrvfY7Xdr0=_vAEgvJZQ@mail.gmail.com>
Subject: Re: [PATCH v1 23/30] io_uring/rsrc: split io_buffer_register_request()
 logic
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 4:37=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> Split the main initialization logic in io_buffer_register_request() into
> a helper function.
>
> This is a preparatory patch for supporting kernel-populated buffers in
> fuse io-uring, which will be reusing this logic.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  io_uring/rsrc.c | 80 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 48 insertions(+), 32 deletions(-)
>
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index 59cafe63d187..18abba6f6b86 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -941,63 +941,79 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx=
, void __user *arg,
>         return ret;
>  }
>
> -int io_buffer_register_request(struct io_ring_ctx *ctx, struct request *=
rq,
> -                              void (*release)(void *), unsigned int inde=
x,
> -                              unsigned int issue_flags)
> +static int io_buffer_init(struct io_ring_ctx *ctx, unsigned int nr_bvecs=
,

Consider adding "kernel" somewhere in the name to distinguish this
from the userspace registered buffer initialization

> +                         unsigned int total_bytes, u8 dir,
> +                         void (*release)(void *), void *priv,
> +                         unsigned int index)
>  {
>         struct io_rsrc_data *data =3D &ctx->buf_table;
> -       struct req_iterator rq_iter;
>         struct io_mapped_ubuf *imu;
>         struct io_rsrc_node *node;
> -       struct bio_vec bv;
> -       unsigned int nr_bvecs =3D 0;
> -       int ret =3D 0;
>
> -       io_ring_submit_lock(ctx, issue_flags);
> -       if (index >=3D data->nr) {
> -               ret =3D -EINVAL;
> -               goto unlock;
> -       }
> +       if (index >=3D data->nr)
> +               return -EINVAL;
>         index =3D array_index_nospec(index, data->nr);
>
> -       if (data->nodes[index]) {
> -               ret =3D -EBUSY;
> -               goto unlock;
> -       }
> +       if (data->nodes[index])
> +               return -EBUSY;
>
>         node =3D io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
> -       if (!node) {
> -               ret =3D -ENOMEM;
> -               goto unlock;
> -       }
> +       if (!node)
> +               return -ENOMEM;
>
> -       /*
> -        * blk_rq_nr_phys_segments() may overestimate the number of bvecs
> -        * but avoids needing to iterate over the bvecs
> -        */
> -       imu =3D io_alloc_imu(ctx, blk_rq_nr_phys_segments(rq));
> +       imu =3D io_alloc_imu(ctx, nr_bvecs);
>         if (!imu) {
>                 kfree(node);
> -               ret =3D -ENOMEM;
> -               goto unlock;
> +               return -ENOMEM;
>         }
>
>         imu->ubuf =3D 0;
> -       imu->len =3D blk_rq_bytes(rq);
> +       imu->len =3D total_bytes;
>         imu->acct_pages =3D 0;
>         imu->folio_shift =3D PAGE_SHIFT;
> +       imu->nr_bvecs =3D nr_bvecs;
>         refcount_set(&imu->refs, 1);
>         imu->release =3D release;
> -       imu->priv =3D rq;
> +       imu->priv =3D priv;
>         imu->is_kbuf =3D true;
> -       imu->dir =3D 1 << rq_data_dir(rq);
> +       imu->dir =3D 1 << dir;
> +
> +       node->buf =3D imu;
> +       data->nodes[index] =3D node;
> +
> +       return 0;
> +}
> +
> +int io_buffer_register_request(struct io_ring_ctx *ctx, struct request *=
rq,
> +                              void (*release)(void *), unsigned int inde=
x,
> +                              unsigned int issue_flags)
> +{
> +       struct req_iterator rq_iter;
> +       struct io_mapped_ubuf *imu;
> +       struct bio_vec bv;
> +       unsigned int nr_bvecs;
> +       unsigned int total_bytes;
> +       int ret;
> +
> +       io_ring_submit_lock(ctx, issue_flags);
> +
> +       /*
> +        * blk_rq_nr_phys_segments() may overestimate the number of bvecs
> +        * but avoids needing to iterate over the bvecs
> +        */
> +       nr_bvecs =3D blk_rq_nr_phys_segments(rq);
> +       total_bytes =3D blk_rq_bytes(rq);

These could be initialized before io_ring_submit_lock()

> +       ret =3D io_buffer_init(ctx, nr_bvecs, total_bytes, rq_data_dir(rq=
), release, rq,
> +                            index);
> +       if (ret)
> +               goto unlock;
>
> +       imu =3D ctx->buf_table.nodes[index]->buf;

It would be nice to avoid all these additional dereferences. Could
io_buffer_init() return the struct io_mapped_ubuf *, using ERR_PTR()
to return any error code?

Best,
Caleb

> +       nr_bvecs =3D 0;
>         rq_for_each_bvec(bv, rq, rq_iter)
>                 imu->bvec[nr_bvecs++] =3D bv;
>         imu->nr_bvecs =3D nr_bvecs;
>
> -       node->buf =3D imu;
> -       data->nodes[index] =3D node;
>  unlock:
>         io_ring_submit_unlock(ctx, issue_flags);
>         return ret;
> --
> 2.47.3
>

