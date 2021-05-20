Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D222038AE2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 14:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbhETM22 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 08:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41944 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235494AbhETM1S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 08:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621513556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=niIyGypKRI/tMYi74NMa5b60rnjqZJ04fmjRzMuqFao=;
        b=GpQEbuQIFgdU+Bml88iBPTcuz50urVdzmU0t0CyKjKmBunZtSIra16DZmT708GUm/PPsPk
        Rj7DYCul4mDgQoIDgZA14TGhzu1hoYaCRJb7F88Qeu374l/tfuGFar3MjLhGgr3t1VNXVs
        Zfiw4YUw7gUHBYNqtZ0m8/kG56UbzV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-MTTdWM3sNMOefMbCQBY5jw-1; Thu, 20 May 2021 08:25:54 -0400
X-MC-Unique: MTTdWM3sNMOefMbCQBY5jw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57034101371C;
        Thu, 20 May 2021 12:25:53 +0000 (UTC)
Received: from max.com (unknown [10.40.195.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D219C60C04;
        Thu, 20 May 2021 12:25:51 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>, cluster-devel@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Jan Kara <jack@suse.cz>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 5/6] gfs2: Add LM_FLAG_OUTER glock holder flag
Date:   Thu, 20 May 2021 14:25:35 +0200
Message-Id: <20210520122536.1596602-6-agruenba@redhat.com>
In-Reply-To: <20210520122536.1596602-1-agruenba@redhat.com>
References: <20210520122536.1596602-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a glock holder has the LM_FLAG_OUTER flag set, we set the
current_holds_glock() flag upon taking the lock.  With that flag set, we can
then recognize when trying to take an "inner" glock and react accordingly.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 12 ++++++++++++
 fs/gfs2/glock.h | 13 ++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index d9cb261f55b0..f6cae2ee1c83 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1427,6 +1427,11 @@ int gfs2_glock_nq(struct gfs2_holder *gh)
 	if (glock_blocked_by_withdraw(gl) && !(gh->gh_flags & LM_FLAG_NOEXP))
 		return -EIO;
 
+	if (gh->gh_flags & LM_FLAG_OUTER) {
+		BUG_ON(current_holds_glock());
+		set_current_holds_glock(true);
+	}
+
 	if (test_bit(GLF_LRU, &gl->gl_flags))
 		gfs2_glock_remove_from_lru(gl);
 
@@ -1514,6 +1519,11 @@ void gfs2_glock_dq(struct gfs2_holder *gh)
 		__gfs2_glock_queue_work(gl, delay);
 	}
 	spin_unlock(&gl->gl_lockref.lock);
+
+	if (gh->gh_flags & LM_FLAG_OUTER) {
+		BUG_ON(!current_holds_glock());
+		set_current_holds_glock(false);
+	}
 }
 
 void gfs2_glock_dq_wait(struct gfs2_holder *gh)
@@ -2068,6 +2078,8 @@ static const char *hflags2str(char *buf, u16 flags, unsigned long iflags)
 		*p++ = 'p';
 	if (flags & LM_FLAG_NODE_SCOPE)
 		*p++ = 'n';
+	if (flags & LM_FLAG_OUTER)
+		*p++ = 'o';
 	if (flags & GL_ASYNC)
 		*p++ = 'a';
 	if (flags & GL_EXACT)
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index f0ef6fd24ba4..8b145269fb14 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -94,6 +94,12 @@ static inline bool gfs2_holder_is_compatible(struct gfs2_holder *gh, int state)
  * This holder agrees to share the lock within this node. In other words,
  * the glock is held in EX mode according to DLM, but local holders on the
  * same node can share it.
+ *
+ * LM_FLAG_OUTER
+ * Use set_current_holds_glock() to indicate when the current task is holding
+ * this "upper" glock, and current_holds_glock() to detect when the current
+ * task is trying to take another glock.  Used to prevent deadlocks involving
+ * the inode glock during page faults.
  */
 
 #define LM_FLAG_TRY		0x0001
@@ -102,9 +108,10 @@ static inline bool gfs2_holder_is_compatible(struct gfs2_holder *gh, int state)
 #define LM_FLAG_ANY		0x0008
 #define LM_FLAG_PRIORITY	0x0010
 #define LM_FLAG_NODE_SCOPE	0x0020
-#define GL_ASYNC		0x0040
-#define GL_EXACT		0x0080
-#define GL_SKIP			0x0100
+#define LM_FLAG_OUTER		0x0040
+#define GL_ASYNC		0x0080
+#define GL_EXACT		0x0100
+#define GL_SKIP			0x0200
 #define GL_NOCACHE		0x0400
   
 /*
-- 
2.26.3

