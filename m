Return-Path: <linux-fsdevel+bounces-71666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB32BCCC3F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 15:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 311BE3022D0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DAD26D4CD;
	Thu, 18 Dec 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/rGU3oB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8774D157487
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067707; cv=none; b=jdXhR9gQiQCX95JAe+yVZzyZCaRb8lEGlU1LsMIiRrBKvgp6E1Ykm1AcZjTFInEo11OW+tGeABms9A88z9Q+jSLvM4jxpfPo20szLD6gCNzO/AVittRRY4VXc0P3oedtZJc61HVqU07AAlRFxFJoh0iYwjcINa4uAjZNU7MnNKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067707; c=relaxed/simple;
	bh=Z7EMT1UO3RkNku5bwQXsrra0N/zfJAFq2oZNXV5tLnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZT0OpBrbITL5qefDb/gdXjFa5c+RSLaRhjXrkAMzCDXxY0q3xg2wYLPtZ9skREzg7cfT3o1jHxppCizz22Q4TuOl4/dB4swA8o3nY4X7fT84bMzUo6Gbbkrlcj+xIRE/Q4pzZ5dpRG7gImmNZViX2Nb+NSrHpDavM2d7N3gYfEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/rGU3oB; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b2ea5a44a9so73339785a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 06:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766067704; x=1766672504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cLLR5nXh10AnxmsjPcFHlPcqiC135Rsbf44wjW9fVY=;
        b=U/rGU3oBSvvfJdVL54mRKG4mH1rFitUToGZKHqq2BvtuRKg+3+cquRkNSWaaQ64cyk
         M0SECA6qH3dfpv9S0rCY7bSY5vr+8gPrPNKy1K8wAwU0ojlaRvFggA3xbQrloyiSrnVE
         Z/7hZ9hKvZ3Veto1jPdgtFgIvNdQ7GUUoyhY/Wfc6TaM1KoGO6dAPbnr5HgCUgrRf0mT
         hReDP5/dAgYMor+KS38+Qcpneadzx0XKAI4BbBNsD5XSqIqsG6wXWrt9baDh03JaurYM
         hsgsqkWtMsP73lE5yX1hycOJvvm/khAbi0UAxtXy9foO881Air6CduwHoiT4qovYpdB0
         vRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766067704; x=1766672504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0cLLR5nXh10AnxmsjPcFHlPcqiC135Rsbf44wjW9fVY=;
        b=d/i/M/3HzB1/SlsxPBG5iw59X4m+mH14rCRw57K+4ouqM9Ma2NxP7BmbYMfpl1WzVC
         /1s2iJRpP9IEe2KpoMunvgRqoF3Rc4gxr2U/bzHkPetJQJ+FoHwNiBPUk/OvVb/PkkuZ
         abVVlrykEv3jyf/QEXQZzIjnHryP8bxyDLwyvUGO5947uCx2KoVloVo8s5w8IUCFTJUF
         cVkdMH7C82NnNyc85ZbmDhkgDiDYtcSaCFYTmZcNL2emZM8ZQeGnChTc2Z7XQAZa+gAO
         hvg56TeCUQgbGTpEDO5IGQWBlw0J897dY1QKHNAo2Xxr4tQnWfJIZXONbYGPdS01PJBC
         8mGg==
X-Forwarded-Encrypted: i=1; AJvYcCVuOVmS3U0eZGZLru4pF8u/Mp1vr+8y90Grfm5mdq8KkBW1iDvC2MsxQL+MOK3hS2kOKVbYeGZo4hu2xK5C@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4h4+itwfk1feBwrbtDlDxl04yRy6GTyRGsYxndwehC5/1sjoU
	fuLb5StCtxsbCZB/m5xLEXvWFXu5Q8A1BrwUq9fqOZpsU6g2YQLTEJ6Bm2kC+ojSWhyCuW57ZEf
	tlQQYZG8WeQj3j1ARi/yIqHe3uMjoOUY=
X-Gm-Gg: AY/fxX5nQAWqyHVZR7DQEJ4SQ06XUr+6ymp8BdUn+rodO/LmG7LHObPSyGeDt99buhT
	Z5EOhlMpt/tRY/b5/Q/LAefb195uQh4ukKrYygyS0UxEFasR/PlBXf+IaxpIIn3qCrBt8uNSv1r
	62Z75eSkXfoOYGc3m3uQcAFgBK5YrL7URTajl0jGk7Xv2VSPis15N1uFPMZ6Qyq9+WYN5PqOa5n
	t29DCiEt7aHpOc5DAKMyyJafaIK/VWge9J/A33fsSj1wU8wSzBDaEwcoKteWZEMJNFCqR8=
X-Google-Smtp-Source: AGHT+IFhsiOpdX8/Ur7/QbLcy2w0EcG/usAyP8PgPyyDrEe6WT45Nxj1s+yy+iuMKhH/5Q+jez1ZW4oJElO1B9BO/8o=
X-Received: by 2002:a05:622a:244a:b0:4f1:bacc:151 with SMTP id
 d75a77b69052e-4f1d05f6667mr325270011cf.60.1766067704193; Thu, 18 Dec 2025
 06:21:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218083319.3485503-1-joannelkoong@gmail.com> <20251218083319.3485503-7-joannelkoong@gmail.com>
In-Reply-To: <20251218083319.3485503-7-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 18 Dec 2025 22:21:33 +0800
X-Gm-Features: AQt7F2oBpvOvgQ12QxXnz62aeSNQg_j3sipnLsBOWwS9vBNDCk0rng3CaYQHJfM
Message-ID: <CAJnrk1YkV=pwjhLtNbg-67gwXjOEn4f8ScmGmrgq2s6yXne5dw@mail.gmail.com>
Subject: Re: [PATCH v2 06/25] io_uring/kbuf: add buffer ring pinning/unpinning
To: miklos@szeredi.hu, axboe@kernel.dk
Cc: bschubert@ddn.com, asml.silence@gmail.com, io-uring@vger.kernel.org, 
	csander@purestorage.com, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 4:34=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Add kernel APIs to pin and unpin buffer rings, preventing userspace from
> unregistering a buffer ring while it is pinned by the kernel.
>
> This provides a mechanism for kernel subsystems to safely access buffer
> ring contents while ensuring the buffer ring remains valid. A pinned
> buffer ring cannot be unregistered until explicitly unpinned. On the
> userspace side, trying to unregister a pinned buffer will return -EBUSY.
>
> This is a preparatory change for upcoming fuse usage of kernel-managed
> buffer rings. It is necessary for fuse to pin the buffer ring because
> fuse may need to select a buffer in atomic contexts, which it can only
> do so by using the underlying buffer list pointer.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/io_uring/cmd.h | 17 +++++++++++++
>  io_uring/kbuf.c              | 48 ++++++++++++++++++++++++++++++++++++
>  io_uring/kbuf.h              | 10 ++++++++
>  io_uring/uring_cmd.c         | 18 ++++++++++++++
>  4 files changed, 93 insertions(+)
>
> diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
> index c98cecb56b8c..49dc75f24432 100644
> --- a/io_uring/kbuf.c
> +++ b/io_uring/kbuf.c
> @@ -238,6 +238,52 @@ struct io_br_sel io_buffer_select(struct io_kiocb *r=
eq, size_t *len,
>         return sel;
>  }
>
> +int io_kbuf_ring_pin(struct io_kiocb *req, unsigned buf_group,
> +                    unsigned issue_flags, struct io_buffer_list **bl)
> +{
> +       struct io_buffer_list *buffer_list;
> +       struct io_ring_ctx *ctx =3D req->ctx;
> +       int ret =3D -EINVAL;
> +
> +       io_ring_submit_lock(ctx, issue_flags);
> +
> +       buffer_list =3D io_buffer_get_list(ctx, buf_group);
> +       if (likely(buffer_list) && likely(buffer_list->flags & IOBL_BUF_R=
ING)) {
> +               if (unlikely(buffer_list->flags & IOBL_PINNED)) {
> +                       ret =3D -EALREADY;
> +               } else {
> +                       buffer_list->flags |=3D IOBL_PINNED;
> +                       ret =3D 0;
> +                       *bl =3D buffer_list;
> +               }
> +       }
> +
> +       io_ring_submit_unlock(ctx, issue_flags);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(io_kbuf_ring_pin);

This EXPORT_SYMBOL_GPL (and the one below) are remnants from v1 and
are no longer necessary. I"ll remove these for the next version.

> +
> +int io_kbuf_ring_unpin(struct io_kiocb *req, unsigned buf_group,
> +                      unsigned issue_flags)
> +{
> +       struct io_ring_ctx *ctx =3D req->ctx;
> +       struct io_buffer_list *bl;
> +       int ret =3D -EINVAL;
> +
> +       io_ring_submit_lock(ctx, issue_flags);
> +
> +       bl =3D io_buffer_get_list(ctx, buf_group);
> +       if (likely(bl) && likely(bl->flags & IOBL_BUF_RING) &&
> +           likely(bl->flags & IOBL_PINNED)) {
> +               bl->flags &=3D ~IOBL_PINNED;
> +               ret =3D 0;
> +       }
> +
> +       io_ring_submit_unlock(ctx, issue_flags);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(io_kbuf_ring_unpin);
> +

