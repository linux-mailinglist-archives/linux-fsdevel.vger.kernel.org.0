Return-Path: <linux-fsdevel+bounces-65867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E31BC128BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 02:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 959F74FB94A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 01:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E25224B12;
	Tue, 28 Oct 2025 01:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FGNEZCHp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED48226165
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 01:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614932; cv=none; b=lz2AX99vEvKrFxzwNLbNeTo3puFPCsuU0ouM2vMPYYvGS6ixgBMlrAF8K+3qYaGVmdzCFOR0nC5GhpeF+hzCKWI5OBrtkBIR5+wFJ3siDCvwIrgV3uvENvh2JXgRpm+1Jvv1X9A9sQOmh8l+QvQe2kN4bMcEA/6tndXfWpphm/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614932; c=relaxed/simple;
	bh=gbd9UyTX62Ejbh1VX2a7DVx+LkH5WbkiuoydGDFc7vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHJuOqP1BBQwvSWkLUzMnTKlE26R2B/+GnCVkfC8ttOB1tq59ac8HUW8ryyho/GxjAATnJPGddf58rPh0zkrJFgMp4bxGouEJxsK/o4HaJn0nm0zHNOD2H2TemsltJRhTNRAjfHJrixuFZZSdQYL39lKiDqyd6zSnoJAVq0VkVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FGNEZCHp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29245cb814cso11831355ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 18:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761614929; x=1762219729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HildVhXOPZy2bNHRfKprn8B+VXTfXr+xDTtAxxPhxTA=;
        b=FGNEZCHp0X0nvhmFV6z93+s2ioAhVKlR7ibLGcplrqrKqfekt+gYsGoeaxHv61sBxY
         ejlOI8dVNbiiMft/OkpXp9Jmn91nprSYTCIBcpR6ih2FgXDgNaVuqqY2TKahf2b0+BgV
         mf50B1X6kVSCX0BmHIT2W/QdyQXDB/peSrR5sDHHe1f0Wi5Ez0ft4WtVc6owQuhE7XQ1
         Qz92zJtolfOaT05HhU+hyKRSu9Yl6I9RJzb/Bub9dQtAAVnzG/sG7Ku0qUoZa9TsstMc
         HmCCKpRFJHy3zJWZvfFjqs6WQXDdyn3KFh3Ihkn6bOzgGezyr3T5pTmHF4kj2l8oxGdp
         gwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761614929; x=1762219729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HildVhXOPZy2bNHRfKprn8B+VXTfXr+xDTtAxxPhxTA=;
        b=Ioiv1oXKEnNUJcVlL5mRqth0BjlvX9e85ULhR6Ue9Tq3RwQ9RKegLtuu9Q2v42U475
         vE4BV3RmqgDa7tN9lXxVLwIsgZV1IttHM79T5siPCJpnq0Bqjza2JmfhbmwuPVdzJz7t
         cZlm13tMQtxVzkzgHt4GdUATn5KENSisyXVXul7jRc5oEspPX9Y/b+lWItt3Hx1zw2sp
         KhFPDsuU3i2N1iASc0ACHgWqTu6//o0eYTn5rMQLFsregukSoknPY/VFMrLGQFwf6J1c
         mReofj3LyXPPzJJsnCCSPzmnkMhvAYEX9pYw6NwsP69tw0RsPBn91tGQPU893prY+68R
         MS/w==
X-Forwarded-Encrypted: i=1; AJvYcCXO7nF3j7hmxzQ4gb4govw36Rph7arQSWjut5+PbWVFmuOjBOYcG7MJdgUVHyzXY27Tb8NYvRuv8kCyVyb2@vger.kernel.org
X-Gm-Message-State: AOJu0YyNqRb6CTIRPzdZnM09irdu273tmZhkT5GDN0HKJxihQbxq+SDr
	Jv+8vntdBrgqawEli4sIAjk/ysay5Q2XHdIBc857mBr80KE45kgViItPqDnNKrxg2Z+e7wFbSKe
	jc94cxLPlBPKiTGhd8W3AgyhfY19oQGcA40U0G5n7kQ==
X-Gm-Gg: ASbGncs5F7rGj2p79izr7kUDhCGX5PafYWYsIDUss46mufTVkIp6VeAtNvt2hYg6R5R
	t4ovPQ/Ts30/L+xfAEtI1Xbpqta4qhCBO9fLga5la/oe6Zjwn5qhcxEQQdwbQUSa+lk2ihoiiiE
	fqpziMPpjyxGoPynzJb152ypmneYgWNq+4l772OWiNsb5H1ww5wmSEeUu3nZaW59a7VxLYccFqU
	35U5GbxYvSW0L60Z6g4w+y7GrcSznBX4fkoKvaJ16xYNKkZiy7hoh80zsIGL/2e3JOuS+aHw1hl
	U2LCdQgHTIfaMJ6s5A==
X-Google-Smtp-Source: AGHT+IE5kP2a7j3ZfZ0pvv7/KlWsWF2NIisUK0eWeToAafFD7Tg2AyFiYuyVy5T6Ty90ceXd/SBmjzeBmXUGH6fTLr4=
X-Received: by 2002:a17:903:384c:b0:264:cda8:7fd3 with SMTP id
 d9443c01a7336-294cb3e8b60mr10989895ad.6.1761614929436; Mon, 27 Oct 2025
 18:28:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027222808.2332692-1-joannelkoong@gmail.com> <20251027222808.2332692-2-joannelkoong@gmail.com>
In-Reply-To: <20251027222808.2332692-2-joannelkoong@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 27 Oct 2025 18:28:37 -0700
X-Gm-Features: AWmQ_bl9l9O-aIdCcUsnkuMreMHnQ1lQO1-dNrmN8uyT5crrDTF4_uPFeWnUewU
Message-ID: <CADUfDZphGYTPxZvEZm8ZZej0J58TzTVHRHJD0wNBoHKOWyMhMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] io_uring/uring_cmd: add io_uring_cmd_import_fixed_full()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, linux-fsdevel@vger.kernel.org, 
	bschubert@ddn.com, asml.silence@gmail.com, io-uring@vger.kernel.org, 
	xiaobing.li@samsung.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 3:29=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Add an API for fetching the registered buffer associated with a
> io_uring cmd. This is useful for callers who need access to the buffer
> but do not have prior knowledge of the buffer's user address or length.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/io_uring/cmd.h |  3 +++
>  io_uring/rsrc.c              | 14 ++++++++++++++
>  io_uring/rsrc.h              |  2 ++
>  io_uring/uring_cmd.c         | 13 +++++++++++++
>  4 files changed, 32 insertions(+)
>
> diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> index 7509025b4071..8c11d9a92733 100644
> --- a/include/linux/io_uring/cmd.h
> +++ b/include/linux/io_uring/cmd.h
> @@ -43,6 +43,9 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long l=
en, int rw,
>                               struct iov_iter *iter,
>                               struct io_uring_cmd *ioucmd,
>                               unsigned int issue_flags);
> +int io_uring_cmd_import_fixed_full(int rw, struct iov_iter *iter,
> +                                  struct io_uring_cmd *ioucmd,
> +                                  unsigned int issue_flags);
>  int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
>                                   const struct iovec __user *uvec,
>                                   size_t uvec_segs,
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index d787c16dc1c3..2c3d8489ae52 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -1147,6 +1147,20 @@ int io_import_reg_buf(struct io_kiocb *req, struct=
 iov_iter *iter,
>         return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
>  }
>
> +int io_import_reg_buf_full(struct io_kiocb *req, struct iov_iter *iter,
> +                          int ddir, unsigned issue_flags)
> +{
> +       struct io_rsrc_node *node;
> +       struct io_mapped_ubuf *imu;
> +
> +       node =3D io_find_buf_node(req, issue_flags);
> +       if (!node)
> +               return -EFAULT;
> +
> +       imu =3D node->buf;
> +       return io_import_fixed(ddir, iter, imu, imu->ubuf, imu->len);

It's probably possible to avoid the logic in io_import_fixed() for
checking the user address range against the registered buffer's range
and offsetting the iov_iter, but that could always be done as future
optimization work.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> +}
> +
>  /* Lock two rings at once. The rings must be different! */
>  static void lock_two_rings(struct io_ring_ctx *ctx1, struct io_ring_ctx =
*ctx2)
>  {
> diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
> index a3ca6ba66596..4e01eb0f277e 100644
> --- a/io_uring/rsrc.h
> +++ b/io_uring/rsrc.h
> @@ -64,6 +64,8 @@ struct io_rsrc_node *io_find_buf_node(struct io_kiocb *=
req,
>  int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
>                         u64 buf_addr, size_t len, int ddir,
>                         unsigned issue_flags);
> +int io_import_reg_buf_full(struct io_kiocb *req, struct iov_iter *iter,
> +                          int ddir, unsigned issue_flags);
>  int io_import_reg_vec(int ddir, struct iov_iter *iter,
>                         struct io_kiocb *req, struct iou_vec *vec,
>                         unsigned nr_iovs, unsigned issue_flags);
> diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> index d1e3ba62ee8e..07730ced9449 100644
> --- a/io_uring/uring_cmd.c
> +++ b/io_uring/uring_cmd.c
> @@ -292,6 +292,19 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned lon=
g len, int rw,
>  }
>  EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
>
> +int io_uring_cmd_import_fixed_full(int rw, struct iov_iter *iter,
> +                                  struct io_uring_cmd *ioucmd,
> +                                  unsigned int issue_flags)
> +{
> +       struct io_kiocb *req =3D cmd_to_io_kiocb(ioucmd);
> +
> +       if (WARN_ON_ONCE(!(ioucmd->flags & IORING_URING_CMD_FIXED)))
> +               return -EINVAL;
> +
> +       return io_import_reg_buf_full(req, iter, rw, issue_flags);
> +}
> +EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed_full);
> +
>  int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
>                                   const struct iovec __user *uvec,
>                                   size_t uvec_segs,
> --
> 2.47.3
>

