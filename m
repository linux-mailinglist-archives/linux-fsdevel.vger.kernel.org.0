Return-Path: <linux-fsdevel+bounces-67801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41390C4BC62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0B4C34D713
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 06:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE6734CFA8;
	Tue, 11 Nov 2025 06:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qH7TBk+e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A350E3446A8;
	Tue, 11 Nov 2025 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844130; cv=none; b=NWOOslj0BTf7HAf6eOpKY4o/1npEjoE9PfgFALVSfUpR/5XxeP+uI/ISMw3FEqL8B4rUrZAZ/T2twOX1eMARu+ODmE4TdbmHian6JKYhKweOqJsOUZ4L5b0J9wi1mchEARVIyFw7ohMDdJqGdP/uWZqoP5W40veihg4HXT0fPNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844130; c=relaxed/simple;
	bh=2tBJa3241oegAKQCFnpKxHR5dSy+PnQV9THCILKDbT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPGCyWPVjtpbSp8LqZvEwotHtakNO6b3JTr/a+xb8SZjuCToeNBolVVXa3l83X45gAN770h6JbKI/I0A/oP7qrS3a6u0I9oMis0X3b7a6ZdL6ej/y14eFHaVoHI0pvsUZODYTbR15o/h53eTF9AN6hiI08zJlMVaoe2oSqKAyUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qH7TBk+e; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fTvrbo3mOzTGCel3agLEDWiwlpX39p3niSGJ7gA+srw=; b=qH7TBk+eHDvm5siQkKlw8FrzJW
	5Jui0fzA1zXpfadChbrGfDRhwWzG9A5d3XeSOOD9mgbukwwt8ilhKYsGWlBDSIwpBddE6btAAtNO1
	Q+UfbQyrVcMNQ6/tVYxuZ11sG1+GQLxgGfZ6/dzMsBqwd7J4360gzf1wxR/Ha9FhGqS7Q7RPS/Z19
	7nm0ndxcMPWJn1kWEBx+YxLOZz5dZlD+HOAVoPRbQBr+KLbYHRTaXR/j7mT3o1NzDnCTzvSyaGs4t
	ot+pnKsJnuiV+NRDNWD4nZHhKUnDl7BjtUBnp6m+dEeVUEtt52QIfrLLCGG074PcsdayQbP7DUbrZ
	ze0yilYA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHj-0000000BwyB-1e67;
	Tue, 11 Nov 2025 06:55:23 +0000
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
Subject: [PATCH v3 13/50] convert hugetlbfs
Date: Tue, 11 Nov 2025 06:54:42 +0000
Message-ID: <20251111065520.2847791-14-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Very much ramfs-like; dget()+d_instantiate() -> d_make_persistent()
(in two places) is all it takes.

NB: might make sense to turn its ->put_super() into ->kill_sb().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/hugetlbfs/inode.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f42548ee9083..83273677183d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -975,8 +975,7 @@ static int hugetlbfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (!inode)
 		return -ENOSPC;
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	d_instantiate(dentry, inode);
-	dget(dentry);/* Extra count - pin the dentry in core */
+	d_make_persistent(dentry, inode);
 	return 0;
 }
 
@@ -1023,10 +1022,9 @@ static int hugetlbfs_symlink(struct mnt_idmap *idmap,
 	if (inode) {
 		int l = strlen(symname)+1;
 		error = page_symlink(inode, symname, l);
-		if (!error) {
-			d_instantiate(dentry, inode);
-			dget(dentry);
-		} else
+		if (!error)
+			d_make_persistent(dentry, inode);
+		else
 			iput(inode);
 	}
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
@@ -1483,7 +1481,7 @@ static struct file_system_type hugetlbfs_fs_type = {
 	.name			= "hugetlbfs",
 	.init_fs_context	= hugetlbfs_init_fs_context,
 	.parameters		= hugetlb_fs_parameters,
-	.kill_sb		= kill_litter_super,
+	.kill_sb		= kill_anon_super,
 	.fs_flags               = FS_ALLOW_IDMAP,
 };
 
-- 
2.47.3


