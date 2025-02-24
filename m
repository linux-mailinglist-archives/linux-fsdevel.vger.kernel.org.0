Return-Path: <linux-fsdevel+bounces-42519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D4BA42EE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 22:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB983A6C65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B2D1E9917;
	Mon, 24 Feb 2025 21:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lfmavk88"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1FE1D6DB9
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432056; cv=none; b=I8qF5KowLP+IOX9AkW9/sJW4foFj/TzmPaNxcER81HYC5fgRq5jJKUw+fDMKqX23A9+lktOTbVHgRYAbqmu7+RhXvAsjI7w+/pegABshS0lKYibOfa+JW4pvUfbTJ2uJmpt0zRks8XtWFZfPT0tp86lKK6gI/4XUDmpQ6gKXVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432056; c=relaxed/simple;
	bh=8p1bcouPMG3+Y1vuVzAjEaR/2q1CKaJWy45XAbOYFi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyOZ6L3mo5kD/Cu0Sfe4HSX1Tc5jZ9kRLKVVlg+yH8L/WsbpUHm0JJO86MEl+j0xTjKM68Kpus2PA3lJ1oo7EJJ97Mvt/5aJk3yADCw8Z1RcASRDe1KJlCDmQwLCixZxkGTRXPtxSeX20fCPA62/0J9ebvaPn9WDivgpI2+xnnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lfmavk88; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=V1AmfIcr1FuHheMfjRG7UFAAksNAqzZZSXJuXYqh/I8=; b=lfmavk88OPn3K9RntxsRIFeqzm
	KXEOf+hxoTOw1DcvpcqvkUYlRSkoeFXEibP2h3M/CBn7Hh/nFGskhhpzXyXuoI0482L2uijNZp91P
	ENWevpQHXeP/1ZMlfdJSLe1RZZDvQk07LVNfNaEU9NRHG7604fKww8R9bBv4QDFCoFPMO77ZW465O
	zxKXNmhbo3onNENgHU6+vv0nJSCNkfBO8EgZlswW63GdF3WH9NFGxnfxOAFvzPsJVsEUe4gez+5+0
	FlJJEong2Ak0AQabY4J1Fntsd/FkaPFxrR361DCLo9ZyWSHsqfG8sIwfGdRvWZHMOHkwquvgIzOp0
	jIpBqLpA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmfsi-00000007MxF-1jAo;
	Mon, 24 Feb 2025 21:20:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 07/21] set_default_d_op(): calculate the matching value for ->d_flags
Date: Mon, 24 Feb 2025 21:20:37 +0000
Message-ID: <20250224212051.1756517-7-viro@zeniv.linux.org.uk>
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

... and store it in ->s_d_flags, to be used in __d_alloc()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c        | 6 ++++--
 include/linux/fs.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1201149e1e2c..a4795617c3db 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1705,14 +1705,14 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	dentry->d_inode = NULL;
 	dentry->d_parent = dentry;
 	dentry->d_sb = sb;
-	dentry->d_op = NULL;
+	dentry->d_op = sb->__s_d_op;
+	dentry->d_flags = sb->s_d_flags;
 	dentry->d_fsdata = NULL;
 	INIT_HLIST_BL_NODE(&dentry->d_hash);
 	INIT_LIST_HEAD(&dentry->d_lru);
 	INIT_HLIST_HEAD(&dentry->d_children);
 	INIT_HLIST_NODE(&dentry->d_u.d_alias);
 	INIT_HLIST_NODE(&dentry->d_sib);
-	d_set_d_op(dentry, dentry->d_sb->__s_d_op);
 
 	if (dentry->d_op && dentry->d_op->d_init) {
 		err = dentry->d_op->d_init(dentry);
@@ -1850,7 +1850,9 @@ EXPORT_SYMBOL(d_set_d_op);
 
 void set_default_d_op(struct super_block *s, const struct dentry_operations *ops)
 {
+	unsigned int flags = d_op_flags(ops);
 	s->__s_d_op = ops;
+	s->s_d_flags = (s->s_d_flags & ~DCACHE_OP_FLAGS) | flags;
 }
 EXPORT_SYMBOL(set_default_d_op);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 23fd8b0d4e81..473a9de5fc8f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1392,6 +1392,7 @@ struct super_block {
 	char			s_sysfs_name[UUID_STRING_LEN + 1];
 
 	unsigned int		s_max_links;
+	unsigned int		s_d_flags;
 
 	/*
 	 * The next field is for VFS *only*. No filesystems have any business
-- 
2.39.5


