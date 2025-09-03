Return-Path: <linux-fsdevel+bounces-60137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B60B41A25
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 11:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866C51881776
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 09:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5908B2EDD40;
	Wed,  3 Sep 2025 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="drYgVRia"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE5C2EC56C
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892070; cv=none; b=r/wStwUbDiVR079W/lujtjuu6tQDiDZZftwJ9oLG33cSEcC8e8vEOHo/6U+wRV6NlbrAmS5Wc6RAU/1jjPwSlZH7BbE+vaDioHnTOk17FIBE88gKyr9KdSpM49VkFzygmJzIu6BqrlopJaowPkajYvnnX50QZ/DGzXLjiOstSYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892070; c=relaxed/simple;
	bh=mqiBnPPXMAPCJPBFrcXf+lHIv/LU5ou+i6Dp8Hv/Zk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2aiIxU2Crh5aspFH6n1AZoAtMrIQN8zM13SoVSgLRxS+ApuJxhDQeqlKDeQV1wlMoQvh49eIAI02x0rx2F6u0iZSGw++zIVzZVEzcRQOH5CVVQhMrVPQAKziFQLPWhlvIJuB9l9t+zqdg2fj8Dmk1TcWoQfyVrCcITR8ltuxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=drYgVRia; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77238cb3cbbso3784182b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756892068; x=1757496868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8+JgdG34uJkrarV50U4TwoOp7vca+o3Si3HJ74OVuk=;
        b=drYgVRia/t4mnF03Nm1XVhTmJyoQQ+5bZhxUMdg3hK5AKbaUktx9Scpo5svgMaDZuE
         6CCSyOeWykrJpwUgIrBcI/94B6zZ1TW5DtHnEJG7IFgP9YuceB3waTgbb/IfxCBjE4WG
         OfoQDApnE6ZAwuyXfLFboQp+lhDnY47rdEQ7mGVglum6hQhHj+bYCHiy42HbDTId1K81
         QBQ1lQr6rDJIeSsWcKXy2PkRk1jMvR62jHBeJ8sk9HqXNKG5F+QIVUmh1jCe99IjQ8x8
         hz/C1MoFIZ4ayDIsA3W1bAa2XNQbmoIfa1Qc9dxhIAXqDIlN16UDqK39ERkxvm/I+iFA
         cmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756892068; x=1757496868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8+JgdG34uJkrarV50U4TwoOp7vca+o3Si3HJ74OVuk=;
        b=I+YVS8+lAQNzl8qP7Wkgz2AE5vpRNt/Z6NWj9MjPRKm3Cmf3LEPNGtdAmpcQ9e4sBJ
         BW/9oS8hSGkPUf8NJUIjsS3zPUPm+7NmC6KnQoGoVwNjAgkMFjvV7HV5NCE5D5om8Pxe
         3aniNcgFe/6v3+4zQyJYqLTaefZr3vNIMAhTpF+Ra6Q/2MiAmiXeeKmiOJld3ovN2WPn
         O2TX/HowTY683KWDyT2NZSHUTApvN1YeaK9TBnG1kWpLEv9jYRkTQCyFlIbZ1nFOiJE6
         lyZzshUd6mOBPodi2iatLGdgnKhgz3/rejIxSxuJqL8FP42kITAqyfTbkoY/pNziVWws
         GY2Q==
X-Gm-Message-State: AOJu0YzSayXEx0D8HYAZ1Vh50LU28mieE3I6mM18M3QaUg/IsuB1rva8
	2YWvcsk3Em2FbEYJe8U6IumGzpisH/5MwPbDKJ3KE3k4T92iKvXHcORp7HCMmoRlCQ4=
X-Gm-Gg: ASbGncttMe8kw3ICbfIFrkfKYGgV7O5PHFC4iZecUE7ta1fWOW+gQzB7EvY1PW6pD9U
	NSIXOED5DuMvuu4f3accli9pHPkaI6A+86BXby1+gx+iyLjLjksUma3iykWGrCKwPWDbT8T21M5
	wsDm7158jFb+d9LJc/5CsoF8jmhbWimxqz5eON5Pn6qBCxUMS7NKEy9GQ7fLrzTXfwVtsHVwq28
	yuS2IfZf6/oXHFKrcjIRE15gjcREWnOcrENZtzHmhv/eoVRJWWqmMX2s2WA2G1NQudAfFK6xlRD
	Gsjz6mThkLN1+MrEnzXtxigvbQGHyWr5RUkHZrPSnUqXsrzUqzhVwG5lEp1rBm3q8g/yBRRfHAZ
	vuBt+3vwmJvC9tCCUd3r8qLO8Ig6PRpW523F1Iw2VgWI6CoNFWLKYcThrLuIhl6xGZk/02XbXUa
	Y6ngK07dW4Yw==
X-Google-Smtp-Source: AGHT+IEmp8gIpdAuYX7o1UeCnn/wvhN/DI1CzgzRc15udjdmJwcMX/9ME+0o5g/Bzt3J9gqcWZYAyA==
X-Received: by 2002:a05:6a20:9148:b0:23f:fec8:9ab0 with SMTP id adf61e73a8af0-243d6e690ffmr23344873637.25.1756892068057;
        Wed, 03 Sep 2025 02:34:28 -0700 (PDT)
Received: from H7GWF0W104.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5014desm16171734b3a.92.2025.09.03.02.34.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Sep 2025 02:34:27 -0700 (PDT)
From: Diangang Li <lidiangang@bytedance.com>
To: jack@suse.cz,
	amir73il@gmail.com,
	stephen.s.brennan@oracle.com,
	changfengnan@bytedance.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Diangang Li <lidiangang@bytedance.com>
Subject: [RFC 1/1] fsnotify: clear PARENT_WATCHED flags lazily
Date: Wed,  3 Sep 2025 17:34:13 +0800
Message-ID: <20250903093413.3434-2-lidiangang@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903093413.3434-1-lidiangang@bytedance.com>
References: <20250903093413.3434-1-lidiangang@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

commit 172e422ffea2 ("fsnotify: clear PARENT_WATCHED flags lazily")

In some setups directories can have many (usually negative) dentries.
Hence __fsnotify_update_child_dentry_flags() function can take a
significant amount of time. Since the bulk of this function happens
under inode->i_lock this causes a significant contention on the lock
when we remove the watch from the directory as the
__fsnotify_update_child_dentry_flags() call from fsnotify_recalc_mask()
races with __fsnotify_update_child_dentry_flags() calls from
__fsnotify_parent() happening on children. This can lead upto softlockup
reports reported by users.

Fix the problem by calling fsnotify_update_children_dentry_flags() to
set PARENT_WATCHED flags only when parent starts watching children.

When parent stops watching children, clear false positive PARENT_WATCHED
flags lazily in __fsnotify_parent() for each accessed child.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Diangang Li <lidiangang@bytedance.com>
---
 fs/notify/fsnotify.c             | 31 +++++++++++++++++++++----------
 fs/notify/fsnotify.h             |  2 +-
 fs/notify/mark.c                 | 32 +++++++++++++++++++++++++++++---
 include/linux/fsnotify_backend.h |  8 +++++---
 4 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index f44e39c68328..d5757fd69f62 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -105,17 +105,13 @@ void fsnotify_sb_delete(struct super_block *sb)
  * parent cares.  Thus when an event happens on a child it can quickly tell if
  * if there is a need to find a parent and send the event to the parent.
  */
-void __fsnotify_update_child_dentry_flags(struct inode *inode)
+void fsnotify_set_children_dentry_flags(struct inode *inode)
 {
 	struct dentry *alias;
-	int watched;
 
 	if (!S_ISDIR(inode->i_mode))
 		return;
 
-	/* determine if the children should tell inode about their events */
-	watched = fsnotify_inode_watches_children(inode);
-
 	spin_lock(&inode->i_lock);
 	/* run all of the dentries associated with this inode.  Since this is a
 	 * directory, there damn well better only be one item on this list */
@@ -131,10 +127,7 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 				continue;
 
 			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
-			if (watched)
-				child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
-			else
-				child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
+			child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
 			spin_unlock(&child->d_lock);
 		}
 		spin_unlock(&alias->d_lock);
@@ -142,6 +135,24 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 }
 
+/*
+ * Lazily clear false positive PARENT_WATCHED flag for child whose parent had
+ * stopped watching children.
+ */
+static void fsnotify_clear_child_dentry_flag(struct inode *pinode,
+					     struct dentry *dentry)
+{
+	spin_lock(&dentry->d_lock);
+	/*
+	 * d_lock is a sufficient barrier to prevent observing a non-watched
+	 * parent state from before the fsnotify_set_children_dentry_flags()
+	 * or fsnotify_update_flags() call that had set PARENT_WATCHED.
+	 */
+	if (!fsnotify_inode_watches_children(pinode))
+		dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
+	spin_unlock(&dentry->d_lock);
+}
+
 /* Notify this dentry's parent about a child's events. */
 int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask)
 {
@@ -159,7 +170,7 @@ int __fsnotify_parent(const struct path *path, struct dentry *dentry, __u32 mask
 	p_inode = parent->d_inode;
 
 	if (unlikely(!fsnotify_inode_watches_children(p_inode))) {
-		__fsnotify_update_child_dentry_flags(p_inode);
+		fsnotify_clear_child_dentry_flag(p_inode, dentry);
 	} else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
 		struct name_snapshot name;
 
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index f3462828a0e2..0ac1f8e8e012 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -59,7 +59,7 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
  * update the dentry->d_flags of all of inode's children to indicate if inode cares
  * about events that happen to its children.
  */
-extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
+extern void fsnotify_set_children_dentry_flags(struct inode *inode);
 
 /* allocate and destroy and event holder to attach events to notification/access queues */
 extern struct fsnotify_event_holder *fsnotify_alloc_event_holder(void);
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index fdf8e03bf3df..ba4953b0917d 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -132,6 +132,24 @@ static void __fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 	*fsnotify_conn_mask_p(conn) = new_mask;
 }
 
+static bool fsnotify_conn_watches_children(
+					struct fsnotify_mark_connector *conn)
+{
+	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
+		return false;
+
+	return fsnotify_inode_watches_children(fsnotify_conn_inode(conn));
+}
+
+static void fsnotify_conn_set_children_dentry_flags(
+					struct fsnotify_mark_connector *conn)
+{
+	if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
+		return;
+
+	fsnotify_set_children_dentry_flags(fsnotify_conn_inode(conn));
+}
+
 /*
  * Calculate mask of events for a list of marks. The caller must make sure
  * connector and connector->obj cannot disappear under us.  Callers achieve
@@ -140,15 +158,23 @@ static void __fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
  */
 void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
+	bool update_children;
+
 	if (!conn)
 		return;
 
 	spin_lock(&conn->lock);
+	update_children = !fsnotify_conn_watches_children(conn);
 	__fsnotify_recalc_mask(conn);
+	update_children &= fsnotify_conn_watches_children(conn);
 	spin_unlock(&conn->lock);
-	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
-		__fsnotify_update_child_dentry_flags(
-					fsnotify_conn_inode(conn));
+	/*
+	 * Set children's PARENT_WATCHED flags only if parent started watching.
+	 * When parent stops watching, we clear false positive PARENT_WATCHED
+	 * flags lazily in __fsnotify_parent().
+	 */
+	if (update_children)
+		fsnotify_conn_set_children_dentry_flags(conn);
 }
 
 /* Free all connectors queued for freeing once SRCU period ends */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 64cfb5446f4d..d7ced985ffee 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -360,12 +360,14 @@ extern u32 fsnotify_get_cookie(void);
 
 static inline int fsnotify_inode_watches_children(struct inode *inode)
 {
+	__u32 parent_mask = READ_ONCE(inode->i_fsnotify_mask);
+
 	/* FS_EVENT_ON_CHILD is set if the inode may care */
-	if (!(inode->i_fsnotify_mask & FS_EVENT_ON_CHILD))
+	if (!(parent_mask & FS_EVENT_ON_CHILD))
 		return 0;
 	/* this inode might care about child events, does it care about the
 	 * specific set of events that can happen on a child? */
-	return inode->i_fsnotify_mask & FS_EVENTS_POSS_ON_CHILD;
+	return parent_mask & FS_EVENTS_POSS_ON_CHILD;
 }
 
 /*
@@ -379,7 +381,7 @@ static inline void fsnotify_update_flags(struct dentry *dentry)
 	/*
 	 * Serialisation of setting PARENT_WATCHED on the dentries is provided
 	 * by d_lock. If inotify_inode_watched changes after we have taken
-	 * d_lock, the following __fsnotify_update_child_dentry_flags call will
+	 * d_lock, the following fsnotify_set_children_dentry_flags call will
 	 * find our entry, so it will spin until we complete here, and update
 	 * us with the new state.
 	 */
-- 
2.39.5


