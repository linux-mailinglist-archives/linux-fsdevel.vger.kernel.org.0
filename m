Return-Path: <linux-fsdevel+bounces-15618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4252890D99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 23:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625B21F2521B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 22:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9742613AD04;
	Thu, 28 Mar 2024 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="M2mkRrOQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D8F12DDAC
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711664990; cv=none; b=VTl/p2ESmWiGPvD6ric0iH7N5ykgO+a6SnNoKO2ZFjGVPKNVC+iyHbRFMNy7Ji+gyNsqZYfHs2RQ/VLrlxOcqvezkamPlaSEu9i4Qq4XGwUu0Nuno3py/qrxuZw4LgSv2KBYefaBl50umLH4PiOfCrj+li24JdziaVY3AMnpC6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711664990; c=relaxed/simple;
	bh=AhAZFWyVIj43769K8qWO+kd9kc/H11h4Vy/5wgkSPy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6O9AGvVKO5bjdk11HIDc5VaOW/QIWlMm9/TjTOamJwnnoKwJQ3w/vLPNkHGSZ8oLyCypVEET8IKLxCcflk7M2SqPbkAeMeEQp98/KXQKCKpbk3KJKci2wy2BQcYSJ3z7lePrKVYRDZEvlOolcEG4otNyuJ30/VU4WD8i5fh0Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=M2mkRrOQ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 074FB42495
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 22:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711664983;
	bh=cmvb3z5lDkpk22Gt5OjrHjimBIyUncQSGoXFgXwGdY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=M2mkRrOQvxL5irZZzFRgaX8Hk5GfVaPa+gAodHtcgL0ylcFj6NP/xBKMy6QVPcBm/
	 VpiwvVUVQ5UdU57kq1TpMnjKkZPGK21rjC7jTmkghR1+mp84nuh2swHjVmp9nJAi2A
	 Xnxk+ETr4aDpJ3PBKPTsoGnLMnFrCkOlVipbAP7GLyF5p2iaXqzG4WSnIKApfozl4u
	 RxTg4naqnIINO+ARsDE5OnL5tpsRZFq4fBCsWRZttf920nTY1u69i58bWr/mmYeVwt
	 5cWHUmSJzfhmgAR0fK4MJjc+/nD7omlK2t2gYqRVdd8Ga3jmSMqo5Nx82ahxn6TXQp
	 YM41mhOH9TZrQ==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56c1ac93679so1073951a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 15:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711664981; x=1712269781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cmvb3z5lDkpk22Gt5OjrHjimBIyUncQSGoXFgXwGdY0=;
        b=rdHIqur+lcgP8whhlBXY5Dchp7GhYB5y9r3B+JgK3xuGEzC98SJey+KZil0dA1OgEQ
         HT+/ORFvwkPom2Baw+uL7GzMgv/DqPLESlSl+ZWjP3Dkl+dENsrBHmX7n6bnKpSjhKCx
         dqXD80JssOw0URtp0F0Mjh3WqycnKMcIMRw8kk2vqeMzrjoqLrcayKVc73Tuy3tkZOEt
         1v6W/g4yCSYEaIaiGm+J1e8FtcvvdmFi8ZHqvt1bnzKcCRkwSpCWPseAG3onsg/W0kNW
         da0vBnv8y3rjv2YPG3kR6Tc5j+DgVCQg3maUJyFIP5lnb/tTo2VrZf9SeH3NIRKnSsGj
         DTDg==
X-Forwarded-Encrypted: i=1; AJvYcCXIYVRhW7f5mG2Fn5+oGk39O2RhmMBG1vIpvZQUUTTNcTJ87AFyGWt1p2ifPcn3gThYsBjwnwF+B7Ws/aDu2QsJ30ERXOiOHXTyzy46DQ==
X-Gm-Message-State: AOJu0YzZAhBMl4WGwDrWVIW0ui69h3NG89qS0U8oCUXLXv+3pUjPH8YQ
	/+s2+ki0cV2YCXH1ubzg+hdvu9sKEgpTbs1qz634uaT8Ywu7t4knO8Pgij9ok7JvBnfLnfB0Hua
	KmfKDT8DbMLG/8frjJaNb1se3Q7bMf5uyCwim9AOAyx0JVazzZSHb08XaC/AYGCeAJb+KyAz9Hv
	LO32Sgw0u46eeJVJoOwF8qUe0Eg4djOv7aHu5StNIsbdQyTdn4f4BpsO6XKBvzk1HThnk=
X-Received: by 2002:a05:6402:34d6:b0:56b:a077:2eee with SMTP id w22-20020a05640234d600b0056ba0772eeemr410999edc.4.1711664981555;
        Thu, 28 Mar 2024 15:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4WFS3ISo4GyU+NQ0UItX7Z91uJD3qXe+LMZ+VgUAN4k3xThawNSFjngHceStuxScwKcIoyeup4iYM7LbAei8=
X-Received: by 2002:a05:6402:34d6:b0:56b:a077:2eee with SMTP id
 w22-20020a05640234d600b0056ba0772eeemr410989edc.4.1711664981212; Thu, 28 Mar
 2024 15:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b8e4d93c-f2f2-4a0e-a47f-15a740434356@mitchellaugustin.com>
In-Reply-To: <b8e4d93c-f2f2-4a0e-a47f-15a740434356@mitchellaugustin.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Thu, 28 Mar 2024 17:29:30 -0500
Message-ID: <CAHTA-ubfwwB51A5Wg5M6H_rPEQK9pNf8FkAGH=vr=FEkyRrtqw@mail.gmail.com>
Subject: Re: [PATCH] fs/aio: obey min_nr when doing wakeups
To: kent.overstreet@linux.dev
Cc: linux-aio@kvack.org, brauner@kernel.org, bcrl@kvack.org, 
	linux-fsdevel@vger.kernel.org, colin.i.king@gmail.com, 
	dann frazier <dann.frazier@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Hello!

While running the stress-ng disk test suite as part of our
certification process for Noble on Nvidia Grace machines, I observed a
kernel panic during the aiol test. This issue initially presented
itself on the Ubuntu 6.8.0-11-generic kernel, but I have verified that
it is also present in the latest mainline 6.8 kernel as well as the
master branch of the Linus tree (at least as late as
8d025e2092e29bfd13e56c78e22af25fac83c8ec). The panic does not occur
during every run of the aiol test on affected kernels, but it does
appear at least 25% of the time based on my tests. I'm also not
entirely sure if this is related, but I have only personally observed
this issue on Grace when disks were set up with LVM enabled during the
Ubuntu installation phase (and thus, stress-ng was stressing /dev/dm-0
rather than /dev/nvme*). (See this Ubuntu BugLink for more details on
reproducing this:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2058557).

I have determined that this commit
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/aio.c?id=71eb6b6b0ba93b1467bccff57b5de746b09113d2)
introduced this regression. On this commit's parent (and all other
ancestors I tested during the bisect), I was able to run the aiol test
15 times in a row without any panics, but on this commit (and all
descendants I tested, including the latest version of the Linus tree),
there would typically be a kernel panic within the first 5 executions
of the aiol test. The trace also supports this, as it shows the crash
occurring during the wake_up_process() call inside aio_complete(),
which is introduced in this commit. To further verify this, I also
reverted this patch on the latest Ubuntu kernel, and that version of
the kernel did not panic after 15 aiol test runs.

I've CC'd Colin King here since stress-ng helped us find this bug.
Thanks, Colin!

Let me know if you need any more information from me that would be
useful in fixing this regression.

Thanks,

Mitchell Augustin

Kernel panic trace:

28 Mar 21:28: Running stress-ng aiol stressor for 240 seconds...
[  453.969106] Unable to handle kernel NULL pointer dereference at virtual add
ress 00000000000008f5
[  453.978106] Mem abort info:
[  453.980957]   ESR = 0x0000000096000005
[  453.984786]   EC = 0x25: DABT (current EL), IL = 32 bits
[  453.990215]   SET = 0, FnV = 0
[  453.993331]   EA = 0, S1PTW = 0
[  453.996537]   FSC = 0x05: level 1 translation fault
[  454.001521] Data abort info:
[  454.004459]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[  454.010065]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  454.015225]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  454.020653] user pgtable: 64k pages, 48-bit VAs, pgdp=00001000d9a70a00
[  454.027328] [00000000000008f5] pgd=0000000000000000, p4d=0000000000000000,
pud=0000000000000000
[  454.036229] Internal error: Oops: 0000000096000005 [#1] SMP
[  454.041928] Modules linked in: qrtr cfg80211 binfmt_misc nls_iso8859_1 dax_
hmem cxl_acpi acpi_ipmi cxl_core onboard_usb_hub ipmi_ssif input_leds einj uio
_pdrv_genirq ipmi_devintf arm_smmuv3_pmu arm_cspmu_module uio ipmi_msghandler
joydev spi_nor mtd cppc_cpufreq acpi_power_meter dm_multipath nvme_fabrics efi
_pstore nfnetlink dmi_sysfs ip_tables x_tables autofs4 btrfs blake2b_generic r
aid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor x
or_neon raid6_pq libcrc32c raid1 raid0 hid_generic rndis_host usbhid cdc_ether
 hid usbnet uas usb_storage crct10dif_ce polyval_ce polyval_generic ghash_ce s
m4_ce_gcm sm4_ce_ccm sm4_ce sm4_ce_cipher sm4 ast sm3_ce sm3 drm_shmem_helper
i2c_algo_bit i2c_smbus sha3_ce drm_kms_helper nvme sha2_ce ixgbe xhci_pci sha2
56_arm64 sha1_ce drm xfrm_algo nvme_core xhci_pci_renesas mdio spi_tegra210_qu
ad i2c_tegra aes_neon_bs aes_neon_blk aes_ce_blk aes_ce_cipher
[  454.123972] CPU: 63 PID: 3571 Comm: kworker/63:6 Not tainted 6.9.0-rc1+ #2
[  454.131003] Hardware name: Supermicro MBD-G1SMH/G1SMH, BIOS 1.0c 12/28/2023
[  454.138121] Workqueue: dio/dm-0 iomap_dio_complete_work
[  454.143475] pstate: 034000c9 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[  454.150594] pc : _raw_spin_lock_irqsave+0x44/0x100
[  454.155503] lr : try_to_wake_up+0x68/0x758
[  454.159692] sp : ffff8000faa4fc50
[  454.163075] x29: ffff8000faa4fc50 x28: 0000000000000000 x27: 00000000000000
00
[  454.170371] x26: ffff003bdc6ff328 x25: 0000000000000000 x24: 00000000000000
12
[  454.177666] x23: ffff0000e11f5640 x22: 00000000000008f5 x21: 00000000000000
00
[  454.184963] x20: 0000000000000003 x19: 00000000000000c0 x18: ffff8000faa600
48
[  454.192258] x17: 0000000000000000 x16: 0000000000000000 x15: 0000ba4bb2d887
f0
[  454.199554] x14: 0000000000000000 x13: 0000000000000000 x12: 01010101010101
01
[  454.206850] x11: 7f7f7f7f7f7f7f7f x10: fefefefefefefeff x9 : ffffc81e3f8edb
60
[  454.214145] x8 : 8080808080808080 x7 : 0000002040000000 x6 : 000000000000b2
40
[  454.221442] x5 : 0000ba4bb2d883b0 x4 : 0000000000000000 x3 : ffff0000ec4400
00
[  454.228738] x2 : 0000000000000001 x1 : 0000000000000000 x0 : 00000000000008
f5
[  454.236034] Call trace:
[  454.238529]  _raw_spin_lock_irqsave+0x44/0x100
[  454.243069]  try_to_wake_up+0x68/0x758
[  454.246897]  wake_up_process+0x24/0x50
[  454.250725]  aio_complete+0x1cc/0x2c0
[  454.254472]  aio_complete_rw+0x11c/0x2c8
[  454.258480]  iomap_dio_complete_work+0x3c/0x68
[  454.263018]  process_one_work+0x18c/0x478
[  454.267118]  worker_thread+0x338/0x450
[  454.270947]  kthread+0x11c/0x128
[  454.274244]  ret_from_fork+0x10/0x20
[  454.277901] Code: b9001041 d503201f 52800001 52800022 (88e17c02)
[  454.284134] ---[ end trace 0000000000000000 ]---
[  454.316501] note: kworker/63:6[3571] exited with irqs disabled
[  454.322522] note: kworker/63:6[3571] exited with preempt_count 3
[  454.325180] kauditd_printk_skb: 81 callbacks suppressed
[  454.325247] audit: type=1400 audit(1711661498.816:93): apparmor="DENIED" op
eration="open" class="file" profile="rsyslogd" name="/run/systemd/sessions/" p
id=2692 comm=72733A6D61696E20513A526567 requested_mask="r" denied_mask="r" fsu
id=103 ouid=0
[  514.192212] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  514.198495] rcu: 120-...0: (27 ticks this GP) idle=7504/1/0x40000000000
00000 softirq=9023/9025 fqs=6895
[  514.208233] rcu:         hardirqs   softirqs   csw/system
[  514.213941] rcu: number:        0          0            0
[  514.219653] rcu: cputime:        0          0            0   ==> 30028(
ms)
[  514.226801] rcu: (detected by 18, t=15010 jiffies, g=19925, q=444 ncpus
=144)
[  514.234133] Sending NMI from CPU 18 to CPUs 120:
[  524.245328] rcu: rcu_preempt kthread timer wakeup didn't happen for 2513 ji
ffies! g19925 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[  524.257006] rcu: Possible timer handling issue on cpu=18 timer-softirq=
2890
[  524.264227] rcu: rcu_preempt kthread starved for 2518 jiffies! g19925 f0x0
RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=18
[  524.275009] rcu: Unless rcu_preempt kthread gets sufficient CPU time, O
OM is now expected behavior.
[  524.284361] rcu: RCU grace-period kthread stack dump:
[  524.289532] task:rcu_preempt     state:I stack:0     pid:16    tgid:16    p
pid:2      flags:0x00000008
[  524.299085] Call trace:
[  524.301593]  __switch_to+0xdc/0x138
[  524.305196]  __schedule+0x3f0/0x18a0
[  524.308870]  schedule+0x40/0x1b8
[  524.312184]  schedule_timeout+0xac/0x1e0
[  524.316222]  rcu_gp_fqs_loop+0x120/0x508
[  524.320273]  rcu_gp_kthread+0x148/0x178
[  524.324222]  kthread+0x11c/0x128
[  524.327551]  ret_from_fork+0x10/0x20
[  524.331235] rcu: Stack dump where RCU GP kthread last ran:
[  524.336859] CPU: 18 PID: 0 Comm: swapper/18 Tainted: G      D            6.
9.0-rc1+ #2
[  524.344976] Hardware name: Supermicro MBD-G1SMH/G1SMH, BIOS 1.0c 12/28/2023
[  524.352104] pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[  524.359243] pc : cpuidle_enter_state+0xd8/0x790
[  524.363906] lr : cpuidle_enter_state+0xcc/0x790
[  524.368563] sp : ffff80008324fd80
[  524.371957] x29: ffff80008324fd80 x28: 0000000000000000 x27: 00000000000000
00
[  524.379287] x26: 0000000000000000 x25: 00000077b804c1a0 x24: 00000000000000
00
[  524.386611] x23: ffffc81e42d8bd68 x22: 0000000000000000 x21: 00000077b83e5c
e0
[  524.393935] x20: ffffc81e42d8bd80 x19: ffff000098ef0000 x18: ffff8000832600
28
[  524.401258] x17: 0000000000000000 x16: 0000000000000000 x15: 0000ba4bb2d87f
b0
[  524.408583] x14: 0000000000000000 x13: 0000000000000000 x12: 00000000000000
00
[  524.415907] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffc81e40d035
64
[  524.423231] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 00000000000000
00
[  524.430553] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000000000
00
[  524.437876] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000000000000
00
[  524.445198] Call trace:
[  524.447705]  cpuidle_enter_state+0xd8/0x790
[  524.452008]  cpuidle_enter+0x44/0x78
[  524.455683]  do_idle+0x264/0x2f8
[  524.458995]  cpu_startup_entry+0x44/0x50
[  524.463016]  secondary_start_kernel+0x13c/0x180
[  524.467679]  __secondary_switched+0xc0/0xc8
[  615.621045] ------------[ cut here ]------------
[  615.625852] hwirq = 71
[  615.625996] WARNING: CPU: 0 PID: 0 at drivers/gpio/gpio-tegra186.c:655 tegr
a186_gpio_irq+0x258/0x2e0
[  615.637932] Modules linked in: qrtr cfg80211 binfmt_misc nls_iso8859_1 dax_
hmem cxl_acpi acpi_ipmi cxl_core onboard_usb_hub ipmi_ssif input_leds einj uio
_pdrv_genirq ipmi_devintf arm_smmuv3_pmu arm_cspmu_module uio ipmi_msghandler
joydev spi_nor mt[0001.089] W> RATCHET: MB1 binary ratchet value 1 is larger t
han ratchet level 0 from HW fuses.


On Wed, 22 Nov 2023 18:42:53 -0500 Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> Unclear who's maintaining fs/aio.c these days - who wants to take this?
> -- >8 --
>
> I've been observing workloads where IPIs due to wakeups in
> aio_complete() are ~15% of total CPU time in the profile. Most of those
> wakeups are unnecessary when completion batching is in use in
> io_getevents().
>
> This plumbs min_nr through via the wait eventry, so that aio_complete()
> can avoid doing unnecessary wakeups.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Benjamin LaHaise <bcrl@kvack.org
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-aio@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> ---
> fs/aio.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++---------
> 1 file changed, 56 insertions(+), 10 deletions(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index f8589caef9c1..c69e7caacd1b 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1106,6 +1106,11 @@ static inline void iocb_destroy(struct aio_kiocb
> *iocb)
> kmem_cache_free(kiocb_cachep, iocb);
> }
> +struct aio_waiter {
> + struct wait_queue_entry w;
> + size_t min_nr;
> +};
> +
> /* aio_complete
> * Called when the io request on the given iocb is complete.
> */
> @@ -1114,7 +1119,7 @@ static void aio_complete(struct aio_kiocb *iocb)
> struct kioctx *ctx = iocb->ki_ctx;
> struct aio_ring *ring;
> struct io_event *ev_page, *event;
> - unsigned tail, pos, head;
> + unsigned tail, pos, head, avail;
> unsigned long flags;
> /*
> @@ -1156,6 +1161,10 @@ static void aio_complete(struct aio_kiocb *iocb)
> ctx->completed_events++;
> if (ctx->completed_events > 1)
> refill_reqs_available(ctx, head, tail);
> +
> + avail = tail > head
> + ? tail - head
> + : tail + ctx->nr_events - head;
> spin_unlock_irqrestore(&ctx->completion_lock, flags);
> pr_debug("added to ring %p at [%u]\n", iocb, tail);
> @@ -1176,8 +1185,18 @@ static void aio_complete(struct aio_kiocb *iocb)
> */
> smp_mb();
> - if (waitqueue_active(&ctx->wait))
> - wake_up(&ctx->wait);
> + if (waitqueue_active(&ctx->wait)) {
> + struct aio_waiter *curr, *next;
> + unsigned long flags;
> +
> + spin_lock_irqsave(&ctx->wait.lock, flags);
> + list_for_each_entry_safe(curr, next, &ctx->wait.head, w.entry)
> + if (avail >= curr->min_nr) {
> + list_del_init_careful(&curr->w.entry);
> + wake_up_process(curr->w.private);
> + }
> + spin_unlock_irqrestore(&ctx->wait.lock, flags);
> + }
> }
> static inline void iocb_put(struct aio_kiocb *iocb)
> @@ -1290,7 +1309,9 @@ static long read_events(struct kioctx *ctx, long
> min_nr, long nr,
> struct io_event __user *event,
> ktime_t until)
> {
> - long ret = 0;
> + struct hrtimer_sleeper t;
> + struct aio_waiter w;
> + long ret = 0, ret2 = 0;
> /*
> * Note that aio_read_events() is being called as the conditional - i.e.
> @@ -1306,12 +1327,37 @@ static long read_events(struct kioctx *ctx, long
> min_nr, long nr,
> * the ringbuffer empty. So in practice we should be ok, but it's
> * something to be aware of when touching this code.
> */
> - if (until == 0)
> - aio_read_events(ctx, min_nr, nr, event, &ret);
> - else
> - wait_event_interruptible_hrtimeout(ctx->wait,
> - aio_read_events(ctx, min_nr, nr, event, &ret),
> - until);
> + aio_read_events(ctx, min_nr, nr, event, &ret);
> + if (until == 0 || ret < 0 || ret >= min_nr)
> + return ret;
> +
> + hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> + if (until != KTIME_MAX) {
> + hrtimer_set_expires_range_ns(&t.timer, until, current->timer_slack_ns);
> + hrtimer_sleeper_start_expires(&t, HRTIMER_MODE_REL);
> + }
> +
> + init_wait(&w.w);
> +
> + while (1) {
> + unsigned long nr_got = ret;
> +
> + w.min_nr = min_nr - ret;
> +
> + ret2 = prepare_to_wait_event(&ctx->wait, &w.w, TASK_INTERRUPTIBLE) ?:
> + !t.task ? -ETIME : 0;
> +
> + if (aio_read_events(ctx, min_nr, nr, event, &ret) || ret2)
> + break;
> +
> + if (nr_got == ret)
> + schedule();
> + }
> +
> + finish_wait(&ctx->wait, &w.w);
> + hrtimer_cancel(&t.timer);
> + destroy_hrtimer_on_stack(&t.timer);
> +
> return ret;
> }
>
> --
> 2.42.0
>
>

