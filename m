Return-Path: <linux-fsdevel+bounces-3636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D05B7F6C21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4101C20B7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1847BDDBD;
	Fri, 24 Nov 2023 06:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Bv6kmSv4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5529A19B5;
	Thu, 23 Nov 2023 22:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WdlMjmeNJfREGqWuANDJU4VuiNfuWxzfrjdKu58i0yk=; b=Bv6kmSv4FG6J0DTEPHbR95nSz4
	doiTVehJfYzFMS3rNkrRfiX+O4r6AAi1oSWpBLw64Cmz7Lj+h8tvXY13dWwy2UDG6JoghwTrHIAtE
	pOcESk4I1Xbcha3QU6pWh85eKmqAqhPcsy5SfVjiBEM/aDPQBzpC3no3Z+wkb/1u/uw9KWNo9V6QL
	QUHMb5yp3S/cfJKRA3yEBRtz+L4dbTwsUDO5ytRam91+BBed5qESxTKhSa1LEfI4sNju9DJ4Ub3S1
	ADPGgzWDs3Ri/uKUAqX6OyXnBBNQAS5LG9Rcj9PdYMNohRrLKwivTJawhmxmZbJNurGAdeUDXXawE
	JHbpKgCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PKx-002Q1s-2g;
	Fri, 24 Nov 2023 06:06:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/20] __d_unalias() doesn't use inode argument
Date: Fri, 24 Nov 2023 06:06:42 +0000
Message-Id: <20231124060644.576611-18-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060644.576611-1-viro@zeniv.linux.org.uk>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and hasn't since 2015.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 51e2f777a2c5..b8f502a66e53 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3043,8 +3043,7 @@ struct dentry *d_ancestor(struct dentry *p1, struct dentry *p2)
  * Note: If ever the locking in lock_rename() changes, then please
  * remember to update this too...
  */
-static int __d_unalias(struct inode *inode,
-		struct dentry *dentry, struct dentry *alias)
+static int __d_unalias(struct dentry *dentry, struct dentry *alias)
 {
 	struct mutex *m1 = NULL;
 	struct rw_semaphore *m2 = NULL;
@@ -3125,7 +3124,7 @@ struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
 					inode->i_sb->s_id);
 			} else if (!IS_ROOT(new)) {
 				struct dentry *old_parent = dget(new->d_parent);
-				int err = __d_unalias(inode, dentry, new);
+				int err = __d_unalias(dentry, new);
 				write_sequnlock(&rename_lock);
 				if (err) {
 					dput(new);
-- 
2.39.2


