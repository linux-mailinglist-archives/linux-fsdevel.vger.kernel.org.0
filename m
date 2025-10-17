Return-Path: <linux-fsdevel+bounces-64539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 329A4BEB944
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 22:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E22D84FB3BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 20:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEF03491F1;
	Fri, 17 Oct 2025 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1KKq25H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEB13446CB
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732001; cv=none; b=EDE3e0QLjJgBE0DxT0yUtd7NlfTZsAoZceb+FA84jnZcjGBTDwc8UnEal51fu9kO+tU43iMJwpKOUpi6rOkAL9M7nrwBHhPN7J0eextVf8qbInH6+rtTwxSEwhve6018TQWc3TtHNPpqXxqa74J0c9NxmsyVFz/84L6Wj78rWo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732001; c=relaxed/simple;
	bh=per631JY4Gz7eV84rzXzYabz2IMo+T2NHK7hd8tMJDo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A+mT86EPGpeALqRux4YekolK2B+acc6vBDZrHCns6l2lKy87KZtZ8cuO0GrWvrAEEIxSRq0ILwL4UeQ+7AOD5EvJkKmh/n8NSHAFMtWf/IQM6tE71BoTmeXzWRBOLOyGRcUXF/tO5MHPKYHRtmoMRpQqYhwaFX/x+NpVRd+YXzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q1KKq25H; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-334b0876195so2500089a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 13:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731992; x=1761336792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a410UVUkGWxYqDToM9eO24m2S1wWqIP4ItBf1At6t3A=;
        b=Q1KKq25HHV66y+Pfrwsx+JwGFmUxMkMluEGIqK87iqk93CCF+WxdwJfQsoY3Karx6+
         Z2R9v9bG28VjKGZYDNblQJrwhPSz/65fR49i1eAfFs+HEBev0CnZYnYJXRYlG2yvMyvK
         443bX1+kO5lZYXC0WpkeoR64UVMV4126E+yQcY2LkGTSJDWU//98E5CPBlW4MoxBTakA
         uWCi1tJmSEOhvUPL/zmq/xLFkdazxL1GRY3eoRBDbz/jGI/2OekdS4vAS0vLiVMTH4UL
         5MeJydaISLDwA6L0vjTrmyVsc70g9N50yqFXCZ+zYm0OaPJ4kOT4rvmHhnHFLWrIWLZk
         Igmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731992; x=1761336792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a410UVUkGWxYqDToM9eO24m2S1wWqIP4ItBf1At6t3A=;
        b=bh1bAM+LZO3dNBSvQEAknGTUp3k37xn3bGoQwA2WYJ9hs2H1O1oj8HKIU5KY2NeALd
         CK9uHC/FJQp9Nzg8I6VMMPrd78ESgKAlfJzZft8vh1E3/e0yxF0Wcbol4mhUqrMmCuA1
         TeRS1gCJEK1au6pCVMvGXc7zqA/8KJOjBkAlVFhSNOefUrS9kPtep62ukPKmoML8dfi6
         UGKkkq7MAVYvkzKjiKGMMkMwMqcqwyqkLnfh1AA1HdXVlSvP0hPMCBX6w0uMHtEaOaRl
         Bcli61oniRsWddE6YIMMhSapKt69NRI/Xl5G++sdnD2KvXdupYR3tCa6OFbvgdayE9wM
         2P9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVx0K6hb/JG0GwBG4stdIjmsMpdyUNkqCU9vQZgldu7zSCoV3wxpylxu53PllFTxwGHUhKSGG6yI77kajLe@vger.kernel.org
X-Gm-Message-State: AOJu0YzPULBBIf0/vtt4z3oVvaK5+M1hogzCFhusKw6mTV/k1tDE6WjP
	qPFlxr00dF4RcSw0KNcoGKDL2Nv4u4TiFexKJ9J9/kZmMdsa//0u0a2PGyBj4Zvx8IcOvpDfer3
	Sjhqxse1qKleMR4c1wNaQ5XgENw==
X-Google-Smtp-Source: AGHT+IHRvzzwMR4y0ztHkD4pksfFtRgb0k5+ziur45rOES6dge9lLW63A0tWR3m6aINjc/jUiO+gZmGPknwu1Q9I7g==
X-Received: from pjpx13.prod.google.com ([2002:a17:90a:a38d:b0:33b:51fe:1a93])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1dc4:b0:33b:ade7:51d3 with SMTP id 98e67ed59e1d1-33bcf8f78c4mr6385553a91.20.1760731991624;
 Fri, 17 Oct 2025 13:13:11 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:07 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <bb336979b10ee5b9c6b3c3934ec3aff19330b3e7.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 26/37] KVM: selftests: guest_memfd: Test that
 shared/private status is consistent across processes
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

From: Sean Christopherson <seanjc@google.com>

Add a test to verify that a guest_memfd's shared/private status is
consistent across processes.

The test forks a child process after creating the shared guest_memfd
region so that the second process exists alongside the main process for the
entire test.

The processes then take turns to access memory to check that the
shared/private status is consistent across processes.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../kvm/guest_memfd_conversions_test.c        | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 907d415d72315..e6abf2d30c62d 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -330,6 +330,80 @@ GMEM_CONVERSION_TEST_INIT_SHARED(truncate)
 	test_private(t, 0, 0, 'A');
 }
 
+/* Test that shared/private memory protections work and are seen from any process. */
+GMEM_CONVERSION_TEST_INIT_SHARED(forked_accesses)
+{
+	/*
+	 * No races are intended in this test, shared memory is only used to
+	 * coordinate between processes.
+	 */
+	static enum {
+		STATE_INIT,
+		STATE_CHECK_SHARED,
+		STATE_DONE_CHECKING_SHARED,
+		STATE_CHECK_PRIVATE,
+		STATE_DONE_CHECKING_PRIVATE,
+	} *test_state;
+	pid_t child_pid;
+
+	test_state = kvm_mmap(sizeof(*test_state), PROT_READ | PROT_WRITE,
+			      MAP_SHARED | MAP_ANONYMOUS, -1);
+
+#define TEST_STATE_AWAIT(__state)						\
+	while (READ_ONCE(*test_state) != __state) {				\
+		if (child_pid != 0) {						\
+			int status;						\
+			pid_t pid;						\
+			do {							\
+				pid = waitpid(child_pid, &status, WNOHANG);	\
+			} while (pid == -1 && errno == EINTR);			\
+			if (pid == -1)						\
+				TEST_FAIL("Couldn't check child status.");	\
+			else if (pid != 0)					\
+				TEST_FAIL("Child exited prematurely.");		\
+		}								\
+	}
+
+#define TEST_STATE_SET(__state) WRITE_ONCE(*test_state, __state)
+
+	child_pid = fork();
+	TEST_ASSERT(child_pid != -1, "fork failed");
+
+	if (child_pid == 0) {
+		const char inconsequential = 0xdd;
+
+		TEST_STATE_AWAIT(STATE_CHECK_SHARED);
+
+		/*
+		 * This maps the pages into the child process as well, and tests
+		 * that the conversion process will unmap the guest_memfd memory
+		 * from all processes.
+		 */
+		host_do_rmw(t->mem, 0, 0xB, 0xC);
+
+		TEST_STATE_SET(STATE_DONE_CHECKING_SHARED);
+		TEST_STATE_AWAIT(STATE_CHECK_PRIVATE);
+
+		TEST_EXPECT_SIGBUS(READ_ONCE(t->mem[0]));
+		TEST_EXPECT_SIGBUS(WRITE_ONCE(t->mem[0], inconsequential));
+
+		TEST_STATE_SET(STATE_DONE_CHECKING_PRIVATE);
+		exit(0);
+	}
+
+	test_shared(t, 0, 0, 0xA, 0xB);
+
+	TEST_STATE_SET(STATE_CHECK_SHARED);
+	TEST_STATE_AWAIT(STATE_DONE_CHECKING_SHARED);
+
+	test_convert_to_private(t, 0, 0xC, 0xD);
+
+	TEST_STATE_SET(STATE_CHECK_PRIVATE);
+	TEST_STATE_AWAIT(STATE_DONE_CHECKING_PRIVATE);
+
+	kvm_munmap(test_state, sizeof(*test_state));
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
-- 
2.51.0.858.gf9c4a03a3a-goog


