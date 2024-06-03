Return-Path: <linux-fsdevel+bounces-20813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAA68D8191
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2DE1C21723
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 11:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB21785959;
	Mon,  3 Jun 2024 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGGuuZCj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C985935;
	Mon,  3 Jun 2024 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717415441; cv=none; b=drEWYsApDuhI3VIR2jewYCyxYyATOhym+eWNSBtR6veTXUiM311ficQxfb2yOzbtLDUrbZTjE0daq9uT4zIsMrVSnDOSk6t8QID/dzC7zXMcekHdZX/fgNFv0jaJxOE0LDGuT56iBLLUQAmVzq9FhciPDUNkB9lDIC2fL6zjsV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717415441; c=relaxed/simple;
	bh=Ef8601AvoIDfPOriBRG7eHg2z8rWNV2l2tKH9n1+nkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNKNWdiSYAZaLgwbD64HyhDAw51HxRjOTW9IrX9C+yfBBSU4PL/G6ILrEQwtmOOsRpRw9E1RjjHRMts2onyzeAiSrq//y85FvrJRiBUSJ2kxZSLa7VPJUELhLZsDPJi0ibYhcTqvP8CQyDLFGmF5F7PO0+AZrwOnusePetPahUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGGuuZCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34071C4AF09;
	Mon,  3 Jun 2024 11:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717415441;
	bh=Ef8601AvoIDfPOriBRG7eHg2z8rWNV2l2tKH9n1+nkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rGGuuZCjBWkOzFHWhQXRwV36Mj4e4i5FxTV7SwMhE+KE20CD5WunE9VNRIwbnz5IM
	 U3VHwvOsXPRXHyUclA77b1dsD0IgeVcB3TFATjcDFoMxJIbR5dWVb3N+kCdzwyEENr
	 FpSi3ysnrsSBtdS8uGozEhjYDQMYpnigcYwUSX9TnnUAYUFs9pcBy1cJPbmOtZZP2F
	 vm7OK2EUYX85CdEw4NkvxyU3fdfWV5mnuimRl/Jil8d6TqPHZxHJMxIvVcrVdOjUuE
	 tyByeebh+IBSzKIxMjr1g37IVnDnN+sy03sFVdIauixcjDciYWW4N0ani4fTt6F2rA
	 zR2To+gOuWMiA==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b96a78639aso1861003eaf.1;
        Mon, 03 Jun 2024 04:50:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZS19iaD+qYER19b7o2hQdpKVMkGno5BbLiWK70Vuo4l4gu4rEkIC3DbYeGR8W6CpNjbq08p9SieqAszSYOdbLufASqUCYViTEf5NbTziFAU/ezCPPs76yMlsLpEV1UnH+FeSW
X-Gm-Message-State: AOJu0YyjC0SIjg4MWffgnkgqufR7n5xYgRco9wnwt44FsPujaohNN4RI
	FFMU8jRXweWOZXpLIAEB+x59gFBO3eRQgzRX5xNcB5SR3YRuJiKFFlBoZ8I0wjqpn9pFL6cTAqD
	6qjNngufPmoHwr09sjoo3wi68jiI=
X-Google-Smtp-Source: AGHT+IEMtJutuogKyxLH8LA4gpH7pP0JB9BUJXlbDAbWahKXyTmF/cAWoa0Z9SMHK4nQF11HsNs8MLtAmTeY1M0GPyE=
X-Received: by 2002:a05:6820:1607:b0:5b9:fc9f:6a55 with SMTP id
 006d021491bc7-5ba05e00201mr8257945eaf.7.1717415440275; Mon, 03 Jun 2024
 04:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240531101615epcas1p3f0085b563af62c7f83699b0135cc832a@epcas1p3.samsung.com>
 <20240531101444.1874926-1-sj1557.seo@samsung.com>
In-Reply-To: <20240531101444.1874926-1-sj1557.seo@samsung.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 3 Jun 2024 20:50:29 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8UD7bzUJ4wntiSMEn+x=anoaJcfisKJoNSUo67F_HpjA@mail.gmail.com>
Message-ID: <CAKYAXd8UD7bzUJ4wntiSMEn+x=anoaJcfisKJoNSUo67F_HpjA@mail.gmail.com>
Subject: Re: [PATCH] exfat: fix potential deadlock on __exfat_get_dentry_set
To: Sungjong Seo <sj1557.seo@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+412a392a2cd4a65e71db@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 5=EC=9B=94 31=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 7:16, S=
ungjong Seo <sj1557.seo@samsung.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> When accessing a file with more entries than ES_MAX_ENTRY_NUM, the bh-arr=
ay
> is allocated in __exfat_get_entry_set. The problem is that the bh-array i=
s
> allocated with GFP_KERNEL. It does not make sense. In the following cases=
,
> a deadlock for sbi->s_lock between the two processes may occur.
>
>        CPU0                CPU1
>        ----                ----
>   kswapd
>    balance_pgdat
>     lock(fs_reclaim)
>                       exfat_iterate
>                        lock(&sbi->s_lock)
>                        exfat_readdir
>                         exfat_get_uniname_from_ext_entry
>                          exfat_get_dentry_set
>                           __exfat_get_dentry_set
>                            kmalloc_array
>                             ...
>                             lock(fs_reclaim)
>     ...
>     evict
>      exfat_evict_inode
>       lock(&sbi->s_lock)
>
> To fix this, let's allocate bh-array with GFP_NOFS.
>
> Fixes: a3ff29a95fde ("exfat: support dynamic allocate bh for exfat_entry_=
set_cache")
> Cc: stable@vger.kernel.org # v6.2+
> Reported-by: syzbot+412a392a2cd4a65e71db@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/000000000000fef47e0618c0327f@google.=
com
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied it to #dev.
Thanks for your patch!

