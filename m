Return-Path: <linux-fsdevel+bounces-67802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E614C4BCEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 652C44F2D88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 06:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3A234C9AC;
	Tue, 11 Nov 2025 06:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="odzar9we"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F68C330D26;
	Tue, 11 Nov 2025 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844131; cv=none; b=OlvqwpkgxGvEBQT9SwXeWs1gcVaN6AhEWG5xaZfl9p1CdoGA0ae/49ppHv/Bf0R8nsuCOophHT1+dKXoipe6+X2RLzPDoG5uyuGLx5nTkpr3081pm1Zyu5aTmQC5xAmdVDtilDqlbpGMMPJTKl3yZsNph/I8HOln8ZjDFNYYlGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844131; c=relaxed/simple;
	bh=/LaVkFLh1YjZDdmlfu7Y7iehW4lVeCwtnmZ9ARo1aE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHCLuhFCbIbcTcXmuJcYkmvlxtkfn+A6P4ZL0VMHZF2rPeM8HeelGhjnfvYrpJ2ILIaylsQ1TBC2YdjmvzMDsqRL+riFZwwpeSZCjTvd8kDdjoide3WGSFySeiTczG4ffVwkr0+ZspvWy5JfOOWCSL0dcyoR2106Y7QPO9M86i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=odzar9we; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AovK4oTG8i9mD8KDrbZrZDCi+2Kh5o4vX35c5oMMEjA=; b=odzar9weixBzYX42VUwPE8PYUf
	DnpEWbjsupemEddy27qT0QEladdomZrTuxiiYhnT0M3EgQ774jwpEHRyJniCoyxXzBmW61bHT5Qxn
	WMeToZUkmaW/5WUOL3G6/um5bstbPf0PLLijdD8s2ltQG6JOeiOTR4MoOnuzgb8d3bTmn2faGk2FP
	K5KJ3To7GTbCuzAssuAQ1Cow7i4xvRz7BVXCVE8gWQPNGtbw8ePBzXInYNoEF0DQFNFs9cTs+khFJ
	rzOoaoUTkPzhr4mKruj4ilzPBx2woTM4O/0sHKSLOoiVFVSmR0DRMkQO/Ua5XjjdZ79/YBdCfLOd3
	xMemXTYA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHl-0000000Bwzb-2GZL;
	Tue, 11 Nov 2025 06:55:25 +0000
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
Subject: [PATCH v3 25/50] ibmasmfs: get rid of ibmasmfs_dir_ops
Date: Tue, 11 Nov 2025 06:54:54 +0000
Message-ID: <20251111065520.2847791-26-viro@zeniv.linux.org.uk>
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

it is always equal (and always had been equal) to &simple_dir_operations

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/misc/ibmasm/ibmasmfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
index a6cde74efb68..824c5b664985 100644
--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -97,8 +97,6 @@ static const struct super_operations ibmasmfs_s_ops = {
 	.drop_inode	= inode_just_drop,
 };
 
-static const struct file_operations *ibmasmfs_dir_ops = &simple_dir_operations;
-
 static struct file_system_type ibmasmfs_type = {
 	.owner          = THIS_MODULE,
 	.name           = "ibmasmfs",
@@ -122,7 +120,7 @@ static int ibmasmfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		return -ENOMEM;
 
 	root->i_op = &simple_dir_inode_operations;
-	root->i_fop = ibmasmfs_dir_ops;
+	root->i_fop = &simple_dir_operations;
 
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root)
@@ -188,7 +186,7 @@ static struct dentry *ibmasmfs_create_dir(struct dentry *parent,
 	}
 
 	inode->i_op = &simple_dir_inode_operations;
-	inode->i_fop = ibmasmfs_dir_ops;
+	inode->i_fop = &simple_dir_operations;
 
 	d_make_persistent(dentry, inode);
 	dput(dentry);
-- 
2.47.3


