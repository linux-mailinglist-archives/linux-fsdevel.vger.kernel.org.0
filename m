Return-Path: <linux-fsdevel+bounces-3465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 668097F50C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 20:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978571C20B34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6775C915;
	Wed, 22 Nov 2023 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="flAxY/Wb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1531A8;
	Wed, 22 Nov 2023 11:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=74v1Dg7yBE+4rxKY7xG9GKf0VfPvIUvY43ZeQBhdM3Q=; b=flAxY/WbiiMK3fPdqrhtjrTbxn
	knWsKpeOfxS/4NrPxAIcl8WOgTbfTXsv0aD4CodgCbFtRtHRh66vrZXa+5JY3Rgn7LEdSvGS1DiMO
	kSrZkHjLnDAcilDWdjOzrILwGHoUz/p/al5cIA2WRE9QA9jcYJgZDkgvXuukrsHhU8Db9IqZR8gma
	4EbU61wQYxwy/NpdYp7IL+2NKlEDEQX/7r9fWfe7WVxxh1WvoMtG8BCEniS6YnOodUM/LCcyJ0E8i
	lS7BEu4tFzW7o6EBDkkcrKvhMHj4sFIRILfKgOG6AFT1RAapGtNYrUBIStplYTjITEstVZC8PnDi5
	AvB/GrOw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5t1o-001l1g-2B;
	Wed, 22 Nov 2023 19:36:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mo Zou <lostzoumo@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] ocfs2: Avoid touching renamed directory if parent does not change
Date: Wed, 22 Nov 2023 19:36:45 +0000
Message-Id: <20231122193652.419091-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231122193652.419091-1-viro@zeniv.linux.org.uk>
References: <20231122193028.GE38156@ZenIV>
 <20231122193652.419091-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

From: Jan Kara <jack@suse.cz>

The VFS will not be locking moved directory if its parent does not
change. Change ocfs2 rename code to avoid touching renamed directory if
its parent does not change as without locking that can corrupt the
filesystem.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ocfs2/namei.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 814733ba2f4b..9221a33f917b 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -1336,7 +1336,7 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
 		goto bail;
 	}
 
-	if (S_ISDIR(old_inode->i_mode)) {
+	if (S_ISDIR(old_inode->i_mode) && new_dir != old_dir) {
 		u64 old_inode_parent;
 
 		update_dot_dot = 1;
@@ -1353,8 +1353,7 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
 			goto bail;
 		}
 
-		if (!new_inode && new_dir != old_dir &&
-		    new_dir->i_nlink >= ocfs2_link_max(osb)) {
+		if (!new_inode && new_dir->i_nlink >= ocfs2_link_max(osb)) {
 			status = -EMLINK;
 			goto bail;
 		}
@@ -1601,6 +1600,9 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
 			mlog_errno(status);
 			goto bail;
 		}
+	}
+
+	if (S_ISDIR(old_inode->i_mode)) {
 		drop_nlink(old_dir);
 		if (new_inode) {
 			drop_nlink(new_inode);
-- 
2.39.2


