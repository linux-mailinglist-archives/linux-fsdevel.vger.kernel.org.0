Return-Path: <linux-fsdevel+bounces-64537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E06EBEB932
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 22:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185E63A5EB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 20:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB8C3491E3;
	Fri, 17 Oct 2025 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nd9fH3AF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09551340A6B
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731997; cv=none; b=OB7dAqjaZm+URaUWST0CMrmuF+wOOEFkMZZnFbscCJcixz6zWGL6D6IjFeEjyCHDtJzQk8h3TkXEK4lECQnvs6UBwv9YjYl7kJnzzawiRpY08hr9YClMJ1nGsYLdpKIlvv48n+dwwJQstJ+rHAeQi3wmig5HcYtDmqmtBKLroyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731997; c=relaxed/simple;
	bh=i0JjKVivSfUtEJKMtg8Zh0aQ6cl6o1OLhPEiIgjuNsg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m5PyKfoulvJAJgCs7qVaXUFxPsp7wSdzB7mhS7+1msEmwM7bTdsJTMy+PkkGw6L8I1R04t/yoC7HBnqIgfmurtcUmDtDNRftUmk0Wd/E5gH73668+QjYRQ7W7vhbe2YG69dydpxsb7l3JqwrGPt3qN1hYF57XQJScZGr0ROVAxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nd9fH3AF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bba464b08so1792075a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 13:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731988; x=1761336788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VpPPOYob1QZnV0MVjnp55PhCGroJIJiVg+QyoFgvrb4=;
        b=Nd9fH3AFP8sW/QWuZh681RFQw31g3laz2+LPTG53+GbkQhDnzK75qYQgMGSU4aDrVd
         C4F++mtNvQZq8gLgCEnXUu7ZadHnZTqZB4sKMf8gWPjUVwf4q0yRv3qRDZb0kQmcw0wZ
         wQYfR+IbYuvr51xUilB52IUxGuZpHT3LvKlxNUf7kQvtnY2YxGdIaQEZbOomtgYaQTib
         zBKLejGCUcc7Sf5zmdtYvbw5ZXaTEfwZQN+WKGCzBSbzGn1W6wNp6ZDJ52QF3ibpLdHg
         df//9+JzvGJGRuqvgVzIYedA1yDRs6+vnXxDi/vO2yAE2SLw8N/cbvKWcnMrCT/1LTUU
         G/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731988; x=1761336788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpPPOYob1QZnV0MVjnp55PhCGroJIJiVg+QyoFgvrb4=;
        b=YbmbfdO/JZXKYTmkdrhuFn6a0n/KOP/QBNvQkmISk7RC1k+QqJcM0mliNmZX4GREVw
         gBO7/wibDnPiSM6nfU0epzU270BJHQ+cB8mJqeDTx4PrpY+xpLixK13e/6yzXBVi6arj
         mVWv4HasLBhwWAMaQl7pgCvD0Fdef4xVqEmyNKOyNMHOS44CSWx2/tOJaJQWG/Kd3FCL
         i9Hs1hZqlZs4RcaunLoAYwTPsJ4O2sRNTFAKvtgBPt6Mcatc7ejVAQcK7AdkhmhGaiRP
         LHT2Na3stqXeca8PWipm09NGrcGKFvEpLBNBm/n2meFpKDTGp3WugH0KK1jTuY9kUS70
         OUkA==
X-Forwarded-Encrypted: i=1; AJvYcCUS4TKcV1X6uN4eHdYicEcfj7oG54yZwLqEeyPZL0zYkvQ+pVKtnXr3idneXkrcNxUHOMRO8hWk7f+YMyn/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/9fjB0fLNb8YZcJZBU/INmf+/GpOHXs2liOcGBjaFhlgyKNB
	kigmPUgSPaOBHPibAmEx4TMyOdtXpK10SuAq3FRAG8VWM1WjK5zsSP65HJBkXwpFm32ipCrYlg+
	ZuMMeaQlS/LRzqPn6LRqwpkJQvQ==
X-Google-Smtp-Source: AGHT+IFaVh5FLKaAG/q3ccs7S5CZUmyME95ySy5g2wu/pIuJKr9rpIYkO/d4uo4694WlqOqMAyATNgjBKMjQAO8boA==
X-Received: from pjbnl2.prod.google.com ([2002:a17:90b:3842:b0:33b:51fe:1a73])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:ec8b:b0:32e:d011:ea0f with SMTP id 98e67ed59e1d1-33bcf8f7280mr5551444a91.25.1760731988400;
 Fri, 17 Oct 2025 13:13:08 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:05 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <1869a0b8eaf867052c11a04fe1efb1442ba1897d.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 24/37] KVM: selftests: guest_memfd: Test precision of conversion
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

Enhance the guest_memfd indexing selftest to also verify the precision of
memory conversions between private and shared.

The existing test converted a single page within a multi-page mapping but
did not explicitly check the state of the surrounding pages after the
conversion loop.

Add checks to confirm that converting a single page from shared to private
only affects the target page. Iterate through all other pages in the
guest_memfd region to ensure they remain in their original shared state,
thus verifying that the conversion operation is precise and does not have
unintended side effects.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/guest_memfd_conversions_test.c    | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index b42b1b27cb727..43efe4af1403c 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -235,7 +235,8 @@ GMEM_CONVERSION_TEST_INIT_SHARED(init_shared)
 
 /*
  * Test indexing of pages within guest_memfd, using test data that is a multiple
- * of page index.
+ * of page index.  Also test the precision of conversion, that it does not
+ * affect surrounding pages.
  */
 GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
 {
@@ -255,12 +256,20 @@ GMEM_CONVERSION_MULTIPAGE_TEST_INIT_SHARED(indexing, 4)
 			test_shared(t, i, i * 2, i * 3, i * 4);
 	}
 
+	/* Confirm that only one page was converted */
 	for (i = 0; i < nr_pages; ++i) {
 		if (i == test_page)
-			test_convert_to_shared(t, i, i * 4, i * 5, i * 6);
+			test_private(t, i, i * 4, i * 6);
 		else
 			test_shared(t, i, i * 4, i * 5, i * 6);
 	}
+
+	for (i = 0; i < nr_pages; ++i) {
+		if (i == test_page)
+			test_convert_to_shared(t, i, i * 6, i * 7, i * 8);
+		else
+			test_shared(t, i, i * 6, i * 7, i * 8);
+	}
 }
 
 /*
-- 
2.51.0.858.gf9c4a03a3a-goog


