Return-Path: <linux-fsdevel+bounces-72927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CC6D05D3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 20:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F690300E4E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 19:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0FE2E719E;
	Thu,  8 Jan 2026 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="apjlUARl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFAA279DC0
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899911; cv=none; b=f+VyhBGS/3Rvqec44lzHXlheZ8vr4zZI2lD15gFoBGoKIiFxTlPa+Qx8hB5q8Rv8A8eCy6Xh0stZpUspQxpEprz6c2dO4sgWDkcpEzGkRT06Y5P1qmkfkM96I4XPTl3sNTWZRTvL5b/BipXD7Uozl550E42zhaN9j98jW+0Sy2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899911; c=relaxed/simple;
	bh=vvdD3Gd0++u8qcAyJkhfelThow2UkPtazIrJgAtTvM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BN4VS8evkEnGvvGRyu73wQ0WprmY6SXnm7tGG03MqRKpKPthpTacn0PCZkh+ec7oXHl0PaP8J5aNd3EraEDmFBQOGHcB+VYlAcVe0sNO+h2jhQJ6rOvWim4Ki6TCqiAWa/4BrxAToXywGLtU4eri+Tl6Jc4gcu+iQpV3SMGAq/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=apjlUARl; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b07583340dso213838eec.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 11:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767899909; x=1768504709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvVFe2diZMiZcxqbNk5dY7iJATPPwzTSj48fRKnPZEs=;
        b=apjlUARlLTuLRj9U5Q8f4EJIGyZMqexy37R1xFt2lkIhXd9TTjLCEJykQaYTtZPXB2
         2e6YjOa9xohfpHC0QqdyYcddfaaI4n764/LGQKElRRib9A1qt/KkmvEQVX6K3sMoAQvJ
         y7bptrGunFak5mrg4J4jUEhtSACHMoEkeKwdo5VDmrhtWjU3o0cljg/svfOJ3L38Jn2b
         AuU5UeIBuv8JpNUWlWjNXquRfHOjm0ddJUo05ZonGZTANqel61FP0i42MdONbquQxkOx
         971kDea21Z/u4LeBu+LwN4/XGSEQsHZBpl6sCXgTRms9HwEIm21mcWuWM/z+3Y6tf9d4
         k7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899909; x=1768504709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YvVFe2diZMiZcxqbNk5dY7iJATPPwzTSj48fRKnPZEs=;
        b=i9vVysTqVTGAGrFqXNxMpT+QXc56FaHh/Zhy3NGXuHauDOINCq3n1ShwKkg+zfVuW6
         vrf+qyHky6sWWJuYlW2p8k773gHoe4HhnztpeVK1YVORD81V83tznG++htKATdl1X0Ac
         l33FD3G7WHAZo8XKcPn/q1mxVzzCOPl1HwRWypNsZ4Xgd1thUVOsip5ywLVY2yEydpRm
         2bR2RUe6BVNnlNgRNxm1ozFgqeqQGoje2VSc20yAfdoBgWyu40qGfMZ4eOTaGqoYYzdS
         1as9IyrKv8hDE8Oza34ktAtfn8fmg0+g4/dOCEAABKsx+C3puS8r4r9j2GsAjy0+3aGH
         KQ/A==
X-Forwarded-Encrypted: i=1; AJvYcCU78oF73roSE74/ySVuCf48n8uM6486qHsp2LMwc7oFh144LKsJLqecewBOHtJXAqh+4JJcwYOsnvBOhlQQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2F64PKAWUZJ74wQw9JCqZ1hNlQpr2YKaeqJLUW8e9YFBPGx1C
	Fb7Lhuk1yEekon/WnJG+hB2gy8a+T7j+NiJsa0jq6ttwsO7hByiwTyjruvKMnhO93ixV7MYDT9s
	tA06ub1TpCWORXN5y2nEFfp9Vs7rGOKyE0nCPpmEhKw==
X-Gm-Gg: AY/fxX6mhOMTWM6EdDma/0GdJSPUnTAkRiI2Gz7zBC9mtXD/aN4ve1kCI7BIAq90+eE
	axkVqNzzrVrkD8hZn4foed/AP+P+87mNDs9nvyLCPlIu1LWVAtEsYiF37OPCFAM8fYcsLJtrd8f
	Wswwt9p25wiqm7rFDnfAoXF+nHkKsawW2SEPapGwNQx30kqG4TF8gRYYqHFdKQ99p4SlKCRzK8j
	CYpWOCQvwKiAat8BEIPSM3cPR+12Rkx9ltg/vwy5DeOiUeyUEBjzokSwusJ4vlt+2r8E3eh
X-Google-Smtp-Source: AGHT+IEJo6UdmSwvNV1jA3h2HyxuXfEneEMt8GdOo83YpPpe4zPkvBC1ZTeDALk+jZeMVZBG18sf6v5FsRwiSP0VF/Q=
X-Received: by 2002:a05:7022:619c:b0:119:e55a:95a3 with SMTP id
 a92af1059eb24-121f8b92076mr3647792c88.5.1767899909050; Thu, 08 Jan 2026
 11:18:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223003522.3055912-1-joannelkoong@gmail.com> <20251223003522.3055912-7-joannelkoong@gmail.com>
In-Reply-To: <20251223003522.3055912-7-joannelkoong@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 8 Jan 2026 11:18:17 -0800
X-Gm-Features: AQt7F2ptVEsV9kFBiXyLQK36DHnP8Zc0Zvf87eqdRUqk8zK24lF0k1J7hE-4I8Q
Message-ID: <CADUfDZqKu0AN_Ci5fKZEgLzOCMgjtAVhfMbyO6KkX3PYfs4Xcw@mail.gmail.com>
Subject: Re: [PATCH v3 06/25] io_uring/kbuf: add buffer ring pinning/unpinning
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 4:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
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
>  io_uring/kbuf.c              | 46 ++++++++++++++++++++++++++++++++++++
>  io_uring/kbuf.h              | 10 ++++++++
>  io_uring/uring_cmd.c         | 18 ++++++++++++++
>  4 files changed, 91 insertions(+)
>
> diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> index 375fd048c4cb..424f071f42e5 100644
> --- a/include/linux/io_uring/cmd.h
> +++ b/include/linux/io_uring/cmd.h
> @@ -84,6 +84,10 @@ struct io_br_sel io_uring_cmd_buffer_select(struct io_=
uring_cmd *ioucmd,
>  bool io_uring_mshot_cmd_post_cqe(struct io_uring_cmd *ioucmd,
>                                  struct io_br_sel *sel, unsigned int issu=
e_flags);
>
> +int io_uring_cmd_buf_ring_pin(struct io_uring_cmd *ioucmd, unsigned buf_=
group,
> +                             unsigned issue_flags, struct io_buffer_list=
 **bl);
> +int io_uring_cmd_buf_ring_unpin(struct io_uring_cmd *ioucmd, unsigned bu=
f_group,
> +                               unsigned issue_flags);
>  #else
>  static inline int
>  io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
> @@ -126,6 +130,19 @@ static inline bool io_uring_mshot_cmd_post_cqe(struc=
t io_uring_cmd *ioucmd,
>  {
>         return true;
>  }
> +static inline int io_uring_cmd_buf_ring_pin(struct io_uring_cmd *ioucmd,
> +                                           unsigned buf_group,
> +                                           unsigned issue_flags,
> +                                           struct io_buffer_list **bl)
> +{
> +       return -EOPNOTSUPP;
> +}
> +static inline int io_uring_cmd_buf_ring_unpin(struct io_uring_cmd *ioucm=
d,
> +                                             unsigned buf_group,
> +                                             unsigned issue_flags)
> +{
> +       return -EOPNOTSUPP;
> +}
>  #endif
>
>  static inline struct io_uring_cmd *io_uring_cmd_from_tw(struct io_tw_req=
 tw_req)
> diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
> index 8f63924bc9f7..03e05bab023a 100644
> --- a/io_uring/kbuf.c
> +++ b/io_uring/kbuf.c
> @@ -238,6 +238,50 @@ struct io_br_sel io_buffer_select(struct io_kiocb *r=
eq, size_t *len,
>         return sel;
>  }
>
> +int io_kbuf_ring_pin(struct io_kiocb *req, unsigned buf_group,
> +                    unsigned issue_flags, struct io_buffer_list **bl)
> +{
> +       struct io_buffer_list *buffer_list;
> +       struct io_ring_ctx *ctx =3D req->ctx;

Would it make sense to take struct io_ring_ctx *ctx instead of struct
io_kiocb *req since this doesn't otherwise use the req? Same comment
for several of the other kbuf_ring helpers (io_kbuf_ring_unpin(),
io_reg_buf_index_get(), io_reg_buf_index_put(), io_is_kmbuf_ring()).

Best,
Caleb

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
> +
>  /* cap it at a reasonable 256, will be one page even for 4K */
>  #define PEEK_MAX_IMPORT                256
>
> @@ -744,6 +788,8 @@ int io_unregister_buf_ring(struct io_ring_ctx *ctx, v=
oid __user *arg)
>                 return -ENOENT;
>         if (!(bl->flags & IOBL_BUF_RING))
>                 return -EINVAL;
> +       if (bl->flags & IOBL_PINNED)
> +               return -EBUSY;
>
>         scoped_guard(mutex, &ctx->mmap_lock)
>                 xa_erase(&ctx->io_bl_xa, bl->bgid);
> diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
> index 11d165888b8e..c4368f35cf11 100644
> --- a/io_uring/kbuf.h
> +++ b/io_uring/kbuf.h
> @@ -12,6 +12,11 @@ enum {
>         IOBL_INC                =3D 2,
>         /* buffers are kernel managed */
>         IOBL_KERNEL_MANAGED     =3D 4,
> +       /*
> +        * buffer ring is pinned and cannot be unregistered by userspace =
until
> +        * it has been unpinned
> +        */
> +       IOBL_PINNED             =3D 8,
>  };
>
>  struct io_buffer_list {
> @@ -136,4 +141,9 @@ static inline unsigned int io_put_kbufs(struct io_kio=
cb *req, int len,
>                 return 0;
>         return __io_put_kbufs(req, bl, len, nbufs);
>  }
> +
> +int io_kbuf_ring_pin(struct io_kiocb *req, unsigned buf_group,
> +                    unsigned issue_flags, struct io_buffer_list **bl);
> +int io_kbuf_ring_unpin(struct io_kiocb *req, unsigned buf_group,
> +                      unsigned issue_flags);
>  #endif
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index 197474911f04..8ac79ead4158 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -398,3 +398,21 @@ bool io_uring_mshot_cmd_post_cqe(struct io_uring_cmd=
 *ioucmd,
>         return true;
>  }
>  EXPORT_SYMBOL_GPL(io_uring_mshot_cmd_post_cqe);
> +
> +int io_uring_cmd_buf_ring_pin(struct io_uring_cmd *ioucmd, unsigned buf_=
group,
> +                             unsigned issue_flags, struct io_buffer_list=
 **bl)
> +{
> +       struct io_kiocb *req =3D cmd_to_io_kiocb(ioucmd);
> +
> +       return io_kbuf_ring_pin(req, buf_group, issue_flags, bl);
> +}
> +EXPORT_SYMBOL_GPL(io_uring_cmd_buf_ring_pin);
> +
> +int io_uring_cmd_buf_ring_unpin(struct io_uring_cmd *ioucmd, unsigned bu=
f_group,
> +                               unsigned issue_flags)
> +{
> +       struct io_kiocb *req =3D cmd_to_io_kiocb(ioucmd);
> +
> +       return io_kbuf_ring_unpin(req, buf_group, issue_flags);
> +}
> +EXPORT_SYMBOL_GPL(io_uring_cmd_buf_ring_unpin);
> --
> 2.47.3
>

