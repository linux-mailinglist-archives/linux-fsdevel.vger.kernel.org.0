Return-Path: <linux-fsdevel+bounces-68878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F97C6783F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F26E6366389
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2B12BE02B;
	Tue, 18 Nov 2025 05:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LeMawiHQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E29B274B53;
	Tue, 18 Nov 2025 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442982; cv=none; b=juZYCg0MW7HIx1p+AW+DLDbhhpT+znEEe0/88YNWth6jnjWnV/bIIlTiXJC0sx8XXeX2ULvAw26E97FpBKHzfMyqWcdj85vDh6SXeP7kIRWzZxAW0zctWhD3cs4MySaw0yZkec8CiIzkCQBm0jOYyrZOsgrQYDMIP4hHt5PFYh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442982; c=relaxed/simple;
	bh=aQ8wiaM2Vz5X//su5rT71uA1xpaSvUMrx9j5Y7IQzKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7LHnmIfR0etxeQ6qOdzn/SoAinfIGpctuXwVq8oFtBtLCzhqD+hkhN3RtvhMvxmvPfpcOkg/NykxadvD20mIqqtawKWVndTFhlzAz8rILwHf8Cg+zFkEQ4DnBf9zKSPhFww7tiMOWeSKExhAOQPe2XVQJTlNoCKBY9YblHHpFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LeMawiHQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tZCVSqTQSDDLvQs1X2myYSkLJtZwbiT5pTgxLsDWfWg=; b=LeMawiHQ7jKHSt76eutlBW3Zs2
	s+rZfr3ileWw8U0iBYcz8v2ImHtWAxoclxDit7HsWTNNQmQKOMJkc0H1JsL4GuhLFLZAMtpbJFw3v
	5sBlLWQgFe0bcX9zWvwGz2Giq4KokVLbCiwbMNLTfCiXwtxQVQZeLPKNNBE7juy/rmT4e3GALwTZ5
	PEyKCfonsy9yCOuc26nYqza3cVari3TereVcpVEUdC67qgYTv+GiT8T0E7SLQpJSYJLJKgWMdFNWd
	Zh/sz9+hFx+PvVhRl7jo7ztL9IWysDkF6r54Lx6xBC6oEYA264W6d3qLG14Ze+qOGrr/0NYrKK5Sb
	Q2r9AhKw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLE4T-0000000GEQD-3C7U;
	Tue, 18 Nov 2025 05:16:05 +0000
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
Subject: [PATCH v4 07/54] convert simple_{link,unlink,rmdir,rename,fill_super}() to new primitives
Date: Tue, 18 Nov 2025 05:15:16 +0000
Message-ID: <20251118051604.3868588-8-viro@zeniv.linux.org.uk>
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

Note that simple_unlink() et.al. are used by many filesystems; for now
they can not assume that persistency mark will have been set back
when the object got created.  Once all conversions are done we'll
have them complain if called for something that had not been marked
persistent.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/libfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index a033f35493d0..80f288a771e3 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -630,7 +630,7 @@ static void __simple_recursive_removal(struct dentry *dentry,
 				if (callback)
 					callback(victim);
 				fsnotify_delete(inode, d_inode(victim), victim);
-				dput(victim);		// unpin it
+				d_make_discardable(victim);
 			}
 			if (victim == dentry) {
 				inode_set_mtime_to_ts(inode,
@@ -764,8 +764,7 @@ int simple_link(struct dentry *old_dentry, struct inode *dir, struct dentry *den
 			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
 	inc_nlink(inode);
 	ihold(inode);
-	dget(dentry);
-	d_instantiate(dentry, inode);
+	d_make_persistent(dentry, inode);
 	return 0;
 }
 EXPORT_SYMBOL(simple_link);
@@ -798,7 +797,7 @@ int simple_unlink(struct inode *dir, struct dentry *dentry)
 	inode_set_mtime_to_ts(dir,
 			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
 	drop_nlink(inode);
-	dput(dentry);
+	d_make_discardable(dentry);
 	return 0;
 }
 EXPORT_SYMBOL(simple_unlink);
@@ -1078,7 +1077,8 @@ int simple_fill_super(struct super_block *s, unsigned long magic,
 		simple_inode_init_ts(inode);
 		inode->i_fop = files->ops;
 		inode->i_ino = i;
-		d_add(dentry, inode);
+		d_make_persistent(dentry, inode);
+		dput(dentry);
 	}
 	return 0;
 }
-- 
2.47.3


