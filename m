Return-Path: <linux-fsdevel+bounces-7421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1288249DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 21:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628D01C22A0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 20:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3B82C6A4;
	Thu,  4 Jan 2024 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayZbPGPX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365C28E0D;
	Thu,  4 Jan 2024 20:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E415CC433C7;
	Thu,  4 Jan 2024 20:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704401728;
	bh=IhnX4hHtRzrAnyp6d66bwgBG87Kr2elb7Rz8vNJe5Ow=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ayZbPGPXvWqfwtKSX6X6zZI6EM26dV4fn+554cr4go09tYn7hraciFC2IEqAeHdnt
	 PhOVm3pZa/454HgW27ta0+Cm80OymPFAvCKIU67zPJO4OeAgwNfx7b1xgKaQj/48v2
	 VA49/FxsiLlkvEOWcBKiy1MIX3+OkAim38jhMHb6oPw94H86P1VEEpIwk0weE1UwWS
	 FLYTWtZwAxfPO6T5Dhg3FZ9vChnYvA02tSmpk26GUflJs0VUfLitI21hhC+zATw/20
	 3DWiL+Ik52X+Cwywso/wzSK2Yrmg3Tkaqu5AUSmKnFye9PTOw2S+WAOFz2NdgNuBFf
	 laREqoye1Ld7A==
Subject: [PATCH v4 1/2] exportfs: fix the fallback implementation of the
 get_name export operation
From: Chuck Lever <cel@kernel.org>
To: jlayton@redhat.com, amir73il@gmail.com
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 trondmy@hammerspace.com, viro@zeniv.linux.org.uk, brauner@kernel.org
Date: Thu, 04 Jan 2024 15:55:26 -0500
Message-ID: 
 <170440172682.204613.14380981758225537964.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170440153940.204613.6839922871340228115.stgit@bazille.1015granger.net>
References: 
 <170440153940.204613.6839922871340228115.stgit@bazille.1015granger.net>
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



