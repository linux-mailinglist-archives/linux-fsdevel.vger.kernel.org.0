Return-Path: <linux-fsdevel+bounces-73642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A785D1D431
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 09:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91E48307889B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CAA37F75E;
	Wed, 14 Jan 2026 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UJDpRkoJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF337F733
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380267; cv=none; b=dOSWNZlEljLYrTVLSsmkBGYImLnkoyhlKrwoKb2+CnJ24Xi2lq8MG522GcIVt33qQtCVkw9RqCBwldxmTIRf+wVDLEPxYxM7U96SDIU4D7FAJHrf9Tnkr0knm3/1xucu4kbqSmGNf2kRt1N3toxkR43KvKIu/5SpanxDaHI1K+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380267; c=relaxed/simple;
	bh=ysd4WYTvCh9+HsQ1AtbOfW5FzL4/iKQHwd6lm5bPF7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMKl21FZ2PlsvMC51eq5MIUxVMwqseTwS2IkzSc0uHty13CVtvuprx5vf+OXCIgMwiWXWGDteW9IgqYjdQ0c67/66vZdxk760n5jxt+mr5IunsSVK8x2VZZWtj5ofjPbb3KcmKiAzRbXCnHSzdPSoXOH41/Y7erjk10C/hFrbpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UJDpRkoJ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-432d256c2e6so4679594f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 00:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768380255; x=1768985055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Nn9M/VPDoeuifL+P7no8o5FApQZk7zNKYvSR+p2CRU=;
        b=UJDpRkoJ07RgspaR1NhfCpR626ZyVYHDm/91x63cM8gsy5+B8MAqHavRm979cqv826
         adfCBmE4P0x6kfOJf6QVKQ+F73K8lwHrXn3rzPWHcqFa3N4E1nvvheWr+fvWlsfjnG3d
         q5I4aa3r8n+1bnVHkuJKjH4VnxEE0Ax/OlO+0AlsTNmjx9JmMpIQmGfXyFrUV7bjE4AG
         b+aIpJVdS5yOciq4wFCdKoOH2ygYDkIIMtINtTrq5bEwn2hZxdIsOnH1Mevl7p3aXRkT
         mmHrpfvAEIKMqwJsI6Dxxcv5mSGvyKeQIfwtfaMbksOr61rqb70D/17uospsX2LrpTOB
         fjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380255; x=1768985055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Nn9M/VPDoeuifL+P7no8o5FApQZk7zNKYvSR+p2CRU=;
        b=FCNohE73B8PuxzwNz7rR2mNBLEtSw3YHoMwrX3wiBZS1kt2cP/a0mwfw91Jca1PMU9
         5CmKAD0VapbySo8Ingfw2cy9y7ti4bQGEnJiy8Io+rNTpR7jm01FEzbBvOWwj0Y0iQNz
         +dHi7RB+f8xy3PGA76Ab2kB0s/Jskj3PDNuPY7bC3A3q86+luz6QzsxAnxw271P5T19N
         rhEGdvzfTPmtdE28T2V9iiDVDCxOjD/kb62x7/fPOEGZzzIMO1bhjDw6CCiuMijZg6S3
         /5JDCb4QLkugfNzhKeiAaXUspUQNYw59iV21V1hhAj6OwVKelLZJrrwuaeJEyELF/uWY
         BTsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6RNsOxJkRPpFGHy0KITTO5BHgkUl/SW0WXR6lJ1Jf9qFYdB2dWqMhphn4Ar5NAn8IK1pkPoKO3rUNFPs9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7yO8+s+UpyRV6TqlpAik8uTMoVJ4FcLbTi4iDiCkaScOocLy
	unFnDSq8BOcXwa+mAhlMREpyc9aAwfTt9U41ozDrOSweFV9ao8u5aP/3DsrH9Vw+uys=
X-Gm-Gg: AY/fxX4NHqprI456qPNcJ0IQP23TsPiTuypeD19/576ebm+sfJsNyQdAIBiQ+7+QRjV
	G854TUf4BEa5WVeLFhTNhIMylVgbV3UvuOF8CU9h70sEgjAmvHC7/gpiClNQTMROsF/yY8X1PSz
	nDjr+3ImHNZzv07w0JvrxeZjgyA/QB+3LzxtdOE0L88X0uTLTFtSzd79as+Y1MOsAowsgtXd4tj
	AUdYBhbyDH71lq8eEvjCrcZNdqYLnR8y1as3T+2BZ0EuwNwh9O1K1uNCJ4VfN0wNYDdlDNGQ7Cs
	wdT3dgAlQYN+pOdAFeypVRioT/UL83YousWGnnPOKymmMCkDSNUNyzrrmbyh8eS2AfKTlSrP5pA
	EViKO2rVc+V15YJvmd2bv0CHiI3yYWyIHC6TiSnaYp8aVRiBnyrkOh4jBU8+3h9MLG3APV6nLQz
	kxB2ZxH0UW1qhGmw==
X-Received: by 2002:a05:6000:61e:b0:431:a38:c2f7 with SMTP id ffacd0b85a97d-4342c574bedmr1500621f8f.59.1768380254886;
        Wed, 14 Jan 2026 00:44:14 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee5e3sm48685590f8f.35.2026.01.14.00.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:44:14 -0800 (PST)
Date: Wed, 14 Jan 2026 09:44:11 +0100
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
Subject: Re: [PATCH 03/19] printk: Drop flags argument from console_is_usable
Message-ID: <aWdXW6ohfQ7_z2B_@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-3-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-3-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:10, Marcos Paulo de Souza wrote:
> The flags argument was also used to check if CON_NBCON was set, but their
> usage was fixed in the last commit. All current users are reading the
> variable just to call console_is_usable.
> 
> By calling console_srcu_read_flags inside console_is_usable makes the
> code cleaner and removes one argument from the function.
> 
> Along with it, create a variant called __console_is_usable that can be
> used under console_list_lock(), like unregister_console_locked.
> 
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -656,13 +656,8 @@ extern bool nbcon_kdb_try_acquire(struct console *con,
>  				  struct nbcon_write_context *wctxt);
>  extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
>  
> -/*
> - * Check if the given console is currently capable and allowed to print
> - * records. Note that this function does not consider the current context,
> - * which can also play a role in deciding if @con can be used to print
> - * records.
> - */
> -static inline bool console_is_usable(struct console *con, short flags,
> +/* Variant of console_is_usable() when the console_list_lock is held. */

Nit: The comment is a bit misleading because this function is called
     also from console_is_usable() under console_srcu_read_lock().

     I would say something like:

/*
 * The caller must ensure that @con can't disappear either by taking
 * console_list_lock() or console_srcu_read_lock(). See also
 * console_is_usable().
 */
> +static inline bool __console_is_usable(struct console *con, short flags,
>  				     enum nbcon_write_cb nwc)
>  {
>  	if (!(flags & CON_ENABLED))
> @@ -707,6 +702,18 @@ static inline bool console_is_usable(struct console *con, short flags,
>  	return true;
>  }
>  
> +/*
> + * Check if the given console is currently capable and allowed to print
> + * records. Note that this function does not consider the current context,
> + * which can also play a role in deciding if @con can be used to print
> + * records.

And I would add here something like:

 *
 * Context: Must be called under console_srcu_read_lock().

> + */
> +static inline bool console_is_usable(struct console *con,
> +				     enum nbcon_write_cb nwc)
> +{
> +	return __console_is_usable(con, console_srcu_read_flags(con), nwc);
> +}
> +
>  #else
>  static inline void nbcon_cpu_emergency_enter(void) { }
>  static inline void nbcon_cpu_emergency_exit(void) { }

Otherwise, it looks good. It is a nice clean up.

Best Regards,
Petr

