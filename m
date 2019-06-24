Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD87501AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 07:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfFXFxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 01:53:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50588 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfFXFxA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vs0VQZ8KjUPrhpsoQBCbpDKj0GvlZXsU1FRyQmL0RPo=; b=IqiCYwEtpiTr9YHNxj5geuEGZa
        N8AZ2BNpNmKd/Hi5NEGfff9MgrasK+4xmiGFBwxSbq7i06+7TbGjo9OQG2ukVMX05Fc7SpcLuEoak
        KIq9ZgkPsoU8A1N1cct2kQ8h6mbPc+Gs7zDhj/3BG+d23LW34HhDC+vkdcZ7jDDvSYwQTPxJCcgNR
        qxITHWy1H4+9uyUMv0NguUiTTaXJHduwVKEZSz/uDIKxzw+b+G+DLU0usY70I0jpY6xMaJS8usq2b
        tS7WNauamD/4DgrQJSvIAvaw8yQ1ZY0KbgKNBoZpsAo2mOgx1mVWTl5RTKgu5BZbRZetNXVzGWnrh
        s9MVUhyg==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfHuU-00042O-Md; Mon, 24 Jun 2019 05:52:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] list.h: add a list_pop helper
Date:   Mon, 24 Jun 2019 07:52:42 +0200
Message-Id: <20190624055253.31183-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624055253.31183-1-hch@lst.de>
References: <20190624055253.31183-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have a very common pattern where we want to delete the first entry
from a list and return it as the properly typed container structure.

Add a list_pop helper to implement this behavior.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/list.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index e951228db4b2..e07a5f54cc9d 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -500,6 +500,28 @@ static inline void list_splice_tail_init(struct list_head *list,
 	pos__ != head__ ? list_entry(pos__, type, member) : NULL; \
 })
 
+/**
+ * list_pop - delete the first entry from a list and return it
+ * @list:	the list to take the element from.
+ * @type:	the type of the struct this is embedded in.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Note that if the list is empty, it returns NULL.
+ */
+#define list_pop(list, type, member) 				\
+({								\
+	struct list_head *head__ = (list);			\
+	struct list_head *pos__ = READ_ONCE(head__->next);	\
+	type *entry__ = NULL;					\
+								\
+	if (pos__ != head__) {					\
+		entry__ = list_entry(pos__, type, member);	\
+		list_del(pos__);				\
+	}							\
+								\
+	entry__;						\
+})
+
 /**
  * list_next_entry - get the next element in list
  * @pos:	the type * to cursor
-- 
2.20.1

