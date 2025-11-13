Return-Path: <linux-fsdevel+bounces-68403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A18C5A88E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 00:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB89E3A2AA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 23:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8BF328605;
	Thu, 13 Nov 2025 23:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IpgFRC4+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E730CD95;
	Thu, 13 Nov 2025 23:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076340; cv=none; b=gtZJSRWWuWyR6bQh178ZG8ZPrQ3XXLbaPOm3/XT5T6y3krA4ffGzhQdBrfhdshQnYZIEDbQxQT3hjttWnxFpI6S+rzKHqk4byLGnl8CGJrw7BqeqdExTM52Cg1s/owH4anu1IQCeXDOtXAnutSY/dMmRRGx50R9X/FIjEdryu40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076340; c=relaxed/simple;
	bh=Q44FH8nEZSklAl/nsITfuf20Tja2HwHmgy385XTSodo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVsF4i0T08Hb9v92qWyacNPBoJsHAel6oN7GlL0RaiHUtWcJ+GWZALnGkMCo7aZDMnmOFZDsBGK7KltW/AITGD30cp+FBMX1QjRXTeg/P/+Ucltg3c2FBelnNGZJ96FOP4e0xtm/skhLF0TS08AZ7pDwi8OO42I/7dneR7ZS9pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IpgFRC4+; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADMa85G006424;
	Thu, 13 Nov 2025 23:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ZBJWhlRERiLRF+DMRxqYDNdTr0fKc
	xudSw6DcG92dj0=; b=IpgFRC4+SsdZKun8tG2LRbw4yN29aD8U9/l/BGp+L4Yvu
	ppbeo5q4QfGRTDeIcSj1Y9NB3Lx2wd3LjIzR1cXYzBpJCH/rW1CteVi4+Uso2G4x
	sN4EkQri1gZTc65Ul1CIaoX7CX7BsjWVrqPGDzgDWv5EALnucZDyjrer50aflR3N
	KeWIrAOWAe0ggYdDZBUi5VIomDV7G68cJlAQ4T9fHQ8hjn9wWvQlu8U/G3ohhJ+A
	qpHZUl544jZuNaFV6zkHi07SsSxoqbekuAE2DzL2eEaJ/WBzvK1LziIucmCjw02U
	PBcX/poxasKa2HhfOZQEgHjsTBLQ2UwegdKKCSmbg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8r81pr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 23:25:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADLdoZd039231;
	Thu, 13 Nov 2025 23:25:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacsnj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 23:25:16 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADNPGud035130;
	Thu, 13 Nov 2025 23:25:16 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacsnhm-1;
	Thu, 13 Nov 2025 23:25:16 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [Patch v3 0/3] NFSD: Fix server hang when there are multiple layout conflicts
Date: Thu, 13 Nov 2025 15:22:59 -0800
Message-ID: <20251113232512.2066584-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130184
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfXxxtP+L1k3ku8
 oZ48heX5g1MgnJPJaecVMgYYe4Qpecl3o5f8vTddLJBL3GTOmXfkiXRq3PQQqRSrVjO4jRBx8ou
 HltXs5UGDDCTANUkXv2/mF4X/536bm+pEJxAOL7997flPk25MtYWxJefgzzoOZBgsUdJHstOWD0
 GGCx0yL998KENnzh/NF8crQeC9AIxogtoXwswzjiilkFZwqWkuunMdu6LWtmFqarylzmnCxf/Aq
 vbBI/zGjRVp1Vz1REV/hNUEMNwOGFP0kE5edm2oLyAeDCjeiOOeRpLHz8r627Fm/PGVSWIZECNF
 3onVDpavYeJgOMWA8V+xiSOX01TiTa2Md3oQCiUzcNTPvYM9F6yfpAe4LqRde0RRm3todgna799
 LMzPlRrM1d3IMCzI+1PoMRPt5fNLRg==
X-Authority-Analysis: v=2.4 cv=FqEIPmrq c=1 sm=1 tr=0 ts=691668de cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=rS3juFYI7g7JQA16c3QA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: OItJjOEdwtzej-YlgF4_jitNChRoaR4a
X-Proofpoint-GUID: OItJjOEdwtzej-YlgF4_jitNChRoaR4a

When a layout conflict triggers a call to __break_lease, the function
nfsd4_layout_lm_break clears the fl_break_time timeout before sending
the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
its loop, waiting indefinitely for the conflicting file lease to be
released.

If the number of lease conflicts matches the number of NFSD threads (which
defaults to 8), all available NFSD threads become occupied. onsequently,
there are no threads left to handle incoming requests or callback replies,
leading to a total hang of the NFSD server.

This issue is reliably reproducible by running the Git test suite on a
configuration using the SCSI layout.

This patchset fixes this problem by introducing the new lm_breaker_timedout
operation to lease_manager_operations and enforcing timeout for layout
lease break.

V2:
. replace int with u32 for ls_layout_type in nfsd_layout_breaker_timedout.

. add mechanism to ensure threads wait in __break_lease for layout conflict
  must wait until one of the waiting threads done with the fencing operation
  before these threads can continue.

V3:
. break the patchset into 3 patches:
  (1/3) locks: Introduce lm_breaker_timedout operation to lease_manager_operations.
        No change from V1
  (2/3) locks: Threads with layout conflict must wait until the client was fenced.
        New patch: add synchronization in __break_lease to ensure threads with
        layout conflict must wait until the client was fenced.
  (3/3) NFSD: Fix NFS server hang when there are multiple layout conflicts
        Replace int with u32 for ls_layout_type in nfsd_layout_breaker_timedout

  I added the Fixes tag in (1/3 and (2/3) because they are needed by (3/3).
  All these patches must come together as one set.


 Documentation/filesystems/locking.rst |  2 ++
 fs/locks.c                            | 29 +++++++++++++++++++++++++----
 fs/nfsd/nfs4layouts.c                 | 26 ++++++++++++++++++++++----
 include/linux/filelock.h              |  4 ++++
 4 files changed, 53 insertions(+), 8 deletions(-)


