Return-Path: <linux-fsdevel+bounces-62289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CC8B8C257
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 09:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2380756755C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 07:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FAB2E36F6;
	Sat, 20 Sep 2025 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Xd+fhdH+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D02727EE;
	Sat, 20 Sep 2025 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354486; cv=none; b=cG+10PD/4fcn5vcskRakZRORsqH0Tz1eip/kDH26uF7Cu8Z+hEi6haulxXcyjQHQ60EMPK4DsowlsocmPkZ7ilXvW1IIwgRMx7QSVJGx6WHHgyfBjSDbK4fQdwfFHDMigHOWJy5ymeZYzfmm8lxIVbnsxJzj6psOEbGhkacMaKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354486; c=relaxed/simple;
	bh=Wrw1kERWZPqAZ4vjPv/ev7634qJXhbajZNEnCZ+7MLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgkOdkjCiOgNV+qWYElXVl7hK8a9QEfcQVevVvXqWkcQLobEkfi9juoTdKDWjtjXZVrakFoHQvPjApVj4fCvEnh5OikgsT+TAeMzLRnD/a+DHIQ4POAMJ8J7lYwoFL3++Y9bYYZru69lNCRSUayC8DhRQPl7dOZVg1/lKCGc09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Xd+fhdH+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SHIurh1L4ZAnx8Qlum7bXJSPzKE6mjESH5b9zbhJwo0=; b=Xd+fhdH+XROIHkZFDeHvNlvGi9
	2XDjMdW0HBBVLKWurJFnhokxryB8V7D0GP7K9K48Gtb4JvIpea72Lqt8zNNKOf1gP5ZbalRwMA/Xa
	yenZDqNr5o036U952M8Q9k5Bu6ohbdqU0HFDCyc6fPRdm2ziCCaevvpNIj7uKyx3g9vd4hAlQDwt6
	c8ELFtaoSFtPE5hO03NWrFizgx12s47mZFKBGy+doHIlOiXqU3YuIlOy0VtCexqTUQuHeQJTezd2p
	jSOqkfX7/7qhwr/ni2e5+G3Ar9WkN1ld9PMG0uKudvozKird2FxqtQkzzEQcZ1pcbRkVKTC1IJWsa
	ezXbChyQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzsK9-0000000ExDc-3YnV;
	Sat, 20 Sep 2025 07:48:01 +0000
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
Subject: [PATCH 14/39] convert dlmfs
Date: Sat, 20 Sep 2025 08:47:33 +0100
Message-ID: <20250920074759.3564072-14-viro@zeniv.linux.org.uk>
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

All modifications via normal VFS codepaths; just take care of making
persistent in ->create() and ->mkdir() and that's it (removal side
doesn't need any changes, since it uses simple_rmdir() for ->rmdir()
and calls simple_unlink() from ->unlink()).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ocfs2/dlmfs/dlmfs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 5130ec44e5e1..c1419765a8fb 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -441,8 +441,7 @@ static struct dentry *dlmfs_mkdir(struct mnt_idmap * idmap,
 	ip->ip_conn = conn;
 
 	inc_nlink(dir);
-	d_instantiate(dentry, inode);
-	dget(dentry);	/* Extra count - pin the dentry in core */
+	d_make_persistent(dentry, inode);
 
 	status = 0;
 bail:
@@ -480,8 +479,7 @@ static int dlmfs_create(struct mnt_idmap *idmap,
 		goto bail;
 	}
 
-	d_instantiate(dentry, inode);
-	dget(dentry);	/* Extra count - pin the dentry in core */
+	d_make_persistent(dentry, inode);
 bail:
 	return status;
 }
@@ -574,7 +572,7 @@ static int dlmfs_init_fs_context(struct fs_context *fc)
 static struct file_system_type dlmfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "ocfs2_dlmfs",
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= kill_anon_super,
 	.init_fs_context = dlmfs_init_fs_context,
 };
 MODULE_ALIAS_FS("ocfs2_dlmfs");
-- 
2.47.3


