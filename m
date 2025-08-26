Return-Path: <linux-fsdevel+bounces-59305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EF2B37218
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 20:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EA58E1371
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 18:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECF536CC6B;
	Tue, 26 Aug 2025 18:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XekmSBv7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEC2368092;
	Tue, 26 Aug 2025 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756232488; cv=none; b=sMSQsb8DNPZ/abtqh5XBZQpaHlKZWatXPuwYzR0goMNnGGkNdB04rqPcVmfN7/ltRlU2OsnIFFu2fGbzOOu9DqmrsaPvQ72yHet363UsH1E+srvAj9bB28p+dA/f/lfqiqm4bh20QPInTXl+I1oDWmg0V1ia3Z0YCT3llw1vyx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756232488; c=relaxed/simple;
	bh=B6jdH8HP6wEJcaBfFcYa/Jt54pKRzu6ZWCW/l7bqB9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqbVSQtx/jFBzuyjQAcckxM9agpDHRKwNzKA1Q2H1rK6vkcddU3xda3iL9ueFGDZULhTmLP0Zc0F4s57XVVMRtCczp2bUFFjdcVx4DTRZRUqigEpWEwyNvcEtUmF0JBmJOb7uKS0wT3MRVicDLp7AURup0jjyqzX8n79xpNo0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XekmSBv7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eKrsZ8n9c1Uhnt/CnikDa+5wZlJ2YhlU+uxnrgRiAFw=; b=XekmSBv7dFXym2MgTXupORM5i4
	K2rBmKKpE9CPkslVaxxm3OcPzNCiuhCCnCzMrmgu8g3uVsG+COaBR8PwsbzEX7DivbXdO1zX+OgYA
	jEo+B7ZNQjcIE5d22aCJzS9doXxqa/HRkOwqItf4YRrCzWjxnqGCpe8vN7KhirMX+jd0ori0bfBnF
	ufJVsS9Nd9mAqeAPrG1bZ5m4r2TXSqugN0QK5X9RbpjRLlaB8KhrUPphcPuNkciE9VCYDudxG3t5R
	qJjE4S6jwdbBhbWFHfd/re5SEzY9h67fmLKSq6k+Tq1yP3fYqWXGW6XkNNLpaBivzI9XbDn4ZHSO5
	BwLpSVvQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqyIO-00000004A2y-0OkV;
	Tue, 26 Aug 2025 18:21:24 +0000
Date: Tue, 26 Aug 2025 19:21:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>
Subject: [RFC][PATCH] switch do_new_mount_fc() to using fc_mount()
Message-ID: <20250826182124.GV39973@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-25-viro@zeniv.linux.org.uk>
 <20250825-zugute-verkohlen-945073b3851f@brauner>
 <20250825160939.GL39973@ZenIV>
 <20250826-kronleuchter-vortag-af3c087ae46a@brauner>
 <20250826170044.GT39973@ZenIV>
 <20250826175501.GU39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826175501.GU39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[
This is on top of -rc3; if nobody objects, I'll insert that early in series
in viro/vfs.git#work.mount.  It has an impact for LSM folks - ->sb_kern_mount()
would be called without ->s_umount; nothing in-tree cares, but if you have
objections, yell now.
]

Prior to the call of do_new_mount_fc() the caller has just done successful
vfs_get_tree().  Then do_new_mount_fc() does several checks on resulting
superblock, and either does fc_drop_locked() and returns an error or
proceeds to unlock the superblock and call vfs_create_mount().
    
The thing is, there's no reason to delay that unlock + vfs_create_mount() -
the tests do not rely upon the state of ->s_umount and
        fc_drop_locked()
        put_fs_context()
is equivalent to
        unlock ->s_umount
        put_fs_context()

Doing vfs_create_mount() before the checks allows us to move vfs_get_tree()
from caller to do_new_mount_fc() and collapse it with vfs_create_mount()
into an fc_mount() call.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
index ae6d1312b184..9e1b7319532c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3721,25 +3721,19 @@ static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags
 static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 			   unsigned int mnt_flags)
 {
-	struct vfsmount *mnt;
 	struct pinned_mountpoint mp = {};
 	struct super_block *sb = fc->root->d_sb;
+	struct vfsmount *mnt = fc_mount(fc);
 	int error;
 
+	if (IS_ERR(mnt))
+		return PTR_ERR(mnt);
+
 	error = security_sb_kern_mount(sb);
 	if (!error && mount_too_revealing(sb, &mnt_flags))
 		error = -EPERM;
-
-	if (unlikely(error)) {
-		fc_drop_locked(fc);
-		return error;
-	}
-
-	up_write(&sb->s_umount);
-
-	mnt = vfs_create_mount(fc);
-	if (IS_ERR(mnt))
-		return PTR_ERR(mnt);
+	if (unlikely(error))
+		goto out;
 
 	mnt_warn_timestamp_expiry(mountpoint, mnt);
 
@@ -3747,10 +3741,12 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 	if (!error) {
 		error = do_add_mount(real_mount(mnt), mp.mp,
 				     mountpoint, mnt_flags);
+		if (!error)
+			mnt = NULL;	// consumed on success
 		unlock_mount(&mp);
 	}
-	if (error < 0)
-		mntput(mnt);
+out:
+	mntput(mnt);
 	return error;
 }
 
@@ -3804,8 +3800,6 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 		err = parse_monolithic_mount_data(fc, data);
 	if (!err && !mount_capable(fc))
 		err = -EPERM;
-	if (!err)
-		err = vfs_get_tree(fc);
 	if (!err)
 		err = do_new_mount_fc(fc, path, mnt_flags);
 

