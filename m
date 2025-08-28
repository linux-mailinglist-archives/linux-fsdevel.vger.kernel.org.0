Return-Path: <linux-fsdevel+bounces-59588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1BBB3AE39
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05D5583F72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED0D2F3C03;
	Thu, 28 Aug 2025 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nvUTXaHo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2952F39BF
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422499; cv=none; b=Sf9XtiL2u7d1FiH9e9bvvuTdjSTDRKcZ1AOykYHWtrrW/ZqwF0ErjLIbruUu9EzOfiDznql9UmaqxtggcvPORQo+kDccLji/6OtfPstUe1UFyjNb3cYdqJ3YlRtTv4J6FYR6viA4yyLx1E43kbsL+Hrj0a7Ji3C3H0O/OcDdOXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422499; c=relaxed/simple;
	bh=Iby5EXCqRGBL1A7gR/Qw3UMByGOX5C3uKFUjKMDvDMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUFneAnq+yEw475zMgBoyfmktFhhRttxCzxz8zBzMmpYVy67rCj5v7oC3IAPEtlKgtFQzmXVqIjCJxm7zgGIaBj9EMM+alOE1hMhr9EYVQMSE6iAhgtM889vg/fmz28u7doFIhtQKgnL2iWEQGKyVi9blfUKZw5etVcxXEQWC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nvUTXaHo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dFc7HzgbpH2BgiI2TFfpRWmue4ruDWn/qwgAnX/EXXE=; b=nvUTXaHoYLGy7Op3W9TiVHxkBs
	uE0BZMWjxix+Er4nYhkBkDZkGa74ShljHYs86+xTAYOQOGbUUEmMJEaqUm5XFukGg/e//4N7Q/xSh
	LZh5uZbmGHePOpSg8/rKlxpDuV0X5RZV8OBO0BpEFpf0LKLxcC9eMzIc+Tor/sevGEe925gF63XCR
	uoMyZAUaQPnmYvaGPQoA5zBb5jjx8WfV0RG5THr8ZolOfjsfUsFbZ/+DLNB8SsrOjKHYHcOFQ0qct
	YSmffR0wATSNs5XF1g6B58K9KE21cqvVtdNB4lKwrIWxdFFbDQbcMCax/E85QAyPNGlyoKxXyb9qq
	hw0AFN4g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj4-0000000F2A6-2CKF;
	Thu, 28 Aug 2025 23:08:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 54/63] open_detached_copy(): don't bother with mount_lock_hash()
Date: Fri, 29 Aug 2025 00:07:57 +0100
Message-ID: <20250828230806.3582485-54-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

we are holding namespace_sem and a reference to root of tree;
iterating through that tree does not need mount_lock.  Neither
does the insertion into the rbtree of new namespace or incrementing
the mount count of that namespace.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2e35f5eb4f81..425c33377770 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3086,14 +3086,12 @@ static struct file *open_detached_copy(struct path *path, bool recursive)
 		return ERR_CAST(mnt);
 	}
 
-	lock_mount_hash();
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
 		mnt_add_to_ns(ns, p);
 		ns->nr_mounts++;
 	}
 	ns->root = mnt;
 	mntget(&mnt->mnt);
-	unlock_mount_hash();
 	namespace_unlock();
 
 	mntput(path->mnt);
-- 
2.47.2


