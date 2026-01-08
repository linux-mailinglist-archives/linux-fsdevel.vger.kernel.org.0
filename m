Return-Path: <linux-fsdevel+bounces-72943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CC1D06356
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 22:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28B1A300D294
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 21:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2F833290A;
	Thu,  8 Jan 2026 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KrDAQ7Wg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A6329370
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767906576; cv=none; b=DfZIhv9ghq1XhO0ywXUcdQ2yzUPZA30dJNcCFdUuGiQu5qePUyfb168MrwdJZxYCEy2lNyJivqESBdsZ04i1XCdY8Fob7vLxaeNkreVe0CtEO5O91ryGPdNXDpcmeZQTT3hfi/AUcQxA80EiP7TkLNTeyCdZfcTayyf3uT/5Pdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767906576; c=relaxed/simple;
	bh=r2Zn5rDhgmznXysDzd71ddQjoYVPIvx/TD6jmmvJ3ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vF1+Q/3yPrLoVMX3XOosxIIb5I5ePTu15hcmBhIPzJ7S0elaEDtnUiTXZU3lUS/Yh9bdTdpa/OooGbYAk3iv0mLgv3qA0SkfcusuciU1ExzLvpCBY37gAMjieVQvTaXl9CCsQuOheDW7mjTcNrrM9ziTK4SOJtjIKA+mQfLfUmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KrDAQ7Wg; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-11bba84006dso342461c88.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 13:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767906574; x=1768511374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l32sfxaQYx7HwL0yJhv52El4V7H01MIwAo5l1s6aKA0=;
        b=KrDAQ7Wg+uCtagcLpVgcJ3HemkEX/HDQ0s42tKt/ThFt+H3vRClTyHyVtaGPJ/lcKT
         0dzRvl3h+FH/75SvwvqU1gJjkFHSJX36StuSKj/ykyDwY+jM/nlrEVNEDsHJUd7u+o2i
         FJv/9ToYQ6tANpBXj5HQH+gm6hLHoRAUyBwqlZlO3qTvbyuzYbGOKFeA0cpqchn34Gco
         09uuGNtjU1bLnoRtqqys6Z6i6gg9z9LSwHPMBfnhMnY5F2fAutFcWKnW3vXaRpMAAHgv
         n2aMfGR8eNtr2hIDyucH/uvRWFrm8Fl/7MKxbzvNQbJuIak3AwXfRJOS+F9kvDQHOh5R
         CcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767906574; x=1768511374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l32sfxaQYx7HwL0yJhv52El4V7H01MIwAo5l1s6aKA0=;
        b=Kp4l4d7DdpuYdm8i5IGq4uA1ri57sGHzIltuUABEuvAuOLa1HSxL9ZY+rSm0DVviTE
         bmqr2hlI5oOcXoblqbtRfl0MWUFvL01uecl3z73Vvncsflo85KS0PME9JhtsxkfoW5D+
         Vfp9to+853oQEEjDaCtkbbRK1XWhBRHTrXXy47ATUiYSkn54GXVVUd5w4TZhpS5J+AhU
         MAJpwOrMC2cdX7t1dcCsYG/UVmerBbr42r3ptujm72MxyUr52QwvkTvbTGd5q+cgg+X9
         QJM1QMOVPGnX0If6o5VyGxNvC9CfXw+vJQA4+faHqy6IGzuUsw7I5363kHzMxYbSYCs/
         ryAA==
X-Forwarded-Encrypted: i=1; AJvYcCV7xCd0YKjvSOr0l9Dv6k82SNwjdZnLg10c/N1/7gepZY4LMgPxu4vBEq6DSOgKyFG1F/mAOS42O/70GcJv@vger.kernel.org
X-Gm-Message-State: AOJu0YwCBNZcMJVTZi4JqphN6NEvTYKGJTdC99+Mr4DQNx4XTJ+PHqQV
	y4rIdeWHTJpBMK5/SZRSNIZueN7S/nfqxyzitLUAXo1TxhSqBi4ArMBJ/jvhyA7+EroyUeMQ18O
	wKhmlEQWKdqNZGIzp5XO9s8PXW2WFOOWaZUae6NACdg==
X-Gm-Gg: AY/fxX7qLCyQU7wS+tkJXMXuCEKzTCQc6gWTK/noPBlh3mmzwv90gAg2NvFoKem15yR
	jZOaesIXQqXz1JPtk7NJ2D8htJJaBqjmK/i22Fr4Guc5DlHDqHVOILGvB3yuOFyP+My0KB/WXKJ
	lsCQzPHfzza9aTnKluvbogaTWH5IMl+E9p+kQzg+c/H/zzV+UVNEswTbjnAhQ360uPPB0suF0/3
	RYcVB9xh5mGpME3twEdwEQzhTGusu5l0RWT8KS08zJ5fLQBFQZjza8iC+ss0Nw2j31g0WtG
X-Google-Smtp-Source: AGHT+IGLSO8qM78JDwvs6pRB77Vr4srcQDB8fAfKcBSQzO7NatF2/x6gHVKNcHHzHOZ4eL1CR+klMQF9vwD2CYtOmr4=
X-Received: by 2002:a05:7022:2217:b0:11e:3e9:3e9b with SMTP id
 a92af1059eb24-121f8b60647mr3467529c88.6.1767906573413; Thu, 08 Jan 2026
 13:09:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223003522.3055912-1-joannelkoong@gmail.com> <20251223003522.3055912-24-joannelkoong@gmail.com>
In-Reply-To: <20251223003522.3055912-24-joannelkoong@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 8 Jan 2026 13:09:22 -0800
X-Gm-Features: AQt7F2qDtxHhMN1toWQImy--O_0Kfj3wGn-7AHn6cD_XHI5MFAZzwfo_WDSsiDQ
Message-ID: <CADUfDZoph-=on3E3sis0eLy_Fm7kUGShRUc89-0V1OjMHNLLAQ@mail.gmail.com>
Subject: Re: [PATCH v3 23/25] io_uring/rsrc: add io_buffer_register_bvec()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, bschubert@ddn.com, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 4:37=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Add io_buffer_register_bvec() for registering a bvec array.
>
> This is a preparatory patch for fuse-over-io-uring zero-copy.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/io_uring/cmd.h | 12 ++++++++++++
>  io_uring/rsrc.c              | 27 +++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> index 06e4cfadb344..f5094eb1206a 100644
> --- a/include/linux/io_uring/cmd.h
> +++ b/include/linux/io_uring/cmd.h
> @@ -106,6 +106,9 @@ int io_uring_cmd_is_kmbuf_ring(struct io_uring_cmd *i=
oucmd,
>  int io_buffer_register_request(struct io_uring_cmd *cmd, struct request =
*rq,
>                                void (*release)(void *), unsigned int inde=
x,
>                                unsigned int issue_flags);
> +int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct bio_vec *bv=
s,

Could take const struct bio_vec *? Might also be helpful to document
that this internally makes a copy of the bio_vec array, so the memory
bvs points to can be deallocated as soon as io_buffer_register_bvec()
returns.

> +                           unsigned int nr_bvecs, unsigned int total_byt=
es,
> +                           u8 dir, unsigned int index, unsigned int issu=
e_flags);
>  int io_buffer_unregister(struct io_uring_cmd *cmd, unsigned int index,
>                          unsigned int issue_flags);
>  #else
> @@ -199,6 +202,15 @@ static inline int io_buffer_register_request(struct =
io_uring_cmd *cmd,
>  {
>         return -EOPNOTSUPP;
>  }
> +static inline int io_buffer_register_bvec(struct io_uring_cmd *cmd,
> +                                         struct bio_vec *bvs,
> +                                         unsigned int nr_bvecs,
> +                                         unsigned int total_bytes, u8 di=
r,
> +                                         unsigned int index,
> +                                         unsigned int issue_flags)
> +{
> +       return -EOPNOTSUPP;
> +}
>  static inline int io_buffer_unregister(struct io_uring_cmd *cmd,
>                                        unsigned int index,
>                                        unsigned int issue_flags)
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index 5a708cecba4a..32126c06f4c9 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -1020,6 +1020,33 @@ int io_buffer_register_request(struct io_uring_cmd=
 *cmd, struct request *rq,
>  }
>  EXPORT_SYMBOL_GPL(io_buffer_register_request);
>
> +int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct bio_vec *bv=
s,
> +                           unsigned int nr_bvecs, unsigned int total_byt=
es,
> +                           u8 dir, unsigned int index,
> +                           unsigned int issue_flags)
> +{
> +       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> +       struct io_mapped_ubuf *imu;
> +       struct bio_vec *bvec;
> +       int i;

unsigned?

Other than that,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> +
> +       io_ring_submit_lock(ctx, issue_flags);
> +       imu =3D io_kernel_buffer_init(ctx, nr_bvecs, total_bytes, dir, NU=
LL,
> +                                   NULL, index);
> +       if (IS_ERR(imu)) {
> +               io_ring_submit_unlock(ctx, issue_flags);
> +               return PTR_ERR(imu);
> +       }
> +
> +       bvec =3D imu->bvec;
> +       for (i =3D 0; i < nr_bvecs; i++)
> +               bvec[i] =3D bvs[i];
> +
> +       io_ring_submit_unlock(ctx, issue_flags);
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(io_buffer_register_bvec);
> +
>  int io_buffer_unregister(struct io_uring_cmd *cmd, unsigned int index,
>                          unsigned int issue_flags)
>  {
> --
> 2.47.3
>

