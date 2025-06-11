Return-Path: <linux-fsdevel+bounces-51247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E2AD4D93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028C53A5C62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D73A244691;
	Wed, 11 Jun 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vkXYwkC0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABFD23ABAA
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628483; cv=none; b=uQr49Prb3uQMI2yv0ucAkwcodJmNtcvIGLP9/hY1eGLmY+n3jw8Ca9TwopIrQo91KOQ2mHvDF4ARmxG6c2yC9W6cChujpw26apILtDLi1BikE14QQwL2X1lKSgxr73aSD8rXuw1JmmlvJuZb/KhpxKamuED4yd1ZOfbkps95SzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628483; c=relaxed/simple;
	bh=QjBgKXVBweBarePWDBynMcdwKMF6Tz3G6ppXCW2Qazc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ue8hpTqgt19TmyucJl9f6isb1Tpje+YM2KZm3q9gy9xnrS0XvMMyQg3uApG8hmTIG4vx9cnWau07Mx5G6IwV+HZFFQPezn4qtlO4AocSA+DIbliI8Hmv5phr3TPMoA3JJ2hrOZZRKmA/j7qANM8u3KCfHqwgploS2h6W1Qv001U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vkXYwkC0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/fgqr0rN1I7/AjWDHE0dWjzzG4L8TzXOh08KW8rb7TQ=; b=vkXYwkC0aGM2WVzVrYcOJ7Q+ca
	TXwyh/1QLzU7nKIR1VLzy3LM26DYZoVQuq9OlAUaJxOlum7z74DBww+mpRbigv+2UI8lZyGelihSZ
	TnnDoCf246RCc9Wt3sGAYyJEYIVp3lOe4RFXHl2zmWa9woVFoBjfItsFL3gJxTy1rvNNU5n3Bj6Mk
	x1Knk63yp2IykdttfNihZ8Ns37HgMOANuRCqlVDzdbwCnMQry0FhjV0NxPkJFxKjZ77jc1ZlZMuoQ
	OKDe4dyAoaaZJxbInA/fpqXMjzTlTW2XD1G8+ZMqm+fBeaCEffoOp2xDxyEfkDZlH0Eq1O2pR1y+H
	R6gy9ZDg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIA-0000000HTwz-3Xf3;
	Wed, 11 Jun 2025 07:54:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 09/21] set_default_d_op(): calculate the matching value for ->d_flags
Date: Wed, 11 Jun 2025 08:54:25 +0100
Message-ID: <20250611075437.4166635-9-viro@zeniv.linux.org.uk>
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

... and store it in ->s_d_flags, to be used by __d_alloc()

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c        | 6 ++++--
 include/linux/fs.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 27e6d2f36973..7519c5f66f79 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1731,14 +1731,14 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
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
@@ -1877,7 +1877,9 @@ EXPORT_SYMBOL(d_set_d_op);
 
 void set_default_d_op(struct super_block *s, const struct dentry_operations *ops)
 {
+	unsigned int flags = d_op_flags(ops);
 	s->__s_d_op = ops;
+	s->s_d_flags = (s->s_d_flags & ~DCACHE_OP_FLAGS) | flags;
 }
 EXPORT_SYMBOL(set_default_d_op);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7cd8eaab4d4e..65548e70e596 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1400,6 +1400,7 @@ struct super_block {
 	char			s_sysfs_name[UUID_STRING_LEN + 1];
 
 	unsigned int		s_max_links;
+	unsigned int		s_d_flags;	/* default d_flags for dentries */
 
 	/*
 	 * The next field is for VFS *only*. No filesystems have any business
-- 
2.39.5


