Return-Path: <linux-fsdevel+bounces-51246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 963C7AD4D92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723051BC07A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D59324468B;
	Wed, 11 Jun 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JhSA+7Sj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE5233D91
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628483; cv=none; b=CKaW8zWQKAIWxyP6xVhoqdQla1PY4n6L9B7cGuU2sxCrVySXn3ZP8hubQ53yfGldwD+5ZjXtPRoqIW9b0TcvxAXHAtlUrcIq+zOFH4bUQcOGMswHqP0XDYCfp8hf9H9WurFrc86/0+g3Zs9gxoeYO9RSoV94oxQJKwNOcWzhqIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628483; c=relaxed/simple;
	bh=i7kgM2AOBRp7nuOn66zfWujdLqD5X9vVwLBbhSxDBzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcIMtHcH7KgBl66OaObqHebZYc+kpcscUdcAuNyKBqkPfXZRpJXuwt1wxUbehh0lh0ks0TTFWp1jE9G4mtcpFNoECF3F1NiPX+XiLnoYpE0Xz3uvJ+KLn89sg8BH4B+YQaL08KFQ2H8xiBXAn9DakXe5e6xiQQNpV8005YkXLNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JhSA+7Sj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Q3w9StHjySV4mCM7yTWZ4kYD4G0sDDx35i4jHFvFlZU=; b=JhSA+7SjlvS0+H9m2mC4JX3eZu
	XM5IXQTmxUq6AfsAFE0v6pVH3Yd0/C2zkF1nAxvRwV6zEdEOvFGocO3dptpfBoBwmN3T92nx8DM/4
	nBiLFUTK2y0pfUUc88yPWQEE8l35kBj/wbtjzLUWtH3EmXEipNtAqjOSqzXk8nk2nbdPuegRtUyFs
	jwAtpFqOeNCyjxukOryUUo4zu6pnNn377nVUoWsv4AuQ9dAzp4MNSB9R8y6Mv+xRoKGbl33f1CuP0
	3WXt8IEQLi7cp0CL2xounvIJQsnBfdnpQXwPpuWe2+taXRh5sideIXoWgzoikG12lXUfSO4wL37R1
	xsBYzn2w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIA-0000000HTx9-4B3w;
	Wed, 11 Jun 2025 07:54:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 10/21] simple_lookup(): just set DCACHE_DONTCACHE
Date: Wed, 11 Jun 2025 08:54:26 +0100
Message-ID: <20250611075437.4166635-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
References: <20250611075023.GJ299672@ZenIV>
 <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
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

NOTE: there are only two filesystems where
	* simple_lookup() might be called
	* default ->d_op is non-NULL
	* its ->d_delete() doesn't always return 1
If not for those, we could have simple_lookup() just set DCACHE_DONTCACHE
without even looking at ->d_op.  Filesystems in question are btrfs
(where ->d_delete() takes care to recognize the dentries that might
come from simple_lookup() and returns 1 for those) and tracefs.

The former would be fine with simple_lookup() setting DCACHE_DONTCACHE;
the latter... probably wants DCACHE_DONTCACHE in default d_flags.

IOW, we might want to drop the check for ->d_op in simple_lookup();
it's definitely a separate story, though.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/libfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index ab82de070310..19cc12651708 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -75,9 +75,11 @@ struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry, unsigned
 {
 	if (dentry->d_name.len > NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
-	if (!dentry->d_op)
-		d_set_d_op(dentry, &simple_dentry_operations);
-
+	if (!dentry->d_op && !(dentry->d_flags & DCACHE_DONTCACHE)) {
+		spin_lock(&dentry->d_lock);
+		dentry->d_flags |= DCACHE_DONTCACHE;
+		spin_unlock(&dentry->d_lock);
+	}
 	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		return NULL;
 
-- 
2.39.5


