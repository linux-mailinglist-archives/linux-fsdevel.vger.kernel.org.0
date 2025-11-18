Return-Path: <linux-fsdevel+bounces-68876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94289C67915
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 360E94F85D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A7D30FC11;
	Tue, 18 Nov 2025 05:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tvP+Rm/V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F78B2C21C1;
	Tue, 18 Nov 2025 05:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442979; cv=none; b=hQYl2Rn8DsVP0g+19HQkoJ72Us/9xBngrMcwpfTIS0PFCO1dm+8a5OshEWPyCj9nFeMcE2ZSKufeYmyhSGKmf5S1myBQun34atrLD0uRfg+ktpffVTMagEm4aL3/Cypmbb8YSOU3oALp0a5Eudj8dYlqrAyC1Q7kgMk4uBYXbTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442979; c=relaxed/simple;
	bh=zPYbbdJMbimCH8CGuafAZf5bHfgge+LaaShYJQxoDwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUNM5Hmt/Ju2ZjQM+yPy1Kd1YzNEJJ/OHQrasrd7+TUaxhwtRSzwvXDLck8e2gqgCCbyIpNqqeiv2vIZBnRWDThbQ7xwtW8xW3mvgCpDOpxtDY4FE6mh5C5RPwFj4UKdI/UPq/dLNdOh01ph4RDb3F/zZHe7x8JdUobF711osBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tvP+Rm/V; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sU0Rwyb1f70hxWqGLaDrX9gfHmhzhxjXEuqfS3xyBnk=; b=tvP+Rm/VUpFEtjTr5flW9AZmbU
	EzRtigGLTzsKq+yofPuIueTOmYfV6zi1I2TwuPtT4PHJPyuXP1Nc9lVhj59h2gYy4cFJq4LhZprop
	8ROzJjA86BGtttEVo7zzpWV8snzvasJlqumptzAGTNUTgNkToBAF6Mo6SjcDieMNQ7YYjtXCzisGi
	xYIVaaWwZiJNaqIArUEL4pOtTYOpcwX81Jc4rYYhr0q/ERBWw7VHcz3FQjVCL3Z1fPKPvorH8ODG4
	+Lr1JnaIN5qc2SyQI2UEBN9yNgcAtpy83rsAK2ffeQM7yd8Lt/4NmPt35xVbfRI9BzvSluCk2t3ZX
	lNMovGhw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLE4Z-0000000GEZu-0Uh8;
	Tue, 18 Nov 2025 05:16:11 +0000
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
Subject: [PATCH v4 47/54] convert hypfs
Date: Tue, 18 Nov 2025 05:15:56 +0000
Message-ID: <20251118051604.3868588-48-viro@zeniv.linux.org.uk>
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

just have hypfs_create_file() do the usual simple_start_creating()/
d_make_persistent()/simple_done_creating() and that's it

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/s390/hypfs/inode.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 6a80ab2692be..98952543d593 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -311,7 +311,7 @@ static void hypfs_kill_super(struct super_block *sb)
 	struct hypfs_sb_info *sb_info = sb->s_fs_info;
 
 	hypfs_last_dentry = NULL;
-	kill_litter_super(sb);
+	kill_anon_super(sb);
 	kfree(sb_info);
 }
 
@@ -321,17 +321,13 @@ static struct dentry *hypfs_create_file(struct dentry *parent, const char *name,
 	struct dentry *dentry;
 	struct inode *inode;
 
-	inode_lock(d_inode(parent));
-	dentry = lookup_noperm(&QSTR(name), parent);
-	if (IS_ERR(dentry)) {
-		dentry = ERR_PTR(-ENOMEM);
-		goto fail;
-	}
+	dentry = simple_start_creating(parent, name);
+	if (IS_ERR(dentry))
+		return ERR_PTR(-ENOMEM);
 	inode = hypfs_make_inode(parent->d_sb, mode);
 	if (!inode) {
-		dput(dentry);
-		dentry = ERR_PTR(-ENOMEM);
-		goto fail;
+		simple_done_creating(dentry);
+		return ERR_PTR(-ENOMEM);
 	}
 	if (S_ISREG(mode)) {
 		inode->i_fop = &hypfs_file_ops;
@@ -346,10 +342,9 @@ static struct dentry *hypfs_create_file(struct dentry *parent, const char *name,
 	} else
 		BUG();
 	inode->i_private = data;
-	d_instantiate(dentry, inode);
-fail:
-	inode_unlock(d_inode(parent));
-	return dentry;
+	d_make_persistent(dentry, inode);
+	simple_done_creating(dentry);
+	return dentry;	 // borrowed
 }
 
 struct dentry *hypfs_mkdir(struct dentry *parent, const char *name)
-- 
2.47.3


