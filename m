Return-Path: <linux-fsdevel+bounces-65831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9155C12756
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 02:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BED58758D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 00:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F21339B5B;
	Tue, 28 Oct 2025 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RcnVZKzg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3269A213E89;
	Tue, 28 Oct 2025 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612386; cv=none; b=LjTovSWL/5t4FwWWYZWGL4u5tvcsdOHK4g2h0Dd2RRR87WbqJyE3DYmBTyNGHWgQaZzrYcxSp+tRwhN+RxmBB91wPlJ7zpasxjXK7jZ48EhzZhx6cDvG8G6DCxS5jludVsrU36USiD9nQgG1W+riHUMQlYOUv+tF227AVYNcvho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612386; c=relaxed/simple;
	bh=CyVivJufSb4sh4+oM9l7NXmE+V2B9EmDQGjIticKJ8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsyBjHfqxBWb1KEqE4H+1mQCYlO7+Qcl9v5jqYNBfYORZ285iZBMSa2F7+UfHQnNu10ZiGTzYFxC4T6XWK39/l/WZayQaHrQyrNxeUoZS63aypc//L/TrK7yBCiphx3nVayXkII8nHeaGitEMi4RL5TGF9n0UX/WzMcARo4Kw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RcnVZKzg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TcFcmzxfGV+3rJDGgJ/eg0JcSdO3AKCKkQ7NxQ/vrvI=; b=RcnVZKzge2ZU1Twimv07i13nqf
	QcTAS7+ds57DbCpe2rtYdEQxTk5PARrtpmJM2BrTn2SFSpRJvutptyWQDosOkBcbfgIkRnl3sKkz6
	l3S0K68HzObgZhlSis7xLOjp8Ap3h3Vvgb9fCy7L7KKIHY6cASWQdyKrYHvQdgeTwnJ1y22zpC5Zx
	J3xHZUgolAhB6fLGwxLd2TtLLgs634TGaQk8UUJGXW8ztkdIzO1tMc9E1WQfsHBGYZMSfrTu71afw
	JqXESNeUsJKgUFYqFzRFwYSJsAf96HUdjMmSbH885RndZRJzjdVYGgQQx3uYbk/spCH9UHwPzJuZG
	zGK7eyUQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDXqr-00000001eYZ-0dcu;
	Tue, 28 Oct 2025 00:46:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	neil@brown.name,
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
	john.johansen@canonical.com,
	selinux@vger.kernel.org,
	borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: [PATCH v2 24/50] convert ibmasmfs
Date: Tue, 28 Oct 2025 00:45:43 +0000
Message-ID: <20251028004614.393374-25-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

static contents for each "service processor", whatever the fuck it is.
Congruent subdirectories of root, created at mount time, taken out
by kill_litter_super().  All dentries created with d_alloc_name() and are
left pinned.  The odd part is that the list of service providers is
assumed to be unchanging - no locking, nothing to handle removals or
extra elements added later on.

... and it's a PCI device.  If you ever tell it to remove an instance,
you are fucked - it doesn't bother with removing its directory from filesystem,
it has a strange check that presumably wanted to be a check for removed
devices, but it had never been fleshed out.

Anyway, d_add() -> d_make_persistent()+dput() in ibmasmfs_create_dir() and
ibmasmfs_create_file(), and make the latter return int - no need to even
borrow that dentry, callers completely ignore it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/misc/ibmasm/ibmasmfs.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
index b26c930e3edb..a6cde74efb68 100644
--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -103,7 +103,7 @@ static struct file_system_type ibmasmfs_type = {
 	.owner          = THIS_MODULE,
 	.name           = "ibmasmfs",
 	.init_fs_context = ibmasmfs_init_fs_context,
-	.kill_sb        = kill_litter_super,
+	.kill_sb        = kill_anon_super,
 };
 MODULE_ALIAS_FS("ibmasmfs");
 
@@ -144,7 +144,7 @@ static struct inode *ibmasmfs_make_inode(struct super_block *sb, int mode)
 	return ret;
 }
 
-static struct dentry *ibmasmfs_create_file(struct dentry *parent,
+static int ibmasmfs_create_file(struct dentry *parent,
 			const char *name,
 			const struct file_operations *fops,
 			void *data,
@@ -155,19 +155,20 @@ static struct dentry *ibmasmfs_create_file(struct dentry *parent,
 
 	dentry = d_alloc_name(parent, name);
 	if (!dentry)
-		return NULL;
+		return -ENOMEM;
 
 	inode = ibmasmfs_make_inode(parent->d_sb, S_IFREG | mode);
 	if (!inode) {
 		dput(dentry);
-		return NULL;
+		return -ENOMEM;
 	}
 
 	inode->i_fop = fops;
 	inode->i_private = data;
 
-	d_add(dentry, inode);
-	return dentry;
+	d_make_persistent(dentry, inode);
+	dput(dentry);
+	return 0;
 }
 
 static struct dentry *ibmasmfs_create_dir(struct dentry *parent,
@@ -189,8 +190,9 @@ static struct dentry *ibmasmfs_create_dir(struct dentry *parent,
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = ibmasmfs_dir_ops;
 
-	d_add(dentry, inode);
-	return dentry;
+	d_make_persistent(dentry, inode);
+	dput(dentry);
+	return dentry; // borrowed
 }
 
 int ibmasmfs_register(void)
-- 
2.47.3


