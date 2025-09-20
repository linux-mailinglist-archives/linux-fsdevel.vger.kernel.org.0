Return-Path: <linux-fsdevel+bounces-62312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07CBB8C35C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 09:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328823AE661
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 07:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609722EC089;
	Sat, 20 Sep 2025 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pD4mFh9B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440B62F3C37;
	Sat, 20 Sep 2025 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354493; cv=none; b=GljJBNk7LWJaaXUVLbjvDOaciiwQQnJfomvGXACnlVTPTwisQk+7IvetgdKg5nBKAXUR8khznZXYhUtpibOp1vjifP3NlYeockyCADATg3vzbcVmcTcMgrSv9JsOnaBesRHRBOSfG61zX/fE+XWQyXhsu5F/vPzu7k6oXtj4czA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354493; c=relaxed/simple;
	bh=3oZpLGt/ktjoRgoxKXulIuPbvwnJgknw+aES2ijS1cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RItaHMz8uwRz5J6vUx9sbestmlbw+i7Vqv8gf8OnjpWPTCwCKknDHLU6kYdtGI3m9IVb+4ON54+RZqdoGmmI/p1+8CYyDvS1Fev149YFPyqMk8PCsjsT0aL6R61vTFSABkOSpzXBprCmuLqEHkdk2RZ6gcIxb4STHzR0dts5TtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pD4mFh9B; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=V2I7OUIWBFRscgYYRdCjjF8wTtyFfkGTFabZVJfLoxo=; b=pD4mFh9BRC1dnf7SHGUZrVB5mK
	DAk58StnHJnuz34FnQl1HvRD1TDl7iszbrHoYPbCnfwpkOZ4dMuc3AqXH1j+jPnxfvYbNcAbJJiFx
	VP36scCd152zIzcX4mPaDfgvAoAxZ3WA5qaNbw+gIMfly4BtzasSyDqP4MrJGi6QtPbNdRTPcMW81
	kvAFyxYkNsNfG8mtqR8OeIfZ5dE1tOHl9wEUBz4jlw2Yo1JdSpey0kK4JhBqHh+jzIVmrR63gbild
	iDbqrfLYFJj3lRworHvKrFPvSn+sxdmkiSFcU11T0z/7RsZ8F0nT8ANZ7dCoQE9nbuWzk2b9tC1Ld
	eidcKYJA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzsKH-0000000ExMv-23xH;
	Sat, 20 Sep 2025 07:48:09 +0000
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
Subject: [PATCH 35/39] convert gadgetfs
Date: Sat, 20 Sep 2025 08:47:54 +0100
Message-ID: <20250920074759.3564072-35-viro@zeniv.linux.org.uk>
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

same as functionfs

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/gadget/legacy/inode.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index fcc5f5455625..6b7adf153407 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1989,17 +1989,20 @@ static int gadgetfs_create_file (struct super_block *sb, char const *name,
 	struct dentry	*dentry;
 	struct inode	*inode;
 
-	dentry = d_alloc_name(sb->s_root, name);
-	if (!dentry)
-		return -ENOMEM;
-
 	inode = gadgetfs_make_inode (sb, data, fops,
 			S_IFREG | (default_perm & S_IRWXUGO));
-	if (!inode) {
-		dput(dentry);
+	if (!inode)
 		return -ENOMEM;
+
+	dentry = simple_start_creating(sb->s_root, name);
+	if (IS_ERR(dentry)) {
+		iput(inode);
+		return PTR_ERR(dentry);
 	}
-	d_add (dentry, inode);
+
+	d_make_persistent(dentry, inode);
+
+	simple_done_creating(dentry);
 	return 0;
 }
 
@@ -2096,7 +2099,7 @@ static void
 gadgetfs_kill_sb (struct super_block *sb)
 {
 	mutex_lock(&sb_mutex);
-	kill_litter_super (sb);
+	kill_anon_super (sb);
 	if (the_device) {
 		put_dev (the_device);
 		the_device = NULL;
-- 
2.47.3


