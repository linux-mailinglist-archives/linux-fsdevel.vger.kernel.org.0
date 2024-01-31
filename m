Return-Path: <linux-fsdevel+bounces-9669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F4A844357
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 16:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DFE1C245D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CD712A162;
	Wed, 31 Jan 2024 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H9SVQJ3k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uMlUuZq/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828431292FA;
	Wed, 31 Jan 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716060; cv=none; b=mBhHP7ZNR5IatxETtGnOD9o7IZWLstIpUp6A9RMzf6o1kRhYg6533YeeJFU79pt92q9PgAiXRZH37Xg+FRbf+pNghFil9GYPYOW2Y4ZI/XGRvWnRyv6bnxkn8MyRDaURyVk+qoGwrSqpfvEFDctItQOz2EpSmBeKDusH8gEZzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716060; c=relaxed/simple;
	bh=dPqaiX5PAWnQlOQ8Jiutu8bSeKEr3U2pTg/+HqQA8Ak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O6iptg37gIBvci8kk5Rq9Bg4tykHSaqQ8DbLGeP9ras1RCQHb0xHwdlRphTv8F1t/KtO5tySYe8VPNPKa/KIDPDI0rmj/KttC8/eXOHtkugPkVemJbhgc6IKWzwkxX/gB/72O0T8JJ7vskJGV4r8Hyk1CGrAm7sz5N+98kv/aIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H9SVQJ3k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uMlUuZq/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706716056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgMsdbxCaBeot/1FIP0WAPLTrTPmjNYgZHCMmQQu8dA=;
	b=H9SVQJ3kZBcTos2bLSoPIrvvuZKMApea5Qu9HHZYgNM8BNQfA/OHFJ+WjVXo9vY7aDRTYj
	ADHdyOKvce0Yx57ElMxY8VKqQeBrB6bnGXVcCpphzLJ/FAxc3tG8ylCm3Mfmi7ES3VJNgc
	5INdOZHUh6oDVntoImpbiMFZj0rr9FigBfKXo+yy499BbD7YTOHzSGSullWchOTiHzaAaF
	xqtwBg4aOuV84BADA55KqidMBwO1u0n8G0zIEXQYRWuYIwFbwbUrc8aYvIVAkzifI8qQzg
	SQE7/RUsoOi63G/shU8/5VmgYyTiG17bDxAPMZoZjyDiiGljPu5dtVIlgnfHxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706716056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgMsdbxCaBeot/1FIP0WAPLTrTPmjNYgZHCMmQQu8dA=;
	b=uMlUuZq/EpH/uEvkdR/5kovyAEmTtSfIOBdtlMc+HOaYYqnXFmQEhRRc2BfnSYhyfHHkXS
	XtjXjlW9DmUwSGBQ==
To: Luis Chamberlain <mcgrof@kernel.org>, Yoann Congal
 <yoann.congal@smile.fr>, Josh Triplett <josh@joshtriplett.org>, Petr
 Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, Matthew Wilcox
 <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, =?utf-8?Q?An?=
 =?utf-8?Q?dr=C3=A9?= Almeida
 <andrealmeid@igalia.com>, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2] printk: Remove redundant CONFIG_BASE_SMALL
In-Reply-To: <ZbfLl6PR_qxxreeX@bombadil.infradead.org>
References: <20240127220026.1722399-1-yoann.congal@smile.fr>
 <ZbfLl6PR_qxxreeX@bombadil.infradead.org>
Date: Wed, 31 Jan 2024 16:53:32 +0106
Message-ID: <871q9xzeqz.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-29, Luis Chamberlain <mcgrof@kernel.org> wrote:
> You should mention the one case which this patch fixes is:
>
>> CONFIG_BASE_SMALL was used that way in init/Kconfig:
>>   config LOG_CPU_MAX_BUF_SHIFT
>>   	default 12 if !BASE_SMALL
>>   	default 0 if BASE_SMALL
>
> You should then mention this has been using 12 for a long time now
> for BASE_SMALL, and so this patch is a functional fix for those
> who used BASE_SMALL and wanted a smaller printk buffer contribtion per
> cpu. The contribution was only per CPU, and since BASE_SMALL systems
> likely don't have many CPUs the impact of this was relatively small,
> 4 KiB per CPU.  This patch fixes that back down to 0 KiB per CPU.

For printk this will mean that BASE_SMALL systems were probably
previously allocating/using the dynamic ringbuffer and now they will
just continue to use the static ringbuffer. Which is fine and saves
memory (as it should).

Reviewed-by: John Ogness <john.ogness@linutronix.de>

