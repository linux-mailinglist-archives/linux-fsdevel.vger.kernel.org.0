Return-Path: <linux-fsdevel+bounces-68405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3E2C5A89D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 00:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FF384E22FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 23:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7354F328B50;
	Thu, 13 Nov 2025 23:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T+e7CdLo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615A132825E;
	Thu, 13 Nov 2025 23:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763076340; cv=none; b=VGFDkApoOCpIFKNDIGbdQb9Qs9OmWm9U3vaMISOUOl+s8ZT3RufQRNz7c6NxIbU4K66WVzX0T28IuchnEKLvs3Mcu9dIDCoAfqSQywA6M7oeV3CtW7dKUlECs4xlSkNXHMlo8yF9uIRf9hcTBPoeyGiECe2Pvb5YKkbgPPRHPVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763076340; c=relaxed/simple;
	bh=mtjJ6d5xWcz/tGV1mqXnRjgmimNDR8pj//50yJOyJPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULmmHo5EEzS0YcGoHFCsDxTmuPLw+N6fLKqssQfbNE/vG/4Lt7NNAtUt9L9SfJ6BUh3Nm9YACOrEDitvI/2ag3tu0Rm5C0I4rUKOOYH9wfZusHhLE2EZPi3YoIEBmxCkTo2VZRunofN/3xqMul14vzjezsLzfUqLwoydtupgGoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T+e7CdLo; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADMaUb2006992;
	Thu, 13 Nov 2025 23:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=llsUB
	9SAOpUFsh00LzqKkjuc/c4i0N+/vrynF3ht0PQ=; b=T+e7CdLoTlEXMihosl6Iz
	8cv2g8il8kGNeOVgRCp5puZk6yTSafsPrQHKhZ97JGPZwOHuTvyUlgqAYFRGApAt
	cw5tskTdHJiHjIMxc3GedQl9SeCPxf6pAUiOr1mnEp5Q7yl4QFMWE4jecRUQv1ho
	0n17sZwNv/J8IuL9ZQdBSMJXqrU4/khLBrW/fDPilXvZhOW1XyHWWo8WIA1QPLgg
	8Z1RlyNUoV2kr9YdpE/zXhL6ZF9AiBuZ0EX+JmYIuYjAB3ZTbAYPu2GSm1V1SKGV
	JM5fnse3H2JUgrpbnpFjDWyGEg5BqJ0eflknFhIXvnMbCaRqRgWoflWN4zPmervn
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4adr8r81pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 23:25:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADM2AOO039056;
	Thu, 13 Nov 2025 23:25:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacsnk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 23:25:19 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5ADNPGuj035130;
	Thu, 13 Nov 2025 23:25:18 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9vacsnhm-4;
	Thu, 13 Nov 2025 23:25:18 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v3 3/3] FSD: Fix NFS server hang when there are multiple layout conflicts
Date: Thu, 13 Nov 2025 15:23:02 -0800
Message-ID: <20251113232512.2066584-4-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113232512.2066584-1-dai.ngo@oracle.com>
References: <20251113232512.2066584-1-dai.ngo@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OCBTYWx0ZWRfX7rFXvQrTYo72
 E//ZusBoCWr77Rt6XLKAqCRETjkpzqvvHjQ93HazHS0c4jlnph+ZXQ+63imtHoSEUw0ZeT+9IRO
 QHUbGMTmyi92yLI99MY5T6mhHyj+EpJ47DtsEQpbjscvvV9yvI/US1wB9ZHlSqMXMqNQCxNx4X/
 vbPCV2l+34+XdkTlVrYxp4xYS5dcW1yjMb6+a2f3uZ0rz8k3aIwM3eCUs1j8iPEmS9HBATH+GlW
 9VZnJBI4WQfYh3Caee/r/ExI6KG3X57rwTsU7/0Up0hF9NpADFDXRyasYCvh5dHhGdZO49i3AfG
 h5H7EBMfITpsfgaUZP+Jm7HG0QGEKArCYFMSzvrXxRGbKJHwit9ae1qvCUGBOc8TsRhD44ghvjG
 TZiaw/GceyMz8NtZimRYRyUDFObgxA==
X-Authority-Analysis: v=2.4 cv=FqEIPmrq c=1 sm=1 tr=0 ts=691668df cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=57DVBpu5xdd1SRTCfJcA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: LmDbGajPhBhxdgawV69A8lB0kFDA59XU
X-Proofpoint-GUID: LmDbGajPhBhxdgawV69A8lB0kFDA59XU

When a layout conflict triggers a call to __break_lease, the function
nfsd4_layout_lm_break clears the fl_break_time timeout before sending
the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
its loop, waiting indefinitely for the conflicting file lease to be
released.

If the number of lease conflicts matches the number of NFSD threads
(which defaults to 8), all available NFSD threads become occupied.
Consequently, there are no threads left to handle incoming requests
or callback replies, leading to a total hang of the NFSD server.

This issue is reliably reproducible by running the Git test suite
on a configuration using the SCSI layout.

This patch addresses the problem by using the break lease timeout
and ensures that the unresponsive client is fenced, preventing it
from accessing the data server directly.

Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4layouts.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 683bd1130afe..6321fc187825 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -747,11 +747,10 @@ static bool
 nfsd4_layout_lm_break(struct file_lease *fl)
 {
 	/*
-	 * We don't want the locks code to timeout the lease for us;
-	 * we'll remove it ourself if a layout isn't returned
-	 * in time:
+	 * Enforce break lease timeout to prevent starvation of
+	 * NFSD threads in __break_lease that causes server to
+	 * hang.
 	 */
-	fl->fl_break_time = 0;
 	nfsd4_recall_file_layout(fl->c.flc_owner);
 	return false;
 }
@@ -764,9 +763,28 @@ nfsd4_layout_lm_change(struct file_lease *onlist, int arg,
 	return lease_modify(onlist, arg, dispose);
 }
 
+static void
+nfsd_layout_breaker_timedout(struct file_lease *fl)
+{
+	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
+	struct nfsd_file *nf;
+
+	rcu_read_lock();
+	nf = nfsd_file_get(ls->ls_file);
+	rcu_read_unlock();
+	if (nf) {
+		u32 type = ls->ls_layout_type;
+
+		if (nfsd4_layout_ops[type]->fence_client)
+			nfsd4_layout_ops[type]->fence_client(ls, nf);
+		nfsd_file_put(nf);
+	}
+}
+
 static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
 	.lm_break	= nfsd4_layout_lm_break,
 	.lm_change	= nfsd4_layout_lm_change,
+	.lm_breaker_timedout	= nfsd_layout_breaker_timedout,
 };
 
 int
-- 
2.47.3


