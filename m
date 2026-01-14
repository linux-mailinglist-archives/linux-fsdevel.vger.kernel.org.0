Return-Path: <linux-fsdevel+bounces-73705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 920BBD1F0FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBCF530221B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15B239B4BA;
	Wed, 14 Jan 2026 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GlebQonK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BED396D3E
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396821; cv=none; b=KsGkSUF2gMnY8XKMeIRliBDcbzKS24nZt7UYO8efg4BUuB7te3L7YejBHuNmplqqOMjOwPNr443A27ZgakRkwrlY6v87/fhDAiNiHLmQJtYnA2oljI8OtcSNnUXyrTl4zrd6gC6docSEOWwx91hgHAJyAghk0nl+QX5G+LENqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396821; c=relaxed/simple;
	bh=tXOp5Q+91Ev71kEJDwNUHqTl/QTwmM0CMtRXuMN58II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=es4PXDKi1uNty+1pc6M438JxMnvh1pWVZ1Ud4LvtJlEokgVqdapPrYaUcKtoa2NKZV2c1p7wV0RDqhbtd01ntIi2LxSOLfaaEualLIVgqoTNov+inUxSHkkAiuwFNV/SvTinfKiMk/B0U6JjweZdakLZNLZnWW8/gnB8Mp6gB2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GlebQonK; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43284ed32a0so4500618f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 05:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768396817; x=1769001617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWiGwjTB0ZEpbDkwRFO+MVJzM9uZpDrSFPQIlzRZfsU=;
        b=GlebQonK1BdB5DbGUyi9LiHoN8EziU92CFCkVI0QFOq3zEhwH6N5lbaRdR+rY/gCBJ
         Fg2NFXOcXLM1sjMYh2EL+pPASArlb7dn5JYQ7xAsAHxn9ooNPyk8HFEWSqJ0AKiLb8Jy
         OQSWVcr/+nNTLUeQmGlmWpTFmRkrVv42YP0mJNxo52tq3Z9CmAHgnisMw8pXZTj3j6iw
         W9dqlfWz3lgvzZ7jhta9fOBYyatVRtFEe5eB3muxZaEykIAOGsy8r+eNHdfFZhS6yWUF
         ROqkPhLwPP8lxjeZu4RqCxL6fdAD5MnzbZZlLD2XpYbBoT63LePeeYvof/5bXqQB6xDM
         DGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768396817; x=1769001617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWiGwjTB0ZEpbDkwRFO+MVJzM9uZpDrSFPQIlzRZfsU=;
        b=Fm+vg/I5NBftRqPTfCGVCyWuQKY9ey+ndh9k/1lRSnbl5+lRrJbZady9C63O3gQAOF
         DgKGscnPOpQ+qNUbimYPlzWZDmQHEqOwQ0FK4Qga02ZMxjs0yE58velHRwgi+bsz1HnY
         5FOHTl9spDZNspEFgI1lZhzn5krtn5nNVWqwnR7CZo1TlU49I01coIQ8gOjzXX/sA8y0
         36co5g7OiIcs0u88uZWTz6QOYsjLWtOconTzbHsY7wIuOT8H53cFEuPmwg+W5LS6gtiS
         UA7MbLMbmRpf/E5z6Odlst+UHxBfHl3pp9ZG94PR/osmre2z12fEgIGGJGoUmetZemds
         78+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+swDJ/GLCrmtxcU7+HRP9IcOsLRAm3u/9Lg5lok0ugIIeNfBwp+sEhEj0p0WkvsdYOYRrAfLm24JDq0X@vger.kernel.org
X-Gm-Message-State: AOJu0YzwArkBxWtS81zcuybLhY1Tgx/7NytBOr4yx9xon/pce0SL+zA7
	VHYGVa9ZQdyPJqVk0J8Ced1Ro7b1OxpZimYYmnMLfAyrBINH3bbm26Pba3+2F/gNBYE=
X-Gm-Gg: AY/fxX6r86W+3cNNpKHQeN/6P+eb4LBNoW/vNH9NMnVvoPTlsrzFMCZEJPXT47ve0Ic
	ACGaEItiqMhMQZOPXAENGxohwf5pKqqVCpACRPHGCv4RU5bO8eki2dEUqqGvXolMvlFE3piZxLc
	azwQkGsiXgkGrZoOdpZ0B0LaJ4PQeU/8UY/PzL2Oq0GADA7hjLQGj5fPZOwgJ5+9HL7flOp3Aon
	lwt8DKajJl+VFJHhJJhdcZQkaUlmLO/yj+whnJ5fZtt5vBtt29udOiK1UvTz2QaBDhfd2TE8/cT
	5i3vOAKWJHDNsr4r+gzncBbjGWQhO8y0GXOXggwaV1YKhTmCwn10+e5uHCKeNuB87YVRzmYyAdq
	A1D50+Fu6mjHCpGccw2N+cro2TTMh/gEsmn8jdAW9WkOJYfgecAUReYm//WSDfZnlGn/KB4CEhX
	gnY47NgDeCH52V2Q==
X-Received: by 2002:a05:6000:2511:b0:431:9b2:61c0 with SMTP id ffacd0b85a97d-4342d5b2ab9mr2581603f8f.24.1768396817421;
        Wed, 14 Jan 2026 05:20:17 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacd1sm49153435f8f.4.2026.01.14.05.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:20:16 -0800 (PST)
Date: Wed, 14 Jan 2026 14:20:14 +0100
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
Subject: Re: [PATCH 05/19] printk: Add more context to suspend/resume
 functions
Message-ID: <aWeYDoMsdBNkJEqO@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-5-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-5-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:12, Marcos Paulo de Souza wrote:
> The new comments clarifies from where the functions are supposed to be
> called.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

The improved comments would have helped to understand the previous patch.
I would either merge it into the previous patch or switch the
ordering.

If this stays as a separate patch, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

