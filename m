Return-Path: <linux-fsdevel+bounces-79754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKjqHtyYrmmqGgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 10:54:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DF3236943
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 10:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC61330172C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 09:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C6138A71A;
	Mon,  9 Mar 2026 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvGDC3DC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD2F3876AA
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050061; cv=none; b=fIjOpF8MNEGfImizrcspaqe1M4XGkyQK8gTvQb/k/OkFbl/xs/Bz9I8r5KVz64kE1DrKM6UBV1xAJwN1yxZNG62vmad7gMrzMdojmtI7Yzs6CBVzGXL13bM7lxja/W4N29Lp5rBIal8JEDtB8Qsjg2h2czNRiWoFqes8moSJuoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050061; c=relaxed/simple;
	bh=yeoFRB0x0cYTGtPfHobeqkFPIXI/Si+Y5++BAFhp31U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rKPnrlFP1rMzoOKl7uy/6UGATS8CGFV9KtZWHbIgNMVKKSmJcSb0A8g7oXNFgNDWhBGwASzrk+IwmHvQUH2uBBuhUzxSU2Lh2FGLJEoxOkuDpoVN8mdf9RQdW9jRYLrMH96iEE9abnlWQz+djdzNJbdCbqPeYp17PT3Op64dnNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GvGDC3DC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae5031c6c5so385905565ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 02:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773050057; x=1773654857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6X2ZyGf4duGXbwGrp5sOhQZ4KKFdJaMZm2rOVj/sk3w=;
        b=GvGDC3DCDyp+M8O8kG2TA1uXQfbBzqiC0NDi74wjtWtUrQYY8pAcdtBDR+mZZGumSi
         LjatRCd6q81OmdtC/DUL+ZQKtR2lBvpm8sx4rHDAnkcESClA7GuvnhfFDl7ZxJYiMWdP
         2djhiwRF1xScKpttDE9Ml2iNkXTWlbanE5dbM42K2ozFCz3fLxFPU1UDdE0LQ7zMbLzN
         7sdCU0vDAEsPek+NtJk6SKCkQXtKQQgDyGJk4IPCYlNDX0lQ3TTGjZRvcX86rX8Ce4+P
         n/b0Oo6EofXztqnF3fA2Zx7g2N7YKrJEXwkHme1OHnJnzFBjmBLgZA9hW+wKhWiSvz0Q
         /fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773050057; x=1773654857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6X2ZyGf4duGXbwGrp5sOhQZ4KKFdJaMZm2rOVj/sk3w=;
        b=hhD2QEeP/A2uR9h4pCEm7cU85f5ceIBRLTBHZ7DKFFTGE1exl3F/qn5qjFRgsX+kFx
         aAK4jN8jGlrg6OpEeWZo9BgMa/VOhuP1vmy4gUJtWo9SL6YNCpdwJUhQ216RQHLN4Ri8
         BINnqP35nKnLzvh63WbXI1zRLjJd9uvzUolfnMeTRQRy+35/QIQ2FGZsg7fgEJcV+N0h
         OQQZDyYed/D9oSEIeoGphSj5CS7lSsA2A7kZzq1BhpPHTUwqbd84rbhlP89px/ZfoEcK
         JCEcRbqWnks+/cIdkMihDGDJycJPs2fcKlLe5kh++bJpFxEl/MYqK7I87/LJcT8VuyoV
         K7Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVo24Bvf70P+0QK0qz2xkqv4D3kS0wEUNzqFLk6fSi01qW6ALs0gGYASuucZrr3zEH++EFO5xlWKqCkZjS+@vger.kernel.org
X-Gm-Message-State: AOJu0YxJuQsiT4iehW3z90SG0I+dC8qBdcGSamfBBcw37MPXNyI+1wzt
	LPS5RjKbtKMnh/WMufJWRngQzjqL4K2rtM7tDDPq/eqHoziZHw3vm6v3eGd4Gz2c5ksdjBC0cna
	vVswevU49X9PDgo80J2OXCww5lQ==
X-Received: from pliy13.prod.google.com ([2002:a17:903:3d0d:b0:2ae:3f26:a1c3])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e890:b0:2ae:7f49:8e37 with SMTP id d9443c01a7336-2ae82416de1mr112118785ad.11.1773050056826;
 Mon, 09 Mar 2026 02:54:16 -0700 (PDT)
Date: Mon, 09 Mar 2026 09:53:54 +0000
In-Reply-To: <20260309-gmem-st-blocks-v3-0-815f03d9653e@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309-gmem-st-blocks-v3-0-815f03d9653e@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773050050; l=3039;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=yeoFRB0x0cYTGtPfHobeqkFPIXI/Si+Y5++BAFhp31U=; b=/7QaGGXJvObuh04yNGHeLFEneGC6nTgx3TASDbD9523g5EzCojJdSnNh5/P0oXkbUD04qd+mq
 7mGm6etCRziCzsqHuyNkqm2bt1BC9Gf7zUKg1q8Pm9Ood8vplQeG6EK
X-Mailer: b4 0.14.3
Message-ID: <20260309-gmem-st-blocks-v3-3-815f03d9653e@google.com>
Subject: [PATCH RFC v3 3/4] KVM: selftests: Wrap fstat() to assert success
From: Ackerley Tng <ackerleytng@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	seanjc@google.com, rientjes@google.com, rick.p.edgecombe@intel.com, 
	yan.y.zhao@intel.com, fvdl@google.com, jthoughton@google.com, 
	vannapurve@google.com, shivankg@amd.com, michael.roth@amd.com, 
	pratyush@kernel.org, pasha.tatashin@soleen.com, kalyazin@amazon.com, 
	tabba@google.com, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 65DF3236943
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79754-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.914];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Extend kvm_syscalls.h to wrap fstat() to assert success. This will be used
in the next patch.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c     | 15 +++++----------
 tools/testing/selftests/kvm/include/kvm_syscalls.h |  2 ++
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index ec7644aae999d..638906298ed73 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -270,10 +270,8 @@ static void test_mmap_not_supported(int fd, size_t total_size)
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
@@ -361,25 +359,22 @@ static void test_create_guest_memfd_invalid_sizes(struct kvm_vm *vm,
 
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
index 843c9904c46f6..2266c06347f5d 100644
--- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
+++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
@@ -2,6 +2,7 @@
 #ifndef SELFTEST_KVM_SYSCALLS_H
 #define SELFTEST_KVM_SYSCALLS_H
 
+#include <sys/stat.h>
 #include <sys/syscall.h>
 
 #define MAP_ARGS0(m,...)
@@ -78,5 +79,6 @@ __KVM_SYSCALL_DEFINE(close, 1, int, fd);
 __KVM_SYSCALL_DEFINE(fallocate, 4, int, fd, int, mode, loff_t, offset, loff_t, len);
 __KVM_SYSCALL_DEFINE(ftruncate, 2, unsigned int, fd, off_t, length);
 __KVM_SYSCALL_DEFINE(madvise, 3, void *, addr, size_t, length, int, advice);
+__KVM_SYSCALL_DEFINE(fstat, 2, int, fd, struct stat *, buf);
 
 #endif /* SELFTEST_KVM_SYSCALLS_H */

-- 
2.53.0.473.g4a7958ca14-goog


