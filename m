Return-Path: <linux-fsdevel+bounces-64426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EDCBE749F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A0618927A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2101293C42;
	Fri, 17 Oct 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ds7lp1vJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B770726F292
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691130; cv=none; b=W32JPCpja+9zkFrLlno4MSFcRGOQ/QUXkC8hdC37N3iJEUkgDbpqXtZrYcg+eNC1UuEhB8I1DdE70s2iZqMauJPT7a/Tyahm4PrNjUOj8KjO9eyp54g76/qc/7IatyJUxggX+LWPc/FDxN28M+ou6tyP4IgC/JW4SSW+WRAkZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691130; c=relaxed/simple;
	bh=2oLMnCZ23LLTDdFKDD3O2sUs72MeFy/tN37/VGxtlsA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JNLNab2RCQmESVjw2gk1ArpoY7T4/D+cbqwzgpsrjJnXVdxezT2BU3QBrfSLOSZ/vfXeVKmzC7jGo7vd+yISA8cF96c9CyHjvMXv71wBQ3Y/8KnCTWBQ4Ox7pmH6aVEnmRnDlv7SJ0hGm8xl7sQA9Rg/jFGNXCl1Wp9gE1LsK2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ds7lp1vJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-292322d10feso309215ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 01:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760691128; x=1761295928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J+y1vB4iqnryB//UhMXxu9OFiqC1kDkx0s8+5S3KEFo=;
        b=ds7lp1vJAhMfZEy3rXTjECwKGoxjvE2Wbdw6EdyDbPI9JQFiiaHIY1butP8qXAOnGj
         nDV0MoztSaExsAcpoS/qXcrqw0gFPGoHbu/GERV3s21uMQUUJ0sDyD69MxWPH72bR8Jc
         AGAfxM9TadlB0twAq3ZAxESDfL1rZBFnFoYVYGyEFpppHY8MLAVTtCcMW8d3paJ1+YAN
         QE9DxM6E5lv3pxwqgQUrwTVSdv7VQKJyWSVnY1buoiNhE6QJ+XfaEx41GF716y+2JVJl
         e7QcC8eU6I1QPGocTztgesmJ0jHEt2vwJWy5Qu3DPnrHrrFwYYiBRutifuTQ18sSDA/E
         4M3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691128; x=1761295928;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J+y1vB4iqnryB//UhMXxu9OFiqC1kDkx0s8+5S3KEFo=;
        b=NVjp3YKPVHYhH954zadFY1onVlgLsKj9TCjc9d5rnBY7O5Wfr7jmIA949X8Kaf30uI
         ronSo7bwwmk6+piRjw5nE92nAYQ49wHs30g/Faog0Ayit7wHp00Yj/7od756LY1qZyEJ
         77Tbv52JfO4VUVEPSRG9f1zxYmYH2DlWetmH3eb3QYd7MzDMc8jMZuphzaJMnXqD0QJe
         V1fmj2TV1Svsox6crC+RiZmSFiP0l0QPlSq4lWjlArpBW3Tc0Nwr1uzFSbJim8uz9z9m
         p3dwmTH5HVsOOGx9ZJEwDG4TlYCuK4T04MNVDWANxRIL5f/Sh6yl05F8arM2xjl77t6D
         XH+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3psMb0WLZDBvSj7Q0tmp37vJ9VX4iOTnZgMf8Z/+CjWvUBy+3uXqXm/YjVcYXwzBhG3seC/kxI7Wrx4aP@vger.kernel.org
X-Gm-Message-State: AOJu0YzZm7rmU4wdk8HcWPzOFmlzVlQPE0CaIVs+xadpAwedeolEaqIB
	1HJXqzwNvK+QV/coih4QHJv4kjzh/rdnj2eYNI9u3rS7+xHM431CM8/PSDTKcmAzfAjr3bzSRRI
	ofFAHPIJqBswK3bFPuGatjej251yU2Ic7TW72YPZnXw==
X-Gm-Gg: ASbGncsACtYdjfQE4OAmLSYgvNko9ENiZp8O3yus11S6F3vcDwaraCaD1Y7/fayB42T
	Z5RDF9LPDsd3MGwTeFrkWEI3JHX49aW5OmSqmt1qcslsXosvRjhRUH5k6xGgT+us/WP4HzPSGGf
	J8a1OWstOPT2B5WBSHSHdi35t3SckhYqAhaaYdVs4EWLzEWRO8BMhrmY780HljVOLO24DqpqVPt
	9gpBaW62+hcML0zuUA7o1p3jJ/2y2x4b+5GF8nMaCJYFsWviBN+2TRKKiAjenxjRS07kq6COyuG
	ZpeUCtglnBlVL/80Px8X0ws0SqLOU6QFhr6WC3VslCv3EJi8tSOhl+s8iKu9
X-Google-Smtp-Source: AGHT+IHnzdCZiWkeq6B0nWCC7+Ta7WqnE/RTfJHl80GUdwDwM+iInU4JzJQ1fseC0j68aNlkWHaYLC2Le5AdhB426tw=
X-Received: by 2002:a17:903:2310:b0:290:ad7a:bb50 with SMTP id
 d9443c01a7336-290ad7abe3amr60139775ad.27.1760691127941; Fri, 17 Oct 2025
 01:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 17 Oct 2025 14:21:56 +0530
X-Gm-Features: AS18NWDmy4VY4bYGS9Uinoj_a_bgUwsPBK0TlYzxtMKYza6ex6eRnnUZiu6_1_8
Message-ID: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
Subject: 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL: ioctl(pidfd,
 PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL: ENOTTY (25)
To: open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The LTP syscalls ioctl_pidfd05 test failed due to following error on
the Linux mainline
kernel v6.18-rc1-104-g7ea30958b305 on the arm64, arm and x86_64.

The Test case is expecting to fail with EINVAL but found ENOTTY.

Please investigate this reported regression.

First seen on v6.18-rc1-104-g7ea30958b305
Good: 6.18.0-rc1
Bad: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Test regressions: 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL:
ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL:
ENOTTY (25)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test error log
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_test.c:2021: TINFO: LTP version: 20250930
tst_test.c:2024: TINFO: Tested kernel: 6.18.0-rc1 #1 SMP PREEMPT
@1760657272 aarch64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
which might slow the execution
tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
ioctl_pidfd05.c:45: TPASS: ioctl(pidfd, PIDFD_GET_INFO, NULL) : EINVAL (22)
ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT,
info_invalid) expected EINVAL: ENOTTY (25)
Summary:
passed   1
failed   1

## Source
* Kernel version: 6.18.0-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
* Git describe: v6.18-rc1-104-g98ac9cc4b445
* Git commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
* Architectures: arm64, x86_64
* Toolchains: gcc-13 clang
* Kconfigs: defconfig+lkftconfig

## Build
* Test log: https://lkft.validation.linaro.org/scheduler/job/8495154#L15590
* Test details:
https://regressions.linaro.org/lkft/linux-mainline-master/v6.18-rc1-104-g98ac9cc4b445/ltp-syscalls/ioctl_pidfd05/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/34AVGrBMrEy9qh7gqsguINdUFFt
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34AVFcbKDpJQfCdAQupg3lZzwFY/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/34AVFcbKDpJQfCdAQupg3lZzwFY/config

--
Linaro LKFT

