Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFCF30B1B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 21:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhBAUsp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 15:48:45 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35542 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBAUsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:48:43 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111KhTcH066273;
        Mon, 1 Feb 2021 20:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=o2MixFdZlwlNEQ1EG+IsGg5dAo+aZ7N0IY5pU/zVYuQ=;
 b=Qv8YGjMlcyeE2TSAKYGMF/0IMujceG7y2sb9YO78ernphXyizD4sC6PKyTjvEueVHLko
 HJ5CdOUDsdXn134MEySnG/+Rcbw/ISDZqSA2Ln+s/bAj9WMV9sHEhZ7GXKTqQ3y5u5aJ
 H8U3m+ZCScFX7H2VcddXhQ0GIwBCTdrYCPkRXo9Z58u6OovRcFMIBrqNdgdibL82QcUN
 ydou8Z0h3Ut/SWNmnSRDz11008tC3H0mis6OllZfvfau5fdvNC3UYieKfIW/z2xyMQJ8
 ZgDiVwlcVdfcWfgjWZWokCtkkpeVnw2Sitx7nRPhPo3b5vNB99qsK0oPY0JhLiQBCNnm iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36cvyaqqef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 20:48:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111KeBfS005739;
        Mon, 1 Feb 2021 20:48:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 36dh7qav02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 20:48:01 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 111Km05N037603;
        Mon, 1 Feb 2021 20:48:00 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3020.oracle.com with ESMTP id 36dh7qauy9-1;
        Mon, 01 Feb 2021 20:48:00 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH] vfs: generic_copy_file_checks should return EINVAL when source offset is beyond EOF
Date:   Mon,  1 Feb 2021 15:47:56 -0500
Message-Id: <20210201204756.74577-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010113
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix by returning -EINVAL instead of 0, per man page of copy_file_range,
when the requested range extends beyond the end of the source file.
Probem was discovered by subtest inter11 of nfstest_ssc.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/read_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 75f764b43418..438c00910716 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1445,7 +1445,7 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	/* Shorten the copy to EOF */
 	size_in = i_size_read(inode_in);
 	if (pos_in >= size_in)
-		count = 0;
+		count = -EINVAL;
 	else
 		count = min(count, size_in - (uint64_t)pos_in);
 
-- 
2.9.5

