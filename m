Return-Path: <linux-fsdevel+bounces-44046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A70A61DD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59DC842164C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 21:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2C3193436;
	Fri, 14 Mar 2025 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Arj0TRtG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56752BA38
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741987052; cv=none; b=OLOLOrsUbg7fU1vYMfsr1oH+NypvNwPqkq7SUo1/SBV+kOicsNQeup5wFC9tYo55a+0OgtOrwcXiU6jKkrmedHpEa9lsm5bWLwsk5M49H4KEXvxb8bJjniuAk91MKZnDDCYHymszxcZMsqC3vut8BOHeihVVOpTdjXcviinNR5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741987052; c=relaxed/simple;
	bh=2G7SHJwfCY/VcN9R/8cRx0j+KgLHsgC/GN8UoNttexI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K23AJqWP5lumay+jFZ/I3ifxkXsD2CLmMmSDpJ+e+QPtT1USwYqA1UXBT0mgSY1/NaEvp2Su+j7I7L0+hmO1e8Mt6YyOZJQg/YWu7e5AmnxSee4yGs7u/R8I8v6/Gb89Vjb5zj+iSgTy6xzQkoZVyrqgeyhctfoOYpMj3Ra2MFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Arj0TRtG; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476a57a9379so35079441cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 14:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741987050; x=1742591850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOz1k/5/bODnOo+FUxCRWdpxcfi8P9ugoKJAkTDgjM8=;
        b=Arj0TRtG69SQFS6e/e5i3voWUwXLDadavW83bIYjlysqtlZd5oCxeET/1N2ugKKHdx
         PKYPww8WtXgKt0VQ6ux/4+KrWK6WnNr5HHI4BUsC7n+gY4T5xvJCnHCU6YXRX3drifGC
         5wW5FaZ7DUguUDqo2TZbBLXzJeRlxhYNQpzQv5ubJHcXw8bK0AtwlhlRE182lyMdhnW/
         yfxCveYlfOutdijfgh7kTgaZp2X8v1ArPX6VadVlr4pb/tDH9sV/Yf0NJci+6BJBoWTQ
         g+4AD4pqFk3qZ78FRGbfQ+MqMwdZqPwuoclQmXwlBziyV/HR5QFuPjlp7mIQ6BfVo63q
         sQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741987050; x=1742591850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOz1k/5/bODnOo+FUxCRWdpxcfi8P9ugoKJAkTDgjM8=;
        b=WnAc34Mrf8fxEbc/z8b+Vl/8RjlN5eC+invd7xwTiRYDYktMpI4Xzpob4STavjdQLh
         mSAwTKy2tKDQkrDDcPkxY514u3Tryvlt7UH5ffweewecWpIjTPutZ1xTWuFbmD1u8hqh
         1xxyhyUxYCBlmlLOUtsM/sX+YGT3qSR5S5QylmOSqzQIKKRYWh3553dla36NdedOmqhK
         U2MvBm6ojU5ULTT3pQgevTtXgzfZu7MfDVg2fDSTAkGnyGJJEahSZZg6kB0nVBBKt8pb
         8WP5SLOL4+ppANunb49RArAu2rSnbv1HqMI6b/Ve+51SDWXgseNOyFVHoAG/aCp7VITK
         JiSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnRuWjx9ZhrEPm8eCjmo1XFIe2741H7jU1Oer1hE67prR8p/2oaNJHD7Clc7Sqg3igDHgyySsMwsNRSnFd@vger.kernel.org
X-Gm-Message-State: AOJu0YwYDIWD0roq6xR5mZ8mVV14TfzNK/XQ8Go+m//ZcZbbbBo21oFH
	RKT2iVfVf/zc3UwXPi/raeBCjpevdOAAUVImsQDRt1j1i/2fKW89xO0z5tq4JM7lDhkx1Xf8ULt
	9tDMK7YHi3TWdwOX2G/dFzhFxrsc=
X-Gm-Gg: ASbGnctNbWmRFYwO1WseeWUMJXKX4QbPkQS38TrW0bmM65n2cv3cik1QtNnl/hPDVyg
	3oKLxbBCq7sQwQTNlW+xVSC2VamAB2K6/w7LLtsXNKZ8sSfmDuzdDObkCLmZCcUJOJg4HbF/bYV
	oZcAMIDQci/I4p1obRD5f+IIPVlJE=
X-Google-Smtp-Source: AGHT+IFEoxAH5bcRSYLDDmJgghLtOFcGpWcOqahpIlgCoWAzjhAmhiJWEY36eP9y6BbBqojXNnI4RgQj3NSn4C9s1Uw=
X-Received: by 2002:a05:622a:38b:b0:476:87f6:3ce4 with SMTP id
 d75a77b69052e-476c81c3327mr60792761cf.39.1741987050143; Fri, 14 Mar 2025
 14:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314205033.762641-1-joannelkoong@gmail.com>
In-Reply-To: <20250314205033.762641-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 14 Mar 2025 14:17:19 -0700
X-Gm-Features: AQ5f1JovEt_bk_q22JCn3VJDxFSQeg9hCVNjkcYQ1aLKV7lMLUOUfw55mrBpexA
Message-ID: <CAJnrk1a4fyip+8PxLA-7CTiAnkQqGqsogsO=34Y5o6sOqa4wcA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: fix uring race condition for null dereference of fc
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 1:50=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> There is a race condition leading to a kernel crash from a null
> dereference when attemping to access fc->lock in
> fuse_uring_create_queue(). fc may be NULL in the case where another
> thread is creating the uring in fuse_uring_create() and has set
> fc->ring but has not yet set ring->fc when fuse_uring_create_queue()
> reads ring->fc.
>
> This fix passes fc to fuse_uring_create_queue() instead of accessing it
> through ring->fc.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands")

Thought I added the changelog between v1 -> v2 to the patch but I
guess not. including it here now:

Changes between v1 -> v2:
* v1 implementation may be reordered by compiler (Bernd)
* link to v1: https://lore.kernel.org/linux-fsdevel/20250314191334.215741-1=
-joannelkoong@gmail.com/


Thanks,
Joanne


> ---
>  fs/fuse/dev_uring.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index ab8c26042aa8..64f1ae308dc4 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -250,10 +250,10 @@ static struct fuse_ring *fuse_uring_create(struct f=
use_conn *fc)
>         return res;
>  }
>
> -static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring =
*ring,
> +static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_conn =
*fc,
> +                                                      struct fuse_ring *=
ring,
>                                                        int qid)
>  {
> -       struct fuse_conn *fc =3D ring->fc;
>         struct fuse_ring_queue *queue;
>         struct list_head *pq;
>
> @@ -1088,7 +1088,7 @@ static int fuse_uring_register(struct io_uring_cmd =
*cmd,
>
>         queue =3D ring->queues[qid];
>         if (!queue) {
> -               queue =3D fuse_uring_create_queue(ring, qid);
> +               queue =3D fuse_uring_create_queue(fc, ring, qid);
>                 if (!queue)
>                         return err;
>         }
> --
> 2.47.1
>

