Return-Path: <linux-fsdevel+bounces-42525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18736A42EEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485423A773E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6B01FC7CB;
	Mon, 24 Feb 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TOKQueYq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD40D1DB122
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432057; cv=none; b=e7Cukx50BS2ti9TxpQcF1aWssWoqy8BHPoD90SO/rI1QHAZVLKlToCvP1GN3FVOesVp4+kkdCG5z5+6Iml+zEhuhsOGtbxCOtZNCPMFB4UGQJ38XC5mA3CxiyExgqH94gjqNiT89hu/HLxkc5xqWBUrmXGLGdI85Oj7U2OhAk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432057; c=relaxed/simple;
	bh=9hluVPEYHHQLFtNGS/15wkkYwjw+IaVTArhwWU41vi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryBa44mUo17LkAUd1yrlUOuxcA2zMoKHCLkUcFKGvqSCEImxPkh7LG5H9xDRZIiaYwwGdeOHfYh8YE7CAfdfuZpevsx8vjbkU20b9GjxcRQWHxqaPUA+bZOISyxOJItSfP4hhZCwNo7UlxB+mSxf6XpjsVhupb3IeqKP/aXnNeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TOKQueYq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mpgL5SpQCNaa9CtDJA+4p6r8A9vBvN1ZNlx9FA6k0Cc=; b=TOKQueYql72ccepxhFGmozlTU0
	uYtlGxbfsdlloWMkqyBPqwIrlMOOW55Jm1ooun6u8Opjsv4sLuFMpKZnE8jeRKDp0A26B88SYP+dX
	iPaa9JF4HKR0tV2ot1q8EyxVHMK7NBrRgAhYHmC0EFYvfp23aHqkIW1faHCsxw5M7spT8Nzo2Sj6s
	XY6qmdCgF3AkwWQlcrcSwL5tB05nggsweBS7syb43SrB2NmVV8X3n1KmwxYA8O40AILDg5z1F4huE
	SQnRV9I/3bjHm0aQ4zwLcZp6Ba/coiqnngthrvM6cLZsD6LYr/vBaSpw+nabKfu53SqjgpKWWXds7
	klErjWWg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsi-00000007Mxb-1tHc;
	Mon, 24 Feb 2025 21:20:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 08/21] simple_lookup(): just set DCACHE_DONTCACHE
Date: Mon, 24 Feb 2025 21:20:38 +0000
Message-ID: <20250224212051.1756517-8-viro@zeniv.linux.org.uk>
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

No need to mess with ->d_op at all.  Note that ->d_delete that always
returns 1 is equivalent to having DCACHE_DONTCACHE in ->d_flags.
Later the same thing will be placed into ->s_d_flags of the filesystems
where we want that behaviour for all dentries; then the check in
simple_lookup() will at least get unlikely() slapped on it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/libfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 929bef0fecbd..b15a2148714e 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -75,9 +75,11 @@ struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry, unsigned
 {
 	if (dentry->d_name.len > NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
-	if (!dentry->d_op)
-		d_set_d_op(dentry, &simple_dentry_operations);
-
+	if (!(dentry->d_flags & DCACHE_DONTCACHE)) {
+		spin_lock(&dentry->d_lock);
+		dentry->d_flags |= DCACHE_DONTCACHE;
+		spin_unlock(&dentry->d_lock);
+	}
 	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		return NULL;
 
-- 
2.39.5


