Return-Path: <linux-fsdevel+bounces-79755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJqaAJ6ZrmmqGgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 10:57:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA50236A4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 10:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFF05303E4B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28C938B7C2;
	Mon,  9 Mar 2026 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jBoeGbob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8449389460
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050063; cv=none; b=S/A9tgasveRcP4lFAeEzwkdhveNYrX2VYt8XLYXTwdCSeUPX2rSeMmDUQc4ZdOBU3KHZ3I264DNGekqABXo55WkknPnrY12dEOn5FYzGwyxlSxjOsKk0x+jhi9JYr3kzPYKQccAU5fmg2I54+uu9rtlcMU41zu4Z3vbJyRPfFy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050063; c=relaxed/simple;
	bh=j//w3WNdHhv+K+KJtK+49w6iacgmz4dTxY4RPng9cDM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nalKBKh4iBBKq4PKRPCiJigwM+HyGd7d+97eZtYqvT8HOnyVYMZeNukKQFjUEaZpL58pWLyg5rke6plVEHtvCN+0uvqqNJ9LEcKcpeI8AHVYR/p8tvGknwNP+GxyJOI3SjkaMfIwPJDCMPE9x9A3QIzed67K276/E8DFz8F94zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jBoeGbob; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3597f559e70so5835084a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 02:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773050059; x=1773654859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/MEyZb/LBxvw6GMpGFDX0oKNKuzzaTQJv09alTwZUHg=;
        b=jBoeGbobj/yi+M2LQwgl1qx7sArCfTFGvxF5XbkL3jWyqS21RVKROuu050PtaWf7O6
         shDPTH3/eDYmksy5EQL/BRMSW66450RgItibmOJHKs2DCVG4xqHii4LUXqdmqMiwjjIi
         e4W7n3h1f5ZDOBqtkEyMFJgpi893oGhCfImQrwqX1whU92yLIfVK5bLyIqMxrHKI8hQP
         /sNZ4PSKd9vpzQ1LoQR2C9yzHeAOQSk62x6QcGd6uP1F19LE6c0V1wVJ//FZRipHqJMF
         P/tj4CJ0OqvB4Ozeb8cQEDp8bGVrgJKsbhWt68X+yTEw/5loh5W90exHu7vue4nRaqy6
         Y2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773050059; x=1773654859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/MEyZb/LBxvw6GMpGFDX0oKNKuzzaTQJv09alTwZUHg=;
        b=Onb/Sff6L5AIxxq88moKyED4bJdjIOJUYu5eqaiRbZmFHJuGoKA/Usk6utouysAFP/
         U+BpNBaFDQgac3aIeXfDBDYy7vRr1ZUg2wVa9FHp1aYBQXRw5GZpkDhurVN9DvlNUEn+
         vkOZGpQeW0QPwSIsoMXB/HHv1STV3fEd19jNjC3q5+lX3yuX6Ku/z+iXzj3gHibeg++T
         NLQE5Vcwa2NW/JGzKJhASGNNwZvTkJASj9sKmB8m58/zLlqRW8fSzzP2YsYjQfnp8YBU
         Utj96SNoRadhXyE3LkDgdfL8IqIwlCdG0YWZmLP2QaQaqPuweQOPWVNmd1SJs0TL6VzU
         iozw==
X-Forwarded-Encrypted: i=1; AJvYcCUrwglD4PjcAsoFPHxNdJ3qmDywQ8xnUlagNQVi1hpcUjp2TgDBcDbO6mn9yJU60v3SKbULC8n0gBv5+4ZO@vger.kernel.org
X-Gm-Message-State: AOJu0YzvJn8UzZJiRqTYPo89DnJRf6E1Ms5xZxiKjLf36Tkq5VR40Q3y
	+wcqmndO7h8v5GHGdVaBET5Y/fxxzBosnhFQxzqjQ2ye3e0MlPhPom2ja0G5mEiRCgw7eHbZNI9
	3yQ9Ozn8GOtCcEO8d9oEw0iw2MQ==
X-Received: from pjbcq1.prod.google.com ([2002:a17:90a:f981:b0:359:8ddd:8042])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2b4e:b0:359:8e5e:43ee with SMTP id 98e67ed59e1d1-359be2ee7f0mr9058209a91.19.1773050058833;
 Mon, 09 Mar 2026 02:54:18 -0700 (PDT)
Date: Mon, 09 Mar 2026 09:53:55 +0000
In-Reply-To: <20260309-gmem-st-blocks-v3-0-815f03d9653e@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309-gmem-st-blocks-v3-0-815f03d9653e@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773050050; l=3384;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=j//w3WNdHhv+K+KJtK+49w6iacgmz4dTxY4RPng9cDM=; b=47SP9RDMCEYTpZusRbsJtAhE6uNyDbx53VwlcxfkhVofBND7pZ84qMDahkOmQWfyUOEuUMi+w
 8KtzTKEfucPCalS3OewldUeVaBmw6TDArODKk48Vg/ruFqX9znVvd2L
X-Mailer: b4 0.14.3
Message-ID: <20260309-gmem-st-blocks-v3-4-815f03d9653e@google.com>
Subject: [PATCH RFC v3 4/4] KVM: selftests: Test that st_blocks is updated on allocation
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
X-Rspamd-Queue-Id: 5BA50236A4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79755-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.914];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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
index 638906298ed73..3381a556f397d 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -276,41 +276,58 @@ static void test_file_size(int fd, size_t total_size)
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
2.53.0.473.g4a7958ca14-goog


