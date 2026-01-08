Return-Path: <linux-fsdevel+bounces-72940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D008AD06274
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 21:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1644A300D91D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 20:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800D2330641;
	Thu,  8 Jan 2026 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Di1Zo7kY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F532E72F
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767905080; cv=pass; b=rXX6gVbVMPn1KDw+lIMYAkz7pvEovPlFtcsumbsK7B83+U1TxvUgcUsxLWTaFS2HUlMFyW2Jqeirq0OTr41KFIwWEiDc+cHZ3vbUzLm15JLK2POCgHOp4Fl/B0x+Pb2BkI0YEM4JTjPQ5VSuZNATnm8LqxS2LIV7rU4i46j5EQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767905080; c=relaxed/simple;
	bh=k1XBSbFb7cmHPMCntpYacEARNpC62HmflhB0LJjsUQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn5kekoF16Ug4VRTBIWF+cae+Gy97OU5lafWlEOzh24w13icDOhFVaAelPUx8FNuCbD8d/3TUPerQonydwXREgRUAClkU1yFSWsHCd+k16f+XFqezYumDrIyKjJOd8MK4Y8tGpvryD0zKvPnH6/1DGAAVMzTGfKkw03XDKuhUZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Di1Zo7kY; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ac37f8898eso68423eec.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 12:44:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767905077; cv=none;
        d=google.com; s=arc-20240605;
        b=FEUQz3pOjtE+p41X9GThJR810e01/4yMk/vQST4RsG4Q1a2M/CdfFVDRm+751B7Ctu
         b/KQLGXaTYBsPv9bynzlIMUgN6GI7MU1cuBpKx1qIrb0qzkV1UqhgNEN2VZewSouMwSh
         VM4yljnmbz1TjrzZfXTSnhWeY2QKyNBWBS8Jdc6oZD9nWgTl5TsMMoYigSXRK+W8wjNa
         5rExlUG85PCoqilBNRIh43iN2NMYjNL3eWnsDTsv4tVAmyAJjW9FeThuSvD5EACVO8iT
         5c92Ew13G42Xgrfu0ljKBtnoA9vQtw4sXXFxheuo2/WbgNUe+dAI9lit0m8mS5gg8qEq
         Qxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pW7sigX15hN6avzy6UTnxYB3uk3gvQPCeFOj5yzWtKA=;
        fh=Rzs/tzG3VIgNC1jvWSd8bA+ZOOJ0tRurjvsTwFWgX88=;
        b=ILkmScPgqdYLhyBib6rWh5svWDPg53LheGb/odn7p/V+AEiXrh6V3BYSGoJkd2cEra
         3xCPXq1Xojby9YyAyJS8W41hVIpLNolvclfPagdrelJ4uuLoybWTBnFA92PSkUASUA8x
         XdUtmhS/PagwQccq3FMcrq1/LwUdjTsOwbbnMota5Kz+20QjpbfSv97Pg5xqnVX9TpA1
         Gsk7/Ng7hx+BpqGf0L9NACam6cBX1n6EWium6XO0gnl/XqQgCHrgjQubIkYyWcsF1BNU
         s1qvoZKebCR9vMegGRWYmDh+L6faPCOCkldz6QnlSG/kL42xh4pxSMiRm5Unowc9EYcq
         x1Dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767905077; x=1768509877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW7sigX15hN6avzy6UTnxYB3uk3gvQPCeFOj5yzWtKA=;
        b=Di1Zo7kYw5eY9ly44Bo+emYczGIspYSmKSLRfLGnjjaAljb/EmIjE+JM2RkqEjOc+a
         Bd4JvWXWO3eI1W+DVQuicpTrvq++WJfugqehtzxEiz4kwD1WND+OWaPicmpkwlRN++1u
         6wxt8y8nNFjnNDWnYA9HXGYhPLjWNGhT7PfZGCh615He6TFi3C/TGK/ucfHZx4Hu8uTz
         gw5Hhh8AqseFm3EEcMWsAeP53h/8ROhGuFylrag9vTC7w4YZVB70nV9C+5j6J5NJyniT
         JQhCMZ7MzVvdDpwRkiNXiA7j5kjUTpB3mYswFZhdzuNM9/of3jOhKhAudkPGqRnQ/hao
         pubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767905077; x=1768509877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pW7sigX15hN6avzy6UTnxYB3uk3gvQPCeFOj5yzWtKA=;
        b=VdekUCK8bTJjOiUpNdeVc2z6J92ccDkWyPSbDTY111q3IIyqqrvzL2k6JOspDpRhI7
         jXnbhxVOB8RU22kV7rM81LccCe42ivBAZcvlHaffdFYpMHJssJpO2HXVtwSruSeZy07r
         oqR9269SwY0Qvh1eCWEa1Wc2nfh4lb/yT37sSlGXYKuUuge17bDC95d+80D7/ELQlXzc
         knoRscsbwd7Oa2nTc0u5UwhpXNVTuHzHtAD6N0Gg0mR0RptFWCcj/O83+nAfUGgpnSVo
         6zYlPH3ZRBEUFabdS5AD7Joof4SzflGJyLg0At25q2q6TI5SV36JyxZH/A+1WTdxrUfr
         5OMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4MXs7mrkuizZfnFQdajPZG7b4a3WyP1zEUrZjYpt4UtHBEQGxq/kBN+musuBksSkA0Se9AdbPWWo978oH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpi6ZB8l0MOXl2eouVQemtB1HqTnD7oJ8rzd2Dk67/YEYiQjOa
	vzxAaP5eKhNwZ+TFYi+RtooStzx5RCKqQS8u2IY9o/UaFUJnWZQ9YehVSsm5JKVPPrRBYgg6tz7
	/ybyjsHX0az5XqG0JCl3K2ZELF2YlXNI144gyg5jgAQ==
X-Gm-Gg: AY/fxX4gALWftdU+h7Bbh5EY1h8tPb1itP/A6yYIqmbcjp9hEKyXF/vRjysB63/VXGs
	J50UFW9U0/PCFueQp5ivPgwX20PLTwFtLJVMA46nStb7rrUifkZbrZt+rLhYqgTY5+RO7nmNF57
	ZBdk56KR7UR7Ds2XSwZPxy63zMMONFmTgcWgt+9p0aEtycM5PUbHSBEEScFLycx590wthVobHaV
	tFEWJ/i41w1CfU5VehuYo2EX+gKX5RrinKR6kkoC8kscRzCguROCraqSm4BIHDyfb750UFe
X-Google-Smtp-Source: AGHT+IFE/V4GLet/VjNoARbIbfq0zl4sxuh0zJPSjisd5kuQ0/iDtfgF0YgzI1g7MysaPIeJfGRLiHczVi6k32R3M4w=
X-Received: by 2002:a05:7022:b9e:b0:122:8d:39d8 with SMTP id
 a92af1059eb24-122008d3f76mr1437659c88.6.1767905077263; Thu, 08 Jan 2026
 12:44:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
 <20251223003522.3055912-9-joannelkoong@gmail.com> <CADUfDZpdNNYdNnrPWviGYPViQ6O_S4S0hB7Hg56+wnQDgnXwAQ@mail.gmail.com>
In-Reply-To: <CADUfDZpdNNYdNnrPWviGYPViQ6O_S4S0hB7Hg56+wnQDgnXwAQ@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 8 Jan 2026 12:44:25 -0800
X-Gm-Features: AQt7F2p5vHzm4rpOv0lZNbi3GBrpBZbr7bmBEEtnT13leQSwA8xliVgiupyXOKo
Message-ID: <CADUfDZpo06_FNCvYy+s0hi+vtUbWozeASv6ojxERqv=LMtQK2w@mail.gmail.com>
Subject: Re: [PATCH v3 08/25] io_uring: add io_uring_cmd_fixed_index_get() and io_uring_cmd_fixed_index_put()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 11:02=E2=80=AFAM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Mon, Dec 22, 2025 at 4:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > Add two new helpers, io_uring_cmd_fixed_index_get() and
> > io_uring_cmd_fixed_index_put(). io_uring_cmd_fixed_index_get()
> > constructs an iter for a fixed buffer at a given index and acquires a
> > refcount on the underlying node. io_uring_cmd_fixed_index_put()
> > decrements this refcount. The caller is responsible for ensuring
> > io_uring_cmd_fixed_index_put() is properly called for releasing the
> > refcount after it is done using the iter it obtained through
> > io_uring_cmd_fixed_index_get().
> >
> > This is a preparatory patch needed for fuse-over-io-uring support, as
> > the metadata for fuse requests will be stored at the last index, which
> > will be different from the buf index set on the sqe.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/io_uring/cmd.h | 20 +++++++++++
> >  io_uring/rsrc.c              | 65 ++++++++++++++++++++++++++++++++++++
> >  io_uring/rsrc.h              |  5 +++
> >  io_uring/uring_cmd.c         | 21 ++++++++++++
> >  4 files changed, 111 insertions(+)
> >
> > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.=
h
> > index 7169a2a9a744..2988592e045c 100644
> > --- a/include/linux/io_uring/cmd.h
> > +++ b/include/linux/io_uring/cmd.h
> > @@ -44,6 +44,12 @@ int io_uring_cmd_import_fixed_vec(struct io_uring_cm=
d *ioucmd,
> >                                   size_t uvec_segs,
> >                                   int ddir, struct iov_iter *iter,
> >                                   unsigned issue_flags);
> > +int io_uring_cmd_fixed_index_get(struct io_uring_cmd *ioucmd, u16 buf_=
index,
> > +                                unsigned int off, size_t len, int ddir=
,
> > +                                struct iov_iter *iter,
> > +                                unsigned int issue_flags);
> > +int io_uring_cmd_fixed_index_put(struct io_uring_cmd *ioucmd, u16 buf_=
index,
> > +                                unsigned int issue_flags);
> >
> >  /*
> >   * Completes the request, i.e. posts an io_uring CQE and deallocates @=
ioucmd
> > @@ -109,6 +115,20 @@ static inline int io_uring_cmd_import_fixed_vec(st=
ruct io_uring_cmd *ioucmd,
> >  {
> >         return -EOPNOTSUPP;
> >  }
> > +static inline int io_uring_cmd_fixed_index_get(struct io_uring_cmd *io=
ucmd,
> > +                                              u16 buf_index, unsigned =
int off,
> > +                                              size_t len, int ddir,
> > +                                              struct iov_iter *iter,
> > +                                              unsigned int issue_flags=
)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> > +static inline int io_uring_cmd_fixed_index_put(struct io_uring_cmd *io=
ucmd,
> > +                                              u16 buf_index,
> > +                                              unsigned int issue_flags=
)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> >  static inline void __io_uring_cmd_done(struct io_uring_cmd *cmd, s32 r=
et,
> >                 u64 ret2, unsigned issue_flags, bool is_cqe32)
> >  {
> > diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> > index a63474b331bf..a141aaeb099d 100644
> > --- a/io_uring/rsrc.c
> > +++ b/io_uring/rsrc.c
> > @@ -1151,6 +1151,71 @@ int io_import_reg_buf(struct io_kiocb *req, stru=
ct iov_iter *iter,
> >         return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
> >  }
> >
> > +int io_reg_buf_index_get(struct io_kiocb *req, struct iov_iter *iter,
> > +                        u16 buf_index, unsigned int off, size_t len,
> > +                        int ddir, unsigned issue_flags)
> > +{
> > +       struct io_ring_ctx *ctx =3D req->ctx;
> > +       struct io_rsrc_node *node;
> > +       struct io_mapped_ubuf *imu;
> > +       u64 addr;
> > +       int err;
> > +
> > +       io_ring_submit_lock(ctx, issue_flags);
> > +
> > +       node =3D io_rsrc_node_lookup(&ctx->buf_table, buf_index);
> > +       if (!node) {
> > +               io_ring_submit_unlock(ctx, issue_flags);
> > +               return -EINVAL;
> > +       }
> > +
> > +       node->refs++;
> > +
> > +       io_ring_submit_unlock(ctx, issue_flags);
> > +
> > +       imu =3D node->buf;
> > +       if (!imu) {
> > +               err =3D -EFAULT;
> > +               goto error;
> > +       }
> > +
> > +       if (check_add_overflow(imu->ubuf, off, &addr)) {
> > +               err =3D -EINVAL;
> > +               goto error;
> > +       }
> > +
> > +       err =3D io_import_fixed(ddir, iter, imu, addr, len);
> > +       if (err)
> > +               goto error;
> > +
> > +       return 0;
> > +
> > +error:
> > +       io_reg_buf_index_put(req, buf_index, issue_flags);
> > +       return err;
> > +}
> > +
> > +int io_reg_buf_index_put(struct io_kiocb *req, u16 buf_index,
> > +                        unsigned issue_flags)
> > +{
> > +       struct io_ring_ctx *ctx =3D req->ctx;
> > +       struct io_rsrc_node *node;
> > +
> > +       io_ring_submit_lock(ctx, issue_flags);
> > +
> > +       node =3D io_rsrc_node_lookup(&ctx->buf_table, buf_index);
>
> Hmm, I don't think it's safe to assume this node looked up by
> buf_index matches the one obtained in io_reg_buf_index_get(). Since
> the uring_lock is released between io_reg_buf_index_get() and
> io_reg_buf_index_put(), an intervening IORING_REGISTER_BUFFERS_UPDATE
> operation may modify the node at buf_index in the buf_table. That
> could result in a reference decrement on the wrong node, resulting in
> the new node being freed while still in use.
> Can we return the struct io_rsrc_node * from io_reg_buf_index_get()
> and pass it to io_reg_buf_index_put() in place of buf_index?

Alternatively, store the struct io_rsrc_node * in the struct io_kiocb,
as io_find_buf_node() does? Then you wouldn't even need to call
io_reg_buf_index_put(); io_uring would automatically release the
buffer node reference upon completion of the request. The only reason
I can see why that wouldn't work is if a single fuse io_uring_cmd
needs to import multiple registered buffers. But it doesn't look like
that's the case from my quick skim of the fuse code.

