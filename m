Return-Path: <linux-fsdevel+bounces-68875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B46C678FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D89FD4F8101
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453F63101A5;
	Tue, 18 Nov 2025 05:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Swn8OWC9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302B62C11D7;
	Tue, 18 Nov 2025 05:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442981; cv=none; b=qJLFA1iNrB0gmtQL9CBj0zdaRmw3y8tDkkbUVlv/NjZFjk7hpSdKpqY7RNvq1RSGBfVeCPKJRM3dhI0pTFgJbJgOGZGRf7ARr4rD5cAskstaYo5dQaiq7BKZfjbJ99Pl47eXcIP95ZnURt0idAzRMHk5wUNllbnaCxlbM1mC9qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442981; c=relaxed/simple;
	bh=WwFHCuQtytil9cvgc+ldg87rrIX/Mu55UMJ+9wTv5BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jt+TSekzy/m3c9SYey/tRZ84vch6doV9Hzt708fJVfTEl+aSK46nJ6UWaajXbs1Tho+xg24gLkXPrsY5QQntL/TX/2NaJ70NtgQWWJWZhKITZuPOwa/HDLJaNTn9T2gKwwcJJbqA4Eib9uiQGca7MpuADMLPLZremQMloFKCz9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Swn8OWC9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NN/33ifYl1WumRWtJ01j5wECnyYUZIw+8lYgHF3pdkY=; b=Swn8OWC9emGgXeb+svd6xyIRtH
	O8+0bfGk7vkeVTnmYyKKioAH2dKMhnaFqOOdCZhfH7DTDKCUSFYkaejYy7x5Ny81bWQhjdQklMl7S
	Kd0VDr5NDP9eF1J4N8xntap3OHNW7LYMKQSxUanm+oLz2/1oJDnE6dgRVdmQLOR5vLoRgU8+aY8O1
	+aFljvFS4ROnasgOFbo/ITPdAlXRonmWAtPelnYbpVkk7vcidV3IaRtWRy+plvzUZekKUcxqbxUCM
	z/GnEDfM/zcm9STlAGaLt6i8N1wM/qw5FGnC6drFm7BAttYg7nCeiSYYhZseGYxd1llCsSW+9Jwv8
	PU9hcoXw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLE4Z-0000000GEch-2tzA;
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
Subject: [PATCH v4 49/54] convert nfsctl
Date: Tue, 18 Nov 2025 05:15:58 +0000
Message-ID: <20251118051604.3868588-50-viro@zeniv.linux.org.uk>
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

One instance per net-ns.  There's a fixed subset (several files in root,
an optional symlink in root + initially empty /clients/) + per-client
subdirectory in /clients/.  Clients can appear only after the filesystem
is there and they are all gone before it gets through ->kill_sb().

Fixed subset created in fill_super(), regular files by simple_fill_super(),
then a subdirectory and a symlink - manually.  It is removed by
kill_litter_super().

Per-client subdirectories are created by nfsd_client_mkdir() (populated
with client-supplied list of files in them).  Removed by nfsd_client_rmdir(),
which is simple_recursive_removal().

All dentries except for the ones from simple_fill_super() come from
	* nfsd_mkdir() (subdirectory, dentry from simple_start_creating()).
	  Called from fill_super() (creates initially empty /clients)
	  and from nfsd_client_mkdir (creates a per-client subdirectory
	  in /clients).
	* _nfsd_symlink() (symlink, dentry from simple_start_creating()), called
	  from fill_super().
	* nfsdfs_create_files() (regulars, dentry from simple_start_creating()),
	  called only from nfsd_client_mkdir().

Turn d_instatiate() + inode_unlock() into d_make_persistent() + simple_done_creating()
in nfsd_mkdir(), _nfsd_symlink() and nfsdfs_create_files() and we are done.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfsd/nfsctl.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 2b79129703d5..5ce9a49e76ba 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1137,11 +1137,11 @@ static struct dentry *nfsd_mkdir(struct dentry *parent, struct nfsdfs_client *nc
 		inode->i_private = ncl;
 		kref_get(&ncl->cl_ref);
 	}
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	inc_nlink(dir);
 	fsnotify_mkdir(dir, dentry);
-	inode_unlock(dir);
-	return dentry;
+	simple_done_creating(dentry);
+	return dentry;	// borrowed
 }
 
 #if IS_ENABLED(CONFIG_SUNRPC_GSS)
@@ -1170,9 +1170,9 @@ static void _nfsd_symlink(struct dentry *parent, const char *name,
 	inode->i_link = (char *)content;
 	inode->i_size = strlen(content);
 
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	fsnotify_create(dir, dentry);
-	inode_unlock(dir);
+	simple_done_creating(dentry);
 }
 #else
 static inline void _nfsd_symlink(struct dentry *parent, const char *name,
@@ -1228,11 +1228,11 @@ static int nfsdfs_create_files(struct dentry *root,
 		kref_get(&ncl->cl_ref);
 		inode->i_fop = files->ops;
 		inode->i_private = ncl;
-		d_instantiate(dentry, inode);
+		d_make_persistent(dentry, inode);
 		fsnotify_create(dir, dentry);
 		if (fdentries)
-			fdentries[i] = dentry;
-		inode_unlock(dir);
+			fdentries[i] = dentry; // borrowed
+		simple_done_creating(dentry);
 	}
 	return 0;
 }
@@ -1346,7 +1346,7 @@ static void nfsd_umount(struct super_block *sb)
 
 	nfsd_shutdown_threads(net);
 
-	kill_litter_super(sb);
+	kill_anon_super(sb);
 	put_net(net);
 }
 
-- 
2.47.3


