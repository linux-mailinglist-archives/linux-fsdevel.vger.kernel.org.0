Return-Path: <linux-fsdevel+bounces-67846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BDAC4BF1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC10D4F6B6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B4435970A;
	Tue, 11 Nov 2025 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hgd1T/hR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EF234EF03;
	Tue, 11 Nov 2025 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844137; cv=none; b=Ate6A6oPYs1M9oGsDXEGg/DD36TvXl36WwsWqOM9gwSGDYWCbGa2jwFwpRj2MI+lKiJZLlVhvp8tapyPlFfzWhH3DEN+gEwYFiXs7hk5i9/OhNgpvyw0DdT3Auei9ov8606keqxK/TER83xFTTSo0dAVIllmUCzvQKNKQoDQIDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844137; c=relaxed/simple;
	bh=xdBCDyyVJS4G+zsY9iJC7Lf/yxlRWctmNpOPn0NXpIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU/2Sqby5yMxUffY6xP1/cZfy99yys8tne7a3eo2GvuIqLm2+dCsdZlpGZHWoHSwzt3f6Zzc61ncFJUCvjQ3+w3RC/WpOFqd12N+t0p3Ex8zVLb7QU3xFKG6enj8xkWOaLO+H0rZiVbJedBVoQoDi/kFmQ9AWmr1a3nIeVeR0LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hgd1T/hR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/QE5WDCT/6E4/9SENMzbAx4/TtK/VNDZoQCVo0AmPFA=; b=hgd1T/hR7hFzvqa4/FhQi64LUF
	DpGBGzt8FSozWK1vHT1CSAIxtkOUMD9lfA+Yg5jssmzeqp36q2yrCN1/ha/2TSHNgQG0WInh76BP3
	S+rZAUnPIolPPEO6FsPoyNn3RAH6ashTBW/05hTa2+Gf9ltR3CmC8s3eEAvGIOLEzKZj8ctY0MWWd
	QcP46qJ8955VSBOzIya9NtrbLAAv7jtnZPWHr1LfNQ6KwEohpuZdrws6OkrXvoNH5ypk/dY4ZvEtL
	t26DMKkl5jl6E+GclnSqGx58FWqgLhyI4nW3pOThpZWg0niou86/LHLxzvZcrzqxg9WNlmOEQl9PK
	HXAt9dmA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHt-0000000BxNT-1JUi;
	Tue, 11 Nov 2025 06:55:33 +0000
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
Subject: [PATCH v3 48/50] convert securityfs
Date: Tue, 11 Nov 2025 06:55:17 +0000
Message-ID: <20251111065520.2847791-49-viro@zeniv.linux.org.uk>
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

securityfs uses simple_recursive_removal(), but does not bother to mark
dentries persistent.  This is the only place where it still happens; get
rid of that irregularity.

* use simple_{start,done}_creating() and d_make_persitent(); kill_litter_super()
use was already gone, since we empty the filesystem instance before it gets
shut down.

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/inode.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index bf7b5e2e6955..73df5db7f831 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -127,24 +127,19 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 		parent = mount->mnt_root;
 	}
 
-	dir = d_inode(parent);
-
-	inode_lock(dir);
-	dentry = lookup_noperm(&QSTR(name), parent);
-	if (IS_ERR(dentry))
+	inode = new_inode(parent->d_sb);
+	if (unlikely(!inode)) {
+		dentry = ERR_PTR(-ENOMEM);
 		goto out;
-
-	if (d_really_is_positive(dentry)) {
-		error = -EEXIST;
-		goto out1;
 	}
 
-	inode = new_inode(dir->i_sb);
-	if (!inode) {
-		error = -ENOMEM;
-		goto out1;
-	}
+	dir = d_inode(parent);
 
+	dentry = simple_start_creating(parent, name);
+	if (IS_ERR(dentry)) {
+		iput(inode);
+		goto out;
+	}
 	inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
 	simple_inode_init_ts(inode);
@@ -160,15 +155,11 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 	} else {
 		inode->i_fop = fops;
 	}
-	d_instantiate(dentry, inode);
-	inode_unlock(dir);
-	return dentry;
+	d_make_persistent(dentry, inode);
+	simple_done_creating(dentry);
+	return dentry; // borrowed
 
-out1:
-	dput(dentry);
-	dentry = ERR_PTR(error);
 out:
-	inode_unlock(dir);
 	if (pinned)
 		simple_release_fs(&mount, &mount_count);
 	return dentry;
-- 
2.47.3


