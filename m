Return-Path: <linux-fsdevel+bounces-65694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D962C0D02E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 11:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9293A9E83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 10:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641082E8884;
	Mon, 27 Oct 2025 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mP4DIxCb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E05134BD;
	Mon, 27 Oct 2025 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761562034; cv=none; b=HO82Df0J+KdJKN3owLyNMyGo9c9Idiym7iHr+9ZsSsECJCQPLqIXfXcqbL8SeQOPK2AFgRwWL8ZK4h1nhCRVt+rt0glzrMsQE7bz/t07zOkDfm23j8TvFuuGb4sYHS19P3/D9OzP+DbKU8/flUp2uAx2JpzX2G11KAZTJJOoJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761562034; c=relaxed/simple;
	bh=gGZhkW7niLe2MdGyZToRUdXC6b+kReNd+C0HHnYXwL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qKGay3WdZhD0PZ57ueZdeE+YW2Nro2+vXq4Of26Y6RZrbCFpnnu8DnUv6BvkdP91GGFRLS421cp3qLwCqtp6rLnl5NvYpqbUBMju38kaDn8BPzBB3xDu6LUV27b5Nqj2FuZ3RiSzPKyU97ZtGdcWbJP4tew4nCnfPMyrwpaXves=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mP4DIxCb; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59R9CY3J027644;
	Mon, 27 Oct 2025 10:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=7PK0+k6b5JOoq377B50uv8yx7Vgfp
	66X5cOMfaPvDz0=; b=mP4DIxCbD3IMG/D9VJ+cO21iUU7RF8dpy+xXVvxO828mr
	m9DqzitbxNdCS/xFlvrwJ/hpzzJRO8fYHfqkZTMLkuBxFPD8kqHIfJmypMc+SQoI
	2CLbRpoTRB6+UwGXnkxiaP+trOITHgchS9d4xODyKS5rWlxfnfm+397mQI4DoZly
	JhJcjeaDRwCYU4Vl7UvDJwOmiuTeVy9M0AD60+8zjvAzXoPJjHU1jSl3Hc3h8c4h
	LLWUwJMrYeuXwyBGc7r99gfTN2dT41ar4A5H2WLKbPjotBo6ZkWh7nQPYIcr7zD8
	1BTbsqJdOvXaM9wo115jWjMRuPiR4T5Fyx8qp4F5Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0q3s31u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 10:47:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59R8Nu1J035013;
	Mon, 27 Oct 2025 10:47:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a19pe154u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 10:47:03 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59RAl2XP027073;
	Mon, 27 Oct 2025 10:47:02 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4a19pe1542-1;
	Mon, 27 Oct 2025 10:47:02 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: mgurtovoy@nvidia.com, izach@nvidia.com, smalin@nvidia.com,
        vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu,
        eperezma@redhat.com, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        alok.a.tiwari@oracle.com
Cc: alok.a.tiwarilinux@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] virtio-fs: fix incorrect check for fsvq->kobj
Date: Mon, 27 Oct 2025 03:46:47 -0700
Message-ID: <20251027104658.1668537-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270100
X-Proofpoint-ORIG-GUID: E0mEKcxnwKuoec3n6bjOLpgmyZIX9ddF
X-Proofpoint-GUID: E0mEKcxnwKuoec3n6bjOLpgmyZIX9ddF
X-Authority-Analysis: v=2.4 cv=Q57fIo2a c=1 sm=1 tr=0 ts=68ff4da8 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=WG1-RVo5mTiFFoM0DvIA:9 cc=ntf awl=host:12092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAzMSBTYWx0ZWRfX9YkLGvXJ3rES
 xVYaduPM96vexs5ZH4JS1RteCMiM0T3V5y9TLKHCJ5hcBllki/xZ0oQvxvadkhNSc3YpANm92se
 TE9sTnWqQUFm0oclU3lkaFkUdTgt3rkEipl9/qy9oI96btOCPbk8QdYUJ3bcRESuaNO/GZvqFmi
 LgBQAM4pn5K7zLxXrH6O2dmY2856Upi2MuPPPo3io6wcotU69aeQx4TqmhYFAUYEXQhJztfeTbR
 uH1vW8dXA1Ez8ZaDHLKKm9UXDfJg/HHqrMGfdo3xJZKfZO7qn3muSm2TeljvrLCqh4ccsNJ7x20
 W5c4zomi7rN2qos2Zlu2PCAUh7Fv5NW7qJ8pcxKjemGfAnGKJuhtXd7TZ4FFuxDAbODiE31OcjR
 7/tdZ09PeAHKRZgMVtH7jlGpyNYYy2I2DEB/p2fiVtI5kJjyOkE=

In virtio_fs_add_queues_sysfs(), the code incorrectly checks fs->mqs_kobj
after calling kobject_create_and_add(). Change the check to fsvq->kobj
(fs->mqs_kobj -> fsvq->kobj) to ensure the per-queue kobject is
successfully created.

Fixes: 87cbdc396a31 ("virtio_fs: add sysfs entries for queue information")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 fs/fuse/virtio_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 6bc7c97b017d..b2f6486fe1d5 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -373,7 +373,7 @@ static int virtio_fs_add_queues_sysfs(struct virtio_fs *fs)
 
 		sprintf(buff, "%d", i);
 		fsvq->kobj = kobject_create_and_add(buff, fs->mqs_kobj);
-		if (!fs->mqs_kobj) {
+		if (!fsvq->kobj) {
 			ret = -ENOMEM;
 			goto out_del;
 		}
-- 
2.50.1


