Return-Path: <linux-fsdevel+bounces-62301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F89B8C2E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 09:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062BB6258DD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 07:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3F92F0C5E;
	Sat, 20 Sep 2025 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vtuBnJp1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9206B26FA52;
	Sat, 20 Sep 2025 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354489; cv=none; b=NrNvtXCa+UMolXiTRHYfdDiWuZUdhaNo9gRvz6G0ln5M/urLJTkwP5rKaXpnKbNne8v57ShEsWP/Junad3mOjcKTApMCnFtZc8pr71wu8fh3yGk8KeQ05+v/z2WD/YAzKdsMSkFnBmBARKT3Qy+VDT+sb3uAYVIAVK9jSJbf2yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354489; c=relaxed/simple;
	bh=aQb2qy2J1pCZ1132PoicrKjRnzTEBFPwnGLeE5EsJfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RraeIY9JL/jDeX5L9/MKx+hca0SCxhnfmEyVtjXUJCjv5virpmFLMnoR/pGDo7Nf0jHq8JV/0Q+YMEfxzJ8gGChSdvCUNmo+KxkOHy8zNBTXCEQl1+8WRIBllBDEuovlVJtI+MXaFE+o+KiWRhBGEsnzEODyLylqZ7guJYAtlEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vtuBnJp1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JiG9nHcsxcwZpHb/L0Tx41DaV7imD29tLb/ai1sU578=; b=vtuBnJp1FKdRJaUi9wf6dBa+cw
	yFyba5mUeAFRsUmJroWbhRl2eUzKZlVVNqj5veAhvT6EC9M+C9P1/Y8zGdTeqZE/bI1HCme8sHdO9
	GcPjmOj3eT9y485+3rjAUNq69uFkp69CbzOdiVe81V46rzs0RvAuwHALDxEHK9F+mtRy7IyEHwrkQ
	W48r8UtFZtMv4LD8awybcvRGhiXenr5wHvuktQ8hFQb+XjdjbkZfFpItsbQfdQktAwp+/VAEU1+5f
	6XYhchXPqQgz+DLx4WbjOi5xYPuroCrhW+UL2w1nNz90dt4otfrX1DERefvNIrWozjB1cTQ8oHCXr
	q1esPHew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzsK9-0000000ExD1-2NQ8;
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
Subject: [PATCH 12/39] convert mqueue
Date: Sat, 20 Sep 2025 08:47:31 +0100
Message-ID: <20250920074759.3564072-12-viro@zeniv.linux.org.uk>
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
persistent in in mqueue_create_attr() and discardable in mqueue_unlink()
and it doesn't need kill_litter_super() at all.

mqueue_unlink() side is best handled by having it call simple_unlink()
rather than duplicating its guts...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 ipc/mqueue.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 093551fe66a7..5737130137bf 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -599,8 +599,7 @@ static int mqueue_create_attr(struct dentry *dentry, umode_t mode, void *arg)
 	dir->i_size += DIRENT_SIZE;
 	simple_inode_init_ts(dir);
 
-	d_instantiate(dentry, inode);
-	dget(dentry);
+	d_make_persistent(dentry, inode);
 	return 0;
 out_unlock:
 	spin_unlock(&mq_lock);
@@ -617,13 +616,8 @@ static int mqueue_create(struct mnt_idmap *idmap, struct inode *dir,
 
 static int mqueue_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct inode *inode = d_inode(dentry);
-
-	simple_inode_init_ts(dir);
 	dir->i_size -= DIRENT_SIZE;
-	drop_nlink(inode);
-	dput(dentry);
-	return 0;
+	return simple_unlink(dir, dentry);
 }
 
 /*
@@ -1638,7 +1632,7 @@ static const struct fs_context_operations mqueue_fs_context_ops = {
 static struct file_system_type mqueue_fs_type = {
 	.name			= "mqueue",
 	.init_fs_context	= mqueue_init_fs_context,
-	.kill_sb		= kill_litter_super,
+	.kill_sb		= kill_anon_super,
 	.fs_flags		= FS_USERNS_MOUNT,
 };
 
-- 
2.47.3


