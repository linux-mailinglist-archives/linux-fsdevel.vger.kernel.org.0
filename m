Return-Path: <linux-fsdevel+bounces-46659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F01CA93034
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 04:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67618467A04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 02:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9D0268FFB;
	Fri, 18 Apr 2025 02:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOs/Wg6M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839E2268FD7;
	Fri, 18 Apr 2025 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944973; cv=none; b=dvRIQhY22tdi/Vxe9IXDcArrcGgFUIwqCggafekDf2M2QAklNzpOI0l8IKXkawTtDlTIZliMpqCdGW8ss/r0J6fFOOb7x0GpSYX/GFnCCohdtZnvaZ7v9weajzJzbOnzJ0x2lUXTVKxxd+yYCPxuNBH/JVtIDNGPsTZgDPf278A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944973; c=relaxed/simple;
	bh=6sJpBWl/1W4/+vXFYEgRNLtk9AosG9H1BFtmEvakKgI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U6RyUqZFQwJ8s4tFGrCv6cfTx9M5uhJsiagV5cg5FatkIbmDNhYORGlCqEoQnKTznK+215bZG4tJSN7cITmQOOlTYo2Dycgq4b09rnYZcUNJa89g8tXTT1s9iJP/p1R38WsjyPnUJs33lzLMEqp4hcsQq3SsjdGBujfkM1mUTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOs/Wg6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DC4C4CEE4;
	Fri, 18 Apr 2025 02:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744944973;
	bh=6sJpBWl/1W4/+vXFYEgRNLtk9AosG9H1BFtmEvakKgI=;
	h=Date:From:To:Cc:Subject:From;
	b=UOs/Wg6MLrwJKITE83/HMsbvx9hmaodga4lHFmqCmFNAS3q3VVvOWUkt5vwvH03Wj
	 1WtPAOC8ap3dAB8j0JJkccNv1bCK6Qo9U7NFoN78lZGNkzXykYp7hB7SH29jivTyRm
	 I8L941quWPLtXBtGTpYHyQP5xQiik4Y/E++oUkOBr/NpbHZZeWakIRtIVRAmolDZMP
	 prD6S5y9TNOFWO6ZH6txr3Nqb+vIj5B2NtmrrcDIMKc4luOHGgaVwt/bessRA9d84G
	 5IuRetGvXjse4gCytArc8HcUa5qCwdP2qt5IzXxEBK2F5oaW61vRzRXeCaWzpJrcTe
	 9bIok45WhCcIw==
Date: Thu, 17 Apr 2025 19:56:11 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	kdevops@lists.linux.dev
Subject: xarray regression: XArray: Add extra debugging check to xas_lock and
 friends
Message-ID: <aAG_Sz_a2j3ummY2@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

kdevops has found that the the linux-next tag next-20250417 was hosed
by running the memory management tests it has, it detected test_xarray
killed it.

Upon inspection we found that reverting the following patch title fixed
this issue, which matches a prior odd report [0]:

XArray: Add extra debugging check to xas_lock and friends

[0] https://lore.kernel.org/all/Z98oChgU7Z9wyTw1@casper.infradead.org/

I confirm reverting the patch "XArray: Add extra debugging check to
xas_lock and friends" fixes the issue for test_xarray test. Likewise
as silly as it may seem the suggested patch above also fixes the issue.

I can't spot the issue... although the logic reads inverted for

	XA_NODE_BUG_ON(xas->xa_node, xas_valid(xas));

But that's not it... confused too...

The kernel crash below, decoded for brownie points:

Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Linux version 6.15.0-rc2-next-20250417 (gh@diay-mae) (gcc (Debian 14.2.0-16) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #5 SMP PREEMPT_DYNAMIC Fri Apr 18 02:27:09 UTC 2025
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Command line: BOOT_IMAGE=/boot/vmlinuz-6.15.0-rc2-next-20250417 root=PARTUUID=46d2416b-7a7a-4bca-a1ec-52a628b140d1 ro console=tty0 console=tty1 console=ttyS0,115200n8 console=ttyS0
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-provided physical RAM map:
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x0000000000100000-0x00000000007fffff] usable
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x0000000000800000-0x0000000000807fff] ACPI NVS
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x0000000000808000-0x000000000080afff] usable
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x000000000080b000-0x000000000080bfff] ACPI NVS
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x000000000080c000-0x0000000000810fff] usable
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x0000000000811000-0x00000000008fffff] ACPI NVS
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x0000000000900000-0x000000007eb3efff] usable
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x000000007eb3f000-0x000000007ebfffff] reserved
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x000000007ec00000-0x000000007f6ecfff] usable
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x000000007f6ed000-0x000000007f96cfff] reserved
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x000000007f96d000-0x000000007f97efff] ACPI data
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x000000007f97f000-0x000000007f9fefff] ACPI NVS
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x000000007f9ff000-0x000000007fe51fff] usable
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x000000007fe52000-0x000000007fe55fff] reserved
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x000000007fe56000-0x000000007fe57fff] ACPI NVS
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x000000007fe58000-0x000000007febbfff] usable
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x000000007febc000-0x000000007ff3ffff] reserved
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x000000007ff40000-0x000000007fffffff] ACPI NVS
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] reserved
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: BIOS-e820: [mem 0x0000000100000000-0x000000017fffffff] usable
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: NX (Execute Disable) protection: active
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: APIC: Static calls initialized
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: efi: EFI v2.7 by Debian distribution of EDK II
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: efi: SMBIOS=0x7f788000 ACPI=0x7f97e000 ACPI 2.0=0x7f97e014 MEMATTR=0x7e15a018 INITRD=0x7e15ba98 RNG=0x7f974018
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: random: crng init done
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: efi: Remove mem151: MMIO range=[0xffc00000-0xffffffff] (4MB) from e820 map
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: e820: remove [mem 0xffc00000-0xffffffff] reserved
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: SMBIOS 2.8 present.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: DMI: Memory slots populated: 1/1
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Hypervisor detected: KVM
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: kvm-clock: Using msrs 4b564d01 and 4b564d00
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: kvm-clock: using sched offset of 43536983132514 cycles
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: tsc: Detected 2194.842 MHz processor
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: last_pfn = 0x180000 max_arch_pfn = 0x400000000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: MTRR map: 4 entries (2 fixed + 2 variable; max 18), built from 8 variable MTRRs
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: last_pfn = 0x7febc max_arch_pfn = 0x400000000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Using GB pages for direct mapping
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Secure boot disabled
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: RAMDISK: [mem 0x73bf4000-0x79e7dfff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: Early table checksum verification disabled
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: RSDP 0x000000007F97E014 000024 (v02 BOCHS )
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: XSDT 0x000000007F97D0E8 000044 (v01 BOCHS  BXPC     00000001      01000013)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: FACP 0x000000007F978000 0000F4 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: DSDT 0x000000007F979000 0034F3 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: FACS 0x000000007F9DD000 000040
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: APIC 0x000000007F977000 0000B0 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: MCFG 0x000000007F976000 00003C (v01 BOCHS  BXPC     00000001 BXPC 00000001)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: WAET 0x000000007F975000 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: Reserving FACP table memory at [mem 0x7f978000-0x7f9780f3]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: Reserving DSDT table memory at [mem 0x7f979000-0x7f97c4f2]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: Reserving FACS table memory at [mem 0x7f9dd000-0x7f9dd03f]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: Reserving APIC table memory at [mem 0x7f977000-0x7f9770af]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: Reserving MCFG table memory at [mem 0x7f976000-0x7f97603b]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: Reserving WAET table memory at [mem 0x7f975000-0x7f975027]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: No NUMA configuration found
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Faking a node at [mem 0x0000000000000000-0x000000017fffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: NODE_DATA(0) allocated [mem 0x17fffaa80-0x17fffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Zone ranges:
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:   Normal   [mem 0x0000000100000000-0x000000017fffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:   Device   empty
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Movable zone start for each node
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Early memory node ranges
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:   node   0: [mem 0x0000000000001000-0x000000000009ffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:   node   0: [mem 0x0000000000100000-0x00000000007fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:   node   0: [mem 0x0000000000808000-0x000000000080afff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:   node   0: [mem 0x000000000080c000-0x0000000000810fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:   node   0: [mem 0x0000000000900000-0x000000007eb3efff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:   node   0: [mem 0x000000007ec00000-0x000000007f6ecfff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:   node   0: [mem 0x000000007f9ff000-0x000000007fe51fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:   node   0: [mem 0x000000007fe58000-0x000000007febbfff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:   node   0: [mem 0x0000000100000000-0x000000017fffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Initmem setup node 0 [mem 0x0000000000001000-0x000000017fffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: On node 0, zone DMA: 1 pages in unavailable ranges
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: On node 0, zone DMA: 96 pages in unavailable ranges
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: On node 0, zone DMA: 8 pages in unavailable ranges
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: On node 0, zone DMA: 1 pages in unavailable ranges
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: On node 0, zone DMA: 239 pages in unavailable ranges
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: On node 0, zone DMA32: 193 pages in unavailable ranges
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: On node 0, zone DMA32: 786 pages in unavailable ranges
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: On node 0, zone DMA32: 6 pages in unavailable ranges
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: On node 0, zone Normal: 324 pages in unavailable ranges
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PM-Timer IO Port: 0x608
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: Using ACPI (MADT) for SMP configuration information
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: TSC deadline timer available
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: CPU topo: Max. logical packages:   8
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: CPU topo: Max. logical dies:       8
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: CPU topo: Max. dies per package:   1
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: CPU topo: Max. threads per core:   1
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: CPU topo: Num. cores per package:     1
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: CPU topo: Num. threads per package:   1
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: CPU topo: Allowing 8 present CPUs plus 0 hotplug CPUs
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: kvm-guest: APIC: eoi() replaced with kvm_guest_apic_eoi_write()
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: kvm-guest: KVM setup pv remote TLB flush
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: kvm-guest: setup PV sched yield
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PM: hibernation: Registered nosave memory: [mem 0x00800000-0x00807fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PM: hibernation: Registered nosave memory: [mem 0x0080b000-0x0080bfff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PM: hibernation: Registered nosave memory: [mem 0x00811000-0x008fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PM: hibernation: Registered nosave memory: [mem 0x7eb3f000-0x7ebfffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PM: hibernation: Registered nosave memory: [mem 0x7f6ed000-0x7f9fefff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PM: hibernation: Registered nosave memory: [mem 0x7fe52000-0x7fe57fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PM: hibernation: Registered nosave memory: [mem 0x7febc000-0xffffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: [mem 0x80000000-0xdfffffff] available for PCI devices
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Booting paravirtualized kernel on KVM
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: setup_percpu: NR_CPUS:512 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: percpu: Embedded 56 pages/cpu s191064 r8192 d30120 u262144
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcpu-alloc: s191064 r8192 d30120 u262144 alloc=1*2097152
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcpu-alloc: [0] 0 1 2 3 4 5 6 7
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: kvm-guest: PV spinlocks enabled
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.15.0-rc2-next-20250417 root=PARTUUID=46d2416b-7a7a-4bca-a1ec-52a628b140d1 ro console=tty0 console=tty1 console=ttyS0,115200n8 console=ttyS0
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Unknown kernel command line parameters "BOOT_IMAGE=/boot/vmlinuz-6.15.0-rc2-next-20250417", will be passed to user space.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: printk: log buffer data + meta data: 131072 + 458752 = 589824 bytes
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: software IO TLB: area num 8.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Fallback order for Node 0: 0
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Built 1 zonelists, mobility grouping on.  Total pages: 1046922
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Policy zone: Normal
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: mem auto-init: stack:off, heap alloc:off, heap free:off
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: stackdepot: allocating hash table via alloc_large_system_hash
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: stackdepot hash table entries: 262144 (order: 10, 4194304 bytes, linear)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ftrace: allocating 41574 entries in 164 pages
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ftrace: allocated 164 pages with 3 groups
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Dynamic Preempt: full
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: rcu: Preemptible hierarchical RCU implementation.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: rcu:         RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=8.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:         Trampoline variant of Tasks RCU enabled.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:         Rude variant of Tasks RCU enabled.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:         Tracing variant of Tasks RCU enabled.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=8.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: NR_IRQS: 33024, nr_irqs: 488, preallocated irqs: 16
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: rcu: srcu_init: Setting srcu_struct sizes based on contention.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Console: colour dummy device 80x25
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: printk: legacy console [tty0] enabled
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: printk: legacy console [ttyS0] enabled
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: Core revision 20241212
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: APIC: Switch to symmetric I/O mode setup
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x2apic enabled
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: APIC: Switched APIC routing to: physical x2apic
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: kvm-guest: APIC: send_IPI_mask() replaced with kvm_send_ipi_mask()
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: kvm-guest: APIC: send_IPI_mask_allbutself() replaced with kvm_send_ipi_mask_allbutself()
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: kvm-guest: setup PV IPIs
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1fa32a29722, max_idle_ns: 440795224307 ns
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Calibrating delay loop (skipped) preset value.. 4389.68 BogoMIPS (lpj=8779368)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86/cpu: User Mode Instruction Prevention (UMIP) activated
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Spectre V2 : WARNING: Unprivileged eBPF is enabled with eIBRS on, data leaks possible via Spectre v2 BHB attacks!
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Spectre V2 : Spectre BHI mitigation: SW BHB clearing on syscall and VM exit
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Spectre V2 : Mitigation: Enhanced / Automatic IBRS
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: TAA: Mitigation: TSX disabled
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: MMIO Stale Data: Vulnerable: Clear CPU buffers attempted, no microcode
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: GDS: Unknown: Dependent on hypervisor status
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86/fpu: Enabled xstate features 0x2e7, context size is 2440 bytes, using 'compacted' format.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Freeing SMP alternatives memory: 40K
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pid_max: default: 32768 minimum: 301
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ------------[ cut here ]------------
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: WARNING: CPU: 0 PID: 0 at arch/x86/mm/tlb.c:918 switch_mm_irqs_off (arch/x86/mm/tlb.c:918 (discriminator 9)) 
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Modules linked in:
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.0-rc2-next-20250417 #5 PREEMPT(full)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: RIP: 0010:switch_mm_irqs_off (arch/x86/mm/tlb.c:918 (discriminator 9)) 
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Code: 65 4c 89 25 b6 36 a9 01 65 48 c7 05 a2 36 a9 01 01 00 00 00 48 81 fd c0 d9 50 a5 74 0f 44 89 f8 48 0f a3 85 80 05 00 00 72 02 <0f> 0b 48 81 fb c0 d9 50 a5 74 16 48 8d 83 80 05 00 00 4c 0f a3 bb
All code
========
   0:	65 4c 89 25 b6 36 a9 	mov    %r12,%gs:0x1a936b6(%rip)        # 0x1a936be
   7:	01 
   8:	65 48 c7 05 a2 36 a9 	movq   $0x1,%gs:0x1a936a2(%rip)        # 0x1a936b6
   f:	01 01 00 00 00 
  14:	48 81 fd c0 d9 50 a5 	cmp    $0xffffffffa550d9c0,%rbp
  1b:	74 0f                	je     0x2c
  1d:	44 89 f8             	mov    %r15d,%eax
  20:	48 0f a3 85 80 05 00 	bt     %rax,0x580(%rbp)
  27:	00 
  28:	72 02                	jb     0x2c
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 81 fb c0 d9 50 a5 	cmp    $0xffffffffa550d9c0,%rbx
  33:	74 16                	je     0x4b
  35:	48 8d 83 80 05 00 00 	lea    0x580(%rbx),%rax
  3c:	4c                   	rex.WR
  3d:	0f                   	.byte 0xf
  3e:	a3                   	.byte 0xa3
  3f:	bb                   	.byte 0xbb

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 81 fb c0 d9 50 a5 	cmp    $0xffffffffa550d9c0,%rbx
   9:	74 16                	je     0x21
   b:	48 8d 83 80 05 00 00 	lea    0x580(%rbx),%rax
  12:	4c                   	rex.WR
  13:	0f                   	.byte 0xf
  14:	a3                   	.byte 0xa3
  15:	bb                   	.byte 0xbb
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: RSP: 0000:ffffffffa5403de8 EFLAGS: 00010202
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: RAX: 0000000000000000 RBX: ffffffffa550d9c0 RCX: 0000000000000002
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffa52f43d5
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: RBP: ffffffffa557e800 R08: ffffffffa5403da4 R09: 000000007f7ec018
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: R10: 000000007f8e1860 R11: 00000000ce1c672e R12: 0000000000000001
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: R13: ffffffffa540c500 R14: 0000000000000000 R15: 0000000000000000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: FS:  0000000000000000(0000) GS:ffff8c9c15ec6000(0000) knlGS:0000000000000000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: CR2: ffff8c9b9a601000 CR3: 0000000100352002 CR4: 0000000000770ef0
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PKRU: 55555554
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Call Trace:
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:  <TASK>
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: unuse_temporary_mm (./arch/x86/include/asm/debugreg.h:115 arch/x86/mm/tlb.c:1044) 
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: efi_set_virtual_address_map (arch/x86/platform/efi/efi_64.c:839) 
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: efi_enter_virtual_mode (arch/x86/platform/efi/efi.c:828 arch/x86/platform/efi/efi.c:872) 
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: start_kernel (init/main.c:1073) 
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86_64_start_reservations (arch/x86/kernel/head64.c:304) 
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86_64_start_kernel (??:?) 
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: common_startup_64 (arch/x86/kernel/head_64.S:419) 
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:  </TASK>
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ---[ end trace 0000000000000000 ]---
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: LSM: initializing lsm=capability,yama,apparmor,tomoyo
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Yama: becoming mindful.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: AppArmor: AppArmor initialized
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: TOMOYO Linux initialized
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: smpboot: CPU0: Intel(R) Xeon(R) Gold 6338N CPU @ 2.20GHz (family: 0x6, model: 0x6a, stepping: 0x6)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Performance Events: PEBS fmt4+, Icelake events, 32-deep LBR, full-width counters, Intel PMU driver.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ... version:                2
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ... bit width:              48
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ... generic registers:      8
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ... value mask:             0000ffffffffffff
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ... max period:             00007fffffffffff
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ... fixed-purpose events:   3
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ... event mask:             00000007000000ff
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: signal: max sigframe size: 3632
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: rcu: Hierarchical SRCU implementation.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: rcu:         Max phase no-delay instances is 1000.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: smp: Bringing up secondary CPUs ...
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: smpboot: x86: Booting SMP configuration:
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: smp: Brought up 1 node, 8 CPUs
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: smpboot: Total of 8 processors activated (35117.47 BogoMIPS)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Memory: 3897520K/4187688K available (14320K kernel code, 1982K rwdata, 6068K rodata, 3176K init, 4656K bss, 280736K reserved, 0K cma-reserved)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: devtmpfs: initialized
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86/mm: Memory block size: 128MB
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PM: Registering ACPI NVS region [mem 0x00800000-0x00807fff] (32768 bytes)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PM: Registering ACPI NVS region [mem 0x0080b000-0x0080bfff] (4096 bytes)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PM: Registering ACPI NVS region [mem 0x00811000-0x008fffff] (978944 bytes)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PM: Registering ACPI NVS region [mem 0x7f97f000-0x7f9fefff] (524288 bytes)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PM: Registering ACPI NVS region [mem 0x7fe56000-0x7fe57fff] (8192 bytes)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PM: Registering ACPI NVS region [mem 0x7ff40000-0x7fffffff] (786432 bytes)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: posixtimers hash table entries: 4096 (order: 4, 65536 bytes, linear)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pinctrl core: initialized pinctrl subsystem
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: NET: Registered PF_NETLINK/PF_ROUTE protocol family
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: audit: initializing netlink subsys (disabled)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: audit: type=2000 audit(1744943416.760:1): state=initialized audit_enabled=0 res=1
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: thermal_sys: Registered thermal governor 'fair_share'
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: thermal_sys: Registered thermal governor 'bang_bang'
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: thermal_sys: Registered thermal governor 'step_wise'
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: thermal_sys: Registered thermal governor 'user_space'
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: cpuidle: using governor ladder
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: cpuidle: using governor menu
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PCI: Using configuration type 1 for base access
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: HugeTLB: allocation took 0ms with hugepage_allocation_threads=2
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: Added _OSI(Module Device)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: Added _OSI(Processor Device)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: Added _OSI(Processor Aggregator Device)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: 1 ACPI AML tables successfully acquired and loaded
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: Interpreter enabled
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PM: (supports S0 S3 S4 S5)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: Using IOAPIC for interrupt routing
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PCI: Ignoring E820 reservations for host bridge windows
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: Enabled 2 GPEs in block 00 to 3F
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpi PNP0A08:00: _OSC: platform does not support [PCIeHotplug LTR]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpi PNP0A08:00: _OSC: OS now controls [SHPCHotplug PME AER PCIeCapability]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PCI host bridge to bus 0000:00
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:00: root bus resource [mem 0x80000000-0x81dfffff window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:00: root bus resource [mem 0x82604000-0xdfffffff window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfebfffff window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:00: root bus resource [mem 0x380000000000-0x3877ffffffff window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:00: root bus resource [bus 00-1f]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:00.0: [8086:29c0] type 00 class 0x060000 conventional PCI endpoint
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.0: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.0: BAR 0 [mem 0x81c8f000-0x81c8ffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.0:   bridge window [mem 0x81a00000-0x81bfffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.0:   bridge window [mem 0x380000000000-0x3807ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.0: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.1: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.1: BAR 0 [mem 0x81c8e000-0x81c8efff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.1: PCI bridge to [bus 02]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.1:   bridge window [mem 0x81800000-0x819fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.1:   bridge window [mem 0x380800000000-0x380fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.1: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.2: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.2: BAR 0 [mem 0x81c8d000-0x81c8dfff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.2: PCI bridge to [bus 03]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.2:   bridge window [mem 0x81600000-0x817fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.2:   bridge window [mem 0x381000000000-0x3817ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.2: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.3: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.3: BAR 0 [mem 0x81c8c000-0x81c8cfff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.3: PCI bridge to [bus 04]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.3:   bridge window [mem 0x81400000-0x815fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.3:   bridge window [mem 0x381800000000-0x381fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.3: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.4: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.4: BAR 0 [mem 0x81c8b000-0x81c8bfff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.4: PCI bridge to [bus 05]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.4:   bridge window [mem 0x81200000-0x813fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.4:   bridge window [mem 0x382000000000-0x3827ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.4: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.5: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.5: BAR 0 [mem 0x81c8a000-0x81c8afff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.5: PCI bridge to [bus 06]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.5:   bridge window [mem 0x81000000-0x811fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.5:   bridge window [mem 0x382800000000-0x382fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.5: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.6: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.6: BAR 0 [mem 0x81c89000-0x81c89fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.6: PCI bridge to [bus 07]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.6:   bridge window [mem 0x80e00000-0x80ffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.6:   bridge window [mem 0x383000000000-0x3837ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.6: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.7: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.7: BAR 0 [mem 0x81c88000-0x81c88fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.7: PCI bridge to [bus 08]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.7:   bridge window [mem 0x80c00000-0x80dfffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.7:   bridge window [mem 0x383800000000-0x383fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.7: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.0: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.0: BAR 0 [mem 0x81c87000-0x81c87fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.0: PCI bridge to [bus 09]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.0:   bridge window [mem 0x80a00000-0x80bfffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.0:   bridge window [mem 0x384000000000-0x3847ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.0: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.1: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.1: BAR 0 [mem 0x81c86000-0x81c86fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.1: PCI bridge to [bus 0a]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.1:   bridge window [mem 0x80800000-0x809fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.1:   bridge window [mem 0x384800000000-0x384fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.1: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.2: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.2: BAR 0 [mem 0x81c85000-0x81c85fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.2: PCI bridge to [bus 0b]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.2:   bridge window [mem 0x80600000-0x807fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.2:   bridge window [mem 0x385000000000-0x3857ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.2: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.3: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.3: BAR 0 [mem 0x81c84000-0x81c84fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.3: PCI bridge to [bus 0c]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.3:   bridge window [mem 0x80400000-0x805fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.3:   bridge window [mem 0x385800000000-0x385fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.3: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.4: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.4: BAR 0 [mem 0x81c83000-0x81c83fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.4: PCI bridge to [bus 0d]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.4:   bridge window [mem 0x80200000-0x803fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.4:   bridge window [mem 0x386000000000-0x3867ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.4: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.5: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.5: BAR 0 [mem 0x81c82000-0x81c82fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.5: PCI bridge to [bus 0e]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.5:   bridge window [mem 0x80000000-0x801fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.5:   bridge window [mem 0x386800000000-0x386fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.5: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:08.0: [1b36:000b] type 00 class 0x060000 conventional PCI endpoint
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:10.0: [1af4:1009] type 00 class 0x000200 conventional PCI endpoint
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:10.0: BAR 0 [io  0x6040-0x607f]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:10.0: BAR 1 [mem 0x81c81000-0x81c81fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:10.0: BAR 4 [mem 0x387000000000-0x387000003fff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:1f.0: [8086:2918] type 00 class 0x060100 conventional PCI endpoint
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed by ICH6 ACPI/GPIO/TCO
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601 conventional PCI endpoint
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:1f.2: BAR 4 [io  0x6080-0x609f]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:1f.2: BAR 5 [mem 0x81c80000-0x81c80fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500 conventional PCI endpoint
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:1f.3: BAR 4 [io  0x6000-0x603f]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpiphp: Slot [0] registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:01:00.0: [1af4:1041] type 00 class 0x020000 PCIe Endpoint
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:01:00.0: BAR 1 [mem 0x81a00000-0x81a00fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:01:00.0: BAR 4 [mem 0x380000000000-0x380000003fff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:01:00.0: ROM [mem 0xfff80000-0xffffffff pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:01:00.0: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpiphp: Slot [0-2] registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:02:00.0: [1b36:000d] type 00 class 0x0c0330 PCIe Endpoint
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:02:00.0: BAR 0 [mem 0x81800000-0x81803fff 64bit]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:02:00.0: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.1: PCI bridge to [bus 02]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpiphp: Slot [0-3] registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:03:00.0: [1af4:1043] type 00 class 0x078000 PCIe Endpoint
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:03:00.0: BAR 1 [mem 0x81600000-0x81600fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:03:00.0: BAR 4 [mem 0x381000000000-0x381000003fff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:03:00.0: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.2: PCI bridge to [bus 03]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpiphp: Slot [0-4] registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:04:00.0: [1af4:1042] type 00 class 0x010000 PCIe Endpoint
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:04:00.0: BAR 1 [mem 0x81400000-0x81400fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:04:00.0: BAR 4 [mem 0x381800000000-0x381800003fff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:04:00.0: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.3: PCI bridge to [bus 04]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpiphp: Slot [0-5] registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:05:00.0: [1af4:1045] type 00 class 0x00ff00 PCIe Endpoint
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:05:00.0: BAR 4 [mem 0x382000000000-0x382000003fff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:05:00.0: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.4: PCI bridge to [bus 05]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpiphp: Slot [0-6] registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:06:00.0: [1af4:1044] type 00 class 0x00ff00 PCIe Endpoint
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:06:00.0: BAR 1 [mem 0x81000000-0x81000fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:06:00.0: BAR 4 [mem 0x382800000000-0x382800003fff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:06:00.0: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.5: PCI bridge to [bus 06]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpiphp: Slot [0-7] registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.6: PCI bridge to [bus 07]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpiphp: Slot [0-8] registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.7: PCI bridge to [bus 08]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpiphp: Slot [0-9] registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.0: PCI bridge to [bus 09]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpiphp: Slot [0-10] registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.1: PCI bridge to [bus 0a]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpiphp: Slot [0-11] registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.2: PCI bridge to [bus 0b]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpiphp: Slot [0-12] registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.3: PCI bridge to [bus 0c]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpiphp: Slot [0-13] registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.4: PCI bridge to [bus 0d]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpiphp: Slot [0-14] registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.5: PCI bridge to [bus 0e]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI: Interrupt link LNKA configured for IRQ 10
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI: Interrupt link LNKB configured for IRQ 10
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI: Interrupt link LNKC configured for IRQ 11
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI: Interrupt link LNKD configured for IRQ 11
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI: Interrupt link LNKE configured for IRQ 10
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI: Interrupt link LNKF configured for IRQ 10
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI: Interrupt link LNKG configured for IRQ 11
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI: Interrupt link LNKH configured for IRQ 11
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI: Interrupt link GSIA configured for IRQ 16
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI: Interrupt link GSIB configured for IRQ 17
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI: Interrupt link GSIC configured for IRQ 18
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI: Interrupt link GSID configured for IRQ 19
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI: Interrupt link GSIE configured for IRQ 20
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI: Interrupt link GSIF configured for IRQ 21
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI: Interrupt link GSIG configured for IRQ 22
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI: Interrupt link GSIH configured for IRQ 23
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: PCI Root Bridge [PC20] (domain 0000 [bus 20-24])
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpi PNP0A08:01: _OSC: platform does not support [LTR]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PCI host bridge to bus 0000:20
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:20: root bus resource [mem 0x81e00000-0x82603fff window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:20: root bus resource [mem 0x387800000000-0x3897ffffffff window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:20: root bus resource [bus 20-24]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:00.0: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:00.0: BAR 0 [mem 0x82603000-0x82603fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:00.0: PCI bridge to [bus 21]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:00.0:   bridge window [mem 0x82400000-0x825fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:00.0:   bridge window [mem 0x387800000000-0x387fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:00.0: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:01.0: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:01.0: BAR 0 [mem 0x82602000-0x82602fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:01.0: PCI bridge to [bus 22]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:01.0:   bridge window [mem 0x82200000-0x823fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:01.0:   bridge window [mem 0x388000000000-0x3887ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:01.0: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:02.0: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:02.0: BAR 0 [mem 0x82601000-0x82601fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:02.0: PCI bridge to [bus 23]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:02.0:   bridge window [mem 0x82000000-0x821fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:02.0:   bridge window [mem 0x388800000000-0x388fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:02.0: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:03.0: [1b36:000c] type 01 class 0x060400 PCIe Root Port
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:03.0: BAR 0 [mem 0x82600000-0x82600fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:03.0: PCI bridge to [bus 24]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:03.0:   bridge window [mem 0x81e00000-0x81ffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:03.0:   bridge window [mem 0x389000000000-0x3897ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:03.0: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:21:00.0: [1af4:1042] type 00 class 0x010000 PCIe Endpoint
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:21:00.0: BAR 1 [mem 0x82400000-0x82400fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:21:00.0: BAR 4 [mem 0x387800000000-0x387800003fff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:21:00.0: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:00.0: PCI bridge to [bus 21]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:22:00.0: [1af4:1042] type 00 class 0x010000 PCIe Endpoint
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:22:00.0: BAR 1 [mem 0x82200000-0x82200fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:22:00.0: BAR 4 [mem 0x388000000000-0x388000003fff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:22:00.0: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:01.0: PCI bridge to [bus 22]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:23:00.0: [1af4:1042] type 00 class 0x010000 PCIe Endpoint
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:23:00.0: BAR 1 [mem 0x82000000-0x82000fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:23:00.0: BAR 4 [mem 0x388800000000-0x388800003fff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:23:00.0: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:02.0: PCI bridge to [bus 23]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:24:00.0: [1af4:1042] type 00 class 0x010000 PCIe Endpoint
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:24:00.0: BAR 1 [mem 0x81e00000-0x81e00fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:24:00.0: BAR 4 [mem 0x389000000000-0x389000003fff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:24:00.0: enabling Extended Tags
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:03.0: PCI bridge to [bus 24]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: iommu: Default domain type: Translated
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: iommu: DMA domain TLB invalidation policy: lazy mode
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pps_core: LinuxPPS API ver. 1 registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PTP clock support registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: EDAC MC: Ver: 3.0.0
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: efivars: Registered efivars operations
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PCI: Using ACPI for IRQ routing
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PCI: pci_cache_line_size set to 64 bytes
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: e820: reserve RAM buffer [mem 0x0080b000-0x008fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: e820: reserve RAM buffer [mem 0x00811000-0x008fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: e820: reserve RAM buffer [mem 0x7eb3f000-0x7fffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: e820: reserve RAM buffer [mem 0x7f6ed000-0x7fffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: e820: reserve RAM buffer [mem 0x7fe52000-0x7fffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: e820: reserve RAM buffer [mem 0x7febc000-0x7fffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: vgaarb: loaded
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: clocksource: Switched to clocksource kvm-clock
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: VFS: Disk quotas dquot_6.6.0
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: AppArmor: AppArmor Filesystem Enabled
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pnp: PnP ACPI init
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: system 00:04: [mem 0xe0000000-0xefffffff window] has been reserved
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pnp: PnP ACPI: found 5 devices
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: NET: Registered PF_INET protocol family
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: TCP: Hash tables configured (established 32768 bind 32768)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: UDP hash table entries: 2048 (order: 5, 131072 bytes, linear)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: UDP-Lite hash table entries: 2048 (order: 5, 131072 bytes, linear)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: NET: Registered PF_UNIX/PF_LOCAL protocol family
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:01:00.0: ROM [mem 0xfff80000-0xffffffff pref]: can't claim; no compatible bridge window
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.1: bridge window [io  0x1000-0x0fff] to [bus 02] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.2: bridge window [io  0x1000-0x0fff] to [bus 03] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.3: bridge window [io  0x1000-0x0fff] to [bus 04] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.4: bridge window [io  0x1000-0x0fff] to [bus 05] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.5: bridge window [io  0x1000-0x0fff] to [bus 06] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.6: bridge window [io  0x1000-0x0fff] to [bus 07] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.7: bridge window [io  0x1000-0x0fff] to [bus 08] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.0: bridge window [io  0x1000-0x0fff] to [bus 09] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.1: bridge window [io  0x1000-0x0fff] to [bus 0a] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.2: bridge window [io  0x1000-0x0fff] to [bus 0b] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.3: bridge window [io  0x1000-0x0fff] to [bus 0c] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.4: bridge window [io  0x1000-0x0fff] to [bus 0d] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.5: bridge window [io  0x1000-0x0fff] to [bus 0e] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.0: bridge window [io  0x1000-0x1fff]: assigned
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.1: bridge window [io  0x2000-0x2fff]: assigned
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.2: bridge window [io  0x3000-0x3fff]: assigned
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.3: bridge window [io  0x4000-0x4fff]: assigned
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.4: bridge window [io  0x5000-0x5fff]: assigned
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.5: bridge window [io  0x7000-0x7fff]: assigned
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.6: bridge window [io  0x8000-0x8fff]: assigned
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.7: bridge window [io  0x9000-0x9fff]: assigned
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.0: bridge window [io  0xa000-0xafff]: assigned
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.1: bridge window [io  0xb000-0xbfff]: assigned
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.2: bridge window [io  0xc000-0xcfff]: assigned
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.3: bridge window [io  0xd000-0xdfff]: assigned
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.4: bridge window [io  0xe000-0xefff]: assigned
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.5: bridge window [io  0xf000-0xffff]: assigned
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:01:00.0: ROM [mem 0x81a80000-0x81afffff pref]: assigned
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.0: PCI bridge to [bus 01]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.0:   bridge window [io  0x1000-0x1fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.0:   bridge window [mem 0x81a00000-0x81bfffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.0:   bridge window [mem 0x380000000000-0x3807ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.1: PCI bridge to [bus 02]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.1:   bridge window [io  0x2000-0x2fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.1:   bridge window [mem 0x81800000-0x819fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.1:   bridge window [mem 0x380800000000-0x380fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.2: PCI bridge to [bus 03]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.2:   bridge window [io  0x3000-0x3fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.2:   bridge window [mem 0x81600000-0x817fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.2:   bridge window [mem 0x381000000000-0x3817ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.3: PCI bridge to [bus 04]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.3:   bridge window [io  0x4000-0x4fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.3:   bridge window [mem 0x81400000-0x815fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.3:   bridge window [mem 0x381800000000-0x381fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.4: PCI bridge to [bus 05]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.4:   bridge window [io  0x5000-0x5fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.4:   bridge window [mem 0x81200000-0x813fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.4:   bridge window [mem 0x382000000000-0x3827ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.5: PCI bridge to [bus 06]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.5:   bridge window [io  0x7000-0x7fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.5:   bridge window [mem 0x81000000-0x811fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.5:   bridge window [mem 0x382800000000-0x382fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.6: PCI bridge to [bus 07]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.6:   bridge window [io  0x8000-0x8fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.6:   bridge window [mem 0x80e00000-0x80ffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.6:   bridge window [mem 0x383000000000-0x3837ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.7: PCI bridge to [bus 08]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.7:   bridge window [io  0x9000-0x9fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.7:   bridge window [mem 0x80c00000-0x80dfffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:01.7:   bridge window [mem 0x383800000000-0x383fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.0: PCI bridge to [bus 09]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.0:   bridge window [io  0xa000-0xafff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.0:   bridge window [mem 0x80a00000-0x80bfffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.0:   bridge window [mem 0x384000000000-0x3847ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.1: PCI bridge to [bus 0a]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.1:   bridge window [io  0xb000-0xbfff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.1:   bridge window [mem 0x80800000-0x809fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.1:   bridge window [mem 0x384800000000-0x384fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.2: PCI bridge to [bus 0b]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.2:   bridge window [io  0xc000-0xcfff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.2:   bridge window [mem 0x80600000-0x807fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.2:   bridge window [mem 0x385000000000-0x3857ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.3: PCI bridge to [bus 0c]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.3:   bridge window [io  0xd000-0xdfff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.3:   bridge window [mem 0x80400000-0x805fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.3:   bridge window [mem 0x385800000000-0x385fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.4: PCI bridge to [bus 0d]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.4:   bridge window [io  0xe000-0xefff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.4:   bridge window [mem 0x80200000-0x803fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.4:   bridge window [mem 0x386000000000-0x3867ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.5: PCI bridge to [bus 0e]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.5:   bridge window [io  0xf000-0xffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.5:   bridge window [mem 0x80000000-0x801fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:00:02.5:   bridge window [mem 0x386800000000-0x386fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:00: resource 7 [mem 0x80000000-0x81dfffff window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:00: resource 8 [mem 0x82604000-0xdfffffff window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfebfffff window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:00: resource 10 [mem 0x380000000000-0x3877ffffffff window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:01: resource 1 [mem 0x81a00000-0x81bfffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:01: resource 2 [mem 0x380000000000-0x3807ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:02: resource 1 [mem 0x81800000-0x819fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:02: resource 2 [mem 0x380800000000-0x380fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:03: resource 1 [mem 0x81600000-0x817fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:03: resource 2 [mem 0x381000000000-0x3817ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:04: resource 0 [io  0x4000-0x4fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:04: resource 1 [mem 0x81400000-0x815fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:04: resource 2 [mem 0x381800000000-0x381fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:05: resource 0 [io  0x5000-0x5fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:05: resource 1 [mem 0x81200000-0x813fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:05: resource 2 [mem 0x382000000000-0x3827ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:06: resource 0 [io  0x7000-0x7fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:06: resource 1 [mem 0x81000000-0x811fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:06: resource 2 [mem 0x382800000000-0x382fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:07: resource 0 [io  0x8000-0x8fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:07: resource 1 [mem 0x80e00000-0x80ffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:07: resource 2 [mem 0x383000000000-0x3837ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:08: resource 0 [io  0x9000-0x9fff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:08: resource 1 [mem 0x80c00000-0x80dfffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:08: resource 2 [mem 0x383800000000-0x383fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:09: resource 0 [io  0xa000-0xafff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:09: resource 1 [mem 0x80a00000-0x80bfffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:09: resource 2 [mem 0x384000000000-0x3847ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:0a: resource 0 [io  0xb000-0xbfff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:0a: resource 1 [mem 0x80800000-0x809fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:0a: resource 2 [mem 0x384800000000-0x384fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:0b: resource 0 [io  0xc000-0xcfff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:0b: resource 1 [mem 0x80600000-0x807fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:0b: resource 2 [mem 0x385000000000-0x3857ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:0c: resource 0 [io  0xd000-0xdfff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:0c: resource 1 [mem 0x80400000-0x805fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:0c: resource 2 [mem 0x385800000000-0x385fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:0d: resource 0 [io  0xe000-0xefff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:0d: resource 1 [mem 0x80200000-0x803fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:0d: resource 2 [mem 0x386000000000-0x3867ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:0e: resource 0 [io  0xf000-0xffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:0e: resource 1 [mem 0x80000000-0x801fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:0e: resource 2 [mem 0x386800000000-0x386fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:00.0: bridge window [io  0x1000-0x0fff] to [bus 21] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:01.0: bridge window [io  0x1000-0x0fff] to [bus 22] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:02.0: bridge window [io  0x1000-0x0fff] to [bus 23] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:03.0: bridge window [io  0x1000-0x0fff] to [bus 24] add_size 1000
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:00.0: bridge window [io  size 0x1000]: can't assign; no space
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:00.0: bridge window [io  size 0x1000]: failed to assign
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:01.0: bridge window [io  size 0x1000]: can't assign; no space
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:01.0: bridge window [io  size 0x1000]: failed to assign
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:02.0: bridge window [io  size 0x1000]: can't assign; no space
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:02.0: bridge window [io  size 0x1000]: failed to assign
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:03.0: bridge window [io  size 0x1000]: can't assign; no space
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:03.0: bridge window [io  size 0x1000]: failed to assign
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:03.0: bridge window [io  size 0x1000]: can't assign; no space
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:03.0: bridge window [io  size 0x1000]: failed to assign
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:02.0: bridge window [io  size 0x1000]: can't assign; no space
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:02.0: bridge window [io  size 0x1000]: failed to assign
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:01.0: bridge window [io  size 0x1000]: can't assign; no space
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:01.0: bridge window [io  size 0x1000]: failed to assign
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:00.0: bridge window [io  size 0x1000]: can't assign; no space
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:00.0: bridge window [io  size 0x1000]: failed to assign
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:00.0: PCI bridge to [bus 21]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:00.0:   bridge window [mem 0x82400000-0x825fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:00.0:   bridge window [mem 0x387800000000-0x387fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:01.0: PCI bridge to [bus 22]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:01.0:   bridge window [mem 0x82200000-0x823fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:01.0:   bridge window [mem 0x388000000000-0x3887ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:02.0: PCI bridge to [bus 23]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:02.0:   bridge window [mem 0x82000000-0x821fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:02.0:   bridge window [mem 0x388800000000-0x388fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:03.0: PCI bridge to [bus 24]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:03.0:   bridge window [mem 0x81e00000-0x81ffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci 0000:20:03.0:   bridge window [mem 0x389000000000-0x3897ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:20: Some PCI device resources are unassigned, try booting with pci=realloc
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:20: resource 4 [mem 0x81e00000-0x82603fff window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:20: resource 5 [mem 0x387800000000-0x3897ffffffff window]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:21: resource 1 [mem 0x82400000-0x825fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:21: resource 2 [mem 0x387800000000-0x387fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:22: resource 1 [mem 0x82200000-0x823fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:22: resource 2 [mem 0x388000000000-0x3887ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:23: resource 1 [mem 0x82000000-0x821fffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:23: resource 2 [mem 0x388800000000-0x388fffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:24: resource 1 [mem 0x81e00000-0x81ffffff]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pci_bus 0000:24: resource 2 [mem 0x389000000000-0x3897ffffffff 64bit pref]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: _SB_.GSIF: Enabled at IRQ 21
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PCI: CLS 0 bytes, default 64
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Trying to unpack rootfs image as initramfs...
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: software IO TLB: mapped [mem 0x000000006fbf4000-0x0000000073bf4000] (64MB)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fa32a29722, max_idle_ns: 440795224307 ns
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: clocksource: Switched to clocksource tsc
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Initialise system trusted keyrings
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: workingset: timestamp_bits=40 max_order=20 bucket_order=0
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Freeing initrd memory: 100904K
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Key type asymmetric registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Asymmetric key parser 'x509' registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: io scheduler mq-deadline registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ledtrig-cpu: registered to indicate activity on CPUs
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:01.0: PME: Signaling with IRQ 24
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:01.0: AER: enabled with IRQ 24
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:01.1: PME: Signaling with IRQ 25
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:01.1: AER: enabled with IRQ 25
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:01.2: PME: Signaling with IRQ 26
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:01.2: AER: enabled with IRQ 26
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:01.3: PME: Signaling with IRQ 27
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:01.3: AER: enabled with IRQ 27
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:01.4: PME: Signaling with IRQ 28
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:01.4: AER: enabled with IRQ 28
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:01.5: PME: Signaling with IRQ 29
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:01.5: AER: enabled with IRQ 29
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:01.6: PME: Signaling with IRQ 30
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:01.6: AER: enabled with IRQ 30
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:01.7: PME: Signaling with IRQ 31
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:01.7: AER: enabled with IRQ 31
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: _SB_.GSIG: Enabled at IRQ 22
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:02.0: PME: Signaling with IRQ 32
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:02.0: AER: enabled with IRQ 32
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:02.1: PME: Signaling with IRQ 33
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:02.1: AER: enabled with IRQ 33
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:02.2: PME: Signaling with IRQ 34
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:02.2: AER: enabled with IRQ 34
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:02.3: PME: Signaling with IRQ 35
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:02.3: AER: enabled with IRQ 35
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:02.4: PME: Signaling with IRQ 36
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:02.4: AER: enabled with IRQ 36
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:02.5: PME: Signaling with IRQ 37
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:00:02.5: AER: enabled with IRQ 37
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: _SB_.LNKD: Enabled at IRQ 11
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:20:00.0: PME: Signaling with IRQ 38
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:20:00.0: AER: enabled with IRQ 38
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:20:00.0: pciehp: Slot #0 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep+
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: _SB_.LNKA: Enabled at IRQ 10
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:20:01.0: PME: Signaling with IRQ 39
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:20:01.0: AER: enabled with IRQ 39
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:20:01.0: pciehp: Slot #0 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep+
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: _SB_.LNKB: Enabled at IRQ 10
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:20:02.0: PME: Signaling with IRQ 40
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:20:02.0: AER: enabled with IRQ 40
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:20:02.0: pciehp: Slot #0 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep+
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: _SB_.LNKC: Enabled at IRQ 11
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:20:03.0: PME: Signaling with IRQ 41
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:20:03.0: AER: enabled with IRQ 41
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pcieport 0000:20:03.0: pciehp: Slot #0 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- IbPresDis- LLActRep+
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: 00:00: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Linux agpgart interface v0.103
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: mousedev: PS/2 mouse device common for all mice
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: rtc_cmos 00:03: RTC can wake from S4
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: rtc_cmos 00:03: registered as rtc0
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: rtc_cmos 00:03: setting system clock to 2025-04-18T02:30:19 UTC (1744943419)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: rtc_cmos 00:03: alarms up to one day, y3k, 242 bytes nvram
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: intel_pstate: CPU model not supported
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pstore: Using crash dump compression: deflate
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: pstore: Registered efi_pstore as persistent store backend
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: NET: Registered PF_INET6 protocol family
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Segment Routing with IPv6
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: In-situ OAM (IOAM) with IPv6
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: mip6: Mobile IPv6
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: NET: Registered PF_PACKET protocol family
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: 9pnet: Installing 9P2000 support
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: mpls_gso: MPLS GSO support
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: IPI shorthand broadcast: enabled
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: sched_clock: Marking stable (2504003832, 145518200)->(2867145478, -217623446)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: registered taskstats version 1
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Loading compiled-in X.509 certificates
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Demotion targets for Node 0: null
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: kmemleak: Kernel memory leak detector initialized (mem pool available: 15691)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Key type .fscrypt registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Key type fscrypt-provisioning registered
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: AppArmor: AppArmor sha256 policy hashing enabled
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: clk: Disabling unused clocks
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Freeing unused kernel image (initmem) memory: 3176K
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Write protecting the kernel read-only data: 20480k
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Freeing unused kernel image (text/rodata gap) memory: 12K
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Freeing unused kernel image (rodata/data gap) memory: 76K
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Run /init as init process
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:   with arguments:
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:     /init
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:   with environment:
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:     HOME=/
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:     TERM=linux
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:     BOOT_IMAGE=/boot/vmlinuz-6.15.0-rc2-next-20250417
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: _SB_.GSIE: Enabled at IRQ 20
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input3
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input2
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: virtio_blk virtio3: 8/0/0 default/read/poll queues
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: virtio_blk virtio3: [vda] 41943040 512-byte logical blocks (21.5 GB/20.0 GiB)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel:  vda: vda1 vda2 vda3
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: virtio_blk virtio6: 8/0/0 default/read/poll queues
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: virtio_blk virtio6: [vdb] 209715200 512-byte logical blocks (107 GB/100 GiB)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: virtio_blk virtio7: 8/0/0 default/read/poll queues
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: virtio_net virtio1 enp1s0: renamed from eth0
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: virtio_blk virtio7: [vdc] 209715200 512-byte logical blocks (107 GB/100 GiB)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: virtio_blk virtio8: 8/0/0 default/read/poll queues
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: virtio_blk virtio8: [vdd] 209715200 512-byte logical blocks (107 GB/100 GiB)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: virtio_blk virtio9: 8/0/0 default/read/poll queues
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: virtio_blk virtio9: [vde] 209715200 512-byte logical blocks (107 GB/100 GiB)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: raid6: avx512x4 gen() 22803 MB/s
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: raid6: avx512x2 gen() 19179 MB/s
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: raid6: avx512x1 gen() 27592 MB/s
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: raid6: avx2x4   gen() 24555 MB/s
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: raid6: avx2x2   gen() 24379 MB/s
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: raid6: avx2x1   gen() 17296 MB/s
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: raid6: using algorithm avx512x1 gen() 27592 MB/s
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: raid6: .... xor() 22356 MB/s, rmw enabled
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: raid6: using avx512x2 recovery algorithm
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: xor: automatically using best checksumming function   avx
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: async_tx: api initialized (async)
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Btrfs loaded, zoned=yes, fsverity=no
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: EXT4-fs (vda3): mounted filesystem f333b539-3dd5-4b51-a3c9-8ec738f555eb ro with ordered data mode. Quota mode: none.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Inserted module 'autofs4'
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: systemd 257.5-2 running in system mode (+PAM +AUDIT +SELINUX +APPARMOR +IMA +IPE +SMACK +SECCOMP +GCRYPT -GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Detected virtualization kvm.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Detected architecture x86-64.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Hostname set to <e00aeb44aaa1-xarray>.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: bpf-restrict-fs: BPF LSM hook not enabled in the kernel, BPF LSM not supported.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: NET: Registered PF_VSOCK protocol family
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Condition check resulted in -.slice - Root Slice being skipped.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Condition check resulted in system.slice - System Slice being skipped.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Queued start job for default target graphical.target.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Created slice system-getty.slice - Slice /system/getty.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Created slice system-serialx2dgetty.slice - Slice /system/serial-getty.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Created slice system-systemdx2dfsck.slice - Slice /system/systemd-fsck.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Created slice system-xfs_scrub.slice - xfs_scrub background service slice.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Created slice user.slice - User and Session Slice.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Started systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point was skipped because of an unmet condition check (ConditionPathExists=/proc/sys/fs/binfmt_misc).
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Expecting device dev-disk-byx2dlabel-data.device - /dev/disk/by-label/data...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Expecting device dev-disk-byx2dpartuuid-9b03c52cx2d249ex2d42dcx2da87dx2dbb51dea63a54.device - /dev/disk/by-partuuid/9b03c52c-249e-42dc-a87d-bb51dea63a54...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Expecting device dev-ttyS0.device - /dev/ttyS0...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Reached target paths.target - Path Units.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Reached target slices.target - Slice Units.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Reached target swap.target - Swaps.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Listening on rpcbind.socket - RPCbind Server Activation Socket.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Listening on systemd-creds.socket - Credential Encryption/Decryption.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Listening on systemd-journald.socket - Journal Sockets.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Listening on systemd-networkd.socket - Network Service Netlink Socket.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: systemd-pcrextend.socket - TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: systemd-pcrlock.socket - Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Mounting run-lock.mount - Legacy Locks Directory /run/lock...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Mounting tmp.mount - Temporary Directory /tmp...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Starting modprobe@efi_pstore.service - Load Kernel Module efi_pstore...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: netplan-ovs-cleanup.service - OpenVSwitch configuration for cleanup was skipped because of an unmet condition check (ConditionFileIsExecutable=/usr/bin/ovs-vsctl).
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: systemd-fsck-root.service - File System Check on Root Device was skipped because of an unmet condition check (ConditionPathExists=!/run/initramfs/fsck-root).
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: systemd-hibernate-clear.service - Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Starting systemd-journald.service - Journal Service...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Starting systemd-network-generator.service - Generate network units from Kernel command line...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: systemd-pcrmachine.service - TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: systemd-tpm2-setup-early.service - Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: bus type drm_connector registered
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Starting systemd-udev-load-credentials.service - Load udev Rules from Credentials...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd-journald[349]: Collecting audit messages is disabled.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Mounted dev-mqueue.mount - POSIX Message Queue File System.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Mounted run-lock.mount - Legacy Locks Directory /run/lock.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Mounted sys-kernel-debug.mount - Kernel Debug File System.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Mounted sys-kernel-tracing.mount - Kernel Trace File System.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Mounted tmp.mount - Temporary Directory /tmp.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: modprobe@configfs.service: Deactivated successfully.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Finished modprobe@configfs.service - Load Kernel Module configfs.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: modprobe@drm.service: Deactivated successfully.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Finished modprobe@drm.service - Load Kernel Module drm.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: modprobe@efi_pstore.service: Deactivated successfully.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Finished modprobe@efi_pstore.service - Load Kernel Module efi_pstore.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: EXT4-fs (vda3): re-mounted f333b539-3dd5-4b51-a3c9-8ec738f555eb r/w.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: modprobe@fuse.service: Deactivated successfully.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Finished modprobe@fuse.service - Load Kernel Module fuse.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Finished systemd-modules-load.service - Load Kernel Modules.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Finished systemd-network-generator.service - Generate network units from Kernel command line.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Finished systemd-remount-fs.service - Remount Root and Kernel File Systems.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Finished systemd-udev-load-credentials.service - Load udev Rules from Credentials.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Reached target network-pre.target - Preparation for Network.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: sys-fs-fuse-connections.mount - FUSE Control File System was skipped because of an unmet condition check (ConditionPathExists=/sys/fs/fuse/connections).
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Mounting sys-kernel-config.mount - Kernel Configuration File System...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Starting systemd-growfs-root.service - Grow Root File System...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: systemd-hwdb-update.service - Rebuild Hardware Database was skipped because of an unmet condition check (ConditionNeedsUpdate=/etc).
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: systemd-pstore.service - Platform Persistent Storage Archival was skipped because of an unmet condition check (ConditionDirectoryNotEmpty=/sys/fs/pstore).
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Starting systemd-random-seed.service - Load/Save OS Random Seed...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Starting systemd-sysctl.service - Apply Kernel Variables...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Starting systemd-tmpfiles-setup-dev-early.service - Create Static Device Nodes in /dev gracefully...
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: systemd-tpm2-setup.service - TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: EXT4-fs (vda3): resizing filesystem from 5210107 to 5210107 blocks
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Mounted sys-kernel-config.mount - Kernel Configuration File System.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Finished systemd-growfs-root.service - Grow Root File System.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd[1]: Started systemd-journald.service - Journal Service.
Apr 18 02:30:22 e00aeb44aaa1-xarray systemd-journald[349]: Received client request to flush runtime journal.
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: ACPI: button: Power Button [PWRF]
Apr 18 02:30:22 e00aeb44aaa1-xarray kernel: cryptd: max_cpu_qlen set to 1000
Apr 18 02:30:23 e00aeb44aaa1-xarray kernel: BTRFS: device label data devid 1 transid 11 /dev/vdb (254:16) scanned by mount (523)
Apr 18 02:30:23 e00aeb44aaa1-xarray kernel: BTRFS info (device vdb): first mount of filesystem 5652802d-5ba5-4571-8a14-a41b6bc637c9
Apr 18 02:30:23 e00aeb44aaa1-xarray kernel: BTRFS info (device vdb): using crc32c (crc32c-x86) checksum algorithm
Apr 18 02:30:23 e00aeb44aaa1-xarray kernel: BTRFS info (device vdb): using free-space-tree
Apr 18 02:30:23 e00aeb44aaa1-xarray kernel: 9p: Installing v9fs 9p2000 file system support
Apr 18 02:30:23 e00aeb44aaa1-xarray kernel: audit: type=1400 audit(1744943423.372:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="QtWebEngineProcess" pid=564 comm="apparmor_parser"
Apr 18 02:30:23 e00aeb44aaa1-xarray kernel: audit: type=1400 audit(1744943423.372:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="buildah" pid=568 comm="apparmor_parser"
Apr 18 02:30:23 e00aeb44aaa1-xarray kernel: audit: type=1400 audit(1744943423.372:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="balena-etcher" pid=566 comm="apparmor_parser"
Apr 18 02:30:23 e00aeb44aaa1-xarray kernel: audit: type=1400 audit(1744943423.372:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="Discord" pid=562 comm="apparmor_parser"
Apr 18 02:30:23 e00aeb44aaa1-xarray kernel: audit: type=1400 audit(1744943423.372:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="1password" pid=561 comm="apparmor_parser"
Apr 18 02:30:23 e00aeb44aaa1-xarray kernel: audit: type=1400 audit(1744943423.372:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name=4D6F6E676F444220436F6D70617373 pid=563 comm="apparmor_parser"
Apr 18 02:30:23 e00aeb44aaa1-xarray kernel: audit: type=1400 audit(1744943423.376:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="busybox" pid=570 comm="apparmor_parser"
Apr 18 02:30:23 e00aeb44aaa1-xarray kernel: audit: type=1400 audit(1744943423.376:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="cam" pid=571 comm="apparmor_parser"
Apr 18 02:30:23 e00aeb44aaa1-xarray kernel: audit: type=1400 audit(1744943423.380:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="chromium" pid=575 comm="apparmor_parser"
Apr 18 02:30:23 e00aeb44aaa1-xarray kernel: audit: type=1400 audit(1744943423.380:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="brave" pid=567 comm="apparmor_parser"
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: BUG at xa_alloc_index:57
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: CPU: 1 UID: 0 PID: 874 Comm: modprobe Tainted: G        W           6.15.0-rc2-next-20250417 #5 PREEMPT(full)
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Tainted: [W]=WARN
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Call Trace:
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel:  <TASK>
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: dump_stack_lvl (lib/dump_stack.c:122) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: xa_alloc_index.constprop.0.cold (lib/test_xarray.c:602) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: check_xa_alloc_1 (lib/test_xarray.c:940) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: ? __pfx_xarray_checks (lib/test_xarray.c:2233) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: check_xa_alloc (lib/test_xarray.c:1106) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: xarray_checks (lib/test_xarray.c:2250) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_one_initcall (init/main.c:1271) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_init_module (kernel/module/main.c:2930) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: init_module_from_file (kernel/module/main.c:3587) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: idempotent_init_module (./include/linux/spinlock.h:351 kernel/module/main.c:3528 kernel/module/main.c:3600) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: __x64_sys_finit_module (./include/linux/file.h:62 (discriminator 1) ./include/linux/file.h:83 (discriminator 1) kernel/module/main.c:3622 (discriminator 1) kernel/module/main.c:3609 (discriminator 1) kernel/module/main.c:3609 (discriminator 1)) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1)) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RIP: 0033:0x7f0a99f18779
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
All code
========
   0:	ff c3                	inc    %ebx
   2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00 
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 4f 86 0d 00 	mov    0xd864f(%rip),%rcx        # 0xd8689
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 4f 86 0d 00 	mov    0xd864f(%rip),%rcx        # 0xd865f
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RSP: 002b:00007fffcb2588c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RAX: ffffffffffffffda RBX: 000055e8f735a970 RCX: 00007f0a99f18779
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RDX: 0000000000000000 RSI: 000055e8e9dd2328 RDI: 0000000000000003
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 000055e8f735c410
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 000055e8e9dd2328
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: R13: 0000000000040000 R14: 000055e8f735aa80 R15: 0000000000000000
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel:  </TASK>
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: BUG at xa_alloc_index:57
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: CPU: 1 UID: 0 PID: 874 Comm: modprobe Tainted: G        W           6.15.0-rc2-next-20250417 #5 PREEMPT(full)
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Tainted: [W]=WARN
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Call Trace:
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel:  <TASK>
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: dump_stack_lvl (lib/dump_stack.c:122) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: xa_alloc_index.constprop.0.cold (lib/test_xarray.c:602) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: check_xa_alloc_1 (lib/test_xarray.c:941) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: ? __pfx_xarray_checks (lib/test_xarray.c:2233) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: check_xa_alloc (lib/test_xarray.c:1106) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: xarray_checks (lib/test_xarray.c:2250) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_one_initcall (init/main.c:1271) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_init_module (kernel/module/main.c:2930) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: init_module_from_file (kernel/module/main.c:3587) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: idempotent_init_module (./include/linux/spinlock.h:351 kernel/module/main.c:3528 kernel/module/main.c:3600) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: __x64_sys_finit_module (./include/linux/file.h:62 (discriminator 1) ./include/linux/file.h:83 (discriminator 1) kernel/module/main.c:3622 (discriminator 1) kernel/module/main.c:3609 (discriminator 1) kernel/module/main.c:3609 (discriminator 1)) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1)) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RIP: 0033:0x7f0a99f18779
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
All code
========
   0:	ff c3                	inc    %ebx
   2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00 
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 4f 86 0d 00 	mov    0xd864f(%rip),%rcx        # 0xd8689
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 4f 86 0d 00 	mov    0xd864f(%rip),%rcx        # 0xd865f
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RSP: 002b:00007fffcb2588c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RAX: ffffffffffffffda RBX: 000055e8f735a970 RCX: 00007f0a99f18779
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RDX: 0000000000000000 RSI: 000055e8e9dd2328 RDI: 0000000000000003
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 000055e8f735c410
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 000055e8e9dd2328
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: R13: 0000000000040000 R14: 000055e8f735aa80 R15: 0000000000000000
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel:  </TASK>
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: BUG at xa_erase_index:62
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: CPU: 1 UID: 0 PID: 874 Comm: modprobe Tainted: G        W           6.15.0-rc2-next-20250417 #5 PREEMPT(full)
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Tainted: [W]=WARN
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Call Trace:
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel:  <TASK>
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: dump_stack_lvl (lib/dump_stack.c:122) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: xa_erase_index.cold (lib/test_xarray.c:2272) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: check_xa_alloc_1 (./include/linux/xarray.h:61 lib/test_xarray.c:37 lib/test_xarray.c:42 lib/test_xarray.c:944) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: ? __pfx_xarray_checks (lib/test_xarray.c:2233) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: check_xa_alloc (lib/test_xarray.c:1106) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: xarray_checks (lib/test_xarray.c:2250) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_one_initcall (init/main.c:1271) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_init_module (kernel/module/main.c:2930) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: init_module_from_file (kernel/module/main.c:3587) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: idempotent_init_module (./include/linux/spinlock.h:351 kernel/module/main.c:3528 kernel/module/main.c:3600) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: __x64_sys_finit_module (./include/linux/file.h:62 (discriminator 1) ./include/linux/file.h:83 (discriminator 1) kernel/module/main.c:3622 (discriminator 1) kernel/module/main.c:3609 (discriminator 1) kernel/module/main.c:3609 (discriminator 1)) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1)) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RIP: 0033:0x7f0a99f18779
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
All code
========
   0:	ff c3                	inc    %ebx
   2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00 
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 4f 86 0d 00 	mov    0xd864f(%rip),%rcx        # 0xd8689
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 4f 86 0d 00 	mov    0xd864f(%rip),%rcx        # 0xd865f
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RSP: 002b:00007fffcb2588c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RAX: ffffffffffffffda RBX: 000055e8f735a970 RCX: 00007f0a99f18779
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RDX: 0000000000000000 RSI: 000055e8e9dd2328 RDI: 0000000000000003
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 000055e8f735c410
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 000055e8e9dd2328
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: R13: 0000000000040000 R14: 000055e8f735aa80 R15: 0000000000000000
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel:  </TASK>
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: BUG at xa_erase_index:62
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: CPU: 1 UID: 0 PID: 874 Comm: modprobe Tainted: G        W           6.15.0-rc2-next-20250417 #5 PREEMPT(full)
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Tainted: [W]=WARN
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Call Trace:
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel:  <TASK>
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: dump_stack_lvl (lib/dump_stack.c:122) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: xa_erase_index.cold (lib/test_xarray.c:2272) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: check_xa_alloc_1 (lib/test_xarray.c:949) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: ? __pfx_xarray_checks (lib/test_xarray.c:2233) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: check_xa_alloc (lib/test_xarray.c:1106) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: xarray_checks (lib/test_xarray.c:2250) test_xarray 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_one_initcall (init/main.c:1271) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_init_module (kernel/module/main.c:2930) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: init_module_from_file (kernel/module/main.c:3587) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: idempotent_init_module (./include/linux/spinlock.h:351 kernel/module/main.c:3528 kernel/module/main.c:3600) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: __x64_sys_finit_module (./include/linux/file.h:62 (discriminator 1) ./include/linux/file.h:83 (discriminator 1) kernel/module/main.c:3622 (discriminator 1) kernel/module/main.c:3609 (discriminator 1) kernel/module/main.c:3609 (discriminator 1)) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1)) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RIP: 0033:0x7f0a99f18779
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
All code
========
   0:	ff c3                	inc    %ebx
   2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00 
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d 4f 86 0d 00 	mov    0xd864f(%rip),%rcx        # 0xd8689
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d 4f 86 0d 00 	mov    0xd864f(%rip),%rcx        # 0xd865f
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RSP: 002b:00007fffcb2588c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RAX: ffffffffffffffda RBX: 000055e8f735a970 RCX: 00007f0a99f18779
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RDX: 0000000000000000 RSI: 000055e8e9dd2328 RDI: 0000000000000003
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 000055e8f735c410
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 000055e8e9dd2328
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel: R13: 0000000000040000 R14: 000055e8f735aa80 R15: 0000000000000000
Apr 18 02:30:42 e00aeb44aaa1-xarray kernel:  </TASK>
Apr 18 02:30:43 e00aeb44aaa1-xarray kernel: XArray: 158825678 of 158825682 tests passed

