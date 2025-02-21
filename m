Return-Path: <linux-fsdevel+bounces-42260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD65A3FAAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A947AE77E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7112321639A;
	Fri, 21 Feb 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="YUeHcL3Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5941FF7BE;
	Fri, 21 Feb 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154203; cv=none; b=LVjPJ0AjoniA1/79zubdfP6TuPBSTmhU00Y2xivEGsG4yJ9QZoSgVEAyfBjaIIKue3B6kav2dkL0qSyZq44188SAyI4wav7OP5UBReLSWSSdRXtAEp+cq2osXimX3RFxc98hvVvM5VXOZth0/+PaPwsQTmIvXXmHIeTXp8+iKiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154203; c=relaxed/simple;
	bh=VDcPMXQybEm3GGDB4UYUuW18irMxI1IXP/e4b6JOcSU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gz4h3VefFj7a8a8eGLtOsYHj+1ExaP0mZKDE4AHzlWoidh7IoIrWdHSgh4RR8q5+7VEzJtjzbCH4iXQRJpxuA93pGjNrG5+7UZHmumM1kg5ew0OJw+pB6U1ZRKjavpQSc5jwhTysbGSNlfdaVR5uL3W4jsxsF9V2eiw1RPLdjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=YUeHcL3Z; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1740154202; x=1771690202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BANXS/j3GyDpPFNip1mF1wVudzuNk8XiTmPfvkONALE=;
  b=YUeHcL3Zfp0aOYuABAEMvX/A90effDNCwcKIcnbescQCmIT5FD6QUCLt
   jQz7zJbvQlwl3RJU0Lu7kUNFri+7hpii2o7gUFkfDdLT71Y1RXTj2vdOs
   4QQIcQbEANkP6OysoykpJ0Yi88AlqpCxnwIQzgi2SU3BFPmiY/btOZyKr
   E=;
X-IronPort-AV: E=Sophos;i="6.13,305,1732579200"; 
   d="scan'208";a="174721379"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 16:09:57 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:2561]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.102:2525] with esmtp (Farcaster)
 id 637de5e4-6bbf-4399-b51a-8701d5206b05; Fri, 21 Feb 2025 16:09:56 +0000 (UTC)
X-Farcaster-Flow-ID: 637de5e4-6bbf-4399-b51a-8701d5206b05
Received: from EX19D015EUB001.ant.amazon.com (10.252.51.114) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 16:09:53 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D015EUB001.ant.amazon.com (10.252.51.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 16:09:52 +0000
Received: from email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Fri, 21 Feb 2025 16:09:52 +0000
Received: from ua2d7e1a6107c5b.ant.amazon.com (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com (Postfix) with ESMTPS id A16AF404C9;
	Fri, 21 Feb 2025 16:09:44 +0000 (UTC)
From: Patrick Roy <roypat@amazon.co.uk>
To: <rppt@kernel.org>, <david@redhat.com>, <seanjc@google.com>
CC: Patrick Roy <roypat@amazon.co.uk>, <pbonzini@redhat.com>,
	<corbet@lwn.net>, <willy@infradead.org>, <akpm@linux-foundation.org>,
	<song@kernel.org>, <jolsa@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<eddyz87@gmail.com>, <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
	<kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
	<Liam.Howlett@oracle.com>, <lorenzo.stoakes@oracle.com>, <vbabka@suse.cz>,
	<jannh@google.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <tabba@google.com>, <jgowans@amazon.com>,
	<graf@amazon.com>, <kalyazin@amazon.com>, <xmarcalx@amazon.com>,
	<derekmn@amazon.com>, <jthoughton@google.com>
Subject: [PATCH v4 06/12] KVM: selftests: load elf via bounce buffer
Date: Fri, 21 Feb 2025 16:07:19 +0000
Message-ID: <20250221160728.1584559-7-roypat@amazon.co.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221160728.1584559-1-roypat@amazon.co.uk>
References: <20250221160728.1584559-1-roypat@amazon.co.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

If guest memory is backed using a VMA that does not allow GUP (e.g. a
userspace mapping of guest_memfd when the fd was allocated using
KVM_GMEM_NO_DIRECT_MAP), then directly loading the test ELF binary into
it via read(2) potentially does not work. To nevertheless support
loading binaries in this cases, do the read(2) syscall using a bounce
buffer, and then memcpy from the bounce buffer into guest memory.

Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 .../testing/selftests/kvm/include/test_util.h |  1 +
 tools/testing/selftests/kvm/lib/elf.c         |  8 +++----
 tools/testing/selftests/kvm/lib/io.c          | 23 +++++++++++++++++++
 3 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 3e473058849f..51f34c34b5a2 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -46,6 +46,7 @@ do {								\
 
 ssize_t test_write(int fd, const void *buf, size_t count);
 ssize_t test_read(int fd, void *buf, size_t count);
+ssize_t test_read_bounce(int fd, void *buf, size_t count);
 int test_seq_read(const char *path, char **bufp, size_t *sizep);
 
 void __printf(5, 6) test_assert(bool exp, const char *exp_str,
diff --git a/tools/testing/selftests/kvm/lib/elf.c b/tools/testing/selftests/kvm/lib/elf.c
index f34d926d9735..e829fbe0a11e 100644
--- a/tools/testing/selftests/kvm/lib/elf.c
+++ b/tools/testing/selftests/kvm/lib/elf.c
@@ -31,7 +31,7 @@ static void elfhdr_get(const char *filename, Elf64_Ehdr *hdrp)
 	 * the real size of the ELF header.
 	 */
 	unsigned char ident[EI_NIDENT];
-	test_read(fd, ident, sizeof(ident));
+	test_read_bounce(fd, ident, sizeof(ident));
 	TEST_ASSERT((ident[EI_MAG0] == ELFMAG0) && (ident[EI_MAG1] == ELFMAG1)
 		&& (ident[EI_MAG2] == ELFMAG2) && (ident[EI_MAG3] == ELFMAG3),
 		"ELF MAGIC Mismatch,\n"
@@ -79,7 +79,7 @@ static void elfhdr_get(const char *filename, Elf64_Ehdr *hdrp)
 	offset_rv = lseek(fd, 0, SEEK_SET);
 	TEST_ASSERT(offset_rv == 0, "Seek to ELF header failed,\n"
 		"  rv: %zi expected: %i", offset_rv, 0);
-	test_read(fd, hdrp, sizeof(*hdrp));
+	test_read_bounce(fd, hdrp, sizeof(*hdrp));
 	TEST_ASSERT(hdrp->e_phentsize == sizeof(Elf64_Phdr),
 		"Unexpected physical header size,\n"
 		"  hdrp->e_phentsize: %x\n"
@@ -146,7 +146,7 @@ void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename)
 
 		/* Read in the program header. */
 		Elf64_Phdr phdr;
-		test_read(fd, &phdr, sizeof(phdr));
+		test_read_bounce(fd, &phdr, sizeof(phdr));
 
 		/* Skip if this header doesn't describe a loadable segment. */
 		if (phdr.p_type != PT_LOAD)
@@ -187,7 +187,7 @@ void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename)
 				"  expected: 0x%jx",
 				n1, errno, (intmax_t) offset_rv,
 				(intmax_t) phdr.p_offset);
-			test_read(fd, addr_gva2hva(vm, phdr.p_vaddr),
+			test_read_bounce(fd, addr_gva2hva(vm, phdr.p_vaddr),
 				phdr.p_filesz);
 		}
 	}
diff --git a/tools/testing/selftests/kvm/lib/io.c b/tools/testing/selftests/kvm/lib/io.c
index fedb2a741f0b..a89b43cc2ebc 100644
--- a/tools/testing/selftests/kvm/lib/io.c
+++ b/tools/testing/selftests/kvm/lib/io.c
@@ -155,3 +155,26 @@ ssize_t test_read(int fd, void *buf, size_t count)
 
 	return num_read;
 }
+
+/* Test read via intermediary buffer
+ *
+ * Same as test_read, except read(2)s happen into a bounce buffer that is memcpy'd
+ * to buf. For use with buffers that cannot be GUP'd (e.g. guest_memfd VMAs if
+ * guest_memfd was allocated with KVM_GMEM_NO_DIRECT_MAP).
+ */
+ssize_t test_read_bounce(int fd, void *buf, size_t count)
+{
+	void *bounce_buffer;
+	ssize_t num_read;
+
+	TEST_ASSERT(count >= 0, "Unexpected count, count: %li", count);
+
+	bounce_buffer = malloc(count);
+	TEST_ASSERT(bounce_buffer != NULL, "Failed to allocate bounce buffer");
+
+	num_read = test_read(fd, bounce_buffer, count);
+	memcpy(buf, bounce_buffer, num_read);
+	free(bounce_buffer);
+
+	return num_read;
+}
-- 
2.48.1


