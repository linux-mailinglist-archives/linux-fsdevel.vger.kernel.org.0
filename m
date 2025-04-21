Return-Path: <linux-fsdevel+bounces-46779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F5DA94BAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 05:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D11516EB56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32B72561CE;
	Mon, 21 Apr 2025 03:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NTPW1PXW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D95F507
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 03:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745206514; cv=none; b=rYS5nUUm7CDPCz4WN52XW8n+5tBX3JO/NoUnQdJo2NDFYk7lz4dPhrWudoAKqey/Nphv/fujbomFagn1jrgVFuVGa70DmanekduHsOMVMCnXpx/PwyzATnphAcyoxIzAq4QRqDrZcd7vyyDSAl1AfBDReeC4lNFbspfWtp4VrGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745206514; c=relaxed/simple;
	bh=/x8XnYYLRWm0yjQymygzcERO18LdPJ3xwwYQjMCgyjE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HLCIEmPqe9A8otcp0TlhuGGSDVgfT4kkjhTaIJNM+g0mfoup2wCfTUSin9VfMYlTQUYGNJ0j013RoaE5D6VTXNuq/ccMRgLXTiZxp2A9asY5acbfvqQV0yGUphf3RT4eGTccEI7qtwInzEGcfneIV47ETuA9w0NRcM+muAGIkmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NTPW1PXW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=hGs9KYFCtSd4Vn+lIXrx2hdsoPAQKEJgoD11v3wy4BA=; b=NTPW1PXWTwUG4byAmerDs++6A8
	E3lLn/jWK9ZlY9z4T1EKobAOjmO+Td51QdG50F6karTb5iOTmhkH6It6RuJLWpYbupRdFP2jqcIIj
	JML2l4zFtQfXkVC8dYKomGFt+dyPR7BsOHfklu4XdOnQmjK9qytAqVUkPXQle0TDYW0PYkrejhR0I
	oAW5QqMQoVSa2cQt5VNkDVX3Y1oZWJSO1dEMzwGwOOFVPRpWAba+1cofYJtxmwrlL1tbo/Didzud+
	3P/hU8L5jNzvQpsIEAHqBkMTdUzJoDbnYa/Wd9HMrsytP3pRrbhR+k+GZ4W7Z3DT6N1KVlDOoLOV3
	9BzQ7kog==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6hw5-0000000HG43-3VOx
	for linux-fsdevel@vger.kernel.org;
	Mon, 21 Apr 2025 03:35:09 +0000
Date: Mon, 21 Apr 2025 04:35:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH][RFC] ->mnt_devname is never NULL
Message-ID: <20250421033509.GV2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

Not since 8f2918898eb5 "new helpers: vfs_create_mount(), fc_mount()"
back in 2018.  Get rid of the dead checks...
    
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index d9ca80dcc544..fa17762268f5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -355,12 +355,13 @@ static struct mount *alloc_vfsmnt(const char *name)
 		if (err)
 			goto out_free_cache;
 
-		if (name) {
+		if (name)
 			mnt->mnt_devname = kstrdup_const(name,
 							 GFP_KERNEL_ACCOUNT);
-			if (!mnt->mnt_devname)
-				goto out_free_id;
-		}
+		else
+			mnt->mnt_devname = "none";
+		if (!mnt->mnt_devname)
+			goto out_free_id;
 
 #ifdef CONFIG_SMP
 		mnt->mnt_pcp = alloc_percpu(struct mnt_pcp);
@@ -1268,7 +1269,7 @@ struct vfsmount *vfs_create_mount(struct fs_context *fc)
 	if (!fc->root)
 		return ERR_PTR(-EINVAL);
 
-	mnt = alloc_vfsmnt(fc->source ?: "none");
+	mnt = alloc_vfsmnt(fc->source);
 	if (!mnt)
 		return ERR_PTR(-ENOMEM);
 
@@ -5491,7 +5492,7 @@ static int statmount_sb_source(struct kstatmount *s, struct seq_file *seq)
 		seq->buf[seq->count] = '\0';
 		seq->count = start;
 		seq_commit(seq, string_unescape_inplace(seq->buf + start, UNESCAPE_OCTAL));
-	} else if (r->mnt_devname) {
+	} else {
 		seq_puts(seq, r->mnt_devname);
 	}
 	return 0;
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index e133b507ddf3..5c555db68aa2 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -111,7 +111,7 @@ static int show_vfsmnt(struct seq_file *m, struct vfsmount *mnt)
 		if (err)
 			goto out;
 	} else {
-		mangle(m, r->mnt_devname ? r->mnt_devname : "none");
+		mangle(m, r->mnt_devname);
 	}
 	seq_putc(m, ' ');
 	/* mountpoints outside of chroot jail will give SEQ_SKIP on this */
@@ -177,7 +177,7 @@ static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
 		if (err)
 			goto out;
 	} else {
-		mangle(m, r->mnt_devname ? r->mnt_devname : "none");
+		mangle(m, r->mnt_devname);
 	}
 	seq_puts(m, sb_rdonly(sb) ? " ro" : " rw");
 	err = show_sb_opts(m, sb);
@@ -199,17 +199,13 @@ static int show_vfsstat(struct seq_file *m, struct vfsmount *mnt)
 	int err;
 
 	/* device */
+	seq_puts(m, "device ");
 	if (sb->s_op->show_devname) {
-		seq_puts(m, "device ");
 		err = sb->s_op->show_devname(m, mnt_path.dentry);
 		if (err)
 			goto out;
 	} else {
-		if (r->mnt_devname) {
-			seq_puts(m, "device ");
-			mangle(m, r->mnt_devname);
-		} else
-			seq_puts(m, "no device");
+		mangle(m, r->mnt_devname);
 	}
 
 	/* mount point */

