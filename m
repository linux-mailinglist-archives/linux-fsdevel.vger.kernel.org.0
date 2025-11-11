Return-Path: <linux-fsdevel+bounces-67825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 602B7C4BF78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32321896E42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE1C357739;
	Tue, 11 Nov 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="m9R6mf51"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909BC34AB04;
	Tue, 11 Nov 2025 06:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844134; cv=none; b=efBaJAMuCRoUrgwzAzD+JeATa51ciwVh7UBPXzJtnhbQP7zIqZ2dCPYLlRJY5ySE70CfSi2+qfwmtWDZtcnfpNJeFByFgYHrkPRAKGseMdL1h+Hvkg5KlVGGl2Y4lwiBGOgXJeURfHixai+v+J7y+P6msAO+Ex9dJ3cuO6btvTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844134; c=relaxed/simple;
	bh=cYeL+5cA9x0NwfB4diEl1DuF4hqIkdO6EuC/cakMsiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koFcnIuRB1xiTLJXzv3GMDoI+kfDEHg5Ne0Y9CssLX1Lwr8VivekauvKxViCgq9Ev85Bivah3TvEA/A00RsH9P3wguaWRXNzhDVIewN8MrUWLSUxZmS648TQLM5slbyCN1reJQmolDE7DO8QEeWqPrhLK5/1XkT5zzp8avMzmfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=m9R6mf51; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jitbeNxbeSwoLaO1GW63OWcQzV6dbGiBbZYgEsubm2E=; b=m9R6mf51Go0SgMCw1YQi0QXZgW
	EyEDA3mrdd+Xjdc8EP55fxHY3ZVHvcC31RtBHNSQgCsfzeNqTK9w+olpHpy/tnKKOSCqeAmKuScoa
	pUKqXnr7u4y83LLprUDaV/ArG4DF68auUhiUB4wwLmO2QrN5KiiHTdH9fQqTA1suUH2Rif7WKh3eW
	PTW4fB/8QQOLO7z3HjLqgHRpHJv1XOVsG3tWfys3RiZBnG8IDExyWgpw1jBjmd793ymisdgf4ev0H
	NHdpI95KjyuLQ84zGf8WP4io9nLiO0zNh8dHhtL5teHCf/5MSvrN/1a2rmWvfeTCk0AkwnKIHf6hu
	iv0AyxUg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHo-0000000Bx6h-0ucI;
	Tue, 11 Nov 2025 06:55:28 +0000
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
Subject: [PATCH v3 37/50] convert functionfs
Date: Tue, 11 Nov 2025 06:55:06 +0000
Message-ID: <20251111065520.2847791-38-viro@zeniv.linux.org.uk>
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

All files are regular; ep0 is there all along, other ep* may appear
and go away during the filesystem lifetime; all of those are guaranteed
to be gone by the time we umount it.

Object creation is in ffs_sb_create_file(), removals - at ->kill_sb()
time (for ep0) or by simple_remove_by_name() from ffs_epfiles_destroy()
(for the rest of them).

Switch ffs_sb_create_file() to simple_start_creating()/d_make_persistent()/
simple_done_creating() and that's it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/gadget/function/f_fs.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 43dcd39b76c5..8b27414a424e 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1870,17 +1870,18 @@ static int ffs_sb_create_file(struct super_block *sb, const char *name,
 	struct dentry	*dentry;
 	struct inode	*inode;
 
-	dentry = d_alloc_name(sb->s_root, name);
-	if (!dentry)
-		return -ENOMEM;
-
 	inode = ffs_sb_make_inode(sb, data, fops, NULL, &ffs->file_perms);
-	if (!inode) {
-		dput(dentry);
+	if (!inode)
 		return -ENOMEM;
+	dentry = simple_start_creating(sb->s_root, name);
+	if (IS_ERR(dentry)) {
+		iput(inode);
+		return PTR_ERR(dentry);
 	}
 
-	d_add(dentry, inode);
+	d_make_persistent(dentry, inode);
+
+	simple_done_creating(dentry);
 	return 0;
 }
 
@@ -2067,7 +2068,7 @@ static int ffs_fs_init_fs_context(struct fs_context *fc)
 static void
 ffs_fs_kill_sb(struct super_block *sb)
 {
-	kill_litter_super(sb);
+	kill_anon_super(sb);
 	if (sb->s_fs_info)
 		ffs_data_closed(sb->s_fs_info);
 }
-- 
2.47.3


