Return-Path: <linux-fsdevel+bounces-70537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D711DC9DC24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 05:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E123A65F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 04:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7C71EF36C;
	Wed,  3 Dec 2025 04:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZWHAzD1v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA70627586C
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 04:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764737387; cv=none; b=NQjx9rjvkpAuf6MKPUUcZMVv9VW0dDUqhBYflhIsIYBFUyAyWPifZwtWUl9LZqsC4LuiF8rJJA/9ZhupuERXJD0tnJyqhWBj6HQyTQwZZO02uux7brVGTNJW9zLymvaoVMewiK2ZLDQu0YnR6oNKFfDVu8dbAizpBwsXPtWfv0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764737387; c=relaxed/simple;
	bh=CtLMzO+EkIiDxmWvm4zrn7QDaX3JlLSeuGs+TDR8kIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPwDjHUMadbtAJGYATOxa7beY7F3bb8miC1fm4Hmo+wlOq2hdIaAf3F7JubfhcZQaDgHGcndFWtrUo3HDi0zZOo9gnx231l8yH4QCW0/rG5HNuiOwaGgkBKW7AgMdDPgfEO9Ge/FxbLtyYb20DeGS2scesS8hR5XGoiN9/4Xyxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZWHAzD1v; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7bac5b906bcso783557b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 20:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764737384; x=1765342184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHkvJWNiDtqjeNJ3/XWKxN+DZ0F0cDp+uzwu4MUCaz4=;
        b=ZWHAzD1vQT46rR5Tq48yJmOFH3k8U3gPiF69d6t+ELnafKAlKDr9wNYrGnMhhmE0QB
         cNkCV4KqNDTsEzot3pC+2nJkTo7KUW4AUb3T78VD4p/3kA3y7j/hw751aTspIi7FqB4q
         Rqh6GHsQp+LMsmZF6QvuyY4i9wnW/F6YpOIDL1+wazTDebCOQ2D1znhQJbyggyDbCrCi
         7ZKOLNIG/b99/7K5BmMRclO48WKfJvJ20DUgfJCLmxdzJS1iyL3rrblySGS3zI8+PhLH
         ZjnvR0zubKPgloqJ6K3BFe2Kk4nL8VvRiNA5LRxD+h71Byem4lmIhXDr5REFMLvTzxU3
         5tEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764737384; x=1765342184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JHkvJWNiDtqjeNJ3/XWKxN+DZ0F0cDp+uzwu4MUCaz4=;
        b=plnWT7cnmPdaIR2aOLmlI3hdry7qSUoWDcKjEb13Y1lSpI5i4hlVP1/daMubxWYL25
         v1mQVPItU/QceFDzSPn2WiXye2n9ftwaLdt2/4Us3fw2tZOq7UGiUR4lqPc53z6azZIs
         Bu9bJPadNZjMStAyfabQGQuJDQkKX0W54q22erWSWjVDvFM3B27UK6B2OjZhsjHJwWFG
         Rc70AqN70XrTwoixQbs7NnMlbZGlTvJlIn8ELvULm0eIwc/xnBdRxvrOZRr+HcS9kpRM
         oPzFblIyZC4nVo4BURxmJewHtY/0tw/b5hpcvwvuM+AKDaOIfGzJ6+3K2nCQLK7Wucg9
         GRHw==
X-Forwarded-Encrypted: i=1; AJvYcCWvruC6jeBAF5IBLx+rOfWRfdnmnZTyIjtckcWok9Rtd6ZDUFXUPFaB9gJmOZQ++UOKFiw7ZX7O6diIe9iO@vger.kernel.org
X-Gm-Message-State: AOJu0YzXMrW9R9EO/HYSXVVw9iKYqb3PqaNRTmHtXRefw9r8+JAwp8t1
	iimEDBH+7li9I4yUPp+Ng6VafTsVJv+k0ssmzyztA6Dwp9fqgwFkdsc5HzqF6F3H/MBMOmupEaV
	uFh0D6HGT6sYTPIc/A5QhEsKl6HwBlEZ9ejfCXmMUZQ==
X-Gm-Gg: ASbGncujdHQv4GVxVJStVjwYHq0RNLv6taN5DeKkr+TkmWjbH/vVIPdPYS/H3adZVYH
	xB4u3wputH41Nb6CcpnpOzo0YaL/kcVS5vhVvE3g/9VzaV4T+qA+lYscOCjmQcTXaW7TNGLb/2N
	y0bpLMLo47a390gwymQETIfJFUuRZFMmQCZjeFWu7N2gVZ/MLYN2xXncydS0KQB18kNhf08PJes
	fJ2y3muCf/8ly1W9xbn2IReVmy1l98WtK0+1PkrSkaagpTuOzdf/YyREIwYnsuIkS2FhJ99JsEt
	ESWdc4A=
X-Google-Smtp-Source: AGHT+IHSCCXVwcGWdcuTfOa+Rg9oh0WRs3Q67G1HVUduLRzeb9VcfO1tAQ8FrL7M2SaNH+c1wLRLp/skKBn1L6ybBTE=
X-Received: by 2002:a05:7022:41a6:b0:11b:ad6a:6e39 with SMTP id
 a92af1059eb24-11df0cf5ba4mr753384c88.5.1764737383828; Tue, 02 Dec 2025
 20:49:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203003526.2889477-1-joannelkoong@gmail.com> <20251203003526.2889477-8-joannelkoong@gmail.com>
In-Reply-To: <20251203003526.2889477-8-joannelkoong@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 2 Dec 2025 20:49:32 -0800
X-Gm-Features: AWmQ_bmWfayZBqik_nzKNaGHp6KRhV1hQNLbLfmY456BtQ9TBNyUXTNnHHIKlhI
Message-ID: <CADUfDZosVLf4vGm4_kNFReaNH3wSi2RoLXwZBc6TN0Jw__s1OQ@mail.gmail.com>
Subject: Re: [PATCH v1 07/30] io_uring/rsrc: add fixed buffer table pinning/unpinning
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 4:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> Add kernel APIs to pin and unpin the buffer table for fixed buffers,
> preventing userspace from unregistering or updating the fixed buffers
> table while it is pinned by the kernel.
>
> This has two advantages:
> a) Eliminating the overhead of having to fetch and construct an iter for
> a fixed buffer per every cmd. Instead, the caller can pin the buffer
> table, fetch/construct the iter once, and use that across cmds for
> however long it needs to until it is ready to unpin the buffer table.
>
> b) Allowing a fixed buffer lookup at any index. The buffer table must be
> pinned in order to allow this, otherwise we would have to keep track of
> all the nodes that have been looked up by the io_kiocb so that we can
> properly adjust the refcounts for those nodes. Ensuring that the buffer
> table must first be pinned before being able to fetch a buffer at any
> index makes things logistically a lot neater.

Why is it necessary to pin the entire buffer table rather than
specific entries? That's the purpose of the existing io_rsrc_node refs
field.

>
> This is a preparatory patch for fuse io-uring's usage of fixed buffers.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/io_uring/buf.h   | 13 +++++++++++
>  include/linux/io_uring_types.h |  9 ++++++++
>  io_uring/rsrc.c                | 42 ++++++++++++++++++++++++++++++++++
>  3 files changed, 64 insertions(+)
>
> diff --git a/include/linux/io_uring/buf.h b/include/linux/io_uring/buf.h
> index 7a1cf197434d..c997c01c24c4 100644
> --- a/include/linux/io_uring/buf.h
> +++ b/include/linux/io_uring/buf.h
> @@ -9,6 +9,9 @@ int io_uring_buf_ring_pin(struct io_ring_ctx *ctx, unsign=
ed buf_group,
>                           unsigned issue_flags, struct io_buffer_list **b=
l);
>  int io_uring_buf_ring_unpin(struct io_ring_ctx *ctx, unsigned buf_group,
>                             unsigned issue_flags);
> +
> +int io_uring_buf_table_pin(struct io_ring_ctx *ctx, unsigned issue_flags=
);
> +int io_uring_buf_table_unpin(struct io_ring_ctx *ctx, unsigned issue_fla=
gs);
>  #else
>  static inline int io_uring_buf_ring_pin(struct io_ring_ctx *ctx,
>                                         unsigned buf_group,
> @@ -23,6 +26,16 @@ static inline int io_uring_buf_ring_unpin(struct io_ri=
ng_ctx *ctx,
>  {
>         return -EOPNOTSUPP;
>  }
> +static inline int io_uring_buf_table_pin(struct io_ring_ctx *ctx,
> +                                        unsigned issue_flags)
> +{
> +       return -EOPNOTSUPP;
> +}
> +static inline int io_uring_buf_table_unpin(struct io_ring_ctx *ctx,
> +                                          unsigned issue_flags)
> +{
> +       return -EOPNOTSUPP;
> +}
>  #endif /* CONFIG_IO_URING */
>
>  #endif /* _LINUX_IO_URING_BUF_H */
> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_type=
s.h
> index 36fac08db636..e1a75cfe57d9 100644
> --- a/include/linux/io_uring_types.h
> +++ b/include/linux/io_uring_types.h
> @@ -57,8 +57,17 @@ struct io_wq_work {
>         int cancel_seq;
>  };
>
> +/*
> + * struct io_rsrc_data flag values:
> + *
> + * IO_RSRC_DATA_PINNED: data is pinned and cannot be unregistered by use=
rspace
> + * until it has been unpinned. Currently this is only possible on buffer=
 tables.
> + */
> +#define IO_RSRC_DATA_PINNED            BIT(0)
> +
>  struct io_rsrc_data {
>         unsigned int                    nr;
> +       u8                              flags;
>         struct io_rsrc_node             **nodes;
>  };
>
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index 3765a50329a8..67331cae0a5a 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -9,6 +9,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/compat.h>
>  #include <linux/io_uring.h>
> +#include <linux/io_uring/buf.h>
>  #include <linux/io_uring/cmd.h>
>
>  #include <uapi/linux/io_uring.h>
> @@ -304,6 +305,8 @@ static int __io_sqe_buffers_update(struct io_ring_ctx=
 *ctx,
>                 return -ENXIO;
>         if (up->offset + nr_args > ctx->buf_table.nr)
>                 return -EINVAL;
> +       if (ctx->buf_table.flags & IO_RSRC_DATA_PINNED)
> +               return -EBUSY;

IORING_REGISTER_CLONE_BUFFERS can also be used to unregister existing
buffers, so it may need the check too?

>
>         for (done =3D 0; done < nr_args; done++) {
>                 struct io_rsrc_node *node;
> @@ -615,6 +618,8 @@ int io_sqe_buffers_unregister(struct io_ring_ctx *ctx=
)
>  {
>         if (!ctx->buf_table.nr)
>                 return -ENXIO;
> +       if (ctx->buf_table.flags & IO_RSRC_DATA_PINNED)
> +               return -EBUSY;

io_buffer_unregister_bvec() can also be used to unregister ublk
zero-copy buffers (also under control of userspace), so it may need
the check too? But maybe fuse ensures that it never uses a ublk
zero-copy buffer?

Best,
Caleb

>         io_rsrc_data_free(ctx, &ctx->buf_table);
>         return 0;
>  }
> @@ -1580,3 +1585,40 @@ int io_prep_reg_iovec(struct io_kiocb *req, struct=
 iou_vec *iv,
>         req->flags |=3D REQ_F_IMPORT_BUFFER;
>         return 0;
>  }
> +
> +int io_uring_buf_table_pin(struct io_ring_ctx *ctx, unsigned issue_flags=
)
> +{
> +       struct io_rsrc_data *data;
> +       int err =3D 0;
> +
> +       io_ring_submit_lock(ctx, issue_flags);
> +
> +       data =3D &ctx->buf_table;
> +       /* There was nothing registered. There is nothing to pin */
> +       if (!data->nr)
> +               err =3D -ENXIO;
> +       else
> +               data->flags |=3D IO_RSRC_DATA_PINNED;
> +
> +       io_ring_submit_unlock(ctx, issue_flags);
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(io_uring_buf_table_pin);
> +
> +int io_uring_buf_table_unpin(struct io_ring_ctx *ctx, unsigned issue_fla=
gs)
> +{
> +       struct io_rsrc_data *data;
> +       int err =3D 0;
> +
> +       io_ring_submit_lock(ctx, issue_flags);
> +
> +       data =3D &ctx->buf_table;
> +       if (WARN_ON_ONCE(!(data->flags & IO_RSRC_DATA_PINNED)))
> +               err =3D -EINVAL;
> +       else
> +               data->flags &=3D ~IO_RSRC_DATA_PINNED;
> +
> +       io_ring_submit_unlock(ctx, issue_flags);
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(io_uring_buf_table_unpin);
> --
> 2.47.3
>

