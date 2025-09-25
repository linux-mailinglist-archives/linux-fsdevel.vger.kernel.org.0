Return-Path: <linux-fsdevel+bounces-62812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B9ABA1A1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 23:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C521704D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 21:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E8F323F61;
	Thu, 25 Sep 2025 21:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="onw8lRvi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBDA322C8E
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836124; cv=none; b=UZLNbJryy63zyZ8qVXSZStOEH8p9kIsXh16igES+OPTIL1nbC/2+Or/ET5+We01IIXpUjDmCvmMENOHur9kjbvPsxODXr+DJxWFTWTLqpziqVq6/a7kG95oHCQhigUJtGLW1ibMQWlmh9r3IHbs85VoT+yQbpxnj0SlQXHCOoa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836124; c=relaxed/simple;
	bh=Lh1tfSZ0NF/AFO/V/8hHUF+qpGzjYGIIGuaXa4zfnL4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pXR/ZSRNufZzGCWMDDWW0IZDQTGkFkxYNquZV3XA7x32Q/d/8iEfpQO1CizEZArpVLpsk5CUKU6mlxGtGEj2C/QfkAUcj66eaiOfML9iaoXaozrZNxsNm/X6I2Sh9x8e6yybNPhIXuWq7cLAzlQeGikHKjyEItFhzhES1UrdFmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=onw8lRvi; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3306543e5abso1409347a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 14:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758836121; x=1759440921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dyD0NvHQvKcjtkMWqtARFSwsGpym7n4r8JiRe/0tuUQ=;
        b=onw8lRvivIaqXqhZ94k9VIfBy202X1wcl6kC5wMxM4fMRMqJCFtExOOO4OSzFrs0RS
         qHFjEeoEtQfyZAZJP6YQmMYMFNJIzjcra6ZBnCxaERFeYR408n/9Ve3aVpTYm5nPBAgJ
         qMsrAXWPQ+p75NcDftx9/Rr0IZF8PIOZA9ltXOiwvQ3g1F5fyBcv9jTQYfnHqjrZpAF3
         2/qagGANvpvdP7va2hYkf8cOa2EP1yIlnKne6xfHvbNp5CAlkPKUDXZTgovUwRHGL259
         zQiCfU9XIGcVYd7ArvCRqcPxJUFH5956E3BUVCgylnJjJk5rRwHzTewMQqRNjVs5Xxff
         mXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758836121; x=1759440921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyD0NvHQvKcjtkMWqtARFSwsGpym7n4r8JiRe/0tuUQ=;
        b=h0UzU5/WhbV1LfZimnkXmiTc0dfw6bshBRLDU8PGIE9teVFtBJV/f91p3pxP2/RQiQ
         tUU9jP36o5oH4pR7laeECkO9/T7ml7NEzpJ2PpNxErEhk340w1E+112mJFrooK1J+tOx
         WhYfmhWlGpO1MHhCRFNG1auCL06vLL2ejowvcW3kc4csdA/ccPkXhOsHJq9rFIcIi08e
         Yc64wXEQXd2ZHPUYGj93KE9CQqsgc064YWPj7ggZENQCghku7sB7i1Qz0jXDTrqp2qwF
         A3ft1HwbasRaoeya4+ia1wQGRxKN0E19XZGG3wP4gsS8jpG4IGrfyL3pHyMXkTOEcRKe
         eaKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJaD5KpiD2xy9FYMkqpmjfeHDzSGjxfC2fgZKp741kTN6MDyHhRilWnv6OZQBfdM6et+DVjFsRom6zHwjJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzAhkxJumdcjGd/0B6T1SxtbtvQkpo+FPmfAjBi3OfG11pFVCkq
	+nMxzggl9V59Gn43QS9/LQmVeWP1VgdHU2K11ntdPCtloONzFOqrQM43E/1bVnfIgwWyvzGi7BU
	cuH1KjQ==
X-Google-Smtp-Source: AGHT+IEF46Ap3+CoFy4DNwHeeqPSdM0QIu1/iWB0NVseFrH0JqhT9O+vdtR7XjCf1sCWIaN5eWCQMso96V4=
X-Received: from pjj5.prod.google.com ([2002:a17:90b:5545:b0:330:6cf5:5f38])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c07:b0:32e:ca60:6bd7
 with SMTP id 98e67ed59e1d1-334568960d8mr4094341a91.11.1758836121051; Thu, 25
 Sep 2025 14:35:21 -0700 (PDT)
Date: Thu, 25 Sep 2025 14:35:19 -0700
In-Reply-To: <20250827175247.83322-10-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-10-shivankg@amd.com>
Message-ID: <aNW1l-Wdk6wrigM8@google.com>
Subject: Re: [PATCH kvm-next V11 7/7] KVM: guest_memfd: selftests: Add tests
 for mmap and NUMA policy support
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, david@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, vbabka@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, dsterba@suse.com, xiang@kernel.org, chao@kernel.org, 
	jaegeuk@kernel.org, clm@fb.com, josef@toxicpanda.com, 
	kent.overstreet@linux.dev, zbestahu@gmail.com, jefflexu@linux.alibaba.com, 
	dhavale@google.com, lihongbo22@huawei.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, tabba@google.com, 
	ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, 
	kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, hch@infradead.org, 
	cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com, 
	roypat@amazon.co.uk, chao.p.peng@intel.com, amit@infradead.org, 
	ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com, 
	gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com, 
	yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 27, 2025, Shivank Garg wrote:
> Add tests for NUMA memory policy binding and NUMA aware allocation in
> guest_memfd. This extends the existing selftests by adding proper
> validation for:
> - KVM GMEM set_policy and get_policy() vm_ops functionality using
>   mbind() and get_mempolicy()
> - NUMA policy application before and after memory allocation
> 
> These tests help ensure NUMA support for guest_memfd works correctly.
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../testing/selftests/kvm/guest_memfd_test.c  | 121 ++++++++++++++++++
>  2 files changed, 122 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 90f03f00cb04..c46cef2a7cd7 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -275,6 +275,7 @@ pgste-option = $(call try-run, echo 'int main(void) { return 0; }' | \
>  	$(CC) -Werror -Wl$(comma)--s390-pgste -x c - -o "$$TMP",-Wl$(comma)--s390-pgste)
>  
>  LDLIBS += -ldl
> +LDLIBS += -lnuma

Hrm, this is going to be very annoying.  I don't have libnuma-dev installed on
any of my <too many> systems, and I doubt I'm alone.  Installing the package is
trivial, but I'm a little wary of foisting that requirement on all KVM developers
and build bots.

I'd be especially curious what ARM and RISC-V think, as NUMA is likely a bit less
prevelant there.

>  LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
>  
>  LIBKVM_C := $(filter %.c,$(LIBKVM))
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> index b3ca6737f304..9640d04ec293 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -7,6 +7,8 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> +#include <numa.h>
> +#include <numaif.h>
>  #include <errno.h>
>  #include <stdio.h>
>  #include <fcntl.h>
> @@ -19,6 +21,7 @@
>  #include <sys/mman.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <sys/syscall.h>
>  
>  #include "kvm_util.h"
>  #include "test_util.h"
> @@ -72,6 +75,122 @@ static void test_mmap_supported(int fd, size_t page_size, size_t total_size)
>  	TEST_ASSERT(!ret, "munmap() should succeed.");
>  }
>  
> +#define TEST_REQUIRE_NUMA_MULTIPLE_NODES()	\
> +	TEST_REQUIRE(numa_available() != -1 && numa_max_node() >= 1)

Using TEST_REQUIRE() here will result in skipping the _entire_ test.  Ideally
this test would use fixtures so that each testcase can run in a child process
and thus can use TEST_REQUIRE(), but that's a conversion for another day.

Easiest thing would probably be to turn this into a common helper and then bail
early.

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 9640d04ec293..6acb186e5300 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -7,7 +7,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <numa.h>
 #include <numaif.h>
 #include <errno.h>
 #include <stdio.h>
@@ -75,9 +74,6 @@ static void test_mmap_supported(int fd, size_t page_size, size_t total_size)
        TEST_ASSERT(!ret, "munmap() should succeed.");
 }
 
-#define TEST_REQUIRE_NUMA_MULTIPLE_NODES()     \
-       TEST_REQUIRE(numa_available() != -1 && numa_max_node() >= 1)
-
 static void test_mbind(int fd, size_t page_size, size_t total_size)
 {
        unsigned long nodemask = 1; /* nid: 0 */
@@ -87,7 +83,8 @@ static void test_mbind(int fd, size_t page_size, size_t total_size)
        char *mem;
        int ret;
 
-       TEST_REQUIRE_NUMA_MULTIPLE_NODES();
+       if (!is_multi_numa_node_system())
+               return;
 
        mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
        TEST_ASSERT(mem != MAP_FAILED, "mmap for mbind test should succeed");
@@ -136,7 +133,8 @@ static void test_numa_allocation(int fd, size_t page_size, size_t total_size)
        char *mem;
        int ret, i;
 
-       TEST_REQUIRE_NUMA_MULTIPLE_NODES();
+       if (!is_multi_numa_node_system())
+               return;
 
        /* Clean slate: deallocate all file space, if any */
        ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, total_size);
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 23a506d7eca3..d7051607e6bf 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -21,6 +21,7 @@
 #include <sys/eventfd.h>
 #include <sys/ioctl.h>
 
+#include <numa.h>
 #include <pthread.h>
 
 #include "kvm_util_arch.h"
@@ -633,6 +634,11 @@ static inline bool is_smt_on(void)
        return false;
 }
 
+static inline bool is_multi_numa_node_system(void)
+{
+       return numa_available() != -1 && numa_max_node() >= 1;
+}
+
 void vm_create_irqchip(struct kvm_vm *vm);
 
 static inline int __vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,

