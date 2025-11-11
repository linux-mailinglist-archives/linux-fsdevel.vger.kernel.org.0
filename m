Return-Path: <linux-fsdevel+bounces-67819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35845C4BE7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FC634F5628
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653CB3570AF;
	Tue, 11 Nov 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tc0/LaWO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23655347FD8;
	Tue, 11 Nov 2025 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844133; cv=none; b=MlvNJRnny1aZKx9RHdD7QtZETmDu2Ih3NyNQBTUVWnddqcChLmk8Fy56uPaZmQm+PWpR2wywvp2DNzK224eCY+0UIShAZN/LYpHpplkK1mcjZnjoc4p8zZJ+GoM5E+krI4IPFnTr2soBQuKO4DgXQ5Zu4014MA/zLJ/0fLbie4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844133; c=relaxed/simple;
	bh=g0DzPIcsJ7FGStG4d77ktIfa76GpIX47vIyEYt5ulTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2SG0uM59ksPfycyT/9pG2MlBqY4or6w56ayWMfFkg9Z1xVVQh76OIG6U3L+d/IgSWGvkv2dAHdazz+8zwq19LSBMh6jaEBKEtWwp1eYYqcZ7VKa7Fi+9p8QFmyH7WSjH17C0gesQY5VJHKmbczz6ugYzrsl5DpXL089gh+REs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tc0/LaWO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0EOMkT/UFsYLOkQCFILn7xjwHlMa0Zq2h7YoVPTnFkU=; b=tc0/LaWOOgbMQ111+igu49CS2g
	phQ+Ub498iuMr20TnISzkpSlI5Rh9m3XDKIHm7ttVNJWMNodhJrqScO1UChifsgTI0vp9a+TC0zQ6
	wgIoJMLc1ZxBeW43ROXp06EFElt8QvwpbW5Lm+4FTnxcW0IJWyS8W4g9QDdJpt4Ef4wpnI+3bZwTD
	/FrUz0/B80hWcmSL60mE+RJDBRevzP6gYz6fARP+/akZPB5L0nOP9JBP0eptP6MQFkY9iVmWnn0uy
	48PTVG93EJ3fivCiWdovYzsAT+/N8eSgVEHVRP0vkxJajSkYrBjMF90xFvWKrIH4uI8kq34s1Uk3/
	2di164SQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHm-0000000Bx00-0jJ1;
	Tue, 11 Nov 2025 06:55:26 +0000
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
Subject: [PATCH v3 30/50] autofs_{rmdir,unlink}: dentry->d_fsdata->dentry == dentry there
Date: Tue, 11 Nov 2025 06:54:59 +0000
Message-ID: <20251111065520.2847791-31-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/autofs/root.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 174c7205fee4..39794633d484 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -623,12 +623,11 @@ static int autofs_dir_symlink(struct mnt_idmap *idmap,
 static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct autofs_sb_info *sbi = autofs_sbi(dir->i_sb);
-	struct autofs_info *ino = autofs_dentry_ino(dentry);
 	struct autofs_info *p_ino;
 
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count--;
-	dput(ino->dentry);
+	dput(dentry);
 
 	d_inode(dentry)->i_size = 0;
 	clear_nlink(d_inode(dentry));
@@ -710,7 +709,7 @@ static int autofs_dir_rmdir(struct inode *dir, struct dentry *dentry)
 
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count--;
-	dput(ino->dentry);
+	dput(dentry);
 	d_inode(dentry)->i_size = 0;
 	clear_nlink(d_inode(dentry));
 
-- 
2.47.3


