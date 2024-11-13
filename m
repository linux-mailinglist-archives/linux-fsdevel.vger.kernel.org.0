Return-Path: <linux-fsdevel+bounces-34701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 622619C7E44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 23:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39C01F238CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 22:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F54F18C91E;
	Wed, 13 Nov 2024 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bvk4DMG2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E8A33CFC;
	Wed, 13 Nov 2024 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731537294; cv=none; b=N0A1N7aN7jKHNERLTLGyCtXpQyklx9+v6Xp6Xq06nNnQnTPgtENRj7OFryiUHLDKapbxOUxEVahlw6MOS9wJoZCLuKLADiAIIYhqjcBhAQrHxoVKjbV72hOt65nP/VQZQT8O4iJ6s8FtnSDD+nUq7RZOotZ4YxO+PvLuEhBzEcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731537294; c=relaxed/simple;
	bh=lCr4gDfzH8M2gwqQXfHWSLP0KTiPoCN6OrvQGWIuGaU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=m6YaU4Rm2E8TnNPkMQD1GulghwvgjII2IM+/TpSRDaGfNsM4AblqrPz8WXh/1OHv2u0nrur9kANr5oC06jbteEv4u9iC98eehXyp2iF4l825lrMvYWgCwqH+kUtv/oVNpkZtiAT2qtV9yIh22hRpm6CfGADxJiccs8ZwuQZ2WiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bvk4DMG2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADH1Xmi026885;
	Wed, 13 Nov 2024 22:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TGYFoQgLrHaKKvL0/25+aVVEULzKFimBMlOW1rCGOnI=; b=Bvk4DMG2itvq5EQR
	eTrHfjC8729o7GjceXKjac4hQeN/IvVzg7w3r8MmNz07s2lbgA3yY9C8l83gWU9E
	kTk+9UTVRPs2NwmDFVgE0/bGvcWtrNpowW/c+Ofo2KA3srrXpCOZz/FvCanevtfo
	Mfg3mP80NTN2Od5VVjwST//CLTc3800PgPpKIJE9DgJ4WBzN0VlPHdDn+wxkuUy5
	Aza8RZO6AEXuJ/3QhycVsvC5XfRMGCPrAccVzyZwljIX59VGoLf/nARQbxJFe741
	fKszmidbA/Kj2OLVV0jLP+751URfEUyI/TdiRDDpSki273oh0N2XpFJEge86F4XT
	ailrXQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vt731w70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 22:34:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ADMYd3q019845
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 22:34:39 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 13 Nov 2024 14:34:39 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Wed, 13 Nov 2024 14:34:36 -0800
Subject: [PATCH RFC v3 1/2] KVM: guest_memfd: Convert .free_folio() to
 .release_folio()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241113-guestmem-library-v3-1-71fdee85676b@quicinc.com>
References: <20241113-guestmem-library-v3-0-71fdee85676b@quicinc.com>
In-Reply-To: <20241113-guestmem-library-v3-0-71fdee85676b@quicinc.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>,
        "Fuad
 Tabba" <tabba@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        "Mike
 Rapoport" <rppt@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
CC: James Gowans <jgowans@amazon.com>, <linux-fsdevel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <linux-coco@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Elliot Berman <quic_eberman@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UG0i_TuQukSkwCJybahNRt05tvZ6Wd4j
X-Proofpoint-GUID: UG0i_TuQukSkwCJybahNRt05tvZ6Wd4j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130185

When guest_memfd becomes a library, a callback will need to be made to
the owner (KVM SEV) to transition pages back to hypervisor-owned/shared
state. This is currently being done as part of .free_folio() address
space op, but this callback shouldn't assume that the mapping still
exists. guest_memfd library will need the mapping to still exist to look
up its operations table.

.release_folio() and .invalidate_folio() address space ops can serve the
same purpose here. The key difference between release_folio() and
free_folio() is whether the mapping is still valid at time of the
callback. This approach was discussed in the link in the footer, but not
taken because free_folio() was easier to implement.

Link: https://lore.kernel.org/kvm/20231016115028.996656-1-michael.roth@amd.com/
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 virt/kvm/guest_memfd.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 47a9f68f7b247f4cba0c958b4c7cd9458e7c46b4..13f83ad8a4c26ba82aca4f2684f22044abb4bc19 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -358,22 +358,35 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 }
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-static void kvm_gmem_free_folio(struct folio *folio)
+static bool kvm_gmem_release_folio(struct folio *folio, gfp_t gfp)
 {
 	struct page *page = folio_page(folio, 0);
 	kvm_pfn_t pfn = page_to_pfn(page);
 	int order = folio_order(folio);
 
 	kvm_arch_gmem_invalidate(pfn, pfn + (1ul << order));
+
+	return true;
+}
+
+static void kvm_gmem_invalidate_folio(struct folio *folio, size_t offset,
+				      size_t len)
+{
+	WARN_ON_ONCE(offset != 0);
+	WARN_ON_ONCE(len != folio_size(folio));
+
+	if (offset == 0 && len == folio_size(folio))
+		filemap_release_folio(folio, 0);
 }
 #endif
 
 static const struct address_space_operations kvm_gmem_aops = {
 	.dirty_folio = noop_dirty_folio,
-	.migrate_folio	= kvm_gmem_migrate_folio,
+	.migrate_folio = kvm_gmem_migrate_folio,
 	.error_remove_folio = kvm_gmem_error_folio,
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-	.free_folio = kvm_gmem_free_folio,
+	.release_folio = kvm_gmem_release_folio,
+	.invalidate_folio = kvm_gmem_invalidate_folio,
 #endif
 };
 

-- 
2.34.1


