Return-Path: <linux-fsdevel+bounces-72393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C88FCF426F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 15:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82EBF3036C51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 14:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61D333BBB9;
	Mon,  5 Jan 2026 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="H9+hkPjh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8585533A9EB
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jan 2026 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767622117; cv=none; b=KETDCzznssFsGAjtpa/N7LWb73h/+c33dAum31ZAWitDN1k2tyGg48pBUQ0UOTou8m+ba0Ng8IZxLZmQ2n3LCBQTYtpUGo8OEGb1uE8hk7sawO7T30sxDRAFi/brJTgXwECFwz2AC3a/kecY7QfFaStQ26f72XCCgCatDv70Z9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767622117; c=relaxed/simple;
	bh=r3I6M7kWHIbwx8pg9jWTMfz8fscetYU9L971EGe7OZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fICKfKh11Fyxv49orhoW3QpFJoHundR1qD0kTWVBh60A0PjDFb/eEz8yS9mxpT/GPTX1J2qbsPcbwvs1gdC76zbeS3ti7PRGRC8pCP6tHVUImSb5Zz3feZgpfRYLm9pA2aglQTexu0DLZsROmj6KqB6/X/6QHeLpJ8QX4VeO9hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=H9+hkPjh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fed090e5fso6465348f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jan 2026 06:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767622109; x=1768226909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq3TtsxUy/q4IZcqauYlg+KhZOOjIgyB7YRbMBjceZQ=;
        b=H9+hkPjhAyTEos4JbC3SAHaK4U1jFi/jCKRwkG3H3+42Ugy69WLCmKacOeNmxPOKw0
         Ix+pwpDSjEpf1yAwNXdsT20c7NqUd5oHunNPqzsePlSzps5WYOiSx5uiCtjGUY1TIUPv
         t3T9IoS8ShGcJgfzjL2u6Q1kdVMwGv1f8pIgH0DMcox24h5IEYh+Atzg4WxOTvniWzK+
         G51sNEh08yMuuRlk8CmnRljUjsg5kNffJGszJhny8HWJRogQSvnCbU6DTnjhLeuxTHmy
         I4XskcK1GoHISE8qrTfNJmMx/D+rH0FMktQJVeTsE0D2xA7ox80+XRiyZ3oSBGef62e1
         HWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767622109; x=1768226909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kq3TtsxUy/q4IZcqauYlg+KhZOOjIgyB7YRbMBjceZQ=;
        b=u3s45Ijtk6L6bWOLOooIUTZMMtpWrW9DTv4MAVttITfwX4PIUhuAf2kg5a27n77Yvc
         PwgmW1FjAUB5LTlbLJXBpBik7nKQjYSXTyjCLw0q5d8HwahZuwcKaTaDaQVD89Ko3/Us
         8Zj/NSTHl1GgzSxTXJSuw3rE30YKxv0094/5IuBLFLXlyLXr7GcoVfs+TKpIxTbN9G2k
         yhvEfelYQfk+jOa9Eida4ziYA8euD1NLNklsCyrgr7uqGoNaE6VbpCCDtTaJxCSEBEO2
         MP3nxwDf0+ahfqsZk33F/I0nto63pAtksUnb5iy34z0Vlo+tQbxcMDPQn5vfAgX0jPe7
         oW7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUx0a6UeqOs3I0aPDG/ANMzQZYrhEC31ApyDRsveHnQ1xvl2unu4M4EpEHQIMoxscja5Gjl8T7vNnlKxque@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0stY9A2+lRhpdxd0lsCvJnpjPDUYHPFq8wZQqhcGcDevl0yq+
	x/FECjNLifISlSn5zbQnWdWTB9rSekBw1M0qv3etA1pOKrty7KX9kKjMvNYZ6n68W98=
X-Gm-Gg: AY/fxX5ETvTBoAaVZfrwSf99bj+XeNbUrdD0oRphDB8dxPq/mJK6LKTQEb1spfpacSR
	gwoERKnfxIh8dMDbkANymifA4NouTOsiAYq7RNuJY0dGJGTJoNmeyMoPuVu4kuNGFE0OzGTNP8m
	fyneH/GeYXTQ3r/gmXWgBQKnA83chsnY3g3P6tpuP2P3CFiqa/eboKeLrYejvbWgVTQQ8euQ/rs
	zObl7OWCab2VYO7Vik6NG0MIsmmknO3BCnf0pRlbMaAQ91+7IiI4Py5+ZxK5F3LOmpy8QXO/sn0
	70MCkwG8ZxQueuxxjTI3iNZTUhe4UFGeMqFBdf3SiyaENVb4l5/Tj+yl1tZtqhuV8ArifamhRvK
	+kabwjTi/kHsk9misvdzdIj3Q7Sk1TX85+z6v14TJKEQkKrUDOYY4DibB1h3YCLQ7P1epx1lBjs
	gkOEMemw1yonzHBxG95Ca4B0hn5HIi8tKqWoCND9w1kCE1TAME2Pshqrd2mmaM9MfMjCwonfDwE
	PTAiS7PyEth2Y0yDfgP7op8OCzPlN5smMJeub6XelJTZ3fV73br2kQs7CowNFZtejjZTi6c
X-Google-Smtp-Source: AGHT+IFtm/KgnS/DHXZ241C9Tii09D9IuHplpok3aN88rFmOsLWOymloQBuensoLNVO5jV8TaARwoQ==
X-Received: by 2002:a5d:4842:0:b0:432:84ee:186d with SMTP id ffacd0b85a97d-43284ee2de1mr31846134f8f.62.1767622109438;
        Mon, 05 Jan 2026 06:08:29 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1b1sm100250524f8f.3.2026.01.05.06.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:08:29 -0800 (PST)
Date: Mon, 5 Jan 2026 14:08:26 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
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
Subject: Re: [PATCH 00/19] printk cleanup - part 3
Message-ID: <aVvF2hivCm0vIlfE@aspen.lan>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <aVuz_hpbrk8oSCVC@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVuz_hpbrk8oSCVC@aspen.lan>

On Mon, Jan 05, 2026 at 12:52:14PM +0000, Daniel Thompson wrote:
> Hi Marcos
>
> On Sat, Dec 27, 2025 at 09:16:07AM -0300, Marcos Paulo de Souza wrote:
> > The parts 1 and 2 can be found here [1] and here[2].
> >
> > The changes proposed in this part 3 are mostly to clarify the usage of
> > the interfaces for NBCON, and use the printk helpers more broadly.
> > Besides it, it also introduces a new way to register consoles
> > and drop thes the CON_ENABLED flag. It seems too much, but in reality
> > the changes are not complex, and as the title says, it's basically a
> > cleanup without changing the functional changes.
>
> I ran this patchset through the kgdb test suite and I'm afraid it is
> reporting functional changes.
>
> Specifically the earlycon support for kdb has regressed (FWIW the
> problem bisects down to the final patch in the series where CON_ENABLED
> is removed).
>
> Reproduction on x86-64 KVM outside of the test suite should be easy:
>
>     make defconfig
>     scripts/config \
>         --enable DEBUG_INFO \
> 	--enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> 	--enable DEBUG_FS \
> 	--enable KALLSYMS_ALL \
> 	--enable MAGIC_SYSRQ \
> 	--enable KGDB \
> 	--enable KGDB_TESTS \
> 	--enable KGDB_KDB \
> 	--enable KDB_KEYBOARD \
> 	--enable LKDTM \
> 	--enable SECURITY_LOCKDOWN_LSM
>     make olddefconfig
>     make -j$(nproc)
>     qemu-system-x86_64 \
>         -m 1G -smp 2 -nographic \
> 	-kernel arch/x86/boot/bzImage \
> 	-append "console=ttyS0,115200 kgdboc=ttyS0 earlycon=uart8250,io,0x3f8 kgdboc_earlycon kgdbwait"

Actually I realized there was a simpler reproduction (hinted at by the
missing "printk: legacy bootconsole [uart8250] enabled" in the regressed
case). It looks like the earlycon simply doesn't work and that means the
reproduction doesn't require anything related to kgdb at all. Simply:

    make defconfig
    make -j$(nproc)
    qemu-system-x86_64 -m 1G -smp 2 -nographic -kernel arch/x86/boot/bzImage \
        -append "earlycon=uart8250,io,0x3f8"

With the part 3 patchset applied I get no output from the earlycon
(without the patch set I get the early boot messages which, as expected,
stop when tty0 comes up).


Daniel.

