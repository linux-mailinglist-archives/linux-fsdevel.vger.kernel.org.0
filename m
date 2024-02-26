Return-Path: <linux-fsdevel+bounces-12900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB98A8684CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 00:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CB81F23394
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 23:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED849135A65;
	Mon, 26 Feb 2024 23:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UqG8LT/2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05BE1E878
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 23:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991751; cv=none; b=RjGMCu+G0J433vIBBzN/heB+bR3ep/sKo6VpgLrzu5Ue5hucVh7zAkEbfHIklC7z/RFPPZscAC7lie10aSTfAJyjgqpZGseCizpkt46uk/7lK8efCT+Y2t683HzlS5a1J25bd1VIdavOocKNf9WLSa465LHB5szhQcWzZHWVOWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991751; c=relaxed/simple;
	bh=pd6yrnTC+hRr0/Z0yLyCvqH0hBN/UOqqiHViIEB2PNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dv0KCPAmu1OvPTeTE90TMrqELe7kYo/8LRY8Jo0MengJ6pi9HhqBdnd4yCbXlCHUVH1vJXqZLPKBFY2q0aHn2hJi6poNcCuHlEKwiS/EHiOuuP8d/6XPUl2w3L7jM6okRB6HAZCpFl2LQ+2yKOrjagLX/W3Eiq64jBCZ9rkPIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UqG8LT/2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3f4464c48dso430297366b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 15:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708991745; x=1709596545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra7j2veHt8ckgDfEUqJ6n9hg5jJXbYYJjjFPbVavXog=;
        b=UqG8LT/2wFgBZPJqSyp1CcgOHdKnmjwsUG0S84n2y9IxSUyglFMdqtb8PsL9h6agIW
         08jEZnwpZGp3AwFaryvTkZE/wif9JOy2LYRJBLLvyp8CK0VX1pJc2fGZCsJVQqWJqr+l
         TEs5YL2DJFyyC7gmlbIrZPWW0xxLkNC0sjDUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708991745; x=1709596545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ra7j2veHt8ckgDfEUqJ6n9hg5jJXbYYJjjFPbVavXog=;
        b=hWdC9pg/2zI3fec6Gvc78/jUKPMfccBEcGNeFva6ptO1SoPTUVADp94whnVgRVE6i0
         Sm4Ffj6Tz5ME2FLB20fm1Mpr4fx/aprn+Rkxd5wpjdkdxu7ZTxSqJscWlD5amecUNylB
         iwFrlQSAkFiMIGZB9ijjcG8VqUKebbYq2BdC1oL2qlJe9482qFo5de+HJ6xoAXSrjHM2
         6fB1m1q01HZgMtYnKukhlEUUFZkguAWf93c0kPMbCY6bqiloyxdvuRc4vBkKR4dmW7Y5
         VnVEkR95H6GxMiustbrqAcEf5v3rjwV7Yj0CdELQwF3wyrs6PAL3foXIQTvs/DFi8zrz
         Pb2A==
X-Forwarded-Encrypted: i=1; AJvYcCWfkVmqqmxGxw6IBh3vuQS5KqOKCop+jadiyj5gKFPt4PuaO2dIwekz6EUCaY9XwAM5NlEgMkRE/Y2058c/0vl9zrhLha2zT4Ft1ANv2Q==
X-Gm-Message-State: AOJu0YxdO2v3qEbvqCBo67KSAa09kWB9wmPr5otXWBXoiEUOEGmEyZZC
	i3gK8cHBUxAYB/djNc+LemlPIENchpA6JNbF6AoYa4Za6HYXiEDplWT03hwy7DMlQRYttuaHYte
	Kp0JX
X-Google-Smtp-Source: AGHT+IEe/AVFUfb6LYweWrP6PGzthPiOhukqbyMdBoMKBjqG83tn5jhBAQYnsC8l934ZSBMWOCwgMQ==
X-Received: by 2002:a17:906:48c7:b0:a43:4eba:d008 with SMTP id d7-20020a17090648c700b00a434ebad008mr2687484ejt.73.1708991745187;
        Mon, 26 Feb 2024 15:55:45 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id lu4-20020a170906fac400b00a3ecdd0ba23sm209334ejb.52.2024.02.26.15.55.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 15:55:44 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412a9f272f4so20315e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 15:55:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2yBcjjHOVwjU12jc7fYsbdVZGaehTwARFQ+WdWfle9AzQjfaeq8awBolf0mwrWDABt03l/HDH9L0ZqdGHO0IM2bem5o5hnl9LH+ggQQ==
X-Received: by 2002:a05:600c:501f:b0:412:5616:d3d with SMTP id
 n31-20020a05600c501f00b0041256160d3dmr41903wmr.7.1708991743417; Mon, 26 Feb
 2024 15:55:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205092626.v2.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
In-Reply-To: <20240205092626.v2.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Feb 2024 15:55:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WgGuJLBWmXBOU5oHMvWP2M1cSMS201K8HpyXSYiBPJXQ@mail.gmail.com>
Message-ID: <CAD=FV=WgGuJLBWmXBOU5oHMvWP2M1cSMS201K8HpyXSYiBPJXQ@mail.gmail.com>
Subject: Re: [PATCH v2] regset: use kvzalloc() for regset_get_alloc()
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>, Oleg Nesterov <oleg@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, Matthew Wilcox <willy@infradead.org>, 
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 5, 2024 at 9:27=E2=80=AFAM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> While browsing through ChromeOS crash reports, I found one with an
> allocation failure that looked like this:
>
>   chrome: page allocation failure: order:7,
>           mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
>           nodemask=3D(null),cpuset=3Durgent,mems_allowed=3D0
>   CPU: 7 PID: 3295 Comm: chrome Not tainted
>           5.15.133-20574-g8044615ac35c #1 (HASH:1162 1)
>   Hardware name: Google Lazor (rev3 - 8) with KB Backlight (DT)
>   Call trace:
>   ...
>   warn_alloc+0x104/0x174
>   __alloc_pages+0x5f0/0x6e4
>   kmalloc_order+0x44/0x98
>   kmalloc_order_trace+0x34/0x124
>   __kmalloc+0x228/0x36c
>   __regset_get+0x68/0xcc
>   regset_get_alloc+0x1c/0x28
>   elf_core_dump+0x3d8/0xd8c
>   do_coredump+0xeb8/0x1378
>   get_signal+0x14c/0x804
>   ...
>
> An order 7 allocation is (1 << 7) contiguous pages, or 512K. It's not
> a surprise that this allocation failed on a system that's been running
> for a while.
>
> More digging showed that it was fairly easy to see the order 7
> allocation by just sending a SIGQUIT to chrome (or other processes) to
> generate a core dump. The actual amount being allocated was 279,584
> bytes and it was for "core_note_type" NT_ARM_SVE.
>
> There was quite a bit of discussion [1] on the mailing lists in
> response to my v1 patch attempting to switch to vmalloc. The overall
> conclusion was that we could likely reduce the 279,584 byte allocation
> by quite a bit and Mark Brown has sent a patch to that effect [2].
> However even with the 279,584 byte allocation gone there are still
> 65,552 byte allocations. These are just barely more than the 65,536
> bytes and thus would require an order 5 allocation.
>
> An order 5 allocation is still something to avoid unless necessary and
> nothing needs the memory here to be contiguous. Change the allocation
> to kvzalloc() which should still be efficient for small allocations
> but doesn't force the memory subsystem to work hard (and maybe fail)
> at getting a large contiguous chunk.
>
> [1] https://lore.kernel.org/r/20240201171159.1.Id9ad163b60d21c9e56c2d686b=
0cc9083a8ba7924@changeid
> [2] https://lore.kernel.org/r/20240203-arm64-sve-ptrace-regset-size-v1-1-=
2c3ba1386b9e@kernel.org
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - Use kvzalloc() instead of vmalloc().
> - Update description based on v1 discussion.
>
>  fs/binfmt_elf.c | 2 +-
>  kernel/regset.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Just wanted to check in to see if there's anything else that I need to
do here. Mark's patch to avoid the order 7 allocations [1] has landed,
but we still want this kvzalloc() because the order 5 allocations
can't really be avoided. I'm happy to sit tight for longer but just
wanted to make sure it was clear that we still want my patch _in
addition_ to Mark's patch and to see if there was anything else you
needed me to do.

Thanks!

[1] https://lore.kernel.org/r/20240213-arm64-sve-ptrace-regset-size-v2-1-c7=
600ca74b9b@kernel.org

