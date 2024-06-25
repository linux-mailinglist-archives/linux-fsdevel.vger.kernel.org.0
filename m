Return-Path: <linux-fsdevel+bounces-22453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5F691744E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 00:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395A41F23A2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 22:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D9E17D88C;
	Tue, 25 Jun 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gysGch8L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB6F17FAC1
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719354907; cv=none; b=GTJCKTqDC5zfNOq9QgG3XU4LaQp9lEBnV0TvrgGn0sGhr/XeaNnmWDjv/kEimptiX6mGLfbwItLNgg95h6VKid9/XTqZqx2rnEVwAFGf4CaIlQS5Qa80p+t4P5P8/H0o4kytkenNlmPH7IoeM7piYO0IUUeyjWP5ibwCAu4ghfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719354907; c=relaxed/simple;
	bh=Nz14t21hcHX1PDz4gX9brGggz6D63/l/IGgEClEx/P4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ie+8ItsSUo6oQQath/cZQh9wwOHNwU1odBHUHN5EE726R6EW1xyLLrKmz8cSU3CRSeFQw8b02zUUeAi2AbCQXmQwnIwCG8336KpH2mJnBGnGMfg8V9JT+HyveQysf5DKStAAs/u5JhGQjybIy+ZNjGJaqmO3GXvoq664vlFhP2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gysGch8L; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62d032a07a9so128548147b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 15:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719354905; x=1719959705; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=87Jin1neXman428FZaPVpz5vAZT4i6hdnDg6P39Dvmk=;
        b=gysGch8Lr+ZJ8ZK1ZKAjLss5CfsUDUxdga3ngMC9+qrw+gD0rZ48JCU4hceJu9FJDz
         84yiSLkRkGlpchiV8Nix4CBJSWAvLb2rxB4tnVNo++7Ftz8rSEGUwrOPx6DTjAMxjjh2
         9bmcyZMWIG+xG8YzDFvmp+kr3xORJzdP54pKgQ8hLFhSj37DsGmfH/SrSXxBOrKQemAA
         KAHntA4RXke433RupEuwlbUGe1Ovt3WhIEaoy6vpzJoeQB2/wZQhsmdCDWr/n0h6Ufqq
         nqL2DzL+XOjyTN43rcbRSXn8V4IQP9zMEFbiRTbb7XRocjs7EKTkpMO5kuVw86H/tezz
         dQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719354905; x=1719959705;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87Jin1neXman428FZaPVpz5vAZT4i6hdnDg6P39Dvmk=;
        b=jyOno85ogq686cR7ln03PfVQv90ymecoPhzCdacdB3w+cckVZMTKgJbFLTftQq7Kyz
         6svqhBPtyRBCb8nXI49Jcs8DKUoLSyPnAxjHDZ+zXqOT0P/mj6zoxgWvMMOD9UsAS1vv
         q9VOsAJrojczRypXxrtHOSW4xJsSDlXOhTqhHn9syTfDoFehs2UNNDQd93vBLx9AXW+q
         gRIufDvwChXft+IyH2JKuyVWcbl2KmEX/bw+mFwLqbbGILK4ILwiFXOqLa8+jpaAEJv1
         JKjvD+WhMloRMCgOXDQN0WfjlhfFfIFS72leZy1NDR4sYlYtijuhdOCGitv/W4NwdCI4
         9H9g==
X-Forwarded-Encrypted: i=1; AJvYcCVVw25kn040LPlyP5LBwB3n0cSpKUGh1rZW1huYa7N7fbyLizWt/hJRe1PPJqztXotHdEHzCVPa9vkQIc+uiShyHsWqalvtWRiYuZWd+w==
X-Gm-Message-State: AOJu0YyqHcn+JMx3/2BQP3RK3JquxBskgutukD1Dck9lLc2x0/0L/xMF
	cdpG1lsXkC5L8EtmmInc4ndYaWTC+uM/dpTbuNXu4bi7RivTp8bGVsI6wDXTfodlflCKuAOPBrs
	QSA==
X-Google-Smtp-Source: AGHT+IEGuPw81A+vd3VK4UXWXuPsSlJshJybw2PugwKr4mE141Kgqb4D3k0bZmkq8unTm2UAe55tWdXFj6o=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:6112:b0:61c:89a4:dd5f with SMTP id
 00721157ae682-643a76e6dd7mr1219237b3.0.1719354904824; Tue, 25 Jun 2024
 15:35:04 -0700 (PDT)
Date: Tue, 25 Jun 2024 22:34:45 +0000
In-Reply-To: <20240625223454.1586259-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625223454.1586259-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240625223454.1586259-2-edliaw@google.com>
Subject: [PATCH v7 1/1] selftests: Centralize -D_GNU_SOURCE= to CFLAGS in lib.mk
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, usama.anjum@collabora.com, seanjc@google.com, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sgx@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Centralize the _GNU_SOURCE definition to CFLAGS in lib.mk.  Remove
redundant defines from Makefiles that import lib.mk.  Convert any usage
of "#define _GNU_SOURCE 1" to "#define _GNU_SOURCE".

This uses the form "-D_GNU_SOURCE=", which is equivalent to
"#define _GNU_SOURCE".

Otherwise using "-D_GNU_SOURCE" is equivalent to "-D_GNU_SOURCE=1" and
"#define _GNU_SOURCE 1", which is less commonly seen in source code and
would require many changes in selftests to avoid redefinition warnings.

Suggested-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/exec/Makefile             | 1 -
 tools/testing/selftests/futex/functional/Makefile | 2 +-
 tools/testing/selftests/intel_pstate/Makefile     | 2 +-
 tools/testing/selftests/iommu/Makefile            | 2 --
 tools/testing/selftests/kvm/Makefile              | 2 +-
 tools/testing/selftests/lib.mk                    | 3 +++
 tools/testing/selftests/mm/thuge-gen.c            | 2 +-
 tools/testing/selftests/net/Makefile              | 2 +-
 tools/testing/selftests/net/tcp_ao/Makefile       | 2 +-
 tools/testing/selftests/proc/Makefile             | 1 -
 tools/testing/selftests/resctrl/Makefile          | 2 +-
 tools/testing/selftests/ring-buffer/Makefile      | 1 -
 tools/testing/selftests/riscv/mm/Makefile         | 2 +-
 tools/testing/selftests/sgx/Makefile              | 2 +-
 tools/testing/selftests/tmpfs/Makefile            | 1 -
 15 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index ab67d58cfab7..ba012bc5aab9 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
-CFLAGS += -D_GNU_SOURCE
 
 ALIGNS := 0x1000 0x200000 0x1000000
 ALIGN_PIES        := $(patsubst %,load_address.%,$(ALIGNS))
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 994fa3468f17..f79f9bac7918 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE= -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS := -lpthread -lrt
 
 LOCAL_HDRS := \
diff --git a/tools/testing/selftests/intel_pstate/Makefile b/tools/testing/selftests/intel_pstate/Makefile
index 05d66ef50c97..f45372cb00fe 100644
--- a/tools/testing/selftests/intel_pstate/Makefile
+++ b/tools/testing/selftests/intel_pstate/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS := $(CFLAGS) -Wall -D_GNU_SOURCE
+CFLAGS := $(CFLAGS) -Wall
 LDLIBS += -lm
 
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index 32c5fdfd0eef..fd6477911f24 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -2,8 +2,6 @@
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += $(KHDR_INCLUDES)
 
-CFLAGS += -D_GNU_SOURCE
-
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += iommufd
 TEST_GEN_PROGS += iommufd_fail_nth
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index ac280dcba996..4ee37abf70ff 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -231,7 +231,7 @@ LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-Wno-gnu-variable-sized-type-not-at-end -MD -MP -DCONFIG_64BIT \
-	-D_GNU_SOURCE -fno-builtin-memcmp -fno-builtin-memcpy \
+	-fno-builtin-memcmp -fno-builtin-memcpy \
 	-fno-builtin-memset -fno-builtin-strnlen \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 7b299ed5ff45..d6edcfcb5be8 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -196,6 +196,9 @@ endef
 clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 	$(CLEAN)
 
+# Build with _GNU_SOURCE by default
+CFLAGS += -D_GNU_SOURCE=
+
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
 # make USERCFLAGS=-Werror USERLDFLAGS=-static
 CFLAGS += $(USERCFLAGS)
diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index d50dc71cac32..e4370b79b62f 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -13,7 +13,7 @@
    sudo ipcs | awk '$1 == "0x00000000" {print $2}' | xargs -n1 sudo ipcrm -m
    (warning this will remove all if someone else uses them) */
 
-#define _GNU_SOURCE 1
+#define _GNU_SOURCE
 #include <sys/mman.h>
 #include <linux/mman.h>
 #include <stdlib.h>
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index bc3925200637..8eaffd7a641c 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for net selftests
 
-CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
+CFLAGS +=  -Wall -Wl,--no-as-needed -O2 -g
 CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
 # Additional include paths needed by kselftest.h
 CFLAGS += -I../
diff --git a/tools/testing/selftests/net/tcp_ao/Makefile b/tools/testing/selftests/net/tcp_ao/Makefile
index 522d991e310e..bd88b90b902b 100644
--- a/tools/testing/selftests/net/tcp_ao/Makefile
+++ b/tools/testing/selftests/net/tcp_ao/Makefile
@@ -26,7 +26,7 @@ LIB	:= $(LIBDIR)/libaotst.a
 LDLIBS	+= $(LIB) -pthread
 LIBDEPS	:= lib/aolib.h Makefile
 
-CFLAGS	:= -Wall -O2 -g -D_GNU_SOURCE -fno-strict-aliasing
+CFLAGS	+= -Wall -O2 -g -fno-strict-aliasing
 CFLAGS	+= $(KHDR_INCLUDES)
 CFLAGS	+= -iquote ./lib/ -I ../../../../include/
 
diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index 6066f607f758..ee424a9f075f 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += -D_GNU_SOURCE
 LDFLAGS += -pthread
 
 TEST_GEN_PROGS :=
diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 021863f86053..f408bd6bfc3d 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE
+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
diff --git a/tools/testing/selftests/ring-buffer/Makefile b/tools/testing/selftests/ring-buffer/Makefile
index 627c5fa6d1ab..23605782639e 100644
--- a/tools/testing/selftests/ring-buffer/Makefile
+++ b/tools/testing/selftests/ring-buffer/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -Wl,-no-as-needed -Wall
 CFLAGS += $(KHDR_INCLUDES)
-CFLAGS += -D_GNU_SOURCE
 
 TEST_GEN_PROGS = map_test
 
diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
index c333263f2b27..4664ed79e20b 100644
--- a/tools/testing/selftests/riscv/mm/Makefile
+++ b/tools/testing/selftests/riscv/mm/Makefile
@@ -3,7 +3,7 @@
 # Originally tools/testing/arm64/abi/Makefile
 
 # Additional include paths needed by kselftest.h and local headers
-CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+CFLAGS += -std=gnu99 -I.
 
 TEST_GEN_FILES := mmap_default mmap_bottomup
 
diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 867f88ce2570..03b5e13b872b 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -12,7 +12,7 @@ OBJCOPY := $(CROSS_COMPILE)objcopy
 endif
 
 INCLUDES := -I$(top_srcdir)/tools/include
-HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC
+HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC $(CFLAGS)
 HOST_LDFLAGS := -z noexecstack -lcrypto
 ENCL_CFLAGS += -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
diff --git a/tools/testing/selftests/tmpfs/Makefile b/tools/testing/selftests/tmpfs/Makefile
index aa11ccc92e5b..3be931e1193f 100644
--- a/tools/testing/selftests/tmpfs/Makefile
+++ b/tools/testing/selftests/tmpfs/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2
-CFLAGS += -D_GNU_SOURCE
 
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += bug-link-o-tmpfile
-- 
2.45.2.803.g4e1b14247a-goog


