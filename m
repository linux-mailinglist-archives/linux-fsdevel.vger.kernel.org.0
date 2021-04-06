Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA393553F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 14:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344069AbhDFMeA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 08:34:00 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:41692 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344053AbhDFMd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:33:58 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A27CF1042071;
        Tue,  6 Apr 2021 22:33:48 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lTktv-00Cq7Y-VI; Tue, 06 Apr 2021 22:33:47 +1000
Received: from dave by discord.disaster.area with local (Exim 4.94)
        (envelope-from <david@fromorbit.com>)
        id 1lTktv-007Imb-Ng; Tue, 06 Apr 2021 22:33:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hlist-bl: add hlist_bl_fake()
Date:   Tue,  6 Apr 2021 22:33:42 +1000
Message-Id: <20210406123343.1739669-3-david@fromorbit.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210406123343.1739669-1-david@fromorbit.com>
References: <20210406123343.1739669-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0 cx=a_idp_x
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=3YhXtTcJ-WEA:10 a=20KFwNOVAAAA:8 a=5GoOSNrQKTzYL-JgveQA:9
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

in preparation for switching the VFS inode cache over the hlist_bl
lists, we nee dto be able to fake a list node that looks like it is
hased for correct operation of filesystems that don't directly use
the VFS indoe cache.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/list_bl.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index ae1b541446c9..8ee2bf5af131 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -143,6 +143,28 @@ static inline void hlist_bl_del_init(struct hlist_bl_node *n)
 	}
 }
 
+/**
+ * hlist_bl_add_fake - create a fake list consisting of a single headless node
+ * @n: Node to make a fake list out of
+ *
+ * This makes @n appear to be its own predecessor on a headless hlist.
+ * The point of this is to allow things like hlist_bl_del() to work correctly
+ * in cases where there is no list.
+ */
+static inline void hlist_bl_add_fake(struct hlist_bl_node *n)
+{
+	n->pprev = &n->next;
+}
+
+/**
+ * hlist_fake: Is this node a fake hlist_bl?
+ * @h: Node to check for being a self-referential fake hlist.
+ */
+static inline bool hlist_bl_fake(struct hlist_bl_node *n)
+{
+	return n->pprev == &n->next;
+}
+
 static inline void hlist_bl_lock(struct hlist_bl_head *b)
 {
 	bit_spin_lock(0, (unsigned long *)b);
-- 
2.31.0

