Return-Path: <linux-fsdevel+bounces-67940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB09C4E5B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 15:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B15204F6992
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840E535B145;
	Tue, 11 Nov 2025 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2IoZNf1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB535A921;
	Tue, 11 Nov 2025 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870393; cv=none; b=jlqgP9fkfyDnVa/c8JBuZ0kwOqj1EfikrMd9qBduRiJTciJoC4CXCUihrEDvbuctHLV0O7KbzOkFoQ/506mG4sZrKd+MT3HhH9GfHWsmqQSIl/GDoDRzyEeKkVzxiGYwjjZYg7WmdmZuhWrxNRvh2+Fjgv5fuTFJPrMgbcCWDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870393; c=relaxed/simple;
	bh=V8Nctj73gICiDSGTb2wnqFhIueJ8IABmBKooNfcEfec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pT5gsCrs0cRhvKFlOTOhcTDMKzBlZaurnklPxBahCnUbm1QzdhOOXnCdVm2meJSvFkW9sneSqBXPgVPAWiAy5gDKqdbOifMvRhBny7S2zLMA8HiRWAvSG/JOImTJC6WO6ZvoxV6GpgX3hvvd9o0cGNKR8Yd9LdZN38p0jaZ4CrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2IoZNf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD6DC116D0;
	Tue, 11 Nov 2025 14:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762870393;
	bh=V8Nctj73gICiDSGTb2wnqFhIueJ8IABmBKooNfcEfec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p2IoZNf13l5ps724b3zns0BZfLCF5eNViK1cHQQBumZ7sMGUOYMe/y3MRMQ579SK9
	 BrvqXBXygUfVwQsX0QMJ8FDBp8hFOFW+2RBGkmGVyIVRTRCdQlVLC8r/Ea/xPa6DVR
	 n7YdeIQd+GGmO4dw2PUDl3vO0ED6g/F/rR59wg09hjNatPmI9oULI0YccUaJ6yQ9Wu
	 Iszprucy7kXz9x+BdF7uK9eA+jpZb4e+Ivy8k/HbV1n/dDCs+OouFGIhNDSBnC3MF0
	 0jUkukNGlSpQLIlEEYQ1zLQQLI1cQe6HQrnzZMh9TqyKJy/7RKRrFLuFSqhKTEDPuk
	 TrdPWaJAkQoWw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 11 Nov 2025 09:12:44 -0500
Subject: [PATCH v6 03/17] filelock: add struct delegated_inode
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-dir-deleg-ro-v6-3-52f3feebb2f2@kernel.org>
References: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
In-Reply-To: <20251111-dir-deleg-ro-v6-0-52f3feebb2f2@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org, 
 linux-api@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15568; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=V8Nctj73gICiDSGTb2wnqFhIueJ8IABmBKooNfcEfec=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpE0RnMDo9GVTOIBM785fQ6a32azk6JbnFc72yl
 LfZ7BCJ7IeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaRNEZwAKCRAADmhBGVaC
 FUWTD/wKuGcmP0b1noDMpt4/CI4QdpTJf0CAmBzKDey9/wUiBdso2A25zkFbzQ450g0Yr987qDs
 7/qvVA51DmSe8B778ucybvKD+cGv3KWDi+qSJNsp61t26c1vFtjIayDOlPY4/a7JqbkrNexY3zQ
 ENBA8kOjSZrkdlF42lxlsF9p0OQwaX+4irmbsJhIMSclOlrmGImVYHBP0AoTmevd9d9Nw4JazMe
 WYKS16pcnAFsg0IQgKyaFoiyt3/86FX7fhOdZqgsTPlqVG4LMiUng6BU1nUQx0lLPCtHy4PPsZV
 dfrNqMKWO8p2fcIxF/lf2eixmWYwO9usoLH9IcNU6IKBdqCw+di0Lrm28zujbfFYxZhbkVFuk7o
 L7ZOW/gWvyBrQ+32cOti6BnDN7v6gO3rn6dfNCZUZiR9J25LIzOOUnmSkz/c2m/EvBFsN//j8Kp
 12kR6kT2L9qDrRTEiXpYJHPdyLGzd3GH2JOBANxwavuSjEybamMKwZ3XPC4HaEkcDpm03gS/AUE
 C0t3M7fsaNn0bYjg+lLJIKG3gAKzpSxfQrh7GGbq9y2jyAjfO+tMCHyqKAmD7o6+6jXgy9Ni0B3
 izA0E1fsxGhrxchZ9JHvloVfPnDAb4M4+nGCKON1Vp83t181qu/r+xjUHAPa/Baxb8ZQkSQVhqD
 AEyCtxmhzmiByZw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The current API requires a pointer to an inode pointer. It's easy for
callers to get this wrong. Add a new delegated_inode structure and use
that to pass back any inode that needs to be waited on.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/attr.c                |  2 +-
 fs/namei.c               | 18 +++++++++---------
 fs/open.c                |  8 ++++----
 fs/posix_acl.c           |  8 ++++----
 fs/utimes.c              |  4 ++--
 fs/xattr.c               | 12 ++++++------
 include/linux/filelock.h | 36 +++++++++++++++++++++++++++---------
 include/linux/fs.h       |  9 +++++----
 include/linux/xattr.h    |  4 ++--
 9 files changed, 60 insertions(+), 41 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 795f231d00e8eaaadf5b62f241655cb4b69cb507..b9ec6b47bab2fc2b561677b639633bd32994022f 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -415,7 +415,7 @@ EXPORT_SYMBOL(may_setattr);
  * performed on the raw inode simply pass @nop_mnt_idmap.
  */
 int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
-		  struct iattr *attr, struct inode **delegated_inode)
+		  struct iattr *attr, struct delegated_inode *delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	umode_t mode = inode->i_mode;
diff --git a/fs/namei.c b/fs/namei.c
index 7377020a2cba02501483020e0fc93c279fb38d3e..bf42f146f847a5330fc581595c7256af28d9db90 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4648,7 +4648,7 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
  * raw inode simply pass @nop_mnt_idmap.
  */
 int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
-	       struct dentry *dentry, struct inode **delegated_inode)
+	       struct dentry *dentry, struct delegated_inode *delegated_inode)
 {
 	struct inode *target = dentry->d_inode;
 	int error = may_delete(idmap, dir, dentry, 0);
@@ -4706,7 +4706,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	struct qstr last;
 	int type;
 	struct inode *inode = NULL;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	unsigned int lookup_flags = 0;
 retry:
 	error = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
@@ -4743,7 +4743,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	if (inode)
 		iput(inode);	/* truncate the inode here */
 	inode = NULL;
-	if (delegated_inode) {
+	if (is_delegated(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
@@ -4892,7 +4892,7 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
  */
 int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 	     struct inode *dir, struct dentry *new_dentry,
-	     struct inode **delegated_inode)
+	     struct delegated_inode *delegated_inode)
 {
 	struct inode *inode = old_dentry->d_inode;
 	unsigned max_links = dir->i_sb->s_max_links;
@@ -4968,7 +4968,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	struct mnt_idmap *idmap;
 	struct dentry *new_dentry;
 	struct path old_path, new_path;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	int how = 0;
 	int error;
 
@@ -5012,7 +5012,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 			 new_dentry, &delegated_inode);
 out_dput:
 	end_creating_path(&new_path, new_dentry);
-	if (delegated_inode) {
+	if (is_delegated(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error) {
 			path_put(&old_path);
@@ -5098,7 +5098,7 @@ int vfs_rename(struct renamedata *rd)
 	struct inode *new_dir = d_inode(rd->new_parent);
 	struct dentry *old_dentry = rd->old_dentry;
 	struct dentry *new_dentry = rd->new_dentry;
-	struct inode **delegated_inode = rd->delegated_inode;
+	struct delegated_inode *delegated_inode = rd->delegated_inode;
 	unsigned int flags = rd->flags;
 	bool is_dir = d_is_dir(old_dentry);
 	struct inode *source = old_dentry->d_inode;
@@ -5261,7 +5261,7 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	struct path old_path, new_path;
 	struct qstr old_last, new_last;
 	int old_type, new_type;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	unsigned int lookup_flags = 0, target_flags =
 		LOOKUP_RENAME_TARGET | LOOKUP_CREATE;
 	bool should_retry = false;
@@ -5369,7 +5369,7 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 exit3:
 	unlock_rename(new_path.dentry, old_path.dentry);
 exit_lock_rename:
-	if (delegated_inode) {
+	if (is_delegated(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
diff --git a/fs/open.c b/fs/open.c
index 3d64372ecc675e4795eb0a0deda10f8f67b95640..fdaa6f08f6f4cac5c2fefd3eafa5e430e51f3979 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -631,7 +631,7 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
 int chmod_common(const struct path *path, umode_t mode)
 {
 	struct inode *inode = path->dentry->d_inode;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	struct iattr newattrs;
 	int error;
 
@@ -651,7 +651,7 @@ int chmod_common(const struct path *path, umode_t mode)
 			      &newattrs, &delegated_inode);
 out_unlock:
 	inode_unlock(inode);
-	if (delegated_inode) {
+	if (is_delegated(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
@@ -756,7 +756,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	struct mnt_idmap *idmap;
 	struct user_namespace *fs_userns;
 	struct inode *inode = path->dentry->d_inode;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	int error;
 	struct iattr newattrs;
 	kuid_t uid;
@@ -791,7 +791,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 		error = notify_change(idmap, path->dentry, &newattrs,
 				      &delegated_inode);
 	inode_unlock(inode);
-	if (delegated_inode) {
+	if (is_delegated(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 4050942ab52f95741da2df13d191ade5c5ca12a2..768f027c142811ea907fe8545155ba7abd016305 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1091,7 +1091,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	int acl_type;
 	int error;
 	struct inode *inode = d_inode(dentry);
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 
 	acl_type = posix_acl_type(acl_name);
 	if (acl_type < 0)
@@ -1141,7 +1141,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 out_inode_unlock:
 	inode_unlock(inode);
 
-	if (delegated_inode) {
+	if (is_delegated(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
@@ -1212,7 +1212,7 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	int acl_type;
 	int error;
 	struct inode *inode = d_inode(dentry);
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 
 	acl_type = posix_acl_type(acl_name);
 	if (acl_type < 0)
@@ -1249,7 +1249,7 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 out_inode_unlock:
 	inode_unlock(inode);
 
-	if (delegated_inode) {
+	if (is_delegated(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
diff --git a/fs/utimes.c b/fs/utimes.c
index c7c7958e57b22f91646ca9f76d18781b64d371a3..bf9f45bdef54947de7ac55c9f873ae9d0336dafa 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -22,7 +22,7 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
 	int error;
 	struct iattr newattrs;
 	struct inode *inode = path->dentry->d_inode;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 
 	if (times) {
 		if (!nsec_valid(times[0].tv_nsec) ||
@@ -66,7 +66,7 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
 	error = notify_change(mnt_idmap(path->mnt), path->dentry, &newattrs,
 			      &delegated_inode);
 	inode_unlock(inode);
-	if (delegated_inode) {
+	if (is_delegated(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
diff --git a/fs/xattr.c b/fs/xattr.c
index 8851a5ef34f5ab34383975dd4cef537de3f6391e..32d445fb60aaf2aaf4b16b62934dc99bad378067 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -274,7 +274,7 @@ int __vfs_setxattr_noperm(struct mnt_idmap *idmap,
 int
 __vfs_setxattr_locked(struct mnt_idmap *idmap, struct dentry *dentry,
 		      const char *name, const void *value, size_t size,
-		      int flags, struct inode **delegated_inode)
+		      int flags, struct delegated_inode *delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
@@ -305,7 +305,7 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	     const char *name, const void *value, size_t size, int flags)
 {
 	struct inode *inode = dentry->d_inode;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	const void  *orig_value = value;
 	int error;
 
@@ -322,7 +322,7 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 				      flags, &delegated_inode);
 	inode_unlock(inode);
 
-	if (delegated_inode) {
+	if (is_delegated(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
@@ -533,7 +533,7 @@ EXPORT_SYMBOL(__vfs_removexattr);
 int
 __vfs_removexattr_locked(struct mnt_idmap *idmap,
 			 struct dentry *dentry, const char *name,
-			 struct inode **delegated_inode)
+			 struct delegated_inode *delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
@@ -567,7 +567,7 @@ vfs_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		const char *name)
 {
 	struct inode *inode = dentry->d_inode;
-	struct inode *delegated_inode = NULL;
+	struct delegated_inode delegated_inode = { };
 	int error;
 
 retry_deleg:
@@ -576,7 +576,7 @@ vfs_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
 					 name, &delegated_inode);
 	inode_unlock(inode);
 
-	if (delegated_inode) {
+	if (is_delegated(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
 			goto retry_deleg;
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 47da6aa28d8dc9122618d02c6608deda0f3c4d3e..208d108df2d73a9df65e5dc9968d074af385f881 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -486,25 +486,35 @@ static inline int break_deleg(struct inode *inode, unsigned int flags)
 	return 0;
 }
 
-static inline int try_break_deleg(struct inode *inode, struct inode **delegated_inode)
+struct delegated_inode {
+	struct inode *di_inode;
+};
+
+static inline bool is_delegated(struct delegated_inode *di)
+{
+	return di->di_inode;
+}
+
+static inline int try_break_deleg(struct inode *inode,
+				  struct delegated_inode *di)
 {
 	int ret;
 
 	ret = break_deleg(inode, LEASE_BREAK_NONBLOCK);
-	if (ret == -EWOULDBLOCK && delegated_inode) {
-		*delegated_inode = inode;
+	if (ret == -EWOULDBLOCK && di) {
+		di->di_inode = inode;
 		ihold(inode);
 	}
 	return ret;
 }
 
-static inline int break_deleg_wait(struct inode **delegated_inode)
+static inline int break_deleg_wait(struct delegated_inode *di)
 {
 	int ret;
 
-	ret = break_deleg(*delegated_inode, 0);
-	iput(*delegated_inode);
-	*delegated_inode = NULL;
+	ret = break_deleg(di->di_inode, 0);
+	iput(di->di_inode);
+	di->di_inode = NULL;
 	return ret;
 }
 
@@ -523,6 +533,13 @@ static inline int break_layout(struct inode *inode, bool wait)
 }
 
 #else /* !CONFIG_FILE_LOCKING */
+struct delegated_inode { };
+
+static inline bool is_delegated(struct delegated_inode *di)
+{
+	return false;
+}
+
 static inline int break_lease(struct inode *inode, bool wait)
 {
 	return 0;
@@ -533,12 +550,13 @@ static inline int break_deleg(struct inode *inode, unsigned int flags)
 	return 0;
 }
 
-static inline int try_break_deleg(struct inode *inode, struct inode **delegated_inode)
+static inline int try_break_deleg(struct inode *inode,
+				  struct delegated_inode *delegated_inode)
 {
 	return 0;
 }
 
-static inline int break_deleg_wait(struct inode **delegated_inode)
+static inline int break_deleg_wait(struct delegated_inode *delegated_inode)
 {
 	BUG();
 	return 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444be36e0a779df55622cc38c9419ff..909a88e3979d4f1ba3104f3d05145e1096ed44d5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -80,6 +80,7 @@ struct fs_context;
 struct fs_parameter_spec;
 struct file_kattr;
 struct iomap_ops;
+struct delegated_inode;
 
 extern void __init inode_init(void);
 extern void __init inode_init_early(void);
@@ -2119,10 +2120,10 @@ int vfs_mknod(struct mnt_idmap *, struct inode *, struct dentry *,
 int vfs_symlink(struct mnt_idmap *, struct inode *,
 		struct dentry *, const char *);
 int vfs_link(struct dentry *, struct mnt_idmap *, struct inode *,
-	     struct dentry *, struct inode **);
+	     struct dentry *, struct delegated_inode *);
 int vfs_rmdir(struct mnt_idmap *, struct inode *, struct dentry *);
 int vfs_unlink(struct mnt_idmap *, struct inode *, struct dentry *,
-	       struct inode **);
+	       struct delegated_inode *);
 
 /**
  * struct renamedata - contains all information required for renaming
@@ -2140,7 +2141,7 @@ struct renamedata {
 	struct dentry *old_dentry;
 	struct dentry *new_parent;
 	struct dentry *new_dentry;
-	struct inode **delegated_inode;
+	struct delegated_inode *delegated_inode;
 	unsigned int flags;
 } __randomize_layout;
 
@@ -3071,7 +3072,7 @@ static inline int bmap(struct inode *inode,  sector_t *block)
 #endif
 
 int notify_change(struct mnt_idmap *, struct dentry *,
-		  struct iattr *, struct inode **);
+		  struct iattr *, struct delegated_inode *);
 int inode_permission(struct mnt_idmap *, struct inode *, int);
 int generic_permission(struct mnt_idmap *, struct inode *, int);
 static inline int file_permission(struct file *file, int mask)
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 86b0d47984a16d935dd1c45ca80a3b8bb5b7295b..64e9afe7d647dc38f686a4b5c6f765e061cde54c 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -85,12 +85,12 @@ int __vfs_setxattr_noperm(struct mnt_idmap *, struct dentry *,
 			  const char *, const void *, size_t, int);
 int __vfs_setxattr_locked(struct mnt_idmap *, struct dentry *,
 			  const char *, const void *, size_t, int,
-			  struct inode **);
+			  struct delegated_inode *);
 int vfs_setxattr(struct mnt_idmap *, struct dentry *, const char *,
 		 const void *, size_t, int);
 int __vfs_removexattr(struct mnt_idmap *, struct dentry *, const char *);
 int __vfs_removexattr_locked(struct mnt_idmap *, struct dentry *,
-			     const char *, struct inode **);
+			     const char *, struct delegated_inode *);
 int vfs_removexattr(struct mnt_idmap *, struct dentry *, const char *);
 
 ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);

-- 
2.51.1


