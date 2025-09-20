Return-Path: <linux-fsdevel+bounces-62288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23926B8C24B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 09:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30AE3B4506
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 07:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC072D061A;
	Sat, 20 Sep 2025 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iOX+SvVu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FBE26E146;
	Sat, 20 Sep 2025 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354486; cv=none; b=JTakCqWcr1M8XjLkgBh1FHqPlAsf/J967ab0JsEcKPk73UZgg8dkzR3dic6tnDxSkBA3Tz8bBeweijUzwDNQHxk+SnUkUgPYYJ0UnEmbKZFboOdA/iI+rit5CvFHX5FDFXltfZOKMxj9f0XRo5KRrXwYnRQNXz6RmxCgVq2ILKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354486; c=relaxed/simple;
	bh=rSD1tbwuBhbQUb66t6RD+Fsqu5RCGAOtAqx7WBTEKkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8DYqyz1i1PB6EZ3+JSpjXz8Xh84TS40qHVGIM0hHQC8WBNQOMO3Bid8Vlbx501Ru81Y6gON3nQuYBV4nTbpRA9zLwzKETIqf7f4s0hmUT0j2gO0sOtLTD6rm3iOOjv2/ann3TnKJex+ING2As6Vb/W1tqNgKBPnRyfUG/LF2Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iOX+SvVu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lqA6uNnelhHPNdxaTr+BMqt87A9Hf9N7voNPs9LM5YI=; b=iOX+SvVue18PtFh4vqwMLsvM3g
	nT+og5qvc1RpyWQNYEig7PwPyghWWW2axPiENKqw94Oeg3NsfhJAaGwuMuylM13vmzV+4nxHoftHW
	xVnc+onOTPvXe6MxIzPME6L3qYb2E7lOjrLkvZZ7ZPfCb3DcdIomj/bHJvv92EuDeH7UM0n9I2yGW
	nO9VriKQlu8YMExmaHFEuFK004y/0pCqU4RhcPZgXw7igdOLM/05eFAYhCj+dYT9/Gga0NdDYheTr
	+pFfCai9roXTbAGbbyD13fGeumpQEBrdNokPvc8EUC9bwINP+sRtYGd8XFU+vhCNfg+9owwSoQatJ
	Iv+GtRNQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzsK9-0000000ExCv-1nhF;
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
Subject: [PATCH 11/39] convert hugetlbfs
Date: Sat, 20 Sep 2025 08:47:30 +0100
Message-ID: <20250920074759.3564072-11-viro@zeniv.linux.org.uk>
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

Very much ramfs-like; dget()+d_instantiate() -> d_make_persistent()
(in two places) is all it takes.

NB: might make sense to turn its ->put_super() into ->kill_sb().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/hugetlbfs/inode.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 09d4baef29cf..f77fb71f78fc 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -985,8 +985,7 @@ static int hugetlbfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (!inode)
 		return -ENOSPC;
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	d_instantiate(dentry, inode);
-	dget(dentry);/* Extra count - pin the dentry in core */
+	d_make_persistent(dentry, inode);
 	return 0;
 }
 
@@ -1033,10 +1032,9 @@ static int hugetlbfs_symlink(struct mnt_idmap *idmap,
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
@@ -1493,7 +1491,7 @@ static struct file_system_type hugetlbfs_fs_type = {
 	.name			= "hugetlbfs",
 	.init_fs_context	= hugetlbfs_init_fs_context,
 	.parameters		= hugetlb_fs_parameters,
-	.kill_sb		= kill_litter_super,
+	.kill_sb		= kill_anon_super,
 	.fs_flags               = FS_ALLOW_IDMAP,
 };
 
-- 
2.47.3


