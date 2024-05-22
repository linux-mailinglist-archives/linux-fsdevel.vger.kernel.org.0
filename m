Return-Path: <linux-fsdevel+bounces-20013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C658CC5FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 20:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907BD28660E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 18:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13987145B1F;
	Wed, 22 May 2024 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqnG3Bur"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631FF182B9;
	Wed, 22 May 2024 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400993; cv=none; b=DrByRj+AZIfFSSUuWMBU00OO1QxOrVpash5YWPiY9ni9ifVctxuVEz+YO9ZMA4YC92WjEDhUPrcbyhm6huph9yyHHt1a2cteUwbk9qADCfYvMBJfh4XFBMtr2BMP+oZnZoCIgYOGhvhn8WXeZhw5JXPtfaBvP/lPzGNx93VzoB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400993; c=relaxed/simple;
	bh=EgqUgI0H7TNae0QKJUbfzzMgFbTC81vHTSiEYGcj1Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3p1Df0swB4XkKeUOI8KMG7sDgB2WyNY9In7TbfSeBpyDwA/7HmV3RaJ1T+TI4Ev036UQRM6RYR1NprHzEfUhF6AjBo2PrUJ6JD7hA4DlZbqWgsg+DFGwzez1cJO/4grO0EggZoCOCIam0tnMN5PO0dHbt/kHxsDzn82oFi74E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqnG3Bur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17E8C4AF09;
	Wed, 22 May 2024 18:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716400993;
	bh=EgqUgI0H7TNae0QKJUbfzzMgFbTC81vHTSiEYGcj1Kc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eqnG3BurugA8eP+sBdeowbE+tTl1ziDioTAU76vCtcnMRell+SQ6FCr0wmO56ZbyF
	 04BXP1XMFrNHmKIrorHpFHirI7Y8+eTSXKUpfM+ivhMr6ZIVSJMxan9pJ33UMWwLuz
	 pRMurL9vRHaVw4lvUASCjD/KLQALbHF42X8Z4NWprQpZTuvBuTO9DY0fSST7idEF7S
	 c7PSRjLHs/w4uOsQK2ImVFG1o1D0g9RrmSYjK3tdmYnnifuFPrTXidirpg4HI8syja
	 TRAFUi8ts/h3esYVg+R10zYSnYf1TqAHyf4hfdgyoZszcPzTHfuk/WLvKXBx80xtwj
	 1lW5FYanDiNcA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e1fa824504so65411741fa.0;
        Wed, 22 May 2024 11:03:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5syn8iZtyEwb+Ocr0CIqpotitMw+84IR1sLoV01S1mPzwoMUnhqdidQiCH9Kjf5XgXJ9fq2XT+ns4Z2JknPSkq1Wx9xR8L5DPQQIZcG0leOBfntPpxPx0LG9iqVVQ9mTMCX5KfO3Xhib1/2xK0QuWfz8yvscRzVUc0O9oe3XcpthkF5isvq4IF4ReblQgnuMHzU8C9KW4KDfrQ3XZaEGY
X-Gm-Message-State: AOJu0YyijETD19m/3iL/jJ4Xl71X/WnpPxluAV5FWi8s4ZZX5FfmNPfA
	0FZKxzvIH9uXaxqiXiYasuwyVaxQrpebRMw0/KLPXwS808UhtMphYpfcERSN3q5PXLyxbNQRew6
	YxB3yguRZn4/KVraKmml/ANvLvg==
X-Google-Smtp-Source: AGHT+IHwAu69YuO1Nh3RQD2Pvp4YaJq25imcdHx3Dm0uO3K69AKZ/92diCIr1s9eL3l/QWkXG2g3XsBaE4fqA9npTO0=
X-Received: by 2002:a19:9143:0:b0:51d:1830:8380 with SMTP id
 2adb3069b0e04-526bebb4d43mr1337039e87.8.1716400991593; Wed, 22 May 2024
 11:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522074658.2420468-1-Sukrit.Bhatnagar@sony.com> <20240522074658.2420468-2-Sukrit.Bhatnagar@sony.com>
In-Reply-To: <20240522074658.2420468-2-Sukrit.Bhatnagar@sony.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 22 May 2024 11:02:59 -0700
X-Gmail-Original-Message-ID: <CANeU7Qn5KmdA2bVmEMjFtxcP+WnE174VgtkXZEHX82fc-gxXhg@mail.gmail.com>
Message-ID: <CANeU7Qn5KmdA2bVmEMjFtxcP+WnE174VgtkXZEHX82fc-gxXhg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iomap: swap: print warning for unaligned swapfile
To: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-xfs@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sukrit,

It seems that you need the swap file block start address to read the
swap file headers.
This warning still requires the user to read the dmesg. The kernel
still does not have the swapfile header at resume. In other words, it
does not fix the issue.

I don't know the suspend/resume code enough, will adding recording the
physical start address of the swapfile in swap_info_struct help you
address this problem? The suspend code can write that value to
"somewhere* for resume to pick it up.

Let's find a proper way to fix this issue rather than just warning on it.

Chris

On Wed, May 22, 2024 at 12:42=E2=80=AFAM Sukrit Bhatnagar
<Sukrit.Bhatnagar@sony.com> wrote:
>
> When creating a swapfile on a filesystem with block size less than the
> PAGE_SIZE, there is a possibility that the starting physical block is not
> page-aligned, which results in rounding up that value before setting it
> in the first swap extent. But now that the value is rounded up, we have
> lost the actual offset location of the first physical block.
>
> The starting physical block value is needed in hibernation when using a
> swapfile, i.e., the resume_offset. After we have written the snapshot
> pages, some values will be set in the swap header which is accessed using
> that offset location. However, it will not find the swap header if the
> offset value was rounded up and results in an error.
>
> The swapfile offset being unaligned should not fail the swapon activation
> as the swap extents will always have the alignment.
>
> Therefore, just print a warning if an unaligned swapfile is activated
> when hibernation is enabled.
>
> Signed-off-by: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
> ---
>  fs/iomap/swapfile.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
> index 5fc0ac36dee3..1f7b189089dd 100644
> --- a/fs/iomap/swapfile.c
> +++ b/fs/iomap/swapfile.c
> @@ -49,6 +49,16 @@ static int iomap_swapfile_add_extent(struct iomap_swap=
file_info *isi)
>         next_ppage =3D ALIGN_DOWN(iomap->addr + iomap->length, PAGE_SIZE)=
 >>
>                         PAGE_SHIFT;
>
> +#ifdef CONFIG_HIBERNATION
> +       /*
> +        * Print a warning if the starting physical block is not aligned
> +        * to PAGE_SIZE (for filesystems using smaller block sizes).
> +        * This will fail the hibernation suspend as we need to read
> +        * the swap header later using the starting block offset.
> +        */
> +       if (!iomap->offset && iomap->addr & PAGE_MASK)
> +               pr_warn("swapon: starting physical offset not page-aligne=
d\n");
> +#endif
>         /* Skip too-short physical extents. */
>         if (first_ppage >=3D next_ppage)
>                 return 0;
> --
> 2.34.1
>
>

