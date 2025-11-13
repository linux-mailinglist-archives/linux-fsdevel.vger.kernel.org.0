Return-Path: <linux-fsdevel+bounces-68337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07679C58FE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BBBBD363694
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AB3364EA0;
	Thu, 13 Nov 2025 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ixNf22R8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9354C33BBCD;
	Thu, 13 Nov 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052067; cv=none; b=aAyTGyS9ednD2W73EvX3FNTsMHqLWP/mNxcdDyKlF6rjwj8nAQ/hqs7Uv/9dR8Ee0/Pokr6yYgP5ceyoFO3ymxRnwBHuj1qv/kXa044BIwqjHlcts5iQx+8VpkuaNxAgKrJvbuOFmpul+Xh/mbpmWWSpm0L3U11jQLCcGRJumMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052067; c=relaxed/simple;
	bh=iXHaB9Bv3KGI92weLEk6be+2chbCVJrhEJyBy9Ty3ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPMdHB49kU51Ph9vehchLjG7MKqp6uUEuXoouLRzaz5MYgCBXCrTEDXnkVpBlmKoQQnCA9gsh2WmIvejT/D5CUh/Twu2R7YI5EJmxUTAN8Zm+wfOD4IbP17IudZ/GWgso2Ypwk0c9tKuLZ9xC3Ns3GQz4yf9QLmrleci+Z6LeHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ixNf22R8; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADEAF5R006370;
	Thu, 13 Nov 2025 16:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=tkuxawbh2MRzSlQaPViDi23B6CtDH
	5nJoDytHtjQ04A=; b=ixNf22R8sjdliNhMZIDYsOLCtZIHDkamPWMo0sMUbyKQX
	F9ibWSoq346kKDjwdsSim5yEAZzz+HFuqN+x7y6hkEqOKwh6kg93K+9CvSGkE9k6
	J4oqGoQ3OMtj5GQxmrU45mtnav2cv4n5+OJiOXuW7M/TH0U5q3ejGDgEw4Ir9MjY
	zns6vXocL47q+1Dql1ENYiZ6j5pMCnFAdYKyzhOaLIn8S4sUI9Ay9jaK6JLq4FSA
	CY8lEovlLNt/0dN1edhP24VF3u4XH45wxgceV8dKKzI6PWedZlUhFC0j6ccKQe0N
	uscVz7wq2FbWwXVGakYpinrufRZUGamgvNuReDorQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyraa5dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:40:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADGA5MW003025;
	Thu, 13 Nov 2025 16:40:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacw4yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 16:40:50 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADGenxH039586;
	Thu, 13 Nov 2025 16:40:49 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacw4y7-1;
	Thu, 13 Nov 2025 16:40:49 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [Patch v2 0/2] NFSD: Fix server hang when there are multiple layout conflicts 
Date: Thu, 13 Nov 2025 08:39:14 -0800
Message-ID: <20251113164043.1809156-1-dai.ngo@oracle.com>
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
 definitions=2025-11-13_03,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE1MSBTYWx0ZWRfX7RF8HWMYw5YZ
 PjGXHMjzZs9frl1vM1hjkVGjXLdAXhU4qWaMHurNIfBZu3LzfWY6GXqcTPJAus//yEwAut5tjbn
 nOFZKPhB4BRscuNZlTCPcNW4kR0A9Ysm/2i65lXcauAeF0Zhn8/iBjWmrzLDyKapzoQs/qvqhfR
 oU3liru9xgkZPJhhvV4ticXTwjKzljwefn7xKLowxC1jVsiVQjNFCO9FnKRWQWtSBDCX+11emT2
 yHNkjvdggRdUV8t+mxSPJogQ4h7Ij8IsNIUykcHutnt6sAJ9hpJMCdWa8QodgtpZidRXQ+pl51/
 5QspdJor54AMFXZRZzjoI52GLE3pBk9YKHjhL1WEcVnR5RF0YW1DQEWgVWbC9w5J9LcsHCpta3O
 U5wra/GqK0+WBlZq/W+18CHJBj3mYw==
X-Proofpoint-GUID: 96z8q_82dFtwDkIO6iDqRxyne4XgxZNB
X-Authority-Analysis: v=2.4 cv=ILgPywvG c=1 sm=1 tr=0 ts=69160a13 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=FhaksxW9uHxgCJp66zcA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 96z8q_82dFtwDkIO6iDqRxyne4XgxZNB

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

 Documentation/filesystems/locking.rst |  2 ++
 fs/locks.c                            | 30 ++++++++++++++++++++++++++----
 fs/nfsd/nfs4layouts.c                 | 25 +++++++++++++++++++++----
 include/linux/filelock.h              |  4 ++++
 4 files changed, 53 insertions(+), 8 deletions(-)


