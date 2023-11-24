Return-Path: <linux-fsdevel+bounces-3635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8207F6C20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0831C1C20CD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E729DCA49;
	Fri, 24 Nov 2023 06:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k4pyVtzO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A714C13;
	Thu, 23 Nov 2023 22:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/IlHdjyXvMUq90PQPZsasCErAt9FORhE4yKp5BHiqsk=; b=k4pyVtzOc2QWXYEOEOuKRMpx1h
	6i5vBKNCgQb5KTf/XK60hSS3HkZQInhpBowEwAkDDeDuFpwoFpHLpKUEQlLBPkdWQwvTuF02foGNL
	lA682vraOMmeUo8iKDHR3oarSUj7urIxu6jz4SjQDrAdV1IUfqp3+89lJoFOGU7QeMkj1yyMZalFw
	E/H4kHQkiEJEQQSQMHFEpsEnpN5B4hgCQZnxaiRGkxlYsSBzYw0JM1i3Jf66QPrH073FwoxJQMCrv
	krGRMDnJ09vA6SV6PC+35yDCR6lLKokFQX9nZOTursyH6MTA41qUQC8RWuYfyNqBKiSLisy398SOx
	GLjKyGkQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PKx-002Q1Z-0V;
	Fri, 24 Nov 2023 06:06:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/20] d_genocide(): move the extern into fs/internal.h
Date: Fri, 24 Nov 2023 06:06:39 +0000
Message-Id: <20231124060644.576611-15-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/internal.h          | 1 +
 include/linux/dcache.h | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 9e9fc629f935..d9a920e2636e 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -219,6 +219,7 @@ extern void shrink_dcache_for_umount(struct super_block *);
 extern struct dentry *__d_lookup(const struct dentry *, const struct qstr *);
 extern struct dentry *__d_lookup_rcu(const struct dentry *parent,
 				const struct qstr *name, unsigned *seq);
+extern void d_genocide(struct dentry *);
 
 /*
  * pipe.c
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 8c5e3bdf1147..b4324d47f249 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -243,9 +243,6 @@ extern void d_invalidate(struct dentry *);
 /* only used at mount-time */
 extern struct dentry * d_make_root(struct inode *);
 
-/* <clickety>-<click> the ramfs-type tree */
-extern void d_genocide(struct dentry *);
-
 extern void d_mark_tmpfile(struct file *, struct inode *);
 extern void d_tmpfile(struct file *, struct inode *);
 
-- 
2.39.2


