Return-Path: <linux-fsdevel+bounces-13976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4FD875D19
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 05:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9D128214A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 04:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CC72CCB3;
	Fri,  8 Mar 2024 04:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M8sqMQqu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C463E2C1A6;
	Fri,  8 Mar 2024 04:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709871714; cv=none; b=SfaXByT8XPCCfjHF2nIkkmWf1VYNuH27uFt3VCLrZDUNLGHOskn1pLNwcJE95z6h9t1GhIj/Hr0Bnzgeh6lcHxWTBQjoO4IbhuPURnjYrsvj6c+fKMNA68WPgIkB5Ugei8ta4znOg22AAvUs709t2HJIfaoCTirqif2kAa/Ip0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709871714; c=relaxed/simple;
	bh=mmvy5azSDXUdowkCAJwabP8D5FIN7wVHZTgkJUorUzM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MyZaS9cyYCRfkLzjyVRHDe3qrlECQ7IWjhdJBqzqKw8UM0Fmlfcks60vXDYa4/x7aRonzfoohVtg0pEWVRBOQQMrXM82FXLQANtPzAE2LmeR26rQ30ee9WWwebi9pdlev/3oCMUeIlWHFzQWo5us+qd3QCIT5scRKaqLN3Dtoso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M8sqMQqu; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4281iD0k011677;
	Fri, 8 Mar 2024 04:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=r3Jellr22qKHaJrOAxSlScMDJSeEVcmcOkavqmzmZFY=;
 b=M8sqMQqu99cbQocSxLOE+VfcyScWk5Yzk6udXbYaDqFBlHRqiw4/WEIDC9vQKiZGN/El
 P1hpkD5nr/C00cgNjHjPs8LIzLUKtqoJciQRqbd00dSNIP33V2rqzJpbo+yodBE1cLeN
 LgFkaptOTe28aEjYGtbsbwVnkRipXd8ISgK5jaHQKjesImRMyTahiGuBUed3aV1oSGP1
 MyPIJkMjn0VJjICKf4C59eQyGqMGeO0vsi0fFX5QgBB1RnnM9LIi2hTEPVBxDBG96UKx
 gCiQ83TmiJGgErJpT29gKDz/Nzx4BV66pKbcIyHnq9QVHeC7iBtbXYVhDRqPq7bNUbpO eQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkvnv4yhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 04:21:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4282V5Bw016014;
	Fri, 8 Mar 2024 04:21:40 GMT
Received: from localhost.localdomain (dhcp-10-191-134-242.vpn.oracle.com [10.191.134.242])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3wktjc7afj-1;
	Fri, 08 Mar 2024 04:21:39 +0000
From: Imran Khan <imran.f.khan@oracle.com>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] eventpoll: record task that adds to monitor list.
Date: Fri,  8 Mar 2024 15:21:36 +1100
Message-Id: <20240308042136.2739321-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_02,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=899 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080031
X-Proofpoint-ORIG-GUID: EcklyHUXzSLfDqPZ-z_2W3r_y8bYcpH3
X-Proofpoint-GUID: EcklyHUXzSLfDqPZ-z_2W3r_y8bYcpH3

While debugging latency issues for task waiting on epoll_wait, sometimes
it becomes necessary to see if the lower layer is invoking ep_poll_callback
timely for a given pid or not.

Recording task_struct in involved eppoll_entry's wait_queue_entry, allows us
to check this using a probe (say dtrace) at this function.
We could also achieve this by checking wait_queue_entry on eventpoll's
wait_queue_head itself, but that would involve more indirections.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---

Since it just helps in debugging, I have kept the patch RFC.

 fs/eventpoll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3534d36a1474..3d4faf0a2d25 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1287,6 +1287,8 @@ static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead,
 	init_waitqueue_func_entry(&pwq->wait, ep_poll_callback);
 	pwq->whead = whead;
 	pwq->base = epi;
+	pwq->wait.private = current;
+
 	if (epi->event.events & EPOLLEXCLUSIVE)
 		add_wait_queue_exclusive(whead, &pwq->wait);
 	else
-- 
2.34.1


