Return-Path: <linux-fsdevel+bounces-59573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF42B3AE2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D81C1C802F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECA02FAC1F;
	Thu, 28 Aug 2025 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="L/jNo2AM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40FC2ED159
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422497; cv=none; b=EDlW7bc8KKDQtExkZ8SVRdfbUYcHLmeW96wDecqlNAGn86LEyL0RYFWf+Mnkuj5H+2RJg4a0kDfw4VqyJVQWumLNyM0Hs5w7Yl3HWmXFdAGj1gqCiF00hfAXBIfVetVxP/OpC+qsce/ruLQsFT1LuiNTc+VxHAQqJG0rcdQ/38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422497; c=relaxed/simple;
	bh=q/BZ2uAgeA9f54U/Awp6B/hjfR4/33yKhnGosbhdFUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+s6/tuViaVvjT69K2cCNTcpXSbCrEh5BryZUR+q8xYIE2cFhU6iZyoSxfvuLWJGvxlHOB2qff07rqDKbcOcKz6/MRl7tm+1Kxk6+8UUEjIedTs2yumxjDJhes6RS7bMKsHrjhg1RRLijyWDB32lPs6su9GejZI0X0I2yyV5E6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=L/jNo2AM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6zLPYxe/hkU9yC1RRWKfSqGVUdc9sEQEhTnp8Z1DLvM=; b=L/jNo2AMUSkIcr5+HWpn2b1d5m
	Jze5KtrIeSbeV11p7Ar8ZfMUdl14GzdCJRXWqL0oEsQri9CIuPaPD6OaUJO79PQtA1NdHTUwpUtx6
	UFDyaNDB43DSGptK1fRZhEbRzcuHTOB7bIhwSMbNnwDc8rvmF5JNjL8irHrtErOyZSRbmo+MDSKyE
	IIhU5Mum/1hAWTm/U/66CBNFzFp+5cSl+aBPyOMNeyTJEvf2qyspXXH4DPuWK4j6A+ZnnjY+PhqPg
	Zqdd7jFou+mR/NxlgZaSloI7SPHsC4lsJf8CShcQktQU4SrQksnMgnkTFHig28mGtYhXbNFNVTz0I
	QeNb4/mw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj2-0000000F27P-1QkX;
	Thu, 28 Aug 2025 23:08:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 40/63] collect_paths(): constify the return value
Date: Fri, 29 Aug 2025 00:07:43 +0100
Message-ID: <20250828230806.3582485-40-viro@zeniv.linux.org.uk>
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

callers have no business modifying the paths they get

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c        | 4 ++--
 include/linux/mount.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 61dfa899bd57..43f46d9e84fe 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2300,7 +2300,7 @@ static inline bool extend_array(struct path **res, struct path **to_free,
 	return p;
 }
 
-struct path *collect_paths(const struct path *path,
+const struct path *collect_paths(const struct path *path,
 			      struct path *prealloc, unsigned count)
 {
 	struct mount *root = real_mount(path->mnt);
@@ -2334,7 +2334,7 @@ struct path *collect_paths(const struct path *path,
 	return res;
 }
 
-void drop_collected_paths(const struct path *paths, struct path *prealloc)
+void drop_collected_paths(const struct path *paths, const struct path *prealloc)
 {
 	for (const struct path *p = paths; p->mnt; p++)
 		path_put(p);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index c09032463b36..18e4b97f8a98 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -104,8 +104,8 @@ extern int may_umount_tree(struct vfsmount *);
 extern int may_umount(struct vfsmount *);
 int do_mount(const char *, const char __user *,
 		     const char *, unsigned long, void *);
-extern struct path *collect_paths(const struct path *, struct path *, unsigned);
-extern void drop_collected_paths(const struct path *, struct path *);
+extern const struct path *collect_paths(const struct path *, struct path *, unsigned);
+extern void drop_collected_paths(const struct path *, const struct path *);
 extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int num);
 
 extern int cifs_root_data(char **dev, char **opts);
-- 
2.47.2


