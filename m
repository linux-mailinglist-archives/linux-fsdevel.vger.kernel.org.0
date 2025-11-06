Return-Path: <linux-fsdevel+bounces-67354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDEEC3CC08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 18:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46E7B4E4660
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 17:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75D834E760;
	Thu,  6 Nov 2025 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wy4v1JiQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1952BF3DF;
	Thu,  6 Nov 2025 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448871; cv=none; b=tpmF4fkPmz9qCaCpmrTlN3P5VNo27gpp2qBEt0cxPB3iigppdAM3PPhbGlbJk/hRx/mCwHtG3VYc71fuqMRnAHspkKzsgh7lIb7gqs9uU06++yOJ+Hjl3f0O+IRtu8jZJwaY9a9T+p7I3dbgutzMA7HfJdTqdQ2v9AB0yZq8krk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448871; c=relaxed/simple;
	bh=YkLNOMxwwBrdEM923v9aiNd7pFnoxYqTsQLteY+Gcl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8na7Ez6MeESCIkV/M3DzcBMJAwy8UvZmVBvLBGSeFUX8G/S86WZn7fuRh+zZnTMTWsa4imgWfzuXTfevBNJCUzV+zc4B/wX88CwRKOzATVxAcXtuAsgQbguDqJn1E7BUQC6T7gY7Xw8iPrjtxv8Zt1l9tkJrz/smyPlIDqj6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wy4v1JiQ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6H0KhH031117;
	Thu, 6 Nov 2025 17:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=AQ4HM
	Y/ATy5W4Q60Bc/7YUR1Ll7NeTFMi8TNiJv69dA=; b=Wy4v1JiQLPxWNIzZtubhe
	nAPugSYjI5IHSMmvWKN+j2/M3MF9HhSIhynFRESOzbqhw4GdyoiBLQRKj0edIOiy
	gJdUMwIv1QZSTXI/ZUSdEtESWnMoNwNBd+pXDzFxnwCcrpGubjvVaUjsJ2VfW7q5
	JsGgwDPIeapKM0p7WVT9KadknJr+mcu04gncLZtDRpPvy16vnDe2cogb6I7j8Dep
	p1YQKnNCuk52SZ17IxfBvZTz9pc5AEZW0XmygZF78WkAzSiZK0yDPoGtOlNhjWkN
	BaTe6Ibv8cwTLD3nfEjmUYYULB2i0bb39w9zN1HMow4TBCUh475BeD5jLVzuWG0b
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8yprg0y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 17:07:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6GDaXB010927;
	Thu, 6 Nov 2025 17:07:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ncpaye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 17:07:38 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A6H7Zxd007846;
	Thu, 6 Nov 2025 17:07:37 GMT
Received: from labops-common-sca-01.us.oracle.com (labops-common-sca-01.us.oracle.com [10.132.26.161])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a58ncpav3-3;
	Thu, 06 Nov 2025 17:07:37 +0000
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSD: Fix server hang when there are multiple layout conflicts
Date: Thu,  6 Nov 2025 09:05:26 -0800
Message-ID: <20251106170729.310683-3-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251106170729.310683-1-dai.ngo@oracle.com>
References: <20251106170729.310683-1-dai.ngo@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=fe+gCkQF c=1 sm=1 tr=0 ts=690cd5db cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=57DVBpu5xdd1SRTCfJcA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: maOhDLwifAih1_50AGZvC4WEVndlCyzn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzNCBTYWx0ZWRfX9VZIl1C5n/bA
 b7bQfnZMyA8Y7Kh9n1p8wuxB5jSj5Ete0dF+tegD9xJu03Epwr4x0vEBMcuv6FZTWaEnMDNg1pu
 IeybCZpmisyAinR2ogvpHI3SDB5RhTUBXKU4PMqx9cG3KvGx1yzWT3fPrymrlVIoKR7vc1j19RS
 X19cVNQR8ldfD9YqCzG1zaEdJyKjx702WmmlQIpLJTjGTNrYhtzvGu+E6Batgd87kPyzV96gI1P
 zpUjrEsBLnLz1iloS64puj8jMT/0K1Lawd+KDagYcOAIMGWnVC7Pzvld/hLPY52UnpOpovolu5X
 +ftix895wYAojkdTYZK/NyjLw3REJOi7RJ7+WRJmTp/jFtIQN/qMxh0tIfndHHMWhatFy+5LR4k
 nEDVOWoLp+aQs5xQkrxMH9+a1rlnUg==
X-Proofpoint-GUID: maOhDLwifAih1_50AGZvC4WEVndlCyzn

When a layout conflict triggers a call to __break_lease, the function
nfsd4_layout_lm_break clears the fl_break_time timeout before sending
the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
its loop, waiting indefinitely for the conflicting file lease to be
released.

If the number of lease conflicts matches the number of NFSD threads
(which defaults to 8), all available NFSD threads become occupied.
Consequently, there are no threads left to handle incoming requests
or callback replies, leading to a total hang of the NFS server.

This issue is reliably reproducible by running the Git test suite
on a configuration using SCSI layout.

This patch addresses the problem by using the break lease timeout
and ensures that the unresponsive client is fenced, preventing it from
accessing the data server directly.

Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4layouts.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 683bd1130afe..b9b1eb32624c 100644
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
@@ -764,9 +763,27 @@ nfsd4_layout_lm_change(struct file_lease *onlist, int arg,
 	return lease_modify(onlist, arg, dispose);
 }
 
+static void nfsd_layout_breaker_timedout(struct file_lease *fl)
+{
+	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
+	struct nfsd_file *nf;
+
+	rcu_read_lock();
+	nf = nfsd_file_get(ls->ls_file);
+	rcu_read_unlock();
+	if (nf) {
+		int type = ls->ls_layout_type;
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


