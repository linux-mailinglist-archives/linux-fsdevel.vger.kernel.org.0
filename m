Return-Path: <linux-fsdevel+bounces-10246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9DF84958C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 09:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED991C21FE6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 08:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1790F11706;
	Mon,  5 Feb 2024 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gFzYo+ms";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1W5AvZd6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAB8111A0;
	Mon,  5 Feb 2024 08:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707122380; cv=none; b=gzeZWGnz3xnA1DTuNEKRh+e6o9XV3shrsvgwgLyKfBZzw+UaCo1VP0FJgovqwoz7K0z0EST2yAPcV0lKpqVFoYmoKZbPWJt2IYDJCG4RTQysivoayyvmVARi0dZNV3HIhJNjzw5UzUeVgDffYaFAQtKfVQLWRlYFpWT3vzb8dG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707122380; c=relaxed/simple;
	bh=glbysHXbTHeXgr5vqZPyAXI1kRCcReCyMqy5wLvmetQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sK6oFExT6Bd/j62uTCQkmIQ4wgHGwSOyE1Up7zjD1hNgYKRcbyIUaiJzNMfjXoPXgAdGe40KXicvY+RHdrsZpkItgEzcqvIC8xGSS1ZuYeoMUGh2Dmsh1eNUjKrOTarGmLgDeOEMEBgQKXXeQxG53W5IXuPnMKYGSxYw17g3mGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gFzYo+ms; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1W5AvZd6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707122375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=410oVLaTDeyabSNXtoLd0DEYuxw6VZoAesHkjytsmkA=;
	b=gFzYo+msOvMEqmQChOwt9aQES7HiYfENSE4iVu2jY2ht0dYMaOgcJlESbXeHr8TFE/rSPI
	kdChic2EqUi6SYMJMLOpiHNIuBy0mR747eBjdTi1P8gkVP0Hvmxqho3Sxauacs0efjCirX
	EBTErOi618UP4pZJ93kHE7JBatfkH6QBSbiiZuLMLTVkgUUJ3Up0+MZeeBR9T0hwZo2RW3
	T1ILu/liVJtWjx0ZBeTRwH5ytiL70VbZQ5C7uzB7farneeZsWFuaezpGrGL0mu40MnfP6H
	2Q715CyvsbPMi7cpEV3K2lPvJT4R3iJ7ELBmYlwJmwm7Q5tb/IMRLJL4sgWegA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707122375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=410oVLaTDeyabSNXtoLd0DEYuxw6VZoAesHkjytsmkA=;
	b=1W5AvZd6AD73J8/TVCafIxEOeHTeYFntbFzFdcKPaAtejg3RNTMWK1wKMmOZD2ZSBxdbnW
	Et6AH5rJwsuRCpCA==
To: Yoann Congal <yoann.congal@smile.fr>, linux-fsdevel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, x86@kernel.org
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Borislav Petkov
 <bp@alien8.de>,
 Darren Hart <dvhart@infradead.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "H . Peter Anvin" <hpa@zytor.com>, Ingo
 Molnar <mingo@redhat.com>, Jiri Slaby <jirislaby@kernel.org>, Josh
 Triplett <josh@joshtriplett.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Peter Zijlstra
 <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Yoann Congal <yoann.congal@smile.fr>,
 Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH v3 1/2] printk: Fix LOG_CPU_MAX_BUF_SHIFT when
 BASE_SMALL is enabled
In-Reply-To: <20240204232945.1576403-2-yoann.congal@smile.fr>
References: <20240204232945.1576403-1-yoann.congal@smile.fr>
 <20240204232945.1576403-2-yoann.congal@smile.fr>
Date: Mon, 05 Feb 2024 09:45:27 +0106
Message-ID: <87bk8vpao0.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-05, Yoann Congal <yoann.congal@smile.fr> wrote:
> LOG_CPU_MAX_BUF_SHIFT default value depends on BASE_SMALL:
>   config LOG_CPU_MAX_BUF_SHIFT
>   	default 12 if !BASE_SMALL
>   	default 0 if BASE_SMALL
> But, BASE_SMALL is a config of type int and "!BASE_SMALL" is always
> evaluated to true whatever is the value of BASE_SMALL.
>
> This patch fixes this by using BASE_FULL (type bool) which is equivalent
> to BASE_SMALL==0.
>
> Note: This changes CONFIG_LOG_CPU_MAX_BUF_SHIFT=12 to
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=0 for BASE_SMALL defconfigs, but that will
> not be a big impact due to this code in kernel/printk/printk.c:
>   /* by default this will only continue through for large > 64 CPUs */
>   if (cpu_extra <= __LOG_BUF_LEN / 2)
>           return;
> Systems using CONFIG_BASE_SMALL and having 64+ CPUs should be quite
> rare.
>
> John Ogness <john.ogness@linutronix.de> (printk reviewer) wrote:
>> For printk this will mean that BASE_SMALL systems were probably
>> previously allocating/using the dynamic ringbuffer and now they will
>> just continue to use the static ringbuffer. Which is fine and saves
>> memory (as it should).
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/all/CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com/
> Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
> Closes: https://lore.kernel.org/all/f6856be8-54b7-0fa0-1d17-39632bf29ada@oracle.com/
> Fixes: 4e244c10eab3 ("kconfig: remove unneeded symbol_empty variable")

Reviewed-by: John Ogness <john.ogness@linutronix.de>

