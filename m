Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C6224328C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 04:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHMCqr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 22:46:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34982 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgHMCqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 22:46:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07D2cBkW091933
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 02:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2020-01-29;
 bh=94D0Z08M8ia3kF37oQV8UAw2rdoflPBE+8HAE5qkjEE=;
 b=fnqIf3zRpX3c4TIZeFpOZApBLdJHb/UqwYBWR6nRNgXGypooW9x1s+fgV/xUZ/HzxAjT
 LsJS0iCvGOGyEXWh2bOx6Y7uDtRV3nO+HP+BnoHw09NyArivMDSGaPxg6GJi4fmlIPdO
 bvq2eYWo/vB35cyzosZCofiwzbucid3N89KthJRqf+w/dhTU1ql133N0WMJ04Nx4c4ZC
 m9BAd9XBwWCU9Tk2+kB1IWQcEVi5iexzFvOtmOkWAN6vr5/MHCw2YiZcSVdUCxm8Ay0z
 H1L0VDXF7WD0QmSHrVSAohVEsvvx82UBK0KtvaYxI+k4W9yn9mKPPxOldoh7bAu2x9xw vA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32t2ydvecs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 02:46:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07D2hX78029786
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 02:44:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32u3h4jsvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 02:44:45 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07D2ijvt031286
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 02:44:45 GMT
Received: from jian-L460.jp.oracle.com (/10.191.2.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Aug 2020 02:44:44 +0000
From:   Jacob Wen <jian.w.wen@oracle.com>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] block: insert a general SMP memory barrier before wake_up_bit()
Date:   Thu, 13 Aug 2020 10:44:38 +0800
Message-Id: <20200813024438.13170-1-jian.w.wen@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9711 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=1 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9711 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=1 phishscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130017
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

wake_up_bit() uses waitqueue_active() that needs the explicit smp_mb().

Signed-off-by: Jacob Wen <jian.w.wen@oracle.com>
---
 fs/block_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0ae656e022fd..e74980848a2a 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1175,6 +1175,7 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
 	/* tell others that we're done */
 	BUG_ON(whole->bd_claiming != holder);
 	whole->bd_claiming = NULL;
+	smp_mb();
 	wake_up_bit(&whole->bd_claiming, 0);
 }
 
-- 
2.17.1

