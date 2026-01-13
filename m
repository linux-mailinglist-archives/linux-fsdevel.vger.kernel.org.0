Return-Path: <linux-fsdevel+bounces-73482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D0FD1AADE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1454300ACFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB29350D7B;
	Tue, 13 Jan 2026 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ru2sEbeo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E239C3815D0
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325844; cv=none; b=oN/+Xz+2Gmie2nUaJAynjgyNeFVtag4frUu61XLJNc1CpGZhiDNqY35pc6eq7Hc4WcMy4eucbqVTXBky0mXmR0De881+GNDf8VGC0zvsWj3HEEvtnJ7qNHZovnNqYCP8xzANg37izXXZiT3kkrEFdny9DP1PzuNvIYTnnEic0Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325844; c=relaxed/simple;
	bh=ICK4ui9NDNRZmZPvqUFhVVRYDzu3U7vjvh8uoefFqv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPnS1Jo4Xor7iO0oJQpiBwAlwCL4avP0VkUdTKkMOwcsE/u20aYqfKWWS1sFgvbnFVmvwF6dMyLa5Kkydoqtt5Xx8OiMEc5+KKn+NX/zpS2n0+Eax0o4IwDpubl3a43E6njDNhfhtYGygfrqP4WNdzKe84p+n518jPFXKlDnoM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ru2sEbeo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-430f57cd471so3943966f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 09:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768325840; x=1768930640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/CVOy4tPw1zWY0e6rYcKRwtfrfRvUlKFzd8YTNoGp5w=;
        b=Ru2sEbeo3aF1V5dVdmZ8y7qebfvXyJmIOu3zKjZ0L9VDAaRDnX70AwM7BG2MTCNZwb
         Wt2M0HgSorW10TpGQfsg9caRtjEHGygzZnBCUoVZVtJ9cb0vr93mesbIAhkVPGacjxdE
         7HU2OwKQxMCRd8/BsuI9FzZju+1UH8Go43H+kiq9CHCnMXgCIpF7/w0CTdPzN1DW1Rpm
         vJFnt7QVkUwAiqmRpO4P0wQ4QtHunX4dgFkC5Y5pl2pjWjZOPmVYlIv+L2228OrXc7FR
         T3QgLrVe14c5TYcEkEJYXN3hig3ZqFkIKuc/jaTuv7lqME1z4P3n4adyHDJ+f9c9YNAe
         Bvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325840; x=1768930640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CVOy4tPw1zWY0e6rYcKRwtfrfRvUlKFzd8YTNoGp5w=;
        b=aV3hj6GxWyYXINzxJfFit+Qxc7fr61smflKD6prHcFFT0wC10lbw4xdC2YmeLqREn7
         cBlnqWzruL/3bb758IXrIe2ks7h4JiIPJqSkyHkupeRyuoTccj1bal6X6x549sIAWfwu
         yzpJqnwXBMK1yW0W4t7PWvPaqP68mZwleMIEHt6DGlbmprgWXwu3hRioX2CXp8/yBRNA
         1Hp/T0R1HMUEoZNXmyG9WRzuA5BLfFoTFPbPpSGBX4h2yqcAk3vI1pzWHFXOv1q6RP1z
         3ZxUR2Y7Phf4s+m0xQGHwqpqBS7Y9kYWoH8mAjt/SsK45+2rIcjHmb1sNpdTDe/z5HgB
         3F3w==
X-Forwarded-Encrypted: i=1; AJvYcCVaXYxrQeDcFmmHHxPKdP2RVTpPwhEHRn2mIdzga1pDYUkp9Y7k5mLwhMAK0fReYGSfoXW4GFnUhF2MrVpB@vger.kernel.org
X-Gm-Message-State: AOJu0YzVWzjF/5dT3qXx7y5lkgp2IWWK1XQpOeWikkvvs1Ys55ILj2j3
	WEngjIoKFwjfMFTULZ32Y5URgUAeGexwhiEPinDbWm8XjvzUlwzs11gVFft3Y9HLKqc=
X-Gm-Gg: AY/fxX7QLCByOW/Wqk/VO35KKyK1igVy+ocMBTz6FKIpR/GXsfv43Yi5eZM/KquPcxG
	XKfL6pVrBwJK3C3hwP9s4l9YJGbHTRei5xk02uyspjpznxbttvE1OMYMXePrKyZqLPxZr2jzcMl
	/p1JBOw4/CPztWheNWyi720O1n31ZUwBuUoK5ukaTWwT0pc5FKk0oRaW8gPzUg1vrPKykEEe3k/
	pzdta2VM1CDIyPCcn4S/mKu6kOI7lOToelGuMrkHVHbw0ioVC1IMZW7tpqbARhTtkgtmvnPecxp
	LQ+IfJmG+aInz69WED0pFlBxiLC+tgYN7L2cVj6IurIP/d1wPG/Ui4mSx8/GQAYPjLqyQZsgF4G
	iRCo5xZNPJCoIkD3uRpa+PANFwVEMM9g/iPVhRh5JV9b+AiQrvOzU5xl2gs/nsZkkh1uSbC+Ajg
	bHxEHI7iqo+OIF+g==
X-Google-Smtp-Source: AGHT+IHUReQqvVgC0db5F0/UgqAPwHgCcpq2ZD0lhm0g7XnDeEa3Phlj1/GEitKl8zvqkUFbSZC6XA==
X-Received: by 2002:a05:6000:2dc9:b0:430:fced:902 with SMTP id ffacd0b85a97d-432c36436fbmr29258778f8f.26.1768325840268;
        Tue, 13 Jan 2026 09:37:20 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432d9610671sm28342147f8f.34.2026.01.13.09.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:37:19 -0800 (PST)
Date: Tue, 13 Jan 2026 18:37:17 +0100
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
Subject: Re: [PATCH 02/19] printk: Introduce console_is_nbcon
Message-ID: <aWaCzZ8_UuyAa6xp@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-2-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-2-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:09, Marcos Paulo de Souza wrote:
> Besides checking if the current console is NBCON or not, console->flags
> is also being read in order to serve as argument of the console_is_usable
> function.
> 
> But CON_NBCON flag is unique: it's set just once in the console
> registration and never cleared. In this case it can be possible to read
> the flag when console_srcu_lock is held (which is the case when using
> for_each_console).
> 
> This change makes possible to remove the flags argument from
> console_is_usable in the next patches.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  include/linux/console.h   | 27 +++++++++++++++++++++++++++
>  kernel/debug/kdb/kdb_io.c |  2 +-
>  kernel/printk/nbcon.c     |  2 +-
>  kernel/printk/printk.c    | 15 ++++++---------
>  4 files changed, 35 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 35c03fc4ed51..dd4ec7a5bff9 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -561,6 +561,33 @@ static inline void console_srcu_write_flags(struct console *con, short flags)
>  	WRITE_ONCE(con->flags, flags);
>  }
>  
> +/**
> + * console_srcu_is_nbcon - Locklessly check whether the console is nbcon

There is _srcu in the function name, see below.

> + * @con:	struct console pointer of console to check
> + *
> + * Requires console_srcu_read_lock to be held, which implies that @con might
> + * be a registered console. The purpose of holding console_srcu_read_lock is
> + * to guarantee that no exit/cleanup routines will run if the console
> + * is currently undergoing unregistration.
> + *
> + * If the caller is holding the console_list_lock or it is _certain_ that
> + * @con is not and will not become registered, the caller may read
> + * @con->flags directly instead.
> + *
> + * Context: Any context.
> + * Return: True when CON_NBCON flag is set.
> + */
> +static inline bool console_is_nbcon(const struct console *con)

And here it is without _srcu.

I would prefer the variant with _srcu to make it clear that it
can be called only under _srcu. Similar to console_srcu_read_flags(con).

> +{
> +	WARN_ON_ONCE(!console_srcu_read_lock_is_held());
> +
> +	/*
> +	 * The CON_NBCON flag is statically initialized and is never
> +	 * set or cleared at runtime.
> +	 */
> +	return data_race(con->flags & CON_NBCON);
> +}
> +
>  /* Variant of console_is_registered() when the console_list_lock is held. */
>  static inline bool console_is_registered_locked(const struct console *con)
>  {

Otherwise, it looks good to me.

With a consistent name, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

