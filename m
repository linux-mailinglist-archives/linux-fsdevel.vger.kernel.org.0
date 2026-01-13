Return-Path: <linux-fsdevel+bounces-73472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A5FD1A38E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BBB730275AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF872EFD9E;
	Tue, 13 Jan 2026 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FGSyEuus"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4BA2EC084
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321560; cv=none; b=cX9H5BBMnAsMDjEdTJGzOCOkmMfJh+xnE2WPZr4RRQZvNiCo9ZXErjunQHNMhpy4ADLLI1RPwClxvf5JADqW/QtXuC5tPnm96L3O6uhIFUsQhW6pXcWJmX11Xbnt5ExqHQFLiB0gHfP3xrAiyf0G0Dgh1lBgaAoRf43Ga2UXKqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321560; c=relaxed/simple;
	bh=tEU15hlDUcTJJO53/6hArpv/PNu5aaHiWIXc6QqAK0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5cIQUyh3SBb5ad8N4LL9/vVxQW/dDC1tyRedp3Tr5pK1mF7FkGNJxEVR2o9aP5cInEJNtuUERz/ZymKfdCModCg2bPO/ypzXNMDDkCWWt8sMrjqSh3Hjt+n89XTK8yhYj3kUvptEtT4Eh36hqYcXSbQfNP4Zg2D7mlSoSeLSF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FGSyEuus; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso71146285e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 08:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768321556; x=1768926356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y9kSWtn88k+QkPqpOG7NN6Fxk/gRH5gvJVVHZoYjlVA=;
        b=FGSyEuusFmgrT0XsAUYKc+T1x7+rMlFZ0ZDJ13+ibdAuF76j/kaYXC/4SYPu2aBOzQ
         sHeRusEJOZlBU4pbpvtBbiDdJoMZd1C8STFiLYT/KIQa14Sw1fkPw34aAflH83PLQL+E
         lQR4drZq8Q5FQW+pDM9NGGnj7rODVJPPGbaek9pMRPTC2JYDDJnEsSV1L3tmXyJFlBce
         BANRLJB0M7OgWSLC8LtB9994Q+ZAb/3YdsfFwDbFrYniG2Zs44fv05yeLk2yV47Q0SVz
         J5yGi5P/qBe7Gbq5lz2kCYqhMqNJ263/zAzb+Zz91mt6v9BC/otd7447j5yJTlJXGXt5
         VrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768321556; x=1768926356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9kSWtn88k+QkPqpOG7NN6Fxk/gRH5gvJVVHZoYjlVA=;
        b=GEXqV7rKJZUUP1qXKYhNiYAC5rY0nq8/69U/iIHDIW8ahR/JaLXml1e0gBEEwLw6/C
         bpSqtDrItxIyuXfe4Rj02C/A1uwyjMp9V7N7aKoHoXuIKRZovAr2skvVke0xZKwfCaK7
         UHmHoV6sERqghqDZmh+nbnwccW88UR+KRbb7BHCpS8JFOSnHXR+sYnLu4DSjzKtcK847
         R8/pmo1ZX6hsGO9trhK62WXjqnO9URDAloiZAtXCLsu/cVAVB1bnSt3aEBw3FAf3NUUt
         eXBifHgf/eiHr4YKLFXWqVQZh+ZbUX9HawSdBT+m4PrhHyszwTKfahD0vGzZCDShOSOh
         2BHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXRewaR6ub8KH+eWM6d1nQ1a9RVMs+T7ZDDrrxgFdaMOmjLoqqNP9WJO7oKzi77fWRO/WpMjKezwul+IFO@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkey6CQk5s+k0T3eNhDVHCZn6f/k+xbUB79/KDa4jkO/MPVFKi
	/LxeH0Q3L9Yd+mbuen+khlTYoxSfOAKj4+oTEjRAeZ8j80h9BSeskxQGOKcGWDF1qxg=
X-Gm-Gg: AY/fxX4n/NKxzTr0zm0CyXko8ItxakMQBGnwaoa96rlM4BZY5dDWt1ObUxWUbfp1Kft
	ZDlZ9XbTSG2FeFZoOh244YQw3pD23tGv+klsd+IfrXKTldUF5sbcHvKchOw7PZa+gxOsOiJ+cny
	jdxsArph9+5PRw0IIVscPeZUTm5epyQ0vJZd7kOkrMfPdPuE+ZVjKAyZz3/vHuvckW6YfNNL8sk
	9+bx+tpgDeV+hA0nLD/mfDo7ZFWn5afY5e+r+7Id0imkV7OGsQgphLe9o6edyHaVECdS4QIUlFg
	KPdE7wmXlAfRCkxxpueMwdX0AKHyn82jLG8Elw8Bitpfz46CQvhlPArVl/J5OlGjpIK6C8U4GJE
	FsDOrknpQIywFuoLM7qSXDYlwBBXVgJNsbrm04szDS5fqG/cGGideYHWEbyptZ4Hbb92pKYn9mZ
	KfWj539HlQ9jeSEEM4vuPBljft
X-Google-Smtp-Source: AGHT+IG4o2sMRbjal/wNqE1AyBhrQEhgOmuQP9i1Wb50Y85ZgDNaJvwCCbv/cl0e10bMkrsnwOfPLQ==
X-Received: by 2002:a05:600c:1e1c:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-47d84b0aa4bmr229523325e9.5.1768321556267;
        Tue, 13 Jan 2026 08:25:56 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dad8bsm45637605f8f.8.2026.01.13.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:25:55 -0800 (PST)
Date: Tue, 13 Jan 2026 17:25:52 +0100
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
Subject: Re: [PATCH 01/19] printk/nbcon: Use an enum to specify the required
 callback in console_is_usable()
Message-ID: <aWZyEHsOJFLRLRKT@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-1-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-1-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:08, Marcos Paulo de Souza wrote:
> The current usage of console_is_usable() is clumsy. The parameter
> @use_atomic is boolean and thus not self-explanatory. The function is
> called twice in situations when there are no-strict requirements.
> 
> Replace it with enum nbcon_write_cb which provides a more descriptive
> values for all 3 situations: atomic, thread or any.
> 
> Note that console_is_usable() checks only NBCON_USE_ATOMIC because
> .write_thread() callback is mandatory. But the other two values still
> make sense because they describe the intention of the caller.
> 
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -202,6 +202,19 @@ enum cons_flags {
>  	CON_NBCON_ATOMIC_UNSAFE	= BIT(9),
>  };
>  
> +/**
> + * enum nbcon_write_cb - Defines which nbcon write() callback must be used based
> + *                       on the caller context.
> + * @NBCON_USE_ATOMIC: Use con->write_atomic().
> + * @NBCON_USE_THREAD: Use con->write_thread().
> + * @NBCON_USE_ANY:    The caller does not have any strict requirements.
> + */
> +enum nbcon_write_cb {
> +	NBCON_USE_ATOMIC,
> +	NBCON_USE_THREAD,
> +	NBCON_USE_ANY,

AFAIK, this would define NBCON_USE_ATOMIC as zero. See below.

> +};
> +
>  /**
>   * struct nbcon_state - console state for nbcon consoles
>   * @atom:	Compound of the state fields for atomic operations
> @@ -622,7 +635,8 @@ extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
>   * which can also play a role in deciding if @con can be used to print
>   * records.
>   */
> -static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
> +static inline bool console_is_usable(struct console *con, short flags,
> +				     enum nbcon_write_cb nwc)
>  {
>  	if (!(flags & CON_ENABLED))
>  		return false;
> @@ -631,7 +645,7 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
>  		return false;
>  
>  	if (flags & CON_NBCON) {
> -		if (use_atomic) {
> +		if (nwc & NBCON_USE_ATOMIC) {

This will always be false because NBCON_USE_ATOMIC is zero.
I think that it was defined as "0x1" in the original proposal.

Let's keep it defined by as zero and use here:

		if (nwc == NBCON_USE_ATOMIC) {

Note that we do _not_ want to return "false" for "NBCON_USE_ANY"
when con->write_atomic does not exist.

>  			/* The write_atomic() callback is optional. */
>  			if (!con->write_atomic)
>  				return false;


Otherwise, it looks good to me.

Best Regards,
Petr

