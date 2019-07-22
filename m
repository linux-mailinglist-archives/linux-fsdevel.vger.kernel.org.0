Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0D9B6FCCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 11:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbfGVJud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 05:50:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfGVJuc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9q+L3RgE1NtSucIJXSWQVXlzXfNSwEyTOSV2prChZy0=; b=i9D/xH/ohp/w4yj1P0zVOtwNN1
        8gLSMEkQTW6jzJ841ClXYpLCanXdKc/SjR4kQLls2nWLPOptwA7Bn8zX4Ca2UtuDsCfQPY/Ll+wUv
        F/4U8VWcieb+nOrctPp/9dBbIdq+NwNMmBoq+nIp2cy2cTEvQJ85Gsah1yr8rAoh5NvdyLBosAZNJ
        VWk4/xpePa3gFiHvSN885U87b2R2JXHzxq6ntj6kksImiJaITO/WQBQ4jEydG6vGyVDPtclHanHeO
        mBN3JLJ9nuuNvL9lFNDeq53hbVXIopoWDVdT97SLh8RZOjHI0E6BGqjteEMxTrGxtszSXHPgTNKix
        MbhLUc0Q==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpUxh-0005VR-DB; Mon, 22 Jul 2019 09:50:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] list.h: add list_pop and list_pop_entry helpers
Date:   Mon, 22 Jul 2019 11:50:13 +0200
Message-Id: <20190722095024.19075-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722095024.19075-1-hch@lst.de>
References: <20190722095024.19075-1-hch@lst.de>
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
-- 
2.20.1

