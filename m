Return-Path: <linux-fsdevel+bounces-20097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A558CE09E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 07:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787451F224E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 05:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637F57E76F;
	Fri, 24 May 2024 05:36:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A271CFB2;
	Fri, 24 May 2024 05:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716528984; cv=none; b=YuBzFusNZklyGrC/muC2+wSP0mkENrtJHwJtGkhO34q0MtRm256bz16n90q8MgO9LQDLwoH0mgdbeyaSLM97xhTrEfbZGcXNcF/rcvlMDYdRZhVtVQ0BjzXNVf5XwQZN5n6Y/aGn2CJew3sJ35FblKfdld4jJBcgzMGsKyyj4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716528984; c=relaxed/simple;
	bh=irFCw8KzMo+m6E4baCU+ZFCSYodoYiZd5YBrZZA2KFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gr1drXdMGPaQNI3lAlcZyohMJGf8RmGRleBuMPR0lzSIQ8tk4e+7juQj7iT6zr2r5NLrW/yP3sKpw7tBdgTxPcd7GyH/+yPOjzEhh7c2EyA55AdTEgrZE9txt88QburTi7AJR3GmLrByLWKS22QJApeczIrn0unvA0irI+6wU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44O4TOb6010895;
	Thu, 23 May 2024 22:36:01 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yaa8qrfg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 23 May 2024 22:36:00 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 22:36:00 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 22:35:58 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
CC: <brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>,
        <viro@zeniv.linux.org.uk>
Subject: [PATCH] netfs: if extracting pages from user iterator fails return 0
Date: Fri, 24 May 2024 13:35:57 +0800
Message-ID: <20240524053557.2702600-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
References: <0000000000002fd2de0618de2e65@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: q0rghB-4_wCA7zfprS5MaTJ-ifykiuLk
X-Proofpoint-ORIG-GUID: q0rghB-4_wCA7zfprS5MaTJ-ifykiuLk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_15,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1011 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240037

When extracting the pages from a user iterator fails, netfs_extract_user_iter()
will return 0, this situation will result in an abnormal and oversized return 
value for netfs_unbuffered_writer_locked() (for example, 9223372036854775807).

Therefore, when the number of extracted pages is 0, set ret to 0 and jump to out.

Reported-and-tested-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/netfs/direct_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 608ba6416919..d74761fb1876 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -69,7 +69,7 @@ static ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov
 		 */
 		if (async || user_backed_iter(iter)) {
 			n = netfs_extract_user_iter(iter, len, &wreq->iter, 0);
-			if (n < 0) {
+			if (n <= 0) {
 				ret = n;
 				goto out;
 			}
-- 
2.43.0


