Return-Path: <linux-fsdevel+bounces-62295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07387B8C281
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 09:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F90756780E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 07:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD9F1DDA18;
	Sat, 20 Sep 2025 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="t9iONXrV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B002749C5;
	Sat, 20 Sep 2025 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354487; cv=none; b=QIY/UtpYiQl95W9+5VY+yApXBFLzzZhp4EjzEmUl9U2Ygw+SYf/MATMLjgeX3nL0Wem/00fhete/dbUk6Y/XvqU9PH6g2JT/X8Urw0/8j+L/AspQBC1ABqQ0UYMm87mREQAom3vDjX+tskZhXSQ+jw7w2jwB3B08oU7LT02a9+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354487; c=relaxed/simple;
	bh=pfDtlIgV2LBEjsb/aUM9dZDlLqvkBkhHD1AP4d33njU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoF5mxu5k9vrFsfHuB1xK8st0LmUAQiIMq+Rxrj+LHkCNXKknJ8ScI25Xi7WukKW81miGhVA6SGXwwAduNOM8aoyGbz+j5Yf73+xQ6MNO1ELjB7eUt6c8U8XJ+iuqbC/q/dwaZMIViQSirHQbNffzfECE/E/P78Hvgw0OW5yEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=t9iONXrV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Rblw1/+FVpnDSF+tGzA58CitG6ZVFpPLgpN9TawlUAc=; b=t9iONXrVV2xYR0Ohv6Uqq876VT
	EOLP68t82ONpzCjT6GTEie1WbU4Z5xuFIUQfrY7W3q92BniOaKvWeviTTUUvh/+gK6WzBnInI47DQ
	x3iQ1kIlshSd70ZWXETqVX7uIwzov3t0WdsszcElheVQ2bY76i0NDZRonXWE7dQyC9EiAmEQ6Bscb
	CjwXDS52jAujjzTldVIar/giui3Tc2BusRDf1/9QdkxmGstJBQO+kgyXUVlaXTOwelnzqjDTz1r+S
	6EokSysi9b0Fmqf/9VicVzGeuaGtZddJ9ODEOvwWRo69viMy5RpA5RqkrUcO3jKzhP58lRog6xhzc
	2jQZqg1A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzsKA-0000000ExEK-1Zwa;
	Sat, 20 Sep 2025 07:48:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	borntraeger@linux.ibm.com
Subject: [PATCH 16/39] convert pstore
Date: Sat, 20 Sep 2025 08:47:35 +0100
Message-ID: <20250920074759.3564072-16-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
References: <20250920074156.GK39973@ZenIV>
 <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

object creation by d_alloc_name()+d_add() in pstore_mkfile(), removal -
via normal VFS codepaths (with ->unlink() using simple_unlink()) or
in pstore_put_backend_records() via locked_recursive_removal()

Replace d_add() with d_make_persistent()+dput() - that's what really
happens there.  The reference that goes into record->dentry is valid
only until the unlink (and explicitly cleared by pstore_unlink()).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pstore/inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 1a2e1185426c..bad479fbb0ff 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -373,7 +373,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	if (!dentry)
 		return -ENOMEM;
 
-	private->dentry = dentry;
+	private->dentry = dentry; // borrowed
 	private->record = record;
 	inode->i_size = private->total_size = size;
 	inode->i_private = private;
@@ -382,7 +382,8 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 		inode_set_mtime_to_ts(inode,
 				      inode_set_ctime_to_ts(inode, record->time));
 
-	d_add(dentry, no_free_ptr(inode));
+	d_make_persistent(dentry, no_free_ptr(inode));
+	dput(dentry);
 
 	list_add(&(no_free_ptr(private))->list, &records_list);
 
@@ -465,7 +466,7 @@ static void pstore_kill_sb(struct super_block *sb)
 	guard(mutex)(&pstore_sb_lock);
 	WARN_ON(pstore_sb && pstore_sb != sb);
 
-	kill_litter_super(sb);
+	kill_anon_super(sb);
 	pstore_sb = NULL;
 
 	guard(mutex)(&records_list_lock);
-- 
2.47.3


