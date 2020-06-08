Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1BC1F1AC3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 16:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbgFHOQu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 10:16:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37280 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729969AbgFHOQt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 10:16:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058EGinr019012;
        Mon, 8 Jun 2020 14:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=hMtLnsxq3vYQ/tEpRoQzUmipcu6sgK4LnOH203zQx4E=;
 b=G0nx0Gf8Uh4VA+1LxkU7UFWjNI4PFoOuDQYk+OW8H7SPy0W34qSHbPUy+xkbj8j01ubd
 +4SD65KiM4eoppE+Ri8s2TKSZL+xv6doW5KSbuII4spO/MEE8/v4GiqSmlSATGelvH64
 HRdE5ysljtGBGKd+kj05ARJRLC00TUgVzLaUXQeoGj/UichKPpzLKQ90YpP9yN2ZoAzb
 avszYLXSbuPEbFog3QTn6cKPhg6wABjE8FmOYckPL3W2mFhhqJXfWO8swIKas+DS8GWh
 nhFg1nsXj4xAs9/f8YBNRnwpGC4JgiK1Kldl7dqBILudJ1Uk5HoLmxoeLbUrC1aYvyo6 tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31g33ky435-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 14:16:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058E4NNa057384;
        Mon, 8 Jun 2020 14:16:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 31gmwq0dyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 14:16:39 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 058EGaS2004302;
        Mon, 8 Jun 2020 14:16:37 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 07:16:36 -0700
Date:   Mon, 8 Jun 2020 17:16:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Tetsuhiro Kohada <kohada.t2@gmail.com>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] exfat: Fix pontential use after free in
 exfat_load_upcase_table()
Message-ID: <20200608141629.GA1912173@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 adultscore=0 spamscore=0
 cotscore=-2147483648 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080106
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This code calls brelse(bh) and then dereferences "bh" on the next line
resulting in a possible use after free.  The brelse() should just be
moved down a line.

Fixes: b676fdbcf4c8 ("exfat: standardize checksum calculation")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/exfat/nls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index c1ec056954974..57b5a7a4d1f7a 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -692,8 +692,8 @@ static int exfat_load_upcase_table(struct super_block *sb,
 				index++;
 			}
 		}
-		brelse(bh);
 		chksum = exfat_calc_chksum32(bh->b_data, i, chksum, CS_DEFAULT);
+		brelse(bh);
 	}
 
 	if (index >= 0xFFFF && utbl_checksum == chksum)
-- 
2.26.2

