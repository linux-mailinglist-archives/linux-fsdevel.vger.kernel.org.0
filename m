Return-Path: <linux-fsdevel+bounces-34702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761939C7E48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 23:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8626B25221
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 22:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F1518CBF0;
	Wed, 13 Nov 2024 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OfM8qVxx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3EF13959D;
	Wed, 13 Nov 2024 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731537294; cv=none; b=crVfvvTn+YAuYSGv8Oy5KsWwM2PZDToKwVcyCudv6rU8vNLjtpBWtVTTwBW94MedmsTR9gHjvFVGwYkSoJNeLVR3orXA+XgOlUa1mPQi4RFtpdsYrAYH0IHTvW2qv0I1s7BJ7Ztmxrri0ZhwG+nysf2YyAy78GMPF0KONrd/Fqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731537294; c=relaxed/simple;
	bh=AOVX+Q3LP2qMURxMX1tJm7ekf6MwcEHpxO8hdpqc/3s=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=r8YyPrOEGUhGzvNI4eiQid/afEJHmOwf4GmITcvGPTWlmIQpju0FT4acNNBOKAop0Xci1GxH6s5Yy56n2z287wF//Ng413kH/Yoyv1y7Me91e9Gics1+iHLOHD0UizGtDKOZ7XPTqCsYPpJS55eFOv2SDgMe1EmfcGqMFscLVpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OfM8qVxx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADHxknj027135;
	Wed, 13 Nov 2024 22:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BtXq4E+cGX3BSnPnoNAAsr
	KGpw88rLXe/Rc0cHF3mes=; b=OfM8qVxx9vlTJMtOL/p+eK5Y+FODNdCZt23nNE
	yQ2c4UragxbRFZpl4qqp4hNnfLtl1DvTI2su5t6rSN6Jc8IB0KUy7dD59rvRDRfO
	nT8FRtPrLYSnf0IpTBuo3ByIg9miORIpXKpr5g2ICMu3molFSXVO4bTKS37uRWVU
	4WtpMOy5WHlYraxXWhVR2XSZTlkaEiA59jplSK7bu7otnHVetlr8OAhBn+iBgQYj
	ZRMcZ9LOy4b5RwO+9TET/Ko0D6ubk9bUY9oRMX7LvUE6DFZxjRxDK3rQMQPoqDed
	ofTM8K+8PxK77KG3uhFqBnKDaJIMUWqZv8DNBNkWSD8CP3EQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42w10jrn10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 22:34:40 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ADMYdxo006632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 22:34:39 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 13 Nov 2024 14:34:38 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH RFC v3 0/2] mm: Refactor KVM guest_memfd to introduce
 guestmem library
Date: Wed, 13 Nov 2024 14:34:35 -0800
Message-ID: <20241113-guestmem-library-v3-0-71fdee85676b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHspNWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQ0Mj3fTS1OKS3NRc3ZzMpKLEokpdMwtjM+PkJCNLQwszJaC2gqLUtMw
 KsJHRSkFuzkqxtbUAnc24EmcAAAA=
X-Change-ID: 20241112-guestmem-library-68363cb29186
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
X-Proofpoint-ORIG-GUID: rGKUzBUjULE8r9lkutNxPo0AT6PlGYjw
X-Proofpoint-GUID: rGKUzBUjULE8r9lkutNxPo0AT6PlGYjw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=849
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130185

In preparation for adding more features to KVM's guest_memfd, refactor
and introduce a library which abtracts some of the core-mm decisions
about managing folios associated with guest memory. The goal of the
refactor serves two purposes:

1. Provide an easier way to reason about memory in guest_memfd. KVM
   needs to support multiple confidentiality models (TDX, SEV, pKVM, Arm
   CCA). These models support different semantics for when the host
   can(not) access guest memory. An abstraction for the allocator and
   managing the state of pages will make it eaiser to reason about the
   state of folios within the guest_memfd.

2. Provide a common implementation for other users such as Gunyah [1] and
   guestmemfs [2].

In this initial series, I'm seeking comments for the line I'm drawing
between library and user (KVM). I've not introduced new functionality in
this series; the first new feature will probably be Fuad's mappability
patches [3].

I've decided to only bring out the address_space from guest_memfd as it
seemed the simplest approach. In the current iteration, KVM "attaches"
the guestmem to the inode. I expect we'll want to provide some helpers
for inode, file, and vm operations when it's relevant to
mappability/accessiblity/faultability.

I'd appreciate any feedback, especially on how much we should pull into
the guestmem library.

[1]: https://lore.kernel.org/lkml/20240222-gunyah-v17-0-1e9da6763d38@quicinc.com/
[2]: https://lore.kernel.org/all/20240805093245.889357-1-jgowans@amazon.com/
[3]: https://lore.kernel.org/all/20241010085930.1546800-3-tabba@google.com/

Changes in v3:
 - Refactor/extract only the address_space
 - Link to v2: https://lore.kernel.org/all/20240829-guest-memfd-lib-v2-0-b9afc1ff3656@quicinc.com/

Changes in v2:
- Significantly reworked to introduce "accessible" and "safe" reference
  counters
- Link to v1: https://lore.kernel.org/r/20240805-guest-memfd-lib-v1-0-e5a29a4ff5d7@quicinc.com

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
Elliot Berman (2):
      KVM: guest_memfd: Convert .free_folio() to .release_folio()
      mm: guestmem: Convert address_space operations to guestmem library

 MAINTAINERS              |   2 +
 include/linux/guestmem.h |  33 +++++++
 mm/Kconfig               |   3 +
 mm/Makefile              |   1 +
 mm/guestmem.c            | 232 +++++++++++++++++++++++++++++++++++++++++++++++
 virt/kvm/Kconfig         |   1 +
 virt/kvm/guest_memfd.c   | 107 +++++++---------------
 7 files changed, 305 insertions(+), 74 deletions(-)
---
base-commit: 5cb1659f412041e4780f2e8ee49b2e03728a2ba6
change-id: 20241112-guestmem-library-68363cb29186

Best regards,
-- 
Elliot Berman <quic_eberman@quicinc.com>


