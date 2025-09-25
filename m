Return-Path: <linux-fsdevel+bounces-62793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E6FBA105D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 20:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35BF07A2F2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 18:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99E23191AD;
	Thu, 25 Sep 2025 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AfashHh6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C993164DF
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825022; cv=none; b=Hz/5UCOH0WUtV+ecJbPlmGIs2frvnMC84WGEbM5Bw2BnR9D+wa47/GFs3ZO0VjDd7iLjBI2cnXpgkE/AjkiRqL3ZJuDTU5DNHs1lQn6gA5muxSBcaYtVdgIVEI/6HoyAiLjS3iG6d6HhFZlhQcl6M3AtZFCAAWILqJO/f6aVhYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825022; c=relaxed/simple;
	bh=tCSiCHjiYLBxiKxlzQijJtKjNIcmFyJ2Vn54zVJDrFE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UAwoCpOlSNJs4HJsdcg30B7Y3QnNx8sRkEjDl184rp8Q4v5UcCWvoL4/uZlJDQjD8gxEDpK/NbGSqV0o2xx5+RuKL55jBc28gDm36yt6YT7GKzNMYyqtyMibwn1G9qcc9RCef0ILHNhd0PsVPxRJElA9bVJxqmBi/UhX1PgLGgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AfashHh6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-279e2554c8fso13061635ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758825019; x=1759429819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AD3Aprn/2Yo5LyXOC6U3dPN+8zQtQVUv9tcaZi7+WVY=;
        b=AfashHh6rUbxAMRwzk2ib/8WUrYt49OEOg7pkBw6020hcJCRp3m+5dojxs8adEG1z2
         bF7znesG3ylX424JTj45YkHo36IBa4d2zvunbj1ziB6bRNQMuOEfV4eRCO5hhQsBnQyY
         fh/AS4h6WEl12ZemG5cxhecy+aVkaOtYQawiWLYpdtx4N2bmR4toyP+ryD+0naFTrfY5
         A3Yyfw9iAX9PafpglLzK9stvVkyRKMYCPIaJJ1lOmhivC7TYQR4gEdXejAie+4Fe/XAj
         s5HBYrJzUFBoWCAqYRjdoa6npu6z73qaWK1sM45ct/yTBsj0P4Bdp3/AZna0N4coaN+x
         YoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825019; x=1759429819;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AD3Aprn/2Yo5LyXOC6U3dPN+8zQtQVUv9tcaZi7+WVY=;
        b=jmNzas3QiQp8eIxeDBEAVd3uuTjA3bm2hrs9csI6zAHMacClkKsL+x3gGhcvV+cX8w
         eHFEl9jH5l1GRuBCyZyRnEneUDDt64IXPzLz8YcXSa22DukeWfjXC4KUXnoH8B7nqmWB
         ppJt3jaYqKsp1Kr9uP/lh/ebPFMgXmxhuPMvoJNuwwrOSWvFio2BZ0+wcxd2EV4I9QWF
         0UUaOluuGBT+sMC2gYypR/jVM/GPPe+hM3r4Qt8Em4SlPTYGIIthnStWWy8bV9nWTqwv
         0kwg0rQQu6R+td5PAyUW5ayfoAu5HIMZduwSGCVGv227Y4Q9P7jGwdraWIIH8cF4M0YS
         bw0g==
X-Forwarded-Encrypted: i=1; AJvYcCXDVTDlFwUgubxOoa0J+agLgIfFr1ubtDKrcScJxzHVng9sBrlkjVpY8B3/Rtrx91oisjCMTXYWneHL3y+C@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+5iJu/Rn4iJVdT90ibtjgLPvVnsnz3AxNsdcjxn1Xjm+dHySm
	fEzRdSar2I7f5/BjZtUCVtB+bptkHkWjMRT0PdMtmzdMNgKecRN4rQJCe/7X4qjx8aVo58vGCkq
	cnuvkRktoSM26o+Cdfnr56hJr+3Yv0bGEytA93+C+xQ==
X-Gm-Gg: ASbGnctAm/0NNcK8qvmiCEWAk1H9/I8UXkETZma4hwiaqg/c6szB5KdrE0kHz+3zX9X
	qt+d/3kCKaiB+N3vfqT/q5Tx6tdatA31/emRKJEx+wpq35kRwkS11uH3bcWQRZqIVcTzf/wcBFS
	95tpNIWK2rGurCP17xhRNgX2THeJFfxEC/fzh96gkY8MsSgH+ISl/a1R85dRSJvT9G3LJQkYLtG
	8UETgEmiimevxbpn8RgcM7nwuiMLh2/buxsB9iI
X-Google-Smtp-Source: AGHT+IG0aEHA+SJ8POTvI7rXmHNNRmnCFjhfAJmzMzYuwnnWzgcjC3HMZZQWT5S9lDAxvmI0iW8mMspWOZ82crH3Q5k=
X-Received: by 2002:a17:902:fccf:b0:273:31fb:a872 with SMTP id
 d9443c01a7336-27ed4a06cefmr33651145ad.6.1758825019214; Thu, 25 Sep 2025
 11:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 26 Sep 2025 00:00:08 +0530
X-Gm-Features: AS18NWDtBpm_KTK7hpnu3EgD5L63hZbjcu26dinYNzF8NjUERzFkzicBNK0EhOQ
Message-ID: <CA+G9fYueO8kP8mXVNmbHkyrFPKpt-onPfeyNXLuLGGjiO1WFfQ@mail.gmail.com>
Subject: next-20250924: Internal error: Oops: mnt_ns_release
 (fs/namespace.c:148) __arm64_sys_listmount (fs/namespace.c:5936)
To: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

While running LTP syscalls tests on Linux next-20250924 tag build
the following kernel oops noticed on arm64 and x86_64 devices.

First seen on next-20250924
Good: next-20250923
Bad: next-2025094

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Test regression: next-20250924: Internal error: Oops: mnt_ns_release
(fs/namespace.c:148) __arm64_sys_listmount (fs/namespace.c:5936)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
$  git log --oneline next-20250923..next-20250924  -- fs/namespace.c
c54644c3221b6 (next/fs-next) Merge branch 'for-next' of
https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
1f28cc19559a8 Merge branch 'namespace-6.18' into vfs.all
e2c277f720291 Merge branch 'kernel-6.18.clone3' into vfs.all
b2af83d5b8223 Merge branch 'vfs-6.18.mount' into vfs.all
29ecd1ca48ec2 Merge branch 'vfs-6.18.misc' into vfs.all
d7610cb7454bb ns: simplify ns_common_init() further
59bfb66816809 listmount: don't call path_put() under namespace semaphore
2bc5bfbfd3f27 statmount: don't call path_put() under namespace semaphore


## Test log
[   41.821877] Internal error: Oops: 0000000096000005 [#1]  SMP
[   41.919038] Modules linked in: cdc_ether usbnet sm3_ce sha3_ce nvme
xhci_pci_renesas nvme_core arm_cspmu_module arm_spe_pmu ipmi_devintf
ipmi_msghandler arm_cmn cppc_cpufreq drm fuse backlight
[   41.944048] CPU: 14 UID: 0 PID: 6416 Comm: listmount04 Not tainted
6.17.0-rc7-next-20250924 #1 PREEMPT
[   41.958197] Hardware name: Inspur NF5280R7/Mitchell MB, BIOS
04.04.00004001 2025-02-04 22:23:30 02/04/2025
[   41.967837] pstate: 63400009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[   41.974958] pc : mnt_ns_release
(arch/arm64/include/asm/atomic_lse.h:62 (discriminator 1)
arch/arm64/include/asm/atomic_lse.h:76 (discriminator 1)
arch/arm64/include/asm/atomic.h:51 (discriminator 1)
include/linux/atomic/atomic-arch-fallback.h:944 (discriminator 1)
include/linux/atomic/atomic-instrumented.h:401 (discriminator 1)
include/linux/refcount.h:389 (discriminator 1)
include/linux/refcount.h:432 (discriminator 1)
include/linux/refcount.h:450 (discriminator 1) fs/namespace.c:148
(discriminator 1))
[   41.981910] lr : __arm64_sys_listmount (fs/namespace.c:5936)
[   41.993467] sp : ffff8000ff5afd50
[   42.000329] x29: ffff8000ff5afd50 x28: fff00001bd947380 x27: 0000000000000000
[   42.007454] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000100
[   42.030726] x23: 0000000000000000 x22: 0000000000000020 x21: ffff8000ff5afdc8
[   42.038281] x20: 0000aaaabd6a1110 x19: 0000000000000000 x18: 0000000000000000
[   42.045405] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   42.052528] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[   42.075541] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffda68dcdbbe30
[   42.082835] x8 : ffff8000ff5afda0 x7 : fefefefefefefefe x6 : ffffda68df5e9000
[   42.096212] x5 : fff00001bd947380
[   42.108978]  x4 : fff00001bd947380 x3 : 0000000000000000
[   42.114449] x2 : 0000000000000000 x1 : 00000000ffffffff x0 : 00000000000000b8
[   42.134515] Call trace:
[   42.139725]  mnt_ns_release (arch/arm64/include/asm/atomic_lse.h:62
(discriminator 1) arch/arm64/include/asm/atomic_lse.h:76
(discriminator 1) arch/arm64/include/asm/atomic.h:51 (discriminator 1)
include/linux/atomic/atomic-arch-fallback.h:944 (discriminator 1)
include/linux/atomic/atomic-instrumented.h:401 (discriminator 1)
include/linux/refcount.h:389 (discriminator 1)
include/linux/refcount.h:432 (discriminator 1)
include/linux/refcount.h:450 (discriminator 1) fs/namespace.c:148
(discriminator 1)) (P)
[   42.143811]  __arm64_sys_listmount (fs/namespace.c:5936)
[   42.148327]  invoke_syscall.constprop.0
(arch/arm64/include/asm/syscall.h:61 arch/arm64/kernel/syscall.c:54)
[   42.159193]  do_el0_svc (include/linux/thread_info.h:135
(discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2)
arch/arm64/kernel/syscall.c:151 (discriminator 2))
[   42.163970]  el0_svc (arch/arm64/include/asm/irqflags.h:82
(discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
arch/arm64/kernel/entry-common.c:102 (discriminator 1)
arch/arm64/kernel/entry-common.c:745 (discriminator 1))
[   42.173791]  el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:764)
[   42.185342]  el0t_64_sync (arch/arm64/kernel/entry.S:596)
[   42.189165] Code: aa0003f3 9102e000 d503201f 12800001 (b8610001)
All code
========
   0: aa0003f3 mov x19, x0
   4: 9102e000 add x0, x0, #0xb8
   8: d503201f nop
   c: 12800001 mov w1, #0xffffffff            // #-1
  10:* b8610001 ldaddl w1, w1, [x0] <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0: b8610001 ldaddl w1, w1, [x0]
[   42.211485] ---[ end trace 0000000000000000 ]---

## Source
* Kernel version: 6.17.0-rc7
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe:  6.17.0-rc7-next-20250924
* Git commit: b5a4da2c459f79a2c87c867398f1c0c315779781
* Architectures: arm64, x86_64
* Toolchains: gcc-13
* Kconfigs: defconfig+lkftconfig

## Build
* Test log arm64: https://qa-reports.linaro.org/api/testruns/30007634/log_file/
* Test log x86_64: https://qa-reports.linaro.org/api/testruns/30000230/log_file/
* Test details:
https://regressions.linaro.org/lkft/linux-next-master-ampere/next-20250924/log-parser-test/internal-error-oops-oops-smp/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/ampere/projects/ci/tests/339teV8pAwrsgeSJq9beV5V11U8
* Build link: https://storage.tuxsuite.com/public/ampere/ci/builds/339teBhKZ4DENKbJJNnbWKh5ud1/
* Kernel config:
https://storage.tuxsuite.com/public/ampere/ci/builds/339teBhKZ4DENKbJJNnbWKh5ud1/config

--
Linaro LKFT

