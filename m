Return-Path: <linux-fsdevel+bounces-9402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66932840ABB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 17:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06AC1B24D8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5212E155A54;
	Mon, 29 Jan 2024 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="REb131pB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736051552FE;
	Mon, 29 Jan 2024 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544034; cv=none; b=jvhxvE4/b+KZXKOrEX6yPqaqJ2jLqwCAv9zlNVKHNU6iCp/F3XP+RHYroshp/Jhrhj0v7TglAYs/AH53h/5hM2R33EOkDSHDmNXFEJT156voO8oxYrMt272HG6pUfl40MtCBxIZxPR1L/ku20JGBVUx0Fcx+Qi2uJgZRVUVeQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544034; c=relaxed/simple;
	bh=FX/3JZsgoeRJk8/gT/ahewzSdOBqCFPARvgcZJkGxSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaz7dDcoCCNdojhomeQBjIiyNtRlwFa6pl1T0y7/bc72YyBCdzJt2C6vgrFfgtSmaM2IJuNQMlQ3INtzbfHuvNaRiLY6Ybc2vbpfZStKHL1wsDEOCwxYfVnSUBewFRPv6xJ4QxJQyIb57H6MBZRpJK55dD7qjpchFhfXWFAiKxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=REb131pB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pBVtJRmqf+crBbobrGzBK2lFMDtFqvFaWK9LtbdMiw0=; b=REb131pBQOlURPlaqY/BWYJkYn
	6XiNQWL5ysnJDjT2Q/knsZymoxmJ9qg3ZTfjxAzf6s28tQ2qC1Ej9fGitEUS0C5NtE8hqJL7EnBxD
	C/JZrsLTBbNkc1ACH0HcmRUwZOBoMDQ2lO5CbUnkpj5e3WtB+EImTFJ71cHYj126vSqqUID5tbF1z
	pbQ5vbvK7Xy0+YFlr0gSMvXuWxBk9IpWXiUtwGPHQgFsV8nF2BPawr+OO5aM6hwKcaZFTE63IkmdY
	d2w1qigl2szKcAIB8iDyKjNn+GVTOJr78eGOyl+6Zny6+WsIjo3bFpaYg1BK6O65xAHu46yrE1pTR
	+ZBF5jNQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUU3b-0000000DPH0-3JRj;
	Mon, 29 Jan 2024 16:00:23 +0000
Date: Mon, 29 Jan 2024 08:00:23 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Yoann Congal <yoann.congal@smile.fr>,
	Josh Triplett <josh@joshtriplett.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2] printk: Remove redundant CONFIG_BASE_SMALL
Message-ID: <ZbfLl6PR_qxxreeX@bombadil.infradead.org>
References: <20240127220026.1722399-1-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127220026.1722399-1-yoann.congal@smile.fr>
Sender: Luis Chamberlain <mcgrof@infradead.org>

You wanna address the printk maintainers, which I've added now.
And Josh as he's interested in tiny linux.

On Sat, Jan 27, 2024 at 11:00:26PM +0100, Yoann Congal wrote:
> CONFIG_BASE_SMALL is currently a type int but is only used as a boolean
> equivalent to !CONFIG_BASE_FULL.
> 
> So, remove it entirely and move every usage to !CONFIG_BASE_FULL.

Thanks for doing this.

> In addition, recent kconfig changes (see the discussion in Closes: tag)
> revealed that using:
>   config SOMETHING
>      default "some value" if X
> does not work as expected if X is not of type bool.

We should see if we can get kconfig to warn on this type of use.
Also note that this was reported long ago by Vegard Nossum but he
never really sent a fix [0] as I suggested, so thanks for doing this
work.

[0] https://lkml.iu.edu/hypermail/linux/kernel/2110.2/02402.html

You should mention the one case which this patch fixes is:

> CONFIG_BASE_SMALL was used that way in init/Kconfig:
>   config LOG_CPU_MAX_BUF_SHIFT
>   	default 12 if !BASE_SMALL
>   	default 0 if BASE_SMALL

You should then mention this has been using 12 for a long time now
for BASE_SMALL, and so this patch is a functional fix for those
who used BASE_SMALL and wanted a smaller printk buffer contribtion per
cpu. The contribution was only per CPU, and since BASE_SMALL systems
likely don't have many CPUs the impact of this was relatively small,
4 KiB per CPU.  This patch fixes that back down to 0 KiB per CPU.

So in practice I'd imagine this fix is not critical to stable. However
if folks do want it backported I'll note BAS_FULL has been around since
we started with git on Linux so it should backport just fine.

> diff --git a/init/Kconfig b/init/Kconfig
> index 8d4e836e1b6b1..877b3f6f0e605 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -734,8 +734,8 @@ config LOG_CPU_MAX_BUF_SHIFT
>  	int "CPU kernel log buffer size contribution (13 => 8 KB, 17 => 128KB)"
>  	depends on SMP
>  	range 0 21
> -	default 12 if !BASE_SMALL
> -	default 0 if BASE_SMALL
> +	default 12 if BASE_FULL
> +	default 0
>  	depends on PRINTK
>  	help
>  	  This option allows to increase the default ring buffer size

This is the only functional change, it is a fix, so please address
this in a separate small patch where you can go into all the above
details about its issue and implications of fixing this as per my
note above.

Then you can address a separate patch which addresses the move of
BASE_SMALL users to BASE_FULL so to remove BASE_SMALL, that is
because that commit would have no functional changes and it makes
it easier to review.

  Luis

