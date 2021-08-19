Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204883F20D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 21:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhHSTmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 15:42:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234942AbhHSTmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629402103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dzlVCOn6ciocu+oY7/xltnn9HG07joJwbc5GNBbl0EY=;
        b=eIOKnOufLwahF4VHb1ofxGY6AmotP/Ldk1gGxmcBYA4p4VAwjZBofOng6biC75skRwgchq
        jB4Dd/7BhXv/orBOZk4TBMIRiCgCn8Qn9IRXPd/U2EuZfTusyLuPyXn6vHZ1e9G/qenQTk
        UYfYpDadB6IxN2nU0dxkdUUhO5sDi6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-JeccV3OtOs2Y3EsrGlYExw-1; Thu, 19 Aug 2021 15:41:38 -0400
X-MC-Unique: JeccV3OtOs2Y3EsrGlYExw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBD431082921;
        Thu, 19 Aug 2021 19:41:36 +0000 (UTC)
Received: from max.com (unknown [10.40.194.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20E6F1B46B;
        Thu, 19 Aug 2021 19:41:33 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v6 07/19] gfs2: Clean up function may_grant
Date:   Thu, 19 Aug 2021 21:40:50 +0200
Message-Id: <20210819194102.1491495-8-agruenba@redhat.com>
In-Reply-To: <20210819194102.1491495-1-agruenba@redhat.com>
References: <20210819194102.1491495-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass the first current glock holder into function may_grant and
deobfuscate the logic there.

We're now using function find_first_holder in do_promote, so move the
function's definition above do_promote.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 120 ++++++++++++++++++++++++++++--------------------
 1 file changed, 70 insertions(+), 50 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 1f3902ecdded..545b435f55ea 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -301,46 +301,59 @@ void gfs2_glock_put(struct gfs2_glock *gl)
 }
 
 /**
- * may_grant - check if its ok to grant a new lock
+ * may_grant - check if it's ok to grant a new lock
  * @gl: The glock
+ * @current_gh: One of the current holders of @gl
  * @gh: The lock request which we wish to grant
  *
- * Returns: true if its ok to grant the lock
+ * With our current compatibility rules, if a glock has one or more active
+ * holders (HIF_HOLDER flag set), any of those holders can be passed in as
+ * @current_gh; they are all the same as far as compatibility with the new @gh
+ * goes.
+ *
+ * Returns true if it's ok to grant the lock.
  */
 
-static inline int may_grant(const struct gfs2_glock *gl, const struct gfs2_holder *gh)
-{
-	const struct gfs2_holder *gh_head = list_first_entry(&gl->gl_holders, const struct gfs2_holder, gh_list);
+static inline bool may_grant(const struct gfs2_glock *gl,
+			     const struct gfs2_holder *current_gh,
+			     const struct gfs2_holder *gh)
+{
+	if (current_gh) {
+		BUG_ON(!test_bit(HIF_HOLDER, &current_gh->gh_iflags));
+
+		switch(current_gh->gh_state) {
+		case LM_ST_EXCLUSIVE:
+			/*
+			 * Here we make a special exception to grant holders
+			 * who agree to share the EX lock with other holders
+			 * who also have the bit set. If the original holder
+			 * has the LM_FLAG_NODE_SCOPE bit set, we grant more
+			 * holders with the bit set.
+			 */
+			return gh->gh_state == LM_ST_EXCLUSIVE &&
+			       (current_gh->gh_flags & LM_FLAG_NODE_SCOPE) &&
+			       (gh->gh_flags & LM_FLAG_NODE_SCOPE);
 
-	if (gh != gh_head) {
-		/**
-		 * Here we make a special exception to grant holders who agree
-		 * to share the EX lock with other holders who also have the
-		 * bit set. If the original holder has the LM_FLAG_NODE_SCOPE bit
-		 * is set, we grant more holders with the bit set.
-		 */
-		if (gh_head->gh_state == LM_ST_EXCLUSIVE &&
-		    (gh_head->gh_flags & LM_FLAG_NODE_SCOPE) &&
-		    gh->gh_state == LM_ST_EXCLUSIVE &&
-		    (gh->gh_flags & LM_FLAG_NODE_SCOPE))
-			return 1;
-		if ((gh->gh_state == LM_ST_EXCLUSIVE ||
-		     gh_head->gh_state == LM_ST_EXCLUSIVE))
-			return 0;
+		case LM_ST_SHARED:
+		case LM_ST_DEFERRED:
+			return gh->gh_state == current_gh->gh_state;
+
+		default:
+			return false;
+		}
 	}
+
 	if (gl->gl_state == gh->gh_state)
-		return 1;
+		return true;
 	if (gh->gh_flags & GL_EXACT)
-		return 0;
+		return false;
 	if (gl->gl_state == LM_ST_EXCLUSIVE) {
-		if (gh->gh_state == LM_ST_SHARED && gh_head->gh_state == LM_ST_SHARED)
-			return 1;
-		if (gh->gh_state == LM_ST_DEFERRED && gh_head->gh_state == LM_ST_DEFERRED)
-			return 1;
+		return gh->gh_state == LM_ST_SHARED ||
+		       gh->gh_state == LM_ST_DEFERRED;
 	}
-	if (gl->gl_state != LM_ST_UNLOCKED && (gh->gh_flags & LM_FLAG_ANY))
-		return 1;
-	return 0;
+	if (gh->gh_flags & LM_FLAG_ANY)
+		return gl->gl_state != LM_ST_UNLOCKED;
+	return false;
 }
 
 static void gfs2_holder_wake(struct gfs2_holder *gh)
@@ -380,6 +393,24 @@ static void do_error(struct gfs2_glock *gl, const int ret)
 	}
 }
 
+/**
+ * find_first_holder - find the first "holder" gh
+ * @gl: the glock
+ */
+
+static inline struct gfs2_holder *find_first_holder(const struct gfs2_glock *gl)
+{
+	struct gfs2_holder *gh;
+
+	if (!list_empty(&gl->gl_holders)) {
+		gh = list_first_entry(&gl->gl_holders, struct gfs2_holder,
+				      gh_list);
+		if (test_bit(HIF_HOLDER, &gh->gh_iflags))
+			return gh;
+	}
+	return NULL;
+}
+
 /**
  * do_promote - promote as many requests as possible on the current queue
  * @gl: The glock
@@ -393,14 +424,16 @@ __releases(&gl->gl_lockref.lock)
 __acquires(&gl->gl_lockref.lock)
 {
 	const struct gfs2_glock_operations *glops = gl->gl_ops;
-	struct gfs2_holder *gh, *tmp;
+	struct gfs2_holder *gh, *tmp, *first_gh;
 	int ret;
 
+	first_gh = find_first_holder(gl);
+
 restart:
 	list_for_each_entry_safe(gh, tmp, &gl->gl_holders, gh_list) {
 		if (test_bit(HIF_HOLDER, &gh->gh_iflags))
 			continue;
-		if (may_grant(gl, gh)) {
+		if (may_grant(gl, first_gh, gh)) {
 			if (gh->gh_list.prev == &gl->gl_holders &&
 			    glops->go_lock) {
 				spin_unlock(&gl->gl_lockref.lock);
@@ -722,23 +755,6 @@ __acquires(&gl->gl_lockref.lock)
 	spin_lock(&gl->gl_lockref.lock);
 }
 
-/**
- * find_first_holder - find the first "holder" gh
- * @gl: the glock
- */
-
-static inline struct gfs2_holder *find_first_holder(const struct gfs2_glock *gl)
-{
-	struct gfs2_holder *gh;
-
-	if (!list_empty(&gl->gl_holders)) {
-		gh = list_first_entry(&gl->gl_holders, struct gfs2_holder, gh_list);
-		if (test_bit(HIF_HOLDER, &gh->gh_iflags))
-			return gh;
-	}
-	return NULL;
-}
-
 /**
  * run_queue - do all outstanding tasks related to a glock
  * @gl: The glock in question
@@ -1354,8 +1370,12 @@ __acquires(&gl->gl_lockref.lock)
 		GLOCK_BUG_ON(gl, true);
 
 	if (gh->gh_flags & (LM_FLAG_TRY | LM_FLAG_TRY_1CB)) {
-		if (test_bit(GLF_LOCK, &gl->gl_flags))
-			try_futile = !may_grant(gl, gh);
+		if (test_bit(GLF_LOCK, &gl->gl_flags)) {
+			struct gfs2_holder *first_gh;
+
+			first_gh = find_first_holder(gl);
+			try_futile = !may_grant(gl, first_gh, gh);
+		}
 		if (test_bit(GLF_INVALIDATE_IN_PROGRESS, &gl->gl_flags))
 			goto fail;
 	}
-- 
2.26.3

