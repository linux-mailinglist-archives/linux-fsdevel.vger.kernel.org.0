Return-Path: <linux-fsdevel+bounces-11919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1781B8592A0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 21:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C713D2823CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 20:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E957E593;
	Sat, 17 Feb 2024 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4X30OxK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6DC7F48B;
	Sat, 17 Feb 2024 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708201422; cv=none; b=OPCVtslzwYeUx0LNhhbZ+xx97T07EOaZWxcQzjb4C9X6X/t+qEQBRncuuMge1Ed4r5l8aa1ZdWU2i/VO2mHpQOkdZd7g7HVtNJN8jB7CdldziP7VTt43AJtHXDIgiE19rGX5YmjVOYdTtCiET/PSbzcq8LoCsW8tjDkQ0zA06Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708201422; c=relaxed/simple;
	bh=R5X4D36CuE1wpCsrFE/3Fuex0DnO2GtnjfkqVv5cjQg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzUEFfjFPuZ4aoi9hVC7uDl1OA6ZiB7JI7Kq1Qy9L2bjt/iHE06/moj1rpQppUAJUSpiwb3YO1F9SdGdpH7KPhJTTdoRU+gxk417zW5XEqClsIFHldXRi7aae1KuxNvr+2aDrOFAdVDUkrqobXpOZbzt/y1P3e0RSfotP8lYOHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4X30OxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32618C433F1;
	Sat, 17 Feb 2024 20:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708201422;
	bh=R5X4D36CuE1wpCsrFE/3Fuex0DnO2GtnjfkqVv5cjQg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=P4X30OxKc0EN8nPXm8GE/AdSc3yeT5iVNwWMRGyRMVcJFIie5F4caTrhUc28NAuXO
	 9voVKSq/opp81jg2cRH3/szMzpTTQ/4XgrT8WdD2WpFkvBWhxoEj1F/vcTYv1kOP4+
	 FZdDrkL9Ov1gk0qvcx9T66jKl6xWpHB0h4rQB5Ze7WhCUX3SKZ6cEUOGk9Z5vnO5+j
	 XY0aze0RMR8AG9xJitjPfN95aBR+joD0NoDr2zyACqqmGYNchunmvsmDUeW9cgCf9a
	 DCi8QemiRpOkaILmDK6aiHQNcv88w0pNMBL71uYhHVosom/O2z6gP7OwvFkgLUc3ph
	 MCA7wONlVDoYw==
Subject: [PATCH v2 1/6] libfs: Re-arrange locking in offset_iterate_dir()
From: Chuck Lever <cel@kernel.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 hughd@google.com, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 oliver.sang@intel.com, feng.tang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Date: Sat, 17 Feb 2024 15:23:40 -0500
Message-ID: 
 <170820142021.6328.15047865406275957018.stgit@91.116.238.104.host.secureserver.net>
In-Reply-To: 
 <170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net>
References: 
 <170820083431.6328.16233178852085891453.stgit@91.116.238.104.host.secureserver.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

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
---
 fs/libfs.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index eec6031b0155..752e24c669d9 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -402,12 +402,13 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
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
@@ -430,12 +431,11 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 
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
 
@@ -444,8 +444,8 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 			break;
 		}
 
+		ctx->pos = dentry2offset(dentry) + 1;
 		dput(dentry);
-		ctx->pos = xas.xa_index + 1;
 	}
 	return NULL;
 }



