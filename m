Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE83530B1BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Feb 2021 21:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhBAUwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 15:52:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46772 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBAUwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:52:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111KoDfH075574;
        Mon, 1 Feb 2021 20:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=t3OPxfa0YXMc0Y8JjFBtLhAlAt3t5WwKoSmh17rqIiw=;
 b=CSFqSyZV5rouSb0VEaJkEAdfC6UxHOZIiq17Kdl3+YvnqRhO9NMELrYSH7tl+3U21eBx
 +7mYrdOqV/W9NWlVyvihxX7JhgzTK+TcH14hu/C2Jm5n+uZuSnA59xHJ6ARLXu+BibZq
 2XCYKBp72nnRXdEVizV0GbYI5O+ghPpyo+UgtiChVvDgL9jbYZ/doq7YGXscj+BGlyEn
 YHFrhjD9HsaiSxxx1JC44+9wiiKSBsegIacSICkJnW5NPdybGukX/5DGbbobkonfGlF/
 Pij2aT2m2XXI8EyJw+omX3YHKuFJyaKnGsjaa6hCoO50zUL942daedGvKPg6beAv/qqy Xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36cxvqyk56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 20:51:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 111KeVTr065495;
        Mon, 1 Feb 2021 20:49:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 36dhcvjncy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Feb 2021 20:49:55 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 111Kns34099914;
        Mon, 1 Feb 2021 20:49:54 GMT
Received: from aserp3020.oracle.com (ksplice-shell2.us.oracle.com [10.152.118.36])
        by userp3030.oracle.com with ESMTP id 36dhcvjncp-1;
        Mon, 01 Feb 2021 20:49:54 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v2] vfs: generic_copy_file_checks should return EINVAL when source offset is beyond EOF
Date:   Mon,  1 Feb 2021 15:49:52 -0500
Message-Id: <20210201204952.74625-1-dai.ngo@oracle.com>
X-Mailer: git-send-email 2.20.1.1226.g1595ea5.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010114
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix by returning -EINVAL instead of 0, per man page of copy_file_range,
when the requested range extends beyond the end of the source file.
Problem was discovered by subtest inter11 of nfstest_ssc.

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

