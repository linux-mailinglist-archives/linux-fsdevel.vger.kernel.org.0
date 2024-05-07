Return-Path: <linux-fsdevel+bounces-18953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC288BEEFB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 23:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A601F2577B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 21:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE48114B97E;
	Tue,  7 May 2024 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LzJy02zA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2078269
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715118259; cv=none; b=alKVv9JbggkPo6l0KYl6KV72RE97pYAZM8g+d2ABBzAoU3YuvqGEbbj/ydD0wIT7IScn8hkppxfFmvgoMrivEt4wJh7L5jS5U8B6YKl9iD038lhEOjq+GXqRkR0+pyCcQ4egel7AHNzvfvVIU9gICnrdAtRe/xOBJjttEeHGt1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715118259; c=relaxed/simple;
	bh=/hZXDGTVBq72ITacQNgH9USqBScMcZl2RHFGP0aGwTY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aBtVk5zwdRPJsZGo3ULz5Cl0D2Dhan6evFoAKYmKzmD2S4aCddHKD5RGhWhP2ZP52qRKJZfv7mJAnS4oqym2NfcyI7inYFD4uT1MaXpfPJt6D0WPGXIXc5AtLNtjL4Pml+z+CSyadi1ZtlZNWGOv8jJARQ+yGuTLqcBzF0bjMbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LzJy02zA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d8bff2b792so3686716a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2024 14:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715118256; x=1715723056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EqE8unr5Y0tDCis4xdjJK0CstdIHAP3qZAtz/KAFViU=;
        b=LzJy02zA5px32yuO91iezTCEbpba9w1y+6Mi4eTUmt0Vf3M0HK5X+KKPaN7Sc1SFYC
         OTZQX0NqdjS0rMFXcYvuaI+8E5SmgyBdD4QfBltpDVuxsTM9dgjmINEmYR+y4FKIK9s0
         bdkqZZ9xzk65MtPstqYrhCHvxnal783YOhlkO4dlGkA0JCf7Up/WBvOniONpHKez3L3F
         ugWuO/QzqQ3MYCo5CBo6F7ooDiVkfu+iG+fbv2gKWyqLv3DQnRiIKTWnECT2BmrHuScf
         awPramyxj5gCX8BlJ0H51ddcu9QsNofU8h7ozZ8pDNIsCYCQhU8Mg2DFd9fKqeNGuI8H
         qDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715118256; x=1715723056;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqE8unr5Y0tDCis4xdjJK0CstdIHAP3qZAtz/KAFViU=;
        b=efwAuJMDmo3xd4Z4fLAej7WWBtP+aUEAP98xFfc681FfW0lB7ybkQpgsciZAhfxOdn
         9t86o55vdZm8wcYM3q/YwvakY519AyKq/p14LGYjoWM+wa2SBz1FXb4xrhCn9wPi19hF
         HmmY15y+uFbysT2n2c01c4EMAStIansiyDMMI7p5V2Bw7jJexyMGTNbFF2TdsY7p7Ht0
         1YVYzplhpSvpyn5Y2PbyTdiMzDF4tCpQntz1yEBAyg7ugIF9kRspOSa2nwwvecyVzDCU
         KIxE0kN/TP1avLrIgRQi2p+kDpS4kBBnPBxhdJ4OJ2x7nUNi9MEbjZTP731uwGB3Z525
         xkDg==
X-Forwarded-Encrypted: i=1; AJvYcCUS5juRvgyHGHq9r/iOy1CVR09BhtZd2Y5sbhI0wyO7Axi85u4lnvw4AddqujMoRmQUXcm6pYsTNJreCrvMQgt3q4hLZcrW0caJQZhs5g==
X-Gm-Message-State: AOJu0YzERr39u/aZMdrLrUY9+7gRsyUb21Dp7pg4E8G1bKTGMcJw6ljF
	tsazQUfYqr+0iYgPS2snbm9RoGaNSyETqKUxxdnLjqO4k9JtkoUOYjMJ31++4vRplEPOymOKeBh
	dlg==
X-Google-Smtp-Source: AGHT+IFisE4XLh7ZU+8mMwucPbxKUp9BzA2d0YyKj/xpS/Zt0NyK17LSV96dCgkbVAdnpiktJzrlwRA0ARY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a65:6a93:0:b0:5dc:14c9:64aa with SMTP id
 41be03b00d2f7-62f1f684fd2mr2704a12.3.1715118255449; Tue, 07 May 2024 14:44:15
 -0700 (PDT)
Date: Tue,  7 May 2024 21:38:25 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507214254.2787305-1-edliaw@google.com>
Subject: [PATCH v2 0/5] Define _GNU_SOURCE for sources using
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Hildenbrand <david@redhat.com>, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Seth Forshee <sforshee@kernel.org>, 
	Bongsu Jeon <bongsu.jeon@samsung.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-sound@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-input@vger.kernel.org, iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-actions@lists.infradead.org, mptcp@lists.linux.dev, 
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
asprintf into kselftest_harness.h, which is a GNU extension and needs
_GNU_SOURCE to either be defined prior to including headers or with the
-D_GNU_SOURCE flag passed to the compiler.

v1: https://lore.kernel.org/linux-kselftest/20240430235057.1351993-1-edliaw@google.com/
v2: add -D_GNU_SOURCE to KHDR_INCLUDES so that it is in a single
location.  Remove #define _GNU_SOURCE from source code to resolve
redefinition warnings.

Edward Liaw (5):
  selftests: Compile kselftest headers with -D_GNU_SOURCE
  selftests/sgx: Include KHDR_INCLUDES in Makefile
  selftests: Include KHDR_INCLUDES in Makefile
  selftests: Drop define _GNU_SOURCE
  selftests: Drop duplicate -D_GNU_SOURCE

 tools/testing/selftests/Makefile                              | 4 ++--
 tools/testing/selftests/alsa/Makefile                         | 2 +-
 tools/testing/selftests/arm64/signal/Makefile                 | 2 +-
 tools/testing/selftests/cachestat/test_cachestat.c            | 2 --
 tools/testing/selftests/capabilities/test_execve.c            | 2 --
 tools/testing/selftests/clone3/clone3.c                       | 2 --
 .../testing/selftests/clone3/clone3_cap_checkpoint_restore.c  | 2 --
 tools/testing/selftests/clone3/clone3_clear_sighand.c         | 2 --
 tools/testing/selftests/clone3/clone3_selftests.h             | 1 -
 tools/testing/selftests/clone3/clone3_set_tid.c               | 2 --
 tools/testing/selftests/core/close_range_test.c               | 2 --
 tools/testing/selftests/drivers/dma-buf/udmabuf.c             | 1 -
 tools/testing/selftests/exec/Makefile                         | 2 +-
 tools/testing/selftests/fchmodat2/fchmodat2_test.c            | 2 --
 tools/testing/selftests/filesystems/binderfs/binderfs_test.c  | 2 --
 tools/testing/selftests/filesystems/devpts_pts.c              | 1 -
 tools/testing/selftests/filesystems/dnotify_test.c            | 1 -
 tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c | 2 --
 tools/testing/selftests/filesystems/eventfd/eventfd_test.c    | 2 --
 tools/testing/selftests/filesystems/fat/rename_exchange.c     | 2 --
 tools/testing/selftests/filesystems/overlayfs/Makefile        | 2 +-
 tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c   | 2 --
 .../testing/selftests/filesystems/statmount/statmount_test.c  | 3 ---
 tools/testing/selftests/futex/functional/Makefile             | 2 +-
 tools/testing/selftests/futex/functional/futex_requeue_pi.c   | 3 ---
 tools/testing/selftests/hid/Makefile                          | 2 +-
 tools/testing/selftests/iommu/Makefile                        | 2 --
 tools/testing/selftests/ipc/msgque.c                          | 1 -
 tools/testing/selftests/kcmp/kcmp_test.c                      | 2 --
 tools/testing/selftests/kselftest_harness.h                   | 2 +-
 tools/testing/selftests/kvm/aarch64/arch_timer.c              | 2 --
 tools/testing/selftests/kvm/aarch64/page_fault_test.c         | 1 -
 tools/testing/selftests/kvm/aarch64/psci_test.c               | 3 ---
 tools/testing/selftests/kvm/aarch64/vgic_init.c               | 1 -
 tools/testing/selftests/kvm/arch_timer.c                      | 3 ---
 tools/testing/selftests/kvm/demand_paging_test.c              | 3 ---
 tools/testing/selftests/kvm/dirty_log_test.c                  | 3 ---
 tools/testing/selftests/kvm/guest_memfd_test.c                | 2 --
 tools/testing/selftests/kvm/hardware_disable_test.c           | 3 ---
 tools/testing/selftests/kvm/include/userfaultfd_util.h        | 3 ---
 tools/testing/selftests/kvm/kvm_binary_stats_test.c           | 2 --
 tools/testing/selftests/kvm/kvm_create_max_vcpus.c            | 2 --
 tools/testing/selftests/kvm/kvm_page_table_test.c             | 3 ---
 tools/testing/selftests/kvm/lib/assert.c                      | 3 ---
 tools/testing/selftests/kvm/lib/kvm_util.c                    | 2 --
 tools/testing/selftests/kvm/lib/memstress.c                   | 2 --
 tools/testing/selftests/kvm/lib/test_util.c                   | 2 --
 tools/testing/selftests/kvm/lib/userfaultfd_util.c            | 3 ---
 tools/testing/selftests/kvm/lib/x86_64/sev.c                  | 1 -
 tools/testing/selftests/kvm/max_guest_memory_test.c           | 2 --
 .../testing/selftests/kvm/memslot_modification_stress_test.c  | 3 ---
 tools/testing/selftests/kvm/riscv/arch_timer.c                | 3 ---
 tools/testing/selftests/kvm/rseq_test.c                       | 1 -
 tools/testing/selftests/kvm/s390x/cmma_test.c                 | 2 --
 tools/testing/selftests/kvm/s390x/sync_regs_test.c            | 2 --
 tools/testing/selftests/kvm/set_memory_region_test.c          | 1 -
 tools/testing/selftests/kvm/steal_time.c                      | 1 -
 tools/testing/selftests/kvm/x86_64/amx_test.c                 | 2 --
 .../selftests/kvm/x86_64/exit_on_emulation_failure_test.c     | 3 ---
 tools/testing/selftests/kvm/x86_64/hwcr_msr_test.c            | 2 --
 tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c             | 2 --
 tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c             | 1 -
 tools/testing/selftests/kvm/x86_64/hyperv_ipi.c               | 2 --
 tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c          | 1 -
 tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c         | 2 --
 tools/testing/selftests/kvm/x86_64/nested_exceptions_test.c   | 2 --
 tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c       | 3 ---
 tools/testing/selftests/kvm/x86_64/platform_info_test.c       | 2 --
 tools/testing/selftests/kvm/x86_64/pmu_counters_test.c        | 2 --
 tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c    | 3 ---
 .../selftests/kvm/x86_64/private_mem_conversions_test.c       | 1 -
 tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c          | 1 -
 tools/testing/selftests/kvm/x86_64/set_sregs_test.c           | 1 -
 .../selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c  | 3 ---
 tools/testing/selftests/kvm/x86_64/smm_test.c                 | 1 -
 tools/testing/selftests/kvm/x86_64/state_test.c               | 1 -
 tools/testing/selftests/kvm/x86_64/sync_regs_test.c           | 2 --
 tools/testing/selftests/kvm/x86_64/ucna_injection_test.c      | 2 --
 tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c  | 2 --
 tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c       | 3 ---
 tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c        | 1 -
 .../testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c  | 1 -
 tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c           | 2 --
 tools/testing/selftests/kvm/x86_64/xapic_state_test.c         | 1 -
 tools/testing/selftests/kvm/x86_64/xss_msr_test.c             | 2 --
 tools/testing/selftests/landlock/base_test.c                  | 2 --
 tools/testing/selftests/landlock/fs_test.c                    | 2 --
 tools/testing/selftests/landlock/net_test.c                   | 2 --
 tools/testing/selftests/landlock/ptrace_test.c                | 2 --
 tools/testing/selftests/lib.mk                                | 2 +-
 tools/testing/selftests/lsm/common.c                          | 2 --
 tools/testing/selftests/lsm/lsm_get_self_attr_test.c          | 2 --
 tools/testing/selftests/lsm/lsm_list_modules_test.c           | 2 --
 tools/testing/selftests/lsm/lsm_set_self_attr_test.c          | 2 --
 tools/testing/selftests/membarrier/membarrier_test_impl.h     | 1 -
 .../selftests/membarrier/membarrier_test_multi_thread.c       | 1 -
 .../selftests/membarrier/membarrier_test_single_thread.c      | 1 -
 tools/testing/selftests/memfd/common.c                        | 1 -
 tools/testing/selftests/memfd/fuse_test.c                     | 2 --
 tools/testing/selftests/memfd/memfd_test.c                    | 1 -
 tools/testing/selftests/mm/cow.c                              | 1 -
 tools/testing/selftests/mm/gup_longterm.c                     | 1 -
 tools/testing/selftests/mm/hugepage-mmap.c                    | 1 -
 tools/testing/selftests/mm/hugepage-mremap.c                  | 2 --
 tools/testing/selftests/mm/hugetlb-madvise.c                  | 2 --
 tools/testing/selftests/mm/hugetlb-read-hwpoison.c            | 2 --
 tools/testing/selftests/mm/khugepaged.c                       | 1 -
 tools/testing/selftests/mm/ksm_functional_tests.c             | 1 -
 tools/testing/selftests/mm/madv_populate.c                    | 1 -
 tools/testing/selftests/mm/map_populate.c                     | 2 --
 tools/testing/selftests/mm/mdwe_test.c                        | 1 -
 tools/testing/selftests/mm/memfd_secret.c                     | 2 --
 tools/testing/selftests/mm/mlock2-tests.c                     | 1 -
 tools/testing/selftests/mm/mrelease_test.c                    | 1 -
 tools/testing/selftests/mm/mremap_dontunmap.c                 | 1 -
 tools/testing/selftests/mm/mremap_test.c                      | 2 --
 tools/testing/selftests/mm/pagemap_ioctl.c                    | 1 -
 tools/testing/selftests/mm/pkey-helpers.h                     | 1 -
 tools/testing/selftests/mm/protection_keys.c                  | 1 -
 tools/testing/selftests/mm/split_huge_page_test.c             | 2 --
 tools/testing/selftests/mm/thuge-gen.c                        | 2 --
 tools/testing/selftests/mm/uffd-common.h                      | 1 -
 tools/testing/selftests/mount_setattr/mount_setattr_test.c    | 1 -
 .../move_mount_set_group/move_mount_set_group_test.c          | 1 -
 tools/testing/selftests/nci/Makefile                          | 2 +-
 tools/testing/selftests/net/af_unix/diag_uid.c                | 2 --
 tools/testing/selftests/net/af_unix/scm_pidfd.c               | 1 -
 tools/testing/selftests/net/af_unix/unix_connect.c            | 2 --
 tools/testing/selftests/net/csum.c                            | 3 ---
 tools/testing/selftests/net/gro.c                             | 3 ---
 tools/testing/selftests/net/ip_defrag.c                       | 3 ---
 tools/testing/selftests/net/ipsec.c                           | 3 ---
 tools/testing/selftests/net/ipv6_flowlabel.c                  | 3 ---
 tools/testing/selftests/net/ipv6_flowlabel_mgr.c              | 3 ---
 tools/testing/selftests/net/mptcp/mptcp_connect.c             | 3 ---
 tools/testing/selftests/net/mptcp/mptcp_inq.c                 | 3 ---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c             | 3 ---
 tools/testing/selftests/net/msg_zerocopy.c                    | 3 ---
 tools/testing/selftests/net/nettest.c                         | 2 --
 tools/testing/selftests/net/psock_fanout.c                    | 3 ---
 tools/testing/selftests/net/psock_snd.c                       | 3 ---
 tools/testing/selftests/net/reuseport_addr_any.c              | 3 ---
 tools/testing/selftests/net/reuseport_bpf_cpu.c               | 3 ---
 tools/testing/selftests/net/reuseport_bpf_numa.c              | 3 ---
 tools/testing/selftests/net/reuseport_dualstack.c             | 3 ---
 tools/testing/selftests/net/so_incoming_cpu.c                 | 1 -
 tools/testing/selftests/net/so_netns_cookie.c                 | 1 -
 tools/testing/selftests/net/so_txtime.c                       | 3 ---
 tools/testing/selftests/net/tap.c                             | 3 ---
 tools/testing/selftests/net/tcp_ao/Makefile                   | 2 +-
 tools/testing/selftests/net/tcp_fastopen_backup_key.c         | 1 -
 tools/testing/selftests/net/tcp_inq.c                         | 2 --
 tools/testing/selftests/net/tcp_mmap.c                        | 1 -
 tools/testing/selftests/net/tls.c                             | 3 ---
 tools/testing/selftests/net/toeplitz.c                        | 3 ---
 tools/testing/selftests/net/tun.c                             | 3 ---
 tools/testing/selftests/net/txring_overwrite.c                | 3 ---
 tools/testing/selftests/net/txtimestamp.c                     | 3 ---
 tools/testing/selftests/net/udpgso.c                          | 3 ---
 tools/testing/selftests/net/udpgso_bench_rx.c                 | 3 ---
 tools/testing/selftests/net/udpgso_bench_tx.c                 | 3 ---
 tools/testing/selftests/perf_events/remove_on_exec.c          | 2 --
 tools/testing/selftests/perf_events/sigtrap_threads.c         | 2 --
 tools/testing/selftests/pid_namespace/regression_enomem.c     | 1 -
 tools/testing/selftests/pidfd/pidfd.h                         | 1 -
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c             | 2 --
 tools/testing/selftests/pidfd/pidfd_getfd_test.c              | 2 --
 tools/testing/selftests/pidfd/pidfd_open_test.c               | 2 --
 tools/testing/selftests/pidfd/pidfd_poll_test.c               | 2 --
 tools/testing/selftests/pidfd/pidfd_setns_test.c              | 2 --
 tools/testing/selftests/pidfd/pidfd_test.c                    | 2 --
 tools/testing/selftests/pidfd/pidfd_wait.c                    | 2 --
 tools/testing/selftests/prctl/Makefile                        | 2 ++
 tools/testing/selftests/proc/Makefile                         | 2 +-
 tools/testing/selftests/ptrace/get_set_sud.c                  | 1 -
 tools/testing/selftests/ptrace/peeksiginfo.c                  | 1 -
 tools/testing/selftests/resctrl/Makefile                      | 2 +-
 tools/testing/selftests/riscv/mm/Makefile                     | 2 +-
 tools/testing/selftests/rseq/basic_percpu_ops_test.c          | 1 -
 tools/testing/selftests/rseq/basic_test.c                     | 2 --
 tools/testing/selftests/rseq/param_test.c                     | 1 -
 tools/testing/selftests/rseq/rseq.c                           | 2 --
 tools/testing/selftests/rtc/Makefile                          | 2 +-
 tools/testing/selftests/seccomp/seccomp_benchmark.c           | 1 -
 tools/testing/selftests/seccomp/seccomp_bpf.c                 | 2 --
 tools/testing/selftests/sgx/Makefile                          | 2 +-
 tools/testing/selftests/sgx/sigstruct.c                       | 1 -
 tools/testing/selftests/tmpfs/Makefile                        | 2 +-
 tools/testing/selftests/user_events/abi_test.c                | 2 --
 tools/testing/selftests/x86/amx.c                             | 2 --
 tools/testing/selftests/x86/check_initial_reg_state.c         | 3 ---
 tools/testing/selftests/x86/corrupt_xstate_header.c           | 3 ---
 tools/testing/selftests/x86/entry_from_vm86.c                 | 3 ---
 tools/testing/selftests/x86/fsgsbase.c                        | 2 --
 tools/testing/selftests/x86/fsgsbase_restore.c                | 2 --
 tools/testing/selftests/x86/ioperm.c                          | 2 --
 tools/testing/selftests/x86/iopl.c                            | 2 --
 tools/testing/selftests/x86/lam.c                             | 1 -
 tools/testing/selftests/x86/ldt_gdt.c                         | 2 --
 tools/testing/selftests/x86/mov_ss_trap.c                     | 2 --
 tools/testing/selftests/x86/nx_stack.c                        | 2 --
 tools/testing/selftests/x86/ptrace_syscall.c                  | 2 --
 tools/testing/selftests/x86/sigaltstack.c                     | 2 --
 tools/testing/selftests/x86/sigreturn.c                       | 3 ---
 tools/testing/selftests/x86/single_step_syscall.c             | 3 ---
 tools/testing/selftests/x86/syscall_arg_fault.c               | 3 ---
 tools/testing/selftests/x86/syscall_numbering.c               | 3 ---
 tools/testing/selftests/x86/sysret_rip.c                      | 3 ---
 tools/testing/selftests/x86/sysret_ss_attrs.c                 | 3 ---
 tools/testing/selftests/x86/test_FCMOV.c                      | 4 ----
 tools/testing/selftests/x86/test_FCOMI.c                      | 4 ----
 tools/testing/selftests/x86/test_FISTTP.c                     | 4 ----
 tools/testing/selftests/x86/test_mremap_vdso.c                | 1 -
 tools/testing/selftests/x86/test_shadow_stack.c               | 3 ---
 tools/testing/selftests/x86/test_syscall_vdso.c               | 4 ----
 tools/testing/selftests/x86/test_vsyscall.c                   | 3 ---
 tools/testing/selftests/x86/unwind_vdso.c                     | 3 ---
 tools/testing/selftests/x86/vdso_restorer.c                   | 3 ---
 218 files changed, 20 insertions(+), 426 deletions(-)

--
2.45.0.rc1.225.g2a3ae87e7f-goog


