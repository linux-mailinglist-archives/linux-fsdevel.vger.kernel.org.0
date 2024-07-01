Return-Path: <linux-fsdevel+bounces-22845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDA491D7F2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 08:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379401F21642
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 06:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE675464A;
	Mon,  1 Jul 2024 06:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RP6AD1v+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4452231C;
	Mon,  1 Jul 2024 06:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719814535; cv=none; b=BgtsCZ93vqLd0hAvZ4LslF2FS/p1jQ+WBFyG3nBFyUw2fzx7JjgQi5gw58BTkrs5702sDssOQcT/NWUIbEL4ej9tZ1TUNDrHfjLVxiPaii3kkn07n+4u+KNcXAYgvDeu9TsF9xE9tls09Adw1vWHOOUCNcV03XKv1/Q3MYq90uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719814535; c=relaxed/simple;
	bh=WmI09JaExLOgwIiAfkIPKvdePbKWzCZg6yL6VDCaUN4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=izu1CEz78RJoT4Rvy4JoVmrEvOCnpIW3YKKPEzFMDXlQV9OpLejtaMNMWSYFWh1cBXWaOJ3p54RUDJhje45ylFtYhUtNdq4x/EV51VjlV7oJuTi1CY480QZx+hSuhHarSrt/+JgS36nRbk9MjhOChojmhSVDDRSblcY/JYAo/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RP6AD1v+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719814532;
	bh=WmI09JaExLOgwIiAfkIPKvdePbKWzCZg6yL6VDCaUN4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=RP6AD1v+j6bPzkD4Qfi/D0Q58GhtnnMPgGqhmQ9YGJX9Jc/5j84eJ7xUBdHZJRzFx
	 aXPXn39mJWbIX+hF2Rx6HPtqgMK4vfUXHqti+IbFCO5Q8bGEOYciAZVbAvxI1kGzeR
	 g0TD5c0QDnRR5cYZ0bk02V6Iz6eS/b5EgMh95woV6SkktOdHJgXgDkEDcqIbeyMewD
	 TfpEAsVSV82X6VPFFcT0pA4AfIytfyCqe6TFWaYlNmT4kY7j1t72YZQc6kzGiHWxze
	 VlPaDaj3j6O+JFwu31mdPgmr5u8MzDcUXIrceg69E0CyvjyMCcC0aTq021O4QEtL3Z
	 exwCDx8GCLtyg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AA10E3782065;
	Mon,  1 Jul 2024 06:15:00 +0000 (UTC)
Message-ID: <221495d5-1be2-4c71-ab2f-eb145257737a@collabora.com>
Date: Mon, 1 Jul 2024 11:14:54 +0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kernel@vger.kernel.org, seanjc@google.com, kernel-team@android.com,
 linux-mm@kvack.org, iommu@lists.linux.dev, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-sgx@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v7 1/1] selftests: Centralize -D_GNU_SOURCE= to CFLAGS in
 lib.mk
To: Edward Liaw <edliaw@google.com>, linux-kselftest@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20240625223454.1586259-1-edliaw@google.com>
 <20240625223454.1586259-2-edliaw@google.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240625223454.1586259-2-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/24 3:34 AM, Edward Liaw wrote:
> Centralize the _GNU_SOURCE definition to CFLAGS in lib.mk.  Remove
> redundant defines from Makefiles that import lib.mk.  Convert any usage
> of "#define _GNU_SOURCE 1" to "#define _GNU_SOURCE".
> 
> This uses the form "-D_GNU_SOURCE=", which is equivalent to
> "#define _GNU_SOURCE".
> 
> Otherwise using "-D_GNU_SOURCE" is equivalent to "-D_GNU_SOURCE=1" and
> "#define _GNU_SOURCE 1", which is less commonly seen in source code and
> would require many changes in selftests to avoid redefinition warnings.
> 
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Edward Liaw <edliaw@google.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/exec/Makefile             | 1 -
>  tools/testing/selftests/futex/functional/Makefile | 2 +-
>  tools/testing/selftests/intel_pstate/Makefile     | 2 +-
>  tools/testing/selftests/iommu/Makefile            | 2 --
>  tools/testing/selftests/kvm/Makefile              | 2 +-
>  tools/testing/selftests/lib.mk                    | 3 +++
>  tools/testing/selftests/mm/thuge-gen.c            | 2 +-
>  tools/testing/selftests/net/Makefile              | 2 +-
>  tools/testing/selftests/net/tcp_ao/Makefile       | 2 +-
>  tools/testing/selftests/proc/Makefile             | 1 -
>  tools/testing/selftests/resctrl/Makefile          | 2 +-
>  tools/testing/selftests/ring-buffer/Makefile      | 1 -
>  tools/testing/selftests/riscv/mm/Makefile         | 2 +-
>  tools/testing/selftests/sgx/Makefile              | 2 +-
>  tools/testing/selftests/tmpfs/Makefile            | 1 -
>  15 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
> index ab67d58cfab7..ba012bc5aab9 100644
> --- a/tools/testing/selftests/exec/Makefile
> +++ b/tools/testing/selftests/exec/Makefile
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  CFLAGS = -Wall
>  CFLAGS += -Wno-nonnull
> -CFLAGS += -D_GNU_SOURCE
>  
>  ALIGNS := 0x1000 0x200000 0x1000000
>  ALIGN_PIES        := $(patsubst %,load_address.%,$(ALIGNS))
> diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
> index 994fa3468f17..f79f9bac7918 100644
> --- a/tools/testing/selftests/futex/functional/Makefile
> +++ b/tools/testing/selftests/futex/functional/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
> -CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE= -pthread $(INCLUDES) $(KHDR_INCLUDES)
> +CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
>  LDLIBS := -lpthread -lrt
>  
>  LOCAL_HDRS := \
> diff --git a/tools/testing/selftests/intel_pstate/Makefile b/tools/testing/selftests/intel_pstate/Makefile
> index 05d66ef50c97..f45372cb00fe 100644
> --- a/tools/testing/selftests/intel_pstate/Makefile
> +++ b/tools/testing/selftests/intel_pstate/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -CFLAGS := $(CFLAGS) -Wall -D_GNU_SOURCE
> +CFLAGS := $(CFLAGS) -Wall
>  LDLIBS += -lm
>  
>  ARCH ?= $(shell uname -m 2>/dev/null || echo not)
> diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
> index 32c5fdfd0eef..fd6477911f24 100644
> --- a/tools/testing/selftests/iommu/Makefile
> +++ b/tools/testing/selftests/iommu/Makefile
> @@ -2,8 +2,6 @@
>  CFLAGS += -Wall -O2 -Wno-unused-function
>  CFLAGS += $(KHDR_INCLUDES)
>  
> -CFLAGS += -D_GNU_SOURCE
> -
>  TEST_GEN_PROGS :=
>  TEST_GEN_PROGS += iommufd
>  TEST_GEN_PROGS += iommufd_fail_nth
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index ac280dcba996..4ee37abf70ff 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -231,7 +231,7 @@ LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
>  endif
>  CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
>  	-Wno-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT \
> -	-D_GNU_SOURCE -fno-builtin-memcmp -fno-builtin-memcpy \
> +	-fno-builtin-memcmp -fno-builtin-memcpy \
>  	-fno-builtin-memset -fno-builtin-strnlen \
>  	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
>  	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 7b299ed5ff45..d6edcfcb5be8 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -196,6 +196,9 @@ endef
>  clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
>  	$(CLEAN)
>  
> +# Build with _GNU_SOURCE by default
> +CFLAGS += -D_GNU_SOURCE=
> +
>  # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
>  # make USERCFLAGS=-Werror USERLDFLAGS=-static
>  CFLAGS += $(USERCFLAGS)
> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
> index d50dc71cac32..e4370b79b62f 100644
> --- a/tools/testing/selftests/mm/thuge-gen.c
> +++ b/tools/testing/selftests/mm/thuge-gen.c
> @@ -13,7 +13,7 @@
>     sudo ipcs | awk '$1 == "0x00000000" {print $2}' | xargs -n1 sudo ipcrm -m
>     (warning this will remove all if someone else uses them) */
>  
> -#define _GNU_SOURCE 1
> +#define _GNU_SOURCE
>  #include <sys/mman.h>
>  #include <linux/mman.h>
>  #include <stdlib.h>
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index bc3925200637..8eaffd7a641c 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for net selftests
>  
> -CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
> +CFLAGS +=  -Wall -Wl,--no-as-needed -O2 -g
>  CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
>  # Additional include paths needed by kselftest.h
>  CFLAGS += -I../
> diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
> index 522d991e310e..bd88b90b902b 100644
> --- a/tools/testing/selftests/net/tcp_ao/Makefile
> +++ b/tools/testing/selftests/net/tcp_ao/Makefile
> @@ -26,7 +26,7 @@ LIB	:= $(LIBDIR)/libaotst.a
>  LDLIBS	+= $(LIB) -pthread
>  LIBDEPS	:= lib/aolib.h Makefile
>  
> -CFLAGS	:= -Wall -O2 -g -D_GNU_SOURCE -fno-strict-aliasing
> +CFLAGS	+= -Wall -O2 -g -fno-strict-aliasing
>  CFLAGS	+= $(KHDR_INCLUDES)
>  CFLAGS	+= -iquote ./lib/ -I ../../../../include/
>  
> diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
> index 6066f607f758..ee424a9f075f 100644
> --- a/tools/testing/selftests/proc/Makefile
> +++ b/tools/testing/selftests/proc/Makefile
> @@ -1,6 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  CFLAGS += -Wall -O2 -Wno-unused-function
> -CFLAGS += -D_GNU_SOURCE
>  LDFLAGS += -pthread
>  
>  TEST_GEN_PROGS :=
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index 021863f86053..f408bd6bfc3d 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE
> +CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
>  CFLAGS += $(KHDR_INCLUDES)
>  
>  TEST_GEN_PROGS := resctrl_tests
> diff --git a/tools/testing/selftests/ring-buffer/Makefile b/tools/testing/selftests/ring-buffer/Makefile
> index 627c5fa6d1ab..23605782639e 100644
> --- a/tools/testing/selftests/ring-buffer/Makefile
> +++ b/tools/testing/selftests/ring-buffer/Makefile
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  CFLAGS += -Wl,-no-as-needed -Wall
>  CFLAGS += $(KHDR_INCLUDES)
> -CFLAGS += -D_GNU_SOURCE
>  
>  TEST_GEN_PROGS = map_test
>  
> diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
> index c333263f2b27..4664ed79e20b 100644
> --- a/tools/testing/selftests/riscv/mm/Makefile
> +++ b/tools/testing/selftests/riscv/mm/Makefile
> @@ -3,7 +3,7 @@
>  # Originally tools/testing/arm64/abi/Makefile
>  
>  # Additional include paths needed by kselftest.h and local headers
> -CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
> +CFLAGS += -std=gnu99 -I.
>  
>  TEST_GEN_FILES := mmap_default mmap_bottomup
>  
> diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
> index 867f88ce2570..03b5e13b872b 100644
> --- a/tools/testing/selftests/sgx/Makefile
> +++ b/tools/testing/selftests/sgx/Makefile
> @@ -12,7 +12,7 @@ OBJCOPY := $(CROSS_COMPILE)objcopy
>  endif
>  
>  INCLUDES := -I$(top_srcdir)/tools/include
> -HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC
> +HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC $(CFLAGS)
>  HOST_LDFLAGS := -z noexecstack -lcrypto
>  ENCL_CFLAGS += -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE \
>  	       -fno-stack-protector -mrdrnd $(INCLUDES)
> diff --git a/tools/testing/selftests/tmpfs/Makefile b/tools/testing/selftests/tmpfs/Makefile
> index aa11ccc92e5b..3be931e1193f 100644
> --- a/tools/testing/selftests/tmpfs/Makefile
> +++ b/tools/testing/selftests/tmpfs/Makefile
> @@ -1,6 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  CFLAGS += -Wall -O2
> -CFLAGS += -D_GNU_SOURCE
>  
>  TEST_GEN_PROGS :=
>  TEST_GEN_PROGS += bug-link-o-tmpfile

-- 
BR,
Muhammad Usama Anjum

