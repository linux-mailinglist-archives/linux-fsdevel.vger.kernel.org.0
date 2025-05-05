Return-Path: <linux-fsdevel+bounces-48136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795ECAA9EB7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 00:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F3A3B07C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 22:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B4D275868;
	Mon,  5 May 2025 22:03:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482C01FC0FC;
	Mon,  5 May 2025 22:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746482601; cv=none; b=A5u9Rems5aBHPbckfq/0IlvnrbPVtKVK6yb2fa3ZlB1yOdLDc5KtaoGtCTsVobZ/EwO2qeSehyovGeFklK94swwHFAlXXav6XfNJpH+jy3QopMzQxDDWhF/BmHRtomo0h7IpQ70oNDCstpK1B3rPVwZHesNyD+yNFgsKJ9XvmxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746482601; c=relaxed/simple;
	bh=4tIdy1eNVabgIkyQ/aGtInUI8WyketjcPeyE7XfTSKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FqA52Axy1SRXjET5+XEPJ4iQ1if2tCbFsBafmylJM0iC5k/eYpex7GPx77CgsrnUEkFoVzCcikLH7w/heR3AKKVNRHa0C2e1ZcWcJNxQdhtC32m7GUhSKSCW5I9jgDmhIJxh66VEVH/QWOzU5Yb+62E72Dt9q35nwAakbcz6nJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7370f389d07so755421b3a.3;
        Mon, 05 May 2025 15:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746482598; x=1747087398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UyuTRWwa63sgzcu4uOhEilYwscaDbdvjA6+RJR1uCNM=;
        b=olsBLl+hEyYjEteQVgrsILZkbXWuCC7HiILQbQXQEKmX1RWReALUt7WJzoLS+Uva5k
         l9D+Emxvxc4hp+0E8zFqhswiBvDCFySLX3RvRLXdvgVC9revALs4NPciA3viu6kFsrPI
         83s+C+2dRgBnDmot17G0DsThD2l13Mo0JW7JEWL6bit1421xVTzQ4bEwOslOs9p3yheP
         50z/7MtCM5c9j6g4bfw0/Wwwz6QIoLM5IBJ2kAqGBfqmLg2gR/s03lQUWhuU7GYMcwUz
         j+OV8gyc2akWYJP2YUhCB9sIsgWna282AvxlQL0ZglSeFNSJW/Ll9aQv8JUZPAPwVTXb
         7v1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtppkaTvv9K/CwkkTChvQiUv/76Tn76Gvq+CZ3knjReblbowiaEVKHlkv2dqVYMLcc9AhCYoIOX77/SRep@vger.kernel.org, AJvYcCX1NuhK6xon4SJVO5Qf0xLlK36hreU7/yhKH185WarehL9d9P7kszWpYR39DVZBPWK4snqiskHeS0ysIXcX@vger.kernel.org, AJvYcCXx8+0O9VTPyNNLVZkb+j3eVE00Nupud/AGE+G2QqXU6/zwnwGeCmlnGjzESYFBnP47nAwJuTsrXX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlVLoWb8rftxtDuYSeE6tZRHwPquCj+kHYDA1hSDvfmMt1ExaJ
	vcV7RcWb6BRbTudRxT/IFEwfxSY4QopRsMpAg3I995LO8xAwkx7bCQsI0w==
X-Gm-Gg: ASbGncvP60kqagjE/7JkVLyj+4rDE/y6jEtjcwuFXWco+MOEW1/3eH3nyImbCdW9vh5
	4scn6NVVm9UUvp8kopSW0M/vG2kyiP2kkFIYiXZvWzp/+3IAm0cEE+rVfXiLYZyAdXSF0GBVXvI
	X2zI4uG5Lnb1jZI94L6O5eRSLKs+AQjMLb0fh5SL49EdWKt+BTzP9leAi/N5I0hxtYWJFfRvaP8
	kHTc8DQQi5Y5OLzmxkZLu4uwUhioj2nj67OAHpYrV52iNYrz22Sx8o93bpboxcwB/hEpv5+PMp6
	yYaBupOFigkTAW234B3P/hA4ou5/RA==
X-Google-Smtp-Source: AGHT+IGJ7q5ChXB+Ie7Ba17UQu8Vj6IELeCByAVztJKx1l+Wr2tbG6+abolop0kGzINjHUa6QwOVcw==
X-Received: by 2002:a17:90b:4ace:b0:2fe:91d0:f781 with SMTP id 98e67ed59e1d1-30a4e579edemr8085578a91.2.1746482598219;
        Mon, 05 May 2025 15:03:18 -0700 (PDT)
Received: from fedora.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a476267d5sm9579251a91.33.2025.05.05.15.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 15:03:17 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>
Cc: byungchul@sk.com,
	max.byungchul.park@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>
Subject: [PATCH] fs: Prevent panic from NULL dereference in alloc_fs_context() during do_exit()
Date: Tue,  6 May 2025 05:38:02 +0900
Message-ID: <20250505203801.83699-2-ysk@kzalloc.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The function alloc_fs_context() assumes that current->nsproxy and its
net_ns field are valid. However, this assumption can be violated in
cases such as task teardown during do_exit(), where current->nsproxy can
be NULL or already cleared.

This issue was triggered during stress-ng's kernel-coverage.sh testing,
Since alloc_fs_context() can be invoked in various contexts =E2=80=94 inclu=
ding
from asynchronous or teardown paths like do_exit() =E2=80=94 it's difficult=
 to
guarantee that its input arguments are always valid.

A follow-up patch will improve the granularity of this fix by moving the
check closer to the actual mount trigger(e.g., in efivarfs_pm_notify()).

Observed on Apple M2 (fedora 42 asahi remix) during stress-ng-dev:

[  137.769615] Unable to handle kernel NULL pointer dereference at virtual =
address 0000000000000028
[  137.769691] Mem abort info:
[  137.769693]   ESR =3D 0x0000000096000007
[  137.769694]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  137.769695]   SET =3D 0, FnV =3D 0
[  137.769696]   EA =3D 0, S1PTW =3D 0
[  137.769697]   FSC =3D 0x07: level 3 translation fault
[  137.769698] Data abort info:
[  137.769699]   ISV =3D 0, ISS =3D 0x00000007, ISS2 =3D 0x00000000
[  137.769700]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[  137.769700]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[  137.769702] user pgtable: 16k pages, 48-bit VAs, pgdp=3D0000000810df28b0
[  137.769703] [0000000000000028] pgd=3D08000008ace3c403, p4d=3D08000008ace=
3c403, pud=3D08000008f7658403, pmd=3D08000008f765c403, pte=3D00000000000000=
00
[  137.769743] Internal error: Oops: 0000000096000007 [#1] SMP
[  137.769745] Modules linked in: uinput rfcomm snd_seq_dummy snd_hrtimer s=
nd_seq snd_seq_device uas usb_storage nf_conntrack_netbios_ns nf_conntrack_=
broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf=
_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_connt=
rack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables qrtr uhid bnep brcmfmac=
_wcc sunrpc binfmt_misc brcmfmac brcmutil cfg80211 hci_bcm4377 bluetooth mm=
c_core rfkill aop_als aop_las industrialio macsmc_hid snd_soc_aop apple_isp=
 videobuf2_dma_sg ofpart videobuf2_memops videobuf2_v4l2 spi_nor mtd videod=
ev snd_soc_cs42l84 snd_soc_tas2764 videobuf2_common snd_soc_apple_mca mc ap=
ple_soc_cpufreq snd_soc_macaudio snd_soc_core snd_compress ac97_bus leds_pw=
m joydev loop dm_multipath nfnetlink zram lz4hc_compress lz4_compress hid_a=
pple nvmem_spmi_mfd tps6598x macsmc_hwmon macsmc_reboot dockchannel_hid mac=
smc_power rtc_macsmc gpio_macsmc simple_mfd_spmi polyval_ce polyval_generic=
 ghash_ce sha3_ce appledrm dwc3 phy_apple_atc sha512_ce
[  137.769778]  apple_dcp typec sha512_arm64 aop apple_dockchannel ulpi mac=
smc_rtkit mux_core apple_wdt macsmc spmi_apple_controller drm_dma_helper nv=
mem_apple_efuses udc_core apple_rtkit_helper snd_pcm_dmaengine snd_pcm asah=
i spi_apple clk_apple_nco snd_timer snd i2c_pasemi_platform pwm_apple pinct=
rl_apple_gpio apple_admac soundcore i2c_pasemi_core apple_dart xhci_plat_hc=
d vfat fat nvme_apple apple_sart nvme_core nvme_auth scsi_dh_rdac scsi_dh_e=
mc scsi_dh_alua fuse i2c_dev
[  137.769796] CPU: 6 UID: 0 PID: 3632 Comm: stress-ng-dev Kdump: loaded Ta=
inted: G S      W          6.14.2-401.asahi.fc42.aarch64+16k-debug #1
[  137.769799] Tainted: [S]=3DCPU_OUT_OF_SPEC, [W]=3DWARN
[  137.769799] Hardware name: Apple MacBook Air (13-inch, M2, 2022) (DT)
[  137.769801] pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=
=3D--)
[  137.769802] pc : alloc_fs_context+0x98/0x2e8
[  137.769807] lr : alloc_fs_context+0x70/0x2e8
[  137.769808] sp : ffff80009b5479b0
[  137.769809] x29: ffff80009b5479b0 x28: ffff5a120e960000 x27: 00000000000=
00000
[  137.769811] x26: 0000000000000002 x25: ffffa55a71473000 x24: 00000000000=
00000
[  137.769812] x23: 0000000000000000 x22: ffffa55a7170ddc8 x21: 00000000000=
00000
[  137.769814] x20: 0000000000000000 x19: ffff5a1284390200 x18: ffffa55a73a=
de328
[  137.769815] x17: 0000000000000000 x16: 0000000000000000 x15: ffffa55a739=
51c70
[  137.769816] x14: 0000000000000002 x13: 000000000003bb2a x12: 00000000000=
00002
[  137.769818] x11: 000000000003bb28 x10: ffffa55a71473000 x9 : ffffa55a6e0=
56b8c
[  137.769819] x8 : ffff5a120e960000 x7 : ffffa55a714727b0 x6 : 00000000000=
00006
[  137.769821] x5 : 0000000000000040 x4 : 0000000000000001 x3 : ffff5a17dd5=
bfa28
[  137.769822] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 00000000000=
00000
[  137.769824] Call trace:
[  137.769825]  alloc_fs_context+0x98/0x2e8 (P)
[  137.769827]  fs_context_for_mount+0x28/0x40
[  137.769828]  vfs_kern_mount.part.0+0x28/0xe8
[  137.769830]  vfs_kern_mount+0x1c/0x38
[  137.769831]  efivarfs_pm_notify+0xf8/0x2f8
[  137.769834]  notifier_call_chain+0xb4/0x220
[  137.769836]  blocking_notifier_call_chain+0x4c/0x78
[  137.769837]  pm_notifier_call_chain+0x2c/0x40
[  137.769840]  snapshot_release+0x60/0xa0
[  137.769841]  __fput+0xf8/0x310
[  137.769843]  ____fput+0x1c/0x30
[  137.769845]  task_work_run+0x88/0x120
[  137.769846]  do_exit+0x19c/0x450
[  137.769848]  do_group_exit+0x38/0xc0
[  137.769849]  __arm64_sys_exit_group+0x20/0x28
[  137.769851]  invoke_syscall.constprop.0+0x64/0xe8
[  137.769853]  el0_svc_common.constprop.0+0xc0/0xe8
[  137.769854]  do_el0_svc+0x24/0x38
[  137.769855]  el0_svc+0x54/0x230
[  137.769857]  el0t_64_sync_handler+0x10c/0x138
[  137.769859]  el0t_64_sync+0x1bc/0x1c0
[  137.769861] Code: f821001f f9006e60 d5384100 f9463c00 (f9401417)
[  137.769862] ---[ end trace 0000000000000000 ]---
[  137.769864] Fixing recursive fault but reboot is needed!
[  137.769866] check_preemption_disabled: 35 callbacks suppressed
[  137.769867] BUG: using smp_processor_id() in preemptible [00000000] code=
: stress-ng-dev/3632
[  137.769869] caller is debug_smp_processor_id+0x20/0x38
[  137.769871] CPU: 6 UID: 0 PID: 3632 Comm: stress-ng-dev Kdump: loaded Ta=
inted: G S    D W          6.14.2-401.asahi.fc42.aarch64+16k-debug #1
[  137.769872] Tainted: [S]=3DCPU_OUT_OF_SPEC, [D]=3DDIE, [W]=3DWARN
[  137.769873] Hardware name: Apple MacBook Air (13-inch, M2, 2022) (DT)
[  137.769873] Call trace:
[  137.769873]  show_stack+0x30/0x98 (C)
[  137.769874]  dump_stack_lvl+0xa8/0xe8
[  137.769876]  dump_stack+0x18/0x34
[  137.769876]  check_preemption_disabled+0x120/0x128
[  137.769878]  debug_smp_processor_id+0x20/0x38
[  137.769879]  __schedule+0x4c/0x718
[  137.769880]  do_task_dead+0x58/0x68
[  137.769882]  make_task_dead+0xe8/0x150
[  137.769883]  die+0x210/0x258
[  137.769884]  die_kernel_fault+0x1ac/0x1c8
[  137.769885]  __do_kernel_fault+0x1cc/0x1d8
[  137.769886]  do_page_fault+0x2b4/0x9f0
[  137.769888]  do_translation_fault+0x54/0xf0
[  137.769889]  do_mem_abort+0x48/0xa0
[  137.769890]  el1_abort+0x58/0xc8
[  137.769891]  el1h_64_sync_handler+0xf0/0x120
[  137.769892]  el1h_64_sync+0x84/0x88
[  137.769892]  alloc_fs_context+0x98/0x2e8 (P)
[  137.769893]  fs_context_for_mount+0x28/0x40
[  137.769894]  vfs_kern_mount.part.0+0x28/0xe8
[  137.769895]  vfs_kern_mount+0x1c/0x38
[  137.769896]  efivarfs_pm_notify+0xf8/0x2f8
[  137.769897]  notifier_call_chain+0xb4/0x220
[  137.769897]  blocking_notifier_call_chain+0x4c/0x78
[  137.769898]  pm_notifier_call_chain+0x2c/0x40
[  137.769899]  snapshot_release+0x60/0xa0
[  137.769900]  __fput+0xf8/0x310
[  137.769901]  ____fput+0x1c/0x30
[  137.769902]  task_work_run+0x88/0x120
[  137.769903]  do_exit+0x19c/0x450
[  137.769904]  do_group_exit+0x38/0xc0
[  137.769905]  __arm64_sys_exit_group+0x20/0x28
[  137.769906]  invoke_syscall.constprop.0+0x64/0xe8
[  137.769907]  el0_svc_common.constprop.0+0xc0/0xe8
[  137.769907]  do_el0_svc+0x24/0x38
[  137.769908]  el0_svc+0x54/0x230
[  137.769909]  el0t_64_sync_handler+0x10c/0x138
[  137.769910]  el0t_64_sync+0x1bc/0x1c0

Observed on Fedora 42 on Apple Virtualization during the same test:

[  473.893249] Unable to handle kernel NULL pointer dereference at virtual =
address 0000000000000028
[  473.893253] Mem abort info:
[  473.893256]   ESR =3D 0x0000000096000004
[  473.893258]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  473.893262]   SET =3D 0, FnV =3D 0
[  473.893264]   EA =3D 0, S1PTW =3D 0
[  473.893267]   FSC =3D 0x04: level 0 translation fault
[  473.893270] Data abort info:
[  473.893272]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
[  473.893275]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[  473.893278]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[  473.893282] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000027468e000
[  473.893285] [0000000000000028] pgd=3D0000000000000000, p4d=3D00000000000=
00000
[  473.893294] Internal error: Oops: 0000000096000004 [#1]  SMP
[  473.893298] Modules linked in: vfio_iommu_type1 vfio cuse vhost_net tun =
vhost vhost_iotlb tap uhid overlay isofs uinput snd_seq_dummy snd_hrtimer n=
f_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft=
_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject =
nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfki=
ll ip_set nf_tables qrtr sunrpc virtio_snd snd_seq snd_seq_device snd_pcm s=
nd_timer snd virtio_net net_failover failover virtio_balloon soundcore vfat=
 fat joydev loop nfnetlink vsock_loopback vmw_vsock_virtio_transport_common=
 zram vmw_vsock_vmci_transport lz4hc_compress vmw_vmci lz4_compress vsock u=
as polyval_ce polyval_generic ghash_ce sha3_ce usb_storage sha512_ce virtio=
_gpu sha512_arm64 virtio_dma_buf apple_mfi_fastcharge fuse
[  473.893383] CPU: 2 UID: 0 PID: 4496 Comm: stress-ng-dev Kdump: loaded No=
t tainted 6.15.0-rc4+ #1 PREEMPT(voluntary)
[  473.893387] Hardware name: Apple Inc. Apple Virtualization Generic Platf=
orm, BIOS 2075.101.2.0.0 03/12/2025
[  473.893390] pstate: 81400005 (Nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=
=3D--)
[  473.893394] pc : alloc_fs_context+0xc4/0x460
[  473.893401] lr : alloc_fs_context+0xa0/0x460
[  473.893405] sp : ffff80008f01b7d0
[  473.893406] x29: ffff80008f01b7d0 x28: ffff800084754520 x27: 00000000000=
00006
[  473.893411] x26: 0000000000000004 x25: ffff0000cd714a28 x24: ffff0000ca9=
76540
[  473.893416] x23: ffff000232890000 x22: ffff80008452aa80 x21: 00000000000=
00000
[  473.893420] x20: 0000000000000000 x19: ffff0001215ab200 x18: 00000000000=
00001
[  473.893425] x17: ffff00015083bb00 x16: 0f043b79c558efdb x15: 00000000000=
00000
[  473.893429] x14: 0000000000000063 x13: 657461747320656c x12: 62616972617=
62067
[  473.893434] x11: 0000000000000000 x10: 0000000000ff0100 x9 : 00000000000=
00000
[  473.893438] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 00000000000=
00000
[  473.893442] x5 : fffffd7fbf054dd8 x4 : ffff00032d538da8 x3 : ffff00032d5=
38da8
[  473.893447] x2 : ffff80008f01b440 x1 : ffff800082a4aeb8 x0 : 00000000000=
00000
[  473.893452] Call trace:
[  473.893453]  alloc_fs_context+0xc4/0x460 (P)
[  473.893458]  fs_context_for_mount+0x40/0x58
[  473.893462]  vfs_kern_mount+0x44/0x158
[  473.893468]  efivarfs_pm_notify+0x124/0x320
[  473.893472]  notifier_call_chain+0x11c/0x300
[  473.893476]  blocking_notifier_call_chain+0x60/0x98
[  473.893480]  pm_notifier_call_chain+0x38/0x50
[  473.893484]  snapshot_release+0x9c/0xc0
[  473.893489]  __fput+0x1c4/0x4f0
[  473.893494]  ____fput+0x2c/0x70
[  473.893497]  task_work_run+0x100/0x150
[  473.893501]  do_exit+0x2e4/0xfb8
[  473.893506]  do_group_exit+0xd8/0xe0
[  473.893511]  __arm64_sys_exit_group+0x24/0x30
[  473.893515]  invoke_syscall+0x90/0x180
[  473.893520]  el0_svc_common+0x140/0x178
[  473.893523]  do_el0_svc+0x38/0x50
[  473.893527]  el0_svc+0x58/0x158
[  473.893533]  el0t_64_sync_handler+0x78/0x108
[  473.893538]  el0t_64_sync+0x1bc/0x1c0
[  473.893543] Code: 140000ab 97ebb69c f9006e78 f9463ee8 (f9401519)
[  473.893545] ---[ end trace 0000000000000000 ]---
[  473.893600] Fixing recursive fault but reboot is needed!
[  473.893604] check_preemption_disabled: 40 callbacks suppressed

Tested-on: Apple M2 (fedora 42 asahi remix, 16k pages)
Tested-on: Fedora 42 on Apple Virtualization Generic Platform
Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 fs/fs_context.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 582d33e81117..529de43b8b5e 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -282,6 +282,9 @@ static struct fs_context *alloc_fs_context(struct file_=
system_type *fs_type,
 	struct fs_context *fc;
 	int ret =3D -ENOMEM;
=20
+	if (!current->nsproxy || !current->nsproxy->net_ns)
+		return ERR_PTR(-EINVAL);
+
 	fc =3D kzalloc(sizeof(struct fs_context), GFP_KERNEL_ACCOUNT);
 	if (!fc)
 		return ERR_PTR(-ENOMEM);
--=20
2.49.0


