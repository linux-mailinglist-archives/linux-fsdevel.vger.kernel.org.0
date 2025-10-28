Return-Path: <linux-fsdevel+bounces-65833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EBCC125B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 01:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D47A550220E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 00:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E18332EC5;
	Tue, 28 Oct 2025 00:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WS+FB8wn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400FB217723;
	Tue, 28 Oct 2025 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612387; cv=none; b=MY90+g8QwgFwj8G6Be2Yp8rM4Zd+Z8WQ9TvjIi4cOsjFYIt86v3C5H4+m2y/nTg2GuC5YWipiDV15F7s7Uk6ZS786AglMB9O5hl+oj1/sgaeS/YXo+ucBee11MWzf3VVi1Ku47Vw9+IBs+EL672FFPCrl13EsrPnJ0Z7wABP5FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612387; c=relaxed/simple;
	bh=jGXLbtBoU52kB5fq2se2ip0WlsiUE6GUM8W8byZni/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpmQ06bUrcK3LtPXwgybHTXmOnGmabp35ygZJaxFC9sESvavitkprxKeQqWedE/GK3u4nUkZl1jqW/F4thGcD5SU4Ps2ruIXjJ2w9X/bLFE5feUKgmp/B9qXT+ftilDCT53Dok9rxScoOnJHIMGMEQWAZU2my52TgH4RqwtWfKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WS+FB8wn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XM4FZa0do0+xkZhNaAyLfkF8FdfO7rZo+6nC0ji7Cc4=; b=WS+FB8wnnvrg1STdVHRHhgtd3e
	vA8ZVpy0FVTwmwDGjCHc/2tiGcDQkk87YeN70uDxpICW0w2QMEcAqsDJXCqIGDXWDAgcCJQT5FLgv
	IU1uIxyHaIhuzZXuqtR+78tanMf6sk8IV1fzlNZL69yfV+Af2Upb49UTz4IjADgRxoaWJnca5sKQX
	AATECFXUnQxK2k3O9chDriGxOsLOR3+wEFJUafpfsa2m7AS9rX3yNjIxcIrfS+Af1F2DtpuBwBJgV
	tBZ4ytoVCKlXYk5skQ95GPhvuT0p8Zj7buhDSVwVyQEZVMEI52Ey0/J/+V9+vtlESXizL3+cBs2Xa
	mmNljBtQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDXqq-00000001eXr-29Z5;
	Tue, 28 Oct 2025 00:46:16 +0000
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
Subject: [PATCH v2 17/50] convert fuse_ctl
Date: Tue, 28 Oct 2025 00:45:36 +0000
Message-ID: <20251028004614.393374-18-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

objects are created in fuse_ctl_add_dentry() by d_alloc_name()+d_add(),
removed by simple_remove_by_name().

What we return is a borrowed reference - it is valid until the call of
fuse_ctl_remove_conn() and we depend upon the exclusion (on fuse_mutex)
for safety.  Return value is used only within the caller
(fuse_ctl_add_conn()).

Replace d_add() with d_make_persistent() + dput().  dput() is paired
with d_alloc_name() and return value is the result of d_make_persistent().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fuse/control.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 3dca752127ff..140bd5730d99 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -236,8 +236,14 @@ static struct dentry *fuse_ctl_add_dentry(struct dentry *parent,
 		inc_nlink(inode);
 	}
 	inode->i_private = fc;
-	d_add(dentry, inode);
-
+	d_make_persistent(dentry, inode);
+	dput(dentry);
+
+	/*
+	 * We are returning a borrowed reference here - it's only good while
+	 * fuse_mutex is held.  Actually it's d_make_persistent() return
+	 * value...
+	 */
 	return dentry;
 }
 
@@ -346,7 +352,7 @@ static void fuse_ctl_kill_sb(struct super_block *sb)
 	fuse_control_sb = NULL;
 	mutex_unlock(&fuse_mutex);
 
-	kill_litter_super(sb);
+	kill_anon_super(sb);
 }
 
 static struct file_system_type fuse_ctl_fs_type = {
-- 
2.47.3


