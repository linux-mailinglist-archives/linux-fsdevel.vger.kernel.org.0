Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620B524337B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 07:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgHMFIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 01:08:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39026 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgHMFIE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 01:08:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07D57s6u153035
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 05:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2020-01-29;
 bh=fPIQyaMll5+IkFCsNc9dEYxthlTQ0JfccgdEqykt9Gs=;
 b=L5xCqVDZVbUX/gH9z9Ff6eLdrvBflmCt0p5DXk1nvUE3EPcnr6Z8weC9esASR/u49Xpp
 lDogW/YILkHu4tkSUuQbuqcY6Sb+v6lj4Ghk/KqFXZc0tmaaDfw4SjHZOkBwGwJdRaZu
 3CnFfnFeTUoozuMApJEFwBoHCm1aXJtx2KYsAa6/tVLKBsXOENckzr5xUjEl3DgZlN4o
 oAfTD6mC3BtdSPXfMzLg9vbpVIwmreOxrdT4bwTx5WtWndb/SaceTxPX1TCv9wrXOD1h
 IiIwngPSbOUHzgMlLkybqiFbdt/JcfhmIS2ztm/ZhsHTn9MfiBVgH164dTiBuUoSETFl /w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32sm0mxd9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 05:08:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07D52ati094219
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 05:06:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32t602sbnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 05:06:02 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07D561qa023664
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 05:06:01 GMT
Received: from jian-L460.jp.oracle.com (/10.191.2.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Aug 2020 05:06:00 +0000
From:   Jacob Wen <jian.w.wen@oracle.com>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] block: use DEFINE_WAIT_BIT instead of DEFINE_WAIT for bit wait queue
Date:   Thu, 13 Aug 2020 13:05:51 +0800
Message-Id: <20200813050552.26856-1-jian.w.wen@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9711 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=1 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9711 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015
 suspectscore=1 mlxlogscore=999 priorityscore=1501 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130039
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DEFINE_WAIT_BIT uses wake_bit_function() which is able to avoid
false-wakeups due to possible hash collisions in the bit wait table.

Signed-off-by: Jacob Wen <jian.w.wen@oracle.com>
---
 fs/block_dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0ae656e022fd..ba4fad08cdaf 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1062,12 +1062,12 @@ static int bd_prepare_to_claim(struct block_device *bdev,
 	/* if claiming is already in progress, wait for it to finish */
 	if (whole->bd_claiming) {
 		wait_queue_head_t *wq = bit_waitqueue(&whole->bd_claiming, 0);
-		DEFINE_WAIT(wait);
+		DEFINE_WAIT_BIT(wait, &whole->bd_claiming, 0);
 
-		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
+		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
 		spin_unlock(&bdev_lock);
 		schedule();
-		finish_wait(wq, &wait);
+		finish_wait(wq, &wait.wq_entry);
 		spin_lock(&bdev_lock);
 		goto retry;
 	}
-- 
2.17.1

