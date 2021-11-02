Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38788442E06
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 13:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhKBMda (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 08:33:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231735AbhKBMdE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 08:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635856229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YogwOCAGA6fGeJ6dIyu8SDwnsFySGYbVr3aA98EooB0=;
        b=NA92QlLJcrPqPAGIgozw0zShWeSJtQcfPmqQB8VwB8IsDOykYOSPiScFBIsK8uB6EcfaL3
        B6bjqho4CptFpamHssGUanJEhm9vicXKCxEWzVRiYY8TVJtKdCNcd4osgnoojc1Yft8vlF
        mUd+Bni3gb0CWEJ53lwEGqKjtKBtT4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-FYG-E7orMmKLyEX6Tnn8UA-1; Tue, 02 Nov 2021 08:30:26 -0400
X-MC-Unique: FYG-E7orMmKLyEX6Tnn8UA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4D2D5074C;
        Tue,  2 Nov 2021 12:30:24 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.195.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DB9967842;
        Tue,  2 Nov 2021 12:30:16 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v9 08/17] gfs2: Introduce flag for glock holder auto-demotion
Date:   Tue,  2 Nov 2021 13:29:36 +0100
Message-Id: <20211102122945.117744-9-agruenba@redhat.com>
In-Reply-To: <20211102122945.117744-1-agruenba@redhat.com>
References: <20211102122945.117744-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

This patch introduces a new HIF_MAY_DEMOTE flag and infrastructure that
will allow glocks to be demoted automatically on locking conflicts.
When a locking request comes in that isn't compatible with the locking
state of an active holder and that holder has the HIF_MAY_DEMOTE flag
set, the holder will be demoted before the incoming locking request is
granted.

Note that this mechanism demotes active holders (with the HIF_HOLDER
flag set), while before we were only demoting glocks without any active
holders.  This allows processes to keep hold of locks that may form a
cyclic locking dependency; the core glock logic will then break those
dependencies in case a conflicting locking request occurs.  We'll use
this to avoid giving up the inode glock proactively before faulting in
pages.

Processes that allow a glock holder to be taken away indicate this by
calling gfs2_holder_allow_demote(), which sets the HIF_MAY_DEMOTE flag.
Later, they call gfs2_holder_disallow_demote() to clear the flag again,
and then they check if their holder is still queued: if it is, they are
still holding the glock; if it isn't, they can re-acquire the glock (or
abort).

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c  | 215 +++++++++++++++++++++++++++++++++++++++--------
 fs/gfs2/glock.h  |  20 +++++
 fs/gfs2/incore.h |   1 +
 3 files changed, 200 insertions(+), 36 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index bffd9c20f2de..f686083d0250 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -58,6 +58,7 @@ struct gfs2_glock_iter {
 typedef void (*glock_examiner) (struct gfs2_glock * gl);
 
 static void do_xmote(struct gfs2_glock *gl, struct gfs2_holder *gh, unsigned int target);
+static void __gfs2_glock_dq(struct gfs2_holder *gh);
 
 static struct dentry *gfs2_root;
 static struct workqueue_struct *glock_workqueue;
@@ -197,6 +198,12 @@ static int demote_ok(const struct gfs2_glock *gl)
 
 	if (gl->gl_state == LM_ST_UNLOCKED)
 		return 0;
+	/*
+	 * Note that demote_ok is used for the lru process of disposing of
+	 * glocks. For this purpose, we don't care if the glock's holders
+	 * have the HIF_MAY_DEMOTE flag set or not. If someone is using
+	 * them, don't demote.
+	 */
 	if (!list_empty(&gl->gl_holders))
 		return 0;
 	if (glops->go_demote_ok)
@@ -379,7 +386,7 @@ static void do_error(struct gfs2_glock *gl, const int ret)
 	struct gfs2_holder *gh, *tmp;
 
 	list_for_each_entry_safe(gh, tmp, &gl->gl_holders, gh_list) {
-		if (test_bit(HIF_HOLDER, &gh->gh_iflags))
+		if (!test_bit(HIF_WAIT, &gh->gh_iflags))
 			continue;
 		if (ret & LM_OUT_ERROR)
 			gh->gh_error = -EIO;
@@ -393,6 +400,40 @@ static void do_error(struct gfs2_glock *gl, const int ret)
 	}
 }
 
+/**
+ * demote_incompat_holders - demote incompatible demoteable holders
+ * @gl: the glock we want to promote
+ * @new_gh: the new holder to be promoted
+ */
+static void demote_incompat_holders(struct gfs2_glock *gl,
+				    struct gfs2_holder *new_gh)
+{
+	struct gfs2_holder *gh;
+
+	/*
+	 * Demote incompatible holders before we make ourselves eligible.
+	 * (This holder may or may not allow auto-demoting, but we don't want
+	 * to demote the new holder before it's even granted.)
+	 */
+	list_for_each_entry(gh, &gl->gl_holders, gh_list) {
+		/*
+		 * Since holders are at the front of the list, we stop when we
+		 * find the first non-holder.
+		 */
+		if (!test_bit(HIF_HOLDER, &gh->gh_iflags))
+			return;
+		if (test_bit(HIF_MAY_DEMOTE, &gh->gh_iflags) &&
+		    !may_grant(gl, new_gh, gh)) {
+			/*
+			 * We should not recurse into do_promote because
+			 * __gfs2_glock_dq only calls handle_callback,
+			 * gfs2_glock_add_to_lru and __gfs2_glock_queue_work.
+			 */
+			__gfs2_glock_dq(gh);
+		}
+	}
+}
+
 /**
  * find_first_holder - find the first "holder" gh
  * @gl: the glock
@@ -411,6 +452,26 @@ static inline struct gfs2_holder *find_first_holder(const struct gfs2_glock *gl)
 	return NULL;
 }
 
+/**
+ * find_first_strong_holder - find the first non-demoteable holder
+ * @gl: the glock
+ *
+ * Find the first holder that doesn't have the HIF_MAY_DEMOTE flag set.
+ */
+static inline struct gfs2_holder *
+find_first_strong_holder(struct gfs2_glock *gl)
+{
+	struct gfs2_holder *gh;
+
+	list_for_each_entry(gh, &gl->gl_holders, gh_list) {
+		if (!test_bit(HIF_HOLDER, &gh->gh_iflags))
+			return NULL;
+		if (!test_bit(HIF_MAY_DEMOTE, &gh->gh_iflags))
+			return gh;
+	}
+	return NULL;
+}
+
 /**
  * do_promote - promote as many requests as possible on the current queue
  * @gl: The glock
@@ -425,14 +486,20 @@ __acquires(&gl->gl_lockref.lock)
 {
 	const struct gfs2_glock_operations *glops = gl->gl_ops;
 	struct gfs2_holder *gh, *tmp, *first_gh;
+	bool incompat_holders_demoted = false;
 	int ret;
 
 restart:
-	first_gh = find_first_holder(gl);
+	first_gh = find_first_strong_holder(gl);
 	list_for_each_entry_safe(gh, tmp, &gl->gl_holders, gh_list) {
-		if (test_bit(HIF_HOLDER, &gh->gh_iflags))
+		if (!test_bit(HIF_WAIT, &gh->gh_iflags))
 			continue;
 		if (may_grant(gl, first_gh, gh)) {
+			if (!incompat_holders_demoted) {
+				demote_incompat_holders(gl, first_gh);
+				incompat_holders_demoted = true;
+				first_gh = gh;
+			}
 			if (gh->gh_list.prev == &gl->gl_holders &&
 			    glops->go_lock) {
 				spin_unlock(&gl->gl_lockref.lock);
@@ -458,6 +525,11 @@ __acquires(&gl->gl_lockref.lock)
 			gfs2_holder_wake(gh);
 			continue;
 		}
+		/*
+		 * If we get here, it means we may not grant this holder for
+		 * some reason. If this holder is the head of the list, it
+		 * means we have a blocked holder at the head, so return 1.
+		 */
 		if (gh->gh_list.prev == &gl->gl_holders)
 			return 1;
 		do_error(gl, 0);
@@ -1372,7 +1444,7 @@ __acquires(&gl->gl_lockref.lock)
 		if (test_bit(GLF_LOCK, &gl->gl_flags)) {
 			struct gfs2_holder *first_gh;
 
-			first_gh = find_first_holder(gl);
+			first_gh = find_first_strong_holder(gl);
 			try_futile = !may_grant(gl, first_gh, gh);
 		}
 		if (test_bit(GLF_INVALIDATE_IN_PROGRESS, &gl->gl_flags))
@@ -1381,7 +1453,8 @@ __acquires(&gl->gl_lockref.lock)
 
 	list_for_each_entry(gh2, &gl->gl_holders, gh_list) {
 		if (unlikely(gh2->gh_owner_pid == gh->gh_owner_pid &&
-		    (gh->gh_gl->gl_ops->go_type != LM_TYPE_FLOCK)))
+		    (gh->gh_gl->gl_ops->go_type != LM_TYPE_FLOCK) &&
+		    !test_bit(HIF_MAY_DEMOTE, &gh2->gh_iflags)))
 			goto trap_recursive;
 		if (try_futile &&
 		    !(gh2->gh_flags & (LM_FLAG_TRY | LM_FLAG_TRY_1CB))) {
@@ -1477,51 +1550,83 @@ int gfs2_glock_poll(struct gfs2_holder *gh)
 	return test_bit(HIF_WAIT, &gh->gh_iflags) ? 0 : 1;
 }
 
-/**
- * gfs2_glock_dq - dequeue a struct gfs2_holder from a glock (release a glock)
- * @gh: the glock holder
- *
- */
+static inline bool needs_demote(struct gfs2_glock *gl)
+{
+	return (test_bit(GLF_DEMOTE, &gl->gl_flags) ||
+		test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags));
+}
 
-void gfs2_glock_dq(struct gfs2_holder *gh)
+static void __gfs2_glock_dq(struct gfs2_holder *gh)
 {
 	struct gfs2_glock *gl = gh->gh_gl;
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 	unsigned delay = 0;
 	int fast_path = 0;
 
-	spin_lock(&gl->gl_lockref.lock);
 	/*
-	 * If we're in the process of file system withdraw, we cannot just
-	 * dequeue any glocks until our journal is recovered, lest we
-	 * introduce file system corruption. We need two exceptions to this
-	 * rule: We need to allow unlocking of nondisk glocks and the glock
-	 * for our own journal that needs recovery.
+	 * This while loop is similar to function demote_incompat_holders:
+	 * If the glock is due to be demoted (which may be from another node
+	 * or even if this holder is GL_NOCACHE), the weak holders are
+	 * demoted as well, allowing the glock to be demoted.
 	 */
-	if (test_bit(SDF_WITHDRAW_RECOVERY, &sdp->sd_flags) &&
-	    glock_blocked_by_withdraw(gl) &&
-	    gh->gh_gl != sdp->sd_jinode_gl) {
-		sdp->sd_glock_dqs_held++;
-		spin_unlock(&gl->gl_lockref.lock);
-		might_sleep();
-		wait_on_bit(&sdp->sd_flags, SDF_WITHDRAW_RECOVERY,
-			    TASK_UNINTERRUPTIBLE);
-		spin_lock(&gl->gl_lockref.lock);
-	}
-	if (gh->gh_flags & GL_NOCACHE)
-		handle_callback(gl, LM_ST_UNLOCKED, 0, false);
+	while (gh) {
+		/*
+		 * If we're in the process of file system withdraw, we cannot
+		 * just dequeue any glocks until our journal is recovered, lest
+		 * we introduce file system corruption. We need two exceptions
+		 * to this rule: We need to allow unlocking of nondisk glocks
+		 * and the glock for our own journal that needs recovery.
+		 */
+		if (test_bit(SDF_WITHDRAW_RECOVERY, &sdp->sd_flags) &&
+		    glock_blocked_by_withdraw(gl) &&
+		    gh->gh_gl != sdp->sd_jinode_gl) {
+			sdp->sd_glock_dqs_held++;
+			spin_unlock(&gl->gl_lockref.lock);
+			might_sleep();
+			wait_on_bit(&sdp->sd_flags, SDF_WITHDRAW_RECOVERY,
+				    TASK_UNINTERRUPTIBLE);
+			spin_lock(&gl->gl_lockref.lock);
+		}
+
+		/*
+		 * This holder should not be cached, so mark it for demote.
+		 * Note: this should be done before the check for needs_demote
+		 * below.
+		 */
+		if (gh->gh_flags & GL_NOCACHE)
+			handle_callback(gl, LM_ST_UNLOCKED, 0, false);
+
+		list_del_init(&gh->gh_list);
+		clear_bit(HIF_HOLDER, &gh->gh_iflags);
+		trace_gfs2_glock_queue(gh, 0);
+
+		/*
+		 * If there hasn't been a demote request we are done.
+		 * (Let the remaining holders, if any, keep holding it.)
+		 */
+		if (!needs_demote(gl)) {
+			if (list_empty(&gl->gl_holders))
+				fast_path = 1;
+			break;
+		}
+		/*
+		 * If we have another strong holder (we cannot auto-demote)
+		 * we are done. It keeps holding it until it is done.
+		 */
+		if (find_first_strong_holder(gl))
+			break;
 
-	list_del_init(&gh->gh_list);
-	clear_bit(HIF_HOLDER, &gh->gh_iflags);
-	if (list_empty(&gl->gl_holders) &&
-	    !test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags) &&
-	    !test_bit(GLF_DEMOTE, &gl->gl_flags))
-		fast_path = 1;
+		/*
+		 * If we have a weak holder at the head of the list, it
+		 * (and all others like it) must be auto-demoted. If there
+		 * are no more weak holders, we exit the while loop.
+		 */
+		gh = find_first_holder(gl);
+	}
 
 	if (!test_bit(GLF_LFLUSH, &gl->gl_flags) && demote_ok(gl))
 		gfs2_glock_add_to_lru(gl);
 
-	trace_gfs2_glock_queue(gh, 0);
 	if (unlikely(!fast_path)) {
 		gl->gl_lockref.count++;
 		if (test_bit(GLF_PENDING_DEMOTE, &gl->gl_flags) &&
@@ -1530,6 +1635,19 @@ void gfs2_glock_dq(struct gfs2_holder *gh)
 			delay = gl->gl_hold_time;
 		__gfs2_glock_queue_work(gl, delay);
 	}
+}
+
+/**
+ * gfs2_glock_dq - dequeue a struct gfs2_holder from a glock (release a glock)
+ * @gh: the glock holder
+ *
+ */
+void gfs2_glock_dq(struct gfs2_holder *gh)
+{
+	struct gfs2_glock *gl = gh->gh_gl;
+
+	spin_lock(&gl->gl_lockref.lock);
+	__gfs2_glock_dq(gh);
 	spin_unlock(&gl->gl_lockref.lock);
 }
 
@@ -1692,6 +1810,7 @@ void gfs2_glock_dq_m(unsigned int num_gh, struct gfs2_holder *ghs)
 
 void gfs2_glock_cb(struct gfs2_glock *gl, unsigned int state)
 {
+	struct gfs2_holder mock_gh = { .gh_gl = gl, .gh_state = state, };
 	unsigned long delay = 0;
 	unsigned long holdtime;
 	unsigned long now = jiffies;
@@ -1706,6 +1825,28 @@ void gfs2_glock_cb(struct gfs2_glock *gl, unsigned int state)
 		if (test_bit(GLF_REPLY_PENDING, &gl->gl_flags))
 			delay = gl->gl_hold_time;
 	}
+	/*
+	 * Note 1: We cannot call demote_incompat_holders from handle_callback
+	 * or gfs2_set_demote due to recursion problems like: gfs2_glock_dq ->
+	 * handle_callback -> demote_incompat_holders -> gfs2_glock_dq
+	 * Plus, we only want to demote the holders if the request comes from
+	 * a remote cluster node because local holder conflicts are resolved
+	 * elsewhere.
+	 *
+	 * Note 2: if a remote node wants this glock in EX mode, lock_dlm will
+	 * request that we set our state to UNLOCKED. Here we mock up a holder
+	 * to make it look like someone wants the lock EX locally. Any SH
+	 * and DF requests should be able to share the lock without demoting.
+	 *
+	 * Note 3: We only want to demote the demoteable holders when there
+	 * are no more strong holders. The demoteable holders might as well
+	 * keep the glock until the last strong holder is done with it.
+	 */
+	if (!find_first_strong_holder(gl)) {
+		if (state == LM_ST_UNLOCKED)
+			mock_gh.gh_state = LM_ST_EXCLUSIVE;
+		demote_incompat_holders(gl, &mock_gh);
+	}
 	handle_callback(gl, state, delay, true);
 	__gfs2_glock_queue_work(gl, delay);
 	spin_unlock(&gl->gl_lockref.lock);
@@ -2095,6 +2236,8 @@ static const char *hflags2str(char *buf, u16 flags, unsigned long iflags)
 		*p++ = 'H';
 	if (test_bit(HIF_WAIT, &iflags))
 		*p++ = 'W';
+	if (test_bit(HIF_MAY_DEMOTE, &iflags))
+		*p++ = 'D';
 	*p = 0;
 	return buf;
 }
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 31a8f2f649b5..9012487da4c6 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -150,6 +150,8 @@ static inline struct gfs2_holder *gfs2_glock_is_locked_by_me(struct gfs2_glock *
 	list_for_each_entry(gh, &gl->gl_holders, gh_list) {
 		if (!test_bit(HIF_HOLDER, &gh->gh_iflags))
 			break;
+		if (test_bit(HIF_MAY_DEMOTE, &gh->gh_iflags))
+			continue;
 		if (gh->gh_owner_pid == pid)
 			goto out;
 	}
@@ -325,6 +327,24 @@ static inline void glock_clear_object(struct gfs2_glock *gl, void *object)
 	spin_unlock(&gl->gl_lockref.lock);
 }
 
+static inline void gfs2_holder_allow_demote(struct gfs2_holder *gh)
+{
+	struct gfs2_glock *gl = gh->gh_gl;
+
+	spin_lock(&gl->gl_lockref.lock);
+	set_bit(HIF_MAY_DEMOTE, &gh->gh_iflags);
+	spin_unlock(&gl->gl_lockref.lock);
+}
+
+static inline void gfs2_holder_disallow_demote(struct gfs2_holder *gh)
+{
+	struct gfs2_glock *gl = gh->gh_gl;
+
+	spin_lock(&gl->gl_lockref.lock);
+	clear_bit(HIF_MAY_DEMOTE, &gh->gh_iflags);
+	spin_unlock(&gl->gl_lockref.lock);
+}
+
 extern void gfs2_inode_remember_delete(struct gfs2_glock *gl, u64 generation);
 extern bool gfs2_inode_already_deleted(struct gfs2_glock *gl, u64 generation);
 
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 0fe49770166e..58b7bac501e4 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -252,6 +252,7 @@ struct gfs2_lkstats {
 
 enum {
 	/* States */
+	HIF_MAY_DEMOTE		= 1,
 	HIF_HOLDER		= 6,  /* Set for gh that "holds" the glock */
 	HIF_WAIT		= 10,
 };
-- 
2.31.1

