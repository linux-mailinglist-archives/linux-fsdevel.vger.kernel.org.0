Return-Path: <linux-fsdevel+bounces-3628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C867F6C18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EB41C20C95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DA7AD55;
	Fri, 24 Nov 2023 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QsAPWECo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EA24C11;
	Thu, 23 Nov 2023 22:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=r3JK578nvtRlEYlNy4HHNA64A/oAo9K1qeY4IrJLMig=; b=QsAPWECon8p/NpfQGwzXLYe2ks
	12oFosRYi6VLL/kLJA1/GQeO2o1NZKNR0t0AeWviZJdzl0JOG0REjzGQYTt62huj+9G6+oVZIxCfI
	UgySibO5LppS8k8K6owd1Tx44nHfOTgwatSJ7VuoQvr9/ytnkOymAMbgHeiKJp3Kz6okDJTrlZY04
	RfEWBgXx7bU9U4ulQ+bQAbMVz5tUCoycmq+mpvFP1Nm+S5t7Wqkl4SmKqkHy7+NrCaRK/RC/qcHjI
	yhFSTZ2gOoNYaxFyOUDIotSwF2V76gIZkMCKqmpvDR9Ks9Kh41OXsN9iklO3A69rwpN4aodWjyjRj
	X6VAzxWg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PKw-002Q1L-2H;
	Fri, 24 Nov 2023 06:06:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/20] nsfs: use d_make_root()
Date: Fri, 24 Nov 2023 06:06:37 +0000
Message-Id: <20231124060644.576611-13-viro@zeniv.linux.org.uk>
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

Normally d_make_root() is used to create the root dentry of superblock;
here we use it for a different purpose, but... idiomatic or not, we
need the same operation.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nsfs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 9a4b228d42fa..34e1e3e36733 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -90,12 +90,9 @@ static int __ns_get_path(struct path *path, struct ns_common *ns)
 	inode->i_fop = &ns_file_operations;
 	inode->i_private = ns;
 
-	dentry = d_alloc_anon(mnt->mnt_sb);
-	if (!dentry) {
-		iput(inode);
+	dentry = d_make_root(inode);	/* not the normal use, but... */
+	if (!dentry)
 		return -ENOMEM;
-	}
-	d_instantiate(dentry, inode);
 	dentry->d_fsdata = (void *)ns->ops;
 	d = atomic_long_cmpxchg(&ns->stashed, 0, (unsigned long)dentry);
 	if (d) {
-- 
2.39.2


