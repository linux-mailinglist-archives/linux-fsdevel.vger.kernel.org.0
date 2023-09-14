Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CD679F764
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 04:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbjINCBu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 22:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbjINCA0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:00:26 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96D23C2F
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59beb3a8291so3976627b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694656600; x=1695261400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=i91JvGzfQg7A4MbSmUGyo4+8+JqUux5ifD59BoUsadA=;
        b=XN95L1dXLkzuSG+hNiM+A+e7KQXKTh9khvx0jTBPuWI3JF2PPRtKZyTaYuBf3QArdV
         Ev+PHhTTBPArtqEfTTiu/BuHluUhu1+F0rMi7JsnrpcyVeefLInusgTaEO8nZhLBncnc
         ZL4iWZbS1BQMDmwvCodpQHxtpanuZLuYegsAY1glYt1Oo6icVhwjdNjVpIhb1iGw96e6
         9XHWppHr9cvjiq24xl8CAxx46HEIH7FkuMUMX/ThCPAhbhIdOci92sudIHsZ2JHxJnOn
         3sy2EdJwrQJA9yRbaEbaUDUEV/EEDFBNdL6UYBuNnJk7VPelfPD5s1rrC+hno80eDgFP
         oBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656600; x=1695261400;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i91JvGzfQg7A4MbSmUGyo4+8+JqUux5ifD59BoUsadA=;
        b=v3MyWMndEhmM+s5bOS4t4EuzWqHxrS6uh14w8N3vCxHTZFGwTlrVHeDfO70gerKkrg
         zzTi2rg3mxuErGjeZuQ0fcN/F+wmx60j0QmpaQE2GXKq/xnYiNwR5L/+xFstI+2YNnAi
         QvTkE8eb9KlTL5Wic54RJwNYL1WfsPC2stLWGJh3SqE3tIUmuDgjJ6KjHs+92NqW8ol2
         3RYE46zSlsE3V+/9R7b5i22EGULcMfXTtjpFpqW62kFTavOPr+jURham0n9i8aZicoIp
         H72p2CNElsTkZB/6FevMT5fjItToD6X8XYAhCzogCbKVOP5gRYBsDIWd/A6WVuMxo5N8
         WNGg==
X-Gm-Message-State: AOJu0Yzu6qbT8muI8LKnC3ZQWkzrC5NVdBzqoKPMOJjPv72HieOcg1Nf
        kzyiFYwhnUNLSuwcCP533TyWmhsM2fI=
X-Google-Smtp-Source: AGHT+IEvLzTJgrzr2NLiV8Z9En5+JUJxc1EswgYLaEL3Jr6eWhED9/CQgA0jS1j6Htu+3uQxxbNwCvj4oqA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:400c:0:b0:589:a855:7af with SMTP id
 l12-20020a81400c000000b00589a85507afmr107432ywn.7.1694656599914; Wed, 13 Sep
 2023 18:56:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:55:30 -0700
In-Reply-To: <20230914015531.1419405-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230914015531.1419405-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914015531.1419405-33-seanjc@google.com>
Subject: [RFC PATCH v12 32/33] KVM: selftests: Add basic selftest for guest_memfd()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chao Peng <chao.p.peng@linux.intel.com>

Add a selftest to verify the basic functionality of guest_memfd():

+ file descriptor created with the guest_memfd() ioctl does not allow
  read/write/mmap operations
+ file size and block size as returned from fstat are as expected
+ fallocate on the fd checks that offset/length on
  fallocate(FALLOC_FL_PUNCH_HOLE) should be page aligned
+ invalid inputs (misaligned size, invalid flags) are rejected

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../testing/selftests/kvm/guest_memfd_test.c  | 165 ++++++++++++++++++
 2 files changed, 166 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index b709a52d5cdb..2b1ef809d73a 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -124,6 +124,7 @@ TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
 TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
+TEST_GEN_PROGS_x86_64 += guest_memfd_test
 TEST_GEN_PROGS_x86_64 += guest_print_test
 TEST_GEN_PROGS_x86_64 += hardware_disable_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
new file mode 100644
index 000000000000..75073645aaa1
--- /dev/null
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright Intel Corporation, 2023
+ *
+ * Author: Chao Peng <chao.p.peng@linux.intel.com>
+ */
+
+#define _GNU_SOURCE
+#include "test_util.h"
+#include "kvm_util_base.h"
+#include <linux/bitmap.h>
+#include <linux/falloc.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+#include <fcntl.h>
+
+static void test_file_read_write(int fd)
+{
+	char buf[64];
+
+	TEST_ASSERT(read(fd, buf, sizeof(buf)) < 0,
+		    "read on a guest_mem fd should fail");
+	TEST_ASSERT(write(fd, buf, sizeof(buf)) < 0,
+		    "write on a guest_mem fd should fail");
+	TEST_ASSERT(pread(fd, buf, sizeof(buf), 0) < 0,
+		    "pread on a guest_mem fd should fail");
+	TEST_ASSERT(pwrite(fd, buf, sizeof(buf), 0) < 0,
+		    "pwrite on a guest_mem fd should fail");
+}
+
+static void test_mmap(int fd, size_t page_size)
+{
+	char *mem;
+
+	mem = mmap(NULL, page_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	TEST_ASSERT_EQ(mem, MAP_FAILED);
+}
+
+static void test_file_size(int fd, size_t page_size, size_t total_size)
+{
+	struct stat sb;
+	int ret;
+
+	ret = fstat(fd, &sb);
+	TEST_ASSERT(!ret, "fstat should succeed");
+	TEST_ASSERT_EQ(sb.st_size, total_size);
+	TEST_ASSERT_EQ(sb.st_blksize, page_size);
+}
+
+static void test_fallocate(int fd, size_t page_size, size_t total_size)
+{
+	int ret;
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, 0, total_size);
+	TEST_ASSERT(!ret, "fallocate with aligned offset and size should succeed");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
+			page_size - 1, page_size);
+	TEST_ASSERT(ret, "fallocate with unaligned offset should fail");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, total_size, page_size);
+	TEST_ASSERT(ret, "fallocate beginning at total_size should fail");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, total_size + page_size, page_size);
+	TEST_ASSERT(ret, "fallocate beginning after total_size should fail");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
+			total_size, page_size);
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) at total_size should succeed");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
+			total_size + page_size, page_size);
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) after total_size should succeed");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
+			page_size, page_size - 1);
+	TEST_ASSERT(ret, "fallocate with unaligned size should fail");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
+			page_size, page_size);
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) with aligned offset and size should succeed");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, page_size, page_size);
+	TEST_ASSERT(!ret, "fallocate to restore punched hole should succeed");
+}
+
+static void test_create_guest_memfd_invalid(struct kvm_vm *vm)
+{
+	uint64_t valid_flags = 0;
+	size_t page_size = getpagesize();
+	uint64_t flag;
+	size_t size;
+	int fd;
+
+	for (size = 1; size < page_size; size++) {
+		fd = __vm_create_guest_memfd(vm, size, 0);
+		TEST_ASSERT(fd == -1 && errno == EINVAL,
+			    "guest_memfd() with non-page-aligned page size '0x%lx' should fail with EINVAL",
+			    size);
+	}
+
+	if (thp_configured()) {
+		for (size = page_size * 2; size < get_trans_hugepagesz(); size += page_size) {
+			fd = __vm_create_guest_memfd(vm, size, KVM_GUEST_MEMFD_ALLOW_HUGEPAGE);
+			TEST_ASSERT(fd == -1 && errno == EINVAL,
+				    "guest_memfd() with non-hugepage-aligned page size '0x%lx' should fail with EINVAL",
+				    size);
+		}
+
+		valid_flags = KVM_GUEST_MEMFD_ALLOW_HUGEPAGE;
+	}
+
+	for (flag = 1; flag; flag <<= 1) {
+		uint64_t bit;
+
+		if (flag & valid_flags)
+			continue;
+
+		fd = __vm_create_guest_memfd(vm, page_size, flag);
+		TEST_ASSERT(fd == -1 && errno == EINVAL,
+			    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
+			    flag);
+
+		for_each_set_bit(bit, &valid_flags, 64) {
+			fd = __vm_create_guest_memfd(vm, page_size, flag | BIT_ULL(bit));
+			TEST_ASSERT(fd == -1 && errno == EINVAL,
+				    "guest_memfd() with flags '0x%llx' should fail with EINVAL",
+				    flag | BIT_ULL(bit));
+		}
+	}
+}
+
+
+int main(int argc, char *argv[])
+{
+	size_t page_size;
+	size_t total_size;
+	int fd;
+	struct kvm_vm *vm;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_GUEST_MEMFD));
+
+	page_size = getpagesize();
+	total_size = page_size * 4;
+
+	vm = vm_create_barebones();
+
+	test_create_guest_memfd_invalid(vm);
+
+	fd = vm_create_guest_memfd(vm, total_size, 0);
+
+	test_file_read_write(fd);
+	test_mmap(fd, page_size);
+	test_file_size(fd, page_size, total_size);
+	test_fallocate(fd, page_size, total_size);
+
+	close(fd);
+}
-- 
2.42.0.283.g2d96d420d3-goog

