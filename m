Return-Path: <linux-fsdevel+bounces-67352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0021DC3CBF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 18:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A3F5502AB1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DF934DCE0;
	Thu,  6 Nov 2025 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BWW9jnX7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CB32DAFD7;
	Thu,  6 Nov 2025 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448870; cv=none; b=KIRuxJnnWKPH0RIgzTsxNJyeAAF+9reD4CTBIa+631pL/8Hc2JVO4h2OwE//e2FQlpnI312dc+aBxMuqtvIPSO8bw7RJ0nVHDSFN2Mo6fFRXSAgp4weKmZp37XijX9pmEkyu2b6vrx3LOTTmbsHRfB3ChqN3gfRfMe8gad674S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448870; c=relaxed/simple;
	bh=mb7cfLou3to9TE/Rme3Rw2b8n7pHKZ0AGUd3pIBmR7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6AHa1GhCMnt9NmJZ9lDiyGEQE3r3jiMQUnHth70oNUbQXpNiYTdb6ta9G9XbhRTS43r0k1ELwFrSvG+vZTx83GSOJB6egoz3sshVb/wvGfcBrneUvl0uHXjoRunUXxrb2YOElToKlTpgW8PJaWj0b1vwhkS12V4WBMms37Q7uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BWW9jnX7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6H0St1031228;
	Thu, 6 Nov 2025 17:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ix+vz5Z3RJbr7r01y1AOS2oMatg1l
	mmqh5ZOfRC3hmg=; b=BWW9jnX7ERJ6LLVT7BYSunvXhzAAYeVcDaMEtdRdu1mnn
	w6KgpQA5SsPyiefdC+eeVV9kgC2LItID3NACETB+lq7HJJKAaJns6lnvnB46zed5
	e5lauBHhbC1MyQk2CuR4Kr4wg9uXKeouEAEAxuGj4hmgX8KLc78yA+cDLihOVb1U
	qBceMsfWscpv02OrIDfd/rb92H1/H60/WvkhuevyV35PL2/rUFkYA+4TIWBZEmUm
	nH0HDczxYqwxQme2sAdHeZEWqkNEF0xpBo8Gpdww1on26RsCob9RxPY1bTegcFRD
	14sS3eL8zQqu2kOm+zinmgOzIf0X21mrI4N2oameg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8yprg0y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 17:07:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6FoLse010788;
	Thu, 6 Nov 2025 17:07:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ncpawv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 17:07:36 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A6H7ZxZ007846;
	Thu, 6 Nov 2025 17:07:35 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a58ncpav3-1;
	Thu, 06 Nov 2025 17:07:35 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: [Patch 0/2] NFSD: Fix server hang when there are multiple layout conflicts
Date: Thu,  6 Nov 2025 09:05:24 -0800
Message-ID: <20251106170729.310683-1-dai.ngo@oracle.com>
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
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060137
X-Authority-Analysis: v=2.4 cv=fe+gCkQF c=1 sm=1 tr=0 ts=690cd5d9 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=iQKRUGprwFFxlDHd1zoA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: KjCYgNQG5DIUJpnYCKfbN9vihqZxS82i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzNCBTYWx0ZWRfX5BflJ6qP4qRk
 HoLWMCwhCW0r3TLt7ootFinZMc+T3jRjvayW3mVSTjGVym3tDprkp1ceZHRmql/BFr/pEt2eWgh
 5dOexBN0VV+Hl3jk7LOaUobWPPAKOTvXjm5njc4GRlg2B6utBigTsFolv4pscubgFJs95CpAEgH
 PBPXdLcbKSQLZSZiTha5FHOioXiJyWb3fZH6VaRngkgRLn3qoBH1imXSWeasGTNdaRJUU58GW2J
 qYRvUnFPwMATZXMV0S2YvCW+e2FRQyct6gt2TSt0YlOobMPfD5SWpiI80CPUsXgeRxHWSwtxf0x
 Y6pbSoLV9H3QjXmYI3vknR4lWEKAJ3kixf6xrT/6YJTT8sjdltcwR6xYkkvW+YbPpfed5QqMA/B
 LBkDFfZ2AIMS2CC/gNbW4KuNuGWjXg==
X-Proofpoint-GUID: KjCYgNQG5DIUJpnYCKfbN9vihqZxS82i

When a layout conflict triggers a call to __break_lease, the function
nfsd4_layout_lm_break clears the fl_break_time timeout before sending
the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
its loop, waiting indefinitely for the conflicting file lease to be
released.

If the number of lease conflicts matches the number of NFSD threads (which
defaults to 8), all available NFSD threads become occupied. Consequently,
there are no threads left to handle incoming requests or callback replies,
leading to a total hang of the NFS server.

This issue is reliably reproducible by running the Git test suite on a
configuration using SCSI layout.

This patchset fixes this problem by introducing the new lm_breaker_timedout
operation to lease_manager_operations and using timeout for layout
lease break.

 Documentation/filesystems/locking.rst |  2 ++
 fs/locks.c                            | 14 +++++++++++---
 fs/nfsd/nfs4layouts.c                 | 25 +++++++++++++++++++++----
 include/linux/filelock.h              |  2 ++
 4 files changed, 36 insertions(+), 7 deletions(-)


