Return-Path: <linux-fsdevel+bounces-72348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E78CF06C3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 03 Jan 2026 23:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08F76301AD0E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jan 2026 22:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7525322156F;
	Sat,  3 Jan 2026 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KShEaLnm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F93B262BD
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Jan 2026 22:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767480365; cv=pass; b=PUoh+HkEugsHz2c/rvY1NuPIrACajuoZMdE3D28+vfSNtDaViP7kHRGaxAH2PRwkBMxN+h3vbRcsOitxArrrBsxAXhteXLqyDLhM5tzV29+ZI41APOW/iGFsm7iBGI0kdHvp22bCJwGhJjtDMCbYCsjsni4M+FJcAN2ckzJikdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767480365; c=relaxed/simple;
	bh=QvL0IEYlojdzn2+kCqrNQA9sYBsL0NQVJKZC1AUN3Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADHPRcwyxxyNyZuHYOae5eQ0b1DC+/gFnM15UHYTWvBRLNyqJKfnsoe/Jl4J8h1EgfxzFdezGKte9bYRqNY0Zq1zCrBSxk6bJhw78lTLnsTi9I1sSH7PgFGbxqWaKUlAh27HO8J12OpYGsJfgGnIgXABCaNQlcm1o8CIOPpht9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KShEaLnm; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a2bff5f774so31741135ad.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Jan 2026 14:46:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767480362; cv=none;
        d=google.com; s=arc-20240605;
        b=YqSwV7FIxJK88XS1vRE+pSmjjGvEsQBBjOTBzdyQKRZhHqIsyKEJtVamWN/Dhgzii3
         SSgNI5lfUzSEEB12JizmdYLG6g4nqar+GqJggoQPPFuYXo+dY70mJBHF1KqdE7JdoIHo
         MOyyHuYHVrTGVR+U7kqahFh41rylnOKBVL/memVh4qUohDDo31Yw5lkspt6zc0xvO8Rz
         VQFodBRUAUJzi4PYwODQX11/z4CfYv22YxKOiWCrDaHvNf7fPckZJPAsXJQSBI5BWm6c
         j8qQL1LoBYmYU/FkTQRUz9DGDwls2VP5d486PVjh8lzmGOFAYp/8SErrDpi5SXJjGHP5
         R+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XGp4slpsd36FtS6nH/SR27JKHN67f5JDPi7Wgd1lzlU=;
        fh=BxTbNLUHT4A5P/2hL7TlAkkFbhSHoxYi4bzMJniKeY8=;
        b=Fx/p0lm30TXBgzS2ibUnG/KgdXXy/sbi96K1UYoWSoM+LW77nB1oJcyjC57JMgZRkc
         TlPFpYfM7pIXcEkL0FQzeLl0NKgveL1RhkM4Wps6rCMXMEsZR4o5RVdTVeT3XUR/Bra4
         krSta3z4KENm6uIaRdQ6ygYCQNfZ5bO0f88rMl2H/jbn69F5lsLfKVPCZq9CTY96eII8
         45liufqbrRfxZU/3eGCIIIEQBfvOdnbJGo/W+3/LdezDZ97vSmbsS+RVUva2mtInu/1Z
         TNQLaPXqGCGk/EanhgZV+fHL2iMSzKL3uOYEzUqs01CINKBrPfUAdaai7jwXxIgqC4pF
         +bWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767480362; x=1768085162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGp4slpsd36FtS6nH/SR27JKHN67f5JDPi7Wgd1lzlU=;
        b=KShEaLnmRtdHuIqJ5pdQc60u6RfXO4JXRBVGhKAtI2BNjehNBlqwO3O1DrnhxoKhkt
         4EIvxDFSOfe4q0CjCJcUG5iEaPwfvDzdI4w09AJR0KLt2wjLY/FP1G61bYhJ9u4LQPsC
         As/ax2PCLvedoT19KPsEjdgcTbK0MuQSggOsHfPjEQTEqIOZpIdmE3R3c9Z0ijf0fNw0
         s0guT1mavWL8aafu8nEurvEKtjhuLXCLGF6ol5fWHNZ9miATN9Yjvfl5/2TlQhrZuEaC
         wDlVu/etUKw0QYG9SEUcT3TAZPlXj/OV9lGQii98Jvhp3x4TiDTwZfEqLudgR1taNjAQ
         PdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767480362; x=1768085162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XGp4slpsd36FtS6nH/SR27JKHN67f5JDPi7Wgd1lzlU=;
        b=Ww70BQeY5wIT/9OevXVZx4HMsxPFmSAGfzHjaP8slPqRZwR9EHA2UUmm66W0pRwJz2
         EPq4MHm0y87mdGzuMiQmO63Vv9jtayGTKGAHiyIatG86TJzv2BhG8pGqcIdORbfxM3jm
         ytD1KaTvJnshHyUuj9KYlY+4zAE8lEE+VucVvu6mtBtZNa9kxWd9Rs4B+T/IAEaKp+W0
         984mrhjnFSc003aBVOwCUcCUC7B94JLQB6adxCwdoTTEYIr73T5PHbVAhScnhGwT58AQ
         5WRYRr7OBs7IKgLYm7zF2EKiCv/rkwUUNekm0WAROXlkJEQmrIdWUduPNxHKCAM+3ibZ
         93CA==
X-Forwarded-Encrypted: i=1; AJvYcCVYHrJV1XnWGAFLMf6Fs1Q0USnCsMOFgIc5hEhitOyl2WFrODKjycRX8VGtZGwCGkcypbWy4gZsvPgk7xyO@vger.kernel.org
X-Gm-Message-State: AOJu0Yys5OKhGCNa02MuTbMS/8V3R/pgbU+xZoU8EPO78WtwrTfWECAu
	8HE/rCpUqN6TgJgwzQEk8bxk/mvdnq6u9PLpllHqhDVDYLtVgyO7QoEyzMT18fdBooK7yOiHHos
	u44uedQUj4LX3E1JGTetxxrVZZag3hluCvU9HWCD8vA==
X-Gm-Gg: AY/fxX7+cJKTqJSCnooXxiCnUEiIEyCWPLhM15ijFpJ+dWDuWRCfBWFbksbaHq5pw3X
	t/EscSzKOlxlVK8cVBv+ZliEw0JtTcl3FILhrtwiBtriMnNDPI5EPtzMp7MJQE+M3ki5IKtKMIe
	KDhj3EJc6qEZ0wyHLVxjk1sA8ysmugOYRwZAocloH56BKzIVlCJPrxVWlwucAsUnDCgylahnRWz
	x1L2WBnKtsZd/71q5X71yiQRZOgenM9qGHwV/ZOIGYgM/78u6tKILoHTV2ovXj0vlNOB+0G
X-Google-Smtp-Source: AGHT+IHOqMuhJoMhmZ02WaBjabl6IVrpeObki83fCpag55F4Cw31dCSH+4rdvlCjougzCFLVvNpG7EdYoG29oYJ/UV0=
X-Received: by 2002:a05:7022:42b:b0:11a:5cb2:24a0 with SMTP id
 a92af1059eb24-121722b42c1mr23801291c88.1.1767480361568; Sat, 03 Jan 2026
 14:46:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223003522.3055912-1-joannelkoong@gmail.com> <20251223003522.3055912-6-joannelkoong@gmail.com>
In-Reply-To: <20251223003522.3055912-6-joannelkoong@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 3 Jan 2026 14:45:50 -0800
X-Gm-Features: AQt7F2rR-f8SX-sEp6qwHniHsd1svaEcM35nVb-EkG3DNEcEI9T7X5WNbjorMeg
Message-ID: <CADUfDZqAWCWchX=tqJxy5Hcz1z1s=TO12teuEiz67vXvxATtKQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/25] io_uring/kbuf: support kernel-managed buffer
 rings in buffer selection
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 4:36=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Allow kernel-managed buffers to be selected. This requires modifying the
> io_br_sel struct to separate the fields for address and val, since a
> kernel address cannot be distinguished from a negative val when error
> checking.
>
> Auto-commit any selected kernel-managed buffer.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/io_uring_types.h |  8 ++++----
>  io_uring/kbuf.c                | 15 ++++++++++++---
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_type=
s.h
> index e1adb0d20a0a..36fac08db636 100644
> --- a/include/linux/io_uring_types.h
> +++ b/include/linux/io_uring_types.h
> @@ -93,13 +93,13 @@ struct io_mapped_region {
>   */
>  struct io_br_sel {
>         struct io_buffer_list *buf_list;
> -       /*
> -        * Some selection parts return the user address, others return an=
 error.
> -        */
>         union {
> +               /* for classic/ring provided buffers */
>                 void __user *addr;
> -               ssize_t val;
> +               /* for kernel-managed buffers */
> +               void *kaddr;
>         };
> +       ssize_t val;
>  };
>
>
> diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
> index 68469efe5552..8f63924bc9f7 100644
> --- a/io_uring/kbuf.c
> +++ b/io_uring/kbuf.c
> @@ -155,7 +155,8 @@ static int io_provided_buffers_select(struct io_kiocb=
 *req, size_t *len,
>         return 1;
>  }
>
> -static bool io_should_commit(struct io_kiocb *req, unsigned int issue_fl=
ags)
> +static bool io_should_commit(struct io_kiocb *req, struct io_buffer_list=
 *bl,
> +                            unsigned int issue_flags)
>  {
>         /*
>         * If we came in unlocked, we have no choice but to consume the
> @@ -170,7 +171,11 @@ static bool io_should_commit(struct io_kiocb *req, u=
nsigned int issue_flags)
>         if (issue_flags & IO_URING_F_UNLOCKED)
>                 return true;
>
> -       /* uring_cmd commits kbuf upfront, no need to auto-commit */
> +       /* kernel-managed buffers are auto-committed */
> +       if (bl->flags & IOBL_KERNEL_MANAGED)
> +               return true;
> +
> +       /* multishot uring_cmd commits kbuf upfront, no need to auto-comm=
it */
>         if (!io_file_can_poll(req) && req->opcode !=3D IORING_OP_URING_CM=
D)
>                 return true;
>         return false;
> @@ -201,8 +206,12 @@ static struct io_br_sel io_ring_buffer_select(struct=
 io_kiocb *req, size_t *len,
>         req->buf_index =3D READ_ONCE(buf->bid);
>         sel.buf_list =3D bl;
>         sel.addr =3D u64_to_user_ptr(READ_ONCE(buf->addr));

Drop this assignment as it's overwritten by the assignments below?

Best,
Caleb

> +       if (bl->flags & IOBL_KERNEL_MANAGED)
> +               sel.kaddr =3D (void *)(uintptr_t)buf->addr;
> +       else
> +               sel.addr =3D u64_to_user_ptr(READ_ONCE(buf->addr));
>
> -       if (io_should_commit(req, issue_flags)) {
> +       if (io_should_commit(req, bl, issue_flags)) {
>                 io_kbuf_commit(req, sel.buf_list, *len, 1);
>                 sel.buf_list =3D NULL;
>         }
> --
> 2.47.3
>

