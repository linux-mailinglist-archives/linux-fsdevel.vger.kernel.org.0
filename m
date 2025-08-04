Return-Path: <linux-fsdevel+bounces-56685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91373B1A988
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 21:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B36188768F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 19:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E1C28B3F7;
	Mon,  4 Aug 2025 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sRks9nje"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4819323315A
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754335243; cv=none; b=cGDG+ocEafjRLtNL8Pm/ECQd24v8rNfaJeHuRJo78CrCXhg2+UyQEMWFRQlyOZEzyC9wjK8/8tGjl5LO+nCMS4PtLlYDipi8J00xx7gGt1LYqtB/W6YOfJKHu/8ps3VnS/m9KNsIzvAHa3ZQQHb3q8IWpnseBFkAS8GFPYQcQoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754335243; c=relaxed/simple;
	bh=wFAU7nN8iqQTl8TKbZUkeGThsQLtYv2/KVDlnaUW6SE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Ku4+dJUzvEZqlk/1wsp7tixnq+CCgAUUJVQKB7DGU9UEgixyZT9r/Y5z+bX7JfPBv6ze+odjGF+IIwNwnVn0nGfkGemTnt7ATBk0FH8nP8tyfRkF9rHKT5wnBcYJ8TkxkNaDqhJ2+XQmPCNE9M9ZVHurq1PxqlR0Xz4OZ+PYhaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sRks9nje; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso3023712b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 12:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754335240; x=1754940040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LpsahPywnld5FHIV1ESEO7M7gH9RzC0iKDniv98/Wis=;
        b=sRks9njeDhF2hgQSeVyeh8QFFntxsZ+5Nr2tbRBzHH3bhFrIp57hqhMiniZ50Q3XRJ
         UV+gIq+AvuExjsafBh66RTIfcXgBLr8a8wY+Wf5kSh8jBb0Ah9d+3uZVJVonASdTmNPT
         qUWLu8Qr5bXNDwidheumHV7fPRctrw0asf4N6HK/mNvjsDvpOiY07QH0A3d4tYhy6D/h
         mWG/cZwr0uIa646++Su83YoaNVUZuKhBpGifEj7ANQeOBkxpkFJcht9DH2XJ7uXhgC6U
         xjGDaquDHe85vqseJXuDW4DQAuB5s16sjjXuz9V+NfiTH8XMjqfN94fN6s5muiWiDl3B
         xAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754335240; x=1754940040;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LpsahPywnld5FHIV1ESEO7M7gH9RzC0iKDniv98/Wis=;
        b=wjqtqyjntlt162SSRB3eGneazHvxbQ3/ATXvhn3ZYFY/Ns3LXf8kcgyErvxMHNXrte
         KJfUk+J3r3IWgzqUOer2PnfXjkcHtNP/dzSq5GoH7jpw0aLfe1diy+nHd+pqcUCNbEWq
         AR6x6kvV1Lmvj2cvUHAz3XmQNqVGwdxD5ZeZhEUFOmkh8f9PRCvyhfcxB/3w8Cp2WOsR
         CXzctSHlzcnC7bg5Hm12rgQVJz22kaTdMB3eWFibqgGwiTP8ONBxKBI0MueufmGbdy5Z
         2oUFuV/kGm+OtabUc1ldsvmDozx3JzBfRKb3c8swlToFPF4QYdjerOpcfG/nCzoKL+yY
         L3rw==
X-Forwarded-Encrypted: i=1; AJvYcCUHeySgt266YV+pGfKsq1xjb34IJ7M0OeRH5RP99P7h2qtkz4ytS5y9PBRRYNOcPIiGIyP1gD5yOldPKB7a@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8cyR/Hn3YFnigkIn7br22jBiGfH+DkTxzfie/Fvze/DzBrieV
	zVQ/aBm89eMi4WUGhkluiPtov8NvTtUSHYQDXDD7XgxOR1jLP6QUUSlgbH7YNqoHd/xEYSCCDHN
	hgSJGLf1qFLB4G549A2+akNLMRvwtqIIW9MshZFQ0OQ==
X-Gm-Gg: ASbGnctTdDVfZCiay8dPyCPcAkgvJcbVfx5Par7aRviPGusQ8Or3uQvdo8RLXk6mmhn
	0q+R7wXYY3SUCAQY0BEcsEPI60wWSo4j9x2jTTGo7ea63IHipZENTBk6oUTBLAgTwX9jQdX3vst
	KjESARNGhXRjvd+E9bQr+6C1VhVClkG8IidUS2vBzcPgtmWybDGWv9u+mTlXc9VXD16j7PKt6Pg
	DI1QNG3
X-Google-Smtp-Source: AGHT+IF/c/lpdpmh5BcWY6wMPI3ef98Pzyt7paHBQjoePKRiA5HjyZKDofGpTrzFnaQFZuIuyQvLMxYPczosushqQ4Y=
X-Received: by 2002:a17:902:fc8e:b0:234:ba37:879e with SMTP id
 d9443c01a7336-242470303bamr151165155ad.38.1754335240252; Mon, 04 Aug 2025
 12:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 5 Aug 2025 00:50:28 +0530
X-Gm-Features: Ac12FXz2euhDqdsSuu6cKigdhHbw-zywjAcR-iTxtYH6wKeeNS8FrzqZSjkvpO4
Message-ID: <CA+G9fYvZtbQLoS=GpaZ_uzm3YiZEQmz0oghnwVamNQ49CosT2w@mail.gmail.com>
Subject: next-20250804 Unable to handle kernel execute from non-executable
 memory at virtual address idem_hash
To: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Cgroups <cgroups@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, linux-fsdevel@vger.kernel.org
Cc: Song Liu <song@kernel.org>, yukuai3@huawei.com, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Renjiang Han <quic_renjiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

While booting and testing selftest cgroups and filesystem testing on arm64
dragonboard-410c the following kernel warnings / errors noticed and system
halted and did not recover with selftests Kconfig enabled running the kernel
Linux next tag next-20250804.

Regression Analysis:
- New regression? Yes
- Reproducibility? Re-validation is in progress

First seen on the next-20250804
Good: next-20250801
Bad: next-20250804

Test regression: next-20250804 Unable to handle kernel execute from
non-executable memory at virtual address idem_hash
Test regression: next-20250804 refcount_t: addition on 0;
use-after-free refcount_warn_saturate

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test crash log
[    9.811341] Unable to handle kernel NULL pointer dereference at
virtual address 000000000000002e
[    9.811444] Mem abort info:
[    9.821150]   ESR = 0x0000000096000004
[    9.833499]   SET = 0, FnV = 0
[    9.833566]   EA = 0, S1PTW = 0
[    9.835511]   FSC = 0x04: level 0 translation fault
[    9.838901] Data abort info:
[    9.843788]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    9.846565]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    9.851938]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    9.853510] rtc-pm8xxx 200f000.spmi:pmic@0:rtc@6000: registered as rtc0
[    9.856992] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000856f8000
[    9.862446] rtc-pm8xxx 200f000.spmi:pmic@0:rtc@6000: setting system
clock to 1970-01-01T00:00:31 UTC (31)
[    9.868789] [000000000000002e] pgd=0000000000000000, p4d=0000000000000000
[    9.875459] Internal error: Oops: 0000000096000004 [#1]  SMP
[    9.889547] input: pm8941_pwrkey as
/devices/platform/soc@0/200f000.spmi/spmi-0/0-00/200f000.spmi:pmic@0:pon@800/200f000.spmi:pmic@0:pon@800:pwrkey/input/input1
[    9.891545] Modules linked in: qcom_spmi_temp_alarm rtc_pm8xxx
qcom_pon(+) qcom_pil_info videobuf2_dma_sg ubwc_config qcom_q6v5
venus_core(+) qcom_sysmon qcom_spmi_vadc v4l2_fwnode llcc_qcom
v4l2_async qcom_vadc_common qcom_common ocmem v4l2_mem2mem drm_gpuvm
videobuf2_memops qcom_glink_smem videobuf2_v4l2 drm_exec mdt_loader
qmi_helpers gpu_sched drm_dp_aux_bus qnoc_msm8916 videodev
drm_display_helper qcom_stats videobuf2_common cec qcom_rng
drm_client_lib mc phy_qcom_usb_hs socinfo rpmsg_ctrl display_connector
rpmsg_char ramoops rmtfs_mem reed_solomon drm_kms_helper fuse drm
backlight
[    9.912286] input: pm8941_resin as
/devices/platform/soc@0/200f000.spmi/spmi-0/0-00/200f000.spmi:pmic@0:pon@800/200f000.spmi:pmic@0:pon@800:resin/input/input2
[    9.941186] CPU: 2 UID: 0 PID: 221 Comm: (udev-worker) Not tainted
6.16.0-next-20250804 #1 PREEMPT
[    9.941200] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    9.941206] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    9.941215] pc : dev_pm_opp_put (/builds/linux/drivers/opp/core.c:1685)
[    9.941233] lr : core_clks_enable+0x54/0x148 venus_core
[   10.004266] sp : ffff8000842b35f0
[   10.004273] x29: ffff8000842b35f0 x28: ffff8000842b3ba0 x27: ffff0000047be938
[   10.004289] x26: 0000000000000000 x25: 0000000000000000 x24: ffff80007b350ba0
[   10.004303] x23: ffff00000ba380c8 x22: ffff00000ba38080 x21: 0000000000000000
[   10.004316] x20: 0000000000000000 x19: ffffffffffffffee x18: 00000000ffffffff
[   10.004330] x17: 0000000000000000 x16: 1fffe000017541a1 x15: ffff8000842b3560
[   10.004344] x14: 0000000000000000 x13: 007473696c5f7974 x12: 696e696666615f65
[   10.004358] x11: 00000000000000c0 x10: 0000000000000020 x9 : ffff80007b33f2bc
[   10.004371] x8 : ffffffffffffffde x7 : ffff0000044a4800 x6 : 0000000000000000
[   10.004384] x5 : 0000000000000002 x4 : 00000000c0000000 x3 : 0000000000000001
[   10.004397] x2 : 0000000000000002 x1 : ffffffffffffffde x0 : ffffffffffffffee
[   10.004412] Call trace:
[   10.004417] dev_pm_opp_put (/builds/linux/drivers/opp/core.c:1685) (P)
[   10.004435] core_clks_enable+0x54/0x148 venus_core
[   10.004504] core_power_v1+0x78/0x90 venus_core
[   10.004560] venus_runtime_resume+0x6c/0x98 venus_core
[   10.004616] pm_generic_runtime_resume
(/builds/linux/drivers/base/power/generic_ops.c:47)
[   10.004630] __genpd_runtime_resume
(/builds/linux/drivers/pmdomain/core.c:1203)
[   10.004645] genpd_runtime_resume (/builds/linux/drivers/pmdomain/core.c:1329)
[   10.004656] __rpm_callback (/builds/linux/drivers/base/power/runtime.c:406)
[   10.004668] rpm_callback (/builds/linux/drivers/base/power/runtime.c:460)
[   10.004680] rpm_resume (/builds/linux/drivers/base/power/runtime.c:934)
[   10.004692] __pm_runtime_resume
(/builds/linux/drivers/base/power/runtime.c:1192)
[   10.004704] venus_probe+0x2d8/0x588 venus_core
[   10.004761] platform_probe
(/builds/linux/drivers/base/platform.c:1408 (discriminator 1))
[   10.004776] really_probe (/builds/linux/drivers/base/dd.c:581
/builds/linux/drivers/base/dd.c:659)
[   10.004788] __driver_probe_device (/builds/linux/drivers/base/dd.c:801)
[   10.004800] driver_probe_device (/builds/linux/drivers/base/dd.c:831)
[   10.004812] __driver_attach (/builds/linux/drivers/base/dd.c:1218
/builds/linux/drivers/base/dd.c:1157)
[   10.004824] bus_for_each_dev (/builds/linux/drivers/base/bus.c:370)
[   10.004835] driver_attach (/builds/linux/drivers/base/dd.c:1236)
[   10.004847] bus_add_driver (/builds/linux/drivers/base/bus.c:678)
[   10.004859] driver_register (/builds/linux/drivers/base/driver.c:249)
[   10.004871] __platform_driver_register
(/builds/linux/drivers/base/platform.c:868)
[   10.004885] qcom_venus_driver_init+0x28/0xfb8 venus_core
[   10.004942] do_one_initcall (/builds/linux/init/main.c:1269)
[   10.004954] do_init_module (/builds/linux/kernel/module/main.c:3039)
[   10.004967] load_module (/builds/linux/kernel/module/main.c:3509)
[   10.004979] init_module_from_file (/builds/linux/kernel/module/main.c:3702)
[   10.004991] __arm64_sys_finit_module
(/builds/linux/kernel/module/main.c:3713
/builds/linux/kernel/module/main.c:3739
/builds/linux/kernel/module/main.c:3723
/builds/linux/kernel/module/main.c:3723)
[   10.005004] invoke_syscall
(/builds/linux/arch/arm64/include/asm/current.h:19
/builds/linux/arch/arm64/kernel/syscall.c:54)
[   10.005014] el0_svc_common.constprop.0
(/builds/linux/arch/arm64/kernel/syscall.c:139)
[   10.005023] do_el0_svc (/builds/linux/arch/arm64/kernel/syscall.c:152)
[   10.005032] el0_svc
(/builds/linux/arch/arm64/include/asm/irqflags.h:82 (discriminator 1)
/builds/linux/arch/arm64/include/asm/irqflags.h:123 (discriminator 1)
/builds/linux/arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
/builds/linux/arch/arm64/kernel/entry-common.c:169 (discriminator 1)
/builds/linux/arch/arm64/kernel/entry-common.c:182 (discriminator 1)
/builds/linux/arch/arm64/kernel/entry-common.c:880 (discriminator 1))
[   10.005045] el0t_64_sync_handler
(/builds/linux/arch/arm64/kernel/entry-common.c:899)
[   10.005058] el0t_64_sync (/builds/linux/arch/arm64/kernel/entry.S:596)
[ 10.005073] Code: 910003fd f9000bf3 91004013 aa1303e0 (f9402821)
All code
========
   0: 910003fd mov x29, sp
   4: f9000bf3 str x19, [sp, #16]
   8: 91004013 add x19, x0, #0x10
   c: aa1303e0 mov x0, x19
  10:* f9402821 ldr x1, [x1, #80] <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0: f9402821 ldr x1, [x1, #80]
[   10.005082] ---[ end trace 0000000000000000 ]---
[   10.089433] systemd-journald[147]: Time jumped backwards, rotating.


## Test cgroup crash log
selftests: cgroup: test_cpu
ok 1 test_cpucg_subtree_control
ok 2 test_cpucg_stats
ok 3 test_cpucg_nice
not ok 4 test_cpucg_weight_overprovisioned
not ok 5 test_cpucg_weight_underprovisioned
ok 6 test_cpucg_nested_weight_overprovisioned
[   60.273474] Unable to handle kernel execute from non-executable
memory at virtual address ffff800082f89d50
[   60.273547] Mem abort info:
[   60.282111]   ESR = 0x000000008600000e
[   60.284730]   EC = 0x21: IABT (current EL), IL = 32 bits
[   60.288616]   SET = 0, FnV = 0
[   60.294041]   EA = 0, S1PTW = 0
[   60.296880]   FSC = 0x0e: level 2 permission fault
[   60.299953] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000082485000
[   60.304828] [ffff800082f89d50] pgd=0000000000000000,
p4d=100000008300c003, pud=100000008300d003, pmd=0068000082e00701
[   60.311682] Internal error: Oops: 000000008600000e [#2]  SMP
[   60.322146] Modules linked in: pm8916_wdt qcom_wcnss_pil
snd_soc_lpass_apq8016 snd_soc_msm8916_analog snd_soc_lpass_cpu
snd_soc_apq8016_sbc snd_soc_msm8916_digital snd_soc_lpass_platform
snd_soc_qcom_common coresight_cpu_debug snd_soc_core coresight_tmc
coresight_replicator snd_compress coresight_funnel snd_pcm_dmaengine
coresight_stm stm_core coresight_cti coresight_tpiu snd_pcm coresight
snd_timer qrtr msm snd adv7511 qcom_camss qcom_q6v5_mss soundcore
qcom_spmi_temp_alarm rtc_pm8xxx qcom_pon qcom_pil_info
videobuf2_dma_sg ubwc_config qcom_q6v5 venus_core(+) qcom_sysmon
qcom_spmi_vadc v4l2_fwnode llcc_qcom v4l2_async qcom_vadc_common
qcom_common ocmem v4l2_mem2mem drm_gpuvm videobuf2_memops
qcom_glink_smem videobuf2_v4l2 drm_exec mdt_loader qmi_helpers
gpu_sched drm_dp_aux_bus qnoc_msm8916 videodev drm_display_helper
qcom_stats videobuf2_common cec qcom_rng drm_client_lib mc
phy_qcom_usb_hs socinfo rpmsg_ctrl display_connector rpmsg_char
ramoops rmtfs_mem reed_solomon drm_kms_helper fuse drm backlight
[   60.394361] CPU: 3 UID: 0 PID: 252 Comm: kworker/u16:7 Tainted: G
   D             6.16.0-next-20250804 #1 PREEMPT
[   60.416518] Tainted: [D]=DIE
[   60.427172] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[   60.430139] Workqueue:  0x0 (async)
[   60.436813] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   60.440027] pc : idem_hash+0x58/0x800
[   60.446967] lr : idem_hash+0x58/0x800
[   60.450785] sp : ffff8000842b3dd0
[   60.454429] x29: ffff8000842b3dd0 x28: 0000000000000000 x27: 0000000000000000
[   60.457737] x26: 0000000000000000 x25: ffff000010127880 x24: ffff000010127840
[   60.464856] x23: ffff8000828cf000 x22: 61c8864680b583eb x21: ffff000003418c28
[   60.471973] x20: ffff0000044a4800 x19: ffff0000044a4800 x18: 0000000000000000
[   60.479090] x17: ffff7fffbd4dd000 x16: ffff800080018000 x15: 0000000000000000
[   60.486208] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[   60.493327] x11: 00000000000000c0 x10: 0000000000000b50 x9 : ffff80008163543c
[   60.500444] x8 : ffff8000842b3bd8 x7 : 0000000000000001 x6 : ffff8000828ab000
[   60.507563] x5 : ffff0000044a4800 x4 : ffff8000828ab3e0 x3 : 0000000000000000
[   60.514680] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000044a4800
[   60.521800] Call trace:
[   60.528909] idem_hash+0x58/0x800 (P)
[   60.531168] worker_thread (/builds/linux/kernel/workqueue.c:3353)
[   60.534987] kthread (/builds/linux/kernel/kthread.c:463)
[   60.538631] ret_from_fork (/builds/linux/arch/arm64/kernel/entry.S:861)
[ 60.542023] Code: 00000000 00000000 00000000 00000000 (842b3d70)
All code
========
...
  10: 842b3d70 .inst 0x842b3d70 ; undefined

Code starting with the faulting instruction
===========================================
   0: 842b3d70 .inst 0x842b3d70 ; undefined
[   60.545587] ---[ end trace 0000000000000000 ]---
[   60.561661] note: kworker/u16:7[252] exited with preempt_count 1
ok 7 test_cpucg_nested_weight_underprovisioned
#
not ok 2 selftests: cgroup: test_cpu TIMEOUT 45 seconds

## Test filesystems crash log
selftests: filesystems: file_stressor
TAP version 13
1..1
Starting 1 tests from 1 test cases.
RUN           file_stressor.slab_typesafe_by_rcu ...
[  316.785677] ------------[ cut here ]------------
[  316.785733] refcount_t: addition on 0; use-after-free.
[  316.789429] WARNING: lib/refcount.c:25 at
refcount_warn_saturate+0x120/0x148, CPU#0: 5/88
[  316.794336] Modules linked in: pm8916_wdt qcom_wcnss_pil
snd_soc_lpass_apq8016 snd_soc_msm8916_analog snd_soc_lpass_cpu
snd_soc_apq8016_sbc snd_soc_msm8916_digital snd_soc_lpass_platform
snd_soc_qcom_common coresight_cpu_debug snd_soc_core coresight_tmc
coresight_replicator snd_compress coresight_funnel snd_pcm_dmaengine
coresight_stm stm_core coresight_cti coresight_tpiu snd_pcm coresight
snd_timer qrtr msm snd adv7511 qcom_camss qcom_q6v5_mss soundcore
qcom_spmi_temp_alarm rtc_pm8xxx qcom_pon qcom_pil_info
videobuf2_dma_sg ubwc_config qcom_q6v5 venus_core(+) qcom_sysmon
qcom_spmi_vadc v4l2_fwnode llcc_qcom v4l2_async qcom_vadc_common
qcom_common ocmem v4l2_mem2mem drm_gpuvm videobuf2_memops
qcom_glink_smem videobuf2_v4l2 drm_exec mdt_loader qmi_helpers
gpu_sched drm_dp_aux_bus qnoc_msm8916 videodev drm_display_helper
qcom_stats videobuf2_common cec qcom_rng drm_client_lib mc
phy_qcom_usb_hs socinfo rpmsg_ctrl display_connector rpmsg_char
ramoops rmtfs_mem reed_solomon drm_kms_helper fuse drm backlight
[  316.870196] CPU: 0 UID: 0 PID: 88 Comm: kworker/u16:5 Tainted: G
  D             6.16.0-next-20250804 #1 PREEMPT
[  316.892345] Tainted: [D]=DIE
[  316.903000] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[  316.905873] Workqueue: events_unbound idle_cull_fn
[  316.912553] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  316.917156] pc : refcount_warn_saturate
(/builds/linux/lib/refcount.c:25 (discriminator 1))
[  316.924010] lr : refcount_warn_saturate
(/builds/linux/lib/refcount.c:25 (discriminator 1))
[  316.928870] sp : ffff8000839dbd10
[  316.933727] x29: ffff8000839dbd10 x28: 0000000000000000 x27: 0000000000000000
[  316.937208] x26: ffff000003418c28 x25: 0000000000000000 x24: ffff000003418c78
[  316.944327] x23: 00000000000124f8 x22: ffff8000828a8000 x21: ffff8000839dbd38
[  316.951444] x20: ffff8000828cf108 x19: ffff000003418c00 x18: 0000000000000006
[  316.958563] x17: 0000000000000000 x16: 0000000000000000 x15: 0765076507720766
[  316.965680] x14: 072d077207650774 x13: 0765076507720766 x12: 072d077207650774
[  316.972799] x11: 0720072007200720 x10: ffff800082931cc0 x9 : ffff8000801ce594
[  316.979918] x8 : 00000000ffffefff x7 : ffff800082931cc0 x6 : 80000000fffff000
[  316.987035] x5 : 0000000000000566 x4 : 0000000000000000 x3 : 0000000000000027
[  316.994153] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000059e0000
[  317.001272] Call trace:
[  317.008380] refcount_warn_saturate (/builds/linux/lib/refcount.c:25
(discriminator 1)) (P)
[  317.010642] set_worker_dying
(/builds/linux/include/linux/refcount.h:289
/builds/linux/include/linux/refcount.h:366
/builds/linux/include/linux/refcount.h:383
/builds/linux/include/linux/sched/task.h:116
/builds/linux/kernel/workqueue.c:2895)
[  317.015500] idle_cull_fn (/builds/linux/kernel/workqueue.c:962
/builds/linux/kernel/workqueue.c:2961)
[  317.019666] process_one_work (/builds/linux/kernel/workqueue.c:3241)
[  317.023225] worker_thread (/builds/linux/kernel/workqueue.c:3313
(discriminator 2) /builds/linux/kernel/workqueue.c:3400 (discriminator
2))
[  317.027217] kthread (/builds/linux/kernel/kthread.c:463)
[  317.030862] ret_from_fork (/builds/linux/arch/arm64/kernel/entry.S:861)
[  317.034249] ---[ end trace 0000000000000000 ]---
[  317.047081] ------------[ cut here ]------------
[  317.047142] refcount_t: saturated; leaking memory.
[  317.051602] WARNING: lib/refcount.c:22 at
refcount_warn_saturate+0x74/0x148, CPU#0: 5/88
[  317.055397] Modules linked in: pm8916_wdt qcom_wcnss_pil
snd_soc_lpass_apq8016 snd_soc_msm8916_analog snd_soc_lpass_cpu
snd_soc_apq8016_sbc snd_soc_msm8916_digital snd_soc_lpass_platform
snd_soc_qcom_common coresight_cpu_debug snd_soc_core coresight_tmc
coresight_replicator snd_compress coresight_funnel snd_pcm_dmaengine
coresight_stm stm_core coresight_cti coresight_tpiu snd_pcm coresight
snd_timer qrtr msm snd adv7511 qcom_camss qcom_q6v5_mss soundcore
qcom_spmi_temp_alarm rtc_pm8xxx qcom_pon qcom_pil_info
videobuf2_dma_sg ubwc_config qcom_q6v5 venus_core(+) qcom_sysmon
qcom_spmi_vadc v4l2_fwnode llcc_qcom v4l2_async qcom_vadc_common
qcom_common ocmem v4l2_mem2mem drm_gpuvm videobuf2_memops
qcom_glink_smem videobuf2_v4l2 drm_exec mdt_loader qmi_helpers
gpu_sched drm_dp_aux_bus qnoc_msm8916 videodev drm_display_helper
qcom_stats videobuf2_common cec qcom_rng drm_client_lib mc
phy_qcom_usb_hs socinfo rpmsg_ctrl display_connector rpmsg_char
ramoops rmtfs_mem reed_solomon drm_kms_helper fuse drm backlight
[  317.131166] CPU: 0 UID: 0 PID: 88 Comm: kworker/u16:5 Tainted: G
  D W           6.16.0-next-20250804 #1 PREEMPT
[  317.153317] Tainted: [D]=DIE, [W]=WARN
[  317.163972] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[  317.167536] Workqueue: events_unbound idle_cull_fn
[  317.174392] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  317.178993] pc : refcount_warn_saturate
(/builds/linux/lib/refcount.c:22 (discriminator 1))
[  317.185848] lr : refcount_warn_saturate
(/builds/linux/lib/refcount.c:22 (discriminator 1))
[  317.190708] sp : ffff8000839dbcd0
[  317.195478] x29: ffff8000839dbcd0 x28: 0000000000000000 x27: 0000000000000000
[  317.198871] x26: ffff000003418c28 x25: 0000000000000000 x24: ffff000003418c78
[  317.205990] x23: dead000000000122 x22: dead000000000100 x21: ffff8000839dbd38
[  317.213109] x20: ffff0000044a4828 x19: ffff0000044a4800 x18: 0000000000000000
[  317.220226] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  317.227345] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[  317.234463] x11: 00000000000000c0 x10: 0000000000000b50 x9 : ffff80008163543c
[  317.241581] x8 : ffff8000839db9e8 x7 : 0000000000000001 x6 : 0000000000000001
[  317.248699] x5 : ffff8000828ab000 x4 : ffff8000828ab3e0 x3 : 0000000000000000
[  317.255817] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000059e0000
[  317.262936] Call trace:
[  317.270045] refcount_warn_saturate (/builds/linux/lib/refcount.c:22
(discriminator 1)) (P)
[  317.272306] kthread_stop
(/builds/linux/include/linux/refcount.h:291
/builds/linux/include/linux/refcount.h:366
/builds/linux/include/linux/refcount.h:383
/builds/linux/include/linux/sched/task.h:116
/builds/linux/kernel/kthread.c:784)
[  317.277163] kthread_stop_put
(/builds/linux/include/linux/sched/task.h:130
/builds/linux/kernel/kthread.c:812)
[  317.280897] idle_cull_fn (/builds/linux/kernel/workqueue.c:2859
/builds/linux/kernel/workqueue.c:2980)
[  317.284541] process_one_work (/builds/linux/kernel/workqueue.c:3241)
[  317.288361] worker_thread (/builds/linux/kernel/workqueue.c:3313
(discriminator 2) /builds/linux/kernel/workqueue.c:3400 (discriminator
2))
[  317.292353] kthread (/builds/linux/kernel/kthread.c:463)
[  317.295999] ret_from_fork (/builds/linux/arch/arm64/kernel/entry.S:861)
[  317.299386] ---[ end trace 0000000000000000 ]---
[  317.303294] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[  317.307630] Mem abort info:
[  317.316403]   ESR = 0x0000000096000004
[  317.318879]   EC = 0x25: DABT (current EL), IL = 32 bits
[  317.322723]   SET = 0, FnV = 0
[  317.328194]   EA = 0, S1PTW = 0
[  317.331025]   FSC = 0x04: level 0 translation fault
[  317.334121] Data abort info:
[  317.338933]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[  317.342061]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  317.347364]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  317.352515] user pgtable: 4k pages, 48-bit VAs, pgdp=000000008a592000
[  317.357892] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[  317.364247] Internal error: Oops: 0000000096000004 [#3]  SMP
[  317.370923] Modules linked in: pm8916_wdt qcom_wcnss_pil
snd_soc_lpass_apq8016 snd_soc_msm8916_analog snd_soc_lpass_cpu
snd_soc_apq8016_sbc snd_soc_msm8916_digital snd_soc_lpass_platform
snd_soc_qcom_common coresight_cpu_debug snd_soc_core coresight_tmc
coresight_replicator snd_compress coresight_funnel snd_pcm_dmaengine
coresight_stm stm_core coresight_cti coresight_tpiu snd_pcm coresight
snd_timer qrtr msm snd adv7511 qcom_camss qcom_q6v5_mss soundcore
qcom_spmi_temp_alarm rtc_pm8xxx qcom_pon qcom_pil_info
videobuf2_dma_sg ubwc_config qcom_q6v5 venus_core(+) qcom_sysmon
qcom_spmi_vadc v4l2_fwnode llcc_qcom v4l2_async qcom_vadc_common
qcom_common ocmem v4l2_mem2mem drm_gpuvm videobuf2_memops
qcom_glink_smem videobuf2_v4l2 drm_exec mdt_loader qmi_helpers
gpu_sched drm_dp_aux_bus qnoc_msm8916 videodev drm_display_helper
qcom_stats videobuf2_common cec qcom_rng drm_client_lib mc
phy_qcom_usb_hs socinfo rpmsg_ctrl display_connector rpmsg_char
ramoops rmtfs_mem reed_solomon drm_kms_helper fuse drm backlight
[  317.443145] CPU: 0 UID: 0 PID: 88 Comm: kworker/u16:5 Tainted: G
  D W           6.16.0-next-20250804 #1 PREEMPT
[  317.465294] Tainted: [D]=DIE, [W]=WARN
[  317.475949] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[  317.479516] Workqueue: events_unbound idle_cull_fn
[  317.486370] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  317.490972] pc : kthread_stop
(/builds/linux/arch/arm64/include/asm/atomic_ll_sc.h:203
(discriminator 2) /builds/linux/arch/arm64/include/asm/atomic.h:65
(discriminator 2)
/builds/linux/include/linux/atomic/atomic-arch-fallback.h:3798
(discriminator 2)
/builds/linux/include/linux/atomic/atomic-long.h:1069 (discriminator
2) /builds/linux/include/asm-generic/bitops/atomic.h:18 (discriminator
2) /builds/linux/include/asm-generic/bitops/instrumented-atomic.h:29
(discriminator 2) /builds/linux/kernel/kthread.c:786 (discriminator
2))
[  317.497825] lr : kthread_stop
(/builds/linux/include/linux/refcount.h:291
/builds/linux/include/linux/refcount.h:366
/builds/linux/include/linux/refcount.h:383
/builds/linux/include/linux/sched/task.h:116
/builds/linux/kernel/kthread.c:784)
[  317.501989] sp : ffff8000839dbce0
[  317.505981] x29: ffff8000839dbce0 x28: 0000000000000000 x27: 0000000000000000
[  317.509288] x26: ffff000003418c28 x25: 0000000000000000 x24: ffff000003418c78
[  317.516405] x23: dead000000000122 x22: dead000000000100 x21: 0000000000000000
[  317.523526] x20: ffff0000044a4828 x19: ffff0000044a4800 x18: 0000000000000000
[  317.530642] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  317.537762] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[  317.544879] x11: 00000000000000c0 x10: 0000000000000b50 x9 : ffff80008163543c
[  317.551996] x8 : ffff8000839db9e8 x7 : 0000000000000001 x6 : 0000000000000001
[  317.559116] x5 : ffff8000828ab000 x4 : ffff8000828ab3e0 x3 : 0000000000000000
[  317.566232] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 000000000020804c
[  317.573353] Call trace:
[  317.580461] kthread_stop
(/builds/linux/arch/arm64/include/asm/atomic_ll_sc.h:203
(discriminator 2) /builds/linux/arch/arm64/include/asm/atomic.h:65
(discriminator 2)
/builds/linux/include/linux/atomic/atomic-arch-fallback.h:3798
(discriminator 2)
/builds/linux/include/linux/atomic/atomic-long.h:1069 (discriminator
2) /builds/linux/include/asm-generic/bitops/atomic.h:18 (discriminator
2) /builds/linux/include/asm-generic/bitops/instrumented-atomic.h:29
(discriminator 2) /builds/linux/kernel/kthread.c:786 (discriminator
2)) (P)
[  317.582720] kthread_stop_put
(/builds/linux/include/linux/sched/task.h:130
/builds/linux/kernel/kthread.c:812)
[  317.586884] idle_cull_fn (/builds/linux/kernel/workqueue.c:2859
/builds/linux/kernel/workqueue.c:2980)
[  317.590531] process_one_work (/builds/linux/kernel/workqueue.c:3241)
[  317.594351] worker_thread (/builds/linux/kernel/workqueue.c:3313
(discriminator 2) /builds/linux/kernel/workqueue.c:3400 (discriminator
2))
[  317.598345] kthread (/builds/linux/kernel/kthread.c:463)
[  317.601988] ret_from_fork (/builds/linux/arch/arm64/kernel/entry.S:861)
[ 317.605380] Code: c8017e60 35ffffa1 17ffffaf f98002b1 (c85f7ea0)
All code
========
   0: c8017e60 stxr w1, x0, [x19]
   4: 35ffffa1 cbnz w1, 0xfffffffffffffff8
   8: 17ffffaf b 0xfffffffffffffec4
   c: f98002b1 prfm pstl1strm, [x21]
  10:* c85f7ea0 ldxr x0, [x21] <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0: c85f7ea0 ldxr x0, [x21]
[  317.608944] ---[ end trace 0000000000000000 ]---

## Source
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 5c5a10f0be967a8950a2309ea965bae54251b50e
* Git describe: next-20250804
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250804
* Architectures: arm64 Dragonboard-410c
* Toolchains: gcc-13
* Kconfigs: selftests/*/configs

## Build
* Test log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250804/testrun/29369024/suite/kselftest-cgroup/test/cgroup_test_cpu_test_cpucg_weight_underprovisioned/log
* Test details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250804/testrun/29369024/suite/log-parser-test/tests/
* Test history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250804/testrun/29369024/suite/log-parser-test/test/exception-refcount_t-saturated-leaking-memory/history/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/30oCAeKlwlxH2CKKW2YbjVNQ5oX
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/30oC7ut8e7yXWPAtJXayE9a4nMn/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/30oC7ut8e7yXWPAtJXayE9a4nMn/config

--
Linaro LKFT
https://lkft.linaro.org

