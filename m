Return-Path: <linux-fsdevel+bounces-41057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D622FA2A659
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 11:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2726F7A1B7D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 10:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A6422758B;
	Thu,  6 Feb 2025 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="DvHlPtWx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1476227580;
	Thu,  6 Feb 2025 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839264; cv=none; b=afKUx7GAH2/qPQ3xkyu14Bu9w0vS/Nqw6OrPm3R44kPZ1RAvCleu7V02KTC18YuV4vhbZbxWIihno6dbcD6U57NAcpVuTxA7F3prGoh0+oa3pP4Ob23pFJlT8aw/DXZkpumIXJFSNNZOd4nMyOXzfcWUqXOQSowQYXGcMGobuac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839264; c=relaxed/simple;
	bh=ecBLWbFlGgTe7jkhUolhscOAYW7hHiUSCSYGL/lgH6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H5sUE4ZY7IB59Gvo0S+q+ZZ1wPgD4PWtrW8QIn9M3S+dvsRoD6jNembLDAkmnfIBIzl5VdIkO+qUxwcKUFFF1Tf3V6Nxr7kspOznxx2CYzHDfUxDcMeRxVojg6dQJ20bp4r2dRMjtySn2kCgeQdwSe6TlL5o8P5eUziSP1bA2Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=DvHlPtWx; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1738839235; x=1739444035; i=christian@heusel.eu;
	bh=PaDCg/42ZOzIs+EkyKGX5gcoxqb7gauMs9lZCRAKsJg=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DvHlPtWx3DZtPAnaiQPNnWoSMlz0W0oGaQzYJSwKJ009/Lv3caO+ul0PPBnx80rb
	 8ZsyXkgaaVkgRWLIN570CkAI6hW0fZnY5Ng8Ra8MEV3aCp1wlF3Srv3PLPDX0aPgB
	 nKWhseyhWv21WHt14OukXf+ghxJDPsjcoZXYYJVXHuxCwt6/uZNU1gtMw3UEz/Ksl
	 xBG14KpHqUF3mQk9yYownw+WeJUFa3vA/c76opVlngtLnu8lyerjTLnmxxTO4JWHn
	 JqL9oMoh7l9jyBatBHjwzLWzwxhG0u4tQN0P8gd6lzZ5nYbb8SAPVIwt3tghwq6mP
	 +y8X2D3HEr8EkLYgWw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mo77T-1t5JGb2dD9-00eLCD; Thu, 06
 Feb 2025 11:53:54 +0100
Date: Thu, 6 Feb 2025 11:53:53 +0100
From: Christian Heusel <christian@heusel.eu>
To: Josef Bacik <josef@toxicpanda.com>, 
	Miklos Szeredi <mszeredi@redhat.com>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
Message-ID: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xqg47v3xy6vv4paz"
Content-Disposition: inline
X-Provags-ID: V03:K1:LtgCkhmKg5RJMyAidJ3BBRfDxS/3N4sQIAun4skTAWEFyxFJtZg
 DE1/DpssXR2HA6STRGBfNdN0v+Hf1MYPloE5mgSij3MktmKfKV0WF0ZJ7N8zBHvwlvMToaJ
 /DZUaz3oYbvZ7dmAJ/KiH0IOt75NzGHpAh8sgNbY0VK45eb5DlfwLM+NHH3uqFNsrvXrsXU
 9PahOIHZ6O2IoBAQ+Upwg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9lP82Ua1OBI=;EdF5+nJHfxyCescVlwMkulKrQvC
 u8D1E7oxyWZ1TwrEzcwZRw0e9d4IXaNkkzhe+tGOQPk94/K6N3Hc8kGPibMEuZPUVhOCg+pMi
 n6Vd03oqIYlLaUDX0jSG1EtU22jCNqHwmeBfzr/6iqtwoN3HhPicr4HWDdM6MkFHwcRmt7G4U
 CeTjclaCpynqzIogu+yXlfstt7qMqV3ssOoUntZZDhHmjPL4m+F6bM6/zxCvzuiLJkyRKDMof
 Ozz5SJRZuFsD75xvMaw7M3wuVKlfkOP4uCKfe8+Xqaf89LrgqyitCFSFJM7SlV1lovDN6U9fG
 3d09xVtZ41W6Dlw8ynv2QyAIGYvEUr/bx3V6OGDD2IV9nVtbgNn/XcrwKP8h5sEfPHpZYFjeA
 oelGNsLnkCviQXuevmptEkubWCH0VOwGXGeAwbQMFKnKRPmr0CPqw5scZoP9Sc/TSwXALs3BF
 PhkXFhU2iUDuadpqim++wYhGk297kaQ8qtEx3GzagWFVlPLA28dy1d4PQEs6qoxmhuSiyjGHT
 wuQ2hlfrcCD6wxDk+q51pmtHpxLB1t8QjZZ9fEo1JJ1q3dVwYETpBz3r4dNWoCjsdF+3e9L1r
 ekT6ttlBBp/nSfZKpF48KkRZheZOEGlcKFYrZF/5BWpxsDsKrffuYXjqAKZVsA3TRcQT8f24L
 jgt6eXWAH2/2LvhcZBCVtPHueZTqtQR90wVeVgivnvYjYDxVjDdpIMz8jdFsMYNO8MhqKv/35
 RaHT032QMtj0f8qlbxyHMfq01hu9wAMv+DYQlFzbuBSQWG4Bbpl/XMDFAQf0o9spcn5dQ/A/b
 DhB+hbBjdwBw4HIJPQ7dySIrBgprA5+H85MAxnAXzzj1eiRYQdpk2sYjsYTO/YJzekfUtI4nv
 6ujmo01g5p85CSfSKVqH29tE5W3lO7H/wq1IpA9nevlZiAuxgNt5TnHvJnxPGh3XvCvP79t7V
 xDJnfpCIN0/Sok0WanYdAGtKi4xsND2ca9sh+osLOYeJMdoS/jvVzZlaMaN5rD0RTtfMSBbxy
 shyzlzJG5fOa6og/futs6gcS8+EI3th3ydtHJq1ROG5Sk+GD3Kt0LMDQ/g7tmtg4COiQb1Rvh
 KF5+WiJKA1LxKz6Oclzsc9w71lLGm5AICmWbc3nJC/xQuKMtcTZUCQHfAJNZUDbYNPdUGXAxL
 kzJJfgWrLaghFljtVd80jkx1QmWV1oRObEmXGo1Ug31SYm26oV4WCEBQNYmpAXWVZfbLZofXS
 oaFXOyu03iHrAzrXvfGzEBrbr/mHSKrkmGubySTquzEHaYJcGpFhxg846y2JGEncwgH3LjGow
 i64rDf2ZPXpro071ptmcai0Y/x4cL7Z2Tp77qmaT/3Reyp3ofS4j8GCKLP09AyA20kZEGAqGn
 NKk43VfUywaSWA/7MdFC/798cSJDp/4PFE66sdvcBzHpVIgzI+jLYNZjkS


--xqg47v3xy6vv4paz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [REGRESSION][BISECTED] Crash with Bad page state for FUSE/Flatpak
 related applications since v6.13
MIME-Version: 1.0

Hello everyone,

we have recently received [a report][0] on the Arch Linux Gitlab about
multiple users having system crashes when using Flatpak programs and
related FUSE errors in their dmesg logs.

We have subsequently bisected the issue within the mainline kernel tree
to the following commit:

    3eab9d7bc2f4 ("fuse: convert readahead to use folios")

The error is still present in the latest mainline release 6.14-rc1 and
sadly testing a revert is not trivially possible due to conflicts.

I have attached a dmesg output from a boot where the failure occurs and
I'm happy to test any debug patches with the help of the other reporters
on our GitLab.

We also noticed that there already was [a discussion][1] about a related
commit but the fix for the issue back then 7a4f54187373 ("fuse: fix
direct io folio offset and length calculation") was already included in
the revisions we have tested.

Cheers,
Christian

[0]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issu=
es/110
[1]: https://lore.kernel.org/all/p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo=
674f7f3y@cwnwffjqltzw/

---

#regzbot link: https://gitlab.archlinux.org/archlinux/packaging/packages/li=
nux/-/issues/110
#regzbot introduced: 3eab9d7bc2f4
#regzbot title: fuse: Crashes with Bad page state when using Flatpaks

---

Feb 06 08:53:45 archvm kernel: Linux version 6.14.0-rc1-1-mainline (linux-m=
ainline@archlinux) (gcc (GCC) 14.2.1 20250128, GNU ld (GNU Binutils) 2.43.1=
) #1 SMP PREEMPT_DYNAMIC Mon, 03 Feb 2025 12:52:24 +0000
Feb 06 08:53:45 archvm kernel: Command line: initrd=3D\initramfs-linux-main=
line.img root=3D"LABEL=3DARCH" rw net.ifnames=3D0
Feb 06 08:53:45 archvm kernel: [Firmware Bug]: TSC doesn't count with P0 fr=
equency!
Feb 06 08:53:45 archvm kernel: BIOS-provided physical RAM map:
Feb 06 08:53:45 archvm kernel: BIOS-e820: [mem 0x0000000000000000-0x0000000=
00002ffff] usable
Feb 06 08:53:45 archvm kernel: BIOS-e820: [mem 0x0000000000030000-0x0000000=
00004ffff] reserved
Feb 06 08:53:45 archvm kernel: BIOS-e820: [mem 0x0000000000050000-0x0000000=
00009efff] usable
Feb 06 08:53:45 archvm kernel: BIOS-e820: [mem 0x000000000009f000-0x0000000=
00009ffff] reserved
Feb 06 08:53:45 archvm kernel: BIOS-e820: [mem 0x0000000000100000-0x0000000=
07e8ebfff] usable
Feb 06 08:53:45 archvm kernel: BIOS-e820: [mem 0x000000007e8ec000-0x0000000=
07eb6bfff] reserved
Feb 06 08:53:45 archvm kernel: BIOS-e820: [mem 0x000000007eb6c000-0x0000000=
07eb7dfff] ACPI data
Feb 06 08:53:45 archvm kernel: BIOS-e820: [mem 0x000000007eb7e000-0x0000000=
07ebfdfff] ACPI NVS
Feb 06 08:53:45 archvm kernel: BIOS-e820: [mem 0x000000007ebfe000-0x0000000=
07ef99fff] usable
Feb 06 08:53:45 archvm kernel: BIOS-e820: [mem 0x000000007ef9a000-0x0000000=
07ef9bfff] ACPI NVS
Feb 06 08:53:45 archvm kernel: BIOS-e820: [mem 0x000000007ef9c000-0x0000000=
07effffff] usable
Feb 06 08:53:45 archvm kernel: BIOS-e820: [mem 0x000000007f000000-0x0000000=
07fffffff] reserved
Feb 06 08:53:45 archvm kernel: BIOS-e820: [mem 0x00000000e0000000-0x0000000=
0efffffff] reserved
Feb 06 08:53:45 archvm kernel: BIOS-e820: [mem 0x00000000feffc000-0x0000000=
0feffffff] reserved
Feb 06 08:53:45 archvm kernel: BIOS-e820: [mem 0x000000fd00000000-0x000000f=
fffffffff] reserved
Feb 06 08:53:45 archvm kernel: NX (Execute Disable) protection: active
Feb 06 08:53:45 archvm kernel: APIC: Static calls initialized
Feb 06 08:53:45 archvm kernel: e820: update [mem 0x7bc2a018-0x7bc51457] usa=
ble =3D=3D> usable
Feb 06 08:53:45 archvm kernel: e820: update [mem 0x7bc09018-0x7bc29457] usa=
ble =3D=3D> usable
Feb 06 08:53:45 archvm kernel: extended physical RAM map:
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x0000000000000000-=
0x000000000002ffff] usable
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x0000000000030000-=
0x000000000004ffff] reserved
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x0000000000050000-=
0x000000000009efff] usable
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x000000000009f000-=
0x000000000009ffff] reserved
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x0000000000100000-=
0x000000007bc09017] usable
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x000000007bc09018-=
0x000000007bc29457] usable
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x000000007bc29458-=
0x000000007bc2a017] usable
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x000000007bc2a018-=
0x000000007bc51457] usable
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x000000007bc51458-=
0x000000007e8ebfff] usable
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x000000007e8ec000-=
0x000000007eb6bfff] reserved
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x000000007eb6c000-=
0x000000007eb7dfff] ACPI data
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x000000007eb7e000-=
0x000000007ebfdfff] ACPI NVS
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x000000007ebfe000-=
0x000000007ef99fff] usable
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x000000007ef9a000-=
0x000000007ef9bfff] ACPI NVS
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x000000007ef9c000-=
0x000000007effffff] usable
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x000000007f000000-=
0x000000007fffffff] reserved
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x00000000e0000000-=
0x00000000efffffff] reserved
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x00000000feffc000-=
0x00000000feffffff] reserved
Feb 06 08:53:45 archvm kernel: reserve setup_data: [mem 0x000000fd00000000-=
0x000000ffffffffff] reserved
Feb 06 08:53:45 archvm kernel: efi: EFI v2.7 by EDK II
Feb 06 08:53:45 archvm kernel: efi: SMBIOS=3D0x7e9d4000 ACPI=3D0x7eb7d000 A=
CPI 2.0=3D0x7eb7d014 MEMATTR=3D0x7d632018 RNG=3D0x7eb73f18 INITRD=3D0x7d633=
d18
Feb 06 08:53:45 archvm kernel: random: crng init done
Feb 06 08:53:45 archvm kernel: SMBIOS 2.8 present.
Feb 06 08:53:45 archvm kernel: DMI: QEMU Standard PC (Q35 + ICH9, 2009), BI=
OS unknown 02/02/2022
Feb 06 08:53:45 archvm kernel: DMI: Memory slots populated: 1/1
Feb 06 08:53:45 archvm kernel: Hypervisor detected: KVM
Feb 06 08:53:45 archvm kernel: kvm-clock: Using msrs 4b564d01 and 4b564d00
Feb 06 08:53:45 archvm kernel: kvm-clock: using sched offset of 17158487143=
 cycles
Feb 06 08:53:45 archvm kernel: clocksource: kvm-clock: mask: 0xffffffffffff=
ffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
Feb 06 08:53:45 archvm kernel: tsc: Detected 3700.034 MHz processor
Feb 06 08:53:45 archvm kernel: e820: update [mem 0x00000000-0x00000fff] usa=
ble =3D=3D> reserved
Feb 06 08:53:45 archvm kernel: e820: remove [mem 0x000a0000-0x000fffff] usa=
ble
Feb 06 08:53:45 archvm kernel: last_pfn =3D 0x7f000 max_arch_pfn =3D 0x4000=
00000
Feb 06 08:53:45 archvm kernel: MTRR map: 4 entries (2 fixed + 2 variable; m=
ax 18), built from 8 variable MTRRs
Feb 06 08:53:45 archvm kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC=
  WB  WP  UC- WT
Feb 06 08:53:45 archvm kernel: Using GB pages for direct mapping
Feb 06 08:53:45 archvm kernel: Secure boot disabled
Feb 06 08:53:45 archvm kernel: RAMDISK: [mem 0x7bc52000-0x7c6b9fff]
Feb 06 08:53:45 archvm kernel: ACPI: Early table checksum verification disa=
bled
Feb 06 08:53:45 archvm kernel: ACPI: RSDP 0x000000007EB7D014 000024 (v02 BO=
CHS )
Feb 06 08:53:45 archvm kernel: ACPI: XSDT 0x000000007EB7C0E8 00004C (v01 BO=
CHS  BXPC     00000001      01000013)
Feb 06 08:53:45 archvm kernel: ACPI: FACP 0x000000007EB78000 0000F4 (v03 BO=
CHS  BXPC     00000001 BXPC 00000001)
Feb 06 08:53:45 archvm kernel: ACPI: DSDT 0x000000007EB79000 002A44 (v01 BO=
CHS  BXPC     00000001 BXPC 00000001)
Feb 06 08:53:45 archvm kernel: ACPI: FACS 0x000000007EBDC000 000040
Feb 06 08:53:45 archvm kernel: ACPI: APIC 0x000000007EB77000 0000B0 (v03 BO=
CHS  BXPC     00000001 BXPC 00000001)
Feb 06 08:53:45 archvm kernel: ACPI: MCFG 0x000000007EB76000 00003C (v01 BO=
CHS  BXPC     00000001 BXPC 00000001)
Feb 06 08:53:45 archvm kernel: ACPI: WAET 0x000000007EB75000 000028 (v01 BO=
CHS  BXPC     00000001 BXPC 00000001)
Feb 06 08:53:45 archvm kernel: ACPI: BGRT 0x000000007EB74000 000038 (v01 IN=
TEL  EDK2     00000002      01000013)
Feb 06 08:53:45 archvm kernel: ACPI: Reserving FACP table memory at [mem 0x=
7eb78000-0x7eb780f3]
Feb 06 08:53:45 archvm kernel: ACPI: Reserving DSDT table memory at [mem 0x=
7eb79000-0x7eb7ba43]
Feb 06 08:53:45 archvm kernel: ACPI: Reserving FACS table memory at [mem 0x=
7ebdc000-0x7ebdc03f]
Feb 06 08:53:45 archvm kernel: ACPI: Reserving APIC table memory at [mem 0x=
7eb77000-0x7eb770af]
Feb 06 08:53:45 archvm kernel: ACPI: Reserving MCFG table memory at [mem 0x=
7eb76000-0x7eb7603b]
Feb 06 08:53:45 archvm kernel: ACPI: Reserving WAET table memory at [mem 0x=
7eb75000-0x7eb75027]
Feb 06 08:53:45 archvm kernel: ACPI: Reserving BGRT table memory at [mem 0x=
7eb74000-0x7eb74037]
Feb 06 08:53:45 archvm kernel: No NUMA configuration found
Feb 06 08:53:45 archvm kernel: Faking a node at [mem 0x0000000000000000-0x0=
00000007effffff]
Feb 06 08:53:45 archvm kernel: NODE_DATA(0) allocated [mem 0x7ef212c0-0x7ef=
4bfff]
Feb 06 08:53:45 archvm kernel: Zone ranges:
Feb 06 08:53:45 archvm kernel:   DMA      [mem 0x0000000000001000-0x0000000=
000ffffff]
Feb 06 08:53:45 archvm kernel:   DMA32    [mem 0x0000000001000000-0x0000000=
07effffff]
Feb 06 08:53:45 archvm kernel:   Normal   empty
Feb 06 08:53:45 archvm kernel:   Device   empty
Feb 06 08:53:45 archvm kernel: Movable zone start for each node
Feb 06 08:53:45 archvm kernel: Early memory node ranges
Feb 06 08:53:45 archvm kernel:   node   0: [mem 0x0000000000001000-0x000000=
000002ffff]
Feb 06 08:53:45 archvm kernel:   node   0: [mem 0x0000000000050000-0x000000=
000009efff]
Feb 06 08:53:45 archvm kernel:   node   0: [mem 0x0000000000100000-0x000000=
007e8ebfff]
Feb 06 08:53:45 archvm kernel:   node   0: [mem 0x000000007ebfe000-0x000000=
007ef99fff]
Feb 06 08:53:45 archvm kernel:   node   0: [mem 0x000000007ef9c000-0x000000=
007effffff]
Feb 06 08:53:45 archvm kernel: Initmem setup node 0 [mem 0x0000000000001000=
-0x000000007effffff]
Feb 06 08:53:45 archvm kernel: On node 0, zone DMA: 1 pages in unavailable =
ranges
Feb 06 08:53:45 archvm kernel: On node 0, zone DMA: 32 pages in unavailable=
 ranges
Feb 06 08:53:45 archvm kernel: On node 0, zone DMA: 97 pages in unavailable=
 ranges
Feb 06 08:53:45 archvm kernel: On node 0, zone DMA32: 786 pages in unavaila=
ble ranges
Feb 06 08:53:45 archvm kernel: On node 0, zone DMA32: 2 pages in unavailabl=
e ranges
Feb 06 08:53:45 archvm kernel: On node 0, zone DMA32: 4096 pages in unavail=
able ranges
Feb 06 08:53:45 archvm kernel: ACPI: PM-Timer IO Port: 0x608
Feb 06 08:53:45 archvm kernel: ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[=
0x1])
Feb 06 08:53:45 archvm kernel: IOAPIC[0]: apic_id 0, version 17, address 0x=
fec00000, GSI 0-23
Feb 06 08:53:45 archvm kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_ir=
q 2 dfl dfl)
Feb 06 08:53:45 archvm kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_ir=
q 5 high level)
Feb 06 08:53:45 archvm kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_ir=
q 9 high level)
Feb 06 08:53:45 archvm kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_i=
rq 10 high level)
Feb 06 08:53:45 archvm kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_i=
rq 11 high level)
Feb 06 08:53:45 archvm kernel: ACPI: Using ACPI (MADT) for SMP configuratio=
n information
Feb 06 08:53:45 archvm kernel: e820: update [mem 0x7d16f000-0x7d177fff] usa=
ble =3D=3D> reserved
Feb 06 08:53:45 archvm kernel: TSC deadline timer available
Feb 06 08:53:45 archvm kernel: CPU topo: Max. logical packages:   1
Feb 06 08:53:45 archvm kernel: CPU topo: Max. logical dies:       1
Feb 06 08:53:45 archvm kernel: CPU topo: Max. dies per package:   1
Feb 06 08:53:45 archvm kernel: CPU topo: Max. threads per core:   2
Feb 06 08:53:45 archvm kernel: CPU topo: Num. cores per package:     4
Feb 06 08:53:45 archvm kernel: CPU topo: Num. threads per package:   8
Feb 06 08:53:45 archvm kernel: CPU topo: Allowing 8 present CPUs plus 0 hot=
plug CPUs
Feb 06 08:53:45 archvm kernel: kvm-guest: APIC: eoi() replaced with kvm_gue=
st_apic_eoi_write()
Feb 06 08:53:45 archvm kernel: kvm-guest: KVM setup pv remote TLB flush
Feb 06 08:53:45 archvm kernel: kvm-guest: setup PV sched yield
Feb 06 08:53:45 archvm kernel: PM: hibernation: Registered nosave memory: [=
mem 0x00000000-0x00000fff]
Feb 06 08:53:45 archvm kernel: PM: hibernation: Registered nosave memory: [=
mem 0x00030000-0x0004ffff]
Feb 06 08:53:45 archvm kernel: PM: hibernation: Registered nosave memory: [=
mem 0x0009f000-0x0009ffff]
Feb 06 08:53:45 archvm kernel: PM: hibernation: Registered nosave memory: [=
mem 0x000a0000-0x000fffff]
Feb 06 08:53:45 archvm kernel: PM: hibernation: Registered nosave memory: [=
mem 0x7bc09000-0x7bc09fff]
Feb 06 08:53:45 archvm kernel: PM: hibernation: Registered nosave memory: [=
mem 0x7bc29000-0x7bc29fff]
Feb 06 08:53:45 archvm kernel: PM: hibernation: Registered nosave memory: [=
mem 0x7bc2a000-0x7bc2afff]
Feb 06 08:53:45 archvm kernel: PM: hibernation: Registered nosave memory: [=
mem 0x7bc51000-0x7bc51fff]
Feb 06 08:53:45 archvm kernel: PM: hibernation: Registered nosave memory: [=
mem 0x7d16f000-0x7d177fff]
Feb 06 08:53:45 archvm kernel: PM: hibernation: Registered nosave memory: [=
mem 0x7e8ec000-0x7eb6bfff]
Feb 06 08:53:45 archvm kernel: PM: hibernation: Registered nosave memory: [=
mem 0x7eb6c000-0x7eb7dfff]
Feb 06 08:53:45 archvm kernel: PM: hibernation: Registered nosave memory: [=
mem 0x7eb7e000-0x7ebfdfff]
Feb 06 08:53:45 archvm kernel: PM: hibernation: Registered nosave memory: [=
mem 0x7ef9a000-0x7ef9bfff]
Feb 06 08:53:45 archvm kernel: [mem 0x80000000-0xdfffffff] available for PC=
I devices
Feb 06 08:53:45 archvm kernel: Booting paravirtualized kernel on KVM
Feb 06 08:53:45 archvm kernel: clocksource: refined-jiffies: mask: 0xffffff=
ff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
Feb 06 08:53:45 archvm kernel: setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8=
 nr_cpu_ids:8 nr_node_ids:1
Feb 06 08:53:45 archvm kernel: percpu: Embedded 67 pages/cpu s237568 r8192 =
d28672 u524288
Feb 06 08:53:45 archvm kernel: pcpu-alloc: s237568 r8192 d28672 u524288 all=
oc=3D1*2097152
Feb 06 08:53:45 archvm kernel: pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7
Feb 06 08:53:45 archvm kernel: kvm-guest: PV spinlocks enabled
Feb 06 08:53:45 archvm kernel: PV qspinlock hash table entries: 256 (order:=
 0, 4096 bytes, linear)
Feb 06 08:53:45 archvm kernel: Kernel command line: initrd=3D\initramfs-lin=
ux-mainline.img root=3D"LABEL=3DARCH" rw net.ifnames=3D0
Feb 06 08:53:45 archvm kernel: printk: log buffer data + meta data: 131072 =
+ 458752 =3D 589824 bytes
Feb 06 08:53:45 archvm kernel: Dentry cache hash table entries: 262144 (ord=
er: 9, 2097152 bytes, linear)
Feb 06 08:53:45 archvm kernel: Inode-cache hash table entries: 131072 (orde=
r: 8, 1048576 bytes, linear)
Feb 06 08:53:45 archvm kernel: Fallback order for Node 0: 0
Feb 06 08:53:45 archvm kernel: Built 1 zonelists, mobility grouping on.  To=
tal pages: 519274
Feb 06 08:53:45 archvm kernel: Policy zone: DMA32
Feb 06 08:53:45 archvm kernel: mem auto-init: stack:all(zero), heap alloc:o=
n, heap free:off
Feb 06 08:53:45 archvm kernel: SLUB: HWalign=3D64, Order=3D0-3, MinObjects=
=3D0, CPUs=3D8, Nodes=3D1
Feb 06 08:53:45 archvm kernel: ftrace: allocating 51829 entries in 203 pages
Feb 06 08:53:45 archvm kernel: ftrace: allocated 203 pages with 5 groups
Feb 06 08:53:45 archvm kernel: Dynamic Preempt: full
Feb 06 08:53:45 archvm kernel: rcu: Preemptible hierarchical RCU implementa=
tion.
Feb 06 08:53:45 archvm kernel: rcu:         RCU restricting CPUs from NR_CP=
US=3D8192 to nr_cpu_ids=3D8.
Feb 06 08:53:45 archvm kernel: rcu:         RCU priority boosting: priority=
 1 delay 500 ms.
Feb 06 08:53:45 archvm kernel:         Trampoline variant of Tasks RCU enab=
led.
Feb 06 08:53:45 archvm kernel:         Rude variant of Tasks RCU enabled.
Feb 06 08:53:45 archvm kernel:         Tracing variant of Tasks RCU enabled.
Feb 06 08:53:45 archvm kernel: rcu: RCU calculated value of scheduler-enlis=
tment delay is 100 jiffies.
Feb 06 08:53:45 archvm kernel: rcu: Adjusting geometry for rcu_fanout_leaf=
=3D16, nr_cpu_ids=3D8
Feb 06 08:53:45 archvm kernel: RCU Tasks: Setting shift to 3 and lim to 1 r=
cu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D8.
Feb 06 08:53:45 archvm kernel: RCU Tasks Rude: Setting shift to 3 and lim t=
o 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D8.
Feb 06 08:53:45 archvm kernel: RCU Tasks Trace: Setting shift to 3 and lim =
to 1 rcu_task_cb_adjust=3D1 rcu_task_cpu_ids=3D8.
Feb 06 08:53:45 archvm kernel: NR_IRQS: 524544, nr_irqs: 488, preallocated =
irqs: 16
Feb 06 08:53:45 archvm kernel: rcu: srcu_init: Setting srcu_struct sizes ba=
sed on contention.
Feb 06 08:53:45 archvm kernel: kfence: initialized - using 2097152 bytes fo=
r 255 objects at 0x(____ptrval____)-0x(____ptrval____)
Feb 06 08:53:45 archvm kernel: Console: colour dummy device 80x25
Feb 06 08:53:45 archvm kernel: printk: legacy console [tty0] enabled
Feb 06 08:53:45 archvm kernel: ACPI: Core revision 20240827
Feb 06 08:53:45 archvm kernel: APIC: Switch to symmetric I/O mode setup
Feb 06 08:53:45 archvm kernel: x2apic enabled
Feb 06 08:53:45 archvm kernel: APIC: Switched APIC routing to: physical x2a=
pic
Feb 06 08:53:45 archvm kernel: kvm-guest: APIC: send_IPI_mask() replaced wi=
th kvm_send_ipi_mask()
Feb 06 08:53:45 archvm kernel: kvm-guest: APIC: send_IPI_mask_allbutself() =
replaced with kvm_send_ipi_mask_allbutself()
Feb 06 08:53:45 archvm kernel: kvm-guest: setup PV IPIs
Feb 06 08:53:45 archvm kernel: clocksource: tsc-early: mask: 0xffffffffffff=
ffff max_cycles: 0x6aaaebaad24, max_idle_ns: 881591041906 ns
Feb 06 08:53:45 archvm kernel: Calibrating delay loop (skipped) preset valu=
e.. 7400.06 BogoMIPS (lpj=3D3700034)
Feb 06 08:53:45 archvm kernel: AMD Zen1 DIV0 bug detected. Disable SMT for =
full protection.
Feb 06 08:53:45 archvm kernel: Last level iTLB entries: 4KB 1024, 2MB 1024,=
 4MB 512
Feb 06 08:53:45 archvm kernel: Last level dTLB entries: 4KB 1536, 2MB 1536,=
 4MB 768, 1GB 0
Feb 06 08:53:45 archvm kernel: Spectre V1 : Mitigation: usercopy/swapgs bar=
riers and __user pointer sanitization
Feb 06 08:53:45 archvm kernel: Spectre V2 : Mitigation: Retpolines
Feb 06 08:53:45 archvm kernel: Spectre V2 : Spectre v2 / SpectreRSB mitigat=
ion: Filling RSB on context switch
Feb 06 08:53:45 archvm kernel: Spectre V2 : Spectre v2 / SpectreRSB : Filli=
ng RSB on VMEXIT
Feb 06 08:53:45 archvm kernel: Spectre V2 : Enabling Speculation Barrier fo=
r firmware calls
Feb 06 08:53:45 archvm kernel: RETBleed: Mitigation: untrained return thunk
Feb 06 08:53:45 archvm kernel: Spectre V2 : mitigation: Enabling conditiona=
l Indirect Branch Prediction Barrier
Feb 06 08:53:45 archvm kernel: Speculative Store Bypass: Mitigation: Specul=
ative Store Bypass disabled via prctl
Feb 06 08:53:45 archvm kernel: Speculative Return Stack Overflow: Mitigatio=
n: Safe RET
Feb 06 08:53:45 archvm kernel: x86/fpu: Supporting XSAVE feature 0x001: 'x8=
7 floating point registers'
Feb 06 08:53:45 archvm kernel: x86/fpu: Supporting XSAVE feature 0x002: 'SS=
E registers'
Feb 06 08:53:45 archvm kernel: x86/fpu: Supporting XSAVE feature 0x004: 'AV=
X registers'
Feb 06 08:53:45 archvm kernel: x86/fpu: xstate_offset[2]:  576, xstate_size=
s[2]:  256
Feb 06 08:53:45 archvm kernel: x86/fpu: Enabled xstate features 0x7, contex=
t size is 832 bytes, using 'compacted' format.
Feb 06 08:53:45 archvm kernel: Freeing SMP alternatives memory: 44K
Feb 06 08:53:45 archvm kernel: pid_max: default: 32768 minimum: 301
Feb 06 08:53:45 archvm kernel: LSM: initializing lsm=3Dcapability,landlock,=
lockdown,yama,bpf
Feb 06 08:53:45 archvm kernel: landlock: Up and running.
Feb 06 08:53:45 archvm kernel: Yama: becoming mindful.
Feb 06 08:53:45 archvm kernel: LSM support for eBPF active
Feb 06 08:53:45 archvm kernel: Mount-cache hash table entries: 4096 (order:=
 3, 32768 bytes, linear)
Feb 06 08:53:45 archvm kernel: Mountpoint-cache hash table entries: 4096 (o=
rder: 3, 32768 bytes, linear)
Feb 06 08:53:45 archvm kernel: smpboot: CPU0: AMD Ryzen 7 2700X Eight-Core =
Processor (family: 0x17, model: 0x8, stepping: 0x2)
Feb 06 08:53:45 archvm kernel: Performance Events: Fam17h+ core perfctr, AM=
D PMU driver.
Feb 06 08:53:45 archvm kernel: ... version:                0
Feb 06 08:53:45 archvm kernel: ... bit width:              48
Feb 06 08:53:45 archvm kernel: ... generic registers:      6
Feb 06 08:53:45 archvm kernel: ... value mask:             0000ffffffffffff
Feb 06 08:53:45 archvm kernel: ... max period:             00007fffffffffff
Feb 06 08:53:45 archvm kernel: ... fixed-purpose events:   0
Feb 06 08:53:45 archvm kernel: ... event mask:             000000000000003f
Feb 06 08:53:45 archvm kernel: signal: max sigframe size: 1776
Feb 06 08:53:45 archvm kernel: rcu: Hierarchical SRCU implementation.
Feb 06 08:53:45 archvm kernel: rcu:         Max phase no-delay instances is=
 400.
Feb 06 08:53:45 archvm kernel: Timer migration: 1 hierarchy levels; 8 child=
ren per group; 1 crossnode level
Feb 06 08:53:45 archvm kernel: smp: Bringing up secondary CPUs ...
Feb 06 08:53:45 archvm kernel: smpboot: x86: Booting SMP configuration:
Feb 06 08:53:45 archvm kernel: .... node  #0, CPUs:      #2 #4 #6 #1 #3 #5 =
#7
Feb 06 08:53:45 archvm kernel: smp: Brought up 1 node, 8 CPUs
Feb 06 08:53:45 archvm kernel: smpboot: Total of 8 processors activated (59=
200.54 BogoMIPS)
Feb 06 08:53:45 archvm kernel: Memory: 1965392K/2077096K available (17367K =
kernel code, 2681K rwdata, 14500K rodata, 4308K init, 3932K bss, 103332K re=
served, 0K cma-reserved)
Feb 06 08:53:45 archvm kernel: devtmpfs: initialized
Feb 06 08:53:45 archvm kernel: x86/mm: Memory block size: 128MB
Feb 06 08:53:45 archvm kernel: ACPI: PM: Registering ACPI NVS region [mem 0=
x7eb7e000-0x7ebfdfff] (524288 bytes)
Feb 06 08:53:45 archvm kernel: ACPI: PM: Registering ACPI NVS region [mem 0=
x7ef9a000-0x7ef9bfff] (8192 bytes)
Feb 06 08:53:45 archvm kernel: clocksource: jiffies: mask: 0xffffffff max_c=
ycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
Feb 06 08:53:45 archvm kernel: futex hash table entries: 2048 (order: 5, 13=
1072 bytes, linear)
Feb 06 08:53:45 archvm kernel: pinctrl core: initialized pinctrl subsystem
Feb 06 08:53:45 archvm kernel: PM: RTC time: 21:53:41, date: 2025-02-05
Feb 06 08:53:45 archvm kernel: NET: Registered PF_NETLINK/PF_ROUTE protocol=
 family
Feb 06 08:53:45 archvm kernel: DMA: preallocated 256 KiB GFP_KERNEL pool fo=
r atomic allocations
Feb 06 08:53:45 archvm kernel: DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA=
 pool for atomic allocations
Feb 06 08:53:45 archvm kernel: DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA=
32 pool for atomic allocations
Feb 06 08:53:45 archvm kernel: audit: initializing netlink subsys (disabled)
Feb 06 08:53:45 archvm kernel: audit: type=3D2000 audit(1738792422.728:1): =
state=3Dinitialized audit_enabled=3D0 res=3D1
Feb 06 08:53:45 archvm kernel: thermal_sys: Registered thermal governor 'fa=
ir_share'
Feb 06 08:53:45 archvm kernel: thermal_sys: Registered thermal governor 'ba=
ng_bang'
Feb 06 08:53:45 archvm kernel: thermal_sys: Registered thermal governor 'st=
ep_wise'
Feb 06 08:53:45 archvm kernel: thermal_sys: Registered thermal governor 'us=
er_space'
Feb 06 08:53:45 archvm kernel: thermal_sys: Registered thermal governor 'po=
wer_allocator'
Feb 06 08:53:45 archvm kernel: cpuidle: using governor ladder
Feb 06 08:53:45 archvm kernel: cpuidle: using governor menu
Feb 06 08:53:45 archvm kernel: acpiphp: ACPI Hot Plug PCI Controller Driver=
 version: 0.5
Feb 06 08:53:45 archvm kernel: PCI: ECAM [mem 0xe0000000-0xefffffff] (base =
0xe0000000) for domain 0000 [bus 00-ff]
Feb 06 08:53:45 archvm kernel: PCI: Using configuration type 1 for base acc=
ess
Feb 06 08:53:45 archvm kernel: kprobes: kprobe jump-optimization is enabled=
=2E All kprobes are optimized if possible.
Feb 06 08:53:45 archvm kernel: HugeTLB: registered 1.00 GiB page size, pre-=
allocated 0 pages
Feb 06 08:53:45 archvm kernel: HugeTLB: 16380 KiB vmemmap can be freed for =
a 1.00 GiB page
Feb 06 08:53:45 archvm kernel: HugeTLB: registered 2.00 MiB page size, pre-=
allocated 0 pages
Feb 06 08:53:45 archvm kernel: HugeTLB: 28 KiB vmemmap can be freed for a 2=
=2E00 MiB page
Feb 06 08:53:45 archvm kernel: ACPI: Added _OSI(Module Device)
Feb 06 08:53:45 archvm kernel: ACPI: Added _OSI(Processor Device)
Feb 06 08:53:45 archvm kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
Feb 06 08:53:45 archvm kernel: ACPI: Added _OSI(Processor Aggregator Device)
Feb 06 08:53:45 archvm kernel: ACPI: 1 ACPI AML tables successfully acquire=
d and loaded
Feb 06 08:53:45 archvm kernel: ACPI: Interpreter enabled
Feb 06 08:53:45 archvm kernel: ACPI: PM: (supports S0 S5)
Feb 06 08:53:45 archvm kernel: ACPI: Using IOAPIC for interrupt routing
Feb 06 08:53:45 archvm kernel: PCI: Using host bridge windows from ACPI; if=
 necessary, use "pci=3Dnocrs" and report a bug
Feb 06 08:53:45 archvm kernel: PCI: Using E820 reservations for host bridge=
 windows
Feb 06 08:53:45 archvm kernel: ACPI: Enabled 2 GPEs in block 00 to 3F
Feb 06 08:53:45 archvm kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [b=
us 00-ff])
Feb 06 08:53:45 archvm kernel: acpi PNP0A08:00: _OSC: OS supports [Extended=
Config ASPM ClockPM Segments MSI EDR HPX-Type3]
Feb 06 08:53:45 archvm kernel: acpi PNP0A08:00: _OSC: platform does not sup=
port [PCIeHotplug LTR DPC]
Feb 06 08:53:45 archvm kernel: acpi PNP0A08:00: _OSC: OS now controls [SHPC=
Hotplug PME AER PCIeCapability]
Feb 06 08:53:45 archvm kernel: PCI host bridge to bus 0000:00
Feb 06 08:53:45 archvm kernel: pci_bus 0000:00: root bus resource [io  0x00=
00-0x0cf7 window]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:00: root bus resource [io  0x0d=
00-0xffff window]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:00: root bus resource [mem 0x00=
0a0000-0x000bffff window]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:00: root bus resource [mem 0x80=
000000-0xdfffffff window]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:00: root bus resource [mem 0xf0=
000000-0xfebfffff window]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:00: root bus resource [mem 0x38=
0000000000-0x384fffffffff window]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:00: root bus resource [bus 00-f=
f]
Feb 06 08:53:45 archvm kernel: pci 0000:00:00.0: [8086:29c0] type 00 class =
0x060000 conventional PCI endpoint
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.0: [1b36:000c] type 01 class =
0x060400 PCIe Root Port
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.0: BAR 0 [mem 0x8248e000-0x82=
48efff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.0:   bridge window [mem 0x822=
00000-0x823fffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.0:   bridge window [mem 0x380=
000000000-0x3807ffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.1: [1b36:000c] type 01 class =
0x060400 PCIe Root Port
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.1: BAR 0 [mem 0x8248d000-0x82=
48dfff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.1: PCI bridge to [bus 02]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.1:   bridge window [mem 0x820=
00000-0x821fffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.1:   bridge window [mem 0x380=
800000000-0x380fffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.2: [1b36:000c] type 01 class =
0x060400 PCIe Root Port
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.2: BAR 0 [mem 0x8248c000-0x82=
48cfff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.2: PCI bridge to [bus 03]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.2:   bridge window [mem 0x81e=
00000-0x81ffffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.2:   bridge window [mem 0x381=
000000000-0x3817ffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.3: [1b36:000c] type 01 class =
0x060400 PCIe Root Port
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.3: BAR 0 [mem 0x8248b000-0x82=
48bfff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.3: PCI bridge to [bus 04]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.3:   bridge window [mem 0x81c=
00000-0x81dfffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.3:   bridge window [mem 0x381=
800000000-0x381fffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.4: [1b36:000c] type 01 class =
0x060400 PCIe Root Port
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.4: BAR 0 [mem 0x8248a000-0x82=
48afff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.4: PCI bridge to [bus 05]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.4:   bridge window [mem 0x81a=
00000-0x81bfffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.4:   bridge window [mem 0x382=
000000000-0x3827ffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.5: [1b36:000c] type 01 class =
0x060400 PCIe Root Port
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.5: BAR 0 [mem 0x82489000-0x82=
489fff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.5: PCI bridge to [bus 06]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.5:   bridge window [mem 0x818=
00000-0x819fffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.5:   bridge window [mem 0x382=
800000000-0x382fffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.6: [1b36:000c] type 01 class =
0x060400 PCIe Root Port
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.6: BAR 0 [mem 0x82488000-0x82=
488fff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.6: PCI bridge to [bus 07]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.6:   bridge window [mem 0x816=
00000-0x817fffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.6:   bridge window [mem 0x383=
000000000-0x3837ffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.7: [1b36:000c] type 01 class =
0x060400 PCIe Root Port
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.7: BAR 0 [mem 0x82487000-0x82=
487fff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.7: PCI bridge to [bus 08]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.7:   bridge window [mem 0x814=
00000-0x815fffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.7:   bridge window [mem 0x383=
800000000-0x383fffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.0: [1b36:000c] type 01 class =
0x060400 PCIe Root Port
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.0: BAR 0 [mem 0x82486000-0x82=
486fff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.0: PCI bridge to [bus 09]
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.0:   bridge window [io  0x600=
0-0x6fff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.0:   bridge window [mem 0x800=
00000-0x810fffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.0:   bridge window [mem 0x384=
000000000-0x3847ffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.1: [1b36:000c] type 01 class =
0x060400 PCIe Root Port
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.1: BAR 0 [mem 0x82485000-0x82=
485fff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.1: PCI bridge to [bus 0a]
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.1:   bridge window [mem 0x812=
00000-0x813fffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.1:   bridge window [mem 0x384=
800000000-0x384fffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:1b.0: [8086:293e] type 00 class =
0x040300 conventional PCI endpoint
Feb 06 08:53:45 archvm kernel: pci 0000:00:1b.0: BAR 0 [mem 0x82480000-0x82=
483fff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:1f.0: [8086:2918] type 00 class =
0x060100 conventional PCI endpoint
Feb 06 08:53:45 archvm kernel: pci 0000:00:1f.0: quirk: [io  0x0600-0x067f]=
 claimed by ICH6 ACPI/GPIO/TCO
Feb 06 08:53:45 archvm kernel: pci 0000:00:1f.2: [8086:2922] type 00 class =
0x010601 conventional PCI endpoint
Feb 06 08:53:45 archvm kernel: pci 0000:00:1f.2: BAR 4 [io  0x7040-0x705f]
Feb 06 08:53:45 archvm kernel: pci 0000:00:1f.2: BAR 5 [mem 0x82484000-0x82=
484fff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:1f.3: [8086:2930] type 00 class =
0x0c0500 conventional PCI endpoint
Feb 06 08:53:45 archvm kernel: pci 0000:00:1f.3: BAR 4 [io  0x7000-0x703f]
Feb 06 08:53:45 archvm kernel: acpiphp: Slot [0] registered
Feb 06 08:53:45 archvm kernel: pci 0000:01:00.0: [1af4:105a] type 00 class =
0x018000 PCIe Endpoint
Feb 06 08:53:45 archvm kernel: pci 0000:01:00.0: BAR 1 [mem 0x82200000-0x82=
200fff]
Feb 06 08:53:45 archvm kernel: pci 0000:01:00.0: BAR 4 [mem 0x380000000000-=
0x380000003fff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Feb 06 08:53:45 archvm kernel: acpiphp: Slot [0-2] registered
Feb 06 08:53:45 archvm kernel: pci 0000:02:00.0: [1af4:1041] type 00 class =
0x020000 PCIe Endpoint
Feb 06 08:53:45 archvm kernel: pci 0000:02:00.0: BAR 1 [mem 0x82000000-0x82=
000fff]
Feb 06 08:53:45 archvm kernel: pci 0000:02:00.0: BAR 4 [mem 0x380800000000-=
0x380800003fff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:02:00.0: ROM [mem 0xfffc0000-0xffff=
ffff pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.1: PCI bridge to [bus 02]
Feb 06 08:53:45 archvm kernel: acpiphp: Slot [0-3] registered
Feb 06 08:53:45 archvm kernel: pci 0000:03:00.0: [1b36:000d] type 00 class =
0x0c0330 PCIe Endpoint
Feb 06 08:53:45 archvm kernel: pci 0000:03:00.0: BAR 0 [mem 0x81e00000-0x81=
e03fff 64bit]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.2: PCI bridge to [bus 03]
Feb 06 08:53:45 archvm kernel: acpiphp: Slot [0-4] registered
Feb 06 08:53:45 archvm kernel: pci 0000:04:00.0: [1af4:1043] type 00 class =
0x078000 PCIe Endpoint
Feb 06 08:53:45 archvm kernel: pci 0000:04:00.0: BAR 1 [mem 0x81c00000-0x81=
c00fff]
Feb 06 08:53:45 archvm kernel: pci 0000:04:00.0: BAR 4 [mem 0x381800000000-=
0x381800003fff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.3: PCI bridge to [bus 04]
Feb 06 08:53:45 archvm kernel: acpiphp: Slot [0-5] registered
Feb 06 08:53:45 archvm kernel: pci 0000:05:00.0: [1af4:1042] type 00 class =
0x010000 PCIe Endpoint
Feb 06 08:53:45 archvm kernel: pci 0000:05:00.0: BAR 1 [mem 0x81a00000-0x81=
a00fff]
Feb 06 08:53:45 archvm kernel: pci 0000:05:00.0: BAR 4 [mem 0x382000000000-=
0x382000003fff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.4: PCI bridge to [bus 05]
Feb 06 08:53:45 archvm kernel: acpiphp: Slot [0-6] registered
Feb 06 08:53:45 archvm kernel: pci 0000:06:00.0: [1af4:1044] type 00 class =
0x00ff00 PCIe Endpoint
Feb 06 08:53:45 archvm kernel: pci 0000:06:00.0: BAR 1 [mem 0x81800000-0x81=
800fff]
Feb 06 08:53:45 archvm kernel: pci 0000:06:00.0: BAR 4 [mem 0x382800000000-=
0x382800003fff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.5: PCI bridge to [bus 06]
Feb 06 08:53:45 archvm kernel: acpiphp: Slot [0-7] registered
Feb 06 08:53:45 archvm kernel: pci 0000:07:00.0: [1af4:1052] type 00 class =
0x090000 PCIe Endpoint
Feb 06 08:53:45 archvm kernel: pci 0000:07:00.0: BAR 1 [mem 0x81600000-0x81=
600fff]
Feb 06 08:53:45 archvm kernel: pci 0000:07:00.0: BAR 4 [mem 0x383000000000-=
0x383000003fff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.6: PCI bridge to [bus 07]
Feb 06 08:53:45 archvm kernel: acpiphp: Slot [0-8] registered
Feb 06 08:53:45 archvm kernel: pci 0000:08:00.0: [1af4:1052] type 00 class =
0x090200 PCIe Endpoint
Feb 06 08:53:45 archvm kernel: pci 0000:08:00.0: BAR 1 [mem 0x81400000-0x81=
400fff]
Feb 06 08:53:45 archvm kernel: pci 0000:08:00.0: BAR 4 [mem 0x383800000000-=
0x383800003fff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.7: PCI bridge to [bus 08]
Feb 06 08:53:45 archvm kernel: acpiphp: Slot [0-9] registered
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.0: [10de:1380] type 00 class =
0x030000 PCIe Legacy Endpoint
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.0: BAR 0 [mem 0x80000000-0x80=
ffffff]
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.0: BAR 1 [mem 0x384000000000-=
0x38400fffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.0: BAR 3 [mem 0x384010000000-=
0x384011ffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.0: BAR 5 [io  0x6000-0x607f]
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.0: ROM [mem 0xfff80000-0xffff=
ffff pref]
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.0: Max Payload Size set to 12=
8 (was 256, max 256)
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.0: 16.000 Gb/s available PCIe=
 bandwidth, limited by 2.5 GT/s PCIe x8 link at 0000:00:02.0 (capable of 12=
6.016 Gb/s with 8.0 GT/s PCIe x16 link)
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.1: [10de:0fbc] type 00 class =
0x040300 PCIe Endpoint
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.1: BAR 0 [mem 0x81000000-0x81=
003fff]
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.1: Max Payload Size set to 12=
8 (was 256, max 256)
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.0: PCI bridge to [bus 09]
Feb 06 08:53:45 archvm kernel: acpiphp: Slot [0-10] registered
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.1: PCI bridge to [bus 0a]
Feb 06 08:53:45 archvm kernel: ACPI: PCI: Interrupt link LNKA configured fo=
r IRQ 10
Feb 06 08:53:45 archvm kernel: ACPI: PCI: Interrupt link LNKB configured fo=
r IRQ 10
Feb 06 08:53:45 archvm kernel: ACPI: PCI: Interrupt link LNKC configured fo=
r IRQ 11
Feb 06 08:53:45 archvm kernel: ACPI: PCI: Interrupt link LNKD configured fo=
r IRQ 11
Feb 06 08:53:45 archvm kernel: ACPI: PCI: Interrupt link LNKE configured fo=
r IRQ 10
Feb 06 08:53:45 archvm kernel: ACPI: PCI: Interrupt link LNKF configured fo=
r IRQ 10
Feb 06 08:53:45 archvm kernel: ACPI: PCI: Interrupt link LNKG configured fo=
r IRQ 11
Feb 06 08:53:45 archvm kernel: ACPI: PCI: Interrupt link LNKH configured fo=
r IRQ 11
Feb 06 08:53:45 archvm kernel: ACPI: PCI: Interrupt link GSIA configured fo=
r IRQ 16
Feb 06 08:53:45 archvm kernel: ACPI: PCI: Interrupt link GSIB configured fo=
r IRQ 17
Feb 06 08:53:45 archvm kernel: ACPI: PCI: Interrupt link GSIC configured fo=
r IRQ 18
Feb 06 08:53:45 archvm kernel: ACPI: PCI: Interrupt link GSID configured fo=
r IRQ 19
Feb 06 08:53:45 archvm kernel: ACPI: PCI: Interrupt link GSIE configured fo=
r IRQ 20
Feb 06 08:53:45 archvm kernel: ACPI: PCI: Interrupt link GSIF configured fo=
r IRQ 21
Feb 06 08:53:45 archvm kernel: ACPI: PCI: Interrupt link GSIG configured fo=
r IRQ 22
Feb 06 08:53:45 archvm kernel: ACPI: PCI: Interrupt link GSIH configured fo=
r IRQ 23
Feb 06 08:53:45 archvm kernel: iommu: Default domain type: Translated
Feb 06 08:53:45 archvm kernel: iommu: DMA domain TLB invalidation policy: l=
azy mode
Feb 06 08:53:45 archvm kernel: SCSI subsystem initialized
Feb 06 08:53:45 archvm kernel: libata version 3.00 loaded.
Feb 06 08:53:45 archvm kernel: ACPI: bus type USB registered
Feb 06 08:53:45 archvm kernel: usbcore: registered new interface driver usb=
fs
Feb 06 08:53:45 archvm kernel: usbcore: registered new interface driver hub
Feb 06 08:53:45 archvm kernel: usbcore: registered new device driver usb
Feb 06 08:53:45 archvm kernel: EDAC MC: Ver: 3.0.0
Feb 06 08:53:45 archvm kernel: efivars: Registered efivars operations
Feb 06 08:53:45 archvm kernel: NetLabel: Initializing
Feb 06 08:53:45 archvm kernel: NetLabel:  domain hash size =3D 128
Feb 06 08:53:45 archvm kernel: NetLabel:  protocols =3D UNLABELED CIPSOv4 C=
ALIPSO
Feb 06 08:53:45 archvm kernel: NetLabel:  unlabeled traffic allowed by defa=
ult
Feb 06 08:53:45 archvm kernel: mctp: management component transport protoco=
l core
Feb 06 08:53:45 archvm kernel: NET: Registered PF_MCTP protocol family
Feb 06 08:53:45 archvm kernel: PCI: Using ACPI for IRQ routing
Feb 06 08:53:45 archvm kernel: PCI: pci_cache_line_size set to 64 bytes
Feb 06 08:53:45 archvm kernel: e820: reserve RAM buffer [mem 0x0009f000-0x0=
009ffff]
Feb 06 08:53:45 archvm kernel: e820: reserve RAM buffer [mem 0x7bc09018-0x7=
bffffff]
Feb 06 08:53:45 archvm kernel: e820: reserve RAM buffer [mem 0x7bc2a018-0x7=
bffffff]
Feb 06 08:53:45 archvm kernel: e820: reserve RAM buffer [mem 0x7d16f000-0x7=
fffffff]
Feb 06 08:53:45 archvm kernel: e820: reserve RAM buffer [mem 0x7e8ec000-0x7=
fffffff]
Feb 06 08:53:45 archvm kernel: e820: reserve RAM buffer [mem 0x7ef9a000-0x7=
fffffff]
Feb 06 08:53:45 archvm kernel: e820: reserve RAM buffer [mem 0x7f000000-0x7=
fffffff]
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.0: vgaarb: setting as boot VG=
A device
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.0: vgaarb: bridge control pos=
sible
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.0: vgaarb: VGA device added: =
decodes=3Dio+mem,owns=3Dnone,locks=3Dnone
Feb 06 08:53:45 archvm kernel: vgaarb: loaded
Feb 06 08:53:45 archvm kernel: clocksource: Switched to clocksource kvm-clo=
ck
Feb 06 08:53:45 archvm kernel: VFS: Disk quotas dquot_6.6.0
Feb 06 08:53:45 archvm kernel: VFS: Dquot-cache hash table entries: 512 (or=
der 0, 4096 bytes)
Feb 06 08:53:45 archvm kernel: pnp: PnP ACPI init
Feb 06 08:53:45 archvm kernel: system 00:03: [mem 0xe0000000-0xefffffff win=
dow] has been reserved
Feb 06 08:53:45 archvm kernel: pnp: PnP ACPI: found 4 devices
Feb 06 08:53:45 archvm kernel: clocksource: acpi_pm: mask: 0xffffff max_cyc=
les: 0xffffff, max_idle_ns: 2085701024 ns
Feb 06 08:53:45 archvm kernel: NET: Registered PF_INET protocol family
Feb 06 08:53:45 archvm kernel: IP idents hash table entries: 32768 (order: =
6, 262144 bytes, linear)
Feb 06 08:53:45 archvm kernel: tcp_listen_portaddr_hash hash table entries:=
 1024 (order: 2, 16384 bytes, linear)
Feb 06 08:53:45 archvm kernel: Table-perturb hash table entries: 65536 (ord=
er: 6, 262144 bytes, linear)
Feb 06 08:53:45 archvm kernel: TCP established hash table entries: 16384 (o=
rder: 5, 131072 bytes, linear)
Feb 06 08:53:45 archvm kernel: TCP bind hash table entries: 16384 (order: 7=
, 524288 bytes, linear)
Feb 06 08:53:45 archvm kernel: TCP: Hash tables configured (established 163=
84 bind 16384)
Feb 06 08:53:45 archvm kernel: MPTCP token hash table entries: 2048 (order:=
 3, 49152 bytes, linear)
Feb 06 08:53:45 archvm kernel: UDP hash table entries: 1024 (order: 4, 6553=
6 bytes, linear)
Feb 06 08:53:45 archvm kernel: UDP-Lite hash table entries: 1024 (order: 4,=
 65536 bytes, linear)
Feb 06 08:53:45 archvm kernel: NET: Registered PF_UNIX/PF_LOCAL protocol fa=
mily
Feb 06 08:53:45 archvm kernel: NET: Registered PF_XDP protocol family
Feb 06 08:53:45 archvm kernel: pci 0000:02:00.0: ROM [mem 0xfffc0000-0xffff=
ffff pref]: can't claim; no compatible bridge window
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.0: ROM [mem 0xfff80000-0xffff=
ffff pref]: can't claim; no compatible bridge window
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.0: bridge window [io  0x1000-=
0x0fff] to [bus 01] add_size 1000
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.1: bridge window [io  0x1000-=
0x0fff] to [bus 02] add_size 1000
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.2: bridge window [io  0x1000-=
0x0fff] to [bus 03] add_size 1000
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.3: bridge window [io  0x1000-=
0x0fff] to [bus 04] add_size 1000
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.4: bridge window [io  0x1000-=
0x0fff] to [bus 05] add_size 1000
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.5: bridge window [io  0x1000-=
0x0fff] to [bus 06] add_size 1000
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.6: bridge window [io  0x1000-=
0x0fff] to [bus 07] add_size 1000
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.7: bridge window [io  0x1000-=
0x0fff] to [bus 08] add_size 1000
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.1: bridge window [io  0x1000-=
0x0fff] to [bus 0a] add_size 1000
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.0: bridge window [io  0x1000-=
0x1fff]: assigned
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.1: bridge window [io  0x2000-=
0x2fff]: assigned
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.2: bridge window [io  0x3000-=
0x3fff]: assigned
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.3: bridge window [io  0x4000-=
0x4fff]: assigned
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.4: bridge window [io  0x5000-=
0x5fff]: assigned
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.5: bridge window [io  0x8000-=
0x8fff]: assigned
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.6: bridge window [io  0x9000-=
0x9fff]: assigned
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.7: bridge window [io  0xa000-=
0xafff]: assigned
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.1: bridge window [io  0xb000-=
0xbfff]: assigned
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.0:   bridge window [io  0x100=
0-0x1fff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.0:   bridge window [mem 0x822=
00000-0x823fffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.0:   bridge window [mem 0x380=
000000000-0x3807ffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:02:00.0: ROM [mem 0x82040000-0x8207=
ffff pref]: assigned
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.1: PCI bridge to [bus 02]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.1:   bridge window [io  0x200=
0-0x2fff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.1:   bridge window [mem 0x820=
00000-0x821fffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.1:   bridge window [mem 0x380=
800000000-0x380fffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.2: PCI bridge to [bus 03]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.2:   bridge window [io  0x300=
0-0x3fff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.2:   bridge window [mem 0x81e=
00000-0x81ffffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.2:   bridge window [mem 0x381=
000000000-0x3817ffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.3: PCI bridge to [bus 04]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.3:   bridge window [io  0x400=
0-0x4fff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.3:   bridge window [mem 0x81c=
00000-0x81dfffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.3:   bridge window [mem 0x381=
800000000-0x381fffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.4: PCI bridge to [bus 05]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.4:   bridge window [io  0x500=
0-0x5fff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.4:   bridge window [mem 0x81a=
00000-0x81bfffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.4:   bridge window [mem 0x382=
000000000-0x3827ffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.5: PCI bridge to [bus 06]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.5:   bridge window [io  0x800=
0-0x8fff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.5:   bridge window [mem 0x818=
00000-0x819fffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.5:   bridge window [mem 0x382=
800000000-0x382fffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.6: PCI bridge to [bus 07]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.6:   bridge window [io  0x900=
0-0x9fff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.6:   bridge window [mem 0x816=
00000-0x817fffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.6:   bridge window [mem 0x383=
000000000-0x3837ffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.7: PCI bridge to [bus 08]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.7:   bridge window [io  0xa00=
0-0xafff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.7:   bridge window [mem 0x814=
00000-0x815fffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:01.7:   bridge window [mem 0x383=
800000000-0x383fffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.0: ROM [mem 0x81080000-0x810f=
ffff pref]: assigned
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.0: PCI bridge to [bus 09]
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.0:   bridge window [io  0x600=
0-0x6fff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.0:   bridge window [mem 0x800=
00000-0x810fffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.0:   bridge window [mem 0x384=
000000000-0x3847ffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.1: PCI bridge to [bus 0a]
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.1:   bridge window [io  0xb00=
0-0xbfff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.1:   bridge window [mem 0x812=
00000-0x813fffff]
Feb 06 08:53:45 archvm kernel: pci 0000:00:02.1:   bridge window [mem 0x384=
800000000-0x384fffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x0c=
f7 window]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:00: resource 5 [io  0x0d00-0xff=
ff window]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:00: resource 6 [mem 0x000a0000-=
0x000bffff window]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:00: resource 7 [mem 0x80000000-=
0xdfffffff window]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:00: resource 8 [mem 0xf0000000-=
0xfebfffff window]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:00: resource 9 [mem 0x380000000=
000-0x384fffffffff window]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:01: resource 0 [io  0x1000-0x1f=
ff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:01: resource 1 [mem 0x82200000-=
0x823fffff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:01: resource 2 [mem 0x380000000=
000-0x3807ffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:02: resource 0 [io  0x2000-0x2f=
ff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:02: resource 1 [mem 0x82000000-=
0x821fffff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:02: resource 2 [mem 0x380800000=
000-0x380fffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:03: resource 0 [io  0x3000-0x3f=
ff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:03: resource 1 [mem 0x81e00000-=
0x81ffffff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:03: resource 2 [mem 0x381000000=
000-0x3817ffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:04: resource 0 [io  0x4000-0x4f=
ff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:04: resource 1 [mem 0x81c00000-=
0x81dfffff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:04: resource 2 [mem 0x381800000=
000-0x381fffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:05: resource 0 [io  0x5000-0x5f=
ff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:05: resource 1 [mem 0x81a00000-=
0x81bfffff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:05: resource 2 [mem 0x382000000=
000-0x3827ffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:06: resource 0 [io  0x8000-0x8f=
ff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:06: resource 1 [mem 0x81800000-=
0x819fffff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:06: resource 2 [mem 0x382800000=
000-0x382fffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:07: resource 0 [io  0x9000-0x9f=
ff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:07: resource 1 [mem 0x81600000-=
0x817fffff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:07: resource 2 [mem 0x383000000=
000-0x3837ffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:08: resource 0 [io  0xa000-0xaf=
ff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:08: resource 1 [mem 0x81400000-=
0x815fffff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:08: resource 2 [mem 0x383800000=
000-0x383fffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:09: resource 0 [io  0x6000-0x6f=
ff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:09: resource 1 [mem 0x80000000-=
0x810fffff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:09: resource 2 [mem 0x384000000=
000-0x3847ffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:0a: resource 0 [io  0xb000-0xbf=
ff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:0a: resource 1 [mem 0x81200000-=
0x813fffff]
Feb 06 08:53:45 archvm kernel: pci_bus 0000:0a: resource 2 [mem 0x384800000=
000-0x384fffffffff 64bit pref]
Feb 06 08:53:45 archvm kernel: ACPI: \_SB_.GSIF: Enabled at IRQ 21
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.1: extending delay after powe=
r-on from D3hot to 20 msec
Feb 06 08:53:45 archvm kernel: pci 0000:09:00.1: D0 power state depends on =
0000:09:00.0
Feb 06 08:53:45 archvm kernel: PCI: CLS 64 bytes, default 64
Feb 06 08:53:45 archvm kernel: clocksource: tsc: mask: 0xffffffffffffffff m=
ax_cycles: 0x6aaaebaad24, max_idle_ns: 881591041906 ns
Feb 06 08:53:45 archvm kernel: clocksource: Switched to clocksource tsc
Feb 06 08:53:45 archvm kernel: Trying to unpack rootfs image as initramfs...
Feb 06 08:53:45 archvm kernel: Initialise system trusted keyrings
Feb 06 08:53:45 archvm kernel: Key type blacklist registered
Feb 06 08:53:45 archvm kernel: workingset: timestamp_bits=3D36 max_order=3D=
19 bucket_order=3D0
Feb 06 08:53:45 archvm kernel: fuse: init (API version 7.42)
Feb 06 08:53:45 archvm kernel: integrity: Platform Keyring initialized
Feb 06 08:53:45 archvm kernel: integrity: Machine keyring initialized
Feb 06 08:53:45 archvm kernel: Key type asymmetric registered
Feb 06 08:53:45 archvm kernel: Asymmetric key parser 'x509' registered
Feb 06 08:53:45 archvm kernel: Block layer SCSI generic (bsg) driver versio=
n 0.4 loaded (major 246)
Feb 06 08:53:45 archvm kernel: io scheduler mq-deadline registered
Feb 06 08:53:45 archvm kernel: io scheduler kyber registered
Feb 06 08:53:45 archvm kernel: io scheduler bfq registered
Feb 06 08:53:45 archvm kernel: ledtrig-cpu: registered to indicate activity=
 on CPUs
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:01.0: PME: Signaling with I=
RQ 24
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:01.0: AER: enabled with IRQ=
 24
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:01.1: PME: Signaling with I=
RQ 25
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:01.1: AER: enabled with IRQ=
 25
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:01.2: PME: Signaling with I=
RQ 26
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:01.2: AER: enabled with IRQ=
 26
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:01.3: PME: Signaling with I=
RQ 27
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:01.3: AER: enabled with IRQ=
 27
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:01.4: PME: Signaling with I=
RQ 28
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:01.4: AER: enabled with IRQ=
 28
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:01.5: PME: Signaling with I=
RQ 29
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:01.5: AER: enabled with IRQ=
 29
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:01.6: PME: Signaling with I=
RQ 30
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:01.6: AER: enabled with IRQ=
 30
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:01.7: PME: Signaling with I=
RQ 31
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:01.7: AER: enabled with IRQ=
 31
Feb 06 08:53:45 archvm kernel: ACPI: \_SB_.GSIG: Enabled at IRQ 22
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:02.0: PME: Signaling with I=
RQ 32
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:02.0: AER: enabled with IRQ=
 32
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:02.1: PME: Signaling with I=
RQ 33
Feb 06 08:53:45 archvm kernel: pcieport 0000:00:02.1: AER: enabled with IRQ=
 33
Feb 06 08:53:45 archvm kernel: shpchp: Standard Hot Plug PCI Controller Dri=
ver version: 0.4
Feb 06 08:53:45 archvm kernel: input: Power Button as /devices/LNXSYSTM:00/=
LNXPWRBN:00/input/input0
Feb 06 08:53:45 archvm kernel: ACPI: button: Power Button [PWRF]
Feb 06 08:53:45 archvm kernel: virtiofs virtio0: discovered new tag: host
Feb 06 08:53:45 archvm kernel: virtiofs virtio0: virtio_fs_setup_dax: No ca=
che capability
Feb 06 08:53:45 archvm kernel: Serial: 8250/16550 driver, 32 ports, IRQ sha=
ring enabled
Feb 06 08:53:45 archvm kernel: Non-volatile memory driver v1.3
Feb 06 08:53:45 archvm kernel: Linux agpgart interface v0.103
Feb 06 08:53:45 archvm kernel: ACPI: bus type drm_connector registered
Feb 06 08:53:45 archvm kernel: Freeing initrd memory: 10656K
Feb 06 08:53:45 archvm kernel: ahci 0000:00:1f.2: version 3.0
Feb 06 08:53:45 archvm kernel: ACPI: \_SB_.GSIA: Enabled at IRQ 16
Feb 06 08:53:45 archvm kernel: ahci 0000:00:1f.2: AHCI vers 0001.0000, 32 c=
ommand slots, 1.5 Gbps, SATA mode
Feb 06 08:53:45 archvm kernel: ahci 0000:00:1f.2: 6/6 ports implemented (po=
rt mask 0x3f)
Feb 06 08:53:45 archvm kernel: ahci 0000:00:1f.2: flags: 64bit ncq only
Feb 06 08:53:45 archvm kernel: scsi host0: ahci
Feb 06 08:53:45 archvm kernel: scsi host1: ahci
Feb 06 08:53:45 archvm kernel: scsi host2: ahci
Feb 06 08:53:45 archvm kernel: scsi host3: ahci
Feb 06 08:53:45 archvm kernel: scsi host4: ahci
Feb 06 08:53:45 archvm kernel: scsi host5: ahci
Feb 06 08:53:45 archvm kernel: ata1: SATA max UDMA/133 abar m4096@0x8248400=
0 port 0x82484100 irq 37 lpm-pol 0
Feb 06 08:53:45 archvm kernel: ata2: SATA max UDMA/133 abar m4096@0x8248400=
0 port 0x82484180 irq 37 lpm-pol 0
Feb 06 08:53:45 archvm kernel: ata3: SATA max UDMA/133 abar m4096@0x8248400=
0 port 0x82484200 irq 37 lpm-pol 0
Feb 06 08:53:45 archvm kernel: ata4: SATA max UDMA/133 abar m4096@0x8248400=
0 port 0x82484280 irq 37 lpm-pol 0
Feb 06 08:53:45 archvm kernel: ata5: SATA max UDMA/133 abar m4096@0x8248400=
0 port 0x82484300 irq 37 lpm-pol 0
Feb 06 08:53:45 archvm kernel: ata6: SATA max UDMA/133 abar m4096@0x8248400=
0 port 0x82484380 irq 37 lpm-pol 0
Feb 06 08:53:45 archvm kernel: xhci_hcd 0000:03:00.0: xHCI Host Controller
Feb 06 08:53:45 archvm kernel: xhci_hcd 0000:03:00.0: new USB bus registere=
d, assigned bus number 1
Feb 06 08:53:45 archvm kernel: xhci_hcd 0000:03:00.0: hcc params 0x00087001=
 hci version 0x100 quirks 0x0000000000000010
Feb 06 08:53:45 archvm kernel: xhci_hcd 0000:03:00.0: xHCI Host Controller
Feb 06 08:53:45 archvm kernel: xhci_hcd 0000:03:00.0: new USB bus registere=
d, assigned bus number 2
Feb 06 08:53:45 archvm kernel: xhci_hcd 0000:03:00.0: Host supports USB 3.0=
 SuperSpeed
Feb 06 08:53:45 archvm kernel: usb usb1: New USB device found, idVendor=3D1=
d6b, idProduct=3D0002, bcdDevice=3D 6.14
Feb 06 08:53:45 archvm kernel: usb usb1: New USB device strings: Mfr=3D3, P=
roduct=3D2, SerialNumber=3D1
Feb 06 08:53:45 archvm kernel: usb usb1: Product: xHCI Host Controller
Feb 06 08:53:45 archvm kernel: usb usb1: Manufacturer: Linux 6.14.0-rc1-1-m=
ainline xhci-hcd
Feb 06 08:53:45 archvm kernel: usb usb1: SerialNumber: 0000:03:00.0
Feb 06 08:53:45 archvm kernel: hub 1-0:1.0: USB hub found
Feb 06 08:53:45 archvm kernel: hub 1-0:1.0: 15 ports detected
Feb 06 08:53:45 archvm kernel: usb usb2: We don't know the algorithms for L=
PM for this host, disabling LPM.
Feb 06 08:53:45 archvm kernel: usb usb2: New USB device found, idVendor=3D1=
d6b, idProduct=3D0003, bcdDevice=3D 6.14
Feb 06 08:53:45 archvm kernel: usb usb2: New USB device strings: Mfr=3D3, P=
roduct=3D2, SerialNumber=3D1
Feb 06 08:53:45 archvm kernel: usb usb2: Product: xHCI Host Controller
Feb 06 08:53:45 archvm kernel: usb usb2: Manufacturer: Linux 6.14.0-rc1-1-m=
ainline xhci-hcd
Feb 06 08:53:45 archvm kernel: usb usb2: SerialNumber: 0000:03:00.0
Feb 06 08:53:45 archvm kernel: hub 2-0:1.0: USB hub found
Feb 06 08:53:45 archvm kernel: hub 2-0:1.0: 15 ports detected
Feb 06 08:53:45 archvm kernel: usbcore: registered new interface driver usb=
serial_generic
Feb 06 08:53:45 archvm kernel: usbserial: USB Serial support registered for=
 generic
Feb 06 08:53:45 archvm kernel: rtc_cmos 00:02: RTC can wake from S4
Feb 06 08:53:45 archvm kernel: rtc_cmos 00:02: registered as rtc0
Feb 06 08:53:45 archvm kernel: rtc_cmos 00:02: setting system clock to 2025=
-02-05T21:53:42 UTC (1738792422)
Feb 06 08:53:45 archvm kernel: rtc_cmos 00:02: alarms up to one day, y3k, 2=
42 bytes nvram
Feb 06 08:53:45 archvm kernel: simple-framebuffer simple-framebuffer.0: [dr=
m] Registered 1 planes with drm panic
Feb 06 08:53:45 archvm kernel: [drm] Initialized simpledrm 1.0.0 for simple=
-framebuffer.0 on minor 0
Feb 06 08:53:45 archvm kernel: fbcon: Deferring console take-over
Feb 06 08:53:45 archvm kernel: simple-framebuffer simple-framebuffer.0: [dr=
m] fb0: simpledrmdrmfb frame buffer device
Feb 06 08:53:45 archvm kernel: hid: raw HID events driver (C) Jiri Kosina
Feb 06 08:53:45 archvm kernel: drop_monitor: Initializing network drop moni=
tor service
Feb 06 08:53:45 archvm kernel: NET: Registered PF_INET6 protocol family
Feb 06 08:53:45 archvm kernel: Segment Routing with IPv6
Feb 06 08:53:45 archvm kernel: RPL Segment Routing with IPv6
Feb 06 08:53:45 archvm kernel: In-situ OAM (IOAM) with IPv6
Feb 06 08:53:45 archvm kernel: NET: Registered PF_PACKET protocol family
Feb 06 08:53:45 archvm kernel: IPI shorthand broadcast: enabled
Feb 06 08:53:45 archvm kernel: sched_clock: Marking stable (881003097, 1295=
698)->(922058577, -39759782)
Feb 06 08:53:45 archvm kernel: registered taskstats version 1
Feb 06 08:53:45 archvm kernel: Loading compiled-in X.509 certificates
Feb 06 08:53:45 archvm kernel: Loaded X.509 cert 'Build time autogenerated =
kernel key: d6666ab7e7b98485ae8647dd9e2d15e353fd1113'
Feb 06 08:53:45 archvm kernel: Demotion targets for Node 0: null
Feb 06 08:53:45 archvm kernel: Key type .fscrypt registered
Feb 06 08:53:45 archvm kernel: Key type fscrypt-provisioning registered
Feb 06 08:53:45 archvm kernel: PM:   Magic number: 13:916:903
Feb 06 08:53:45 archvm kernel: usb usb2-port4: hash matches
Feb 06 08:53:45 archvm kernel: RAS: Correctable Errors collector initialize=
d.
Feb 06 08:53:45 archvm kernel: clk: Disabling unused clocks
Feb 06 08:53:45 archvm kernel: PM: genpd: Disabling unused power domains
Feb 06 08:53:45 archvm kernel: ata1: SATA link down (SStatus 0 SControl 300)
Feb 06 08:53:45 archvm kernel: ata3: SATA link down (SStatus 0 SControl 300)
Feb 06 08:53:45 archvm kernel: ata5: SATA link down (SStatus 0 SControl 300)
Feb 06 08:53:45 archvm kernel: ata2: SATA link down (SStatus 0 SControl 300)
Feb 06 08:53:45 archvm kernel: ata6: SATA link down (SStatus 0 SControl 300)
Feb 06 08:53:45 archvm kernel: ata4: SATA link down (SStatus 0 SControl 300)
Feb 06 08:53:45 archvm kernel: Freeing unused decrypted memory: 2028K
Feb 06 08:53:45 archvm kernel: Freeing unused kernel image (initmem) memory=
: 4308K
Feb 06 08:53:45 archvm kernel: Write protecting the kernel read-only data: =
34816k
Feb 06 08:53:45 archvm kernel: Freeing unused kernel image (text/rodata gap=
) memory: 1064K
Feb 06 08:53:45 archvm kernel: Freeing unused kernel image (rodata/data gap=
) memory: 1884K
Feb 06 08:53:45 archvm kernel: x86/mm: Checked W+X mappings: passed, no W+X=
 pages found.
Feb 06 08:53:45 archvm kernel: rodata_test: all tests were successful
Feb 06 08:53:45 archvm kernel: Run /init as init process
Feb 06 08:53:45 archvm kernel:   with arguments:
Feb 06 08:53:45 archvm kernel:     /init
Feb 06 08:53:45 archvm kernel:   with environment:
Feb 06 08:53:45 archvm kernel:     HOME=3D/
Feb 06 08:53:45 archvm kernel:     TERM=3Dlinux
Feb 06 08:53:45 archvm kernel: fbcon: Taking over console
Feb 06 08:53:45 archvm kernel: Console: switching to colour frame buffer de=
vice 160x50
Feb 06 08:53:45 archvm kernel: i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP=
0f13:MOU] at 0x60,0x64 irq 1,12
Feb 06 08:53:45 archvm kernel: virtio_blk virtio3: 8/0/0 default/read/poll =
queues
Feb 06 08:53:45 archvm kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb 06 08:53:45 archvm kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb 06 08:53:45 archvm kernel: virtio_blk virtio3: [vda] 62914560 512-byte =
logical blocks (32.2 GB/30.0 GiB)
Feb 06 08:53:45 archvm kernel: input: QEMU Virtio Keyboard as /devices/pci0=
000:00/0000:00:01.6/0000:07:00.0/virtio5/input/input1
Feb 06 08:53:45 archvm kernel:  vda: vda1 vda2
Feb 06 08:53:45 archvm kernel: input: AT Translated Set 2 keyboard as /devi=
ces/platform/i8042/serio0/input/input2
Feb 06 08:53:45 archvm kernel: input: QEMU Virtio Mouse as /devices/pci0000=
:00/0000:00:01.7/0000:08:00.0/virtio6/input/input3
Feb 06 08:53:45 archvm kernel: nouveau 0000:09:00.0: NVIDIA GM107 (117000a2)
Feb 06 08:53:45 archvm kernel: nouveau 0000:09:00.0: bios: version 82.07.32=
=2E00.6d
Feb 06 08:53:45 archvm kernel: Console: switching to colour dummy device 80=
x25
Feb 06 08:53:45 archvm kernel: nouveau 0000:09:00.0: vgaarb: deactivate vga=
 console
Feb 06 08:53:45 archvm kernel: nouveau 0000:09:00.0: fb: 2048 MiB GDDR5
Feb 06 08:53:45 archvm kernel: nouveau 0000:09:00.0: bus: MMIO read of 0000=
0000 FAULT at 3e6684 [ PRIVRING ]
Feb 06 08:53:45 archvm kernel: nouveau 0000:09:00.0: drm: VRAM: 2048 MiB
Feb 06 08:53:45 archvm kernel: nouveau 0000:09:00.0: drm: GART: 1048576 MiB
Feb 06 08:53:45 archvm kernel: nouveau 0000:09:00.0: drm: TMDS table versio=
n 2.0
Feb 06 08:53:45 archvm kernel: nouveau 0000:09:00.0: drm: MM: using COPY fo=
r buffer copies
Feb 06 08:53:45 archvm kernel: nouveau 0000:09:00.0: [drm] Registered 4 pla=
nes with drm panic
Feb 06 08:53:45 archvm kernel: [drm] Initialized nouveau 1.4.0 for 0000:09:=
00.0 on minor 0
Feb 06 08:53:45 archvm kernel: fbcon: nouveaudrmfb (fb0) is primary device
Feb 06 08:53:45 archvm kernel: Console: switching to colour frame buffer de=
vice 240x67
Feb 06 08:53:45 archvm kernel: nouveau 0000:09:00.0: [drm] fb0: nouveaudrmf=
b frame buffer device
Feb 06 08:53:45 archvm kernel: EXT4-fs (vda2): mounted filesystem 52298256-=
d09b-4e26-86ee-d93193a072ad r/w with ordered data mode. Quota mode: none.
Feb 06 08:53:45 archvm systemd[1]: systemd 257.2-2-arch running in system m=
ode (+PAM +AUDIT -SELINUX -APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUT=
LS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBC=
RYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENC=
ODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP =
-SYSVINIT +LIBARCHIVE)
Feb 06 08:53:45 archvm systemd[1]: Detected virtualization kvm.
Feb 06 08:53:45 archvm systemd[1]: Detected architecture x86-64.
Feb 06 08:53:45 archvm systemd[1]: Hostname set to .
Feb 06 08:53:45 archvm systemd[1]: bpf-restrict-fs: LSM BPF program attached
Feb 06 08:53:45 archvm kernel: Guest personality initialized and is inactive
Feb 06 08:53:45 archvm kernel: VMCI host device registered (name=3Dvmci, ma=
jor=3D10, minor=3D123)
Feb 06 08:53:45 archvm kernel: Initialized host personality
Feb 06 08:53:45 archvm kernel: NET: Registered PF_VSOCK protocol family
Feb 06 08:53:45 archvm systemd[1]: Queued start job for default target Grap=
hical Interface.
Feb 06 08:53:45 archvm systemd[1]: Created slice Slice /system/dirmngr.
Feb 06 08:53:45 archvm systemd[1]: Created slice Slice /system/getty.
Feb 06 08:53:45 archvm systemd[1]: Created slice Slice /system/gpg-agent.
Feb 06 08:53:45 archvm systemd[1]: Created slice Slice /system/gpg-agent-br=
owser.
Feb 06 08:53:45 archvm systemd[1]: Created slice Slice /system/gpg-agent-ex=
tra.
Feb 06 08:53:45 archvm systemd[1]: Created slice Slice /system/gpg-agent-ss=
h.
Feb 06 08:53:45 archvm systemd[1]: Created slice Slice /system/keyboxd.
Feb 06 08:53:45 archvm systemd[1]: Created slice Slice /system/modprobe.
Feb 06 08:53:45 archvm systemd[1]: Created slice User and Session Slice.
Feb 06 08:53:45 archvm systemd[1]: Started Dispatch Password Requests to Co=
nsole Directory Watch.
Feb 06 08:53:45 archvm systemd[1]: Started Forward Password Requests to Wal=
l Directory Watch.
Feb 06 08:53:45 archvm systemd[1]: Set up automount Arbitrary Executable Fi=
le Formats File System Automount Point.
Feb 06 08:53:45 archvm systemd[1]: Reached target Local Encrypted Volumes.
Feb 06 08:53:45 archvm systemd[1]: Reached target Login Prompts.
Feb 06 08:53:45 archvm systemd[1]: Reached target Local Integrity Protected=
 Volumes.
Feb 06 08:53:45 archvm systemd[1]: Reached target Path Units.
Feb 06 08:53:45 archvm systemd[1]: Reached target Remote Encrypted Volumes.
Feb 06 08:53:45 archvm systemd[1]: Reached target Remote File Systems.
Feb 06 08:53:45 archvm systemd[1]: Reached target Slice Units.
Feb 06 08:53:45 archvm systemd[1]: Reached target Local Verity Protected Vo=
lumes.
Feb 06 08:53:45 archvm systemd[1]: Listening on Device-mapper event daemon =
FIFOs.
Feb 06 08:53:45 archvm systemd[1]: Listening on Process Core Dump Socket.
Feb 06 08:53:45 archvm systemd[1]: Listening on Credential Encryption/Decry=
ption.
Feb 06 08:53:45 archvm systemd[1]: Listening on Journal Audit Socket.
Feb 06 08:53:45 archvm systemd[1]: Listening on Journal Socket (/dev/log).
Feb 06 08:53:45 archvm systemd[1]: Listening on Journal Sockets.
Feb 06 08:53:45 archvm systemd[1]: Listening on DDI File System Mounter Soc=
ket.
Feb 06 08:53:45 archvm systemd[1]: Listening on Namespace Resource Manager =
Socket.
Feb 06 08:53:45 archvm systemd[1]: TPM PCR Measurements was skipped because=
 of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
Feb 06 08:53:45 archvm systemd[1]: Make TPM PCR Policy was skipped because =
of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
Feb 06 08:53:45 archvm systemd[1]: Listening on udev Control Socket.
Feb 06 08:53:45 archvm systemd[1]: Listening on udev Kernel Socket.
Feb 06 08:53:45 archvm systemd[1]: Listening on User Database Manager Socke=
t.
Feb 06 08:53:45 archvm systemd[1]: Mounting Huge Pages File System...
Feb 06 08:53:45 archvm systemd[1]: Mounting POSIX Message Queue File System=
=2E..
Feb 06 08:53:45 archvm systemd[1]: Mounting Kernel Debug File System...
Feb 06 08:53:45 archvm systemd[1]: Mounting Kernel Trace File System...
Feb 06 08:53:45 archvm systemd[1]: Starting Create List of Static Device No=
des...
Feb 06 08:53:45 archvm systemd[1]: Starting Load Kernel Module configfs...
Feb 06 08:53:45 archvm systemd[1]: Starting Load Kernel Module dm_mod...
Feb 06 08:53:45 archvm systemd[1]: Starting Load Kernel Module drm...
Feb 06 08:53:45 archvm systemd[1]: Starting Load Kernel Module efi_pstore...
Feb 06 08:53:45 archvm systemd[1]: Starting Load Kernel Module fuse...
Feb 06 08:53:45 archvm systemd[1]: Starting Load Kernel Module loop...
Feb 06 08:53:45 archvm systemd[1]: Clear Stale Hibernate Storage Info was s=
kipped because of an unmet condition check (ConditionPathExists=3D/sys/firm=
ware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
Feb 06 08:53:45 archvm systemd[1]: Starting Journal Service...
Feb 06 08:53:45 archvm kernel: device-mapper: uevent: version 1.0.3
Feb 06 08:53:45 archvm kernel: device-mapper: ioctl: 4.49.0-ioctl (2025-01-=
17) initialised: dm-devel@lists.linux.dev
Feb 06 08:53:45 archvm kernel: loop: module loaded
Feb 06 08:53:45 archvm systemd[1]: Starting Load Kernel Modules...
Feb 06 08:53:45 archvm systemd[1]: TPM PCR Machine ID Measurement was skipp=
ed because of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
Feb 06 08:53:45 archvm systemd[1]: Starting Remount Root and Kernel File Sy=
stems...
Feb 06 08:53:45 archvm systemd[1]: Early TPM SRK Setup was skipped because =
of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
Feb 06 08:53:45 archvm systemd[1]: Starting Load udev Rules from Credential=
s...
Feb 06 08:53:45 archvm systemd[1]: Starting Coldplug All udev Devices...
Feb 06 08:53:45 archvm systemd[1]: Mounted Huge Pages File System.
Feb 06 08:53:45 archvm systemd[1]: Mounted POSIX Message Queue File System.
Feb 06 08:53:45 archvm systemd[1]: Mounted Kernel Debug File System.
Feb 06 08:53:45 archvm systemd[1]: Mounted Kernel Trace File System.
Feb 06 08:53:45 archvm systemd[1]: Finished Create List of Static Device No=
des.
Feb 06 08:53:45 archvm systemd[1]: modprobe@configfs.service: Deactivated s=
uccessfully.
Feb 06 08:53:45 archvm systemd[1]: Finished Load Kernel Module configfs.
Feb 06 08:53:45 archvm systemd[1]: modprobe@dm_mod.service: Deactivated suc=
cessfully.
Feb 06 08:53:45 archvm systemd[1]: Finished Load Kernel Module dm_mod.
Feb 06 08:53:45 archvm systemd-journald[314]: Collecting audit messages is =
enabled.
Feb 06 08:53:45 archvm kernel: audit: type=3D1130 audit(1738792425.612:2): =
pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@d=
m_mod comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm kernel: audit: type=3D1131 audit(1738792425.612:3): =
pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@d=
m_mod comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm systemd[1]: modprobe@drm.service: Deactivated succes=
sfully.
Feb 06 08:53:45 archvm systemd[1]: Finished Load Kernel Module drm.
Feb 06 08:53:45 archvm kernel: audit: type=3D1130 audit(1738792425.613:4): =
pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@d=
rm comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? =
terminal=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm kernel: audit: type=3D1131 audit(1738792425.613:5): =
pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@d=
rm comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? =
terminal=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm systemd[1]: modprobe@efi_pstore.service: Deactivated=
 successfully.
Feb 06 08:53:45 archvm systemd[1]: Finished Load Kernel Module efi_pstore.
Feb 06 08:53:45 archvm kernel: audit: type=3D1130 audit(1738792425.615:6): =
pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@e=
fi_pstore comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm kernel: audit: type=3D1131 audit(1738792425.615:7): =
pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@e=
fi_pstore comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm systemd[1]: modprobe@fuse.service: Deactivated succe=
ssfully.
Feb 06 08:53:45 archvm systemd[1]: Finished Load Kernel Module fuse.
Feb 06 08:53:45 archvm kernel: audit: type=3D1130 audit(1738792425.616:8): =
pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@f=
use comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=
 terminal=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm kernel: audit: type=3D1131 audit(1738792425.616:9): =
pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@f=
use comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?=
 terminal=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm systemd[1]: modprobe@loop.service: Deactivated succe=
ssfully.
Feb 06 08:53:45 archvm systemd[1]: Finished Load Kernel Module loop.
Feb 06 08:53:45 archvm kernel: audit: type=3D1130 audit(1738792425.617:10):=
 pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@=
loop comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D=
? terminal=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm systemd[1]: Finished Remount Root and Kernel File Sy=
stems.
Feb 06 08:53:45 archvm systemd[1]: Finished Load udev Rules from Credential=
s.
Feb 06 08:53:45 archvm systemd[1]: Activating swap /swap/swapfile...
Feb 06 08:53:45 archvm systemd[1]: Mounting FUSE Control File System...
Feb 06 08:53:45 archvm systemd[1]: Mounting Kernel Configuration File Syste=
m...
Feb 06 08:53:45 archvm systemd[1]: Rebuild Hardware Database was skipped be=
cause no trigger condition checks were met.
Feb 06 08:53:45 archvm systemd[1]: Platform Persistent Storage Archival was=
 skipped because of an unmet condition check (ConditionDirectoryNotEmpty=3D=
/sys/fs/pstore).
Feb 06 08:53:45 archvm systemd[1]: Starting Load/Save OS Random Seed...
Feb 06 08:53:45 archvm systemd[1]: Repartition Root Disk was skipped becaus=
e no trigger condition checks were met.
Feb 06 08:53:45 archvm systemd[1]: Starting Create Static Device Nodes in /=
dev gracefully...
Feb 06 08:53:45 archvm systemd[1]: TPM SRK Setup was skipped because of an =
unmet condition check (ConditionSecurity=3Dmeasured-uki).
Feb 06 08:53:45 archvm systemd[1]: Finished Load Kernel Modules.
Feb 06 08:53:45 archvm kernel: Adding 524284k swap on /swap/swapfile.  Prio=
rity:-2 extents:3 across:548860k
Feb 06 08:53:45 archvm systemd[1]: Activated swap /swap/swapfile.
Feb 06 08:53:45 archvm systemd[1]: Mounted FUSE Control File System.
Feb 06 08:53:45 archvm systemd[1]: Mounted Kernel Configuration File System.
Feb 06 08:53:45 archvm systemd[1]: Reached target Swaps.
Feb 06 08:53:45 archvm systemd[1]: Mounting Temporary Directory /tmp...
Feb 06 08:53:45 archvm systemd[1]: Starting Apply Kernel Variables...
Feb 06 08:53:45 archvm systemd[1]: Finished Load/Save OS Random Seed.
Feb 06 08:53:45 archvm systemd[1]: Starting Namespace Resource Manager...
Feb 06 08:53:45 archvm systemd[1]: Starting User Database Manager...
Feb 06 08:53:45 archvm systemd[1]: Mounted Temporary Directory /tmp.
Feb 06 08:53:45 archvm systemd-journald[314]: Journal started
Feb 06 08:53:45 archvm systemd-journald[314]: Runtime Journal (/run/log/jou=
rnal/8f1b161d188e41219ae9cfb088b4379d) is 8M, max 97.3M, 89.3M free.
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@dm_mod comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
Feb 06 08:53:45 archvm audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@dm_mod comm=3D"systemd" exe=3D=
"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@drm comm=3D"systemd" exe=3D"/=
usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@drm comm=3D"systemd" exe=3D"/u=
sr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@efi_pstore comm=3D"systemd" e=
xe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsu=
ccess'
Feb 06 08:53:45 archvm audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@efi_pstore comm=3D"systemd" ex=
e=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuc=
cess'
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@fuse comm=3D"systemd" exe=3D"=
/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@fuse comm=3D"systemd" exe=3D"/=
usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@loop comm=3D"systemd" exe=3D"=
/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@loop comm=3D"systemd" exe=3D"/=
usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-remount-fs comm=3D"systemd" ex=
e=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuc=
cess'
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-udev-load-credentials comm=3D"=
systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D=
? res=3Dsuccess'
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-modules-load comm=3D"systemd" =
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-random-seed comm=3D"systemd" e=
xe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsu=
ccess'
Feb 06 08:53:45 archvm audit: BPF prog-id=3D25 op=3DLOAD
Feb 06 08:53:45 archvm audit: BPF prog-id=3D26 op=3DLOAD
Feb 06 08:53:45 archvm audit: BPF prog-id=3D27 op=3DLOAD
Feb 06 08:53:45 archvm audit: BPF prog-id=3D28 op=3DLOAD
Feb 06 08:53:45 archvm audit: BPF prog-id=3D29 op=3DLOAD
Feb 06 08:53:45 archvm audit: BPF prog-id=3D30 op=3DLOAD
Feb 06 08:53:45 archvm systemd-modules-load[315]: Inserted module 'crypto_u=
ser'
Feb 06 08:53:45 archvm systemd[1]: Finished Apply Kernel Variables.
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-sysctl comm=3D"systemd" exe=3D=
"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm systemd[1]: Started Journal Service.
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-journald comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
Feb 06 08:53:45 archvm systemd[1]: Starting Flush Journal to Persistent Sto=
rage...
Feb 06 08:53:45 archvm audit: BPF prog-id=3D31 op=3DLOAD
Feb 06 08:53:45 archvm audit[331]: SYSCALL arch=3Dc000003e syscall=3D321 su=
ccess=3Dyes exit=3D13 a0=3D5 a1=3D7ffebd1b7bb0 a2=3D94 a3=3D1000 items=3D0 =
ppid=3D1 pid=3D331 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsui=
d=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"sys=
temd-nsresou" exe=3D"/usr/lib/systemd/systemd-nsresourced" key=3D(null)
Feb 06 08:53:45 archvm audit: PROCTITLE proctitle=3D"/usr/lib/systemd/syste=
md-nsresourced"
Feb 06 08:53:45 archvm audit: BPF prog-id=3D31 op=3DUNLOAD
Feb 06 08:53:45 archvm audit[331]: SYSCALL arch=3Dc000003e syscall=3D3 succ=
ess=3Dyes exit=3D0 a0=3Dd a1=3D0 a2=3D0 a3=3D0 items=3D0 ppid=3D1 pid=3D331=
 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgi=
d=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"systemd-nsresou" exe=
=3D"/usr/lib/systemd/systemd-nsresourced" key=3D(null)
Feb 06 08:53:45 archvm audit: PROCTITLE proctitle=3D"/usr/lib/systemd/syste=
md-nsresourced"
Feb 06 08:53:45 archvm audit: BPF prog-id=3D32 op=3DLOAD
Feb 06 08:53:45 archvm audit[331]: SYSCALL arch=3Dc000003e syscall=3D321 su=
ccess=3Dyes exit=3D11 a0=3D5 a1=3D7ffebd1b7ab0 a2=3D94 a3=3D2 items=3D0 ppi=
d=3D1 pid=3D331 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=
=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"syst=
emd-nsresou" exe=3D"/usr/lib/systemd/systemd-nsresourced" key=3D(null)
Feb 06 08:53:45 archvm audit: PROCTITLE proctitle=3D"/usr/lib/systemd/syste=
md-nsresourced"
Feb 06 08:53:45 archvm audit: BPF prog-id=3D32 op=3DUNLOAD
Feb 06 08:53:45 archvm audit[331]: SYSCALL arch=3Dc000003e syscall=3D3 succ=
ess=3Dyes exit=3D0 a0=3Db a1=3D0 a2=3D0 a3=3D0 items=3D0 ppid=3D1 pid=3D331=
 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgi=
d=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"systemd-nsresou" exe=
=3D"/usr/lib/systemd/systemd-nsresourced" key=3D(null)
Feb 06 08:53:45 archvm audit: PROCTITLE proctitle=3D"/usr/lib/systemd/syste=
md-nsresourced"
Feb 06 08:53:45 archvm systemd[1]: Finished Coldplug All udev Devices.
Feb 06 08:53:45 archvm systemd-journald[314]: Time spent on flushing to /va=
r/log/journal/8f1b161d188e41219ae9cfb088b4379d is 7.609ms for 876 entries.
Feb 06 08:53:45 archvm systemd-journald[314]: System Journal (/var/log/jour=
nal/8f1b161d188e41219ae9cfb088b4379d) is 40M, max 2.9G, 2.8G free.
Feb 06 08:53:45 archvm systemd-journald[314]: Received client request to fl=
ush runtime journal.
Feb 06 08:53:45 archvm systemd-journald[314]: File /var/log/journal/8f1b161=
d188e41219ae9cfb088b4379d/system.journal corrupted or uncleanly shut down, =
renaming and replacing.
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-udev-trigger comm=3D"systemd" =
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-userdbd comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
Feb 06 08:53:45 archvm audit: BPF prog-id=3D33 op=3DLOAD
Feb 06 08:53:45 archvm audit[331]: SYSCALL arch=3Dc000003e syscall=3D321 su=
ccess=3Dyes exit=3D14 a0=3D5 a1=3D7ffebd1b7810 a2=3D94 a3=3D4 items=3D0 ppi=
d=3D1 pid=3D331 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=
=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"syst=
emd-nsresou" exe=3D"/usr/lib/systemd/systemd-nsresourced" key=3D(null)
Feb 06 08:53:45 archvm audit: PROCTITLE proctitle=3D"/usr/lib/systemd/syste=
md-nsresourced"
Feb 06 08:53:45 archvm audit: BPF prog-id=3D33 op=3DUNLOAD
Feb 06 08:53:45 archvm audit[331]: SYSCALL arch=3Dc000003e syscall=3D3 succ=
ess=3Dyes exit=3D0 a0=3De a1=3D0 a2=3D0 a3=3D0 items=3D0 ppid=3D1 pid=3D331=
 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgi=
d=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"systemd-nsresou" exe=
=3D"/usr/lib/systemd/systemd-nsresourced" key=3D(null)
Feb 06 08:53:45 archvm audit: PROCTITLE proctitle=3D"/usr/lib/systemd/syste=
md-nsresourced"
Feb 06 08:53:45 archvm audit: BPF prog-id=3D34 op=3DLOAD
Feb 06 08:53:45 archvm audit[331]: SYSCALL arch=3Dc000003e syscall=3D321 su=
ccess=3Dyes exit=3D14 a0=3D5 a1=3D7ffebd1b7940 a2=3D94 a3=3D0 items=3D0 ppi=
d=3D1 pid=3D331 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=
=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"syst=
emd-nsresou" exe=3D"/usr/lib/systemd/systemd-nsresourced" key=3D(null)
Feb 06 08:53:45 archvm audit: PROCTITLE proctitle=3D"/usr/lib/systemd/syste=
md-nsresourced"
Feb 06 08:53:45 archvm audit: BPF prog-id=3D34 op=3DUNLOAD
Feb 06 08:53:45 archvm audit[331]: SYSCALL arch=3Dc000003e syscall=3D3 succ=
ess=3Dyes exit=3D0 a0=3De a1=3D0 a2=3D0 a3=3D0 items=3D0 ppid=3D1 pid=3D331=
 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sgi=
d=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"systemd-nsresou" exe=
=3D"/usr/lib/systemd/systemd-nsresourced" key=3D(null)
Feb 06 08:53:45 archvm audit: PROCTITLE proctitle=3D"/usr/lib/systemd/syste=
md-nsresourced"
Feb 06 08:53:45 archvm audit: BPF prog-id=3D35 op=3DLOAD
Feb 06 08:53:45 archvm audit[331]: SYSCALL arch=3Dc000003e syscall=3D321 su=
ccess=3Dyes exit=3D14 a0=3D5 a1=3D7ffebd1b70e0 a2=3D94 a3=3D35 items=3D0 pp=
id=3D1 pid=3D331 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=
=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"syst=
emd-nsresou" exe=3D"/usr/lib/systemd/systemd-nsresourced" key=3D(null)
Feb 06 08:53:45 archvm audit: PROCTITLE proctitle=3D"/usr/lib/systemd/syste=
md-nsresourced"
Feb 06 08:53:45 archvm audit: BPF prog-id=3D36 op=3DLOAD
Feb 06 08:53:45 archvm audit[331]: SYSCALL arch=3Dc000003e syscall=3D321 su=
ccess=3Dyes exit=3D15 a0=3D5 a1=3D7ffebd1b70e0 a2=3D94 a3=3D35 items=3D0 pp=
id=3D1 pid=3D331 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=
=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"syst=
emd-nsresou" exe=3D"/usr/lib/systemd/systemd-nsresourced" key=3D(null)
Feb 06 08:53:45 archvm audit: PROCTITLE proctitle=3D"/usr/lib/systemd/syste=
md-nsresourced"
Feb 06 08:53:45 archvm audit: BPF prog-id=3D37 op=3DLOAD
Feb 06 08:53:45 archvm audit[331]: SYSCALL arch=3Dc000003e syscall=3D321 su=
ccess=3Dyes exit=3D16 a0=3D5 a1=3D7ffebd1b70e0 a2=3D94 a3=3D35 items=3D0 pp=
id=3D1 pid=3D331 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=
=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"syst=
emd-nsresou" exe=3D"/usr/lib/systemd/systemd-nsresourced" key=3D(null)
Feb 06 08:53:45 archvm audit: PROCTITLE proctitle=3D"/usr/lib/systemd/syste=
md-nsresourced"
Feb 06 08:53:45 archvm audit: BPF prog-id=3D38 op=3DLOAD
Feb 06 08:53:45 archvm audit[331]: SYSCALL arch=3Dc000003e syscall=3D321 su=
ccess=3Dyes exit=3D17 a0=3D5 a1=3D7ffebd1b70e0 a2=3D94 a3=3D35 items=3D0 pp=
id=3D1 pid=3D331 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=
=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"syst=
emd-nsresou" exe=3D"/usr/lib/systemd/systemd-nsresourced" key=3D(null)
Feb 06 08:53:45 archvm audit: PROCTITLE proctitle=3D"/usr/lib/systemd/syste=
md-nsresourced"
Feb 06 08:53:45 archvm audit: BPF prog-id=3D39 op=3DLOAD
Feb 06 08:53:45 archvm audit[331]: SYSCALL arch=3Dc000003e syscall=3D321 su=
ccess=3Dyes exit=3D18 a0=3D5 a1=3D7ffebd1b70e0 a2=3D94 a3=3D35 items=3D0 pp=
id=3D1 pid=3D331 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=
=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"syst=
emd-nsresou" exe=3D"/usr/lib/systemd/systemd-nsresourced" key=3D(null)
Feb 06 08:53:45 archvm audit: PROCTITLE proctitle=3D"/usr/lib/systemd/syste=
md-nsresourced"
Feb 06 08:53:45 archvm audit: BPF prog-id=3D40 op=3DLOAD
Feb 06 08:53:45 archvm audit[331]: SYSCALL arch=3Dc000003e syscall=3D321 su=
ccess=3Dyes exit=3D19 a0=3D5 a1=3D7ffebd1b70e0 a2=3D94 a3=3D16 items=3D0 pp=
id=3D1 pid=3D331 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=
=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"syst=
emd-nsresou" exe=3D"/usr/lib/systemd/systemd-nsresourced" key=3D(null)
Feb 06 08:53:45 archvm audit: PROCTITLE proctitle=3D"/usr/lib/systemd/syste=
md-nsresourced"
Feb 06 08:53:45 archvm systemd[1]: Started User Database Manager.
Feb 06 08:53:45 archvm systemd[1]: Finished Flush Journal to Persistent Sto=
rage.
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-journal-flush comm=3D"systemd"=
 exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
Feb 06 08:53:45 archvm systemd-nsresourced[331]: userns-restrict BPF-LSM pr=
ogram userns_restrict_path_chown now attached.
Feb 06 08:53:45 archvm systemd-nsresourced[331]: userns-restrict BPF-LSM pr=
ogram userns_restrict_path_mkdir now attached.
Feb 06 08:53:45 archvm systemd-nsresourced[331]: userns-restrict BPF-LSM pr=
ogram userns_restrict_path_mknod now attached.
Feb 06 08:53:45 archvm systemd-nsresourced[331]: userns-restrict BPF-LSM pr=
ogram userns_restrict_path_symlink now attached.
Feb 06 08:53:45 archvm systemd-nsresourced[331]: userns-restrict BPF-LSM pr=
ogram userns_restrict_path_link now attached.
Feb 06 08:53:45 archvm audit: BPF prog-id=3D41 op=3DLOAD
Feb 06 08:53:45 archvm audit[331]: SYSCALL arch=3Dc000003e syscall=3D321 su=
ccess=3Dyes exit=3D26 a0=3D5 a1=3D7ffebd1b7680 a2=3D94 a3=3D2 items=3D0 ppi=
d=3D1 pid=3D331 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=
=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"syst=
emd-nsresou" exe=3D"/usr/lib/systemd/systemd-nsresourced" key=3D(null)
Feb 06 08:53:45 archvm audit: PROCTITLE proctitle=3D"/usr/lib/systemd/syste=
md-nsresourced"
Feb 06 08:53:45 archvm audit: BPF prog-id=3D41 op=3DUNLOAD
Feb 06 08:53:45 archvm audit[331]: SYSCALL arch=3Dc000003e syscall=3D3 succ=
ess=3Dyes exit=3D0 a0=3D1a a1=3D0 a2=3D0 a3=3D0 items=3D0 ppid=3D1 pid=3D33=
1 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0 sg=
id=3D0 fsgid=3D0 tty=3D(none) ses=3D4294967295 comm=3D"systemd-nsresou" exe=
=3D"/usr/lib/systemd/systemd-nsresourced" key=3D(null)
Feb 06 08:53:45 archvm audit: PROCTITLE proctitle=3D"/usr/lib/systemd/syste=
md-nsresourced"
Feb 06 08:53:45 archvm systemd-nsresourced[331]: userns-restrict BPF-LSM pr=
ogram userns_restrict_free_user_ns now attached.
Feb 06 08:53:45 archvm systemd[1]: Started Namespace Resource Manager.
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-nsresourced comm=3D"systemd" e=
xe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsu=
ccess'
Feb 06 08:53:45 archvm systemd[1]: Finished Create Static Device Nodes in /=
dev gracefully.
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-tmpfiles-setup-dev-early comm=
=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termina=
l=3D? res=3Dsuccess'
Feb 06 08:53:45 archvm systemd[1]: Starting Create System Users...
Feb 06 08:53:45 archvm systemd[1]: Finished Create System Users.
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-sysusers comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
Feb 06 08:53:45 archvm audit: BPF prog-id=3D42 op=3DLOAD
Feb 06 08:53:45 archvm systemd[1]: Starting Network Name Resolution...
Feb 06 08:53:45 archvm audit: BPF prog-id=3D43 op=3DLOAD
Feb 06 08:53:45 archvm systemd[1]: Starting Network Time Synchronization...
Feb 06 08:53:45 archvm systemd[1]: Starting Create Static Device Nodes in /=
dev...
Feb 06 08:53:45 archvm systemd[1]: Finished Create Static Device Nodes in /=
dev.
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-tmpfiles-setup-dev comm=3D"sys=
temd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? r=
es=3Dsuccess'
Feb 06 08:53:45 archvm systemd[1]: Started Network Time Synchronization.
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-timesyncd comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
Feb 06 08:53:45 archvm systemd[1]: Reached target Preparation for Local Fil=
e Systems.
Feb 06 08:53:45 archvm systemd[1]: Set up automount EFI System Partition Au=
tomount.
Feb 06 08:53:45 archvm systemd[1]: Reached target System Time Set.
Feb 06 08:53:45 archvm audit: BPF prog-id=3D44 op=3DLOAD
Feb 06 08:53:45 archvm audit: BPF prog-id=3D45 op=3DLOAD
Feb 06 08:53:45 archvm systemd[1]: Starting Rule-based Manager for Device E=
vents and Files...
Feb 06 08:53:45 archvm systemd-resolved[373]: Positive Trust Anchors:
Feb 06 08:53:45 archvm systemd-resolved[373]: . IN DS 20326 8 2 e06d44b80b8=
f1d39a95c0b0d7c65d08458e880409bbc683457104237c7f8ec8d
Feb 06 08:53:45 archvm systemd-resolved[373]: Negative trust anchors: home.=
arpa 10.in-addr.arpa 16.172.in-addr.arpa 17.172.in-addr.arpa 18.172.in-addr=
=2Earpa 19.172.in-addr.arpa 20.172.in-addr.arpa 21.172.in-addr.arpa 22.172.=
in-addr.arpa 23.172.in-addr.arpa 24.172.in-addr.arpa 25.172.in-addr.arpa 26=
=2E172.in-addr.arpa 27.172.in-addr.arpa 28.172.in-addr.arpa 29.172.in-addr.=
arpa 30.172.in-addr.arpa 31.172.in-addr.arpa 170.0.0.192.in-addr.arpa 171.0=
=2E0.192.in-addr.arpa 168.192.in-addr.arpa d.f.ip6.arpa ipv4only.arpa resol=
ver.arpa corp home internal intranet lan local private test
Feb 06 08:53:45 archvm systemd-resolved[373]: Using system hostname 'archvm=
'.
Feb 06 08:53:45 archvm systemd[1]: Started Network Name Resolution.
Feb 06 08:53:45 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-resolved comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
Feb 06 08:53:45 archvm systemd[1]: Reached target Host and Network Name Loo=
kups.
Feb 06 08:53:45 archvm systemd-udevd[383]: Using default interface naming s=
cheme 'v257'.
Feb 06 08:53:46 archvm systemd[1]: Started Rule-based Manager for Device Ev=
ents and Files.
Feb 06 08:53:46 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-udevd comm=3D"systemd" exe=3D"=
/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:46 archvm (udev-worker)[398]: Network interface NamePolicy=3D =
disabled on kernel command line.
Feb 06 08:53:46 archvm kernel: mousedev: PS/2 mouse device common for all m=
ice
Feb 06 08:53:46 archvm systemd[1]: Starting Load Kernel Module dm_mod...
Feb 06 08:53:46 archvm kernel: lpc_ich 0000:00:1f.0: I/O space for GPIO uni=
nitialized
Feb 06 08:53:46 archvm systemd[1]: Starting Load Kernel Module efi_pstore...
Feb 06 08:53:46 archvm systemd[1]: Starting Load Kernel Module loop...
Feb 06 08:53:46 archvm systemd[1]: Clear Stale Hibernate Storage Info was s=
kipped because of an unmet condition check (ConditionPathExists=3D/sys/firm=
ware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
Feb 06 08:53:46 archvm systemd[1]: Rebuild Hardware Database was skipped be=
cause no trigger condition checks were met.
Feb 06 08:53:46 archvm systemd[1]: TPM PCR Machine ID Measurement was skipp=
ed because of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
Feb 06 08:53:46 archvm systemd[1]: Early TPM SRK Setup was skipped because =
of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
Feb 06 08:53:46 archvm systemd[1]: TPM SRK Setup was skipped because of an =
unmet condition check (ConditionSecurity=3Dmeasured-uki).
Feb 06 08:53:46 archvm kernel: input: PC Speaker as /devices/platform/pcspk=
r/input/input5
Feb 06 08:53:46 archvm kernel: cryptd: max_cpu_qlen set to 1000
Feb 06 08:53:46 archvm systemd[1]: modprobe@dm_mod.service: Deactivated suc=
cessfully.
Feb 06 08:53:46 archvm systemd[1]: Finished Load Kernel Module dm_mod.
Feb 06 08:53:46 archvm systemd[1]: modprobe@loop.service: Deactivated succe=
ssfully.
Feb 06 08:53:46 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@dm_mod comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
Feb 06 08:53:46 archvm audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@dm_mod comm=3D"systemd" exe=3D=
"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:46 archvm systemd[1]: Finished Load Kernel Module loop.
Feb 06 08:53:46 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@loop comm=3D"systemd" exe=3D"=
/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:46 archvm audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@loop comm=3D"systemd" exe=3D"/=
usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:46 archvm systemd[1]: modprobe@efi_pstore.service: Deactivated=
 successfully.
Feb 06 08:53:46 archvm systemd[1]: Finished Load Kernel Module efi_pstore.
Feb 06 08:53:46 archvm kernel: input: VirtualPS/2 VMware VMMouse as /device=
s/platform/i8042/serio1/input/input7
Feb 06 08:53:46 archvm kernel: input: VirtualPS/2 VMware VMMouse as /device=
s/platform/i8042/serio1/input/input6
Feb 06 08:53:46 archvm kernel: i801_smbus 0000:00:1f.3: Enabling SMBus devi=
ce
Feb 06 08:53:46 archvm kernel: i801_smbus 0000:00:1f.3: SMBus using PCI int=
errupt
Feb 06 08:53:46 archvm kernel: i2c i2c-13: Memory type 0x07 not supported y=
et, not instantiating SPD
Feb 06 08:53:46 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@efi_pstore comm=3D"systemd" e=
xe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsu=
ccess'
Feb 06 08:53:46 archvm audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'unit=3Dmodprobe@efi_pstore comm=3D"systemd" ex=
e=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuc=
cess'
Feb 06 08:53:46 archvm systemd[1]: Platform Persistent Storage Archival was=
 skipped because of an unmet condition check (ConditionDirectoryNotEmpty=3D=
/sys/fs/pstore).
Feb 06 08:53:46 archvm systemd[1]: Repartition Root Disk was skipped becaus=
e no trigger condition checks were met.
Feb 06 08:53:46 archvm kernel: AES CTR mode by8 optimization enabled
Feb 06 08:53:46 archvm kernel: iTCO_vendor_support: vendor-support=3D0
Feb 06 08:53:46 archvm systemd[1]: Starting Virtual Console Setup...
Feb 06 08:53:46 archvm kernel: iTCO_wdt iTCO_wdt.1.auto: Found a ICH9 TCO d=
evice (Version=3D2, TCOBASE=3D0x0660)
Feb 06 08:53:46 archvm kernel: iTCO_wdt iTCO_wdt.1.auto: initialized. heart=
beat=3D30 sec (nowayout=3D0)
Feb 06 08:53:46 archvm systemd[1]: Finished Virtual Console Setup.
Feb 06 08:53:46 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-vconsole-setup comm=3D"systemd=
" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
Feb 06 08:53:46 archvm kernel: ACPI: \_SB_.GSIH: Enabled at IRQ 23
Feb 06 08:53:46 archvm kernel: snd_hda_intel 0000:09:00.1: Disabling MSI
Feb 06 08:53:46 archvm kernel: snd_hda_intel 0000:09:00.1: Handle vga_switc=
heroo audio client
Feb 06 08:53:46 archvm kernel: snd_hda_codec_generic hdaudioC0D0: autoconfi=
g for Generic: line_outs=3D1 (0x3/0x0/0x0/0x0/0x0) type:speaker
Feb 06 08:53:46 archvm kernel: snd_hda_codec_generic hdaudioC0D0:    speake=
r_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
Feb 06 08:53:46 archvm kernel: snd_hda_codec_generic hdaudioC0D0:    hp_out=
s=3D0 (0x0/0x0/0x0/0x0/0x0)
Feb 06 08:53:46 archvm kernel: snd_hda_codec_generic hdaudioC0D0:    mono: =
mono_out=3D0x0
Feb 06 08:53:46 archvm kernel: snd_hda_codec_generic hdaudioC0D0:    inputs:
Feb 06 08:53:46 archvm kernel: snd_hda_codec_generic hdaudioC0D0:      Mic=
=3D0x5
Feb 06 08:53:46 archvm systemd[1]: Reached target Sound Card.
Feb 06 08:53:46 archvm kernel: snd_hda_intel 0000:09:00.1: bound 0000:09:00=
=2E0 (ops nv50_audio_component_bind_ops [nouveau])
Feb 06 08:53:46 archvm kernel: input: HDA NVidia HDMI/DP,pcm=3D3 as /device=
s/pci0000:00/0000:00:02.0/0000:09:00.1/sound/card1/input8
Feb 06 08:53:46 archvm kernel: input: HDA NVidia HDMI/DP,pcm=3D7 as /device=
s/pci0000:00/0000:00:02.0/0000:09:00.1/sound/card1/input9
Feb 06 08:53:46 archvm kernel: input: HDA NVidia HDMI/DP,pcm=3D8 as /device=
s/pci0000:00/0000:00:02.0/0000:09:00.1/sound/card1/input10
Feb 06 08:53:46 archvm kernel: input: HDA NVidia HDMI/DP,pcm=3D9 as /device=
s/pci0000:00/0000:00:02.0/0000:09:00.1/sound/card1/input11
Feb 06 08:53:46 archvm kernel: kvm_amd: TSC scaling supported
Feb 06 08:53:46 archvm kernel: kvm_amd: Nested Virtualization enabled
Feb 06 08:53:46 archvm kernel: kvm_amd: Nested Paging enabled
Feb 06 08:53:46 archvm kernel: kvm_amd: LBR virtualization supported
Feb 06 08:53:46 archvm kernel: kvm_amd: Virtual VMLOAD VMSAVE supported
Feb 06 08:53:46 archvm kernel: kvm_amd: Virtual GIF supported
Feb 06 08:53:46 archvm systemd[1]: Virtual Machine and Container Storage (C=
ompatibility) was skipped because of an unmet condition check (ConditionPat=
hExists=3D/var/lib/machines.raw).
Feb 06 08:53:46 archvm systemd[1]: Reached target Local File Systems.
Feb 06 08:53:46 archvm systemd[1]: Reached target Containers.
Feb 06 08:53:46 archvm systemd[1]: Listening on Boot Entries Service Socket.
Feb 06 08:53:46 archvm systemd-timesyncd[374]: Network configuration change=
d, trying to establish connection.
Feb 06 08:53:46 archvm systemd[1]: Listening on Disk Image Download Service=
 Socket.
Feb 06 08:53:46 archvm systemd-timesyncd[374]: Network configuration change=
d, trying to establish connection.
Feb 06 08:53:46 archvm systemd[1]: Listening on System Extension Image Mana=
gement.
Feb 06 08:53:46 archvm systemd-timesyncd[374]: Network configuration change=
d, trying to establish connection.
Feb 06 08:53:46 archvm systemd[1]: Set Up Additional Binary Formats was ski=
pped because no trigger condition checks were met.
Feb 06 08:53:46 archvm systemd[1]: Starting Update Boot Loader Random Seed.=
=2E.
Feb 06 08:53:46 archvm systemd[1]: Starting Automatic Boot Loader Update...
Feb 06 08:53:46 archvm systemd[1]: Merge System Configuration Images into /=
etc/ was skipped because no trigger condition checks were met.
Feb 06 08:53:46 archvm systemd[1]: Merge System Extension Images into /usr/=
 and /opt/ was skipped because no trigger condition checks were met.
Feb 06 08:53:46 archvm systemd[1]: Starting Create System Files and Directo=
ries...
Feb 06 08:53:46 archvm systemd[1]: boot.automount: Got automount request fo=
r /boot, triggered by 439 (bootctl)
Feb 06 08:53:46 archvm systemd[1]: Mounting EFI System Partition Automount.=
=2E.
Feb 06 08:53:46 archvm kernel: FAT-fs (vda1): Volume was not properly unmou=
nted. Some data may be corrupt. Please run fsck.
Feb 06 08:53:46 archvm systemd[1]: Mounted EFI System Partition Automount.
Feb 06 08:53:46 archvm bootctl[438]: Random seed file /boot/loader/random-s=
eed successfully refreshed (32 bytes).
Feb 06 08:53:46 archvm systemd[1]: Finished Update Boot Loader Random Seed.
Feb 06 08:53:46 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-boot-random-seed comm=3D"syste=
md" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
Feb 06 08:53:46 archvm bootctl[439]: Skipping "/boot/EFI/systemd/systemd-bo=
otx64.efi", same boot loader version in place already.
Feb 06 08:53:46 archvm bootctl[439]: Skipping "/boot/EFI/BOOT/BOOTX64.EFI",=
 same boot loader version in place already.
Feb 06 08:53:46 archvm bootctl[439]: Skipping "/boot/EFI/BOOT/BOOTX64.EFI",=
 same boot loader version in place already.
Feb 06 08:53:46 archvm systemd[1]: Finished Automatic Boot Loader Update.
Feb 06 08:53:46 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-boot-update comm=3D"systemd" e=
xe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsu=
ccess'
Feb 06 08:53:46 archvm kernel: kauditd_printk_skb: 83 callbacks suppressed
Feb 06 08:53:46 archvm kernel: audit: type=3D1130 audit(1738792426.713:62):=
 pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-b=
oot-update comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:46 archvm systemd-timesyncd[374]: Network configuration change=
d, trying to establish connection.
Feb 06 08:53:46 archvm systemd-timesyncd[374]: Network configuration change=
d, trying to establish connection.
Feb 06 08:53:46 archvm systemd-timesyncd[374]: Network configuration change=
d, trying to establish connection.
Feb 06 08:53:46 archvm systemd[1]: Finished Create System Files and Directo=
ries.
Feb 06 08:53:46 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-tmpfiles-setup comm=3D"systemd=
" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
Feb 06 08:53:46 archvm kernel: audit: type=3D1130 audit(1738792426.764:63):=
 pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-t=
mpfiles-setup comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D=
? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:46 archvm systemd[1]: Starting Rebuild Dynamic Linker Cache...
Feb 06 08:53:46 archvm systemd[1]: First Boot Wizard was skipped because of=
 an unmet condition check (ConditionFirstBoot=3Dyes).
Feb 06 08:53:46 archvm systemd[1]: First Boot Complete was skipped because =
of an unmet condition check (ConditionFirstBoot=3Dyes).
Feb 06 08:53:46 archvm systemd[1]: Starting Rebuild Journal Catalog...
Feb 06 08:53:46 archvm systemd[1]: Save Transient machine-id to Disk was sk=
ipped because of an unmet condition check (ConditionPathIsMountPoint=3D/etc=
/machine-id).
Feb 06 08:53:46 archvm systemd[1]: Starting Record System Boot/Shutdown in =
UTMP...
Feb 06 08:53:46 archvm audit[453]: SYSTEM_BOOT pid=3D453 uid=3D0 auid=3D429=
4967295 ses=3D4294967295 msg=3D' comm=3D"systemd-update-utmp" exe=3D"/usr/l=
ib/systemd/systemd-update-utmp" hostname=3D? addr=3D? terminal=3D? res=3Dsu=
ccess'
Feb 06 08:53:46 archvm kernel: audit: type=3D1127 audit(1738792426.787:64):=
 pid=3D453 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D' comm=3D"syste=
md-update-utmp" exe=3D"/usr/lib/systemd/systemd-update-utmp" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:46 archvm systemd[1]: Finished Record System Boot/Shutdown in =
UTMP.
Feb 06 08:53:46 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-update-utmp comm=3D"systemd" e=
xe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsu=
ccess'
Feb 06 08:53:46 archvm kernel: audit: type=3D1130 audit(1738792426.792:65):=
 pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-u=
pdate-utmp comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:46 archvm systemd[1]: Finished Rebuild Journal Catalog.
Feb 06 08:53:46 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-journal-catalog-update comm=3D=
"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=
=3D? res=3Dsuccess'
Feb 06 08:53:46 archvm kernel: audit: type=3D1130 audit(1738792426.813:66):=
 pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-j=
ournal-catalog-update comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hos=
tname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:46 archvm systemd[1]: Finished Rebuild Dynamic Linker Cache.
Feb 06 08:53:46 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dldconfig comm=3D"systemd" exe=3D"/usr/=
lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:46 archvm kernel: audit: type=3D1130 audit(1738792426.871:67):=
 pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dldconfig =
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? ter=
minal=3D? res=3Dsuccess'
Feb 06 08:53:46 archvm systemd[1]: Starting Update is Completed...
Feb 06 08:53:46 archvm systemd[1]: Finished Update is Completed.
Feb 06 08:53:46 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-update-done comm=3D"systemd" e=
xe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsu=
ccess'
Feb 06 08:53:46 archvm kernel: audit: type=3D1130 audit(1738792426.900:68):=
 pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-u=
pdate-done comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? a=
ddr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:46 archvm systemd[1]: Reached target System Initialization.
Feb 06 08:53:46 archvm systemd[1]: Started Refresh existing PGP keys of arc=
hlinux-keyring regularly.
Feb 06 08:53:46 archvm systemd[1]: Started Daily verification of password a=
nd group files.
Feb 06 08:53:46 archvm systemd[1]: Started Daily Cleanup of Temporary Direc=
tories.
Feb 06 08:53:46 archvm systemd[1]: Reached target Timer Units.
Feb 06 08:53:46 archvm systemd[1]: Listening on D-Bus System Message Bus So=
cket.
Feb 06 08:53:46 archvm systemd[1]: Listening on GnuPG network certificate m=
anagement daemon for /etc/pacman.d/gnupg.
Feb 06 08:53:46 archvm systemd[1]: Listening on GnuPG cryptographic agent a=
nd passphrase cache (access for web browsers) for /etc/pacman.d/gnupg.
Feb 06 08:53:46 archvm systemd[1]: Listening on GnuPG cryptographic agent a=
nd passphrase cache (restricted) for /etc/pacman.d/gnupg.
Feb 06 08:53:46 archvm systemd[1]: Listening on GnuPG cryptographic agent (=
ssh-agent emulation) for /etc/pacman.d/gnupg.
Feb 06 08:53:46 archvm systemd[1]: Listening on GnuPG cryptographic agent a=
nd passphrase cache for /etc/pacman.d/gnupg.
Feb 06 08:53:46 archvm systemd[1]: Listening on GnuPG public key management=
 service for /etc/pacman.d/gnupg.
Feb 06 08:53:46 archvm systemd[1]: Listening on OpenSSH Server Socket (syst=
emd-ssh-generator, AF_UNIX Local).
Feb 06 08:53:46 archvm systemd[1]: Listening on OpenSSH Server Socket (syst=
emd-ssh-generator, AF_VSOCK).
Feb 06 08:53:46 archvm systemd[1]: Reached target SSH Access Available.
Feb 06 08:53:46 archvm systemd[1]: Listening on Hostname Service Socket.
Feb 06 08:53:46 archvm systemd[1]: Reached target Socket Units.
Feb 06 08:53:46 archvm audit: BPF prog-id=3D46 op=3DLOAD
Feb 06 08:53:46 archvm kernel: audit: type=3D1334 audit(1738792426.940:69):=
 prog-id=3D46 op=3DLOAD
Feb 06 08:53:46 archvm systemd[1]: Starting D-Bus System Message Bus...
Feb 06 08:53:46 archvm systemd[1]: TPM PCR Barrier (Initialization) was ski=
pped because of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
Feb 06 08:53:46 archvm systemd[1]: Started D-Bus System Message Bus.
Feb 06 08:53:47 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Ddbus-broker comm=3D"systemd" exe=3D"/u=
sr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:47 archvm systemd[1]: Reached target Basic System.
Feb 06 08:53:47 archvm kernel: audit: type=3D1130 audit(1738792427.002:70):=
 pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Ddbus-brok=
er comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? =
terminal=3D? res=3Dsuccess'
Feb 06 08:53:47 archvm systemd[1]: Starting Network Manager...
Feb 06 08:53:47 archvm systemd[1]: Initializes Pacman keyring was skipped b=
ecause of an unmet condition check (ConditionFirstBoot=3Dyes).
Feb 06 08:53:47 archvm systemd[1]: Started QEMU Guest Agent.
Feb 06 08:53:47 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dqemu-guest-agent comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
Feb 06 08:53:47 archvm systemd[1]: SSH Key Generation was skipped because n=
o trigger condition checks were met.
Feb 06 08:53:47 archvm kernel: audit: type=3D1130 audit(1738792427.013:71):=
 pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dqemu-gues=
t-agent comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:47 archvm dbus-broker-launch[460]: Ready
Feb 06 08:53:47 archvm audit: BPF prog-id=3D47 op=3DLOAD
Feb 06 08:53:47 archvm systemd[1]: Starting Home Area Manager...
Feb 06 08:53:47 archvm audit: BPF prog-id=3D48 op=3DLOAD
Feb 06 08:53:47 archvm audit: BPF prog-id=3D49 op=3DLOAD
Feb 06 08:53:47 archvm audit: BPF prog-id=3D50 op=3DLOAD
Feb 06 08:53:47 archvm systemd[1]: Starting User Login Management...
Feb 06 08:53:47 archvm systemd[1]: TPM PCR Barrier (User) was skipped becau=
se of an unmet condition check (ConditionSecurity=3Dmeasured-uki).
Feb 06 08:53:47 archvm systemd-homed[464]: Watching /home.
Feb 06 08:53:47 archvm systemd[1]: Started Home Area Manager.
Feb 06 08:53:47 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-homed comm=3D"systemd" exe=3D"=
/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:47 archvm systemd[1]: Finished Home Area Activation.
Feb 06 08:53:47 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-homed-activate comm=3D"systemd=
" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.0658] NetworkMana=
ger (version 1.50.2-1) is starting... (boot:f574cc39-9154-46f6-b97c-f093dc2=
4e6a4)
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.0658] Read config=
: /etc/NetworkManager/NetworkManager.conf (lib: 20-connectivity.conf)
Feb 06 08:53:47 archvm systemd-logind[468]: New seat seat0.
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.0793] manager[0x5=
603a773f030]: monitoring kernel firmware directory '/lib/firmware'.
Feb 06 08:53:47 archvm systemd-logind[468]: Watching system buttons on /dev=
/input/event0 (Power Button)
Feb 06 08:53:47 archvm systemd-logind[468]: Watching system buttons on /dev=
/input/event1 (QEMU Virtio Keyboard)
Feb 06 08:53:47 archvm audit: BPF prog-id=3D51 op=3DLOAD
Feb 06 08:53:47 archvm audit: BPF prog-id=3D52 op=3DLOAD
Feb 06 08:53:47 archvm audit: BPF prog-id=3D53 op=3DLOAD
Feb 06 08:53:47 archvm systemd[1]: Starting Hostname Service...
Feb 06 08:53:47 archvm systemd-logind[468]: Watching system buttons on /dev=
/input/event2 (AT Translated Set 2 keyboard)
Feb 06 08:53:47 archvm systemd[1]: Started User Login Management.
Feb 06 08:53:47 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-logind comm=3D"systemd" exe=3D=
"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:47 archvm systemd[1]: Started Hostname Service.
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.1453] hostname: h=
ostname: using hostnamed
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.1453] hostname: s=
tatic hostname changed from (none) to "archvm"
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.1458] dns-mgr: in=
it: dns=3Dsystemd-resolved rc-manager=3Dsymlink, plugin=3Dsystemd-resolved
Feb 06 08:53:47 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hostnamed comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.1542] manager[0x5=
603a773f030]: rfkill: Wi-Fi hardware radio set enabled
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.1543] manager[0x5=
603a773f030]: rfkill: WWAN hardware radio set enabled
Feb 06 08:53:47 archvm systemd[1]: Listening on Load/Save RF Kill Switch St=
atus /dev/rfkill Watch.
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.1647] Loaded devi=
ce plugin: NMBluezManager (/usr/lib/NetworkManager/1.50.2-1/libnm-device-pl=
ugin-bluetooth.so)
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.1667] Loaded devi=
ce plugin: NMWifiFactory (/usr/lib/NetworkManager/1.50.2-1/libnm-device-plu=
gin-wifi.so)
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.1688] Loaded devi=
ce plugin: NMOvsFactory (/usr/lib/NetworkManager/1.50.2-1/libnm-device-plug=
in-ovs.so)
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.1697] Loaded devi=
ce plugin: NMWwanFactory (/usr/lib/NetworkManager/1.50.2-1/libnm-device-plu=
gin-wwan.so)
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.1706] Loaded devi=
ce plugin: NMAtmManager (/usr/lib/NetworkManager/1.50.2-1/libnm-device-plug=
in-adsl.so)
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.1996] Loaded devi=
ce plugin: NMTeamFactory (/usr/lib/NetworkManager/1.50.2-1/libnm-device-plu=
gin-team.so)
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2001] manager: rf=
kill: Wi-Fi enabled by radio killswitch; enabled by state file
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2001] manager: rf=
kill: WWAN enabled by radio killswitch; enabled by state file
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2002] manager: Ne=
tworking is enabled by state file
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2012] settings: L=
oaded settings plugin: keyfile (internal)
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2030] dhcp: init:=
 Using DHCP client 'internal'
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2033] manager: (l=
o): new Loopback device (/org/freedesktop/NetworkManager/Devices/1)
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2053] device (lo)=
: state change: unmanaged -> unavailable (reason 'connection-assumed', mana=
ged-type: 'external')
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2062] device (lo)=
: state change: unavailable -> disconnected (reason 'connection-assumed', m=
anaged-type: 'external')
Feb 06 08:53:47 archvm systemd[1]: Starting Network Manager Script Dispatch=
er Service...
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2071] device (lo)=
: Activation: starting connection 'lo' (691b2b06-87b5-4c39-99af-ad3a5e7fee7=
3)
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2084] manager: (e=
th0): new Ethernet device (/org/freedesktop/NetworkManager/Devices/2)
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2097] settings: (=
eth0): created default wired connection 'Wired connection 1'
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2098] device (eth=
0): state change: unmanaged -> unavailable (reason 'managed', managed-type:=
 'external')
Feb 06 08:53:47 archvm systemd[1]: Started Network Manager.
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2215] bus-manager=
: acquired D-Bus service "org.freedesktop.NetworkManager"
Feb 06 08:53:47 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3DNetworkManager comm=3D"systemd" exe=3D=
"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:47 archvm systemd[1]: Reached target Network.
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2236] ovsdb: disc=
onnected from ovsdb
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2237] device (lo)=
: state change: disconnected -> prepare (reason 'none', managed-type: 'exte=
rnal')
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2239] device (lo)=
: state change: prepare -> config (reason 'none', managed-type: 'external')
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2241] device (lo)=
: state change: config -> ip-config (reason 'none', managed-type: 'external=
')
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2243] device (eth=
0): carrier: link connected
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2248] device (lo)=
: state change: ip-config -> ip-check (reason 'none', managed-type: 'extern=
al')
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2255] device (eth=
0): state change: unavailable -> disconnected (reason 'carrier-changed', ma=
naged-type: 'full')
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2259] policy: aut=
o-activating connection 'Wired connection 1' (bc9e607e-500f-3431-b611-9802a=
9fb982f)
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2265] device (eth=
0): Activation: starting connection 'Wired connection 1' (bc9e607e-500f-343=
1-b611-9802a9fb982f)
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2266] device (eth=
0): state change: disconnected -> prepare (reason 'none', managed-type: 'fu=
ll')
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2268] manager: Ne=
tworkManager state is now CONNECTING
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2269] device (eth=
0): state change: prepare -> config (reason 'none', managed-type: 'full')
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2277] device (eth=
0): state change: config -> ip-config (reason 'none', managed-type: 'full')
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2281] dhcp4 (eth0=
): activation: beginning transaction (timeout in 45 seconds)
Feb 06 08:53:47 archvm systemd[1]: Starting OpenSSH Daemon...
Feb 06 08:53:47 archvm systemd[1]: Starting Permit User Sessions...
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2338] dhcp4 (eth0=
): state changed new lease, address=3D192.168.122.116, acd pending
Feb 06 08:53:47 archvm systemd[1]: Finished Permit User Sessions.
Feb 06 08:53:47 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-user-sessions comm=3D"systemd"=
 exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
Feb 06 08:53:47 archvm systemd[1]: Started Network Manager Script Dispatche=
r Service.
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2491] device (lo)=
: state change: ip-check -> secondaries (reason 'none', managed-type: 'exte=
rnal')
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2493] device (lo)=
: state change: secondaries -> activated (reason 'none', managed-type: 'ext=
ernal')
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.2497] device (lo)=
: Activation: successful, device activated.
Feb 06 08:53:47 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-dispatcher comm=3D"syst=
emd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? re=
s=3Dsuccess'
Feb 06 08:53:47 archvm systemd[1]: Starting GNOME Display Manager...
Feb 06 08:53:47 archvm sshd[491]: Server listening on 0.0.0.0 port 22.
Feb 06 08:53:47 archvm sshd[491]: Server listening on :: port 22.
Feb 06 08:53:47 archvm systemd[1]: Started OpenSSH Daemon.
Feb 06 08:53:47 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsshd comm=3D"systemd" exe=3D"/usr/lib/=
systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:47 archvm systemd[1]: Reached target Multi-User System.
Feb 06 08:53:47 archvm systemd[1]: Started GNOME Display Manager.
Feb 06 08:53:47 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dgdm comm=3D"systemd" exe=3D"/usr/lib/s=
ystemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:47 archvm systemd[1]: Reached target Graphical Interface.
Feb 06 08:53:47 archvm systemd[1]: Startup finished in 3.185s (kernel) + 2.=
451s (userspace) =3D 5.636s.
Feb 06 08:53:47 archvm systemd[1]: Reached target User and Group Name Looku=
ps.
Feb 06 08:53:47 archvm audit: BPF prog-id=3D54 op=3DLOAD
Feb 06 08:53:47 archvm systemd[1]: Starting Accounts Service...
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.3563] dhcp4 (eth0=
): state changed new lease, address=3D192.168.122.116
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.3567] policy: set=
 'Wired connection 1' (eth0) as default for IPv4 routing and DNS
Feb 06 08:53:47 archvm systemd-resolved[373]: eth0: Bus client set default =
route setting: yes
Feb 06 08:53:47 archvm systemd-resolved[373]: eth0: Bus client set DNS serv=
er list to: 192.168.122.1
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.3612] device (eth=
0): state change: ip-config -> ip-check (reason 'none', managed-type: 'full=
')
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.3623] device (eth=
0): state change: ip-check -> secondaries (reason 'none', managed-type: 'fu=
ll')
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.3624] device (eth=
0): state change: secondaries -> activated (reason 'none', managed-type: 'f=
ull')
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.3626] manager: Ne=
tworkManager state is now CONNECTED_SITE
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.3628] device (eth=
0): Activation: successful, device activated.
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.3631] manager: st=
artup complete
Feb 06 08:53:47 archvm audit: BPF prog-id=3D55 op=3DLOAD
Feb 06 08:53:47 archvm systemd[1]: Starting Authorization Manager...
Feb 06 08:53:47 archvm polkitd[509]: Started polkitd version 126
Feb 06 08:53:47 archvm polkitd[509]: Loading rules from directory /etc/polk=
it-1/rules.d
Feb 06 08:53:47 archvm polkitd[509]: Loading rules from directory /run/polk=
it-1/rules.d
Feb 06 08:53:47 archvm polkitd[509]: Error opening rules directory: Error o=
pening directory =E2=80=9C/run/polkit-1/rules.d=E2=80=9D: No such file or d=
irectory (g-file-error-quark, 4)
Feb 06 08:53:47 archvm polkitd[509]: Loading rules from directory /usr/loca=
l/share/polkit-1/rules.d
Feb 06 08:53:47 archvm polkitd[509]: Error opening rules directory: Error o=
pening directory =E2=80=9C/usr/local/share/polkit-1/rules.d=E2=80=9D: No su=
ch file or directory (g-file-error-quark, 4)
Feb 06 08:53:47 archvm polkitd[509]: Loading rules from directory /usr/shar=
e/polkit-1/rules.d
Feb 06 08:53:47 archvm polkitd[509]: Finished loading, compiling and execut=
ing 10 rules
Feb 06 08:53:47 archvm systemd[1]: Started Authorization Manager.
Feb 06 08:53:47 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dpolkit comm=3D"systemd" exe=3D"/usr/li=
b/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:47 archvm polkitd[509]: Acquired the name org.freedesktop.Poli=
cyKit1 on the system bus
Feb 06 08:53:47 archvm accounts-daemon[503]: started daemon version 23.13.0
Feb 06 08:53:47 archvm systemd[1]: Started Accounts Service.
Feb 06 08:53:47 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Daccounts-daemon comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
Feb 06 08:53:47 archvm audit[525]: USER_AUTH pid=3D525 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'op=3DPAM:authentication grantors=3Dpam_succee=
d_if,pam_permit acct=3D"gdm" exe=3D"/usr/lib/gdm-session-worker" hostname=
=3Darchvm addr=3D? terminal=3D/dev/tty1 res=3Dsuccess'
Feb 06 08:53:47 archvm audit[525]: USER_ACCT pid=3D525 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'op=3DPAM:accounting grantors=3Dpam_succeed_if=
,pam_permit acct=3D"gdm" exe=3D"/usr/lib/gdm-session-worker" hostname=3Darc=
hvm addr=3D? terminal=3D/dev/tty1 res=3Dsuccess'
Feb 06 08:53:47 archvm audit[525]: CRED_ACQ pid=3D525 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'op=3DPAM:setcred grantors=3Dpam_permit acct=3D=
"gdm" exe=3D"/usr/lib/gdm-session-worker" hostname=3Darchvm addr=3D? termin=
al=3D/dev/tty1 res=3Dsuccess'
Feb 06 08:53:47 archvm audit[525]: SYSCALL arch=3Dc000003e syscall=3D1 succ=
ess=3Dyes exit=3D3 a0=3D8 a1=3D7ffd94f5daa0 a2=3D3 a3=3D0 items=3D0 ppid=3D=
498 pid=3D525 auid=3D120 uid=3D0 gid=3D120 euid=3D0 suid=3D0 fsuid=3D0 egid=
=3D120 sgid=3D120 fsgid=3D120 tty=3D(none) ses=3D1 comm=3D"gdm-session-wor"=
 exe=3D"/usr/lib/gdm-session-worker" key=3D(null)
Feb 06 08:53:47 archvm audit: PROCTITLE proctitle=3D67646D2D73657373696F6E2=
D776F726B6572205B70616D2F67646D2D6C61756E63682D656E7669726F6E6D656E745D
Feb 06 08:53:47 archvm systemd-logind[468]: New session 1 of user gdm.
Feb 06 08:53:47 archvm systemd[1]: Created slice User Slice of UID 120.
Feb 06 08:53:47 archvm systemd[1]: Starting User Runtime Directory /run/use=
r/120...
Feb 06 08:53:47 archvm systemd[1]: Finished User Runtime Directory /run/use=
r/120.
Feb 06 08:53:47 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Duser-runtime-dir@120 comm=3D"systemd" =
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
Feb 06 08:53:47 archvm systemd[1]: Starting User Manager for UID 120...
Feb 06 08:53:47 archvm audit[533]: USER_ACCT pid=3D533 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'op=3DPAM:accounting grantors=3Dpam_access,pam=
_unix,pam_permit,pam_time acct=3D"gdm" exe=3D"/usr/lib/systemd/systemd-exec=
utor" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:47 archvm audit[533]: CRED_ACQ pid=3D533 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'op=3DPAM:setcred grantors=3D? acct=3D"gdm" exe=
=3D"/usr/lib/systemd/systemd-executor" hostname=3D? addr=3D? terminal=3D? r=
es=3Dfailed'
Feb 06 08:53:47 archvm audit[533]: SYSCALL arch=3Dc000003e syscall=3D1 succ=
ess=3Dyes exit=3D3 a0=3Da a1=3D7ffd1a3c3760 a2=3D3 a3=3D0 items=3D0 ppid=3D=
1 pid=3D533 auid=3D120 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D0=
 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D2 comm=3D"(systemd)" exe=3D"/usr/lib=
/systemd/systemd-executor" key=3D(null)
Feb 06 08:53:47 archvm audit: PROCTITLE proctitle=3D"(systemd)"
Feb 06 08:53:47 archvm (systemd)[533]: pam_warn(systemd-user:setcred): func=
tion=3D[pam_sm_setcred] flags=3D0x8002 service=3D[systemd-user] terminal=3D=
[] user=3D[gdm] ruser=3D[] rhost=3D[]
Feb 06 08:53:47 archvm (systemd)[533]: pam_unix(systemd-user:session): sess=
ion opened for user gdm(uid=3D120) by gdm(uid=3D0)
Feb 06 08:53:47 archvm systemd-logind[468]: New session 2 of user gdm.
Feb 06 08:53:47 archvm audit[533]: USER_START pid=3D533 uid=3D0 auid=3D120 =
ses=3D2 msg=3D'op=3DPAM:session_open grantors=3Dpam_loginuid,pam_loginuid,p=
am_keyinit,pam_systemd_home,pam_limits,pam_unix,pam_permit,pam_mail,pam_uma=
sk,pam_systemd,pam_env acct=3D"gdm" exe=3D"/usr/lib/systemd/systemd-executo=
r" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:47 archvm systemd[533]: Queued start job for default target Ma=
in User Target.
Feb 06 08:53:47 archvm systemd[533]: Created slice User Application Slice.
Feb 06 08:53:47 archvm systemd[533]: Reached target Paths.
Feb 06 08:53:47 archvm systemd[533]: Reached target Timers.
Feb 06 08:53:47 archvm systemd[533]: Starting D-Bus User Message Bus Socket=
=2E..
Feb 06 08:53:47 archvm systemd[533]: Listening on GnuPG network certificate=
 management daemon.
Feb 06 08:53:47 archvm systemd[533]: Listening on GNOME Keyring daemon.
Feb 06 08:53:47 archvm systemd[533]: Listening on GnuPG cryptographic agent=
 and passphrase cache (access for web browsers).
Feb 06 08:53:47 archvm systemd[533]: Listening on GnuPG cryptographic agent=
 and passphrase cache (restricted).
Feb 06 08:53:47 archvm systemd[533]: Listening on GnuPG cryptographic agent=
 (ssh-agent emulation).
Feb 06 08:53:47 archvm systemd[533]: Listening on GnuPG cryptographic agent=
 and passphrase cache.
Feb 06 08:53:47 archvm systemd[533]: Listening on GnuPG public key manageme=
nt service.
Feb 06 08:53:47 archvm systemd[533]: Listening on p11-kit server.
Feb 06 08:53:47 archvm systemd[533]: Listening on PipeWire PulseAudio.
Feb 06 08:53:47 archvm systemd[533]: Listening on PipeWire Multimedia Syste=
m Sockets.
Feb 06 08:53:47 archvm systemd[533]: Listening on D-Bus User Message Bus So=
cket.
Feb 06 08:53:47 archvm systemd[533]: Reached target Sockets.
Feb 06 08:53:47 archvm systemd[533]: Reached target Basic System.
Feb 06 08:53:47 archvm systemd[1]: Started User Manager for UID 120.
Feb 06 08:53:47 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Duser@120 comm=3D"systemd" exe=3D"/usr/=
lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:47 archvm systemd[533]: Starting Update XDG user dir configura=
tion...
Feb 06 08:53:47 archvm systemd[1]: Started Session 1 of User gdm.
Feb 06 08:53:47 archvm audit[525]: USER_START pid=3D525 uid=3D0 auid=3D120 =
ses=3D1 msg=3D'op=3DPAM:session_open grantors=3Dpam_loginuid,pam_keyinit,pa=
m_succeed_if,pam_permit,pam_systemd,pam_env acct=3D"gdm" exe=3D"/usr/lib/gd=
m-session-worker" hostname=3Darchvm addr=3D? terminal=3D/dev/tty1 res=3Dsuc=
cess'
Feb 06 08:53:47 archvm systemd[533]: Finished Update XDG user dir configura=
tion.
Feb 06 08:53:47 archvm systemd[533]: Reached target Main User Target.
Feb 06 08:53:47 archvm systemd[533]: Startup finished in 219ms.
Feb 06 08:53:47 archvm systemd[533]: Created slice User Core Session Slice.
Feb 06 08:53:47 archvm systemd[533]: Starting D-Bus User Message Bus...
Feb 06 08:53:47 archvm dbus-broker-launch[548]: Policy to allow eavesdroppi=
ng in /usr/share/dbus-1/session.conf +31: Eavesdropping is deprecated and i=
gnored
Feb 06 08:53:47 archvm dbus-broker-launch[548]: Policy to allow eavesdroppi=
ng in /usr/share/dbus-1/session.conf +33: Eavesdropping is deprecated and i=
gnored
Feb 06 08:53:47 archvm systemd[533]: Started D-Bus User Message Bus.
Feb 06 08:53:47 archvm dbus-broker-launch[548]: Ready
Feb 06 08:53:47 archvm NetworkManager[462]:   [1738792427.9220] manager: Ne=
tworkManager state is now CONNECTED_GLOBAL
Feb 06 08:53:47 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Activating service name=3D'org.fre=
edesktop.systemd1' requested by ':1.2' (uid=3D120 pid=3D553 comm=3D"/usr/li=
b/gnome-session-binary --autostart /usr/sha")
Feb 06 08:53:47 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Activated service 'org.freedesktop=
=2Esystemd1' failed: Process org.freedesktop.systemd1 exited with status 1
Feb 06 08:53:47 archvm gnome-session[553]: gnome-session-binary[553]: WARNI=
NG: Could not check if unit gnome-session-wayland@gnome-login.target is act=
ive: Error calling StartServiceByName for org.freedesktop.systemd1: Process=
 org.freedesktop.systemd1 exited with status 1
Feb 06 08:53:47 archvm gnome-session-binary[553]: WARNING: Could not check =
if unit gnome-session-wayland@gnome-login.target is active: Error calling S=
tartServiceByName for org.freedesktop.systemd1: Process org.freedesktop.sys=
temd1 exited with status 1
Feb 06 08:53:48 archvm gnome-shell[565]: Running GNOME Shell (using mutter =
47.5) as a Wayland display server
Feb 06 08:53:48 archvm systemd[1]: Starting RealtimeKit Scheduling Policy S=
ervice...
Feb 06 08:53:48 archvm systemd[1]: Started RealtimeKit Scheduling Policy Se=
rvice.
Feb 06 08:53:48 archvm rtkit-daemon[584]: Successfully called chroot.
Feb 06 08:53:48 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Drtkit-daemon comm=3D"systemd" exe=3D"/=
usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:48 archvm rtkit-daemon[584]: Successfully dropped privileges.
Feb 06 08:53:48 archvm rtkit-daemon[584]: Successfully limited resources.
Feb 06 08:53:48 archvm rtkit-daemon[584]: Running.
Feb 06 08:53:48 archvm rtkit-daemon[584]: Watchdog thread running.
Feb 06 08:53:48 archvm rtkit-daemon[584]: Canary thread running.
Feb 06 08:53:48 archvm rtkit-daemon[584]: Supervising 0 threads of 0 proces=
ses of 0 users.
Feb 06 08:53:48 archvm rtkit-daemon[584]: Successfully made thread 583 of p=
rocess 565 owned by '120' high priority at nice level -15.
Feb 06 08:53:48 archvm rtkit-daemon[584]: Supervising 1 threads of 1 proces=
ses of 1 users.
Feb 06 08:53:48 archvm gnome-shell[565]: Thread 'KMS thread' will be using =
high priority scheduling
Feb 06 08:53:48 archvm gnome-shell[565]: Device '/dev/dri/card0' prefers sh=
adow buffer
Feb 06 08:53:48 archvm gnome-shell[565]: Added device '/dev/dri/card0' (nou=
veau) using non-atomic mode setting.
Feb 06 08:53:48 archvm gnome-shell[565]: Created gbm renderer for '/dev/dri=
/card0'
Feb 06 08:53:48 archvm gnome-shell[565]: Boot VGA GPU /dev/dri/card0 select=
ed as primary
Feb 06 08:53:48 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Activating service name=3D'org.a11=
y.Bus' requested by ':1.4' (uid=3D120 pid=3D565 comm=3D"/usr/bin/gnome-shel=
l")
Feb 06 08:53:48 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Successfully activated service 'or=
g.a11y.Bus'
Feb 06 08:53:48 archvm gnome-shell[565]: Using public X11 display :1024, (u=
sing :1025 for managed services)
Feb 06 08:53:48 archvm gnome-shell[565]: Using Wayland display name 'waylan=
d-0'
Feb 06 08:53:48 archvm /usr/lib/gdm-wayland-session[603]: dbus-daemon[603]:=
 Activating service name=3D'org.a11y.atspi.Registry' requested by ':1.0' (u=
id=3D120 pid=3D565 comm=3D"/usr/bin/gnome-shell")
Feb 06 08:53:48 archvm systemd[1]: Starting Manage, Install and Generate Co=
lor Profiles...
Feb 06 08:53:48 archvm /usr/lib/gdm-wayland-session[603]: dbus-daemon[603]:=
 Successfully activated service 'org.a11y.atspi.Registry'
Feb 06 08:53:48 archvm /usr/lib/gdm-wayland-session[606]: SpiRegistry daemo=
n is running with well-known name - org.a11y.atspi.Registry
Feb 06 08:53:48 archvm systemd[1]: Started Manage, Install and Generate Col=
or Profiles.
Feb 06 08:53:48 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dcolord comm=3D"systemd" exe=3D"/usr/li=
b/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:49 archvm gnome-shell[565]: Unset XDG_SESSION_ID, getCurrentSe=
ssionProxy() called outside a user session. Asking logind directly.
Feb 06 08:53:49 archvm gnome-shell[565]: Will monitor session 1
Feb 06 08:53:49 archvm audit: BPF prog-id=3D56 op=3DLOAD
Feb 06 08:53:49 archvm audit: BPF prog-id=3D57 op=3DLOAD
Feb 06 08:53:49 archvm audit: BPF prog-id=3D58 op=3DLOAD
Feb 06 08:53:49 archvm systemd[1]: Starting Locale Service...
Feb 06 08:53:49 archvm dbus-broker-launch[460]: Activation request for 'org=
=2Efreedesktop.Avahi' failed: The systemd unit 'dbus-org.freedesktop.Avahi.=
service' could not be found.
Feb 06 08:53:49 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Activating service name=3D'org.gno=
me.Shell.Screencast' requested by ':1.3' (uid=3D120 pid=3D565 comm=3D"/usr/=
bin/gnome-shell")
Feb 06 08:53:49 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Activating service name=3D'org.fre=
edesktop.impl.portal.PermissionStore' requested by ':1.3' (uid=3D120 pid=3D=
565 comm=3D"/usr/bin/gnome-shell")
Feb 06 08:53:49 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Successfully activated service 'or=
g.freedesktop.impl.portal.PermissionStore'
Feb 06 08:53:49 archvm systemd[1]: Started Locale Service.
Feb 06 08:53:49 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-localed comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
Feb 06 08:53:49 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Activating service name=3D'org.gno=
me.Shell.Notifications' requested by ':1.3' (uid=3D120 pid=3D565 comm=3D"/u=
sr/bin/gnome-shell")
Feb 06 08:53:49 archvm audit: BPF prog-id=3D59 op=3DLOAD
Feb 06 08:53:49 archvm audit: BPF prog-id=3D60 op=3DLOAD
Feb 06 08:53:49 archvm systemd[1]: Starting Daemon for power management...
Feb 06 08:53:49 archvm gnome-shell[565]: Extension apps-menu@gnome-shell-ex=
tensions.gcampax.github.com already installed in /usr/share/gnome-shell/ext=
ensions/apps-menu@gnome-shell-extensions.gcampax.github.com. /usr/share/gno=
me-shell/extensions/apps-menu@gnome-shell-extensions.gcampax.github.com wil=
l not be loaded
Feb 06 08:53:49 archvm gnome-shell[565]: Extension auto-move-windows@gnome-=
shell-extensions.gcampax.github.com already installed in /usr/share/gnome-s=
hell/extensions/auto-move-windows@gnome-shell-extensions.gcampax.github.com=
=2E /usr/share/gnome-shell/extensions/auto-move-windows@gnome-shell-extensi=
ons.gcampax.github.com will not be loaded
Feb 06 08:53:49 archvm gnome-shell[565]: Extension drive-menu@gnome-shell-e=
xtensions.gcampax.github.com already installed in /usr/share/gnome-shell/ex=
tensions/drive-menu@gnome-shell-extensions.gcampax.github.com. /usr/share/g=
nome-shell/extensions/drive-menu@gnome-shell-extensions.gcampax.github.com =
will not be loaded
Feb 06 08:53:49 archvm gnome-shell[565]: Extension launch-new-instance@gnom=
e-shell-extensions.gcampax.github.com already installed in /usr/share/gnome=
-shell/extensions/launch-new-instance@gnome-shell-extensions.gcampax.github=
=2Ecom. /usr/share/gnome-shell/extensions/launch-new-instance@gnome-shell-e=
xtensions.gcampax.github.com will not be loaded
Feb 06 08:53:49 archvm gnome-shell[565]: Extension light-style@gnome-shell-=
extensions.gcampax.github.com already installed in /usr/share/gnome-shell/e=
xtensions/light-style@gnome-shell-extensions.gcampax.github.com. /usr/share=
/gnome-shell/extensions/light-style@gnome-shell-extensions.gcampax.github.c=
om will not be loaded
Feb 06 08:53:49 archvm gnome-shell[565]: Extension native-window-placement@=
gnome-shell-extensions.gcampax.github.com already installed in /usr/share/g=
nome-shell/extensions/native-window-placement@gnome-shell-extensions.gcampa=
x.github.com. /usr/share/gnome-shell/extensions/native-window-placement@gno=
me-shell-extensions.gcampax.github.com will not be loaded
Feb 06 08:53:49 archvm gnome-shell[565]: Extension places-menu@gnome-shell-=
extensions.gcampax.github.com already installed in /usr/share/gnome-shell/e=
xtensions/places-menu@gnome-shell-extensions.gcampax.github.com. /usr/share=
/gnome-shell/extensions/places-menu@gnome-shell-extensions.gcampax.github.c=
om will not be loaded
Feb 06 08:53:49 archvm gnome-shell[565]: Extension screenshot-window-sizer@=
gnome-shell-extensions.gcampax.github.com already installed in /usr/share/g=
nome-shell/extensions/screenshot-window-sizer@gnome-shell-extensions.gcampa=
x.github.com. /usr/share/gnome-shell/extensions/screenshot-window-sizer@gno=
me-shell-extensions.gcampax.github.com will not be loaded
Feb 06 08:53:49 archvm gnome-shell[565]: Extension status-icons@gnome-shell=
-extensions.gcampax.github.com already installed in /usr/share/gnome-shell/=
extensions/status-icons@gnome-shell-extensions.gcampax.github.com. /usr/sha=
re/gnome-shell/extensions/status-icons@gnome-shell-extensions.gcampax.githu=
b.com will not be loaded
Feb 06 08:53:49 archvm gnome-shell[565]: Extension system-monitor@gnome-she=
ll-extensions.gcampax.github.com already installed in /usr/share/gnome-shel=
l/extensions/system-monitor@gnome-shell-extensions.gcampax.github.com. /usr=
/share/gnome-shell/extensions/system-monitor@gnome-shell-extensions.gcampax=
=2Egithub.com will not be loaded
Feb 06 08:53:49 archvm gnome-shell[565]: Extension user-theme@gnome-shell-e=
xtensions.gcampax.github.com already installed in /usr/share/gnome-shell/ex=
tensions/user-theme@gnome-shell-extensions.gcampax.github.com. /usr/share/g=
nome-shell/extensions/user-theme@gnome-shell-extensions.gcampax.github.com =
will not be loaded
Feb 06 08:53:49 archvm gnome-shell[565]: Extension window-list@gnome-shell-=
extensions.gcampax.github.com already installed in /usr/share/gnome-shell/e=
xtensions/window-list@gnome-shell-extensions.gcampax.github.com. /usr/share=
/gnome-shell/extensions/window-list@gnome-shell-extensions.gcampax.github.c=
om will not be loaded
Feb 06 08:53:49 archvm gnome-shell[565]: Extension windowsNavigator@gnome-s=
hell-extensions.gcampax.github.com already installed in /usr/share/gnome-sh=
ell/extensions/windowsNavigator@gnome-shell-extensions.gcampax.github.com. =
/usr/share/gnome-shell/extensions/windowsNavigator@gnome-shell-extensions.g=
campax.github.com will not be loaded
Feb 06 08:53:49 archvm gnome-shell[565]: Extension workspace-indicator@gnom=
e-shell-extensions.gcampax.github.com already installed in /usr/share/gnome=
-shell/extensions/workspace-indicator@gnome-shell-extensions.gcampax.github=
=2Ecom. /usr/share/gnome-shell/extensions/workspace-indicator@gnome-shell-e=
xtensions.gcampax.github.com will not be loaded
Feb 06 08:53:49 archvm org.gnome.Shell.desktop[565]: Window manager warning=
: Failed to parse saved session file: Failed to open file =E2=80=9C/var/lib=
/gdm/.config/mutter/sessions/1011029c3265d9c4af1738792427974095000000055300=
00.ms=E2=80=9D: No such file or directory
Feb 06 08:53:49 archvm gnome-shell[565]: Failed to launch ibus-daemon: Fail=
ed to execute child process =E2=80=9Cibus-daemon=E2=80=9D (No such file or =
directory)
Feb 06 08:53:49 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Successfully activated service 'or=
g.gnome.Shell.Notifications'
Feb 06 08:53:49 archvm polkitd[509]: Registered Authentication Agent for un=
ix-session:1 (system bus name :1.19 [/usr/bin/gnome-shell], object path /or=
g/freedesktop/PolicyKit1/AuthenticationAgent, locale en_AU.UTF-8)
Feb 06 08:53:49 archvm gnome-shell[565]: Error looking up permission: GDBus=
=2EError:org.freedesktop.portal.Error.NotFound: No entry for geolocation
Feb 06 08:53:49 archvm kernel: rfkill: input handler disabled
Feb 06 08:53:49 archvm NetworkManager[462]:   [1738792429.4317] agent-manag=
er: agent[4a2a1c97cbef3c0f,:1.19/org.gnome.Shell.NetworkAgent/120]: agent r=
egistered
Feb 06 08:53:49 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Activating service name=3D'org.fre=
edesktop.systemd1' requested by ':1.10' (uid=3D120 pid=3D664 comm=3D"/usr/l=
ib/gsd-sharing")
Feb 06 08:53:49 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Activated service 'org.freedesktop=
=2Esystemd1' failed: Process org.freedesktop.systemd1 exited with status 1
Feb 06 08:53:49 archvm gsd-sharing[664]: Failed to StopUnit service: GDBus.=
Error:org.freedesktop.DBus.Error.Spawn.ChildExited: Process org.freedesktop=
=2Esystemd1 exited with status 1
Feb 06 08:53:49 archvm gsd-sharing[664]: Failed to StopUnit service: GDBus.=
Error:org.freedesktop.DBus.Error.Spawn.ChildExited: Process org.freedesktop=
=2Esystemd1 exited with status 1
Feb 06 08:53:49 archvm systemd[1]: Started Daemon for power management.
Feb 06 08:53:49 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dupower comm=3D"systemd" exe=3D"/usr/li=
b/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:49 archvm systemd[533]: Started PipeWire Multimedia Service.
Feb 06 08:53:49 archvm systemd[533]: Started Multimedia Service Session Man=
ager.
Feb 06 08:53:49 archvm systemd[533]: Started PipeWire PulseAudio.
Feb 06 08:53:49 archvm systemd[1]: Starting Location Lookup Service...
Feb 06 08:53:49 archvm rtkit-daemon[584]: Supervising 1 threads of 1 proces=
ses of 1 users.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Supervising 1 threads of 1 proces=
ses of 1 users.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Supervising 1 threads of 1 proces=
ses of 1 users.
Feb 06 08:53:49 archvm wireplumber[833]: wp-internal-comp-loader: Loading p=
rofile 'main'
Feb 06 08:53:49 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Successfully activated service 'or=
g.gnome.Shell.Screencast'
Feb 06 08:53:49 archvm rtkit-daemon[584]: Successfully made thread 831 of p=
rocess 831 owned by '120' high priority at nice level -11.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Supervising 2 threads of 2 proces=
ses of 1 users.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Successfully made thread 847 of p=
rocess 831 owned by '120' RT at priority 20.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Supervising 3 threads of 2 proces=
ses of 1 users.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Supervising 3 threads of 2 proces=
ses of 1 users.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Supervising 3 threads of 2 proces=
ses of 1 users.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Supervising 3 threads of 2 proces=
ses of 1 users.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Supervising 3 threads of 2 proces=
ses of 1 users.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Supervising 3 threads of 2 proces=
ses of 1 users.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Supervising 3 threads of 2 proces=
ses of 1 users.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Successfully made thread 839 of p=
rocess 839 owned by '120' high priority at nice level -11.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Supervising 4 threads of 3 proces=
ses of 1 users.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Successfully made thread 857 of p=
rocess 839 owned by '120' RT at priority 20.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Supervising 5 threads of 3 proces=
ses of 1 users.
Feb 06 08:53:49 archvm gnome-shell[565]: Failed to launch ibus-daemon: Fail=
ed to execute child process =E2=80=9Cibus-daemon=E2=80=9D (No such file or =
directory)
Feb 06 08:53:49 archvm rtkit-daemon[584]: Successfully made thread 833 of p=
rocess 833 owned by '120' high priority at nice level -11.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Supervising 6 threads of 4 proces=
ses of 1 users.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Successfully made thread 863 of p=
rocess 833 owned by '120' RT at priority 20.
Feb 06 08:53:49 archvm rtkit-daemon[584]: Supervising 7 threads of 4 proces=
ses of 1 users.
Feb 06 08:53:49 archvm systemd[1]: Starting WPA supplicant...
Feb 06 08:53:49 archvm org.gnome.Shell.desktop[881]: The XKEYBOARD keymap c=
ompiler (xkbcomp) reports:
Feb 06 08:53:49 archvm org.gnome.Shell.desktop[881]: > Warning:          Un=
supported maximum keycode 708, clipping.
Feb 06 08:53:49 archvm org.gnome.Shell.desktop[881]: >                   X1=
1 cannot support keycodes above 255.
Feb 06 08:53:49 archvm org.gnome.Shell.desktop[881]: > Warning:          Co=
uld not resolve keysym XF86KbdInputAssistPrevgrou
Feb 06 08:53:49 archvm org.gnome.Shell.desktop[881]: > Warning:          Co=
uld not resolve keysym XF86KbdInputAssistNextgrou
Feb 06 08:53:49 archvm org.gnome.Shell.desktop[881]: Errors from xkbcomp ar=
e not fatal to the X server
Feb 06 08:53:49 archvm systemd[1]: Started WPA supplicant.
Feb 06 08:53:49 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dwpa_supplicant comm=3D"systemd" exe=3D=
"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:49 archvm wpa_supplicant[882]: Successfully initialized wpa_su=
pplicant
Feb 06 08:53:49 archvm geoclue[844]: Failed to connect to avahi service: Da=
emon not running
Feb 06 08:53:49 archvm systemd[1]: Started Location Lookup Service.
Feb 06 08:53:49 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dgeoclue comm=3D"systemd" exe=3D"/usr/l=
ib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:49 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Activating service name=3D'org.fre=
edesktop.portal.Desktop' requested by ':1.32' (uid=3D120 pid=3D864 comm=3D"=
/usr/lib/mutter-x11-frames")
Feb 06 08:53:49 archvm gnome-session-binary[553]: Entering running state
Feb 06 08:53:49 archvm xbrlapi.desktop[898]: openConnection: connect: No su=
ch file or directory
Feb 06 08:53:49 archvm xbrlapi.desktop[898]: cannot connect to braille devi=
ces daemon brltty at :0
Feb 06 08:53:49 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Activating service name=3D'org.fre=
edesktop.portal.Documents' requested by ':1.33' (uid=3D120 pid=3D896 comm=
=3D"/usr/lib/xdg-desktop-portal")
Feb 06 08:53:49 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Successfully activated service 'or=
g.freedesktop.portal.Documents'
Feb 06 08:53:49 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Activating service name=3D'org.fre=
edesktop.impl.portal.desktop.gnome' requested by ':1.33' (uid=3D120 pid=3D8=
96 comm=3D"/usr/lib/xdg-desktop-portal")
Feb 06 08:53:49 archvm wireplumber[833]: spa.bluez5: BlueZ system service i=
s not available
Feb 06 08:53:49 archvm wireplumber[833]: wp-device: SPA handle 'api.libcame=
ra.enum.manager' could not be loaded; is it installed?
Feb 06 08:53:49 archvm wireplumber[833]: s-monitors-libcamera: PipeWire's l=
ibcamera SPA plugin is missing or broken. Some camera types may not be supp=
orted.
Feb 06 08:53:49 archvm gsd-media-keys[706]: Unable to get default sink
Feb 06 08:53:49 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Activating service name=3D'org.gno=
me.ScreenSaver' requested by ':1.23' (uid=3D120 pid=3D751 comm=3D"/usr/lib/=
gsd-power")
Feb 06 08:53:49 archvm gsd-media-keys[706]: Failed to grab accelerator for =
keybinding settings:playback-repeat
Feb 06 08:53:49 archvm gsd-media-keys[706]: Failed to grab accelerator for =
keybinding settings:hibernate
Feb 06 08:53:49 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Successfully activated service 'or=
g.gnome.ScreenSaver'
Feb 06 08:53:50 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Successfully activated service 'or=
g.freedesktop.impl.portal.desktop.gnome'
Feb 06 08:53:50 archvm rtkit-daemon[584]: Supervising 7 threads of 4 proces=
ses of 1 users.
Feb 06 08:53:50 archvm rtkit-daemon[584]: Supervising 7 threads of 4 proces=
ses of 1 users.
Feb 06 08:53:50 archvm rtkit-daemon[584]: Supervising 7 threads of 4 proces=
ses of 1 users.
Feb 06 08:53:50 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Activating service name=3D'org.fre=
edesktop.impl.portal.desktop.gtk' requested by ':1.33' (uid=3D120 pid=3D896=
 comm=3D"/usr/lib/xdg-desktop-portal")
Feb 06 08:53:50 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Successfully activated service 'or=
g.freedesktop.impl.portal.desktop.gtk'
Feb 06 08:53:50 archvm /usr/lib/gdm-wayland-session[552]: dbus-daemon[552]:=
 [session uid=3D120 pid=3D552 pidfd=3D5] Activating service name=3D'org.fre=
edesktop.secrets' requested by ':1.33' (uid=3D120 pid=3D896 comm=3D"/usr/li=
b/xdg-desktop-portal")
Feb 06 08:53:50 archvm systemd[533]: Started GNOME Keyring daemon.
Feb 06 08:53:50 archvm gnome-shell[565]: Registering session with GDM
Feb 06 08:53:50 archvm gnome-keyring-daemon[969]: GNOME_KEYRING_CONTROL=3D/=
run/user/120/keyring
Feb 06 08:53:50 archvm gnome-keyring-daemon[969]: The Secret Service was al=
ready initialized
Feb 06 08:53:50 archvm gnome-keyring-d[969]: The Secret Service was already=
 initialized
Feb 06 08:53:50 archvm /usr/lib/gdm-wayland-session[968]: GNOME_KEYRING_CON=
TROL=3D/run/user/120/keyring
Feb 06 08:53:50 archvm gnome-keyring-daemon[968]: discover_other_daemon: 1
Feb 06 08:53:57 archvm systemd[1]: NetworkManager-dispatcher.service: Deact=
ivated successfully.
Feb 06 08:53:57 archvm kernel: kauditd_printk_skb: 46 callbacks suppressed
Feb 06 08:53:57 archvm kernel: audit: type=3D1131 audit(1738792437.258:114)=
: pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3DNetworkM=
anager-dispatcher comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostnam=
e=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:57 archvm audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'unit=3DNetworkManager-dispatcher comm=3D"syste=
md" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=
=3Dsuccess'
Feb 06 08:53:58 archvm gdm-password][978]: gkr-pam: unable to locate daemon=
 control file
Feb 06 08:53:58 archvm audit[978]: USER_AUTH pid=3D978 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'op=3DPAM:authentication grantors=3Dpam_shells=
,pam_faillock,pam_permit,pam_faillock,pam_gnome_keyring acct=3D"arch" exe=
=3D"/usr/lib/gdm-session-worker" hostname=3Darchvm addr=3D? terminal=3D/dev=
/tty1 res=3Dsuccess'
Feb 06 08:53:58 archvm gdm-password][978]: gkr-pam: stashed password to try=
 later in open session
Feb 06 08:53:58 archvm kernel: audit: type=3D1100 audit(1738792438.847:115)=
: pid=3D978 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:auth=
entication grantors=3Dpam_shells,pam_faillock,pam_permit,pam_faillock,pam_g=
nome_keyring acct=3D"arch" exe=3D"/usr/lib/gdm-session-worker" hostname=3Da=
rchvm addr=3D? terminal=3D/dev/tty1 res=3Dsuccess'
Feb 06 08:53:58 archvm audit[978]: USER_ACCT pid=3D978 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'op=3DPAM:accounting grantors=3Dpam_access,pam=
_unix,pam_permit,pam_time acct=3D"arch" exe=3D"/usr/lib/gdm-session-worker"=
 hostname=3Darchvm addr=3D? terminal=3D/dev/tty1 res=3Dsuccess'
Feb 06 08:53:58 archvm kernel: audit: type=3D1101 audit(1738792438.850:116)=
: pid=3D978 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:acco=
unting grantors=3Dpam_access,pam_unix,pam_permit,pam_time acct=3D"arch" exe=
=3D"/usr/lib/gdm-session-worker" hostname=3Darchvm addr=3D? terminal=3D/dev=
/tty1 res=3Dsuccess'
Feb 06 08:53:58 archvm audit[978]: CRED_ACQ pid=3D978 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'op=3DPAM:setcred grantors=3Dpam_shells,pam_fai=
llock,pam_permit,pam_faillock,pam_gnome_keyring acct=3D"arch" exe=3D"/usr/l=
ib/gdm-session-worker" hostname=3Darchvm addr=3D? terminal=3D/dev/tty1 res=
=3Dsuccess'
Feb 06 08:53:58 archvm kernel: audit: type=3D1103 audit(1738792438.852:117)=
: pid=3D978 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setc=
red grantors=3Dpam_shells,pam_faillock,pam_permit,pam_faillock,pam_gnome_ke=
yring acct=3D"arch" exe=3D"/usr/lib/gdm-session-worker" hostname=3Darchvm a=
ddr=3D? terminal=3D/dev/tty1 res=3Dsuccess'
Feb 06 08:53:58 archvm audit[978]: SYSCALL arch=3Dc000003e syscall=3D1 succ=
ess=3Dyes exit=3D4 a0=3Db a1=3D7ffd3b980060 a2=3D4 a3=3D0 items=3D0 ppid=3D=
498 pid=3D978 auid=3D1000 uid=3D0 gid=3D1000 euid=3D0 suid=3D0 fsuid=3D0 eg=
id=3D1000 sgid=3D1000 fsgid=3D1000 tty=3D(none) ses=3D3 comm=3D"gdm-session=
-wor" exe=3D"/usr/lib/gdm-session-worker" key=3D(null)
Feb 06 08:53:58 archvm audit: PROCTITLE proctitle=3D67646D2D73657373696F6E2=
D776F726B6572205B70616D2F67646D2D70617373776F72645D
Feb 06 08:53:58 archvm gdm-password][978]: pam_unix(gdm-password:session): =
session opened for user arch(uid=3D1000) by arch(uid=3D0)
Feb 06 08:53:58 archvm kernel: audit: type=3D1006 audit(1738792438.853:118)=
: pid=3D978 uid=3D0 old-auid=3D4294967295 auid=3D1000 tty=3D(none) old-ses=
=3D4294967295 ses=3D3 res=3D1
Feb 06 08:53:58 archvm kernel: audit: type=3D1300 audit(1738792438.853:118)=
: arch=3Dc000003e syscall=3D1 success=3Dyes exit=3D4 a0=3Db a1=3D7ffd3b9800=
60 a2=3D4 a3=3D0 items=3D0 ppid=3D498 pid=3D978 auid=3D1000 uid=3D0 gid=3D1=
000 euid=3D0 suid=3D0 fsuid=3D0 egid=3D1000 sgid=3D1000 fsgid=3D1000 tty=3D=
(none) ses=3D3 comm=3D"gdm-session-wor" exe=3D"/usr/lib/gdm-session-worker"=
 key=3D(null)
Feb 06 08:53:58 archvm kernel: audit: type=3D1327 audit(1738792438.853:118)=
: proctitle=3D67646D2D73657373696F6E2D776F726B6572205B70616D2F67646D2D70617=
373776F72645D
Feb 06 08:53:58 archvm systemd-logind[468]: New session 3 of user arch.
Feb 06 08:53:58 archvm systemd[1]: Created slice User Slice of UID 1000.
Feb 06 08:53:58 archvm systemd[1]: Starting User Runtime Directory /run/use=
r/1000...
Feb 06 08:53:58 archvm systemd[1]: Finished User Runtime Directory /run/use=
r/1000.
Feb 06 08:53:58 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Duser-runtime-dir@1000 comm=3D"systemd"=
 exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
Feb 06 08:53:58 archvm kernel: audit: type=3D1130 audit(1738792438.886:119)=
: pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Duser-run=
time-dir@1000 comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D=
? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:58 archvm systemd[1]: Starting User Manager for UID 1000...
Feb 06 08:53:58 archvm audit[990]: USER_ACCT pid=3D990 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'op=3DPAM:accounting grantors=3Dpam_access,pam=
_unix,pam_permit,pam_time acct=3D"arch" exe=3D"/usr/lib/systemd/systemd-exe=
cutor" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:58 archvm kernel: audit: type=3D1101 audit(1738792438.912:120)=
: pid=3D990 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:acco=
unting grantors=3Dpam_access,pam_unix,pam_permit,pam_time acct=3D"arch" exe=
=3D"/usr/lib/systemd/systemd-executor" hostname=3D? addr=3D? terminal=3D? r=
es=3Dsuccess'
Feb 06 08:53:58 archvm kernel: audit: type=3D1103 audit(1738792438.912:121)=
: pid=3D990 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:setc=
red grantors=3D? acct=3D"arch" exe=3D"/usr/lib/systemd/systemd-executor" ho=
stname=3D? addr=3D? terminal=3D? res=3Dfailed'
Feb 06 08:53:58 archvm audit[990]: CRED_ACQ pid=3D990 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'op=3DPAM:setcred grantors=3D? acct=3D"arch" ex=
e=3D"/usr/lib/systemd/systemd-executor" hostname=3D? addr=3D? terminal=3D? =
res=3Dfailed'
Feb 06 08:53:58 archvm audit[990]: SYSCALL arch=3Dc000003e syscall=3D1 succ=
ess=3Dyes exit=3D4 a0=3Da a1=3D7ffc4c3222c0 a2=3D4 a3=3D0 items=3D0 ppid=3D=
1 pid=3D990 auid=3D1000 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=3D=
0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D4 comm=3D"(systemd)" exe=3D"/usr/li=
b/systemd/systemd-executor" key=3D(null)
Feb 06 08:53:58 archvm audit: PROCTITLE proctitle=3D"(systemd)"
Feb 06 08:53:58 archvm (systemd)[990]: pam_warn(systemd-user:setcred): func=
tion=3D[pam_sm_setcred] flags=3D0x8002 service=3D[systemd-user] terminal=3D=
[] user=3D[arch] ruser=3D[] rhost=3D[]
Feb 06 08:53:58 archvm (systemd)[990]: pam_unix(systemd-user:session): sess=
ion opened for user arch(uid=3D1000) by arch(uid=3D0)
Feb 06 08:53:58 archvm systemd-logind[468]: New session 4 of user arch.
Feb 06 08:53:58 archvm audit[990]: USER_START pid=3D990 uid=3D0 auid=3D1000=
 ses=3D4 msg=3D'op=3DPAM:session_open grantors=3Dpam_loginuid,pam_loginuid,=
pam_keyinit,pam_systemd_home,pam_limits,pam_unix,pam_permit,pam_mail,pam_um=
ask,pam_systemd,pam_env acct=3D"arch" exe=3D"/usr/lib/systemd/systemd-execu=
tor" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:59 archvm systemd[990]: Queued start job for default target Ma=
in User Target.
Feb 06 08:53:59 archvm systemd-journald[314]: File /var/log/journal/8f1b161=
d188e41219ae9cfb088b4379d/user-1000.journal corrupted or uncleanly shut dow=
n, renaming and replacing.
Feb 06 08:53:59 archvm systemd[990]: Created slice User Application Slice.
Feb 06 08:53:59 archvm systemd[990]: Reached target Paths.
Feb 06 08:53:59 archvm systemd[990]: Reached target Timers.
Feb 06 08:53:59 archvm systemd[990]: Starting D-Bus User Message Bus Socket=
=2E..
Feb 06 08:53:59 archvm systemd[990]: Listening on GnuPG network certificate=
 management daemon.
Feb 06 08:53:59 archvm systemd[990]: Listening on GNOME Keyring daemon.
Feb 06 08:53:59 archvm systemd[990]: Listening on GnuPG cryptographic agent=
 and passphrase cache (access for web browsers).
Feb 06 08:53:59 archvm systemd[990]: Listening on GnuPG cryptographic agent=
 and passphrase cache (restricted).
Feb 06 08:53:59 archvm systemd[990]: Listening on GnuPG cryptographic agent=
 (ssh-agent emulation).
Feb 06 08:53:59 archvm systemd[990]: Listening on GnuPG cryptographic agent=
 and passphrase cache.
Feb 06 08:53:59 archvm systemd[990]: Listening on GnuPG public key manageme=
nt service.
Feb 06 08:53:59 archvm systemd[990]: Listening on p11-kit server.
Feb 06 08:53:59 archvm systemd[990]: Listening on PipeWire PulseAudio.
Feb 06 08:53:59 archvm systemd[990]: Listening on PipeWire Multimedia Syste=
m Sockets.
Feb 06 08:53:59 archvm systemd[990]: Listening on D-Bus User Message Bus So=
cket.
Feb 06 08:53:59 archvm systemd[990]: Reached target Sockets.
Feb 06 08:53:59 archvm systemd[990]: Reached target Basic System.
Feb 06 08:53:59 archvm systemd[1]: Started User Manager for UID 1000.
Feb 06 08:53:59 archvm systemd[990]: Starting Update XDG user dir configura=
tion...
Feb 06 08:53:59 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Duser@1000 comm=3D"systemd" exe=3D"/usr=
/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:53:59 archvm systemd[1]: Started Session 3 of User arch.
Feb 06 08:53:59 archvm systemd[990]: Started GNOME Keyring daemon.
Feb 06 08:53:59 archvm systemd[990]: Finished Update XDG user dir configura=
tion.
Feb 06 08:53:59 archvm systemd[990]: Reached target Main User Target.
Feb 06 08:53:59 archvm systemd[990]: Startup finished in 169ms.
Feb 06 08:53:59 archvm gnome-keyring-daemon[1002]: GNOME_KEYRING_CONTROL=3D=
/run/user/1000/keyring
Feb 06 08:53:59 archvm systemd[990]: Created slice User Core Session Slice.
Feb 06 08:53:59 archvm systemd[990]: Starting D-Bus User Message Bus...
Feb 06 08:53:59 archvm dbus-broker-launch[1008]: Policy to allow eavesdropp=
ing in /usr/share/dbus-1/session.conf +31: Eavesdropping is deprecated and =
ignored
Feb 06 08:53:59 archvm dbus-broker-launch[1008]: Policy to allow eavesdropp=
ing in /usr/share/dbus-1/session.conf +33: Eavesdropping is deprecated and =
ignored
Feb 06 08:53:59 archvm systemd[990]: Started D-Bus User Message Bus.
Feb 06 08:53:59 archvm dbus-broker-launch[1008]: Ready
Feb 06 08:53:59 archvm gdm-password][978]: gkr-pam: unlocked login keyring
Feb 06 08:53:59 archvm audit[978]: USER_START pid=3D978 uid=3D0 auid=3D1000=
 ses=3D3 msg=3D'op=3DPAM:session_open grantors=3Dpam_loginuid,pam_keyinit,p=
am_systemd_home,pam_limits,pam_unix,pam_permit,pam_mail,pam_umask,pam_syste=
md,pam_env,pam_gnome_keyring acct=3D"arch" exe=3D"/usr/lib/gdm-session-work=
er" hostname=3Darchvm addr=3D? terminal=3D/dev/tty2 res=3Dsuccess'
Feb 06 08:53:59 archvm kernel: rfkill: input handler enabled
Feb 06 08:53:59 archvm gsd-media-keys[706]: Unable to get default source
Feb 06 08:53:59 archvm gsd-media-keys[706]: Unable to get default sink
Feb 06 08:53:59 archvm systemd[990]: Created slice Slice /app/gnome-session=
-manager.
Feb 06 08:53:59 archvm systemd[990]: Reached target GNOME Wayland Session.
Feb 06 08:53:59 archvm systemd[990]: Reached target Session services which =
should run early before the graphical session is brought up.
Feb 06 08:53:59 archvm systemd[990]: Reached target GNOME Shell.
Feb 06 08:53:59 archvm systemd[990]: Starting Monitor Session leader for GN=
OME Session...
Feb 06 08:53:59 archvm systemd[990]: Started Monitor Session leader for GNO=
ME Session.
Feb 06 08:53:59 archvm systemd[990]: Reached target Tasks to be run before =
GNOME Session starts.
Feb 06 08:53:59 archvm systemd[990]: Starting GNOME Session Manager (sessio=
n: gnome)...
Feb 06 08:53:59 archvm gnome-keyring-daemon[1080]: discover_other_daemon: 1
Feb 06 08:53:59 archvm gnome-keyring-ssh.desktop[1080]: discover_other_daem=
on: 1GNOME_KEYRING_CONTROL=3D/run/user/1000/keyring
Feb 06 08:53:59 archvm gnome-keyring-daemon[1002]: The Secret Service was a=
lready initialized
Feb 06 08:53:59 archvm gnome-keyring-d[1002]: The Secret Service was alread=
y initialized
Feb 06 08:53:59 archvm gnome-keyring-daemon[1082]: discover_other_daemon: 1
Feb 06 08:53:59 archvm gnome-keyring-secrets.desktop[1082]: discover_other_=
daemon: 1GNOME_KEYRING_CONTROL=3D/run/user/1000/keyring
Feb 06 08:53:59 archvm gnome-keyring-daemon[1002]: The PKCS#11 component wa=
s already initialized
Feb 06 08:53:59 archvm gnome-keyring-d[1002]: The PKCS#11 component was alr=
eady initialized
Feb 06 08:53:59 archvm gnome-keyring-daemon[1083]: discover_other_daemon: 1
Feb 06 08:53:59 archvm gnome-keyring-pkcs11.desktop[1083]: discover_other_d=
aemon: 1GNOME_KEYRING_CONTROL=3D/run/user/1000/keyring
Feb 06 08:53:59 archvm gnome-session[1063]: gnome-session-binary[1063]: Gno=
meDesktop-WARNING: Could not create transient scope for PID 1076: GDBus.Err=
or:org.freedesktop.DBus.Error.UnixProcessIdUnknown: Failed to set unit prop=
erties: No such process
Feb 06 08:53:59 archvm gnome-session-binary[1063]: GnomeDesktop-WARNING: Co=
uld not create transient scope for PID 1076: GDBus.Error:org.freedesktop.DB=
us.Error.UnixProcessIdUnknown: Failed to set unit properties: No such proce=
ss
Feb 06 08:53:59 archvm systemd[990]: app-gnome-gnome\x2dkeyring\x2dpkcs11-1=
072.scope: PID 1072 vanished before we could move it to target cgroup '/use=
r.slice/user-1000.slice/user@1000.service/app.slice/app-gnome-gnome\x2dkeyr=
ing\x2dpkcs11-1072.scope', skipping: No such process
Feb 06 08:53:59 archvm systemd[990]: app-gnome-gnome\x2dkeyring\x2dpkcs11-1=
072.scope: No PIDs left to attach to the scope's control group, refusing.
Feb 06 08:53:59 archvm systemd[990]: app-gnome-gnome\x2dkeyring\x2dpkcs11-1=
072.scope: Failed with result 'resources'.
Feb 06 08:53:59 archvm systemd[990]: Failed to start Application launched b=
y gnome-session-binary.
Feb 06 08:53:59 archvm systemd[990]: app-gnome-gnome\x2dkeyring\x2dssh-1070=
=2Escope: PID 1070 vanished before we could move it to target cgroup '/user=
=2Eslice/user-1000.slice/user@1000.service/app.slice/app-gnome-gnome\x2dkey=
ring\x2dssh-1070.scope', skipping: No such process
Feb 06 08:53:59 archvm systemd[990]: app-gnome-gnome\x2dkeyring\x2dssh-1070=
=2Escope: No PIDs left to attach to the scope's control group, refusing.
Feb 06 08:53:59 archvm systemd[990]: app-gnome-gnome\x2dkeyring\x2dssh-1070=
=2Escope: Failed with result 'resources'.
Feb 06 08:53:59 archvm systemd[990]: Failed to start Application launched b=
y gnome-session-binary.
Feb 06 08:53:59 archvm systemd[990]: Started GNOME Session Manager (session=
: gnome).
Feb 06 08:53:59 archvm systemd[990]: Reached target GNOME Session Manager i=
s ready.
Feb 06 08:53:59 archvm systemd[990]: Starting GNOME Shell on Wayland...
Feb 06 08:53:59 archvm systemd[990]: GNOME Shell on X11 was skipped because=
 of an unmet condition check (ConditionEnvironment=3DXDG_SESSION_TYPE=3Dx11=
).
Feb 06 08:53:59 archvm systemd[990]: Starting Virtual filesystem service...
Feb 06 08:53:59 archvm systemd[990]: Started Virtual filesystem service.
Feb 06 08:53:59 archvm gnome-shell[1087]: Running GNOME Shell (using mutter=
 47.5) as a Wayland display server
Feb 06 08:53:59 archvm rtkit-daemon[584]: Supervising 7 threads of 4 proces=
ses of 1 users.
Feb 06 08:53:59 archvm rtkit-daemon[584]: Successfully made thread 1117 of =
process 1087 owned by '1000' high priority at nice level -15.
Feb 06 08:53:59 archvm rtkit-daemon[584]: Supervising 8 threads of 5 proces=
ses of 2 users.
Feb 06 08:53:59 archvm gnome-shell[1087]: Thread 'KMS thread' will be using=
 high priority scheduling
Feb 06 08:53:59 archvm gnome-shell[1087]: Device '/dev/dri/card0' prefers s=
hadow buffer
Feb 06 08:54:00 archvm gnome-shell[1087]: Added device '/dev/dri/card0' (no=
uveau) using non-atomic mode setting.
Feb 06 08:54:00 archvm gnome-shell[1087]: Created gbm renderer for '/dev/dr=
i/card0'
Feb 06 08:54:00 archvm gnome-shell[1087]: Boot VGA GPU /dev/dri/card0 selec=
ted as primary
Feb 06 08:54:00 archvm systemd[990]: Starting Accessibility services bus...
Feb 06 08:54:00 archvm systemd[990]: Started Accessibility services bus.
Feb 06 08:54:00 archvm dbus-broker-launch[1132]: Ready
Feb 06 08:54:00 archvm gnome-shell[1087]: Using public X11 display :0, (usi=
ng :1 for managed services)
Feb 06 08:54:00 archvm gnome-shell[1087]: Using Wayland display name 'wayla=
nd-0'
Feb 06 08:54:00 archvm systemd[990]: Created slice Slice /app/dbus-:1.17-or=
g.a11y.atspi.Registry.
Feb 06 08:54:00 archvm systemd[990]: Started dbus-:1.17-org.a11y.atspi.Regi=
stry@0.service.
Feb 06 08:54:00 archvm at-spi2-registryd[1134]: SpiRegistry daemon is runni=
ng with well-known name - org.a11y.atspi.Registry
Feb 06 08:54:00 archvm gnome-shell[1087]: Unset XDG_SESSION_ID, getCurrentS=
essionProxy() called outside a user session. Asking logind directly.
Feb 06 08:54:00 archvm gnome-shell[1087]: Will monitor session 3
Feb 06 08:54:00 archvm systemd[990]: Created slice Slice /app/dbus-:1.2-org=
=2Egnome.Shell.Screencast.
Feb 06 08:54:00 archvm systemd[990]: Started dbus-:1.2-org.gnome.Shell.Scre=
encast@0.service.
Feb 06 08:54:00 archvm systemd[990]: Created slice Slice /app/dbus-:1.2-org=
=2Egnome.Shell.CalendarServer.
Feb 06 08:54:00 archvm systemd[990]: Started dbus-:1.2-org.gnome.Shell.Cale=
ndarServer@0.service.
Feb 06 08:54:00 archvm systemd[990]: Starting sandboxed app permission stor=
e...
Feb 06 08:54:00 archvm systemd[990]: Started sandboxed app permission store.
Feb 06 08:54:00 archvm systemd[990]: Created slice Slice /app/dbus-:1.2-org=
=2Egnome.Shell.Notifications.
Feb 06 08:54:00 archvm systemd[990]: Started dbus-:1.2-org.gnome.Shell.Noti=
fications@0.service.
Feb 06 08:54:00 archvm gnome-shell[1087]: Could not issue 'GetUnit' systemd=
 call
Feb 06 08:54:00 archvm systemd[990]: Starting Evolution source registry...
Feb 06 08:54:00 archvm systemd[990]: Started GNOME Shell on Wayland.
Feb 06 08:54:00 archvm systemd[990]: Reached target GNOME Session is initia=
lized.
Feb 06 08:54:00 archvm systemd[990]: GNOME session X11 services is inactive.
Feb 06 08:54:00 archvm systemd[990]: Dependency failed for GNOME XSettings =
service.
Feb 06 08:54:00 archvm systemd[990]: org.gnome.SettingsDaemon.XSettings.ser=
vice: Job org.gnome.SettingsDaemon.XSettings.service/start failed with resu=
lt 'dependency'.
Feb 06 08:54:00 archvm systemd[990]: gnome-session-x11-services-ready.targe=
t: Job gnome-session-x11-services-ready.target/verify-active failed with re=
sult 'dependency'.
Feb 06 08:54:00 archvm systemd[990]: Reached target GNOME Session (session:=
 gnome).
Feb 06 08:54:00 archvm systemd[990]: Reached target GNOME XSettings target.
Feb 06 08:54:00 archvm systemd[990]: Starting Signal initialization done to=
 GNOME Session Manager...
Feb 06 08:54:00 archvm systemd[990]: Starting GNOME accessibility service...
Feb 06 08:54:00 archvm systemd[990]: Starting GNOME color management servic=
e...
Feb 06 08:54:00 archvm systemd[990]: Starting GNOME date & time service...
Feb 06 08:54:00 archvm systemd[990]: Starting GNOME maintenance of expirabl=
e data service...
Feb 06 08:54:00 archvm systemd[990]: Starting GNOME keyboard configuration =
service...
Feb 06 08:54:00 archvm systemd[990]: Starting GNOME keyboard shortcuts serv=
ice...
Feb 06 08:54:00 archvm systemd[990]: Starting GNOME power management servic=
e...
Feb 06 08:54:00 archvm systemd[990]: Starting GNOME printer notifications s=
ervice...
Feb 06 08:54:00 archvm systemd[990]: Starting GNOME RFKill support service.=
=2E.
Feb 06 08:54:00 archvm gnome-shell[1087]: Failed to launch ibus-daemon: Fai=
led to execute child process =E2=80=9Cibus-daemon=E2=80=9D (No such file or=
 directory)
Feb 06 08:54:00 archvm systemd[990]: Starting GNOME FreeDesktop screensaver=
 service...
Feb 06 08:54:00 archvm systemd[990]: Starting GNOME file sharing service...
Feb 06 08:54:00 archvm systemd[990]: Starting GNOME smartcard service...
Feb 06 08:54:00 archvm systemd[990]: Starting GNOME sound sample caching se=
rvice...
Feb 06 08:54:00 archvm systemd[990]: Starting GNOME USB protection service.=
=2E.
Feb 06 08:54:00 archvm gnome-session-binary[1063]: Entering running state
Feb 06 08:54:00 archvm systemd[1]: Starting Disk Manager...
Feb 06 08:54:00 archvm systemd[990]: Starting GNOME Wacom tablet support se=
rvice...
Feb 06 08:54:00 archvm udisksd[1255]: udisks daemon version 2.10.1 starting
Feb 06 08:54:00 archvm systemd[990]: Finished Signal initialization done to=
 GNOME Session Manager.
Feb 06 08:54:00 archvm gnome-session[1063]: gnome-session-binary[1063]: Gno=
meDesktop-WARNING: Could not create transient scope for PID 1222: GDBus.Err=
or:org.freedesktop.DBus.Error.UnixProcessIdUnknown: Process with ID 1222 do=
es not exist.
Feb 06 08:54:00 archvm gnome-session-binary[1063]: GnomeDesktop-WARNING: Co=
uld not create transient scope for PID 1222: GDBus.Error:org.freedesktop.DB=
us.Error.UnixProcessIdUnknown: Process with ID 1222 does not exist.
Feb 06 08:54:00 archvm systemd[990]: Started GNOME FreeDesktop screensaver =
service.
Feb 06 08:54:00 archvm systemd[990]: Started GNOME accessibility service.
Feb 06 08:54:00 archvm systemd[990]: Started Application launched by gnome-=
session-binary.
Feb 06 08:54:00 archvm systemd[990]: Started Application launched by gnome-=
session-binary.
Feb 06 08:54:00 archvm systemd[990]: Started Application launched by gnome-=
session-binary.
Feb 06 08:54:00 archvm systemd[990]: Reached target GNOME accessibility tar=
get.
Feb 06 08:54:00 archvm systemd[990]: Reached target GNOME FreeDesktop scree=
nsaver target.
Feb 06 08:54:00 archvm systemd[990]: Started GNOME maintenance of expirable=
 data service.
Feb 06 08:54:00 archvm systemd[990]: Reached target GNOME maintenance of ex=
pirable data target.
Feb 06 08:54:00 archvm systemd[990]: Started GNOME smartcard service.
Feb 06 08:54:00 archvm systemd[990]: Reached target GNOME smartcard target.
Feb 06 08:54:00 archvm systemd[990]: Started GNOME USB protection service.
Feb 06 08:54:00 archvm systemd[990]: Reached target GNOME USB protection ta=
rget.
Feb 06 08:54:00 archvm kernel: rfkill: input handler disabled
Feb 06 08:54:00 archvm systemd[990]: Started GNOME RFKill support service.
Feb 06 08:54:00 archvm systemd[990]: Reached target GNOME RFKill support ta=
rget.
Feb 06 08:54:00 archvm systemd[990]: Started GNOME date & time service.
Feb 06 08:54:00 archvm systemd[990]: Reached target GNOME date & time targe=
t.
Feb 06 08:54:00 archvm systemd[1]: Started Disk Manager.
Feb 06 08:54:00 archvm udisksd[1255]: Acquired the name org.freedesktop.UDi=
sks2 on the system message bus
Feb 06 08:54:00 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dudisks2 comm=3D"systemd" exe=3D"/usr/l=
ib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:54:00 archvm systemd[990]: Started GNOME file sharing service.
Feb 06 08:54:00 archvm systemd[990]: Reached target GNOME file sharing targ=
et.
Feb 06 08:54:00 archvm systemd[990]: Started GNOME printer notifications se=
rvice.
Feb 06 08:54:00 archvm systemd[990]: Reached target GNOME printer notificat=
ions target.
Feb 06 08:54:00 archvm systemd[990]: Created slice Slice /app/dbus-:1.2-org=
=2Egnome.ScreenSaver.
Feb 06 08:54:00 archvm systemd[990]: Started dbus-:1.2-org.gnome.ScreenSave=
r@0.service.
Feb 06 08:54:00 archvm systemd[990]: Started GNOME sound sample caching ser=
vice.
Feb 06 08:54:00 archvm systemd[990]: Reached target GNOME sound sample cach=
ing target.
Feb 06 08:54:00 archvm systemd[990]: Created slice Slice /app/dbus-:1.2-org=
=2Egnome.OnlineAccounts.
Feb 06 08:54:00 archvm systemd[990]: Started dbus-:1.2-org.gnome.OnlineAcco=
unts@0.service.
Feb 06 08:54:00 archvm systemd[990]: Started Evolution source registry.
Feb 06 08:54:00 archvm systemd[990]: Starting Virtual filesystem service - =
disk device monitor...
Feb 06 08:54:01 archvm systemd[990]: Starting Evolution calendar service...
Feb 06 08:54:01 archvm systemd[990]: Started Virtual filesystem service - d=
isk device monitor.
Feb 06 08:54:01 archvm goa-daemon[1375]: goa-daemon version 3.52.3.1 starti=
ng
Feb 06 08:54:01 archvm systemd[990]: Starting Virtual filesystem service - =
GNOME Online Accounts monitor...
Feb 06 08:54:01 archvm systemd[990]: Created slice Slice /app/dbus-:1.2-org=
=2Egnome.Identity.
Feb 06 08:54:01 archvm systemd[990]: Started dbus-:1.2-org.gnome.Identity@0=
=2Eservice.
Feb 06 08:54:01 archvm systemd[990]: Started Virtual filesystem service - G=
NOME Online Accounts monitor.
Feb 06 08:54:01 archvm systemd[990]: Starting Virtual filesystem service - =
digital camera monitor...
Feb 06 08:54:01 archvm systemd[990]: Started Evolution calendar service.
Feb 06 08:54:01 archvm systemd[990]: Starting Evolution address book servic=
e...
Feb 06 08:54:01 archvm systemd[990]: Started Virtual filesystem service - d=
igital camera monitor.
Feb 06 08:54:01 archvm systemd[990]: Starting Virtual filesystem service - =
Apple File Conduit monitor...
Feb 06 08:54:01 archvm systemd[990]: Started Virtual filesystem service - A=
pple File Conduit monitor.
Feb 06 08:54:01 archvm systemd[990]: Starting Virtual filesystem service - =
Media Transfer Protocol monitor...
Feb 06 08:54:01 archvm systemd[990]: Started Virtual filesystem service - M=
edia Transfer Protocol monitor.
Feb 06 08:54:01 archvm gsd-usb-protect[1246]: Failed to fetch USBGuard para=
meters: GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name is =
not activatable
Feb 06 08:54:01 archvm systemd[990]: Started Evolution address book service.
Feb 06 08:54:01 archvm gnome-shell[1087]: Error looking up permission: GDBu=
s.Error:org.freedesktop.portal.Error.NotFound: No entry for geolocation
Feb 06 08:54:01 archvm polkitd[509]: Registered Authentication Agent for un=
ix-session:3 (system bus name :1.59 [/usr/bin/gnome-shell], object path /or=
g/freedesktop/PolicyKit1/AuthenticationAgent, locale en_AU.UTF-8)
Feb 06 08:54:01 archvm NetworkManager[462]:   [1738792441.3911] agent-manag=
er: agent[86227efc33d4e0aa,:1.59/org.gnome.Shell.NetworkAgent/1000]: agent =
registered
Feb 06 08:54:01 archvm systemd[990]: Started PipeWire Multimedia Service.
Feb 06 08:54:01 archvm systemd[990]: Started Multimedia Service Session Man=
ager.
Feb 06 08:54:01 archvm systemd[990]: Started PipeWire PulseAudio.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 8 threads of 5 proces=
ses of 2 users.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 8 threads of 5 proces=
ses of 2 users.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 8 threads of 5 proces=
ses of 2 users.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 8 threads of 5 proces=
ses of 2 users.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 8 threads of 5 proces=
ses of 2 users.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 8 threads of 5 proces=
ses of 2 users.
Feb 06 08:54:01 archvm wireplumber[1465]: wp-internal-comp-loader: Loading =
profile 'main'
Feb 06 08:54:01 archvm rtkit-daemon[584]: Successfully made thread 1463 of =
process 1463 owned by '1000' high priority at nice level -11.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 9 threads of 6 proces=
ses of 2 users.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Successfully made thread 1479 of =
process 1463 owned by '1000' RT at priority 20.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 10 threads of 6 proce=
sses of 2 users.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 10 threads of 6 proce=
sses of 2 users.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 10 threads of 6 proce=
sses of 2 users.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 10 threads of 6 proce=
sses of 2 users.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Successfully made thread 1467 of =
process 1467 owned by '1000' high priority at nice level -11.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 11 threads of 7 proce=
sses of 2 users.
Feb 06 08:54:01 archvm systemd[990]: Started GNOME keyboard configuration s=
ervice.
Feb 06 08:54:01 archvm systemd[990]: Reached target GNOME keyboard configur=
ation target.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Successfully made thread 1481 of =
process 1467 owned by '1000' RT at priority 20.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 12 threads of 7 proce=
sses of 2 users.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Successfully made thread 1465 of =
process 1465 owned by '1000' high priority at nice level -11.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 13 threads of 8 proce=
sses of 2 users.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Successfully made thread 1490 of =
process 1465 owned by '1000' RT at priority 20.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 14 threads of 8 proce=
sses of 2 users.
Feb 06 08:54:01 archvm systemd[990]: Started GNOME color management service.
Feb 06 08:54:01 archvm systemd[990]: Reached target GNOME color management =
target.
Feb 06 08:54:01 archvm systemd[990]: Starting Portal service...
Feb 06 08:54:01 archvm systemd[990]: Started GNOME keyboard shortcuts servi=
ce.
Feb 06 08:54:01 archvm systemd[990]: Reached target GNOME keyboard shortcut=
s target.
Feb 06 08:54:01 archvm systemd[990]: Started GNOME Wacom tablet support ser=
vice.
Feb 06 08:54:01 archvm systemd[990]: Reached target GNOME Wacom tablet supp=
ort target.
Feb 06 08:54:01 archvm systemd[990]: Starting flatpak document portal servi=
ce...
Feb 06 08:54:01 archvm systemd[990]: Started flatpak document portal servic=
e.
Feb 06 08:54:01 archvm wireplumber[1465]: spa.bluez5: BlueZ system service =
is not available
Feb 06 08:54:01 archvm wireplumber[1465]: wp-device: SPA handle 'api.libcam=
era.enum.manager' could not be loaded; is it installed?
Feb 06 08:54:01 archvm wireplumber[1465]: s-monitors-libcamera: PipeWire's =
libcamera SPA plugin is missing or broken. Some camera types may not be sup=
ported.
Feb 06 08:54:01 archvm gsd-media-keys[1187]: Unable to get default sink
Feb 06 08:54:01 archvm systemd[990]: Started GNOME power management service.
Feb 06 08:54:01 archvm systemd[990]: Reached target GNOME power management =
target.
Feb 06 08:54:01 archvm systemd[990]: Reached target GNOME Session.
Feb 06 08:54:01 archvm systemd[990]: Reached target GNOME Wayland Session (=
session: gnome).
Feb 06 08:54:01 archvm systemd[990]: Reached target Current graphical user =
session.
Feb 06 08:54:01 archvm systemd[990]: Starting Portal service (GNOME impleme=
ntation)...
Feb 06 08:54:01 archvm gsd-media-keys[1187]: Failed to grab accelerator for=
 keybinding settings:playback-repeat
Feb 06 08:54:01 archvm gsd-media-keys[1187]: Failed to grab accelerator for=
 keybinding settings:hibernate
Feb 06 08:54:01 archvm systemd[990]: Started Portal service (GNOME implemen=
tation).
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 14 threads of 8 proce=
sses of 2 users.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 14 threads of 8 proce=
sses of 2 users.
Feb 06 08:54:01 archvm rtkit-daemon[584]: Supervising 14 threads of 8 proce=
sses of 2 users.
Feb 06 08:54:02 archvm systemd[990]: Starting Portal service (GTK/GNOME imp=
lementation)...
Feb 06 08:54:02 archvm systemd[990]: Started Portal service (GTK/GNOME impl=
ementation).
Feb 06 08:54:02 archvm gnome-shell[1087]: GNOME Shell started at Thu Feb 06=
 2025 08:54:00 GMT+1100 (Australian Eastern Daylight Time)
Feb 06 08:54:02 archvm gnome-shell[1087]: Registering session with GDM
Feb 06 08:54:02 archvm gnome-shell[565]: Shutting down GNOME Shell
Feb 06 08:54:02 archvm systemd[1]: run-user-120-doc.mount: Deactivated succ=
essfully.
Feb 06 08:54:02 archvm audit[525]: USER_END pid=3D525 uid=3D0 auid=3D120 se=
s=3D1 msg=3D'op=3DPAM:session_close grantors=3Dpam_loginuid,pam_keyinit,pam=
_succeed_if,pam_permit,pam_systemd,pam_env acct=3D"gdm" exe=3D"/usr/lib/gdm=
-session-worker" hostname=3Darchvm addr=3D? terminal=3D/dev/tty1 res=3Dsucc=
ess'
Feb 06 08:54:02 archvm systemd[990]: Started Portal service.
Feb 06 08:54:02 archvm audit[525]: CRED_DISP pid=3D525 uid=3D0 auid=3D120 s=
es=3D1 msg=3D'op=3DPAM:setcred grantors=3Dpam_permit acct=3D"gdm" exe=3D"/u=
sr/lib/gdm-session-worker" hostname=3Darchvm addr=3D? terminal=3D/dev/tty1 =
res=3Dsuccess'
Feb 06 08:54:02 archvm xdg-document-po[908]: Error releasing name org.freed=
esktop.portal.Documents: The connection is closed
Feb 06 08:54:02 archvm /usr/lib/gdm-wayland-session[968]: discover_other_da=
emon: 1
Feb 06 08:54:02 archvm systemd-logind[468]: Session 1 logged out. Waiting f=
or processes to exit.
Feb 06 08:54:02 archvm polkitd[509]: Unregistered Authentication Agent for =
unix-session:1 (system bus name :1.19, object path /org/freedesktop/PolicyK=
it1/AuthenticationAgent, locale en_AU.UTF-8) (disconnected from bus)
Feb 06 08:54:02 archvm systemd[1]: session-1.scope: Deactivated successfull=
y.
Feb 06 08:54:02 archvm systemd[1]: session-1.scope: Consumed 3.907s CPU tim=
e, 347.3M memory peak.
Feb 06 08:54:02 archvm systemd-logind[468]: Removed session 1.
Feb 06 08:54:02 archvm gdm[498]: Gdm: Child process -544 was already dead.
Feb 06 08:54:02 archvm gnome-software[1253]: Failed to load /usr/lib/gnome-=
software/plugins-21/libgs_plugin_fwupd.so: failed to open plugin /usr/lib/g=
nome-software/plugins-21/libgs_plugin_fwupd.so: libfwupd.so.3: cannot open =
shared object file: No such file or directory
Feb 06 08:54:02 archvm systemd[990]: Created slice Slice /app/dbus-:1.2-org=
=2Egnome.Epiphany.WebAppProvider.
Feb 06 08:54:02 archvm systemd[990]: Started dbus-:1.2-org.gnome.Epiphany.W=
ebAppProvider@0.service.
Feb 06 08:54:09 archvm gnome-shell[1087]: Received error from D-Bus search =
provider firefox.desktop: Gio.DBusError: GDBus.Error:org.freedesktop.DBus.E=
rror.ServiceUnknown: The name is not activatable
Feb 06 08:54:09 archvm systemd[990]: Created slice Slice /app/dbus-:1.2-org=
=2Egnome.Calculator.SearchProvider.
Feb 06 08:54:09 archvm systemd[990]: Created slice Slice /app/dbus-:1.2-org=
=2Egnome.Calendar.
Feb 06 08:54:09 archvm systemd[990]: Created slice Slice /app/dbus-:1.2-org=
=2Egnome.Characters.
Feb 06 08:54:09 archvm systemd[990]: Created slice Slice /app/dbus-:1.2-org=
=2Egnome.Contacts.SearchProvider.
Feb 06 08:54:09 archvm systemd[990]: Created slice Slice /app/dbus-:1.2-org=
=2Egnome.Epiphany.SearchProvider.
Feb 06 08:54:09 archvm systemd[990]: Created slice Slice /app/dbus-:1.2-org=
=2Egnome.Nautilus.
Feb 06 08:54:09 archvm systemd[990]: Created slice Slice /app/dbus-:1.2-org=
=2Egnome.Settings.SearchProvider.
Feb 06 08:54:09 archvm systemd[990]: Created slice Slice /app/dbus-:1.2-org=
=2Egnome.clocks.
Feb 06 08:54:09 archvm systemd[990]: Started dbus-:1.2-org.gnome.Calculator=
=2ESearchProvider@0.service.
Feb 06 08:54:09 archvm systemd[990]: Started dbus-:1.2-org.gnome.Calendar@0=
=2Eservice.
Feb 06 08:54:09 archvm systemd[990]: Started dbus-:1.2-org.gnome.Characters=
@0.service.
Feb 06 08:54:09 archvm systemd[990]: Started dbus-:1.2-org.gnome.Contacts.S=
earchProvider@0.service.
Feb 06 08:54:09 archvm systemd[990]: Started dbus-:1.2-org.gnome.Epiphany.S=
earchProvider@0.service.
Feb 06 08:54:09 archvm systemd[990]: Started dbus-:1.2-org.gnome.Nautilus@0=
=2Eservice.
Feb 06 08:54:09 archvm systemd[990]: Started dbus-:1.2-org.gnome.Settings.S=
earchProvider@0.service.
Feb 06 08:54:09 archvm systemd[990]: Started dbus-:1.2-org.gnome.clocks@0.s=
ervice.
Feb 06 08:54:09 archvm nautilus[1619]: Connecting to org.freedesktop.Tracke=
r3.Miner.Files
Feb 06 08:54:09 archvm audit: BPF prog-id=3D61 op=3DLOAD
Feb 06 08:54:09 archvm audit: BPF prog-id=3D62 op=3DLOAD
Feb 06 08:54:09 archvm audit: BPF prog-id=3D63 op=3DLOAD
Feb 06 08:54:09 archvm kernel: kauditd_printk_skb: 9 callbacks suppressed
Feb 06 08:54:09 archvm kernel: audit: type=3D1334 audit(1738792449.671:129)=
: prog-id=3D61 op=3DLOAD
Feb 06 08:54:09 archvm kernel: audit: type=3D1334 audit(1738792449.671:130)=
: prog-id=3D62 op=3DLOAD
Feb 06 08:54:09 archvm kernel: audit: type=3D1334 audit(1738792449.671:131)=
: prog-id=3D63 op=3DLOAD
Feb 06 08:54:09 archvm systemd[1]: Starting Time & Date Service...
Feb 06 08:54:09 archvm dbus-broker-launch[460]: Activation request for 'org=
=2Ebluez' failed: The systemd unit 'dbus-org.bluez.service' could not be fo=
und.
Feb 06 08:54:09 archvm systemd[990]: Starting User preferences database...
Feb 06 08:54:09 archvm systemd[1]: Started Time & Date Service.
Feb 06 08:54:09 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-timedated comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
Feb 06 08:54:09 archvm kernel: audit: type=3D1130 audit(1738792449.748:132)=
: pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-=
timedated comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:54:09 archvm systemd[990]: Started User preferences database.
Feb 06 08:54:09 archvm gnome-shell[1087]: Received error from D-Bus search =
provider firefox.desktop: Gio.DBusError: GDBus.Error:org.freedesktop.DBus.E=
rror.ServiceUnknown: The name is not activatable
Feb 06 08:54:09 archvm gnome-character[1616]: JS LOG: Characters Applicatio=
n started
Feb 06 08:54:09 archvm systemd[990]: Created slice User Background Tasks Sl=
ice.
Feb 06 08:54:09 archvm systemd[990]: Starting Tracker file system data mine=
r...
Feb 06 08:54:09 archvm gnome-calendar[1615]: Running Calendar as a service
Feb 06 08:54:09 archvm systemd[990]: Created slice Slice /app/dbus-:1.2-org=
=2Egnome.NautilusPreviewer.
Feb 06 08:54:09 archvm systemd[990]: Started dbus-:1.2-org.gnome.NautilusPr=
eviewer@0.service.
Feb 06 08:54:09 archvm epiphany-search[1618]: Failed to canonicalize path /=
home/arch/.config/epiphany: No such file or directory
Feb 06 08:54:09 archvm epiphany-search[1618]: Attempted to add disallowed p=
ath to sandbox: /home/arch/.config/epiphany
Feb 06 08:54:09 archvm gnome-shell[1087]: Object St.BoxLayout (0x55a6f1ceea=
90), has been already disposed =E2=80=94 impossible to access it. This migh=
t be caused by the object having been destroyed from C code using something=
 such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   7ffef28b9610 b   resource://=
/org/gnome/shell/ui/search.js:320 (856259ad1f0 @ 22)
                                          #1   7ffef28b96d0 b   resource://=
/org/gnome/shell/ui/search.js:251 (856259a6f60 @ 92)
                                          #2   7ffef28b97b0 b   resource://=
/org/gnome/shell/ui/search.js:839 (856259ae1f0 @ 79)
                                          #3   7ffef28b9880 b   resource://=
/org/gnome/shell/ui/search.js:691 (856259adce0 @ 313)
                                          #4   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #5   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:09 archvm gnome-shell[1087]: Object .Gjs_ui_search_ListSearchR=
esults (0x55a6f080d3a0), has been already disposed =E2=80=94 impossible to =
access it. This might be caused by the object having been destroyed from C =
code using something such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   7ffef28b96d0 b   resource://=
/org/gnome/shell/ui/search.js:252 (856259a6f60 @ 108)
                                          #1   7ffef28b97b0 b   resource://=
/org/gnome/shell/ui/search.js:839 (856259ae1f0 @ 79)
                                          #2   7ffef28b9880 b   resource://=
/org/gnome/shell/ui/search.js:691 (856259adce0 @ 313)
                                          #3   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #4   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:09 archvm rtkit-daemon[584]: Supervising 13 threads of 7 proce=
sses of 2 users.
Feb 06 08:54:09 archvm rtkit-daemon[584]: Failed to look up client: No such=
 file or directory
Feb 06 08:54:09 archvm gnome-shell[1087]: Object .Gjs_ui_search_ListSearchR=
esults (0x55a6f1d76a50), has been already disposed =E2=80=94 impossible to =
access it. This might be caused by the object having been destroyed from C =
code using something such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   7ffef28b9870 b   resource://=
/org/gnome/shell/ui/search.js:267 (856259a6f60 @ 349)
                                          #1   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #2   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:09 archvm gnome-shell[1087]: Object St.BoxLayout (0x55a6f1d84e=
10), has been already disposed =E2=80=94 impossible to access it. This migh=
t be caused by the object having been destroyed from C code using something=
 such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   7ffef28b97b0 b   resource://=
/org/gnome/shell/ui/search.js:320 (856259ad1f0 @ 22)
                                          #1   7ffef28b9870 b   resource://=
/org/gnome/shell/ui/search.js:268 (856259a6f60 @ 365)
                                          #2   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #3   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:09 archvm gnome-shell[1087]: Object St.BoxLayout (0x55a6f1d84e=
10), has been already disposed =E2=80=94 impossible to access it. This migh=
t be caused by the object having been destroyed from C code using something=
 such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   55a6ee6db588 i   resource://=
/org/gnome/shell/ui/search.js:329 (856259ad290 @ 25)
                                          #1   7ffef28b9730 b   resource://=
/org/gnome/shell/ui/search.js:270 (856259a6fb0 @ 26)
                                          #2   7ffef28b97a0 I   self-hosted=
:160 (2e0112397f60 @ 245)
                                          #3   7ffef28b9870 b   resource://=
/org/gnome/shell/ui/search.js:269 (856259a6f60 @ 385)
                                          #4   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #5   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:09 archvm gnome-shell[1087]: Object St.Label (0x55a6f1d823c0),=
 has been already disposed =E2=80=94 impossible to set any property on it. =
This might be caused by the object having been destroyed from C code using =
something such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   55a6ee6db618 i   resource://=
/org/gnome/shell/ui/search.js:962 (856259ae5b0 @ 50)
                                          #1   55a6ee6db588 i   resource://=
/org/gnome/shell/ui/search.js:312 (856259ad150 @ 25)
                                          #2   7ffef28b9870 b   resource://=
/org/gnome/shell/ui/search.js:271 (856259a6f60 @ 446)
                                          #3   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #4   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:09 archvm gnome-shell[1087]: clutter_text_get_editable: assert=
ion 'CLUTTER_IS_TEXT (self)' failed
Feb 06 08:54:09 archvm gnome-shell[1087]: clutter_text_get_text: assertion =
'CLUTTER_IS_TEXT (self)' failed
Feb 06 08:54:09 archvm gnome-shell[1087]: clutter_text_set_text: assertion =
'CLUTTER_IS_TEXT (self)' failed
Feb 06 08:54:09 archvm gnome-shell[1087]: Object St.Label (0x55a6f1d823c0),=
 has been already disposed =E2=80=94 impossible to set any property on it. =
This might be caused by the object having been destroyed from C code using =
something such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   55a6ee6db618 i   resource://=
/org/gnome/shell/ui/search.js:963 (856259ae5b0 @ 70)
                                          #1   55a6ee6db588 i   resource://=
/org/gnome/shell/ui/search.js:312 (856259ad150 @ 25)
                                          #2   7ffef28b9870 b   resource://=
/org/gnome/shell/ui/search.js:271 (856259a6f60 @ 446)
                                          #3   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #4   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:09 archvm gnome-shell[1087]: Object .Gjs_ui_search_ListSearchR=
esults (0x55a6f1d76a50), has been already disposed =E2=80=94 impossible to =
access it. This might be caused by the object having been destroyed from C =
code using something such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   7ffef28b9870 b   resource://=
/org/gnome/shell/ui/search.js:272 (856259a6f60 @ 462)
                                          #1   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #2   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm systemd[990]: Started Tracker file system data miner.
Feb 06 08:54:10 archvm gnome-shell[1087]: Object .Gjs_ui_search_ListSearchR=
esults (0x55a6f07c8e00), has been already disposed =E2=80=94 impossible to =
access it. This might be caused by the object having been destroyed from C =
code using something such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   7ffef28b9870 b   resource://=
/org/gnome/shell/ui/search.js:267 (856259a6f60 @ 349)
                                          #1   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #2   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: Object St.BoxLayout (0x55a6f1d45d=
c0), has been already disposed =E2=80=94 impossible to access it. This migh=
t be caused by the object having been destroyed from C code using something=
 such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   7ffef28b97b0 b   resource://=
/org/gnome/shell/ui/search.js:320 (856259ad1f0 @ 22)
                                          #1   7ffef28b9870 b   resource://=
/org/gnome/shell/ui/search.js:268 (856259a6f60 @ 365)
                                          #2   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #3   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: Object St.BoxLayout (0x55a6f1d45d=
c0), has been already disposed =E2=80=94 impossible to access it. This migh=
t be caused by the object having been destroyed from C code using something=
 such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   55a6ee6db588 i   resource://=
/org/gnome/shell/ui/search.js:329 (856259ad290 @ 25)
                                          #1   7ffef28b9730 b   resource://=
/org/gnome/shell/ui/search.js:270 (856259a6fb0 @ 26)
                                          #2   7ffef28b97a0 I   self-hosted=
:160 (2e0112397f60 @ 245)
                                          #3   7ffef28b9870 b   resource://=
/org/gnome/shell/ui/search.js:269 (856259a6f60 @ 385)
                                          #4   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #5   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: Object St.BoxLayout (0x55a6f1d45d=
c0), has been already disposed =E2=80=94 impossible to access it. This migh=
t be caused by the object having been destroyed from C code using something=
 such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   55a6ee6db588 i   resource://=
/org/gnome/shell/ui/search.js:329 (856259ad290 @ 25)
                                          #1   7ffef28b9730 b   resource://=
/org/gnome/shell/ui/search.js:270 (856259a6fb0 @ 26)
                                          #2   7ffef28b97a0 I   self-hosted=
:160 (2e0112397f60 @ 245)
                                          #3   7ffef28b9870 b   resource://=
/org/gnome/shell/ui/search.js:269 (856259a6f60 @ 385)
                                          #4   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #5   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: Object St.BoxLayout (0x55a6f1d45d=
c0), has been already disposed =E2=80=94 impossible to access it. This migh=
t be caused by the object having been destroyed from C code using something=
 such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   55a6ee6db588 i   resource://=
/org/gnome/shell/ui/search.js:329 (856259ad290 @ 25)
                                          #1   7ffef28b9730 b   resource://=
/org/gnome/shell/ui/search.js:270 (856259a6fb0 @ 26)
                                          #2   7ffef28b97a0 I   self-hosted=
:160 (2e0112397f60 @ 245)
                                          #3   7ffef28b9870 b   resource://=
/org/gnome/shell/ui/search.js:269 (856259a6f60 @ 385)
                                          #4   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #5   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: Object St.BoxLayout (0x55a6f1d45d=
c0), has been already disposed =E2=80=94 impossible to access it. This migh=
t be caused by the object having been destroyed from C code using something=
 such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   55a6ee6db588 i   resource://=
/org/gnome/shell/ui/search.js:329 (856259ad290 @ 25)
                                          #1   7ffef28b9730 b   resource://=
/org/gnome/shell/ui/search.js:270 (856259a6fb0 @ 26)
                                          #2   7ffef28b97a0 I   self-hosted=
:160 (2e0112397f60 @ 245)
                                          #3   7ffef28b9870 b   resource://=
/org/gnome/shell/ui/search.js:269 (856259a6f60 @ 385)
                                          #4   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #5   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: Object St.BoxLayout (0x55a6f1d45d=
c0), has been already disposed =E2=80=94 impossible to access it. This migh=
t be caused by the object having been destroyed from C code using something=
 such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   55a6ee6db588 i   resource://=
/org/gnome/shell/ui/search.js:329 (856259ad290 @ 25)
                                          #1   7ffef28b9730 b   resource://=
/org/gnome/shell/ui/search.js:270 (856259a6fb0 @ 26)
                                          #2   7ffef28b97a0 I   self-hosted=
:160 (2e0112397f60 @ 245)
                                          #3   7ffef28b9870 b   resource://=
/org/gnome/shell/ui/search.js:269 (856259a6f60 @ 385)
                                          #4   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #5   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: Object St.Label (0x55a6f1d43370),=
 has been already disposed =E2=80=94 impossible to set any property on it. =
This might be caused by the object having been destroyed from C code using =
something such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   55a6ee6db618 i   resource://=
/org/gnome/shell/ui/search.js:962 (856259ae5b0 @ 50)
                                          #1   55a6ee6db588 i   resource://=
/org/gnome/shell/ui/search.js:312 (856259ad150 @ 25)
                                          #2   7ffef28b9870 b   resource://=
/org/gnome/shell/ui/search.js:271 (856259a6f60 @ 446)
                                          #3   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #4   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: clutter_text_get_editable: assert=
ion 'CLUTTER_IS_TEXT (self)' failed
Feb 06 08:54:10 archvm gnome-shell[1087]: clutter_text_get_text: assertion =
'CLUTTER_IS_TEXT (self)' failed
Feb 06 08:54:10 archvm gnome-shell[1087]: clutter_text_set_text: assertion =
'CLUTTER_IS_TEXT (self)' failed
Feb 06 08:54:10 archvm gnome-shell[1087]: Object St.Label (0x55a6f1d43370),=
 has been already disposed =E2=80=94 impossible to set any property on it. =
This might be caused by the object having been destroyed from C code using =
something such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   55a6ee6db618 i   resource://=
/org/gnome/shell/ui/search.js:963 (856259ae5b0 @ 70)
                                          #1   55a6ee6db588 i   resource://=
/org/gnome/shell/ui/search.js:312 (856259ad150 @ 25)
                                          #2   7ffef28b9870 b   resource://=
/org/gnome/shell/ui/search.js:271 (856259a6f60 @ 446)
                                          #3   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #4   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: Object .Gjs_ui_search_ListSearchR=
esults (0x55a6f07c8e00), has been already disposed =E2=80=94 impossible to =
access it. This might be caused by the object having been destroyed from C =
code using something such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   7ffef28b9870 b   resource://=
/org/gnome/shell/ui/search.js:272 (856259a6f60 @ 462)
                                          #1   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #2   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: Object .Gjs_ui_search_ListSearchR=
esults (0x55a6f1d67030), has been already disposed =E2=80=94 impossible to =
access it. This might be caused by the object having been destroyed from C =
code using something such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   55a6ee6db638 i   resource://=
/org/gnome/shell/ui/search.js:267 (856259a6f60 @ 349)
                                          #1   55a6ee6db588 i   self-hosted=
:1417 (3fdca097c380 @ 30)
                                          #2   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #3   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: Object St.BoxLayout (0x55a6f1d754=
80), has been already disposed =E2=80=94 impossible to access it. This migh=
t be caused by the object having been destroyed from C code using something=
 such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   55a6ee6db6e8 i   resource://=
/org/gnome/shell/ui/search.js:320 (856259ad1f0 @ 22)
                                          #1   55a6ee6db638 i   resource://=
/org/gnome/shell/ui/search.js:268 (856259a6f60 @ 365)
                                          #2   55a6ee6db588 i   self-hosted=
:1417 (3fdca097c380 @ 30)
                                          #3   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #4   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: Object St.BoxLayout (0x55a6f1d754=
80), has been already disposed =E2=80=94 impossible to access it. This migh=
t be caused by the object having been destroyed from C code using something=
 such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   7ffef28b8570 b   resource://=
/org/gnome/shell/ui/search.js:329 (856259ad290 @ 25)
                                          #1   55a6ee6db6e8 i   resource://=
/org/gnome/shell/ui/search.js:270 (856259a6fb0 @ 26)
                                          #2   7ffef28b9060 b   self-hosted=
:160 (2e0112397f60 @ 245)
                                          #3   55a6ee6db638 i   resource://=
/org/gnome/shell/ui/search.js:269 (856259a6f60 @ 385)
                                          #4   55a6ee6db588 i   self-hosted=
:1417 (3fdca097c380 @ 30)
                                          #5   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #6   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: Object St.BoxLayout (0x55a6f1d754=
80), has been already disposed =E2=80=94 impossible to access it. This migh=
t be caused by the object having been destroyed from C code using something=
 such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   7ffef28b8510 b   resource://=
/org/gnome/shell/ui/search.js:329 (856259ad290 @ 25)
                                          #1   55a6ee6db6e8 i   resource://=
/org/gnome/shell/ui/search.js:270 (856259a6fb0 @ 26)
                                          #2   7ffef28b9060 b   self-hosted=
:160 (2e0112397f60 @ 245)
                                          #3   55a6ee6db638 i   resource://=
/org/gnome/shell/ui/search.js:269 (856259a6f60 @ 385)
                                          #4   55a6ee6db588 i   self-hosted=
:1417 (3fdca097c380 @ 30)
                                          #5   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #6   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: Object St.BoxLayout (0x55a6f1d754=
80), has been already disposed =E2=80=94 impossible to access it. This migh=
t be caused by the object having been destroyed from C code using something=
 such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   7ffef28b8510 b   resource://=
/org/gnome/shell/ui/search.js:329 (856259ad290 @ 25)
                                          #1   55a6ee6db6e8 i   resource://=
/org/gnome/shell/ui/search.js:270 (856259a6fb0 @ 26)
                                          #2   7ffef28b9060 b   self-hosted=
:160 (2e0112397f60 @ 245)
                                          #3   55a6ee6db638 i   resource://=
/org/gnome/shell/ui/search.js:269 (856259a6f60 @ 385)
                                          #4   55a6ee6db588 i   self-hosted=
:1417 (3fdca097c380 @ 30)
                                          #5   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #6   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: Object St.BoxLayout (0x55a6f1d754=
80), has been already disposed =E2=80=94 impossible to access it. This migh=
t be caused by the object having been destroyed from C code using something=
 such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   7ffef28b8510 b   resource://=
/org/gnome/shell/ui/search.js:329 (856259ad290 @ 25)
                                          #1   55a6ee6db6e8 i   resource://=
/org/gnome/shell/ui/search.js:270 (856259a6fb0 @ 26)
                                          #2   7ffef28b9060 b   self-hosted=
:160 (2e0112397f60 @ 245)
                                          #3   55a6ee6db638 i   resource://=
/org/gnome/shell/ui/search.js:269 (856259a6f60 @ 385)
                                          #4   55a6ee6db588 i   self-hosted=
:1417 (3fdca097c380 @ 30)
                                          #5   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #6   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: Object St.BoxLayout (0x55a6f1d754=
80), has been already disposed =E2=80=94 impossible to access it. This migh=
t be caused by the object having been destroyed from C code using something=
 such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   7ffef28b8510 b   resource://=
/org/gnome/shell/ui/search.js:329 (856259ad290 @ 25)
                                          #1   55a6ee6db6e8 i   resource://=
/org/gnome/shell/ui/search.js:270 (856259a6fb0 @ 26)
                                          #2   7ffef28b9060 b   self-hosted=
:160 (2e0112397f60 @ 245)
                                          #3   55a6ee6db638 i   resource://=
/org/gnome/shell/ui/search.js:269 (856259a6f60 @ 385)
                                          #4   55a6ee6db588 i   self-hosted=
:1417 (3fdca097c380 @ 30)
                                          #5   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #6   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: Object St.Label (0x55a6f1d72a30),=
 has been already disposed =E2=80=94 impossible to set any property on it. =
This might be caused by the object having been destroyed from C code using =
something such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   55a6ee6db778 i   resource://=
/org/gnome/shell/ui/search.js:962 (856259ae5b0 @ 50)
                                          #1   55a6ee6db6e8 i   resource://=
/org/gnome/shell/ui/search.js:312 (856259ad150 @ 25)
                                          #2   55a6ee6db638 i   resource://=
/org/gnome/shell/ui/search.js:271 (856259a6f60 @ 446)
                                          #3   55a6ee6db588 i   self-hosted=
:1417 (3fdca097c380 @ 30)
                                          #4   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #5   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: clutter_text_get_editable: assert=
ion 'CLUTTER_IS_TEXT (self)' failed
Feb 06 08:54:10 archvm gnome-shell[1087]: clutter_text_get_text: assertion =
'CLUTTER_IS_TEXT (self)' failed
Feb 06 08:54:10 archvm gnome-shell[1087]: clutter_text_set_text: assertion =
'CLUTTER_IS_TEXT (self)' failed
Feb 06 08:54:10 archvm gnome-shell[1087]: Object St.Label (0x55a6f1d72a30),=
 has been already disposed =E2=80=94 impossible to set any property on it. =
This might be caused by the object having been destroyed from C code using =
something such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   55a6ee6db778 i   resource://=
/org/gnome/shell/ui/search.js:963 (856259ae5b0 @ 70)
                                          #1   55a6ee6db6e8 i   resource://=
/org/gnome/shell/ui/search.js:312 (856259ad150 @ 25)
                                          #2   55a6ee6db638 i   resource://=
/org/gnome/shell/ui/search.js:271 (856259a6f60 @ 446)
                                          #3   55a6ee6db588 i   self-hosted=
:1417 (3fdca097c380 @ 30)
                                          #4   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #5   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm gnome-shell[1087]: Object .Gjs_ui_search_ListSearchR=
esults (0x55a6f1d67030), has been already disposed =E2=80=94 impossible to =
access it. This might be caused by the object having been destroyed from C =
code using something such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   55a6ee6db638 i   resource://=
/org/gnome/shell/ui/search.js:272 (856259a6f60 @ 462)
                                          #1   55a6ee6db588 i   self-hosted=
:1417 (3fdca097c380 @ 30)
                                          #2   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #3   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:10 archvm systemd[990]: Created slice Slice /app/dbus-:1.2-org=
=2Egnome.Console.
Feb 06 08:54:10 archvm systemd[990]: Started dbus-:1.2-org.gnome.Console@0.=
service.
Feb 06 08:54:11 archvm systemd[990]: Started VTE child process 1793 launche=
d by kgx process 1785.
Feb 06 08:54:11 archvm gnome-shell[1087]: Object St.BoxLayout (0x55a6f07d82=
b0), has been already disposed =E2=80=94 impossible to access it. This migh=
t be caused by the object having been destroyed from C code using something=
 such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   7ffef28b9060 b   resource://=
/org/gnome/shell/ui/search.js:320 (856259ad1f0 @ 22)
                                          #1   55a6ee6db780 i   resource://=
/org/gnome/shell/ui/search.js:251 (856259a6f60 @ 92)
                                          #2   55a6ee6db6d8 i   resource://=
/org/gnome/shell/ui/search.js:839 (856259ae1f0 @ 79)
                                          #3   55a6ee6db630 i   resource://=
/org/gnome/shell/ui/search.js:691 (856259adce0 @ 313)
                                          #4   55a6ee6db588 i   self-hosted=
:1417 (3fdca097c380 @ 30)
                                          #5   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #6   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:11 archvm gnome-shell[1087]: Object .Gjs_ui_search_ListSearchR=
esults (0x55a6f07cb0e0), has been already disposed =E2=80=94 impossible to =
access it. This might be caused by the object having been destroyed from C =
code using something such as destroy(), dispose(), or remove() vfuncs.
                                          =3D=3D Stack trace for context 0x=
55a6ee5e6500 =3D=3D
                                          #0   55a6ee6db780 i   resource://=
/org/gnome/shell/ui/search.js:252 (856259a6f60 @ 108)
                                          #1   55a6ee6db6d8 i   resource://=
/org/gnome/shell/ui/search.js:839 (856259ae1f0 @ 79)
                                          #2   55a6ee6db630 i   resource://=
/org/gnome/shell/ui/search.js:691 (856259adce0 @ 313)
                                          #3   55a6ee6db588 i   self-hosted=
:1417 (3fdca097c380 @ 30)
                                          #4   7ffef28b9920 b   self-hosted=
:804 (2d86cd6a3fb0 @ 15)
                                          #5   55a6ee6db4f8 i   resource://=
/org/gnome/shell/ui/init.js:21 (2e0112370c90 @ 48)
Feb 06 08:54:12 archvm systemd[1]: Stopping User Manager for UID 120...
Feb 06 08:54:12 archvm systemd[533]: Activating special unit Exit the Sessi=
on...
Feb 06 08:54:12 archvm systemd[533]: Stopped target Main User Target.
Feb 06 08:54:12 archvm systemd[533]: Stopping GNOME Keyring daemon...
Feb 06 08:54:12 archvm systemd[533]: Stopping PipeWire PulseAudio...
Feb 06 08:54:12 archvm systemd[533]: Stopped GNOME Keyring daemon.
Feb 06 08:54:12 archvm systemd[533]: Stopped PipeWire PulseAudio.
Feb 06 08:54:12 archvm systemd[533]: Stopping Multimedia Service Session Ma=
nager...
Feb 06 08:54:12 archvm wireplumber[833]: wireplumber: stopped by signal: Te=
rminated
Feb 06 08:54:12 archvm wireplumber[833]: wireplumber: disconnected from pip=
ewire
Feb 06 08:54:12 archvm systemd[533]: Stopped Multimedia Service Session Man=
ager.
Feb 06 08:54:12 archvm systemd[533]: Stopping PipeWire Multimedia Service...
Feb 06 08:54:12 archvm systemd[533]: Stopped PipeWire Multimedia Service.
Feb 06 08:54:12 archvm systemd[533]: Stopped target Basic System.
Feb 06 08:54:12 archvm systemd[533]: Stopped target Paths.
Feb 06 08:54:12 archvm systemd[533]: Stopped target Sockets.
Feb 06 08:54:12 archvm systemd[533]: Stopped target Timers.
Feb 06 08:54:12 archvm systemd[533]: Closed GnuPG network certificate manag=
ement daemon.
Feb 06 08:54:12 archvm systemd[533]: Closed GNOME Keyring daemon.
Feb 06 08:54:12 archvm systemd[533]: Closed GnuPG cryptographic agent and p=
assphrase cache (access for web browsers).
Feb 06 08:54:12 archvm systemd[533]: Closed GnuPG cryptographic agent and p=
assphrase cache (restricted).
Feb 06 08:54:12 archvm systemd[533]: Closed GnuPG cryptographic agent (ssh-=
agent emulation).
Feb 06 08:54:12 archvm systemd[533]: Closed GnuPG cryptographic agent and p=
assphrase cache.
Feb 06 08:54:12 archvm systemd[533]: Closed GnuPG public key management ser=
vice.
Feb 06 08:54:12 archvm systemd[533]: Closed p11-kit server.
Feb 06 08:54:12 archvm systemd[533]: Closed PipeWire PulseAudio.
Feb 06 08:54:12 archvm systemd[533]: Closed PipeWire Multimedia System Sock=
ets.
Feb 06 08:54:12 archvm dbus-broker[549]: Dispatched 369 messages @ 3(=C2=B1=
6)=CE=BCs / message.
Feb 06 08:54:12 archvm systemd[533]: Stopping D-Bus User Message Bus...
Feb 06 08:54:12 archvm systemd[533]: Stopped D-Bus User Message Bus.
Feb 06 08:54:12 archvm systemd[533]: Removed slice User Core Session Slice.
Feb 06 08:54:12 archvm systemd[533]: Closed D-Bus User Message Bus Socket.
Feb 06 08:54:12 archvm systemd[533]: Removed slice User Application Slice.
Feb 06 08:54:12 archvm systemd[533]: Reached target Shutdown.
Feb 06 08:54:12 archvm systemd[533]: Finished Exit the Session.
Feb 06 08:54:12 archvm systemd[533]: Reached target Exit the Session.
Feb 06 08:54:12 archvm (sd-pam)[535]: pam_unix(systemd-user:session): sessi=
on closed for user gdm
Feb 06 08:54:12 archvm systemd[1]: user@120.service: Deactivated successful=
ly.
Feb 06 08:54:12 archvm systemd[1]: Stopped User Manager for UID 120.
Feb 06 08:54:12 archvm audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'unit=3Duser@120 comm=3D"systemd" exe=3D"/usr/l=
ib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:54:12 archvm kernel: audit: type=3D1131 audit(1738792452.495:133)=
: pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Duser@120=
 comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? te=
rminal=3D? res=3Dsuccess'
Feb 06 08:54:12 archvm systemd[1]: Stopping User Runtime Directory /run/use=
r/120...
Feb 06 08:54:12 archvm systemd[1]: run-user-120.mount: Deactivated successf=
ully.
Feb 06 08:54:12 archvm systemd[1]: user-runtime-dir@120.service: Deactivate=
d successfully.
Feb 06 08:54:12 archvm systemd[1]: Stopped User Runtime Directory /run/user=
/120.
Feb 06 08:54:12 archvm audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'unit=3Duser-runtime-dir@120 comm=3D"systemd" e=
xe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsu=
ccess'
Feb 06 08:54:12 archvm kernel: audit: type=3D1131 audit(1738792452.522:134)=
: pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Duser-run=
time-dir@120 comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D?=
 addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:54:12 archvm systemd[1]: Removed slice User Slice of UID 120.
Feb 06 08:54:12 archvm systemd[1]: user-120.slice: Consumed 4.546s CPU time=
, 377.2M memory peak.
Feb 06 08:54:12 archvm systemd-logind[468]: Removed session 2.
Feb 06 08:54:18 archvm systemd-resolved[373]: Clock change detected. Flushi=
ng caches.
Feb 06 08:54:18 archvm systemd-timesyncd[374]: Contacted time server 159.19=
6.3.239:123 (2.arch.pool.ntp.org).
Feb 06 08:54:18 archvm systemd-timesyncd[374]: Initial clock synchronizatio=
n to Thu 2025-02-06 08:54:18.371109 AEDT.
Feb 06 08:54:21 archvm gnome-character[1616]: JS LOG: Characters Applicatio=
n exiting
Feb 06 08:54:30 archvm gnome-shell[1087]: Received error from D-Bus search =
provider firefox.desktop: Gio.DBusError: GDBus.Error:org.freedesktop.DBus.E=
rror.ServiceUnknown: The name is not activatable
Feb 06 08:54:30 archvm systemd[990]: Started dbus-:1.2-org.gnome.Calculator=
=2ESearchProvider@1.service.
Feb 06 08:54:30 archvm systemd[990]: Started dbus-:1.2-org.gnome.Characters=
@1.service.
Feb 06 08:54:30 archvm systemd[990]: Started dbus-:1.2-org.gnome.Contacts.S=
earchProvider@1.service.
Feb 06 08:54:30 archvm systemd[990]: Started dbus-:1.2-org.gnome.Nautilus@1=
=2Eservice.
Feb 06 08:54:30 archvm systemd[990]: Started dbus-:1.2-org.gnome.clocks@1.s=
ervice.
Feb 06 08:54:30 archvm nautilus[1851]: Connecting to org.freedesktop.Tracke=
r3.Miner.Files
Feb 06 08:54:30 archvm gnome-character[1849]: JS LOG: Characters Applicatio=
n started
Feb 06 08:54:30 archvm systemd[990]: Started dbus-:1.2-org.gnome.NautilusPr=
eviewer@1.service.
Feb 06 08:54:32 archvm systemd[1]: systemd-hostnamed.service: Deactivated s=
uccessfully.
Feb 06 08:54:32 archvm audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hostnamed comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
Feb 06 08:54:32 archvm kernel: audit: type=3D1131 audit(1738792472.650:135)=
: pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-=
hostnamed comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:54:32 archvm systemd[990]: Started Application launched by gnome-=
shell.
Feb 06 08:54:32 archvm systemd[990]: Starting flatpak session helper...
Feb 06 08:54:32 archvm systemd[990]: Started flatpak session helper.
Feb 06 08:54:32 archvm systemd[990]: Started app-flatpak-com.github.flxzt.r=
note-1941.scope.
Feb 06 08:54:37 archvm systemd[1]: systemd-localed.service: Deactivated suc=
cessfully.
Feb 06 08:54:37 archvm audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'unit=3Dsystemd-localed comm=3D"systemd" exe=3D=
"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:54:37 archvm kernel: audit: type=3D1131 audit(1738792477.170:136)=
: pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-=
localed comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=
=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:54:40 archvm gnome-character[1849]: JS LOG: Characters Applicatio=
n exiting
Feb 06 08:54:40 archvm systemd[1]: systemd-timedated.service: Deactivated s=
uccessfully.
Feb 06 08:54:40 archvm audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D429496=
7295 ses=3D4294967295 msg=3D'unit=3Dsystemd-timedated comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
Feb 06 08:54:40 archvm kernel: audit: type=3D1131 audit(1738792480.824:137)=
: pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-=
timedated comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:54:40 archvm audit: BPF prog-id=3D63 op=3DUNLOAD
Feb 06 08:54:40 archvm audit: BPF prog-id=3D62 op=3DUNLOAD
Feb 06 08:54:40 archvm audit: BPF prog-id=3D61 op=3DUNLOAD
Feb 06 08:54:40 archvm kernel: audit: type=3D1334 audit(1738792480.836:138)=
: prog-id=3D63 op=3DUNLOAD
Feb 06 08:54:40 archvm kernel: audit: type=3D1334 audit(1738792480.836:139)=
: prog-id=3D62 op=3DUNLOAD
Feb 06 08:54:40 archvm kernel: audit: type=3D1334 audit(1738792480.836:140)=
: prog-id=3D61 op=3DUNLOAD
Feb 06 08:54:43 archvm systemd[990]: Started dbus-:1.2-org.gnome.Nautilus@2=
=2Eservice.
Feb 06 08:54:43 archvm nautilus[2000]: Connecting to org.freedesktop.Tracke=
r3.Miner.Files
Feb 06 08:54:43 archvm systemd[990]: Started dbus-:1.2-org.gnome.NautilusPr=
eviewer@2.service.
Feb 06 08:54:43 archvm audit: BPF prog-id=3D64 op=3DLOAD
Feb 06 08:54:43 archvm audit: BPF prog-id=3D65 op=3DLOAD
Feb 06 08:54:43 archvm audit: BPF prog-id=3D66 op=3DLOAD
Feb 06 08:54:43 archvm kernel: audit: type=3D1334 audit(1738792483.699:141)=
: prog-id=3D64 op=3DLOAD
Feb 06 08:54:43 archvm kernel: audit: type=3D1334 audit(1738792483.699:142)=
: prog-id=3D65 op=3DLOAD
Feb 06 08:54:43 archvm kernel: audit: type=3D1334 audit(1738792483.699:143)=
: prog-id=3D66 op=3DLOAD
Feb 06 08:54:43 archvm systemd[1]: Starting Hostname Service...
Feb 06 08:54:43 archvm gvfsd[2031]: 2025-02-06 08:54:43,776:wsdd WARNING(pi=
d 2031): no interface given, using all interfaces
Feb 06 08:54:43 archvm systemd[1]: Started Hostname Service.
Feb 06 08:54:43 archvm audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42949=
67295 ses=3D4294967295 msg=3D'unit=3Dsystemd-hostnamed comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsucc=
ess'
Feb 06 08:54:43 archvm kernel: audit: type=3D1130 audit(1738792483.794:144)=
: pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-=
hostnamed comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? ad=
dr=3D? terminal=3D? res=3Dsuccess'
Feb 06 08:54:47 archvm kernel: BUG: Bad page state in process rnote  pfn:67=
587
Feb 06 08:54:47 archvm kernel: page: refcount:-1 mapcount:0 mapping:0000000=
000000000 index:0x0 pfn:0x67587
Feb 06 08:54:47 archvm kernel: flags: 0xfffffc8000020(lru|node=3D0|zone=3D1=
|lastcpupid=3D0x1fffff)
Feb 06 08:54:47 archvm kernel: raw: 000fffffc8000020 dead000000000100 dead0=
00000000122 0000000000000000
Feb 06 08:54:47 archvm kernel: raw: 0000000000000000 0000000000000000 fffff=
fffffffffff 0000000000000000
Feb 06 08:54:47 archvm kernel: page dumped because: PAGE_FLAGS_CHECK_AT_PRE=
P flag(s) set
Feb 06 08:54:47 archvm kernel: Modules linked in: snd_seq_dummy snd_hrtimer=
 snd_seq snd_seq_device rfkill vfat fat intel_rapl_msr intel_rapl_common kv=
m_amd ccp snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_intel_=
dspcfg kvm snd_intel_sdw_acpi snd_hda_codec polyval_clmulni snd_hda_core po=
lyval_generic ghash_clmulni_intel snd_hwdep iTCO_wdt sha512_ssse3 intel_pmc=
_bxt sha256_ssse3 snd_pcm joydev iTCO_vendor_support sha1_ssse3 snd_timer a=
esni_intel snd crypto_simd i2c_i801 psmouse cryptd pcspkr i2c_smbus soundco=
re lpc_ich i2c_mux mousedev mac_hid crypto_user loop dm_mod nfnetlink vsock=
_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock =
vmw_vmci qemu_fw_cfg ip_tables x_tables ext4 crc16 mbcache jbd2 nouveau drm=
_ttm_helper ttm video gpu_sched i2c_algo_bit drm_gpuvm serio_raw drm_exec a=
tkbd mxm_wmi wmi libps2 vivaldi_fmap drm_display_helper virtio_net net_fail=
over cec intel_agp virtio_input virtio_rng virtio_console failover virtio_b=
lk i8042 intel_gtt serio
Feb 06 08:54:47 archvm kernel: CPU: 0 UID: 1000 PID: 1962 Comm: rnote Not t=
ainted 6.14.0-rc1-1-mainline #1 715c0460cf5d3cc18e3178ef3209cee42e97ae1c
Feb 06 08:54:47 archvm kernel: Hardware name: QEMU Standard PC (Q35 + ICH9,=
 2009), BIOS unknown 02/02/2022
Feb 06 08:54:47 archvm kernel: Call Trace:
Feb 06 08:54:47 archvm kernel:
Feb 06 08:54:47 archvm kernel:  dump_stack_lvl+0x5d/0x80
Feb 06 08:54:47 archvm kernel:  bad_page.cold+0x7a/0x91
Feb 06 08:54:47 archvm kernel:  __rmqueue_pcplist+0x200/0xc50
Feb 06 08:54:47 archvm kernel:  get_page_from_freelist+0x2ae/0x1740
Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
Feb 06 08:54:47 archvm kernel:  ? __pm_runtime_suspend+0x69/0xc0
Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
Feb 06 08:54:47 archvm kernel:  ? __seccomp_filter+0x303/0x520
Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
Feb 06 08:54:47 archvm kernel:  __alloc_frozen_pages_noprof+0x184/0x330
Feb 06 08:54:47 archvm kernel:  alloc_pages_mpol+0x7d/0x160
Feb 06 08:54:47 archvm kernel:  folio_alloc_mpol_noprof+0x14/0x40
Feb 06 08:54:47 archvm kernel:  vma_alloc_folio_noprof+0x69/0xb0
Feb 06 08:54:47 archvm kernel:  do_anonymous_page+0x32a/0x8b0
Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
Feb 06 08:54:47 archvm kernel:  ? ___pte_offset_map+0x1b/0x180
Feb 06 08:54:47 archvm kernel:  __handle_mm_fault+0xb5e/0xfe0
Feb 06 08:54:47 archvm kernel:  handle_mm_fault+0xe2/0x2c0
Feb 06 08:54:47 archvm kernel:  do_user_addr_fault+0x217/0x620
Feb 06 08:54:47 archvm kernel:  exc_page_fault+0x81/0x1b0
Feb 06 08:54:47 archvm kernel:  asm_exc_page_fault+0x26/0x30
Feb 06 08:54:47 archvm kernel: RIP: 0033:0x7fcfc31c8cf9
Feb 06 08:54:47 archvm kernel: Code: 34 19 49 39 d4 49 89 74 24 60 0f 95 c2=
 48 29 d8 48 83 c1 10 0f b6 d2 48 83 c8 01 48 c1 e2 02 48 09 da 48 83 ca 01=
 48 89 51 f8 <48> 89 46 08 e9 22 ff ff ff 48 8d 3d 07 ed 10 00 e8 62 c3 ff =
ff 48
Feb 06 08:54:47 archvm kernel: RSP: 002b:00007fff1f931850 EFLAGS: 00010206
Feb 06 08:54:47 archvm kernel: RAX: 000000000000bee1 RBX: 0000000000000140 =
RCX: 000056541d491ff0
Feb 06 08:54:47 archvm kernel: RDX: 0000000000000141 RSI: 000056541d492120 =
RDI: 0000000000000000
Feb 06 08:54:47 archvm kernel: RBP: 00007fff1f9318a0 R08: 0000000000000140 =
R09: 0000000000000001
Feb 06 08:54:47 archvm kernel: R10: 0000000000000004 R11: 0000565419567488 =
R12: 00007fcfc3308ac0
Feb 06 08:54:47 archvm kernel: R13: 0000000000000130 R14: 00007fcfc3308b20 =
R15: 0000000000000140
Feb 06 08:54:47 archvm kernel:
Feb 06 08:54:47 archvm kernel: Disabling lock debugging due to kernel taint
Feb 06 08:54:47 archvm kernel: Oops: general protection fault, probably for=
 non-canonical address 0xdead000000000122: 0000 [#1] PREEMPT SMP NOPTI
Feb 06 08:54:47 archvm kernel: CPU: 0 UID: 1000 PID: 1962 Comm: rnote Taint=
ed: G    B              6.14.0-rc1-1-mainline #1 715c0460cf5d3cc18e3178ef32=
09cee42e97ae1c
Feb 06 08:54:47 archvm kernel: Tainted: [B]=3DBAD_PAGE
Feb 06 08:54:47 archvm kernel: Hardware name: QEMU Standard PC (Q35 + ICH9,=
 2009), BIOS unknown 02/02/2022
Feb 06 08:54:47 archvm kernel: RIP: 0010:__rmqueue_pcplist+0xb0/0xc50
Feb 06 08:54:47 archvm kernel: Code: 00 4c 01 f0 48 89 7c 24 30 48 89 44 24=
 20 49 8b 04 24 49 39 c4 0f 84 6c 01 00 00 49 8b 14 24 48 8b 42 08 48 8b 0a=
 48 8d 5a f8 <48> 3b 10 0f 85 8d 0b 00 00 48 3b 51 08 0f 85 d5 0f be ff 48 =
89 41
Feb 06 08:54:47 archvm kernel: RSP: 0000:ffffab3b84a2faa0 EFLAGS: 00010297
Feb 06 08:54:47 archvm kernel: RAX: dead000000000122 RBX: ffffdd38819d61c0 =
RCX: dead000000000100
Feb 06 08:54:47 archvm kernel: RDX: ffffdd38819d61c8 RSI: ffff9b31fd2218c0 =
RDI: ffff9b31fd2218c0
Feb 06 08:54:47 archvm kernel: RBP: 0000000000000010 R08: 0000000000000000 =
R09: ffffab3b84a2f920
Feb 06 08:54:47 archvm kernel: R10: ffffffffbdeb44a8 R11: 0000000000000003 =
R12: ffff9b31fd23d4b0
Feb 06 08:54:47 archvm kernel: R13: 0000000000000000 R14: ffff9b31fef21980 =
R15: ffff9b31fd23d480
Feb 06 08:54:47 archvm kernel: FS:  00007fcfbead5140(0000) GS:ffff9b31fd200=
000(0000) knlGS:0000000000000000
Feb 06 08:54:47 archvm kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
Feb 06 08:54:47 archvm kernel: CR2: 000056541d492128 CR3: 000000001ed94000 =
CR4: 00000000003506f0
Feb 06 08:54:47 archvm kernel: Call Trace:
Feb 06 08:54:47 archvm kernel:
Feb 06 08:54:47 archvm kernel:  ? __die_body.cold+0x19/0x27
Feb 06 08:54:47 archvm kernel:  ? die_addr+0x3c/0x60
Feb 06 08:54:47 archvm kernel:  ? exc_general_protection+0x17d/0x400
Feb 06 08:54:47 archvm kernel:  ? asm_exc_general_protection+0x26/0x30
Feb 06 08:54:47 archvm kernel:  ? __rmqueue_pcplist+0xb0/0xc50
Feb 06 08:54:47 archvm kernel:  get_page_from_freelist+0x2ae/0x1740
Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
Feb 06 08:54:47 archvm kernel:  ? __pm_runtime_suspend+0x69/0xc0
Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
Feb 06 08:54:47 archvm kernel:  ? __seccomp_filter+0x303/0x520
Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
Feb 06 08:54:47 archvm kernel:  __alloc_frozen_pages_noprof+0x184/0x330
Feb 06 08:54:47 archvm kernel:  alloc_pages_mpol+0x7d/0x160
Feb 06 08:54:47 archvm kernel:  folio_alloc_mpol_noprof+0x14/0x40
Feb 06 08:54:47 archvm kernel:  vma_alloc_folio_noprof+0x69/0xb0
Feb 06 08:54:47 archvm kernel:  do_anonymous_page+0x32a/0x8b0
Feb 06 08:54:47 archvm kernel:  ? srso_return_thunk+0x5/0x5f
Feb 06 08:54:47 archvm kernel:  ? ___pte_offset_map+0x1b/0x180
Feb 06 08:54:47 archvm kernel:  __handle_mm_fault+0xb5e/0xfe0
Feb 06 08:54:47 archvm kernel:  handle_mm_fault+0xe2/0x2c0
Feb 06 08:54:47 archvm kernel:  do_user_addr_fault+0x217/0x620
Feb 06 08:54:47 archvm kernel:  exc_page_fault+0x81/0x1b0
Feb 06 08:54:47 archvm kernel:  asm_exc_page_fault+0x26/0x30
Feb 06 08:54:47 archvm kernel: RIP: 0033:0x7fcfc31c8cf9
Feb 06 08:54:47 archvm kernel: Code: 34 19 49 39 d4 49 89 74 24 60 0f 95 c2=
 48 29 d8 48 83 c1 10 0f b6 d2 48 83 c8 01 48 c1 e2 02 48 09 da 48 83 ca 01=
 48 89 51 f8 <48> 89 46 08 e9 22 ff ff ff 48 8d 3d 07 ed 10 00 e8 62 c3 ff =
ff 48
Feb 06 08:54:47 archvm kernel: RSP: 002b:00007fff1f931850 EFLAGS: 00010206
Feb 06 08:54:47 archvm kernel: RAX: 000000000000bee1 RBX: 0000000000000140 =
RCX: 000056541d491ff0
Feb 06 08:54:47 archvm kernel: RDX: 0000000000000141 RSI: 000056541d492120 =
RDI: 0000000000000000
Feb 06 08:54:47 archvm kernel: RBP: 00007fff1f9318a0 R08: 0000000000000140 =
R09: 0000000000000001
Feb 06 08:54:47 archvm kernel: R10: 0000000000000004 R11: 0000565419567488 =
R12: 00007fcfc3308ac0
Feb 06 08:54:47 archvm kernel: R13: 0000000000000130 R14: 00007fcfc3308b20 =
R15: 0000000000000140
Feb 06 08:54:47 archvm kernel:
Feb 06 08:54:47 archvm kernel: Modules linked in: snd_seq_dummy snd_hrtimer=
 snd_seq snd_seq_device rfkill vfat fat intel_rapl_msr intel_rapl_common kv=
m_amd ccp snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_intel_=
dspcfg kvm snd_intel_sdw_acpi snd_hda_codec polyval_clmulni snd_hda_core po=
lyval_generic ghash_clmulni_intel snd_hwdep iTCO_wdt sha512_ssse3 intel_pmc=
_bxt sha256_ssse3 snd_pcm joydev iTCO_vendor_support sha1_ssse3 snd_timer a=
esni_intel snd crypto_simd i2c_i801 psmouse cryptd pcspkr i2c_smbus soundco=
re lpc_ich i2c_mux mousedev mac_hid crypto_user loop dm_mod nfnetlink vsock=
_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock =
vmw_vmci qemu_fw_cfg ip_tables x_tables ext4 crc16 mbcache jbd2 nouveau drm=
_ttm_helper ttm video gpu_sched i2c_algo_bit drm_gpuvm serio_raw drm_exec a=
tkbd mxm_wmi wmi libps2 vivaldi_fmap drm_display_helper virtio_net net_fail=
over cec intel_agp virtio_input virtio_rng virtio_console failover virtio_b=
lk i8042 intel_gtt serio
Feb 06 08:54:47 archvm kernel: ---[ end trace 0000000000000000 ]---
Feb 06 08:54:47 archvm kernel: RIP: 0010:__rmqueue_pcplist+0xb0/0xc50
Feb 06 08:54:47 archvm kernel: Code: 00 4c 01 f0 48 89 7c 24 30 48 89 44 24=
 20 49 8b 04 24 49 39 c4 0f 84 6c 01 00 00 49 8b 14 24 48 8b 42 08 48 8b 0a=
 48 8d 5a f8 <48> 3b 10 0f 85 8d 0b 00 00 48 3b 51 08 0f 85 d5 0f be ff 48 =
89 41
Feb 06 08:54:47 archvm kernel: RSP: 0000:ffffab3b84a2faa0 EFLAGS: 00010297
Feb 06 08:54:47 archvm kernel: RAX: dead000000000122 RBX: ffffdd38819d61c0 =
RCX: dead000000000100
Feb 06 08:54:47 archvm kernel: RDX: ffffdd38819d61c8 RSI: ffff9b31fd2218c0 =
RDI: ffff9b31fd2218c0
Feb 06 08:54:47 archvm kernel: RBP: 0000000000000010 R08: 0000000000000000 =
R09: ffffab3b84a2f920
Feb 06 08:54:47 archvm kernel: R10: ffffffffbdeb44a8 R11: 0000000000000003 =
R12: ffff9b31fd23d4b0
Feb 06 08:54:47 archvm kernel: R13: 0000000000000000 R14: ffff9b31fef21980 =
R15: ffff9b31fd23d480
Feb 06 08:54:47 archvm kernel: FS:  00007fcfbead5140(0000) GS:ffff9b31fd200=
000(0000) knlGS:0000000000000000
Feb 06 08:54:47 archvm kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
Feb 06 08:54:47 archvm kernel: CR2: 000056541d492128 CR3: 000000001ed94000 =
CR4: 00000000003506f0
Feb 06 08:54:47 archvm kernel: note: rnote[1962] exited with preempt_count 2
Feb 06 08:54:50 archvm geoclue[844]: Service not used for 60 seconds. Shutt=
ing down..
Feb 06 08:55:01 archvm systemd[990]: Starting Virtual filesystem metadata s=
ervice...
Feb 06 08:55:14 archvm kernel: watchdog: BUG: soft lockup - CPU#0 stuck for=
 26s! [kworker/0:3:370]
Feb 06 08:55:14 archvm kernel: CPU#0 Utilization every 4s during lockup:
Feb 06 08:55:14 archvm kernel:         #1: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:55:14 archvm kernel:         #2: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:55:14 archvm kernel:         #3: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:55:14 archvm kernel:         #4: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:55:14 archvm kernel:         #5: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:55:14 archvm kernel: Modules linked in: snd_seq_dummy snd_hrtimer=
 snd_seq snd_seq_device rfkill vfat fat intel_rapl_msr intel_rapl_common kv=
m_amd ccp snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_intel_=
dspcfg kvm snd_intel_sdw_acpi snd_hda_codec polyval_clmulni snd_hda_core po=
lyval_generic ghash_clmulni_intel snd_hwdep iTCO_wdt sha512_ssse3 intel_pmc=
_bxt sha256_ssse3 snd_pcm joydev iTCO_vendor_support sha1_ssse3 snd_timer a=
esni_intel snd crypto_simd i2c_i801 psmouse cryptd pcspkr i2c_smbus soundco=
re lpc_ich i2c_mux mousedev mac_hid crypto_user loop dm_mod nfnetlink vsock=
_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock =
vmw_vmci qemu_fw_cfg ip_tables x_tables ext4 crc16 mbcache jbd2 nouveau drm=
_ttm_helper ttm video gpu_sched i2c_algo_bit drm_gpuvm serio_raw drm_exec a=
tkbd mxm_wmi wmi libps2 vivaldi_fmap drm_display_helper virtio_net net_fail=
over cec intel_agp virtio_input virtio_rng virtio_console failover virtio_b=
lk i8042 intel_gtt serio
Feb 06 08:55:14 archvm kernel: CPU: 0 UID: 0 PID: 370 Comm: kworker/0:3 Tai=
nted: G    B D            6.14.0-rc1-1-mainline #1 715c0460cf5d3cc18e3178ef=
3209cee42e97ae1c
Feb 06 08:55:14 archvm kernel: Tainted: [B]=3DBAD_PAGE, [D]=3DDIE
Feb 06 08:55:14 archvm kernel: Hardware name: QEMU Standard PC (Q35 + ICH9,=
 2009), BIOS unknown 02/02/2022
Feb 06 08:55:14 archvm kernel: Workqueue: mm_percpu_wq vmstat_update
Feb 06 08:55:14 archvm kernel: RIP: 0010:__pv_queued_spin_lock_slowpath+0x2=
67/0x490
Feb 06 08:55:14 archvm kernel: Code: 14 0f 85 5c fe ff ff 41 c6 45 00 03 4c=
 89 fe 4c 89 ef e8 8c 2d 2e ff e9 47 fe ff ff f3 90 4d 8b 3e 4d 85 ff 74 f6=
 eb c1 f3 90 <83> ea 01 75 8a 48 83 3c 24 00 41 c6 45 01 00 0f 84 de 01 00 =
00 41
Feb 06 08:55:14 archvm kernel: RSP: 0018:ffffab3b80907c98 EFLAGS: 00000206
Feb 06 08:55:14 archvm kernel: RAX: 0000000000000003 RBX: 0000000000040000 =
RCX: 0000000000000008
Feb 06 08:55:14 archvm kernel: RDX: 00000000000053b7 RSI: 0000000000000003 =
RDI: ffff9b31fd23d480
Feb 06 08:55:14 archvm kernel: RBP: 0000000000000001 R08: ffff9b31fd237bc0 =
R09: 0000000000000000
Feb 06 08:55:14 archvm kernel: R10: 0000000000000000 R11: fefefefefefefeff =
R12: 0000000000000100
Feb 06 08:55:14 archvm kernel: R13: ffff9b31fd23d480 R14: ffff9b31fd237bc0 =
R15: 0000000000000000
Feb 06 08:55:14 archvm kernel: FS:  0000000000000000(0000) GS:ffff9b31fd200=
000(0000) knlGS:0000000000000000
Feb 06 08:55:14 archvm kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
Feb 06 08:55:14 archvm kernel: CR2: 00007fa8ba718100 CR3: 0000000016022000 =
CR4: 00000000003506f0
Feb 06 08:55:14 archvm kernel: Call Trace:
Feb 06 08:55:14 archvm kernel:
Feb 06 08:55:14 archvm kernel:  ? watchdog_timer_fn.cold+0x226/0x22b
Feb 06 08:55:14 archvm kernel:  ? srso_return_thunk+0x5/0x5f
Feb 06 08:55:14 archvm kernel:  ? __pfx_watchdog_timer_fn+0x10/0x10
Feb 06 08:55:14 archvm kernel:  ? __hrtimer_run_queues+0x132/0x2a0
Feb 06 08:55:14 archvm kernel:  ? hrtimer_interrupt+0xff/0x230
Feb 06 08:55:14 archvm kernel:  ? __sysvec_apic_timer_interrupt+0x55/0x100
Feb 06 08:55:14 archvm kernel:  ? sysvec_apic_timer_interrupt+0x6c/0x90
Feb 06 08:55:14 archvm kernel:
Feb 06 08:55:14 archvm kernel:
Feb 06 08:55:14 archvm kernel:  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
Feb 06 08:55:14 archvm kernel:  ? __pv_queued_spin_lock_slowpath+0x267/0x490
Feb 06 08:55:14 archvm kernel:  ? __pv_queued_spin_lock_slowpath+0x2be/0x490
Feb 06 08:55:14 archvm kernel:  _raw_spin_lock+0x29/0x30
Feb 06 08:55:14 archvm kernel:  decay_pcp_high+0x63/0x90
Feb 06 08:55:14 archvm kernel:  refresh_cpu_vm_stats+0xf7/0x240
Feb 06 08:55:14 archvm kernel:  vmstat_update+0x13/0x50
Feb 06 08:55:14 archvm kernel:  process_one_work+0x17e/0x330
Feb 06 08:55:14 archvm kernel:  worker_thread+0x2ce/0x3f0
Feb 06 08:55:14 archvm kernel:  ? __pfx_worker_thread+0x10/0x10
Feb 06 08:55:14 archvm kernel:  kthread+0xef/0x230
Feb 06 08:55:14 archvm kernel:  ? __pfx_kthread+0x10/0x10
Feb 06 08:55:14 archvm kernel:  ret_from_fork+0x34/0x50
Feb 06 08:55:14 archvm kernel:  ? __pfx_kthread+0x10/0x10
Feb 06 08:55:14 archvm kernel:  ret_from_fork_asm+0x1a/0x30
Feb 06 08:55:14 archvm kernel:
Feb 06 08:55:26 archvm gnome-shell[1087]: Error: Error calling StartService=
ByName for org.gtk.vfs.Metadata: Timeout was reached
Feb 06 08:55:30 archvm epiphany-search[1618]: broker.vala:159: Error loadin=
g plugin: libhunspell-1.7.so.0: cannot open shared object file: No such fil=
e or directory
Feb 06 08:55:30 archvm epiphany-search[1618]: broker.vala:159: Error loadin=
g plugin: libhspell.so.0: cannot open shared object file: No such file or d=
irectory
Feb 06 08:55:30 archvm epiphany-search[1618]: broker.vala:159: Error loadin=
g plugin: libaspell.so.15: cannot open shared object file: No such file or =
directory
Feb 06 08:55:30 archvm epiphany-search[1618]: broker.vala:159: Error loadin=
g plugin: libvoikko.so.1: cannot open shared object file: No such file or d=
irectory
Feb 06 08:55:30 archvm epiphany-search[1618]: broker.vala:159: Error loadin=
g plugin: libnuspell.so.5: cannot open shared object file: No such file or =
directory
Feb 06 08:55:42 archvm kernel: watchdog: BUG: soft lockup - CPU#0 stuck for=
 52s! [kworker/0:3:370]
Feb 06 08:55:42 archvm kernel: CPU#0 Utilization every 4s during lockup:
Feb 06 08:55:42 archvm kernel:         #1: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:55:42 archvm kernel:         #2: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:55:42 archvm kernel:         #3: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:55:42 archvm kernel:         #4: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:55:42 archvm kernel:         #5: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:55:42 archvm kernel: Modules linked in: snd_seq_dummy snd_hrtimer=
 snd_seq snd_seq_device rfkill vfat fat intel_rapl_msr intel_rapl_common kv=
m_amd ccp snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_intel_=
dspcfg kvm snd_intel_sdw_acpi snd_hda_codec polyval_clmulni snd_hda_core po=
lyval_generic ghash_clmulni_intel snd_hwdep iTCO_wdt sha512_ssse3 intel_pmc=
_bxt sha256_ssse3 snd_pcm joydev iTCO_vendor_support sha1_ssse3 snd_timer a=
esni_intel snd crypto_simd i2c_i801 psmouse cryptd pcspkr i2c_smbus soundco=
re lpc_ich i2c_mux mousedev mac_hid crypto_user loop dm_mod nfnetlink vsock=
_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock =
vmw_vmci qemu_fw_cfg ip_tables x_tables ext4 crc16 mbcache jbd2 nouveau drm=
_ttm_helper ttm video gpu_sched i2c_algo_bit drm_gpuvm serio_raw drm_exec a=
tkbd mxm_wmi wmi libps2 vivaldi_fmap drm_display_helper virtio_net net_fail=
over cec intel_agp virtio_input virtio_rng virtio_console failover virtio_b=
lk i8042 intel_gtt serio
Feb 06 08:55:42 archvm kernel: CPU: 0 UID: 0 PID: 370 Comm: kworker/0:3 Tai=
nted: G    B D      L     6.14.0-rc1-1-mainline #1 715c0460cf5d3cc18e3178ef=
3209cee42e97ae1c
Feb 06 08:55:42 archvm kernel: Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [L]=3DSO=
FTLOCKUP
Feb 06 08:55:42 archvm kernel: Hardware name: QEMU Standard PC (Q35 + ICH9,=
 2009), BIOS unknown 02/02/2022
Feb 06 08:55:42 archvm kernel: Workqueue: mm_percpu_wq vmstat_update
Feb 06 08:55:42 archvm kernel: RIP: 0010:__pv_queued_spin_lock_slowpath+0x2=
67/0x490
Feb 06 08:55:42 archvm kernel: Code: 14 0f 85 5c fe ff ff 41 c6 45 00 03 4c=
 89 fe 4c 89 ef e8 8c 2d 2e ff e9 47 fe ff ff f3 90 4d 8b 3e 4d 85 ff 74 f6=
 eb c1 f3 90 <83> ea 01 75 8a 48 83 3c 24 00 41 c6 45 01 00 0f 84 de 01 00 =
00 41
Feb 06 08:55:42 archvm kernel: RSP: 0018:ffffab3b80907c98 EFLAGS: 00000206
Feb 06 08:55:42 archvm kernel: RAX: 0000000000000003 RBX: 0000000000040000 =
RCX: 0000000000000008
Feb 06 08:55:42 archvm kernel: RDX: 00000000000024c1 RSI: 0000000000000003 =
RDI: ffff9b31fd23d480
Feb 06 08:55:42 archvm kernel: RBP: 0000000000000001 R08: ffff9b31fd237bc0 =
R09: 0000000000000000
Feb 06 08:55:42 archvm kernel: R10: 0000000000000000 R11: fefefefefefefeff =
R12: 0000000000000100
Feb 06 08:55:42 archvm kernel: R13: ffff9b31fd23d480 R14: ffff9b31fd237bc0 =
R15: 0000000000000000
Feb 06 08:55:42 archvm kernel: FS:  0000000000000000(0000) GS:ffff9b31fd200=
000(0000) knlGS:0000000000000000
Feb 06 08:55:42 archvm kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
Feb 06 08:55:42 archvm kernel: CR2: 00007fa8ba718100 CR3: 0000000016022000 =
CR4: 00000000003506f0
Feb 06 08:55:42 archvm kernel: Call Trace:
Feb 06 08:55:42 archvm kernel:
Feb 06 08:55:42 archvm kernel:  ? watchdog_timer_fn.cold+0x226/0x22b
Feb 06 08:55:42 archvm kernel:  ? srso_return_thunk+0x5/0x5f
Feb 06 08:55:42 archvm kernel:  ? __pfx_watchdog_timer_fn+0x10/0x10
Feb 06 08:55:42 archvm kernel:  ? __hrtimer_run_queues+0x132/0x2a0
Feb 06 08:55:42 archvm kernel:  ? hrtimer_interrupt+0xff/0x230
Feb 06 08:55:42 archvm kernel:  ? __sysvec_apic_timer_interrupt+0x55/0x100
Feb 06 08:55:42 archvm kernel:  ? sysvec_apic_timer_interrupt+0x6c/0x90
Feb 06 08:55:42 archvm kernel:
Feb 06 08:55:42 archvm kernel:
Feb 06 08:55:42 archvm kernel:  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
Feb 06 08:55:42 archvm kernel:  ? __pv_queued_spin_lock_slowpath+0x267/0x490
Feb 06 08:55:42 archvm kernel:  ? __pv_queued_spin_lock_slowpath+0x2be/0x490
Feb 06 08:55:42 archvm kernel:  _raw_spin_lock+0x29/0x30
Feb 06 08:55:42 archvm kernel:  decay_pcp_high+0x63/0x90
Feb 06 08:55:42 archvm kernel:  refresh_cpu_vm_stats+0xf7/0x240
Feb 06 08:55:42 archvm kernel:  vmstat_update+0x13/0x50
Feb 06 08:55:42 archvm kernel:  process_one_work+0x17e/0x330
Feb 06 08:55:42 archvm kernel:  worker_thread+0x2ce/0x3f0
Feb 06 08:55:42 archvm kernel:  ? __pfx_worker_thread+0x10/0x10
Feb 06 08:55:42 archvm kernel:  kthread+0xef/0x230
Feb 06 08:55:42 archvm kernel:  ? __pfx_kthread+0x10/0x10
Feb 06 08:55:42 archvm kernel:  ret_from_fork+0x34/0x50
Feb 06 08:55:42 archvm kernel:  ? __pfx_kthread+0x10/0x10
Feb 06 08:55:42 archvm kernel:  ret_from_fork_asm+0x1a/0x30
Feb 06 08:55:42 archvm kernel:
Feb 06 08:55:50 archvm kernel: rcu: INFO: rcu_preempt detected stalls on CP=
Us/tasks:
Feb 06 08:55:50 archvm kernel: rcu:         (detected by 7, t=3D60002 jiffi=
es, g=3D13761, q=3D4009 ncpus=3D8)
Feb 06 08:55:50 archvm kernel: rcu: All QSes seen, last rcu_preempt kthread=
 activity 60002 (4294795144-4294735142), jiffies_till_next_fqs=3D3, root ->=
qsmask 0x0
Feb 06 08:55:50 archvm kernel: rcu: rcu_preempt kthread starved for 60002 j=
iffies! g13761 f0x2 RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
Feb 06 08:55:50 archvm kernel: rcu:         Unless rcu_preempt kthread gets=
 sufficient CPU time, OOM is now expected behavior.
Feb 06 08:55:50 archvm kernel: rcu: RCU grace-period kthread stack dump:
Feb 06 08:55:50 archvm kernel: task:rcu_preempt     state:R  running task  =
   stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0=
x00004000
Feb 06 08:55:50 archvm kernel: Call Trace:
Feb 06 08:55:50 archvm kernel:
Feb 06 08:55:50 archvm kernel:  ? __pfx_rcu_gp_kthread+0x10/0x10
Feb 06 08:55:50 archvm kernel:  __schedule+0x45f/0x1310
Feb 06 08:55:50 archvm kernel:  ? psi_group_change+0x13b/0x310
Feb 06 08:55:50 archvm kernel:  ? srso_return_thunk+0x5/0x5f
Feb 06 08:55:50 archvm kernel:  ? lock_timer_base+0x6d/0x90
Feb 06 08:55:50 archvm kernel:  ? srso_return_thunk+0x5/0x5f
Feb 06 08:55:50 archvm kernel:  ? __pfx_rcu_gp_kthread+0x10/0x10
Feb 06 08:55:50 archvm kernel:  schedule+0x27/0xf0
Feb 06 08:55:50 archvm kernel:  schedule_timeout+0x84/0x100
Feb 06 08:55:50 archvm kernel:  ? __pfx_process_timeout+0x10/0x10
Feb 06 08:55:50 archvm kernel:  rcu_gp_fqs_loop+0x10b/0x530
Feb 06 08:55:50 archvm kernel:  ? srso_return_thunk+0x5/0x5f
Feb 06 08:55:50 archvm kernel:  rcu_gp_kthread+0xdc/0x1a0
Feb 06 08:55:50 archvm kernel:  kthread+0xef/0x230
Feb 06 08:55:50 archvm kernel:  ? __pfx_kthread+0x10/0x10
Feb 06 08:55:50 archvm kernel:  ret_from_fork+0x34/0x50
Feb 06 08:55:50 archvm kernel:  ? __pfx_kthread+0x10/0x10
Feb 06 08:55:50 archvm kernel:  ret_from_fork_asm+0x1a/0x30
Feb 06 08:55:50 archvm kernel:
Feb 06 08:55:50 archvm kernel: rcu: Stack dump where RCU GP kthread last ra=
n:
Feb 06 08:55:50 archvm kernel: Sending NMI from CPU 7 to CPUs 0:
Feb 06 08:55:50 archvm kernel: NMI backtrace for cpu 0
Feb 06 08:55:50 archvm kernel: CPU: 0 UID: 0 PID: 370 Comm: kworker/0:3 Tai=
nted: G    B D      L     6.14.0-rc1-1-mainline #1 715c0460cf5d3cc18e3178ef=
3209cee42e97ae1c
Feb 06 08:55:50 archvm kernel: Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [L]=3DSO=
FTLOCKUP
Feb 06 08:55:50 archvm kernel: Hardware name: QEMU Standard PC (Q35 + ICH9,=
 2009), BIOS unknown 02/02/2022
Feb 06 08:55:50 archvm kernel: Workqueue: mm_percpu_wq vmstat_update
Feb 06 08:55:50 archvm kernel: RIP: 0010:__pv_queued_spin_lock_slowpath+0x2=
67/0x490
Feb 06 08:55:50 archvm kernel: Code: 14 0f 85 5c fe ff ff 41 c6 45 00 03 4c=
 89 fe 4c 89 ef e8 8c 2d 2e ff e9 47 fe ff ff f3 90 4d 8b 3e 4d 85 ff 74 f6=
 eb c1 f3 90 <83> ea 01 75 8a 48 83 3c 24 00 41 c6 45 01 00 0f 84 de 01 00 =
00 41
Feb 06 08:55:50 archvm kernel: RSP: 0018:ffffab3b80907c98 EFLAGS: 00000206
Feb 06 08:55:50 archvm kernel: RAX: 0000000000000003 RBX: 0000000000040000 =
RCX: 0000000000000008
Feb 06 08:55:50 archvm kernel: RDX: 0000000000005a57 RSI: 0000000000000003 =
RDI: ffff9b31fd23d480
Feb 06 08:55:50 archvm kernel: RBP: 0000000000000001 R08: ffff9b31fd237bc0 =
R09: 0000000000000000
Feb 06 08:55:50 archvm kernel: R10: 0000000000000000 R11: fefefefefefefeff =
R12: 0000000000000100
Feb 06 08:55:50 archvm kernel: R13: ffff9b31fd23d480 R14: ffff9b31fd237bc0 =
R15: 0000000000000000
Feb 06 08:55:50 archvm kernel: FS:  0000000000000000(0000) GS:ffff9b31fd200=
000(0000) knlGS:0000000000000000
Feb 06 08:55:50 archvm kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
Feb 06 08:55:50 archvm kernel: CR2: 00007fa8ba718100 CR3: 0000000016022000 =
CR4: 00000000003506f0
Feb 06 08:55:50 archvm kernel: Call Trace:
Feb 06 08:55:50 archvm kernel:
Feb 06 08:55:50 archvm kernel:  ? nmi_cpu_backtrace.cold+0x32/0x68
Feb 06 08:55:50 archvm kernel:  ? nmi_cpu_backtrace_handler+0x11/0x20
Feb 06 08:55:50 archvm kernel:  ? nmi_handle+0x61/0x120
Feb 06 08:55:50 archvm kernel:  ? default_do_nmi+0x40/0x130
Feb 06 08:55:50 archvm kernel:  ? exc_nmi+0x122/0x1a0
Feb 06 08:55:50 archvm kernel:  ? end_repeat_nmi+0xf/0x53
Feb 06 08:55:50 archvm kernel:  ? __pv_queued_spin_lock_slowpath+0x267/0x490
Feb 06 08:55:50 archvm kernel:  ? __pv_queued_spin_lock_slowpath+0x267/0x490
Feb 06 08:55:50 archvm kernel:  ? __pv_queued_spin_lock_slowpath+0x267/0x490
Feb 06 08:55:50 archvm kernel:
Feb 06 08:55:50 archvm kernel:
Feb 06 08:55:50 archvm kernel:  _raw_spin_lock+0x29/0x30
Feb 06 08:55:50 archvm kernel:  decay_pcp_high+0x63/0x90
Feb 06 08:55:50 archvm kernel:  refresh_cpu_vm_stats+0xf7/0x240
Feb 06 08:55:50 archvm kernel:  vmstat_update+0x13/0x50
Feb 06 08:55:50 archvm kernel:  process_one_work+0x17e/0x330
Feb 06 08:55:50 archvm kernel:  worker_thread+0x2ce/0x3f0
Feb 06 08:55:50 archvm kernel:  ? __pfx_worker_thread+0x10/0x10
Feb 06 08:55:50 archvm kernel:  kthread+0xef/0x230
Feb 06 08:55:50 archvm kernel:  ? __pfx_kthread+0x10/0x10
Feb 06 08:55:50 archvm kernel:  ret_from_fork+0x34/0x50
Feb 06 08:55:50 archvm kernel:  ? __pfx_kthread+0x10/0x10
Feb 06 08:55:50 archvm kernel:  ret_from_fork_asm+0x1a/0x30
Feb 06 08:55:50 archvm kernel:
Feb 06 08:55:50 archvm kernel: rcu: INFO: rcu_preempt detected expedited st=
alls on CPUs/tasks: { 0-.... } 60017 jiffies s: 1033 root: 0x1/.
Feb 06 08:55:50 archvm kernel: rcu: blocking rcu_node structures (internal =
RCU debug):
Feb 06 08:55:50 archvm kernel: Sending NMI from CPU 3 to CPUs 0:
Feb 06 08:55:50 archvm kernel: NMI backtrace for cpu 0
Feb 06 08:55:50 archvm kernel: CPU: 0 UID: 0 PID: 370 Comm: kworker/0:3 Tai=
nted: G    B D      L     6.14.0-rc1-1-mainline #1 715c0460cf5d3cc18e3178ef=
3209cee42e97ae1c
Feb 06 08:55:50 archvm kernel: Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [L]=3DSO=
FTLOCKUP
Feb 06 08:55:50 archvm kernel: Hardware name: QEMU Standard PC (Q35 + ICH9,=
 2009), BIOS unknown 02/02/2022
Feb 06 08:55:50 archvm kernel: Workqueue: mm_percpu_wq vmstat_update
Feb 06 08:55:50 archvm kernel: RIP: 0010:__pv_queued_spin_lock_slowpath+0x2=
67/0x490
Feb 06 08:55:50 archvm kernel: Code: 14 0f 85 5c fe ff ff 41 c6 45 00 03 4c=
 89 fe 4c 89 ef e8 8c 2d 2e ff e9 47 fe ff ff f3 90 4d 8b 3e 4d 85 ff 74 f6=
 eb c1 f3 90 <83> ea 01 75 8a 48 83 3c 24 00 41 c6 45 01 00 0f 84 de 01 00 =
00 41
Feb 06 08:55:50 archvm kernel: RSP: 0018:ffffab3b80907c98 EFLAGS: 00000206
Feb 06 08:55:50 archvm kernel: RAX: 0000000000000003 RBX: 0000000000040000 =
RCX: 0000000000000008
Feb 06 08:55:50 archvm kernel: RDX: 0000000000006f78 RSI: 0000000000000003 =
RDI: ffff9b31fd23d480
Feb 06 08:55:50 archvm kernel: RBP: 0000000000000001 R08: ffff9b31fd237bc0 =
R09: 0000000000000000
Feb 06 08:55:50 archvm kernel: R10: 0000000000000000 R11: fefefefefefefeff =
R12: 0000000000000100
Feb 06 08:55:50 archvm kernel: R13: ffff9b31fd23d480 R14: ffff9b31fd237bc0 =
R15: 0000000000000000
Feb 06 08:55:50 archvm kernel: FS:  0000000000000000(0000) GS:ffff9b31fd200=
000(0000) knlGS:0000000000000000
Feb 06 08:55:50 archvm kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
Feb 06 08:55:50 archvm kernel: CR2: 00007fa8ba718100 CR3: 0000000016022000 =
CR4: 00000000003506f0
Feb 06 08:55:50 archvm kernel: Call Trace:
Feb 06 08:55:50 archvm kernel:
Feb 06 08:55:50 archvm kernel:  ? nmi_cpu_backtrace.cold+0x32/0x68
Feb 06 08:55:50 archvm kernel:  ? nmi_cpu_backtrace_handler+0x11/0x20
Feb 06 08:55:50 archvm kernel:  ? nmi_handle+0x61/0x120
Feb 06 08:55:50 archvm kernel:  ? default_do_nmi+0x40/0x130
Feb 06 08:55:50 archvm kernel:  ? exc_nmi+0x122/0x1a0
Feb 06 08:55:50 archvm kernel:  ? end_repeat_nmi+0xf/0x53
Feb 06 08:55:50 archvm kernel:  ? __pv_queued_spin_lock_slowpath+0x267/0x490
Feb 06 08:55:50 archvm kernel:  ? __pv_queued_spin_lock_slowpath+0x267/0x490
Feb 06 08:55:50 archvm kernel:  ? __pv_queued_spin_lock_slowpath+0x267/0x490
Feb 06 08:55:50 archvm kernel:
Feb 06 08:55:50 archvm kernel:
Feb 06 08:55:50 archvm kernel:  _raw_spin_lock+0x29/0x30
Feb 06 08:55:50 archvm kernel:  decay_pcp_high+0x63/0x90
Feb 06 08:55:50 archvm kernel:  refresh_cpu_vm_stats+0xf7/0x240
Feb 06 08:55:50 archvm kernel:  vmstat_update+0x13/0x50
Feb 06 08:55:50 archvm kernel:  process_one_work+0x17e/0x330
Feb 06 08:55:50 archvm kernel:  worker_thread+0x2ce/0x3f0
Feb 06 08:55:50 archvm kernel:  ? __pfx_worker_thread+0x10/0x10
Feb 06 08:55:50 archvm kernel:  kthread+0xef/0x230
Feb 06 08:55:50 archvm kernel:  ? __pfx_kthread+0x10/0x10
Feb 06 08:55:50 archvm kernel:  ret_from_fork+0x34/0x50
Feb 06 08:55:50 archvm kernel:  ? __pfx_kthread+0x10/0x10
Feb 06 08:55:50 archvm kernel:  ret_from_fork_asm+0x1a/0x30
Feb 06 08:55:50 archvm kernel:
Feb 06 08:56:11 archvm gnome-shell[1087]: Received error from D-Bus search =
provider firefox.desktop: Gio.DBusError: GDBus.Error:org.freedesktop.DBus.E=
rror.ServiceUnknown: The name is not activatable
Feb 06 08:56:11 archvm gnome-shell[1087]: Received error from D-Bus search =
provider firefox.desktop: Gio.DBusError: GDBus.Error:org.freedesktop.DBus.E=
rror.ServiceUnknown: The name is not activatable
Feb 06 08:56:11 archvm gnome-shell[1087]: Received error from D-Bus search =
provider firefox.desktop: Gio.DBusError: GDBus.Error:org.freedesktop.DBus.E=
rror.ServiceUnknown: The name is not activatable
Feb 06 08:56:11 archvm gnome-shell[1087]: Received error from D-Bus search =
provider firefox.desktop: Gio.DBusError: GDBus.Error:org.freedesktop.DBus.E=
rror.ServiceUnknown: The name is not activatable
Feb 06 08:56:12 archvm gnome-shell[1087]: cogl_framebuffer_set_viewport: as=
sertion 'width > 0 && height > 0' failed
Feb 06 08:56:12 archvm gnome-shell[1087]: cogl_framebuffer_set_viewport: as=
sertion 'width > 0 && height > 0' failed
Feb 06 08:56:12 archvm gnome-shell[1087]: cogl_framebuffer_set_viewport: as=
sertion 'width > 0 && height > 0' failed
Feb 06 08:56:14 archvm kernel: watchdog: BUG: soft lockup - CPU#0 stuck for=
 82s! [kworker/0:3:370]
Feb 06 08:56:14 archvm kernel: CPU#0 Utilization every 4s during lockup:
Feb 06 08:56:14 archvm kernel:         #1: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:56:14 archvm kernel:         #2: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:56:14 archvm kernel:         #3: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:56:14 archvm kernel:         #4: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:56:14 archvm kernel:         #5: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:56:14 archvm kernel: Modules linked in: snd_seq_dummy snd_hrtimer=
 snd_seq snd_seq_device rfkill vfat fat intel_rapl_msr intel_rapl_common kv=
m_amd ccp snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_intel_=
dspcfg kvm snd_intel_sdw_acpi snd_hda_codec polyval_clmulni snd_hda_core po=
lyval_generic ghash_clmulni_intel snd_hwdep iTCO_wdt sha512_ssse3 intel_pmc=
_bxt sha256_ssse3 snd_pcm joydev iTCO_vendor_support sha1_ssse3 snd_timer a=
esni_intel snd crypto_simd i2c_i801 psmouse cryptd pcspkr i2c_smbus soundco=
re lpc_ich i2c_mux mousedev mac_hid crypto_user loop dm_mod nfnetlink vsock=
_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock =
vmw_vmci qemu_fw_cfg ip_tables x_tables ext4 crc16 mbcache jbd2 nouveau drm=
_ttm_helper ttm video gpu_sched i2c_algo_bit drm_gpuvm serio_raw drm_exec a=
tkbd mxm_wmi wmi libps2 vivaldi_fmap drm_display_helper virtio_net net_fail=
over cec intel_agp virtio_input virtio_rng virtio_console failover virtio_b=
lk i8042 intel_gtt serio
Feb 06 08:56:14 archvm kernel: CPU: 0 UID: 0 PID: 370 Comm: kworker/0:3 Tai=
nted: G    B D      L     6.14.0-rc1-1-mainline #1 715c0460cf5d3cc18e3178ef=
3209cee42e97ae1c
Feb 06 08:56:14 archvm kernel: Tainted: [B]=3DBAD_PAGE, [D]=3DDIE, [L]=3DSO=
FTLOCKUP
Feb 06 08:56:14 archvm kernel: Hardware name: QEMU Standard PC (Q35 + ICH9,=
 2009), BIOS unknown 02/02/2022
Feb 06 08:56:14 archvm kernel: Workqueue: mm_percpu_wq vmstat_update
Feb 06 08:56:14 archvm kernel: RIP: 0010:__pv_queued_spin_lock_slowpath+0x2=
67/0x490
Feb 06 08:56:14 archvm kernel: Code: 14 0f 85 5c fe ff ff 41 c6 45 00 03 4c=
 89 fe 4c 89 ef e8 8c 2d 2e ff e9 47 fe ff ff f3 90 4d 8b 3e 4d 85 ff 74 f6=
 eb c1 f3 90 <83> ea 01 75 8a 48 83 3c 24 00 41 c6 45 01 00 0f 84 de 01 00 =
00 41
Feb 06 08:56:14 archvm kernel: RSP: 0018:ffffab3b80907c98 EFLAGS: 00000206
Feb 06 08:56:14 archvm kernel: RAX: 0000000000000003 RBX: 0000000000040000 =
RCX: 0000000000000008
Feb 06 08:56:14 archvm kernel: RDX: 00000000000024a2 RSI: 0000000000000003 =
RDI: ffff9b31fd23d480
Feb 06 08:56:14 archvm kernel: RBP: 0000000000000001 R08: ffff9b31fd237bc0 =
R09: 0000000000000000
Feb 06 08:56:14 archvm kernel: R10: 0000000000000000 R11: fefefefefefefeff =
R12: 0000000000000100
Feb 06 08:56:14 archvm kernel: R13: ffff9b31fd23d480 R14: ffff9b31fd237bc0 =
R15: 0000000000000000
Feb 06 08:56:14 archvm kernel: FS:  0000000000000000(0000) GS:ffff9b31fd200=
000(0000) knlGS:0000000000000000
Feb 06 08:56:14 archvm kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
Feb 06 08:56:14 archvm kernel: CR2: 00007fa8ba718100 CR3: 0000000016022000 =
CR4: 00000000003506f0
Feb 06 08:56:14 archvm kernel: Call Trace:
Feb 06 08:56:14 archvm kernel:
Feb 06 08:56:14 archvm kernel:  ? watchdog_timer_fn.cold+0x226/0x22b
Feb 06 08:56:14 archvm kernel:  ? srso_return_thunk+0x5/0x5f
Feb 06 08:56:14 archvm kernel:  ? __pfx_watchdog_timer_fn+0x10/0x10
Feb 06 08:56:14 archvm kernel:  ? __hrtimer_run_queues+0x132/0x2a0
Feb 06 08:56:14 archvm kernel:  ? hrtimer_interrupt+0xff/0x230
Feb 06 08:56:14 archvm kernel:  ? __sysvec_apic_timer_interrupt+0x55/0x100
Feb 06 08:56:14 archvm kernel:  ? sysvec_apic_timer_interrupt+0x6c/0x90
Feb 06 08:56:14 archvm kernel:
Feb 06 08:56:14 archvm kernel:
Feb 06 08:56:14 archvm kernel:  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
Feb 06 08:56:14 archvm kernel:  ? __pv_queued_spin_lock_slowpath+0x267/0x490
Feb 06 08:56:14 archvm kernel:  ? __pv_queued_spin_lock_slowpath+0x2be/0x490
Feb 06 08:56:14 archvm kernel:  _raw_spin_lock+0x29/0x30
Feb 06 08:56:14 archvm kernel:  decay_pcp_high+0x63/0x90
Feb 06 08:56:14 archvm kernel:  refresh_cpu_vm_stats+0xf7/0x240
Feb 06 08:56:14 archvm kernel:  vmstat_update+0x13/0x50
Feb 06 08:56:14 archvm kernel:  process_one_work+0x17e/0x330
Feb 06 08:56:14 archvm kernel:  worker_thread+0x2ce/0x3f0
Feb 06 08:56:14 archvm kernel:  ? __pfx_worker_thread+0x10/0x10
Feb 06 08:56:14 archvm kernel:  kthread+0xef/0x230
Feb 06 08:56:14 archvm kernel:  ? __pfx_kthread+0x10/0x10
Feb 06 08:56:14 archvm kernel:  ret_from_fork+0x34/0x50
Feb 06 08:56:14 archvm kernel:  ? __pfx_kthread+0x10/0x10
Feb 06 08:56:14 archvm kernel:  ret_from_fork_asm+0x1a/0x30
Feb 06 08:56:14 archvm kernel:
Feb 06 08:56:20 archvm systemd[1]: geoclue.service: State 'stop-sigterm' ti=
med out. Killing.
Feb 06 08:56:20 archvm systemd[1]: geoclue.service: Killing process 844 (ge=
oclue) with signal SIGKILL.
Feb 06 08:56:20 archvm systemd[1]: geoclue.service: Killing process 871 (gm=
ain) with signal SIGKILL.
Feb 06 08:56:38 archvm qemu-ga[463]: info: guest-shutdown called, mode: pow=
erdown
Feb 06 08:56:38 archvm systemd-logind[468]: Creating /run/nologin, blocking=
 further logins...
Feb 06 08:56:38 archvm systemd-logind[468]: System is powering down (hyperv=
isor initiated shutdown).
Feb 06 08:56:38 archvm systemd[1]: Stopping Session 3 of User arch...
Feb 06 08:56:38 archvm gdm-password][978]: pam_unix(gdm-password:session): =
session closed for user arch
Feb 06 08:56:38 archvm audit[978]: USER_END pid=3D978 uid=3D0 auid=3D1000 s=
es=3D3 msg=3D'op=3DPAM:session_close grantors=3Dpam_loginuid,pam_keyinit,pa=
m_systemd_home,pam_limits,pam_unix,pam_permit,pam_mail,pam_umask,pam_system=
d,pam_env,pam_gnome_keyring acct=3D"arch" exe=3D"/usr/lib/gdm-session-worke=
r" hostname=3Darchvm addr=3D? terminal=3D/dev/tty2 res=3Dsuccess'
Feb 06 08:56:38 archvm kernel: audit: type=3D1106 audit(1738792598.200:145)=
: pid=3D978 uid=3D0 auid=3D1000 ses=3D3 msg=3D'op=3DPAM:session_close grant=
ors=3Dpam_loginuid,pam_keyinit,pam_systemd_home,pam_limits,pam_unix,pam_per=
mit,pam_mail,pam_umask,pam_systemd,pam_env,pam_gnome_keyring acct=3D"arch" =
exe=3D"/usr/lib/gdm-session-worker" hostname=3Darchvm addr=3D? terminal=3D/=
dev/tty2 res=3Dsuccess'
Feb 06 08:56:38 archvm kernel: audit: type=3D1104 audit(1738792598.200:146)=
: pid=3D978 uid=3D0 auid=3D1000 ses=3D3 msg=3D'op=3DPAM:setcred grantors=3D=
pam_shells,pam_faillock,pam_permit,pam_faillock,pam_gnome_keyring acct=3D"a=
rch" exe=3D"/usr/lib/gdm-session-worker" hostname=3Darchvm addr=3D? termina=
l=3D/dev/tty2 res=3Dsuccess'
Feb 06 08:56:38 archvm audit[978]: CRED_DISP pid=3D978 uid=3D0 auid=3D1000 =
ses=3D3 msg=3D'op=3DPAM:setcred grantors=3Dpam_shells,pam_faillock,pam_perm=
it,pam_faillock,pam_gnome_keyring acct=3D"arch" exe=3D"/usr/lib/gdm-session=
-worker" hostname=3Darchvm addr=3D? terminal=3D/dev/tty2 res=3Dsuccess'
Feb 06 08:56:38 archvm audit[2140]: USER_AUTH pid=3D2140 uid=3D0 auid=3D429=
4967295 ses=3D4294967295 msg=3D'op=3DPAM:authentication grantors=3Dpam_succ=
eed_if,pam_permit acct=3D"gdm" exe=3D"/usr/lib/gdm-session-worker" hostname=
=3Darchvm addr=3D? terminal=3D/dev/tty1 res=3Dsuccess'
Feb 06 08:56:38 archvm kernel: audit: type=3D1100 audit(1738792598.217:147)=
: pid=3D2140 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:aut=
hentication grantors=3Dpam_succeed_if,pam_permit acct=3D"gdm" exe=3D"/usr/l=
ib/gdm-session-worker" hostname=3Darchvm addr=3D? terminal=3D/dev/tty1 res=
=3Dsuccess'
Feb 06 08:56:38 archvm audit[2140]: USER_ACCT pid=3D2140 uid=3D0 auid=3D429=
4967295 ses=3D4294967295 msg=3D'op=3DPAM:accounting grantors=3Dpam_succeed_=
if,pam_permit acct=3D"gdm" exe=3D"/usr/lib/gdm-session-worker" hostname=3Da=
rchvm addr=3D? terminal=3D/dev/tty1 res=3Dsuccess'
Feb 06 08:56:38 archvm kernel: audit: type=3D1101 audit(1738792598.218:148)=
: pid=3D2140 uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D'op=3DPAM:acc=
ounting grantors=3Dpam_succeed_if,pam_permit acct=3D"gdm" exe=3D"/usr/lib/g=
dm-session-worker" hostname=3Darchvm addr=3D? terminal=3D/dev/tty1 res=3Dsu=
ccess'
Feb 06 08:56:38 archvm gdm[498]: Gdm: Freeing conversation 'gdm-password' w=
ith active job
Feb 06 08:56:38 archvm kernel: rfkill: input handler enabled
Feb 06 08:56:38 archvm gsd-media-keys[1187]: Unable to get default source
Feb 06 08:56:38 archvm gsd-media-keys[1187]: Unable to get default sink
Feb 06 08:56:42 archvm kernel: watchdog: BUG: soft lockup - CPU#0 stuck for=
 108s! [kworker/0:3:370]
Feb 06 08:56:42 archvm kernel: CPU#0 Utilization every 4s during lockup:
Feb 06 08:56:42 archvm kernel:         #1: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:56:42 archvm kernel:         #2: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:56:42 archvm kernel:         #3: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:56:42 archvm kernel:         #4: 100% system,          0% softirq=
,          1% hardirq,          0% idle
Feb 06 08:56:42 archvm kernel:         #5: 100% system,          0% softirq=
,          1% hardirq,          0% idle

--xqg47v3xy6vv4paz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmeklMEACgkQwEfU8yi1
JYUBhhAAnmshnMmmWF+va7LjiZ0vuFR+jKpJkJU+tojZlo4soLzKhSHmm23FE4qq
BM5Ow+z8uOGvKlrEXXl/ngzI9davR3OmlTVDgTdVuEMk1Ojzdref5fOpymUmt7C3
bGew5+FsQbszzgZFa8TSuDI2Oh+TLdESw9q3SH/spaV/TK0UsRLx9x1VRO17SHuH
VCxkxOxHWEYCxBP14AsubJubUlxu0sN3+XQCOT5DEqNxxCm5R84Mt7szeNtoOTU4
6j78/lgSv3L0ysuFprex8N4OJddDdtV5c/LGBc363FU0D9RG5OUw52ml775eMNIM
1+1LWaljgpSLKs4rYgXGy+2aOIk3IFkdsA1+UGRhM1hfEriZ1xcLDgLTQ+HlpolO
T2e9pq3U/WRODdf0Hm3MVistW8CaMNDr40g2ZP788WwUEIivLV9MhTcQmRnT5b9D
fJDn8lTcXAah7n7Rk12rD4iVTUGD/2dH5EK4F9hmFk4fzJmb9EJxeW+1ay3c/snp
+dKpX5jP8hRQ81ypGX2LZYXgzjOP7Ov5b/9WvzJeiOpcge93IcW/XNmG5jsXL326
1qNQ/7+bhPLMnqSWZUXvy1RvheeU2KW/ZEJT5LpZ4pjbwM09Ll0F8DbkVJvAKQvc
N1wMEyJiHNNo2cs/hh7TtnpkYub4h6lN5+HVdn7VIujDZSZYWeM=
=v4tq
-----END PGP SIGNATURE-----

--xqg47v3xy6vv4paz--

