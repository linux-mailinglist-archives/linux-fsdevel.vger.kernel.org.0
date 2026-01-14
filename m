Return-Path: <linux-fsdevel+bounces-73729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8437FD1F655
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6BBF3042298
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905FD2E1F02;
	Wed, 14 Jan 2026 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HHqfcaHC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1EB2D8764
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400586; cv=none; b=PpNLYeyDU41+Mop6/IGhSY22wKbNQN/3wyAIbEaIWt1jMpZePPC0CaUAaHThtA6xKXm/hCWlYUjnA7NyjToXqwFM58wPjLtQzaw3BSLBs5LXwJm6YJxAlOSv0DqCse3IohSlK39ic/zVqmNEXqtRYO209WLfmpY4HEP7Cb3goR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400586; c=relaxed/simple;
	bh=DfrdswblHy1q9UZ6D1iDapX7djYN6NrxRY58tdu4Ov8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjAWIShbQTOt8pFlr6f+G7GO0w/qpP2EJrjBBrDZLfV1DCVsoNAdqx6ba/UEl5wdmt+SrL5EK2jylcDJysqDhpxSprhpwWMKsSI9nvK3hMZ13NEHLVlmDeoB348nmXHgnnBItHtzNw6xuOlJz0NmswkevuF96QftVdySl4V6qH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HHqfcaHC; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso8892405e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 06:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768400583; x=1769005383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjJ0doliNf6plVmMYQkV7IlLiBwqr6x+viyB7m/anSs=;
        b=HHqfcaHCDZ4C/25aiu2LLUMRB6a3JGJWGhQfFT6QaEtcdkNlMy33Eg5S1g6VGmzYXo
         hpfCXuvsZWvysbszR52KoZ2Hm1zuNEeCpDbVwfZG4XIIepu7J6DwkkZTdV4+WvGZUfb2
         J50i9CArQzRD7a32Tos9uS2iTNN+n78n5NdtroiOypIe6+cM2D5E/4P5BmzBG0Y1OMZi
         TF2vHM81yG5bimXpDBncf/8rbHqG0I7eJ966s7d0iQ2MM9s31pdW7eDgXOSxl6kdp6c/
         Y/on+swJawD0gJ25otHcu9wX57o6bpwey1K2T1Em/Ha1Hnr4ql+oU5YXD54Y+M9nX783
         +Gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400583; x=1769005383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjJ0doliNf6plVmMYQkV7IlLiBwqr6x+viyB7m/anSs=;
        b=nLB1J8zHOzPkBg2HlMcIJAZwk/exjaglpfk2Ie3LI2Tp+dAf0UBXt80Hj7CpoJcF+P
         xcHovFWHQpoVVTtCckXeksuWy7Qgo43ccyc5NoEb6tJyEXWHvtcixJL/wK3P7NJ+4gcU
         kKP+EXikqb28xzN0kU3W6kONA13/VKiGvRJu7gzaZTmS2n3f5SSCuIwV0hHTR4PMUg0f
         lT3RnhrGjzDOCt3TxdsFxckDwcQ0V6BoG18ttM2k87eReeRVKFlgVb6ZZlOLbHnVastW
         JHjQcwP5AQNp/WuktfSyYdyPGR/Ni0SGgrSZbcGw0bsccCtdXA/lQlLM1xeKXubsmZtl
         Pcbg==
X-Forwarded-Encrypted: i=1; AJvYcCXmv+f4COpe7IrbKgAExSwEjS9vHOu9qSTyjVlHEZ0s5XsFTNdLEapg4aQhliZTb+0WigyyPUerdZYnoYwV@vger.kernel.org
X-Gm-Message-State: AOJu0YzlTrMAUjcsfzi4a3iQjTbMBgY8xQdhjHsg/amDb495z7KAGJ8l
	olikVdGlMxJ5DTm405jD9NtJMaFW9gCZa48zAP0cWnrpT46rjPFX03Xq/tFV0Y1vNGY=
X-Gm-Gg: AY/fxX5AQ3VgFhSkNSNNNPodp672LlTwSH0e70hDV2iZQBSFbSicUxFdbJsIr/GlKTa
	+k45WiWsjyItTMCcmU7pNRJB6goubjHMnonEHSvPP+w4Oh6d90/wh6c52KK08/YIDyR+GCwkmFU
	WfEz1qjqlIqVQ1vODVvM1HG723fk4yr+5KagAtX26cklqivsurwiOJl7ViGZ0RtWyZSOmN0kcpO
	piBMtFd45R0wcgeT94A1QDOMrlwKU2ps2/KaiNZEQH5tdORCz1WmLJwiH+gIQE7UcLYHhOk9ul4
	QXHaB2xqHl77M/ce4DV6f6kjF05FF2/fvbQyf9PCFhiy7YFjKhvHXA/XXnCBdcq9SR3Xfvg54p9
	VBiW6TxtPXTozwDQCIJ8SLy0uOqbbiSKfj2pMmgSCJdrFY4Ra3MXAj0dV6c2gT9dQr/wBYj5KBO
	hUYwqXbYAGFomStA==
X-Received: by 2002:a05:6000:3105:b0:431:104:6dd5 with SMTP id ffacd0b85a97d-4342c5728e2mr3256518f8f.58.1768400582935;
        Wed, 14 Jan 2026 06:23:02 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacd1sm49446446f8f.4.2026.01.14.06.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:23:02 -0800 (PST)
Date: Wed, 14 Jan 2026 15:22:59 +0100
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
Subject: Re: [PATCH 06/19] printk: Introduce register_console_force
Message-ID: <aWemw2ZCwtAd17I1@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-6-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-6-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:13, Marcos Paulo de Souza wrote:
> The register_console_force function will register a console even if it
> wasn't specified on boot. The new function will act like all consoles
> being registered were using the CON_ENABLED flag.

I am a bit confused by the last sentence. It might be bacause I am not
a native speaker. I wonder if the following is more clear:

<proposal>
The register_console_force() function will register a console even if it
wasn't preferred via the command line, SPCR, or device tree. Currently,
certain drivers pre-set the CON_ENABLE flag to achieve this.
</proposal>

> The CON_ENABLED flag will be removed in the following patches and the
> drivers that use it will migrate to register_console_force instead.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3858,7 +3858,7 @@ static int console_call_setup(struct console *newcon, char *options)
>   * enabled such as netconsole
>   */
>  static int try_enable_preferred_console(struct console *newcon,
> -					bool user_specified)
> +					bool user_specified, bool force)
>  {
>  	struct console_cmdline *c;
>  	int i, err;
> @@ -3896,12 +3896,15 @@ static int try_enable_preferred_console(struct console *newcon,
>  		return 0;
>  	}
>  
> +	if (force)
> +		newcon->flags |= CON_ENABLED;
> +

This makes sense because the pre-enabled CON_ENABLED flag is handled
right below.

>  	/*
>  	 * Some consoles, such as pstore and netconsole, can be enabled even
>  	 * without matching. Accept the pre-enabled consoles only when match()
>  	 * and setup() had a chance to be called.
>  	 */
> -	if (newcon->flags & CON_ENABLED && c->user_specified ==	user_specified)
> +	if (newcon->flags & CON_ENABLED && c->user_specified == user_specified)
>  		return 0;

But this location was not a good idea in the first place. It hides an unexpected
side-effect into this function. It is easy to miss. A good example is
the regression caused by the last patch in this patch set, see
https://lore.kernel.org/all/89409a0f48e6998ff6dd2245691b9954f0e1e435.camel@suse.com/

I actually have a patch removing this side-effect:

From d24cd6b812967669900f9866f6202e8b0b65325a Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Mon, 24 Nov 2025 17:34:25 +0100
Subject: [PATCH] printk/console: Do not rely on
 try_enable_preferred_console() for pre-enabled consoles

try_enable_preferred_console() has non-obvious side effects. It returns
success for pre-enabled consoles.

Move the check for pre-enabled consoles to register_console(). It makes
the handling of pre-enabled consoles more obvious.

Also it will allow call try_enable_preferred_console() only when there
is an entry in preferred_consoles[] array. But it would need some more
changes.

It is part of the code clean up. It should not change the existing
behavior.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index abf1b93de056..d6b1d0a26217 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3826,14 +3826,6 @@ static int try_enable_preferred_console(struct console *newcon,
 		return 0;
 	}
 
-	/*
-	 * Some consoles, such as pstore and netconsole, can be enabled even
-	 * without matching. Accept the pre-enabled consoles only when match()
-	 * and setup() had a chance to be called.
-	 */
-	if (newcon->flags & CON_ENABLED && pc->user_specified == user_specified)
-		return 0;
-
 	return -ENOENT;
 }
 
@@ -4022,6 +4014,14 @@ void register_console(struct console *newcon)
 	if (err == -ENOENT)
 		err = try_enable_preferred_console(newcon, false);
 
+	/*
+	 * Some consoles, such as pstore and netconsole, can be enabled even
+	 * without matching. Accept them at this stage when they had a chance
+	 * to match() and call setup().
+	 */
+	if (err == -ENOENT && (newcon->flags & CON_ENABLED))
+		err = 0;
+
 	/* printk() messages are not printed to the Braille console. */
 	if (err || newcon->flags & CON_BRL) {
 		if (newcon->flags & CON_NBCON)
-- 
2.52.0


It would be better to do the above change 1st. Then the @force
parameter might be checked in __register_console() directly, like:

	/*
	 * Some consoles, such as pstore and netconsole, can be enabled even
	 * without matching. Accept them at this stage when they had a chance
	 * to match() and call setup().
	 */
	if (err == -ENOENT && (force || newcon->flags & CON_ENABLED))
		err = 0;

You might just remove the check of CON_ENABLED in the last patch.
I think that this should actually fix the regression. It will
handle also the case when the console was enabled by
try_enable_default_console() and try_enable_preferred_console()
returned -ENOENT.

Note: I have some more patches which clean up this mess. But they are
      more complicated because of how the Braille console support
      is wired. They still need some love. Anyway, the above patch should
      be good enough for removing CON_ENABLED flag.

Best Regards,
Petr

