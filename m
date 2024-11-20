Return-Path: <linux-fsdevel+bounces-35353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5DB9D41E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 19:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD3F1F22AE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 18:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6972E1BC074;
	Wed, 20 Nov 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lFiAVJA/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425F31E515;
	Wed, 20 Nov 2024 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732126364; cv=none; b=rBntKq8+JdrBC7LnLyuTbVOTVTiJsAi53RB/K7gQDS72NSVcbPn/x2Q1e/I/DzE+E4WDtVlBwAPovsNsziCKZxT9w9ERqawMwo5vG9L4ca+SaUCq0DEMcYhBuCfmSP9Kj4lGN45VwFjNUErz+TGo+p4RSc9cQC9mU7xyY+3toe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732126364; c=relaxed/simple;
	bh=+GIAMTVbJ1ixJStHsEbMHlliDpePtNm2e3H3BFBrBvg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=BuBSytoEYYHrYO3fRfb8D8YZal6q9fIDOzf+LHY+2I6ewvAGseGfUokJwkQYI1bggVPPgpo0AvJbktfdp4QspT+VgFMDo7HK3oTYWrHuEfZq3eFvtZtmKADey0MHOig36lOK3BB3JH4qqV5x878+0YymFLDlUw/LQyxhdYGiWDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lFiAVJA/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK9GWxj025929;
	Wed, 20 Nov 2024 18:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EhNaM1mzvIH9f+QEUvvyQ1
	l0k56DBuV7rXs6Bl8yZT4=; b=lFiAVJA/Rqalps64p2UfO3u40nM1FzbsFDrJ1D
	THUltmdgjEBUEcKlBvuxBT2L8RhqW72MgoEeiz98N0J6C8mPYg8cR6IJf0+f5a1E
	tn5mRsV5pKw/Bh3OUJMieLY5YCiKa/a5ncxVEE55gFxUjhDWgXayN3LR4jWourMR
	NOrvqJV5nOCv8tx1a1G1Hyz7dVFc1p2B6uHYR0W+dcbkNKEaN+lXs278Ps71Leps
	93blNZDTZU8rDEECrj3D+MQXgIZYzyG1UKLcCs4FCuIWrWKFtk2uEvj88dHGcWNs
	vy9XkecfWSUdp49K2mX+KB1yhH6RzQ6rXArt9iwmDgJk8Q6Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431byjhkpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 18:12:15 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AKICEkM001246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 18:12:14 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 20 Nov 2024 10:12:13 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH v4 0/2] mm: Refactor KVM guest_memfd to introduce guestmem
 library
Date: Wed, 20 Nov 2024 10:12:06 -0800
Message-ID: <20241120-guestmem-library-v4-0-0c597f733909@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHcmPmcC/2WNwQ6CMBAFf4Xs2RraYqme/A/DgZYFNrGALTQSw
 r9bSTx5nEnevA0CesIAt2wDj5ECjUOC4pSB7euhQ0ZNYhC5KDjngnULhtmhY08yvvYrU1oqaY2
 4cq0gzSaPLb2P5KNK3FOYR78eD1F+7S8m/2NRspyVvG0Q9UWVytxfC1ka7NmODqp93z+32UyVs
 gAAAA==
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
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nd43uozb7EZ_SXIRUmbmgsxDVz64o2Pc
X-Proofpoint-ORIG-GUID: nd43uozb7EZ_SXIRUmbmgsxDVz64o2Pc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=954
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200125

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
 include/linux/guestmem.h              |  33 ++++++
 mm/Kconfig                            |   3 +
 mm/Makefile                           |   1 +
 mm/filemap.c                          |   9 +-
 mm/guestmem.c                         | 196 ++++++++++++++++++++++++++++++++++
 mm/secretmem.c                        |   3 +-
 mm/vmscan.c                           |   4 +-
 virt/kvm/Kconfig                      |   1 +
 virt/kvm/guest_memfd.c                |  97 +++++------------
 14 files changed, 283 insertions(+), 84 deletions(-)
---
base-commit: 5cb1659f412041e4780f2e8ee49b2e03728a2ba6
change-id: 20241112-guestmem-library-68363cb29186

Best regards,
-- 
Elliot Berman <quic_eberman@quicinc.com>


