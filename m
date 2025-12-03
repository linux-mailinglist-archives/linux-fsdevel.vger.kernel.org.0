Return-Path: <linux-fsdevel+bounces-70601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A55CA1C21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 23:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61A88300BEF6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 22:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094C3313E1D;
	Wed,  3 Dec 2025 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Dcvz6tv7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D805A32C936
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798852; cv=none; b=XUNvVNiwCLAonKYOMcbk/Z9c/xUoDinPpjszzTOTVfNmN+LOhOBYLOYtRoy2a2FT/EupVcGy76l3KX/OG2lluuOnBCmZw8AfwGpfozINe7Ulo1+8BlbVT/NDX4DngtRs7Dm89inpmArcZKfluXcQzhZfSADd1oFOYteAFVG8KdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798852; c=relaxed/simple;
	bh=qcJFPyaOH0oDmtQ8gBNn+OmZhs8yDCgNd35ZDEbGD0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKNle5p+F0eDmo8QTEDNOuURolpSH7lCLcK9QjZNoczxxBK8Ywi/ffZbm+SSDPk0G72+Qp1r2JUTXOrTxPcUSom0QX8cwm1MLcJlRcvpz1wd2D5oGDwHQWa0FUiAkg6GdeffqiP+N6TSSJV0EcSdNN6NCPoQaYlhWHRnJPmKz6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Dcvz6tv7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297e2736308so284955ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 13:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764798846; x=1765403646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNqO1AOktfiC8ElyrsXdFe7FkjysK5RRpMpW3lmsUhg=;
        b=Dcvz6tv76Qm6/lQYRLtBnJXB/UTVfLiQIez5SWJtgqtQtQApzwhQLXQaZTiSf24itg
         uLZs1XaDtXoGgbKgLAhuukrJMVYyQr8i/EIwDwgkv2JZEkkP7S9ETP2lcikqvYB/MaQQ
         YH4H1n78WqYZm9xf3t5jeDvOnznbJ5EshZVO8njFNAqPKngol2JtLw0R19P6bc/rMdq6
         1S/XgeuU0pqZgOfKR+1yf+w9xYuQ/4+6qj+MqMOue3r5pd1Zs+NVeEVKKmi4i+ENruci
         7z8SMUgKjFlDul+zfJiGcWClNQ43Mp8cdr9YvG4rY1HnhZ8WQ+klgPIcPWpPRmnhenuR
         QHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798846; x=1765403646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cNqO1AOktfiC8ElyrsXdFe7FkjysK5RRpMpW3lmsUhg=;
        b=ZDimz0rvJaFQUeNp9Y/7WnAHnFXs7HAlzGfAhn2SEUID+O2tNa8tCZRbvxv4UxBbKz
         5b1PCF26fm2ngqyv09Ineajyk1R5SAhpD8ZlzlweCdaOLYAgUBiZ7PkyA8mAf4bf6R+v
         9c/bv5dIf3VQw/kM5JS7NKsbfrB8AD+RxEszePZl/uF0gEicAbPBgYED0IPGm0sjhJMR
         SAu7KlYEH8M/MfSDkUeIudvP60IR/vnRvx1nuU6ffNLuaz/8vfFHVWhF/CkYzqfyT38z
         5ytITH0ymYITHKfH9S+yZyMB4exclCBmzSvXHFkjJG8B8X4UA7/hB7iD5cNGRCt/vKg+
         12KA==
X-Forwarded-Encrypted: i=1; AJvYcCVgFzA+v8MB3xYNKKFAbpFE1D10bxV0B2325pOjy+zozi4OIpsM54QIN6DPhEbygeeSBpcDolF7nf5HpImk@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ4i1EumtcOlYW/fEcNAeoA/2D+Hcuy3vwSkPjnzPmHIeouQMx
	SwIxMJkuB2/vnjoDK3iZikUlI6qzFq4AbN2dBRjh8NfRWXS9n5smyP7E19rpj4Q5fT8h5xmwdtc
	PMlrubc9iD2dggK4e1XVZiSThx62pZi93uTCE/dtj3cCknIYMhqBMrQU=
X-Gm-Gg: ASbGncvado5CdTmokePnlsTTZ8tLWDDsixnZOKv7GCHH2/lnyZs06jhAtBXgrMOGRPm
	3/2T6BlZQQmkN5w0xtSJCs+xDDhOVgDn21lF40ddXZ0pe9S7ADG6fygGfQ4Yoqw4/oVAiskS6xp
	3IOOS6DfMtLGfgTKIuuLpRj2kQx5LmpRbl7rZh8dQneIBVA3DrdFXvF75/FxHrt8UpSDtxNqRu2
	K5CfTSS4cs94rF57O/euZ3YiXc1ig==
X-Google-Smtp-Source: AGHT+IGo4rk2z3qITjUHjmzT74C8yUrNTvE4/mUjuUkdwPqjvYE0jxAXVSt1ovTOalvhiBDxbHC8Le18N48vfr9kgEQ=
X-Received: by 2002:a05:7300:df4a:b0:2a4:3593:5fc6 with SMTP id
 5a478bee46e88-2ab97895aeamr2241627eec.0.1764798845818; Wed, 03 Dec 2025
 13:54:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203003526.2889477-1-joannelkoong@gmail.com> <20251203003526.2889477-12-joannelkoong@gmail.com>
In-Reply-To: <20251203003526.2889477-12-joannelkoong@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 3 Dec 2025 13:53:54 -0800
X-Gm-Features: AWmQ_bnRKN2DJsYkd-18LskwFUzAFXKwgZ1sSlNV8ChDsShyP9GxhinWLmBTy_A
Message-ID: <CADUfDZoHCf4qHE1i7S4-Ya9WgGY0q6SmN4NVRgeGu347oZ6zJA@mail.gmail.com>
Subject: Re: [PATCH v1 11/30] io_uring/kbuf: return buffer id in buffer selection
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 4:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> Return the id of the selected buffer in io_buffer_select(). This is
> needed for kernel-managed buffer rings to later recycle the selected
> buffer.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/io_uring/cmd.h   | 2 +-
>  include/linux/io_uring_types.h | 2 ++
>  io_uring/kbuf.c                | 7 +++++--
>  3 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> index a4b5eae2e5d1..795b846d1e11 100644
> --- a/include/linux/io_uring/cmd.h
> +++ b/include/linux/io_uring/cmd.h
> @@ -74,7 +74,7 @@ void io_uring_cmd_issue_blocking(struct io_uring_cmd *i=
oucmd);
>
>  /*
>   * Select a buffer from the provided buffer group for multishot uring_cm=
d.
> - * Returns the selected buffer address and size.
> + * Returns the selected buffer address, size, and id.
>   */
>  struct io_br_sel io_uring_cmd_buffer_select(struct io_uring_cmd *ioucmd,
>                                             unsigned buf_group, size_t *l=
en,
> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_type=
s.h
> index e1a75cfe57d9..dcc95e73f12f 100644
> --- a/include/linux/io_uring_types.h
> +++ b/include/linux/io_uring_types.h
> @@ -109,6 +109,8 @@ struct io_br_sel {
>                 void *kaddr;
>         };
>         ssize_t val;
> +       /* id of the selected buffer */
> +       unsigned buf_id;

Looks like this could be unioned with val? I think val's size can be
reduced to an int since only int values are assigned to it.

>  };
>
>
> diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
> index 8a94de6e530f..3ecb6494adea 100644
> --- a/io_uring/kbuf.c
> +++ b/io_uring/kbuf.c
> @@ -239,6 +239,7 @@ static struct io_br_sel io_ring_buffer_select(struct =
io_kiocb *req, size_t *len,
>         req->flags |=3D REQ_F_BUFFER_RING | REQ_F_BUFFERS_COMMIT;
>         req->buf_index =3D buf->bid;
>         sel.buf_list =3D bl;
> +       sel.buf_id =3D buf->bid;

This is userspace mapped, so probably should be using READ_ONCE() and
reusing the value between req->buf_index and buf->bid? Looks like an
existing bug that the reads of buf->bid and buf->addr aren't using
READ_ONCE().

>         if (bl->flags & IOBL_KERNEL_MANAGED)
>                 sel.kaddr =3D (void *)buf->addr;
>         else
> @@ -262,10 +263,12 @@ struct io_br_sel io_buffer_select(struct io_kiocb *=
req, size_t *len,
>
>         bl =3D io_buffer_get_list(ctx, buf_group);
>         if (likely(bl)) {
> -               if (bl->flags & IOBL_BUF_RING)
> +               if (bl->flags & IOBL_BUF_RING) {
>                         sel =3D io_ring_buffer_select(req, len, bl, issue=
_flags);
> -               else
> +               } else {
>                         sel.addr =3D io_provided_buffer_select(req, len, =
bl);
> +                       sel.buf_id =3D req->buf_index;

Could this cover both IOBL_BUF_RING and !IOBL_BUF_RING cases to avoid
the additional logic in io_ring_buffer_select()?

Best,
Caleb

> +               }
>         }
>         io_ring_submit_unlock(req->ctx, issue_flags);
>         return sel;
> --
> 2.47.3
>

