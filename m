Return-Path: <linux-fsdevel+bounces-11968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C47AE859AA5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 03:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642AE1F20CD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 02:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68CE1FDB;
	Mon, 19 Feb 2024 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dfl9+CHh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC0D1FA3
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 02:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708308721; cv=none; b=Ud2t4feyHFSihoyHZvMm0lC7GiGQW+C2OLONrDT0s61oHwlngg6D3BHr9jZUI0zxPE0hyqodh17rfiK9//XUA+2LN+mP7etsISn35M0Ah0qqag+N9cVxwKAwnbBGBmIYHxas6uGrL6ZB4Mr4GgSqjV1kezfbQJPEPppXgANtSSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708308721; c=relaxed/simple;
	bh=foDXcE8AQIVgf8zNBAtJxrl/QCj3Mxl+ldQYrYCEiDo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ukq2IHV/qQwCA46jsAtueQ/BtcM3Kt3pKaLn2GSBMslJ90/lVrZ5w317iCGdN/PNbHFllNdZNQnK8lRAUJ++gQO3AYodMBWA8oUkzNh1UsSZMWfW2RssZH9qNVIDJVl2D0bNPv++wrXpj8Kwuz+QjlVepFRryB2eqxEIn4NiSuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dfl9+CHh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41J16e0M027087;
	Mon, 19 Feb 2024 02:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=vP3YmMR
	yprsla96yQCYLMk5FXkbXxSTW6XNDsbCj1Ek=; b=Dfl9+CHhi3g+BDAuBXQZlL6
	mSuDxIgfhae2ulkzDG2nIggRZQqROL3ZN8XDc7rUqh/PlAUNeNQ49rRcqFk25z43
	Xiq6hj305wE95oaB0sA3oMmgsdtVP2Q7FOvMoRAkoa8YYWj7VDxIr/Q1i0GqUohK
	7nh/htQvPaMg8eigXceYWDEi1BkWqm8ncmxRN/n5od/hDf78VCGc01L1JiPitnjc
	oxslXqhWLFVjlmOyrN+H5aQY305SdVOrSm4aVhI50lPt9uex4jjl8C2FaHmnsM6n
	M2fqnYU1L/KmujxvnYf5CHzGgFBqWZ9blziZHXeUuC0a0tvSEOPXSxFv9opRyJA=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wav1at3kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 02:11:56 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41J2Bui6019205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 02:11:56 GMT
Received: from maow2-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 18 Feb 2024 18:11:54 -0800
From: Kassey Li <quic_yingangl@quicinc.com>
To: <brauner@kernel.org>, <djwong@kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <quic_yingangl@quicinc.com>
Subject: [PATCH] iomap: Add processed for iomap_iter
Date: Mon, 19 Feb 2024 10:11:38 +0800
Message-ID: <20240219021138.3481763-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Wa-CfATY8VMAoWedZetXe-5I86NxBz7M
X-Proofpoint-GUID: Wa-CfATY8VMAoWedZetXe-5I86NxBz7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-18_21,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=860 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402190016

processed: The number of bytes processed by the body in the
most recent  iteration, or a negative errno. 0 causes the iteration to
stop.

The processed is useful to check when the loop breaks.

Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
 fs/iomap/trace.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index c16fd55f5595..ff87ac58b6b7 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -165,6 +165,7 @@ TRACE_EVENT(iomap_iter,
 		__field(u64, ino)
 		__field(loff_t, pos)
 		__field(u64, length)
+		__field(s64, processed)
 		__field(unsigned int, flags)
 		__field(const void *, ops)
 		__field(unsigned long, caller)
@@ -174,15 +175,17 @@ TRACE_EVENT(iomap_iter,
 		__entry->ino = iter->inode->i_ino;
 		__entry->pos = iter->pos;
 		__entry->length = iomap_length(iter);
+		__entry->processed = iter->processed;
 		__entry->flags = iter->flags;
 		__entry->ops = ops;
 		__entry->caller = caller;
 	),
-	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx length 0x%llx flags %s (0x%x) ops %ps caller %pS",
+	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx length 0x%llx processed %lld flags %s (0x%x) ops %ps caller %pS",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		   __entry->ino,
 		   __entry->pos,
 		   __entry->length,
+		   __entry->processed,
 		   __print_flags(__entry->flags, "|", IOMAP_FLAGS_STRINGS),
 		   __entry->flags,
 		   __entry->ops,
-- 
2.25.1


