Return-Path: <linux-fsdevel+bounces-74085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B7DD2F2BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 11:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99238302D53E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C16D246782;
	Fri, 16 Jan 2026 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WCF7cVDD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27DC3590C4
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557605; cv=none; b=M0iVlJa9ACxYCJUCzykTq6sBYPEKNnxbfc7bsKp5Cm5FzRiWjTfN80WhXyW68wdEw5jLEyNhC01qVB7x0riE7sIbePMAHj10v9J11PA8ko7qtt4lZCImNsZGbS4xRxiuf5cGXoO1pC+Yxfdp5AqFSzAyFLCBy3GVBtuS4XQPnoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557605; c=relaxed/simple;
	bh=fW48aaLNkBbdqH7KvcMJgixNgMqvTRK+gAl5/GVTNZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMAbcBkse428wPi3yMsi9+6LmEMJjP39fe+3ggmVuRBlbM8DmwkTTkjUKlfNgJmnnHS8QjQGRf2wvuRtVomBsuTXEC7JH9UaGREdmBz/V0vzDyniPmH8boFggZTTzg7JAFQUKL15TWYxZMAUHAxJk1gl3jmFBu0CTYq3Ih56iRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WCF7cVDD; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so1639862f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 02:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768557601; x=1769162401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ik7nBSUvqjiZji8p0UMpcxyJ9CmKYvj/STnQwZRmw6o=;
        b=WCF7cVDDVoB7pSe59ofWaHYm6WNWzgeCXj8b+qY0A56i1sLhU7jfZqSVNd09WGg+iP
         f4eR9gPxvQR5/pHfAGNpik4PCuv6aKvY6ouYfZtAaHwrnRuZFJw3FTz4pmkHEG86FoB7
         TMmoYc+q95nONQi9si31m7D047LidkhP8UUnwP+UOdoThlMX5CJcYB04BF9WOnets/Tg
         L5dlHcJONq2vPjUjHvC1mCTJQ2urla/2xjO+iH5DEdnk4eUv+OCuOjTemCPEY2alMOZa
         fWYcpaR3qVDtomJZhGypYpkv6zIeBvXluZfpLRi9Y+0snNxTaupLZlVdQB6Xr29r1t2X
         AIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768557601; x=1769162401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik7nBSUvqjiZji8p0UMpcxyJ9CmKYvj/STnQwZRmw6o=;
        b=m4t0KVflqd3ZGOQ4YgoycFws3Jpa3+BNgyV1WomeB3WLb2EMjOivvUOqdFh6xn/bmJ
         UZ1wv4QU4Rd00z//lRPg1cGI1CnQz0ONTRmmKdWS+78ZanuGkwvYjjz1MKYoryB0FMNt
         TZDNPOBK4VbaEfR4XEMCaGvSJkGo7AGQ+3yN1THVQiPI/JgkaVU1DnwudjLixChien0N
         lKK7Frxc5JyhQv0V+h4jI8e2E9W/XE7ShP6ZoyPMe+iyGo7mWgwGFKLBcUz/VssHBcZm
         SmzL3vcsESHpG8XO9SmoaRI2mFo5Lj74C93GpDrwU4tjcjLtKJ2yGjyXYwUtPeUoUilr
         jROA==
X-Forwarded-Encrypted: i=1; AJvYcCVtH0SRNIQk4aAnpA7fy28CSztYhwWNlvEPq6KAJiG6LqlnBAx3JCsH98R3AQ3XjZvLdlFS+HHZwqlIHdgv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8IOW4ZFKrO+Z1FPljUCDCt4Vzo6X1i/NcPP5nLnWJgRBPUmPx
	Uw0Z0MZna7OwpURHMX4ixyxz4loq3gKoB6yhLATsSNVm6zATN1w7F5oo0W9k6F8beFo=
X-Gm-Gg: AY/fxX6Y6UqOzDf6OqL1/vngnUNrWODBPE5+IWObPRBNQBPG/38NRIc1BQ4mXz8Vj4B
	35mjYrpS0b4m3yRvCWASnq9fnUeSSoVfYDrVX0Y3HEn4U232Z9DLCoQD3mvQV1iLrYyZWoPawRM
	rwfjj3zgJHJTwYO3RYMcI+FoHfemWLt8UpWZzMBTR/PCoJGn1CAg9dHCgxJLIGc8oAxxlCOd/lb
	QAMKW8URdsJR6lZPYoqNcFpLwhOkCnwjy8LHNg5pUZJ6cSWCR6RA2xXUU8joeMQhP0XEMCZUcmO
	f57/2JGkoTYrxeYjddJU1PKCl8kadvG2B1MSSR5qdfuBCb+tLIkvGt6eX8kY5pG4FtbHaQtPQ+H
	eGvUzo0tq6FIqkSGfMPHcBEnDcUn5F2X1Q+e+oeqmt9Ky0sEEDCOM0sWyy/gqyWRDRiF0xblXC4
	dVq0EKsGkvlTrrpg==
X-Received: by 2002:a05:6000:26ce:b0:432:dfea:1fa8 with SMTP id ffacd0b85a97d-43569bc5767mr3019291f8f.45.1768557601174;
        Fri, 16 Jan 2026 02:00:01 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921f6esm4337797f8f.4.2026.01.16.01.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 02:00:00 -0800 (PST)
Date: Fri, 16 Jan 2026 10:59:57 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/19] drivers: tty: serial: mux.c: Migrate to
 register_console_force helper
Message-ID: <aWoMHbbn-BmmbZMg@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-15-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-15-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:22, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
> 
> --- a/drivers/tty/serial/mux.c
> +++ b/drivers/tty/serial/mux.c
> @@ -390,7 +390,7 @@ static struct console mux_console = {
>  	.write =	mux_console_write,
>  	.device =	uart_console_device,
>  	.setup =	mux_console_setup,
> -	.flags =	CON_ENABLED | CON_PRINTBUFFER,
> +	.flags =	CON_PRINTBUFFER,
>  	.index =	0,
>  	.data =		&mux_driver,
>  };
> @@ -547,7 +547,7 @@ static int __init mux_init(void)
>  		mod_timer(&mux_timer, jiffies + MUX_POLL_DELAY);
>  
>  #ifdef CONFIG_SERIAL_MUX_CONSOLE
> -	        register_console(&mux_console);
> +		register_console_force(&mux_console);

The situation here is the same as in 16th patch for
ma35d1serial_console().

Also "mux_console" is assigned to

static int __init mux_probe(struct parisc_device *dev)
{
[...]
		mux_driver.cons = MUX_CONSOLE;

		status = uart_register_driver(&mux_driver);
[...]
		status = uart_add_one_port(&mux_driver, port);
[...]
}

So, that it can get registered also by:

  + mux_probe()
    + uart_add_one_port()
      + serial_ctrl_register_port()
	+ serial_core_register_port()
	  + serial_core_add_one_port()
	    + uart_configure_port()
	      + register_console()

And we would need to pass the "force" information via CON_FORCE flag.

Best Regards,
Petr

