Return-Path: <linux-fsdevel+bounces-68567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 832D7C60A6B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 20:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 916B8359EFB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 19:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B160930AAD7;
	Sat, 15 Nov 2025 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nVqI4QLO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91942222584;
	Sat, 15 Nov 2025 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763235516; cv=none; b=qqIy5SL2fmeTMwk1vUaNbsKp2yiOb7KEW+YxXppbfvf9CwFVu9lSyq13DuR5XvGNGvYGSB43BUwJRL697XDRPoB5qlmV9PKVbFuqXetGezpw7qzEMH7hZaJms8cl1C6OUb34jF0iiHbkVYN08jB+3rJRzNFMT6CM8yEmyh8Vp04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763235516; c=relaxed/simple;
	bh=uKhoM8MN11qRW/J3bpspjisa5kWEI128HtTaOv11sbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XznwSUIBzlyeeGq0ubxy0qqidv85uQ0rBxnupOi7atZeb7AfaxGFMY1R1jO2EaoBWaIrC6iHhd+DUNnAvOsU4hl3fTBdq1Z3r3psQVXcrmWQIU0Wb6u5GSXu5Zw2RzksTHbMak2dQFyPih0Zkh6RHouqL4tihQsGsodt5JwR7ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nVqI4QLO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFJXUWW015908;
	Sat, 15 Nov 2025 19:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=JWcRSIb4k6DzUyZO98rMAh7yIQ/UM
	sDxtxy+qdmAN8s=; b=nVqI4QLOb80AonXTH/lSuAmEr681HuNkTnKQBFviwexWP
	GOa6B+jInptKEXOhAlvB0/6UuKQdUzyc95ETM9ryX175HccDRJHkGVdsmZAo274m
	9wxeo3M+qu2GFDTu8q+BEl22vWKjn+y8EbFFTI7a0XC17X/jjhnMerK0yHejOqRW
	FMjNTp9U+ii1y47nQsUyIwkZVy0gVoGt0+VDwtibA1obhNRnX8yObK9i8pvlLujf
	VmolftmxrJhZ1RR2WaTf6R+B5aNxhgDUURmTz9pMEqCfBRR1WG8/qqAkvI5DDnNg
	r+Qxqy/g5GpFgiLgX8Kroa152KVHhglSRPd1PR8+g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbpreq7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Nov 2025 19:38:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFJ11MT002461;
	Sat, 15 Nov 2025 19:17:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy68kfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Nov 2025 19:17:26 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AFJHPj0012081;
	Sat, 15 Nov 2025 19:17:25 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4aefy68kff-1;
	Sat, 15 Nov 2025 19:17:25 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [Patch v4 0/3] NFSD: Fix server hang when there are multiple layout conflicts
Date: Sat, 15 Nov 2025 11:16:36 -0800
Message-ID: <20251115191722.3739234-1-dai.ngo@oracle.com>
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
 definitions=2025-11-15_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511150159
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX0hcUu33LSxPX
 ZYXDsvewTpPCPKDyL7f+q+IAOHSAA7EeH0EEgOS78fox/9SpwOroE5bC9qLLXO4iAqks6OqowyH
 SxDohs4lnBERMWB2fE8D766rN2EuRi6kbBiVdpamIZT84BwZPkrTg57FZ4pXy/MDqKYrx8Et1aD
 FsTzPV5lQ/VI5tw45DrYB/XAi8iSbcld0+sUriLEN/YrKs3M6/FIwse3OZo1sNtnWHNOe/1cAPZ
 kxMLYByIkOp6kRsBF48juT+OTRf2REOe008WxrcoGNwdLg+yehIMb3KYwfQJjofnhAWEj+teyr5
 vY0dTIwrWu42nDRUifmXw0qzVN/KuSatBq3UxH+dgz516QVVCX2sYSYwROMHXZsebHEK9raP0Q2
 caKqQt+EoOv0geSSYttD5HvV9TlmSw==
X-Proofpoint-ORIG-GUID: Im5NoCDSTjEaLh0MmRqoyk-bt_3l30I4
X-Proofpoint-GUID: Im5NoCDSTjEaLh0MmRqoyk-bt_3l30I4
X-Authority-Analysis: v=2.4 cv=a+o9NESF c=1 sm=1 tr=0 ts=6918d6ab b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=rS3juFYI7g7JQA16c3QA:9

NFSD: Fix server hang when there are multiple layout conflicts

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
V4:
. (2/3) add wait_queue_head_t in file_lock_context for threads to wait
        until fencing is done.

 Documentation/filesystems/locking.rst |  2 ++
 fs/locks.c                            | 38 +++++++++++++++++++++++++++---
 fs/nfsd/nfs4layouts.c                 | 26 ++++++++++++++++----
 include/linux/filelock.h              |  7 ++++++
 4 files changed, 66 insertions(+), 7 deletions(-)

