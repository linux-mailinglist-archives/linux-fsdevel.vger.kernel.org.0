Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F54B243378
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 07:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgHMFGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 01:06:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32784 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgHMFGF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 01:06:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07D52etY057347
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 05:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=zOWNouboW/aM9kWS9OnskKprO5d6i506rwn0AqsgqVg=;
 b=qGsUFNRuagLGwanpdTUn9COBHP9MgSTz42d9iTn6cBhDUFaTeCzRzHYQT01qw8rgK6mw
 8Kh3Zsjfz4EJO52C+tbv2of8yY/q30OMDsr+eiefafoHIWcloCY2El9tYg001hNwWZaZ
 m4Z1slKGqqXOgqE5u615cpv26H6APdw9SZ36fMF7di+rgX87QETGr8T1pJ/NfFIfsZB6
 KRz6K8fNaR2yy/o+fN9KmXW5Xsb03WmUQND1hDDAKY20ty2o7lM6c7WQXL/jbkBqvxNi
 51SfsB4gZqulPoR4kkYQ/HoRPgcKaiBNyYNNCd1vX5yDveY0AvS+o2WmhdxonLFYDWAB qw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32smpnpbwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 05:06:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07D53Y8w062071
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 05:06:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32u3h4puct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 05:06:03 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07D562fO023667
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 05:06:02 GMT
Received: from jian-L460.jp.oracle.com (/10.191.2.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Aug 2020 05:06:02 +0000
From:   Jacob Wen <jian.w.wen@oracle.com>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] writeback: use DEFINE_WAIT_BIT instead of DEFINE_WAIT for bit wait queue
Date:   Thu, 13 Aug 2020 13:05:52 +0800
Message-Id: <20200813050552.26856-2-jian.w.wen@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200813050552.26856-1-jian.w.wen@oracle.com>
References: <20200813050552.26856-1-jian.w.wen@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9711 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=1 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9711 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130038
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DEFINE_WAIT_BIT uses wake_bit_function() which is able to avoid
false-wakeups due to possible hash collisions in the bit wait table.

Signed-off-by: Jacob Wen <jian.w.wen@oracle.com>
---
 fs/fs-writeback.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a605c3dddabc..3bf751b33b48 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1354,16 +1354,16 @@ void inode_wait_for_writeback(struct inode *inode)
 static void inode_sleep_on_writeback(struct inode *inode)
 	__releases(inode->i_lock)
 {
-	DEFINE_WAIT(wait);
+	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_SYNC);
 	wait_queue_head_t *wqh = bit_waitqueue(&inode->i_state, __I_SYNC);
 	int sleep;
 
-	prepare_to_wait(wqh, &wait, TASK_UNINTERRUPTIBLE);
+	prepare_to_wait(wqh, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
 	sleep = inode->i_state & I_SYNC;
 	spin_unlock(&inode->i_lock);
 	if (sleep)
 		schedule();
-	finish_wait(wqh, &wait);
+	finish_wait(wqh, &wait.wq_entry);
 }
 
 /*
-- 
2.17.1

