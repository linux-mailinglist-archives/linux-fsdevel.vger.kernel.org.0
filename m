Return-Path: <linux-fsdevel+bounces-2028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2257E1532
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 17:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413C21C20993
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02DB171DC;
	Sun,  5 Nov 2023 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fltI8HUf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1EB168D5
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 16:37:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E596110D4
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 08:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699202106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=spqhuF0PZGaMSdHDZ1KRxocAKbjvl7sJJnsJWiVNP2k=;
	b=fltI8HUfCAsXElWB36yYylcKfnHVz2RBks7ZtvpZrtkwS1lQhbywKWkKELK5u0D/hTR+2W
	4DUmeVFE5aAygN+dwqDZe5E08OejZwY9Go0bd9Yq8PsKUiFwwkut0T7G/LTCDWVA389rtn
	j4TWabgJlgGNsP6opR6VTKCilANflDY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-9xnWxafYO26IbHoplvKORA-1; Sun, 05 Nov 2023 11:34:58 -0500
X-MC-Unique: 9xnWxafYO26IbHoplvKORA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39603810FC1;
	Sun,  5 Nov 2023 16:34:56 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.39.192.93])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5ED902166B26;
	Sun,  5 Nov 2023 16:34:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Fuad Tabba <tabba@google.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Anish Moorthy <amoorthy@google.com>,
	David Matlack <dmatlack@google.com>,
	Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 32/34] KVM: selftests: Add basic selftest for guest_memfd()
Date: Sun,  5 Nov 2023 17:30:35 +0100
Message-ID: <20231105163040.14904-33-pbonzini@redhat.com>
In-Reply-To: <20231105163040.14904-1-pbonzini@redhat.com>
References: <20231105163040.14904-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

From: Chao Peng <chao.p.peng@linux.intel.com>

Add a selftest to verify the basic functionality of guest_memfd():

+ file descriptor created with the guest_memfd() ioctl does not allow
  read/write/mmap operations
+ file size and block size as returned from fstat are as expected
+ fallocate on the fd checks that offset/length on
  fallocate(FALLOC_FL_PUNCH_HOLE) should be page aligned
+ invalid inputs (misaligned size, invalid flags) are rejected
+ file size and inode are unique (the innocuous-sounding
  anon_inode_getfile() backs all files with a single inode...)

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20231027182217.3615211-35-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../testing/selftests/kvm/guest_memfd_test.c  | 206 ++++++++++++++++++
 2 files changed, 207 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index ecdea5e7afa8..fd3b30a4ca7b 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -134,6 +134,7 @@ TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
 TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
+TEST_GEN_PROGS_x86_64 += guest_memfd_test
 TEST_GEN_PROGS_x86_64 += guest_print_test
 TEST_GEN_PROGS_x86_64 += hardware_disable_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
new file mode 100644
index 000000000000..ea0ae7e25330
--- /dev/null
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -0,0 +1,206 @@
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
+static void test_invalid_punch_hole(int fd, size_t page_size, size_t total_size)
+{
+	struct {
+		off_t offset;
+		off_t len;
+	} testcases[] = {
+		{0, 1},
+		{0, page_size - 1},
+		{0, page_size + 1},
+
+		{1, 1},
+		{1, page_size - 1},
+		{1, page_size},
+		{1, page_size + 1},
+
+		{page_size, 1},
+		{page_size, page_size - 1},
+		{page_size, page_size + 1},
+	};
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(testcases); i++) {
+		ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
+				testcases[i].offset, testcases[i].len);
+		TEST_ASSERT(ret == -1 && errno == EINVAL,
+			    "PUNCH_HOLE with !PAGE_SIZE offset (%lx) and/or length (%lx) should fail",
+			    testcases[i].offset, testcases[i].len);
+	}
+}
+
+static void test_create_guest_memfd_invalid(struct kvm_vm *vm)
+{
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
+	for (flag = 1; flag; flag <<= 1) {
+		uint64_t bit;
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
+static void test_create_guest_memfd_multiple(struct kvm_vm *vm)
+{
+	int fd1, fd2, ret;
+	struct stat st1, st2;
+
+	fd1 = __vm_create_guest_memfd(vm, 4096, 0);
+	TEST_ASSERT(fd1 != -1, "memfd creation should succeed");
+
+	ret = fstat(fd1, &st1);
+	TEST_ASSERT(ret != -1, "memfd fstat should succeed");
+	TEST_ASSERT(st1.st_size == 4096, "memfd st_size should match requested size");
+
+	fd2 = __vm_create_guest_memfd(vm, 8192, 0);
+	TEST_ASSERT(fd2 != -1, "memfd creation should succeed");
+
+	ret = fstat(fd2, &st2);
+	TEST_ASSERT(ret != -1, "memfd fstat should succeed");
+	TEST_ASSERT(st2.st_size == 8192, "second memfd st_size should match requested size");
+
+	ret = fstat(fd1, &st1);
+	TEST_ASSERT(ret != -1, "memfd fstat should succeed");
+	TEST_ASSERT(st1.st_size == 4096, "first memfd st_size should still match requested size");
+	TEST_ASSERT(st1.st_ino != st2.st_ino, "different memfd should have different inode numbers");
+}
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
+	test_create_guest_memfd_multiple(vm);
+
+	fd = vm_create_guest_memfd(vm, total_size, 0);
+
+	test_file_read_write(fd);
+	test_mmap(fd, page_size);
+	test_file_size(fd, page_size, total_size);
+	test_fallocate(fd, page_size, total_size);
+	test_invalid_punch_hole(fd, page_size, total_size);
+
+	close(fd);
+}
-- 
2.39.1



