Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7984C79DCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfG3BSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:18:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:32954 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfG3BSE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:18:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U18aVI095483;
        Tue, 30 Jul 2019 01:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=g9c2RncZ7+p19tL7qo1Ya21k4WOi7/ov7/QwLqXzV6A=;
 b=yTYIwKoR5mIzYeuT4zpkrEvCb9//jDDnTafQopVWPtbkccVsmJ9m8fk/pBT0YlKXVZ2Z
 7NAbX/t7zvcRYEArm1MoS1SpO2fk5hAZh8F2SKT1e5TYgK4xD6rXsasa+pZCLVHivYsl
 O6X0odK6zslYED4e30QHGNBVNMUSP65t+ap3WsqjAbgZUk4v8i+bVGAQZs4IqtS7pcAG
 GihsLjdKogp+U6+t5l7OZm0D/dXfB7H3zBxy50+2A55scxlZ3h53ZJMBVLgtHup1w8Ve
 EYfDCh2uM4VNa7AW0gNZTEaKSoAi+fYLUqbFz48L1dKWGrIt74z0eijHA+gjqq2/HAfj RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2u0ejpb0eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:17:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U1D9dl033949;
        Tue, 30 Jul 2019 01:17:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2u0dxqmrfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:17:49 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6U1HlbI011963;
        Tue, 30 Jul 2019 01:17:47 GMT
Received: from localhost (/10.159.132.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 18:17:46 -0700
Subject: [PATCH 1/6] list.h: add list_pop and list_pop_entry helpers
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     Damien.LeMoal@wdc.com, agruenba@redhat.com,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Date:   Mon, 29 Jul 2019 18:17:46 -0700
Message-ID: <156444946635.2682261.14776328020249327506.stgit@magnolia>
In-Reply-To: <156444945993.2682261.3926017251626679029.stgit@magnolia>
References: <156444945993.2682261.3926017251626679029.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300010
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300010
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

We have a very common pattern where we want to delete the first entry
from a list and return it as the properly typed container structure.

Add two helpers to implement this behavior.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 include/linux/list.h |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)


diff --git a/include/linux/list.h b/include/linux/list.h
index 85c92555e31f..d3b00267446a 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -514,6 +514,39 @@ static inline void list_splice_tail_init(struct list_head *list,
 	pos__ != head__ ? list_entry(pos__, type, member) : NULL; \
 })
 
+/**
+ * list_pop - delete the first entry from a list and return it
+ * @list:	the list to take the element from.
+ *
+ * Return the list entry after @list.  If @list is empty return NULL.
+ */
+static inline struct list_head *list_pop(struct list_head *list)
+{
+	struct list_head *pos = READ_ONCE(list->next);
+
+	if (pos == list)
+		return NULL;
+	list_del(pos);
+	return pos;
+}
+
+/**
+ * list_pop_entry - delete the first entry from a list and return the
+ *			containing structure
+ * @list:	the list to take the element from.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Return the containing structure for the list entry after @list.  If @list
+ * is empty return NULL.
+ */
+#define list_pop_entry(list, type, member)			\
+({								\
+	struct list_head *pos__ = list_pop(list);		\
+								\
+	pos__ ? list_entry(pos__, type, member) : NULL;		\
+})
+
 /**
  * list_next_entry - get the next element in list
  * @pos:	the type * to cursor

