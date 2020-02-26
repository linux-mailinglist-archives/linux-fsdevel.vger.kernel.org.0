Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D435170407
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 17:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgBZQPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 11:15:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49066 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727916AbgBZQPj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582733738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=jFlp1Ai79InLDRWAlyPIGd+U3BTEfGYkEUUnbfg479Y=;
        b=A8XQj9g20ne5V0KqXfhAklyUdKJU46KKyWh6vCSUNzqN+TlT9tlZHM4/+h3mM+lLKA6LqQ
        jCo7s8VdH8kjBPySY5xLa7x+goHX4sOe8++18Oje8dKq2wrCKQGf6br2IaVQMeX/y492/O
        qv9ecEhv439jo8r6XTEW2w1ij80ts4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-CpvYF8T_O5Go3acqcBCJNA-1; Wed, 26 Feb 2020 11:15:36 -0500
X-MC-Unique: CpvYF8T_O5Go3acqcBCJNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08A6510883B9;
        Wed, 26 Feb 2020 16:15:34 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55CEE60BE1;
        Wed, 26 Feb 2020 16:15:31 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 08/11] fs/dcache: Limit dentry reclaim count in negative_reclaim_workfn()
Date:   Wed, 26 Feb 2020 11:14:01 -0500
Message-Id: <20200226161404.14136-9-longman@redhat.com>
In-Reply-To: <20200226161404.14136-1-longman@redhat.com>
References: <20200226161404.14136-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To limit the d_lock hold time of directory dentry in the negative dentry
reclaim process, a quota (currently 64k) is added to limit the amount of
work that the work function can do and hence its execution time. This is
done to minimize impact on other processes that depend on that d_lock or
other work functions in the same work queue from excessive delay.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/dcache.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 149c0a6c1a6e..0bd5d6974f75 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1374,10 +1374,25 @@ static inline void init_dentry_iname(struct dentry *dentry)
 	set_dentry_npositive(dentry, 0);
 }
 
+/*
+ * In the pathological case where a large number of negative dentries are
+ * generated in a short time in a given directory, there is a possibility
+ * that negative dentries reclaiming process will have many dentries to
+ * be dispose of. Thus the d_lock lock can be hold for too long impacting
+ * other running processes that need it.
+ *
+ * There is also the consideration that a long runtime will impact other
+ * work functions that need to be run in the same work queue. As a result,
+ * we have to limit the number of dentries that can be reclaimed in each
+ * invocation of the work function.
+ */
+#define MAX_DENTRY_RECLAIM	(1 << 16)
+
 /*
  * Reclaim excess negative dentries in a directory
+ * Return: true if the work function needs to be rescheduled, false otherwise
  */
-static void reclaim_negative_dentry(struct dentry *parent,
+static void reclaim_negative_dentry(struct dentry *parent, int *quota,
 				    struct list_head *dispose)
 {
 	struct dentry *child;
@@ -1394,9 +1409,16 @@ static void reclaim_negative_dentry(struct dentry *parent,
 	 */
 	if (cnt <= limit)
 		return;
+
+	npositive = 0;
 	cnt -= limit;
 	cnt += (limit >> 3);
-	npositive = 0;
+	if (cnt >= *quota) {
+		cnt = *quota;
+		*quota = 0;
+	} else {
+		*quota -= cnt;
+	}
 
 	/*
 	 * The d_subdirs is treated like a kind of LRU where
@@ -1462,6 +1484,8 @@ static void reclaim_negative_dentry(struct dentry *parent,
 	}
 	if (dentry_has_npositive(parent))
 		set_dentry_npositive(parent, npositive);
+
+	*quota += cnt;
 }
 
 /*
@@ -1472,6 +1496,7 @@ static void negative_reclaim_workfn(struct work_struct *work)
 	struct llist_node *nodes, *next;
 	struct dentry *parent;
 	struct reclaim_dentry *dentry_node;
+	int quota = MAX_DENTRY_RECLAIM;
 
 	/*
 	 * Collect excess negative dentries in dispose list & shrink them.
@@ -1486,10 +1511,10 @@ static void negative_reclaim_workfn(struct work_struct *work)
 		parent = dentry_node->parent_dir;
 		spin_lock(&parent->d_lock);
 
-		if (d_is_dir(parent) &&
+		if (d_is_dir(parent) && quota &&
 		    can_reclaim_dentry(parent->d_flags) &&
 		    (parent->d_flags & DCACHE_RECLAIMING))
-			reclaim_negative_dentry(parent, &dispose);
+			reclaim_negative_dentry(parent, &quota, &dispose);
 
 		if (!list_empty(&dispose)) {
 			spin_unlock(&parent->d_lock);
-- 
2.18.1

