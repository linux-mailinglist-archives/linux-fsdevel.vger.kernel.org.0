Return-Path: <linux-fsdevel+bounces-68572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32947C60CC9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 00:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC3444E2917
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 23:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5555F26CE22;
	Sat, 15 Nov 2025 23:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="It+rt+WO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA7E262FCB
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 23:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249658; cv=none; b=HWiNZ3JfsAB+Q33eg1t9bv242mUqD7AJgd8vhXJsV/m83AC8WTB16XinYNIDeAYDnoFXZmOTgiG2/PNGRnQX40RwpLoQwrJ7i5Bn+2sisOrDcEl/DDNHjFxt7ai17W1nXRkcecyNqP4VVZD2MwJrh06JXRBlENN0FnNh6PnA9DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249658; c=relaxed/simple;
	bh=KC4peQg3ZgK5xdZoWnqcywww4iaBRhdSHDWeNU9db10=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rNo33b9Leax9nBxnnURsTvs/yGhwGNmM5UXUBrzudzyPII/VKtZEeD8KINVunAItlJod5aNz9K4pF3kXPmDwQjQwX+zNZV7p95wYkTII/oRFoDNnghst9GbG0FYGebxZOREKeT3tm1RXpbzHqbM9TRTfTdRJNpFZ2KfV7AZt1uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=It+rt+WO; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-787da30c53dso28687337b3.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 15:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763249655; x=1763854455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ee7lz4Om+GPES8DwWVPvUGgIK1alarn+M6wiUgt8ct8=;
        b=It+rt+WOG+XhMPXITo2trVWlnoRA4e+7qLkEUxGuHyk3SPliCy9Ep1hP8QyuiFNqW1
         7WvH+GScKMIpiRo2SV7k1HgUCIDqrQEypz8OJfK0rLhq057g9XjE2OuhwmHywCgcYup0
         cv5lslDGxuDoCFXqlLYLxvU2uVEftcR+t2zxdH/srtYFD6kMpo1It4FW+9+MwR4DjzqO
         zmB9ckZvsH6yl/jHqN9RIkv/0Jxar3JI1QjVzdZqJvcMmdHH7mal29FVEgFoOBMHNN9f
         NX7NM22aVYLpJqnPfZtSLWtl6tpHzJx2T2DmPJ/ZsXMKsNHNiZUgR71U12GVa8WBdep7
         O/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249655; x=1763854455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ee7lz4Om+GPES8DwWVPvUGgIK1alarn+M6wiUgt8ct8=;
        b=n0CgQVuz6aefjo/+qkrzoU9SPnqKWah9xbVqicWirZFaUAQR9q4NRGu2yrhjAOLgWh
         oE3f0h4Qdh3j9DTqgpLW2MF9aYi9w3OKki5xQmC+NFKQ39hLCsJhJ2Viwz9O/HxFBtYd
         NW+oQkq+sA0FIu7V0OxjGGUzNoZfGDXJrC3zpzsEE+/EioRVTxIQpwA7tWAWhSBlG4sy
         kku+GBioWQI32+w+hwY5iWNlmXQH2dtyB0JFFybbkIrbGzdfyXnh1pzmbDUeTi3UEqt5
         WdSBUt0Zzh8UJfTTC+0atX8gLV/eskYetKIu7m30IU6/PXgv4oTxfb2ha2qDblOppGgg
         U5sw==
X-Forwarded-Encrypted: i=1; AJvYcCXSwDtBMdiSMhu5Z8qehAb/dkxnVrlZA45taJi5OAj5OcjJe14w9dnb4KjmbygpcAmxXPm8P2SaTEhbaSWZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyUo8mI1iUsIWLPjeW0ofloaLybEVdWcIbiDkcyL9EKwpEWfwl3
	4pq7tIHhpYglJ4YlszOpPo+nRYwQOdybBBz8cPXJFYKIik8ergb2U17qdhPvKx51Mmw=
X-Gm-Gg: ASbGncv7qUD3V5m5ejxFTxLevWlCEv2UWiOHnL4RrfOzk+AdiPY3FL060C2b6xJqUFg
	F9kpDLVtr1D3lvTp6YW1b+rwFzjEidTcR1oAaYUXnbDTpBUJSo7P6WNNaiVBDpgGRrXb+x2ad2b
	cVqRAO59sae2TrQ9rJ/hgFbb0A8xX1SmdxDk+XIH5ej76JE/hoxQIdM4HLwV/XpGC+8RUiqX7j2
	Pj8Tbu6xQQThrOU5JZHRBZ/zxgJAL76RMHdW8rxoe40DUMv1gngDHSjcUhF+IWrXt9sAENNFbh0
	6X3tpf0qaleHfVLDosAMND4mi/SUO1Kp4ka5bStLr/DMltqZK6Fswwz4amrOvvuofJ7iQYkzGVa
	gXYZY77zk53vSK4/68olcEp9XyncaGtuJLn8ljEcdV1S+wC75JKrt2j3g64yjeWVKU7eTsc5m1i
	dgGvgwDi9Lf9gij7oYCI3mxOGXq1fiJhs/7vmgvKvv6SfPZ2n5dfYzwcuJqPc1HVt/SIS+g0Xao
	bggyiP6KBiJg1bVlQ==
X-Google-Smtp-Source: AGHT+IHY/9H7Rzp2eriASzkL5MJ3Zatp1dgl1eRotDeTufMXyR7gZWjPaOKAzBcpPxEOBX631v43uw==
X-Received: by 2002:a05:690c:b98:b0:787:f72d:2a57 with SMTP id 00721157ae682-78929e23b6cmr69035687b3.15.1763249654638;
        Sat, 15 Nov 2025 15:34:14 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882218774esm28462007b3.57.2025.11.15.15.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:34:14 -0800 (PST)
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
Subject: [PATCH v6 00/20] Live Update Orchestrator
Date: Sat, 15 Nov 2025 18:33:46 -0500
Message-ID: <20251115233409.768044-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Changelog since v5 [7]

- Moved internal luo_alloc/free_* memory helpers to generic
  kho_alloc/free_* APIs, and submitted as a separate KHO series [8].

- Moved the liveupdate_reboot() invocation from kernel/reboot.c to
  kernel_kexec() in kernel/kexec_core.c.

- Moved generic KHO enabling patches (debugfs, kimage logic) out of this
  series and into the base KHO series.

- Feedback: Addressed review comments from Mike Rapoport and Pratyush
  Yadav.

[1] https://lore.kernel.org/all/20251018000713.677779-1-vipinsh@google.com/
[2] https://lore.kernel.org/linux-iommu/20250928190624.3735830-1-skhawaja@google.com
[3] https://lore.kernel.org/linux-pci/20250916-luo-pci-v2-0-c494053c3c08@kernel.org
[4] https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v6
[5] https://tinyurl.com/luoddesign
[6] https://lore.kernel.org/all/20251020100306.2709352-1-jasonmiu@google.com
[7] https://lore.kernel.org/all/20251107210526.257742-1-pasha.tatashin@soleen.com
[8] https://lore.kernel.org/all/20251114190002.3311679-1-pasha.tatashin@soleen.com

Pasha Tatashin (14):
  liveupdate: luo_core: luo_ioctl: Live Update Orchestrator
  liveupdate: luo_core: integrate with KHO
  kexec: call liveupdate_reboot() before kexec
  liveupdate: luo_session: add sessions support
  liveupdate: luo_ioctl: add user interface
  liveupdate: luo_file: implement file systems callbacks
  liveupdate: luo_session: Add ioctls for file preservation
  liveupdate: luo_flb: Introduce File-Lifecycle-Bound global state
  docs: add luo documentation
  MAINTAINERS: add liveupdate entry
  selftests/liveupdate: Add userspace API selftests
  selftests/liveupdate: Add kexec-based selftest for session lifecycle
  selftests/liveupdate: Add kexec test for multiple and empty sessions
  tests/liveupdate: Add in-kernel liveupdate test

Pratyush Yadav (6):
  mm: shmem: use SHMEM_F_* flags instead of VM_* flags
  mm: shmem: allow freezing inode mapping
  mm: shmem: export some functions to internal.h
  liveupdate: luo_file: add private argument to store runtime state
  mm: memfd_luo: allow preserving memfd
  docs: add documentation for memfd preservation via LUO

 Documentation/core-api/index.rst              |   1 +
 Documentation/core-api/liveupdate.rst         |  71 ++
 Documentation/mm/index.rst                    |   1 +
 Documentation/mm/memfd_preservation.rst       |  23 +
 Documentation/userspace-api/index.rst         |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 Documentation/userspace-api/liveupdate.rst    |  20 +
 MAINTAINERS                                   |  15 +
 include/linux/liveupdate.h                    | 265 +++++
 include/linux/liveupdate/abi/luo.h            | 238 +++++
 include/linux/liveupdate/abi/memfd.h          |  88 ++
 include/linux/shmem_fs.h                      |  23 +
 include/uapi/linux/liveupdate.h               | 216 +++++
 kernel/kexec_core.c                           |   5 +
 kernel/liveupdate/Kconfig                     |  27 +
 kernel/liveupdate/Makefile                    |   9 +
 kernel/liveupdate/luo_core.c                  | 252 +++++
 kernel/liveupdate/luo_file.c                  | 906 ++++++++++++++++++
 kernel/liveupdate/luo_flb.c                   | 658 +++++++++++++
 kernel/liveupdate/luo_internal.h              |  95 ++
 kernel/liveupdate/luo_ioctl.c                 | 223 +++++
 kernel/liveupdate/luo_session.c               | 600 ++++++++++++
 lib/Kconfig.debug                             |  23 +
 lib/tests/Makefile                            |   1 +
 lib/tests/liveupdate.c                        | 143 +++
 mm/Makefile                                   |   1 +
 mm/internal.h                                 |   6 +
 mm/memfd_luo.c                                | 671 +++++++++++++
 mm/shmem.c                                    |  50 +-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/liveupdate/.gitignore |   3 +
 tools/testing/selftests/liveupdate/Makefile   |  40 +
 tools/testing/selftests/liveupdate/config     |   5 +
 .../testing/selftests/liveupdate/do_kexec.sh  |  16 +
 .../testing/selftests/liveupdate/liveupdate.c | 348 +++++++
 .../selftests/liveupdate/luo_kexec_simple.c   | 114 +++
 .../selftests/liveupdate/luo_multi_session.c  | 190 ++++
 .../selftests/liveupdate/luo_test_utils.c     | 168 ++++
 .../selftests/liveupdate/luo_test_utils.h     |  39 +
 39 files changed, 5539 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/core-api/liveupdate.rst
 create mode 100644 Documentation/mm/memfd_preservation.rst
 create mode 100644 Documentation/userspace-api/liveupdate.rst
 create mode 100644 include/linux/liveupdate.h
 create mode 100644 include/linux/liveupdate/abi/luo.h
 create mode 100644 include/linux/liveupdate/abi/memfd.h
 create mode 100644 include/uapi/linux/liveupdate.h
 create mode 100644 kernel/liveupdate/luo_core.c
 create mode 100644 kernel/liveupdate/luo_file.c
 create mode 100644 kernel/liveupdate/luo_flb.c
 create mode 100644 kernel/liveupdate/luo_internal.h
 create mode 100644 kernel/liveupdate/luo_ioctl.c
 create mode 100644 kernel/liveupdate/luo_session.c
 create mode 100644 lib/tests/liveupdate.c
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

-- 
2.52.0.rc1.455.g30608eb744-goog


