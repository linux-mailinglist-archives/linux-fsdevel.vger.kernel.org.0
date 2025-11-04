Return-Path: <linux-fsdevel+bounces-66941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5A5C30ED2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736F018C4575
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558092F6560;
	Tue,  4 Nov 2025 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lL0TEYpk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CCB2F6166;
	Tue,  4 Nov 2025 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258373; cv=none; b=kI7jb9slT6oA0U8vYmUzuygFx6/eN0EuZ8aL7+uQhtkJWrhd8oB5DGmhBq6ocMkNnODu8dcH0ke60vLinaC9RzdUEjMXxS3eH3eXJSJkYG/lTL/LU24nzJ2h7N7LanhFSbW8H6hadX0XvQi/iAbqXnbJHPgQFXypI1YwZfWeW50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258373; c=relaxed/simple;
	bh=j43u69lY2L8m7hBFsetpVJRhjSFaP4gqX0tweq1oFtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F923KcBIEj+2jjqnjYN6fMCqAAlvuFf3Cli8iDD1qJUrGAVIDz8314ep2aMx+6d7z0QNHgTSmmm7UShmqTcE8TKBQhci68RZzN4vViFCoezy7leNC6+YG5SWZHedxaQWRV/cD8nXcvjYfFo71wre1Zx0xG+7tqvR1r+B8rSpZRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lL0TEYpk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB53AC116C6;
	Tue,  4 Nov 2025 12:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762258373;
	bh=j43u69lY2L8m7hBFsetpVJRhjSFaP4gqX0tweq1oFtg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lL0TEYpkshL4ahHy+WhlA4T61e/VYgxMpKs4GyEdB+u8us+M6Jlh4b4ahACR8pDLk
	 zBNWIYpjqcgXrTYVDIEFMdQ+0LvIJyUE4+Emm1JRpEmsMgm3jrW78qMou5aJ/HNSc3
	 7Ckau+7P9Do39PNMNAL9DYtFBYnyRZdlV/Cyq9f2pnGYefx+r4tSSVsMB+GvbzpcUr
	 zL3o3jQus5IYN+C0es9XdDE/6S6cKbeved6kiSIPe44KKi/31m7tBLKnmE6y/3IM7j
	 Rhh/pocyqHE+bXJio2k+cxZqEUXDGIAiN9YTj1B9MnihQFeRQpvmhPsPyz3tR/cccC
	 t9c3t1/S8bGPA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Nov 2025 13:12:36 +0100
Subject: [PATCH RFC 7/8] open: use super write guard in do_ftruncate()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-work-guards-v1-7-5108ac78a171@kernel.org>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
In-Reply-To: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=784; i=brauner@kernel.org;
 h=from:subject:message-id; bh=j43u69lY2L8m7hBFsetpVJRhjSFaP4gqX0tweq1oFtg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyvt3C7/WZq/Ll2vm9LzWaD4b+71JcZuL9nJflkbthn
 fbS5yw5HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPxFmT4n3Dqz81Y7ll/7s/Z
 63gy48oU0RT9xrPKTQf+fVXqvJTkzsPIcNTrBtMb3uqbDRNvTC2qmiOjVW1nHDrRv4Zp21KFFmN
 2fgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/open.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 3d64372ecc67..1d73a17192da 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -191,12 +191,9 @@ int do_ftruncate(struct file *file, loff_t length, int small)
 	if (error)
 		return error;
 
-	sb_start_write(inode->i_sb);
-	error = do_truncate(file_mnt_idmap(file), dentry, length,
-			    ATTR_MTIME | ATTR_CTIME, file);
-	sb_end_write(inode->i_sb);
-
-	return error;
+	scoped_guard(super_write, inode->i_sb)
+		return do_truncate(file_mnt_idmap(file), dentry, length,
+				   ATTR_MTIME | ATTR_CTIME, file);
 }
 
 int do_sys_ftruncate(unsigned int fd, loff_t length, int small)

-- 
2.47.3


