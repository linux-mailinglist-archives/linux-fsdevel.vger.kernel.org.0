Return-Path: <linux-fsdevel+bounces-68569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DD7C60A77
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 20:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 931B02424E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 19:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB56C30ACEC;
	Sat, 15 Nov 2025 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jR+RK3D6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50B222584;
	Sat, 15 Nov 2025 19:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763235579; cv=none; b=sxij0vl1Ma5cLqUm5N/iq+cw1JQURWMQ1H+ccHXjIUypZ3xE8WQqrjs3qicPsj5/G6CoxoL2PkHXToh5+SSUBM3ULa+oKId9VviKMFN1FjKBlywtuU7Odrwxt64CATXf6Ziipae9OyKrjxFbWevHmrgIhVzN/CQxokQXQ0RHZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763235579; c=relaxed/simple;
	bh=mtjJ6d5xWcz/tGV1mqXnRjgmimNDR8pj//50yJOyJPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnPHxgy7w+ZZQFDdbGJgXu1Wv+pL/djUtC0OvsR0qgGFy9fHmte9StAcYV9v6cGT2O3N5jm1cifiKSJM87w0fYrMCvDalJ+urCFsd+JXDDSG7+3sG+5iF1vygyckTJ2y2yyjQVVDLQGLniEvLXEfTitPm6cTXYVBG9X50ZSy2yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jR+RK3D6; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFJVwIi024838;
	Sat, 15 Nov 2025 19:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=llsUB
	9SAOpUFsh00LzqKkjuc/c4i0N+/vrynF3ht0PQ=; b=jR+RK3D6GbIGoJamxFbMO
	GzHn79cqzKbRIHGky75Sj954yqMfdFPAyeKItfJfTV3mBwxuuRn/gQeeW+4bnCmY
	n+W+hxaC0dmyGqNxQe4f1GnMHp0Er3F2F5/cGkDLAIsXD+2tNHZu/PddKHuXnsOp
	kGq0yeOsct+VZyNQsS6pSFZUaAx3WAlEdJTScK6mxeJkeAa2kSEmSYJlnDCajnlv
	ujtcD4pwWtZdFoOSjET8SZS+d4xk7JL1XOBZw+9H8jwniriaro503bxOxd2qitf6
	5dJstm4hm1O6GV6xtAcJh90AN4UPkGJBXp36vpY7ngQAN271g4PC+01WqP7qmEXy
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbugesa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Nov 2025 19:39:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFIpVgo002704;
	Sat, 15 Nov 2025 19:17:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy68kg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Nov 2025 19:17:28 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AFJHPj6012081;
	Sat, 15 Nov 2025 19:17:27 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4aefy68kff-4;
	Sat, 15 Nov 2025 19:17:27 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v4 3/3] FSD: Fix NFS server hang when there are multiple layout conflicts
Date: Sat, 15 Nov 2025 11:16:39 -0800
Message-ID: <20251115191722.3739234-4-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251115191722.3739234-1-dai.ngo@oracle.com>
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX5pq1jNG1lS63
 BkaXRALl7y9tXsgTdCS/a5YpRyE8GgC6urYNsJO+IroFnZB2lwNeeXig7lQE/FESvON7HFgc0JD
 S2WLptLicnAL/5uk0CQqSZFs/eK9S1PTBliLeVFSj/QtpcOjrlvpTPt5uepkilMAZhJZcs8WbvW
 x+hC386OO3esZvoA1wohRhG7xlTE3s9eQiZwXX1hh+OYgVzhukFuumZ94rY1IH+EIcDsdfqAgwC
 mhH9VMs1Pf3x50vCEiGxGPCiS3Fj2pIlJzHfdFgqHabOWQKO9ALxTv5nN1mW6zCEcKP4uTixWkP
 atcgX5BxUmWEXN6kgommdAUQukYqJ7Wu9F20YM98oOc3CwgD9rWIly4Jro8xEADMbqf4H3RzkSL
 OHwKgERPJxoorEWes5blRUbUT96BFQ==
X-Proofpoint-GUID: U0HeJ1rGX--INy-CSGASrNNB_cLucFZ1
X-Proofpoint-ORIG-GUID: U0HeJ1rGX--INy-CSGASrNNB_cLucFZ1
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=6918d6df b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=57DVBpu5xdd1SRTCfJcA:9

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


