Return-Path: <linux-fsdevel+bounces-68846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0188BC67723
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 06:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E373136320C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 05:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3353B2F3C2A;
	Tue, 18 Nov 2025 05:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FkUHaqpP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3CD246BD8;
	Tue, 18 Nov 2025 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442978; cv=none; b=E0OPTNIG1nOoNkYWS4s8T+Z39okERdFatpNEgdFHIkZhKzuXLbQTaOc0I0d3t3GyeYTSGbUoWSG6OOZQtUotIOWi33hrn00Bpf6tUWTNqNPXdE+28XAtox1Er+E2bLsTy6sg2SKpjxld7iaDT0IBVzlPCe4CbIdiAJ0AsU40cNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442978; c=relaxed/simple;
	bh=qXZbEHrdLHw3ER0EjOoBTxUqixD7QySPym/js84zGF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgRPTT968Bo0kxLe0t7MRuRwoPMWvnvDNOdjNsA1Q9u2dvnK5DMv61EbYQfQloi+Km9Bb7FqNxWdAHosXKSv4zE7ZPY1zZxjqgGOz0FDrEIMdCZXLx8N37qIt+N5iLvXcy63PP2Wc9zqSjyGkKf7xXL+qhvVcyGbSSfyowTqypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FkUHaqpP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DcJDdyyw+9mZFsLI1pNHpwtOdVFfzDBEUjJvLA9jflQ=; b=FkUHaqpPlLEPJ5vDVwvDjKssLJ
	NGc/9kDZwbBHoUXj1aImGAOqPNAm/OEBRH9e2JsaS7bS3xn8au2YrZF+iUY/GqO6Cv7+vb5wPdsph
	riz89b9xKivq4rwEeUSAQhbZruTyAHLQZUpMJagJsD6e2mauhgaaUEQ7xD6cAE7f2IjC4Yazl/wUt
	WvgbzN9Qswmq05hv6LK25ATXj8rqnUUtvccBmF2nrkZFOB1gPIr8IqhbtsRMZwxq0zjp/GC9wHzY1
	YsBiIwpErIUhXzRHICcofmNrkpcYpe2XpkXAgOW/PVw8+N3P4bN8wiSnBP8pNeXSRhgApLPAikiCN
	qnhCwY9w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLE4U-0000000GERN-42q2;
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
Subject: [PATCH v4 17/54] convert fuse_ctl
Date: Tue, 18 Nov 2025 05:15:26 +0000
Message-ID: <20251118051604.3868588-18-viro@zeniv.linux.org.uk>
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

objects are created in fuse_ctl_add_dentry() by d_alloc_name()+d_add(),
removed by simple_remove_by_name().

What we return is a borrowed reference - it is valid until the call of
fuse_ctl_remove_conn() and we depend upon the exclusion (on fuse_mutex)
for safety.  Return value is used only within the caller
(fuse_ctl_add_conn()).

Replace d_add() with d_make_persistent() + dput().  dput() is paired
with d_alloc_name() and return value is the result of d_make_persistent().

Acked-by: Miklos Szeredi <mszeredi@redhat.com>
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


