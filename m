Return-Path: <linux-fsdevel+bounces-57070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 503C6B1E83F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CD7A05501
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 12:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5D6277CB1;
	Fri,  8 Aug 2025 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMRCOSJ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC1D275B17;
	Fri,  8 Aug 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655891; cv=none; b=u0yE5JuwT2LKbzHrIL+aFQdJXRjK1a/ZQEIq54zDrDa7fLDjNpWf9pzKBI83gLkCkFfPWpysZHBKwdSjag/rvquq3W64bCcR1E37sOc5nZa9sH2JXit/qyraHzPbnJaIa7lkUSph07xgatYpXuT0jAgKMfs5WjCg4U+vvRTVLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655891; c=relaxed/simple;
	bh=qRjvtQepeMwWQ1iZeyP+WXdo3DOPw4yY3tm/2Jj3ro8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hhuBIGrQG8Pm5YD/j3z5pjrpQSbKAMOvEiP/5AnP3vd2ZJMMe7pXITpmC3chLzsP1NINH88MqeeCNwjDSU8lVC8expx4lzgBbgXgmPiI4Cuf+bkr0YcL6e/LVtF32j+sTUfi/oASXMRB6jCZO0aLbbZWRqLAAuTsjMLACm+yOic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMRCOSJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01115C4CEED;
	Fri,  8 Aug 2025 12:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754655891;
	bh=qRjvtQepeMwWQ1iZeyP+WXdo3DOPw4yY3tm/2Jj3ro8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CMRCOSJ4OD4BgEV43QFUeLjx//tVMPcvn1zUTdkz9AEdPWvxToF3CTtrJ1JY/j7FQ
	 Wafqp+mkl4F+RrKLdpvFkCtYorEJs9Tt6axGTHlEr587xP5Xo0loGlmK2qV8cF6d9p
	 NmSBZDjZycBiXzMSQy1zA1Ob1jgfjGybkU/W7UHhsItAXGLuyJQCcvBbRVKaPo+3oj
	 HvW4FB4JncGBNWmwmBjkKKNhjw+tydQpk4wQrQ7Sc5vXhwrwqPZpgVhJgUazpVAPKt
	 nCXk1XTmrY1dMOqyD13Z5jOxKdhUOOsLFfOP/zTIiXCQhWc3Q9/8G9+QB5lLT2QKeT
	 MhrbCEVrZ3BPA==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  pratyush@kernel.org,
  jasonmiu@google.com,  graf@amazon.com,  changyuanl@google.com,
  rppt@kernel.org,  dmatlack@google.com,  rientjes@google.com,
  corbet@lwn.net,  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  zhangguopeng@kylinos.cn,  linux@weissschuh.net,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  gregkh@linuxfoundation.org,  tglx@linutronix.de,
  mingo@redhat.com,  bp@alien8.de,  dave.hansen@linux.intel.com,
  x86@kernel.org,  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  jgg@nvidia.com,
  parav@nvidia.com,  leonro@nvidia.com,  witu@nvidia.com, Hugh Dickins
 <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v3 00/30] Live Update Orchestrator
In-Reply-To: <b227482a-31ec-4c92-a856-bd19f72217b7@redhat.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<b227482a-31ec-4c92-a856-bd19f72217b7@redhat.com>
Date: Fri, 08 Aug 2025 14:24:40 +0200
Message-ID: <mafs07bzeatmf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 08 2025, David Hildenbrand wrote:

> On 07.08.25 03:44, Pasha Tatashin wrote:
>> This series introduces the LUO, a kernel subsystem designed to
>> facilitate live kernel updates with minimal downtime,
>> particularly in cloud delplyoments aiming to update without fully
>> disrupting running virtual machines.
>> This series builds upon KHO framework by adding programmatic
>> control over KHO's lifecycle and leveraging KHO for persisting LUO's
>> own metadata across the kexec boundary. The git branch for this series
>> can be found at:
>> https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v3
>> Changelog from v2:
>> - Addressed comments from Mike Rapoport and Jason Gunthorpe
>> - Only one user agent (LiveupdateD) can open /dev/liveupdate
>> - Release all preserved resources if /dev/liveupdate closes
>>    before reboot.
>> - With the above changes, sessions are not needed, and should be
>>    maintained by the user-agent itself, so removed support for
>>    sessions.
>> - Added support for changing per-FD state (i.e. some FDs can be
>>    prepared or finished before the global transition.
>> - All IOCTLs now follow iommufd/fwctl extendable design.
>> - Replaced locks with guards
>> - Added a callback for registered subsystems to be notified
>>    during boot: ops->boot().
>> - Removed args from callbacks, instead use container_of() to
>>    carry context specific data (see luo_selftests.c for example).
>> - removed patches for luolib, they are going to be introduced in
>>    a separate repository.
>> What is Live Update?
>> Live Update is a kexec based reboot process where selected kernel
>> resources (memory, file descriptors, and eventually devices) are kept
>> operational or their state preserved across a kernel transition. For
>> certain resources, DMA and interrupt activity might continue with
>> minimal interruption during the kernel reboot.
>> LUO provides a framework for coordinating live updates. It features:
>> State Machine: Manages the live update process through states:
>> NORMAL, PREPARED, FROZEN, UPDATED.
>> KHO Integration:
>> LUO programmatically drives KHO's finalization and abort sequences.
>> KHO's debugfs interface is now optional configured via
>> CONFIG_KEXEC_HANDOVER_DEBUG.
>> LUO preserves its own metadata via KHO's kho_add_subtree and
>> kho_preserve_phys() mechanisms.
>> Subsystem Participation: A callback API liveupdate_register_subsystem()
>> allows kernel subsystems (e.g., KVM, IOMMU, VFIO, PCI) to register
>> handlers for LUO events (PREPARE, FREEZE, FINISH, CANCEL) and persist a
>> u64 payload via the LUO FDT.
>> File Descriptor Preservation: Infrastructure
>> liveupdate_register_filesystem, luo_register_file, luo_retrieve_file to
>> allow specific types of file descriptors (e.g., memfd, vfio) to be
>> preserved and restored.
>> Handlers for specific file types can be registered to manage their
>> preservation and restoration, storing a u64 payload in the LUO FDT.
>> User-space Interface:
>> ioctl (/dev/liveupdate): The primary control interface for
>> triggering LUO state transitions (prepare, freeze, finish, cancel)
>> and managing the preservation/restoration of file descriptors.
>> Access requires CAP_SYS_ADMIN.
>> sysfs (/sys/kernel/liveupdate/state): A read-only interface for
>> monitoring the current LUO state. This allows userspace services to
>> track progress and coordinate actions.
>> Selftests: Includes kernel-side hooks and userspace selftests to
>> verify core LUO functionality, particularly subsystem registration and
>> basic state transitions.
>> LUO State Machine and Events:
>> NORMAL:   Default operational state.
>> PREPARED: Initial preparation complete after LIVEUPDATE_PREPARE
>>            event. Subsystems have saved initial state.
>> FROZEN:   Final "blackout window" state after LIVEUPDATE_FREEZE
>>            event, just before kexec. Workloads must be suspended.
>> UPDATED:  Next kernel has booted via live update. Awaiting restoration
>>            and LIVEUPDATE_FINISH.
>> Events:
>> LIVEUPDATE_PREPARE: Prepare for reboot, serialize state.
>> LIVEUPDATE_FREEZE:  Final opportunity to save state before kexec.
>> LIVEUPDATE_FINISH:  Post-reboot cleanup in the next kernel.
>> LIVEUPDATE_CANCEL:  Abort prepare or freeze, revert changes.
>> v2:
>> https://lore.kernel.org/all/20250723144649.1696299-1-pasha.tatashin@soleen.com
>> v1: https://lore.kernel.org/all/20250625231838.1897085-1-pasha.tatashin@soleen.com
>> RFC v2: https://lore.kernel.org/all/20250515182322.117840-1-pasha.tatashin@soleen.com
>> RFC v1: https://lore.kernel.org/all/20250320024011.2995837-1-pasha.tatashin@soleen.com
>> Changyuan Lyu (1):
>>    kho: add interfaces to unpreserve folios and physical memory ranges
>> Mike Rapoport (Microsoft) (1):
>>    kho: drop notifiers
>> Pasha Tatashin (23):
>>    kho: init new_physxa->phys_bits to fix lockdep
>>    kho: mm: Don't allow deferred struct page with KHO
>>    kho: warn if KHO is disabled due to an error
>>    kho: allow to drive kho from within kernel
>>    kho: make debugfs interface optional
>>    kho: don't unpreserve memory during abort
>>    liveupdate: kho: move to kernel/liveupdate
>>    liveupdate: luo_core: luo_ioctl: Live Update Orchestrator
>>    liveupdate: luo_core: integrate with KHO
>>    liveupdate: luo_subsystems: add subsystem registration
>>    liveupdate: luo_subsystems: implement subsystem callbacks
>>    liveupdate: luo_files: add infrastructure for FDs
>>    liveupdate: luo_files: implement file systems callbacks
>>    liveupdate: luo_ioctl: add userpsace interface
>>    liveupdate: luo_files: luo_ioctl: Unregister all FDs on device close
>>    liveupdate: luo_files: luo_ioctl: Add ioctls for per-file state
>>      management
>>    liveupdate: luo_sysfs: add sysfs state monitoring
>>    reboot: call liveupdate_reboot() before kexec
>>    kho: move kho debugfs directory to liveupdate
>>    liveupdate: add selftests for subsystems un/registration
>>    selftests/liveupdate: add subsystem/state tests
>>    docs: add luo documentation
>>    MAINTAINERS: add liveupdate entry
>> Pratyush Yadav (5):
>>    mm: shmem: use SHMEM_F_* flags instead of VM_* flags
>>    mm: shmem: allow freezing inode mapping
>>    mm: shmem: export some functions to internal.h
>>    luo: allow preserving memfd
>>    docs: add documentation for memfd preservation via LUO
>
> It's not clear from the description why these mm shmem changes are buried in
> this patch set. It's not even described above in the patch description.

Patches 26-30 describe the shmem changes in more detail, but you're
right, it should be mentioned in the cover as well.

The idea is, LUO is used to preserve kernel resources across kexec. One
of the most fundamental resources the kernel has is memory. Since LUO
does preservation based on file descriptors, memfd is the way to attach
a FD to memory. So we went with memfd as the first user of LUO. memfd
can be backed by shmem or hugetlb, but currently only shmem is
supported. We do plan to support hugetlb as well in the future.

The idea is to keep the serialization/live update logic out of the way
of the main subsystem. So we decided to keep the logic out in a separate
file.

>
> I suggest sending that part out separately, so Hugh actually spots this.
> (is he even CC'ed?)

Hmm, none of the shmem maintainers are included. I wonder why. The
patches do touch shmem.c and shmem_fs.h so the MAINTAINERS entry for
"TMPFS (SHMEM FILESYSTEM)" should have been hit. My guess is that the
shmem changes weren't part of the original RFC so perhaps Pasha forgot
to update the To/Cc list since then?

Either way, I've added Hugh and Baolin to this email. Hugh, Baolin, you
can find the shmem related patches at [0][1][2][3][4].

Pasha, can you please add them for later versions as well?

And now that I think about it, I suppose patch 29 should also add
memfd_luo.c under the SHMEM MAINTAINERS entry.

[0] https://lore.kernel.org/lkml/20250807014442.3829950-27-pasha.tatashin@soleen.com/
[1] https://lore.kernel.org/lkml/20250807014442.3829950-28-pasha.tatashin@soleen.com/
[2] https://lore.kernel.org/lkml/20250807014442.3829950-29-pasha.tatashin@soleen.com/
[3] https://lore.kernel.org/lkml/20250807014442.3829950-30-pasha.tatashin@soleen.com/
[4] https://lore.kernel.org/lkml/20250807014442.3829950-31-pasha.tatashin@soleen.com/

-- 
Regards,
Pratyush Yadav

