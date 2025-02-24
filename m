Return-Path: <linux-fsdevel+bounces-42524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2237FA42EEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0B93A7407
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F81C1FC7D5;
	Mon, 24 Feb 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ew4CKyGb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7631DB55C
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432057; cv=none; b=k1yU8Ng2EPIbmUvYltmbGQo2tfkX68m39sRdynlc8BP08sBnZGsqyFAMcvFFextQeRv6VUJmB6ygzpAZEaWjgsDLhM5Dne9E+ER9Z3T1uF3TujwUsO7cJIvW8aRtgnh3F5VUfGmll5Rfc6Yafd+eQmPQc9goN+EcnFCFqrwuIDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432057; c=relaxed/simple;
	bh=HjgQDYRcXWQn7G+tjSlMmJiwKgtYF4fzVHAYzLinFwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtjDI2qfP8r527lMu9hP5at8kbdg4IYK55TFqBHqPbY8OS/BNZMqALJ0VecY74wTWqNg/SldF4sI9IaTe302KCbJDB4KecQ6D2XOjwvh/uf8f9+n2wrVCQzLEPxiGqLrZdxGxnFhIuWYpPt2Lde1DXLX7/Y51pfMPkIdmnGaJ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ew4CKyGb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oYFi1A8M0zzxnLPLxxvpyZpqrE002jgcmYOtbb39RAg=; b=Ew4CKyGbIfAQ2jbmjiW/TTrLK6
	pAZA8bpGRMsI2VgU7+PmpIoIkc41WWBEpv+OMJzJtzGPyj+YyfJnqKX/1ifQuA6uHfEWtXa44sKw0
	pVhIuBtK1JjqiRi2v+ujylfHYbwnOqEXtSKJGOAV12SPM20XsL3BeV7Mc0ZFb61XJzwHQ22/jKzb7
	+3MaBYvk+4FV4P9vTvREb9nmIa04Z6Fu7jjXSV6RiIKncJgNCCEf5CO07fMk2XLDlsUh1vnBWU3Iz
	3/mEr8uyQI7bo15M8757fX0Q8l1x6dj4trC1fqvR4iPrPO4bpBIh38ZN1dYErFDHwaRo6Qiww89nS
	yMOVUgAA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsj-00000007MzM-2xh1;
	Mon, 24 Feb 2025 21:20:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 18/21] efivarfs: use DCACHE_DONTCACHE instead of always_delete_dentry()
Date: Mon, 24 Feb 2025 21:20:48 +0000
Message-ID: <20250224212051.1756517-18-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/efivarfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index 3f3188e0cfa7..e5d3147cfcea 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -175,7 +175,6 @@ static int efivarfs_d_hash(const struct dentry *dentry, struct qstr *qstr)
 static const struct dentry_operations efivarfs_d_ops = {
 	.d_compare = efivarfs_d_compare,
 	.d_hash = efivarfs_d_hash,
-	.d_delete = always_delete_dentry,
 };
 
 static struct dentry *efivarfs_alloc_dentry(struct dentry *parent, char *name)
@@ -346,6 +345,7 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_magic             = EFIVARFS_MAGIC;
 	sb->s_op                = &efivarfs_ops;
 	set_default_d_op(sb, &efivarfs_d_ops);
+	sb->s_d_flags |= DCACHE_DONTCACHE;
 	sb->s_time_gran         = 1;
 
 	if (!efivar_supports_writes())
-- 
2.39.5


