Return-Path: <linux-fsdevel+bounces-68870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F63C6783B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 81BAA366355
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938BF30E83D;
	Tue, 18 Nov 2025 05:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rzQCg5lh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A52BEC20;
	Tue, 18 Nov 2025 05:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442980; cv=none; b=gI8TQDDdu6+Cjt6O4huT3uOUqawnBDSnfpSpYw0x/0wiuBZUnDVzuzmkFsK4nSkxNeliYM3++HhqRILmkUndCAPd20Ak5F7zzzGXHuWm47xl7YLQi3L+k1/vLOTHqCjGHXoWBO5iLwQhlLrViOb+LJ+2FjqwlQW5P7Gv8Us369s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442980; c=relaxed/simple;
	bh=byBMgHbR87T18XBWxBXLSo3SukdEydOq3tHxIUqMMIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0KJcdqwM0Bqr7MIX46C8EFght5nm/qwN/2nRhris6i4eXueZajGRpVW6M+3ToQPfMoqOQjMUF03OTEWNazuTsByEjOd8MQUQ1JAag2hjwvzMMn9G/qIaAScXW3cbGems2cqitDEQAh4yOSLdkUSc02vS3ipgcdoDEK4SGCTov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rzQCg5lh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=h9ER29fbTJgjBa1gGf0LtXabL8srR/KWhHIa5FKJzwk=; b=rzQCg5lhFgfrMZlOVGl6dExZ/a
	d0AgChO0Od/vBClGgnOu5Fjd5tl4dza+2pw+6RbcoI/f4TzFLHPjRU5qnY9douyr6yZfFvzXeiNCc
	eOk1A/AfCZ2Fq9xW+wz6Iqe+G9K+8nuPPSVS6n3g9BfJxSh5M7HlQ7wGAr5JQXKfUHF8uLZ9hy5G+
	xDwykHVpmx3evybIAKrC1sf5vcsJi02w5hG99QhujDNzHfiDW0+GKIhRq2eSwYG8ZwA8dbSKiOQnk
	GnJYztrt9p6X2SHG0V2njXC+vTfxmOCaE3Nz/WzhcwmKIAz1BWSlmOecW8XBg5ia5hN5eImMb/kkB
	7GelKqYg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLE4X-0000000GETr-25uP;
	Tue, 18 Nov 2025 05:16:09 +0000
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
	bpf@vger.kernel.org,
	clm@meta.com
Subject: [PATCH v4 42/54] gadgetfs: switch to simple_remove_by_name()
Date: Tue, 18 Nov 2025 05:15:51 +0000
Message-ID: <20251118051604.3868588-43-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

No need to return dentry from gadgetfs_create_file() or keep it around
afterwards.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/gadget/legacy/inode.c | 32 +++++++++++++------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 13c3da49348c..bcc25f13483f 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -150,7 +150,6 @@ struct dev_data {
 	void				*buf;
 	wait_queue_head_t		wait;
 	struct super_block		*sb;
-	struct dentry			*dentry;
 
 	/* except this scratch i/o buffer for ep0 */
 	u8				rbuf[RBUF_SIZE];
@@ -208,7 +207,6 @@ struct ep_data {
 	struct usb_endpoint_descriptor	desc, hs_desc;
 	struct list_head		epfiles;
 	wait_queue_head_t		wait;
-	struct dentry			*dentry;
 };
 
 static inline void get_ep (struct ep_data *data)
@@ -1561,16 +1559,12 @@ static void destroy_ep_files (struct dev_data *dev)
 	spin_lock_irq (&dev->lock);
 	while (!list_empty(&dev->epfiles)) {
 		struct ep_data	*ep;
-		struct dentry	*dentry;
 
 		/* break link to FS */
 		ep = list_first_entry (&dev->epfiles, struct ep_data, epfiles);
 		list_del_init (&ep->epfiles);
 		spin_unlock_irq (&dev->lock);
 
-		dentry = ep->dentry;
-		ep->dentry = NULL;
-
 		/* break link to controller */
 		mutex_lock(&ep->lock);
 		if (ep->state == STATE_EP_ENABLED)
@@ -1581,10 +1575,11 @@ static void destroy_ep_files (struct dev_data *dev)
 		mutex_unlock(&ep->lock);
 
 		wake_up (&ep->wait);
-		put_ep (ep);
 
 		/* break link to dcache */
-		simple_recursive_removal(dentry, NULL);
+		simple_remove_by_name(dev->sb->s_root, ep->name, NULL);
+
+		put_ep (ep);
 
 		spin_lock_irq (&dev->lock);
 	}
@@ -1592,14 +1587,14 @@ static void destroy_ep_files (struct dev_data *dev)
 }
 
 
-static struct dentry *
-gadgetfs_create_file (struct super_block *sb, char const *name,
+static int gadgetfs_create_file (struct super_block *sb, char const *name,
 		void *data, const struct file_operations *fops);
 
 static int activate_ep_files (struct dev_data *dev)
 {
 	struct usb_ep	*ep;
 	struct ep_data	*data;
+	int err;
 
 	gadget_for_each_ep (ep, dev->gadget) {
 
@@ -1622,9 +1617,9 @@ static int activate_ep_files (struct dev_data *dev)
 		if (!data->req)
 			goto enomem1;
 
-		data->dentry = gadgetfs_create_file (dev->sb, data->name,
+		err = gadgetfs_create_file (dev->sb, data->name,
 				data, &ep_io_operations);
-		if (!data->dentry)
+		if (err)
 			goto enomem2;
 		list_add_tail (&data->epfiles, &dev->epfiles);
 	}
@@ -1988,8 +1983,7 @@ gadgetfs_make_inode (struct super_block *sb,
 /* creates in fs root directory, so non-renamable and non-linkable.
  * so inode and dentry are paired, until device reconfig.
  */
-static struct dentry *
-gadgetfs_create_file (struct super_block *sb, char const *name,
+static int gadgetfs_create_file (struct super_block *sb, char const *name,
 		void *data, const struct file_operations *fops)
 {
 	struct dentry	*dentry;
@@ -1997,16 +1991,16 @@ gadgetfs_create_file (struct super_block *sb, char const *name,
 
 	dentry = d_alloc_name(sb->s_root, name);
 	if (!dentry)
-		return NULL;
+		return -ENOMEM;
 
 	inode = gadgetfs_make_inode (sb, data, fops,
 			S_IFREG | (default_perm & S_IRWXUGO));
 	if (!inode) {
 		dput(dentry);
-		return NULL;
+		return -ENOMEM;
 	}
 	d_add (dentry, inode);
-	return dentry;
+	return 0;
 }
 
 static const struct super_operations gadget_fs_operations = {
@@ -2059,8 +2053,8 @@ gadgetfs_fill_super (struct super_block *sb, struct fs_context *fc)
 		goto Enomem;
 
 	dev->sb = sb;
-	dev->dentry = gadgetfs_create_file(sb, CHIP, dev, &ep0_operations);
-	if (!dev->dentry) {
+	rc = gadgetfs_create_file(sb, CHIP, dev, &ep0_operations);
+	if (rc) {
 		put_dev(dev);
 		goto Enomem;
 	}
-- 
2.47.3


