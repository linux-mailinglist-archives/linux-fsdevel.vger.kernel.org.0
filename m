Return-Path: <linux-fsdevel+bounces-65269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C42BFEFB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 05:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C1323510E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 03:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6120720C023;
	Thu, 23 Oct 2025 03:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XzYsMEYl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97569169AE6
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 03:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761189435; cv=none; b=HD++Zwj6ntvNOXD2q4JnB2eZJQZ5WDEQYE6/z2SLIEBaZIYWwoESv/uFALAgIz7kl06iATL2PqeUGWd9v+wpYFL9aZpdguY7mHkBOPpruYXqMXQ69rIdm4gFYC84Iu8XQjvpaT7aL6woN5d5Ywo4czaOxVUMJ/kWS9MYoJV8Al0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761189435; c=relaxed/simple;
	bh=iOXht9vrOqUArHzYFYQePWrdvzIabF6CulOPl8EPWJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S77CoenYS77XFrpyiLLg58/8kPp16bOKlqmCLgUmWkzaaJsUthWy030ask80U6rOtRFVsR9P5bCICcdt2fDeVwjh6zyBtjjNphtd6558yc4z/q2wli09HyuhMMw/W5pib1ykShHuzi4s0/EBUP+X5PyLluPusQGq8UY+5Qc7vBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XzYsMEYl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-290a38a2fe4so411835ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 20:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761189431; x=1761794231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsQKop5qY8J1CPJSUCMvyRajEHIdK46Cg/9v4FNyufE=;
        b=XzYsMEYlphtOlsXRFf6CO2yexDq9vJs1i57UuGxxfT2ddmD88tyJdAGvmYuPfknJIl
         sW3Kl2OOGrdRafkAa0ZboVYyTJ0sygMQbCNwGBtpdkUzzF+eMMrR6igkydwCg41aoFs8
         FuGbMFyDcWR5XpvzLZH7uUt86WKgCB0Ot9/X0wQNSJ+ChYZEHEWR7r+QZypF6r5gag49
         IiQYVVu70isQwxtIrgTO/qIlFpJYRv+nA3w+659GnKr4epoWinoOrjPqy6a3cFhNX8/m
         O+xINaatseqmZ/u+7bGVTd3nSmufsksogRpv3c9wjzoAXpFDU7TBneFOPzVyJvZu74Hp
         UXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761189431; x=1761794231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsQKop5qY8J1CPJSUCMvyRajEHIdK46Cg/9v4FNyufE=;
        b=Rndlp+oKfwePhx65KVRaWC2aTkkXfD0aJoHk5v+48s1YHXPdxM3GTD56BSzq1yvwhZ
         PA3+4C9VwXVTxE7GVLQ9VYkXRpvrXo8mDJ0K3yYa2lEv08YQLc+bFcDJ3Xd4mUM8QInd
         +D+TW48OQ4WJqeCEj3eqodAw3zCFUcaArj8BLJwm7MJXuCx0DyH3iSj+aOZfShDQNf9y
         khgn6icHjZXZ6dudmxrnOH3GZ5DmU93QRYqF5IgZT3uMicIxeSl8S42uThe8UAK8G1yV
         JuROIdhMvPNVmwFLP5EERqkJEm4b/NMYi+YasD1I+mipP0r9ZUOwTpEFXDLRtpPrtJOv
         OX0g==
X-Forwarded-Encrypted: i=1; AJvYcCUpLYQJ9OV5apMrnMF05IalRAPeGE0lp1ce6cCo8mVpEl3HkHve0wOfqS4yb+D79J2nJ2tUIA/omOWYoeXG@vger.kernel.org
X-Gm-Message-State: AOJu0YzcKcj8caFLSqJIIZaX8pgdl+oCXEoTEvpzope8hpAlBKWriysA
	YG0xdJ6NZt9i3cOnhmzatJV0jbcSZrcRnXfSFJixVzFi3e+/PF4j1xICOdmtqFBpB+JNUvYrsH1
	wWU3ZHwutESVNgtNXsLEqFp2RBlwPeEHhy1d4ILlvasV1+skGS4qWY/3hHA==
X-Gm-Gg: ASbGncvUbxh0r7w8p2zRu67Y9dWeYSd7Gk9qT/1EJCp7ThLP738bazdGpAzin6JseoD
	K70MUx+13I/sUGNLke3KZvEO39cAo3aLWuG/L84Z4CETyZjiHuCm8GR39aPdgATzFoT8cHnXTK0
	u8Ii0tMy+vhByg69rfJRrx45JDTLl9vM936D1B84nu4riIPCxmWurNJZnXVcxQzZz+Z/42uRxKk
	OZNS2PwVWqzv5uHnFUu1befYl2hjB8eE9Dyyq/uAkZyXVH+gHKY6dibSVvtaxqoBCmZHWRBSExt
	kdE3KQWToJPZXk/u7g==
X-Google-Smtp-Source: AGHT+IF2gr3tjOA3w9b81IEdkti0qDz4SfOy+px6OWbFNwx5WuFkZ5mmJ80dGJ7Bisfb2N5IIMQQ6bJEoIVubhYB4Ak=
X-Received: by 2002:a17:902:fc85:b0:290:af0d:9381 with SMTP id
 d9443c01a7336-292d3facdd0mr63010925ad.7.1761189430734; Wed, 22 Oct 2025
 20:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022202021.3649586-1-joannelkoong@gmail.com> <20251022202021.3649586-2-joannelkoong@gmail.com>
In-Reply-To: <20251022202021.3649586-2-joannelkoong@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 22 Oct 2025 20:16:58 -0700
X-Gm-Features: AS18NWBh4u1l8Qi-V8ty85RFAm-ErpQlPDvQ8UmqI6Xjl_gqZb0DRiqRRfOiLVY
Message-ID: <CADUfDZoeyDg2F1aSOTqg_7wANxH_LUuSGjiA5=-Auf5TDdj8AQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] io-uring: add io_uring_cmd_get_buffer_info()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, linux-fsdevel@vger.kernel.org, 
	bschubert@ddn.com, asml.silence@gmail.com, io-uring@vger.kernel.org, 
	xiaobing.li@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 1:23=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Add io_uring_cmd_get_buffer_info() to fetch buffer information that will
> be necessary for constructing an iov iter for it.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/io_uring/cmd.h |  2 ++
>  io_uring/rsrc.c              | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> index 7509025b4071..a92e810f37f9 100644
> --- a/include/linux/io_uring/cmd.h
> +++ b/include/linux/io_uring/cmd.h
> @@ -177,4 +177,6 @@ int io_buffer_register_bvec(struct io_uring_cmd *cmd,=
 struct request *rq,
>  int io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int ind=
ex,
>                               unsigned int issue_flags);
>
> +int io_uring_cmd_get_buffer_info(struct io_uring_cmd *cmd, u64 *ubuf,
> +                                unsigned int *len);
>  #endif /* _LINUX_IO_URING_CMD_H */
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index d787c16dc1c3..8554cdad8abc 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -1569,3 +1569,24 @@ int io_prep_reg_iovec(struct io_kiocb *req, struct=
 iou_vec *iv,
>         req->flags |=3D REQ_F_IMPORT_BUFFER;
>         return 0;
>  }
> +
> +int io_uring_cmd_get_buffer_info(struct io_uring_cmd *cmd, u64 *ubuf,
> +                                unsigned int *len)
> +{
> +       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> +       struct io_rsrc_data *data =3D &ctx->buf_table;
> +       struct io_mapped_ubuf *imu;
> +       unsigned int buf_index;
> +
> +       if (!data->nr)
> +               return -EINVAL;
> +
> +       buf_index =3D cmd->sqe->buf_index;

This is reading userspace-mapped memory, it should use READ_ONCE().
But why not just use cmd_to_io_kiocb(cmd)->buf_index? That's already
sampled from the SQE in io_uring_cmd_prep() if the
IORING_URING_CMD_FIXED flag is set. And it seems like the fuse
uring_cmd implementation requires that flag to be set.

> +       imu =3D data->nodes[buf_index]->buf;

Needs a bounds check?

> +
> +       *ubuf =3D imu->ubuf;
> +       *len =3D imu->len;

This wouldn't be valid for kernel registered buffers (those registered
with io_buffer_register_bvec()). Either reject those or return a more
general representation of the registered buffer memory (e.g. an
iterator)?

Best,
Caleb

> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(io_uring_cmd_get_buffer_info);
> --
> 2.47.3
>
>

