Return-Path: <linux-fsdevel+bounces-19137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 061808C078F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 01:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71ED61F22946
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 23:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32CB1339B8;
	Wed,  8 May 2024 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iwxf4bkt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F216A5338D
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715209834; cv=none; b=pUrS+MGOKcTnHWp/zKvnrxxgZX3tGvy6O1AFPzGxsLSkwwME9pki3sRuQtf2nrtGi5hJVtZBbTXdk8kYVOVPKTG7WqgHxekn/cLIilE78OkQKubwop4XG+QNTx8IbAE+mH4LBER0jwInXEOPDYe0ETXzGw+8BpmyuIvF2BRUcCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715209834; c=relaxed/simple;
	bh=GLERfbMnsmuFAuMuxywN9iF9fGY0EwPrTh8sSjCh724=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvOEIcOzUfFCcHE97f0c0kz7C0WA6uT9F0ZgPBikmdiJRSY5r8eFVtW81YebK5++iVHbMkXMfQTobe6WTrgwWFplPxqCxZERYI8yLkMxdxtjZTntDJMCh64eFUgwRL4cyybeZN9h/FPYgIOuOf2/t7c138BmVh+Fowoh4JBzE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iwxf4bkt; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36c31c23ab6so90025ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 16:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715209828; x=1715814628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLnlpoMndJv6kXCz+FbZOexc9v1XQ4k/KtWuckbio3c=;
        b=Iwxf4bktbwUVJx1SVqOyYZgiC3xjRaHoWQbFDzoFSVtJcrruuQ175G6cdb+cZHYURL
         0/47qBcikRMUvFGRmRJVnDC6TSRjbuyQSTPQBGyq2fp0XIM1NNgiWnKU9TcLiYXVcO1s
         +2dDcJAiDScGDIug8CCQdqyC+mkoZkE3IxZqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715209828; x=1715814628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLnlpoMndJv6kXCz+FbZOexc9v1XQ4k/KtWuckbio3c=;
        b=CcMOfuMsyJnR/zlI138rU8akgSgTNZc4B8rKWYC24Xn+z+6wfsB7T0O11nGiH+rJWK
         k0M7dZbqEVx6r1Ltc6tI0eu2bUODpPLqeSsDCP7/kxraQ5uqiNZj9P0nk7Q99XmS4vrr
         RuMmepVmJ65ImYgLKCTbIaXJgAOOS0P5fSACC745PWdCUr+InKSKuwZm8QxDDMdNbHk7
         0NUPYUxPcVegLyUBtrd9+OnbBMoKM7TcVK69SBP8gC3QfouhlLNQFrJLHy3j3O1FbILU
         1wj/43pfWAdvm0fYj/JdmEGIJ7HptHmoDW1ThbCgmcuIRtKPzuuquKVTRRkRY+MuZaA+
         oQ9w==
X-Forwarded-Encrypted: i=1; AJvYcCVXXC3Jja80QIB6cio0huBYXOf+A+OFuyeXvzyJGkd3uqP92ADYsYbcRsDN0MySUzd2HpMFrC0jtUqXbZNsfT4Wzs/Iojr2qjVNl+ux4w==
X-Gm-Message-State: AOJu0YzhdlTjonOlcSpiTCai0hvmwFHNd/OnAd84dZG7/Fm7jQw3nASP
	Rzknchv5h4MiTz3o4ncy2NJsKBwGbVHypb+RUqAcab7ptas7j1zkNSdwELxsvcc=
X-Google-Smtp-Source: AGHT+IGjHhKKM24ZUFIVswkuYx3QwGN8iZAP+skToQSUH9ATxlCCLFZFt3zeJLulXQKSKo0MDx46iA==
X-Received: by 2002:a05:6e02:2193:b0:369:f53b:6c2 with SMTP id e9e14a558f8ab-36caecc858bmr42995245ab.1.1715209827936;
        Wed, 08 May 2024 16:10:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9e08d92sm170485ab.54.2024.05.08.16.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 16:10:27 -0700 (PDT)
Message-ID: <f4e45604-86b0-4be6-9bea-36edf301df33@linuxfoundation.org>
Date: Wed, 8 May 2024 17:10:24 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Define _GNU_SOURCE for sources using
To: Edward Liaw <edliaw@google.com>, shuah@kernel.org,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Christian Brauner
 <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>,
 Kees Cook <keescook@chromium.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Andrew Morton <akpm@linux-foundation.org>, Seth Forshee
 <sforshee@kernel.org>, Bongsu Jeon <bongsu.jeon@samsung.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-input@vger.kernel.org, iommu@lists.linux.dev, kvmarm@lists.linux.dev,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
 linux-actions@lists.infradead.org, mptcp@lists.linux.dev,
 linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, bpf@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240507214254.2787305-1-edliaw@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240507214254.2787305-1-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/24 15:38, Edward Liaw wrote:
> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> asprintf into kselftest_harness.h, which is a GNU extension and needs
> _GNU_SOURCE to either be defined prior to including headers or with the
> -D_GNU_SOURCE flag passed to the compiler.
> 
> v1: https://lore.kernel.org/linux-kselftest/20240430235057.1351993-1-edliaw@google.com/
> v2: add -D_GNU_SOURCE to KHDR_INCLUDES so that it is in a single
> location.  Remove #define _GNU_SOURCE from source code to resolve
> redefinition warnings.
> 
> Edward Liaw (5):
>    selftests: Compile kselftest headers with -D_GNU_SOURCE
>    selftests/sgx: Include KHDR_INCLUDES in Makefile

I appled patches 1/5 and 2.5 - The rest need to be split up.

>    selftests: Include KHDR_INCLUDES in Makefile
>    selftests: Drop define _GNU_SOURCE
>    selftests: Drop duplicate -D_GNU_SOURCE
> 

Please split these patches pwe test directory. Otherwise it will
cause merge conflicts which can be hard to resolve.

>   tools/testing/selftests/Makefile                              | 4 ++--
>   tools/testing/selftests/alsa/Makefile                         | 2 +-
>   tools/testing/selftests/arm64/signal/Makefile                 | 2 +-
>   tools/testing/selftests/cachestat/test_cachestat.c            | 2 --
>   tools/testing/selftests/capabilities/test_execve.c            | 2 --
>   tools/testing/selftests/clone3/clone3.c                       | 2 --
>   .../testing/selftests/clone3/clone3_cap_checkpoint_restore.c  | 2 --
>   tools/testing/selftests/clone3/clone3_clear_sighand.c         | 2 --
>   tools/testing/selftests/clone3/clone3_selftests.h             | 1 -
>   tools/testing/selftests/clone3/clone3_set_tid.c               | 2 --
>   tools/testing/selftests/core/close_range_test.c               | 2 --
>   tools/testing/selftests/drivers/dma-buf/udmabuf.c             | 1 -
>   tools/testing/selftests/exec/Makefile                         | 2 +-
>   tools/testing/selftests/fchmodat2/fchmodat2_test.c            | 2 --
>   tools/testing/selftests/filesystems/binderfs/binderfs_test.c  | 2 --
>   tools/testing/selftests/filesystems/devpts_pts.c              | 1 -
>   tools/testing/selftests/filesystems/dnotify_test.c            | 1 -
>   tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c | 2 --
>   tools/testing/selftests/filesystems/eventfd/eventfd_test.c    | 2 --
>   tools/testing/selftests/filesystems/fat/rename_exchange.c     | 2 --
>   tools/testing/selftests/filesystems/overlayfs/Makefile        | 2 +-
>   tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c   | 2 --
>   .../testing/selftests/filesystems/statmount/statmount_test.c  | 3 ---
>   tools/testing/selftests/futex/functional/Makefile             | 2 +-
>   tools/testing/selftests/futex/functional/futex_requeue_pi.c   | 3 ---
>   tools/testing/selftests/hid/Makefile                          | 2 +-
>   tools/testing/selftests/iommu/Makefile                        | 2 --
>   tools/testing/selftests/ipc/msgque.c                          | 1 -
>   tools/testing/selftests/kcmp/kcmp_test.c                      | 2 --
>   tools/testing/selftests/kselftest_harness.h                   | 2 +-
>   tools/testing/selftests/kvm/aarch64/arch_timer.c              | 2 --
>   tools/testing/selftests/kvm/aarch64/page_fault_test.c         | 1 -
>   tools/testing/selftests/kvm/aarch64/psci_test.c               | 3 ---
>   tools/testing/selftests/kvm/aarch64/vgic_init.c               | 1 -
>   tools/testing/selftests/kvm/arch_timer.c                      | 3 ---
>   tools/testing/selftests/kvm/demand_paging_test.c              | 3 ---
>   tools/testing/selftests/kvm/dirty_log_test.c                  | 3 ---
>   tools/testing/selftests/kvm/guest_memfd_test.c                | 2 --
>   tools/testing/selftests/kvm/hardware_disable_test.c           | 3 ---
>   tools/testing/selftests/kvm/include/userfaultfd_util.h        | 3 ---
>   tools/testing/selftests/kvm/kvm_binary_stats_test.c           | 2 --
>   tools/testing/selftests/kvm/kvm_create_max_vcpus.c            | 2 --
>   tools/testing/selftests/kvm/kvm_page_table_test.c             | 3 ---
>   tools/testing/selftests/kvm/lib/assert.c                      | 3 ---
>   tools/testing/selftests/kvm/lib/kvm_util.c                    | 2 --
>   tools/testing/selftests/kvm/lib/memstress.c                   | 2 --
>   tools/testing/selftests/kvm/lib/test_util.c                   | 2 --
>   tools/testing/selftests/kvm/lib/userfaultfd_util.c            | 3 ---
>   tools/testing/selftests/kvm/lib/x86_64/sev.c                  | 1 -
>   tools/testing/selftests/kvm/max_guest_memory_test.c           | 2 --
>   .../testing/selftests/kvm/memslot_modification_stress_test.c  | 3 ---
>   tools/testing/selftests/kvm/riscv/arch_timer.c                | 3 ---
>   tools/testing/selftests/kvm/rseq_test.c                       | 1 -
>   tools/testing/selftests/kvm/s390x/cmma_test.c                 | 2 --
>   tools/testing/selftests/kvm/s390x/sync_regs_test.c            | 2 --
>   tools/testing/selftests/kvm/set_memory_region_test.c          | 1 -
>   tools/testing/selftests/kvm/steal_time.c                      | 1 -
>   tools/testing/selftests/kvm/x86_64/amx_test.c                 | 2 --
>   .../selftests/kvm/x86_64/exit_on_emulation_failure_test.c     | 3 ---
>   tools/testing/selftests/kvm/x86_64/hwcr_msr_test.c            | 2 --
>   tools/testing/selftests/kvm/x86_64/hyperv_cpuid.c             | 2 --
>   tools/testing/selftests/kvm/x86_64/hyperv_evmcs.c             | 1 -
>   tools/testing/selftests/kvm/x86_64/hyperv_ipi.c               | 2 --
>   tools/testing/selftests/kvm/x86_64/hyperv_svm_test.c          | 1 -
>   tools/testing/selftests/kvm/x86_64/hyperv_tlb_flush.c         | 2 --
>   tools/testing/selftests/kvm/x86_64/nested_exceptions_test.c   | 2 --
>   tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.c       | 3 ---
>   tools/testing/selftests/kvm/x86_64/platform_info_test.c       | 2 --
>   tools/testing/selftests/kvm/x86_64/pmu_counters_test.c        | 2 --
>   tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c    | 3 ---
>   .../selftests/kvm/x86_64/private_mem_conversions_test.c       | 1 -
>   tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c          | 1 -
>   tools/testing/selftests/kvm/x86_64/set_sregs_test.c           | 1 -
>   .../selftests/kvm/x86_64/smaller_maxphyaddr_emulation_test.c  | 3 ---
>   tools/testing/selftests/kvm/x86_64/smm_test.c                 | 1 -
>   tools/testing/selftests/kvm/x86_64/state_test.c               | 1 -
>   tools/testing/selftests/kvm/x86_64/sync_regs_test.c           | 2 --
>   tools/testing/selftests/kvm/x86_64/ucna_injection_test.c      | 2 --
>   tools/testing/selftests/kvm/x86_64/userspace_msr_exit_test.c  | 2 --
>   tools/testing/selftests/kvm/x86_64/vmx_dirty_log_test.c       | 3 ---
>   tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c        | 1 -
>   .../testing/selftests/kvm/x86_64/vmx_preemption_timer_test.c  | 1 -
>   tools/testing/selftests/kvm/x86_64/xapic_ipi_test.c           | 2 --
>   tools/testing/selftests/kvm/x86_64/xapic_state_test.c         | 1 -
>   tools/testing/selftests/kvm/x86_64/xss_msr_test.c             | 2 --
>   tools/testing/selftests/landlock/base_test.c                  | 2 --
>   tools/testing/selftests/landlock/fs_test.c                    | 2 --
>   tools/testing/selftests/landlock/net_test.c                   | 2 --
>   tools/testing/selftests/landlock/ptrace_test.c                | 2 --
>   tools/testing/selftests/lib.mk                                | 2 +-
>   tools/testing/selftests/lsm/common.c                          | 2 --
>   tools/testing/selftests/lsm/lsm_get_self_attr_test.c          | 2 --
>   tools/testing/selftests/lsm/lsm_list_modules_test.c           | 2 --
>   tools/testing/selftests/lsm/lsm_set_self_attr_test.c          | 2 --
>   tools/testing/selftests/membarrier/membarrier_test_impl.h     | 1 -
>   .../selftests/membarrier/membarrier_test_multi_thread.c       | 1 -
>   .../selftests/membarrier/membarrier_test_single_thread.c      | 1 -
>   tools/testing/selftests/memfd/common.c                        | 1 -
>   tools/testing/selftests/memfd/fuse_test.c                     | 2 --
>   tools/testing/selftests/memfd/memfd_test.c                    | 1 -
>   tools/testing/selftests/mm/cow.c                              | 1 -
>   tools/testing/selftests/mm/gup_longterm.c                     | 1 -
>   tools/testing/selftests/mm/hugepage-mmap.c                    | 1 -
>   tools/testing/selftests/mm/hugepage-mremap.c                  | 2 --
>   tools/testing/selftests/mm/hugetlb-madvise.c                  | 2 --
>   tools/testing/selftests/mm/hugetlb-read-hwpoison.c            | 2 --
>   tools/testing/selftests/mm/khugepaged.c                       | 1 -
>   tools/testing/selftests/mm/ksm_functional_tests.c             | 1 -
>   tools/testing/selftests/mm/madv_populate.c                    | 1 -
>   tools/testing/selftests/mm/map_populate.c                     | 2 --
>   tools/testing/selftests/mm/mdwe_test.c                        | 1 -
>   tools/testing/selftests/mm/memfd_secret.c                     | 2 --
>   tools/testing/selftests/mm/mlock2-tests.c                     | 1 -
>   tools/testing/selftests/mm/mrelease_test.c                    | 1 -
>   tools/testing/selftests/mm/mremap_dontunmap.c                 | 1 -
>   tools/testing/selftests/mm/mremap_test.c                      | 2 --
>   tools/testing/selftests/mm/pagemap_ioctl.c                    | 1 -
>   tools/testing/selftests/mm/pkey-helpers.h                     | 1 -
>   tools/testing/selftests/mm/protection_keys.c                  | 1 -
>   tools/testing/selftests/mm/split_huge_page_test.c             | 2 --
>   tools/testing/selftests/mm/thuge-gen.c                        | 2 --
>   tools/testing/selftests/mm/uffd-common.h                      | 1 -
>   tools/testing/selftests/mount_setattr/mount_setattr_test.c    | 1 -
>   .../move_mount_set_group/move_mount_set_group_test.c          | 1 -
>   tools/testing/selftests/nci/Makefile                          | 2 +-
>   tools/testing/selftests/net/af_unix/diag_uid.c                | 2 --
>   tools/testing/selftests/net/af_unix/scm_pidfd.c               | 1 -
>   tools/testing/selftests/net/af_unix/unix_connect.c            | 2 --
>   tools/testing/selftests/net/csum.c                            | 3 ---
>   tools/testing/selftests/net/gro.c                             | 3 ---
>   tools/testing/selftests/net/ip_defrag.c                       | 3 ---
>   tools/testing/selftests/net/ipsec.c                           | 3 ---
>   tools/testing/selftests/net/ipv6_flowlabel.c                  | 3 ---
>   tools/testing/selftests/net/ipv6_flowlabel_mgr.c              | 3 ---
>   tools/testing/selftests/net/mptcp/mptcp_connect.c             | 3 ---
>   tools/testing/selftests/net/mptcp/mptcp_inq.c                 | 3 ---
>   tools/testing/selftests/net/mptcp/mptcp_sockopt.c             | 3 ---
>   tools/testing/selftests/net/msg_zerocopy.c                    | 3 ---
>   tools/testing/selftests/net/nettest.c                         | 2 --
>   tools/testing/selftests/net/psock_fanout.c                    | 3 ---
>   tools/testing/selftests/net/psock_snd.c                       | 3 ---
>   tools/testing/selftests/net/reuseport_addr_any.c              | 3 ---
>   tools/testing/selftests/net/reuseport_bpf_cpu.c               | 3 ---
>   tools/testing/selftests/net/reuseport_bpf_numa.c              | 3 ---
>   tools/testing/selftests/net/reuseport_dualstack.c             | 3 ---
>   tools/testing/selftests/net/so_incoming_cpu.c                 | 1 -
>   tools/testing/selftests/net/so_netns_cookie.c                 | 1 -
>   tools/testing/selftests/net/so_txtime.c                       | 3 ---
>   tools/testing/selftests/net/tap.c                             | 3 ---
>   tools/testing/selftests/net/tcp_ao/Makefile                   | 2 +-
>   tools/testing/selftests/net/tcp_fastopen_backup_key.c         | 1 -
>   tools/testing/selftests/net/tcp_inq.c                         | 2 --
>   tools/testing/selftests/net/tcp_mmap.c                        | 1 -
>   tools/testing/selftests/net/tls.c                             | 3 ---
>   tools/testing/selftests/net/toeplitz.c                        | 3 ---
>   tools/testing/selftests/net/tun.c                             | 3 ---
>   tools/testing/selftests/net/txring_overwrite.c                | 3 ---
>   tools/testing/selftests/net/txtimestamp.c                     | 3 ---
>   tools/testing/selftests/net/udpgso.c                          | 3 ---
>   tools/testing/selftests/net/udpgso_bench_rx.c                 | 3 ---
>   tools/testing/selftests/net/udpgso_bench_tx.c                 | 3 ---
>   tools/testing/selftests/perf_events/remove_on_exec.c          | 2 --
>   tools/testing/selftests/perf_events/sigtrap_threads.c         | 2 --
>   tools/testing/selftests/pid_namespace/regression_enomem.c     | 1 -
>   tools/testing/selftests/pidfd/pidfd.h                         | 1 -
>   tools/testing/selftests/pidfd/pidfd_fdinfo_test.c             | 2 --
>   tools/testing/selftests/pidfd/pidfd_getfd_test.c              | 2 --
>   tools/testing/selftests/pidfd/pidfd_open_test.c               | 2 --
>   tools/testing/selftests/pidfd/pidfd_poll_test.c               | 2 --
>   tools/testing/selftests/pidfd/pidfd_setns_test.c              | 2 --
>   tools/testing/selftests/pidfd/pidfd_test.c                    | 2 --
>   tools/testing/selftests/pidfd/pidfd_wait.c                    | 2 --
>   tools/testing/selftests/prctl/Makefile                        | 2 ++
>   tools/testing/selftests/proc/Makefile                         | 2 +-
>   tools/testing/selftests/ptrace/get_set_sud.c                  | 1 -
>   tools/testing/selftests/ptrace/peeksiginfo.c                  | 1 -
>   tools/testing/selftests/resctrl/Makefile                      | 2 +-
>   tools/testing/selftests/riscv/mm/Makefile                     | 2 +-
>   tools/testing/selftests/rseq/basic_percpu_ops_test.c          | 1 -
>   tools/testing/selftests/rseq/basic_test.c                     | 2 --
>   tools/testing/selftests/rseq/param_test.c                     | 1 -
>   tools/testing/selftests/rseq/rseq.c                           | 2 --
>   tools/testing/selftests/rtc/Makefile                          | 2 +-
>   tools/testing/selftests/seccomp/seccomp_benchmark.c           | 1 -
>   tools/testing/selftests/seccomp/seccomp_bpf.c                 | 2 --
>   tools/testing/selftests/sgx/Makefile                          | 2 +-
>   tools/testing/selftests/sgx/sigstruct.c                       | 1 -
>   tools/testing/selftests/tmpfs/Makefile                        | 2 +-
>   tools/testing/selftests/user_events/abi_test.c                | 2 --
>   tools/testing/selftests/x86/amx.c                             | 2 --
>   tools/testing/selftests/x86/check_initial_reg_state.c         | 3 ---
>   tools/testing/selftests/x86/corrupt_xstate_header.c           | 3 ---
>   tools/testing/selftests/x86/entry_from_vm86.c                 | 3 ---
>   tools/testing/selftests/x86/fsgsbase.c                        | 2 --
>   tools/testing/selftests/x86/fsgsbase_restore.c                | 2 --
>   tools/testing/selftests/x86/ioperm.c                          | 2 --
>   tools/testing/selftests/x86/iopl.c                            | 2 --
>   tools/testing/selftests/x86/lam.c                             | 1 -
>   tools/testing/selftests/x86/ldt_gdt.c                         | 2 --
>   tools/testing/selftests/x86/mov_ss_trap.c                     | 2 --
>   tools/testing/selftests/x86/nx_stack.c                        | 2 --
>   tools/testing/selftests/x86/ptrace_syscall.c                  | 2 --
>   tools/testing/selftests/x86/sigaltstack.c                     | 2 --
>   tools/testing/selftests/x86/sigreturn.c                       | 3 ---
>   tools/testing/selftests/x86/single_step_syscall.c             | 3 ---
>   tools/testing/selftests/x86/syscall_arg_fault.c               | 3 ---
>   tools/testing/selftests/x86/syscall_numbering.c               | 3 ---
>   tools/testing/selftests/x86/sysret_rip.c                      | 3 ---
>   tools/testing/selftests/x86/sysret_ss_attrs.c                 | 3 ---
>   tools/testing/selftests/x86/test_FCMOV.c                      | 4 ----
>   tools/testing/selftests/x86/test_FCOMI.c                      | 4 ----
>   tools/testing/selftests/x86/test_FISTTP.c                     | 4 ----
>   tools/testing/selftests/x86/test_mremap_vdso.c                | 1 -
>   tools/testing/selftests/x86/test_shadow_stack.c               | 3 ---
>   tools/testing/selftests/x86/test_syscall_vdso.c               | 4 ----
>   tools/testing/selftests/x86/test_vsyscall.c                   | 3 ---
>   tools/testing/selftests/x86/unwind_vdso.c                     | 3 ---
>   tools/testing/selftests/x86/vdso_restorer.c                   | 3 ---
>   218 files changed, 20 insertions(+), 426 deletions(-)
> 
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
> 
> 

thanks,
-- Shuah

