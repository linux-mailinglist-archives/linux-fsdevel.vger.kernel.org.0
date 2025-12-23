Return-Path: <linux-fsdevel+bounces-71992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B7CCDAB89
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 22:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB0D6306B1A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 21:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B955631327D;
	Tue, 23 Dec 2025 21:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amifNo97"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2041330FC15;
	Tue, 23 Dec 2025 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766526895; cv=none; b=V92zn4xL7mjnE2xjyeBs8Q5V8PkVSWxabsBn0M0FJLvH6iBXGixgg+CErHke+DBKSqHcZpgn7P9tEhZe8U9jZYAq7xmPkY3E5Qj3qDqlHDFFbHwnhW5xcd11VA0BX58nodCKWo6FwTvcmCVDkXZxIU22WkwjdW3aop+u5v5AXN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766526895; c=relaxed/simple;
	bh=/ThjeHJVc4uo3oQeJNNaMpnrdREXhO4j45azc7TnHwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ff8P7mmYrEtZ/fD7KxkmgRPWzUU+kkHfKOkg+NxItMEcY8toJjtMXlrLGdBkFFPWBiME90Wh0/CvrDmuJ+U5XA+G2Qm9kK8JJ5c8fPejHBee2ud2OCrvmjP5UbeGqQmSlQkd6KQqwYZFpkmvrwRu6DBz5RMuoV5E/ZA/vqXko+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amifNo97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F0CC113D0;
	Tue, 23 Dec 2025 21:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766526894;
	bh=/ThjeHJVc4uo3oQeJNNaMpnrdREXhO4j45azc7TnHwo=;
	h=From:To:Cc:Subject:Date:From;
	b=amifNo97AOPiN4A7nS49g8y5wS7y+et3H7E1JacvoQnu2iSFN52M5sutfqlSZFulp
	 nB9dD+eez7RkRg5tKZvnGY4qyN7OEeokxOZfN7rd48GRUcKmAqDaQjCAdWyZT+d70v
	 3MJ4OtxTZAygGuac6rZyJqXn8hj7C5Lk98oQnIulbhjskCmE3+xEN5UJAqoacN0fWY
	 SGDP8wSe0i8SDraI/fqFci5OEMb0hD9sVkoBIpjlvNAwiIJnzx3y37/XCCW3yXRjHX
	 DARW9eztErNu+rE6iO3kuXFlP42vBA6dr3TR1gpwbFTD+o4/EVkvmxNGvZQnDu471R
	 jZvHl5rR9i8Zw==
From: Arnd Bergmann <arnd@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Joanne Koong <joannelkoong@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: fuse: fix max() of incompatible types
Date: Tue, 23 Dec 2025 22:54:03 +0100
Message-Id: <20251223215442.720828-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The 'max()' value of a 'long long' and an 'unsigned int' is problematic
if the former is negative:

In function 'fuse_wr_pages',
    inlined from 'fuse_perform_write' at fs/fuse/file.c:1347:27:
include/linux/compiler_types.h:652:45: error: call to '__compiletime_assert_390' declared with attribute error: min(((pos + len - 1) >> 12) - (pos >> 12) + 1, max_pages) signedness error
  652 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^

Use a temporary variable to make it clearer what is going on here.

Fixes: 0f5bb0cfb0b4 ("fs: use min() or umin() instead of min_t()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/fuse/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 4f71eb5a9bac..d3dec67d73fc 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1323,8 +1323,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 static inline unsigned int fuse_wr_pages(loff_t pos, size_t len,
 				     unsigned int max_pages)
 {
-	return min(((pos + len - 1) >> PAGE_SHIFT) - (pos >> PAGE_SHIFT) + 1,
-		   max_pages);
+	unsigned int pages = ((pos + len - 1) >> PAGE_SHIFT) -
+			     (pos >> PAGE_SHIFT) + 1;
+
+	return min(pages, max_pages);
 }
 
 static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
-- 
2.39.5


