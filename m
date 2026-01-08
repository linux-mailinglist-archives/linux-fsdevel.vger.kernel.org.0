Return-Path: <linux-fsdevel+bounces-72925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2841D05B5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 20:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 697723033656
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 19:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925A62FFF8E;
	Thu,  8 Jan 2026 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="JS4XXrRX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D12B2882B7
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767898961; cv=pass; b=q+Kr/jGnsedA2sk90lukN6AsPR5ZSV/S0gh09LxLr/eLLjCVdpNiRVbVgxnBkszz3gMSyfOvlqz8DOc0ZXXxq/+o4mnyTaQL0Iq/rvdOA5msdEzaKeAhPKI0Id4KacIPj/7ttGRZP0i9JuBk1PwYuHdr9pLMeKQWJpNolDFXPx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767898961; c=relaxed/simple;
	bh=uTnlkJcTXfbxmoeXZPMMV0ilZuDMNeE7cbSS3em9Bms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eC4lDfb0bjArZrwXAauM/2kcQnOAU/Xa3BgY2GtFecweGS67fhuA6INJaFYd0PIJYQzh0Pxv5xahlSpNwqesK4aWLU+vM4kzfzvr+AagnVwRuBzI0/uENRTmNsdZrzoSEA3xerU4ohQxxj41qG/2fnEcX76iu+S75zoM58oZ3aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=JS4XXrRX; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b04a1f495fso77330eec.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 11:02:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767898959; cv=none;
        d=google.com; s=arc-20240605;
        b=LMdtr6cF+guL1vTRfeqVuYH3vuv+zD9emCwe7f/dmSDjtHobgv1Kc/Idjd7RnxibTV
         tLERPsdT98oAB8gYHSfBQvEUIyQoTz2TtqVI0lYvYYW/nltQ8FTrRzsRb2kkL/WzLDMB
         LXVC7wjG+w5C6fnw1l9zh/LqkR5hY/rVxdtiTxlCQPArUbGNQD6imUYJtFLYk4GHZIND
         nZfNUkBAy52G9apokrhsVx6pkqRfBHCqkRwaJB8GHWC77GUND/xlrEXxazW3PRcOhm+9
         RmcVcnU8km15cUlM8ji+FBFwbJnBnP3PrjJJrqN1TdGJQd0cHLXYRJ40Kf6oZghsq+Fs
         PPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7IyVFd6dArUXwo/V61zioGhyNew1+apjCmiH8MfjSwg=;
        fh=4sDBybGjKkaZ+7VYxi7aAX936tzurNObnlbZdchbG7E=;
        b=gQ0ehLRtB2nW6mefDaaclnAVQ3YeRmRk1J1o9R9vYZlUOvwOTvW6NxEo2/JolgYCxP
         lcu8idpCitoxmXPTScySKfU7zSBvfsXeLXyDKCNgBhetykZY2shu6jg1PQi/6vbCVOmB
         p0JmbpULVdgC2Jv9FFZKe9wF4ccJEwjJmdrVsookisyxyG/F/L4thejYXYNwJw2VvAwf
         ot2BG1L97obrcXcoVU1OlPCGloYnLBcjapNUqiKHT0NB0OvEoryjj1YaIBd5OHZTXjzQ
         DXoSF+0dWsjk+zeylQNcXgiJjY3VYHd4JFjoTQRab16bdY2xKk9Di+uK9DFTzX5A5JIB
         vqPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767898959; x=1768503759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IyVFd6dArUXwo/V61zioGhyNew1+apjCmiH8MfjSwg=;
        b=JS4XXrRXr9Ac0NEKAhCAEyfOIqG9qdE6E4C4ZU8ir7tV6CaMx1XX6Ve2lwNX+fVyjv
         xPjlHQ8fpsFbvcJzgy2xIOWyTaRfHFiYnbS1YbawNvie2O/yillbJuUKfVzcIQz5gWfb
         QGlk4FV00jFc64E+rPEZbqgy6lg6RCR/IEe5kgILD7pH5Yrgezb7L1qVLzyT6On2uH6S
         BQaghjswuXFmK1hvYj6D/jgVIRSM9E9LUpUPAtcb5cUQSyjVW/4043x0z7bx520KrhZq
         oyQnNKHKbkFVPSlutsbKVfNQ2qmJTy7jApTeb6ijbEUsHz3dmIisL82Ey97nAmA9Oayq
         aKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767898959; x=1768503759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7IyVFd6dArUXwo/V61zioGhyNew1+apjCmiH8MfjSwg=;
        b=bgWFx6dR1wLSBDAEF6srufKp9s1gIyicW/JnVCRI1D5jTbVHCiieRb+K/uHJCR7c5a
         JDwOHwz2i1D0ulb9vbR1ALH45ITUq+p2esXPySnKCX+7MnBAqoK3l69vcB2bcySrPGTz
         yu3/McHp6MduXfVA2KeYSeC+Ww/mDRL3DY3KgVqSw0yYc/NQ00vMlRDiBwZB2iWTlOEX
         BxLiNgh2bZW1Q+uKtRIk8z3nfxUlxaEhbw1xkhjfh7H3inWMKlgiSX1PT78PoE+B4Gv9
         KDk5J10dR0hfAPPYnnZ72IXjNSIYMwmvzDqPRMU1r1nqYMjMN1ULbX3DH72INfcUELmx
         PMhg==
X-Forwarded-Encrypted: i=1; AJvYcCUP+cLs6oBoQ50tP8ZBFq7lYMpZACmrc/+pT3lKWka6ct6SXoaMxC1B2Mio+zL06br7TmpF1xuOTYzMJFUj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dIZfEJgoDDgufvipoRPpEIze8z/gc+HsO+Wrl3Rlg3RUZ3YD
	55GBNFbD9o0SWq/pGXvCFh549H4E2uhbaOKuqs0DVRi0rNRpXLB4FKg4h8VmCryAptXHNlSwe1O
	l2ud/9TVmn+tmMKUJWTICleJiWMjwKusVcOVLUhvD9w==
X-Gm-Gg: AY/fxX6f+EIlcGgWYPDfN7nXc1cJLj55diENasVnPT2dzjib025xZj+ocwQl6grBDKT
	+qYZgAANdmDJGRqVtXfk63p4Jidt6EYQwGWjYCcxaNaaNmWXaogvP/BlP6Xff14u1f6POdpNIac
	25Fg9fxNhFQfWXrvv0KHl9qMRI6Fqb+rPGRXAwSxReG2bPhu40tC4vax716acfeyF3ltLF1UNld
	9nO8YTyeNjIEfIXidovMKqF1wv6AnOBrW5PyJ3Pmy78xBfR65D31hqbHrNgZSwwXwkn37+8
X-Google-Smtp-Source: AGHT+IFi0zwOLqLd5/lph2wRASewlLfwejDQ39CW9qrkROJvcezR3Nocd3ITIblcrMsqrPYLJtoXFpAt4MfZkawIgMY=
X-Received: by 2002:a05:7022:b9e:b0:122:8d:39d8 with SMTP id
 a92af1059eb24-122008d3f76mr1267185c88.6.1767898958376; Thu, 08 Jan 2026
 11:02:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223003522.3055912-1-joannelkoong@gmail.com> <20251223003522.3055912-9-joannelkoong@gmail.com>
In-Reply-To: <20251223003522.3055912-9-joannelkoong@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 8 Jan 2026 11:02:26 -0800
X-Gm-Features: AQt7F2oEuvySb3d5I4mYqr14hwu_6_mSCZqy4snetF24vEzcoCm0AkgZQrSQoJA
Message-ID: <CADUfDZpdNNYdNnrPWviGYPViQ6O_S4S0hB7Hg56+wnQDgnXwAQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/25] io_uring: add io_uring_cmd_fixed_index_get() and io_uring_cmd_fixed_index_put()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 4:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Add two new helpers, io_uring_cmd_fixed_index_get() and
> io_uring_cmd_fixed_index_put(). io_uring_cmd_fixed_index_get()
> constructs an iter for a fixed buffer at a given index and acquires a
> refcount on the underlying node. io_uring_cmd_fixed_index_put()
> decrements this refcount. The caller is responsible for ensuring
> io_uring_cmd_fixed_index_put() is properly called for releasing the
> refcount after it is done using the iter it obtained through
> io_uring_cmd_fixed_index_get().
>
> This is a preparatory patch needed for fuse-over-io-uring support, as
> the metadata for fuse requests will be stored at the last index, which
> will be different from the buf index set on the sqe.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/io_uring/cmd.h | 20 +++++++++++
>  io_uring/rsrc.c              | 65 ++++++++++++++++++++++++++++++++++++
>  io_uring/rsrc.h              |  5 +++
>  io_uring/uring_cmd.c         | 21 ++++++++++++
>  4 files changed, 111 insertions(+)
>
> diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> index 7169a2a9a744..2988592e045c 100644
> --- a/include/linux/io_uring/cmd.h
> +++ b/include/linux/io_uring/cmd.h
> @@ -44,6 +44,12 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cmd =
*ioucmd,
>                                   size_t uvec_segs,
>                                   int ddir, struct iov_iter *iter,
>                                   unsigned issue_flags);
> +int io_uring_cmd_fixed_index_get(struct io_uring_cmd *ioucmd, u16 buf_in=
dex,
> +                                unsigned int off, size_t len, int ddir,
> +                                struct iov_iter *iter,
> +                                unsigned int issue_flags);
> +int io_uring_cmd_fixed_index_put(struct io_uring_cmd *ioucmd, u16 buf_in=
dex,
> +                                unsigned int issue_flags);
>
>  /*
>   * Completes the request, i.e. posts an io_uring CQE and deallocates @io=
ucmd
> @@ -109,6 +115,20 @@ static inline int io_uring_cmd_import_fixed_vec(stru=
ct io_uring_cmd *ioucmd,
>  {
>         return -EOPNOTSUPP;
>  }
> +static inline int io_uring_cmd_fixed_index_get(struct io_uring_cmd *iouc=
md,
> +                                              u16 buf_index, unsigned in=
t off,
> +                                              size_t len, int ddir,
> +                                              struct iov_iter *iter,
> +                                              unsigned int issue_flags)
> +{
> +       return -EOPNOTSUPP;
> +}
> +static inline int io_uring_cmd_fixed_index_put(struct io_uring_cmd *iouc=
md,
> +                                              u16 buf_index,
> +                                              unsigned int issue_flags)
> +{
> +       return -EOPNOTSUPP;
> +}
>  static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 ret=
,
>                 u64 ret2, unsigned issue_flags, bool is_cqe32)
>  {
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index a63474b331bf..a141aaeb099d 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -1151,6 +1151,71 @@ int io_import_reg_buf(struct io_kiocb *req, struct=
 iov_iter *iter,
>         return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
>  }
>
> +int io_reg_buf_index_get(struct io_kiocb *req, struct iov_iter *iter,
> +                        u16 buf_index, unsigned int off, size_t len,
> +                        int ddir, unsigned issue_flags)
> +{
> +       struct io_ring_ctx *ctx =3D req->ctx;
> +       struct io_rsrc_node *node;
> +       struct io_mapped_ubuf *imu;
> +       u64 addr;
> +       int err;
> +
> +       io_ring_submit_lock(ctx, issue_flags);
> +
> +       node =3D io_rsrc_node_lookup(&ctx->buf_table, buf_index);
> +       if (!node) {
> +               io_ring_submit_unlock(ctx, issue_flags);
> +               return -EINVAL;
> +       }
> +
> +       node->refs++;
> +
> +       io_ring_submit_unlock(ctx, issue_flags);
> +
> +       imu =3D node->buf;
> +       if (!imu) {
> +               err =3D -EFAULT;
> +               goto error;
> +       }
> +
> +       if (check_add_overflow(imu->ubuf, off, &addr)) {
> +               err =3D -EINVAL;
> +               goto error;
> +       }
> +
> +       err =3D io_import_fixed(ddir, iter, imu, addr, len);
> +       if (err)
> +               goto error;
> +
> +       return 0;
> +
> +error:
> +       io_reg_buf_index_put(req, buf_index, issue_flags);
> +       return err;
> +}
> +
> +int io_reg_buf_index_put(struct io_kiocb *req, u16 buf_index,
> +                        unsigned issue_flags)
> +{
> +       struct io_ring_ctx *ctx =3D req->ctx;
> +       struct io_rsrc_node *node;
> +
> +       io_ring_submit_lock(ctx, issue_flags);
> +
> +       node =3D io_rsrc_node_lookup(&ctx->buf_table, buf_index);

Hmm, I don't think it's safe to assume this node looked up by
buf_index matches the one obtained in io_reg_buf_index_get(). Since
the uring_lock is released between io_reg_buf_index_get() and
io_reg_buf_index_put(), an intervening IORING_REGISTER_BUFFERS_UPDATE
operation may modify the node at buf_index in the buf_table. That
could result in a reference decrement on the wrong node, resulting in
the new node being freed while still in use.
Can we return the struct io_rsrc_node * from io_reg_buf_index_get()
and pass it to io_reg_buf_index_put() in place of buf_index?

Thanks,
Caleb

> +       if (WARN_ON_ONCE(!node)) {
> +               io_ring_submit_unlock(ctx, issue_flags);
> +               return -EFAULT;
> +       }
> +
> +       io_put_rsrc_node(ctx, node);
> +
> +       io_ring_submit_unlock(ctx, issue_flags);
> +
> +       return 0;
> +}
> +
>  /* Lock two rings at once. The rings must be different! */
>  static void lock_two_rings(struct io_ring_ctx *ctx1, struct io_ring_ctx =
*ctx2)
>  {
> diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
> index d603f6a47f5e..16f4bab9582b 100644
> --- a/io_uring/rsrc.h
> +++ b/io_uring/rsrc.h
> @@ -64,6 +64,11 @@ struct io_rsrc_node *io_find_buf_node(struct io_kiocb =
*req,
>  int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
>                         u64 buf_addr, size_t len, int ddir,
>                         unsigned issue_flags);
> +int io_reg_buf_index_get(struct io_kiocb *req, struct iov_iter *iter,
> +                        u16 buf_index, unsigned int off, size_t len,
> +                        int ddir, unsigned issue_flags);
> +int io_reg_buf_index_put(struct io_kiocb *req, u16 buf_index,
> +                        unsigned issue_flags);
>  int io_import_reg_vec(int ddir, struct iov_iter *iter,
>                         struct io_kiocb *req, struct iou_vec *vec,
>                         unsigned nr_iovs, unsigned issue_flags);
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index b6b675010bfd..ee95d1102505 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -314,6 +314,27 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cm=
d *ioucmd,
>  }
>  EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed_vec);
>
> +int io_uring_cmd_fixed_index_get(struct io_uring_cmd *ioucmd, u16 buf_in=
dex,
> +                                unsigned int off, size_t len, int ddir,
> +                                struct iov_iter *iter,
> +                                unsigned int issue_flags)
> +{
> +       struct io_kiocb *req =3D cmd_to_io_kiocb(ioucmd);
> +
> +       return io_reg_buf_index_get(req, iter, buf_index, off, len, ddir,
> +                                   issue_flags);
> +}
> +EXPORT_SYMBOL_GPL(io_uring_cmd_fixed_index_get);
> +
> +int io_uring_cmd_fixed_index_put(struct io_uring_cmd *ioucmd, u16 buf_in=
dex,
> +                                unsigned int issue_flags)
> +{
> +       struct io_kiocb *req =3D cmd_to_io_kiocb(ioucmd);
> +
> +       return io_reg_buf_index_put(req, buf_index, issue_flags);
> +}
> +EXPORT_SYMBOL_GPL(io_uring_cmd_fixed_index_put);
> +
>  void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd)
>  {
>         struct io_kiocb *req =3D cmd_to_io_kiocb(ioucmd);
> --
> 2.47.3
>

