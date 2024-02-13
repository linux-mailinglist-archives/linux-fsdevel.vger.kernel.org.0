Return-Path: <linux-fsdevel+bounces-11448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE636853D56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFE81C26295
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8527262A05;
	Tue, 13 Feb 2024 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtQTNyV5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16E4629E7;
	Tue, 13 Feb 2024 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860291; cv=none; b=AgYFfxcwSXUYGoWaQBTXtoTOvjAb6AQpLz64GCS32gcjOn+65kuJ67bgqOBFwctJ/7G9DO9JNXJEa1YMI12qDfrt2TlHexjrqTF6pUP8W1eUyQslYBhtgmtNlMgUrLt7j7y1iuA3WMvCsY/fD6auYpfgnpAqhDcdejqe7q2swfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860291; c=relaxed/simple;
	bh=SovcTJwr5T0bwcx24VxTqCxw8DF70LVQIJpozpuEJ/c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rW/KUxZb4jC1VjwUzXhJWfah05t/rAqctgkP1j3p+A2hrGDv/jk8j2VtQnGJSXSo9TJyxFqOjmAwL9kuldIKPEA0Uqci+DOu/mMdbGmr4AxQ1SDlksbu4mDXvyMk4twEylCVGKJY3ijm2p90lr4dwKkhGSUa4KCOXMnyTCuCoE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtQTNyV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3E2C433C7;
	Tue, 13 Feb 2024 21:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707860290;
	bh=SovcTJwr5T0bwcx24VxTqCxw8DF70LVQIJpozpuEJ/c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BtQTNyV5Zn/oTgtUO3HAG41FZzx+r21bj4Czooq47TPXHx+lj/idVHknoPLK3RJVH
	 XgyxesfzyB2xskU8InhLkEzRzd2KWcyozSsJCvHLwQa4wW/pOt4dWfHHMJDxF/hD3A
	 LxnOHDiCc8VnukMJfNU0tmiGpoGIVz5iOCXClF4YTEHFcAVLNGtutlmBjVMtVdx6Cb
	 YlYV2q3zpxRKJXV6PPZuUtDHrlJfnxTdXlgzmcoClySh5Gm1bEay5VT63RB9M3AflK
	 19AvfgMz+13A6rmaQthtztDQ268tQjbpw0iXdKSAJPuHCcfVETwWx0apSTAmxJX+fZ
	 BdiSRx/XBm5NA==
Subject: [PATCH RFC 7/7] libfs: Re-arrange locking in offset_iterate_dir()
From: Chuck Lever <cel@kernel.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 hughd@google.com, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 oliver.sang@intel.com, feng.tang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Date: Tue, 13 Feb 2024 16:38:08 -0500
Message-ID: 
 <170786028847.11135.14775608389430603086.stgit@91.116.238.104.host.secureserver.net>
In-Reply-To: 
 <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
References: 
 <170785993027.11135.8830043889278631735.stgit@91.116.238.104.host.secureserver.net>
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

Liam says that, unlike with xarray, once the RCU read lock is
released ma_state is not safe to re-use for the next mas_find() call.
But the RCU read lock has to be released on each loop iteration so
that dput() can be called safely.

Thus we are forced to walk the offset tree with fresh state for each
directory entry. mt_find() can do this for us, though it might be a
little less efficient than maintaining ma_state locally.

Since offset_iterate_dir() doesn't build ma_state locally any more,
there's no longer a strong need for offset_find_next(). Clean up by
rolling these two helpers together.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c |   39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index f073e9aeb2bf..6e01fde1cf95 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -436,23 +436,6 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 	return vfs_setpos(file, offset, MAX_LFS_FILESIZE);
 }
 
-static struct dentry *offset_find_next(struct ma_state *mas)
-{
-	struct dentry *child, *found = NULL;
-
-	rcu_read_lock();
-	child = mas_find(mas, ULONG_MAX);
-	if (!child)
-		goto out;
-	spin_lock(&child->d_lock);
-	if (simple_positive(child))
-		found = dget_dlock(child);
-	spin_unlock(&child->d_lock);
-out:
-	rcu_read_unlock();
-	return found;
-}
-
 static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 {
 	unsigned long offset = dentry2offset(dentry);
@@ -465,13 +448,22 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 {
 	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
-	MA_STATE(mas, &octx->mt, ctx->pos, ctx->pos);
-	struct dentry *dentry;
+	struct dentry *dentry, *found;
+	unsigned long offset;
 
+	offset = ctx->pos;
 	while (true) {
-		dentry = offset_find_next(&mas);
+		found = mt_find(&octx->mt, &offset, ULONG_MAX);
+		if (!found)
+			goto out_noent;
+
+		dentry = NULL;
+		spin_lock(&found->d_lock);
+		if (simple_positive(found))
+			dentry = dget_dlock(found);
+		spin_unlock(&found->d_lock);
 		if (!dentry)
-			return ERR_PTR(-ENOENT);
+			goto out_noent;
 
 		if (!offset_dir_emit(ctx, dentry)) {
 			dput(dentry);
@@ -479,9 +471,12 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 		}
 
 		dput(dentry);
-		ctx->pos = mas.index + 1;
+		ctx->pos = offset;
 	}
 	return NULL;
+
+out_noent:
+	return ERR_PTR(-ENOENT);
 }
 
 /**



