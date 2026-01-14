Return-Path: <linux-fsdevel+bounces-73709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C41D1F273
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2244305A2F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB9726ED45;
	Wed, 14 Jan 2026 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="iKQhlnoR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.156.205.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FA23D7C8;
	Wed, 14 Jan 2026 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.156.205.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768398348; cv=none; b=PijDDjHKgMxVhwRM9dMy3/lVix6/Chya+0lRPQ7lWfNtsUssoRZ/cOrTfdMTXn1WrL2DLAzf4vwMty5zBWq7nlJhMmGMRM6+5AUB8dRnG7xu59YtPYUAOkUKxZsCTmuI+B6jGblicZzKT11MgXmE7PcuT/VPom6uGnEa4L+XjLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768398348; c=relaxed/simple;
	bh=iTcepoZIEaroqgR4DOSAWpMuowmG6/u/IWVaVFvVsdU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oiq2AIFryQvCVYEIF1vf1/iXa2z5hhS1BAVdQAyTppxA/lS7Y9D4Eg57k+J/UXSldV5idPH3do36zOC7Dh6ASioe54VE8D6KdoAeJGMI4e9CRKBwTu7gbgYqN+LgaTFrx/QXkRwAhOrHJNecZ5gNMHl3GpY4YWdCbSMl7t6P8fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=iKQhlnoR; arc=none smtp.client-ip=18.156.205.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1768398345; x=1799934345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DwK9FSlwBQuU4XKtXrxQXwU9sl3B3N2UH+rK7uUp150=;
  b=iKQhlnoRjNcRwH8nS2nOSi7HafiZPyY0qosG6lNYWEnG43qzMf3Cagll
   0DsovsOYE6i9cl1ix3ZQ4RCo5qx1GSmFsmglIdXruHIrppQbmiSLZOFij
   awtm/Koyllp1380s9Z9zhOB5kp7PQWBK2vq4evuR0hE8ZJKvg449j9qND
   0k0muLQYef9XjoiYteR97UNMLAkEb8WGbhfnp9yqhu0UAG4dTctDXTg0C
   Jx05jvphn3bBDg3N7daAmJFodEsNTbDoghTbczN49+8JifN/yrlE0Fq+a
   LmVIOK8PW5pEQND3dLehZnZkiWLDlQk6/bwmNK+jTv7TUP2cxQKDUuc0b
   w==;
X-CSE-ConnectionGUID: ADRkyAvURkCXCw3a2Bdf2g==
X-CSE-MsgGUID: EjV5CGptQgi+UwaC8hUurA==
X-IronPort-AV: E=Sophos;i="6.21,225,1763424000"; 
   d="scan'208";a="7586296"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:45:25 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:28749]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.28.56:2525] with esmtp (Farcaster)
 id 5afb6478-7936-4852-84d5-bdcc3b7d5c5a; Wed, 14 Jan 2026 13:45:25 +0000 (UTC)
X-Farcaster-Flow-ID: 5afb6478-7936-4852-84d5-bdcc3b7d5c5a
Received: from EX19D005EUB001.ant.amazon.com (10.252.51.12) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 14 Jan 2026 13:45:24 +0000
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19D005EUB001.ant.amazon.com (10.252.51.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 14 Jan 2026 13:45:23 +0000
Received: from EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c]) by
 EX19D005EUB003.ant.amazon.com ([fe80::b825:becb:4b38:da0c%3]) with mapi id
 15.02.2562.035; Wed, 14 Jan 2026 13:45:23 +0000
From: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel@xen0n.name" <kernel@xen0n.name>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org"
	<oupton@kernel.org>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org"
	<luto@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"willy@infradead.org" <willy@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com"
	<surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jannh@google.com" <jannh@google.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>, "shuah@kernel.org" <shuah@kernel.org>,
	"riel@surriel.com" <riel@surriel.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>,
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
	"prsampat@amd.com" <prsampat@amd.com>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com"
	<agordeev@linux.ibm.com>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "borntraeger@linux.ibm.com"
	<borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com"
	<gor@linux.ibm.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "pjw@kernel.org" <pjw@kernel.org>,
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "thuth@redhat.com"
	<thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com"
	<jackmanb@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack"
	<jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Subject: [PATCH v9 01/13] set_memory: add folio_{zap,restore}_direct_map
 helpers
Thread-Topic: [PATCH v9 01/13] set_memory: add folio_{zap,restore}_direct_map
 helpers
Thread-Index: AQHchVwI418o+7jue0CuccMT4sV6lg==
Date: Wed, 14 Jan 2026 13:45:23 +0000
Message-ID: <20260114134510.1835-2-kalyazin@amazon.com>
References: <20260114134510.1835-1-kalyazin@amazon.com>
In-Reply-To: <20260114134510.1835-1-kalyazin@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Nikita Kalyazin <kalyazin@amazon.com>=0A=
=0A=
These allow guest_memfd to remove its memory from the direct map.=0A=
Only implement them for architectures that have direct map.=0A=
In folio_zap_direct_map(), flush TLB on architectures where=0A=
set_direct_map_valid_noflush() does not flush it internally.=0A=
=0A=
The new helpers need to be accessible to KVM on architectures that=0A=
support guest_memfd (x86 and arm64).  Since arm64 does not support=0A=
building KVM as a module, only export them on x86.=0A=
=0A=
Direct map removal gives guest_memfd the same protection that=0A=
memfd_secret does, such as hardening against Spectre-like attacks=0A=
through in-kernel gadgets.=0A=
=0A=
Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>=0A=
---=0A=
 arch/arm64/include/asm/set_memory.h     |  2 ++=0A=
 arch/arm64/mm/pageattr.c                | 12 ++++++++++++=0A=
 arch/loongarch/include/asm/set_memory.h |  2 ++=0A=
 arch/loongarch/mm/pageattr.c            | 16 ++++++++++++++++=0A=
 arch/riscv/include/asm/set_memory.h     |  2 ++=0A=
 arch/riscv/mm/pageattr.c                | 16 ++++++++++++++++=0A=
 arch/s390/include/asm/set_memory.h      |  2 ++=0A=
 arch/s390/mm/pageattr.c                 | 18 ++++++++++++++++++=0A=
 arch/x86/include/asm/set_memory.h       |  2 ++=0A=
 arch/x86/mm/pat/set_memory.c            | 20 ++++++++++++++++++++=0A=
 include/linux/set_memory.h              | 10 ++++++++++=0A=
 11 files changed, 102 insertions(+)=0A=
=0A=
diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/s=
et_memory.h=0A=
index 90f61b17275e..d949f1deb701 100644=0A=
--- a/arch/arm64/include/asm/set_memory.h=0A=
+++ b/arch/arm64/include/asm/set_memory.h=0A=
@@ -14,6 +14,8 @@ int set_memory_valid(unsigned long addr, int numpages, in=
t enable);=0A=
 int set_direct_map_invalid_noflush(struct page *page);=0A=
 int set_direct_map_default_noflush(struct page *page);=0A=
 int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool vali=
d);=0A=
+int folio_zap_direct_map(struct folio *folio);=0A=
+int folio_restore_direct_map(struct folio *folio);=0A=
 bool kernel_page_present(struct page *page);=0A=
 =0A=
 int set_memory_encrypted(unsigned long addr, int numpages);=0A=
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c=0A=
index f0e784b963e6..a94eff324dda 100644=0A=
--- a/arch/arm64/mm/pageattr.c=0A=
+++ b/arch/arm64/mm/pageattr.c=0A=
@@ -357,6 +357,18 @@ int set_direct_map_valid_noflush(struct page *page, un=
signed nr, bool valid)=0A=
 	return set_memory_valid(addr, nr, valid);=0A=
 }=0A=
 =0A=
+int folio_zap_direct_map(struct folio *folio)=0A=
+{=0A=
+	return set_direct_map_valid_noflush(folio_page(folio, 0),=0A=
+					    folio_nr_pages(folio), false);=0A=
+}=0A=
+=0A=
+int folio_restore_direct_map(struct folio *folio)=0A=
+{=0A=
+	return set_direct_map_valid_noflush(folio_page(folio, 0),=0A=
+					    folio_nr_pages(folio), true);=0A=
+}=0A=
+=0A=
 #ifdef CONFIG_DEBUG_PAGEALLOC=0A=
 /*=0A=
  * This is - apart from the return value - doing the same=0A=
diff --git a/arch/loongarch/include/asm/set_memory.h b/arch/loongarch/inclu=
de/asm/set_memory.h=0A=
index 55dfaefd02c8..9bc80ac420a9 100644=0A=
--- a/arch/loongarch/include/asm/set_memory.h=0A=
+++ b/arch/loongarch/include/asm/set_memory.h=0A=
@@ -18,5 +18,7 @@ bool kernel_page_present(struct page *page);=0A=
 int set_direct_map_default_noflush(struct page *page);=0A=
 int set_direct_map_invalid_noflush(struct page *page);=0A=
 int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool vali=
d);=0A=
+int folio_zap_direct_map(struct folio *folio);=0A=
+int folio_restore_direct_map(struct folio *folio);=0A=
 =0A=
 #endif /* _ASM_LOONGARCH_SET_MEMORY_H */=0A=
diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c=0A=
index f5e910b68229..14bd322dd112 100644=0A=
--- a/arch/loongarch/mm/pageattr.c=0A=
+++ b/arch/loongarch/mm/pageattr.c=0A=
@@ -236,3 +236,19 @@ int set_direct_map_valid_noflush(struct page *page, un=
signed nr, bool valid)=0A=
 =0A=
 	return __set_memory(addr, 1, set, clear);=0A=
 }=0A=
+=0A=
+int folio_zap_direct_map(struct folio *folio)=0A=
+{=0A=
+	int ret;=0A=
+=0A=
+	ret =3D set_direct_map_valid_noflush(folio_page(folio, 0),=0A=
+					   folio_nr_pages(folio), false);=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+int folio_restore_direct_map(struct folio *folio)=0A=
+{=0A=
+	return set_direct_map_valid_noflush(folio_page(folio, 0),=0A=
+					    folio_nr_pages(folio), true);=0A=
+}=0A=
diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/s=
et_memory.h=0A=
index 87389e93325a..16557b70c830 100644=0A=
--- a/arch/riscv/include/asm/set_memory.h=0A=
+++ b/arch/riscv/include/asm/set_memory.h=0A=
@@ -43,6 +43,8 @@ static inline int set_kernel_memory(char *startp, char *e=
ndp,=0A=
 int set_direct_map_invalid_noflush(struct page *page);=0A=
 int set_direct_map_default_noflush(struct page *page);=0A=
 int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool vali=
d);=0A=
+int folio_zap_direct_map(struct folio *folio);=0A=
+int folio_restore_direct_map(struct folio *folio);=0A=
 bool kernel_page_present(struct page *page);=0A=
 =0A=
 #endif /* __ASSEMBLER__ */=0A=
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c=0A=
index 3f76db3d2769..2c218868114b 100644=0A=
--- a/arch/riscv/mm/pageattr.c=0A=
+++ b/arch/riscv/mm/pageattr.c=0A=
@@ -401,6 +401,22 @@ int set_direct_map_valid_noflush(struct page *page, un=
signed nr, bool valid)=0A=
 	return __set_memory((unsigned long)page_address(page), nr, set, clear);=
=0A=
 }=0A=
 =0A=
+int folio_zap_direct_map(struct folio *folio)=0A=
+{=0A=
+	int ret;=0A=
+=0A=
+	ret =3D set_direct_map_valid_noflush(folio_page(folio, 0),=0A=
+					   folio_nr_pages(folio), false);=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+int folio_restore_direct_map(struct folio *folio)=0A=
+{=0A=
+	return set_direct_map_valid_noflush(folio_page(folio, 0),=0A=
+					    folio_nr_pages(folio), true);=0A=
+}=0A=
+=0A=
 #ifdef CONFIG_DEBUG_PAGEALLOC=0A=
 static int debug_pagealloc_set_page(pte_t *pte, unsigned long addr, void *=
data)=0A=
 {=0A=
diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/set=
_memory.h=0A=
index 94092f4ae764..fc73652e5715 100644=0A=
--- a/arch/s390/include/asm/set_memory.h=0A=
+++ b/arch/s390/include/asm/set_memory.h=0A=
@@ -63,6 +63,8 @@ __SET_MEMORY_FUNC(set_memory_4k, SET_MEMORY_4K)=0A=
 int set_direct_map_invalid_noflush(struct page *page);=0A=
 int set_direct_map_default_noflush(struct page *page);=0A=
 int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool vali=
d);=0A=
+int folio_zap_direct_map(struct folio *folio);=0A=
+int folio_restore_direct_map(struct folio *folio);=0A=
 bool kernel_page_present(struct page *page);=0A=
 =0A=
 #endif=0A=
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c=0A=
index d3ce04a4b248..df4a487b484d 100644=0A=
--- a/arch/s390/mm/pageattr.c=0A=
+++ b/arch/s390/mm/pageattr.c=0A=
@@ -412,6 +412,24 @@ int set_direct_map_valid_noflush(struct page *page, un=
signed nr, bool valid)=0A=
 	return __set_memory((unsigned long)page_to_virt(page), nr, flags);=0A=
 }=0A=
 =0A=
+int folio_zap_direct_map(struct folio *folio)=0A=
+{=0A=
+	unsigned long addr =3D (unsigned long)folio_address(folio);=0A=
+	int ret;=0A=
+=0A=
+	ret =3D set_direct_map_valid_noflush(folio_page(folio, 0),=0A=
+					   folio_nr_pages(folio), false);=0A=
+	flush_tlb_kernel_range(addr, addr + folio_size(folio));=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+=0A=
+int folio_restore_direct_map(struct folio *folio)=0A=
+{=0A=
+	return set_direct_map_valid_noflush(folio_page(folio, 0),=0A=
+					    folio_nr_pages(folio), true);=0A=
+}=0A=
+=0A=
 bool kernel_page_present(struct page *page)=0A=
 {=0A=
 	unsigned long addr;=0A=
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_m=
emory.h=0A=
index 61f56cdaccb5..7208af609121 100644=0A=
--- a/arch/x86/include/asm/set_memory.h=0A=
+++ b/arch/x86/include/asm/set_memory.h=0A=
@@ -90,6 +90,8 @@ int set_pages_rw(struct page *page, int numpages);=0A=
 int set_direct_map_invalid_noflush(struct page *page);=0A=
 int set_direct_map_default_noflush(struct page *page);=0A=
 int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool vali=
d);=0A=
+int folio_zap_direct_map(struct folio *folio);=0A=
+int folio_restore_direct_map(struct folio *folio);=0A=
 bool kernel_page_present(struct page *page);=0A=
 =0A=
 extern int kernel_set_to_readonly;=0A=
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c=0A=
index 6c6eb486f7a6..3f0fc30eb320 100644=0A=
--- a/arch/x86/mm/pat/set_memory.c=0A=
+++ b/arch/x86/mm/pat/set_memory.c=0A=
@@ -2656,6 +2656,26 @@ int set_direct_map_valid_noflush(struct page *page, =
unsigned nr, bool valid)=0A=
 	return __set_pages_np(page, nr);=0A=
 }=0A=
 =0A=
+int folio_zap_direct_map(struct folio *folio)=0A=
+{=0A=
+	unsigned long addr =3D (unsigned long)folio_address(folio);=0A=
+	int ret;=0A=
+=0A=
+	ret =3D set_direct_map_valid_noflush(folio_page(folio, 0),=0A=
+					   folio_nr_pages(folio), false);=0A=
+	flush_tlb_kernel_range(addr, addr + folio_size(folio));=0A=
+=0A=
+	return ret;=0A=
+}=0A=
+EXPORT_SYMBOL_FOR_MODULES(folio_zap_direct_map, "kvm");=0A=
+=0A=
+int folio_restore_direct_map(struct folio *folio)=0A=
+{=0A=
+	return set_direct_map_valid_noflush(folio_page(folio, 0),=0A=
+					    folio_nr_pages(folio), true);=0A=
+}=0A=
+EXPORT_SYMBOL_FOR_MODULES(folio_restore_direct_map, "kvm");=0A=
+=0A=
 #ifdef CONFIG_DEBUG_PAGEALLOC=0A=
 void __kernel_map_pages(struct page *page, int numpages, int enable)=0A=
 {=0A=
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h=0A=
index 3030d9245f5a..8d1c8a7f7d79 100644=0A=
--- a/include/linux/set_memory.h=0A=
+++ b/include/linux/set_memory.h=0A=
@@ -40,6 +40,16 @@ static inline int set_direct_map_valid_noflush(struct pa=
ge *page,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static inline int folio_zap_direct_map(struct folio *folio)=0A=
+{=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static inline int folio_restore_direct_map(struct folio *folio)=0A=
+{=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static inline bool kernel_page_present(struct page *page)=0A=
 {=0A=
 	return true;=0A=
-- =0A=
2.50.1=0A=
=0A=

