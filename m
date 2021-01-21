Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3862FEEA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 16:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732818AbhAUP3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 10:29:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48794 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbhAUNYC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:24:02 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LDDw4d043265;
        Thu, 21 Jan 2021 13:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=umojX43O9UL+jYD0gI/4zhN6/zL41ZdveCdmKKXIwBM=;
 b=pqEGV2pIOoYPSPnybD/fuGsJki4qKy0xpc1E9Y+8q/QFTbNTeUfUSqndtJYovCU+vWGz
 MigODdMtjCkXqF9MbTJs2RCTr5U+YK0AJUELQEADtvNq3VE/SSoCUnUCGSC+fHVugx82
 6HbvlcIGUMeK8uLEFlquZF9Ip+Hce3IAN0BDFw14tXbRjcS7YyKGL9brCe7AKgOgcCqd
 g0l9z2Yh5oSkdes/btHbn1FIagJ9/jhvks5IzVgpZsNJ22YgRVbqTmbcJxYe7BWovCR3
 wyG9mNYlyGRfPInXuSr7EHOFWbLZ1PatmjZvm4lWvEXwoE6Y7zZWdQuaJc9leLQGXLK/ 8A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3668qaf9tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 13:23:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LDFktF106733;
        Thu, 21 Jan 2021 13:21:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3668rexr63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 13:21:16 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10LDKZJD123118;
        Thu, 21 Jan 2021 13:21:16 GMT
Received: from gmananth-linux.oraclecorp.com (dhcp-10-166-171-141.vpn.oracle.com [10.166.171.141])
        by userp3030.oracle.com with ESMTP id 3668rexq88-4;
        Thu, 21 Jan 2021 13:21:16 +0000
From:   Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     viro@zeniv.linux.org.uk, matthew.wilcox@oracle.com,
        khlebnikov@yandex-team.ru, gautham.ananthakrishna@oracle.com
Subject: [PATCH RFC 3/6] dcache: add action D_WALK_SKIP_SIBLINGS to d_walk()
Date:   Thu, 21 Jan 2021 18:49:42 +0530
Message-Id: <1611235185-1685-4-git-send-email-gautham.ananthakrishna@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
References: <1611235185-1685-1-git-send-email-gautham.ananthakrishna@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210072
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

This lets skip remaining siblings at seeing d_is_tail_negative().

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
---
 fs/dcache.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index a506169..894e6da 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1320,12 +1320,14 @@ void shrink_dcache_sb(struct super_block *sb)
  * @D_WALK_QUIT:	quit walk
  * @D_WALK_NORETRY:	quit when retry is needed
  * @D_WALK_SKIP:	skip this dentry and its children
+ * @D_WALK_SKIP_SIBLINGS: skip siblings and their children
  */
 enum d_walk_ret {
 	D_WALK_CONTINUE,
 	D_WALK_QUIT,
 	D_WALK_NORETRY,
 	D_WALK_SKIP,
+	D_WALK_SKIP_SIBLINGS,
 };
 
 /**
@@ -1356,6 +1358,7 @@ static void d_walk(struct dentry *parent, void *data,
 		break;
 	case D_WALK_QUIT:
 	case D_WALK_SKIP:
+	case D_WALK_SKIP_SIBLINGS:
 		goto out_unlock;
 	case D_WALK_NORETRY:
 		retry = false;
@@ -1387,6 +1390,9 @@ static void d_walk(struct dentry *parent, void *data,
 		case D_WALK_SKIP:
 			spin_unlock(&dentry->d_lock);
 			continue;
+		case D_WALK_SKIP_SIBLINGS:
+			spin_unlock(&dentry->d_lock);
+			goto skip_siblings;
 		}
 
 		if (!list_empty(&dentry->d_subdirs)) {
@@ -1398,6 +1404,7 @@ static void d_walk(struct dentry *parent, void *data,
 		}
 		spin_unlock(&dentry->d_lock);
 	}
+skip_siblings:
 	/*
 	 * All done at this level ... ascend and resume the search.
 	 */
-- 
1.8.3.1

