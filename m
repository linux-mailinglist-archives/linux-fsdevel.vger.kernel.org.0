Return-Path: <linux-fsdevel+bounces-73907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3FDD23E8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 11:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 260B7309E46A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017EF361DD8;
	Thu, 15 Jan 2026 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="POOTpyf2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEE134D4C4
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472407; cv=none; b=sOkjTmyzmqyuynJABoCbCfjUsMtcTJsqUl5Wb+IistsjJ76l6rpOLyJAp5KiDuKK1ubMdALr3klWe4Q7LZIcbasdjhoXdiKMQLfgsnDpXYimVhP4j2I7cR7E+FkhObnskGZwjKJs5G4O3mjBt5wd2TTDjmqSoOhk+Xc74GAzx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472407; c=relaxed/simple;
	bh=mwoYamMX+C4LOG3qk2bHenfle0rpDp5AHcC+7a69BvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5gTMo30B/qOJ3mIcMH2RHYl/ymQh15wTwabFEPQkrni/vEe4hLamoB7qDVeUY4odCKlLdI3utnm5UR5dt8WCHCJP/m2IJocK+Jelcw7SEKXdXZMqQ+/+TbG8fVnqNzvH32VK+YBxpOXDlm8CnhvtHYVbMMzs9AKqxuslyhFOrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=POOTpyf2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso387784f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 02:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768472404; x=1769077204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Blw9ol92Adxv0ebGIyoRpKSiGhl8JOSAW1An3S4C+Hw=;
        b=POOTpyf2E8LQhfgcWoVnmGcwTv9cjx7t9nOoTBipWSoduSQDl2DtDEX5jXOGnGpHug
         /vEr3bRycNEF9KDphpixHf8pjEFI6ZYVF8QXfo2/p/K4igsaUNuTuTAXBRonG0hkEw3y
         zjPwl0nXJwH8C//iA7KkpuUuefoo6u/aeL1FN/9mZaiJHPN2asi8Bnj10GOb/8yZxglx
         Mo+8uDhw7wpooLcni7m/NfXXLd+GFxPn8auytjzx3hOMHRSxcVVJJnn1AEDU7nQEhSnb
         pM9pvUeivyUXXZdwnM+CoENtMt4wf2UWt/Iei7G0hU36UOd88kWLwxHkhYgi5FI9j7DC
         cpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472404; x=1769077204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Blw9ol92Adxv0ebGIyoRpKSiGhl8JOSAW1An3S4C+Hw=;
        b=v3oJGrvlusFFlw9RbQ7BmCCrO21/xmA89/nmdcB9ElONw06VjvWOBSFOG0dMggiowR
         CW2aShteLuXNLaee3wJnp+JmpQ6MhUvY5ywgF8Y64kGvKKzhHx7b12h488MyYLrZdUnh
         BL1vXmyr35EdBM6qcIZxCYb3Fkcw5HIwptgh1u478pj4JUezLC2ipbeNR3Yn7f23+j0k
         s1/8XISGaiCsqEgQCvsWQYbXBS28MaX0wDSeMS9udUrdJEwPgzdwESyH5IqHwoO4e/OU
         FG/hQrssyofW/VlmAhgoBwcKDbvdzGenuO4pi6UInZ5kIb9sm8sObmJbtI26talnsnfU
         a1Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWyAMdrZzbPc5DbwsQPh/BuE7B++kSK3S7DinTx7GVTooRAxP7HQbrNVcRexCCZSPd2nhFdjJO9ivP0fjWT@vger.kernel.org
X-Gm-Message-State: AOJu0YzrtkeLItUUaqrMlUiZBgyUHjmoQZwB9LfQaEBF/jpepDMOSqSc
	bqIBI3MrKq+NpCk/5OatNBLslk94aNIt8BBP1oqdA785YijdWN6RCSf0xLVsQI/K5VQ=
X-Gm-Gg: AY/fxX5f+2YCrkSU+DXWAhu4k874e31lk7BZ2MlBAT4AgwILLRwxa15qPZSFGH3bERe
	QHtZUt5GDReHgPlMcw109e9aP78y+cY2NRsQVAZK/pB3H1i+4MuL8N+aIRZQ91dcmip5kv3ASKa
	dkBi+TNLsWfFFzoaYqf+eB5gNnHJm7+dy6EyqJ0UtfEmytISP4ym2FuMbIfcrbaWmSCLXvc7fys
	Eajf3AANzpSYQBZGofsjsmEhq23rjDi/B/tPRkVAO/amphqbC2VU8ij6hYvGmUbru6EKOVQQRvn
	O74qJLOQm9rwofPM+4Pcyv3C3r1Nnzmzc+PHRKo0NR9va8tF4PEaHk3XaM+mDNqt+qSJC3bEL30
	iDhllrflMhmCs4p6B2TmQcIXWdsER8C0TL40JjQqE/W/+A9NVlr/1J5aeV4haBJw2mlt9KjMMdy
	W4+Jbna3dWhJl/4A==
X-Received: by 2002:a5d:6b41:0:b0:432:a9db:f99d with SMTP id ffacd0b85a97d-4342c535db3mr5505744f8f.36.1768472403629;
        Thu, 15 Jan 2026 02:20:03 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af653632sm5139931f8f.11.2026.01.15.02.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:20:02 -0800 (PST)
Date: Thu, 15 Jan 2026 11:20:00 +0100
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
Subject: Re: [PATCH 08/19] debug: debug_core: Migrate to
 register_console_force helper
Message-ID: <aWi_UJcrphO9Esxw@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-8-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-8-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:15, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

LGTM, nice cleanup!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

