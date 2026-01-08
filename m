Return-Path: <linux-fsdevel+bounces-72942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B95CD06323
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 22:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C0A030206A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 21:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70CC2FD7BC;
	Thu,  8 Jan 2026 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="I5sb3GdL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD67D2EC0B3
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767906257; cv=none; b=ndgrByG7jJK11rmde00H5UTR9ofQL8MwyxA7PXcGyYI95BVJGrC4RNz9YJBv6Bg2Hp1/tSnOOsTOVbIQo+pEtttZBYd+KTVaAAmoOKeaHoyj7jPhMVHIDTygjwrROGc98DbD9uj43vLBmK82Z5mkxpaZijF1gdtEm5hcZZd3R+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767906257; c=relaxed/simple;
	bh=acZK5DmF0NeSbzAhewFZ3ncsN9lr0DMWSErtNbIY9T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXTaTWMYpTZfSMKgo8/foTw/cfi9nMvJgq0VtMvZe762bYRxFJCRgfJAEB73tBnPSwUKYaXQkV/usuVFjtYQZBbByzpLr/BAEP65c8kSdlKmTPaI3GohQa3l0txSfqUSpEQ25vMgh9xET6+V9b48l0MWaKO3Gtgy4D+sb8jyo+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=I5sb3GdL; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b07583340dso226734eec.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 13:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767906255; x=1768511055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTpQOI7MZxoU8vqpYDbgH+zyca9FqZGoGorLmRF+c04=;
        b=I5sb3GdLAx/3bLVCcy8SfF/g37+OpR8yyKcsamZjt2M+Otaixr1wGWlMOz3TW2V5XF
         e4nVgDa0m3FHpIOr8qicBFJT2AIrDwBgEDRza+1Zw1aTY2S39AAdfEay3z5cZfFtvPfj
         5l11GLY1Ut4UZAyd3lZY34A4QsmOIDbDhdYT9JtVqAsG9oc5Gt+It6A0gp6eOMkNuW7n
         YmD3eCbpQHCoXlAz1y3iUYaNN50z3XmPdjBS67lnCzTjnmP+nvG9XERa5+Bugvh/uYAA
         qcPsUwUjhN5sAJu9sXxVakR0E6G2TqBy3aH4x0ECGaWuO5H/QVpxW5QhgQzRYEh6/2n3
         96Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767906255; x=1768511055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zTpQOI7MZxoU8vqpYDbgH+zyca9FqZGoGorLmRF+c04=;
        b=DaPq1/JxdRZ6NoUb/6qYBLHvyXhjN28MHeUaTRYWis2W7qpQsoS5bIwVkYS2H7Fpq6
         r5mLDrVTkCJ1JjxuEyYuojZoHDNDh5f3NGcterEdUFI20bo1Y9toGKadtZVvXaE28SME
         ygtu5CGIsBJOE0M9gXTt04WqvjStQOfSDYcpYrPW0Z9V2FvMZelx1AK3gkKGzFSQ0WGv
         AzCLWn2UPiGzzt8YIz5SgbwcsFZBO52KGdfQTqsZBv/1RmmVgHEYrXql1XqnovEhwukC
         6ncbnkHP7b8WYvEMNybAcqdvJTK0QNzN9naxSGrXJVk8VkeRb6EEALIznC7PahG8lPEJ
         0Wiw==
X-Forwarded-Encrypted: i=1; AJvYcCUpofSSNfmUdPxUv6jEYQs9GBVY/i8UaT3CCmLgaOYbOwoKjSfeV1uvW4WbyqTDkbwFAayL15gTyhfdyy9y@vger.kernel.org
X-Gm-Message-State: AOJu0Yxls+JU3feBz+8nhRr0e6qrvyxowRQ/fZ6wyeYPGrzP+sVtI4xz
	6PCOaP5KkHiE4OSopHtMJpD81G+20JS8vcPvMTO8N0vcQanTTxEnQPhVhR9Cp54zaORNFS7sTiJ
	XjcBzQ6HWEZszIlZlmmZbcw6KjzMtTTMwy89C5D3pD6eKtql9Q5FORCg=
X-Gm-Gg: AY/fxX5seHpsw0yBTRliYEt68l7daNXhlFdEMYtXLAZRaU3s5gUN6pwIejRP+3ptsdy
	pg/pQoRrz9XzAaEN0eg3WGQLjcgX5FoiB6sg8oCD28jpGuiy/MK8M8S0vIvh/JF24YatYGxEHbP
	41z3IRMRvXq53knPKkjXVf5SQtBGxS1OPwSUpBH2+hNprNzEjWiw2FZFkm2AoNIO2Bvcrr3d2xj
	TEP9XU70YVT9tivzUmD6eOl52B7mskgmoSbjdzjwvbTf2eUyM6rIA9wPeEUjzz9wO7NnDKc
X-Google-Smtp-Source: AGHT+IERHu4pmrNOPdpVMlvGcc709zFniBNdLo+P1sCtZgDhNBczFhutGr0T35PSzbPdHTeypp1NwqV3W9L519r7MGQ=
X-Received: by 2002:a05:7022:2211:b0:11e:3e9:3e89 with SMTP id
 a92af1059eb24-121f8ba1e7fmr3716615c88.7.1767906253312; Thu, 08 Jan 2026
 13:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223003522.3055912-1-joannelkoong@gmail.com> <20251223003522.3055912-22-joannelkoong@gmail.com>
In-Reply-To: <20251223003522.3055912-22-joannelkoong@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 8 Jan 2026 13:04:01 -0800
X-Gm-Features: AQt7F2qIJY_PHn2iJh-5sRirINnx2L2dcIFOQKrc3q0rI-rJ2jRamBToDOENG5M
Message-ID: <CADUfDZo56Bgv4PnKnE-nBbZ8WF1N-42RoBZ6DOXVRyqwksg2Xg@mail.gmail.com>
Subject: Re: [PATCH v3 21/25] io_uring/rsrc: split io_buffer_register_request()
 logic
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 4:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Split the main initialization logic in io_buffer_register_request() into
> a helper function.
>
> This is a preparatory patch for supporting kernel-populated buffers in
> fuse io-uring, which will be reusing this logic.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  io_uring/rsrc.c | 89 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 54 insertions(+), 35 deletions(-)
>
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index b25b418e5c11..5fe2695dafb6 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -936,67 +936,86 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx=
, void __user *arg,
>         return ret;
>  }
>
> -int io_buffer_register_request(struct io_uring_cmd *cmd, struct request =
*rq,
> -                              void (*release)(void *), unsigned int inde=
x,
> -                              unsigned int issue_flags)
> +static struct io_mapped_ubuf *io_kernel_buffer_init(struct io_ring_ctx *=
ctx,
> +                                                   unsigned int nr_bvecs=
,
> +                                                   unsigned int total_by=
tes,
> +                                                   u8 dir,
> +                                                   void (*release)(void =
*),
> +                                                   void *priv,
> +                                                   unsigned int index)
>  {
> -       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
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
> +               return ERR_PTR(-EINVAL);
>         index =3D array_index_nospec(index, data->nr);
>
> -       if (data->nodes[index]) {
> -               ret =3D -EBUSY;
> -               goto unlock;
> -       }
> +       if (data->nodes[index])
> +               return ERR_PTR(-EBUSY);
>
>         node =3D io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
> -       if (!node) {
> -               ret =3D -ENOMEM;
> -               goto unlock;
> -       }
> +       if (!node)
> +               return ERR_PTR(-ENOMEM);
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
> +               return ERR_PTR(-ENOMEM);
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
>
> +       node->buf =3D imu;
> +       data->nodes[index] =3D node;
> +
> +       return imu;
> +}
> +
> +int io_buffer_register_request(struct io_uring_cmd *cmd, struct request =
*rq,
> +                              void (*release)(void *), unsigned int inde=
x,
> +                              unsigned int issue_flags)
> +{
> +       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> +       struct req_iterator rq_iter;
> +       struct io_mapped_ubuf *imu;
> +       struct bio_vec bv;
> +       unsigned int nr_bvecs;
> +       unsigned int total_bytes;
> +
> +       /*
> +        * blk_rq_nr_phys_segments() may overestimate the number of bvecs
> +        * but avoids needing to iterate over the bvecs
> +        */
> +       nr_bvecs =3D blk_rq_nr_phys_segments(rq);
> +       total_bytes =3D blk_rq_bytes(rq);

Could combine these initializations with the variable declarations

> +
> +       io_ring_submit_lock(ctx, issue_flags);
> +
> +       imu =3D io_kernel_buffer_init(ctx, nr_bvecs, total_bytes, rq_data=
_dir(rq),
> +                                   release, rq, index);
> +       if (IS_ERR(imu)) {
> +               io_ring_submit_unlock(ctx, issue_flags);

I would prefer to leave the existing goto unlock; pattern. The goto
pattern is easier to extend in the future with additional resource
acquisitions. And keeping it would make the diff slightly smaller. For
new functions with a single early return path, I don't feel all that
strongly, but it seems like unnecessary refactoring of this existing
code.

Other than that,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> +               return PTR_ERR(imu);
> +       }
> +
> +       nr_bvecs =3D 0;
>         rq_for_each_bvec(bv, rq, rq_iter)
>                 imu->bvec[nr_bvecs++] =3D bv;
>         imu->nr_bvecs =3D nr_bvecs;
>
> -       node->buf =3D imu;
> -       data->nodes[index] =3D node;
> -unlock:
>         io_ring_submit_unlock(ctx, issue_flags);
> -       return ret;
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(io_buffer_register_request);
>
> --
> 2.47.3
>

