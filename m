Return-Path: <linux-fsdevel+bounces-7391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B279824603
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 17:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2E82833D8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 16:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3E424B33;
	Thu,  4 Jan 2024 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exyevQdT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF824B21;
	Thu,  4 Jan 2024 16:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F23AC433C8;
	Thu,  4 Jan 2024 16:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704385137;
	bh=IhnX4hHtRzrAnyp6d66bwgBG87Kr2elb7Rz8vNJe5Ow=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=exyevQdTifpikJvVAx8GvRRe0QImDeEHYL0iqFdNph/rfjzvuW4+6JQK8h0r1FeYP
	 Xcfx/ApTKUQhFg/5j8GeB/fywzPFql8kG96SXQMHUIh0R88ybRujkETmQLK225lM1v
	 Cr6CRtGpEHG/ueJjpZ9hV7l0ojz+BiFrjhigfdcWmVXGByAsHK26BKcDI+nwO0n/of
	 duKwpN60a2+OrfTHx+mebjo4tGdLKCX4tFt4ArNO7jRsz3F9WNz9RJ52+LRhE/LOAp
	 12mmDK9tyMCpKBflZWrh8Ke2UVOyWDw08BRdvxgOgi/P29xdGNegrzVvzY6PJI3bV6
	 IYY/EP8ITkekg==
Subject: [PATCH v3 1/2] exportfs: fix the fallback implementation of the
 get_name export operation
From: Chuck Lever <cel@kernel.org>
To: jlayton@redhat.com, amir73il@gmail.com
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 trondmy@hammerspace.com, viro@zeniv.linux.org.uk, brauner@kernel.org
Date: Thu, 04 Jan 2024 11:18:55 -0500
Message-ID: 
 <170438513526.129184.11255332860133933464.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170438430288.129184.6116374966267668617.stgit@bazille.1015granger.net>
References: 
 <170438430288.129184.6116374966267668617.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The fallback implementation for the get_name export operation uses
readdir() to try to match the inode number to a filename. That filename
is then used together with lookup_one() to produce a dentry.
A problem arises when we match the '.' or '..' entries, since that
causes lookup_one() to fail. This has sometimes been seen to occur for
filesystems that violate POSIX requirements around uniqueness of inode
numbers, something that is common for snapshot directories.

This patch just ensures that we skip '.' and '..' rather than allowing a
match.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Amir Goldstein <amir73il@gmail.com>
Link: https://lore.kernel.org/linux-nfs/CAOQ4uxiOZobN76OKB-VBNXWeFKVwLW_eK5QtthGyYzWU9mjb7Q@mail.gmail.com/
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/exportfs/expfs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 3ae0154c5680..84af58eaf2ca 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -255,7 +255,9 @@ static bool filldir_one(struct dir_context *ctx, const char *name, int len,
 		container_of(ctx, struct getdents_callback, ctx);
 
 	buf->sequence++;
-	if (buf->ino == ino && len <= NAME_MAX) {
+	/* Ignore the '.' and '..' entries */
+	if ((len > 2 || name[0] != '.' || (len == 2 && name[1] != '.')) &&
+	    buf->ino == ino && len <= NAME_MAX) {
 		memcpy(buf->name, name, len);
 		buf->name[len] = '\0';
 		buf->found = 1;



