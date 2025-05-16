Return-Path: <linux-fsdevel+bounces-49204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6355DAB9322
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 02:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D75DA08238
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 00:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04210748D;
	Fri, 16 May 2025 00:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUXqAjcz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFC717E4
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 00:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747354947; cv=none; b=UTf9ExCWYY18liSBzdQqgUtRfeH7sCfZK8F3rV3UPH+xNWUBhnrwGRIu23DUVstVjf6PDNSdCT+glepwCXFlkCfnBHbLKLG839unCS5mlKxcB4RrZ/F5s1V5AQBmBwIYc9iJA05gZyOehL4/5fZ0mFeM2qF2GNf98KXQb8vD2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747354947; c=relaxed/simple;
	bh=FLr14or9G6ctdhc4NjO2TMqj5hlhyJOyOKBdrjBX+q0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aYV078S1HbxMBLKgTcf0SOAz1YkDU9GPJ3aNv/MX4M6JUWb2lsfT28oBbijm9fLWqbDUp4hcFrA94FGzd3CNrb2Ro9p/aUeDMy9woSAReI01hoTX46OgTXnIVd0aObX9s1Xl/PClaEiVYhDpG0rLFyYm6+nOjdC/nnqYDx2q1cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CUXqAjcz; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742512d307bso2732553b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 17:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747354945; x=1747959745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U2sAkeu7MGicRsmk1eQ6Ys1LarlK/EQzO2qqYVap+q8=;
        b=CUXqAjczPMuTHriZl6tvaL4123gmRh9zTXElchUlG6gYQCikDJRMz1sCutUHfzgoJf
         G9sVqQV3rr9ma/GFOyUz8xe0EmS8n2lyWgz3kUK4PfEgNgkm0q9RsJu4xrt7VAlqEksN
         pPPxv92ER/JvLVvvcpoayrDxJ+hpKqc2oVPgE0fnfwhrKKNDwTtXFbrzBsUgJbMWOFx8
         En4szy+an3umatgmNrQ+G/cUAbUxOs/cNqgIsjezLCwixE0mU0BLsFO/m7M9C6LT6Oow
         /dixVeiszZhi/YLzvg/K/CPiFbEsSrQHIOVKmrOrkXlgwMhrhwVuG+r03Qz6rHAug8AW
         4/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747354945; x=1747959745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2sAkeu7MGicRsmk1eQ6Ys1LarlK/EQzO2qqYVap+q8=;
        b=LU5c8LDRyRyGpSgqqE3tjPiQIlsSZ3eqfvNoIeM7VVk7SpVrGJ7dl07MGnkBUdJCbi
         ZrRIRhdgaEwKBXGxWvHZxICqH91P2NlnyvQWMIAKlT5cXnUvtp0oeWFExGaecKLM4qAd
         pZv0rentN7gNQq+aN8ZNqnUAHahFhloP/2R/YTrA7ck1H/9qeMVBnYUDMTE3Cejz+QeH
         m7exUItNfrTJ+OcnVFUoqGPOG9uEHjSheLVJw0Rc+F+TCdieOj/RDXYaXLFCbWE6TYj+
         Rl9QdG7T359zYMfZvfZRS/QRI+ohJGmKpz7NtylvKzMIgEDl2yF3Xkaw4LFT2333k+ou
         m6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHbLvNIRMIKWqLgVRqgRPLKEkEob7d/pTN8ivhdhqnc+7phtbpiavgIyAU+xXkr2cTF+GYJ9+qeiDzi7gC@vger.kernel.org
X-Gm-Message-State: AOJu0YwywJDa2wrE/vibPApC/7jtrAR1ojNPJHQ/Az7QxQDZJxTkbGyF
	kodMdUTioM/gjOplLCvukdhNRCPoN6OXvY7OzL0opJuc0xM2JRhdkDJyeWUerK2LYLhDM9qHyPt
	tZgPW7Z1CSaM79OQf2cYN5u8oJg==
X-Google-Smtp-Source: AGHT+IE6+aZ6pB0+4YWi/bOE+1/FrllyYKfVOjrPP4jF0YyDdqPgCbM1S1tbN8ddfEjmhOfVoPvdJc2p2g7nYFoIDA==
X-Received: from pfbmb27.prod.google.com ([2002:a05:6a00:761b:b0:736:b063:5038])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4fc2:b0:73e:598:7e5b with SMTP id d2e1a72fcca58-742acc906ccmr622342b3a.1.1747354944946;
 Thu, 15 May 2025 17:22:24 -0700 (PDT)
Date: Thu, 15 May 2025 17:22:21 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <a2fb493750ee445f8cc779d9fdf18329ec65812f.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 51/51] KVM: selftests: Test guest_memfd for accuracy of st_blocks
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: ackerleytng@google.com, aik@amd.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	kirill.shutemov@intel.com, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org, 
	mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk, 
	peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com, 
	quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, vannapurve@google.com, vbabka@suse.cz, 
	viro@zeniv.linux.org.uk, vkuznets@redhat.com, wei.w.wang@intel.com, 
	will@kernel.org, willy@infradead.org, xiaoyao.li@intel.com, 
	yan.y.zhao@intel.com, yilun.xu@intel.com, yuzenghui@huawei.com, 
	zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Test that st_blocks in struct stat (inode->i_blocks) is updated.

Change-Id: I67d814f130671b6b64b575e6a25fd17b1994c640
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 55 ++++++++++++++++---
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index c8acccaa9e1d..f51cd876d7dc 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -142,41 +142,78 @@ static void test_file_size(int fd, size_t page_size, size_t total_size)
 	TEST_ASSERT_EQ(sb.st_blksize, page_size);
 }
 
-static void test_fallocate(int fd, size_t page_size, size_t total_size)
+static void assert_st_blocks_equals_size(int fd, size_t page_size, size_t expected_size)
 {
+	struct stat sb;
+	int ret;
+
+	/* TODO: st_blocks is not updated for 4K-page guest_memfd. */
+	if (page_size == getpagesize())
+		return;
+
+	ret = fstat(fd, &sb);
+	TEST_ASSERT(!ret, "fstat should succeed");
+	TEST_ASSERT_EQ(sb.st_blocks, expected_size / 512);
+}
+
+static void test_fallocate(int fd, size_t test_page_size, size_t total_size)
+{
+	size_t page_size;
 	int ret;
 
 	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, 0, total_size);
 	TEST_ASSERT(!ret, "fallocate with aligned offset and size should succeed");
+	assert_st_blocks_equals_size(fd, test_page_size, total_size);
 
 	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
-			page_size - 1, page_size);
+			test_page_size - 1, test_page_size);
 	TEST_ASSERT(ret, "fallocate with unaligned offset should fail");
+	assert_st_blocks_equals_size(fd, test_page_size, total_size);
 
-	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, total_size, page_size);
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, total_size, test_page_size);
 	TEST_ASSERT(ret, "fallocate beginning at total_size should fail");
+	assert_st_blocks_equals_size(fd, test_page_size, total_size);
 
-	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, total_size + page_size, page_size);
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, total_size + test_page_size, test_page_size);
 	TEST_ASSERT(ret, "fallocate beginning after total_size should fail");
+	assert_st_blocks_equals_size(fd, test_page_size, total_size);
 
 	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
-			total_size, page_size);
+			total_size, test_page_size);
 	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) at total_size should succeed");
+	assert_st_blocks_equals_size(fd, test_page_size, total_size);
 
 	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
-			total_size + page_size, page_size);
+			total_size + test_page_size, test_page_size);
 	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) after total_size should succeed");
+	assert_st_blocks_equals_size(fd, test_page_size, total_size);
 
 	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
-			page_size, page_size - 1);
+			test_page_size, test_page_size - 1);
 	TEST_ASSERT(ret, "fallocate with unaligned size should fail");
+	assert_st_blocks_equals_size(fd, test_page_size, total_size);
 
 	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
-			page_size, page_size);
+			test_page_size, test_page_size);
 	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) with aligned offset and size should succeed");
+	assert_st_blocks_equals_size(fd, test_page_size, total_size - test_page_size);
 
-	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, page_size, page_size);
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
+			test_page_size, test_page_size);
+	TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) in a hole should succeed");
+	assert_st_blocks_equals_size(fd, test_page_size, total_size - test_page_size);
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE, test_page_size, test_page_size);
 	TEST_ASSERT(!ret, "fallocate to restore punched hole should succeed");
+	assert_st_blocks_equals_size(fd, test_page_size, total_size);
+
+	page_size = getpagesize();
+	if (test_page_size == page_size) {
+		ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
+				test_page_size + page_size, page_size);
+		TEST_ASSERT(!ret, "fallocate(PUNCH_HOLE) of a subfolio should succeed");
+		assert_st_blocks_equals_size(fd, test_page_size, total_size);
+	}
 }
 
 static void test_invalid_punch_hole(int fd, size_t page_size, size_t total_size)
-- 
2.49.0.1045.g170613ef41-goog


