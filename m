Return-Path: <linux-fsdevel+bounces-73430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B93AD18F2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 13:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1635730714C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 12:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B813138FEFA;
	Tue, 13 Jan 2026 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fRVKHqti"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C1838E5FB
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308116; cv=none; b=PZtmPSUjkWAKic6cLNMiqay5uA4iVg+rO+DEwp+ml7F1b1WXr1IPh8sBO6tjD4ClMmx+LJGmj3TpR1fRKkxPcy/Y3xqdbbbh2rVdTlXJpBX8NI8cPrkfr48zC5tipVkD9rpCJoDysbcQYTIpuIMI3tQUKfgj6A/9EvYPEWNDHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308116; c=relaxed/simple;
	bh=4O/QKnJy0mgeinip5BHk/HuNTgwgeS2i878VGcuximU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R4tZJ9gQ1eLDZhpcnLkpRJzWU/1K62Vd0MyJhEtmFC+LEyZWQq1IXxDefMxZn1n5kDIMM6SBe7z+pSt79isPVMDtELKKZSfqLjY/tC2bymAZm8NY0CZA0XME33KSZKVMLJnBkfWgqVj72vdePyYvhYi25e6i1jNsT20xehh3sL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fRVKHqti; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so60297945e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 04:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768308113; x=1768912913; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2dC4SplNK0CZduFW6/ZkQ29d/9pNlTULD+NHFTfquXY=;
        b=fRVKHqtitRt7aDAXPRYu506G5Ytwzf8hcFy27vH8i+FlRo+tkbAGjcjtXvKoMHUPci
         RHxMzomlVLe76t9tcFgiVsqr2QxQqxck+pSkDKfh9VNKxojK/Smo2Z5AmrptYdJI59M3
         A6y+LbDMWuXyXpbzNdgaPeAgxmE+RJuxtW+xoegjeajNbe1ANij7BBQPRW61gwEXxV4o
         A+t4h7l4xZoC3ymVTqnksmU0IvSChVgNeDGoL0j/XFaShdI6SUjv3CyUiA5rwq7FAJQ0
         L92eXpwJU2MbdacV3ijX3WwllU7V1dRBFwbPgHQJbmPP8Lfa6zjxFsRTB0kQn2Qr8oqF
         O/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768308113; x=1768912913;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dC4SplNK0CZduFW6/ZkQ29d/9pNlTULD+NHFTfquXY=;
        b=CBTuPVTFTs3ow/Ebsxr1lI2ksniGgZgfqP7aHoZk4sFO2lobRj654BbLcp1YnsAVA3
         aXmLzAPYJuPz7jw8Yuq4RWmysX5X8/QUKzdcQkrt4igxcx5eQCL2bYbLHBPc7bsNd3HX
         /urGr/5oJc2YHpkGRZtRsk3JDykLT7Tr6Dh3BF/QD7bwrryDyNkXuBQmuPk1NfsAcR1A
         CVgaapFVicOL969OP9sD0Eee6fhRgbY01YU1wYiK5UhxW1pZn6eN3mWzI9CVc5YaxI7A
         0G9GQGbqqcVoLZsk0hk98i+oW2Z1KLNTWWBHqWatZKzlVxxDIvtuoDF0hlRaVwD3cdD3
         bbew==
X-Forwarded-Encrypted: i=1; AJvYcCUVt6AjTS6OCdhHsQ5MkV0IWFDJcM0Coq41IMARnrlrQZ+UmE0E6qGeMFLFEdyy0fXZgorELPR+TMXdnqrn@vger.kernel.org
X-Gm-Message-State: AOJu0Yym6e5zU++yNuaGnPnqMXTGdITijd98hgLG1pYStcRI/vUe7kM/
	dWYYn6CzRqvxKnWOt3EMNEK+RbfFHVBqdxuocElJJfAADtfwwMlBnIh5ZuoZMi83WTU=
X-Gm-Gg: AY/fxX7DiPH5xWWAKmcTQmdEls87Tf97kgUv/c7RN82QjQQPhY7Gqtaxihnw88zYNaL
	DwBs7tzN7/eDJUQz7es//GnfMmDHn6wdSl3t5lo7WWfLZkgEgR4liH1IHytIUsR+6hFc/7Chihf
	pUSaR9LoAeruCitDYeclGGxbJG9PjSzh2NFE7CPpnN1c5iRvNE7n5aIgmFbZc4BjCIjM/m86lgI
	+BPvhaCuA3AXpC1nXisaeyVGguvw7yO9db86IshjL14dYScH/Ywwnvc7YO0ZGLQQmbDT9+TsdkO
	mEB6goMq5wwLqsnK36c+BuONnvgjH9AsXiLTBCfdLZzsnwbOTljl9WBSDeTktXM52Vnu/PhLzNu
	+ZuulaKwW0ZwzkNcCd2Pe0C43taDiX1+oltwVd0aRb+kF7qmG+4DGYJM7yR38LyCjQxB3Onk2b1
	wRJQj+XvytYLKmHKcCUdyAzxIeJnpSFFS3PihlA+FBXA==
X-Google-Smtp-Source: AGHT+IFNQeuw9WMG2h1Davmi36cm1P3WLycSIMCVChnxdfpM9EbZrc4Y9nv7bv2r6hTzREDcGxTpbg==
X-Received: by 2002:a05:600c:a08:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-47d84b4900bmr279773315e9.30.1768308112530;
        Tue, 13 Jan 2026 04:41:52 -0800 (PST)
Received: from [192.168.3.33] (218.37.160.45.gramnet.com.br. [45.160.37.218])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5013bd680a1sm10831771cf.16.2026.01.13.04.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:41:51 -0800 (PST)
Message-ID: <a5d83903fe2d2c2eb21de1527007913ff00847c5.camel@suse.com>
Subject: Re: [PATCH 00/19] printk cleanup - part 3
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov	
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson	 <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, Petr Mladek	 <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, John Ogness	 <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>,  Jiri Slaby <jirislaby@kernel.org>,
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook	
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"	
 <gpiccoli@igalia.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy	 <christophe.leroy@csgroup.eu>, Andreas Larsson
 <andreas@gaisler.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue	
 <alexandre.torgue@foss.st.com>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
	linux-serial@vger.kernel.org, netdev@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, 	linux-fsdevel@vger.kernel.org
Date: Tue, 13 Jan 2026 09:41:34 -0300
In-Reply-To: <aVvF2hivCm0vIlfE@aspen.lan>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
	 <aVuz_hpbrk8oSCVC@aspen.lan> <aVvF2hivCm0vIlfE@aspen.lan>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-05 at 14:08 +0000, Daniel Thompson wrote:
> On Mon, Jan 05, 2026 at 12:52:14PM +0000, Daniel Thompson wrote:
> > Hi Marcos
> >=20
> > On Sat, Dec 27, 2025 at 09:16:07AM -0300, Marcos Paulo de Souza
> > wrote:
> > > The parts 1 and 2 can be found here [1] and here[2].
> > >=20
> > > The changes proposed in this part 3 are mostly to clarify the
> > > usage of
> > > the interfaces for NBCON, and use the printk helpers more
> > > broadly.
> > > Besides it, it also introduces a new way to register consoles
> > > and drop thes the CON_ENABLED flag. It seems too much, but in
> > > reality
> > > the changes are not complex, and as the title says, it's
> > > basically a
> > > cleanup without changing the functional changes.
> >=20
> > I ran this patchset through the kgdb test suite and I'm afraid it
> > is
> > reporting functional changes.
> >=20
> > Specifically the earlycon support for kdb has regressed (FWIW the
> > problem bisects down to the final patch in the series where
> > CON_ENABLED
> > is removed).
> >=20
> > Reproduction on x86-64 KVM outside of the test suite should be
> > easy:
> >=20
> > =C2=A0=C2=A0=C2=A0 make defconfig
> > =C2=A0=C2=A0=C2=A0 scripts/config \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --enable DEBUG_INFO \
> > 	--enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> > 	--enable DEBUG_FS \
> > 	--enable KALLSYMS_ALL \
> > 	--enable MAGIC_SYSRQ \
> > 	--enable KGDB \
> > 	--enable KGDB_TESTS \
> > 	--enable KGDB_KDB \
> > 	--enable KDB_KEYBOARD \
> > 	--enable LKDTM \
> > 	--enable SECURITY_LOCKDOWN_LSM
> > =C2=A0=C2=A0=C2=A0 make olddefconfig
> > =C2=A0=C2=A0=C2=A0 make -j$(nproc)
> > =C2=A0=C2=A0=C2=A0 qemu-system-x86_64 \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -m 1G -smp 2 -nographic \
> > 	-kernel arch/x86/boot/bzImage \
> > 	-append "console=3DttyS0,115200 kgdboc=3DttyS0
> > earlycon=3Duart8250,io,0x3f8 kgdboc_earlycon kgdbwait"
>=20
> Actually I realized there was a simpler reproduction (hinted at by
> the
> missing "printk: legacy bootconsole [uart8250] enabled" in the
> regressed
> case). It looks like the earlycon simply doesn't work and that means
> the
> reproduction doesn't require anything related to kgdb at all. Simply:
>=20
> =C2=A0=C2=A0=C2=A0 make defconfig
> =C2=A0=C2=A0=C2=A0 make -j$(nproc)
> =C2=A0=C2=A0=C2=A0 qemu-system-x86_64 -m 1G -smp 2 -nographic -kernel
> arch/x86/boot/bzImage \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -append "earlycon=3Duart8250,i=
o,0x3f8"
>=20
> With the part 3 patchset applied I get no output from the earlycon
> (without the patch set I get the early boot messages which, as
> expected,
> stop when tty0 comes up).

Hi Daniel, sorry for the late reply! Lots of things to check lately :)

Ok, I reproduced here, thanks a lot for testing kgdboc, it's a quick
way to check that the new register_console_force is not working. Let me
take a look to find what's wrong. Thanks a lot for finding this issue!

>=20
>=20
> Daniel.

