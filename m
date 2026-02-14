Return-Path: <linux-fsdevel+bounces-77214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCLXCSGdkGmYbgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 17:04:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9669113C66D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 17:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B19EB3014413
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 15:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A285930DEB0;
	Sat, 14 Feb 2026 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0P4TDZ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1596630C370;
	Sat, 14 Feb 2026 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771084756; cv=none; b=KqSvwTug5irgcSsq5Lic50sWodhvGnsywdYVWXg1rVPTtSYeqWYGXwO6s7t/8alAG++6J2wVmsJbxJwds9ftGRYLp0shAFPjIzF7ytkQLu2zVODZJ17xqc6e2G3+KbghftYUdofYx3xrMMwNjZgHUIVPwp9MDS6RDg1JuTLUOxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771084756; c=relaxed/simple;
	bh=/TgtQ0RLP/sm9kV0I2QWiFEuBI2aORjZSDyPV6hdZ5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwTvocJNHm3H5ngGdVjshlUuha9eeORIx2BP+1Z0yPW2roNCiqsXM7D6Tqqb483S9qKy8fQJRy0teCLtjVrTwM96Wss/nfu4keuA1hjb8AMlb6fjr2reLV8IbyN+lcLwmscdyRQMROeSp+JZE3Bt4oUCejuN+p/rGL/boxQ7iGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0P4TDZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088F0C16AAE;
	Sat, 14 Feb 2026 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771084755;
	bh=/TgtQ0RLP/sm9kV0I2QWiFEuBI2aORjZSDyPV6hdZ5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0P4TDZ1sx1OdqDNxLoxpWmIIVL3NNc7i6OA9iBsYjTmlYVUBRRTmiI/FuZhWixo4
	 p83AAAj4qa4+Ywev31m9GyO1noKPV6ctu03JnHKZz63Y4WNXSj/q3GLJ189EDnYbQq
	 stjfU7atmu0jdq+JHqAtOXowDtkZzCmUkIYQyOKTtWvdmKX3OoITXPfyVogBpZ6uIl
	 HWMJ9jkp6gN8Geg+nngwj+MU2g0SkO9RMIZF/VcDCxEFRCO93V7M/wS0hhMgY42R4H
	 RRwUo9UmW6AX/oc/uxBYdAeRf+/Go+nDTxS71zNNmwZ1FR+orYlsoa3veDL68hR7i3
	 Uc1tdWPnx235w==
Date: Sat, 14 Feb 2026 16:59:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+a89f9434fb5a001ccd58@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in clone_mnt
Message-ID: <20260214-werft-vorerst-0b3bf9610224@brauner>
References: <699047f6.050a0220.2757fb.0024.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mmw32roaduaocuzj"
Content-Disposition: inline
In-Reply-To: <699047f6.050a0220.2757fb.0024.GAE@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6428d17febdfb14e];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77214-lists,linux-fsdevel=lfdr.de];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,storage.googleapis.com:url];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel,a89f9434fb5a001ccd58];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 9669113C66D
X-Rspamd-Action: no action


--mmw32roaduaocuzj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sat, Feb 14, 2026 at 02:01:26AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c22e26bd0906 Merge tag 'landlock-7.0-rc1' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12c6a6e6580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6428d17febdfb14e
> dashboard link: https://syzkaller.appspot.com/bug?extid=a89f9434fb5a001ccd58
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b33c549157ca/disk-c22e26bd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/34c7ded19553/vmlinux-c22e26bd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/66faec2158ed/bzImage-c22e26bd.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a89f9434fb5a001ccd58@syzkaller.appspotmail.com

Right, this should be fixed by the appended patch. If someone had the
bright idea to make the real rootfs a shared or dependent mount and it
is later copied the copy will become a peer of the old real rootfs mount
or a dependent mount of it. If locking the new rootfs mount for mounting
fails or the subsequent do_loopback() fails we rely on the copy of the
real root mount to be cleaned up by path_put(). The problem is that this
doesn't deal with mount propagation and will leave the mounts linked in
the propagation lists. Fix this by actually unmounting the copied tree.



--mmw32roaduaocuzj
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mount-unmount-copied-tree.patch"

From 3b3dc6a956af1afc6b95c68550b99083d47ce5fa Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 14 Feb 2026 16:22:13 +0100
Subject: [PATCH] mount: unmount copied tree

Fix an oversight when creating a new mount namespace. If someone had the
bright idea to make the real rootfs a shared or dependent mount and it
is later copied the copy will become a peer of the old real rootfs mount
or a dependent mount of it. The namespace semaphore is dropped and we
use mount lock exact to lock the new real root mount. If that fails or
the subsequent do_loopback() fails we rely on the copy of the real root
mount to be cleaned up by path_put(). The problem is that this doesn't
deal with mount propagation and will leave the mounts linked in the
propagation lists. Fix this by actually unmounting the copied tree.

Reported-by: syzbot+a89f9434fb5a001ccd58@syzkaller.appspotmail.com
Link: https:/lore.kernel.org/699047f6.050a0220.2757fb.0024.GAE@google.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a67cbe42746d..89cac95e6c9b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3073,16 +3073,13 @@ static struct file *open_detached_copy(struct path *path, unsigned int flags)
 	return file;
 }
 
-DEFINE_FREE(put_empty_mnt_ns, struct mnt_namespace *,
-	    if (!IS_ERR_OR_NULL(_T)) free_mnt_ns(_T))
-
 static struct mnt_namespace *create_new_namespace(struct path *path, unsigned int flags)
 {
-	struct mnt_namespace *new_ns __free(put_empty_mnt_ns) = NULL;
-	struct path to_path __free(path_put) = {};
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	struct user_namespace *user_ns = current_user_ns();
+	struct mnt_namespace *new_ns;
 	struct mount *new_ns_root;
+	struct path to_path;
 	struct mount *mnt;
 	unsigned int copy_flags = 0;
 	bool locked = false;
@@ -3096,8 +3093,10 @@ static struct mnt_namespace *create_new_namespace(struct path *path, unsigned in
 
 	scoped_guard(namespace_excl) {
 		new_ns_root = clone_mnt(ns->root, ns->root->mnt.mnt_root, copy_flags);
-		if (IS_ERR(new_ns_root))
+		if (IS_ERR(new_ns_root)) {
+			emptied_ns = new_ns;
 			return ERR_CAST(new_ns_root);
+		}
 
 		/*
 		 * If the real rootfs had a locked mount on top of it somewhere
@@ -3122,12 +3121,17 @@ static struct mnt_namespace *create_new_namespace(struct path *path, unsigned in
 
 	/* Borrow the reference from clone_mnt(). */
 	to_path.mnt = &new_ns_root->mnt;
-	to_path.dentry = dget(new_ns_root->mnt.mnt_root);
+	to_path.dentry = new_ns_root->mnt.mnt_root;
 
 	/* Now lock for actual mounting. */
 	LOCK_MOUNT_EXACT(mp, &to_path);
-	if (unlikely(IS_ERR(mp.parent)))
+	if (unlikely(IS_ERR(mp.parent))) {
+		guard(namespace_excl)();
+		emptied_ns = new_ns;
+		guard(mount_writer)();
+		umount_tree(new_ns_root, 0);
 		return ERR_CAST(mp.parent);
+	}
 
 	/*
 	 * We don't emulate unshare()ing a mount namespace. We stick to the
@@ -3135,10 +3139,13 @@ static struct mnt_namespace *create_new_namespace(struct path *path, unsigned in
 	 * saner and simpler semantics.
 	 */
 	mnt = __do_loopback(path, flags, copy_flags);
-	if (IS_ERR(mnt))
-		return ERR_CAST(mnt);
-
 	scoped_guard(mount_writer) {
+		if (IS_ERR(mnt)) {
+			emptied_ns = new_ns;
+			umount_tree(new_ns_root, 0);
+			return ERR_CAST(mnt);
+		}
+
 		if (locked)
 			mnt->mnt.mnt_flags |= MNT_LOCKED;
 		/*
@@ -3151,14 +3158,14 @@ static struct mnt_namespace *create_new_namespace(struct path *path, unsigned in
 	}
 
 	/* Add all mounts to the new namespace. */
-	for (struct mount *p = new_ns_root; p; p = next_mnt(p, new_ns_root)) {
-		mnt_add_to_ns(new_ns, p);
+	for (mnt = new_ns_root; mnt; mnt = next_mnt(mnt, new_ns_root)) {
+		mnt_add_to_ns(new_ns, mnt);
 		new_ns->nr_mounts++;
 	}
 
-	new_ns->root = real_mount(no_free_ptr(to_path.mnt));
+	new_ns->root = real_mount(to_path.mnt);
 	ns_tree_add_raw(new_ns);
-	return no_free_ptr(new_ns);
+	return new_ns;
 }
 
 static struct file *open_new_namespace(struct path *path, unsigned int flags)
-- 
2.47.3


--mmw32roaduaocuzj--

