Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C636C1F5A37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 19:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgFJRWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 13:22:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51510 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgFJRWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:22:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AHMS6Z148213;
        Wed, 10 Jun 2020 17:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=aL0a/xbCZCIDNKCgomY8AnMMHs27tbW+9lkiBuLKCj8=;
 b=UpNiHbMz/tLQlpq7JPOzoDd0XPh7Y0M44PoYbGoLOkesVOZ57Seiyd8TXQpmdCuW/4J9
 W2Dl9Ic/3H9r8Dxg6b42TMVDK+GXDLn801xoQl95WrSLXOcAPQ4m7kG/66SmPcT/Ul83
 M7ml/b/rh1w2ZbrDQOanQU3ZiyuJCToNees4GRiuNvZgM6SuMAQYFbRQ92egqEZ5CerQ
 rE0maflJjwXXNPgr3vxj5PwRNisWtkqYDu20XvCdYIyL4Rp8YIYF2BI4gpj0s07kTobT
 0ef5JLv5VXoxhV/jWcr3eJ4DPahM9SoOstZ3uxvZ1vYwIZahtiYoAc0qTwLfbUf6DRHw uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31g3sn3h8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Jun 2020 17:22:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05AHMQvU087955;
        Wed, 10 Jun 2020 17:22:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31gn29jd3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 17:22:27 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05AHMKkR030983;
        Wed, 10 Jun 2020 17:22:20 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Jun 2020 10:22:20 -0700
Date:   Wed, 10 Jun 2020 20:22:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Tetsuhiro Kohada <kohada.t2@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH v2] exfat: add missing brelse() calls on error paths
Message-ID: <20200610172213.GA90634@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6939014a-adbf-f970-2541-df16d35de7e5@web.de>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9648 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100133
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the second exfat_get_dentry() call fails then we need to release
"old_bh" before returning.  There is a similar bug in exfat_move_file().

Fixes: 5f2aa075070c ("exfat: add inode operations")
Reported-by: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: fix exfat_move_file() as well.  Also add a Fixes tag.

 fs/exfat/namei.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 5b0f35329d63e..edd8023865a0e 100644
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
@@ -1161,10 +1165,14 @@ static int exfat_move_file(struct inode *inode, struct exfat_chain *p_olddir,
 
 	epmov = exfat_get_dentry(sb, p_olddir, oldentry + 1, &mov_bh,
 		&sector_mov);
+	if (!epmov)
+		return -EIO;
 	epnew = exfat_get_dentry(sb, p_newdir, newentry + 1, &new_bh,
 		&sector_new);
-	if (!epmov || !epnew)
+	if (!epnew) {
+		brelse(mov_bh);
 		return -EIO;
+	}
 
 	memcpy(epnew, epmov, DENTRY_SIZE);
 	exfat_update_bh(sb, new_bh, IS_DIRSYNC(inode));
-- 
2.26.2

