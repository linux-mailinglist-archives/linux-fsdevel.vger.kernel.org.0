Return-Path: <linux-fsdevel+bounces-42515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DB0A42EF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9C7189F36B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1B71DE89E;
	Mon, 24 Feb 2025 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ky4UExG0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA95F1DB15F
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432056; cv=none; b=dhOP9WfGa2eR5wxT1NvqtJ738uNM0REtOGEK9nFH3SBvUnozylHLes4RNRa6sJbI7K5cOmOZoiuP+OUr8VapKh1onwfqVlAXPlpX+4zuaaWGOKN0Jb4AeOu/0U0TtdHRH4eWsRqXfJ/+wc//6HVUf5OGR0nAGTwKSR+5ZSmysEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432056; c=relaxed/simple;
	bh=ne8AwtajFBNtxnmvMbN77JYghmiiYUG/qr6SBUgFxts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSIXx7bPz8J2AwmqZeH8aILMDwUKZmYww0jMccQrWa4geOvRGmjVlAGynEL3FuUtjzu3z7Sv+BPaa4f+JKPRG9j5H2afSYugInWxuJK/t1048CjgLBIUWsXb9nq5mPxxwX2EiMvVCvPrhqbSIJIxwSIAQY7GIWDYZcx8EsQpe5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ky4UExG0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ur2/0gQzExjG+dklyTjyj/DBtXM2nQPw/F4IiMN4Omc=; b=ky4UExG05flxkBi0khxfJZmqQR
	s/OJbMJ3gRBOUwFw95SihgRZEZETub700MyI9gW1dYdc4XCzRnwoQhFMVeLFqhRhFfrc3lzqOyjln
	VPtjop0iPWzfgM6my9BcSTh1mw4foFQAfzsL4uFUtjvlZrqw1lTbrm29+OjHeWExw2cOXuNFsAAdU
	24zsYICdHb2HDVIqMpTkiKkquijXvhJ0tkS5+p9pSnpKjueTHFBVbXBwA8emAzJlEMWEsB+70ChNX
	e2faGct+uUwYXHJiujfPxvptqnfvtymEYKI8ScBcSd7I9I3fJbHHXlN77OsBKyoxB+r7u71KNy8e4
	fTfoURaQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsi-00000007Mxl-22Mw;
	Mon, 24 Feb 2025 21:20:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 09/21] make d_set_d_op() static
Date: Mon, 24 Feb 2025 21:20:39 +0000
Message-ID: <20250224212051.1756517-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
References: <20250224141444.GX1977892@ZenIV>
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Convert the last user (d_alloc_pseudo()) and be done with that.
Any out-of-tree filesystem using it should switch to d_splice_alias_ops()
or, better yet, check whether it really needs to have ->d_op vary among
its dentries.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/porting.rst | 11 +++++++++++
 fs/dcache.c                           |  5 ++---
 include/linux/dcache.h                |  1 -
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 004cd69617a2..61b5771dde53 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1164,3 +1164,14 @@ magic.
 
 If your filesystem sets the default dentry_operations, use set_default_d_op()
 rather than manually setting sb->s_d_op.
+
+---
+
+**mandatory**
+
+d_set_d_op() is no longer exported (or public, for that matter); _if_
+your filesystem really needed that, make use of d_splice_alias_ops()
+to have them set.  Better yet, think hard whether you need different
+->d_op for different dentries - if not, just use set_default_d_op()
+at mount time and be done with that.  Currently procfs is the only
+thing that really needs ->d_op varying between dentries.
diff --git a/fs/dcache.c b/fs/dcache.c
index a4795617c3db..29db27228d97 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1796,7 +1796,7 @@ struct dentry *d_alloc_pseudo(struct super_block *sb, const struct qstr *name)
 	if (likely(dentry)) {
 		dentry->d_flags |= DCACHE_NORCU;
 		if (!dentry->d_op)
-			d_set_d_op(dentry, &anon_ops);
+			dentry->d_op = &anon_ops;
 	}
 	return dentry;
 }
@@ -1837,7 +1837,7 @@ static unsigned int d_op_flags(const struct dentry_operations *op)
 	return flags;
 }
 
-void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
+static void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
 {
 	unsigned int flags = d_op_flags(op);
 	WARN_ON_ONCE(dentry->d_op);
@@ -1846,7 +1846,6 @@ void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
 	if (flags)
 		dentry->d_flags |= flags;
 }
-EXPORT_SYMBOL(d_set_d_op);
 
 void set_default_d_op(struct super_block *s, const struct dentry_operations *ops)
 {
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index e8cf1d0fdd08..5a03e85f92a4 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -242,7 +242,6 @@ extern void d_instantiate_new(struct dentry *, struct inode *);
 extern void __d_drop(struct dentry *dentry);
 extern void d_drop(struct dentry *dentry);
 extern void d_delete(struct dentry *);
-extern void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op);
 
 /* allocate/de-allocate */
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
-- 
2.39.5


