Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73001580E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 12:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfF0Ksx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 06:48:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52062 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfF0Ksx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O/m/0mITlwkr33AYZ7K25oFGl9VFRsPi+VkSt0vj1f0=; b=CIOQvgjlgqk7W/bqo845BtZRB1
        fGrrqGQBmXkU4I1WzpZKRyf2DJytDLYx+tNfjTCNuLuQrEgbBKlsPcD9V2SxydjCvGCR8n/xHXAoN
        vSeCZnBxli4WYAjTr2m81/TTXTWWdmiDH5fDYO+Y/wyF33T229TmmgbtzGi/f8scksTv6hO8gY7n3
        NBf+2+GcHbF0kcb0Jobtr3wvrsU62qPNqWwSZRcYt2opxJ3UTEEIsG1q90t2Ft0gRFwJ9FNOITodc
        UKbfhJCU8s9yhMPu4c0WDZdFQ2YxdxyDb+ZPa+mcMcxOSUbt3S+/FhLB0MVQQ10WIMovXEUgTQwqY
        YmqUAgXw==;
Received: from 089144214055.atnat0023.highway.a1.net ([89.144.214.55] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgRxL-00053F-RM; Thu, 27 Jun 2019 10:48:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] list.h: add list_pop and list_pop_entry helpers
Date:   Thu, 27 Jun 2019 12:48:24 +0200
Message-Id: <20190627104836.25446-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627104836.25446-1-hch@lst.de>
References: <20190627104836.25446-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have a very common pattern where we want to delete the first entry
from a list and return it as the properly typed container structure.

Add two helpers to implement this behavior.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/list.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index e951228db4b2..ba6e27d2235a 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -500,6 +500,39 @@ static inline void list_splice_tail_init(struct list_head *list,
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
-- 
2.20.1

