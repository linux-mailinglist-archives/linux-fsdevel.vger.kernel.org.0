Return-Path: <linux-fsdevel+bounces-54073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799C5AFB06D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 11:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C204B3A73C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 09:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9340288502;
	Mon,  7 Jul 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CmbzWmke"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAFA1DE8BB
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751882149; cv=none; b=UH7LRGu3vkDzy4VRdWiGaXpbgz3MfHYZnGBJl1SJI0RZJeLwUXeCReNPuP5egRHyXz/8RaHXCR9zXKFLgYED2G+5xXeh2F2BDMxFpKjymie2yHdXafuo4ZpajDdV/N2BvFUEv2Sz4xx487vobBouNGNjIJ3WYb49BUwmUFi9nkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751882149; c=relaxed/simple;
	bh=OTx0j4p+xUhAI6jNGadtHX8O4Vsj02k7zVuRoXBDhAY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PTiG+xr7+fU+/F11hiFZkAhXhLkdvsnGY9IOoBNBmK8OHTBAPvpD5aqke8fs4vxIazVKEHu81H6R5Unxok/qPxR5JcXL8NL5jxyRu/iEuvqOqCyISz4dmilx5o85Xl+TqFsZqPMKcvPE/rz05vrjx2FcmfMQzZ0alr1U92jZ6Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CmbzWmke; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566JP9NA006587;
	Mon, 7 Jul 2025 09:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qbRC4GjIExmNGHGfoP5ptJFZP8CA1eevgpToaIVgb
	lI=; b=CmbzWmkeStMMn227GZih5GHJU5c7RL3X9YgXXKy9aL9W0hXYzAQaOxbBz
	pAr9vc6vTYmbNspLikc5WkTbYav1HFVy3qbn/+Q2YWwWaEAmBP47y1FQJ5oS97UT
	v42PdYV3BFdSMCjkCyAq7xzEfbXRlQFQXb4DfGZo7vMHs+R57mSIQJ9Wk8uDXHa8
	Qlu64zQBP5js7I529hwa0QeunWsqITCWLYWzwZes16tJL2ANROdt6+6Pop3qk+uk
	GA4FYMtrHS9ml5k1mm4cgLKOBo+l0ka9sATtbqBpaZb8xkSIJ9t9r5t6l59IIXGi
	mupCT3dxRCV7Agl5Qh7mA3bUxQIEw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk3rtye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 09:55:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5675SsIB013583;
	Mon, 7 Jul 2025 09:55:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkkn81w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 09:55:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5679tgP826673526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Jul 2025 09:55:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A1942004D;
	Mon,  7 Jul 2025 09:55:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 450CA20043;
	Mon,  7 Jul 2025 09:55:42 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Jul 2025 09:55:42 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: brauner@kernel.org, linux-fsdevel@vger.kernel.org
Subject: [BUG] linux-next: Signal handling and coredump regression in LTP coredump_pipe()
Date: Mon,  7 Jul 2025 11:55:39 +0200
Message-ID: <20250707095539.820317-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA1NiBTYWx0ZWRfXxdZ8/HgQnbRG zKk7XezHhGWsPqejb4SBO8HTx+lo9KeZHOzHYFdd4k3pPQN1tqTQHrUXwWcqgL3QIrgJt0vxIrf mqHEoLjJ76Fz5h6oEpYgG43Mv6gyeuOfWkoLVjnah+fz5vui7IbGZ8E66JtyZOY+3D5Jnl8U3uf
 PsPxWhYBHcfOaK+socEfz7fNNkGbfIbhWHZ/VyLfFCcBPE+wEsSNOAhhbSCMzB9DcoX37jzPrF8 QFZXjXA7pIX7HPfmm4Mbx85C4Bnhr0BsngyInYut/B6o3EfDycrVkvhzX3614r2xFjbx8VRQZKd kpmKqci/1HscxuLeIPYtymRCxuz0QypyL9mxC+gmQERqGuETHNF7sV0VxYA0bGbKgUFdVACs2kT
 8lxJs6Jr8nN4IRFM+a8R8ccqwbi3ikruTj8K3kWUfN9NFrVTUE9XnaUlhiJfRMwrWWUOLJ0Z
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=686b99a1 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=DNUl_grZHUUobedpFHoA:9
X-Proofpoint-ORIG-GUID: MQUH_hZ7LEQwbw-8oSeYL74VG9EUp21x
X-Proofpoint-GUID: MQUH_hZ7LEQwbw-8oSeYL74VG9EUp21x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_02,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1011
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070056

Hi all,

While testing the latest linux-next kernel (next-20250704), I encountered a
reproducible issue during LTP (Linux Test Project) runs related to signal
handling and core dumps.

The issue appears to be introduced by commit:

    ef4744dc9960 ("coredump: split pipe coredumping into coredump_pipe()")

This commit seems to contain a typo or logic error that causes several LTP tests
to fail due to missing or incorrect core dump behavior.

### Affected LTP tests and output:

- abort01:
    abort01.c:58: TFAIL: abort() failed to dump core

- kill11:
    kill11.c:84: TFAIL: core dump bit not set for SIGQUIT
    kill11.c:84: TFAIL: core dump bit not set for SIGILL
    kill11.c:84: TFAIL: core dump bit not set for SIGTRAP
    kill11.c:84: TFAIL: core dump bit not set for SIGIOT/SIGABRT
    kill11.c:84: TFAIL: core dump bit not set for SIGBUS
    kill11.c:84: TFAIL: core dump bit not set for SIGFPE
    kill11.c:84: TFAIL: core dump bit not set for SIGSEGV
    kill11.c:84: TFAIL: core dump bit not set for SIGXCPU
    kill11.c:84: TFAIL: core dump bit not set for SIGXFSZ
    kill11.c:84: TFAIL: core dump bit not set for SIGSYS/SIGUNUSED

- waitpid01:
    waitpid01.c:140: TFAIL: Child did not dump core when expected

Best regards,
Jan

Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
Only a suggestion for a fix:
 fs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 081b5e9d16e2..f4f7f0a0ae40 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1019,7 +1019,7 @@ static bool coredump_pipe(struct core_name *cn, struct coredump_params *cprm,
 	if (!sub_info)
 		return false;

-	if (!call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC)) {
+	if (call_usermodehelper_exec(sub_info, UMH_WAIT_EXEC)) {
 		coredump_report_failure("|%s pipe failed", cn->corename);
 		return false;
 	}
--
2.48.1


