Return-Path: <linux-fsdevel+bounces-78345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DfJLg2lnmmrWgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 08:30:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C1D193759
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 08:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 180853179E25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 07:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0446B33B6EC;
	Wed, 25 Feb 2026 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I3tpnjvQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB9832D7F0
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004057; cv=none; b=bwnbIV+yLmlez3/kSikiY0pGKV1Ed74R1+m/dIP+DAdGdPNLKdxLvpKmqB7Ca3kDL+61li8/BL8Nl6jt3oiYFUmriAm4PTUsKXh77pbbDXQt7L7ccyQt0t79xGHJv8MODYQBE+XYXAy0+e+aIjP4SZkGgtrY5c2KC8H18y6eCCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004057; c=relaxed/simple;
	bh=dOYyBdQXA1usfepnnNuDszu6x3QfaYGIbNqVbOtmh7o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DVcrRIvSb42pQUzgz9oB1H6oGwXjNADLtlk/Nrtw/jBzJ9cSZaUwhqlmMMGee5pucOqwNyeGyEO52e22NWGpFDDCD1fPjSTjbUK7+0waMaZJZ0j1BjWxKYZbbACsSziIyzLdQDsBwyt2ZjflRDe8Hj6fhT3tiHHiiDBU/yevbk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I3tpnjvQ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ab4de9580dso463311425ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 23:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772004054; x=1772608854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCRWKaRAQP2gBMw/IwAKqq2A0WtVFQ88sM/7soXGb8M=;
        b=I3tpnjvQuA+B/47Xi93nsUnNz4ABiLiO81bZWolQQPkRP1MvkYIHXHPcOHtDzHOify
         PgkdDgVxvzLGDnW4K8ka2w2JP7gAWU/wkpwAidUfBD69+O43IxV94mlbrPqfLgAdHPcX
         OjRh81UOBI/d6q5DtwbrYBvaSMeukq6Dd7aU4gwXzzBpAizPc8bmGZM0Mh9YCMD0gdYd
         TGdtNxefz49ybrs2EHiWpLKfZiSrI454tp9hIaJQyJ7zubi2ke7h0SM5+ngCPTHdfan4
         q0noHo7uCAamVcCngr2oNwYcdDTHvf6jzPQJQ3AA/JXPJp/fldP4KQ33wlrj5hM34Ab4
         vBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004054; x=1772608854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCRWKaRAQP2gBMw/IwAKqq2A0WtVFQ88sM/7soXGb8M=;
        b=I1HTBIW0iclA1fHOorSjsnzaXXyzSgyHT3vhrvDWImaQEhvONMB9qrxMYFHj3Fzo5N
         Q0IkuevIyTrIQrnacCZYp6dZ4EPfUh5ew6xbHW0kBR/cx1Sj8vP71aoYmDd0apShpe1/
         leHiovz89LaGbWvXkNjQC7UZ/+DrxZ4fh4eEVsTukhWZsg5rR3jtYfc5qnxbtcp1L4Ro
         rUZihDwLLFKYSBVMjXzKLLmkyU9Hbbn7Tc4iCstF2aYt5kXufnseLjQ3PTq3roz+4Wpm
         0F3jO/ia3XDa8Nc80BMwPaMwVlPh+SKUdTjy7EFLDW+a5cMXrDQKeyd5LtcgEFv1k2sm
         fb2g==
X-Forwarded-Encrypted: i=1; AJvYcCVJWdt6jVlqpCcf1WM3VNsuTpchH0Hkg/KJAmww2aN/geLRO0XBkIhtdaaELIJBq8IfqhBVx36nIAS1Ld/x@vger.kernel.org
X-Gm-Message-State: AOJu0YwdvyJ8eBa70882Kh5/L+A+Hiw1QVMeB1FpwFfPdOMuOnK/hZb3
	10u9ywxGzndPp4bASUwigjAXnn/nZA+NmVfsaYN+byrbqrIicgP/WyxA4kzjIoewJ43/ga1whqc
	+ghkqC5U/cQtrbN4K5Eb60V4KWA==
X-Received: from plsk6.prod.google.com ([2002:a17:902:ba86:b0:29f:1738:99f3])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d511:b0:2a7:c188:bd1f with SMTP id d9443c01a7336-2add14146b1mr15540455ad.40.1772004054358;
 Tue, 24 Feb 2026 23:20:54 -0800 (PST)
Date: Wed, 25 Feb 2026 07:20:41 +0000
In-Reply-To: <20260225-gmem-st-blocks-v2-0-87d7098119a9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225-gmem-st-blocks-v2-0-87d7098119a9@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772004043; l=3384;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=dOYyBdQXA1usfepnnNuDszu6x3QfaYGIbNqVbOtmh7o=; b=zZrSG7T8hLIyNxblKZAGfB+9IN1V9IOqYlhpVMvYXXGbthbgU9tmocvsvN/c7FJF4snDqAhSr
 TzWnTmDXwh2DG87+Tp1yHs6y/+kQ/SVsCjVtOclQbRZ0IyhxW13o7OV
X-Mailer: b4 0.14.3
Message-ID: <20260225-gmem-st-blocks-v2-6-87d7098119a9@google.com>
Subject: [PATCH RFC v2 6/6] KVM: selftests: Test that st_blocks is updated on allocation
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
	TAGGED_FROM(0.00)[bounces-78345-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 68C1D193759
X-Rspamd-Action: no action

The st_blocks field reported by fstat should reflect the number of
allocated 512-byte blocks for the guest memfd file.

Extend the fallocate test to verify that st_blocks is correctly updated
when memory is allocated or deallocated via
fallocate(FALLOC_FL_PUNCH_HOLE).

Add checks after each fallocate call to ensure that st_blocks increases on
allocation, decreases when a hole is punched, and is restored when the hole
is re-allocated. Also verify that st_blocks remains unchanged for failing
fallocate calls.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 81387f06e770a..89228d73fa736 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -218,41 +218,58 @@ static void test_file_size(int fd, size_t total_size)
 	TEST_ASSERT_EQ(sb.st_blksize, page_size);
 }
 
+static void assert_st_blocks_matches_size(int fd, size_t expected_size)
+{
+	struct stat sb;
+
+	kvm_fstat(fd, &sb);
+	TEST_ASSERT_EQ(sb.st_blocks, expected_size / 512);
+}
+
 static void test_fallocate(int fd, size_t total_size)
 {
 	int ret;
 
 	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, 0, total_size);
 	TEST_ASSERT(!ret, "fallocate with aligned offset and size should succeed");
+	assert_st_blocks_matches_size(fd, total_size);
 
 	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
 			page_size - 1, page_size);
 	TEST_ASSERT(ret, "fallocate with unaligned offset should fail");
+	assert_st_blocks_matches_size(fd, total_size);
 
 	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, total_size, page_size);
 	TEST_ASSERT(ret, "fallocate beginning at total_size should fail");
+	assert_st_blocks_matches_size(fd, total_size);
 
 	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, total_size + page_size, page_size);
 	TEST_ASSERT(ret, "fallocate beginning after total_size should fail");
+	assert_st_blocks_matches_size(fd, total_size);
 
 	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
 			total_size, page_size);
 	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) at total_size should succeed");
+	assert_st_blocks_matches_size(fd, total_size);
 
 	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
 			total_size + page_size, page_size);
 	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) after total_size should succeed");
+	assert_st_blocks_matches_size(fd, total_size);
 
 	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
 			page_size, page_size - 1);
 	TEST_ASSERT(ret, "fallocate with unaligned size should fail");
+	assert_st_blocks_matches_size(fd, total_size);
 
 	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
 			page_size, page_size);
 	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) with aligned offset and size should succeed");
+	assert_st_blocks_matches_size(fd, total_size - page_size);
 
 	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, page_size, page_size);
 	TEST_ASSERT(!ret, "fallocate to restore punched hole should succeed");
+	assert_st_blocks_matches_size(fd, total_size);
 }
 
 static void test_invalid_punch_hole(int fd, size_t total_size)

-- 
2.53.0.414.gf7e9f6c205-goog


