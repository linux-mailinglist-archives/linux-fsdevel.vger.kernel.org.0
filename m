Return-Path: <linux-fsdevel+bounces-68831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1732CC675D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 8B2472A4E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBDF2D7D41;
	Tue, 18 Nov 2025 05:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cMhlXBqE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D43524BBFD;
	Tue, 18 Nov 2025 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442975; cv=none; b=CRtwI732+/63JZhu2hNXDagIo/2TJxHmcU6goyooH7A5kfUBGwQOU6by2fRB122U8mL7JXhTh1ePt9mcXlF/1RV8ReVNWLtpPED4nezMzZjnig4ojqJ+yPGTPAYP50upe7swcBcDPyXnpbQu1XZ2+DpfmocHMu4lbFWlUZ7vYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442975; c=relaxed/simple;
	bh=Iwt5ye99zRJSX9pycRhX5pwplCSLlQAGWoYLgPWULTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8/qKi/r+brzgvj+9u3oGDIJAerXNwXx8t+j2pTVkst6jAXvdCi4mpWnfr2g8VqeThiEdHO2mwNcAaGxVzTqYBYd/y9yMQ5tqhi1nEkUbXjKN7SNAxp5i0GUyA2v6hzO9VmOzH7x0nosmT9YUZsHiSyo1mkGfbXJ0yfuTxnMQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cMhlXBqE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Zcrjn9Hoyal2qTn93te4BLRuOf8fYSOuLLeBgOIrdbo=; b=cMhlXBqEGcRgFzivtW6c0N9XeJ
	5GoGNtggd/IvFsOSwoxXYFjLNuuucPyNlyXC9RYSslkG2HVqkhhkXopsNdIlCG7dHuTmqENpcMkCW
	1y11RnGPngVleScCDLPtMiEFccZvejq+LsXLe5h3Jpu64iwHmDTVgryh/skc3R/qzpyGfLa/4NEnX
	QzrbT7g12nVRpeqkBNdMWVvVisoqlemJ28304bpBsNN0dZ2QzvYivoQ/dLNwf9c1QWZfGLcJk6nsW
	CgKWdgJB77OjrZB53fmfibtws2x2pG6nmSHorw+hngyXde+felKNRB1P4cCifXGXt+lbUs2oEZ/ou
	nFVCdRrg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLE4U-0000000GERG-3gSD;
	Tue, 18 Nov 2025 05:16:06 +0000
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
Subject: [PATCH v4 16/54] convert dlmfs
Date: Tue, 18 Nov 2025 05:15:25 +0000
Message-ID: <20251118051604.3868588-17-viro@zeniv.linux.org.uk>
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

All modifications via normal VFS codepaths; just take care of making
persistent in ->create() and ->mkdir() and that's it (removal side
doesn't need any changes, since it uses simple_rmdir() for ->rmdir()
and calls simple_unlink() from ->unlink()).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ocfs2/dlmfs/dlmfs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index cccaa1d6fbba..339f0b11cdc8 100644
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


