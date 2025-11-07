Return-Path: <linux-fsdevel+bounces-67476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA5FC41AB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 22:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD474220EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122D32D780C;
	Fri,  7 Nov 2025 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="kk0rOjbk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630802253F2
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549535; cv=none; b=BWdm0ypR2D/jfEntj9Qumpc7y4Zoscr5MfnUY4/SRw4wS50pFc4CnpwO5ol0gPfy1RgHdlXjhdhKpdFlwg6ByC3QPr83EWfBAx4z/Kh1oKt8mHUjvokco89vUmJocUSs6gCanWRiU9Oiy+x1qYYi1xk3OQBOiR/gpfN6tjDlquU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549535; c=relaxed/simple;
	bh=z26cuUUx2lK50Qwl7t7fipY9mcHNhtpzw+Z7j1sGpFQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bW9jwOJJ8/B7p7W4H+uvnEZlkpPYhi7WHyFSBQwTf+QzkHGOQCN4y4Uz6bqjSs76ZNhxL4V/R5Z/f19teLImSAFT9rwf7iYdSEG2nHo1q47OVjMNchSuPlMUGrqvegXf1iQdOW2jU/moIUWMmXlVqzi6Yqd8tmHeq66BKIDQcHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=kk0rOjbk; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63f976ef4bdso1100864d50.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 13:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549532; x=1763154332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j2X8vbQE5FBHQSyrNFjJFLZxDkCyXdmtNSWPzPf1VIY=;
        b=kk0rOjbkybpIXxeJVt52rV2PGPtjpsMFeWtSpYeKdnB6RehZRkVE/QqWK0mKlBDMFP
         IOo/GEV7JxEg8sRAyys4aW+Lq7JDYdVhWM/8Ja1t6lnsL3kplTKMzACDF1TvwHyBsxLl
         0zRWXwYgN0mAiqDTfaXdWF/sMn71wNWSBsDxHLYnHJbKU4fPqwTLeECD4gh2j8vkvPR4
         alUQeClHvoOItXRkxuuD/nuOsToLnZC6vpqs5NA6nRMCwQSZT/gD1sGqkXRYHQl8SQAN
         hwwS0KOsG1ECCf/y/MG+ISYfUM0i4t/ewIfgyN5Xm6Ogh1UB6HzCNgBxmJnjMmTmR9l6
         Wajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549532; x=1763154332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2X8vbQE5FBHQSyrNFjJFLZxDkCyXdmtNSWPzPf1VIY=;
        b=ii7kgG5Y64CDcqSCYmno1Z8P/cd5vW3q/qn13PLOua05bsVgGa4dvWgDlLSsPgQ4e5
         MeRuYcn7xZp/Aa2oWXkLrQ4MZ37WiHTFftWiiAIdhtXEjdijIf7+iUlDhRuK8c2Z7T0G
         TR0wIgFp7hYiLf17ffKvEjuZr9MyceKxr7w1x1jx9zhERIDHPnwW9YpWi+jjzMQ9soQR
         OJui5W7B21vUNs9RLmtmS1vildjI6REMjkorHG8kP0O6jEV3O9eFQtFOPvmHRsC6PJ4Z
         RlaGu8Hk5ejNVtevRpkVeDvMj4gI882RWiq13ifeKWBKewdgcPrajcgDX1V3gaEq6Jnc
         bI1g==
X-Forwarded-Encrypted: i=1; AJvYcCXIbEaers2o0FF8HH3o0oyCb5d+Wgh/+W8Dlzz+rvNhARNU5fDu6b8KzfTWJLXczgYrQiDjBkH8UzT+YGfS@vger.kernel.org
X-Gm-Message-State: AOJu0YzucKb7/NRjvqm7oH5arxzjSt7trR8ra0rHRKCoiz9d2y8AgCEa
	WwwD/V6w0GV3ovtw8Cy9j5lZoKUlFHAjlgH0L1/uDoitPKM8rappOWCeNFNBFlN6rH4=
X-Gm-Gg: ASbGncsS9dKEH5/pRSNEBKJJoHVat0icN0+LYtxvcMBbwaWIxYwSIKvc4GgP6KE1VoH
	q8kIviw/v+RmWu0zRcDMOw1TSwTuwzjVvM/hwMAwjG/7+Vx0lZWWT0hs1ZD6Dm/Hv7n4Hdnhxu+
	0Ny9Q9IHQDYnwayrAQifBtDJW6dHC0/LqygBOY0bWXKVJ4EvVkDZZrgWgWFDktL70gDR5n4yZyv
	yc5iOAF27pm4BxZ/xifvAGOJNQ/BVR08MKdI/pFWCC3tU/oxssgqSpIitYslMrvEghurjSflco0
	1QZWqBb3xFGBicsTvreMlQrvgIvxIqAhKjMqDAE59M8a+HOQby1dnwZR3mjDmhSGtfLJqesn0Ln
	a0XUfXt3Zih0cg6S9/1AZN+oRgCkM/UqBVP9yKeHjkwWo5iYTDHn8ZSEB6aWQNDYi+pMlko6g+A
	G5ARmLdZDssYkSx5m25bICd1KAtWsX91/SfhJfs5wEL7svJ+dVNjjIuPRHwekGGh6rezk34Ldvp
	u8le8ZV1Xp1
X-Google-Smtp-Source: AGHT+IHBoorb0zfo3zhMzO1yWrNtcnFyDIkGNuEmE/z/xxTd6FJYrUZbetqvBXhZSAgqADHjBrKu8A==
X-Received: by 2002:a05:690c:7603:b0:783:697a:5daa with SMTP id 00721157ae682-787d5399f2amr6178507b3.30.1762549532031;
        Fri, 07 Nov 2025 13:05:32 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:05:31 -0800 (PST)
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
	zhangguopeng@kylinos.cn,
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
Subject: [PATCH v5 00/22] Live Update Orchestrator
Date: Fri,  7 Nov 2025 16:02:58 -0500
Message-ID: <20251107210526.257742-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
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

This series applies against linux-next tag: next-20251107, or use
github repo [4].

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
  future this step will also be removed once statelss KHO is merged [6].

- Userspace Interface
  Control is provided via ioctl commands on /dev/liveupdate for creating
  and retrieving sessions, as well as on session file descriptors for
  managing individual files.

- Testing
  The series includes a set of selftests, including userspace API
  validation, kexec-based lifecycle tests for various session and file
  scenarios, and a new in-kernel test module to validate the FLB logic.

Changelog since v4 [7]

The v5 series a significant refinement based on previous feedback
primarily form Jason Gunthorpe focusing on a more robust model for
managing shared dependencies and improving the overall structure.

- Rework KHO for LUO patches from the previous series, were separated
  out and are now linux-next to be merged in the next window [8]
- FLB Mechanism; The most significant change is the removal of the
  generic liveupdate_register_subsystem() API. It has been replaced by
  the File-Lifecycle-Bound mechanism. FLB provides a more robust,
  reference-counted model for managing global kernel state.
- Simplified Global State: The global LUO state machine has been removed
  in favor of a simpler, more robust model where state is managed on a
  per-session and per-file basis, driven directly by userspace actions
  and the final kexec call. This removes the PREPARE/FINISH/CANCEL
  global states.
- Formalized ABI: The ABI passed to the next kernel has been formalized
  with dedicated headers under include/linux/liveupdate/abi/, improving
  clarity, and maintainability.
- New can_finish() callback, that verifies whether all resources within
  a session can finish, or is there still work left to be done.
- memfd Preservation with vmalloc: The memfd handler now utilizes KHO's
  vmalloc preservation mechanism. This is a key improvement, removing
  the previous size limitation tied to contiguous page allocations and
  now allowing arbitrarily large memfd files to be preserved.

[1] https://lore.kernel.org/all/20251018000713.677779-1-vipinsh@google.com/
[2] https://lore.kernel.org/linux-iommu/20250928190624.3735830-1-skhawaja@google.com
[3] https://lore.kernel.org/linux-pci/20250916-luo-pci-v2-0-c494053c3c08@kernel.org
[4] https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v5
[5] https://tinyurl.com/luoddesign
[6] https://lore.kernel.org/all/20251020100306.2709352-1-jasonmiu@google.com
[7] https://lore.kernel.org/all/20250929010321.3462457-1-pasha.tatashin@soleen.com
[8] https://lore.kernel.org/all/20251101142325.1326536-1-pasha.tatashin@soleen.com

Pasha Tatashin (16):
  liveupdate: luo_core: luo_ioctl: Live Update Orchestrator
  liveupdate: luo_core: integrate with KHO
  reboot: call liveupdate_reboot() before kexec
  liveupdate: Kconfig: Make debugfs optional
  liveupdate: kho: when live update add KHO image during kexec load
  liveupdate: luo_session: add sessions support
  liveupdate: luo_ioctl: add user interface
  liveupdate: luo_file: implement file systems callbacks
  liveupdate: luo_session: Add ioctls for file preservation and state
    management
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
 Documentation/mm/memfd_preservation.rst       | 138 +++
 Documentation/userspace-api/index.rst         |   1 +
 .../userspace-api/ioctl/ioctl-number.rst      |   2 +
 Documentation/userspace-api/liveupdate.rst    |  20 +
 MAINTAINERS                                   |  15 +
 include/linux/liveupdate.h                    | 273 ++++++
 include/linux/liveupdate/abi/luo.h            | 233 +++++
 include/linux/liveupdate/abi/memfd.h          |  88 ++
 include/linux/shmem_fs.h                      |  23 +
 include/uapi/linux/liveupdate.h               | 217 +++++
 kernel/liveupdate/Kconfig                     |  28 +-
 kernel/liveupdate/Makefile                    |   9 +
 kernel/liveupdate/kexec_handover.c            |   3 +-
 kernel/liveupdate/luo_core.c                  | 341 +++++++
 kernel/liveupdate/luo_file.c                  | 901 ++++++++++++++++++
 kernel/liveupdate/luo_flb.c                   | 628 ++++++++++++
 kernel/liveupdate/luo_internal.h              | 101 ++
 kernel/liveupdate/luo_ioctl.c                 | 218 +++++
 kernel/liveupdate/luo_session.c               | 580 +++++++++++
 kernel/reboot.c                               |   4 +
 lib/Kconfig.debug                             |  23 +
 lib/tests/Makefile                            |   1 +
 lib/tests/liveupdate.c                        | 130 +++
 mm/Makefile                                   |   1 +
 mm/internal.h                                 |   6 +
 mm/memfd_luo.c                                | 609 ++++++++++++
 mm/mm_init.c                                  |   4 +
 mm/shmem.c                                    |  51 +-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/liveupdate/.gitignore |   3 +
 tools/testing/selftests/liveupdate/Makefile   |  40 +
 tools/testing/selftests/liveupdate/config     |   5 +
 .../testing/selftests/liveupdate/do_kexec.sh  |   6 +
 .../testing/selftests/liveupdate/liveupdate.c | 317 ++++++
 .../selftests/liveupdate/luo_kexec_simple.c   | 114 +++
 .../selftests/liveupdate/luo_multi_session.c  | 190 ++++
 .../selftests/liveupdate/luo_test_utils.c     | 168 ++++
 .../selftests/liveupdate/luo_test_utils.h     |  39 +
 41 files changed, 5583 insertions(+), 21 deletions(-)
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


base-commit: 9c0826a5d9aa4d52206dd89976858457a2a8a7ed
-- 
2.51.2.1041.gc1ab5b90ca-goog


