Return-Path: <linux-fsdevel+bounces-28628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4110B96C7D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 21:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C0B1C253F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 19:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E501E6DEB;
	Wed,  4 Sep 2024 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWdF2DP7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A4F8286A;
	Wed,  4 Sep 2024 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479167; cv=none; b=O4vvtOKLubAqedmbPeVkGQFplzL/dckNx/6VSRGVrnZ1VTs+tib/5q+w3dhJtnphxR+eyp4JDkV6NhccTi7q7TRPWGd93B9OngQGONYogLigdOlU9If6gpDP+w3d/JqfmmAnoxjg0P/HfpVfppsLPItZV6U50d3IiZtH6z9xglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479167; c=relaxed/simple;
	bh=QQsVnSzMJu9Xy6LVYw1rcBARePRY6Cy6vZiFgsTr2ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAZ1YyfUShMppZprvl/zzbmKLWut93j/vczrX/2PHdrkiIu0nC8quTTanK28c/rRade8dox3osmK/Yh5z/Nu4itBMOAZYUJvQPlAKIkk/XXgLCEwgrWCy1hx4hb8VOPTmlMAK5Dcu/2vgQwIIqFYTCCU4gaAFxEAfgRrDEeDjus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWdF2DP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F7FC4CEC2;
	Wed,  4 Sep 2024 19:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725479167;
	bh=QQsVnSzMJu9Xy6LVYw1rcBARePRY6Cy6vZiFgsTr2ig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fWdF2DP79Oz1wDdOdNmJmEFF+B692AQZ4875Bq6z1hg1xwLqlTNY1H+XTrfXMbVpS
	 j9sAxC7eMnwXTd3wNHvjRWj8E5hmjvAylk5hK4Gv4aeWmNf1meqTnsLuu09jxp5IQ6
	 7M3ybSubPsXBmhx6wBiBOKJX/1fjvuOvzRpBPtiDQ+i7+l/luSJZ9/Di6SjL1Zxn8C
	 EUvdYE0SCcmrKuzUMlV6Ukep+/CcDy//Ys7BNiUYeFzQ/QG4XV9j+jFT7/KBZiQtIZ
	 2KtRy5wbsaVhOufckq7FbWVUG9JdrwzD3kd6eZPTewykaW7TfO2EVgPzqOO3iubl79
	 1KjRL3qAlm8dg==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a812b64d1cso399018385a.0;
        Wed, 04 Sep 2024 12:46:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVB3UGXSEhMSqT2DWBxb1qhZMCyzxfw8d69McAP/6k1yeqm2SgMjBrFk0ygbeQa57Bi01oZ4+1MM3MZ@vger.kernel.org, AJvYcCVYA8bBIX/b8aM0C5JXt1OQUkhV7ek2IBNJJHiURLfxFkOxAtbmZRATEGpPNmhBuXNty5Uf8O0Lz8w=@vger.kernel.org, AJvYcCVrwtas2p0XQycjpkX02h3698vZNYUBbc8nF0D/qTMA54gR7YIX21allI0OwMT3vE6fkpO3abFywrijGJbjNhDQo++kfuCY@vger.kernel.org, AJvYcCXF+uZJHzSsg1v8nb2cxKXz6JxIrPb0a7ZUxek+Ll6EhVA5B74ogDMqOX/KkK+bH5/4QVFk233DNmpDV6fL@vger.kernel.org, AJvYcCXKEQ+E168x9AC2ZeD5b+CaFPY6PJL+M+4tqKpi6vpdCxNVbKtUE6q/vZyVV+wy94/4r099ZRuA2cetp+zn@vger.kernel.org, AJvYcCXs8fhs92FHrLWj6e5iehsAIinKM1h82+Er6ZUJRRI/iVH2GYLztpkR5qi/b3CgD5gADW8GiCKE@vger.kernel.org
X-Gm-Message-State: AOJu0YyL3/S4AXjy+rQ/98UuvpwDDGL92HGRDQ9TTq4GS24F8m4GCSyx
	bFJscrisnKMEpc2aQA8wVlonTF9ngiA16ihmYXvnr3XQIz91WYb2q1qLuSFAVdCLscXX890nMbS
	og+IKDo+iQtUpgDgIElt1yb9eUIU=
X-Google-Smtp-Source: AGHT+IEvCs/22u/q3u8HbVezM75pgSYQ+mtXLN/XwyBj7AvVgPLsxLtOdjUjVijcfKiU4aElyUiOX8rriF8t5qXs5jg=
X-Received: by 2002:a05:622a:2610:b0:44f:d986:fe4c with SMTP id
 d75a77b69052e-4567f505b0bmr362111191cf.20.1725479166868; Wed, 04 Sep 2024
 12:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903033011.2870608-1-yukaixiong@huawei.com> <20240903033011.2870608-12-yukaixiong@huawei.com>
In-Reply-To: <20240903033011.2870608-12-yukaixiong@huawei.com>
From: Anna Schumaker <anna@kernel.org>
Date: Wed, 4 Sep 2024 15:45:49 -0400
X-Gmail-Original-Message-ID: <CAFX2Jf=8cDNmjUBCRE-n6N9khkRRrq0ABtsX4V=j830Mi1spwQ@mail.gmail.com>
Message-ID: <CAFX2Jf=8cDNmjUBCRE-n6N9khkRRrq0ABtsX4V=j830Mi1spwQ@mail.gmail.com>
Subject: Re: [PATCH v2 -next 11/15] sunrpc: use vfs_pressure_ratio() helper
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, luto@kernel.org, 
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, kees@kernel.org, 
	j.granados@samsung.com, willy@infradead.org, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, trondmy@kernel.org, 
	chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, paul@paul-moore.com, 
	jmorris@namei.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 11:31=E2=80=AFPM Kaixiong Yu <yukaixiong@huawei.com>=
 wrote:
>
> Use vfs_pressure_ratio() to simplify code.
>
> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> ---
>  net/sunrpc/auth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
> index 04534ea537c8..3d2b51d7e934 100644
> --- a/net/sunrpc/auth.c
> +++ b/net/sunrpc/auth.c
> @@ -489,7 +489,7 @@ static unsigned long
>  rpcauth_cache_shrink_count(struct shrinker *shrink, struct shrink_contro=
l *sc)
>
>  {
> -       return number_cred_unused * sysctl_vfs_cache_pressure / 100;
> +       return vfs_pressure_ratio(number_cred_unused);

Looks fairly straightforward to me.

Acked-by: Anna Schumaker <anna.schumaker@oracle.com>

>  }
>
>  static void
> --
> 2.25.1
>

