Return-Path: <linux-fsdevel+bounces-28175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 295FF96788A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 18:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85F31F21927
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 16:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EB4183CC2;
	Sun,  1 Sep 2024 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mCuJa/Cs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F62C1C68C;
	Sun,  1 Sep 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208382; cv=none; b=oOaNy2/SvRMdQ0rgpF86PyCt6ZxYpffdgpgf3pZ+qXbv5eAOahiW6qVKVxEdBIENFWh2+cvaeMb/LW2T1/do1pH0L6WDNafmH165xQOR9mlLf6sSjYItOq+kr48KuuC/oIa83xtoNCtc8KjqYHfkfnvsUzvqxenWCoSCe+2D8VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208382; c=relaxed/simple;
	bh=qFxpFqMLZ+DFLfzfGFyOQUXyeGsxg2sLnyFJ5vtrwBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqy1Nq6kpFNyIziBXSJ8MeY425muH6XaCunY1Jtyww4A+8QDJKdiYta5LqrLVyH8b+dPuef6qIjIAo1EgTG0AQPJVkOTqqy+VGt+f7FTxBRK7QHJ3JbIrLfyoGggShnywQgIqzxo+vlDsnjcdWCVbu/3pJ1iI+/QNL+RSiwmFlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mCuJa/Cs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA702C4CEC3;
	Sun,  1 Sep 2024 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208382;
	bh=qFxpFqMLZ+DFLfzfGFyOQUXyeGsxg2sLnyFJ5vtrwBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mCuJa/CsG6480KfuMjYtyvW2OfMBCmySkvqeSUTmYGLHSCUvMAzupEbsYwuSudeHq
	 BVacgOp7QFw0GmbwV7FtInGcVipiOxGv5Oppngm7LCnLQ3ysJs8zLRur+o7ajaWeIl
	 lOGeqltbuu6l0fT4nm2yzgjGbtc0RXxp9ooDuDac=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	netfs@lists.linux.dev,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 066/149] afs: Fix post-setattr file edit to do truncation correctly
Date: Sun,  1 Sep 2024 18:16:17 +0200
Message-ID: <20240901160819.949225099@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160817.461957599@linuxfoundation.org>
References: <20240901160817.461957599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit a74ee0e878e262c0276966528d72d4e887174410 ]

At the end of an kAFS RPC operation, there is an "edit" phase (originally
intended for post-directory modification ops to edit the local image) that
the setattr VFS op uses to fix up the pagecache if the RPC that requested
truncation of a file was successful.

afs_setattr_edit_file() calls truncate_setsize() which sets i_size, expands
the pagecache if needed and truncates the pagecache.  The first two of
those, however, are redundant as they've already been done by
afs_setattr_success() under the io_lock and the first is also done under
the callback lock (cb_lock).

Fix afs_setattr_edit_file() to call truncate_pagecache() instead (which is
called by truncate_setsize(), thereby skipping the redundant parts.

Fixes: 100ccd18bb41 ("netfs: Optimise away reads above the point at which there can be no data")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20240823200819.532106-3-dhowells@redhat.com
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Pankaj Raghav <p.raghav@samsung.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/inode.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 3acf5e0500728..a95e77670b494 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -695,13 +695,18 @@ static void afs_setattr_edit_file(struct afs_operation *op)
 {
 	struct afs_vnode_param *vp = &op->file[0];
 	struct afs_vnode *vnode = vp->vnode;
+	struct inode *inode = &vnode->netfs.inode;
 
 	if (op->setattr.attr->ia_valid & ATTR_SIZE) {
 		loff_t size = op->setattr.attr->ia_size;
-		loff_t i_size = op->setattr.old_i_size;
+		loff_t old = op->setattr.old_i_size;
+
+		/* Note: inode->i_size was updated by afs_apply_status() inside
+		 * the I/O and callback locks.
+		 */
 
-		if (size != i_size) {
-			truncate_setsize(&vnode->netfs.inode, size);
+		if (size != old) {
+			truncate_pagecache(inode, size);
 			netfs_resize_file(&vnode->netfs, size, true);
 			fscache_resize_cookie(afs_vnode_cache(vnode), size);
 		}
-- 
2.43.0




