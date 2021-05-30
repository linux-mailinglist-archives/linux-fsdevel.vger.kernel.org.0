Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F7739529E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 May 2021 21:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhE3TOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 May 2021 15:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhE3TOr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 May 2021 15:14:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55FA661206;
        Sun, 30 May 2021 19:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622401988;
        bh=jbX0VUm8xB7FawKj7WL01gS8x3YVX+KKqba3pqUkNeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WMMmbaHiClSEjiK1e2YzBMmxbRdplhR0PdBA2PR9rshuvafbjFFHfMLuzMue5CEnu
         SCjTOYBTuTRj7LhjucYahKgVYkugqYZwdGpzb4hzPajv8K9nqzrucYYQC7Zrp1f4hP
         v55+wzLF7z1RXhzmhy7Ret7H0MPcml/W2T3CQ8+dxqQPldGFNIe37M1UVjMY9e7ftZ
         abTyExBp6heYEyafk0Iu+gM11XJus4cvjmcgJk+bPHSH+EztccfiSsZ99Gqq4IpTAH
         qo24ZkruXHl5MgQST5OKDL9ky1Lf2HydXBAW+kcSLmMEL0nWVK/zgc06UI0BB9Sdxl
         OI2eG6V1ZYhaQ==
Date:   Sun, 30 May 2021 12:13:05 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ian Campbell <ijc@hellion.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Jaya Kumar <jayakumar.lkml@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] fb_defio: Remove custom address_space_operations
Message-ID: <YLPjwUUmHDRjyPpR@Ryzen-9-3900X.localdomain>
References: <20210310185530.1053320-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HCm/Mw5iFU7pz+1x"
Content-Disposition: inline
In-Reply-To: <20210310185530.1053320-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--HCm/Mw5iFU7pz+1x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matthew,

On Wed, Mar 10, 2021 at 06:55:30PM +0000, Matthew Wilcox (Oracle) wrote:
> There's no need to give the page an address_space.  Leaving the
> page->mapping as NULL will cause the VM to handle set_page_dirty()
> the same way that it's handled now, and that was the only reason to
> set the address_space in the first place.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

This patch in mainline as commit ccf953d8f3d6 ("fb_defio: Remove custom
address_space_operations") causes my Hyper-V based VM to no longer make
it to a graphical environment.

$ git bisect log
# bad: [6efb943b8616ec53a5e444193dccf1af9ad627b5] Linux 5.13-rc1
# good: [9f4ad9e425a1d3b6a34617b8ea226d56a119a717] Linux 5.12
git bisect start 'v5.13-rc1' 'v5.12'
# bad: [71a5cc28e88b0db69c3f83d4061ad4cc684af09f] Merge tag 'mfd-next-5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd
git bisect bad 71a5cc28e88b0db69c3f83d4061ad4cc684af09f
# good: [2a19866b6e4cf554b57660549d12496ea84aa7d7] Merge tag '5.12-rc-smb3-fixes-part1' of git://git.samba.org/sfrench/cifs-2.6
git bisect good 2a19866b6e4cf554b57660549d12496ea84aa7d7
# bad: [a1a1ca70deb3ec600eeabb21de7f3f48aaae5695] Merge tag 'drm-misc-next-fixes-2021-04-22' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
git bisect bad a1a1ca70deb3ec600eeabb21de7f3f48aaae5695
# good: [2cbcb78c9ee5520c8d836c7ff57d1b60ebe8e9b7] Merge tag 'amd-drm-next-5.13-2021-03-23' of https://gitlab.freedesktop.org/agd5f/linux into drm-next
git bisect good 2cbcb78c9ee5520c8d836c7ff57d1b60ebe8e9b7
# bad: [9c0fed84d5750e1eea6c664e073ffa2534a17743] Merge tag 'drm-intel-next-2021-04-01' of git://anongit.freedesktop.org/drm/drm-intel into drm-next
git bisect bad 9c0fed84d5750e1eea6c664e073ffa2534a17743
# bad: [1539f71602edf09bb33666afddc5a781c42e768d] Merge tag 'drm-misc-next-2021-04-01' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
git bisect bad 1539f71602edf09bb33666afddc5a781c42e768d
# good: [2f835b5dd8f7fc1e58d73fc2cd2ec33c2b054036] Merge tag 'topic/i915-gem-next-2021-03-26' of ssh://git.freedesktop.org/git/drm/drm into drm-next
git bisect good 2f835b5dd8f7fc1e58d73fc2cd2ec33c2b054036
# bad: [c42712c6e9bea042ea9696713024af7417f5ce18] drm/bridge/analogix/anx6345: Cleanup on errors in anx6345_bridge_attach()
git bisect bad c42712c6e9bea042ea9696713024af7417f5ce18
# bad: [dc659a4e852b591771fc2e5abb60f4455b0cf316] drm/probe-helper: Check epoch counter in output_poll_execute()
git bisect bad dc659a4e852b591771fc2e5abb60f4455b0cf316
# good: [5e7222a3674ea7422370779884dd53aabe9e4a9d] drm/panel-simple: Undo enable if HPD never asserts
git bisect good 5e7222a3674ea7422370779884dd53aabe9e4a9d
# good: [67cc24ac17fe2a2496456c8ca281ef89f7a6fd89] drm: panel: simple: Set enable delay for BOE NV110WTM-N61
git bisect good 67cc24ac17fe2a2496456c8ca281ef89f7a6fd89
# bad: [ccf953d8f3d68e85e577e843fdcde8872b0a9769] fb_defio: Remove custom address_space_operations
git bisect bad ccf953d8f3d68e85e577e843fdcde8872b0a9769
# good: [8613385cb2856e2ee9c4efb1f95eeaca0e1a0963] dma-fence: Document recoverable page fault implications
git bisect good 8613385cb2856e2ee9c4efb1f95eeaca0e1a0963
# first bad commit: [ccf953d8f3d68e85e577e843fdcde8872b0a9769] fb_defio: Remove custom address_space_operations

I did verify that I do not see the issue fixed with next-20210528. I
have attached the output of 'journalctl -k' from v5.13-rc3 and
next-20210528, they do not seem to provide any smoking gun to me but I
am not really sure what to look for. I am happy to provide any further
information or do any debugging as you see fit.

Cheers,
Nathan

--HCm/Mw5iFU7pz+1x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ccf953d8f3d68-next-20210528.log"

May 30 05:04:29 hyperv kernel: Linux version 5.13.0-rc3-next-20210528-next (nathan@hyperv) (gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 2.36.1) #1 SMP PREEMPT Sun May 30 11:59:03 MST 2021
May 30 05:04:29 hyperv kernel: Command line: initrd=\initramfs-linux-next.img root=PARTUUID=33da17a0-bae7-4ff2-97c5-b77426576af6 rw intel_pstate=no_hwp video=hyperv_fb:1920x1080
May 30 05:04:29 hyperv kernel: x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
May 30 05:04:29 hyperv kernel: x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
May 30 05:04:29 hyperv kernel: x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
May 30 05:04:29 hyperv kernel: x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
May 30 05:04:29 hyperv kernel: x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
May 30 05:04:29 hyperv kernel: signal: max sigframe size: 1776
May 30 05:04:29 hyperv kernel: BIOS-provided physical RAM map:
May 30 05:04:29 hyperv kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
May 30 05:04:29 hyperv kernel: BIOS-e820: [mem 0x00000000000c0000-0x00000000000fffff] reserved
May 30 05:04:29 hyperv kernel: BIOS-e820: [mem 0x0000000000100000-0x000000007fff1fff] usable
May 30 05:04:29 hyperv kernel: BIOS-e820: [mem 0x000000007fff2000-0x000000007fff2fff] reserved
May 30 05:04:29 hyperv kernel: BIOS-e820: [mem 0x000000007fff3000-0x00000000f6d93fff] usable
May 30 05:04:29 hyperv kernel: BIOS-e820: [mem 0x00000000f6d94000-0x00000000f6d94fff] ACPI data
May 30 05:04:29 hyperv kernel: BIOS-e820: [mem 0x00000000f6d95000-0x00000000f6ecbfff] usable
May 30 05:04:29 hyperv kernel: BIOS-e820: [mem 0x00000000f6ecc000-0x00000000f6eeafff] ACPI data
May 30 05:04:29 hyperv kernel: BIOS-e820: [mem 0x00000000f6eeb000-0x00000000f6f1afff] reserved
May 30 05:04:29 hyperv kernel: BIOS-e820: [mem 0x00000000f6f1b000-0x00000000f7f9afff] usable
May 30 05:04:29 hyperv kernel: BIOS-e820: [mem 0x00000000f7f9b000-0x00000000f7ff2fff] reserved
May 30 05:04:29 hyperv kernel: BIOS-e820: [mem 0x00000000f7ff3000-0x00000000f7ffafff] ACPI data
May 30 05:04:29 hyperv kernel: BIOS-e820: [mem 0x00000000f7ffb000-0x00000000f7ffefff] ACPI NVS
May 30 05:04:29 hyperv kernel: BIOS-e820: [mem 0x00000000f7fff000-0x00000000f7ffffff] usable
May 30 05:04:29 hyperv kernel: BIOS-e820: [mem 0x0000000100000000-0x0000000107ffffff] usable
May 30 05:04:29 hyperv kernel: intel_pstate: HWP disabled
May 30 05:04:29 hyperv kernel: NX (Execute Disable) protection: active
May 30 05:04:29 hyperv kernel: efi: EFI v2.70 by Microsoft
May 30 05:04:29 hyperv kernel: efi: ACPI=0xf7ffa000 ACPI 2.0=0xf7ffa014 SMBIOS=0xf7fd8000 SMBIOS 3.0=0xf7fd6000 MEMATTR=0xf7328698 RNG=0xf7fda818 
May 30 05:04:29 hyperv kernel: efi: seeding entropy pool
May 30 05:04:29 hyperv kernel: SMBIOS 3.1.0 present.
May 30 05:04:29 hyperv kernel: DMI: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.0 11/01/2019
May 30 05:04:29 hyperv kernel: Hypervisor detected: Microsoft Hyper-V
May 30 05:04:29 hyperv kernel: Hyper-V: privilege flags low 0x2e7f, high 0x3b8030, hints 0xc2c, misc 0xbed7b2
May 30 05:04:29 hyperv kernel: Hyper-V Host Build:19041-10.0-1-0.1023
May 30 05:04:29 hyperv kernel: Hyper-V: LAPIC Timer Frequency: 0xa2c2a
May 30 05:04:29 hyperv kernel: tsc: Marking TSC unstable due to running on Hyper-V
May 30 05:04:29 hyperv kernel: Hyper-V: Using hypercall for remote TLB flush
May 30 05:04:29 hyperv kernel: clocksource: hyperv_clocksource_tsc_page: mask: 0xffffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
May 30 05:04:29 hyperv kernel: tsc: Detected 3800.005 MHz processor
May 30 05:04:29 hyperv kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
May 30 05:04:29 hyperv kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
May 30 05:04:29 hyperv kernel: last_pfn = 0x108000 max_arch_pfn = 0x400000000
May 30 05:04:29 hyperv kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
May 30 05:04:29 hyperv kernel: last_pfn = 0xf8000 max_arch_pfn = 0x400000000
May 30 05:04:29 hyperv kernel: Using GB pages for direct mapping
May 30 05:04:29 hyperv kernel: Secure boot disabled
May 30 05:04:29 hyperv kernel: RAMDISK: [mem 0x7f872000-0x7fff1fff]
May 30 05:04:29 hyperv kernel: ACPI: Early table checksum verification disabled
May 30 05:04:29 hyperv kernel: ACPI: RSDP 0x00000000F7FFA014 000024 (v02 VRTUAL)
May 30 05:04:29 hyperv kernel: ACPI: XSDT 0x00000000F7FF90E8 00005C (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
May 30 05:04:29 hyperv kernel: ACPI: FACP 0x00000000F7FF8000 000114 (v06 VRTUAL MICROSFT 00000001 MSFT 00000001)
May 30 05:04:29 hyperv kernel: ACPI: DSDT 0x00000000F6ECC000 01E184 (v02 MSFTVM DSDT01   00000001 MSFT 05000000)
May 30 05:04:29 hyperv kernel: ACPI: FACS 0x00000000F7FFE000 000040
May 30 05:04:29 hyperv kernel: ACPI: OEM0 0x00000000F7FF7000 000064 (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
May 30 05:04:29 hyperv kernel: ACPI: WAET 0x00000000F7FF6000 000028 (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
May 30 05:04:29 hyperv kernel: ACPI: APIC 0x00000000F7FF5000 0000A8 (v04 VRTUAL MICROSFT 00000001 MSFT 00000001)
May 30 05:04:29 hyperv kernel: ACPI: SRAT 0x00000000F7FF4000 000230 (v02 VRTUAL MICROSFT 00000001 MSFT 00000001)
May 30 05:04:29 hyperv kernel: ACPI: BGRT 0x00000000F7FF3000 000038 (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
May 30 05:04:29 hyperv kernel: ACPI: FPDT 0x00000000F6D94000 000034 (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
May 30 05:04:29 hyperv kernel: ACPI: Reserving FACP table memory at [mem 0xf7ff8000-0xf7ff8113]
May 30 05:04:29 hyperv kernel: ACPI: Reserving DSDT table memory at [mem 0xf6ecc000-0xf6eea183]
May 30 05:04:29 hyperv kernel: ACPI: Reserving FACS table memory at [mem 0xf7ffe000-0xf7ffe03f]
May 30 05:04:29 hyperv kernel: ACPI: Reserving OEM0 table memory at [mem 0xf7ff7000-0xf7ff7063]
May 30 05:04:29 hyperv kernel: ACPI: Reserving WAET table memory at [mem 0xf7ff6000-0xf7ff6027]
May 30 05:04:29 hyperv kernel: ACPI: Reserving APIC table memory at [mem 0xf7ff5000-0xf7ff50a7]
May 30 05:04:29 hyperv kernel: ACPI: Reserving SRAT table memory at [mem 0xf7ff4000-0xf7ff422f]
May 30 05:04:29 hyperv kernel: ACPI: Reserving BGRT table memory at [mem 0xf7ff3000-0xf7ff3037]
May 30 05:04:29 hyperv kernel: ACPI: Reserving FPDT table memory at [mem 0xf6d94000-0xf6d94033]
May 30 05:04:29 hyperv kernel: SRAT: PXM 0 -> APIC 0x00 -> Node 0
May 30 05:04:29 hyperv kernel: SRAT: PXM 0 -> APIC 0x01 -> Node 0
May 30 05:04:29 hyperv kernel: SRAT: PXM 0 -> APIC 0x02 -> Node 0
May 30 05:04:29 hyperv kernel: SRAT: PXM 0 -> APIC 0x03 -> Node 0
May 30 05:04:29 hyperv kernel: SRAT: PXM 0 -> APIC 0x04 -> Node 0
May 30 05:04:29 hyperv kernel: SRAT: PXM 0 -> APIC 0x05 -> Node 0
May 30 05:04:29 hyperv kernel: SRAT: PXM 0 -> APIC 0x06 -> Node 0
May 30 05:04:29 hyperv kernel: SRAT: PXM 0 -> APIC 0x07 -> Node 0
May 30 05:04:29 hyperv kernel: SRAT: PXM 0 -> APIC 0x08 -> Node 0
May 30 05:04:29 hyperv kernel: SRAT: PXM 0 -> APIC 0x09 -> Node 0
May 30 05:04:29 hyperv kernel: SRAT: PXM 0 -> APIC 0x0a -> Node 0
May 30 05:04:29 hyperv kernel: SRAT: PXM 0 -> APIC 0x0b -> Node 0
May 30 05:04:29 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0xf7ffffff] hotplug
May 30 05:04:29 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x107ffffff] hotplug
May 30 05:04:29 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x108000000-0xfdfffffff] hotplug
May 30 05:04:29 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x1000000000-0xfcffffffff] hotplug
May 30 05:04:29 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x10000000000-0x1ffffffffff] hotplug
May 30 05:04:29 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x20000000000-0x3ffffffffff] hotplug
May 30 05:04:29 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x40000000000-0x7ffffffffff] hotplug
May 30 05:04:29 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000000-0xfffffffffff] hotplug
May 30 05:04:29 hyperv kernel: NUMA: Node 0 [mem 0x00000000-0xf7ffffff] + [mem 0x100000000-0x107ffffff] -> [mem 0x00000000-0x107ffffff]
May 30 05:04:29 hyperv kernel: NODE_DATA(0) allocated [mem 0x107ffa000-0x107ffdfff]
May 30 05:04:29 hyperv kernel: Zone ranges:
May 30 05:04:29 hyperv kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
May 30 05:04:29 hyperv kernel:   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
May 30 05:04:29 hyperv kernel:   Normal   [mem 0x0000000100000000-0x0000000107ffffff]
May 30 05:04:29 hyperv kernel:   Device   empty
May 30 05:04:29 hyperv kernel: Movable zone start for each node
May 30 05:04:29 hyperv kernel: Early memory node ranges
May 30 05:04:29 hyperv kernel:   node   0: [mem 0x0000000000001000-0x000000000009ffff]
May 30 05:04:29 hyperv kernel:   node   0: [mem 0x0000000000100000-0x000000007fff1fff]
May 30 05:04:29 hyperv kernel:   node   0: [mem 0x000000007fff3000-0x00000000f6d93fff]
May 30 05:04:29 hyperv kernel:   node   0: [mem 0x00000000f6d95000-0x00000000f6ecbfff]
May 30 05:04:29 hyperv kernel:   node   0: [mem 0x00000000f6f1b000-0x00000000f7f9afff]
May 30 05:04:29 hyperv kernel:   node   0: [mem 0x00000000f7fff000-0x00000000f7ffffff]
May 30 05:04:29 hyperv kernel:   node   0: [mem 0x0000000100000000-0x0000000107ffffff]
May 30 05:04:29 hyperv kernel: Initmem setup node 0 [mem 0x0000000000001000-0x0000000107ffffff]
May 30 05:04:29 hyperv kernel:   DMA zone: 28769 pages in unavailable ranges
May 30 05:04:29 hyperv kernel:   DMA32 zone: 181 pages in unavailable ranges
May 30 05:04:29 hyperv kernel: ACPI: PM-Timer IO Port: 0x408
May 30 05:04:29 hyperv kernel: ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
May 30 05:04:29 hyperv kernel: IOAPIC[0]: apic_id 12, version 17, address 0xfec00000, GSI 0-23
May 30 05:04:29 hyperv kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
May 30 05:04:29 hyperv kernel: ACPI: Using ACPI (MADT) for SMP configuration information
May 30 05:04:29 hyperv kernel: e820: update [mem 0xf7354000-0xf735afff] usable ==> reserved
May 30 05:04:29 hyperv kernel: smpboot: Allowing 12 CPUs, 0 hotplug CPUs
May 30 05:04:29 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
May 30 05:04:29 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000bffff]
May 30 05:04:29 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x000c0000-0x000fffff]
May 30 05:04:29 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x7fff2000-0x7fff2fff]
May 30 05:04:29 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0xf6d94000-0xf6d94fff]
May 30 05:04:29 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0xf6ecc000-0xf6eeafff]
May 30 05:04:29 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0xf6eeb000-0xf6f1afff]
May 30 05:04:29 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0xf7354000-0xf735afff]
May 30 05:04:29 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0xf7f9b000-0xf7ff2fff]
May 30 05:04:29 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0xf7ff3000-0xf7ffafff]
May 30 05:04:29 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0xf7ffb000-0xf7ffefff]
May 30 05:04:29 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xffffffff]
May 30 05:04:29 hyperv kernel: [mem 0xf8000000-0xffffffff] available for PCI devices
May 30 05:04:29 hyperv kernel: Booting paravirtualized kernel on Hyper-V
May 30 05:04:29 hyperv kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
May 30 05:04:29 hyperv kernel: setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:12 nr_node_ids:1
May 30 05:04:29 hyperv kernel: percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u262144
May 30 05:04:29 hyperv kernel: pcpu-alloc: s192512 r8192 d28672 u262144 alloc=1*2097152
May 30 05:04:29 hyperv kernel: pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 -- -- -- -- 
May 30 05:04:29 hyperv kernel: Hyper-V: PV spinlocks enabled
May 30 05:04:29 hyperv kernel: PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
May 30 05:04:29 hyperv kernel: Built 1 zonelists, mobility grouping on.  Total pages: 1030058
May 30 05:04:29 hyperv kernel: Policy zone: Normal
May 30 05:04:29 hyperv kernel: Kernel command line: initrd=\initramfs-linux-next.img root=PARTUUID=33da17a0-bae7-4ff2-97c5-b77426576af6 rw intel_pstate=no_hwp video=hyperv_fb:1920x1080
May 30 05:04:29 hyperv kernel: Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
May 30 05:04:29 hyperv kernel: Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
May 30 05:04:29 hyperv kernel: mem auto-init: stack:off, heap alloc:on, heap free:off
May 30 05:04:29 hyperv kernel: Memory: 3988688K/4193192K available (14344K kernel code, 2011K rwdata, 4660K rodata, 1764K init, 4316K bss, 204244K reserved, 0K cma-reserved)
May 30 05:04:29 hyperv kernel: random: get_random_u64 called from __kmem_cache_create+0x24/0x540 with crng_init=0
May 30 05:04:29 hyperv kernel: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=12, Nodes=1
May 30 05:04:29 hyperv kernel: ftrace: allocating 41421 entries in 162 pages
May 30 05:04:29 hyperv kernel: ftrace: allocated 162 pages with 3 groups
May 30 05:04:29 hyperv kernel: rcu: Preemptible hierarchical RCU implementation.
May 30 05:04:29 hyperv kernel: rcu:         RCU dyntick-idle grace-period acceleration is enabled.
May 30 05:04:29 hyperv kernel: rcu:         RCU restricting CPUs from NR_CPUS=320 to nr_cpu_ids=12.
May 30 05:04:29 hyperv kernel: rcu:         RCU priority boosting: priority 1 delay 500 ms.
May 30 05:04:29 hyperv kernel:         Trampoline variant of Tasks RCU enabled.
May 30 05:04:29 hyperv kernel:         Rude variant of Tasks RCU enabled.
May 30 05:04:29 hyperv kernel:         Tracing variant of Tasks RCU enabled.
May 30 05:04:29 hyperv kernel: rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
May 30 05:04:29 hyperv kernel: rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=12
May 30 05:04:29 hyperv kernel: Using NULL legacy PIC
May 30 05:04:29 hyperv kernel: NR_IRQS: 20736, nr_irqs: 520, preallocated irqs: 0
May 30 05:04:29 hyperv kernel: Console: colour dummy device 80x25
May 30 05:04:29 hyperv kernel: printk: console [tty0] enabled
May 30 05:04:29 hyperv kernel: ACPI: Core revision 20210331
May 30 05:04:29 hyperv kernel: Failed to register legacy timer interrupt
May 30 05:04:29 hyperv kernel: APIC: Switch to symmetric I/O mode setup
May 30 05:04:29 hyperv kernel: Switched APIC routing to physical flat.
May 30 05:04:29 hyperv kernel: Hyper-V: Using IPI hypercalls
May 30 05:04:29 hyperv kernel: Hyper-V: Using enlightened APIC (xapic mode)
May 30 05:04:29 hyperv kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 7603.67 BogoMIPS (lpj=12666683)
May 30 05:04:29 hyperv kernel: pid_max: default: 32768 minimum: 301
May 30 05:04:29 hyperv kernel: LSM: Security Framework initializing
May 30 05:04:29 hyperv kernel: Yama: becoming mindful.
May 30 05:04:29 hyperv kernel: LSM support for eBPF active
May 30 05:04:29 hyperv kernel: Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
May 30 05:04:29 hyperv kernel: Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
May 30 05:04:29 hyperv kernel: Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
May 30 05:04:29 hyperv kernel: Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
May 30 05:04:29 hyperv kernel: Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
May 30 05:04:29 hyperv kernel: Spectre V2 : Mitigation: Full AMD retpoline
May 30 05:04:29 hyperv kernel: Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
May 30 05:04:29 hyperv kernel: Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
May 30 05:04:29 hyperv kernel: Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
May 30 05:04:29 hyperv kernel: Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
May 30 05:04:29 hyperv kernel: Freeing SMP alternatives memory: 36K
May 30 05:04:29 hyperv kernel: smpboot: CPU0: AMD Ryzen 9 3900X 12-Core Processor (family: 0x17, model: 0x71, stepping: 0x0)
May 30 05:04:29 hyperv kernel: Performance Events: PMU not available due to virtualization, using software events only.
May 30 05:04:29 hyperv kernel: rcu: Hierarchical SRCU implementation.
May 30 05:04:29 hyperv kernel: NMI watchdog: Perf NMI watchdog permanently disabled
May 30 05:04:29 hyperv kernel: smp: Bringing up secondary CPUs ...
May 30 05:04:29 hyperv kernel: x86: Booting SMP configuration:
May 30 05:04:29 hyperv kernel: .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6
May 30 05:04:29 hyperv kernel: random: fast init done
May 30 05:04:29 hyperv kernel:   #7  #8  #9 #10 #11
May 30 05:04:29 hyperv kernel: smp: Brought up 1 node, 12 CPUs
May 30 05:04:29 hyperv kernel: smpboot: Max logical packages: 1
May 30 05:04:29 hyperv kernel: smpboot: Total of 12 processors activated (91323.06 BogoMIPS)
May 30 05:04:29 hyperv kernel: devtmpfs: initialized
May 30 05:04:29 hyperv kernel: x86/mm: Memory block size: 128MB
May 30 05:04:29 hyperv kernel: PM: Registering ACPI NVS region [mem 0xf7ffb000-0xf7ffefff] (16384 bytes)
May 30 05:04:29 hyperv kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
May 30 05:04:29 hyperv kernel: futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
May 30 05:04:29 hyperv kernel: pinctrl core: initialized pinctrl subsystem
May 30 05:04:29 hyperv kernel: PM: RTC time: 12:04:28, date: 2021-05-30
May 30 05:04:29 hyperv kernel: NET: Registered protocol family 16
May 30 05:04:29 hyperv kernel: DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
May 30 05:04:29 hyperv kernel: DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
May 30 05:04:29 hyperv kernel: DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
May 30 05:04:29 hyperv kernel: audit: initializing netlink subsys (disabled)
May 30 05:04:29 hyperv kernel: audit: type=2000 audit(1622376267.916:1): state=initialized audit_enabled=0 res=1
May 30 05:04:29 hyperv kernel: thermal_sys: Registered thermal governor 'fair_share'
May 30 05:04:29 hyperv kernel: thermal_sys: Registered thermal governor 'bang_bang'
May 30 05:04:29 hyperv kernel: thermal_sys: Registered thermal governor 'step_wise'
May 30 05:04:29 hyperv kernel: thermal_sys: Registered thermal governor 'user_space'
May 30 05:04:29 hyperv kernel: thermal_sys: Registered thermal governor 'power_allocator'
May 30 05:04:29 hyperv kernel: cpuidle: using governor ladder
May 30 05:04:29 hyperv kernel: cpuidle: using governor menu
May 30 05:04:29 hyperv kernel: ACPI: bus type PCI registered
May 30 05:04:29 hyperv kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
May 30 05:04:29 hyperv kernel: Kprobes globally optimized
May 30 05:04:29 hyperv kernel: HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
May 30 05:04:29 hyperv kernel: HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
May 30 05:04:29 hyperv kernel: ACPI: Added _OSI(Module Device)
May 30 05:04:29 hyperv kernel: ACPI: Added _OSI(Processor Device)
May 30 05:04:29 hyperv kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
May 30 05:04:29 hyperv kernel: ACPI: Added _OSI(Processor Aggregator Device)
May 30 05:04:29 hyperv kernel: ACPI: Added _OSI(Linux-Dell-Video)
May 30 05:04:29 hyperv kernel: ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
May 30 05:04:29 hyperv kernel: ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
May 30 05:04:29 hyperv kernel: ACPI: 1 ACPI AML tables successfully acquired and loaded
May 30 05:04:29 hyperv kernel: ACPI: Interpreter enabled
May 30 05:04:29 hyperv kernel: ACPI: (supports S0 S5)
May 30 05:04:29 hyperv kernel: ACPI: Using IOAPIC for interrupt routing
May 30 05:04:29 hyperv kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
May 30 05:04:29 hyperv kernel: ACPI: Enabled 1 GPEs in block 00 to 0F
May 30 05:04:29 hyperv kernel: iommu: Default domain type: Translated 
May 30 05:04:29 hyperv kernel: vgaarb: loaded
May 30 05:04:29 hyperv kernel: SCSI subsystem initialized
May 30 05:04:29 hyperv kernel: libata version 3.00 loaded.
May 30 05:04:29 hyperv kernel: ACPI: bus type USB registered
May 30 05:04:29 hyperv kernel: usbcore: registered new interface driver usbfs
May 30 05:04:29 hyperv kernel: usbcore: registered new interface driver hub
May 30 05:04:29 hyperv kernel: usbcore: registered new device driver usb
May 30 05:04:29 hyperv kernel: pps_core: LinuxPPS API ver. 1 registered
May 30 05:04:29 hyperv kernel: pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
May 30 05:04:29 hyperv kernel: PTP clock support registered
May 30 05:04:29 hyperv kernel: EDAC MC: Ver: 3.0.0
May 30 05:04:29 hyperv kernel: Registered efivars operations
May 30 05:04:29 hyperv kernel: NetLabel: Initializing
May 30 05:04:29 hyperv kernel: NetLabel:  domain hash size = 128
May 30 05:04:29 hyperv kernel: NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
May 30 05:04:29 hyperv kernel: NetLabel:  unlabeled traffic allowed by default
May 30 05:04:29 hyperv kernel: PCI: Using ACPI for IRQ routing
May 30 05:04:29 hyperv kernel: PCI: System does not support PCI
May 30 05:04:29 hyperv kernel: clocksource: Switched to clocksource hyperv_clocksource_tsc_page
May 30 05:04:29 hyperv kernel: VFS: Disk quotas dquot_6.6.0
May 30 05:04:29 hyperv kernel: VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
May 30 05:04:29 hyperv kernel: pnp: PnP ACPI init
May 30 05:04:29 hyperv kernel: pnp: PnP ACPI: found 1 devices
May 30 05:04:29 hyperv kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
May 30 05:04:29 hyperv kernel: NET: Registered protocol family 2
May 30 05:04:29 hyperv kernel: IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
May 30 05:04:29 hyperv kernel: tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
May 30 05:04:29 hyperv kernel: TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
May 30 05:04:29 hyperv kernel: TCP bind hash table entries: 32768 (order: 7, 524288 bytes, linear)
May 30 05:04:29 hyperv kernel: TCP: Hash tables configured (established 32768 bind 32768)
May 30 05:04:29 hyperv kernel: MPTCP token hash table entries: 4096 (order: 4, 98304 bytes, linear)
May 30 05:04:29 hyperv kernel: UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
May 30 05:04:29 hyperv kernel: UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
May 30 05:04:29 hyperv kernel: NET: Registered protocol family 1
May 30 05:04:29 hyperv kernel: NET: Registered protocol family 44
May 30 05:04:29 hyperv kernel: PCI: CLS 0 bytes, default 64
May 30 05:04:29 hyperv kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
May 30 05:04:29 hyperv kernel: software IO TLB: mapped [mem 0x00000000f2d73000-0x00000000f6d73000] (64MB)
May 30 05:04:29 hyperv kernel: Unpacking initramfs...
May 30 05:04:29 hyperv kernel: Initialise system trusted keyrings
May 30 05:04:29 hyperv kernel: Key type blacklist registered
May 30 05:04:29 hyperv kernel: workingset: timestamp_bits=41 max_order=20 bucket_order=0
May 30 05:04:29 hyperv kernel: zbud: loaded
May 30 05:04:29 hyperv kernel: Key type asymmetric registered
May 30 05:04:29 hyperv kernel: Asymmetric key parser 'x509' registered
May 30 05:04:29 hyperv kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
May 30 05:04:29 hyperv kernel: io scheduler mq-deadline registered
May 30 05:04:29 hyperv kernel: io scheduler kyber registered
May 30 05:04:29 hyperv kernel: io scheduler bfq registered
May 30 05:04:29 hyperv kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
May 30 05:04:29 hyperv kernel: efifb: probing for efifb
May 30 05:04:29 hyperv kernel: efifb: framebuffer at 0xf8000000, using 3072k, total 3072k
May 30 05:04:29 hyperv kernel: efifb: mode is 1024x768x32, linelength=4096, pages=1
May 30 05:04:29 hyperv kernel: efifb: scrolling: redraw
May 30 05:04:29 hyperv kernel: efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
May 30 05:04:29 hyperv kernel: fbcon: Deferring console take-over
May 30 05:04:29 hyperv kernel: fb0: EFI VGA frame buffer device
May 30 05:04:29 hyperv kernel: Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
May 30 05:04:29 hyperv kernel: Non-volatile memory driver v1.3
May 30 05:04:29 hyperv kernel: AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
May 30 05:04:29 hyperv kernel: AMD-Vi: AMD IOMMUv2 functionality not available on this system
May 30 05:04:29 hyperv kernel: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
May 30 05:04:29 hyperv kernel: ehci-pci: EHCI PCI platform driver
May 30 05:04:29 hyperv kernel: ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
May 30 05:04:29 hyperv kernel: ohci-pci: OHCI PCI platform driver
May 30 05:04:29 hyperv kernel: uhci_hcd: USB Universal Host Controller Interface driver
May 30 05:04:29 hyperv kernel: usbcore: registered new interface driver usbserial_generic
May 30 05:04:29 hyperv kernel: usbserial: USB Serial support registered for generic
May 30 05:04:29 hyperv kernel: rtc_cmos 00:00: RTC can wake from S4
May 30 05:04:29 hyperv kernel: rtc_cmos 00:00: registered as rtc0
May 30 05:04:29 hyperv kernel: rtc_cmos 00:00: setting system clock to 2021-05-30T12:04:28 UTC (1622376268)
May 30 05:04:29 hyperv kernel: rtc_cmos 00:00: alarms up to one month, 114 bytes nvram
May 30 05:04:29 hyperv kernel: ledtrig-cpu: registered to indicate activity on CPUs
May 30 05:04:29 hyperv kernel: hid: raw HID events driver (C) Jiri Kosina
May 30 05:04:29 hyperv kernel: drop_monitor: Initializing network drop monitor service
May 30 05:04:29 hyperv kernel: Initializing XFRM netlink socket
May 30 05:04:29 hyperv kernel: NET: Registered protocol family 10
May 30 05:04:29 hyperv kernel: Freeing initrd memory: 7680K
May 30 05:04:29 hyperv kernel: Segment Routing with IPv6
May 30 05:04:29 hyperv kernel: RPL Segment Routing with IPv6
May 30 05:04:29 hyperv kernel: NET: Registered protocol family 17
May 30 05:04:29 hyperv kernel: IPI shorthand broadcast: enabled
May 30 05:04:29 hyperv kernel: registered taskstats version 1
May 30 05:04:29 hyperv kernel: Loading compiled-in X.509 certificates
May 30 05:04:29 hyperv kernel: Loaded X.509 cert 'Build time autogenerated kernel key: 0f4d415814a213e04a366b8bcee25481bf4613e7'
May 30 05:04:29 hyperv kernel: zswap: loaded using pool lz4/z3fold
May 30 05:04:29 hyperv kernel: Key type ._fscrypt registered
May 30 05:04:29 hyperv kernel: Key type .fscrypt registered
May 30 05:04:29 hyperv kernel: Key type fscrypt-provisioning registered
May 30 05:04:29 hyperv kernel: PM:   Magic number: 5:35:78
May 30 05:04:29 hyperv kernel: RAS: Correctable Errors collector initialized.
May 30 05:04:29 hyperv kernel: Unstable clock detected, switching default tracing clock to "global"
                               If you want to keep using the local clock, then add:
                                 "trace_clock=local"
                               on the kernel command line
May 30 05:04:29 hyperv kernel: Freeing unused decrypted memory: 2036K
May 30 05:04:29 hyperv kernel: Freeing unused kernel image (initmem) memory: 1764K
May 30 05:04:29 hyperv kernel: Write protecting the kernel read-only data: 22528k
May 30 05:04:29 hyperv kernel: Freeing unused kernel image (text/rodata gap) memory: 2036K
May 30 05:04:29 hyperv kernel: Freeing unused kernel image (rodata/data gap) memory: 1484K
May 30 05:04:29 hyperv kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
May 30 05:04:29 hyperv kernel: rodata_test: all tests were successful
May 30 05:04:29 hyperv kernel: Run /init as init process
May 30 05:04:29 hyperv kernel:   with arguments:
May 30 05:04:29 hyperv kernel:     /init
May 30 05:04:29 hyperv kernel:   with environment:
May 30 05:04:29 hyperv kernel:     HOME=/
May 30 05:04:29 hyperv kernel:     TERM=linux
May 30 05:04:29 hyperv kernel: fbcon: Taking over console
May 30 05:04:29 hyperv kernel: Console: switching to colour frame buffer device 128x48
May 30 05:04:29 hyperv kernel: hv_vmbus: Vmbus version:5.2
May 30 05:04:29 hyperv kernel: hv_vmbus: registering driver hid_hyperv
May 30 05:04:29 hyperv kernel: input: Microsoft Vmbus HID-compliant Mouse as /devices/0006:045E:0621.0001/input/input0
May 30 05:04:29 hyperv kernel: hid-generic 0006:045E:0621.0001: input: VIRTUAL HID v0.01 Mouse [Microsoft Vmbus HID-compliant Mouse] on 
May 30 05:04:29 hyperv kernel: hv_vmbus: registering driver hyperv_keyboard
May 30 05:04:29 hyperv kernel: hv_vmbus: registering driver hv_storvsc
May 30 05:04:29 hyperv kernel: scsi host0: storvsc_host_t
May 30 05:04:29 hyperv kernel: input: AT Translated Set 2 keyboard as /devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0004:00/VMBUS:00/d34b2567-b9b6-42b9-8778-0a4ec0b955bf/serio0/input/input1
May 30 05:04:29 hyperv kernel: scsi 0:0:0:0: Direct-Access     Msft     Virtual Disk     1.0  PQ: 0 ANSI: 5
May 30 05:04:29 hyperv kernel: scsi 0:0:0:1: CD-ROM            Msft     Virtual DVD-ROM  1.0  PQ: 0 ANSI: 0
May 30 05:04:29 hyperv kernel: sd 0:0:0:0: [sda] 266338304 512-byte logical blocks: (136 GB/127 GiB)
May 30 05:04:29 hyperv kernel: sd 0:0:0:0: [sda] 4096-byte physical blocks
May 30 05:04:29 hyperv kernel: sd 0:0:0:0: [sda] Write Protect is off
May 30 05:04:29 hyperv kernel: sd 0:0:0:0: [sda] Mode Sense: 0f 00 00 00
May 30 05:04:29 hyperv kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
May 30 05:04:29 hyperv kernel:  sda: sda1 sda2
May 30 05:04:29 hyperv kernel: sd 0:0:0:0: [sda] Attached SCSI disk
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] scsi-1 drive
May 30 05:04:29 hyperv kernel: cdrom: Uniform CD-ROM driver Revision: 3.20
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: Attached scsi CD-ROM sr0
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 Sense Key : Not Ready [current] 
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 Add. Sense: Medium not present - tray closed
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 CDB: Read(10) 28 00 00 07 ff fc 00 00 02 00
May 30 05:04:29 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097136 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#198 unaligned transfer
May 30 05:04:29 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097136 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
May 30 05:04:29 hyperv kernel: Buffer I/O error on dev sr0, logical block 2097136, async page read
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#199 unaligned transfer
May 30 05:04:29 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097137 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
May 30 05:04:29 hyperv kernel: Buffer I/O error on dev sr0, logical block 2097137, async page read
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 unaligned transfer
May 30 05:04:29 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097138 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
May 30 05:04:29 hyperv kernel: Buffer I/O error on dev sr0, logical block 2097138, async page read
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#201 unaligned transfer
May 30 05:04:29 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097139 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
May 30 05:04:29 hyperv kernel: Buffer I/O error on dev sr0, logical block 2097139, async page read
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#202 unaligned transfer
May 30 05:04:29 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097140 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
May 30 05:04:29 hyperv kernel: Buffer I/O error on dev sr0, logical block 2097140, async page read
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#203 unaligned transfer
May 30 05:04:29 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097141 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
May 30 05:04:29 hyperv kernel: Buffer I/O error on dev sr0, logical block 2097141, async page read
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#204 unaligned transfer
May 30 05:04:29 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097142 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
May 30 05:04:29 hyperv kernel: Buffer I/O error on dev sr0, logical block 2097142, async page read
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 unaligned transfer
May 30 05:04:29 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097143 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
May 30 05:04:29 hyperv kernel: Buffer I/O error on dev sr0, logical block 2097143, async page read
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 Sense Key : Not Ready [current] 
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 Add. Sense: Medium not present - tray closed
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 CDB: Read(10) 28 00 00 00 00 00 00 00 02 00
May 30 05:04:29 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#207 unaligned transfer
May 30 05:04:29 hyperv kernel: Buffer I/O error on dev sr0, logical block 0, async page read
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#208 unaligned transfer
May 30 05:04:29 hyperv kernel: Buffer I/O error on dev sr0, logical block 1, async page read
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#209 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#210 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#211 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#212 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#213 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#214 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#215 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#216 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#217 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#218 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#220 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#221 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#222 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#223 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#224 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#225 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#226 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#227 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#228 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#229 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#230 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#231 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#232 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#233 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#234 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#235 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#237 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#238 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#239 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#240 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#242 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#243 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#244 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#245 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#246 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#247 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#248 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#249 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#251 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#252 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#253 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#254 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#192 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#193 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#194 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#195 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#196 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#198 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#199 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#201 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#202 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#203 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#204 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#207 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#208 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#209 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#210 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#211 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#212 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#213 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#214 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#215 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#216 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#217 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#218 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#220 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#221 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#222 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#223 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#224 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#225 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#226 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#227 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#228 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#229 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#230 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#231 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#232 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#233 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#234 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#235 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#237 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#238 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#239 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#240 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#242 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#243 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#244 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#245 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#246 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#247 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#248 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#249 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#251 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#252 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#253 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#254 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#192 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#193 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#194 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#195 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#196 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#198 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#199 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#201 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#202 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#203 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#204 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#207 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#208 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#209 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#210 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#211 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#212 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#213 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#214 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#215 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#216 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#217 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#218 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#220 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#221 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#222 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#223 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#224 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#225 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#226 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#227 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#228 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#229 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#230 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#231 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#232 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#233 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#234 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#235 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#237 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#238 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#239 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#240 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#242 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#243 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#244 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#245 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#246 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#247 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#248 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#249 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#251 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#252 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#253 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#254 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 Sense Key : Not Ready [current] 
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 Add. Sense: Medium not present - tray closed
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 CDB: Read(10) 28 00 00 00 00 04 00 00 02 00
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#192 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#193 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#194 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#195 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#196 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#198 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#199 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 Sense Key : Not Ready [current] 
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 Add. Sense: Medium not present - tray closed
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 CDB: Read(10) 28 00 00 00 00 20 00 00 02 00
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#201 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#202 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#203 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#204 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#207 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#208 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#209 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#210 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#211 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#212 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#213 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#214 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#215 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#216 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#217 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#218 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#220 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#221 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#222 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#223 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#224 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#225 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#226 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#227 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#228 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#229 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#230 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#231 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#232 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#233 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#234 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#235 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#237 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#238 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#239 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#240 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 Sense Key : Not Ready [current] 
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 Add. Sense: Medium not present - tray closed
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 CDB: Read(10) 28 00 00 00 00 10 00 00 02 00
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#242 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#243 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#244 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#245 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#246 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#247 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#248 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#249 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#251 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#252 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#253 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#254 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#192 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#193 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#194 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#195 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#196 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#198 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#199 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#201 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#202 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#203 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#204 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#207 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#208 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#209 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#210 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#211 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#212 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#213 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#214 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#215 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#216 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#217 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#218 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#220 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#221 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#222 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#223 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#224 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#225 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#226 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#227 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#228 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#229 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#230 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#231 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#232 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#233 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#234 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#235 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#237 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#238 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#239 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#240 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#242 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#243 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#244 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#245 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#246 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#247 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#248 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#249 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#251 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#252 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#253 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#254 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#192 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#193 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#194 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#195 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#196 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#198 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#199 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#201 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#202 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#203 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#204 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#207 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#208 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#209 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#210 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#211 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#212 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#213 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#214 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#215 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#216 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#217 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#218 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#220 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#221 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#222 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#223 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#224 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#225 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#226 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#227 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#228 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#229 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#230 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#231 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#232 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#233 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#234 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#235 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#237 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#238 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#239 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#240 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#242 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#243 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#244 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#245 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#246 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#247 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#248 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#249 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 Sense Key : Not Ready [current] 
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 Add. Sense: Medium not present - tray closed
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 CDB: Read(10) 28 00 00 00 00 06 00 00 02 00
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#251 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#252 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#253 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#254 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#192 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#193 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#194 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#195 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#196 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#198 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#199 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#201 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#202 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#203 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#204 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#207 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#208 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#209 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#210 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#211 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#212 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#213 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#214 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#215 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#216 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#217 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#218 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 Sense Key : Not Ready [current] 
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 Add. Sense: Medium not present - tray closed
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 CDB: Read(10) 28 00 00 00 00 0e 00 00 02 00
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#220 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#221 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#222 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#223 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#224 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#225 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#226 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#227 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#228 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#229 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#230 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#231 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#232 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#233 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#234 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#235 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#237 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#238 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#239 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#240 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#242 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#243 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#244 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#245 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#246 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#247 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#248 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#249 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#251 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#252 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#253 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#254 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#192 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#193 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#194 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#195 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#196 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#198 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#199 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#201 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#202 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#203 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#204 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#207 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#208 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#209 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#210 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#211 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#212 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#213 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#214 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#215 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#216 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#217 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#218 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#220 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#221 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#222 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#223 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#224 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#225 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#226 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#227 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#228 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#229 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#230 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#231 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#232 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#233 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#234 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#235 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#237 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#238 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#239 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#240 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#242 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#243 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#244 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#245 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#246 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#247 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#248 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#249 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#251 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#252 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#253 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#254 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#192 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#193 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#194 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#195 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#196 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#198 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#199 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#201 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#202 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#203 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#204 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#207 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#208 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#209 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#210 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#211 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#212 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#213 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#214 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#215 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#216 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#217 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#218 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#220 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#221 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#222 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#223 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#224 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#225 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#226 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#227 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#228 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#229 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#230 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#231 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#232 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#233 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#234 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#235 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#237 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#238 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#239 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#240 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#242 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#243 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#244 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#245 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#246 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#247 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#248 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#249 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#251 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#252 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#253 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#254 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#192 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#193 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#194 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#195 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#196 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#198 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#199 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#201 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#202 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#203 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#204 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#207 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#208 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#209 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#210 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#211 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#212 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#213 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#214 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#215 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#216 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#217 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#218 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#220 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#221 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#222 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#223 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#224 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#225 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#226 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#227 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#228 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#229 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#230 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#231 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#232 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#233 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#234 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#235 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#237 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#238 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#239 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#240 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#242 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#243 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#244 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#245 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#246 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#247 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#248 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#249 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#251 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#252 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#253 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#254 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#192 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#193 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#194 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#195 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#196 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#198 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#199 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#201 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#202 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#203 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#204 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#207 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#208 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#209 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#210 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#211 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#212 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#213 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#214 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#215 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#216 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#217 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#218 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#220 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#221 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#222 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#223 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#224 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#225 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#226 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#227 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#228 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#229 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#230 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#231 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#232 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#233 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#234 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#235 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 Sense Key : Not Ready [current] 
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 Add. Sense: Medium not present - tray closed
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 CDB: Read(10) 28 00 00 00 00 02 00 00 02 00
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#237 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#238 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#239 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#240 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#242 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#243 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#244 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#245 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#246 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#247 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#248 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#249 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#251 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#252 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#253 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#254 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#192 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#193 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#194 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#195 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#196 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#198 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#199 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#201 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#202 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#203 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#204 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#207 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#208 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#209 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#210 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#211 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#212 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#213 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#214 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#215 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#216 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#217 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#218 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#220 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#221 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#222 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#223 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#224 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#225 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#226 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#227 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#228 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#229 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#230 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#231 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#232 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#233 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#234 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#235 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#237 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#238 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#239 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#240 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#242 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#243 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#244 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#245 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#246 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#247 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#248 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#249 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#251 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#252 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#253 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#254 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#192 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#193 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#194 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#195 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#196 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#198 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#199 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#201 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#202 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#203 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#204 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 Sense Key : Not Ready [current] 
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 Add. Sense: Medium not present - tray closed
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 CDB: Read(10) 28 00 00 00 04 00 00 00 02 00
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#207 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#208 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#209 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#210 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#211 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#212 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#213 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#214 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#215 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#216 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#217 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#218 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#220 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#221 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#222 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#223 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#224 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#225 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#226 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#227 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#228 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#229 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#230 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#231 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#232 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#233 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#234 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#235 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#237 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#238 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#239 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#240 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#242 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#243 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#244 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#245 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#246 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#247 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#248 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#249 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#251 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#252 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#253 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#254 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#192 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#193 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#194 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#195 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#196 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#198 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#199 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#201 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#202 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#203 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#204 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#207 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#208 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#209 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#210 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#211 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#212 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#213 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#214 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#215 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#216 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#217 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#218 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#220 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#221 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#222 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#223 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#224 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#225 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#226 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#227 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#228 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#229 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#230 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#231 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#232 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#233 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#234 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#235 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#237 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#238 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#239 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#240 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#242 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#243 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#244 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#245 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#246 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#247 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#248 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#249 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#251 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#252 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#253 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#254 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#192 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#193 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#194 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#195 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#196 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#198 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#199 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#201 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#202 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#203 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#204 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#207 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#208 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#209 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#210 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#211 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#212 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#213 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#214 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#215 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#216 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#217 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#218 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#220 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#221 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#222 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#223 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#224 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#225 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#226 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#227 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#228 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#229 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#230 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#231 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#232 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#233 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#234 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#235 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#236 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#237 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#238 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#239 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#240 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#241 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#242 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#243 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#244 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#245 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#246 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#247 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#248 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#249 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#250 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#251 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#252 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#253 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#254 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#255 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#192 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#193 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#194 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#195 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#196 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#197 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#198 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#199 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#200 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#201 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#202 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#203 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#204 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#205 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#206 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#207 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#208 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#209 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#210 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#211 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#212 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#213 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#214 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#215 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#216 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#217 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#218 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#219 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#220 unaligned transfer
May 30 05:04:29 hyperv kernel: sr 0:0:0:1: [sr0] tag#221 unaligned transfer
May 30 05:04:29 hyperv kernel: EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
May 30 05:04:29 hyperv systemd[1]: systemd 248.3-2-arch running in system mode. (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
May 30 05:04:29 hyperv systemd[1]: Detected virtualization microsoft.
May 30 05:04:29 hyperv systemd[1]: Detected architecture x86-64.
May 30 05:04:29 hyperv systemd[1]: Hostname set to <hyperv>.
May 30 05:04:29 hyperv systemd-fstab-generator[253]: Mount point  is not a valid path, ignoring.
May 30 05:04:29 hyperv systemd-fstab-generator[253]: Mount point  is not a valid path, ignoring.
May 30 05:04:29 hyperv kernel: random: lvmconfig: uninitialized urandom read (4 bytes read)
May 30 05:04:29 hyperv systemd[1]: Queued start job for default target Graphical Interface.
May 30 05:04:29 hyperv systemd[1]: Created slice system-getty.slice.
May 30 05:04:29 hyperv systemd[1]: Created slice system-modprobe.slice.
May 30 05:04:29 hyperv systemd[1]: Created slice system-systemd\x2dfsck.slice.
May 30 05:04:29 hyperv systemd[1]: Created slice User and Session Slice.
May 30 05:04:29 hyperv systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
May 30 05:04:29 hyperv systemd[1]: Started Forward Password Requests to Wall Directory Watch.
May 30 05:04:29 hyperv systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
May 30 05:04:29 hyperv systemd[1]: Reached target Local Encrypted Volumes.
May 30 05:04:29 hyperv systemd[1]: Reached target Login Prompts.
May 30 05:04:29 hyperv systemd[1]: Reached target Paths.
May 30 05:04:29 hyperv systemd[1]: Reached target Remote File Systems.
May 30 05:04:29 hyperv systemd[1]: Reached target Slices.
May 30 05:04:29 hyperv systemd[1]: Reached target Swap.
May 30 05:04:29 hyperv systemd[1]: Reached target Local Verity Integrity Protected Volumes.
May 30 05:04:29 hyperv systemd[1]: Listening on Device-mapper event daemon FIFOs.
May 30 05:04:29 hyperv systemd[1]: Listening on LVM2 poll daemon socket.
May 30 05:04:29 hyperv systemd[1]: Listening on Process Core Dump Socket.
May 30 05:04:29 hyperv systemd[1]: Listening on Journal Audit Socket.
May 30 05:04:29 hyperv systemd[1]: Listening on Journal Socket (/dev/log).
May 30 05:04:29 hyperv systemd[1]: Listening on Journal Socket.
May 30 05:04:29 hyperv systemd[1]: Listening on Network Service Netlink Socket.
May 30 05:04:29 hyperv systemd[1]: Listening on udev Control Socket.
May 30 05:04:29 hyperv systemd[1]: Listening on udev Kernel Socket.
May 30 05:04:29 hyperv systemd[1]: Mounting Huge Pages File System...
May 30 05:04:29 hyperv systemd[1]: Mounting POSIX Message Queue File System...
May 30 05:04:29 hyperv systemd[1]: Mounting Kernel Debug File System...
May 30 05:04:29 hyperv systemd[1]: Mounting Kernel Trace File System...
May 30 05:04:29 hyperv systemd[1]: Starting Create list of static device nodes for the current kernel...
May 30 05:04:29 hyperv systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
May 30 05:04:29 hyperv systemd[1]: Starting Load Kernel Module configfs...
May 30 05:04:29 hyperv kernel: random: lvm: uninitialized urandom read (4 bytes read)
May 30 05:04:29 hyperv systemd[1]: Starting Load Kernel Module drm...
May 30 05:04:29 hyperv systemd[1]: Starting Load Kernel Module fuse...
May 30 05:04:29 hyperv systemd[1]: Starting Set Up Additional Binary Formats...
May 30 05:04:29 hyperv systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
May 30 05:04:29 hyperv systemd[1]: Starting Journal Service...
May 30 05:04:29 hyperv systemd[1]: Starting Load Kernel Modules...
May 30 05:04:29 hyperv systemd[1]: Starting Remount Root and Kernel File Systems...
May 30 05:04:29 hyperv systemd[1]: Condition check resulted in Repartition Root Disk being skipped.
May 30 05:04:29 hyperv systemd[1]: Starting Coldplug All udev Devices...
May 30 05:04:29 hyperv systemd[1]: Mounted Huge Pages File System.
May 30 05:04:29 hyperv systemd[1]: Mounted POSIX Message Queue File System.
May 30 05:04:29 hyperv systemd[1]: Mounted Kernel Debug File System.
May 30 05:04:29 hyperv kernel: EXT4-fs (sda2): re-mounted. Opts: (null). Quota mode: none.
May 30 05:04:29 hyperv systemd[1]: Mounted Kernel Trace File System.
May 30 05:04:29 hyperv systemd[1]: Finished Create list of static device nodes for the current kernel.
May 30 05:04:29 hyperv kernel: audit: type=1130 audit(1622376269.029:2): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 05:04:29 hyperv systemd[1]: modprobe@configfs.service: Deactivated successfully.
May 30 05:04:29 hyperv systemd[1]: Finished Load Kernel Module configfs.
May 30 05:04:29 hyperv kernel: fuse: init (API version 7.33)
May 30 05:04:29 hyperv kernel: audit: type=1130 audit(1622376269.029:3): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@configfs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 05:04:29 hyperv kernel: audit: type=1131 audit(1622376269.029:4): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@configfs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 05:04:29 hyperv systemd[1]: Finished Remount Root and Kernel File Systems.
May 30 05:04:29 hyperv kernel: audit: type=1130 audit(1622376269.029:5): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-remount-fs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 05:04:29 hyperv systemd[1]: modprobe@fuse.service: Deactivated successfully.
May 30 05:04:29 hyperv systemd[1]: Finished Load Kernel Module fuse.
May 30 05:04:29 hyperv kernel: audit: type=1130 audit(1622376269.029:6): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@fuse comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 05:04:29 hyperv kernel: audit: type=1131 audit(1622376269.029:7): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@fuse comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 05:04:29 hyperv systemd[1]: proc-sys-fs-binfmt_misc.automount: Got automount request for /proc/sys/fs/binfmt_misc, triggered by 271 (systemd-binfmt)
May 30 05:04:29 hyperv kernel: Asymmetric key parser 'pkcs8' registered
May 30 05:04:29 hyperv systemd[1]: Mounting Arbitrary Executable File Formats File System...
May 30 05:04:29 hyperv systemd[1]: Mounting FUSE Control File System...
May 30 05:04:29 hyperv systemd[1]: Mounting Kernel Configuration File System...
May 30 05:04:29 hyperv systemd[1]: Condition check resulted in First Boot Wizard being skipped.
May 30 05:04:29 hyperv systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
May 30 05:04:29 hyperv systemd[1]: Starting Load/Save Random Seed...
May 30 05:04:29 hyperv systemd[1]: Starting Create System Users...
May 30 05:04:29 hyperv systemd[1]: Finished Load Kernel Modules.
May 30 05:04:29 hyperv kernel: audit: type=1130 audit(1622376269.036:8): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-modules-load comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 05:04:29 hyperv systemd[1]: Mounted Arbitrary Executable File Formats File System.
May 30 05:04:29 hyperv systemd[1]: Mounted FUSE Control File System.
May 30 05:04:29 hyperv systemd[1]: Mounted Kernel Configuration File System.
May 30 05:04:29 hyperv systemd[1]: Starting Apply Kernel Variables...
May 30 05:04:29 hyperv systemd[1]: Finished Set Up Additional Binary Formats.
May 30 05:04:29 hyperv kernel: audit: type=1130 audit(1622376269.039:9): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-binfmt comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 05:04:29 hyperv systemd[1]: Finished Apply Kernel Variables.
May 30 05:04:29 hyperv kernel: audit: type=1130 audit(1622376269.043:10): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 05:04:29 hyperv systemd[1]: modprobe@drm.service: Deactivated successfully.
May 30 05:04:29 hyperv systemd[1]: Finished Load Kernel Module drm.
May 30 05:04:29 hyperv systemd[1]: Finished Create System Users.
May 30 05:04:29 hyperv systemd[1]: Starting Create Static Device Nodes in /dev...
May 30 05:04:29 hyperv systemd[1]: Finished Coldplug All udev Devices.
May 30 05:04:29 hyperv systemd[1]: Finished Create Static Device Nodes in /dev.
May 30 05:04:29 hyperv systemd[1]: Starting Rule-based Manager for Device Events and Files...
May 30 05:04:29 hyperv systemd[1]: Started Journal Service.
May 30 12:04:29 hyperv kernel: input: PC Speaker as /devices/platform/pcspkr/input/input2
May 30 12:04:29 hyperv kernel: mousedev: PS/2 mouse device common for all mice
May 30 12:04:29 hyperv kernel: hv_vmbus: registering driver hv_balloon
May 30 12:04:29 hyperv kernel: hv_utils: Registering HyperV Utility Driver
May 30 12:04:29 hyperv kernel: hv_vmbus: registering driver hv_utils
May 30 12:04:29 hyperv kernel: hv_utils: TimeSync IC version 4.0
May 30 12:04:29 hyperv kernel: hv_utils: VSS IC version 5.0
May 30 12:04:29 hyperv kernel: hv_balloon: Using Dynamic Memory protocol version 2.0
May 30 12:04:29 hyperv kernel: hv_utils: Shutdown IC version 3.2
May 30 12:04:29 hyperv kernel: hv_vmbus: registering driver hv_netvsc
May 30 12:04:29 hyperv kernel: hv_vmbus: registering driver hyperv_fb
May 30 12:04:29 hyperv kernel: RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
May 30 12:04:29 hyperv kernel: hyperv_fb: Synthvid Version major 3, minor 5
May 30 12:04:29 hyperv kernel: hyperv_fb: Screen resolution: 1920x1080, Color depth: 32
May 30 12:04:29 hyperv kernel: checking generic (f8000000 300000) vs hw (f8000000 300000)
May 30 12:04:29 hyperv kernel: fb0: switching to hyperv_fb from EFI VGA
May 30 12:04:29 hyperv kernel: Console: switching to colour dummy device 80x25
May 30 12:04:29 hyperv kernel: Console: switching to colour frame buffer device 240x67
May 30 12:04:29 hyperv kernel: cryptd: max_cpu_qlen set to 1000
May 30 12:04:29 hyperv kernel: AVX2 version of gcm_enc/dec engaged.
May 30 12:04:29 hyperv kernel: AES CTR mode by8 optimization enabled
May 30 12:04:29 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 12:04:29 hyperv kernel: IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
May 30 12:04:29 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 12:04:29 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 12:04:29 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 12:04:29 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 12:04:29 hyperv kernel: random: dbus-daemon: uninitialized urandom read (12 bytes read)
May 30 12:04:29 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 12:04:29 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 12:04:29 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 12:04:29 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 12:04:29 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 12:04:29 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 12:04:29 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 12:04:30 hyperv kernel: random: crng init done
May 30 12:04:30 hyperv kernel: random: 1 urandom warning(s) missed due to ratelimiting
May 30 12:04:30 hyperv kernel: hv_utils: Heartbeat IC version 3.0
May 30 12:05:16 hyperv kernel: hv_balloon: Max. dynamic memory size: 1048576 MB
May 30 12:05:19 hyperv kernel: hv_utils: Shutdown request received - graceful shutdown initiated
May 30 12:05:19 hyperv kernel: kauditd_printk_skb: 47 callbacks suppressed
May 30 12:05:19 hyperv kernel: audit: type=1131 audit(1622401519.101:54): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-random-seed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 12:05:19 hyperv kernel: audit: type=1131 audit(1622401519.121:55): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user@974 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 12:05:19 hyperv kernel: audit: type=1131 audit(1622401519.124:56): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user-runtime-dir@974 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 12:05:19 hyperv kernel: audit: type=1131 audit(1622401519.141:57): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dbus comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 12:05:19 hyperv kernel: audit: type=1130 audit(1622401519.161:58): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=mkinitcpio-generate-shutdown-ramfs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 12:05:19 hyperv kernel: audit: type=1131 audit(1622401519.161:59): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=mkinitcpio-generate-shutdown-ramfs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 12:05:19 hyperv kernel: audit: type=1131 audit(1622401519.228:60): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=sddm comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 12:05:19 hyperv kernel: audit: type=1131 audit(1622401519.231:61): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-user-sessions comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 12:05:19 hyperv kernel: audit: type=1131 audit(1622401519.258:62): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-resolved comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 12:05:19 hyperv kernel: audit: type=1131 audit(1622401519.278:63): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-logind comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 12:05:19 hyperv systemd-shutdown[1]: Syncing filesystems and block devices.
May 30 12:05:19 hyperv systemd-shutdown[1]: Sending SIGTERM to remaining processes...
--HCm/Mw5iFU7pz+1x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ccf953d8f3d68-v5.13-rc3.log"

May 30 04:49:12 hyperv kernel: Linux version 5.13.0-rc3-mainline (nathan@hyperv) (gcc (GCC) 11.1.0, GNU ld (GNU Binutils) 2.36.1) #1 SMP PREEMPT Sun May 30 11:45:07 MST 2021
May 30 04:49:12 hyperv kernel: Command line: initrd=\initramfs-linux-mainline.img root=PARTUUID=33da17a0-bae7-4ff2-97c5-b77426576af6 rw intel_pstate=no_hwp video=hyperv_fb:1920x1080
May 30 04:49:12 hyperv kernel: x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
May 30 04:49:12 hyperv kernel: x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
May 30 04:49:12 hyperv kernel: x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
May 30 04:49:12 hyperv kernel: x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
May 30 04:49:12 hyperv kernel: x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
May 30 04:49:12 hyperv kernel: BIOS-provided physical RAM map:
May 30 04:49:12 hyperv kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
May 30 04:49:12 hyperv kernel: BIOS-e820: [mem 0x00000000000c0000-0x00000000000fffff] reserved
May 30 04:49:12 hyperv kernel: BIOS-e820: [mem 0x0000000000100000-0x000000007fff1fff] usable
May 30 04:49:12 hyperv kernel: BIOS-e820: [mem 0x000000007fff2000-0x000000007fff2fff] reserved
May 30 04:49:12 hyperv kernel: BIOS-e820: [mem 0x000000007fff3000-0x00000000f6d93fff] usable
May 30 04:49:12 hyperv kernel: BIOS-e820: [mem 0x00000000f6d94000-0x00000000f6d94fff] ACPI data
May 30 04:49:12 hyperv kernel: BIOS-e820: [mem 0x00000000f6d95000-0x00000000f6ecbfff] usable
May 30 04:49:12 hyperv kernel: BIOS-e820: [mem 0x00000000f6ecc000-0x00000000f6eeafff] ACPI data
May 30 04:49:12 hyperv kernel: BIOS-e820: [mem 0x00000000f6eeb000-0x00000000f6f1afff] reserved
May 30 04:49:12 hyperv kernel: BIOS-e820: [mem 0x00000000f6f1b000-0x00000000f7f9afff] usable
May 30 04:49:12 hyperv kernel: BIOS-e820: [mem 0x00000000f7f9b000-0x00000000f7ff2fff] reserved
May 30 04:49:12 hyperv kernel: BIOS-e820: [mem 0x00000000f7ff3000-0x00000000f7ffafff] ACPI data
May 30 04:49:12 hyperv kernel: BIOS-e820: [mem 0x00000000f7ffb000-0x00000000f7ffefff] ACPI NVS
May 30 04:49:12 hyperv kernel: BIOS-e820: [mem 0x00000000f7fff000-0x00000000f7ffffff] usable
May 30 04:49:12 hyperv kernel: BIOS-e820: [mem 0x0000000100000000-0x0000000107ffffff] usable
May 30 04:49:12 hyperv kernel: intel_pstate: HWP disabled
May 30 04:49:12 hyperv kernel: NX (Execute Disable) protection: active
May 30 04:49:12 hyperv kernel: efi: EFI v2.70 by Microsoft
May 30 04:49:12 hyperv kernel: efi: ACPI=0xf7ffa000 ACPI 2.0=0xf7ffa014 SMBIOS=0xf7fd8000 SMBIOS 3.0=0xf7fd6000 MEMATTR=0xf7329698 RNG=0xf7fda818 
May 30 04:49:12 hyperv kernel: efi: seeding entropy pool
May 30 04:49:12 hyperv kernel: SMBIOS 3.1.0 present.
May 30 04:49:12 hyperv kernel: DMI: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.0 11/01/2019
May 30 04:49:12 hyperv kernel: Hypervisor detected: Microsoft Hyper-V
May 30 04:49:12 hyperv kernel: Hyper-V: privilege flags low 0x2e7f, high 0x3b8030, hints 0xc2c, misc 0xbed7b2
May 30 04:49:12 hyperv kernel: Hyper-V Host Build:19041-10.0-1-0.1023
May 30 04:49:12 hyperv kernel: Hyper-V: LAPIC Timer Frequency: 0xa2c2a
May 30 04:49:12 hyperv kernel: tsc: Marking TSC unstable due to running on Hyper-V
May 30 04:49:12 hyperv kernel: Hyper-V: Using hypercall for remote TLB flush
May 30 04:49:12 hyperv kernel: clocksource: hyperv_clocksource_tsc_page: mask: 0xffffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
May 30 04:49:12 hyperv kernel: tsc: Detected 3800.005 MHz processor
May 30 04:49:12 hyperv kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
May 30 04:49:12 hyperv kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
May 30 04:49:12 hyperv kernel: last_pfn = 0x108000 max_arch_pfn = 0x400000000
May 30 04:49:12 hyperv kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
May 30 04:49:12 hyperv kernel: last_pfn = 0xf8000 max_arch_pfn = 0x400000000
May 30 04:49:12 hyperv kernel: Using GB pages for direct mapping
May 30 04:49:12 hyperv kernel: Secure boot disabled
May 30 04:49:12 hyperv kernel: RAMDISK: [mem 0x7f872000-0x7fff1fff]
May 30 04:49:12 hyperv kernel: ACPI: Early table checksum verification disabled
May 30 04:49:12 hyperv kernel: ACPI: RSDP 0x00000000F7FFA014 000024 (v02 VRTUAL)
May 30 04:49:12 hyperv kernel: ACPI: XSDT 0x00000000F7FF90E8 00005C (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
May 30 04:49:12 hyperv kernel: ACPI: FACP 0x00000000F7FF8000 000114 (v06 VRTUAL MICROSFT 00000001 MSFT 00000001)
May 30 04:49:12 hyperv kernel: ACPI: DSDT 0x00000000F6ECC000 01E184 (v02 MSFTVM DSDT01   00000001 MSFT 05000000)
May 30 04:49:12 hyperv kernel: ACPI: FACS 0x00000000F7FFE000 000040
May 30 04:49:12 hyperv kernel: ACPI: OEM0 0x00000000F7FF7000 000064 (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
May 30 04:49:12 hyperv kernel: ACPI: WAET 0x00000000F7FF6000 000028 (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
May 30 04:49:12 hyperv kernel: ACPI: APIC 0x00000000F7FF5000 0000A8 (v04 VRTUAL MICROSFT 00000001 MSFT 00000001)
May 30 04:49:12 hyperv kernel: ACPI: SRAT 0x00000000F7FF4000 000230 (v02 VRTUAL MICROSFT 00000001 MSFT 00000001)
May 30 04:49:12 hyperv kernel: ACPI: BGRT 0x00000000F7FF3000 000038 (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
May 30 04:49:12 hyperv kernel: ACPI: FPDT 0x00000000F6D94000 000034 (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
May 30 04:49:12 hyperv kernel: ACPI: Reserving FACP table memory at [mem 0xf7ff8000-0xf7ff8113]
May 30 04:49:12 hyperv kernel: ACPI: Reserving DSDT table memory at [mem 0xf6ecc000-0xf6eea183]
May 30 04:49:12 hyperv kernel: ACPI: Reserving FACS table memory at [mem 0xf7ffe000-0xf7ffe03f]
May 30 04:49:12 hyperv kernel: ACPI: Reserving OEM0 table memory at [mem 0xf7ff7000-0xf7ff7063]
May 30 04:49:12 hyperv kernel: ACPI: Reserving WAET table memory at [mem 0xf7ff6000-0xf7ff6027]
May 30 04:49:12 hyperv kernel: ACPI: Reserving APIC table memory at [mem 0xf7ff5000-0xf7ff50a7]
May 30 04:49:12 hyperv kernel: ACPI: Reserving SRAT table memory at [mem 0xf7ff4000-0xf7ff422f]
May 30 04:49:12 hyperv kernel: ACPI: Reserving BGRT table memory at [mem 0xf7ff3000-0xf7ff3037]
May 30 04:49:12 hyperv kernel: ACPI: Reserving FPDT table memory at [mem 0xf6d94000-0xf6d94033]
May 30 04:49:12 hyperv kernel: ACPI: Local APIC address 0xfee00000
May 30 04:49:12 hyperv kernel: SRAT: PXM 0 -> APIC 0x00 -> Node 0
May 30 04:49:12 hyperv kernel: SRAT: PXM 0 -> APIC 0x01 -> Node 0
May 30 04:49:12 hyperv kernel: SRAT: PXM 0 -> APIC 0x02 -> Node 0
May 30 04:49:12 hyperv kernel: SRAT: PXM 0 -> APIC 0x03 -> Node 0
May 30 04:49:12 hyperv kernel: SRAT: PXM 0 -> APIC 0x04 -> Node 0
May 30 04:49:12 hyperv kernel: SRAT: PXM 0 -> APIC 0x05 -> Node 0
May 30 04:49:12 hyperv kernel: SRAT: PXM 0 -> APIC 0x06 -> Node 0
May 30 04:49:12 hyperv kernel: SRAT: PXM 0 -> APIC 0x07 -> Node 0
May 30 04:49:12 hyperv kernel: SRAT: PXM 0 -> APIC 0x08 -> Node 0
May 30 04:49:12 hyperv kernel: SRAT: PXM 0 -> APIC 0x09 -> Node 0
May 30 04:49:12 hyperv kernel: SRAT: PXM 0 -> APIC 0x0a -> Node 0
May 30 04:49:12 hyperv kernel: SRAT: PXM 0 -> APIC 0x0b -> Node 0
May 30 04:49:12 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0xf7ffffff] hotplug
May 30 04:49:12 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x107ffffff] hotplug
May 30 04:49:12 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x108000000-0xfdfffffff] hotplug
May 30 04:49:12 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x1000000000-0xfcffffffff] hotplug
May 30 04:49:12 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x10000000000-0x1ffffffffff] hotplug
May 30 04:49:12 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x20000000000-0x3ffffffffff] hotplug
May 30 04:49:12 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x40000000000-0x7ffffffffff] hotplug
May 30 04:49:12 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000000-0xfffffffffff] hotplug
May 30 04:49:12 hyperv kernel: NUMA: Node 0 [mem 0x00000000-0xf7ffffff] + [mem 0x100000000-0x107ffffff] -> [mem 0x00000000-0x107ffffff]
May 30 04:49:12 hyperv kernel: NODE_DATA(0) allocated [mem 0x107ffc000-0x107ffffff]
May 30 04:49:12 hyperv kernel: Zone ranges:
May 30 04:49:12 hyperv kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
May 30 04:49:12 hyperv kernel:   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
May 30 04:49:12 hyperv kernel:   Normal   [mem 0x0000000100000000-0x0000000107ffffff]
May 30 04:49:12 hyperv kernel:   Device   empty
May 30 04:49:12 hyperv kernel: Movable zone start for each node
May 30 04:49:12 hyperv kernel: Early memory node ranges
May 30 04:49:12 hyperv kernel:   node   0: [mem 0x0000000000001000-0x000000000009ffff]
May 30 04:49:12 hyperv kernel:   node   0: [mem 0x0000000000100000-0x000000007fff1fff]
May 30 04:49:12 hyperv kernel:   node   0: [mem 0x000000007fff3000-0x00000000f6d93fff]
May 30 04:49:12 hyperv kernel:   node   0: [mem 0x00000000f6d95000-0x00000000f6ecbfff]
May 30 04:49:12 hyperv kernel:   node   0: [mem 0x00000000f6f1b000-0x00000000f7f9afff]
May 30 04:49:12 hyperv kernel:   node   0: [mem 0x00000000f7fff000-0x00000000f7ffffff]
May 30 04:49:12 hyperv kernel:   node   0: [mem 0x0000000100000000-0x0000000107ffffff]
May 30 04:49:12 hyperv kernel: Initmem setup node 0 [mem 0x0000000000001000-0x0000000107ffffff]
May 30 04:49:12 hyperv kernel: On node 0 totalpages: 1048298
May 30 04:49:12 hyperv kernel:   DMA zone: 64 pages used for memmap
May 30 04:49:12 hyperv kernel:   DMA zone: 1344 pages reserved
May 30 04:49:12 hyperv kernel:   DMA zone: 3999 pages, LIFO batch:0
May 30 04:49:12 hyperv kernel:   DMA zone: 28769 pages in unavailable ranges
May 30 04:49:12 hyperv kernel:   DMA32 zone: 16320 pages used for memmap
May 30 04:49:12 hyperv kernel:   DMA32 zone: 1011531 pages, LIFO batch:63
May 30 04:49:12 hyperv kernel:   DMA32 zone: 181 pages in unavailable ranges
May 30 04:49:12 hyperv kernel:   Normal zone: 512 pages used for memmap
May 30 04:49:12 hyperv kernel:   Normal zone: 32768 pages, LIFO batch:7
May 30 04:49:12 hyperv kernel: ACPI: PM-Timer IO Port: 0x408
May 30 04:49:12 hyperv kernel: ACPI: Local APIC address 0xfee00000
May 30 04:49:12 hyperv kernel: ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
May 30 04:49:12 hyperv kernel: IOAPIC[0]: apic_id 12, version 17, address 0xfec00000, GSI 0-23
May 30 04:49:12 hyperv kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
May 30 04:49:12 hyperv kernel: ACPI: IRQ9 used by override.
May 30 04:49:12 hyperv kernel: Using ACPI (MADT) for SMP configuration information
May 30 04:49:12 hyperv kernel: e820: update [mem 0xf7354000-0xf735afff] usable ==> reserved
May 30 04:49:12 hyperv kernel: smpboot: Allowing 12 CPUs, 0 hotplug CPUs
May 30 04:49:12 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
May 30 04:49:12 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000bffff]
May 30 04:49:12 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x000c0000-0x000fffff]
May 30 04:49:12 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x7fff2000-0x7fff2fff]
May 30 04:49:12 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0xf6d94000-0xf6d94fff]
May 30 04:49:12 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0xf6ecc000-0xf6eeafff]
May 30 04:49:12 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0xf6eeb000-0xf6f1afff]
May 30 04:49:12 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0xf7354000-0xf735afff]
May 30 04:49:12 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0xf7f9b000-0xf7ff2fff]
May 30 04:49:12 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0xf7ff3000-0xf7ffafff]
May 30 04:49:12 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0xf7ffb000-0xf7ffefff]
May 30 04:49:12 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xffffffff]
May 30 04:49:12 hyperv kernel: [mem 0xf8000000-0xffffffff] available for PCI devices
May 30 04:49:12 hyperv kernel: Booting paravirtualized kernel on Hyper-V
May 30 04:49:12 hyperv kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
May 30 04:49:12 hyperv kernel: setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:12 nr_node_ids:1
May 30 04:49:12 hyperv kernel: percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u262144
May 30 04:49:12 hyperv kernel: pcpu-alloc: s192512 r8192 d28672 u262144 alloc=1*2097152
May 30 04:49:12 hyperv kernel: pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 -- -- -- -- 
May 30 04:49:12 hyperv kernel: Hyper-V: PV spinlocks enabled
May 30 04:49:12 hyperv kernel: PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
May 30 04:49:12 hyperv kernel: Built 1 zonelists, mobility grouping on.  Total pages: 1030058
May 30 04:49:12 hyperv kernel: Policy zone: Normal
May 30 04:49:12 hyperv kernel: Kernel command line: initrd=\initramfs-linux-mainline.img root=PARTUUID=33da17a0-bae7-4ff2-97c5-b77426576af6 rw intel_pstate=no_hwp video=hyperv_fb:1920x1080
May 30 04:49:12 hyperv kernel: Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
May 30 04:49:12 hyperv kernel: Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
May 30 04:49:12 hyperv kernel: mem auto-init: stack:off, heap alloc:on, heap free:off
May 30 04:49:12 hyperv kernel: Memory: 3996888K/4193192K available (14344K kernel code, 2007K rwdata, 4652K rodata, 1760K init, 4336K bss, 196044K reserved, 0K cma-reserved)
May 30 04:49:12 hyperv kernel: random: get_random_u64 called from __kmem_cache_create+0x24/0x550 with crng_init=0
May 30 04:49:12 hyperv kernel: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=12, Nodes=1
May 30 04:49:12 hyperv kernel: ftrace: allocating 41297 entries in 162 pages
May 30 04:49:12 hyperv kernel: ftrace: allocated 162 pages with 3 groups
May 30 04:49:12 hyperv kernel: rcu: Preemptible hierarchical RCU implementation.
May 30 04:49:12 hyperv kernel: rcu:         RCU dyntick-idle grace-period acceleration is enabled.
May 30 04:49:12 hyperv kernel: rcu:         RCU restricting CPUs from NR_CPUS=320 to nr_cpu_ids=12.
May 30 04:49:12 hyperv kernel: rcu:         RCU priority boosting: priority 1 delay 500 ms.
May 30 04:49:12 hyperv kernel:         Trampoline variant of Tasks RCU enabled.
May 30 04:49:12 hyperv kernel:         Rude variant of Tasks RCU enabled.
May 30 04:49:12 hyperv kernel:         Tracing variant of Tasks RCU enabled.
May 30 04:49:12 hyperv kernel: rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
May 30 04:49:12 hyperv kernel: rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=12
May 30 04:49:12 hyperv kernel: Using NULL legacy PIC
May 30 04:49:12 hyperv kernel: NR_IRQS: 20736, nr_irqs: 520, preallocated irqs: 0
May 30 04:49:12 hyperv kernel: Console: colour dummy device 80x25
May 30 04:49:12 hyperv kernel: printk: console [tty0] enabled
May 30 04:49:12 hyperv kernel: ACPI: Core revision 20210331
May 30 04:49:12 hyperv kernel: Failed to register legacy timer interrupt
May 30 04:49:12 hyperv kernel: APIC: Switch to symmetric I/O mode setup
May 30 04:49:12 hyperv kernel: Switched APIC routing to physical flat.
May 30 04:49:12 hyperv kernel: Hyper-V: Using IPI hypercalls
May 30 04:49:12 hyperv kernel: Hyper-V: Using enlightened APIC (xapic mode)
May 30 04:49:12 hyperv kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 7603.67 BogoMIPS (lpj=12666683)
May 30 04:49:12 hyperv kernel: pid_max: default: 32768 minimum: 301
May 30 04:49:12 hyperv kernel: LSM: Security Framework initializing
May 30 04:49:12 hyperv kernel: Yama: becoming mindful.
May 30 04:49:12 hyperv kernel: LSM support for eBPF active
May 30 04:49:12 hyperv kernel: Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
May 30 04:49:12 hyperv kernel: Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
May 30 04:49:12 hyperv kernel: Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
May 30 04:49:12 hyperv kernel: Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
May 30 04:49:12 hyperv kernel: Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
May 30 04:49:12 hyperv kernel: Spectre V2 : Mitigation: Full AMD retpoline
May 30 04:49:12 hyperv kernel: Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
May 30 04:49:12 hyperv kernel: Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
May 30 04:49:12 hyperv kernel: Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
May 30 04:49:12 hyperv kernel: Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
May 30 04:49:12 hyperv kernel: Freeing SMP alternatives memory: 36K
May 30 04:49:12 hyperv kernel: smpboot: CPU0: AMD Ryzen 9 3900X 12-Core Processor (family: 0x17, model: 0x71, stepping: 0x0)
May 30 04:49:12 hyperv kernel: Performance Events: PMU not available due to virtualization, using software events only.
May 30 04:49:12 hyperv kernel: rcu: Hierarchical SRCU implementation.
May 30 04:49:12 hyperv kernel: NMI watchdog: Perf NMI watchdog permanently disabled
May 30 04:49:12 hyperv kernel: smp: Bringing up secondary CPUs ...
May 30 04:49:12 hyperv kernel: x86: Booting SMP configuration:
May 30 04:49:12 hyperv kernel: .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6
May 30 04:49:12 hyperv kernel: random: fast init done
May 30 04:49:12 hyperv kernel:   #7  #8  #9 #10 #11
May 30 04:49:12 hyperv kernel: smp: Brought up 1 node, 12 CPUs
May 30 04:49:12 hyperv kernel: smpboot: Max logical packages: 1
May 30 04:49:12 hyperv kernel: smpboot: Total of 12 processors activated (91329.80 BogoMIPS)
May 30 04:49:12 hyperv kernel: devtmpfs: initialized
May 30 04:49:12 hyperv kernel: x86/mm: Memory block size: 128MB
May 30 04:49:12 hyperv kernel: PM: Registering ACPI NVS region [mem 0xf7ffb000-0xf7ffefff] (16384 bytes)
May 30 04:49:12 hyperv kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
May 30 04:49:12 hyperv kernel: futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
May 30 04:49:12 hyperv kernel: pinctrl core: initialized pinctrl subsystem
May 30 04:49:12 hyperv kernel: PM: RTC time: 11:49:11, date: 2021-05-30
May 30 04:49:12 hyperv kernel: NET: Registered protocol family 16
May 30 04:49:12 hyperv kernel: DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
May 30 04:49:12 hyperv kernel: DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
May 30 04:49:12 hyperv kernel: DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
May 30 04:49:12 hyperv kernel: audit: initializing netlink subsys (disabled)
May 30 04:49:12 hyperv kernel: audit: type=2000 audit(1622375350.916:1): state=initialized audit_enabled=0 res=1
May 30 04:49:12 hyperv kernel: thermal_sys: Registered thermal governor 'fair_share'
May 30 04:49:12 hyperv kernel: thermal_sys: Registered thermal governor 'bang_bang'
May 30 04:49:12 hyperv kernel: thermal_sys: Registered thermal governor 'step_wise'
May 30 04:49:12 hyperv kernel: thermal_sys: Registered thermal governor 'user_space'
May 30 04:49:12 hyperv kernel: thermal_sys: Registered thermal governor 'power_allocator'
May 30 04:49:12 hyperv kernel: cpuidle: using governor ladder
May 30 04:49:12 hyperv kernel: cpuidle: using governor menu
May 30 04:49:12 hyperv kernel: ACPI: bus type PCI registered
May 30 04:49:12 hyperv kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
May 30 04:49:12 hyperv kernel: Kprobes globally optimized
May 30 04:49:12 hyperv kernel: HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
May 30 04:49:12 hyperv kernel: HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
May 30 04:49:12 hyperv kernel: ACPI: Added _OSI(Module Device)
May 30 04:49:12 hyperv kernel: ACPI: Added _OSI(Processor Device)
May 30 04:49:12 hyperv kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
May 30 04:49:12 hyperv kernel: ACPI: Added _OSI(Processor Aggregator Device)
May 30 04:49:12 hyperv kernel: ACPI: Added _OSI(Linux-Dell-Video)
May 30 04:49:12 hyperv kernel: ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
May 30 04:49:12 hyperv kernel: ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
May 30 04:49:12 hyperv kernel: ACPI: 1 ACPI AML tables successfully acquired and loaded
May 30 04:49:12 hyperv kernel: ACPI: Interpreter enabled
May 30 04:49:12 hyperv kernel: ACPI: (supports S0 S5)
May 30 04:49:12 hyperv kernel: ACPI: Using IOAPIC for interrupt routing
May 30 04:49:12 hyperv kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
May 30 04:49:12 hyperv kernel: ACPI: Enabled 1 GPEs in block 00 to 0F
May 30 04:49:12 hyperv kernel: iommu: Default domain type: Translated 
May 30 04:49:12 hyperv kernel: vgaarb: loaded
May 30 04:49:12 hyperv kernel: SCSI subsystem initialized
May 30 04:49:12 hyperv kernel: libata version 3.00 loaded.
May 30 04:49:12 hyperv kernel: ACPI: bus type USB registered
May 30 04:49:12 hyperv kernel: usbcore: registered new interface driver usbfs
May 30 04:49:12 hyperv kernel: usbcore: registered new interface driver hub
May 30 04:49:12 hyperv kernel: usbcore: registered new device driver usb
May 30 04:49:12 hyperv kernel: pps_core: LinuxPPS API ver. 1 registered
May 30 04:49:12 hyperv kernel: pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
May 30 04:49:12 hyperv kernel: PTP clock support registered
May 30 04:49:12 hyperv kernel: EDAC MC: Ver: 3.0.0
May 30 04:49:12 hyperv kernel: Registered efivars operations
May 30 04:49:12 hyperv kernel: NetLabel: Initializing
May 30 04:49:12 hyperv kernel: NetLabel:  domain hash size = 128
May 30 04:49:12 hyperv kernel: NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
May 30 04:49:12 hyperv kernel: NetLabel:  unlabeled traffic allowed by default
May 30 04:49:12 hyperv kernel: PCI: Using ACPI for IRQ routing
May 30 04:49:12 hyperv kernel: PCI: System does not support PCI
May 30 04:49:12 hyperv kernel: clocksource: Switched to clocksource hyperv_clocksource_tsc_page
May 30 04:49:12 hyperv kernel: VFS: Disk quotas dquot_6.6.0
May 30 04:49:12 hyperv kernel: VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
May 30 04:49:12 hyperv kernel: pnp: PnP ACPI init
May 30 04:49:12 hyperv kernel: pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
May 30 04:49:12 hyperv kernel: pnp: PnP ACPI: found 1 devices
May 30 04:49:12 hyperv kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
May 30 04:49:12 hyperv kernel: NET: Registered protocol family 2
May 30 04:49:12 hyperv kernel: IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
May 30 04:49:12 hyperv kernel: tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
May 30 04:49:12 hyperv kernel: TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
May 30 04:49:12 hyperv kernel: TCP bind hash table entries: 32768 (order: 7, 524288 bytes, linear)
May 30 04:49:12 hyperv kernel: TCP: Hash tables configured (established 32768 bind 32768)
May 30 04:49:12 hyperv kernel: MPTCP token hash table entries: 4096 (order: 4, 98304 bytes, linear)
May 30 04:49:12 hyperv kernel: UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
May 30 04:49:12 hyperv kernel: UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, linear)
May 30 04:49:12 hyperv kernel: NET: Registered protocol family 1
May 30 04:49:12 hyperv kernel: NET: Registered protocol family 44
May 30 04:49:12 hyperv kernel: PCI: CLS 0 bytes, default 64
May 30 04:49:12 hyperv kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
May 30 04:49:12 hyperv kernel: software IO TLB: mapped [mem 0x00000000f2d73000-0x00000000f6d73000] (64MB)
May 30 04:49:12 hyperv kernel: Unpacking initramfs...
May 30 04:49:12 hyperv kernel: Initialise system trusted keyrings
May 30 04:49:12 hyperv kernel: Key type blacklist registered
May 30 04:49:12 hyperv kernel: workingset: timestamp_bits=41 max_order=20 bucket_order=0
May 30 04:49:12 hyperv kernel: zbud: loaded
May 30 04:49:12 hyperv kernel: Key type asymmetric registered
May 30 04:49:12 hyperv kernel: Asymmetric key parser 'x509' registered
May 30 04:49:12 hyperv kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
May 30 04:49:12 hyperv kernel: io scheduler mq-deadline registered
May 30 04:49:12 hyperv kernel: io scheduler kyber registered
May 30 04:49:12 hyperv kernel: io scheduler bfq registered
May 30 04:49:12 hyperv kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
May 30 04:49:12 hyperv kernel: efifb: probing for efifb
May 30 04:49:12 hyperv kernel: efifb: framebuffer at 0xf8000000, using 3072k, total 3072k
May 30 04:49:12 hyperv kernel: efifb: mode is 1024x768x32, linelength=4096, pages=1
May 30 04:49:12 hyperv kernel: efifb: scrolling: redraw
May 30 04:49:12 hyperv kernel: efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
May 30 04:49:12 hyperv kernel: fbcon: Deferring console take-over
May 30 04:49:12 hyperv kernel: fb0: EFI VGA frame buffer device
May 30 04:49:12 hyperv kernel: Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
May 30 04:49:12 hyperv kernel: Non-volatile memory driver v1.3
May 30 04:49:12 hyperv kernel: AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
May 30 04:49:12 hyperv kernel: AMD-Vi: AMD IOMMUv2 functionality not available on this system
May 30 04:49:12 hyperv kernel: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
May 30 04:49:12 hyperv kernel: ehci-pci: EHCI PCI platform driver
May 30 04:49:12 hyperv kernel: ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
May 30 04:49:12 hyperv kernel: ohci-pci: OHCI PCI platform driver
May 30 04:49:12 hyperv kernel: uhci_hcd: USB Universal Host Controller Interface driver
May 30 04:49:12 hyperv kernel: usbcore: registered new interface driver usbserial_generic
May 30 04:49:12 hyperv kernel: usbserial: USB Serial support registered for generic
May 30 04:49:12 hyperv kernel: rtc_cmos 00:00: RTC can wake from S4
May 30 04:49:12 hyperv kernel: rtc_cmos 00:00: registered as rtc0
May 30 04:49:12 hyperv kernel: rtc_cmos 00:00: setting system clock to 2021-05-30T11:49:11 UTC (1622375351)
May 30 04:49:12 hyperv kernel: rtc_cmos 00:00: alarms up to one month, 114 bytes nvram
May 30 04:49:12 hyperv kernel: ledtrig-cpu: registered to indicate activity on CPUs
May 30 04:49:12 hyperv kernel: hid: raw HID events driver (C) Jiri Kosina
May 30 04:49:12 hyperv kernel: drop_monitor: Initializing network drop monitor service
May 30 04:49:12 hyperv kernel: Initializing XFRM netlink socket
May 30 04:49:12 hyperv kernel: NET: Registered protocol family 10
May 30 04:49:12 hyperv kernel: Freeing initrd memory: 7680K
May 30 04:49:12 hyperv kernel: Segment Routing with IPv6
May 30 04:49:12 hyperv kernel: RPL Segment Routing with IPv6
May 30 04:49:12 hyperv kernel: NET: Registered protocol family 17
May 30 04:49:12 hyperv kernel: IPI shorthand broadcast: enabled
May 30 04:49:12 hyperv kernel: registered taskstats version 1
May 30 04:49:12 hyperv kernel: Loading compiled-in X.509 certificates
May 30 04:49:12 hyperv kernel: Loaded X.509 cert 'Build time autogenerated kernel key: e1be59798ca9b410093c31a0ea7c3aeb237830fd'
May 30 04:49:12 hyperv kernel: zswap: loaded using pool lz4/z3fold
May 30 04:49:12 hyperv kernel: Key type ._fscrypt registered
May 30 04:49:12 hyperv kernel: Key type .fscrypt registered
May 30 04:49:12 hyperv kernel: Key type fscrypt-provisioning registered
May 30 04:49:12 hyperv kernel: PM:   Magic number: 5:203:834
May 30 04:49:12 hyperv kernel: RAS: Correctable Errors collector initialized.
May 30 04:49:12 hyperv kernel: Unstable clock detected, switching default tracing clock to "global"
                               If you want to keep using the local clock, then add:
                                 "trace_clock=local"
                               on the kernel command line
May 30 04:49:12 hyperv kernel: Freeing unused decrypted memory: 2036K
May 30 04:49:12 hyperv kernel: Freeing unused kernel image (initmem) memory: 1760K
May 30 04:49:12 hyperv kernel: Write protecting the kernel read-only data: 22528k
May 30 04:49:12 hyperv kernel: Freeing unused kernel image (text/rodata gap) memory: 2036K
May 30 04:49:12 hyperv kernel: Freeing unused kernel image (rodata/data gap) memory: 1492K
May 30 04:49:12 hyperv kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
May 30 04:49:12 hyperv kernel: rodata_test: all tests were successful
May 30 04:49:12 hyperv kernel: Run /init as init process
May 30 04:49:12 hyperv kernel:   with arguments:
May 30 04:49:12 hyperv kernel:     /init
May 30 04:49:12 hyperv kernel:   with environment:
May 30 04:49:12 hyperv kernel:     HOME=/
May 30 04:49:12 hyperv kernel:     TERM=linux
May 30 04:49:12 hyperv kernel: fbcon: Taking over console
May 30 04:49:12 hyperv kernel: Console: switching to colour frame buffer device 128x48
May 30 04:49:12 hyperv kernel: hv_vmbus: Vmbus version:5.2
May 30 04:49:12 hyperv kernel: hv_vmbus: registering driver hid_hyperv
May 30 04:49:12 hyperv kernel: input: Microsoft Vmbus HID-compliant Mouse as /devices/0006:045E:0621.0001/input/input0
May 30 04:49:12 hyperv kernel: hid-generic 0006:045E:0621.0001: input: <UNKNOWN> HID v0.01 Mouse [Microsoft Vmbus HID-compliant Mouse] on 
May 30 04:49:12 hyperv kernel: hv_vmbus: registering driver hyperv_keyboard
May 30 04:49:12 hyperv kernel: hv_vmbus: registering driver hv_storvsc
May 30 04:49:12 hyperv kernel: scsi host0: storvsc_host_t
May 30 04:49:12 hyperv kernel: input: AT Translated Set 2 keyboard as /devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0004:00/VMBUS:00/d34b2567-b9b6-42b9-8778-0a4ec0b955bf/serio0/input/input1
May 30 04:49:12 hyperv kernel: scsi 0:0:0:0: Direct-Access     Msft     Virtual Disk     1.0  PQ: 0 ANSI: 5
May 30 04:49:12 hyperv kernel: scsi 0:0:0:1: CD-ROM            Msft     Virtual DVD-ROM  1.0  PQ: 0 ANSI: 0
May 30 04:49:12 hyperv kernel: sd 0:0:0:0: [sda] 266338304 512-byte logical blocks: (136 GB/127 GiB)
May 30 04:49:12 hyperv kernel: sd 0:0:0:0: [sda] 4096-byte physical blocks
May 30 04:49:12 hyperv kernel: sd 0:0:0:0: [sda] Write Protect is off
May 30 04:49:12 hyperv kernel: sd 0:0:0:0: [sda] Mode Sense: 0f 00 00 00
May 30 04:49:12 hyperv kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
May 30 04:49:12 hyperv kernel:  sda: sda1 sda2
May 30 04:49:12 hyperv kernel: sd 0:0:0:0: [sda] Attached SCSI disk
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] scsi-1 drive
May 30 04:49:12 hyperv kernel: cdrom: Uniform CD-ROM driver Revision: 3.20
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: Attached scsi CD-ROM sr0
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 Sense Key : Not Ready [current] 
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 Add. Sense: Medium not present - tray closed
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 CDB: Read(10) 28 00 00 07 ff fc 00 00 02 00
May 30 04:49:12 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097136 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#395 unaligned transfer
May 30 04:49:12 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097136 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
May 30 04:49:12 hyperv kernel: Buffer I/O error on dev sr0, logical block 2097136, async page read
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#396 unaligned transfer
May 30 04:49:12 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097137 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
May 30 04:49:12 hyperv kernel: Buffer I/O error on dev sr0, logical block 2097137, async page read
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 unaligned transfer
May 30 04:49:12 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097138 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
May 30 04:49:12 hyperv kernel: Buffer I/O error on dev sr0, logical block 2097138, async page read
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#398 unaligned transfer
May 30 04:49:12 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097139 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
May 30 04:49:12 hyperv kernel: Buffer I/O error on dev sr0, logical block 2097139, async page read
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#399 unaligned transfer
May 30 04:49:12 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097140 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
May 30 04:49:12 hyperv kernel: Buffer I/O error on dev sr0, logical block 2097140, async page read
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#400 unaligned transfer
May 30 04:49:12 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097141 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
May 30 04:49:12 hyperv kernel: Buffer I/O error on dev sr0, logical block 2097141, async page read
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#401 unaligned transfer
May 30 04:49:12 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097142 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
May 30 04:49:12 hyperv kernel: Buffer I/O error on dev sr0, logical block 2097142, async page read
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 unaligned transfer
May 30 04:49:12 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 2097143 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
May 30 04:49:12 hyperv kernel: Buffer I/O error on dev sr0, logical block 2097143, async page read
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 Sense Key : Not Ready [current] 
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 Add. Sense: Medium not present - tray closed
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 CDB: Read(10) 28 00 00 00 00 00 00 00 02 00
May 30 04:49:12 hyperv kernel: blk_update_request: I/O error, dev sr0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#404 unaligned transfer
May 30 04:49:12 hyperv kernel: Buffer I/O error on dev sr0, logical block 0, async page read
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#405 unaligned transfer
May 30 04:49:12 hyperv kernel: Buffer I/O error on dev sr0, logical block 1, async page read
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#406 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#407 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#408 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#409 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#410 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#411 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#412 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#413 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#414 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#415 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#417 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#418 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#419 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#420 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#421 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#422 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#423 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#424 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#425 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#426 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#427 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#428 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#429 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#430 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#431 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#432 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#434 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#435 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#436 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#437 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#439 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#440 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#441 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#442 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#443 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#444 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#445 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#446 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#384 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#385 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#386 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#387 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#389 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#390 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#391 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#392 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#393 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#395 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#396 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#398 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#399 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#400 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#401 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#404 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#405 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#406 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#407 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#408 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#409 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#410 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#411 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#412 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#413 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#414 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#415 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#417 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#418 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#419 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#420 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#421 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#422 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#423 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#424 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#425 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#426 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#427 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#428 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#429 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#430 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#431 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#432 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#434 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#435 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#436 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#437 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#439 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#440 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#441 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#442 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#443 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#444 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#445 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#446 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#384 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#385 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#386 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#387 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#389 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#390 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#391 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#392 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#393 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#395 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#396 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#398 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#399 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#400 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#401 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#404 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#405 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#406 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#407 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#408 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#409 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#410 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#411 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#412 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#413 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#414 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#415 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#417 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#418 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#419 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#420 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#421 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#422 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#423 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#424 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#425 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#426 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#427 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#428 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#429 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#430 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#431 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#432 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#434 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#435 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#436 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#437 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#439 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#440 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#441 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#442 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#443 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#444 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#445 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#446 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#384 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#385 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#386 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#387 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 Sense Key : Not Ready [current] 
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 Add. Sense: Medium not present - tray closed
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 CDB: Read(10) 28 00 00 00 00 04 00 00 02 00
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#389 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#390 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#391 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#392 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#393 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#395 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#396 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 Sense Key : Not Ready [current] 
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 Add. Sense: Medium not present - tray closed
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 CDB: Read(10) 28 00 00 00 00 20 00 00 02 00
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#398 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#399 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#400 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#401 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#404 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#405 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#406 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#407 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#408 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#409 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#410 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#411 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#412 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#413 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#414 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#415 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#417 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#418 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#419 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#420 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#421 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#422 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#423 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#424 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#425 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#426 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#427 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#428 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#429 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#430 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#431 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#432 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#434 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#435 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#436 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#437 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 Sense Key : Not Ready [current] 
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 Add. Sense: Medium not present - tray closed
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 CDB: Read(10) 28 00 00 00 00 10 00 00 02 00
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#439 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#440 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#441 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#442 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#443 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#444 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#445 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#446 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#384 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#385 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#386 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#387 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#389 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#390 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#391 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#392 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#393 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#395 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#396 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#398 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#399 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#400 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#401 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#404 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#405 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#406 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#407 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#408 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#409 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#410 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#411 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#412 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#413 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#414 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#415 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#417 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#418 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#419 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#420 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#421 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#422 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#423 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#424 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#425 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#426 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#427 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#428 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#429 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#430 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#431 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#432 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#434 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#435 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#436 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#437 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#439 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#440 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#441 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#442 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#443 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#444 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#445 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#446 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#384 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#385 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#386 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#387 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#389 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#390 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#391 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#392 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#393 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#395 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#396 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#398 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#399 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#400 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#401 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#404 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#405 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#406 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#407 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#408 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#409 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#410 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#411 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#412 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#413 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#414 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#415 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#417 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#418 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#419 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#420 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#421 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#422 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#423 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#424 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#425 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#426 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#427 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#428 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#429 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#430 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#431 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#432 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#434 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#435 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#436 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#437 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#439 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#440 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#441 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#442 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#443 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#444 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#445 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#446 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 Sense Key : Not Ready [current] 
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 Add. Sense: Medium not present - tray closed
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 CDB: Read(10) 28 00 00 00 00 06 00 00 02 00
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#384 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#385 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#386 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#387 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#389 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#390 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#391 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#392 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#393 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#395 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#396 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#398 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#399 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#400 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#401 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#404 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#405 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#406 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#407 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#408 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#409 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#410 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#411 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#412 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#413 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#414 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#415 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 Sense Key : Not Ready [current] 
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 Add. Sense: Medium not present - tray closed
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 CDB: Read(10) 28 00 00 00 00 0e 00 00 02 00
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#417 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#418 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#419 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#420 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#421 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#422 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#423 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#424 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#425 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#426 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#427 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#428 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#429 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#430 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#431 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#432 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#434 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#435 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#436 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#437 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#439 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#440 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#441 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#442 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#443 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#444 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#445 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#446 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#384 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#385 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#386 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#387 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#389 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#390 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#391 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#392 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#393 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#395 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#396 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#398 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#399 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#400 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#401 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#404 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#405 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#406 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#407 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#408 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#409 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#410 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#411 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#412 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#413 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#414 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#415 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#417 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#418 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#419 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#420 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#421 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#422 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#423 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#424 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#425 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#426 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#427 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#428 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#429 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#430 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#431 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#432 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#434 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#435 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#436 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#437 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#439 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#440 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#441 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#442 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#443 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#444 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#445 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#446 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#384 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#385 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#386 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#387 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#389 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#390 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#391 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#392 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#393 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#395 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#396 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#398 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#399 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#400 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#401 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#404 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#405 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#406 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#407 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#408 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#409 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#410 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#411 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#412 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#413 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#414 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#415 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#417 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#418 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#419 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#420 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#421 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#422 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#423 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#424 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#425 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#426 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#427 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#428 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#429 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#430 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#431 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#432 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#434 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#435 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#436 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#437 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#439 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#440 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#441 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#442 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#443 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#444 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#445 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#446 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#384 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#385 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#386 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#387 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#389 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#390 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#391 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#392 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#393 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#395 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#396 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#398 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#399 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#400 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#401 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#404 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#405 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#406 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#407 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#408 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#409 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#410 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#411 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#412 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#413 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#414 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#415 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#417 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#418 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#419 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#420 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#421 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#422 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#423 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#424 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#425 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#426 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#427 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#428 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#429 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#430 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#431 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#432 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#434 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#435 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#436 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#437 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#439 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#440 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#441 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#442 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#443 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#444 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#445 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#446 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#384 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#385 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#386 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#387 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#389 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#390 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#391 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#392 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#393 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#395 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#396 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#398 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#399 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#400 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#401 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#404 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#405 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#406 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#407 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#408 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#409 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#410 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#411 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#412 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#413 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#414 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#415 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#417 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#418 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#419 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#420 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#421 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#422 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#423 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#424 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#425 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#426 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#427 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#428 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#429 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#430 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#431 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#432 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 Sense Key : Not Ready [current] 
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 Add. Sense: Medium not present - tray closed
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 CDB: Read(10) 28 00 00 00 00 02 00 00 02 00
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#434 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#435 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#436 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#437 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#439 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#440 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#441 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#442 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#443 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#444 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#445 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#446 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#384 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#385 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#386 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#387 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#389 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#390 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#391 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#392 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#393 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#395 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#396 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#398 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#399 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#400 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#401 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#404 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#405 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#406 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#407 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#408 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#409 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#410 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#411 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#412 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#413 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#414 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#415 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#417 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#418 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#419 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#420 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#421 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#422 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#423 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#424 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#425 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#426 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#427 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#428 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#429 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#430 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#431 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#432 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#434 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#435 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#436 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#437 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#439 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#440 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#441 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#442 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#443 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#444 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#445 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#446 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#384 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#385 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#386 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#387 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#389 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#390 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#391 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#392 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#393 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#395 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#396 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#398 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#399 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#400 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#401 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 Sense Key : Not Ready [current] 
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 Add. Sense: Medium not present - tray closed
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 CDB: Read(10) 28 00 00 00 04 00 00 00 02 00
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#404 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#405 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#406 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#407 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#408 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#409 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#410 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#411 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#412 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#413 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#414 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#415 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#417 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#418 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#419 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#420 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#421 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#422 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#423 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#424 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#425 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#426 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#427 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#428 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#429 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#430 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#431 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#432 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#434 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#435 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#436 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#437 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#439 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#440 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#441 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#442 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#443 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#444 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#445 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#446 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#384 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#385 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#386 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#387 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#389 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#390 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#391 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#392 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#393 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#395 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#396 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#398 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#399 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#400 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#401 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#404 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#405 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#406 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#407 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#408 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#409 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#410 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#411 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#412 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#413 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#414 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#415 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#417 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#418 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#419 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#420 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#421 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#422 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#423 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#424 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#425 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#426 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#427 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#428 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#429 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#430 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#431 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#432 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#434 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#435 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#436 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#437 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#439 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#440 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#441 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#442 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#443 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#444 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#445 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#446 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#384 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#385 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#386 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#387 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#389 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#390 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#391 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#392 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#393 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#395 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#396 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#398 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#399 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#400 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#401 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#404 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#405 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#406 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#407 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#408 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#409 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#410 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#411 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#412 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#413 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#414 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#415 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#417 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#418 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#419 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#420 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#421 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#422 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#423 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#424 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#425 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#426 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#427 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#428 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#429 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#430 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#431 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#432 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#433 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#434 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#435 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#436 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#437 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#438 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#439 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#440 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#441 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#442 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#443 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#444 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#445 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#446 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#447 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#384 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#385 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#386 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#387 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#388 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#389 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#390 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#391 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#392 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#393 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#394 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#395 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#396 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#397 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#398 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#399 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#400 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#401 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#402 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#403 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#404 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#405 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#406 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#407 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#408 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#409 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#410 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#411 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#412 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#413 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#414 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#415 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#416 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#417 unaligned transfer
May 30 04:49:12 hyperv kernel: sr 0:0:0:1: [sr0] tag#418 unaligned transfer
May 30 04:49:12 hyperv kernel: EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
May 30 04:49:12 hyperv systemd[1]: systemd 248.3-2-arch running in system mode. (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
May 30 04:49:12 hyperv systemd[1]: Detected virtualization microsoft.
May 30 04:49:12 hyperv systemd[1]: Detected architecture x86-64.
May 30 04:49:12 hyperv systemd[1]: Hostname set to <hyperv>.
May 30 04:49:12 hyperv systemd-fstab-generator[253]: Mount point  is not a valid path, ignoring.
May 30 04:49:12 hyperv systemd-fstab-generator[253]: Mount point  is not a valid path, ignoring.
May 30 04:49:12 hyperv kernel: random: lvmconfig: uninitialized urandom read (4 bytes read)
May 30 04:49:12 hyperv systemd[1]: Queued start job for default target Graphical Interface.
May 30 04:49:12 hyperv systemd[1]: Created slice system-getty.slice.
May 30 04:49:12 hyperv systemd[1]: Created slice system-modprobe.slice.
May 30 04:49:12 hyperv systemd[1]: Created slice system-systemd\x2dfsck.slice.
May 30 04:49:12 hyperv systemd[1]: Created slice User and Session Slice.
May 30 04:49:12 hyperv systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
May 30 04:49:12 hyperv systemd[1]: Started Forward Password Requests to Wall Directory Watch.
May 30 04:49:12 hyperv systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
May 30 04:49:12 hyperv systemd[1]: Reached target Local Encrypted Volumes.
May 30 04:49:12 hyperv systemd[1]: Reached target Login Prompts.
May 30 04:49:12 hyperv systemd[1]: Reached target Paths.
May 30 04:49:12 hyperv systemd[1]: Reached target Remote File Systems.
May 30 04:49:12 hyperv systemd[1]: Reached target Slices.
May 30 04:49:12 hyperv systemd[1]: Reached target Swap.
May 30 04:49:12 hyperv systemd[1]: Reached target Local Verity Integrity Protected Volumes.
May 30 04:49:12 hyperv systemd[1]: Listening on Device-mapper event daemon FIFOs.
May 30 04:49:12 hyperv systemd[1]: Listening on LVM2 poll daemon socket.
May 30 04:49:12 hyperv systemd[1]: Listening on Process Core Dump Socket.
May 30 04:49:12 hyperv systemd[1]: Listening on Journal Audit Socket.
May 30 04:49:12 hyperv systemd[1]: Listening on Journal Socket (/dev/log).
May 30 04:49:12 hyperv systemd[1]: Listening on Journal Socket.
May 30 04:49:12 hyperv systemd[1]: Listening on Network Service Netlink Socket.
May 30 04:49:12 hyperv systemd[1]: Listening on udev Control Socket.
May 30 04:49:12 hyperv systemd[1]: Listening on udev Kernel Socket.
May 30 04:49:12 hyperv systemd[1]: Mounting Huge Pages File System...
May 30 04:49:12 hyperv systemd[1]: Mounting POSIX Message Queue File System...
May 30 04:49:12 hyperv systemd[1]: Mounting Kernel Debug File System...
May 30 04:49:12 hyperv systemd[1]: Mounting Kernel Trace File System...
May 30 04:49:12 hyperv systemd[1]: Starting Create list of static device nodes for the current kernel...
May 30 04:49:12 hyperv systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
May 30 04:49:12 hyperv systemd[1]: Starting Load Kernel Module configfs...
May 30 04:49:12 hyperv kernel: random: lvm: uninitialized urandom read (4 bytes read)
May 30 04:49:12 hyperv systemd[1]: Starting Load Kernel Module drm...
May 30 04:49:12 hyperv systemd[1]: Starting Load Kernel Module fuse...
May 30 04:49:12 hyperv systemd[1]: Starting Set Up Additional Binary Formats...
May 30 04:49:12 hyperv systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
May 30 04:49:12 hyperv kernel: Linux agpgart interface v0.103
May 30 04:49:12 hyperv systemd[1]: Starting Journal Service...
May 30 04:49:12 hyperv systemd[1]: Starting Load Kernel Modules...
May 30 04:49:12 hyperv systemd[1]: Starting Remount Root and Kernel File Systems...
May 30 04:49:12 hyperv systemd[1]: Condition check resulted in Repartition Root Disk being skipped.
May 30 04:49:12 hyperv systemd[1]: Starting Coldplug All udev Devices...
May 30 04:49:12 hyperv systemd[1]: Mounted Huge Pages File System.
May 30 04:49:12 hyperv systemd[1]: Mounted POSIX Message Queue File System.
May 30 04:49:12 hyperv systemd[1]: Mounted Kernel Debug File System.
May 30 04:49:12 hyperv systemd[1]: Mounted Kernel Trace File System.
May 30 04:49:12 hyperv kernel: EXT4-fs (sda2): re-mounted. Opts: (null). Quota mode: none.
May 30 04:49:12 hyperv systemd[1]: Finished Create list of static device nodes for the current kernel.
May 30 04:49:12 hyperv kernel: audit: type=1130 audit(1622375352.033:2): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=kmod-static-nodes comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 04:49:12 hyperv systemd[1]: modprobe@configfs.service: Deactivated successfully.
May 30 04:49:12 hyperv systemd[1]: Finished Load Kernel Module configfs.
May 30 04:49:12 hyperv kernel: audit: type=1130 audit(1622375352.033:3): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@configfs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 04:49:12 hyperv kernel: audit: type=1131 audit(1622375352.033:4): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@configfs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 04:49:12 hyperv systemd[1]: Finished Remount Root and Kernel File Systems.
May 30 04:49:12 hyperv kernel: audit: type=1130 audit(1622375352.033:5): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-remount-fs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 04:49:12 hyperv systemd[1]: proc-sys-fs-binfmt_misc.automount: Got automount request for /proc/sys/fs/binfmt_misc, triggered by 270 (systemd-binfmt)
May 30 04:49:12 hyperv kernel: fuse: init (API version 7.33)
May 30 04:49:12 hyperv systemd[1]: Mounting Arbitrary Executable File Formats File System...
May 30 04:49:12 hyperv systemd[1]: Mounting Kernel Configuration File System...
May 30 04:49:12 hyperv systemd[1]: Condition check resulted in First Boot Wizard being skipped.
May 30 04:49:12 hyperv kernel: Asymmetric key parser 'pkcs8' registered
May 30 04:49:12 hyperv systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
May 30 04:49:12 hyperv systemd[1]: Starting Load/Save Random Seed...
May 30 04:49:12 hyperv systemd[1]: Starting Create System Users...
May 30 04:49:12 hyperv systemd[1]: modprobe@fuse.service: Deactivated successfully.
May 30 04:49:12 hyperv systemd[1]: Finished Load Kernel Module fuse.
May 30 04:49:12 hyperv kernel: audit: type=1130 audit(1622375352.036:6): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@fuse comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 04:49:12 hyperv kernel: audit: type=1131 audit(1622375352.036:7): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@fuse comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 04:49:12 hyperv systemd[1]: Finished Load Kernel Modules.
May 30 04:49:12 hyperv kernel: audit: type=1130 audit(1622375352.039:8): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-modules-load comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 04:49:12 hyperv systemd[1]: Mounted Arbitrary Executable File Formats File System.
May 30 04:49:12 hyperv systemd[1]: Mounted Kernel Configuration File System.
May 30 04:49:12 hyperv systemd[1]: Mounting FUSE Control File System...
May 30 04:49:12 hyperv systemd[1]: Starting Apply Kernel Variables...
May 30 04:49:12 hyperv systemd[1]: Finished Set Up Additional Binary Formats.
May 30 04:49:12 hyperv kernel: audit: type=1130 audit(1622375352.043:9): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-binfmt comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 04:49:12 hyperv systemd[1]: Mounted FUSE Control File System.
May 30 04:49:12 hyperv systemd[1]: Finished Apply Kernel Variables.
May 30 04:49:12 hyperv kernel: audit: type=1130 audit(1622375352.046:10): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 04:49:12 hyperv systemd[1]: modprobe@drm.service: Deactivated successfully.
May 30 04:49:12 hyperv systemd[1]: Finished Load Kernel Module drm.
May 30 04:49:12 hyperv systemd[1]: Finished Create System Users.
May 30 04:49:12 hyperv systemd[1]: Starting Create Static Device Nodes in /dev...
May 30 04:49:12 hyperv systemd[1]: Finished Coldplug All udev Devices.
May 30 04:49:12 hyperv systemd[1]: Finished Create Static Device Nodes in /dev.
May 30 04:49:12 hyperv systemd[1]: Starting Rule-based Manager for Device Events and Files...
May 30 04:49:12 hyperv systemd[1]: Started Journal Service.
May 30 11:49:12 hyperv kernel: mousedev: PS/2 mouse device common for all mice
May 30 11:49:12 hyperv kernel: input: PC Speaker as /devices/platform/pcspkr/input/input2
May 30 11:49:12 hyperv kernel: hv_vmbus: registering driver hv_balloon
May 30 11:49:12 hyperv kernel: hv_utils: Registering HyperV Utility Driver
May 30 11:49:12 hyperv kernel: hv_vmbus: registering driver hv_utils
May 30 11:49:12 hyperv kernel: hv_vmbus: registering driver hyperv_fb
May 30 11:49:12 hyperv kernel: hv_balloon: Using Dynamic Memory protocol version 2.0
May 30 11:49:12 hyperv kernel: hv_utils: Shutdown IC version 3.2
May 30 11:49:12 hyperv kernel: hv_utils: VSS IC version 5.0
May 30 11:49:12 hyperv kernel: hv_utils: TimeSync IC version 4.0
May 30 11:49:12 hyperv kernel: hyperv_fb: Synthvid Version major 3, minor 5
May 30 11:49:12 hyperv kernel: hyperv_fb: Screen resolution: 1920x1080, Color depth: 32
May 30 11:49:12 hyperv kernel: hv_vmbus: registering driver hv_netvsc
May 30 11:49:12 hyperv kernel: checking generic (f8000000 300000) vs hw (f8000000 300000)
May 30 11:49:12 hyperv kernel: fb0: switching to hyperv_fb from EFI VGA
May 30 11:49:12 hyperv kernel: Console: switching to colour dummy device 80x25
May 30 11:49:12 hyperv kernel: Console: switching to colour frame buffer device 240x67
May 30 11:49:12 hyperv kernel: RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
May 30 11:49:12 hyperv kernel: cryptd: max_cpu_qlen set to 1000
May 30 11:49:12 hyperv kernel: AVX2 version of gcm_enc/dec engaged.
May 30 11:49:12 hyperv kernel: AES CTR mode by8 optimization enabled
May 30 11:49:12 hyperv kernel: IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
May 30 11:49:12 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 11:49:12 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 11:49:12 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 11:49:12 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 11:49:12 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 11:49:12 hyperv kernel: random: dbus-daemon: uninitialized urandom read (12 bytes read)
May 30 11:49:12 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 11:49:13 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 11:49:13 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 11:49:13 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 11:49:13 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 11:49:13 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 11:49:13 hyperv kernel: Decoding supported only on Scalable MCA processors.
May 30 11:49:14 hyperv kernel: random: crng init done
May 30 11:49:14 hyperv kernel: random: 1 urandom warning(s) missed due to ratelimiting
May 30 11:49:14 hyperv kernel: hv_utils: Heartbeat IC version 3.0
May 30 11:49:35 hyperv kernel: hv_utils: Shutdown request received - graceful shutdown initiated
May 30 11:49:35 hyperv kernel: kauditd_printk_skb: 47 callbacks suppressed
May 30 11:49:35 hyperv kernel: audit: type=1131 audit(1622400575.158:54): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-random-seed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 11:49:35 hyperv kernel: audit: type=1131 audit(1622400575.181:55): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user@974 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 11:49:35 hyperv kernel: audit: type=1131 audit(1622400575.185:56): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user-runtime-dir@974 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 11:49:35 hyperv kernel: audit: type=1131 audit(1622400575.201:57): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dbus comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 11:49:35 hyperv kernel: audit: type=1130 audit(1622400575.221:58): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=mkinitcpio-generate-shutdown-ramfs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 11:49:35 hyperv kernel: audit: type=1131 audit(1622400575.221:59): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=mkinitcpio-generate-shutdown-ramfs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 11:49:35 hyperv kernel: audit: type=1131 audit(1622400575.245:60): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=sddm comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 11:49:35 hyperv kernel: audit: type=1131 audit(1622400575.251:61): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-user-sessions comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 11:49:35 hyperv kernel: audit: type=1131 audit(1622400575.258:62): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-resolved comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 30 11:49:35 hyperv kernel: audit: type=1334 audit(1622400575.298:63): prog-id=11 op=UNLOAD
May 30 11:49:35 hyperv systemd-shutdown[1]: Syncing filesystems and block devices.
May 30 11:49:35 hyperv systemd-shutdown[1]: Sending SIGTERM to remaining processes...
--HCm/Mw5iFU7pz+1x--
