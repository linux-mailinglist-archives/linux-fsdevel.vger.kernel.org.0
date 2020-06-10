Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2DE1F51BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 12:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgFJJ77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 05:59:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47556 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJJ77 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:59:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05A9gowQ123381;
        Wed, 10 Jun 2020 09:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=0a/U729/9KCMjjkSMy03/7Y7SeJTGruerYNr8e0q5DM=;
 b=PaCgYQOUDD2sAbpdyEkB/afye3qllfpdhd2wLAmxMjKKvJUKIFsn4i7sM7F87GrnSrOv
 tqmYqA32V2yfBc1qgLaG4wJeIFrTc/R2F3mbVRXysRg3IOrj0OKMmyjqQMjdz/H7y+z5
 Ui+Abme8N56LRJ+IKdejRGnUB95VmMXlK62efZmQFen6Yp9XuUIaYW9RrwH0mtjs0aMK
 FbbZTT5cftJGmqCO0JORpgLxeaOmWp12I2ACGpOlnZ1atstzbkPtfC0hZZALdKlXkgWU
 VJgDMstR6gDThIL9e2cv62e8U5xWzBXAefCprLvVT5wa2K0/EQgeCTdb6c9mDq2GNk1x dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31jepnubhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Jun 2020 09:59:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05A9gSIw025920;
        Wed, 10 Jun 2020 09:59:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31gmwsydwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 09:59:45 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05A9xg2X026069;
        Wed, 10 Jun 2020 09:59:42 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Jun 2020 02:59:41 -0700
Date:   Wed, 10 Jun 2020 12:59:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Tetsuhiro Kohada <kohada.t2@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH] exfat: call brelse() on error path
Message-ID: <20200610095934.GA35167@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <208cba7b-e535-c8e0-5ac7-f15170117a7f@web.de>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 cotscore=-2147483648 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006100074
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the second exfat_get_dentry() call fails then we need to release
"old_bh" before returning.

Reported-by: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/exfat/namei.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 5b0f35329d63e..fda92c824ff11 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1077,10 +1077,14 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 
 		epold = exfat_get_dentry(sb, p_dir, oldentry + 1, &old_bh,
 			&sector_old);
+		if (!epold)
+			return -EIO;
 		epnew = exfat_get_dentry(sb, p_dir, newentry + 1, &new_bh,
 			&sector_new);
-		if (!epold || !epnew)
+		if (!epnew) {
+			brelse(old_bh);
 			return -EIO;
+		}
 
 		memcpy(epnew, epold, DENTRY_SIZE);
 		exfat_update_bh(sb, new_bh, sync);
-- 
2.26.2

