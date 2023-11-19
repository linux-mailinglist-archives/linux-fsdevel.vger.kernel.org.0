Return-Path: <linux-fsdevel+bounces-3171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F64A7F097E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 23:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40981F21515
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 22:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3149A1772C;
	Sun, 19 Nov 2023 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4749E;
	Sun, 19 Nov 2023 14:53:45 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp01.aussiebb.com.au (Postfix) with ESMTP id 6AF7F1002E8;
	Mon, 20 Nov 2023 09:53:40 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
	by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DzoD7MaJF9yt; Mon, 20 Nov 2023 09:53:40 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
	id 5FD251002F5; Mon, 20 Nov 2023 09:53:40 +1100 (AEDT)
X-Spam-Level: 
Received: from donald.themaw.com (2403-580f-7fe0--101a.ip6.aussiebb.net [IPv6:2403:580f:7fe0::101a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ian146@aussiebb.com.au)
	by smtp01.aussiebb.com.au (Postfix) with ESMTPSA id 957AD100282;
	Mon, 20 Nov 2023 09:53:38 +1100 (AEDT)
From: Ian Kent <raven@themaw.net>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Bill O'Donnell <billodo@redhat.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Ian Kent <raven@themaw.net>,
	syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com
Subject: [PATCH v2] autofs: add: new_inode check in autofs_fill_super()
Date: Mon, 20 Nov 2023 06:53:19 +0800
Message-ID: <20231119225319.331156-1-raven@themaw.net>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing NULL check of root_inode in autofs_fill_super().

While we are at it simplify the logic by taking advantage of the VFS
cleanup procedures and get rid of the goto error handling, as suggested
by Al Viro.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Bill O'Donnell <billodo@redhat.com>
Reported-by: syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com
---
 fs/autofs/inode.c | 59 ++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 37 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index a5083d447a62..6ecf68536240 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -311,7 +311,6 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 	struct inode *root_inode;
 	struct dentry *root;
 	struct autofs_info *ino;
-	int ret = -ENOMEM;
 
 	pr_debug("starting up, sbi = %p\n", sbi);
 
@@ -328,56 +327,42 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 	 */
 	ino = autofs_new_ino(sbi);
 	if (!ino)
-		goto fail;
+		return -ENOMEM;
 
 	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
-	root_inode->i_uid = ctx->uid;
-	root_inode->i_gid = ctx->gid;
-
-	root = d_make_root(root_inode);
-	if (!root)
-		goto fail_ino;
-
-	root->d_fsdata = ino;
+	if (root_inode) {
+		root_inode->i_uid = ctx->uid;
+		root_inode->i_gid = ctx->gid;
+		root_inode->i_fop = &autofs_root_operations;
+		root_inode->i_op = &autofs_dir_inode_operations;
+	}
+	s->s_root = d_make_root(root_inode);
+	if (unlikely(!s->s_root)) {
+		autofs_free_ino(ino);
+		return -ENOMEM;
+	}
+	s->s_root->d_fsdata = ino;
 
 	if (ctx->pgrp_set) {
 		sbi->oz_pgrp = find_get_pid(ctx->pgrp);
-		if (!sbi->oz_pgrp) {
-			ret = invalf(fc, "Could not find process group %d",
-				     ctx->pgrp);
-			goto fail_dput;
-		}
-	} else {
+		if (!sbi->oz_pgrp)
+			return invalf(fc, "Could not find process group %d",
+				      ctx->pgrp);
+	} else
 		sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
-	}
 
 	if (autofs_type_trigger(sbi->type))
-		__managed_dentry_set_managed(root);
-
-	root_inode->i_fop = &autofs_root_operations;
-	root_inode->i_op = &autofs_dir_inode_operations;
+		/* s->s_root won't be contended so there's little to
+		 * be gained by not taking the d_lock when setting
+		 * d_flags, even when a lot mounts are being done.
+		 */
+		managed_dentry_set_managed(s->s_root);
 
 	pr_debug("pipe fd = %d, pgrp = %u\n",
 		 sbi->pipefd, pid_nr(sbi->oz_pgrp));
 
 	sbi->flags &= ~AUTOFS_SBI_CATATONIC;
-
-	/*
-	 * Success! Install the root dentry now to indicate completion.
-	 */
-	s->s_root = root;
 	return 0;
-
-	/*
-	 * Failure ... clean up.
-	 */
-fail_dput:
-	dput(root);
-	goto fail;
-fail_ino:
-	autofs_free_ino(ino);
-fail:
-	return ret;
 }
 
 /*
-- 
2.41.0


