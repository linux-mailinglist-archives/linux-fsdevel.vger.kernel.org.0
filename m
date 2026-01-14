Return-Path: <linux-fsdevel+bounces-73518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC91D1BD3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 01:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D635B3069D6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 00:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0BD225403;
	Wed, 14 Jan 2026 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WdCE0cSe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A97820299B
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768350771; cv=none; b=B8ZvsMNKcxyYZC1FIT33ebSssFDrRFzhBwFuebXKBmxzqClIOg6L+Sr7dF967fZJgBeVIP56TjQk+XONyGryaTVErx+c8c20uEM9XkCA1jtL0zZ+snreLVQkLn+919s+Z/Fli5m+TS7GZYwWqDu2glQqkgotYHnbOXaoa38DVDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768350771; c=relaxed/simple;
	bh=nGJ2jPxKcBzN+czMyCvoFnCk3OT6uIqZnT2Tcb9ddPo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b9oVGiBw5utf/nxg7eJjDXHErBHfWWQRGGh0dfvbvmNhDEvKebgM965NcZMyDmMR478JBN4lIq5lEKI5nP7zvAZEfk1x5nKz6HJiP0lT50LGGt8TsjZKQEthtl/4QR8dHyVhbeCaNc3QpDrJqJ3N7Iv82J/CRv4eCsvvYdtDot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WdCE0cSe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso2930675e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 16:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768350768; x=1768955568; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gaWdSFFdOKkEXTHGFmdiT7EpMTfrWly43NlKkw7Tnic=;
        b=WdCE0cSequz4kIsG0Bvq20O469ENKrlgcuLe6iZhfbc48iN5hskoBU+uCQld9TT/LJ
         RijnSGKQJYxvX+j0y3/1ojflKfiS/a77faj1fUfor2Ta7sEhipGVYlqDZjVlfccuCvrr
         Xkq8WgV7Nrb8vAuVAMHqsGmXZ/F/7H2/9pWP6Kx0QXTOeLxpROE9bKCTptHgARxEJWPu
         7z7w07hyrzIe/L5B6npYw4SXT99LEqKPQ/c+FwQ1pvr+fQbwl0MEOk3XUBotQb6b+oaC
         kVqxF0TecSwhJPrrbHM1G42WU7rsjgfKnn4r007pP0WoVwM2kfqA4Lbj8OYs5ef9pNAV
         sGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768350768; x=1768955568;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gaWdSFFdOKkEXTHGFmdiT7EpMTfrWly43NlKkw7Tnic=;
        b=sLGaGfpWHc1P4mRNqPOVTANVocwnIqNqry5ryJtrz9ctcOU1e1CiOTwthUABF4Y+vJ
         qivVTeemcRzTCY3JXsMVRj+r+8DNrn9Q4kPc/MBhrB9J/tH9GmW5ozKcOsCWP5VKQphP
         DumGewxbMXqxAd0PMK3p6Oxje0CiPBZW7ygCRCd9alwdonxNVo/Bs70z4Eq7Pex40N0l
         BW3UiM+pSfZBS0JesuAS8CmdH4CY7Nk3RH3D7+V9AzSry1Vy9QsCuoro9uTWwpbUWSMX
         ph3J31rRyxW7BTR26mcXEUhDxA8S0aiVDvNwFCwNtm6wBrsAOG6eA9aR+TLhnOt16y1o
         BowA==
X-Forwarded-Encrypted: i=1; AJvYcCVbPACynYgop33T4SiUI8ax6uRIDvn2eImZOH008bWh0WZyiFnriJLpHOkwHMLoUassMQ93aQ0Bs+9EmypK@vger.kernel.org
X-Gm-Message-State: AOJu0YxM91PWHPXbepR3iakNk2oD4GpHIlOoR+IM+k4INGyH0GqI43CX
	BkV/N5Xmfw3JCNGmJqY9I9+8z75DH88aBza82hUhQjpAxhplKOAq2fR3Agb9tvPhDQ0=
X-Gm-Gg: AY/fxX7hxYFQFmEmiMcRmTIbK0T8ombs7xM3o44IkBlYowEqYBCJQnf2F+vaYYSaFgO
	7V2NAPlv4lWARoqpUyEokXWqvGHTdg9ZSjJ5nMy1ebaZG13Lu38k7ldq+NzahfqORBbQojmHbht
	6J0srwkOBkep+2qOjK6NSPCSjPazEWrL8DE4lO1hKG9hsGi9asAFpVGsPfTA0DWvsck9BM+VJA1
	Z5V0XbG1JVYp5MFV9f41igrReMUdSCAKPXQBgVoyJQBdWKiyckKgjjE9bjvoVZno5gxxAPRvN21
	rE/U504RQiA6kpfqjYnzlbuK1iMz7bYr/6sGSMrK/GqzLzkqIyUP2ffUG+Qc9UJPw+APZCch+yI
	sLjrzodKJ4yz3J7ciHTKOZRfCuS5Oz0MIh/bBlrq1GpP4o9USwb+RgHEDsDSpJriBjL9VrH323M
	SMm9ecHSWM3CbRowK88acGT/37//YPA8kkyILYFXNBCg==
X-Received: by 2002:a05:600c:a101:b0:47e:e48b:506d with SMTP id 5b1f17b1804b1-47ee48b510fmr2972975e9.16.1768350767989;
        Tue, 13 Jan 2026 16:32:47 -0800 (PST)
Received: from [192.168.3.33] (218.37.160.45.gramnet.com.br. [45.160.37.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df9c5sm48257391f8f.22.2026.01.13.16.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 16:32:47 -0800 (PST)
Message-ID: <89409a0f48e6998ff6dd2245691b9954f0e1e435.camel@suse.com>
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
Date: Tue, 13 Jan 2026 21:32:33 -0300
In-Reply-To: <a5d83903fe2d2c2eb21de1527007913ff00847c5.camel@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
		 <aVuz_hpbrk8oSCVC@aspen.lan> <aVvF2hivCm0vIlfE@aspen.lan>
	 <a5d83903fe2d2c2eb21de1527007913ff00847c5.camel@suse.com>
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

On Tue, 2026-01-13 at 09:41 -0300, Marcos Paulo de Souza wrote:
> On Mon, 2026-01-05 at 14:08 +0000, Daniel Thompson wrote:
> > On Mon, Jan 05, 2026 at 12:52:14PM +0000, Daniel Thompson wrote:
> > > Hi Marcos
> > >=20
> > > On Sat, Dec 27, 2025 at 09:16:07AM -0300, Marcos Paulo de Souza
> > > wrote:
> > > > The parts 1 and 2 can be found here [1] and here[2].
> > > >=20
> > > > The changes proposed in this part 3 are mostly to clarify the
> > > > usage of
> > > > the interfaces for NBCON, and use the printk helpers more
> > > > broadly.
> > > > Besides it, it also introduces a new way to register consoles
> > > > and drop thes the CON_ENABLED flag. It seems too much, but in
> > > > reality
> > > > the changes are not complex, and as the title says, it's
> > > > basically a
> > > > cleanup without changing the functional changes.
> > >=20
> > > I ran this patchset through the kgdb test suite and I'm afraid it
> > > is
> > > reporting functional changes.
> > >=20
> > > Specifically the earlycon support for kdb has regressed (FWIW the
> > > problem bisects down to the final patch in the series where
> > > CON_ENABLED
> > > is removed).
> > >=20
> > > Reproduction on x86-64 KVM outside of the test suite should be
> > > easy:
> > >=20
> > > =C2=A0=C2=A0=C2=A0 make defconfig
> > > =C2=A0=C2=A0=C2=A0 scripts/config \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --enable DEBUG_INFO \
> > > 	--enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> > > 	--enable DEBUG_FS \
> > > 	--enable KALLSYMS_ALL \
> > > 	--enable MAGIC_SYSRQ \
> > > 	--enable KGDB \
> > > 	--enable KGDB_TESTS \
> > > 	--enable KGDB_KDB \
> > > 	--enable KDB_KEYBOARD \
> > > 	--enable LKDTM \
> > > 	--enable SECURITY_LOCKDOWN_LSM
> > > =C2=A0=C2=A0=C2=A0 make olddefconfig
> > > =C2=A0=C2=A0=C2=A0 make -j$(nproc)
> > > =C2=A0=C2=A0=C2=A0 qemu-system-x86_64 \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -m 1G -smp 2 -nographic \
> > > 	-kernel arch/x86/boot/bzImage \
> > > 	-append "console=3DttyS0,115200 kgdboc=3DttyS0
> > > earlycon=3Duart8250,io,0x3f8 kgdboc_earlycon kgdbwait"
> >=20
> > Actually I realized there was a simpler reproduction (hinted at by
> > the
> > missing "printk: legacy bootconsole [uart8250] enabled" in the
> > regressed
> > case). It looks like the earlycon simply doesn't work and that
> > means
> > the
> > reproduction doesn't require anything related to kgdb at all.
> > Simply:
> >=20
> > =C2=A0=C2=A0=C2=A0 make defconfig
> > =C2=A0=C2=A0=C2=A0 make -j$(nproc)
> > =C2=A0=C2=A0=C2=A0 qemu-system-x86_64 -m 1G -smp 2 -nographic -kernel
> > arch/x86/boot/bzImage \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -append "earlycon=3Duart8250=
,io,0x3f8"
> >=20
> > With the part 3 patchset applied I get no output from the earlycon
> > (without the patch set I get the early boot messages which, as
> > expected,
> > stop when tty0 comes up).
>=20
> Hi Daniel, sorry for the late reply! Lots of things to check lately
> :)
>=20
> Ok, I reproduced here, thanks a lot for testing kgdboc, it's a quick
> way to check that the new register_console_force is not working. Let
> me
> take a look to find what's wrong. Thanks a lot for finding this
> issue!

Ok, I did a bisect and found out that the issue lies in the last
commit, where CON_ENABLED was removed. After it, I then checked what
was wrong, since everything was being plumbed correctly (tm), and then
I found that it was not:

On _register_console, the function try_enable_default_console is called
when there are not registered consoles, and then it sets CON_ENABLED
for the console. Later on, try_enable_preferred_console it checks if
the console was specified by the user, and at the same time it had
CON_ENABLED set.

It worked by chance, but now, we don't have this flag anymore, and then
we are not _marking_ the console on try_enable_default_console so
try_enable_preferred_console returns ENOENT.

I have added logs for both cases first the case with the patchset
applied but the last one patch, and it works:

$ vng --append "console=3DttyS0,115200 earlyprintk=3DttyS0,115200
kgdboc=3DttyS0 earlycon=3Duart8250,io,0x3f8 kgdboc_earlycon kgdbwait" --
verbose

Decompressing Linux... Parsing ELF... Performing relocations... done.
Booting the kernel (entry_offset: 0x000000000450d530).
XXX register_console earlyser
XXX try_enable_default_console earlyser enabled
XXX try_enable_preferred_console earlyser user_specified 1 returned -
ENOENT
XXX try_enable_preferred_console earlyser user_specified 0 returned 0
because flags was ENABLED

^^ here, returning 0 means that the console was accepted and will be
registered

XXX __register_console earlyser registered
XXX register_console uart
XXX try_enable_default_console uart enabled
XXX try_enable_preferred_console uart user_specified 1 returned -ENOENT
XXX try_enable_preferred_console uart user_specified 0 returned 0
because flags was ENABLED
XXX __register_console uart registered

^^^^ same here

Going to register kgdb with earlycon 'uart'
Entering kdb (current=3D0x0000000000000000, pid 0)=20


Now, the logs of the patchset with the last patch also applied:


Decompressing Linux... Parsing ELF... Performing relocations... done.
Booting the kernel (entry_offset: 0x000000000450d530).
XXX register_console earlyser
XXX try_enable_default_console earlyser enabled
XXX try_enable_preferred_console earlyser user_specified 1 returned -
ENOENT
XXX try_enable_preferred_console earlyser user_specified 0 returned -
ENOENT
XXX register_console uart
XXX try_enable_default_console uart enabled
XXX try_enable_preferred_console uart user_specified 1 returned -ENOENT
XXX try_enable_preferred_console uart user_specified 0 returned -ENOENT

^^^^ here, it should have registered the console

XXX console_setup hvc0
XXX __add_preferred_console hvc added, idx 0 i 0
XXX console_setup ttyS0,115200
XXX __add_preferred_console ttyS added, idx 0 i 1
Poking KASLR using RDRAND RDTSC...
XXX register_console tty
XXX try_enable_preferred_console tty user_specified 1 returned -ENOENT
XXX try_enable_preferred_console tty user_specified 0 returned -ENOENT


^^^ again, it fails because we don't flag the console with CON_ENABLED
as before.

XXX register_console hvc
XXX register_console ttyS
XXX try_enable_preferred_console ttyS user_specified 1 returned 0 with
user specified
XXX __register_console ttyS registered
[    0.000000] Linux version 6.18.0+ (mpdesouza@daedalus) (clang
version 21.1.7, LLD 21.1.7) #374 SMP PREEMPT_RT Tue J
an 13 21:08:34 -03 2026 reserved
[    0.000000] earlycon: uart8250 at I/O port 0x3f8 (options '')     =20
[    0.000000] kgdboc: No suitable earlycon yet, will try later       =20


So, without any console kgdb is activated much later in the boot
process, as you found it.

I talked with Petr Mladek and it would need to rework the way that we
register a console, and he's already working on it. For now I believe
that we could take a look in all the patches besides the last one that
currently breaks the earlycon with kgdb and maybe other usecases.

Sorry for not catching this issue before. I'll use kgdb next time to
make sure that it keeps working :)

