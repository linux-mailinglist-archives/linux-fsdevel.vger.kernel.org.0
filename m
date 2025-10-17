Return-Path: <linux-fsdevel+bounces-64513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819ABBEB766
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 22:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB6B6E7CA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 20:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910F3335070;
	Fri, 17 Oct 2025 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3iktQPFY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3B833291C
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731951; cv=none; b=fPJWbKH+3oa0NupRredyYT0BmzpWgXwEd+VODpDpLMqziphEIHldOcqefVdv1gzUmFseqon855Ybt0ZuyyIayM8MyUFCf+umr/7NMrhCc3udDq0IBNXUaapaObuXUQy8HylcpXRTCKhI3klqTIb9VrE6zUyH2vM5wNgdVIcssks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731951; c=relaxed/simple;
	bh=siWpafnUKoLg4oB+hPXsnce7fcIsRgiCopc1fvAbvC8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WmdoaPtBFlwVYnxHjxikIgDmZm+iZzzp2kb7YKZL+TldT7sF89/y0nO5FTmgmRHQ5OfqtzwtfLIwPBbcELH1szGVg1s7T2X6KAu39DVpTrqbs9PPFs+aNlRc32hrPIBX6UBP+lNvEilU9Z5MF+ZZe+hFWe2Gtjrplx4agBPJ+l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3iktQPFY; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33be01bcda8so1168342a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 13:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731949; x=1761336749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MvNEuSw58UwdjUzqQehycSdzJ+PYeq3LWgjQi3Vxd7A=;
        b=3iktQPFYRvpQB02J7IsxLgzetTDdC4IfsafK0tnpmojWN4z09ctQkKghFpdWLCFEZm
         jwC8QIhkztQq9jTLx1dkDq+IQT4V0op7FiD6qw7vCwD/7C1WKcz5IIypiEtddQMUyrry
         XT9Ic+sHfM+RT/2/qh6eEjRlTC6/XsPgHFaRh4cdJZZrnSPFloueN6Cg8chErztytpg9
         fKHZ+ZQSMsK5w1P5t9FYGo2VsfQJLynOwKlZz3tDsA8qESr56A0ipqPPoT8Tq3/Kwzs3
         r5tfgMICeBBfB+/gqKoV8VlM7hm6SU/RxqBsL9a+JCrDF0Hf1k+/q//Rzli2xEn2jrco
         pklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731949; x=1761336749;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvNEuSw58UwdjUzqQehycSdzJ+PYeq3LWgjQi3Vxd7A=;
        b=mrDOUqAQZ6QfAeqL9QrZrI3lrvsghc9iHRg14U7jCReLDwWjerRtmI29yh8AsAwT66
         HnmxGdoKvxpeOD76g+NQiNGtQJKTSvtj7GdSD9wYx7j1HBut1GpeFJygBMTajtpvQTS/
         9EJrlKvG09wkNDvqmTYxeqjNRGt318G4Meb0/nkQXUvmoobTjKul6AGXsqvOhQUt7bSG
         jJz4XqJwowl4tSVhOdbJNKoXmOmApEU6I5D+SzhyygZ+F0fy6USfKXMiTIFO2FmtvR+Z
         +9VEm7LBkjosU4OC8PA36DZzb1jiD4pwp1NbsgEC5MU3VWM3svEJrUs3M3zBUfhXALfA
         /S0g==
X-Forwarded-Encrypted: i=1; AJvYcCW399JDljavVIVHbA4BruU6QU1rWu9zZr00eQOKqkEXQ8BXKQ4v4LQjWmo4gzkGE2DRdgtQmbgOHih2hDOj@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq4vYv6vpBebPZea8PjreT4Fg5tM8b4sjduZOk+39yDqP2rQc7
	M3B4RVy0+bB2v8ZnCAOP005VqKwJZAeFNDSEvxwdlcmjU9Y/F1XniwJPdMWbPMFlYIYA6KXzBjn
	rYB6GvEst658ZYrk0twWzio+yIA==
X-Google-Smtp-Source: AGHT+IGm0uDnlmmvVqLxeQbS/GkNVcVJ1vJxluasBXbGw+YdYIXcsi2a/48HhtEUh6v1e/OBtWieEkqS8C8YBg1I5A==
X-Received: from pjbpm17.prod.google.com ([2002:a17:90b:3c51:b0:33b:b692:47b0])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c4e:b0:32e:6019:5d19 with SMTP id 98e67ed59e1d1-33bcf921526mr5690604a91.34.1760731948481;
 Fri, 17 Oct 2025 13:12:28 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:11:41 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <cover.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 00/37] guest_memfd: In-place conversion support
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

IIUC this is the first independent patch series for guest_memfd's in-place
conversion series! Happy to finally bring this out on its own.

Previous versions of this feature, part of other series, are available at
[1][2][3].

Many prior discussions have led up to these main features of this series, and
these are the main points I'd like feedback on.

1. Having private/shared status stored in a maple tree (Thanks Michael for your
   support of using maple trees over xarrays for performance! [4]).
2. Having a new guest_memfd ioctl (not a vm ioctl) that performs conversions.
3. Using ioctls/structs/input attribute similar to the existing vm ioctl
   KVM_SET_MEMORY_ATTRIBUTES to perform conversions.
4. Storing requested attributes directly in the maple tree.
5. Using a KVM module-wide param to toggle between setting memory attributes via
   vm and guest_memfd ioctls (making them mututally exclusive - a single loaded
   KVM module can only do one of the two.)
6. Skipping LRU in guest_memfd folios - make guest_memfd folios not participate
   in LRU to avoid LRU refcounts from interfering with conversions.

This series is based on kvm/next, followed by

+ v12 of NUMA mempolicy support patches [5]
+ 3 cleanup patches from Sean [6][7][8]

Everything is stitched together here for your convenience

https://github.com/googleprodkernel/linux-cc/commits/guest_memfd-inplace-conversion-v1

Thank you all for helping with this series!

If I missed out your comment from a previous series, it's not intentional!
Please do raise it again.

TODOs:

+ There might be an issue with memory failure handling because when guest_memfd
  folios stop participating in LRU. From a preliminary analysis,
  HWPoisonHandlable() is only true if PageLRU() is true. This needs further
  investigation.

[1] https://lore.kernel.org/all/bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com/
[2] https://lore.kernel.org/all/20250117163001.2326672-6-tabba@google.com/
[3] https://lore.kernel.org/all/b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com/
[4] https://lore.kernel.org/all/20250529054227.hh2f4jmyqf6igd3i@amd.com/
[5] https://lore.kernel.org/all/20251007221420.344669-1-seanjc@google.com/T/
[6] https://lore.kernel.org/all/20250924174255.2141847-1-seanjc@google.com/
[7] https://lore.kernel.org/all/20251007224515.374516-1-seanjc@google.com/
[8] https://lore.kernel.org/all/20251007223625.369939-1-seanjc@google.com/

Ackerley Tng (19):
  KVM: guest_memfd: Update kvm_gmem_populate() to use gmem attributes
  KVM: Introduce KVM_SET_MEMORY_ATTRIBUTES2
  KVM: guest_memfd: Don't set FGP_ACCESSED when getting folios
  KVM: guest_memfd: Skip LRU for guest_memfd folios
  KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES
  KVM: selftests: Update framework to use KVM_SET_MEMORY_ATTRIBUTES2
  KVM: selftests: guest_memfd: Test basic single-page conversion flow
  KVM: selftests: guest_memfd: Test conversion flow when INIT_SHARED
  KVM: selftests: guest_memfd: Test indexing in guest_memfd
  KVM: selftests: guest_memfd: Test conversion before allocation
  KVM: selftests: guest_memfd: Convert with allocated folios in
    different layouts
  KVM: selftests: guest_memfd: Test precision of conversion
  KVM: selftests: guest_memfd: Test that truncation does not change
    shared/private status
  KVM: selftests: guest_memfd: Test conversion with elevated page
    refcount
  KVM: selftests: Reset shared memory after hole-punching
  KVM: selftests: Provide function to look up guest_memfd details from
    gpa
  KVM: selftests: Make TEST_EXPECT_SIGBUS thread-safe
  KVM: selftests: Update private_mem_conversions_test to mmap()
    guest_memfd
  KVM: selftests: Add script to exercise private_mem_conversions_test

Sean Christopherson (18):
  KVM: guest_memfd: Introduce per-gmem attributes, use to guard user
    mappings
  KVM: Rename KVM_GENERIC_MEMORY_ATTRIBUTES to KVM_VM_MEMORY_ATTRIBUTES
  KVM: Enumerate support for PRIVATE memory iff kvm_arch_has_private_mem
    is defined
  KVM: Stub in ability to disable per-VM memory attribute tracking
  KVM: guest_memfd: Wire up kvm_get_memory_attributes() to per-gmem
    attributes
  KVM: guest_memfd: Enable INIT_SHARED on guest_memfd for x86 Coco VMs
  KVM: Move KVM_VM_MEMORY_ATTRIBUTES config definition to x86
  KVM: Let userspace disable per-VM mem attributes, enable per-gmem
    attributes
  KVM: selftests: Create gmem fd before "regular" fd when adding memslot
  KVM: selftests: Rename guest_memfd{,_offset} to gmem_{fd,offset}
  KVM: selftests: Add support for mmap() on guest_memfd in core library
  KVM: selftests: Add helpers for calling ioctls on guest_memfd
  KVM: selftests: guest_memfd: Test that shared/private status is
    consistent across processes
  KVM: selftests: Add selftests global for guest memory attributes
    capability
  KVM: selftests: Provide common function to set memory attributes
  KVM: selftests: Check fd/flags provided to mmap() when setting up
    memslot
  KVM: selftests: Update pre-fault test to work with per-guest_memfd
    attributes
  KVM: selftests: Update private memory exits test work with per-gmem
    attributes

 Documentation/virt/kvm/api.rst                |  72 ++-
 arch/x86/include/asm/kvm_host.h               |   2 +-
 arch/x86/kvm/Kconfig                          |  15 +-
 arch/x86/kvm/mmu/mmu.c                        |   4 +-
 arch/x86/kvm/x86.c                            |  13 +-
 include/linux/kvm_host.h                      |  44 +-
 include/trace/events/kvm.h                    |   4 +-
 include/uapi/linux/kvm.h                      |  17 +
 mm/filemap.c                                  |   1 +
 mm/memcontrol.c                               |   2 +
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/guest_memfd_conversions_test.c        | 498 ++++++++++++++++++
 .../testing/selftests/kvm/include/kvm_util.h  | 127 ++++-
 .../testing/selftests/kvm/include/test_util.h |  29 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 128 +++--
 tools/testing/selftests/kvm/lib/test_util.c   |   7 -
 .../selftests/kvm/pre_fault_memory_test.c     |   2 +-
 .../kvm/x86/private_mem_conversions_test.c    |  55 +-
 .../kvm/x86/private_mem_conversions_test.py   | 159 ++++++
 .../kvm/x86/private_mem_kvm_exits_test.c      |  36 +-
 virt/kvm/Kconfig                              |   4 +-
 virt/kvm/guest_memfd.c                        | 414 +++++++++++++--
 virt/kvm/kvm_main.c                           | 104 +++-
 24 files changed, 1554 insertions(+), 185 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_conversions_test.c
 create mode 100755 tools/testing/selftests/kvm/x86/private_mem_conversions_test.py

--
2.51.0.858.gf9c4a03a3a-goog

