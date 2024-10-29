Return-Path: <linux-fsdevel+bounces-33161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B88A9B550A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 22:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BC51F21E99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 21:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA6619AA5A;
	Tue, 29 Oct 2024 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGCm08jv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99F8206E61;
	Tue, 29 Oct 2024 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237404; cv=none; b=ox4P9iFYKRupq0h92Yv5bRRadZyj0wn5trxM8wgTyaGJRZsIhQ07HXF737/UKRHar9uQG6D0MITA2MANsfcP6l8ScqeBOuKFU7XJszZOGNfpcrc8htuekpPglyxyAv5adnwRvzrITtDcViH+KYkV//KufD9bnhcx0Lz6D3OPc0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237404; c=relaxed/simple;
	bh=Mqn9O4xvpTW1HHOcatck9tYVt4w30aybpr+CRQaaIGg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KhKHplyqLakPvd2tBKjuUTKyOUFDnU0f95EQaH+Pk/5RJ+4iKeF68J7MJU1OUXLV60x7JAnyM83vo2djp+0heFC7o4MkDusc3XmUyKd18evnIhEI8SoKr1wbEflGzT24vKyVa8Tf28s5ODJljRNSz6udCvlF6VsMSTZd49ar7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGCm08jv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC6DC4CEE5;
	Tue, 29 Oct 2024 21:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730237404;
	bh=Mqn9O4xvpTW1HHOcatck9tYVt4w30aybpr+CRQaaIGg=;
	h=From:Date:To:cc:Subject:In-Reply-To:References:From;
	b=vGCm08jvIxbC+ljeFbZVwupK47pzGmsybO74lkH1pbhtD76zKwBHiO0hRY5IIVf7J
	 PWfhYbVwe3kDGWtcxEuo09H39uapWG6PFaif1df2oqOukC/xrzRfsK3HBloyytA8BZ
	 oUx6P9aevpw4IzozKERnAmqRXwNst7EFj0Rx3Qym2FTj62l/g1bYeuQj1iM36IqTRW
	 150O0AKpUD79IlHSIr9ls1/KDfKMAZzLi2M1TfTCQ4MsKPSi65b8xhC6BXb1X31akP
	 K4lDYysqdZXVwEHo0D2iNuwEJ2+pK5dc/yviZ7BacOXFuIpTJ20Drg98DN0rK+WxSY
	 3EjzNmtqim2XA==
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>
Date: Tue, 29 Oct 2024 23:29:58 +0200 (EET)
To: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
    kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
    netfilter-devel@vger.kernel.org, kadlec@netfilter.org, 
    coreteam@netfilter.org, pablo@netfilter.org, bpf@vger.kernel.org, 
    joel.granados@kernel.org, linux-fsdevel@vger.kernel.org, kees@kernel.org, 
    mcgrof@kernel.org, ncardwell@google.com, 
    koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com, 
    ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
    cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
    vidhi_goel@apple.com
Subject: Re: [PATCH v4 net-next 14/14] net: sysctl: introduce sysctl
 SYSCTL_FIVE
In-Reply-To: <20241021215910.59767-15-chia-yu.chang@nokia-bell-labs.com>
Message-ID: <06fe294a-8c7c-36a7-7244-dcdab26adcf3@kernel.org>
References: <20241021215910.59767-1-chia-yu.chang@nokia-bell-labs.com> <20241021215910.59767-15-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 21 Oct 2024, chia-yu.chang@nokia-bell-labs.com wrote:

> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Add SYSCTL_FIVE for new AccECN feedback modes of net.ipv4.tcp_ecn.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/linux/sysctl.h | 17 +++++++++--------
>  kernel/sysctl.c        |  3 ++-
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index aa4c6d44aaa0..37c95a70c10e 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -37,21 +37,22 @@ struct ctl_table_root;
>  struct ctl_table_header;
>  struct ctl_dir;
>  
> -/* Keep the same order as in fs/proc/proc_sysctl.c */
> +/* Keep the same order as in kernel/sysctl.c */
>  #define SYSCTL_ZERO			((void *)&sysctl_vals[0])
>  #define SYSCTL_ONE			((void *)&sysctl_vals[1])
>  #define SYSCTL_TWO			((void *)&sysctl_vals[2])
>  #define SYSCTL_THREE			((void *)&sysctl_vals[3])
>  #define SYSCTL_FOUR			((void *)&sysctl_vals[4])
> -#define SYSCTL_ONE_HUNDRED		((void *)&sysctl_vals[5])
> -#define SYSCTL_TWO_HUNDRED		((void *)&sysctl_vals[6])
> -#define SYSCTL_ONE_THOUSAND		((void *)&sysctl_vals[7])
> -#define SYSCTL_THREE_THOUSAND		((void *)&sysctl_vals[8])
> -#define SYSCTL_INT_MAX			((void *)&sysctl_vals[9])
> +#define SYSCTL_FIVE			((void *)&sysctl_vals[5])
> +#define SYSCTL_ONE_HUNDRED		((void *)&sysctl_vals[6])
> +#define SYSCTL_TWO_HUNDRED		((void *)&sysctl_vals[7])
> +#define SYSCTL_ONE_THOUSAND		((void *)&sysctl_vals[8])
> +#define SYSCTL_THREE_THOUSAND		((void *)&sysctl_vals[9])
> +#define SYSCTL_INT_MAX			((void *)&sysctl_vals[10])
>  
>  /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
> -#define SYSCTL_MAXOLDUID		((void *)&sysctl_vals[10])
> -#define SYSCTL_NEG_ONE			((void *)&sysctl_vals[11])
> +#define SYSCTL_MAXOLDUID		((void *)&sysctl_vals[11])
> +#define SYSCTL_NEG_ONE			((void *)&sysctl_vals[12])
>  
>  extern const int sysctl_vals[];
>  
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 79e6cb1d5c48..68b6ca67a0c6 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -82,7 +82,8 @@
>  #endif
>  
>  /* shared constants to be used in various sysctls */
> -const int sysctl_vals[] = { 0, 1, 2, 3, 4, 100, 200, 1000, 3000, INT_MAX, 65535, -1 };
> +const int sysctl_vals[] = { 0, 1, 2, 3, 4, 5, 100, 200, 1000, 3000, INT_MAX,
> +			   65535, -1 };
>  EXPORT_SYMBOL(sysctl_vals);
>  
>  const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };

Hi,

I know I suggested you to put this change into this first batch of 
AccECN patches but I've since come to other thoughts.

I think this should be moved to very tail of AccECN changes in the series
and joined together with the part of change which allows setting 
net.ipv4.tcp_ecn to those higher values. Currently the latter is done in 
the AccECN negotion patch (IIRC) but that part should be moved into a 
separate patch with this change only after all AccECN patches have been 
included to prevent enabling AccECN in incomplete form.

(This comment is orthogonal to Paolo's suggestion to use static constant.
So whichever form is chosen, it should be with the net.ipv4.tcp_ecn 
change at the end of AccECN changes.)

-- 
 i.


