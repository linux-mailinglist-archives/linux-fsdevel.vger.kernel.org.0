Return-Path: <linux-fsdevel+bounces-72966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9102ED06A7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 01:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FBC030318EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 00:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EF51F09B3;
	Fri,  9 Jan 2026 00:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjlL6kxg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77671AF0AF
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 00:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767920129; cv=none; b=Jv/BYCVskoEjYxOfB+2Kzoutztmz7YZGwECuPGs0Pte47KdESWWI10ET5ubpyPCJmarlkWSqO2gkgswjBC3StXgheenDhhFTy6jRDGgMXSb+qr4pbL0rPpnv36tquN4BzJWzheX5S7TY3hPjqfmqUNa6V87dIEnasnR58oSeOG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767920129; c=relaxed/simple;
	bh=EXttu5V0AlVDTEJdsEajLfBbKh/usX+AZxj3KEDKK0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=co6EcqkGcvO+nUyRkozfDeOBgZTQNWDF+99uin7wrKcMjpnJ9Vh4/puhxrtzJknXg2w6HJOTv4D62dOHq7pYTQeP0Fwt2cyH2LVmNryLPLTGCE7p+5PwiJh/vXYjzEhPOugYaOsiWruYuwaoF5q9Vol4qYsi3AMsiRX6RemdoqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjlL6kxg; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed82ee9e57so47434791cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 16:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767920127; x=1768524927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mHYLGF76I63Y0aeKQKybHEwwKROCpsPwXjzV5dOyf0=;
        b=AjlL6kxgsU74yn0tatzGxQ/pPR1Ut7ofqbARl5SCtYJmB0QNY7cySslLmpOc/7gWU5
         cwteU4MjHAqsb3mh0z3QpUAS2sZonOg8Fl65LhOLqNf1JfKJOk5ytHn6gHs5nVyrYf98
         aRZjImTOwq2nSzvCqmZv8qJyQPgt2gpQDcppByZtVopBfVZ68q01okCgx/vrrVnFpsOV
         H0DTMNDeAHLM8WlwBZudeheblcDdZ+uP+vbZ8WVNcCpDzJb57TBnlnLxxdXoiaepNEHM
         CkG8XKnVT35r86twQNt3qpxpdINP6wNqVzxk7jIDMclqp6ak8W/TGVOn3BLHnawrVUw4
         MbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767920127; x=1768524927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9mHYLGF76I63Y0aeKQKybHEwwKROCpsPwXjzV5dOyf0=;
        b=UT10QsK4PP4ojdcZ5PriS7yjnLJrcCPaoYdFEA21ljj5+4cSToiFHKVdPzgNXFMqdU
         pTtF0w516WebpgH1a04ipYysfEaqDj2rbzXHEHgqPlDhnWKp7VCYk5keNIKoQRbwx9oP
         r/JDFiKirzVajYzeK7hmaF54PuohtyVNj0lBAMOcPyZsIe2l80TLVcY5rY5EbpCbwYgf
         /AHheF4/EcQ8WoFaiwtIBXBuYH3rSMuDaV12LcTZv8WMSMD09Mr/iQzOa10h+D0GuRJF
         b9ijhSTK2VpIKuMAz6p3ECaPgyxG67fLsVRvomR1yyXOTvPou0i75L8m65IXDGDkiOMB
         oOSA==
X-Forwarded-Encrypted: i=1; AJvYcCWTjt4BdvThTv8fdXshNrM8sclItCVCu2OGG45+KbYhLFeZnvhr/z3nn+fQXIIvaL/UiiwhQ3CM9m7xH1lD@vger.kernel.org
X-Gm-Message-State: AOJu0YzAdVTLQb3/e6exH9XnerBrH6Zwk0gFPmwIBZ8iw2k/zOho+TJJ
	96k7aJJksdEDGizP4mb/4IimG+02TsdlQUdAHTBM19vi/U9wgcocKBxN3rvmccbzDFlpg9vHBw9
	5uBfpaZYHf74qzwBmgy7hrVUWYUMmXbLq+6+u
X-Gm-Gg: AY/fxX6gSLYyIVOh2J2Ifz1w/Olu60ZFbiyNr3e/67B2u4K0mB5twjiEM71hpTT7tMc
	5RV5qNemIySOCLTS4XCYMvrTsaJxVFOVLKJ48d7Yepst0bzUYaDJR9xeiQInhhTHswHMFfjrDz/
	gePG6Jh4IjGrwvblUhRGDjHzTbvkaAlTj7WbVVE311sh5J2OvOt/CV6fTbNAwKZwPg2F0RuX+aW
	x482U3tLxUZPPWTSezTDXIzz8ZD0Zgwqvjw/g9mBwHiGD27UeAbBlZvWo6fHLGGkDhaiQ==
X-Google-Smtp-Source: AGHT+IHji8ol9qOQt+esnNq6+xTKJsi3g+GCS7/wfxpHk8D4TUM3GHk9VC+OclwfUv+CeucdDYA6Xzn009yJzaHcxnk=
X-Received: by 2002:ac8:7f54:0:b0:4fb:f92d:bc8b with SMTP id
 d75a77b69052e-4ffb4849f20mr107099261cf.18.1767920126789; Thu, 08 Jan 2026
 16:55:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223003522.3055912-1-joannelkoong@gmail.com>
 <20251223003522.3055912-9-joannelkoong@gmail.com> <CADUfDZpdNNYdNnrPWviGYPViQ6O_S4S0hB7Hg56+wnQDgnXwAQ@mail.gmail.com>
 <CADUfDZpo06_FNCvYy+s0hi+vtUbWozeASv6ojxERqv=LMtQK2w@mail.gmail.com>
In-Reply-To: <CADUfDZpo06_FNCvYy+s0hi+vtUbWozeASv6ojxERqv=LMtQK2w@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 8 Jan 2026 16:55:15 -0800
X-Gm-Features: AQt7F2qtVB5FILH8AiI3x5on-p6f1OKdL7i4mYVf_NmhEYA6f7gD0vlqUnJdxoc
Message-ID: <CAJnrk1aC6x=NppNZX+3iit5weO-oPULfFEq2D=9vDAA-TBuFtw@mail.gmail.com>
Subject: Re: [PATCH v3 08/25] io_uring: add io_uring_cmd_fixed_index_get() and io_uring_cmd_fixed_index_put()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 12:44=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Thu, Jan 8, 2026 at 11:02=E2=80=AFAM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Mon, Dec 22, 2025 at 4:36=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > >
> > > Add two new helpers, io_uring_cmd_fixed_index_get() and
> > > io_uring_cmd_fixed_index_put(). io_uring_cmd_fixed_index_get()
> > > constructs an iter for a fixed buffer at a given index and acquires a
> > > refcount on the underlying node. io_uring_cmd_fixed_index_put()
> > > decrements this refcount. The caller is responsible for ensuring
> > > io_uring_cmd_fixed_index_put() is properly called for releasing the
> > > refcount after it is done using the iter it obtained through
> > > io_uring_cmd_fixed_index_get().
> > >
> > > This is a preparatory patch needed for fuse-over-io-uring support, as
> > > the metadata for fuse requests will be stored at the last index, whic=
h
> > > will be different from the buf index set on the sqe.
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> > >  include/linux/io_uring/cmd.h | 20 +++++++++++
> > >  io_uring/rsrc.c              | 65 ++++++++++++++++++++++++++++++++++=
++
> > >  io_uring/rsrc.h              |  5 +++
> > >  io_uring/uring_cmd.c         | 21 ++++++++++++
> > >  4 files changed, 111 insertions(+)
> > >
> > > diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> > > index a63474b331bf..a141aaeb099d 100644
> > > --- a/io_uring/rsrc.c
> > > +++ b/io_uring/rsrc.c
> > > @@ -1151,6 +1151,71 @@ int io_import_reg_buf(struct io_kiocb *req, st=
ruct iov_iter *iter,
> > >         return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
> > >  }
> > >
> > > +int io_reg_buf_index_get(struct io_kiocb *req, struct iov_iter *iter=
,
> > > +                        u16 buf_index, unsigned int off, size_t len,
> > > +                        int ddir, unsigned issue_flags)
> > > +{
> > > +       struct io_ring_ctx *ctx =3D req->ctx;
> > > +       struct io_rsrc_node *node;
> > > +       struct io_mapped_ubuf *imu;
> > > +       u64 addr;
> > > +       int err;
> > > +
> > > +       io_ring_submit_lock(ctx, issue_flags);
> > > +
> > > +       node =3D io_rsrc_node_lookup(&ctx->buf_table, buf_index);
> > > +       if (!node) {
> > > +               io_ring_submit_unlock(ctx, issue_flags);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       node->refs++;
> > > +
> > > +       io_ring_submit_unlock(ctx, issue_flags);
> > > +
> > > +       imu =3D node->buf;
> > > +       if (!imu) {
> > > +               err =3D -EFAULT;
> > > +               goto error;
> > > +       }
> > > +
> > > +       if (check_add_overflow(imu->ubuf, off, &addr)) {
> > > +               err =3D -EINVAL;
> > > +               goto error;
> > > +       }
> > > +
> > > +       err =3D io_import_fixed(ddir, iter, imu, addr, len);
> > > +       if (err)
> > > +               goto error;
> > > +
> > > +       return 0;
> > > +
> > > +error:
> > > +       io_reg_buf_index_put(req, buf_index, issue_flags);
> > > +       return err;
> > > +}
> > > +
> > > +int io_reg_buf_index_put(struct io_kiocb *req, u16 buf_index,
> > > +                        unsigned issue_flags)
> > > +{
> > > +       struct io_ring_ctx *ctx =3D req->ctx;
> > > +       struct io_rsrc_node *node;
> > > +
> > > +       io_ring_submit_lock(ctx, issue_flags);
> > > +
> > > +       node =3D io_rsrc_node_lookup(&ctx->buf_table, buf_index);
> >
> > Hmm, I don't think it's safe to assume this node looked up by
> > buf_index matches the one obtained in io_reg_buf_index_get(). Since
> > the uring_lock is released between io_reg_buf_index_get() and
> > io_reg_buf_index_put(), an intervening IORING_REGISTER_BUFFERS_UPDATE
> > operation may modify the node at buf_index in the buf_table. That
> > could result in a reference decrement on the wrong node, resulting in
> > the new node being freed while still in use.
> > Can we return the struct io_rsrc_node * from io_reg_buf_index_get()
> > and pass it to io_reg_buf_index_put() in place of buf_index?
>
> Alternatively, store the struct io_rsrc_node * in the struct io_kiocb,
> as io_find_buf_node() does? Then you wouldn't even need to call
> io_reg_buf_index_put(); io_uring would automatically release the
> buffer node reference upon completion of the request. The only reason
> I can see why that wouldn't work is if a single fuse io_uring_cmd
> needs to import multiple registered buffers. But it doesn't look like
> that's the case from my quick skim of the fuse code.

Good catch, I think I'll need to store that rsrc node pointer inside
the fuse code then. I think we could store it inside the struct
io_kiocb for the fuse use case but I think at an api level that ends
up getting ugly with introducing unobvious relationships between
io_uring_cmd_fixed_index_get() and io_uring_cmd_import_fixed().

Thanks,
Joanne

