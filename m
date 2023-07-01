Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F891744A96
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jul 2023 18:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGAQwg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sat, 1 Jul 2023 12:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGAQwf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jul 2023 12:52:35 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BE31FE3
        for <linux-fsdevel@vger.kernel.org>; Sat,  1 Jul 2023 09:52:34 -0700 (PDT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-67e3c6c4624so2631008b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Jul 2023 09:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688230353; x=1690822353;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySurgJmBT+5Dhc6CZeRbarLNSVjGIvGveq8MgdS1Jqo=;
        b=C+rcJ0tAXOpGSJZi8Q12oHhk2KCsT3NpnViTRAnroWq3aIsw4zBvkklERD9fQKk4jO
         sbd7MI707Ifmi5yKU/c4CKZFzwidZUzWi71xPXFxOivRbtFqaeU9h5MqZEGla/Z8v9mK
         J8oTPr6viV2cwYAyyWY3nd3p5bu1biFQe6EyFFNvBbycNk1cHacdBLeM09FE5iHU+Mmu
         yjldoI1+GZEZ6pVJStzjKkL1UAnDvToswnlSLj7tS6nYmE6DNKMVlifpb+h4THLef6PX
         H383yqOyIQkniJ8MUD44IpOXoy3YJKzbgzx6sLsoHOAWvnkSuhysl2vIP7uUujpIWhJA
         LcGw==
X-Gm-Message-State: ABy/qLa0XhrFivfYLZd8OQPSoWtBz+iY91n7XVIksG2gQKhJ8186jHvS
        lxi/swoH0JBzG2TeDrynr7DY3SZXgClOYA8y8YsJY3zURnEk
X-Google-Smtp-Source: APBJJlH3kIa6qD4yqJWlDjtLJeKZIldqaMKFOJf9sUocWrPNUcZowKRE3RfeYW73wwHljPzrgFw/PWEU/uyykNw7co2buSA3jtld
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d9a:b0:67c:3aeb:a47c with SMTP id
 fb26-20020a056a002d9a00b0067c3aeba47cmr6178067pfb.5.1688230353477; Sat, 01
 Jul 2023 09:52:33 -0700 (PDT)
Date:   Sat, 01 Jul 2023 09:52:33 -0700
In-Reply-To: <CAOQ4uxirxK6ts20Ri97pMstcJYrTW8PbgYML057Uj0MBoySeGg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084a55305ff6fc27d@google.com>
Subject: Re: [syzbot] [overlayfs?] KASAN: invalid-free in init_file
From:   syzbot <syzbot+ada42aab05cf51b00e98@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

27119][    T0] Smack:  IPv6 Netfilter enabled.
[    2.128178][    T0] LSM support for eBPF active
[    2.134180][    T0] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, vmalloc hugepage)
[    2.138824][    T0] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, vmalloc hugepage)
[    2.141770][    T0] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, vmalloc)
[    2.143494][    T0] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, vmalloc)
[    2.148953][    T0] Running RCU synchronous self tests
[    2.150087][    T0] Running RCU synchronous self tests
[    2.272250][    T1] smpboot: CPU0: Intel(R) Xeon(R) CPU @ 2.20GHz (family: 0x6, model: 0x4f, stepping: 0x0)
[    2.273215][    T1] RCU Tasks: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
[    2.273215][    T1] RCU Tasks Trace: Setting shift to 1 and lim to 1 rcu_task_cb_adjust=1.
[    2.273254][    T1] Running RCU-tasks wait API self tests
[    2.403503][    T1] Performance Events: unsupported p6 CPU model 79 no PMU driver, software events only.
[    2.405504][    T1] signal: max sigframe size: 1776
[    2.407112][    T1] rcu: Hierarchical SRCU implementation.
[    2.408574][    T1] rcu: 	Max phase no-delay instances is 1000.
[    2.414512][    T1] NMI watchdog: Perf NMI watchdog permanently disabled
[    2.417267][    T1] smp: Bringing up secondary CPUs ...
[    2.420500][    T1] smpboot: x86: Booting SMP configuration:
[    2.421388][    T1] .... node  #0, CPUs:      #1
[    2.423383][    T1] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    2.426407][    T1] TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html for more details.
[    2.429092][    T1] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
[    2.433473][    T1] smp: Brought up 2 nodes, 2 CPUs
[    2.434299][    T1] smpboot: Max logical packages: 1
[    2.435188][    T1] smpboot: Total of 2 processors activated (8800.92 BogoMIPS)
[    2.439416][    T1] devtmpfs: initialized
[    2.439416][    T1] x86/mm: Memory block size: 128MB
[    2.453338][   T14] Callback from call_rcu_tasks_trace() invoked.
[    2.475089][    T1] Running RCU synchronous self tests
[    2.476319][    T1] Running RCU synchronous self tests
[    2.478039][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    2.480252][    T1] futex hash table entries: 512 (order: 4, 65536 bytes, vmalloc)
[    2.483248][    T1] PM: RTC time: 16:50:51, date: 2023-07-01
[    2.492493][    T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    2.506662][    T1] audit: initializing netlink subsys (disabled)
[    2.508842][    T1] thermal_sys: Registered thermal governor 'step_wise'
[    2.508842][    T1] thermal_sys: Registered thermal governor 'user_space'
[    2.508842][   T27] audit: type=2000 audit(1688230251.721:1): state=initialized audit_enabled=0 res=1
[    2.518243][    T1] cpuidle: using governor menu
[    2.518243][    T1] NET: Registered PF_QIPCRTR protocol family
[    2.518243][    T1] dca service started, version 1.12.1
[    2.518243][    T1] PCI: Using configuration type 1 for base access
[    2.523361][    T1] WARNING: workqueue cpumask: online intersect > possible intersect
[    2.564096][    T1] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    2.565677][    T1] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    2.568064][    T1] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    2.570294][    T1] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    2.623640][   T13] Callback from call_rcu_tasks() invoked.
[    2.625239][    T1] cryptd: max_cpu_qlen set to 1000
[    2.654723][    T1] raid6: skipped pq benchmark and selected avx2x4
[    2.656007][    T1] raid6: using avx2x2 recovery algorithm
[    2.658822][    T1] ACPI: Added _OSI(Module Device)
[    2.659746][    T1] ACPI: Added _OSI(Processor Device)
[    2.660600][    T1] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.661534][    T1] ACPI: Added _OSI(Processor Aggregator Device)
[    2.779896][    T1] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    2.853240][    T1] ACPI: Interpreter enabled
[    2.853824][    T1] ACPI: PM: (supports S0 S3 S4 S5)
[    2.855217][    T1] ACPI: Using IOAPIC for interrupt routing
[    2.858802][    T1] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    2.861808][    T1] PCI: Ignoring E820 reservations for host bridge windows
[    2.877265][    T1] ACPI: Enabled 16 GPEs in block 00 to 0F
[    3.020230][    T1] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    3.022254][    T1] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    3.033237][    T1] acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
[    3.037635][    T1] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
[    3.045938][    T1] PCI host bridge to bus 0000:00
[    3.047232][    T1] pci_bus 0000:00: Unknown NUMA node; performance will be reduced
[    3.049572][    T1] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    3.053249][    T1] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    3.055000][    T1] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    3.056802][    T1] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfefff window]
[    3.059261][    T1] pci_bus 0000:00: root bus resource [bus 00-ff]
[    3.061286][    T1] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    3.077371][    T1] pci 0000:00:01.0: [8086:7110] type 00 class 0x060100
[    3.108998][    T1] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    3.132904][    T1] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX4 ACPI
[    3.132904][    T1] pci 0000:00:03.0: [1af4:1004] type 00 class 0x000000
[    3.155328][    T1] pci 0000:00:03.0: reg 0x10: [io  0xc000-0xc03f]
[    3.165224][    T1] pci 0000:00:03.0: reg 0x14: [mem 0xfe800000-0xfe80007f]
[    3.191213][    T1] pci 0000:00:04.0: [1af4:1000] type 00 class 0x020000
[    3.207352][    T1] pci 0000:00:04.0: reg 0x10: [io  0xc040-0xc07f]
[    3.213009][    T1] pci 0000:00:04.0: reg 0x14: [mem 0xfe801000-0xfe80107f]
[    3.242801][    T1] pci 0000:00:05.0: [1ae0:a002] type 00 class 0x030000
[    3.258142][    T1] pci 0000:00:05.0: reg 0x10: [mem 0xfe000000-0xfe7fffff]
[    3.283115][    T1] pci 0000:00:05.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    3.297395][    T1] pci 0000:00:06.0: [1af4:1002] type 00 class 0x00ff00
[    3.309891][    T1] pci 0000:00:06.0: reg 0x10: [io  0xc080-0xc09f]
[    3.313249][    T1] pci 0000:00:06.0: reg 0x14: [mem 0xfe802000-0xfe80207f]
[    3.357243][    T1] pci 0000:00:07.0: [1af4:1005] type 00 class 0x00ff00
[    3.363247][    T1] pci 0000:00:07.0: reg 0x10: [io  0xc0a0-0xc0bf]
[    3.383254][    T1] pci 0000:00:07.0: reg 0x14: [mem 0xfe803000-0xfe80303f]
[    3.428038][    T1] ACPI: PCI: Interrupt link LNKA configured for IRQ 10
[    3.436722][    T1] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    3.445230][    T1] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    3.453537][    T1] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    3.464044][    T1] ACPI: PCI: Interrupt link LNKS configured for IRQ 9
[    3.483327][    T1] iommu: Default domain type: Translated 
[    3.484528][    T1] iommu: DMA domain TLB invalidation policy: lazy mode 
[    3.491460][    T1] SCSI subsystem initialized
[    3.505337][    T1] ACPI: bus type USB registered
[    3.506708][    T1] usbcore: registered new interface driver usbfs
[    3.508578][    T1] usbcore: registered new interface driver hub
[    3.510528][    T1] usbcore: registered new device driver usb
[    3.513915][    T1] mc: Linux media interface: v0.10
[    3.515542][    T1] videodev: Linux video capture interface: v2.00
[    3.518037][    T1] pps_core: LinuxPPS API ver. 1 registered
[    3.520082][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    3.533454][    T1] PTP clock support registered
[    3.543864][    T1] EDAC MC: Ver: 3.0.0
[    3.546889][    T1] Advanced Linux Sound Architecture Driver Initialized.
[    3.553096][    T1] Bluetooth: Core ver 2.22
[    3.563575][    T1] NET: Registered PF_BLUETOOTH protocol family
[    3.565252][    T1] Bluetooth: HCI device and connection manager initialized
[    3.567107][    T1] Bluetooth: HCI socket layer initialized
[    3.568386][    T1] Bluetooth: L2CAP socket layer initialized
[    3.570088][    T1] Bluetooth: SCO socket layer initialized
[    3.571402][    T1] NET: Registered PF_ATMPVC protocol family
[    3.573245][    T1] NET: Registered PF_ATMSVC protocol family
[    3.575012][    T1] NetLabel: Initializing
[    3.575925][    T1] NetLabel:  domain hash size = 128
[    3.576962][    T1] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    3.578855][    T1] NetLabel:  unlabeled traffic allowed by default
[    3.582694][    T1] nfc: nfc_init: NFC Core ver 0.1
[    3.582694][    T1] NET: Registered PF_NFC protocol family
[    3.582694][    T1] PCI: Using ACPI for IRQ routing
[    3.582694][    T1] pci 0000:00:05.0: vgaarb: setting as boot VGA device
[    3.582694][    T1] pci 0000:00:05.0: vgaarb: bridge control possible
[    3.582694][    T1] pci 0000:00:05.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    3.582988][    T1] vgaarb: loaded
[    3.597539][    T1] clocksource: Switched to clocksource kvm-clock
[    3.603189][    T1] VFS: Disk quotas dquot_6.6.0
[    3.603189][    T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.603189][    T1] FS-Cache: Loaded
[    3.605594][    T1] CacheFiles: Loaded
[    3.607713][    T1] TOMOYO: 2.6.0
[    3.608509][    T1] Mandatory Access Control activated.
[    3.610238][    T1] pnp: PnP ACPI init
[    3.632464][    T1] pnp: PnP ACPI: found 7 devices
[    3.690116][    T1] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.693133][    T1] NET: Registered PF_INET protocol family
[    3.699454][    T1] IP idents hash table entries: 131072 (order: 8, 1048576 bytes, vmalloc)
[    3.712599][    T1] tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes, vmalloc)
[    3.718202][    T1] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, vmalloc)
[    3.723203][    T1] TCP established hash table entries: 65536 (order: 7, 524288 bytes, vmalloc)
[    3.735432][    T1] TCP bind hash table entries: 65536 (order: 11, 9437184 bytes, vmalloc hugepage)
[    3.753052][    T1] TCP: Hash tables configured (established 65536 bind 65536)
[    3.759662][    T1] MPTCP token hash table entries: 8192 (order: 7, 720896 bytes, vmalloc)
[    3.766188][    T1] UDP hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
[    3.772152][    T1] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes, vmalloc)
[    3.776897][    T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    3.781241][    T1] RPC: Registered named UNIX socket transport module.
[    3.783239][    T1] RPC: Registered udp transport module.
[    3.784886][    T1] RPC: Registered tcp transport module.
[    3.786903][    T1] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    3.792324][    T1] NET: Registered PF_XDP protocol family
[    3.794148][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    3.796651][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    3.798897][    T1] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    3.801385][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfefff window]
[    3.805305][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    3.807722][    T1] PCI: CLS 0 bytes, default 64
[    3.814903][    T1] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    3.817626][    T1] software IO TLB: mapped [mem 0x00000000b5800000-0x00000000b9800000] (64MB)
[    3.821308][    T1] ACPI: bus type thunderbolt registered
[    3.827146][    T1] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
[    3.837618][   T57] kworker/u4:3 (57) used greatest stack depth: 25848 bytes left
[    3.853873][    T1] kvm_amd: SVM not supported by CPU 0, not amd or hygon
[    3.856145][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fb70c0f8fc, max_idle_ns: 440795213829 ns
[    3.859506][    T1] clocksource: Switched to clocksource tsc
[    3.872085][    T1] AVX2 instructions are not detected.
[    3.874215][    T1] AVX or AES-NI instructions are not detected.
[    3.876743][    T1] AVX2 or AES-NI instructions are not detected.
[    3.879753][    T1] AVX or AES-NI instructions are not detected.
[    3.881266][    T1] AVX2 or AES-NI instructions are not detected.
[    3.883437][    T1] AVX or AES-NI instructions are not detected.


syzkaller build log:
go env (err=<nil>)
GO111MODULE="auto"
GOARCH="amd64"
GOBIN=""
GOCACHE="/syzkaller/.cache/go-build"
GOENV="/syzkaller/.config/go/env"
GOEXE=""
GOEXPERIMENT=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/syzkaller/jobs-2/linux/gopath/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/syzkaller/jobs-2/linux/gopath"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GOVCS=""
GOVERSION="go1.20.1"
GCCGO="gccgo"
GOAMD64="v1"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD="/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.mod"
GOWORK=""
CGO_CFLAGS="-O2 -g"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-O2 -g"
CGO_FFLAGS="-O2 -g"
CGO_LDFLAGS="-O2 -g"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build2315435869=/tmp/go-build -gno-record-gcc-switches"

git status (err=<nil>)
HEAD detached at 4cd5bb25a
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:32: run command via tools/syz-env for best compatibility, see:
Makefile:33: https://github.com/google/syzkaller/blob/master/docs/contributing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
bin/syz-sysgen
touch .descriptions
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=4cd5bb25a2752a9a5b25597d1da34656681f07a6 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230626-110233'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-fuzzer github.com/google/syzkaller/syz-fuzzer
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=4cd5bb25a2752a9a5b25597d1da34656681f07a6 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230626-110233'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
GOOS=linux GOARCH=amd64 go build "-ldflags=-s -w -X github.com/google/syzkaller/prog.GitRevision=4cd5bb25a2752a9a5b25597d1da34656681f07a6 -X 'github.com/google/syzkaller/prog.gitRevisionDate=20230626-110233'" "-tags=syz_target syz_os_linux syz_arch_amd64 " -o ./bin/linux_amd64/syz-stress github.com/google/syzkaller/tools/syz-stress
mkdir -p ./bin/linux_amd64
gcc -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-larger-than=16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -static-pie -fpermissive -w -DGOOS_linux=1 -DGOARCH_amd64=1 \
	-DHOSTGOOS_linux=1 -DGIT_REVISION=\"4cd5bb25a2752a9a5b25597d1da34656681f07a6\"


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=11de8314a80000


Tested on:

commit:         a2175988 fs: fix invalid-free in init_file()
git tree:       https://github.com/amir73il/linux.git ovl-fixes
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9def0ca2621537a
dashboard link: https://syzkaller.appspot.com/bug?extid=ada42aab05cf51b00e98
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
