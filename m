Return-Path: <linux-fsdevel+bounces-31802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D1799B38F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 13:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC3CEB224B3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 11:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCE519E982;
	Sat, 12 Oct 2024 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8YtnqLj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DDC19E81F;
	Sat, 12 Oct 2024 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732406; cv=none; b=JuHw0plbxPotsCNARd83rI0pfnTy4iIiQpQMHzxgs6ds4E8h8blp20QYRY9VfF+gVDgHWw8dbMrgQ2iyZwXfqNdBlM0e8DzgPvj802rL24jPX8bIiVNXPMly9JqiU4JjTJ6YGnSGWG0o52/tnII3W/Nxp91LnDY83jEFAIh3Bec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732406; c=relaxed/simple;
	bh=RYKxMQZaoDwJVc3ulr4USCHdZNWpiZJlL+QIdT0Bn6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEXYSun8Rmed0Ub08EO6RuM/8feRasVZ7+ejRaUKgwtHIs1FJndaC+J/kzxx3VQJ+DLRpXGYtMhmOYT8p1TyEZ6b77Z8Bn84qrzacuX+vMbgtteX8L0fzoGKLEQDGj9vTkhQKO4eH4sze9wUVJB/juqOr2eDR520TCaHl0FV/bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8YtnqLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19422C4CEC6;
	Sat, 12 Oct 2024 11:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732406;
	bh=RYKxMQZaoDwJVc3ulr4USCHdZNWpiZJlL+QIdT0Bn6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8YtnqLjOBMzxvPP5Y4WAJDILy1WF/NllTXyVkLMfoTpOf5GKfGLvW9y15Qy8B49S
	 NBAQeS7aKrNOMtU6FkqwEUhJDd//pX+5iHHoTxZuoLmhk/feTYHPlbyJ/nRz+APwcx
	 9WISHfbL9UNYJMpjhf/nsUU2Ranmk5mTDS0CZ4qmw5LgMp4ZuC897cAOy01J1a63/n
	 nkvjAwrUiK4DgAazeBKbcsYcflIRJVIiW9sRW/17vOv7QR0Pdbu6ae4eHk77UrrhfO
	 r52dMdEJ1/J5e4kKtDoh0AWhgEDxOoofSvwFgPYsv/walmWXgXJTSuGz5wISinLuSg
	 AWXt7Et3OjUug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com,
	Dmitry Vyukov <dvyukov@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 13/16] fsnotify: Avoid data race between fsnotify_recalc_mask() and fsnotify_object_watched()
Date: Sat, 12 Oct 2024 07:26:09 -0400
Message-ID: <20241012112619.1762860-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112619.1762860-1-sashal@kernel.org>
References: <20241012112619.1762860-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 35ceae44742e1101f9d20adadbbbd92c05d7d659 ]

When __fsnotify_recalc_mask() recomputes the mask on the watched object,
the compiler can "optimize" the code to perform partial updates to the
mask (including zeroing it at the beginning). Thus places checking
the object mask without conn->lock such as fsnotify_object_watched()
could see invalid states of the mask. Make sure the mask update is
performed by one memory store using WRITE_ONCE().

Reported-by: syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://lore.kernel.org/all/CACT4Y+Zk0ohwwwHSD63U2-PQ=UuamXczr1mKBD6xtj2dyYKBvA@mail.gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Link: https://patch.msgid.link/20240717140623.27768-1-jack@suse.cz
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fsnotify.c             | 21 ++++++++++++---------
 fs/notify/inotify/inotify_user.c |  2 +-
 fs/notify/mark.c                 |  8 ++++++--
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 272c8a1dab3c2..82ae8254c068b 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -183,8 +183,10 @@ static bool fsnotify_event_needs_parent(struct inode *inode, __u32 mnt_mask,
 	BUILD_BUG_ON(FS_EVENTS_POSS_ON_CHILD & ~FS_EVENTS_POSS_TO_PARENT);
 
 	/* Did either inode/sb/mount subscribe for events with parent/name? */
-	marks_mask |= fsnotify_parent_needed_mask(inode->i_fsnotify_mask);
-	marks_mask |= fsnotify_parent_needed_mask(inode->i_sb->s_fsnotify_mask);
+	marks_mask |= fsnotify_parent_needed_mask(
+				READ_ONCE(inode->i_fsnotify_mask));
+	marks_mask |= fsnotify_parent_needed_mask(
+				READ_ONCE(inode->i_sb->s_fsnotify_mask));
 	marks_mask |= fsnotify_parent_needed_mask(mnt_mask);
 
 	/* Did they subscribe for this event with parent/name info? */
@@ -195,8 +197,8 @@ static bool fsnotify_event_needs_parent(struct inode *inode, __u32 mnt_mask,
 static inline bool fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
 					   __u32 mask)
 {
-	__u32 marks_mask = inode->i_fsnotify_mask | mnt_mask |
-			   inode->i_sb->s_fsnotify_mask;
+	__u32 marks_mask = READ_ONCE(inode->i_fsnotify_mask) | mnt_mask |
+			   READ_ONCE(inode->i_sb->s_fsnotify_mask);
 
 	return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
 }
@@ -213,7 +215,8 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
 		      int data_type)
 {
 	const struct path *path = fsnotify_data_path(data, data_type);
-	__u32 mnt_mask = path ? real_mount(path->mnt)->mnt_fsnotify_mask : 0;
+	__u32 mnt_mask = path ?
+		READ_ONCE(real_mount(path->mnt)->mnt_fsnotify_mask) : 0;
 	struct inode *inode = d_inode(dentry);
 	struct dentry *parent;
 	bool parent_watched = dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED;
@@ -557,13 +560,13 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
 	    (!inode2 || !inode2->i_fsnotify_marks))
 		return 0;
 
-	marks_mask = sb->s_fsnotify_mask;
+	marks_mask = READ_ONCE(sb->s_fsnotify_mask);
 	if (mnt)
-		marks_mask |= mnt->mnt_fsnotify_mask;
+		marks_mask |= READ_ONCE(mnt->mnt_fsnotify_mask);
 	if (inode)
-		marks_mask |= inode->i_fsnotify_mask;
+		marks_mask |= READ_ONCE(inode->i_fsnotify_mask);
 	if (inode2)
-		marks_mask |= inode2->i_fsnotify_mask;
+		marks_mask |= READ_ONCE(inode2->i_fsnotify_mask);
 
 
 	/*
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 4ffc30606e0b9..e163a4b790224 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -569,7 +569,7 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 		/* more bits in old than in new? */
 		int dropped = (old_mask & ~new_mask);
 		/* more bits in this fsn_mark than the inode's mask? */
-		int do_inode = (new_mask & ~inode->i_fsnotify_mask);
+		int do_inode = (new_mask & ~READ_ONCE(inode->i_fsnotify_mask));
 
 		/* update the inode with this new fsn_mark */
 		if (dropped || do_inode)
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 5e170e7130886..c45b222cf9c11 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -128,7 +128,7 @@ __u32 fsnotify_conn_mask(struct fsnotify_mark_connector *conn)
 	if (WARN_ON(!fsnotify_valid_obj_type(conn->type)))
 		return 0;
 
-	return *fsnotify_conn_mask_p(conn);
+	return READ_ONCE(*fsnotify_conn_mask_p(conn));
 }
 
 static void fsnotify_get_sb_watched_objects(struct super_block *sb)
@@ -245,7 +245,11 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 		    !(mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
 			want_iref = true;
 	}
-	*fsnotify_conn_mask_p(conn) = new_mask;
+	/*
+	 * We use WRITE_ONCE() to prevent silly compiler optimizations from
+	 * confusing readers not holding conn->lock with partial updates.
+	 */
+	WRITE_ONCE(*fsnotify_conn_mask_p(conn), new_mask);
 
 	return fsnotify_update_iref(conn, want_iref);
 }
-- 
2.43.0


