Return-Path: <linux-fsdevel+bounces-11442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296DD853D48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5A69B26EC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B3B62173;
	Tue, 13 Feb 2024 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qf4/d1Yg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0246216A;
	Tue, 13 Feb 2024 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860247; cv=none; b=bFbN3VGzqtqCVAPxiyxu6/yWZ28O7KFMnEP5/n84RSUCoQhimr/zy3T2IlvjbPYyQ3BojbZ1OapE/SEtXasiPGKFu1wjKEeFyh09s9V9Qm+xGucCnBvItdfUBALXie/Gtjui+3xAU5aKh1ignQZpQ9pf96qqyiy7FCuQkZhi+YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860247; c=relaxed/simple;
	bh=DgxR48FdvStP6/D6Ne/g9o7gPlflm/a2urdscmeMLJk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5HFQiwQeGxylnHZUuPwcMHYVxdeC2vOhdihTRuvN7O1Atv8aDHIdlPiFeCp08X8+Mk1KV2ZJFk0mpNo9q23P/A6mXQWISmRyzONcLXlPNGqSSNdYuGpXVW24X+u3o4X8EyMqa9ybLAAt9ntviAPTqK1oiF9Vwi/0yO6jscAgKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qf4/d1Yg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEAFC433C7;
	Tue, 13 Feb 2024 21:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707860247;
	bh=DgxR48FdvStP6/D6Ne/g9o7gPlflm/a2urdscmeMLJk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Qf4/d1YgBMtbSniw/Z88hN4lMjBLBDisTs5pGMp+UPlKkqlI/sbFKI33U7LRO+2ay
	 nZw+t7hHnnJwPjgKmA75MYvWUwvIOtRcjz3V9PQoKiIoqz6xKCa+mEUmeNtI5m/xko
	 SQQBO4/wd0ZrZcGZupAzXrUFuFIawodE9jPpQ6ep8tXj3VS6SNGKgCEYPyJERgFyxb
	 4/68TNcUkF28v5gcfRkJsUDp3Su9HGYgbFLfdxfM4zAMXfFr5VRJEdc/pvAmBvdD5e
	 mvOJ7KOHuIm9/QluD4G7YhZraRi4VI/iw19vVrf79E9C+AuWSWbxBaJ0bcueJeh/9s
	 +zD9/Ry1/SiRw==
Subject: [PATCH RFC 1/7] libfs: Rename "so_ctx"
From: Chuck Lever <cel@kernel.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 hughd@google.com, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 oliver.sang@intel.com, feng.tang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Date: Tue, 13 Feb 2024 16:37:25 -0500
Message-ID: 
 <170786024524.11135.12492553100384328157.stgit@91.116.238.104.host.secureserver.net>
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

Most of instances of "so_ctx" were renamed before the simple offset
work was merged, but there were a few that were missed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index eec6031b0155..bfbe1a8c5d2d 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -271,7 +271,7 @@ void simple_offset_init(struct offset_ctx *octx)
  * @octx: directory offset ctx to be updated
  * @dentry: new dentry being added
  *
- * Returns zero on success. @so_ctx and the dentry offset are updated.
+ * Returns zero on success. @octx and the dentry's offset are updated.
  * Otherwise, a negative errno value is returned.
  */
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
@@ -430,8 +430,8 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 
 static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 {
-	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
-	XA_STATE(xas, &so_ctx->xa, ctx->pos);
+	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
+	XA_STATE(xas, &octx->xa, ctx->pos);
 	struct dentry *dentry;
 
 	while (true) {



