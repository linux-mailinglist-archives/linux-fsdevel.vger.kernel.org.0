Return-Path: <linux-fsdevel+bounces-78344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLpnM8OknmlPWgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 08:29:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6FF193705
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 08:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0C9C316E79B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 07:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F889330B3C;
	Wed, 25 Feb 2026 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kl49/QXT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9942A31BC84
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004055; cv=none; b=KDjERpEavMBkcecW0rBp6g7vUmf6mcBGG9cbOBusLW+nCY217Rrz54JWMNmm02UhEtetyXOB0YIVGr5C1fuW01GnliGoq5Gna1Qz+cp8E5f2HLVIeEiIk3Zrp9vNwjfkKvXOkIX7VMBFucxrUhH1c7T3AaqRtnL2cizLO4BHaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004055; c=relaxed/simple;
	bh=41+6neAL0d27ks2wQws7sEuDZgQjzT5nG62AnxD5qpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UmMLu4Uqw7uZIhj0nl5a4kiLKosuTg/lLyGDScSdk1xpNtydWPhjf97CbulMc+qtW2K436X7cqJ+wSImgowu/zWJo6xnY0vFp77Ii+joXvCEBBmS69qOYAFFkSmyCdJihl2NohL7q0OzZRl9rkJ1G7UAUuaZxZ5qua4iShFEDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kl49/QXT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c709551ec08so29060255a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 23:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772004053; x=1772608853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lmqeDy1YGPO6heAH4dtg7V9yIhQw7gZPhshB9Ud1SBU=;
        b=kl49/QXTyHNtzK3awy/yDH8SdYKO5eimqBUQi+UII5h9a9SBFLxjantR3qhGW+uYd8
         mYgQLJVaw0XA6/AV9emQXbYPTYlV4sNCnCj3XUCI8QdJcRtMWv3kYRCiSsZJ+1hV9Hcp
         hBuwHtRnVIszSeYM465KYcCumfhasyjWMat+2JnYCcBAWI9Rl9AhupAbcrc5jdp6chno
         TxlQX9RNq5CXzsQ72qm7LnUK7P286lheZHu9aVJULLBDqjMAokM6/p/U9zeINILNcUMH
         2+ZPyG4CREVQWJ2erErVhEeUsY2SCnGFCAojzxw/ZLnUtQgiogxK004UD809ZrIm8z1j
         b3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004053; x=1772608853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmqeDy1YGPO6heAH4dtg7V9yIhQw7gZPhshB9Ud1SBU=;
        b=q0qG/KTYFyjnNDH4g5vIdaIyQeVxJPqPgyQS0CN8C8WG02XFYna+IzAuK5bULgiDWY
         tpgDEaHoAiFM/Pgzd596nqEOsPTjRPmKtG1Lz8zFiv1ekt9Wqh8I9Uc3bYDKZTHwLsLO
         lY1Zv1QXePCfRkwGdXMaNv8TFcQg6RIENXZoyOaa6EBDF5liamyQnvOt1ncAJiPa/UCN
         77YWp/F07hjPwxg0A6kE/eFGMacacpsdIRwaqAnLYi8AVaIE07PUdnSYPdLDOHXLT5k5
         xwx8qKopcBb3IsRPcIcqbU5JgRKTqgAB1ErpmjI8rAWw5LBkTkad3/g8z1ZYwH0oPmXG
         UWQg==
X-Forwarded-Encrypted: i=1; AJvYcCW45jXrmSuh0j5P2lsNnT34IK/7gJqX0rysN3LTJS9BZO0NVA/QCrs/DzojgNzXcHho45q3fhF+4NisvkT1@vger.kernel.org
X-Gm-Message-State: AOJu0YyNhVlRQDpLt6qS3cWGiiWFN3nUGKY5P1WzKYm+1UH2r6auM/HZ
	8/ky0INPw8QIaQtR0EevOq7OZOIAzr0MB9tCtsDwF1Dg22TcSVQNzq9S1PRx/oLQy9gBzQg+r5C
	VK8SqxLw3tRPzFy270FTbNEw/5g==
X-Received: from pgbfp5.prod.google.com ([2002:a05:6a02:2ce5:b0:c0e:c1b4:51a5])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7f89:b0:394:58eb:48fa with SMTP id adf61e73a8af0-39545dc0482mr14694770637.6.1772004052747;
 Tue, 24 Feb 2026 23:20:52 -0800 (PST)
Date: Wed, 25 Feb 2026 07:20:40 +0000
In-Reply-To: <20260225-gmem-st-blocks-v2-0-87d7098119a9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225-gmem-st-blocks-v2-0-87d7098119a9@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772004043; l=3022;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=41+6neAL0d27ks2wQws7sEuDZgQjzT5nG62AnxD5qpc=; b=Qf0H2UQ2mVaGwE9fmA4IWjbnRJGJ7WGDq8UI2QM5uIsOM4kNu9y1rdgzh53H+jjev44oOi+/r
 kT+aePH4Im8Br8uVg3C6xnPFChAqWmmulNjoE70K9V+ksKWXjrvsGjL
X-Mailer: b4 0.14.3
Message-ID: <20260225-gmem-st-blocks-v2-5-87d7098119a9@google.com>
Subject: [PATCH RFC v2 5/6] KVM: selftests: Wrap fstat() to assert success
From: Ackerley Tng <ackerleytng@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	seanjc@google.com, rientjes@google.com, rick.p.edgecombe@intel.com, 
	yan.y.zhao@intel.com, fvdl@google.com, jthoughton@google.com, 
	vannapurve@google.com, shivankg@amd.com, michael.roth@amd.com, 
	pratyush@kernel.org, pasha.tatashin@soleen.com, kalyazin@amazon.com, 
	tabba@google.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78344-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B6FF193705
X-Rspamd-Action: no action

Extend kvm_syscalls.h to wrap fstat() to assert success. This will be used
in the next patch.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c     | 15 +++++----------
 tools/testing/selftests/kvm/include/kvm_syscalls.h |  2 ++
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 618c937f3c90f..81387f06e770a 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -212,10 +212,8 @@ static void test_mmap_not_supported(int fd, size_t total_size)
 static void test_file_size(int fd, size_t total_size)
 {
 	struct stat sb;
-	int ret;
 
-	ret = fstat(fd, &sb);
-	TEST_ASSERT(!ret, "fstat should succeed");
+	kvm_fstat(fd, &sb);
 	TEST_ASSERT_EQ(sb.st_size, total_size);
 	TEST_ASSERT_EQ(sb.st_blksize, page_size);
 }
@@ -303,25 +301,22 @@ static void test_create_guest_memfd_invalid_sizes(struct kvm_vm *vm,
 
 static void test_create_guest_memfd_multiple(struct kvm_vm *vm)
 {
-	int fd1, fd2, ret;
+	int fd1, fd2;
 	struct stat st1, st2;
 
 	fd1 = __vm_create_guest_memfd(vm, page_size, 0);
 	TEST_ASSERT(fd1 != -1, "memfd creation should succeed");
 
-	ret = fstat(fd1, &st1);
-	TEST_ASSERT(ret != -1, "memfd fstat should succeed");
+	kvm_fstat(fd1, &st1);
 	TEST_ASSERT(st1.st_size == page_size, "memfd st_size should match requested size");
 
 	fd2 = __vm_create_guest_memfd(vm, page_size * 2, 0);
 	TEST_ASSERT(fd2 != -1, "memfd creation should succeed");
 
-	ret = fstat(fd2, &st2);
-	TEST_ASSERT(ret != -1, "memfd fstat should succeed");
+	kvm_fstat(fd2, &st2);
 	TEST_ASSERT(st2.st_size == page_size * 2, "second memfd st_size should match requested size");
 
-	ret = fstat(fd1, &st1);
-	TEST_ASSERT(ret != -1, "memfd fstat should succeed");
+	kvm_fstat(fd1, &st1);
 	TEST_ASSERT(st1.st_size == page_size, "first memfd st_size should still match requested size");
 	TEST_ASSERT(st1.st_ino != st2.st_ino, "different memfd should have different inode numbers");
 
diff --git a/tools/testing/selftests/kvm/include/kvm_syscalls.h b/tools/testing/selftests/kvm/include/kvm_syscalls.h
index d4e613162bba9..3f039c34e12e0 100644
--- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
+++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
@@ -2,6 +2,7 @@
 #ifndef SELFTEST_KVM_SYSCALLS_H
 #define SELFTEST_KVM_SYSCALLS_H
 
+#include <sys/stat.h>
 #include <sys/syscall.h>
 
 #define MAP_ARGS0(m,...)
@@ -77,5 +78,6 @@ __KVM_SYSCALL_DEFINE(munmap, 2, void *, mem, size_t, size);
 __KVM_SYSCALL_DEFINE(close, 1, int, fd);
 __KVM_SYSCALL_DEFINE(fallocate, 4, int, fd, int, mode, loff_t, offset, loff_t, len);
 __KVM_SYSCALL_DEFINE(ftruncate, 2, unsigned int, fd, off_t, length);
+__KVM_SYSCALL_DEFINE(fstat, 2, int, fd, struct stat *, buf);
 
 #endif /* SELFTEST_KVM_SYSCALLS_H */

-- 
2.53.0.414.gf7e9f6c205-goog


