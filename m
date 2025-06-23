Return-Path: <linux-fsdevel+bounces-52542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10838AE3EC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CE3188F46B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3CB24169D;
	Mon, 23 Jun 2025 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vzfIQ8IM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621A5238C07
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679992; cv=none; b=h6N+5L3Qz9CS8ZDUvXlr5fDK6b1/DggTbNYUHaW3SPqvmo/rEHRP85XbX6EMnVRgk44VI++xVjoolfhXdgE4kfT6Yd3bfw2P9sa0L8NTAo5bzV5cTaoKJVHMqfWFM2jUuTBSaGNgruJk3CUG5xGSYC42QDKYtcUGNRjR7LXR65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679992; c=relaxed/simple;
	bh=sUkXXqaPcEc+7VppZMJIlI+UWrPSwDWJ1n4g43Pjq2U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eAwmvzcFMJ2W2MBHXmg2WkewtdrQjiVPCZ8yYgL7KAud7MmoFOkTKm6lYs4Gi91TvgpkWUAE1pxp0uUUN+E1QBOh2Sq3CVP4U6IgF/EP5jrpmWUxNnybL5gtVWvjUADfXOnnszUbu0eaBzd61g/NkZ5sp+YYXFWQlyFvQl2Oxxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vzfIQ8IM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-237311f5a54so38895475ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750679990; x=1751284790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AXNiPa/vEGx138D93gyNZSNaepDJkn5LZASDwOnaP3Q=;
        b=vzfIQ8IMD4RjepRrBmAVuIT9sd6rhcSKdiM7rIVUtX62PXsiTSuze+pWniQ7UDa6WH
         7ODdD++Vuebu6x6dTk6dOxRYLcvP01EZkBWK6D+E9/3a5QVcUxZRrY+JKMEBTL3kT6kG
         i4Uuen4q9nE9xU412cz2YYBblDO4KMT/HZ3xk8eDSyPR/KcMU7UAeHJBoBd1X5Dk/IB3
         FBR6S2Vnjz1kQnM09muH6EWkR72L4rv7jXd2Awqw5Y6HYapT/aDSC1xPDE0VMIPsdq3q
         qC5yQR19jetlrs4b72tBDCm2pvH+OibMhdQCEOoTxyJAm119pi9V5eIZOKPp+wOx/BB7
         Qwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750679990; x=1751284790;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AXNiPa/vEGx138D93gyNZSNaepDJkn5LZASDwOnaP3Q=;
        b=GJjUt6nWaxRA+z4aarh0VzChZaW0h926aEF3s6vbYrhhm1A/cNnW4ws0OFA5l8varI
         AkmNL/x2NJodc1hcufTKlD8lM+5a2S0vuQA4fNTsZh2/RTCjM40CnImU27ffayGBTHE1
         yu75mVHRx9qfv0AM4WD7uC9jrypSAhGFmrMfxt1eIFkxnz7ceAAERDAXoBe3LeLHTHsu
         hr+CHvrEkF4WAEi0dBO2rHLs3oKv/RrlCTAbCRMNM5fYRe23iLBe6lWIPcCDA5WloNsg
         5OJZ9v0b19GdGjop76JmO69Butfo72KD0tGS7B3j5JX0C/c/NSdrQH7ZoLwGvMCUSpRy
         WZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1P1NMMMNOLZaSJj5lvN4TZEMbbkP9l7GrZ30+LXLoGhQkS/OZJDZIZ5Myh0BPZTEPWQoSUcvunyTnTEuT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8n7fW+YGZmdBc17JkswxDKDRnXCC8N+cAHd7yDFJ/2m5kxgnA
	D02vmz5ZIhl4U+4ifSer+D9A0xkIXVHuYVWxE4CqQyEoGTO2fp8AZAf8GSCVESemtplMH/350t8
	6d8W4iExtIHFIR9q4D/pfRZ9k2Ki2vJeFv2sYRiq1dw==
X-Gm-Gg: ASbGnctxowTmfIxcCI5EoOuFTbEv/IRfJfpCpWuUnP68SB7crNYiP7c4fcwRVmqeSWB
	j3rSH2Sh7sYBX2B0zF311eO3EZIsS7+H0Uu+YHFNnjKVSrs8yK0rKMuPdh22/SQpHGR+w5whjB+
	OGKgys6eBzQOCdvNV4Yj2ntImLRmIbWziwN1/7wUrInCvKNsqHqyYYCiLNOrRHywxxzSVXOsZo7
	8uEGcy2YbLVX60=
X-Google-Smtp-Source: AGHT+IGiBd4kCVa0ywnRkcqWhGcCEeGyvisvkfyFlm7078947nB9TYKkqnxCIHumnODAWFdThN/AY578nByJKVZ7yKI=
X-Received: by 2002:a17:90b:2252:b0:313:14b5:2538 with SMTP id
 98e67ed59e1d1-3159d8ff782mr18970645a91.35.1750679989565; Mon, 23 Jun 2025
 04:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 23 Jun 2025 17:29:38 +0530
X-Gm-Features: Ac12FXxA4fdzSIPFEQ5fKIVplDtkIGiICrKuBKW8khXp_ABe7FgMqBB3FaOP2YI
Message-ID: <CA+G9fYt0MfXMEKqHKHrdfqg3Q5NgQsuG1f+cXRt83d7AscX5Fw@mail.gmail.com>
Subject: next-20250623: arm64 devices kernel panic Internal error Oops at
 pidfs_free_pid (fs/pidfs.c:162)
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regressions on arm64 devices and qemu-arm64 while running LTP controllers
and selftests cgroup test cases the following kernel Panic Internal error oops
found on the Linux next-20250623 tag.

Regressions found on arm64 device
  - Kernel Panic Internal oops @ LTP controllers
  - Kernel Panic Internal oops @ selftest cgroups

Test environments:
 - Dragonboard-410c
 - e850-96
 - FVP
 - Juno-r2
 - rk3399-rock-pi-4b
 - qemu-arm64

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Boot regression: arm64 devices kernel panic Internal error Oops at
pidfs_free_pid (fs/pidfs.c:162)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log
[   67.087303] Internal error: Oops: 0000000096000004 [#1]  SMP
[   67.094021] Modules linked in: snd_soc_hdmi_codec venus_enc
venus_dec videobuf2_dma_contig pm8916_wdt qcom_wcnss_pil
coresight_cpu_debug coresight_tmc coresight_replicator qcom_camss
coresight_stm snd_soc_lpass_apq8016 msm qrtr coresight_funnel
snd_soc_msm8916_digital snd_soc_lpass_cpu coresight_tpiu
snd_soc_msm8916_analog videobuf2_dma_sg stm_core coresight_cti
snd_soc_lpass_platform snd_soc_apq8016_sbc venus_core
snd_soc_qcom_common qcom_q6v5_mss v4l2_fwnode coresight snd_soc_core
qcom_pil_info v4l2_async snd_compress llcc_qcom snd_pcm_dmaengine
ocmem qcom_q6v5 v4l2_mem2mem videobuf2_memops snd_pcm qcom_sysmon
drm_exec adv7511 snd_timer videobuf2_v4l2 gpu_sched qcom_common snd
videodev drm_dp_aux_bus qcom_glink_smem soundcore qcom_spmi_vadc
mdt_loader drm_display_helper qnoc_msm8916 qmi_helpers
videobuf2_common qcom_vadc_common qcom_spmi_temp_alarm rtc_pm8xxx
qcom_pon qcom_stats mc cec drm_client_lib qcom_rng rpmsg_ctrl
display_connector rpmsg_char phy_qcom_usb_hs socinfo drm_kms_helper
rmtfs_mem ramoops
[   67.094437]  reed_solomon fuse drm backlight ip_tables x_tables
[   67.189084] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted
6.16.0-rc3-next-20250623 #1 PREEMPT
[   67.194810] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[   67.234078] pc : pidfs_free_pid (fs/pidfs.c:162)
[   67.236989] lr : put_pid.part.0 (kernel/pid.c:104)
[   67.239958] sp : ffff80008001be50
[   67.243892] x29: ffff80008001be50 x28: ffff800082288180 x27: ffff8000801c7654
[   67.247206] x26: ffff8000822882c0 x25: 000000000000000a x24: ffff00003fc96940
[   67.254295] x23: 0000000000000000 x22: 000000000000003f x21: ffff00003fc968c0
[   67.261410] x20: ffff800082212740 x19: 0000000000000000 x18: ffff8000875abc00
[   67.268490] x17: ffff7fffbdb7b000 x16: ffff800080018000 x15: 010c194d58e3a052
[   67.275644] x14: 0000000000000000 x13: 0000000000000000 x12: 00000000000003d4
[   67.282785] x11: 0000000000000000 x10: 000000000000003f x9 : ffff00000295a500
[   67.289863] x8 : ffff80008001be30 x7 : 0000000000000000 x6 : ffff00003fc99be0
[   67.296923] x5 : ffff8000811fafe8 x4 : 0000000000100004 x3 : 0000000000000000
[   67.304036] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffff00000487a9c0
[   67.311148] Call trace:
[   67.318222] pidfs_free_pid (fs/pidfs.c:162) (P)
[   67.320916] put_pid.part.0 (kernel/pid.c:104)
[   67.324597] delayed_put_pid (kernel/pid.c:114)
[   67.328231] rcu_core (arch/arm64/include/asm/preempt.h:13
(discriminator 1) kernel/rcu/tree.c:2589 (discriminator 1)
kernel/rcu/tree.c:2838 (discriminator 1))
[   67.331859] rcu_core_si (kernel/rcu/tree.c:2856)
[   67.335210] handle_softirqs (arch/arm64/include/asm/preempt.h:13
(discriminator 1) kernel/softirq.c:581 (discriminator 1))
[   67.338511] __do_softirq (kernel/softirq.c:614)
[   67.342526] ____do_softirq (arch/arm64/kernel/irq.c:82)
[   67.345735] call_on_irq_stack (arch/arm64/kernel/entry.S:897)
[   67.349550] do_softirq_own_stack (arch/arm64/kernel/irq.c:87)
[   67.353544] __irq_exit_rcu (kernel/softirq.c:460 kernel/softirq.c:680)
[   67.357431] irq_exit_rcu (kernel/softirq.c:699)
[   67.361234] el1_interrupt (arch/arm64/include/asm/current.h:19
arch/arm64/kernel/entry-common.c:280
arch/arm64/kernel/entry-common.c:586
arch/arm64/kernel/entry-common.c:598)
[   67.364591] el1h_64_irq_handler (arch/arm64/kernel/entry-common.c:604)
[   67.368381] el1h_64_irq (arch/arm64/kernel/entry.S:596)
[   67.372250] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:292) (P)
[   67.375640] cpuidle_enter (drivers/cpuidle/cpuidle.c:391 (discriminator 2))
[   67.380025] do_idle (kernel/sched/idle.c:160
kernel/sched/idle.c:235 kernel/sched/idle.c:330)
[   67.383811] cpu_startup_entry (kernel/sched/idle.c:428 (discriminator 1))
[   67.387062] secondary_start_kernel
(arch/arm64/include/asm/atomic_ll_sc.h:95 (discriminator 2)
arch/arm64/include/asm/atomic.h:28 (discriminator 2)
include/linux/atomic/atomic-arch-fallback.h:546 (discriminator 2)
include/linux/atomic/atomic-arch-fallback.h:994 (discriminator 2)
include/linux/atomic/atomic-instrumented.h:436 (discriminator 2)
include/linux/sched/mm.h:37 (discriminator 2)
arch/arm64/kernel/smp.c:214 (discriminator 2))
[   67.390956] __secondary_switched (arch/arm64/kernel/head.S:405)
[ 67.395181] Code: f9401c13 f9001c1f b140067f 540001a8 (f9400274)
All code
========
   0: f9401c13 ldr x19, [x0, #56]
   4: f9001c1f str xzr, [x0, #56]
   8: b140067f cmn x19, #0x1, lsl #12
   c: 540001a8 b.hi 0x40  // b.pmore
  10:* f9400274 ldr x20, [x19] <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0: f9400274 ldr x20, [x19]
[   67.399334] ---[ end trace 0000000000000000 ]---


## Source
* Kernel version: 6.16.0-rc3-next-20250623
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: f817b6dd2b62d921a6cdc0a3ac599cd1851f343c
* Git describe: next-20250623
* Project details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250623/
* Architectures: arm64
* Toolchains: gcc-13
* Kconfigs: defconfig+selftest/configs

## Build arm64
* Test log: https://qa-reports.linaro.org/api/testruns/28834568/log_file/
* Test Lava log: https://lkft.validation.linaro.org/scheduler/job/8326000#L2426
* Test Lava log 2:
https://lkft.validation.linaro.org/scheduler/job/8326094#L5378
* Test details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250623/log-parser-test/internal-error-oops-oops-smp/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ytmpuyjaGkw1YlPt0MbPk2y7vM/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2ytmpuyjaGkw1YlPt0MbPk2y7vM/config

--
Linaro LKFT
https://lkft.linaro.org

