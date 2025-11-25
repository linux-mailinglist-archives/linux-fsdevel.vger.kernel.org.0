Return-Path: <linux-fsdevel+bounces-69806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29342C860DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 17:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE1D24E1103
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 16:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3A4329C6F;
	Tue, 25 Nov 2025 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Q153C7aJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB5329C41
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089939; cv=none; b=gXo6pVCYyeupcnKfu4/IGlV9f+oDnp8KBG1u9QJLjSRdKJzH6jslmvMf7sMI2WAkb/RlRjzrf4emWoLMKQ00RH0Lmy4nhcHCI6pXpBC39jJ8v6lNtzB7RR9bP9S9KNt0qdh7vi/OAVkhnSgpuPLP+jKz/TZECeLvblEowGAbOeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089939; c=relaxed/simple;
	bh=jVG9rx5CvSPo99jlwhy20G+OuBT7bC72SU590paaAd8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tc/ji1fXKF/VdxLcA6MPLQOzigQbYt18uNEcxsCfefV4c6bNqPFN1v4mdepV5Nj1CwMgpKmZ8QfD7oQsvy8UaM8M/nKJPcPwNtnuOoxC9+PWQBYjDTKap7qkgSQwpGPUEC1I6C9idwBEEcOsCU8f3OSd0nhVte52Tmd+rQ+lBtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Q153C7aJ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78a76afeff6so58529097b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 08:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764089936; x=1764694736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YTqmNHLzo7tzA7JTUOF0GwvLgycpcp7G73ozWdvx2A8=;
        b=Q153C7aJ3QHpqipIHNJd5lE36iTKfuC5ocKGGNdNSD5os/Feliaxwu9QIC/7ng+47W
         YBnV3RB4I7FrlOr1pRWJrgCqzh14Pf4grgsrcooWYPLKvrqJ5/ExGBk+fqACW+TaEVN5
         dQbDBvtLRcUV8YRuoAEZyZ17tVpulmubr9QoUFqx6JCEAjd+HfoDuffH8kQCrndEsXr1
         ToF+vrPyAciMgNsgpT14B0uOp7utLxke583gMQV7pum65wLlPKcQkLSTmnR5AWcrpWL/
         i+RIBNGwctGof0xq7lsmcuBVXSKNemr9Ia1d7X/klxpeUbqfN15U0LCR4BmmHT782yqt
         FHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089936; x=1764694736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTqmNHLzo7tzA7JTUOF0GwvLgycpcp7G73ozWdvx2A8=;
        b=jhaEZjRyW1DBQpP1nN0oW0Qp+VlGBQEgxD1TFRps96dPeYFSUBnHj5UkoFgiKJjc5G
         fULMccsIoYRPTA/gDcpDBInt+KvFlcRMow099F2VWplPC8pHurljY19B7FZzO/l1Fo6q
         G7ay7F861g/hJqHDQHHiMGs0z8912SiK2R2c4aSJD8m1fscfhWMY/gVfernXwM04CV7U
         DlHLPQs5SD8j2mQGf9jIPYsYfTK7GAHRfYKbeQx7PLqoGwdReFbcER/EsDw56xn+0YHG
         S2CiTzPSBNLf32l39lc3xU6aT7Mfjp53ngGM6Inzdt73CPku1ZVMJilXv5RlBQtvmoT7
         TiAA==
X-Forwarded-Encrypted: i=1; AJvYcCXgOQvBtmJvtEW8sfZjFykyDPpF0rUxNT+wgM++m7yHlskjkmzgE4tFjSE3yS/D6CkfkijDSsX2TVMRxdC3@vger.kernel.org
X-Gm-Message-State: AOJu0YyM4jOfCNyX39NNg4aUXUo5C6BmiVTOTalIdDPN/4BaC2B4x5O+
	zPWQRPciHlI833wTqTZNIfjHO0Kp5SdasS4k0hIADd5EeHmq+XzsFtlpHh8wHba9UzM=
X-Gm-Gg: ASbGncsbJjijHefgsRiv19Ok80xWG71wUFU8/7Tsded4yyd3nHAP2o2S1Gy9SWxl9gn
	P1Bk6uqDif+OIGSomzj2vEgQUPaaZ39ogJN5bL0CdVb73dbHe5X5wRx5pNpwhlcosWuBT/TEXbs
	++opQOhHkdqsU0aefVN4eg4xpOoTUuBarM4ueTi6I8FbDDCvvvE9T0a+9BTX73bYiPbAebuCuaE
	x6LNmm3ttxSOwXtaA1cIWEV4d0cWY/PWFacZf9qQfW5KoYPdJ8rtBfituhx0wVQlZVRh+DeVrFX
	X5nHes3htsw1ByiG+oM4R2MSjHZhlBF4VY3+5jn5Jn+wn0jmTctijRnscYTkwcRq+xZcAQ7jbOt
	OsNj/L0sFzbZXVezeu0cXmqsaIAUHPmDpEwoqVZaZ0fP81EB4DDP79a6bvLiqsYrz/w7yVOqz4v
	WwWpiMeBsL8VsKKCk8LAj8r0MWPkALw6EntpMY9Kv223DDYeJYEW39jhd7QUSs0uRY
X-Google-Smtp-Source: AGHT+IFlGlAqfg3sgpTFRFuiP3B5xnmQBkkcc9sAGNtrDo+gmfCnheeaiZNxk8RVJmj4AT68BfJgow==
X-Received: by 2002:a05:690c:2784:b0:786:7aaa:a04f with SMTP id 00721157ae682-78a8b47f8d2mr141269687b3.8.1764089936257;
        Tue, 25 Nov 2025 08:58:56 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a5518sm57284357b3.14.2025.11.25.08.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:58:55 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v8 00/18] Live Update Orchestrator
Date: Tue, 25 Nov 2025 11:58:30 -0500
Message-ID: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Andrew: This series has been fully reviewed, and contains minimal
changes compared to what is currently being tested in linux-next
diff between v7 and v8 can be viewe, here: [8]

Four patches have been dropped compared to v7: and are going to be sent
separately.

This series introduces the Live Update Orchestrator, a kernel subsystem
designed to facilitate live kernel updates using a kexec-based reboot.
This capability is critical for cloud environments, allowing hypervisors
to be updated with minimal downtime for running virtual machines. LUO
achieves this by preserving the state of selected resources, such as
memory, devices and their dependencies, across the kernel transition.

As a key feature, this series includes support for preserving memfd file
descriptors, which allows critical in-memory data, such as guest RAM or
any other large memory region, to be maintained in RAM across the kexec
reboot.

The other series that use LUO, are VFIO [1], IOMMU [2], and PCI [3]
preservations.

Github repo of this series [4].

The core of LUO is a framework for managing the lifecycle of preserved
resources through a userspace-driven interface. Key features include:

- Session Management
  Userspace agent (i.e. luod [5]) creates named sessions, each
  represented by a file descriptor (via centralized agent that controls
  /dev/liveupdate). The lifecycle of all preserved resources within a
  session is tied to this FD, ensuring automatic kernel cleanup if the
  controlling userspace agent crashes or exits unexpectedly.

- File Preservation
  A handler-based framework allows specific file types (demonstrated
  here with memfd) to be preserved. Handlers manage the serialization,
  restoration, and lifecycle of their specific file types.

- File-Lifecycle-Bound State
  A new mechanism for managing shared global state whose lifecycle is
  tied to the preservation of one or more files. This is crucial for
  subsystems like IOMMU or HugeTLB, where multiple file descriptors may
  depend on a single, shared underlying resource that must be preserved
  only once.

- KHO Integration
  LUO drives the Kexec Handover framework programmatically to pass its
  serialized metadata to the next kernel. The LUO state is finalized and
  added to the kexec image just before the reboot is triggered. In the
  future this step will also be removed once stateless KHO is
  merged [6].

- Userspace Interface
  Control is provided via ioctl commands on /dev/liveupdate for creating
  and retrieving sessions, as well as on session file descriptors for
  managing individual files.

- Testing
  The series includes a set of selftests, including userspace API
  validation, kexec-based lifecycle tests for various session and file
  scenarios, and a new in-kernel test module to validate the FLB logic.

Changelog since v7 [7]
- Collected Reviewed-by tags from Mike Rapoport, Pratyush Yadav.
- Addressed mostly nits. The diff can be viewed here [8].
 
[1] https://lore.kernel.org/all/20251018000713.677779-1-vipinsh@google.com/
[2] https://lore.kernel.org/linux-iommu/20250928190624.3735830-1-skhawaja@google.com
[3] https://lore.kernel.org/linux-pci/20250916-luo-pci-v2-0-c494053c3c08@kernel.org
[4] https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v8
[5] https://tinyurl.com/luoddesign
[6] https://lore.kernel.org/all/20251020100306.2709352-1-jasonmiu@google.com
[7] https://lore.kernel.org/all/20251115233409.768044-1-pasha.tatashin@soleen.com
[8] https://github.com/soleen/linux/blob/luo/v8b03/diff.v7.v8

Pasha Tatashin (12):
  liveupdate: luo_core: Live Update Orchestrato,
  liveupdate: luo_core: integrate with KHO
  kexec: call liveupdate_reboot() before kexec
  liveupdate: luo_session: add sessions support
  liveupdate: luo_core: add user interface
  liveupdate: luo_file: implement file systems callbacks
  liveupdate: luo_session: Add ioctls for file preservation
  docs: add luo documentation
  MAINTAINERS: add liveupdate entry
  selftests/liveupdate: Add userspace API selftests
  selftests/liveupdate: Add simple kexec-based selftest for LUO
  selftests/liveupdate: Add kexec test for multiple and empty sessions

Pratyush Yadav (6):
  mm: shmem: use SHMEM_F_* flags instead of VM_* flags
  mm: shmem: allow freezing inode mapping
  mm: shmem: export some functions to internal.h
  liveupdate: luo_file: add private argument to store runtime state
  mm: memfd_luo: allow preserving memfd
  docs: add documentation for memfd preservation via LUO

 Documentation/core-api/index.rst              |   1 +
 Documentation/core-api/liveupdate.rst         |  61 ++
 Documentation/mm/index.rst                    |   1 +
 Documentation/mm/memfd_preservation.rst       |  23 +
 Documentation/userspace-api/index.rst         |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 Documentation/userspace-api/liveupdate.rst    |  20 +
 MAINTAINERS                                   |  16 +
 include/linux/kho/abi/luo.h                   | 166 ++++
 include/linux/kho/abi/memfd.h                 |  77 ++
 include/linux/liveupdate.h                    | 138 +++
 include/linux/shmem_fs.h                      |  23 +
 include/uapi/linux/liveupdate.h               | 216 +++++
 kernel/kexec_core.c                           |   5 +
 kernel/liveupdate/Kconfig                     |  21 +
 kernel/liveupdate/Makefile                    |   7 +
 kernel/liveupdate/luo_core.c                  | 450 +++++++++
 kernel/liveupdate/luo_file.c                  | 889 ++++++++++++++++++
 kernel/liveupdate/luo_internal.h              | 110 +++
 kernel/liveupdate/luo_session.c               | 646 +++++++++++++
 mm/Makefile                                   |   1 +
 mm/internal.h                                 |   6 +
 mm/memfd_luo.c                                | 516 ++++++++++
 mm/shmem.c                                    |  49 +-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/liveupdate/.gitignore |   9 +
 tools/testing/selftests/liveupdate/Makefile   |  34 +
 tools/testing/selftests/liveupdate/config     |  11 +
 .../testing/selftests/liveupdate/do_kexec.sh  |  16 +
 .../testing/selftests/liveupdate/liveupdate.c | 348 +++++++
 .../selftests/liveupdate/luo_kexec_simple.c   |  89 ++
 .../selftests/liveupdate/luo_multi_session.c  | 162 ++++
 .../selftests/liveupdate/luo_test_utils.c     | 266 ++++++
 .../selftests/liveupdate/luo_test_utils.h     |  44 +
 34 files changed, 4407 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/core-api/liveupdate.rst
 create mode 100644 Documentation/mm/memfd_preservation.rst
 create mode 100644 Documentation/userspace-api/liveupdate.rst
 create mode 100644 include/linux/kho/abi/luo.h
 create mode 100644 include/linux/kho/abi/memfd.h
 create mode 100644 include/linux/liveupdate.h
 create mode 100644 include/uapi/linux/liveupdate.h
 create mode 100644 kernel/liveupdate/luo_core.c
 create mode 100644 kernel/liveupdate/luo_file.c
 create mode 100644 kernel/liveupdate/luo_internal.h
 create mode 100644 kernel/liveupdate/luo_session.c
 create mode 100644 mm/memfd_luo.c
 create mode 100644 tools/testing/selftests/liveupdate/.gitignore
 create mode 100644 tools/testing/selftests/liveupdate/Makefile
 create mode 100644 tools/testing/selftests/liveupdate/config
 create mode 100755 tools/testing/selftests/liveupdate/do_kexec.sh
 create mode 100644 tools/testing/selftests/liveupdate/liveupdate.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_kexec_simple.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_multi_session.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_test_utils.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_test_utils.h


base-commit: 2cb7e27ffe3e3e1d8a837026462ebca22cba3b4f
-- 
2.52.0.460.gd25c4c69ec-goog


