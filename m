Return-Path: <linux-fsdevel+bounces-39594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D28EA15F3D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 00:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89182165D7D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 23:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E9A1DE3C2;
	Sat, 18 Jan 2025 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tndpfRzy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791B32913
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jan 2025 23:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737242182; cv=none; b=fOR5dfZ+nF0bq0MqHqDxofk+ZNBe5PhMOxapPN+XNK5IgiYaL3aTRRcwzj6bzhoCf+8I0h9J1CPKCHgfhvqDvwOsTAUC8PgQZr53MGmP3nlYnMWtcwtPnnUyiqGOBcP/Krbj9FD4xADpJsb2FOQhBKfmbZiHliJUIiN6VdkuW7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737242182; c=relaxed/simple;
	bh=xruL1yD4NkISNOXpXEdya3romVKDsx8j5/KSgK9FIng=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bfXZjX3JPs1x5sWjaAL+VJn3tPJ3tI6WrmASUDpTDUJenJRLUhmNwf1ZcH6ygGhPRy7DaXVHqrJgmW4tlRVAJapQ/ZBdWB1UWZJWHdb/Ws+3apka+E+AuaujRZCRKFDg4CeetUJzdXl9p5sMvSXgczKgULdK17aO9tRbTdZqXoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tndpfRzy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so9122913a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jan 2025 15:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737242179; x=1737846979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJqIhoBtzK4fSLnMcduoKUM+HVQGj93jZHw3t2wf5ls=;
        b=tndpfRzyneGbT2bPxFD8OEMb1ZK4VaYubGnhfa77axA9h+OldrLPyOWTEaCqAxYB0M
         vSI1yluRwzoJrR3/U6BBCbbKQkP6oi5BtRdkZwuGr9dXe0AFw8pLUjP3ttiSLQ1sRBnd
         4gBwNuVx0mgvS85oaTf/33W//rrEvRQXJhuulo5d969p7T9wbFmxCQWwJhx7ltSJ/y1x
         lgDFa4AGQ3E1ZO86xOc/as2uCxXSsZf1zfN0G6WuBVGH9tIo2hDgryM+VLP2sMiXKRsY
         P8enWyeli7AiB1aivck3RrS7lq0JE9HUkeM6daR3pWXZLh0GChic2iF0GZb1dahvvxGD
         M/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737242179; x=1737846979;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJqIhoBtzK4fSLnMcduoKUM+HVQGj93jZHw3t2wf5ls=;
        b=iBTC22iYvUZ+PPEaz54kipFYe7LevX6kExJZI5KJgK+72Oof3edgRy5YR/ByuaiaJ4
         18Xz6oog3hQAlJ/iHX2b5bM8hUOMVzsOFV3amopRXqWrbGLXgg7V9a6aqrp6hbqKVZ7Q
         ngNAUX8hgU5TmzpNp04o8HdMZem1VC7cDpiFMX69NSriz+jpaXTb/Bj+iB/GjzQbOCC2
         L4kuRzm2zDRKHj98ZqK2+8BbzdqJZlQe30o97Y3Nzsxvz12dElJyge8KvxmFrNy9QoxH
         iqKplPI8XWUtvojUqejm1YjXwF8gbC/WOnM4bWtIryUJKoDLEwBo+mg0L4JnbhR2PfU0
         etmw==
X-Forwarded-Encrypted: i=1; AJvYcCUgNqG3sX/gC1PLcB5vD/i/L42K7KU9uOy3r6KjTawtrR9sZEvK4zpfD4ZmeRynnXTjQirEyWfOvmFOVKsR@vger.kernel.org
X-Gm-Message-State: AOJu0YyR8jjbGKNamNfbIzRBjcT7bRV4eWXhtUwhrNlKk4RIoMXG6gB6
	AipXCz26kF0CjlCKH47ucbc/VWXKCb69qigFe3fz26piFADVrm5kYlzpvy0JVRj+SgG9DGmtse8
	jh1y23pOI0g==
X-Google-Smtp-Source: AGHT+IEjHjW3pzs+1d3mT0gGbm9y5gARLzKuwZ90+iK1dYQQ3yCrpQoUldmJ1BwM4D4F1akFmX2KGp6Y8vBBCA==
X-Received: from pfbcl4.prod.google.com ([2002:a05:6a00:32c4:b0:727:2d74:d385])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d19:b0:72a:8bb6:2963 with SMTP id d2e1a72fcca58-72dafa44141mr11136425b3a.13.1737242178772;
 Sat, 18 Jan 2025 15:16:18 -0800 (PST)
Date: Sat, 18 Jan 2025 23:15:46 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250118231549.1652825-1-jiaqiyan@google.com>
Subject: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com
Cc: tony.luck@intel.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	jane.chu@oracle.com, akpm@linux-foundation.org, osalvador@suse.de, 
	rientjes@google.com, duenwen@google.com, jthoughton@google.com, 
	jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, 
	sidhartha.kumar@oracle.com, david@redhat.com, dave.hansen@linux.intel.com, 
	muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Background and Motivation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

To recap [1] in short: in Cloud, HugeTLB and huge VM_PFNMAP serves
capacity- and performance-critical guest memory, but the current memory
failure recovery (MFR) behavior for both are not ideal:
* Once a byte of memory in a hugepage is hardware corrupted, kernel
  discards the whole hugepage, not only the corrupted bytes but also the
  healthy portion, from the HugeTLB system, causing a great loss of
  memory to VM. We use 1GB HugeTLB for the vast majority of guest memory
  in GCE.
* After MFR zaps PUD (assuming memory mapping is huge VM_PFNMAP [2]),
  there will be a huge hole in the EPT or stage-2 (S2) page table,
  causing a lot of EPT or S2 violations that need to be fixed up by the
  device driver or core MM, and fragmented EPT or S2 after fixup. There
  will be noticeable VM performance downgrades (see =E2=80=9CMemCycler
  Benchmarking=E2=80=9D).

Therefore keeping or discarding a large chunk of contiguous memory
mapped to userspace (particularly to serve guest memory) due to
uncorrected memory error (UE, recoverable is implied) should be
controlled by userspace, e.g. virtual machine monitor (VMM) in Cloud.

In the MM upstream alignment meeting [3], we were able to align with
folks from the Linux MM upstream community on =E2=80=9CWhy Control Needed=
=E2=80=9D and
=E2=80=9CWhat to Control=E2=80=9D. However, the two proposed approaches for=
 =E2=80=9CHow to
Control=E2=80=9D are both not well accepted, and we think it is worthy to p=
ursue
the memfd-based userspace MFR idea brought up by Jason Gunthorpe.

MemCycler Benchmarking
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

To follow up the question by Dave Hansen, =E2=80=9CIf one motivation for th=
is is
guest performance, then it would be great to have some data to back that
up, even if it is worst-case data=E2=80=9D, we run MemCycler in guest and
compare its performance when there are an extremely large number of
memory errors.

The MemCycler benchmark cycles through memory with multiple threads. On
each iteration, the thread reads the current value, validates it, and
writes a counter value. The benchmark continuously outputs rates
indicating the speed at which it is reading and writing 64-bit integers,
and aggregates the reads and writes of the multiple threads across
multiple iterations into a single rate (unit: 64-bit per microsecond).

MemCycler is running inside a VM with 80 vCPUs and 640 GB guest memory.
The hardware platform hosting the VM is using Intel Emerald Rapids CPUs
(in total 120 physical cores) and 1.5 T DDR5 memory. MemCycler allocates
memory with 2M transparent hugepage in the guest. Our in-house VMM backs
the guest memory with 2M transparent hugepage on the host. The final
aggregate rate after 60 runtime is 17,204.69 and referred to as the
baseline case.

In the experimental case, all the setups are identical to the baseline
case, however 25% of the guest memory is split from THP to 4K pages due
to the memory failure recovery triggered by MADV_HWPOISON. I made some
minor changes in the kernel so that the MADV_HWPOISON-ed pages are
unpoisoned, and afterwards the in-guest MemCycle is still able to read
and write its data. The final aggregate rate is 16,355.11, which is
decreased by 5.06% compared to the baseline case. When 5% of the guest
memory is split after MADV_HWPOISON, the final aggregate rate is
16,999.14, a drop of 1.20% compared to the baseline case.

Design
=3D=3D=3D=3D=3D=3D

Userspace process creates memfd to get a file that lives in RAM, that
has a volatile backing storage, that the backing memory has anonymous
semantics. Userspace then can modify, truncate, memory-map the file and
so on.

Per-memfd MFR Policy associates the userspace MFR policy with a memfd
instance. This approach is promising for the following reasons:
1. Keeping memory with UE mapped to a process has risks if the process
   does not do its duty to prevent itself from repeatedly consuming UER.
   The MFR policy can be associated with a memfd to limit such risk to a
   particular memory space owned by a particular process that opts in
   the policy. This is much preferable than the Global MFR Policy
   proposed in the initial RFC, which provides no granularity
   whatsoever.
2. Like Per-VMA MFR Policy in the initial RFC, poisoning the folio and
   keeping the mapping are not conflicting in Per-memfd MFR Policy;
   Kernel can keep setting the HWPoison flag to the folios affected by
   the UE, while the folio is kept mapping to userspace. This is an
   advantage to the Global MFR Policy, which breaks kernel=E2=80=99s HWPois=
on
   behavior.
3. Although MFR policy allows the userspace process to keep memory UE
   mapped, eventually these HWPoison-ed folios need to be dealt with by
   the kernel (e.g. split into smallest chunk and isolated from
   future allocation). For memfd once all references to it are dropped,
   it is automatically released from userspace, which is a perfect
   timing for the kernel to do its duties to HWPoison-ed folios if any.
   This is also a big advantage to the Global MFR Policy, which breaks
   kernel=E2=80=99s protection to HWPoison-ed folios.
4. Given memfd=E2=80=99s anonymous semantic, we don=E2=80=99t need to worry=
 about that
   different threads can have different and conflicting MFR policies. It
   allows a simpler implementation than the Per-VMA MFR Policy in the
   initial RFC [1].

Userspace can choose the memory backing the created file either be
managed by HugeTLB (MFD_HUGETLB) or SHMEM. To userspace the Per-memfd
MFR Policy is independent of the memory management systems, although the
implementations required in kernel are different because the existing
MFR behavior already varies.

UAPI
=3D=3D=3D=3D

The UAPI to control MFR policy via memfd is through the memfd_create
syscall with a new flag value:

  #define MFD_MF_KEEP_UE_MAPPED	0x0020U
  int memfd_create(const char *name, unsigned int flags);

When MFD_MF_KEEP_UE_MAPPED is set in flags, memory failure (MF) recovery
in the kernel doesn=E2=80=99t hard offline memory due to uncorrected error =
(UE)
until the created memfd is released. IOW, the HWPoison-ed memory remains
accessible via the returned memfd or the memory mapping created with
that memfd.

However, the affected memory will be immediately protected and isolated
from future use by both kernel and userspace once the owning memfd is
gone or the memory is truncated. By default MFD_MF_KEEP_UE_MAPPED is not
set, and kernel hard offlines memory having UEs. Kernel immediately
poisons the folios for both cases.

MFD_MF_KEEP_UE_MAPPED translates to a new flag value introduced to
address_space around which the new code changes in MFR, mm fault
handler, and in-RAM file system are added.

  /* * Bits in mapping->flags. */
  enum mapping_flags {
    ...
    /*
     * Keeps folios belong to the mapping mapped even if uncorrectable
     * memory errors (UE) caused memory failure (MF) within the folio.
     * Only at the end of mapping will its HWPoison-ed folios be dealt
     * with.
     */
    AS_MF_KEEP_UE_MAPPED =3D 9,
    ...
  };

Implementation
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Implementation is relatively straightforward with two major parts.

Part 1: When a AS_MF_KEEP_UE_MAPPED memfd is alive and one of its memory
pages is affected by UE:
* MFR needs to defer operations (e.g. unmapping, splitting, dissolving)
  needed to hard offline the memory page. MFR still holds a refcount for
  every raw HWPoison-ed page. MFR still sends SIGBUS to consuming
  thread, but the si_addr_lsb will be reduced to PAGE_SHIFT.
* If the memory was not faulted in yet, the fault handler also needs to
  unblock the fault to HWPoison-ed folio.

Part2: When a AS_MF_KEEP_UE_MAPPED memfd is about to be released, or
when the userspace process truncates a range of memory pages belonging
to a AS_MF_KEEP_UE_MAPPED memfd:
* When the in-memory file system is evicting the inode corresponding to
  the memfd, it needs to prepare the HWPoison-ed folios that are easily
  identifiable with the PG_HWPOISON flag. This operation is implemented
  by populate_memfd_hwp_folios and is exported to file systems.
* After the file system removes all the folios, there is nothing else
  preventing MFR from dealing with HWPoison-ed folios, so the file
  system forwards them to MFR. This step is implemented by
  offline_memfd_hwp_folios and is exported to file systems.
* MFR has been holding refcount(s) of each HWPoison-ed folio. After
  dropping the refcounts, a HWPoison-ed folio should become free and can
  be disposed of. MFR naturally takes the responsibility for this,
  implemented as filemap_offline_hwpoison_folio. How the folio is
  disposed of depends on the type of the memory management system.
  Taking HugeTLB as an example, a HugeTLB folio is dissolved into a set
  of raw pages. The healthy raw pages can be reclaimed by the buddy
  allocator while the HWPoison-ed raw pages need to be taken off and
  prevented from future allocation, as implemented by
  filemap_offline_hwpoison_folio_hugetlb.

This RFC includes the code patch to demonstrate the implementation for
HugeTLB.

In V2 I can probably offline each folio as they get remove, instead of
doing this in batch. The advantage is we can get rid of
populate_memfd_hwp_folios and the linked list needed to store poisoned
folios. One way is to insert filemap_offline_hwpoison_folio into
somewhere in folio_batch_release, or into per file system's free_folio
handler.

Extensibility: Guest memfd
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Guest memfd is going to be the future API used by a virtual machine
monitor (VMM) to allocate and configure memory for the guest but with
better protections that are needed for confidential VM. The current MFR
in guest memfd works as follows:
1. KVM unmaps all the GFNs that are backed by the HWPoison-ed folio from
   the stage-2 page table and invalidates the range in TLB. This
   protects KVM / VM from causing poison consumption at hardware level.
   On the other hand, if the folio backs a large amount of GFNs, e.g. 1G
   HugeTLB, it is likely that majority of the GFNs are still healthy but
   has been =E2=80=9Cofflined=E2=80=9D together (a big hole in stage-2 and =
guest memory
   region).
2. In react to later fault to any part of the HWPoison-ed folio, guest
   memfd returns KVM_PFN_ERR_HWPOISON, and KVM sends SIGBUS to VMM. This
   is good enough for actual hardware corrupted PFN backed GFNs, but not
   ideal for the healthy PFNs =E2=80=9Cofflined=E2=80=9D together with the =
error PFNs.
   The userspace MFR policy can be useful if VMM wants KVM to 1. Keep
   these GFNs mapped in the stage-2 page table 2. In react to later
   access to the actual hardware corrupted part of the HWPoison-ed
   folio, there is going to be a (repeated) poison consumption event,
   and KVM returns KVM_PFN_ERR_HWPOISON for the actual poisoned PFN.
3. In response to later access to the still healthy part of the
   HWPoison-ed folio, guest is able to fast access the memory as the
   healthy PFNs are still in stage-2 page table.

This behavior is better from the PoV of capacity (if the folio contains
a large number of raw pages) and performance (if both the stage-1 and
stage-2 page table sizes are huge), however, at the cost of the risk of
recurring poison consumptions. The cost can be mitigated by splitting
stage-2 page table wrt to HWPoison-ed PFNs so that stage-2 and guest
memory region only have smaller holes.

The UAPI for userspace MFR control via guest memfd can be through the
KVM_CREATE_GUEST_MEMFD IOCTL. It is easy to apply MFD_MF_KEEP_UE_MAPPED
to kvm_create_guest_memfd:

  static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
  {
    //...
    if (flags & MFD_MF_KEEP_UE_MAPPED)
      mapping_set_mf_keep_ue_mapped(inode->i_mapping);
    //...
  }

Of course full implementation requires more code changes in guest memfd,
e.g. __kvm_gmem_get_pfn, kvm_gmem_error_folio etc, especially for VMs
that are built on both guest memfd and HugeTLB. Feedbacks are welcome
before I put out an implementation.

Extensibility: VFIO Device Memory
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

In Cloud a significant amount of memory can be managed by certain VFIO
drivers, for example the GPU device memory, or EGM memory. As mentioned
before, the unmapping behavior in MFR becomes a concern if the VFIO
device driver supports the device memory mapping via huge VM_PFNMAP.

This RFC [4] proposes a MFR framework for VFIO device managed userspace
memory (i.e. memory regions mapped by remap_pfn_region). The userspace
MFR policy can instruct the device driver to keep all PFN mapped in a
VMA (i.e. don=E2=80=99t unmap_mapping_range).

Of course, the above memfd uAPI (MFD_MF_KEEP_UE_MAPPED + memfd_create)
doesn=E2=80=99t work with VFIO device kernel drivers (as of today I don=E2=
=80=99t think
userspace can create a memfd with the path name to a VFIO device). I
don=E2=80=99t have a satisfying uAPI design, but here is what I considered,=
 VFIO
Device Specific IOCTL:
* IOCTL to the VFIO Device File. The device driver usually expose a
  file-like uAPI to its managed device memory (e.g. PCI MMIO BAR)
  directly with the file to the VFIO device. AS_MF_KEEP_UE_MAPPED can be
  placed in the address_space of the file to the VFIO device. Device
  driver can implement a specific IOCTL to the VFIO device file for
  userspace to set AS_MF_KEEP_UE_MAPPED.
* IOCTL to the Char File. The device driver can create a char device for
  its managed memory regions, then expose the file-like uAPI (open,
  close, mmap, unlocked_ioctl) with the created char device using
  cdev_init. AS_MF_KEEP_UE_MAPPED can be straightforwardly put into the
  address_space of the file to the char device. Device driver can
  implement a specific IOCTL to the char device file for userspace to
  set AS_MF_KEEP_UE_MAPPED.

What is common (and unsatisfactory) above is every device driver needs
to add device-specific IOCTL to support MFD_MF_KEEP_UE_MAPPED. The
timing of accepting the IOCTL also needs to be restricted to be after
file descriptor creation (e.g. VFIO_GROUP_GET_DEVICE_FD) and before the
first mmap request. I am still considering how to integrate
MFD_MF_KEEP_UE_MAPPED to VFIO framework=E2=80=99s uAPI.

Extensibility: THP SHMEM/TMPFS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

The current MFR behavior for THP SHMEM/TMPFS is to split the hugepage
into raw page and only offline the raw HWPoison-ed page. In most cases
THP is 2M and raw page size is 4K, so userspace loses the =E2=80=9Chuge=E2=
=80=9D
property of a 2M huge memory, but the actual data loss is only 4K.

Using populate_memfd_hwp_folios and offline_memfd_hwp_folios, it is not
hard to implement AS_MF_KEEP_UE_MAPPED for THP so that userspace process
retain the huge property of the hugepage when it is affected by memory
errors. However, this benefit is not as attractive as to HugeTLB and it
is not implemented for now.

[1] https://lwn.net/Articles/991513
[2] https://lore.kernel.org/kvm/20240826204353.2228736-1-peterx@redhat.com/
[3] https://docs.google.com/presentation/d/1tWqcuAqeCLhfd47uXXLdu2SzolKu7WY=
vM03vEkbhobc/edit#slide=3Did.g3014a65d24b_0_0
[4] https://lore.kernel.org/linux-mm/20231123003513.24292-2-ankita@nvidia.c=
om/

Jiaqi Yan (3):
  mm: memfd/hugetlb: introduce userspace memory failure recovery policy
  selftests/mm: test userspace MFR for HugeTLB 1G hugepage
  Documentation: add userspace MF recovery policy via memfd

 Documentation/userspace-api/index.rst         |   1 +
 .../userspace-api/mfd_mfr_policy.rst          |  55 ++++
 fs/hugetlbfs/inode.c                          |  16 ++
 include/linux/hugetlb.h                       |   7 +
 include/linux/pagemap.h                       |  43 +++
 include/uapi/linux/memfd.h                    |   1 +
 mm/filemap.c                                  |  78 +++++
 mm/hugetlb.c                                  |  20 +-
 mm/memfd.c                                    |  15 +-
 mm/memory-failure.c                           | 119 +++++++-
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 tools/testing/selftests/mm/hugetlb-mfr.c      | 267 ++++++++++++++++++
 13 files changed, 607 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/userspace-api/mfd_mfr_policy.rst
 create mode 100644 tools/testing/selftests/mm/hugetlb-mfr.c

--=20
2.48.0.rc2.279.g1de40edade-goog


