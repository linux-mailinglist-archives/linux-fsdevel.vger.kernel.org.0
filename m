Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93CD433761
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 15:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbhJSNpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 09:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43865 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235991AbhJSNoy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634650961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QCg/80om+kZhpSKXbR2/fa6lxp6Vfm0yj76T9H4aoMg=;
        b=hidPWgw6Jrwk223eFUBBzGkL//cZE0YX+DVnQS4/F84hkYdjq/3mFsyk2ElS0KycVx2O7L
        +qYEtPtnhrX0dXkQB8Ml0l94UVdPrgscqrgUjPj8H1MrVVmtj/Yi57Pz3xX6leB7ELEcoZ
        i/mb3NTNqWcs/LVBkLL4VMAQRuWa+S8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-cZRw-onCP4qVk9UJt3n3fQ-1; Tue, 19 Oct 2021 09:42:37 -0400
X-MC-Unique: cZRw-onCP4qVk9UJt3n3fQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6FAE8042C3;
        Tue, 19 Oct 2021 13:42:35 +0000 (UTC)
Received: from max.com (unknown [10.40.193.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9ADA510016FC;
        Tue, 19 Oct 2021 13:42:32 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v8 07/17] gfs2: Clean up function may_grant
Date:   Tue, 19 Oct 2021 15:41:54 +0200
Message-Id: <20211019134204.3382645-8-agruenba@redhat.com>
In-Reply-To: <20211019134204.3382645-1-agruenba@redhat.com>
References: <20211019134204.3382645-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
index e0eaa9cf9fb6..f24db2ececfb 100644
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

