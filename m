Return-Path: <linux-fsdevel+bounces-3344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B24C7F3A16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 00:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C947282A4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 23:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C2E58129;
	Tue, 21 Nov 2023 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC1482F7;
	Tue, 21 Nov 2023 23:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9167AC433CD;
	Tue, 21 Nov 2023 23:10:56 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97-RC3)
	(envelope-from <rostedt@goodmis.org>)
	id 1r5Ztg-00000002dE7-2p2f;
	Tue, 21 Nov 2023 18:11:12 -0500
Message-ID: <20231121231112.528544825@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 21 Nov 2023 18:10:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/4] eventfs: Move taking of inode_lock into dcache_dir_open_wrapper()
References: <20231121231003.516999942@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The both create_file_dentry() and create_dir_dentry() takes a boolean
parameter "lookup", as on lookup the inode_lock should already be taken,
but for dcache_dir_open_wrapper() it is not taken.

There's no reason that the dcache_dir_open_wrapper() can't take the
inode_lock before calling these functions. In fact, it's better if it
does, as the lock can be held throughout both directory and file
creations.

This also simplifies the code, and possibly prevents unexpected race
conditions when the lock is released.

Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 56d192f0ead8..590e8176449b 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -347,15 +347,8 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 
 	mutex_unlock(&eventfs_mutex);
 
-	/* The lookup already has the parent->d_inode locked */
-	if (!lookup)
-		inode_lock(parent->d_inode);
-
 	dentry = create_file(name, mode, attr, parent, data, fops);
 
-	if (!lookup)
-		inode_unlock(parent->d_inode);
-
 	mutex_lock(&eventfs_mutex);
 
 	if (IS_ERR_OR_NULL(dentry)) {
@@ -453,15 +446,8 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 	}
 	mutex_unlock(&eventfs_mutex);
 
-	/* The lookup already has the parent->d_inode locked */
-	if (!lookup)
-		inode_lock(parent->d_inode);
-
 	dentry = create_dir(ei, parent);
 
-	if (!lookup)
-		inode_unlock(parent->d_inode);
-
 	mutex_lock(&eventfs_mutex);
 
 	if (IS_ERR_OR_NULL(dentry) && !ei->is_freed) {
@@ -693,6 +679,7 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 
+	inode_lock(parent->d_inode);
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
 		d = create_dir_dentry(ei, ei_child, parent, false);
@@ -725,6 +712,7 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 			cnt++;
 		}
 	}
+	inode_unlock(parent->d_inode);
 	srcu_read_unlock(&eventfs_srcu, idx);
 	ret = dcache_dir_open(inode, file);
 
-- 
2.42.0



