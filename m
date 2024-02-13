Return-Path: <linux-fsdevel+bounces-11443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A198853D49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 22:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FB028FD8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994256167E;
	Tue, 13 Feb 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/MEawuU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED835612FE;
	Tue, 13 Feb 2024 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860255; cv=none; b=gPPErK0qRkQHam2HyJOoBmWhCRJP9Zeo9X78oPmaGhzSs1JR1QtsXF3qo73r46fyjAgm+1l2wpQyUCsZCCvaN9gPqJ3lEC8fvYzk0fCNQyZL7Ns+/505fqJ/l29OyO1R/SnKHhvnh9aoBNIxfxcUYPdJnn0WtmaTXQw2wktCQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860255; c=relaxed/simple;
	bh=O0qvn792AlXiXQ1lPPSwqR9KB9RhTSpZi4O/hP+kqjE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTFCLqsV6zZCsC7e3ajXCAozB41GhRegOtp+DOuRE1kk6ToUIxtP6KGtvPGz2UjaO5TzwmJ5JSQqjn0MgpVknVnwuHLwbDFBF6p9yiMut/1KYQrgVV3Tm+Pkf5YcDQZixSxES4xK60knu/kj4+xCd1BfdrK6ivp4ivVYEHNHlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/MEawuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D906C43390;
	Tue, 13 Feb 2024 21:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707860254;
	bh=O0qvn792AlXiXQ1lPPSwqR9KB9RhTSpZi4O/hP+kqjE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Z/MEawuUMQulNCp3MzLp2FmSSCfSgusNftEj26+lYW33qg3nVQgaYiwA/JCowq7NM
	 UoX2zesRaT68Nrwd8NX3XY9+HeCzOAKrXh9q+a2QuyR3XFug07/4eurf+sd/VWQwQz
	 u6UnXVo1sm6+EFDsCqRoRkAXjb/yXCTJW2mUFtRM/z3D12EH5T4iDL3KGIH4lRDfkm
	 LGL5+KOaU4C13CeGv8HXfxKN1X702KXavl8GCO3zYbhf/FzrlS1bI10WT8bpxMnz2a
	 Jc2Ikzn20LMe/okVAdTAeuZjsWRAww2x+GFLS+XM3E5c8lhxYbjiKkMAs/IyqJULrd
	 wSQ6F6bJbwXGQ==
Subject: [PATCH RFC 2/7] libfs: Define a minimum directory offset
From: Chuck Lever <cel@kernel.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 hughd@google.com, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 oliver.sang@intel.com, feng.tang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-mm@kvack.org, lkp@intel.com
Date: Tue, 13 Feb 2024 16:37:32 -0500
Message-ID: 
 <170786025248.11135.14453586596030949713.stgit@91.116.238.104.host.secureserver.net>
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

This value is used in several places, so make it a symbolic
constant.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index bfbe1a8c5d2d..a38af72f4719 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -240,6 +240,11 @@ const struct inode_operations simple_dir_inode_operations = {
 };
 EXPORT_SYMBOL(simple_dir_inode_operations);
 
+/* 0 is '.', 1 is '..', so always start with offset 2 or more */
+enum {
+	DIR_OFFSET_MIN	= 2,
+};
+
 static void offset_set(struct dentry *dentry, u32 offset)
 {
 	dentry->d_fsdata = (void *)((uintptr_t)(offset));
@@ -261,9 +266,7 @@ void simple_offset_init(struct offset_ctx *octx)
 {
 	xa_init_flags(&octx->xa, XA_FLAGS_ALLOC1);
 	lockdep_set_class(&octx->xa.xa_lock, &simple_offset_xa_lock);
-
-	/* 0 is '.', 1 is '..', so always start with offset 2 */
-	octx->next_offset = 2;
+	octx->next_offset = DIR_OFFSET_MIN;
 }
 
 /**
@@ -276,7 +279,7 @@ void simple_offset_init(struct offset_ctx *octx)
  */
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 {
-	static const struct xa_limit limit = XA_LIMIT(2, U32_MAX);
+	static const struct xa_limit limit = XA_LIMIT(DIR_OFFSET_MIN, U32_MAX);
 	u32 offset;
 	int ret;
 
@@ -481,7 +484,7 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 		return 0;
 
 	/* In this case, ->private_data is protected by f_pos_lock */
-	if (ctx->pos == 2)
+	if (ctx->pos == DIR_OFFSET_MIN)
 		file->private_data = NULL;
 	else if (file->private_data == ERR_PTR(-ENOENT))
 		return 0;



