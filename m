Return-Path: <linux-fsdevel+bounces-32249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1429A2B81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 19:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8732E1F248C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 17:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD891E049D;
	Thu, 17 Oct 2024 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RLf9rHuK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ACF1E0085;
	Thu, 17 Oct 2024 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187722; cv=none; b=gxeAGk4nx3tYn0oF11jwcj1g2Mf1MGi+TOhUaBdCNKtiqoXsqkKfImHt0m12zxteHdi1IalngFs8p3ppr6y831/zbYUAnFzg0Hpxh33kx8lzt7F/5ywQwtrpIhJguLxH6VEELheo3fwDcbAFXcxTDycjvoCDmPUY8INRxOhz5kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187722; c=relaxed/simple;
	bh=Y9N3ZQVWfcsH53gJXLZS/tZseBaeZ4sCkFXOQ74XfjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jpmq3D0tG6G1ScvkQPuQw6YNQA5x4EVyd2h00STllOc55mFFvHu7uMJz/hF9o9rYApNz+tHfwsdkjTHRj3LoDykGO+y3kry/w9NS9YZ1ynZa9bpSMXhkChLZAEEBD/3q03Q2ZmkpC/5IaE35iJUbJSWI1j0S5V2UbNF059cxBEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RLf9rHuK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HHshVm016053;
	Thu, 17 Oct 2024 17:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vAtZ9j
	Wrijh6PsUWgaMk2LuM+jVG7BmLBCS0J4uEBYE=; b=RLf9rHuKFy6KSn54+ngTT0
	RkvzVYSdo3j7ybBeUYSS6bDTgm0dA+GkG0d63TEyI7GGyGTepQqeuWf4XYSbqTPY
	mJ45oE+PUGb6Cvixt9uSGZuoDwQbGF4JpNMRnGyhZaGJyFWuendoCuuUFPPrQ9IC
	kLKRel/CpJD4VJqxqyUfMsqw+FD3nayXzEgl7mtbGE+zns4REd5FW0hXrGGoQcTY
	TFn7nCuJVz9bJ97fh6BU4GBwPXTeIDFxQoDXbH6Rz4gnW3c1j2kixM/CMGN4noSK
	k1cVyRxP7kK6CxKThsuGjNvEeA+I07utmyst3A/VxRFOlxdF2SHdQ+01XmNjBiHA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ar0u4g3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 17:54:43 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49HHsgpf015961;
	Thu, 17 Oct 2024 17:54:42 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ar0u4g3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 17:54:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49HH6HfW006338;
	Thu, 17 Oct 2024 17:54:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4286517xdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 17:54:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49HHsXPP21168894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 17:54:33 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C8302004B;
	Thu, 17 Oct 2024 17:54:33 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7ADA20040;
	Thu, 17 Oct 2024 17:54:32 +0000 (GMT)
Received: from osiris (unknown [9.171.18.6])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Oct 2024 17:54:32 +0000 (GMT)
Date: Thu, 17 Oct 2024 19:54:31 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
        David Hildenbrand <david@redhat.com>, g@linux.dev,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, rppt@kernel.org, yosryahmed@google.com,
        Yi Lai <yi1.lai@intel.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v2 bpf] lib/buildid: handle memfd_secret() files in
 build_id_parse()
Message-ID: <20241017175431.6183-A-hca@linux.ibm.com>
References: <20241016221629.1043883-1-andrii@kernel.org>
 <a1501f7a-80b3-4623-ab7b-5f5e0c3f7008@redhat.com>
 <oeoujpsqousyabzgnnavwoinq6lrojbdejvblxdwtav7o5wamw@6dyfuoc7725j>
 <CAEf4BzZzctRsxQ7n42AJrm8XTyxhN+-ceE7Oz5jokz4ALqDekQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzZzctRsxQ7n42AJrm8XTyxhN+-ceE7Oz5jokz4ALqDekQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XtvCaoikFufyZS_nrstXfQ9G85UdXSuv
X-Proofpoint-ORIG-GUID: YFRQ8Yv4j6zSyAnh_V8Ly3weTxOz-J0e
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170121

On Thu, Oct 17, 2024 at 10:35:27AM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 17, 2024 at 9:35 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > On Thu, Oct 17, 2024 at 11:18:34AM GMT, David Hildenbrand wrote:
> > > As replied elsewhere, can't we take a look at the mapping?
> > >
> > > We do the same thing in gup_fast_folio_allowed() where we check
> > > secretmem_mapping().
> >
> > Responded on the v1 but I think we can go with v1 of this work as
> > whoever will be working on unmapping folios from direct map will need to
> > fix gup_fast_folio_allowed(), they can fix this code as well. Also it
> > seems like some arch don't have kernel_page_present() and builds are
> > failing.
> >
> 
> Yeah, we are lucky that BPF CI tested s390x and caught this issue.
> 
> > Andrii, let's move forward with the v1 patch.
> 
> Let me post v3 based on v1 (checking for secretmem_mapping()), but
> I'll change return code to -EFAULT, so in the future this can be
> rolled into generic error handling code path with no change in error
> code.

Ok, I've seen that you don't need kernel_page_present() anymore, just
after I implemented it for s390. I guess I'll send the patch below
(with a different commit message) upstream anyway, just in case
somebody else comes up with a similar use case.

From b625edc35de64293b728b030c62f7aaa65c8627e Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Thu, 17 Oct 2024 19:41:07 +0200
Subject: [PATCH] s390/pageattr: Implement missing kernel_page_present()

kernel_page_present() was intentionally not implemented when adding
ARCH_HAS_SET_DIRECT_MAP support, since it was only used for suspend/resume
which is not supported anymore on s390.

However a new bpf use case now leads to a compile error specific to
s390. Implement kernel_page_present() to fix this.

Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Closes: https://lore.kernel.org/all/045de961-ac69-40cc-b141-ab70ec9377ec@iogearbox.net
Fixes: 0490d6d7ba0a ("s390/mm: enable ARCH_HAS_SET_DIRECT_MAP")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/set_memory.h |  1 +
 arch/s390/mm/pageattr.c            | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/set_memory.h
index 06fbabe2f66c..cb4cc0f59012 100644
--- a/arch/s390/include/asm/set_memory.h
+++ b/arch/s390/include/asm/set_memory.h
@@ -62,5 +62,6 @@ __SET_MEMORY_FUNC(set_memory_4k, SET_MEMORY_4K)
 
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
+bool kernel_page_present(struct page *page);
 
 #endif
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 5f805ad42d4c..aec9eb16b6f7 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -406,6 +406,21 @@ int set_direct_map_default_noflush(struct page *page)
 	return __set_memory((unsigned long)page_to_virt(page), 1, SET_MEMORY_DEF);
 }
 
+bool kernel_page_present(struct page *page)
+{
+	unsigned long addr;
+	unsigned int cc;
+
+	addr = (unsigned long)page_address(page);
+	asm volatile(
+		"	lra	%[addr],0(%[addr])\n"
+		"	ipm	%[cc]\n"
+		: [cc] "=d" (cc), [addr] "+a" (addr)
+		:
+		: "cc");
+	return (cc >> 28) == 0;
+}
+
 #if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_KFENCE)
 
 static void ipte_range(pte_t *pte, unsigned long address, int nr)
-- 
2.45.2


