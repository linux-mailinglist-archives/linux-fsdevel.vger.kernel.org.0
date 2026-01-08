Return-Path: <linux-fsdevel+bounces-72929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A6AD061CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 21:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42679303DD27
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 20:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6782731ED8A;
	Thu,  8 Jan 2026 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="e6UNd7dQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09A28D8D9
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904493; cv=none; b=Lq/qOl8Wz31J4B9wGjgsjCeWoK7G+FWrgcN63bg8eOEW+1ugzW7G/Mlq9c5W0Z4R859T6eqP352c4B9VcgdGZQ4ppwQ2fV/fl9wNpj2lP6m+tGJ71OIsnOiIgi3TteC3XcbwIPGAdS7TdpPhMXJKLDupiSnpCJ8LxZi3HCLF8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904493; c=relaxed/simple;
	bh=CrKlDG2xbsxKf3a4y7GyC24tTUg87XGt74e27eJikzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=br87v4xsZCD8J3ysgZnwBLFIn7uN1y7sGe/1IXL58oykPyH//fUUd383dehiciHnG+CgJLlNI+PawNV1kqfpnEt3sJ5WfpTNHhuSVG3Y9kEPBrBfyglLzurN0RJ/QKV0KDEjUd9FO4g0eAAK1d5NjDgA7ypKACu4LLV1vAz2UWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=e6UNd7dQ; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-11ddccf4afdso264234c88.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 12:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767904492; x=1768509292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnvW4WKmangsNuW7eKuI0hTk1XwSAzpyTyaGA3dt4So=;
        b=e6UNd7dQ4sVfMFx9/m4PSz9aVlfNG0XjoaQjMlXexXQ2AyKS9ELMYpXC1py66uI993
         9GutBCPPzJawlFWQqdHCI4Ozw0M9M841eK3MSuXwvTvBJGz17MLZ16x8FNOdvz3Q/LZk
         JnrqW5bD6TOKj9FElfP0Ak4ukimYypCBeN4R3TjYjsIJOiTcE06jKEb60uvwZs39unHh
         PJLTP/KGH59RY+ch6SyJ6nBDCKsvI7a2UBCEcN9wgN436Kx+JglkiO1H8H614+jrfyvJ
         C1bOiPr/lUTarfgsZJQul2qoI87UztYterHji847DvEC/VMvTzHbWGvWi3dBacF9jpS6
         h57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767904492; x=1768509292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fnvW4WKmangsNuW7eKuI0hTk1XwSAzpyTyaGA3dt4So=;
        b=DVQd4QpwAEqdNdMOcj9hA/MKQf6GaTLGX9VQU+BKzkycNkf99kjkKb6wRYYaJA3Vqj
         10hc+W7H+tZJlddnVGIeyAQZqkOmTatRjza9XIDFCx2xvM7Ztm90kEYA3dLx4iWM8TNz
         IY8dMX6r/UMcmYoil0tFjqbqRqfrvCo3XAesXqq9SvkIM4LVdPSbK3syf4cXPMXujewa
         z8lbqLEZt0aQt8mrnJdspEt1w+KC5wJWO7Ugj8kNqhveL/jraCILmBlw8ZkKPxKVydCh
         yUyI/2Fka83jMjLQiyObckLB+W08VyHIBn0lpeU3NjXbcjPf5VFUK6w3rM9FnLOQOSP6
         S50A==
X-Forwarded-Encrypted: i=1; AJvYcCWtXprcEsQX/Czbn1iVWcxGCZYnSzyb5qYtzaTaPBrO4ZSzCAQ8BzYHflpSHePlfqqkq7M7QJpeyopY4Hb9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ivlDN2jdeHY4pQB47H0evu3vRx1ivb7DAVTWWJ4F9VHdWXzi
	X5/QWS+8OBFHUsvBsp51hUpTSf17Xeu/1y/AFKCiYkHOcY3IuidkIWjKsSpxtojP7+e6P06DVYc
	A/Zn5mMfn/f0mvEY81V8c7Xb5+U2tT3TFSMV1SeafgA==
X-Gm-Gg: AY/fxX7ZyQNIszNvLLiqdLKYU2R7knCKfiVU2Srt5bNXHpOHq1Qrne6w5MTW2aA1vje
	7dknjPREocCca72w0b6yJJNC6tnwBm/tRbrDP0/2co/0AdH7oljwQgX4fM1nEnWQW3Ly0fe9V/1
	exB8hbjVWArpOB0TaO1UHicbyrZLlFYmDt7VPZ67cPPZa3RX+BR0DcjAKcMdo8cSNBnChu49XlG
	RXk6HjNlEVk+sJguaT3GKjrIDbTekvuY6Z3yXnUUjI1XWEC+Yz1Ip1Fsw9BN/eovrBpe5QJ
X-Google-Smtp-Source: AGHT+IE/LI4BedIHNVzwwnWv3XeKEAv4clZYkrvUqTaySrNctmMY+MTE2JmVrYjiviwxSSiLeLnGBHeMs9FaK31koHE=
X-Received: by 2002:a05:7022:41a7:b0:11b:ad6a:6e39 with SMTP id
 a92af1059eb24-121f8b6063cmr3542848c88.5.1767904491511; Thu, 08 Jan 2026
 12:34:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223003522.3055912-1-joannelkoong@gmail.com> <20251223003522.3055912-11-joannelkoong@gmail.com>
In-Reply-To: <20251223003522.3055912-11-joannelkoong@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 8 Jan 2026 12:34:39 -0800
X-Gm-Features: AQt7F2p-Qcq3-Jkt49SWMqafpZtOjR1Z2rts-3pvXcHnzz1shnWSnfp0JcixX6U
Message-ID: <CADUfDZqHhVi1RY71dvEFbWsHmrzLbTSgev5o8yRXxExV5=XY2g@mail.gmail.com>
Subject: Re: [PATCH v3 10/25] io_uring/kbuf: export io_ring_buffer_select()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 4:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Export io_ring_buffer_select() so that it may be used by callers who
> pass in a pinned bufring without needing to grab the io_uring mutex.
>
> This is a preparatory patch that will be needed by fuse io-uring, which
> will need to select a buffer from a kernel-managed bufring while the
> uring mutex may already be held by in-progress commits, and may need to
> select a buffer in atomic contexts.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/io_uring/buf.h | 25 +++++++++++++++++++++++++
>  io_uring/kbuf.c              |  8 +++++---
>  2 files changed, 30 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/io_uring/buf.h
>
> diff --git a/include/linux/io_uring/buf.h b/include/linux/io_uring/buf.h
> new file mode 100644
> index 000000000000..3f7426ced3eb
> --- /dev/null
> +++ b/include/linux/io_uring/buf.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _LINUX_IO_URING_BUF_H
> +#define _LINUX_IO_URING_BUF_H
> +
> +#include <linux/io_uring_types.h>
> +
> +#if defined(CONFIG_IO_URING)
> +struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len=
,

I think struct io_kiocb isn't intended to be exposed outside of
io_uring internal code. Is there a reason not to instead expose a
wrapper function that takes struct io_uring_cmd * instead?

Best,
Caleb

> +                                      struct io_buffer_list *bl,
> +                                      unsigned int issue_flags);
> +#else
> +static inline struct io_br_sel io_ring_buffer_select(struct io_kiocb *re=
q,
> +                                                    size_t *len,
> +                                                    struct io_buffer_lis=
t *bl,
> +                                                    unsigned int issue_f=
lags)
> +{
> +       struct io_br_sel sel =3D {
> +               .val =3D -EOPNOTSUPP,
> +       };
> +
> +       return sel;
> +}
> +#endif /* CONFIG_IO_URING */
> +
> +#endif /* _LINUX_IO_URING_BUF_H */
> diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
> index 0524b22e60a5..3b9907f0a78e 100644
> --- a/io_uring/kbuf.c
> +++ b/io_uring/kbuf.c
> @@ -9,6 +9,7 @@
>  #include <linux/poll.h>
>  #include <linux/vmalloc.h>
>  #include <linux/io_uring.h>
> +#include <linux/io_uring/buf.h>
>
>  #include <uapi/linux/io_uring.h>
>
> @@ -223,9 +224,9 @@ static bool io_should_commit(struct io_kiocb *req, st=
ruct io_buffer_list *bl,
>         return false;
>  }
>
> -static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size=
_t *len,
> -                                             struct io_buffer_list *bl,
> -                                             unsigned int issue_flags)
> +struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len=
,
> +                                      struct io_buffer_list *bl,
> +                                      unsigned int issue_flags)
>  {
>         struct io_uring_buf_ring *br =3D bl->buf_ring;
>         __u16 tail, head =3D bl->head;
> @@ -259,6 +260,7 @@ static struct io_br_sel io_ring_buffer_select(struct =
io_kiocb *req, size_t *len,
>         }
>         return sel;
>  }
> +EXPORT_SYMBOL_GPL(io_ring_buffer_select);
>
>  struct io_br_sel io_buffer_select(struct io_kiocb *req, size_t *len,
>                                   unsigned buf_group, unsigned int issue_=
flags)
> --
> 2.47.3
>

