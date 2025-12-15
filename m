Return-Path: <linux-fsdevel+bounces-71283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14765CBC757
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 05:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44CF030142C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 04:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAC22E0407;
	Mon, 15 Dec 2025 04:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+Df+g/r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976E919258E
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765771613; cv=none; b=XlOnrTVv6zLPxUoTPmqRf2Ex9T3ohfzcn6Jk/BWleIw2EoBDjxQ0CAG5dSSsPVh9HapsBkvQe6n5HRnDEMC0VP6KZnOBdaa683JbRLbGBNOjSOQRga8P2YufMi62wEZePGsp+xiZfNgERikJIjKiyOX6VdcfF3jEdQ11OLgnpJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765771613; c=relaxed/simple;
	bh=U033bjjMDL+S22FAm1p+i3ARdGrtX8LbbxObW9Iu61I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOBVxSrQw92SsvHrC1kbCBeOQ8rZSuxn4cztaICNJPKR56Oqd6c22SxabsEIcaFHrvWZ0Xx3nl0/n2tpBQFHUrRKAWabofI3ZvP8Bt80uRN2wozeglqqalzU8wrKPdGhT0LF8bswLLqXV59rmfeiGfPwKjyplVYOfmERxEFrjMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+Df+g/r; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ee158187aaso29347001cf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Dec 2025 20:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765771610; x=1766376410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj+Ta1nXFfTCbTNeXLwuKTxAYvCeDId1reUoMSL9KEk=;
        b=Y+Df+g/r0qYYfPwoO+yHObKkIicyywjEGfYd5e9fA4TkfiAKBgT7MTcTWtibD61aIR
         pdBPVGJV+1tfSwt0DHVSZfe+rBJj6cskwPjuCUH7fwcInTVWY8NCkNiKFs/5aEJFHe+M
         v3lti+VeDgAnYBHlwFIwDEZYZweoy28OPfxrk9wLE0daIMMy6GLx/NB+O4dFGD4i/Y9a
         GD9rGTlYF7bgll6QPpsSZ5N0dRofvunYpxA8vFrCb1or26nsbqBykqPvdE96KD+B8m/6
         sOAxlv/iBTfhYYCN068+2P202bStuK/P+0U6EUz0hbP/fkw9VvM9YOgT0XrL+ydDG1rC
         ggRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765771610; x=1766376410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qj+Ta1nXFfTCbTNeXLwuKTxAYvCeDId1reUoMSL9KEk=;
        b=cpGQPskmmWH0yL63fmVJLHVTvOGc+7LmgsjOfzTSvlDpBUDkrPxKO/SkDyW+B/69KN
         0QfmXMEJnWzXQ/FTsk2ThLK/y6UE46pPoD5Nz1uE0P8Nl5PYI3bHT1h2ckVJoqvFxqwL
         4Zlpm87LE6Cx5btswpV4JTcbJyYTdXKn8i3bs8+hiofy1zYqYhIgqc0BKGGZO35tAN+1
         B/m7FvcKMMgvrw5exKKmlsgA5XMDQDSPtUGXBMdLRuKG4hlw6sBZHIQIqMwLt2F2mYg+
         cYJY8jB3ldgYNKWmV23hd7z3KkaDyt3bg+4ukW9M5EHzX4vzDZK8At9nd32RrzBLrLlg
         vfdw==
X-Forwarded-Encrypted: i=1; AJvYcCX3dsvgXJ0Xus8lFgE+oogIL//AuV8l3Y21BflfkoLw45twP85CtRYqH+zkre411AmOgW7h/B6gwFbLdKkd@vger.kernel.org
X-Gm-Message-State: AOJu0YxS1hI2t8diq9THh/GvL6SGU7lFVFBVEGLLWIKkqs1lr4aEN3L8
	kqlvJrJLhUOzYNEcrRfX4lKbNnDiLLw5t5YhyISBagDfwfp6W3vIPQdbpc0q1tLzEXOanfixt4D
	O9FMnblbsCb5sCq2m0uF7ETbFu8pLkn0=
X-Gm-Gg: AY/fxX4WVUWteQNSDAUOjzSehBy6Hc4eJGEMimM6ip2UAN6U+yrqGkFbkZGp7vsYZva
	vf9qsmKDXLDBRgxsW/tpC+uypQxnqneR/jVayrSClmkIgZZpfUIJxK4M2kEiCpr3CmMJFy17J3X
	hA7RgHCq/+pFitAbayZlSOnwLyFnyPtNuRlApX62XpVLUgxt4RwBIs+lqyEQdsSEFTtV6ogyiQx
	KGLXhRjAtgwlH4+VYH5xpqBqO+Z60yGUxO5SzwhmE9ZXQVzVjGtPbBT3joyPJNP4fYiHGPr+vu0
	xnxbBB+Bc5g=
X-Google-Smtp-Source: AGHT+IElClD0dCz7o3PD5aJ8ramqK1f0zNFUhCduN85xOfDzt0ZMhYl4EBHvfuVHFjLS1ZgHZlNcPSLunqwrzcMQnOc=
X-Received: by 2002:a05:622a:4c06:b0:4e7:1eb9:605d with SMTP id
 d75a77b69052e-4f1d0462e09mr148402881cf.11.1765771610369; Sun, 14 Dec 2025
 20:06:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215024416.40841-1-chenzhang@kylinos.cn>
In-Reply-To: <20251215024416.40841-1-chenzhang@kylinos.cn>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 15 Dec 2025 13:06:38 +0900
X-Gm-Features: AQt7F2rFBrN5Q1dreTrQoi9uEKFL3k88aRr3AsY7B_5fw5I1Fb9IZM694GqAR6M
Message-ID: <CAJnrk1aGA35Fwh=GfT5SVG9KhycK4X821CNa7=-pd9qJLM7x4w@mail.gmail.com>
Subject: Re: [PATCH] fuse: use sysfs_emit() instead of sprintf()
To: chen zhang <chenzhang@kylinos.cn>
Cc: miklos@szeredi.hu, mszeredi@redhat.com, josef@toxicpanda.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	chenzhang_0901@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 10:44=E2=80=AFAM chen zhang <chenzhang@kylinos.cn> =
wrote:
>
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.

I think it'd be useful here to include why too (eg that it handles the
page-sized buffer limit and prevents potential buffer overflow)

>
> Signed-off-by: chen zhang <chenzhang@kylinos.cn>

nit: the convention (at least as far as I can tell :)) is for
signed-off-by names to be capitalized

> ---
>  fs/fuse/cuse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
> index 28c96961e85d..0c8e7259f489 100644
> --- a/fs/fuse/cuse.c
> +++ b/fs/fuse/cuse.c
> @@ -581,7 +581,7 @@ static ssize_t cuse_class_waiting_show(struct device =
*dev,
>  {
>         struct cuse_conn *cc =3D dev_get_drvdata(dev);
>
> -       return sprintf(buf, "%d\n", atomic_read(&cc->fc.num_waiting));
> +       return sysfs_emit(buf, "%d\n", atomic_read(&cc->fc.num_waiting));
>  }
>  static DEVICE_ATTR(waiting, 0400, cuse_class_waiting_show, NULL);

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

btw, cpu_list_show() in fuse/virtio_fs.c could be converted to use
sysfs_emit_at() as well.

Thanks,
Joanne
>
> --
> 2.25.1
>

