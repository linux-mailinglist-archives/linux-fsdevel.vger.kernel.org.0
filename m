Return-Path: <linux-fsdevel+bounces-35596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C949D6323
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 18:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03943161196
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 17:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CEB1DFE17;
	Fri, 22 Nov 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J6u/19z1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531841DF971;
	Fri, 22 Nov 2024 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296619; cv=none; b=KhjGXYKzI2x5qwQUUTnZMVc2ATJlQ6Bit7lJVaXpyyGDJdCfFqlPjm5lft+ofdouPNnbrvQUimcOCDMhsuhjHPsQXf506Rja9ljV7poMO37/3WvMraaqDaAtv1eIfES8waMsyrXtd9eqq8TbbVs7HUGzAL+8e0nlWoAiQDQCDik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296619; c=relaxed/simple;
	bh=NP4UwV7v0F5OWwafmKBxrz1ZvzT7sYQGx0nqCDPo+1s=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=eRkJYEXK3f7M4lTzkzbNOcSSFeaFQd6HQbPP5sue817mJ8y4FnzlwMgq8WBTHjTp43Ea8GzXty0UXX1Uq06gEDk/MoSshbJqmN2+gLmAo0L6ptqcXRHqY0bDoJ3+k70hR+eQdO2s7AjIjMKWxZFPmklh5OciJb6i12Q6HcGoJ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J6u/19z1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMAMOeZ020697;
	Fri, 22 Nov 2024 17:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XQD1PU6ptvKeI0fuFGCRRH
	zhvac3i1byGnmnm5ZKMNQ=; b=J6u/19z19r8pbkyVFouVXseewIRW9lf/XXr5OY
	xMtAMdYaR3wbGrkPjNxVCsc/cdxs5Esu1wm8TydJwBef+M0BvxaSF9jfDpYnYmlX
	+NYxvkagKjvymiPGHp3V36XefLFtIiHUGHY/Ys1DKRbfZxyNxOWRWrkkGjOmYut3
	5juU7WFtSNtEhTnw2VmGVr6wOmeH4/e9RpCHAfnaZm6yKReEWAjAZdBKokIgW70C
	g0OKLCxgXEDYM5RhHvopGMf1BeBSEU3vCTaL6UwIS4NzDhtoXiTichlvFIgPmhfo
	vzmP+fYvX1Dvf3M28vvcC3EXX+mxASbVbFC4QPokrTRSClSw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431sv2nwj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 17:29:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AMHTgut021006
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 17:29:42 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 22 Nov 2024 09:29:41 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH v5 0/2] mm: Refactor KVM guest_memfd to introduce guestmem
 library
Date: Fri, 22 Nov 2024 09:29:37 -0800
Message-ID: <20241122-guestmem-library-v5-0-450e92951a15@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIG/QGcC/23NTQ6CMBCG4auQrq3pD7TUlfcwLqAMMImAttBIC
 He3kJhodPl+yTyzEA8OwZNTshAHAT0OfYzskBDbFn0DFKvYRDCRcs4FbSbwYwcdvWHpCjdTlUs
 lbSkMzxWJZ3cHNT538nKN3aIfBzfvH4Lc1jcmf7EgKaOa1xVAnimtyvNjQou9PdqhIxsX0g9Cs
 D9EGglmM6NrLaVh5ptY1/UFy5Xc0vUAAAA=
X-Change-ID: 20241112-guestmem-library-68363cb29186
To: Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>,
        "Fuad
 Tabba" <tabba@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        "Mike
 Rapoport" <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter
 Anvin" <hpa@zytor.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, Trond Myklebust <trondmy@kernel.org>,
        "Anna
 Schumaker" <anna@kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        "Martin
 Brandenburg" <martin@omnibond.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
CC: James Gowans <jgowans@amazon.com>, Mike Day <michael.day@amd.com>,
        <linux-fsdevel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <devel@lists.orangefs.org>, <linux-arm-kernel@lists.infradead.org>,
        "Elliot
 Berman" <quic_eberman@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F6Lm3BVFcc9UAbluTuBt_BvMDPNh2TaM
X-Proofpoint-ORIG-GUID: F6Lm3BVFcc9UAbluTuBt_BvMDPNh2TaM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=984 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220147

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

Changes in v5:
- Free all folios when the owner removes detaches the guestmem
- Link to v4: https://lore.kernel.org/r/20241120-guestmem-library-v4-0-0c597f733909@quicinc.com

Changes in v4:
- Update folio_free() to add address_space mapping instead of
  invalidate_folio/free_folio path.
- Link to v3: https://lore.kernel.org/r/20241113-guestmem-library-v3-0-71fdee85676b@quicinc.com

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
      filemap: Pass address_space mapping to ->free_folio()
      mm: guestmem: Convert address_space operations to guestmem library

 Documentation/filesystems/locking.rst |   2 +-
 MAINTAINERS                           |   2 +
 fs/nfs/dir.c                          |  11 +-
 fs/orangefs/inode.c                   |   3 +-
 include/linux/fs.h                    |   2 +-
 include/linux/guestmem.h              |  34 ++++++
 mm/Kconfig                            |   3 +
 mm/Makefile                           |   1 +
 mm/filemap.c                          |   9 +-
 mm/guestmem.c                         | 201 ++++++++++++++++++++++++++++++++++
 mm/secretmem.c                        |   3 +-
 mm/vmscan.c                           |   4 +-
 virt/kvm/Kconfig                      |   1 +
 virt/kvm/guest_memfd.c                |  98 +++++------------
 14 files changed, 290 insertions(+), 84 deletions(-)
---
base-commit: 5cb1659f412041e4780f2e8ee49b2e03728a2ba6
change-id: 20241112-guestmem-library-68363cb29186

Best regards,
-- 
Elliot Berman <quic_eberman@quicinc.com>


