Return-Path: <linux-fsdevel+bounces-8098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8643282F728
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829D81C24714
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CB974E2A;
	Tue, 16 Jan 2024 19:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiK+Axk0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839B219EE;
	Tue, 16 Jan 2024 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434419; cv=none; b=dowaGwDE382/86l2cw7O9XFHIsKQiykwyDZXKWiFdvxNcR3dqIAB7xNxBEhWb8iUo3SQIPMCjA9ZEkoQLsFKkM9b/f0eJyQeTsU0wHKQiA1GmspU5lfLkCrR5+/k7sQIA0lhV33jVYP12xs0ur+UGEIn9LpP5/pfjI3ASJoER3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434419; c=relaxed/simple;
	bh=UKZeng0Nh2Cr7vAO5ryEXgk+B53t1tD85GbEEkjKp9w=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=RixBnjL6Rax7eKckeItYRIPQN75cgu7flDJW+ikAvdBHPGKnKcMCi1+I2PheIG8ESNeVH8b/rYDgqjUzyVkR/QhcGqQ65kxG9DMT64mkrE7lPmlRA5OLk29saG2ovIYrKrUxD8s+aLe/Xbvj6xxArWVwm/t1UXLDKOVmur8aGj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiK+Axk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE13CC43143;
	Tue, 16 Jan 2024 19:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434418;
	bh=UKZeng0Nh2Cr7vAO5ryEXgk+B53t1tD85GbEEkjKp9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fiK+Axk0A5N6AHHN8dtKlXeZHW3WlaWVYQNQWG79KzoyNKI7CNBT+SLopvZSAdY1+
	 Dv+GnfiTwJ/uO255UgQGt2tSApcWQlDrUgD2vIANrP885aUVIQ/6tYVI8M0i2xciYs
	 P6XZiz5fKZZPjUCr7E6avzJ6aCQr9fLT8iJVxBYh2rskZ+P8coikIHVjj2/oRE9aqr
	 oNapnPX4R4+H1g2xiiXXn/3dqGpQDsJmSzGbc6xEcb2SOQCShKKsNKbk6yyZsuqDbr
	 NQ1KKJGq/p3uot4YDOmfYYFWGN/ara/Vd6IXF6mutx7jSxBleu/XOW9Uf83+XoBpgt
	 Tlpl8shGN7Uvg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:45:59 -0500
Subject: [PATCH 03/20] filelock: the results of the coccinelle conversion
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-3-c9d0f4370a5d@kernel.org>
References: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>
In-Reply-To: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Jan Kara <jack@suse.cz>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <lsahlber@redhat.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=130147; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=UKZeng0Nh2Cr7vAO5ryEXgk+B53t1tD85GbEEkjKp9w=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0g1I5RRVtSH5LaL+3YeZmRc8zn3uZMjW8kv
 4tJF/Irvw+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIAAKCRAADmhBGVaC
 FZGFD/9eJWsfaX4VYoXmsWQb4ocgMxOb0zljXBwXbTqNxxcrd4S7dNUQ1Byoz20/5Fq2WShpPL9
 8PMdh5auVL6+VeQ7ncTyuYhedj71U9ZEYcsQMH8Vt8EMAdOmdyknyj/BZqR447u4az839cgCpqE
 MciWuDyLdrM1zST0IO7qeBxHXEf4Oz/bXxahZPC7/VFR5gwyiGKv1/j1RaFRw6PEWrcjs2900it
 fM85eKuBbASG1/nlTCFSROAYmhOESBlZelb7O1hl4xWNGnZH0KQAPp3TuGMPWCTOY47c6rB8EpH
 y6u1etU+/Sl6QsszFUvMqJ4fwdD1LaJ1A8Fk4gjH5moiu1GHqbWx4Z+Wifze8AHmGbnW4dA9BfP
 fy+6Ffgve71MaR/47Rz1nZUljLtnpEJZIbeiW8rIDPDzoteELYyK3SOT1hDh9VSRwPk5rUSLO7t
 xf2RKqmIhOYFc89LTD4gizh+fk6buYuvxtbblH0qmnz0R3SjGke4EVAotTp12/VTJTOGSuemXHq
 k6R3bilc/k9gFT8/wQ1UqmzuaIPSHiPiFGPC4AJ2M53lqAZHN/z81mHzxv7BSYD+E8eHUPtYy+X
 kw1jTKURV/s761b3/gHUyCgmdiA8AtSBP04GpP/x6HPM2o7DRmFoDc+WWqYw/MmrW6YbSosqyjF
 zZVZeCn4MQlJY4A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This is the direct result of the changes generated by coccinelle. There
is still about 1/4 of the callsites that need to be touched by hand
here.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/9p/vfs_file.c            |  38 ++---
 fs/afs/flock.c              |  55 +++---
 fs/ceph/locks.c             |  66 +++----
 fs/dlm/plock.c              |  44 ++---
 fs/fuse/file.c              |  14 +-
 fs/gfs2/file.c              |  16 +-
 fs/lockd/clnt4xdr.c         |   6 +-
 fs/lockd/clntlock.c         |   2 +-
 fs/lockd/clntproc.c         |  60 ++++---
 fs/lockd/clntxdr.c          |   6 +-
 fs/lockd/svclock.c          |  10 +-
 fs/lockd/svcsubs.c          |  20 +--
 fs/lockd/xdr.c              |   6 +-
 fs/lockd/xdr4.c             |   6 +-
 fs/locks.c                  | 406 +++++++++++++++++++++++---------------------
 fs/nfs/delegation.c         |   2 +-
 fs/nfs/file.c               |  22 +--
 fs/nfs/nfs3proc.c           |   2 +-
 fs/nfs/nfs4proc.c           |  35 ++--
 fs/nfs/nfs4state.c          |   4 +-
 fs/nfs/nfs4xdr.c            |   8 +-
 fs/nfs/write.c              |   4 +-
 fs/nfsd/filecache.c         |   4 +-
 fs/nfsd/nfs4layouts.c       |  15 +-
 fs/nfsd/nfs4state.c         |  73 ++++----
 fs/ocfs2/locks.c            |  12 +-
 fs/ocfs2/stack_user.c       |   2 +-
 fs/smb/client/cifssmb.c     |   8 +-
 fs/smb/client/file.c        |  72 ++++----
 fs/smb/client/smb2file.c    |   2 +-
 fs/smb/server/smb2pdu.c     |  44 ++---
 fs/smb/server/vfs.c         |  12 +-
 include/linux/lockd/lockd.h |   8 +-
 33 files changed, 554 insertions(+), 530 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 11cd8d23f6f2..f35ac7cb782e 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -107,7 +107,7 @@ static int v9fs_file_lock(struct file *filp, int cmd, struct file_lock *fl)
 
 	p9_debug(P9_DEBUG_VFS, "filp: %p lock: %p\n", filp, fl);
 
-	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
+	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_core.fl_type != F_UNLCK) {
 		filemap_write_and_wait(inode->i_mapping);
 		invalidate_mapping_pages(&inode->i_data, 0, -1);
 	}
@@ -127,7 +127,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	fid = filp->private_data;
 	BUG_ON(fid == NULL);
 
-	BUG_ON((fl->fl_flags & FL_POSIX) != FL_POSIX);
+	BUG_ON((fl->fl_core.fl_flags & FL_POSIX) != FL_POSIX);
 
 	res = locks_lock_file_wait(filp, fl);
 	if (res < 0)
@@ -136,7 +136,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	/* convert posix lock to p9 tlock args */
 	memset(&flock, 0, sizeof(flock));
 	/* map the lock type */
-	switch (fl->fl_type) {
+	switch (fl->fl_core.fl_type) {
 	case F_RDLCK:
 		flock.type = P9_LOCK_TYPE_RDLCK;
 		break;
@@ -152,7 +152,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 		flock.length = 0;
 	else
 		flock.length = fl->fl_end - fl->fl_start + 1;
-	flock.proc_id = fl->fl_pid;
+	flock.proc_id = fl->fl_core.fl_pid;
 	flock.client_id = fid->clnt->name;
 	if (IS_SETLKW(cmd))
 		flock.flags = P9_LOCK_FLAGS_BLOCK;
@@ -207,12 +207,12 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	 * incase server returned error for lock request, revert
 	 * it locally
 	 */
-	if (res < 0 && fl->fl_type != F_UNLCK) {
-		fl_type = fl->fl_type;
-		fl->fl_type = F_UNLCK;
+	if (res < 0 && fl->fl_core.fl_type != F_UNLCK) {
+		fl_type = fl->fl_core.fl_type;
+		fl->fl_core.fl_type = F_UNLCK;
 		/* Even if this fails we want to return the remote error */
 		locks_lock_file_wait(filp, fl);
-		fl->fl_type = fl_type;
+		fl->fl_core.fl_type = fl_type;
 	}
 	if (flock.client_id != fid->clnt->name)
 		kfree(flock.client_id);
@@ -234,7 +234,7 @@ static int v9fs_file_getlock(struct file *filp, struct file_lock *fl)
 	 * if we have a conflicting lock locally, no need to validate
 	 * with server
 	 */
-	if (fl->fl_type != F_UNLCK)
+	if (fl->fl_core.fl_type != F_UNLCK)
 		return res;
 
 	/* convert posix lock to p9 tgetlock args */
@@ -245,7 +245,7 @@ static int v9fs_file_getlock(struct file *filp, struct file_lock *fl)
 		glock.length = 0;
 	else
 		glock.length = fl->fl_end - fl->fl_start + 1;
-	glock.proc_id = fl->fl_pid;
+	glock.proc_id = fl->fl_core.fl_pid;
 	glock.client_id = fid->clnt->name;
 
 	res = p9_client_getlock_dotl(fid, &glock);
@@ -254,13 +254,13 @@ static int v9fs_file_getlock(struct file *filp, struct file_lock *fl)
 	/* map 9p lock type to os lock type */
 	switch (glock.type) {
 	case P9_LOCK_TYPE_RDLCK:
-		fl->fl_type = F_RDLCK;
+		fl->fl_core.fl_type = F_RDLCK;
 		break;
 	case P9_LOCK_TYPE_WRLCK:
-		fl->fl_type = F_WRLCK;
+		fl->fl_core.fl_type = F_WRLCK;
 		break;
 	case P9_LOCK_TYPE_UNLCK:
-		fl->fl_type = F_UNLCK;
+		fl->fl_core.fl_type = F_UNLCK;
 		break;
 	}
 	if (glock.type != P9_LOCK_TYPE_UNLCK) {
@@ -269,7 +269,7 @@ static int v9fs_file_getlock(struct file *filp, struct file_lock *fl)
 			fl->fl_end = OFFSET_MAX;
 		else
 			fl->fl_end = glock.start + glock.length - 1;
-		fl->fl_pid = -glock.proc_id;
+		fl->fl_core.fl_pid = -glock.proc_id;
 	}
 out:
 	if (glock.client_id != fid->clnt->name)
@@ -293,7 +293,7 @@ static int v9fs_file_lock_dotl(struct file *filp, int cmd, struct file_lock *fl)
 	p9_debug(P9_DEBUG_VFS, "filp: %p cmd:%d lock: %p name: %pD\n",
 		 filp, cmd, fl, filp);
 
-	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
+	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_core.fl_type != F_UNLCK) {
 		filemap_write_and_wait(inode->i_mapping);
 		invalidate_mapping_pages(&inode->i_data, 0, -1);
 	}
@@ -324,16 +324,16 @@ static int v9fs_file_flock_dotl(struct file *filp, int cmd,
 	p9_debug(P9_DEBUG_VFS, "filp: %p cmd:%d lock: %p name: %pD\n",
 		 filp, cmd, fl, filp);
 
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->fl_core.fl_flags & FL_FLOCK))
 		goto out_err;
 
-	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
+	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_core.fl_type != F_UNLCK) {
 		filemap_write_and_wait(inode->i_mapping);
 		invalidate_mapping_pages(&inode->i_data, 0, -1);
 	}
 	/* Convert flock to posix lock */
-	fl->fl_flags |= FL_POSIX;
-	fl->fl_flags ^= FL_FLOCK;
+	fl->fl_core.fl_flags |= FL_POSIX;
+	fl->fl_core.fl_flags ^= FL_FLOCK;
 
 	if (IS_SETLK(cmd) | IS_SETLKW(cmd))
 		ret = v9fs_file_do_lock(filp, cmd, fl);
diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 9c6dea3139f5..212cca72c061 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -93,13 +93,13 @@ static void afs_grant_locks(struct afs_vnode *vnode)
 	bool exclusive = (vnode->lock_type == AFS_LOCK_WRITE);
 
 	list_for_each_entry_safe(p, _p, &vnode->pending_locks, fl_u.afs.link) {
-		if (!exclusive && p->fl_type == F_WRLCK)
+		if (!exclusive && p->fl_core.fl_type == F_WRLCK)
 			continue;
 
 		list_move_tail(&p->fl_u.afs.link, &vnode->granted_locks);
 		p->fl_u.afs.state = AFS_LOCK_GRANTED;
 		trace_afs_flock_op(vnode, p, afs_flock_op_grant);
-		wake_up(&p->fl_wait);
+		wake_up(&p->fl_core.fl_wait);
 	}
 }
 
@@ -121,16 +121,16 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
 
 	list_for_each_entry_safe(p, _p, &vnode->pending_locks, fl_u.afs.link) {
 		if (error &&
-		    p->fl_type == fl_type &&
-		    afs_file_key(p->fl_file) == key) {
+		    p->fl_core.fl_type == fl_type &&
+		    afs_file_key(p->fl_core.fl_file) == key) {
 			list_del_init(&p->fl_u.afs.link);
 			p->fl_u.afs.state = error;
-			wake_up(&p->fl_wait);
+			wake_up(&p->fl_core.fl_wait);
 		}
 
 		/* Select the next locker to hand off to. */
 		if (next &&
-		    (next->fl_type == F_WRLCK || p->fl_type == F_RDLCK))
+		    (next->fl_core.fl_type == F_WRLCK || p->fl_core.fl_type == F_RDLCK))
 			continue;
 		next = p;
 	}
@@ -142,7 +142,7 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
 		afs_set_lock_state(vnode, AFS_VNODE_LOCK_SETTING);
 		next->fl_u.afs.state = AFS_LOCK_YOUR_TRY;
 		trace_afs_flock_op(vnode, next, afs_flock_op_wake);
-		wake_up(&next->fl_wait);
+		wake_up(&next->fl_core.fl_wait);
 	} else {
 		afs_set_lock_state(vnode, AFS_VNODE_LOCK_NONE);
 		trace_afs_flock_ev(vnode, NULL, afs_flock_no_lockers, 0);
@@ -166,7 +166,7 @@ static void afs_kill_lockers_enoent(struct afs_vnode *vnode)
 			       struct file_lock, fl_u.afs.link);
 		list_del_init(&p->fl_u.afs.link);
 		p->fl_u.afs.state = -ENOENT;
-		wake_up(&p->fl_wait);
+		wake_up(&p->fl_core.fl_wait);
 	}
 
 	key_put(vnode->lock_key);
@@ -464,14 +464,14 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 
 	_enter("{%llx:%llu},%llu-%llu,%u,%u",
 	       vnode->fid.vid, vnode->fid.vnode,
-	       fl->fl_start, fl->fl_end, fl->fl_type, mode);
+	       fl->fl_start, fl->fl_end, fl->fl_core.fl_type, mode);
 
 	fl->fl_ops = &afs_lock_ops;
 	INIT_LIST_HEAD(&fl->fl_u.afs.link);
 	fl->fl_u.afs.state = AFS_LOCK_PENDING;
 
 	partial = (fl->fl_start != 0 || fl->fl_end != OFFSET_MAX);
-	type = (fl->fl_type == F_RDLCK) ? AFS_LOCK_READ : AFS_LOCK_WRITE;
+	type = (fl->fl_core.fl_type == F_RDLCK) ? AFS_LOCK_READ : AFS_LOCK_WRITE;
 	if (mode == afs_flock_mode_write && partial)
 		type = AFS_LOCK_WRITE;
 
@@ -524,7 +524,7 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	}
 
 	if (vnode->lock_state == AFS_VNODE_LOCK_NONE &&
-	    !(fl->fl_flags & FL_SLEEP)) {
+	    !(fl->fl_core.fl_flags & FL_SLEEP)) {
 		ret = -EAGAIN;
 		if (type == AFS_LOCK_READ) {
 			if (vnode->status.lock_count == -1)
@@ -621,7 +621,7 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	return 0;
 
 lock_is_contended:
-	if (!(fl->fl_flags & FL_SLEEP)) {
+	if (!(fl->fl_core.fl_flags & FL_SLEEP)) {
 		list_del_init(&fl->fl_u.afs.link);
 		afs_next_locker(vnode, 0);
 		ret = -EAGAIN;
@@ -641,7 +641,7 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	spin_unlock(&vnode->lock);
 
 	trace_afs_flock_ev(vnode, fl, afs_flock_waiting, 0);
-	ret = wait_event_interruptible(fl->fl_wait,
+	ret = wait_event_interruptible(fl->fl_core.fl_wait,
 				       fl->fl_u.afs.state != AFS_LOCK_PENDING);
 	trace_afs_flock_ev(vnode, fl, afs_flock_waited, ret);
 
@@ -704,7 +704,8 @@ static int afs_do_unlk(struct file *file, struct file_lock *fl)
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	int ret;
 
-	_enter("{%llx:%llu},%u", vnode->fid.vid, vnode->fid.vnode, fl->fl_type);
+	_enter("{%llx:%llu},%u", vnode->fid.vid, vnode->fid.vnode,
+	       fl->fl_core.fl_type);
 
 	trace_afs_flock_op(vnode, fl, afs_flock_op_unlock);
 
@@ -730,11 +731,11 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
 	if (vnode->lock_state == AFS_VNODE_LOCK_DELETED)
 		return -ENOENT;
 
-	fl->fl_type = F_UNLCK;
+	fl->fl_core.fl_type = F_UNLCK;
 
 	/* check local lock records first */
 	posix_test_lock(file, fl);
-	if (fl->fl_type == F_UNLCK) {
+	if (fl->fl_core.fl_type == F_UNLCK) {
 		/* no local locks; consult the server */
 		ret = afs_fetch_status(vnode, key, false, NULL);
 		if (ret < 0)
@@ -743,18 +744,18 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
 		lock_count = READ_ONCE(vnode->status.lock_count);
 		if (lock_count != 0) {
 			if (lock_count > 0)
-				fl->fl_type = F_RDLCK;
+				fl->fl_core.fl_type = F_RDLCK;
 			else
-				fl->fl_type = F_WRLCK;
+				fl->fl_core.fl_type = F_WRLCK;
 			fl->fl_start = 0;
 			fl->fl_end = OFFSET_MAX;
-			fl->fl_pid = 0;
+			fl->fl_core.fl_pid = 0;
 		}
 	}
 
 	ret = 0;
 error:
-	_leave(" = %d [%hd]", ret, fl->fl_type);
+	_leave(" = %d [%hd]", ret, fl->fl_core.fl_type);
 	return ret;
 }
 
@@ -769,7 +770,7 @@ int afs_lock(struct file *file, int cmd, struct file_lock *fl)
 
 	_enter("{%llx:%llu},%d,{t=%x,fl=%x,r=%Ld:%Ld}",
 	       vnode->fid.vid, vnode->fid.vnode, cmd,
-	       fl->fl_type, fl->fl_flags,
+	       fl->fl_core.fl_type, fl->fl_core.fl_flags,
 	       (long long) fl->fl_start, (long long) fl->fl_end);
 
 	if (IS_GETLK(cmd))
@@ -778,7 +779,7 @@ int afs_lock(struct file *file, int cmd, struct file_lock *fl)
 	fl->fl_u.afs.debug_id = atomic_inc_return(&afs_file_lock_debug_id);
 	trace_afs_flock_op(vnode, fl, afs_flock_op_lock);
 
-	if (fl->fl_type == F_UNLCK)
+	if (fl->fl_core.fl_type == F_UNLCK)
 		ret = afs_do_unlk(file, fl);
 	else
 		ret = afs_do_setlk(file, fl);
@@ -804,7 +805,7 @@ int afs_flock(struct file *file, int cmd, struct file_lock *fl)
 
 	_enter("{%llx:%llu},%d,{t=%x,fl=%x}",
 	       vnode->fid.vid, vnode->fid.vnode, cmd,
-	       fl->fl_type, fl->fl_flags);
+	       fl->fl_core.fl_type, fl->fl_core.fl_flags);
 
 	/*
 	 * No BSD flocks over NFS allowed.
@@ -813,14 +814,14 @@ int afs_flock(struct file *file, int cmd, struct file_lock *fl)
 	 * Not sure whether that would be unique, though, or whether
 	 * that would break in other places.
 	 */
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->fl_core.fl_flags & FL_FLOCK))
 		return -ENOLCK;
 
 	fl->fl_u.afs.debug_id = atomic_inc_return(&afs_file_lock_debug_id);
 	trace_afs_flock_op(vnode, fl, afs_flock_op_flock);
 
 	/* we're simulating flock() locks using posix locks on the server */
-	if (fl->fl_type == F_UNLCK)
+	if (fl->fl_core.fl_type == F_UNLCK)
 		ret = afs_do_unlk(file, fl);
 	else
 		ret = afs_do_setlk(file, fl);
@@ -843,7 +844,7 @@ int afs_flock(struct file *file, int cmd, struct file_lock *fl)
  */
 static void afs_fl_copy_lock(struct file_lock *new, struct file_lock *fl)
 {
-	struct afs_vnode *vnode = AFS_FS_I(file_inode(fl->fl_file));
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(fl->fl_core.fl_file));
 
 	_enter("");
 
@@ -861,7 +862,7 @@ static void afs_fl_copy_lock(struct file_lock *new, struct file_lock *fl)
  */
 static void afs_fl_release_private(struct file_lock *fl)
 {
-	struct afs_vnode *vnode = AFS_FS_I(file_inode(fl->fl_file));
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(fl->fl_core.fl_file));
 
 	_enter("");
 
diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index e07ad29ff8b9..ee12f9864980 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -33,7 +33,7 @@ void __init ceph_flock_init(void)
 
 static void ceph_fl_copy_lock(struct file_lock *dst, struct file_lock *src)
 {
-	struct inode *inode = file_inode(dst->fl_file);
+	struct inode *inode = file_inode(dst->fl_core.fl_file);
 	atomic_inc(&ceph_inode(inode)->i_filelock_ref);
 	dst->fl_u.ceph.inode = igrab(inode);
 }
@@ -110,17 +110,18 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 	else
 		length = fl->fl_end - fl->fl_start + 1;
 
-	owner = secure_addr(fl->fl_owner);
+	owner = secure_addr(fl->fl_core.fl_owner);
 
 	doutc(cl, "rule: %d, op: %d, owner: %llx, pid: %llu, "
 		    "start: %llu, length: %llu, wait: %d, type: %d\n",
-		    (int)lock_type, (int)operation, owner, (u64)fl->fl_pid,
-		    fl->fl_start, length, wait, fl->fl_type);
+		    (int)lock_type, (int)operation, owner,
+		    (u64) fl->fl_core.fl_pid,
+		    fl->fl_start, length, wait, fl->fl_core.fl_type);
 
 	req->r_args.filelock_change.rule = lock_type;
 	req->r_args.filelock_change.type = cmd;
 	req->r_args.filelock_change.owner = cpu_to_le64(owner);
-	req->r_args.filelock_change.pid = cpu_to_le64((u64)fl->fl_pid);
+	req->r_args.filelock_change.pid = cpu_to_le64((u64) fl->fl_core.fl_pid);
 	req->r_args.filelock_change.start = cpu_to_le64(fl->fl_start);
 	req->r_args.filelock_change.length = cpu_to_le64(length);
 	req->r_args.filelock_change.wait = wait;
@@ -130,13 +131,13 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 		err = ceph_mdsc_wait_request(mdsc, req, wait ?
 					ceph_lock_wait_for_completion : NULL);
 	if (!err && operation == CEPH_MDS_OP_GETFILELOCK) {
-		fl->fl_pid = -le64_to_cpu(req->r_reply_info.filelock_reply->pid);
+		fl->fl_core.fl_pid = -le64_to_cpu(req->r_reply_info.filelock_reply->pid);
 		if (CEPH_LOCK_SHARED == req->r_reply_info.filelock_reply->type)
-			fl->fl_type = F_RDLCK;
+			fl->fl_core.fl_type = F_RDLCK;
 		else if (CEPH_LOCK_EXCL == req->r_reply_info.filelock_reply->type)
-			fl->fl_type = F_WRLCK;
+			fl->fl_core.fl_type = F_WRLCK;
 		else
-			fl->fl_type = F_UNLCK;
+			fl->fl_core.fl_type = F_UNLCK;
 
 		fl->fl_start = le64_to_cpu(req->r_reply_info.filelock_reply->start);
 		length = le64_to_cpu(req->r_reply_info.filelock_reply->start) +
@@ -150,8 +151,8 @@ static int ceph_lock_message(u8 lock_type, u16 operation, struct inode *inode,
 	ceph_mdsc_put_request(req);
 	doutc(cl, "rule: %d, op: %d, pid: %llu, start: %llu, "
 	      "length: %llu, wait: %d, type: %d, err code %d\n",
-	      (int)lock_type, (int)operation, (u64)fl->fl_pid,
-	      fl->fl_start, length, wait, fl->fl_type, err);
+	      (int)lock_type, (int)operation, (u64) fl->fl_core.fl_pid,
+	      fl->fl_start, length, wait, fl->fl_core.fl_type, err);
 	return err;
 }
 
@@ -227,10 +228,10 @@ static int ceph_lock_wait_for_completion(struct ceph_mds_client *mdsc,
 static int try_unlock_file(struct file *file, struct file_lock *fl)
 {
 	int err;
-	unsigned int orig_flags = fl->fl_flags;
-	fl->fl_flags |= FL_EXISTS;
+	unsigned int orig_flags = fl->fl_core.fl_flags;
+	fl->fl_core.fl_flags |= FL_EXISTS;
 	err = locks_lock_file_wait(file, fl);
-	fl->fl_flags = orig_flags;
+	fl->fl_core.fl_flags = orig_flags;
 	if (err == -ENOENT) {
 		if (!(orig_flags & FL_EXISTS))
 			err = 0;
@@ -253,13 +254,13 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	u8 wait = 0;
 	u8 lock_cmd;
 
-	if (!(fl->fl_flags & FL_POSIX))
+	if (!(fl->fl_core.fl_flags & FL_POSIX))
 		return -ENOLCK;
 
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
-	doutc(cl, "fl_owner: %p\n", fl->fl_owner);
+	doutc(cl, "fl_owner: %p\n", fl->fl_core.fl_owner);
 
 	/* set wait bit as appropriate, then make command as Ceph expects it*/
 	if (IS_GETLK(cmd))
@@ -273,19 +274,19 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	}
 	spin_unlock(&ci->i_ceph_lock);
 	if (err < 0) {
-		if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK == fl->fl_type)
+		if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK == fl->fl_core.fl_type)
 			posix_lock_file(file, fl, NULL);
 		return err;
 	}
 
-	if (F_RDLCK == fl->fl_type)
+	if (F_RDLCK == fl->fl_core.fl_type)
 		lock_cmd = CEPH_LOCK_SHARED;
-	else if (F_WRLCK == fl->fl_type)
+	else if (F_WRLCK == fl->fl_core.fl_type)
 		lock_cmd = CEPH_LOCK_EXCL;
 	else
 		lock_cmd = CEPH_LOCK_UNLOCK;
 
-	if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK == fl->fl_type) {
+	if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK == fl->fl_core.fl_type) {
 		err = try_unlock_file(file, fl);
 		if (err <= 0)
 			return err;
@@ -293,7 +294,7 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 
 	err = ceph_lock_message(CEPH_LOCK_FCNTL, op, inode, lock_cmd, wait, fl);
 	if (!err) {
-		if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK != fl->fl_type) {
+		if (op == CEPH_MDS_OP_SETFILELOCK && F_UNLCK != fl->fl_core.fl_type) {
 			doutc(cl, "locking locally\n");
 			err = posix_lock_file(file, fl, NULL);
 			if (err) {
@@ -319,13 +320,13 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	u8 wait = 0;
 	u8 lock_cmd;
 
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->fl_core.fl_flags & FL_FLOCK))
 		return -ENOLCK;
 
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
-	doutc(cl, "fl_file: %p\n", fl->fl_file);
+	doutc(cl, "fl_file: %p\n", fl->fl_core.fl_file);
 
 	spin_lock(&ci->i_ceph_lock);
 	if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
@@ -333,7 +334,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	}
 	spin_unlock(&ci->i_ceph_lock);
 	if (err < 0) {
-		if (F_UNLCK == fl->fl_type)
+		if (F_UNLCK == fl->fl_core.fl_type)
 			locks_lock_file_wait(file, fl);
 		return err;
 	}
@@ -341,14 +342,14 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	if (IS_SETLKW(cmd))
 		wait = 1;
 
-	if (F_RDLCK == fl->fl_type)
+	if (F_RDLCK == fl->fl_core.fl_type)
 		lock_cmd = CEPH_LOCK_SHARED;
-	else if (F_WRLCK == fl->fl_type)
+	else if (F_WRLCK == fl->fl_core.fl_type)
 		lock_cmd = CEPH_LOCK_EXCL;
 	else
 		lock_cmd = CEPH_LOCK_UNLOCK;
 
-	if (F_UNLCK == fl->fl_type) {
+	if (F_UNLCK == fl->fl_core.fl_type) {
 		err = try_unlock_file(file, fl);
 		if (err <= 0)
 			return err;
@@ -356,7 +357,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 
 	err = ceph_lock_message(CEPH_LOCK_FLOCK, CEPH_MDS_OP_SETFILELOCK,
 				inode, lock_cmd, wait, fl);
-	if (!err && F_UNLCK != fl->fl_type) {
+	if (!err && F_UNLCK != fl->fl_core.fl_type) {
 		err = locks_lock_file_wait(file, fl);
 		if (err) {
 			ceph_lock_message(CEPH_LOCK_FLOCK,
@@ -408,10 +409,10 @@ static int lock_to_ceph_filelock(struct inode *inode,
 	cephlock->start = cpu_to_le64(lock->fl_start);
 	cephlock->length = cpu_to_le64(lock->fl_end - lock->fl_start + 1);
 	cephlock->client = cpu_to_le64(0);
-	cephlock->pid = cpu_to_le64((u64)lock->fl_pid);
-	cephlock->owner = cpu_to_le64(secure_addr(lock->fl_owner));
+	cephlock->pid = cpu_to_le64((u64) lock->fl_core.fl_pid);
+	cephlock->owner = cpu_to_le64(secure_addr(lock->fl_core.fl_owner));
 
-	switch (lock->fl_type) {
+	switch (lock->fl_core.fl_type) {
 	case F_RDLCK:
 		cephlock->type = CEPH_LOCK_SHARED;
 		break;
@@ -422,7 +423,8 @@ static int lock_to_ceph_filelock(struct inode *inode,
 		cephlock->type = CEPH_LOCK_UNLOCK;
 		break;
 	default:
-		doutc(cl, "Have unknown lock type %d\n", lock->fl_type);
+		doutc(cl, "Have unknown lock type %d\n",
+		      lock->fl_core.fl_type);
 		err = -EINVAL;
 	}
 
diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index d814c5121367..e98d09c06f57 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -138,14 +138,14 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	}
 
 	op->info.optype		= DLM_PLOCK_OP_LOCK;
-	op->info.pid		= fl->fl_pid;
-	op->info.ex		= (fl->fl_type == F_WRLCK);
-	op->info.wait		= !!(fl->fl_flags & FL_SLEEP);
+	op->info.pid		= fl->fl_core.fl_pid;
+	op->info.ex		= (fl->fl_core.fl_type == F_WRLCK);
+	op->info.wait		= !!(fl->fl_core.fl_flags & FL_SLEEP);
 	op->info.fsid		= ls->ls_global_id;
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
-	op->info.owner = (__u64)(long)fl->fl_owner;
+	op->info.owner = (__u64)(long) fl->fl_core.fl_owner;
 	/* async handling */
 	if (fl->fl_lmops && fl->fl_lmops->lm_grant) {
 		op_data = kzalloc(sizeof(*op_data), GFP_NOFS);
@@ -258,7 +258,7 @@ static int dlm_plock_callback(struct plock_op *op)
 	}
 
 	/* got fs lock; bookkeep locally as well: */
-	flc->fl_flags &= ~FL_SLEEP;
+	flc->fl_core.fl_flags &= ~FL_SLEEP;
 	if (posix_lock_file(file, flc, NULL)) {
 		/*
 		 * This can only happen in the case of kmalloc() failure.
@@ -291,7 +291,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	struct dlm_ls *ls;
 	struct plock_op *op;
 	int rv;
-	unsigned char fl_flags = fl->fl_flags;
+	unsigned char fl_flags = fl->fl_core.fl_flags;
 
 	ls = dlm_find_lockspace_local(lockspace);
 	if (!ls)
@@ -304,7 +304,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	}
 
 	/* cause the vfs unlock to return ENOENT if lock is not found */
-	fl->fl_flags |= FL_EXISTS;
+	fl->fl_core.fl_flags |= FL_EXISTS;
 
 	rv = locks_lock_file_wait(file, fl);
 	if (rv == -ENOENT) {
@@ -317,14 +317,14 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	}
 
 	op->info.optype		= DLM_PLOCK_OP_UNLOCK;
-	op->info.pid		= fl->fl_pid;
+	op->info.pid		= fl->fl_core.fl_pid;
 	op->info.fsid		= ls->ls_global_id;
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
-	op->info.owner = (__u64)(long)fl->fl_owner;
+	op->info.owner = (__u64)(long) fl->fl_core.fl_owner;
 
-	if (fl->fl_flags & FL_CLOSE) {
+	if (fl->fl_core.fl_flags & FL_CLOSE) {
 		op->info.flags |= DLM_PLOCK_FL_CLOSE;
 		send_op(op);
 		rv = 0;
@@ -345,7 +345,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	dlm_release_plock_op(op);
 out:
 	dlm_put_lockspace(ls);
-	fl->fl_flags = fl_flags;
+	fl->fl_core.fl_flags = fl_flags;
 	return rv;
 }
 EXPORT_SYMBOL_GPL(dlm_posix_unlock);
@@ -375,14 +375,14 @@ int dlm_posix_cancel(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		return -EINVAL;
 
 	memset(&info, 0, sizeof(info));
-	info.pid = fl->fl_pid;
-	info.ex = (fl->fl_type == F_WRLCK);
+	info.pid = fl->fl_core.fl_pid;
+	info.ex = (fl->fl_core.fl_type == F_WRLCK);
 	info.fsid = ls->ls_global_id;
 	dlm_put_lockspace(ls);
 	info.number = number;
 	info.start = fl->fl_start;
 	info.end = fl->fl_end;
-	info.owner = (__u64)(long)fl->fl_owner;
+	info.owner = (__u64)(long) fl->fl_core.fl_owner;
 
 	rv = do_lock_cancel(&info);
 	switch (rv) {
@@ -437,13 +437,13 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	}
 
 	op->info.optype		= DLM_PLOCK_OP_GET;
-	op->info.pid		= fl->fl_pid;
-	op->info.ex		= (fl->fl_type == F_WRLCK);
+	op->info.pid		= fl->fl_core.fl_pid;
+	op->info.ex		= (fl->fl_core.fl_type == F_WRLCK);
 	op->info.fsid		= ls->ls_global_id;
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
-	op->info.owner = (__u64)(long)fl->fl_owner;
+	op->info.owner = (__u64)(long) fl->fl_core.fl_owner;
 
 	send_op(op);
 	wait_event(recv_wq, (op->done != 0));
@@ -455,16 +455,16 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 
 	rv = op->info.rv;
 
-	fl->fl_type = F_UNLCK;
+	fl->fl_core.fl_type = F_UNLCK;
 	if (rv == -ENOENT)
 		rv = 0;
 	else if (rv > 0) {
 		locks_init_lock(fl);
-		fl->fl_type = (op->info.ex) ? F_WRLCK : F_RDLCK;
-		fl->fl_flags = FL_POSIX;
-		fl->fl_pid = op->info.pid;
+		fl->fl_core.fl_type = (op->info.ex) ? F_WRLCK : F_RDLCK;
+		fl->fl_core.fl_flags = FL_POSIX;
+		fl->fl_core.fl_pid = op->info.pid;
 		if (op->info.nodeid != dlm_our_nodeid())
-			fl->fl_pid = -fl->fl_pid;
+			fl->fl_core.fl_pid = -fl->fl_core.fl_pid;
 		fl->fl_start = op->info.start;
 		fl->fl_end = op->info.end;
 		rv = 0;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 148a71b8b4d0..13c38696074d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2509,14 +2509,14 @@ static int convert_fuse_file_lock(struct fuse_conn *fc,
 		 * translate it into the caller's pid namespace.
 		 */
 		rcu_read_lock();
-		fl->fl_pid = pid_nr_ns(find_pid_ns(ffl->pid, fc->pid_ns), &init_pid_ns);
+		fl->fl_core.fl_pid = pid_nr_ns(find_pid_ns(ffl->pid, fc->pid_ns), &init_pid_ns);
 		rcu_read_unlock();
 		break;
 
 	default:
 		return -EIO;
 	}
-	fl->fl_type = ffl->type;
+	fl->fl_core.fl_type = ffl->type;
 	return 0;
 }
 
@@ -2530,10 +2530,10 @@ static void fuse_lk_fill(struct fuse_args *args, struct file *file,
 
 	memset(inarg, 0, sizeof(*inarg));
 	inarg->fh = ff->fh;
-	inarg->owner = fuse_lock_owner_id(fc, fl->fl_owner);
+	inarg->owner = fuse_lock_owner_id(fc, fl->fl_core.fl_owner);
 	inarg->lk.start = fl->fl_start;
 	inarg->lk.end = fl->fl_end;
-	inarg->lk.type = fl->fl_type;
+	inarg->lk.type = fl->fl_core.fl_type;
 	inarg->lk.pid = pid;
 	if (flock)
 		inarg->lk_flags |= FUSE_LK_FLOCK;
@@ -2570,8 +2570,8 @@ static int fuse_setlk(struct file *file, struct file_lock *fl, int flock)
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	FUSE_ARGS(args);
 	struct fuse_lk_in inarg;
-	int opcode = (fl->fl_flags & FL_SLEEP) ? FUSE_SETLKW : FUSE_SETLK;
-	struct pid *pid = fl->fl_type != F_UNLCK ? task_tgid(current) : NULL;
+	int opcode = (fl->fl_core.fl_flags & FL_SLEEP) ? FUSE_SETLKW : FUSE_SETLK;
+	struct pid *pid = fl->fl_core.fl_type != F_UNLCK ? task_tgid(current) : NULL;
 	pid_t pid_nr = pid_nr_ns(pid, fm->fc->pid_ns);
 	int err;
 
@@ -2581,7 +2581,7 @@ static int fuse_setlk(struct file *file, struct file_lock *fl, int flock)
 	}
 
 	/* Unlock on close is handled by the flush method */
-	if ((fl->fl_flags & FL_CLOSE_POSIX) == FL_CLOSE_POSIX)
+	if ((fl->fl_core.fl_flags & FL_CLOSE_POSIX) == FL_CLOSE_POSIX)
 		return 0;
 
 	fuse_lk_fill(&args, file, fl, opcode, pid_nr, flock, &inarg);
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 992ca4effb50..fdcd29583cc8 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1440,10 +1440,10 @@ static int gfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 	struct gfs2_sbd *sdp = GFS2_SB(file->f_mapping->host);
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 
-	if (!(fl->fl_flags & FL_POSIX))
+	if (!(fl->fl_core.fl_flags & FL_POSIX))
 		return -ENOLCK;
 	if (gfs2_withdrawing_or_withdrawn(sdp)) {
-		if (fl->fl_type == F_UNLCK)
+		if (fl->fl_core.fl_type == F_UNLCK)
 			locks_lock_file_wait(file, fl);
 		return -EIO;
 	}
@@ -1451,7 +1451,7 @@ static int gfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 		return dlm_posix_cancel(ls->ls_dlm, ip->i_no_addr, file, fl);
 	else if (IS_GETLK(cmd))
 		return dlm_posix_get(ls->ls_dlm, ip->i_no_addr, file, fl);
-	else if (fl->fl_type == F_UNLCK)
+	else if (fl->fl_core.fl_type == F_UNLCK)
 		return dlm_posix_unlock(ls->ls_dlm, ip->i_no_addr, file, fl);
 	else
 		return dlm_posix_lock(ls->ls_dlm, ip->i_no_addr, file, cmd, fl);
@@ -1483,7 +1483,7 @@ static int do_flock(struct file *file, int cmd, struct file_lock *fl)
 	int error = 0;
 	int sleeptime;
 
-	state = (fl->fl_type == F_WRLCK) ? LM_ST_EXCLUSIVE : LM_ST_SHARED;
+	state = (fl->fl_core.fl_type == F_WRLCK) ? LM_ST_EXCLUSIVE : LM_ST_SHARED;
 	flags = GL_EXACT | GL_NOPID;
 	if (!IS_SETLKW(cmd))
 		flags |= LM_FLAG_TRY_1CB;
@@ -1495,8 +1495,8 @@ static int do_flock(struct file *file, int cmd, struct file_lock *fl)
 		if (fl_gh->gh_state == state)
 			goto out;
 		locks_init_lock(&request);
-		request.fl_type = F_UNLCK;
-		request.fl_flags = FL_FLOCK;
+		request.fl_core.fl_type = F_UNLCK;
+		request.fl_core.fl_flags = FL_FLOCK;
 		locks_lock_file_wait(file, &request);
 		gfs2_glock_dq(fl_gh);
 		gfs2_holder_reinit(state, flags, fl_gh);
@@ -1557,10 +1557,10 @@ static void do_unflock(struct file *file, struct file_lock *fl)
 
 static int gfs2_flock(struct file *file, int cmd, struct file_lock *fl)
 {
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->fl_core.fl_flags & FL_FLOCK))
 		return -ENOLCK;
 
-	if (fl->fl_type == F_UNLCK) {
+	if (fl->fl_core.fl_type == F_UNLCK) {
 		do_unflock(file, fl);
 		return 0;
 	} else {
diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
index 8161667c976f..ed00bd2869a7 100644
--- a/fs/lockd/clnt4xdr.c
+++ b/fs/lockd/clnt4xdr.c
@@ -270,7 +270,7 @@ static int decode_nlm4_holder(struct xdr_stream *xdr, struct nlm_res *result)
 		goto out_overflow;
 	exclusive = be32_to_cpup(p++);
 	lock->svid = be32_to_cpup(p);
-	fl->fl_pid = (pid_t)lock->svid;
+	fl->fl_core.fl_pid = (pid_t)lock->svid;
 
 	error = decode_netobj(xdr, &lock->oh);
 	if (unlikely(error))
@@ -280,8 +280,8 @@ static int decode_nlm4_holder(struct xdr_stream *xdr, struct nlm_res *result)
 	if (unlikely(p == NULL))
 		goto out_overflow;
 
-	fl->fl_flags = FL_POSIX;
-	fl->fl_type  = exclusive != 0 ? F_WRLCK : F_RDLCK;
+	fl->fl_core.fl_flags = FL_POSIX;
+	fl->fl_core.fl_type  = exclusive != 0 ? F_WRLCK : F_RDLCK;
 	p = xdr_decode_hyper(p, &l_offset);
 	xdr_decode_hyper(p, &l_len);
 	nlm4svc_set_file_lock_range(fl, l_offset, l_len);
diff --git a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
index 5d85715be763..c15a6d5f1acf 100644
--- a/fs/lockd/clntlock.c
+++ b/fs/lockd/clntlock.c
@@ -185,7 +185,7 @@ __be32 nlmclnt_grant(const struct sockaddr *addr, const struct nlm_lock *lock)
 			continue;
 		if (!rpc_cmp_addr(nlm_addr(block->b_host), addr))
 			continue;
-		if (nfs_compare_fh(NFS_FH(file_inode(fl_blocked->fl_file)), fh) != 0)
+		if (nfs_compare_fh(NFS_FH(file_inode(fl_blocked->fl_core.fl_file)), fh) != 0)
 			continue;
 		/* Alright, we found a lock. Set the return status
 		 * and wake up the caller
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index fba6c7fa7474..ac1d07034346 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -133,7 +133,8 @@ static void nlmclnt_setlockargs(struct nlm_rqst *req, struct file_lock *fl)
 	char *nodename = req->a_host->h_rpcclnt->cl_nodename;
 
 	nlmclnt_next_cookie(&argp->cookie);
-	memcpy(&lock->fh, NFS_FH(file_inode(fl->fl_file)), sizeof(struct nfs_fh));
+	memcpy(&lock->fh, NFS_FH(file_inode(fl->fl_core.fl_file)),
+	       sizeof(struct nfs_fh));
 	lock->caller  = nodename;
 	lock->oh.data = req->a_owner;
 	lock->oh.len  = snprintf(req->a_owner, sizeof(req->a_owner), "%u@%s",
@@ -142,7 +143,7 @@ static void nlmclnt_setlockargs(struct nlm_rqst *req, struct file_lock *fl)
 	lock->svid = fl->fl_u.nfs_fl.owner->pid;
 	lock->fl.fl_start = fl->fl_start;
 	lock->fl.fl_end = fl->fl_end;
-	lock->fl.fl_type = fl->fl_type;
+	lock->fl.fl_type = fl->fl_core.fl_type;
 }
 
 static void nlmclnt_release_lockargs(struct nlm_rqst *req)
@@ -182,7 +183,7 @@ int nlmclnt_proc(struct nlm_host *host, int cmd, struct file_lock *fl, void *dat
 	call->a_callback_data = data;
 
 	if (IS_SETLK(cmd) || IS_SETLKW(cmd)) {
-		if (fl->fl_type != F_UNLCK) {
+		if (fl->fl_core.fl_type != F_UNLCK) {
 			call->a_args.block = IS_SETLKW(cmd) ? 1 : 0;
 			status = nlmclnt_lock(call, fl);
 		} else
@@ -432,13 +433,14 @@ nlmclnt_test(struct nlm_rqst *req, struct file_lock *fl)
 {
 	int	status;
 
-	status = nlmclnt_call(nfs_file_cred(fl->fl_file), req, NLMPROC_TEST);
+	status = nlmclnt_call(nfs_file_cred(fl->fl_core.fl_file), req,
+			      NLMPROC_TEST);
 	if (status < 0)
 		goto out;
 
 	switch (req->a_res.status) {
 		case nlm_granted:
-			fl->fl_type = F_UNLCK;
+			fl->fl_core.fl_type = F_UNLCK;
 			break;
 		case nlm_lck_denied:
 			/*
@@ -446,8 +448,8 @@ nlmclnt_test(struct nlm_rqst *req, struct file_lock *fl)
 			 */
 			fl->fl_start = req->a_res.lock.fl.fl_start;
 			fl->fl_end = req->a_res.lock.fl.fl_end;
-			fl->fl_type = req->a_res.lock.fl.fl_type;
-			fl->fl_pid = -req->a_res.lock.fl.fl_pid;
+			fl->fl_core.fl_type = req->a_res.lock.fl.fl_type;
+			fl->fl_core.fl_pid = -req->a_res.lock.fl.fl_pid;
 			break;
 		default:
 			status = nlm_stat_to_errno(req->a_res.status);
@@ -485,14 +487,15 @@ static const struct file_lock_operations nlmclnt_lock_ops = {
 static void nlmclnt_locks_init_private(struct file_lock *fl, struct nlm_host *host)
 {
 	fl->fl_u.nfs_fl.state = 0;
-	fl->fl_u.nfs_fl.owner = nlmclnt_find_lockowner(host, fl->fl_owner);
+	fl->fl_u.nfs_fl.owner = nlmclnt_find_lockowner(host,
+						       fl->fl_core.fl_owner);
 	INIT_LIST_HEAD(&fl->fl_u.nfs_fl.list);
 	fl->fl_ops = &nlmclnt_lock_ops;
 }
 
 static int do_vfs_lock(struct file_lock *fl)
 {
-	return locks_lock_file_wait(fl->fl_file, fl);
+	return locks_lock_file_wait(fl->fl_core.fl_file, fl);
 }
 
 /*
@@ -518,11 +521,11 @@ static int do_vfs_lock(struct file_lock *fl)
 static int
 nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 {
-	const struct cred *cred = nfs_file_cred(fl->fl_file);
+	const struct cred *cred = nfs_file_cred(fl->fl_core.fl_file);
 	struct nlm_host	*host = req->a_host;
 	struct nlm_res	*resp = &req->a_res;
 	struct nlm_wait block;
-	unsigned char fl_flags = fl->fl_flags;
+	unsigned char fl_flags = fl->fl_core.fl_flags;
 	unsigned char fl_type;
 	__be32 b_status;
 	int status = -ENOLCK;
@@ -531,9 +534,9 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 		goto out;
 	req->a_args.state = nsm_local_state;
 
-	fl->fl_flags |= FL_ACCESS;
+	fl->fl_core.fl_flags |= FL_ACCESS;
 	status = do_vfs_lock(fl);
-	fl->fl_flags = fl_flags;
+	fl->fl_core.fl_flags = fl_flags;
 	if (status < 0)
 		goto out;
 
@@ -591,11 +594,11 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 			goto again;
 		}
 		/* Ensure the resulting lock will get added to granted list */
-		fl->fl_flags |= FL_SLEEP;
+		fl->fl_core.fl_flags |= FL_SLEEP;
 		if (do_vfs_lock(fl) < 0)
 			printk(KERN_WARNING "%s: VFS is out of sync with lock manager!\n", __func__);
 		up_read(&host->h_rwsem);
-		fl->fl_flags = fl_flags;
+		fl->fl_core.fl_flags = fl_flags;
 		status = 0;
 	}
 	if (status < 0)
@@ -622,13 +625,13 @@ nlmclnt_lock(struct nlm_rqst *req, struct file_lock *fl)
 			   req->a_host->h_addrlen, req->a_res.status);
 	dprintk("lockd: lock attempt ended in fatal error.\n"
 		"       Attempting to unlock.\n");
-	fl_type = fl->fl_type;
-	fl->fl_type = F_UNLCK;
+	fl_type = fl->fl_core.fl_type;
+	fl->fl_core.fl_type = F_UNLCK;
 	down_read(&host->h_rwsem);
 	do_vfs_lock(fl);
 	up_read(&host->h_rwsem);
-	fl->fl_type = fl_type;
-	fl->fl_flags = fl_flags;
+	fl->fl_core.fl_type = fl_type;
+	fl->fl_core.fl_flags = fl_flags;
 	nlmclnt_async_call(cred, req, NLMPROC_UNLOCK, &nlmclnt_unlock_ops);
 	return status;
 }
@@ -651,12 +654,13 @@ nlmclnt_reclaim(struct nlm_host *host, struct file_lock *fl,
 	nlmclnt_setlockargs(req, fl);
 	req->a_args.reclaim = 1;
 
-	status = nlmclnt_call(nfs_file_cred(fl->fl_file), req, NLMPROC_LOCK);
+	status = nlmclnt_call(nfs_file_cred(fl->fl_core.fl_file), req,
+			      NLMPROC_LOCK);
 	if (status >= 0 && req->a_res.status == nlm_granted)
 		return 0;
 
 	printk(KERN_WARNING "lockd: failed to reclaim lock for pid %d "
-				"(errno %d, status %d)\n", fl->fl_pid,
+				"(errno %d, status %d)\n", fl->fl_core.fl_pid,
 				status, ntohl(req->a_res.status));
 
 	/*
@@ -683,26 +687,26 @@ nlmclnt_unlock(struct nlm_rqst *req, struct file_lock *fl)
 	struct nlm_host	*host = req->a_host;
 	struct nlm_res	*resp = &req->a_res;
 	int status;
-	unsigned char fl_flags = fl->fl_flags;
+	unsigned char fl_flags = fl->fl_core.fl_flags;
 
 	/*
 	 * Note: the server is supposed to either grant us the unlock
 	 * request, or to deny it with NLM_LCK_DENIED_GRACE_PERIOD. In either
 	 * case, we want to unlock.
 	 */
-	fl->fl_flags |= FL_EXISTS;
+	fl->fl_core.fl_flags |= FL_EXISTS;
 	down_read(&host->h_rwsem);
 	status = do_vfs_lock(fl);
 	up_read(&host->h_rwsem);
-	fl->fl_flags = fl_flags;
+	fl->fl_core.fl_flags = fl_flags;
 	if (status == -ENOENT) {
 		status = 0;
 		goto out;
 	}
 
 	refcount_inc(&req->a_count);
-	status = nlmclnt_async_call(nfs_file_cred(fl->fl_file), req,
-			NLMPROC_UNLOCK, &nlmclnt_unlock_ops);
+	status = nlmclnt_async_call(nfs_file_cred(fl->fl_core.fl_file), req,
+				    NLMPROC_UNLOCK, &nlmclnt_unlock_ops);
 	if (status < 0)
 		goto out;
 
@@ -795,8 +799,8 @@ static int nlmclnt_cancel(struct nlm_host *host, int block, struct file_lock *fl
 	req->a_args.block = block;
 
 	refcount_inc(&req->a_count);
-	status = nlmclnt_async_call(nfs_file_cred(fl->fl_file), req,
-			NLMPROC_CANCEL, &nlmclnt_cancel_ops);
+	status = nlmclnt_async_call(nfs_file_cred(fl->fl_core.fl_file), req,
+				    NLMPROC_CANCEL, &nlmclnt_cancel_ops);
 	if (status == 0 && req->a_res.status == nlm_lck_denied)
 		status = -ENOLCK;
 	nlmclnt_release_call(req);
diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
index 4df62f635529..b0b87a00cd81 100644
--- a/fs/lockd/clntxdr.c
+++ b/fs/lockd/clntxdr.c
@@ -265,7 +265,7 @@ static int decode_nlm_holder(struct xdr_stream *xdr, struct nlm_res *result)
 		goto out_overflow;
 	exclusive = be32_to_cpup(p++);
 	lock->svid = be32_to_cpup(p);
-	fl->fl_pid = (pid_t)lock->svid;
+	fl->fl_core.fl_pid = (pid_t)lock->svid;
 
 	error = decode_netobj(xdr, &lock->oh);
 	if (unlikely(error))
@@ -275,8 +275,8 @@ static int decode_nlm_holder(struct xdr_stream *xdr, struct nlm_res *result)
 	if (unlikely(p == NULL))
 		goto out_overflow;
 
-	fl->fl_flags = FL_POSIX;
-	fl->fl_type  = exclusive != 0 ? F_WRLCK : F_RDLCK;
+	fl->fl_core.fl_flags = FL_POSIX;
+	fl->fl_core.fl_type  = exclusive != 0 ? F_WRLCK : F_RDLCK;
 	l_offset = be32_to_cpup(p++);
 	l_len = be32_to_cpup(p);
 	end = l_offset + l_len - 1;
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 2dc10900ad1c..520886a4b57e 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -157,9 +157,9 @@ nlmsvc_lookup_block(struct nlm_file *file, struct nlm_lock *lock)
 	list_for_each_entry(block, &nlm_blocked, b_list) {
 		fl = &block->b_call->a_args.lock.fl;
 		dprintk("lockd: check f=%p pd=%d %Ld-%Ld ty=%d cookie=%s\n",
-				block->b_file, fl->fl_pid,
+				block->b_file, fl->fl_core.fl_pid,
 				(long long)fl->fl_start,
-				(long long)fl->fl_end, fl->fl_type,
+				(long long)fl->fl_end, fl->fl_core.fl_type,
 				nlmdbg_cookie2a(&block->b_call->a_args.cookie));
 		if (block->b_file == file && nlm_compare_locks(fl, &lock->fl)) {
 			kref_get(&block->b_count);
@@ -409,7 +409,7 @@ nlmsvc_release_lockowner(struct nlm_lock *lock)
 void nlmsvc_locks_init_private(struct file_lock *fl, struct nlm_host *host,
 						pid_t pid)
 {
-	fl->fl_owner = nlmsvc_find_lockowner(host, pid);
+	fl->fl_core.fl_owner = nlmsvc_find_lockowner(host, pid);
 }
 
 /*
@@ -993,8 +993,8 @@ nlmsvc_grant_reply(struct nlm_cookie *cookie, __be32 status)
 		/* Client doesn't want it, just unlock it */
 		nlmsvc_unlink_block(block);
 		fl = &block->b_call->a_args.lock.fl;
-		fl->fl_type = F_UNLCK;
-		error = vfs_lock_file(fl->fl_file, F_SETLK, fl, NULL);
+		fl->fl_core.fl_type = F_UNLCK;
+		error = vfs_lock_file(fl->fl_core.fl_file, F_SETLK, fl, NULL);
 		if (error)
 			pr_warn("lockd: unable to unlock lock rejected by client!\n");
 		break;
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index e3b6229e7ae5..61b5c7ef8a12 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -73,7 +73,7 @@ static inline unsigned int file_hash(struct nfs_fh *f)
 
 int lock_to_openmode(struct file_lock *lock)
 {
-	return (lock->fl_type == F_WRLCK) ? O_WRONLY : O_RDONLY;
+	return (lock->fl_core.fl_type == F_WRLCK) ? O_WRONLY : O_RDONLY;
 }
 
 /*
@@ -181,18 +181,18 @@ static int nlm_unlock_files(struct nlm_file *file, const struct file_lock *fl)
 	struct file_lock lock;
 
 	locks_init_lock(&lock);
-	lock.fl_type  = F_UNLCK;
+	lock.fl_core.fl_type  = F_UNLCK;
 	lock.fl_start = 0;
 	lock.fl_end   = OFFSET_MAX;
-	lock.fl_owner = fl->fl_owner;
-	lock.fl_pid   = fl->fl_pid;
-	lock.fl_flags = FL_POSIX;
+	lock.fl_core.fl_owner = fl->fl_core.fl_owner;
+	lock.fl_core.fl_pid   = fl->fl_core.fl_pid;
+	lock.fl_core.fl_flags = FL_POSIX;
 
-	lock.fl_file = file->f_file[O_RDONLY];
-	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NULL))
+	lock.fl_core.fl_file = file->f_file[O_RDONLY];
+	if (lock.fl_core.fl_file && vfs_lock_file(lock.fl_core.fl_file, F_SETLK, &lock, NULL))
 		goto out_err;
-	lock.fl_file = file->f_file[O_WRONLY];
-	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NULL))
+	lock.fl_core.fl_file = file->f_file[O_WRONLY];
+	if (lock.fl_core.fl_file && vfs_lock_file(lock.fl_core.fl_file, F_SETLK, &lock, NULL))
 		goto out_err;
 	return 0;
 out_err:
@@ -225,7 +225,7 @@ nlm_traverse_locks(struct nlm_host *host, struct nlm_file *file,
 		/* update current lock count */
 		file->f_locks++;
 
-		lockhost = ((struct nlm_lockowner *)fl->fl_owner)->host;
+		lockhost = ((struct nlm_lockowner *) fl->fl_core.fl_owner)->host;
 		if (match(lockhost, host)) {
 
 			spin_unlock(&flctx->flc_lock);
diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
index 2fb5748dae0c..4a676a51eb6c 100644
--- a/fs/lockd/xdr.c
+++ b/fs/lockd/xdr.c
@@ -88,8 +88,8 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 		return false;
 
 	locks_init_lock(fl);
-	fl->fl_flags = FL_POSIX;
-	fl->fl_type  = F_RDLCK;
+	fl->fl_core.fl_flags = FL_POSIX;
+	fl->fl_core.fl_type  = F_RDLCK;
 	end = start + len - 1;
 	fl->fl_start = s32_to_loff_t(start);
 	if (len == 0 || end < 0)
@@ -107,7 +107,7 @@ svcxdr_encode_holder(struct xdr_stream *xdr, const struct nlm_lock *lock)
 	s32 start, len;
 
 	/* exclusive */
-	if (xdr_stream_encode_bool(xdr, fl->fl_type != F_RDLCK) < 0)
+	if (xdr_stream_encode_bool(xdr, fl->fl_core.fl_type != F_RDLCK) < 0)
 		return false;
 	if (xdr_stream_encode_u32(xdr, lock->svid) < 0)
 		return false;
diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
index 5fcbf30cd275..67e53f91717a 100644
--- a/fs/lockd/xdr4.c
+++ b/fs/lockd/xdr4.c
@@ -89,8 +89,8 @@ svcxdr_decode_lock(struct xdr_stream *xdr, struct nlm_lock *lock)
 		return false;
 
 	locks_init_lock(fl);
-	fl->fl_flags = FL_POSIX;
-	fl->fl_type  = F_RDLCK;
+	fl->fl_core.fl_flags = FL_POSIX;
+	fl->fl_core.fl_type  = F_RDLCK;
 	nlm4svc_set_file_lock_range(fl, lock->lock_start, lock->lock_len);
 	return true;
 }
@@ -102,7 +102,7 @@ svcxdr_encode_holder(struct xdr_stream *xdr, const struct nlm_lock *lock)
 	s64 start, len;
 
 	/* exclusive */
-	if (xdr_stream_encode_bool(xdr, fl->fl_type != F_RDLCK) < 0)
+	if (xdr_stream_encode_bool(xdr, fl->fl_core.fl_type != F_RDLCK) < 0)
 		return false;
 	if (xdr_stream_encode_u32(xdr, lock->svid) < 0)
 		return false;
diff --git a/fs/locks.c b/fs/locks.c
index cc7c117ee192..cd6ffa22a1ce 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -78,16 +78,16 @@
 
 static bool lease_breaking(struct file_lock *fl)
 {
-	return fl->fl_flags & (FL_UNLOCK_PENDING | FL_DOWNGRADE_PENDING);
+	return fl->fl_core.fl_flags & (FL_UNLOCK_PENDING | FL_DOWNGRADE_PENDING);
 }
 
 static int target_leasetype(struct file_lock *fl)
 {
-	if (fl->fl_flags & FL_UNLOCK_PENDING)
+	if (fl->fl_core.fl_flags & FL_UNLOCK_PENDING)
 		return F_UNLCK;
-	if (fl->fl_flags & FL_DOWNGRADE_PENDING)
+	if (fl->fl_core.fl_flags & FL_DOWNGRADE_PENDING)
 		return F_RDLCK;
-	return fl->fl_type;
+	return fl->fl_core.fl_type;
 }
 
 static int leases_enable = 1;
@@ -207,7 +207,9 @@ locks_dump_ctx_list(struct list_head *list, char *list_type)
 	struct file_lock *fl;
 
 	list_for_each_entry(fl, list, fl_list) {
-		pr_warn("%s: fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n", list_type, fl->fl_owner, fl->fl_flags, fl->fl_type, fl->fl_pid);
+		pr_warn("%s: fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n", list_type,
+			fl->fl_core.fl_owner, fl->fl_core.fl_flags,
+			fl->fl_core.fl_type, fl->fl_core.fl_pid);
 	}
 }
 
@@ -236,12 +238,13 @@ locks_check_ctx_file_list(struct file *filp, struct list_head *list,
 	struct inode *inode = file_inode(filp);
 
 	list_for_each_entry(fl, list, fl_list)
-		if (fl->fl_file == filp)
+		if (fl->fl_core.fl_file == filp)
 			pr_warn("Leaked %s lock on dev=0x%x:0x%x ino=0x%lx "
 				" fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n",
 				list_type, MAJOR(inode->i_sb->s_dev),
 				MINOR(inode->i_sb->s_dev), inode->i_ino,
-				fl->fl_owner, fl->fl_flags, fl->fl_type, fl->fl_pid);
+				fl->fl_core.fl_owner, fl->fl_core.fl_flags,
+				fl->fl_core.fl_type, fl->fl_core.fl_pid);
 }
 
 void
@@ -257,11 +260,11 @@ locks_free_lock_context(struct inode *inode)
 
 static void locks_init_lock_heads(struct file_lock *fl)
 {
-	INIT_HLIST_NODE(&fl->fl_link);
-	INIT_LIST_HEAD(&fl->fl_list);
-	INIT_LIST_HEAD(&fl->fl_blocked_requests);
-	INIT_LIST_HEAD(&fl->fl_blocked_member);
-	init_waitqueue_head(&fl->fl_wait);
+	INIT_HLIST_NODE(&fl->fl_core.fl_link);
+	INIT_LIST_HEAD(&fl->fl_core.fl_list);
+	INIT_LIST_HEAD(&fl->fl_core.fl_blocked_requests);
+	INIT_LIST_HEAD(&fl->fl_core.fl_blocked_member);
+	init_waitqueue_head(&fl->fl_core.fl_wait);
 }
 
 /* Allocate an empty lock structure. */
@@ -278,11 +281,11 @@ EXPORT_SYMBOL_GPL(locks_alloc_lock);
 
 void locks_release_private(struct file_lock *fl)
 {
-	BUG_ON(waitqueue_active(&fl->fl_wait));
-	BUG_ON(!list_empty(&fl->fl_list));
-	BUG_ON(!list_empty(&fl->fl_blocked_requests));
-	BUG_ON(!list_empty(&fl->fl_blocked_member));
-	BUG_ON(!hlist_unhashed(&fl->fl_link));
+	BUG_ON(waitqueue_active(&fl->fl_core.fl_wait));
+	BUG_ON(!list_empty(&fl->fl_core.fl_list));
+	BUG_ON(!list_empty(&fl->fl_core.fl_blocked_requests));
+	BUG_ON(!list_empty(&fl->fl_core.fl_blocked_member));
+	BUG_ON(!hlist_unhashed(&fl->fl_core.fl_link));
 
 	if (fl->fl_ops) {
 		if (fl->fl_ops->fl_release_private)
@@ -292,8 +295,8 @@ void locks_release_private(struct file_lock *fl)
 
 	if (fl->fl_lmops) {
 		if (fl->fl_lmops->lm_put_owner) {
-			fl->fl_lmops->lm_put_owner(fl->fl_owner);
-			fl->fl_owner = NULL;
+			fl->fl_lmops->lm_put_owner(fl->fl_core.fl_owner);
+			fl->fl_core.fl_owner = NULL;
 		}
 		fl->fl_lmops = NULL;
 	}
@@ -316,9 +319,9 @@ bool locks_owner_has_blockers(struct file_lock_context *flctx,
 
 	spin_lock(&flctx->flc_lock);
 	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
-		if (fl->fl_owner != owner)
+		if (fl->fl_core.fl_owner != owner)
 			continue;
-		if (!list_empty(&fl->fl_blocked_requests)) {
+		if (!list_empty(&fl->fl_core.fl_blocked_requests)) {
 			spin_unlock(&flctx->flc_lock);
 			return true;
 		}
@@ -343,7 +346,7 @@ locks_dispose_list(struct list_head *dispose)
 
 	while (!list_empty(dispose)) {
 		fl = list_first_entry(dispose, struct file_lock, fl_list);
-		list_del_init(&fl->fl_list);
+		list_del_init(&fl->fl_core.fl_list);
 		locks_free_lock(fl);
 	}
 }
@@ -360,11 +363,11 @@ EXPORT_SYMBOL(locks_init_lock);
  */
 void locks_copy_conflock(struct file_lock *new, struct file_lock *fl)
 {
-	new->fl_owner = fl->fl_owner;
-	new->fl_pid = fl->fl_pid;
-	new->fl_file = NULL;
-	new->fl_flags = fl->fl_flags;
-	new->fl_type = fl->fl_type;
+	new->fl_core.fl_owner = fl->fl_core.fl_owner;
+	new->fl_core.fl_pid = fl->fl_core.fl_pid;
+	new->fl_core.fl_file = NULL;
+	new->fl_core.fl_flags = fl->fl_core.fl_flags;
+	new->fl_core.fl_type = fl->fl_core.fl_type;
 	new->fl_start = fl->fl_start;
 	new->fl_end = fl->fl_end;
 	new->fl_lmops = fl->fl_lmops;
@@ -372,7 +375,7 @@ void locks_copy_conflock(struct file_lock *new, struct file_lock *fl)
 
 	if (fl->fl_lmops) {
 		if (fl->fl_lmops->lm_get_owner)
-			fl->fl_lmops->lm_get_owner(fl->fl_owner);
+			fl->fl_lmops->lm_get_owner(fl->fl_core.fl_owner);
 	}
 }
 EXPORT_SYMBOL(locks_copy_conflock);
@@ -384,7 +387,7 @@ void locks_copy_lock(struct file_lock *new, struct file_lock *fl)
 
 	locks_copy_conflock(new, fl);
 
-	new->fl_file = fl->fl_file;
+	new->fl_core.fl_file = fl->fl_core.fl_file;
 	new->fl_ops = fl->fl_ops;
 
 	if (fl->fl_ops) {
@@ -403,12 +406,14 @@ static void locks_move_blocks(struct file_lock *new, struct file_lock *fl)
 	 * ->fl_blocked_requests, so we don't need a lock to check if it
 	 * is empty.
 	 */
-	if (list_empty(&fl->fl_blocked_requests))
+	if (list_empty(&fl->fl_core.fl_blocked_requests))
 		return;
 	spin_lock(&blocked_lock_lock);
-	list_splice_init(&fl->fl_blocked_requests, &new->fl_blocked_requests);
-	list_for_each_entry(f, &new->fl_blocked_requests, fl_blocked_member)
-		f->fl_blocker = new;
+	list_splice_init(&fl->fl_core.fl_blocked_requests,
+			 &new->fl_core.fl_blocked_requests);
+	list_for_each_entry(f, &new->fl_core.fl_blocked_requests,
+			    fl_blocked_member)
+		f->fl_core.fl_blocker = new;
 	spin_unlock(&blocked_lock_lock);
 }
 
@@ -429,11 +434,11 @@ static void flock_make_lock(struct file *filp, struct file_lock *fl, int type)
 {
 	locks_init_lock(fl);
 
-	fl->fl_file = filp;
-	fl->fl_owner = filp;
-	fl->fl_pid = current->tgid;
-	fl->fl_flags = FL_FLOCK;
-	fl->fl_type = type;
+	fl->fl_core.fl_file = filp;
+	fl->fl_core.fl_owner = filp;
+	fl->fl_core.fl_pid = current->tgid;
+	fl->fl_core.fl_flags = FL_FLOCK;
+	fl->fl_core.fl_type = type;
 	fl->fl_end = OFFSET_MAX;
 }
 
@@ -443,7 +448,7 @@ static int assign_type(struct file_lock *fl, int type)
 	case F_RDLCK:
 	case F_WRLCK:
 	case F_UNLCK:
-		fl->fl_type = type;
+		fl->fl_core.fl_type = type;
 		break;
 	default:
 		return -EINVAL;
@@ -488,10 +493,10 @@ static int flock64_to_posix_lock(struct file *filp, struct file_lock *fl,
 	} else
 		fl->fl_end = OFFSET_MAX;
 
-	fl->fl_owner = current->files;
-	fl->fl_pid = current->tgid;
-	fl->fl_file = filp;
-	fl->fl_flags = FL_POSIX;
+	fl->fl_core.fl_owner = current->files;
+	fl->fl_core.fl_pid = current->tgid;
+	fl->fl_core.fl_file = filp;
+	fl->fl_core.fl_flags = FL_POSIX;
 	fl->fl_ops = NULL;
 	fl->fl_lmops = NULL;
 
@@ -525,7 +530,7 @@ lease_break_callback(struct file_lock *fl)
 static void
 lease_setup(struct file_lock *fl, void **priv)
 {
-	struct file *filp = fl->fl_file;
+	struct file *filp = fl->fl_core.fl_file;
 	struct fasync_struct *fa = *priv;
 
 	/*
@@ -553,11 +558,11 @@ static int lease_init(struct file *filp, int type, struct file_lock *fl)
 	if (assign_type(fl, type) != 0)
 		return -EINVAL;
 
-	fl->fl_owner = filp;
-	fl->fl_pid = current->tgid;
+	fl->fl_core.fl_owner = filp;
+	fl->fl_core.fl_pid = current->tgid;
 
-	fl->fl_file = filp;
-	fl->fl_flags = FL_LEASE;
+	fl->fl_core.fl_file = filp;
+	fl->fl_core.fl_flags = FL_LEASE;
 	fl->fl_start = 0;
 	fl->fl_end = OFFSET_MAX;
 	fl->fl_ops = NULL;
@@ -595,7 +600,7 @@ static inline int locks_overlap(struct file_lock *fl1, struct file_lock *fl2)
  */
 static int posix_same_owner(struct file_lock *fl1, struct file_lock *fl2)
 {
-	return fl1->fl_owner == fl2->fl_owner;
+	return fl1->fl_core.fl_owner == fl2->fl_core.fl_owner;
 }
 
 /* Must be called with the flc_lock held! */
@@ -606,8 +611,8 @@ static void locks_insert_global_locks(struct file_lock *fl)
 	percpu_rwsem_assert_held(&file_rwsem);
 
 	spin_lock(&fll->lock);
-	fl->fl_link_cpu = smp_processor_id();
-	hlist_add_head(&fl->fl_link, &fll->hlist);
+	fl->fl_core.fl_link_cpu = smp_processor_id();
+	hlist_add_head(&fl->fl_core.fl_link, &fll->hlist);
 	spin_unlock(&fll->lock);
 }
 
@@ -623,33 +628,34 @@ static void locks_delete_global_locks(struct file_lock *fl)
 	 * is done while holding the flc_lock, and new insertions into the list
 	 * also require that it be held.
 	 */
-	if (hlist_unhashed(&fl->fl_link))
+	if (hlist_unhashed(&fl->fl_core.fl_link))
 		return;
 
-	fll = per_cpu_ptr(&file_lock_list, fl->fl_link_cpu);
+	fll = per_cpu_ptr(&file_lock_list, fl->fl_core.fl_link_cpu);
 	spin_lock(&fll->lock);
-	hlist_del_init(&fl->fl_link);
+	hlist_del_init(&fl->fl_core.fl_link);
 	spin_unlock(&fll->lock);
 }
 
 static unsigned long
 posix_owner_key(struct file_lock *fl)
 {
-	return (unsigned long)fl->fl_owner;
+	return (unsigned long) fl->fl_core.fl_owner;
 }
 
 static void locks_insert_global_blocked(struct file_lock *waiter)
 {
 	lockdep_assert_held(&blocked_lock_lock);
 
-	hash_add(blocked_hash, &waiter->fl_link, posix_owner_key(waiter));
+	hash_add(blocked_hash, &waiter->fl_core.fl_link,
+		 posix_owner_key(waiter));
 }
 
 static void locks_delete_global_blocked(struct file_lock *waiter)
 {
 	lockdep_assert_held(&blocked_lock_lock);
 
-	hash_del(&waiter->fl_link);
+	hash_del(&waiter->fl_core.fl_link);
 }
 
 /* Remove waiter from blocker's block list.
@@ -660,28 +666,28 @@ static void locks_delete_global_blocked(struct file_lock *waiter)
 static void __locks_delete_block(struct file_lock *waiter)
 {
 	locks_delete_global_blocked(waiter);
-	list_del_init(&waiter->fl_blocked_member);
+	list_del_init(&waiter->fl_core.fl_blocked_member);
 }
 
 static void __locks_wake_up_blocks(struct file_lock *blocker)
 {
-	while (!list_empty(&blocker->fl_blocked_requests)) {
+	while (!list_empty(&blocker->fl_core.fl_blocked_requests)) {
 		struct file_lock *waiter;
 
-		waiter = list_first_entry(&blocker->fl_blocked_requests,
+		waiter = list_first_entry(&blocker->fl_core.fl_blocked_requests,
 					  struct file_lock, fl_blocked_member);
 		__locks_delete_block(waiter);
 		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
 			waiter->fl_lmops->lm_notify(waiter);
 		else
-			wake_up(&waiter->fl_wait);
+			wake_up(&waiter->fl_core.fl_wait);
 
 		/*
 		 * The setting of fl_blocker to NULL marks the "done"
 		 * point in deleting a block. Paired with acquire at the top
 		 * of locks_delete_block().
 		 */
-		smp_store_release(&waiter->fl_blocker, NULL);
+		smp_store_release(&waiter->fl_core.fl_blocker, NULL);
 	}
 }
 
@@ -716,12 +722,12 @@ int locks_delete_block(struct file_lock *waiter)
 	 * no new locks can be inserted into its fl_blocked_requests list, and
 	 * can avoid doing anything further if the list is empty.
 	 */
-	if (!smp_load_acquire(&waiter->fl_blocker) &&
-	    list_empty(&waiter->fl_blocked_requests))
+	if (!smp_load_acquire(&waiter->fl_core.fl_blocker) &&
+	    list_empty(&waiter->fl_core.fl_blocked_requests))
 		return status;
 
 	spin_lock(&blocked_lock_lock);
-	if (waiter->fl_blocker)
+	if (waiter->fl_core.fl_blocker)
 		status = 0;
 	__locks_wake_up_blocks(waiter);
 	__locks_delete_block(waiter);
@@ -730,7 +736,7 @@ int locks_delete_block(struct file_lock *waiter)
 	 * The setting of fl_blocker to NULL marks the "done" point in deleting
 	 * a block. Paired with acquire at the top of this function.
 	 */
-	smp_store_release(&waiter->fl_blocker, NULL);
+	smp_store_release(&waiter->fl_core.fl_blocker, NULL);
 	spin_unlock(&blocked_lock_lock);
 	return status;
 }
@@ -757,16 +763,18 @@ static void __locks_insert_block(struct file_lock *blocker,
 					       struct file_lock *))
 {
 	struct file_lock *fl;
-	BUG_ON(!list_empty(&waiter->fl_blocked_member));
+	BUG_ON(!list_empty(&waiter->fl_core.fl_blocked_member));
 
 new_blocker:
-	list_for_each_entry(fl, &blocker->fl_blocked_requests, fl_blocked_member)
+	list_for_each_entry(fl, &blocker->fl_core.fl_blocked_requests,
+			    fl_blocked_member)
 		if (conflict(fl, waiter)) {
 			blocker =  fl;
 			goto new_blocker;
 		}
-	waiter->fl_blocker = blocker;
-	list_add_tail(&waiter->fl_blocked_member, &blocker->fl_blocked_requests);
+	waiter->fl_core.fl_blocker = blocker;
+	list_add_tail(&waiter->fl_core.fl_blocked_member,
+		      &blocker->fl_core.fl_blocked_requests);
 	if (IS_POSIX(blocker) && !IS_OFDLCK(blocker))
 		locks_insert_global_blocked(waiter);
 
@@ -802,7 +810,7 @@ static void locks_wake_up_blocks(struct file_lock *blocker)
 	 * fl_blocked_requests list does not require the flc_lock, so we must
 	 * recheck list_empty() after acquiring the blocked_lock_lock.
 	 */
-	if (list_empty(&blocker->fl_blocked_requests))
+	if (list_empty(&blocker->fl_core.fl_blocked_requests))
 		return;
 
 	spin_lock(&blocked_lock_lock);
@@ -813,7 +821,7 @@ static void locks_wake_up_blocks(struct file_lock *blocker)
 static void
 locks_insert_lock_ctx(struct file_lock *fl, struct list_head *before)
 {
-	list_add_tail(&fl->fl_list, before);
+	list_add_tail(&fl->fl_core.fl_list, before);
 	locks_insert_global_locks(fl);
 }
 
@@ -821,7 +829,7 @@ static void
 locks_unlink_lock_ctx(struct file_lock *fl)
 {
 	locks_delete_global_locks(fl);
-	list_del_init(&fl->fl_list);
+	list_del_init(&fl->fl_core.fl_list);
 	locks_wake_up_blocks(fl);
 }
 
@@ -830,7 +838,7 @@ locks_delete_lock_ctx(struct file_lock *fl, struct list_head *dispose)
 {
 	locks_unlink_lock_ctx(fl);
 	if (dispose)
-		list_add(&fl->fl_list, dispose);
+		list_add(&fl->fl_core.fl_list, dispose);
 	else
 		locks_free_lock(fl);
 }
@@ -841,9 +849,9 @@ locks_delete_lock_ctx(struct file_lock *fl, struct list_head *dispose)
 static bool locks_conflict(struct file_lock *caller_fl,
 			   struct file_lock *sys_fl)
 {
-	if (sys_fl->fl_type == F_WRLCK)
+	if (sys_fl->fl_core.fl_type == F_WRLCK)
 		return true;
-	if (caller_fl->fl_type == F_WRLCK)
+	if (caller_fl->fl_core.fl_type == F_WRLCK)
 		return true;
 	return false;
 }
@@ -874,7 +882,7 @@ static bool posix_test_locks_conflict(struct file_lock *caller_fl,
 				      struct file_lock *sys_fl)
 {
 	/* F_UNLCK checks any locks on the same fd. */
-	if (caller_fl->fl_type == F_UNLCK) {
+	if (caller_fl->fl_core.fl_type == F_UNLCK) {
 		if (!posix_same_owner(caller_fl, sys_fl))
 			return false;
 		return locks_overlap(caller_fl, sys_fl);
@@ -891,7 +899,7 @@ static bool flock_locks_conflict(struct file_lock *caller_fl,
 	/* FLOCK locks referring to the same filp do not conflict with
 	 * each other.
 	 */
-	if (caller_fl->fl_file == sys_fl->fl_file)
+	if (caller_fl->fl_core.fl_file == sys_fl->fl_core.fl_file)
 		return false;
 
 	return locks_conflict(caller_fl, sys_fl);
@@ -908,7 +916,7 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 
 	ctx = locks_inode_context(inode);
 	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
-		fl->fl_type = F_UNLCK;
+		fl->fl_core.fl_type = F_UNLCK;
 		return;
 	}
 
@@ -930,7 +938,7 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 		locks_copy_conflock(fl, cfl);
 		goto out;
 	}
-	fl->fl_type = F_UNLCK;
+	fl->fl_core.fl_type = F_UNLCK;
 out:
 	spin_unlock(&ctx->flc_lock);
 	return;
@@ -979,8 +987,8 @@ static struct file_lock *what_owner_is_waiting_for(struct file_lock *block_fl)
 
 	hash_for_each_possible(blocked_hash, fl, fl_link, posix_owner_key(block_fl)) {
 		if (posix_same_owner(fl, block_fl)) {
-			while (fl->fl_blocker)
-				fl = fl->fl_blocker;
+			while (fl->fl_core.fl_blocker)
+				fl = fl->fl_core.fl_blocker;
 			return fl;
 		}
 	}
@@ -1027,14 +1035,14 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 	bool found = false;
 	LIST_HEAD(dispose);
 
-	ctx = locks_get_lock_context(inode, request->fl_type);
+	ctx = locks_get_lock_context(inode, request->fl_core.fl_type);
 	if (!ctx) {
-		if (request->fl_type != F_UNLCK)
+		if (request->fl_core.fl_type != F_UNLCK)
 			return -ENOMEM;
-		return (request->fl_flags & FL_EXISTS) ? -ENOENT : 0;
+		return (request->fl_core.fl_flags & FL_EXISTS) ? -ENOENT : 0;
 	}
 
-	if (!(request->fl_flags & FL_ACCESS) && (request->fl_type != F_UNLCK)) {
+	if (!(request->fl_core.fl_flags & FL_ACCESS) && (request->fl_core.fl_type != F_UNLCK)) {
 		new_fl = locks_alloc_lock();
 		if (!new_fl)
 			return -ENOMEM;
@@ -1042,21 +1050,21 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
-	if (request->fl_flags & FL_ACCESS)
+	if (request->fl_core.fl_flags & FL_ACCESS)
 		goto find_conflict;
 
 	list_for_each_entry(fl, &ctx->flc_flock, fl_list) {
-		if (request->fl_file != fl->fl_file)
+		if (request->fl_core.fl_file != fl->fl_core.fl_file)
 			continue;
-		if (request->fl_type == fl->fl_type)
+		if (request->fl_core.fl_type == fl->fl_core.fl_type)
 			goto out;
 		found = true;
 		locks_delete_lock_ctx(fl, &dispose);
 		break;
 	}
 
-	if (request->fl_type == F_UNLCK) {
-		if ((request->fl_flags & FL_EXISTS) && !found)
+	if (request->fl_core.fl_type == F_UNLCK) {
+		if ((request->fl_core.fl_flags & FL_EXISTS) && !found)
 			error = -ENOENT;
 		goto out;
 	}
@@ -1066,13 +1074,13 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
 		if (!flock_locks_conflict(request, fl))
 			continue;
 		error = -EAGAIN;
-		if (!(request->fl_flags & FL_SLEEP))
+		if (!(request->fl_core.fl_flags & FL_SLEEP))
 			goto out;
 		error = FILE_LOCK_DEFERRED;
 		locks_insert_block(fl, request, flock_locks_conflict);
 		goto out;
 	}
-	if (request->fl_flags & FL_ACCESS)
+	if (request->fl_core.fl_flags & FL_ACCESS)
 		goto out;
 	locks_copy_lock(new_fl, request);
 	locks_move_blocks(new_fl, request);
@@ -1105,9 +1113,9 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	void *owner;
 	void (*func)(void);
 
-	ctx = locks_get_lock_context(inode, request->fl_type);
+	ctx = locks_get_lock_context(inode, request->fl_core.fl_type);
 	if (!ctx)
-		return (request->fl_type == F_UNLCK) ? 0 : -ENOMEM;
+		return (request->fl_core.fl_type == F_UNLCK) ? 0 : -ENOMEM;
 
 	/*
 	 * We may need two file_lock structures for this operation,
@@ -1115,8 +1123,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	 *
 	 * In some cases we can be sure, that no new locks will be needed
 	 */
-	if (!(request->fl_flags & FL_ACCESS) &&
-	    (request->fl_type != F_UNLCK ||
+	if (!(request->fl_core.fl_flags & FL_ACCESS) &&
+	    (request->fl_core.fl_type != F_UNLCK ||
 	     request->fl_start != 0 || request->fl_end != OFFSET_MAX)) {
 		new_fl = locks_alloc_lock();
 		new_fl2 = locks_alloc_lock();
@@ -1130,7 +1138,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	 * there are any, either return error or put the request on the
 	 * blocker's list of waiters and the global blocked_hash.
 	 */
-	if (request->fl_type != F_UNLCK) {
+	if (request->fl_core.fl_type != F_UNLCK) {
 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
 			if (!posix_locks_conflict(request, fl))
 				continue;
@@ -1148,7 +1156,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			if (conflock)
 				locks_copy_conflock(conflock, fl);
 			error = -EAGAIN;
-			if (!(request->fl_flags & FL_SLEEP))
+			if (!(request->fl_core.fl_flags & FL_SLEEP))
 				goto out;
 			/*
 			 * Deadlock detection and insertion into the blocked
@@ -1173,7 +1181,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 
 	/* If we're just looking for a conflict, we're done. */
 	error = 0;
-	if (request->fl_flags & FL_ACCESS)
+	if (request->fl_core.fl_flags & FL_ACCESS)
 		goto out;
 
 	/* Find the first old lock with the same owner as the new lock */
@@ -1188,7 +1196,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			break;
 
 		/* Detect adjacent or overlapping regions (if same lock type) */
-		if (request->fl_type == fl->fl_type) {
+		if (request->fl_core.fl_type == fl->fl_core.fl_type) {
 			/* In all comparisons of start vs end, use
 			 * "start - 1" rather than "end + 1". If end
 			 * is OFFSET_MAX, end + 1 will become negative.
@@ -1228,7 +1236,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 				continue;
 			if (fl->fl_start > request->fl_end)
 				break;
-			if (request->fl_type == F_UNLCK)
+			if (request->fl_core.fl_type == F_UNLCK)
 				added = true;
 			if (fl->fl_start < request->fl_start)
 				left = fl;
@@ -1261,7 +1269,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 				locks_move_blocks(new_fl, request);
 				request = new_fl;
 				new_fl = NULL;
-				locks_insert_lock_ctx(request, &fl->fl_list);
+				locks_insert_lock_ctx(request,
+						      &fl->fl_core.fl_list);
 				locks_delete_lock_ctx(fl, &dispose);
 				added = true;
 			}
@@ -1279,8 +1288,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 
 	error = 0;
 	if (!added) {
-		if (request->fl_type == F_UNLCK) {
-			if (request->fl_flags & FL_EXISTS)
+		if (request->fl_core.fl_type == F_UNLCK) {
+			if (request->fl_core.fl_flags & FL_EXISTS)
 				error = -ENOENT;
 			goto out;
 		}
@@ -1291,7 +1300,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		}
 		locks_copy_lock(new_fl, request);
 		locks_move_blocks(new_fl, request);
-		locks_insert_lock_ctx(new_fl, &fl->fl_list);
+		locks_insert_lock_ctx(new_fl, &fl->fl_core.fl_list);
 		fl = new_fl;
 		new_fl = NULL;
 	}
@@ -1303,7 +1312,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 			left = new_fl2;
 			new_fl2 = NULL;
 			locks_copy_lock(left, right);
-			locks_insert_lock_ctx(left, &fl->fl_list);
+			locks_insert_lock_ctx(left, &fl->fl_core.fl_list);
 		}
 		right->fl_start = request->fl_end + 1;
 		locks_wake_up_blocks(right);
@@ -1364,8 +1373,8 @@ static int posix_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		error = posix_lock_inode(inode, fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait,
-					list_empty(&fl->fl_blocked_member));
+		error = wait_event_interruptible(fl->fl_core.fl_wait,
+						 list_empty(&fl->fl_core.fl_blocked_member));
 		if (error)
 			break;
 	}
@@ -1377,10 +1386,10 @@ static void lease_clear_pending(struct file_lock *fl, int arg)
 {
 	switch (arg) {
 	case F_UNLCK:
-		fl->fl_flags &= ~FL_UNLOCK_PENDING;
+		fl->fl_core.fl_flags &= ~FL_UNLOCK_PENDING;
 		fallthrough;
 	case F_RDLCK:
-		fl->fl_flags &= ~FL_DOWNGRADE_PENDING;
+		fl->fl_core.fl_flags &= ~FL_DOWNGRADE_PENDING;
 	}
 }
 
@@ -1394,11 +1403,11 @@ int lease_modify(struct file_lock *fl, int arg, struct list_head *dispose)
 	lease_clear_pending(fl, arg);
 	locks_wake_up_blocks(fl);
 	if (arg == F_UNLCK) {
-		struct file *filp = fl->fl_file;
+		struct file *filp = fl->fl_core.fl_file;
 
 		f_delown(filp);
 		filp->f_owner.signum = 0;
-		fasync_helper(0, fl->fl_file, 0, &fl->fl_fasync);
+		fasync_helper(0, fl->fl_core.fl_file, 0, &fl->fl_fasync);
 		if (fl->fl_fasync != NULL) {
 			printk(KERN_ERR "locks_delete_lock: fasync == %p\n", fl->fl_fasync);
 			fl->fl_fasync = NULL;
@@ -1440,11 +1449,11 @@ static bool leases_conflict(struct file_lock *lease, struct file_lock *breaker)
 	if (lease->fl_lmops->lm_breaker_owns_lease
 			&& lease->fl_lmops->lm_breaker_owns_lease(lease))
 		return false;
-	if ((breaker->fl_flags & FL_LAYOUT) != (lease->fl_flags & FL_LAYOUT)) {
+	if ((breaker->fl_core.fl_flags & FL_LAYOUT) != (lease->fl_core.fl_flags & FL_LAYOUT)) {
 		rc = false;
 		goto trace;
 	}
-	if ((breaker->fl_flags & FL_DELEG) && (lease->fl_flags & FL_LEASE)) {
+	if ((breaker->fl_core.fl_flags & FL_DELEG) && (lease->fl_core.fl_flags & FL_LEASE)) {
 		rc = false;
 		goto trace;
 	}
@@ -1495,7 +1504,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	new_fl = lease_alloc(NULL, want_write ? F_WRLCK : F_RDLCK);
 	if (IS_ERR(new_fl))
 		return PTR_ERR(new_fl);
-	new_fl->fl_flags = type;
+	new_fl->fl_core.fl_flags = type;
 
 	/* typically we will check that ctx is non-NULL before calling */
 	ctx = locks_inode_context(inode);
@@ -1523,14 +1532,14 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 		if (!leases_conflict(fl, new_fl))
 			continue;
 		if (want_write) {
-			if (fl->fl_flags & FL_UNLOCK_PENDING)
+			if (fl->fl_core.fl_flags & FL_UNLOCK_PENDING)
 				continue;
-			fl->fl_flags |= FL_UNLOCK_PENDING;
+			fl->fl_core.fl_flags |= FL_UNLOCK_PENDING;
 			fl->fl_break_time = break_time;
 		} else {
 			if (lease_breaking(fl))
 				continue;
-			fl->fl_flags |= FL_DOWNGRADE_PENDING;
+			fl->fl_core.fl_flags |= FL_DOWNGRADE_PENDING;
 			fl->fl_downgrade_time = break_time;
 		}
 		if (fl->fl_lmops->lm_break(fl))
@@ -1559,9 +1568,9 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	percpu_up_read(&file_rwsem);
 
 	locks_dispose_list(&dispose);
-	error = wait_event_interruptible_timeout(new_fl->fl_wait,
-					list_empty(&new_fl->fl_blocked_member),
-					break_time);
+	error = wait_event_interruptible_timeout(new_fl->fl_core.fl_wait,
+						 list_empty(&new_fl->fl_core.fl_blocked_member),
+						 break_time);
 
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
@@ -1608,7 +1617,7 @@ void lease_get_mtime(struct inode *inode, struct timespec64 *time)
 		spin_lock(&ctx->flc_lock);
 		fl = list_first_entry_or_null(&ctx->flc_lease,
 					      struct file_lock, fl_list);
-		if (fl && (fl->fl_type == F_WRLCK))
+		if (fl && (fl->fl_core.fl_type == F_WRLCK))
 			has_lease = true;
 		spin_unlock(&ctx->flc_lock);
 	}
@@ -1655,7 +1664,7 @@ int fcntl_getlease(struct file *filp)
 		spin_lock(&ctx->flc_lock);
 		time_out_leases(inode, &dispose);
 		list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
-			if (fl->fl_file != filp)
+			if (fl->fl_core.fl_file != filp)
 				continue;
 			type = target_leasetype(fl);
 			break;
@@ -1720,7 +1729,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 	struct file_lock *fl, *my_fl = NULL, *lease;
 	struct inode *inode = file_inode(filp);
 	struct file_lock_context *ctx;
-	bool is_deleg = (*flp)->fl_flags & FL_DELEG;
+	bool is_deleg = (*flp)->fl_core.fl_flags & FL_DELEG;
 	int error;
 	LIST_HEAD(dispose);
 
@@ -1746,7 +1755,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
 	time_out_leases(inode, &dispose);
-	error = check_conflicting_open(filp, arg, lease->fl_flags);
+	error = check_conflicting_open(filp, arg, lease->fl_core.fl_flags);
 	if (error)
 		goto out;
 
@@ -1760,8 +1769,8 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 	 */
 	error = -EAGAIN;
 	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
-		if (fl->fl_file == filp &&
-		    fl->fl_owner == lease->fl_owner) {
+		if (fl->fl_core.fl_file == filp &&
+		    fl->fl_core.fl_owner == lease->fl_core.fl_owner) {
 			my_fl = fl;
 			continue;
 		}
@@ -1776,7 +1785,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 		 * Modifying our existing lease is OK, but no getting a
 		 * new lease if someone else is opening for write:
 		 */
-		if (fl->fl_flags & FL_UNLOCK_PENDING)
+		if (fl->fl_core.fl_flags & FL_UNLOCK_PENDING)
 			goto out;
 	}
 
@@ -1803,7 +1812,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
 	 * precedes these checks.
 	 */
 	smp_mb();
-	error = check_conflicting_open(filp, arg, lease->fl_flags);
+	error = check_conflicting_open(filp, arg, lease->fl_core.fl_flags);
 	if (error) {
 		locks_unlink_lock_ctx(lease);
 		goto out;
@@ -1840,8 +1849,8 @@ static int generic_delete_lease(struct file *filp, void *owner)
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
 	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
-		if (fl->fl_file == filp &&
-		    fl->fl_owner == owner) {
+		if (fl->fl_core.fl_file == filp &&
+		    fl->fl_core.fl_owner == owner) {
 			victim = fl;
 			break;
 		}
@@ -2017,8 +2026,8 @@ static int flock_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 		error = flock_lock_inode(inode, fl);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait,
-				list_empty(&fl->fl_blocked_member));
+		error = wait_event_interruptible(fl->fl_core.fl_wait,
+						 list_empty(&fl->fl_core.fl_blocked_member));
 		if (error)
 			break;
 	}
@@ -2036,7 +2045,7 @@ static int flock_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 {
 	int res = 0;
-	switch (fl->fl_flags & (FL_POSIX|FL_FLOCK)) {
+	switch (fl->fl_core.fl_flags & (FL_POSIX|FL_FLOCK)) {
 		case FL_POSIX:
 			res = posix_lock_inode_wait(inode, fl);
 			break;
@@ -2098,13 +2107,13 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 
 	flock_make_lock(f.file, &fl, type);
 
-	error = security_file_lock(f.file, fl.fl_type);
+	error = security_file_lock(f.file, fl.fl_core.fl_type);
 	if (error)
 		goto out_putf;
 
 	can_sleep = !(cmd & LOCK_NB);
 	if (can_sleep)
-		fl.fl_flags |= FL_SLEEP;
+		fl.fl_core.fl_flags |= FL_SLEEP;
 
 	if (f.file->f_op->flock)
 		error = f.file->f_op->flock(f.file,
@@ -2130,7 +2139,7 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
  */
 int vfs_test_lock(struct file *filp, struct file_lock *fl)
 {
-	WARN_ON_ONCE(filp != fl->fl_file);
+	WARN_ON_ONCE(filp != fl->fl_core.fl_file);
 	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, F_GETLK, fl);
 	posix_test_lock(filp, fl);
@@ -2153,17 +2162,17 @@ static pid_t locks_translate_pid(struct file_lock *fl, struct pid_namespace *ns)
 	if (IS_OFDLCK(fl))
 		return -1;
 	if (IS_REMOTELCK(fl))
-		return fl->fl_pid;
+		return fl->fl_core.fl_pid;
 	/*
 	 * If the flock owner process is dead and its pid has been already
 	 * freed, the translation below won't work, but we still want to show
 	 * flock owner pid number in init pidns.
 	 */
 	if (ns == &init_pid_ns)
-		return (pid_t)fl->fl_pid;
+		return (pid_t) fl->fl_core.fl_pid;
 
 	rcu_read_lock();
-	pid = find_pid_ns(fl->fl_pid, &init_pid_ns);
+	pid = find_pid_ns(fl->fl_core.fl_pid, &init_pid_ns);
 	vnr = pid_nr_ns(pid, ns);
 	rcu_read_unlock();
 	return vnr;
@@ -2186,7 +2195,7 @@ static int posix_lock_to_flock(struct flock *flock, struct file_lock *fl)
 	flock->l_len = fl->fl_end == OFFSET_MAX ? 0 :
 		fl->fl_end - fl->fl_start + 1;
 	flock->l_whence = 0;
-	flock->l_type = fl->fl_type;
+	flock->l_type = fl->fl_core.fl_type;
 	return 0;
 }
 
@@ -2198,7 +2207,7 @@ static void posix_lock_to_flock64(struct flock64 *flock, struct file_lock *fl)
 	flock->l_len = fl->fl_end == OFFSET_MAX ? 0 :
 		fl->fl_end - fl->fl_start + 1;
 	flock->l_whence = 0;
-	flock->l_type = fl->fl_type;
+	flock->l_type = fl->fl_core.fl_type;
 }
 #endif
 
@@ -2227,16 +2236,16 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
 		if (flock->l_pid != 0)
 			goto out;
 
-		fl->fl_flags |= FL_OFDLCK;
-		fl->fl_owner = filp;
+		fl->fl_core.fl_flags |= FL_OFDLCK;
+		fl->fl_core.fl_owner = filp;
 	}
 
 	error = vfs_test_lock(filp, fl);
 	if (error)
 		goto out;
 
-	flock->l_type = fl->fl_type;
-	if (fl->fl_type != F_UNLCK) {
+	flock->l_type = fl->fl_core.fl_type;
+	if (fl->fl_core.fl_type != F_UNLCK) {
 		error = posix_lock_to_flock(flock, fl);
 		if (error)
 			goto out;
@@ -2283,7 +2292,7 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
  */
 int vfs_lock_file(struct file *filp, unsigned int cmd, struct file_lock *fl, struct file_lock *conf)
 {
-	WARN_ON_ONCE(filp != fl->fl_file);
+	WARN_ON_ONCE(filp != fl->fl_core.fl_file);
 	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, cmd, fl);
 	else
@@ -2296,7 +2305,7 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
 {
 	int error;
 
-	error = security_file_lock(filp, fl->fl_type);
+	error = security_file_lock(filp, fl->fl_core.fl_type);
 	if (error)
 		return error;
 
@@ -2304,8 +2313,8 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
 		error = vfs_lock_file(filp, cmd, fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
-		error = wait_event_interruptible(fl->fl_wait,
-					list_empty(&fl->fl_blocked_member));
+		error = wait_event_interruptible(fl->fl_core.fl_wait,
+						 list_empty(&fl->fl_core.fl_blocked_member));
 		if (error)
 			break;
 	}
@@ -2318,13 +2327,13 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
 static int
 check_fmode_for_setlk(struct file_lock *fl)
 {
-	switch (fl->fl_type) {
+	switch (fl->fl_core.fl_type) {
 	case F_RDLCK:
-		if (!(fl->fl_file->f_mode & FMODE_READ))
+		if (!(fl->fl_core.fl_file->f_mode & FMODE_READ))
 			return -EBADF;
 		break;
 	case F_WRLCK:
-		if (!(fl->fl_file->f_mode & FMODE_WRITE))
+		if (!(fl->fl_core.fl_file->f_mode & FMODE_WRITE))
 			return -EBADF;
 	}
 	return 0;
@@ -2363,8 +2372,8 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 			goto out;
 
 		cmd = F_SETLK;
-		file_lock->fl_flags |= FL_OFDLCK;
-		file_lock->fl_owner = filp;
+		file_lock->fl_core.fl_flags |= FL_OFDLCK;
+		file_lock->fl_core.fl_owner = filp;
 		break;
 	case F_OFD_SETLKW:
 		error = -EINVAL;
@@ -2372,11 +2381,11 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 			goto out;
 
 		cmd = F_SETLKW;
-		file_lock->fl_flags |= FL_OFDLCK;
-		file_lock->fl_owner = filp;
+		file_lock->fl_core.fl_flags |= FL_OFDLCK;
+		file_lock->fl_core.fl_owner = filp;
 		fallthrough;
 	case F_SETLKW:
-		file_lock->fl_flags |= FL_SLEEP;
+		file_lock->fl_core.fl_flags |= FL_SLEEP;
 	}
 
 	error = do_lock_file_wait(filp, cmd, file_lock);
@@ -2386,8 +2395,8 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 	 * lock that was just acquired. There is no need to do that when we're
 	 * unlocking though, or for OFD locks.
 	 */
-	if (!error && file_lock->fl_type != F_UNLCK &&
-	    !(file_lock->fl_flags & FL_OFDLCK)) {
+	if (!error && file_lock->fl_core.fl_type != F_UNLCK &&
+	    !(file_lock->fl_core.fl_flags & FL_OFDLCK)) {
 		struct files_struct *files = current->files;
 		/*
 		 * We need that spin_lock here - it prevents reordering between
@@ -2398,7 +2407,7 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 		f = files_lookup_fd_locked(files, fd);
 		spin_unlock(&files->file_lock);
 		if (f != filp) {
-			file_lock->fl_type = F_UNLCK;
+			file_lock->fl_core.fl_type = F_UNLCK;
 			error = do_lock_file_wait(filp, cmd, file_lock);
 			WARN_ON_ONCE(error);
 			error = -EBADF;
@@ -2437,16 +2446,16 @@ int fcntl_getlk64(struct file *filp, unsigned int cmd, struct flock64 *flock)
 		if (flock->l_pid != 0)
 			goto out;
 
-		fl->fl_flags |= FL_OFDLCK;
-		fl->fl_owner = filp;
+		fl->fl_core.fl_flags |= FL_OFDLCK;
+		fl->fl_core.fl_owner = filp;
 	}
 
 	error = vfs_test_lock(filp, fl);
 	if (error)
 		goto out;
 
-	flock->l_type = fl->fl_type;
-	if (fl->fl_type != F_UNLCK)
+	flock->l_type = fl->fl_core.fl_type;
+	if (fl->fl_core.fl_type != F_UNLCK)
 		posix_lock_to_flock64(flock, fl);
 
 out:
@@ -2486,8 +2495,8 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 			goto out;
 
 		cmd = F_SETLK64;
-		file_lock->fl_flags |= FL_OFDLCK;
-		file_lock->fl_owner = filp;
+		file_lock->fl_core.fl_flags |= FL_OFDLCK;
+		file_lock->fl_core.fl_owner = filp;
 		break;
 	case F_OFD_SETLKW:
 		error = -EINVAL;
@@ -2495,11 +2504,11 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 			goto out;
 
 		cmd = F_SETLKW64;
-		file_lock->fl_flags |= FL_OFDLCK;
-		file_lock->fl_owner = filp;
+		file_lock->fl_core.fl_flags |= FL_OFDLCK;
+		file_lock->fl_core.fl_owner = filp;
 		fallthrough;
 	case F_SETLKW64:
-		file_lock->fl_flags |= FL_SLEEP;
+		file_lock->fl_core.fl_flags |= FL_SLEEP;
 	}
 
 	error = do_lock_file_wait(filp, cmd, file_lock);
@@ -2509,8 +2518,8 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 	 * lock that was just acquired. There is no need to do that when we're
 	 * unlocking though, or for OFD locks.
 	 */
-	if (!error && file_lock->fl_type != F_UNLCK &&
-	    !(file_lock->fl_flags & FL_OFDLCK)) {
+	if (!error && file_lock->fl_core.fl_type != F_UNLCK &&
+	    !(file_lock->fl_core.fl_flags & FL_OFDLCK)) {
 		struct files_struct *files = current->files;
 		/*
 		 * We need that spin_lock here - it prevents reordering between
@@ -2521,7 +2530,7 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 		f = files_lookup_fd_locked(files, fd);
 		spin_unlock(&files->file_lock);
 		if (f != filp) {
-			file_lock->fl_type = F_UNLCK;
+			file_lock->fl_core.fl_type = F_UNLCK;
 			error = do_lock_file_wait(filp, cmd, file_lock);
 			WARN_ON_ONCE(error);
 			error = -EBADF;
@@ -2555,13 +2564,13 @@ void locks_remove_posix(struct file *filp, fl_owner_t owner)
 		return;
 
 	locks_init_lock(&lock);
-	lock.fl_type = F_UNLCK;
-	lock.fl_flags = FL_POSIX | FL_CLOSE;
+	lock.fl_core.fl_type = F_UNLCK;
+	lock.fl_core.fl_flags = FL_POSIX | FL_CLOSE;
 	lock.fl_start = 0;
 	lock.fl_end = OFFSET_MAX;
-	lock.fl_owner = owner;
-	lock.fl_pid = current->tgid;
-	lock.fl_file = filp;
+	lock.fl_core.fl_owner = owner;
+	lock.fl_core.fl_pid = current->tgid;
+	lock.fl_core.fl_file = filp;
 	lock.fl_ops = NULL;
 	lock.fl_lmops = NULL;
 
@@ -2584,7 +2593,7 @@ locks_remove_flock(struct file *filp, struct file_lock_context *flctx)
 		return;
 
 	flock_make_lock(filp, &fl, F_UNLCK);
-	fl.fl_flags |= FL_CLOSE;
+	fl.fl_core.fl_flags |= FL_CLOSE;
 
 	if (filp->f_op->flock)
 		filp->f_op->flock(filp, F_SETLKW, &fl);
@@ -2608,7 +2617,7 @@ locks_remove_lease(struct file *filp, struct file_lock_context *ctx)
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
 	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_list)
-		if (filp == fl->fl_file)
+		if (filp == fl->fl_core.fl_file)
 			lease_modify(fl, F_UNLCK, &dispose);
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
@@ -2652,7 +2661,7 @@ void locks_remove_file(struct file *filp)
  */
 int vfs_cancel_lock(struct file *filp, struct file_lock *fl)
 {
-	WARN_ON_ONCE(filp != fl->fl_file);
+	WARN_ON_ONCE(filp != fl->fl_core.fl_file);
 	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, F_CANCELLK, fl);
 	return 0;
@@ -2706,8 +2715,8 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	 * init_pid_ns to get saved lock pid value.
 	 */
 
-	if (fl->fl_file != NULL)
-		inode = file_inode(fl->fl_file);
+	if (fl->fl_core.fl_file != NULL)
+		inode = file_inode(fl->fl_core.fl_file);
 
 	seq_printf(f, "%lld: ", id);
 
@@ -2715,7 +2724,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 		seq_printf(f, "%*s", repeat - 1 + (int)strlen(pfx), pfx);
 
 	if (IS_POSIX(fl)) {
-		if (fl->fl_flags & FL_ACCESS)
+		if (fl->fl_core.fl_flags & FL_ACCESS)
 			seq_puts(f, "ACCESS");
 		else if (IS_OFDLCK(fl))
 			seq_puts(f, "OFDLCK");
@@ -2727,21 +2736,21 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	} else if (IS_FLOCK(fl)) {
 		seq_puts(f, "FLOCK  ADVISORY  ");
 	} else if (IS_LEASE(fl)) {
-		if (fl->fl_flags & FL_DELEG)
+		if (fl->fl_core.fl_flags & FL_DELEG)
 			seq_puts(f, "DELEG  ");
 		else
 			seq_puts(f, "LEASE  ");
 
 		if (lease_breaking(fl))
 			seq_puts(f, "BREAKING  ");
-		else if (fl->fl_file)
+		else if (fl->fl_core.fl_file)
 			seq_puts(f, "ACTIVE    ");
 		else
 			seq_puts(f, "BREAKER   ");
 	} else {
 		seq_puts(f, "UNKNOWN UNKNOWN  ");
 	}
-	type = IS_LEASE(fl) ? target_leasetype(fl) : fl->fl_type;
+	type = IS_LEASE(fl) ? target_leasetype(fl) : fl->fl_core.fl_type;
 
 	seq_printf(f, "%s ", (type == F_WRLCK) ? "WRITE" :
 			     (type == F_RDLCK) ? "READ" : "UNLCK");
@@ -2768,12 +2777,12 @@ static struct file_lock *get_next_blocked_member(struct file_lock *node)
 	struct file_lock *tmp;
 
 	/* NULL node or root node */
-	if (node == NULL || node->fl_blocker == NULL)
+	if (node == NULL || node->fl_core.fl_blocker == NULL)
 		return NULL;
 
 	/* Next member in the linked list could be itself */
 	tmp = list_next_entry(node, fl_blocked_member);
-	if (list_entry_is_head(tmp, &node->fl_blocker->fl_blocked_requests, fl_blocked_member)
+	if (list_entry_is_head(tmp, &node->fl_core.fl_blocker->fl_blocked_requests, fl_blocked_member)
 		|| tmp == node) {
 		return NULL;
 	}
@@ -2804,17 +2813,18 @@ static int locks_show(struct seq_file *f, void *v)
 		else
 			lock_get_status(f, cur, iter->li_pos, "", level);
 
-		if (!list_empty(&cur->fl_blocked_requests)) {
+		if (!list_empty(&cur->fl_core.fl_blocked_requests)) {
 			/* Turn left */
-			cur = list_first_entry_or_null(&cur->fl_blocked_requests,
-				struct file_lock, fl_blocked_member);
+			cur = list_first_entry_or_null(&cur->fl_core.fl_blocked_requests,
+						       struct file_lock,
+						       fl_blocked_member);
 			level++;
 		} else {
 			/* Turn right */
 			tmp = get_next_blocked_member(cur);
 			/* Fall back to parent node */
-			while (tmp == NULL && cur->fl_blocker != NULL) {
-				cur = cur->fl_blocker;
+			while (tmp == NULL && cur->fl_core.fl_blocker != NULL) {
+				cur = cur->fl_core.fl_blocker;
 				level--;
 				tmp = get_next_blocked_member(cur);
 			}
@@ -2833,10 +2843,10 @@ static void __show_fd_locks(struct seq_file *f,
 
 	list_for_each_entry(fl, head, fl_list) {
 
-		if (filp != fl->fl_file)
+		if (filp != fl->fl_core.fl_file)
 			continue;
-		if (fl->fl_owner != files &&
-		    fl->fl_owner != filp)
+		if (fl->fl_core.fl_owner != files &&
+		    fl->fl_core.fl_owner != filp)
 			continue;
 
 		(*id)++;
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index fa1a14def45c..31741967ab95 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -157,7 +157,7 @@ static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_state
 	spin_lock(&flctx->flc_lock);
 restart:
 	list_for_each_entry(fl, list, fl_list) {
-		if (nfs_file_open_context(fl->fl_file)->state != state)
+		if (nfs_file_open_context(fl->fl_core.fl_file)->state != state)
 			continue;
 		spin_unlock(&flctx->flc_lock);
 		status = nfs4_lock_delegation_recall(fl, state, stateid);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 8577ccf621f5..94c56c3d9177 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -720,15 +720,15 @@ do_getlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
 {
 	struct inode *inode = filp->f_mapping->host;
 	int status = 0;
-	unsigned int saved_type = fl->fl_type;
+	unsigned int saved_type = fl->fl_core.fl_type;
 
 	/* Try local locking first */
 	posix_test_lock(filp, fl);
-	if (fl->fl_type != F_UNLCK) {
+	if (fl->fl_core.fl_type != F_UNLCK) {
 		/* found a conflict */
 		goto out;
 	}
-	fl->fl_type = saved_type;
+	fl->fl_core.fl_type = saved_type;
 
 	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
 		goto out_noconflict;
@@ -740,7 +740,7 @@ do_getlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
 out:
 	return status;
 out_noconflict:
-	fl->fl_type = F_UNLCK;
+	fl->fl_core.fl_type = F_UNLCK;
 	goto out;
 }
 
@@ -765,7 +765,7 @@ do_unlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
 		 * 	If we're signalled while cleaning up locks on process exit, we
 		 * 	still need to complete the unlock.
 		 */
-		if (status < 0 && !(fl->fl_flags & FL_CLOSE))
+		if (status < 0 && !(fl->fl_core.fl_flags & FL_CLOSE))
 			return status;
 	}
 
@@ -832,12 +832,12 @@ int nfs_lock(struct file *filp, int cmd, struct file_lock *fl)
 	int is_local = 0;
 
 	dprintk("NFS: lock(%pD2, t=%x, fl=%x, r=%lld:%lld)\n",
-			filp, fl->fl_type, fl->fl_flags,
+			filp, fl->fl_core.fl_type, fl->fl_core.fl_flags,
 			(long long)fl->fl_start, (long long)fl->fl_end);
 
 	nfs_inc_stats(inode, NFSIOS_VFSLOCK);
 
-	if (fl->fl_flags & FL_RECLAIM)
+	if (fl->fl_core.fl_flags & FL_RECLAIM)
 		return -ENOGRACE;
 
 	if (NFS_SERVER(inode)->flags & NFS_MOUNT_LOCAL_FCNTL)
@@ -851,7 +851,7 @@ int nfs_lock(struct file *filp, int cmd, struct file_lock *fl)
 
 	if (IS_GETLK(cmd))
 		ret = do_getlk(filp, cmd, fl, is_local);
-	else if (fl->fl_type == F_UNLCK)
+	else if (fl->fl_core.fl_type == F_UNLCK)
 		ret = do_unlk(filp, cmd, fl, is_local);
 	else
 		ret = do_setlk(filp, cmd, fl, is_local);
@@ -869,16 +869,16 @@ int nfs_flock(struct file *filp, int cmd, struct file_lock *fl)
 	int is_local = 0;
 
 	dprintk("NFS: flock(%pD2, t=%x, fl=%x)\n",
-			filp, fl->fl_type, fl->fl_flags);
+			filp, fl->fl_core.fl_type, fl->fl_core.fl_flags);
 
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->fl_core.fl_flags & FL_FLOCK))
 		return -ENOLCK;
 
 	if (NFS_SERVER(inode)->flags & NFS_MOUNT_LOCAL_FLOCK)
 		is_local = 1;
 
 	/* We're simulating flock() locks using posix locks on the server */
-	if (fl->fl_type == F_UNLCK)
+	if (fl->fl_core.fl_type == F_UNLCK)
 		return do_unlk(filp, cmd, fl, is_local);
 	return do_setlk(filp, cmd, fl, is_local);
 }
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 2de66e4e8280..d6d8900d8d83 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -963,7 +963,7 @@ nfs3_proc_lock(struct file *filp, int cmd, struct file_lock *fl)
 	struct nfs_open_context *ctx = nfs_file_open_context(filp);
 	int status;
 
-	if (fl->fl_flags & FL_CLOSE) {
+	if (fl->fl_core.fl_flags & FL_CLOSE) {
 		l_ctx = nfs_get_lock_context(ctx);
 		if (IS_ERR(l_ctx))
 			l_ctx = NULL;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 23819a756508..a5596007b4d9 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6800,7 +6800,7 @@ static int _nfs4_proc_getlk(struct nfs4_state *state, int cmd, struct file_lock
 	status = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
 	switch (status) {
 		case 0:
-			request->fl_type = F_UNLCK;
+			request->fl_core.fl_type = F_UNLCK;
 			break;
 		case -NFS4ERR_DENIED:
 			status = 0;
@@ -7018,8 +7018,8 @@ static struct rpc_task *nfs4_do_unlck(struct file_lock *fl,
 	/* Ensure this is an unlock - when canceling a lock, the
 	 * canceled lock is passed in, and it won't be an unlock.
 	 */
-	fl->fl_type = F_UNLCK;
-	if (fl->fl_flags & FL_CLOSE)
+	fl->fl_core.fl_type = F_UNLCK;
+	if (fl->fl_core.fl_flags & FL_CLOSE)
 		set_bit(NFS_CONTEXT_UNLOCK, &ctx->flags);
 
 	data = nfs4_alloc_unlockdata(fl, ctx, lsp, seqid);
@@ -7045,11 +7045,11 @@ static int nfs4_proc_unlck(struct nfs4_state *state, int cmd, struct file_lock *
 	struct rpc_task *task;
 	struct nfs_seqid *(*alloc_seqid)(struct nfs_seqid_counter *, gfp_t);
 	int status = 0;
-	unsigned char fl_flags = request->fl_flags;
+	unsigned char fl_flags = request->fl_core.fl_flags;
 
 	status = nfs4_set_lock_state(state, request);
 	/* Unlock _before_ we do the RPC call */
-	request->fl_flags |= FL_EXISTS;
+	request->fl_core.fl_flags |= FL_EXISTS;
 	/* Exclude nfs_delegation_claim_locks() */
 	mutex_lock(&sp->so_delegreturn_mutex);
 	/* Exclude nfs4_reclaim_open_stateid() - note nesting! */
@@ -7073,14 +7073,16 @@ static int nfs4_proc_unlck(struct nfs4_state *state, int cmd, struct file_lock *
 	status = -ENOMEM;
 	if (IS_ERR(seqid))
 		goto out;
-	task = nfs4_do_unlck(request, nfs_file_open_context(request->fl_file), lsp, seqid);
+	task = nfs4_do_unlck(request,
+			     nfs_file_open_context(request->fl_core.fl_file),
+			     lsp, seqid);
 	status = PTR_ERR(task);
 	if (IS_ERR(task))
 		goto out;
 	status = rpc_wait_for_completion_task(task);
 	rpc_put_task(task);
 out:
-	request->fl_flags = fl_flags;
+	request->fl_core.fl_flags = fl_flags;
 	trace_nfs4_unlock(request, state, F_SETLK, status);
 	return status;
 }
@@ -7191,7 +7193,7 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
 		renew_lease(NFS_SERVER(d_inode(data->ctx->dentry)),
 				data->timestamp);
 		if (data->arg.new_lock && !data->cancelled) {
-			data->fl.fl_flags &= ~(FL_SLEEP | FL_ACCESS);
+			data->fl.fl_core.fl_flags &= ~(FL_SLEEP | FL_ACCESS);
 			if (locks_lock_inode_wait(lsp->ls_state->inode, &data->fl) < 0)
 				goto out_restart;
 		}
@@ -7292,7 +7294,8 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
 	if (nfs_server_capable(state->inode, NFS_CAP_MOVEABLE))
 		task_setup_data.flags |= RPC_TASK_MOVEABLE;
 
-	data = nfs4_alloc_lockdata(fl, nfs_file_open_context(fl->fl_file),
+	data = nfs4_alloc_lockdata(fl,
+				   nfs_file_open_context(fl->fl_core.fl_file),
 				   fl->fl_u.nfs4_fl.owner, GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
@@ -7398,10 +7401,10 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 {
 	struct nfs_inode *nfsi = NFS_I(state->inode);
 	struct nfs4_state_owner *sp = state->owner;
-	unsigned char fl_flags = request->fl_flags;
+	unsigned char fl_flags = request->fl_core.fl_flags;
 	int status;
 
-	request->fl_flags |= FL_ACCESS;
+	request->fl_core.fl_flags |= FL_ACCESS;
 	status = locks_lock_inode_wait(state->inode, request);
 	if (status < 0)
 		goto out;
@@ -7410,7 +7413,7 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	if (test_bit(NFS_DELEGATED_STATE, &state->flags)) {
 		/* Yes: cache locks! */
 		/* ...but avoid races with delegation recall... */
-		request->fl_flags = fl_flags & ~FL_SLEEP;
+		request->fl_core.fl_flags = fl_flags & ~FL_SLEEP;
 		status = locks_lock_inode_wait(state->inode, request);
 		up_read(&nfsi->rwsem);
 		mutex_unlock(&sp->so_delegreturn_mutex);
@@ -7420,7 +7423,7 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	mutex_unlock(&sp->so_delegreturn_mutex);
 	status = _nfs4_do_setlk(state, cmd, request, NFS_LOCK_NEW);
 out:
-	request->fl_flags = fl_flags;
+	request->fl_core.fl_flags = fl_flags;
 	return status;
 }
 
@@ -7562,7 +7565,7 @@ nfs4_proc_lock(struct file *filp, int cmd, struct file_lock *request)
 	if (!(IS_SETLK(cmd) || IS_SETLKW(cmd)))
 		return -EINVAL;
 
-	if (request->fl_type == F_UNLCK) {
+	if (request->fl_core.fl_type == F_UNLCK) {
 		if (state != NULL)
 			return nfs4_proc_unlck(state, cmd, request);
 		return 0;
@@ -7571,7 +7574,7 @@ nfs4_proc_lock(struct file *filp, int cmd, struct file_lock *request)
 	if (state == NULL)
 		return -ENOLCK;
 
-	if ((request->fl_flags & FL_POSIX) &&
+	if ((request->fl_core.fl_flags & FL_POSIX) &&
 	    !test_bit(NFS_STATE_POSIX_LOCKS, &state->flags))
 		return -ENOLCK;
 
@@ -7579,7 +7582,7 @@ nfs4_proc_lock(struct file *filp, int cmd, struct file_lock *request)
 	 * Don't rely on the VFS having checked the file open mode,
 	 * since it won't do this for flock() locks.
 	 */
-	switch (request->fl_type) {
+	switch (request->fl_core.fl_type) {
 	case F_RDLCK:
 		if (!(filp->f_mode & FMODE_READ))
 			return -EBADF;
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 9a5d911a7edc..a148b6ac4713 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -980,7 +980,7 @@ int nfs4_set_lock_state(struct nfs4_state *state, struct file_lock *fl)
 
 	if (fl->fl_ops != NULL)
 		return 0;
-	lsp = nfs4_get_lock_state(state, fl->fl_owner);
+	lsp = nfs4_get_lock_state(state, fl->fl_core.fl_owner);
 	if (lsp == NULL)
 		return -ENOMEM;
 	fl->fl_u.nfs4_fl.owner = lsp;
@@ -1530,7 +1530,7 @@ static int nfs4_reclaim_locks(struct nfs4_state *state, const struct nfs4_state_
 	spin_lock(&flctx->flc_lock);
 restart:
 	list_for_each_entry(fl, list, fl_list) {
-		if (nfs_file_open_context(fl->fl_file)->state != state)
+		if (nfs_file_open_context(fl->fl_core.fl_file)->state != state)
 			continue;
 		spin_unlock(&flctx->flc_lock);
 		status = ops->recover_lock(state, fl);
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 69406e60f391..25964af5bb80 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1305,7 +1305,7 @@ static void encode_link(struct xdr_stream *xdr, const struct qstr *name, struct
 
 static inline int nfs4_lock_type(struct file_lock *fl, int block)
 {
-	if (fl->fl_type == F_RDLCK)
+	if (fl->fl_core.fl_type == F_RDLCK)
 		return block ? NFS4_READW_LT : NFS4_READ_LT;
 	return block ? NFS4_WRITEW_LT : NFS4_WRITE_LT;
 }
@@ -5052,10 +5052,10 @@ static int decode_lock_denied (struct xdr_stream *xdr, struct file_lock *fl)
 		fl->fl_end = fl->fl_start + (loff_t)length - 1;
 		if (length == ~(uint64_t)0)
 			fl->fl_end = OFFSET_MAX;
-		fl->fl_type = F_WRLCK;
+		fl->fl_core.fl_type = F_WRLCK;
 		if (type & 1)
-			fl->fl_type = F_RDLCK;
-		fl->fl_pid = 0;
+			fl->fl_core.fl_type = F_RDLCK;
+		fl->fl_core.fl_pid = 0;
 	}
 	p = xdr_decode_hyper(p, &clientid); /* read 8 bytes */
 	namelen = be32_to_cpup(p); /* read 4 bytes */  /* have read all 32 bytes now */
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index bb79d3a886ae..a096c84c4678 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1301,7 +1301,7 @@ static bool
 is_whole_file_wrlock(struct file_lock *fl)
 {
 	return fl->fl_start == 0 && fl->fl_end == OFFSET_MAX &&
-			fl->fl_type == F_WRLCK;
+			fl->fl_core.fl_type == F_WRLCK;
 }
 
 /* If we know the page is up to date, and we're not using byte range locks (or
@@ -1341,7 +1341,7 @@ static int nfs_can_extend_write(struct file *file, struct folio *folio,
 	} else if (!list_empty(&flctx->flc_flock)) {
 		fl = list_first_entry(&flctx->flc_flock, struct file_lock,
 					fl_list);
-		if (fl->fl_type == F_WRLCK)
+		if (fl->fl_core.fl_type == F_WRLCK)
 			ret = 1;
 	}
 	spin_unlock(&flctx->flc_lock);
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 9cb7f0c33df5..0300dae3e11f 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -662,8 +662,8 @@ nfsd_file_lease_notifier_call(struct notifier_block *nb, unsigned long arg,
 	struct file_lock *fl = data;
 
 	/* Only close files for F_SETLEASE leases */
-	if (fl->fl_flags & FL_LEASE)
-		nfsd_file_close_inode(file_inode(fl->fl_file));
+	if (fl->fl_core.fl_flags & FL_LEASE)
+		nfsd_file_close_inode(file_inode(fl->fl_core.fl_file));
 	return 0;
 }
 
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 5e8096bc5eaa..4bef3349bd90 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -193,14 +193,15 @@ nfsd4_layout_setlease(struct nfs4_layout_stateid *ls)
 		return -ENOMEM;
 	locks_init_lock(fl);
 	fl->fl_lmops = &nfsd4_layouts_lm_ops;
-	fl->fl_flags = FL_LAYOUT;
-	fl->fl_type = F_RDLCK;
+	fl->fl_core.fl_flags = FL_LAYOUT;
+	fl->fl_core.fl_type = F_RDLCK;
 	fl->fl_end = OFFSET_MAX;
-	fl->fl_owner = ls;
-	fl->fl_pid = current->tgid;
-	fl->fl_file = ls->ls_file->nf_file;
+	fl->fl_core.fl_owner = ls;
+	fl->fl_core.fl_pid = current->tgid;
+	fl->fl_core.fl_file = ls->ls_file->nf_file;
 
-	status = vfs_setlease(fl->fl_file, fl->fl_type, &fl, NULL);
+	status = vfs_setlease(fl->fl_core.fl_file, fl->fl_core.fl_type, &fl,
+			      NULL);
 	if (status) {
 		locks_free_lock(fl);
 		return status;
@@ -731,7 +732,7 @@ nfsd4_layout_lm_break(struct file_lock *fl)
 	 * in time:
 	 */
 	fl->fl_break_time = 0;
-	nfsd4_recall_file_layout(fl->fl_owner);
+	nfsd4_recall_file_layout(fl->fl_core.fl_owner);
 	return false;
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2fa54cfd4882..a6089dbcee9d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4924,7 +4924,7 @@ static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 static bool
 nfsd_break_deleg_cb(struct file_lock *fl)
 {
-	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
+	struct nfs4_delegation *dp = (struct nfs4_delegation *) fl->fl_core.fl_owner;
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
 	struct nfs4_client *clp = dp->dl_stid.sc_client;
 	struct nfsd_net *nn;
@@ -4962,7 +4962,7 @@ nfsd_break_deleg_cb(struct file_lock *fl)
  */
 static bool nfsd_breaker_owns_lease(struct file_lock *fl)
 {
-	struct nfs4_delegation *dl = fl->fl_owner;
+	struct nfs4_delegation *dl = fl->fl_core.fl_owner;
 	struct svc_rqst *rqst;
 	struct nfs4_client *clp;
 
@@ -4980,7 +4980,7 @@ static int
 nfsd_change_deleg_cb(struct file_lock *onlist, int arg,
 		     struct list_head *dispose)
 {
-	struct nfs4_delegation *dp = (struct nfs4_delegation *)onlist->fl_owner;
+	struct nfs4_delegation *dp = (struct nfs4_delegation *) onlist->fl_core.fl_owner;
 	struct nfs4_client *clp = dp->dl_stid.sc_client;
 
 	if (arg & F_UNLCK) {
@@ -5340,12 +5340,12 @@ static struct file_lock *nfs4_alloc_init_lease(struct nfs4_delegation *dp,
 	if (!fl)
 		return NULL;
 	fl->fl_lmops = &nfsd_lease_mng_ops;
-	fl->fl_flags = FL_DELEG;
-	fl->fl_type = flag == NFS4_OPEN_DELEGATE_READ? F_RDLCK: F_WRLCK;
+	fl->fl_core.fl_flags = FL_DELEG;
+	fl->fl_core.fl_type = flag == NFS4_OPEN_DELEGATE_READ? F_RDLCK: F_WRLCK;
 	fl->fl_end = OFFSET_MAX;
-	fl->fl_owner = (fl_owner_t)dp;
-	fl->fl_pid = current->tgid;
-	fl->fl_file = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
+	fl->fl_core.fl_owner = (fl_owner_t)dp;
+	fl->fl_core.fl_pid = current->tgid;
+	fl->fl_core.fl_file = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
 	return fl;
 }
 
@@ -5533,7 +5533,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	if (!fl)
 		goto out_clnt_odstate;
 
-	status = vfs_setlease(fp->fi_deleg_file->nf_file, fl->fl_type, &fl, NULL);
+	status = vfs_setlease(fp->fi_deleg_file->nf_file, fl->fl_core.fl_type,
+			      &fl, NULL);
 	if (fl)
 		locks_free_lock(fl);
 	if (status)
@@ -7149,7 +7150,7 @@ nfsd4_lm_put_owner(fl_owner_t owner)
 static bool
 nfsd4_lm_lock_expirable(struct file_lock *cfl)
 {
-	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)cfl->fl_owner;
+	struct nfs4_lockowner *lo = (struct nfs4_lockowner *) cfl->fl_core.fl_owner;
 	struct nfs4_client *clp = lo->lo_owner.so_client;
 	struct nfsd_net *nn;
 
@@ -7171,7 +7172,7 @@ nfsd4_lm_expire_lock(void)
 static void
 nfsd4_lm_notify(struct file_lock *fl)
 {
-	struct nfs4_lockowner		*lo = (struct nfs4_lockowner *)fl->fl_owner;
+	struct nfs4_lockowner		*lo = (struct nfs4_lockowner *) fl->fl_core.fl_owner;
 	struct net			*net = lo->lo_owner.so_client->net;
 	struct nfsd_net			*nn = net_generic(net, nfsd_net_id);
 	struct nfsd4_blocked_lock	*nbl = container_of(fl,
@@ -7208,7 +7209,7 @@ nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
 	struct nfs4_lockowner *lo;
 
 	if (fl->fl_lmops == &nfsd_posix_mng_ops) {
-		lo = (struct nfs4_lockowner *) fl->fl_owner;
+		lo = (struct nfs4_lockowner *) fl->fl_core.fl_owner;
 		xdr_netobj_dup(&deny->ld_owner, &lo->lo_owner.so_owner,
 						GFP_KERNEL);
 		if (!deny->ld_owner.data)
@@ -7227,7 +7228,7 @@ nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
 	if (fl->fl_end != NFS4_MAX_UINT64)
 		deny->ld_length = fl->fl_end - fl->fl_start + 1;        
 	deny->ld_type = NFS4_READ_LT;
-	if (fl->fl_type != F_RDLCK)
+	if (fl->fl_core.fl_type != F_RDLCK)
 		deny->ld_type = NFS4_WRITE_LT;
 }
 
@@ -7615,11 +7616,11 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 
 	file_lock = &nbl->nbl_lock;
-	file_lock->fl_type = fl_type;
-	file_lock->fl_owner = (fl_owner_t)lockowner(nfs4_get_stateowner(&lock_sop->lo_owner));
-	file_lock->fl_pid = current->tgid;
-	file_lock->fl_file = nf->nf_file;
-	file_lock->fl_flags = fl_flags;
+	file_lock->fl_core.fl_type = fl_type;
+	file_lock->fl_core.fl_owner = (fl_owner_t)lockowner(nfs4_get_stateowner(&lock_sop->lo_owner));
+	file_lock->fl_core.fl_pid = current->tgid;
+	file_lock->fl_core.fl_file = nf->nf_file;
+	file_lock->fl_core.fl_flags = fl_flags;
 	file_lock->fl_lmops = &nfsd_posix_mng_ops;
 	file_lock->fl_start = lock->lk_offset;
 	file_lock->fl_end = last_byte_offset(lock->lk_offset, lock->lk_length);
@@ -7737,9 +7738,9 @@ static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct
 	err = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
 	if (err)
 		goto out;
-	lock->fl_file = nf->nf_file;
+	lock->fl_core.fl_file = nf->nf_file;
 	err = nfserrno(vfs_test_lock(nf->nf_file, lock));
-	lock->fl_file = NULL;
+	lock->fl_core.fl_file = NULL;
 out:
 	inode_unlock(inode);
 	nfsd_file_put(nf);
@@ -7784,11 +7785,11 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	switch (lockt->lt_type) {
 		case NFS4_READ_LT:
 		case NFS4_READW_LT:
-			file_lock->fl_type = F_RDLCK;
+			file_lock->fl_core.fl_type = F_RDLCK;
 			break;
 		case NFS4_WRITE_LT:
 		case NFS4_WRITEW_LT:
-			file_lock->fl_type = F_WRLCK;
+			file_lock->fl_core.fl_type = F_WRLCK;
 			break;
 		default:
 			dprintk("NFSD: nfs4_lockt: bad lock type!\n");
@@ -7798,9 +7799,9 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	lo = find_lockowner_str(cstate->clp, &lockt->lt_owner);
 	if (lo)
-		file_lock->fl_owner = (fl_owner_t)lo;
-	file_lock->fl_pid = current->tgid;
-	file_lock->fl_flags = FL_POSIX;
+		file_lock->fl_core.fl_owner = (fl_owner_t)lo;
+	file_lock->fl_core.fl_pid = current->tgid;
+	file_lock->fl_core.fl_flags = FL_POSIX;
 
 	file_lock->fl_start = lockt->lt_offset;
 	file_lock->fl_end = last_byte_offset(lockt->lt_offset, lockt->lt_length);
@@ -7811,7 +7812,7 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		goto out;
 
-	if (file_lock->fl_type != F_UNLCK) {
+	if (file_lock->fl_core.fl_type != F_UNLCK) {
 		status = nfserr_denied;
 		nfs4_set_lock_denied(file_lock, &lockt->lt_denied);
 	}
@@ -7867,11 +7868,11 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto put_file;
 	}
 
-	file_lock->fl_type = F_UNLCK;
-	file_lock->fl_owner = (fl_owner_t)lockowner(nfs4_get_stateowner(stp->st_stateowner));
-	file_lock->fl_pid = current->tgid;
-	file_lock->fl_file = nf->nf_file;
-	file_lock->fl_flags = FL_POSIX;
+	file_lock->fl_core.fl_type = F_UNLCK;
+	file_lock->fl_core.fl_owner = (fl_owner_t)lockowner(nfs4_get_stateowner(stp->st_stateowner));
+	file_lock->fl_core.fl_pid = current->tgid;
+	file_lock->fl_core.fl_file = nf->nf_file;
+	file_lock->fl_core.fl_flags = FL_POSIX;
 	file_lock->fl_lmops = &nfsd_posix_mng_ops;
 	file_lock->fl_start = locku->lu_offset;
 
@@ -7927,7 +7928,7 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 	if (flctx && !list_empty_careful(&flctx->flc_posix)) {
 		spin_lock(&flctx->flc_lock);
 		list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
-			if (fl->fl_owner == (fl_owner_t)lowner) {
+			if (fl->fl_core.fl_owner == (fl_owner_t)lowner) {
 				status = true;
 				break;
 			}
@@ -8456,7 +8457,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 		return 0;
 	spin_lock(&ctx->flc_lock);
 	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
-		if (fl->fl_flags == FL_LAYOUT)
+		if (fl->fl_core.fl_flags == FL_LAYOUT)
 			continue;
 		if (fl->fl_lmops != &nfsd_lease_mng_ops) {
 			/*
@@ -8464,12 +8465,12 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
 			 * we are done; there isn't any write delegation
 			 * on this inode
 			 */
-			if (fl->fl_type == F_RDLCK)
+			if (fl->fl_core.fl_type == F_RDLCK)
 				break;
 			goto break_lease;
 		}
-		if (fl->fl_type == F_WRLCK) {
-			dp = fl->fl_owner;
+		if (fl->fl_core.fl_type == F_WRLCK) {
+			dp = fl->fl_core.fl_owner;
 			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
 				spin_unlock(&ctx->flc_lock);
 				return 0;
diff --git a/fs/ocfs2/locks.c b/fs/ocfs2/locks.c
index f37174e79fad..30f7af75d18d 100644
--- a/fs/ocfs2/locks.c
+++ b/fs/ocfs2/locks.c
@@ -27,7 +27,7 @@ static int ocfs2_do_flock(struct file *file, struct inode *inode,
 	struct ocfs2_file_private *fp = file->private_data;
 	struct ocfs2_lock_res *lockres = &fp->fp_flock;
 
-	if (fl->fl_type == F_WRLCK)
+	if (fl->fl_core.fl_type == F_WRLCK)
 		level = 1;
 	if (!IS_SETLKW(cmd))
 		trylock = 1;
@@ -53,8 +53,8 @@ static int ocfs2_do_flock(struct file *file, struct inode *inode,
 		 */
 
 		locks_init_lock(&request);
-		request.fl_type = F_UNLCK;
-		request.fl_flags = FL_FLOCK;
+		request.fl_core.fl_type = F_UNLCK;
+		request.fl_core.fl_flags = FL_FLOCK;
 		locks_lock_file_wait(file, &request);
 
 		ocfs2_file_unlock(file);
@@ -100,14 +100,14 @@ int ocfs2_flock(struct file *file, int cmd, struct file_lock *fl)
 	struct inode *inode = file->f_mapping->host;
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->fl_core.fl_flags & FL_FLOCK))
 		return -ENOLCK;
 
 	if ((osb->s_mount_opt & OCFS2_MOUNT_LOCALFLOCKS) ||
 	    ocfs2_mount_local(osb))
 		return locks_lock_file_wait(file, fl);
 
-	if (fl->fl_type == F_UNLCK)
+	if (fl->fl_core.fl_type == F_UNLCK)
 		return ocfs2_do_funlock(file, cmd, fl);
 	else
 		return ocfs2_do_flock(file, inode, cmd, fl);
@@ -118,7 +118,7 @@ int ocfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 	struct inode *inode = file->f_mapping->host;
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 
-	if (!(fl->fl_flags & FL_POSIX))
+	if (!(fl->fl_core.fl_flags & FL_POSIX))
 		return -ENOLCK;
 
 	return ocfs2_plock(osb->cconn, OCFS2_I(inode)->ip_blkno, file, cmd, fl);
diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
index 9b76ee66aeb2..c66a688dea96 100644
--- a/fs/ocfs2/stack_user.c
+++ b/fs/ocfs2/stack_user.c
@@ -744,7 +744,7 @@ static int user_plock(struct ocfs2_cluster_connection *conn,
 		return dlm_posix_cancel(conn->cc_lockspace, ino, file, fl);
 	else if (IS_GETLK(cmd))
 		return dlm_posix_get(conn->cc_lockspace, ino, file, fl);
-	else if (fl->fl_type == F_UNLCK)
+	else if (fl->fl_core.fl_type == F_UNLCK)
 		return dlm_posix_unlock(conn->cc_lockspace, ino, file, fl);
 	else
 		return dlm_posix_lock(conn->cc_lockspace, ino, file, cmd, fl);
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 01e89070df5a..7140c2baa652 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -2066,20 +2066,20 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 		parm_data = (struct cifs_posix_lock *)
 			((char *)&pSMBr->hdr.Protocol + data_offset);
 		if (parm_data->lock_type == cpu_to_le16(CIFS_UNLCK))
-			pLockData->fl_type = F_UNLCK;
+			pLockData->fl_core.fl_type = F_UNLCK;
 		else {
 			if (parm_data->lock_type ==
 					cpu_to_le16(CIFS_RDLCK))
-				pLockData->fl_type = F_RDLCK;
+				pLockData->fl_core.fl_type = F_RDLCK;
 			else if (parm_data->lock_type ==
 					cpu_to_le16(CIFS_WRLCK))
-				pLockData->fl_type = F_WRLCK;
+				pLockData->fl_core.fl_type = F_WRLCK;
 
 			pLockData->fl_start = le64_to_cpu(parm_data->start);
 			pLockData->fl_end = pLockData->fl_start +
 				(le64_to_cpu(parm_data->length) ?
 				 le64_to_cpu(parm_data->length) - 1 : 0);
-			pLockData->fl_pid = -le32_to_cpu(parm_data->pid);
+			pLockData->fl_core.fl_pid = -le32_to_cpu(parm_data->pid);
 		}
 	}
 
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 1b4262aff8fa..1305183842fd 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -1312,20 +1312,20 @@ cifs_lock_test(struct cifsFileInfo *cfile, __u64 offset, __u64 length,
 	down_read(&cinode->lock_sem);
 
 	exist = cifs_find_lock_conflict(cfile, offset, length, type,
-					flock->fl_flags, &conf_lock,
+					flock->fl_core.fl_flags, &conf_lock,
 					CIFS_LOCK_OP);
 	if (exist) {
 		flock->fl_start = conf_lock->offset;
 		flock->fl_end = conf_lock->offset + conf_lock->length - 1;
-		flock->fl_pid = conf_lock->pid;
+		flock->fl_core.fl_pid = conf_lock->pid;
 		if (conf_lock->type & server->vals->shared_lock_type)
-			flock->fl_type = F_RDLCK;
+			flock->fl_core.fl_type = F_RDLCK;
 		else
-			flock->fl_type = F_WRLCK;
+			flock->fl_core.fl_type = F_WRLCK;
 	} else if (!cinode->can_cache_brlcks)
 		rc = 1;
 	else
-		flock->fl_type = F_UNLCK;
+		flock->fl_core.fl_type = F_UNLCK;
 
 	up_read(&cinode->lock_sem);
 	return rc;
@@ -1401,16 +1401,16 @@ cifs_posix_lock_test(struct file *file, struct file_lock *flock)
 {
 	int rc = 0;
 	struct cifsInodeInfo *cinode = CIFS_I(file_inode(file));
-	unsigned char saved_type = flock->fl_type;
+	unsigned char saved_type = flock->fl_core.fl_type;
 
-	if ((flock->fl_flags & FL_POSIX) == 0)
+	if ((flock->fl_core.fl_flags & FL_POSIX) == 0)
 		return 1;
 
 	down_read(&cinode->lock_sem);
 	posix_test_lock(file, flock);
 
-	if (flock->fl_type == F_UNLCK && !cinode->can_cache_brlcks) {
-		flock->fl_type = saved_type;
+	if (flock->fl_core.fl_type == F_UNLCK && !cinode->can_cache_brlcks) {
+		flock->fl_core.fl_type = saved_type;
 		rc = 1;
 	}
 
@@ -1431,7 +1431,7 @@ cifs_posix_lock_set(struct file *file, struct file_lock *flock)
 	struct cifsInodeInfo *cinode = CIFS_I(file_inode(file));
 	int rc = FILE_LOCK_DEFERRED + 1;
 
-	if ((flock->fl_flags & FL_POSIX) == 0)
+	if ((flock->fl_core.fl_flags & FL_POSIX) == 0)
 		return rc;
 
 	cifs_down_write(&cinode->lock_sem);
@@ -1591,12 +1591,12 @@ cifs_push_posix_locks(struct cifsFileInfo *cfile)
 			break;
 		}
 		length = cifs_flock_len(flock);
-		if (flock->fl_type == F_RDLCK || flock->fl_type == F_SHLCK)
+		if (flock->fl_core.fl_type == F_RDLCK || flock->fl_core.fl_type == F_SHLCK)
 			type = CIFS_RDLCK;
 		else
 			type = CIFS_WRLCK;
 		lck = list_entry(el, struct lock_to_push, llist);
-		lck->pid = hash_lockowner(flock->fl_owner);
+		lck->pid = hash_lockowner(flock->fl_core.fl_owner);
 		lck->netfid = cfile->fid.netfid;
 		lck->length = length;
 		lck->type = type;
@@ -1663,42 +1663,43 @@ static void
 cifs_read_flock(struct file_lock *flock, __u32 *type, int *lock, int *unlock,
 		bool *wait_flag, struct TCP_Server_Info *server)
 {
-	if (flock->fl_flags & FL_POSIX)
+	if (flock->fl_core.fl_flags & FL_POSIX)
 		cifs_dbg(FYI, "Posix\n");
-	if (flock->fl_flags & FL_FLOCK)
+	if (flock->fl_core.fl_flags & FL_FLOCK)
 		cifs_dbg(FYI, "Flock\n");
-	if (flock->fl_flags & FL_SLEEP) {
+	if (flock->fl_core.fl_flags & FL_SLEEP) {
 		cifs_dbg(FYI, "Blocking lock\n");
 		*wait_flag = true;
 	}
-	if (flock->fl_flags & FL_ACCESS)
+	if (flock->fl_core.fl_flags & FL_ACCESS)
 		cifs_dbg(FYI, "Process suspended by mandatory locking - not implemented yet\n");
-	if (flock->fl_flags & FL_LEASE)
+	if (flock->fl_core.fl_flags & FL_LEASE)
 		cifs_dbg(FYI, "Lease on file - not implemented yet\n");
-	if (flock->fl_flags &
+	if (flock->fl_core.fl_flags &
 	    (~(FL_POSIX | FL_FLOCK | FL_SLEEP |
 	       FL_ACCESS | FL_LEASE | FL_CLOSE | FL_OFDLCK)))
-		cifs_dbg(FYI, "Unknown lock flags 0x%x\n", flock->fl_flags);
+		cifs_dbg(FYI, "Unknown lock flags 0x%x\n",
+		         flock->fl_core.fl_flags);
 
 	*type = server->vals->large_lock_type;
-	if (flock->fl_type == F_WRLCK) {
+	if (flock->fl_core.fl_type == F_WRLCK) {
 		cifs_dbg(FYI, "F_WRLCK\n");
 		*type |= server->vals->exclusive_lock_type;
 		*lock = 1;
-	} else if (flock->fl_type == F_UNLCK) {
+	} else if (flock->fl_core.fl_type == F_UNLCK) {
 		cifs_dbg(FYI, "F_UNLCK\n");
 		*type |= server->vals->unlock_lock_type;
 		*unlock = 1;
 		/* Check if unlock includes more than one lock range */
-	} else if (flock->fl_type == F_RDLCK) {
+	} else if (flock->fl_core.fl_type == F_RDLCK) {
 		cifs_dbg(FYI, "F_RDLCK\n");
 		*type |= server->vals->shared_lock_type;
 		*lock = 1;
-	} else if (flock->fl_type == F_EXLCK) {
+	} else if (flock->fl_core.fl_type == F_EXLCK) {
 		cifs_dbg(FYI, "F_EXLCK\n");
 		*type |= server->vals->exclusive_lock_type;
 		*lock = 1;
-	} else if (flock->fl_type == F_SHLCK) {
+	} else if (flock->fl_core.fl_type == F_SHLCK) {
 		cifs_dbg(FYI, "F_SHLCK\n");
 		*type |= server->vals->shared_lock_type;
 		*lock = 1;
@@ -1730,7 +1731,7 @@ cifs_getlk(struct file *file, struct file_lock *flock, __u32 type,
 		else
 			posix_lock_type = CIFS_WRLCK;
 		rc = CIFSSMBPosixLock(xid, tcon, netfid,
-				      hash_lockowner(flock->fl_owner),
+				      hash_lockowner(flock->fl_core.fl_owner),
 				      flock->fl_start, length, flock,
 				      posix_lock_type, wait_flag);
 		return rc;
@@ -1747,7 +1748,7 @@ cifs_getlk(struct file *file, struct file_lock *flock, __u32 type,
 	if (rc == 0) {
 		rc = server->ops->mand_lock(xid, cfile, flock->fl_start, length,
 					    type, 0, 1, false);
-		flock->fl_type = F_UNLCK;
+		flock->fl_core.fl_type = F_UNLCK;
 		if (rc != 0)
 			cifs_dbg(VFS, "Error unlocking previously locked range %d during test of lock\n",
 				 rc);
@@ -1755,7 +1756,7 @@ cifs_getlk(struct file *file, struct file_lock *flock, __u32 type,
 	}
 
 	if (type & server->vals->shared_lock_type) {
-		flock->fl_type = F_WRLCK;
+		flock->fl_core.fl_type = F_WRLCK;
 		return 0;
 	}
 
@@ -1767,12 +1768,12 @@ cifs_getlk(struct file *file, struct file_lock *flock, __u32 type,
 	if (rc == 0) {
 		rc = server->ops->mand_lock(xid, cfile, flock->fl_start, length,
 			type | server->vals->shared_lock_type, 0, 1, false);
-		flock->fl_type = F_RDLCK;
+		flock->fl_core.fl_type = F_RDLCK;
 		if (rc != 0)
 			cifs_dbg(VFS, "Error unlocking previously locked range %d during test of lock\n",
 				 rc);
 	} else
-		flock->fl_type = F_WRLCK;
+		flock->fl_core.fl_type = F_WRLCK;
 
 	return 0;
 }
@@ -1940,7 +1941,7 @@ cifs_setlk(struct file *file, struct file_lock *flock, __u32 type,
 			posix_lock_type = CIFS_UNLCK;
 
 		rc = CIFSSMBPosixLock(xid, tcon, cfile->fid.netfid,
-				      hash_lockowner(flock->fl_owner),
+				      hash_lockowner(flock->fl_core.fl_owner),
 				      flock->fl_start, length,
 				      NULL, posix_lock_type, wait_flag);
 		goto out;
@@ -1950,7 +1951,7 @@ cifs_setlk(struct file *file, struct file_lock *flock, __u32 type,
 		struct cifsLockInfo *lock;
 
 		lock = cifs_lock_init(flock->fl_start, length, type,
-				      flock->fl_flags);
+				      flock->fl_core.fl_flags);
 		if (!lock)
 			return -ENOMEM;
 
@@ -1989,7 +1990,7 @@ cifs_setlk(struct file *file, struct file_lock *flock, __u32 type,
 		rc = server->ops->mand_unlock_range(cfile, flock, xid);
 
 out:
-	if ((flock->fl_flags & FL_POSIX) || (flock->fl_flags & FL_FLOCK)) {
+	if ((flock->fl_core.fl_flags & FL_POSIX) || (flock->fl_core.fl_flags & FL_FLOCK)) {
 		/*
 		 * If this is a request to remove all locks because we
 		 * are closing the file, it doesn't matter if the
@@ -1998,7 +1999,7 @@ cifs_setlk(struct file *file, struct file_lock *flock, __u32 type,
 		 */
 		if (rc) {
 			cifs_dbg(VFS, "%s failed rc=%d\n", __func__, rc);
-			if (!(flock->fl_flags & FL_CLOSE))
+			if (!(flock->fl_core.fl_flags & FL_CLOSE))
 				return rc;
 		}
 		rc = locks_lock_file_wait(file, flock);
@@ -2019,7 +2020,7 @@ int cifs_flock(struct file *file, int cmd, struct file_lock *fl)
 
 	xid = get_xid();
 
-	if (!(fl->fl_flags & FL_FLOCK)) {
+	if (!(fl->fl_core.fl_flags & FL_FLOCK)) {
 		rc = -ENOLCK;
 		free_xid(xid);
 		return rc;
@@ -2070,7 +2071,8 @@ int cifs_lock(struct file *file, int cmd, struct file_lock *flock)
 	xid = get_xid();
 
 	cifs_dbg(FYI, "%s: %pD2 cmd=0x%x type=0x%x flags=0x%x r=%lld:%lld\n", __func__, file, cmd,
-		 flock->fl_flags, flock->fl_type, (long long)flock->fl_start,
+		 flock->fl_core.fl_flags, flock->fl_core.fl_type,
+		 (long long)flock->fl_start,
 		 (long long)flock->fl_end);
 
 	cfile = (struct cifsFileInfo *)file->private_data;
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index e0ee96d69d49..39262617f551 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -228,7 +228,7 @@ smb2_unlock_range(struct cifsFileInfo *cfile, struct file_lock *flock,
 			 * flock and OFD lock are associated with an open
 			 * file description, not the process.
 			 */
-			if (!(flock->fl_flags & (FL_FLOCK | FL_OFDLCK)))
+			if (!(flock->fl_core.fl_flags & (FL_FLOCK | FL_OFDLCK)))
 				continue;
 		if (cinode->can_cache_brlcks) {
 			/*
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 3143819935dc..439f68cee402 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6748,10 +6748,10 @@ struct file_lock *smb_flock_init(struct file *f)
 
 	locks_init_lock(fl);
 
-	fl->fl_owner = f;
-	fl->fl_pid = current->tgid;
-	fl->fl_file = f;
-	fl->fl_flags = FL_POSIX;
+	fl->fl_core.fl_owner = f;
+	fl->fl_core.fl_pid = current->tgid;
+	fl->fl_core.fl_file = f;
+	fl->fl_core.fl_flags = FL_POSIX;
 	fl->fl_ops = NULL;
 	fl->fl_lmops = NULL;
 
@@ -6768,30 +6768,30 @@ static int smb2_set_flock_flags(struct file_lock *flock, int flags)
 	case SMB2_LOCKFLAG_SHARED:
 		ksmbd_debug(SMB, "received shared request\n");
 		cmd = F_SETLKW;
-		flock->fl_type = F_RDLCK;
-		flock->fl_flags |= FL_SLEEP;
+		flock->fl_core.fl_type = F_RDLCK;
+		flock->fl_core.fl_flags |= FL_SLEEP;
 		break;
 	case SMB2_LOCKFLAG_EXCLUSIVE:
 		ksmbd_debug(SMB, "received exclusive request\n");
 		cmd = F_SETLKW;
-		flock->fl_type = F_WRLCK;
-		flock->fl_flags |= FL_SLEEP;
+		flock->fl_core.fl_type = F_WRLCK;
+		flock->fl_core.fl_flags |= FL_SLEEP;
 		break;
 	case SMB2_LOCKFLAG_SHARED | SMB2_LOCKFLAG_FAIL_IMMEDIATELY:
 		ksmbd_debug(SMB,
 			    "received shared & fail immediately request\n");
 		cmd = F_SETLK;
-		flock->fl_type = F_RDLCK;
+		flock->fl_core.fl_type = F_RDLCK;
 		break;
 	case SMB2_LOCKFLAG_EXCLUSIVE | SMB2_LOCKFLAG_FAIL_IMMEDIATELY:
 		ksmbd_debug(SMB,
 			    "received exclusive & fail immediately request\n");
 		cmd = F_SETLK;
-		flock->fl_type = F_WRLCK;
+		flock->fl_core.fl_type = F_WRLCK;
 		break;
 	case SMB2_LOCKFLAG_UNLOCK:
 		ksmbd_debug(SMB, "received unlock request\n");
-		flock->fl_type = F_UNLCK;
+		flock->fl_core.fl_type = F_UNLCK;
 		cmd = F_SETLK;
 		break;
 	}
@@ -6829,13 +6829,13 @@ static void smb2_remove_blocked_lock(void **argv)
 	struct file_lock *flock = (struct file_lock *)argv[0];
 
 	ksmbd_vfs_posix_lock_unblock(flock);
-	wake_up(&flock->fl_wait);
+	wake_up(&flock->fl_core.fl_wait);
 }
 
 static inline bool lock_defer_pending(struct file_lock *fl)
 {
 	/* check pending lock waiters */
-	return waitqueue_active(&fl->fl_wait);
+	return waitqueue_active(&fl->fl_core.fl_wait);
 }
 
 /**
@@ -6926,8 +6926,8 @@ int smb2_lock(struct ksmbd_work *work)
 		list_for_each_entry(cmp_lock, &lock_list, llist) {
 			if (cmp_lock->fl->fl_start <= flock->fl_start &&
 			    cmp_lock->fl->fl_end >= flock->fl_end) {
-				if (cmp_lock->fl->fl_type != F_UNLCK &&
-				    flock->fl_type != F_UNLCK) {
+				if (cmp_lock->fl->fl_core.fl_type != F_UNLCK &&
+				    flock->fl_core.fl_type != F_UNLCK) {
 					pr_err("conflict two locks in one request\n");
 					err = -EINVAL;
 					locks_free_lock(flock);
@@ -6975,12 +6975,12 @@ int smb2_lock(struct ksmbd_work *work)
 		list_for_each_entry(conn, &conn_list, conns_list) {
 			spin_lock(&conn->llist_lock);
 			list_for_each_entry_safe(cmp_lock, tmp2, &conn->lock_list, clist) {
-				if (file_inode(cmp_lock->fl->fl_file) !=
-				    file_inode(smb_lock->fl->fl_file))
+				if (file_inode(cmp_lock->fl->fl_core.fl_file) !=
+				    file_inode(smb_lock->fl->fl_core.fl_file))
 					continue;
 
-				if (smb_lock->fl->fl_type == F_UNLCK) {
-					if (cmp_lock->fl->fl_file == smb_lock->fl->fl_file &&
+				if (smb_lock->fl->fl_core.fl_type == F_UNLCK) {
+					if (cmp_lock->fl->fl_core.fl_file == smb_lock->fl->fl_core.fl_file &&
 					    cmp_lock->start == smb_lock->start &&
 					    cmp_lock->end == smb_lock->end &&
 					    !lock_defer_pending(cmp_lock->fl)) {
@@ -6997,7 +6997,7 @@ int smb2_lock(struct ksmbd_work *work)
 					continue;
 				}
 
-				if (cmp_lock->fl->fl_file == smb_lock->fl->fl_file) {
+				if (cmp_lock->fl->fl_core.fl_file == smb_lock->fl->fl_core.fl_file) {
 					if (smb_lock->flags & SMB2_LOCKFLAG_SHARED)
 						continue;
 				} else {
@@ -7039,7 +7039,7 @@ int smb2_lock(struct ksmbd_work *work)
 		}
 		up_read(&conn_list_lock);
 out_check_cl:
-		if (smb_lock->fl->fl_type == F_UNLCK && nolock) {
+		if (smb_lock->fl->fl_core.fl_type == F_UNLCK && nolock) {
 			pr_err("Try to unlock nolocked range\n");
 			rsp->hdr.Status = STATUS_RANGE_NOT_LOCKED;
 			goto out;
@@ -7163,7 +7163,7 @@ int smb2_lock(struct ksmbd_work *work)
 		struct file_lock *rlock = NULL;
 
 		rlock = smb_flock_init(filp);
-		rlock->fl_type = F_UNLCK;
+		rlock->fl_core.fl_type = F_UNLCK;
 		rlock->fl_start = smb_lock->start;
 		rlock->fl_end = smb_lock->end;
 
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index a6961bfe3e13..f7bb6f19492b 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -340,15 +340,15 @@ static int check_lock_range(struct file *filp, loff_t start, loff_t end,
 	list_for_each_entry(flock, &ctx->flc_posix, fl_list) {
 		/* check conflict locks */
 		if (flock->fl_end >= start && end >= flock->fl_start) {
-			if (flock->fl_type == F_RDLCK) {
+			if (flock->fl_core.fl_type == F_RDLCK) {
 				if (type == WRITE) {
 					pr_err("not allow write by shared lock\n");
 					error = 1;
 					goto out;
 				}
-			} else if (flock->fl_type == F_WRLCK) {
+			} else if (flock->fl_core.fl_type == F_WRLCK) {
 				/* check owner in lock */
-				if (flock->fl_file != filp) {
+				if (flock->fl_core.fl_file != filp) {
 					error = 1;
 					pr_err("not allow rw access by exclusive lock from other opens\n");
 					goto out;
@@ -1837,13 +1837,13 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
 
 void ksmbd_vfs_posix_lock_wait(struct file_lock *flock)
 {
-	wait_event(flock->fl_wait, !flock->fl_blocker);
+	wait_event(flock->fl_core.fl_wait, !flock->fl_core.fl_blocker);
 }
 
 int ksmbd_vfs_posix_lock_wait_timeout(struct file_lock *flock, long timeout)
 {
-	return wait_event_interruptible_timeout(flock->fl_wait,
-						!flock->fl_blocker,
+	return wait_event_interruptible_timeout(flock->fl_core.fl_wait,
+						!flock->fl_core.fl_blocker,
 						timeout);
 }
 
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 9f565416d186..c4b9faa261f7 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -375,12 +375,12 @@ static inline int nlm_privileged_requester(const struct svc_rqst *rqstp)
 static inline int nlm_compare_locks(const struct file_lock *fl1,
 				    const struct file_lock *fl2)
 {
-	return file_inode(fl1->fl_file) == file_inode(fl2->fl_file)
-	     && fl1->fl_pid   == fl2->fl_pid
-	     && fl1->fl_owner == fl2->fl_owner
+	return file_inode(fl1->fl_core.fl_file) == file_inode(fl2->fl_core.fl_file)
+	     && fl1->fl_core.fl_pid   == fl2->fl_core.fl_pid
+	     && fl1->fl_core.fl_owner == fl2->fl_core.fl_owner
 	     && fl1->fl_start == fl2->fl_start
 	     && fl1->fl_end   == fl2->fl_end
-	     &&(fl1->fl_type  == fl2->fl_type || fl2->fl_type == F_UNLCK);
+	     &&(fl1->fl_core.fl_type  == fl2->fl_core.fl_type || fl2->fl_core.fl_type == F_UNLCK);
 }
 
 extern const struct lock_manager_operations nlmsvc_lock_operations;

-- 
2.43.0


