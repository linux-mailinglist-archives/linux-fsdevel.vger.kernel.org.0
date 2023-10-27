Return-Path: <linux-fsdevel+bounces-1311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E5D7D8EDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB29E28228E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 06:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9AF79DE;
	Fri, 27 Oct 2023 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103901FD5
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:40:08 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A8F121
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 23:40:07 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id F061167373; Fri, 27 Oct 2023 08:40:02 +0200 (CEST)
Date: Fri, 27 Oct 2023 08:40:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] Implement freeze and thaw as holder operations
Message-ID: <20231027064001.GA9469@lst.de>
References: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024-vfs-super-freeze-v2-0-599c19f4faac@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Btw, while reviewing this I also noticed that thaw_super_locked feels
unreasonably convoluted.  Maybe something like this would be a good
addition for the branch?


---
From f5cbee13dcca6b025c82b365042bc5fab7ac6642 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 27 Oct 2023 08:36:04 +0200
Subject: fs: streamline thaw_super_locked

Add a new out_unlock label to share code that just releases s_umount
and returns an error, and rename and reuse the out label that deactivates
the sb for one more case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/super.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index b26b302f870d24..38381c4b76f09e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -2098,34 +2098,28 @@ EXPORT_SYMBOL(freeze_super);
  */
 static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 {
-	int error;
+	int error = -EINVAL;
 
-	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
-		if (!(sb->s_writers.freeze_holders & who)) {
-			super_unlock_excl(sb);
-			return -EINVAL;
-		}
+	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE)
+		goto out_unlock;
+	if (!(sb->s_writers.freeze_holders & who))
+		goto out_unlock;
 
-		/*
-		 * Freeze is shared with someone else.  Release our hold and
-		 * drop the active ref that freeze_super assigned to the
-		 * freezer.
-		 */
-		if (sb->s_writers.freeze_holders & ~who) {
-			sb->s_writers.freeze_holders &= ~who;
-			deactivate_locked_super(sb);
-			return 0;
-		}
-	} else {
-		super_unlock_excl(sb);
-		return -EINVAL;
+	/*
+	 * Freeze is shared with someone else.  Release our hold and drop the
+	 * active ref that freeze_super assigned to the freezer.
+	 */
+	error = 0;
+	if (sb->s_writers.freeze_holders & ~who) {
+		sb->s_writers.freeze_holders &= ~who;
+		goto out_deactivate;
 	}
 
 	if (sb_rdonly(sb)) {
 		sb->s_writers.freeze_holders &= ~who;
 		sb->s_writers.frozen = SB_UNFROZEN;
 		wake_up_var(&sb->s_writers.frozen);
-		goto out;
+		goto out_deactivate;
 	}
 
 	lockdep_sb_freeze_acquire(sb);
@@ -2135,8 +2129,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 		if (error) {
 			printk(KERN_ERR "VFS:Filesystem thaw failed\n");
 			lockdep_sb_freeze_release(sb);
-			super_unlock_excl(sb);
-			return error;
+			goto out_unlock;
 		}
 	}
 
@@ -2144,9 +2137,13 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who)
 	sb->s_writers.frozen = SB_UNFROZEN;
 	wake_up_var(&sb->s_writers.frozen);
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
-out:
+out_deactivate:
 	deactivate_locked_super(sb);
 	return 0;
+
+out_unlock:
+	super_unlock_excl(sb);
+	return error;
 }
 
 /**
-- 
2.39.2


