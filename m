Return-Path: <linux-fsdevel+bounces-44957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03416A6FAEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BD951703F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC3C257430;
	Tue, 25 Mar 2025 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry1UbhhX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0650C254B1B;
	Tue, 25 Mar 2025 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905011; cv=none; b=EjIqU6tbax5dbsySPQgU7R8CskvenH36b6PpK8kKtrwphRQzqhv4JGEXXqKad5IeTZFa+tm98K3GxnxYBRL1Xv+SjHPXPYYLRqSbQkocHXiKbj7XscUr0itQ6fAivWGUZFK4/OgWrOsVlzpKX3B2RLn3R7bcGNXe3lCk9IXvFFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905011; c=relaxed/simple;
	bh=K8NfNrt/w5dMAy6cCdRBwH4CniB/aO/uODgJmrL2zko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=suyrxMquuJ8fK4+uGz/oDHVHZhCN4jEI4YsBewKA1va8tg2/5t+18P7aYkP2VebUih7mbtzmTHgZeb53Xpf9JsVVtviEv5uIxbcKlEZlWNz6SNX/VkbA/d8Zq6XjDev9Upfl7/LKnG6QmlVX8fi2w+7M3Jg4RW90IdWGocoF6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry1UbhhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B791DC4CEE4;
	Tue, 25 Mar 2025 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905010;
	bh=K8NfNrt/w5dMAy6cCdRBwH4CniB/aO/uODgJmrL2zko=;
	h=From:To:Cc:Subject:Date:From;
	b=Ry1UbhhXqaLoEARZz3dBPY9nuwhWKZiKweODIZbI0GmXAjhtwM90CskxuUCY6HMSE
	 OxU0tozylPr5bYV7YokEk8xaDXOGeOB8hXNZmv0ZNKyql3TAWd/AD0Knbz6YLabuOz
	 ny+Ky84wRsXKLpgqlfRNlbobx4beWJio7eqQqOqGszBwfA5ZARiuTcZusmI4J8AwXN
	 TL+EdMKKXFJfBiOUw2dsaDfqJi5OSldn1Dnc/lZRLNN7gzCQQ43TGIHSpzyE7I1RvO
	 Hy+XD+O9KfSmUed1kCldFysunOIV90bEBJDUu930ZTma4PU5hhm0kk66NLt2Akreoi
	 C1h7EHnv+YgzA==
From: guoren@kernel.org
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	oleg@redhat.com,
	kees@kernel.org,
	tglx@linutronix.de,
	will@kernel.org,
	mark.rutland@arm.com,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	edumazet@google.com,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	gaohan@iscas.ac.cn,
	shihua@iscas.ac.cn,
	jiawei@iscas.ac.cn,
	wuwei2016@iscas.ac.cn,
	drew@pdp7.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	ctsai390@andestech.com,
	wefu@redhat.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	guoren@kernel.org,
	xiao.w.wang@intel.com,
	qingfang.deng@siflower.com.cn,
	leobras@redhat.com,
	jszhang@kernel.org,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com,
	yongxuan.wang@sifive.com,
	luxu.kernel@bytedance.com,
	david@redhat.com,
	ruanjinjie@huawei.com,
	cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com,
	qiaozhe@iscas.ac.cn
Cc: ardb@kernel.org,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-crypto@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-nfs@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [RFC PATCH V3 00/43] rv64ilp32_abi: Build CONFIG_64BIT kernel-self with ILP32 ABI
Date: Tue, 25 Mar 2025 08:15:41 -0400
Message-Id: <20250325121624.523258-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

Since 2001, the CONFIG_64BIT kernel has been built with the LP64 ABI,
but this patchset allows the CONFIG_64BIT kernel to use an ILP32 ABI
for construction to reduce cache & memory footprint (Compared to
kernel-lp64-abi, kernel-rv64ilp32-abi decreased the used memory by
about 20%, as shown in "free -h" in the following demo.)

Caution: this patchset doesn't introduce any new userspace ABI; it's
only for the kernel-self.

The patchset targets RISC-V and is built on the RV64ILP32 ABI, which
was introduced into RISC-V's psABI in January 2025 [1]. This patchset
equips an rv64ilp32-abi kernel with all the functionalities of a
traditional lp64-abi kernel, yet restricts the address space to 2GiB.
Hence, the rv64ilp32-abi kernel simultaneously supports lp64-abi
userspace and ilp32-abi (compat) userspace, the same as the
traditional lp64-abi kernel.

  +--------------------------------+
  | +-------------+--------------+ |
  | |             |   (compat)   | |
  | |  lp64-abi   |   ilp32-abi  | | User
  | +-------------+--------------+ |
  +--------------------------------+-------
  | +----------------------------+ |
  | |  rv64ilp32-abi / lp64-abi  | | Kernel
  | |  ^^^^^^^^^^^^^             | |
  | +----------------------------+ |
  +--------------lp64-sbi----------+-------
  | +----------------------------+ |
  | |            lp64-abi        | | OpenSBI
  | +----------------------------+ |
  +--------------------------------+-------
  | +----------------------------+ |
  | |  rv64gcbvh (RISC-V 64-bit) | | ISA
  | +----------------------------+ |
  +--------------------------------+

Caution: The rv64ilp32-abi and lp64-abi kernels are equivalent
and can be used interchangeably. The only difference is that the
rv64ilp32-abi kernel restricts kernel and user space to separate 
2GiB address spaces.


Motivation
==========
Because all RISC-V RVA(B) Profiles are based on the 64-bit ISA, the market
has experienced a significant rise in RISC-V 64-bit ISA SoCs and CPU cores
for resource-constrained scenarios, such as:

 - allwinner/sun20i-d1-lichee
 - allwinner/sun20i-d1s-mangopi
 - bouffalo/bl808
 - canaan/k230d
 - microchip/mpfs-beaglev-fire
 - renesas/rzfive-smarc
 - sophgo/cv1800b
 - sophgo/cv1812h
 - sophgo/sg2002

The listed RV64 ISA-based SoCs with limited memory (less than 1GiB) can
benefit from this patchset. The patchset's benefit is not only decreasing
the memory footprint but also improving performance due to increased cache
density. Hence, All RVA(B) Profile hardwares can benefit from this
patchset.


Patchset Organization
=====================
This patchset is now in its third version. The major update is the
shift to CONFIG_64BIT with user lp64-abi & ilp32-abi support. The prior
versions (v1, v2) are all based on CONFIG_32BIT and only support the
user ilp32-abi.

The innovation of v3 lies in supporting user lp64-abi by inheriting
CONFIG_64BIT.

This patchset comprises 43 patches affecting more than 20 subsystems.
Most modifications are about ensuring the correct usage of
BITS_PER_LONG and CONFIG_64BIT. Part of the Linux code doesn't care
about that because BITS_PER_LONG and CONFIG_64BIT were the same before.

 - PATCH[1]    : The rv64ilp32-abi kernel reuses lp64-abi uapi.
 - PATCH[2~17] : The riscv subsystem-related modifications.
 - PATCH[18~43]: Other subsystem-related modifications.

The first patch needs discussion and is titled "uapi: Reuse lp64 ABI
interface." How do we define a unified set of lp64-abi uapi header
files that could be utilized for the lp64-abi kernel and the
rv64ilp32-abi kernel?

To get started with the patch set quickly, check out the following
demo.


Demo Introduction
=================
To test the patchset, use a riscv64 toolchain with rv64ilp32-abi
support. The rv64ilp32-abi is integrated as a -mabi=ilp32 feature within
the standard rv64 toolchain. We've built a multi-lib riscv64-elf-toolchain
[2] containing rv64ilp32-abi. We also provide the pre-compiled demo
materials for a quick start, such as qemu, kernel, and rootfs binaries for
the demo.

After download from [2]:
$ tar zxvf riscv64-elf-ubuntu-20(2).04-gcc-nightly-2025.03.24-nightly.tar.gz
$ cd riscv/qemu-linux
 - Image_rv64ilp32		rv64ilp32-abi kernel
 - Image_rv64lp64		lp64-abi kernel
 - u64lp64_rootfs.ext2		lp64-abi userspace rootfs
 - start-qemu-rv64.sh		qemu running wrapper script

Compile Image_rv64ilp32:
$ make ARCH=riscv CROSS_COMPILE=<download path>/riscv/bin/riscv64-unknown-elf- rv64ilp32_defconfig all

Compile Image_rv64lp64:
$ make ARCH=riscv CROSS_COMPILE=<download path>/riscv/bin/riscv64-unknown-elf- defconfig all

Quick Start:
$ ./start-qemu-rv64.sh Image_rv64ilp32 u64lp64_rootfs.ext2
v.s.
$ ./start-qemu-rv64.sh Image_rv64lp64  u64lp64_rootfs.ext2

Used Memory Comparison
======================
Under the same configuration, the used memory decreased by 20% (10.8 ->
8.2) with the Image_rv64ilp32 replacement (Qemu, firmware, and lp64-abi
user rootfs are the same).

$ ./start-qemu-rv64.sh Image_rv64ilp32 u64lp64_rootfs.ext2
$ free -h
       total  used   free  shared  buff/cache   available
Mem:  105.4M  8.2M  93.9M   44.0K        3.3M       93.6M
              ^^^^

$ ./start-qemu-rv64.sh Image_rv64lp64  u64lp64_rootfs.ext2
$ free -h
       total  used   free  shared  buff/cache   available
Mem:   89.3M 10.8M  74.8M   44.0K        3.7M       74.9M
             ^^^^^

$ cat start-qemu-rv64.sh
exec qemu-system-riscv64 -cpu rv64 -M virt -m 128m -nographic -kernel $1 -drive file=$2,format=raw,id=hd0 -device virtio-blk-device,drive=hd0 -append "rootwait root=/dev/vda ro console=ttyS0 earlycon=sbi norandmaps no5lvl no4lvl"


User Virtual Memory Layout
==========================
Here is the comparison running lp64-abi userspace rootfs on
rv64ilp32-abi kernel and lp64-abi kernel:

(rv64ilp32-abi kernel + lp64-abi user rootfs)
$ cat /proc/1/maps
55555000-5560c000 r-xp 00000000 fe:00 17         /bin/busybox
5560c000-5560f000 r--p 000b7000 fe:00 17         /bin/busybox
5560f000-55610000 rw-p 000ba000 fe:00 17         /bin/busybox
55610000-55631000 rw-p 00000000 00:00 0          [heap]
77e69000-77e6b000 rw-p 00000000 00:00 0
77e6b000-77fba000 r-xp 00000000 fe:00 140        /lib/libc.so.6
77fba000-77fbd000 r--p 0014f000 fe:00 140        /lib/libc.so.6
77fbd000-77fbf000 rw-p 00152000 fe:00 140        /lib/libc.so.6
77fbf000-77fcb000 rw-p 00000000 00:00 0
77fcb000-77fd5000 r-xp 00000000 fe:00 148        /lib/libresolv.so.2
77fd5000-77fd6000 r--p 0000a000 fe:00 148        /lib/libresolv.so.2
77fd6000-77fd7000 rw-p 0000b000 fe:00 148        /lib/libresolv.so.2
77fd7000-77fd9000 rw-p 00000000 00:00 0
77fd9000-77fdb000 r--p 00000000 00:00 0          [vvar]
77fdb000-77fdc000 r-xp 00000000 00:00 0          [vdso]
77fdc000-77ffc000 r-xp 00000000 fe:00 135        /lib/ld-linux-riscv64-lp64d.so.1
77ffc000-77ffe000 r--p 0001f000 fe:00 135        /lib/ld-linux-riscv64-lp64d.so.1
77ffe000-78000000 rw-p 00021000 fe:00 135        /lib/ld-linux-riscv64-lp64d.so.1
7ffdf000-80000000 rw-p 00000000 00:00 0          [stack]

(lp64-abi kernel + lp64-abi user rootfs)
$ cat /proc/1/maps
2aaaaaa000-2aaab61000 r-xp 00000000 fe:00 17     /bin/busybox
2aaab61000-2aaab64000 r--p 000b7000 fe:00 17     /bin/busybox
2aaab64000-2aaab65000 rw-p 000ba000 fe:00 17     /bin/busybox
2aaab65000-2aaab86000 rw-p 00000000 00:00 0      [heap]
3ff7e69000-3ff7e6b000 rw-p 00000000 00:00 0
3ff7e6b000-3ff7fba000 r-xp 00000000 fe:00 140    /lib/libc.so.6
3ff7fba000-3ff7fbd000 r--p 0014f000 fe:00 140    /lib/libc.so.6
3ff7fbd000-3ff7fbf000 rw-p 00152000 fe:00 140    /lib/libc.so.6
3ff7fbf000-3ff7fcb000 rw-p 00000000 00:00 0
3ff7fcb000-3ff7fd5000 r-xp 00000000 fe:00 148    /lib/libresolv.so.2
3ff7fd5000-3ff7fd6000 r--p 0000a000 fe:00 148    /lib/libresolv.so.2
3ff7fd6000-3ff7fd7000 rw-p 0000b000 fe:00 148    /lib/libresolv.so.2
3ff7fd7000-3ff7fd9000 rw-p 00000000 00:00 0
3ff7fd9000-3ff7fdb000 r--p 00000000 00:00 0      [vvar]
3ff7fdb000-3ff7fdc000 r-xp 00000000 00:00 0      [vdso]
3ff7fdc000-3ff7ffc000 r-xp 00000000 fe:00 135    /lib/ld-linux-riscv64-lp64d.so.1
3ff7ffc000-3ff7ffe000 r--p 0001f000 fe:00 135    /lib/ld-linux-riscv64-lp64d.so.1
3ff7ffe000-3ff8000000 rw-p 00021000 fe:00 135    /lib/ld-linux-riscv64-lp64d.so.1
3ffffdf000-4000000000 rw-p 00000000 00:00 0      [stack]

~~~~~~~~~~~~~~~~~~~~~~
For the ilp32-abi userspace rootfs, the virtual memory layouts
are the same:
(lp64-abi/rv64ilp32-abi kernel + ilp32-abi user rootfs)
$ cat /proc/1/maps
55555000-55637000 r-xp 00000000 fe:00 17         /bin/busybox
55637000-55639000 r--p 000e1000 fe:00 17         /bin/busybox
55639000-5563a000 rw-p 000e3000 fe:00 17         /bin/busybox
5563a000-5565c000 rw-p 00000000 00:00 0          [heap]
77e63000-77fbe000 r-xp 00000000 fe:00 145        /lib/libc.so.6
77fbe000-77fc0000 r--p 0015a000 fe:00 145        /lib/libc.so.6
77fc0000-77fc1000 rw-p 0015c000 fe:00 145        /lib/libc.so.6
77fc1000-77fcb000 rw-p 00000000 00:00 0
77fcb000-77fd5000 r-xp 00000000 fe:00 154        /lib/libresolv.so.2
77fd5000-77fd6000 r--p 0000a000 fe:00 154        /lib/libresolv.so.2
77fd6000-77fd7000 rw-p 0000b000 fe:00 154        /lib/libresolv.so.2
77fd7000-77fd9000 rw-p 00000000 00:00 0
77fd9000-77fdb000 r--p 00000000 00:00 0          [vvar]
77fdb000-77fdc000 r-xp 00000000 00:00 0          [vdso]
77fdc000-77ffe000 r-xp 00000000 fe:00 138        /lib/ld-linux-riscv32-ilp32d.so.1
77ffe000-77fff000 r--p 00022000 fe:00 138        /lib/ld-linux-riscv32-ilp32d.so.1
77fff000-78000000 rw-p 00023000 fe:00 138        /lib/ld-linux-riscv32-ilp32d.so.1
7ffdf000-80000000 rw-p 00000000 00:00 0          [stack]


Kernel Virtual Memory Layout
============================
Here is the comparison on rv64ilp32-abi kernel and lp64-abi kernel:

Virtual kernel memory layout (rv64ilp32-abi kernel):
   fixmap : 0x94a00000 - 0x94ffffff   (6144 kB)
   pci io : 0x95000000 - 0x95ffffff   (  16 MB)
  vmemmap : 0x96000000 - 0x97ffffff   (  32 MB)
  vmalloc : 0x98000000 - 0xb7ffffff   ( 512 MB)
  modules : 0xb8000000 - 0xbbffffff   (  64 MB)
   lowmem : 0xc0000000 - 0xc7ffffff   ( 128 MB)
    kasan : 0x80000000 - 0x8fffffff   ( 256 MB)
   kernel : 0xbc000000 - 0xbfffffff   (  64 MB)

Virtual kernel memory layout (lp64-abi kernel):
   fixmap : 0xffffffc4fea00000 - 0xffffffc4feffffff   (6144 kB)
   pci io : 0xffffffc4ff000000 - 0xffffffc4ffffffff   (  16 MB)
  vmemmap : 0xffffffc500000000 - 0xffffffc5ffffffff   (4096 MB)
  vmalloc : 0xffffffc600000000 - 0xffffffd5ffffffff   (  64 GB)
  modules : 0xffffffff01591000 - 0xffffffff7fffffff   (2026 MB)
   lowmem : 0xffffffd600000000 - 0xffffffd607ffffff   ( 128 MB)
    kasan : 0xfffffff700000000 - 0xfffffffeffffffff   (  32 GB)
   kernel : 0xffffffff80000000 - 0xfffffffffffffffe   (2047 MB)


Memory Info Comparison
======================

$ ./start-qemu-rv64.sh Image_rv64ilp32 u64lp64_rootfs.ext2
$ cat /proc/meminfo
MemTotal:         107916 kB
MemFree:           96200 kB
MemAvailable:      95932 kB
Buffers:             448 kB
Cached:             2268 kB
SwapCached:            0 kB
Active:             2432 kB
Inactive:            832 kB
Active(anon):         44 kB
Inactive(anon):      548 kB
Active(file):       2388 kB
Inactive(file):      284 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:               108 kB
Writeback:             0 kB
AnonPages:           648 kB
Mapped:             1672 kB
Shmem:                44 kB
KReclaimable:        688 kB
Slab:               4996 kB
SReclaimable:        688 kB
SUnreclaim:         4308 kB
KernelStack:         768 kB
PageTables:          164 kB
SecPageTables:         0 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:       53956 kB
Committed_AS:       2240 kB
VmallocTotal:     524288 kB
VmallocUsed:         924 kB
VmallocChunk:          0 kB
Percpu:               76 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB

$ ./start-qemu-rv64.sh Image_rv64lp64 u64lp64_rootfs.ext2
$ cat /proc/meminfo
MemTotal:          91428 kB
MemFree:           77048 kB
MemAvailable:      77172 kB
Buffers:             448 kB
Cached:             2268 kB
SwapCached:            0 kB
Active:             2492 kB
Inactive:            768 kB
Active(anon):         48 kB
Inactive(anon):      540 kB
Active(file):       2444 kB
Inactive(file):      228 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:             0 kB
SwapFree:              0 kB
Dirty:                32 kB
Writeback:             0 kB
AnonPages:           648 kB
Mapped:             1768 kB
Shmem:                44 kB
KReclaimable:       1140 kB
Slab:               7220 kB
SReclaimable:       1140 kB
SUnreclaim:         6080 kB
KernelStack:         768 kB
PageTables:          408 kB
SecPageTables:         0 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:       45712 kB
Committed_AS:       2240 kB
VmallocTotal:   67108864 kB
VmallocUsed:         864 kB
VmallocChunk:          0 kB
Percpu:               88 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB


CPU Info Comparison
===================
After disabling sv48 and sv57, there is no difference in the "/proc/cpuinfo".

$ ./start-qemu-rv64.sh Image_rv64lp64 u64lp64_rootfs.ext2
$ cat /proc/cpuinfo
processor       : 0
hart            : 0
isa             : rv64imafdch_zicbom_zicboz_zicntr_zicsr_zifencei_zihintpause_zihpm_zawrs_zfa_zca_zcd_zba_zbb_zbc_zbs_sstc_svadu
mmu             : sv39
mvendorid       : 0x0
marchid         : 0x0
mimpid          : 0x0
hart isa        : rv64imafdch_zicbom_zicboz_zicntr_zicsr_zifencei_zihintpause_zihpm_zawrs_zfa_zca_zcd_zba_zbb_zbc_zbs_sstc_svadu

$ ./start-qemu-rv64.sh Image_rv64ilp32 u64lp64_rootfs.ext2
$ cat /proc/cpuinfo
processor       : 0
hart            : 0
isa             : rv64imafdch_zicbom_zicboz_zicntr_zicsr_zifencei_zihintpause_zihpm_zawrs_zfa_zca_zcd_zba_zbb_zbc_zbs_sstc_svadu
mmu             : sv39
mvendorid       : 0x0
marchid         : 0x0
mimpid          : 0x0
hart isa        : rv64imafdch_zicbom_zicboz_zicntr_zicsr_zifencei_zihintpause_zihpm_zawrs_zfa_zca_zcd_zba_zbb_zbc_zbs_sstc_svadu


.config Difference
==================
The patchset adds CONFIG_ABI_RV64ILP32 to Kconfig, switching the
compile options from "-mabi=lp64 -melf64lriscv" to
"-mabi=ilp32 -melf32lriscv" depending on CONFIG_64BIT. So, The
differences of Kconfig between with and without ABI_RV64ILP32
are rare:

 - CONFIG_PAGE_OFFSET		Change to 0xc0000000.
 - CONFIG_ILLEGAL_POINTER_VALUE	Change to 0x0.
 - CONFIG_ABI_RV64ILP32		Compile option depends on CONFIG_64BIT.
 - CONFIG_HAVE_CMPXCHG_DOUBLE	The rv64ilp32-abi kernel offers new feature.
 - CONFIG_ZONE_DMA32		It's unnecessary for rv64ilp32-abi kernel.
 - CONFIG_CSD_LOCK_WAIT_DEBUG	Because of BITS_PER_LONG = 32, rv64ilp32-abi
				kernel doesn't support.

$ diff build-rv64lp64/.config build-rv64ilp32/.config
296c296
< CONFIG_PAGE_OFFSET=0xff60000000000000
---
> CONFIG_PAGE_OFFSET=0xc0000000
308c308
< CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
---
> CONFIG_ILLEGAL_POINTER_VALUE=0
352c352
< # CONFIG_ABI_RV64ILP32 is not set
---
> CONFIG_ABI_RV64ILP32=y
609a610
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
837d837
< CONFIG_ZONE_DMA32=y
7240d7239
< # CONFIG_CSD_LOCK_WAIT_DEBUG is not set

6 differences

Use "zcat /proc/config.gz" to get the .config file in our qemu demo.


Dmesg Difference
================

$ diff rv64lp64.log rv64ilp32.log
1c1
< Linux version 6.14.0-rc1-00041-g804ac3b4d679 (ren.guo@ea134-sw12.eng.xrvm.cn) (riscv64-unknown-elf-gcc (gf9ffd92f861-dirty) 13.2.0, GNU ld (GNU Binutils) 2.42) #1 SMP Sat Mar 15 11:57:20 CST 2025
---
> Linux version 6.14.0-rc1-00041-g804ac3b4d679 (ren.guo@ea134-sw12.eng.xrvm.cn) (riscv64-unknown-elf-gcc (gf9ffd92f861-dirty) 13.2.0, GNU ld (GNU Binutils) 2.42) #1 SMP Sat Mar 15 11:55:33 CST 2025
13,14d12
< Disabled 5-level paging
< Disabled 4-level and 5-level paging
19,20c17
<   DMA32    [mem 0x0000000060000000-0x0000000067ffffff]
<   Normal   empty
---
>   Normal   [mem 0x0000000060000000-0x0000000067ffffff]
31c28
< percpu: Embedded 22 pages/cpu s49384 r8192 d32536 u90112
---
> percpu: Embedded 16 pages/cpu s34264 r8192 d23080 u65536
33,35c30,33
< printk: log buffer data + meta data: 131072 + 458752 = 589824 bytes
< Dentry cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
< Inode-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
---
> Unknown kernel command line parameters "no5lvl no4lvl", will be passed to user space.
> printk: log buffer data + meta data: 131072 + 409600 = 540672 bytes
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
40c38
< software IO TLB: mapped [mem 0x0000000067f6b000-0x0000000067fab000] (0MB)
---
> software IO TLB: mapped [mem 0x0000000067f8e000-0x0000000067fce000] (0MB)
42,48c40,46
<       fixmap : 0xffffffc4fea00000 - 0xffffffc4feffffff   (6144 kB)
<       pci io : 0xffffffc4ff000000 - 0xffffffc4ffffffff   (  16 MB)
<      vmemmap : 0xffffffc500000000 - 0xffffffc5ffffffff   (4096 MB)
<      vmalloc : 0xffffffc600000000 - 0xffffffd5ffffffff   (  64 GB)
<      modules : 0xffffffff0158d000 - 0xffffffff7fffffff   (2026 MB)
<       lowmem : 0xffffffd600000000 - 0xffffffd607ffffff   ( 128 MB)
<       kernel : 0xffffffff80000000 - 0xfffffffffffffffe   (2047 MB)
---
>       fixmap : 0x94a00000 - 0x94ffffff   (6144 kB)
>       pci io : 0x95000000 - 0x95ffffff   (  16 MB)
>      vmemmap : 0x96000000 - 0x97ffffff   (  32 MB)
>      vmalloc : 0x98000000 - 0xb7ffffff   ( 512 MB)
>      modules : 0xb8000000 - 0xbbffffff   (  64 MB)
>       lowmem : 0xc0000000 - 0xc7ffffff   ( 128 MB)
>       kernel : 0xbc000000 - 0xbfffffff   (  64 MB)
68,69c66,67
< Mount-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
< Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
---
> Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
> Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
77c75
< Memory: 87584K/131072K available (9731K kernel code, 4933K rwdata, 4096K rodata, 2307K init, 484K bss, 41948K reserved, 0K cma-reserved)
---
> Memory: 104768K/131072K available (10043K kernel code, 4722K rwdata, 4096K rodata, 2265K init, 371K bss, 25420K reserved, 0K cma-reserved)
85d82
< DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
88c85
< audit: type=2000 audit(0.104:1): state=initialized audit_enabled=0 res=1
---
> audit: type=2000 audit(0.152:1): state=initialized audit_enabled=0 res=1
92c89
< HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
---
> HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
106c103
< tcp_listen_portaddr_hash hash table entries: 128 (order: 0, 4096 bytes, linear)
---
> tcp_listen_portaddr_hash hash table entries: 256 (order: 0, 5120 bytes, linear)
108,109c105,106
< TCP established hash table entries: 1024 (order: 1, 8192 bytes, linear)
< TCP bind hash table entries: 1024 (order: 4, 65536 bytes, linear)
---
> TCP established hash table entries: 1024 (order: 0, 4096 bytes, linear)
> TCP bind hash table entries: 1024 (order: 3, 40960 bytes, linear)
111,112c108,109
< UDP hash table entries: 256 (order: 3, 40960 bytes, linear)
< UDP-Lite hash table entries: 256 (order: 3, 40960 bytes, linear)
---
> UDP hash table entries: 256 (order: 2, 20480 bytes, linear)
> UDP-Lite hash table entries: 256 (order: 2, 20480 bytes, linear)
120c117
< workingset: timestamp_bits=46 max_order=15 bucket_order=0
---
> workingset: timestamp_bits=14 max_order=15 bucket_order=1
165c162
< goldfish_rtc 101000.rtc: setting system clock to 2025-03-15T08:48:58 UTC (1742028538)
---
> goldfish_rtc 101000.rtc: setting system clock to 2025-03-15T08:51:36 UTC (1742028696)
191c188
< Freeing unused kernel image (initmem) memory: 2304K
---
> Freeing unused kernel image (initmem) memory: 2264K

18 differences


References
==========
[1] https://github.com/riscv-non-isa/riscv-elf-psabi-doc/pull/381
[2] https://github.com/ruyisdk/riscv-gnu-toolchain-rv64ilp32/releases/tag/2025.03.24


Changelog
=========
v3:
 - Base on CONFIG_64BIT instead of CONFIG_32BIT
 - Add lp64-abi userspace support
 - Remove rv64ilp32-abi userspace support
 - Rebase on v6.14-rc1

v2:
https://lore.kernel.org/linux-riscv/20231112061514.2306187-1-guoren@kernel.org/
 - Add u64ilp32 support
 - Rebase v6.5-rc1
 - Enable 64ilp32 vgettimeofday for benchmarking

v1:
https://lore.kernel.org/linux-riscv/20230518131013.3366406-1-guoren@kernel.org/

Guo Ren (Alibaba DAMO Academy) (43):
  rv64ilp32_abi: uapi: Reuse lp64 ABI interface
  rv64ilp32_abi: riscv: Adapt Makefile and Kconfig
  rv64ilp32_abi: riscv: Adapt ULL & UL definition
  rv64ilp32_abi: riscv: Introduce xlen_t to adapt __riscv_xlen !=
    BITS_PER_LONG
  rv64ilp32_abi: riscv: crc32: Utilize 64-bit width to improve the
    performance
  rv64ilp32_abi: riscv: csum: Utilize 64-bit width to improve the
    performance
  rv64ilp32_abi: riscv: arch_hweight: Adapt cpopw & cpop of zbb
    extension
  rv64ilp32_abi: riscv: bitops: Adapt ctzw & clzw of zbb extension
  rv64ilp32_abi: riscv: Reuse LP64 SBI interface
  rv64ilp32_abi: riscv: Update SATP.MODE.ASID width
  rv64ilp32_abi: riscv: Introduce PTR_L and PTR_S
  rv64ilp32_abi: riscv: Introduce cmpxchg_double
  rv64ilp32_abi: riscv: Correct stackframe layout
  rv64ilp32_abi: riscv: Adapt kernel module code
  rv64ilp32_abi: riscv: mm: Adapt MMU_SV39 for 2GiB address space
  rv64ilp32_abi: riscv: Support physical addresses >= 0x80000000
  rv64ilp32_abi: riscv: Adapt kasan memory layout
  rv64ilp32_abi: riscv: kvm: Initial support
  rv64ilp32_abi: irqchip: irq-riscv-intc: Use xlen_t instead of ulong
  rv64ilp32_abi: drivers/perf: Adapt xlen_t of sbiret
  rv64ilp32_abi: asm-generic: Add custom BITS_PER_LONG definition
  rv64ilp32_abi: bpf: Change KERN_ARENA_SZ to 256MiB
  rv64ilp32_abi: compat: Correct compat_ulong_t cast
  rv64ilp32_abi: compiler_types: Add "long long" into __native_word()
  rv64ilp32_abi: exec: Adapt 64lp64 env and argv
  rv64ilp32_abi: file_ref: Use 32-bit width for refcnt
  rv64ilp32_abi: input: Adapt BITS_PER_LONG to dword
  rv64ilp32_abi: iov_iter: Resize kvec to match iov_iter's size
  rv64ilp32_abi: locking/atomic: Use BITS_PER_LONG for scripts
  rv64ilp32_abi: kernel/smp: Disable CSD_LOCK_WAIT_DEBUG
  rv64ilp32_abi: maple_tree: Use BITS_PER_LONG instead of CONFIG_64BIT
  rv64ilp32_abi: mm: Remove _folio_nr_pages
  rv64ilp32_abi: mm/auxvec: Adapt mm->saved_auxv[] to Elf64
  rv64ilp32_abi: mm: Adapt vm_flags_t struct
  rv64ilp32_abi: net: Use BITS_PER_LONG in struct dst_entry
  rv64ilp32_abi: printf: Use BITS_PER_LONG instead of CONFIG_64BIT
  rv64ilp32_abi: random: Adapt fast_pool struct
  rv64ilp32_abi: syscall: Use CONFIG_64BIT instead of BITS_PER_LONG
  rv64ilp32_abi: sysinfo: Adapt sysinfo structure to lp64 uapi
  rv64ilp32_abi: tracepoint-defs: Using u64 for trace_print_flags.mask
  rv64ilp32_abi: tty: Adapt ptr_to_compat
  rv64ilp32_abi: memfd: Use vm_flag_t
  riscv: Fixup address space overlay of print_mlk

 arch/riscv/Kconfig                            |  15 +-
 arch/riscv/Makefile                           |  17 ++
 arch/riscv/configs/rv64ilp32.config           |   1 +
 arch/riscv/include/asm/arch_hweight.h         |   8 +-
 arch/riscv/include/asm/asm.h                  |  13 +-
 arch/riscv/include/asm/bitops.h               |  21 +-
 arch/riscv/include/asm/checksum.h             |   4 +
 arch/riscv/include/asm/cmpxchg.h              |  57 ++++-
 arch/riscv/include/asm/cpu_ops_sbi.h          |   4 +-
 arch/riscv/include/asm/csr.h                  | 227 +++++++++---------
 arch/riscv/include/asm/kasan.h                |   6 +-
 arch/riscv/include/asm/kvm_aia.h              |  32 +--
 arch/riscv/include/asm/kvm_host.h             | 192 +++++++--------
 arch/riscv/include/asm/kvm_nacl.h             |  26 +-
 arch/riscv/include/asm/kvm_vcpu_insn.h        |   4 +-
 arch/riscv/include/asm/kvm_vcpu_pmu.h         |   8 +-
 arch/riscv/include/asm/kvm_vcpu_sbi.h         |   4 +-
 arch/riscv/include/asm/page.h                 |  23 +-
 arch/riscv/include/asm/pgtable-64.h           |  55 +++--
 arch/riscv/include/asm/pgtable.h              |  60 ++++-
 arch/riscv/include/asm/processor.h            |  12 +-
 arch/riscv/include/asm/ptrace.h               |  92 +++----
 arch/riscv/include/asm/sbi.h                  |  32 +--
 arch/riscv/include/asm/scs.h                  |   4 +-
 arch/riscv/include/asm/sparsemem.h            |   2 +-
 arch/riscv/include/asm/stacktrace.h           |   6 +
 arch/riscv/include/asm/switch_to.h            |   4 +-
 arch/riscv/include/asm/syscall_table.h        |   2 +-
 arch/riscv/include/asm/thread_info.h          |   2 +-
 arch/riscv/include/asm/timex.h                |   4 +-
 arch/riscv/include/asm/unistd.h               |   4 +-
 arch/riscv/include/uapi/asm/bitsperlong.h     |   6 +
 arch/riscv/include/uapi/asm/elf.h             |   4 +-
 arch/riscv/include/uapi/asm/kvm.h             |  56 ++---
 arch/riscv/include/uapi/asm/ptrace.h          |  97 ++++----
 arch/riscv/include/uapi/asm/ucontext.h        |   7 +-
 arch/riscv/include/uapi/asm/unistd.h          |   2 +-
 arch/riscv/kernel/compat_signal.c             |   4 +-
 arch/riscv/kernel/cpu.c                       |   4 +-
 arch/riscv/kernel/cpu_ops_sbi.c               |   4 +-
 arch/riscv/kernel/entry.S                     |  32 +--
 arch/riscv/kernel/head.S                      | 120 ++++++++-
 arch/riscv/kernel/module.c                    |   2 +-
 arch/riscv/kernel/process.c                   |   8 +-
 arch/riscv/kernel/sbi_ecall.c                 |  22 +-
 arch/riscv/kernel/signal.c                    |   4 +-
 arch/riscv/kernel/traps.c                     |   4 +-
 arch/riscv/kernel/vector.c                    |   2 +-
 arch/riscv/kvm/aia.c                          |  26 +-
 arch/riscv/kvm/aia_imsic.c                    |   6 +-
 arch/riscv/kvm/main.c                         |   2 +-
 arch/riscv/kvm/mmu.c                          |  10 +-
 arch/riscv/kvm/tlb.c                          |  76 +++---
 arch/riscv/kvm/vcpu.c                         |  10 +-
 arch/riscv/kvm/vcpu_exit.c                    |   4 +-
 arch/riscv/kvm/vcpu_insn.c                    |  12 +-
 arch/riscv/kvm/vcpu_onereg.c                  |  18 +-
 arch/riscv/kvm/vcpu_pmu.c                     |   8 +-
 arch/riscv/kvm/vcpu_sbi_base.c                |   2 +-
 arch/riscv/kvm/vmid.c                         |   4 +-
 arch/riscv/lib/crc32-riscv.c                  |  35 +--
 arch/riscv/lib/csum.c                         |  48 ++--
 arch/riscv/mm/context.c                       |  12 +-
 arch/riscv/mm/fault.c                         |  12 +-
 arch/riscv/mm/init.c                          |  63 +++--
 arch/riscv/mm/kasan_init.c                    |   2 +-
 arch/riscv/mm/pageattr.c                      |   4 +-
 arch/riscv/mm/pgtable.c                       |   2 +-
 arch/riscv/net/bpf_jit_comp64.c               |   6 +-
 drivers/char/random.c                         |   8 +
 drivers/input/input.c                         |   4 +
 drivers/irqchip/irq-riscv-intc.c              |   9 +-
 drivers/perf/riscv_pmu_sbi.c                  |   4 +-
 drivers/tty/tty_io.c                          |   4 +
 fs/exec.c                                     |   4 +
 fs/proc/loadavg.c                             |  10 +-
 fs/proc/task_mmu.c                            |   9 +-
 include/asm-generic/bitsperlong.h             |   2 +
 include/asm-generic/module.h                  |   2 +-
 include/linux/atomic/atomic-long.h            | 174 +++++++-------
 include/linux/compiler_types.h                |   7 +
 include/linux/file_ref.h                      |   4 +-
 include/linux/maple_tree.h                    |   2 +-
 include/linux/memfd.h                         |   4 +-
 include/linux/mm.h                            |  14 +-
 include/linux/mm_types.h                      |  10 +-
 include/linux/sched/loadavg.h                 |   4 +
 include/linux/smp_types.h                     |   2 +-
 include/linux/socket.h                        |  35 +++
 include/linux/tracepoint-defs.h               |   4 +
 include/linux/uio.h                           |   6 +
 include/net/dst.h                             |   6 +-
 include/uapi/asm-generic/siginfo.h            |  50 ++++
 include/uapi/asm-generic/signal.h             |  35 +++
 include/uapi/asm-generic/stat.h               |  25 ++
 include/uapi/linux/atm.h                      |   7 +
 include/uapi/linux/atmdev.h                   |   7 +
 include/uapi/linux/auto_fs.h                  |   6 +
 include/uapi/linux/blkpg.h                    |   7 +
 include/uapi/linux/btrfs.h                    |  19 ++
 include/uapi/linux/capi.h                     |  11 +
 include/uapi/linux/fs.h                       |  12 +
 include/uapi/linux/futex.h                    |  18 ++
 include/uapi/linux/if.h                       |   6 +
 include/uapi/linux/netfilter/x_tables.h       |   8 +
 include/uapi/linux/netfilter_ipv4/ip_tables.h |   7 +
 include/uapi/linux/nfs4_mount.h               |  14 ++
 include/uapi/linux/ppp-ioctl.h                |   7 +
 include/uapi/linux/sctp.h                     |   3 +
 include/uapi/linux/sem.h                      |  38 +++
 include/uapi/linux/socket.h                   |   7 +
 include/uapi/linux/sysctl.h                   |  32 +++
 include/uapi/linux/sysinfo.h                  |  20 ++
 include/uapi/linux/uhid.h                     |   7 +
 include/uapi/linux/uio.h                      |  11 +
 include/uapi/linux/usb/tmc.h                  |  14 ++
 include/uapi/linux/usbdevice_fs.h             |  50 ++++
 include/uapi/linux/uvcvideo.h                 |  14 ++
 include/uapi/linux/vfio.h                     |   7 +
 include/uapi/linux/videodev2.h                |   7 +
 kernel/bpf/arena.c                            |  19 +-
 kernel/compat.c                               |  15 +-
 kernel/sched/loadavg.c                        |   4 +
 kernel/sys.c                                  |   8 +
 lib/Kconfig.debug                             |   1 +
 lib/vsprintf.c                                |   2 +-
 mm/debug.c                                    |   4 +
 mm/internal.h                                 |   2 +-
 mm/memfd.c                                    |   8 +-
 mm/memory.c                                   |   4 +
 scripts/atomic/gen-atomic-long.sh             |   4 +-
 scripts/checksyscalls.sh                      |   2 +-
 132 files changed, 1728 insertions(+), 803 deletions(-)
 create mode 100644 arch/riscv/configs/rv64ilp32.config

-- 
2.40.1


