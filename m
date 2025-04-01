Return-Path: <linux-fsdevel+bounces-45455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DC1A77E03
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 16:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498E83A67C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 14:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827D7204F6F;
	Tue,  1 Apr 2025 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="atFd0yKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C525204C30
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743518414; cv=none; b=kHaLfR1qgxe+sMfc8jssr24bBqyU+UOuU+rH4aQMqFa35AysuBHcU6dpJPCDaBKRPLO49Wq8IUrlsEJlBRoOl7avqJfi7pu+LRISujYGbKo7emDGUap+FMoa7jA9OApqFfXAuYGOR5ncVjFWeVejZplf0V6e8zkPs37Iw7RCA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743518414; c=relaxed/simple;
	bh=37CXOnT5gVmWSF86orv67Bi2S0ye3+YwEdKEuruGIcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bjso99WNaUmihzHdyjb9TC7KwdjwcX5K8JgjU7qWCK3RAM73p+eTJvnV3EOR+lVrWmhHGKkmLyimi/i8iAzPHHIXBK+y8wK/kkCGXn+gBIcjBt5OvbTbS9qRrznYKZPd7dClnZI6MWAY4o8Yo7JotTcTjJDozaD1xawJOJMmoSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=atFd0yKa; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c54f67db99so597148685a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Apr 2025 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1743518411; x=1744123211; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=59lR8fyAGZtnyL5JxvCFtODoufn1dWPFxTxyktTFZ+U=;
        b=atFd0yKa+CmxXBBPTL4BqenHYayFz1tW2yoEjhiGHdh1mK5oPh7QEGMjY0RG8iBJSR
         19cFuh67GDbz8ow9EyEMxnt0JoMPSVTcJ9sPE8K61tXHdtZ5wzrt0NXcdhCItB0TrxTt
         M9Cu5Z9kZ2frmSsNbpuCdH+7AoUDrn6av3QIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743518411; x=1744123211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59lR8fyAGZtnyL5JxvCFtODoufn1dWPFxTxyktTFZ+U=;
        b=RxQ7kOG16p1Ttt6qPrU6kZYuBHwU9XO8melUFr6BaPihrPINdZJH8eCIsD4pdc6W5z
         MZF/jBRsDpvJxb3D04Cj3fE8EtC7p++xDC+kxzcpk331yi3OxQIb0rFpCbglwTXCDJi+
         f8QZmv1M9Fouf1yHcs/JUBjX2RfyHLQQP7sEV3neQOIWM5JFqy+ukuiWXXpx8IosH2j7
         2QNZ3M3hgMBHSK63iEEvIoAEZNWOfzslKaOoXblnAGJe2LVxi+1TNTax603sEbUachkU
         w4Xvwik6GN44AhVnf1QErW5uzgv2uyVNdZrISR/KkWSybzB2ThjWKQsTqw599WgnXp1K
         6prw==
X-Forwarded-Encrypted: i=1; AJvYcCUmpZc9RJwu55V2RkG4e0COBqxWMcNSHjli5YRSO+ag7LNUW5wcxRyj5DjVCQlaP2e7VwlGL9nuGLfkTot1@vger.kernel.org
X-Gm-Message-State: AOJu0YwKxZIoUzY607seLvV5UkQRRYvsdePw8gIUNsh5oNd89Eu+YEx2
	TsBWbDa60B7k/lutAiHUjsFIucG46+UMpHQla1fs4k32mnx/bYd7pNBjolJrweOWRE35S6J7yN2
	bim0k3cvYGuXgq76Yyp4fk6zveUm1seOSjSEqog==
X-Gm-Gg: ASbGncsIWjFwBt3chMjqf4IIffQr95AL+3pB/1Zlo2CwbmfdmcEMVMNtcShsqkMODba
	LmEhAdpumWDZlnAk/A1Qjn0KvIOieZjdQfaAefBMWfDUKOlyOzfQei4RAenCcvfAuGZO3UbWgT9
	HVufxZRpCYJeljFKaRWDg4N/xcPg==
X-Google-Smtp-Source: AGHT+IHhI8O7b5ijP+loZV7+ENRm+l4fKn9ZXF7CCFAuMczCuXhabLgBeJHdh/tlFRjneE5K6thzWwDmic3IRpqnakk=
X-Received: by 2002:a05:620a:171f:b0:7c5:93bd:fbf2 with SMTP id
 af79cd13be357-7c762a3f261mr25104785a.19.1743518411252; Tue, 01 Apr 2025
 07:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314221701.12509-1-jaco@uls.co.za> <20250401142831.25699-1-jaco@uls.co.za>
 <20250401142831.25699-3-jaco@uls.co.za>
In-Reply-To: <20250401142831.25699-3-jaco@uls.co.za>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 1 Apr 2025 16:40:00 +0200
X-Gm-Features: AQ5f1JrNAk59O3RgftyW1Wtjx9nrelwARZc0n62ROmOd-FEHaOpq2bCBIDppVoM
Message-ID: <CAJfpegtOGWz_r=7dbQiCh2wqjKh59BqzqJ0ruhtYtsYBB+GG2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Adjust readdir() buffer to requesting buffer size.
To: Jaco Kroon <jaco@uls.co.za>
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr, 
	joannelkoong@gmail.com, rdunlap@infradead.org, trapexit@spawn.link, 
	david.laight.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Apr 2025 at 16:29, Jaco Kroon <jaco@uls.co.za> wrote:
> After:
>
> getdents64(3, 0x7ffae8eed040 /* 276 entries */, 131072) = 6696
> getdents64(3, 0x7ffae8eed040 /* 0 entries */, 131072) = 0

This looks great.  But see below.

>
> Signed-off-by: Jaco Kroon <jaco@uls.co.za>
> ---
>  fs/fuse/readdir.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index 17ce9636a2b1..a13534f411b4 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -12,6 +12,7 @@
>  #include <linux/posix_acl.h>
>  #include <linux/pagemap.h>
>  #include <linux/highmem.h>
> +#include <linux/minmax.h>
>
>  static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
>  {
> @@ -337,11 +338,21 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
>         struct fuse_mount *fm = get_fuse_mount(inode);
>         struct fuse_io_args ia = {};
>         struct fuse_args_pages *ap = &ia.ap;
> -       struct fuse_folio_desc desc = { .length = PAGE_SIZE };
> +       struct fuse_folio_desc desc = { .length = ctx->count };
>         u64 attr_version = 0, evict_ctr = 0;
>         bool locked;
> +       int order;
>
> -       folio = folio_alloc(GFP_KERNEL, 0);
> +       desc.length = clamp(desc.length, PAGE_SIZE, fm->fc->max_pages << PAGE_SHIFT);
> +       order = get_count_order(desc.length >> CONFIG_PAGE_SHIFT);
> +
> +       do {
> +               folio = folio_alloc(GFP_KERNEL, order);
> +               if (folio)
> +                       break;
> +               --order;
> +               desc.length = PAGE_SIZE << order;
> +       } while (order >= 0);
>         if (!folio)
>                 return -ENOMEM;

Why not use kvmalloc instead?

We could also implement allocation based on size of result in dev.c to
optimize this, as most directories will be small, but that can be done
later.

Thanks,
Miklos

