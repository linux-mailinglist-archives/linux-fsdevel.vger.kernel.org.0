Return-Path: <linux-fsdevel+bounces-40063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A6FA1BCBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974583A3C39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 19:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AB4224AF5;
	Fri, 24 Jan 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKo7eiYs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3489CA64;
	Fri, 24 Jan 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737746392; cv=none; b=D4JH6EGPJ7aKlCZtCyGYnUp/GL+Rd2mEXZn68vZiZz4TDK17o5KkxWKaWAoLGDv4WwIR0LxKQNCpYsuyZBL6Y/ZkduEqztBlGaIw/wuDU+dBDk+XEvWZ3ikWPQnqqCYN1NDXyHe8zBhOdPeyDSrtMAVovPSgkRgfiM4SwRDl+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737746392; c=relaxed/simple;
	bh=AAimS1DXsD+1vqFtQxl+lQZkXctbDP9Ux3Ct0lAIRKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUYpOkNq4/AhQmzoDmVUycljUJNVGe38lYsbD0r/wZgSGYdjwGDvgHMCn2nRszCaGpUeBRMExUhf40TA9vD20805wAbFsRxivNU/w/2AGMiNKUn5Yrx/hHT0q60o45iD0fqg8zQLZAr0nCEwrJPfLBO+Gtqb81MAoUgh6eFzFSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKo7eiYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2853FC4CEE3;
	Fri, 24 Jan 2025 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737746391;
	bh=AAimS1DXsD+1vqFtQxl+lQZkXctbDP9Ux3Ct0lAIRKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QKo7eiYsDqb+VJ1oghRzIW9zWNc0+ukRB/vdi13rpjkOm/x9/En0p5WvGX9nbJBoE
	 HKKpJWQKWEq9pjE+a5Gj5Vkn3ZJDWMNASXHPi/KNRrCFjDrc2JApS7dOBmshLFifcJ
	 kQHpa+wwadPT1PZ35KhcpESCLAeXiAYkgJOpq7xYRwZjpO+AjnvksUFltUOinBZ/ys
	 oDlVcHtv4t6rEoisItohXmncZXTf5yIiyu2U8gGGuNLFtRu8nCIFZZfjxilbyW7BD2
	 Sp6Py8Q3zyWbOYEDHjsfHF6GR4d6tifGaCioJUdrvRKF7xpSpxttbURQsEQhr1uQCZ
	 QgUKGWdEXQJlQ==
From: cel@kernel.org
To: Hugh Dickins <hughd@google.com>,
	Andrew Morten <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	<stable@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huawei.com,
	Chuck Lever <chuck.lever@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH v6.6 01/10] libfs: Re-arrange locking in offset_iterate_dir()
Date: Fri, 24 Jan 2025 14:19:36 -0500
Message-ID: <20250124191946.22308-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250124191946.22308-1-cel@kernel.org>
References: <20250124191946.22308-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 3f6d810665dfde0d33785420618ceb03fba0619d ]

Liam and Matthew say that once the RCU read lock is released,
xa_state is not safe to re-use for the next xas_find() call. But the
RCU read lock must be released on each loop iteration so that
dput(), which might_sleep(), can be called safely.

Thus we are forced to walk the offset tree with fresh state for each
directory entry. xa_find() can do this for us, though it might be a
little less efficient than maintaining xa_state locally.

We believe that in the current code base, inode->i_rwsem provides
protection for the xa_state maintained in
offset_iterate_dir(). However, there is no guarantee that will
continue to be the case in the future.

Since offset_iterate_dir() doesn't build xa_state locally any more,
there's no longer a strong need for offset_find_next(). Clean up by
rolling these two helpers together.

Suggested-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Message-ID: <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/r/170820142021.6328.15047865406275957018.stgit@91.116.238.104.host.secureserver.net
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index dc0f7519045f..430f7c95336c 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -401,12 +401,13 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 	return vfs_setpos(file, offset, U32_MAX);
 }
 
-static struct dentry *offset_find_next(struct xa_state *xas)
+static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
 {
 	struct dentry *child, *found = NULL;
+	XA_STATE(xas, &octx->xa, offset);
 
 	rcu_read_lock();
-	child = xas_next_entry(xas, U32_MAX);
+	child = xas_next_entry(&xas, U32_MAX);
 	if (!child)
 		goto out;
 	spin_lock(&child->d_lock);
@@ -429,12 +430,11 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 
 static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 {
-	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
-	XA_STATE(xas, &so_ctx->xa, ctx->pos);
+	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
 	struct dentry *dentry;
 
 	while (true) {
-		dentry = offset_find_next(&xas);
+		dentry = offset_find_next(octx, ctx->pos);
 		if (!dentry)
 			return ERR_PTR(-ENOENT);
 
@@ -443,8 +443,8 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 			break;
 		}
 
+		ctx->pos = dentry2offset(dentry) + 1;
 		dput(dentry);
-		ctx->pos = xas.xa_index + 1;
 	}
 	return NULL;
 }
-- 
2.47.0


