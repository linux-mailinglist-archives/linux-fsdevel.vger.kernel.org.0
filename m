Return-Path: <linux-fsdevel+bounces-9765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE16844C67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CF91F22CBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46514148304;
	Wed, 31 Jan 2024 23:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/VIcs86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE0A1482EF;
	Wed, 31 Jan 2024 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742275; cv=none; b=d1GTYQVDZhI6/zdldcjpqkhTuf5DpZcAxzSmaXJTgcvDZ/ql5tJMgWCBSdpw7zJxJFEgR9oXFkeEElk6MFYt3kI98HgKNL18AUaMKpr5NEVRh0r90bB8Cs4Z0ZgW6FgC1n1bumTsUPXbPN0lYseYVF+HlILXDqrhFWcFlvkBo3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742275; c=relaxed/simple;
	bh=kyu2h/n4Fzdv/eqjiJ3uCiiXLu/8SBPw/K7lznAJ8KM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tgLKS5i8HHRztBIxMxesWnh96vVgSKwTdXOdQTJEjWrXw51b4pEgCCQ25b0xb8NYvOv7IG0SORjnrP7MMpe/Uv6sB+uCOXWAGtk2Yo3w/SC7qAJX4CDmUG/E6zkckaJgDs/vPq60bCDvEQWhciWe8xFpr+WZ0gq4B2hq01/QuxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/VIcs86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914D3C433C7;
	Wed, 31 Jan 2024 23:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742275;
	bh=kyu2h/n4Fzdv/eqjiJ3uCiiXLu/8SBPw/K7lznAJ8KM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l/VIcs86De1apDNSLZuHXgXBijQshecrJCXbHUWIVs5a9zVJC/n0+ro/1BHaryXRD
	 6K1El/rOQI0K1CUJ4ckeCwGr7UIymF5nmSElNYoLWlFQLM7jsl/A2odlAkOQwPLkcb
	 DTO1L+elruRe3Va/87smch39bhDNs3lMSRi+ZS6IiPIKZTNBuHXcJi31anUkd3Mxyz
	 VCbCisQChs64trcSMW57G+od8fa+yTLL+49gsAziStvddce+vFe3vSSbqMbPSq6ffO
	 gI6Ca1oT1+3IE1nhAHCHz/MWXjS5Te05eTcSTRT2lRiWt1FIwoirflxg4O9/D0+1nI
	 JQ2klXQG+eDkg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:16 -0500
Subject: [PATCH v3 35/47] afs: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-35-c6129007ee8d@kernel.org>
References: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
In-Reply-To: <20240131-flsplit-v3-0-c6129007ee8d@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
 ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6392; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kyu2h/n4Fzdv/eqjiJ3uCiiXLu/8SBPw/K7lznAJ8KM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFysWKvUlB8tHSLmI2LL7d3LNH3kDaXNKpKm
 O1GNoaVqLWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcgAKCRAADmhBGVaC
 FTqkD/9FlAzlR8tdVoRicAOZ5zW3nzENMWNyDcbX7BJa9ZpwY2qh8+4+28rJynibZwNBQ2DzCcr
 X01gbf/3jy9x/sPvq8aOwwYvSHp2+wz5dmPCNBpI9bGk8bMFWC39zbVh9sbAM1TatSTj3S749fL
 5oo1b16Q2MCdTvJARKvYHWmuCb66W/Vsf33SrPhXwXWis5Tk9YxRWNvKIh9LLtb3qk338wMuF+R
 4arB9aHW3StKNi2gDnpP+Mya7tK+gHznmXO9EFM1FC1rSjlD/p7m7nrdTGIQxQ5wavPkViTPYu+
 +8DUxwpaKxhpQtqU9emOVj0NjcUBjco6POAfwTk5WpXw62W1KDwZOWAgMZzgOKKeMxk1MJytBn0
 EAR5P0du9Su9mtAtHRBFjqJ7yFPnUcfCzbn9aCrV6iM0PM7D7ckv9uC0VCS09+DH3arevKJzHQ9
 SSwLARiNBFF3B6AToUZepL4Yfg+KpP/dtgFmSiN/5yOYYpGVs5IWa81HelkpAbhbeRnFGBvMwp3
 bShFBNQX/Oz9DZ+SuoXNKY68fw43V6dbPDiJhhlM98+aLqD+ZDIczwxbrMDL9kXW06nV+ADvaMb
 DiXJTAuclUhMBu/qBVMXqHlyRQKqgZ5e932l6HpZAzKDJBSz1RQzJULHVxObEfwJA1sOLDm+TvB
 9yt/50+bIFGolWA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/afs/flock.c             | 38 +++++++++++++++++++-------------------
 fs/afs/internal.h          |  1 -
 include/trace/events/afs.h |  4 ++--
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 4eee3d1ca5ad..f0e96a35093f 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -121,16 +121,15 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
 
 	list_for_each_entry_safe(p, _p, &vnode->pending_locks, fl_u.afs.link) {
 		if (error &&
-		    p->fl_type == type &&
-		    afs_file_key(p->fl_file) == key) {
+		    p->c.flc_type == type &&
+		    afs_file_key(p->c.flc_file) == key) {
 			list_del_init(&p->fl_u.afs.link);
 			p->fl_u.afs.state = error;
 			locks_wake_up(p);
 		}
 
 		/* Select the next locker to hand off to. */
-		if (next &&
-		    (lock_is_write(next) || lock_is_read(p)))
+		if (next && (lock_is_write(next) || lock_is_read(p)))
 			continue;
 		next = p;
 	}
@@ -464,7 +463,7 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 
 	_enter("{%llx:%llu},%llu-%llu,%u,%u",
 	       vnode->fid.vid, vnode->fid.vnode,
-	       fl->fl_start, fl->fl_end, fl->fl_type, mode);
+	       fl->fl_start, fl->fl_end, fl->c.flc_type, mode);
 
 	fl->fl_ops = &afs_lock_ops;
 	INIT_LIST_HEAD(&fl->fl_u.afs.link);
@@ -524,7 +523,7 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	}
 
 	if (vnode->lock_state == AFS_VNODE_LOCK_NONE &&
-	    !(fl->fl_flags & FL_SLEEP)) {
+	    !(fl->c.flc_flags & FL_SLEEP)) {
 		ret = -EAGAIN;
 		if (type == AFS_LOCK_READ) {
 			if (vnode->status.lock_count == -1)
@@ -621,7 +620,7 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	return 0;
 
 lock_is_contended:
-	if (!(fl->fl_flags & FL_SLEEP)) {
+	if (!(fl->c.flc_flags & FL_SLEEP)) {
 		list_del_init(&fl->fl_u.afs.link);
 		afs_next_locker(vnode, 0);
 		ret = -EAGAIN;
@@ -641,7 +640,7 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
 	spin_unlock(&vnode->lock);
 
 	trace_afs_flock_ev(vnode, fl, afs_flock_waiting, 0);
-	ret = wait_event_interruptible(fl->fl_wait,
+	ret = wait_event_interruptible(fl->c.flc_wait,
 				       fl->fl_u.afs.state != AFS_LOCK_PENDING);
 	trace_afs_flock_ev(vnode, fl, afs_flock_waited, ret);
 
@@ -704,7 +703,8 @@ static int afs_do_unlk(struct file *file, struct file_lock *fl)
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	int ret;
 
-	_enter("{%llx:%llu},%u", vnode->fid.vid, vnode->fid.vnode, fl->fl_type);
+	_enter("{%llx:%llu},%u", vnode->fid.vid, vnode->fid.vnode,
+	       fl->c.flc_type);
 
 	trace_afs_flock_op(vnode, fl, afs_flock_op_unlock);
 
@@ -730,7 +730,7 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
 	if (vnode->lock_state == AFS_VNODE_LOCK_DELETED)
 		return -ENOENT;
 
-	fl->fl_type = F_UNLCK;
+	fl->c.flc_type = F_UNLCK;
 
 	/* check local lock records first */
 	posix_test_lock(file, fl);
@@ -743,18 +743,18 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
 		lock_count = READ_ONCE(vnode->status.lock_count);
 		if (lock_count != 0) {
 			if (lock_count > 0)
-				fl->fl_type = F_RDLCK;
+				fl->c.flc_type = F_RDLCK;
 			else
-				fl->fl_type = F_WRLCK;
+				fl->c.flc_type = F_WRLCK;
 			fl->fl_start = 0;
 			fl->fl_end = OFFSET_MAX;
-			fl->fl_pid = 0;
+			fl->c.flc_pid = 0;
 		}
 	}
 
 	ret = 0;
 error:
-	_leave(" = %d [%hd]", ret, fl->fl_type);
+	_leave(" = %d [%hd]", ret, fl->c.flc_type);
 	return ret;
 }
 
@@ -769,7 +769,7 @@ int afs_lock(struct file *file, int cmd, struct file_lock *fl)
 
 	_enter("{%llx:%llu},%d,{t=%x,fl=%x,r=%Ld:%Ld}",
 	       vnode->fid.vid, vnode->fid.vnode, cmd,
-	       fl->fl_type, fl->fl_flags,
+	       fl->c.flc_type, fl->c.flc_flags,
 	       (long long) fl->fl_start, (long long) fl->fl_end);
 
 	if (IS_GETLK(cmd))
@@ -804,7 +804,7 @@ int afs_flock(struct file *file, int cmd, struct file_lock *fl)
 
 	_enter("{%llx:%llu},%d,{t=%x,fl=%x}",
 	       vnode->fid.vid, vnode->fid.vnode, cmd,
-	       fl->fl_type, fl->fl_flags);
+	       fl->c.flc_type, fl->c.flc_flags);
 
 	/*
 	 * No BSD flocks over NFS allowed.
@@ -813,7 +813,7 @@ int afs_flock(struct file *file, int cmd, struct file_lock *fl)
 	 * Not sure whether that would be unique, though, or whether
 	 * that would break in other places.
 	 */
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->c.flc_flags & FL_FLOCK))
 		return -ENOLCK;
 
 	fl->fl_u.afs.debug_id = atomic_inc_return(&afs_file_lock_debug_id);
@@ -843,7 +843,7 @@ int afs_flock(struct file *file, int cmd, struct file_lock *fl)
  */
 static void afs_fl_copy_lock(struct file_lock *new, struct file_lock *fl)
 {
-	struct afs_vnode *vnode = AFS_FS_I(file_inode(fl->fl_file));
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(fl->c.flc_file));
 
 	_enter("");
 
@@ -861,7 +861,7 @@ static void afs_fl_copy_lock(struct file_lock *new, struct file_lock *fl)
  */
 static void afs_fl_release_private(struct file_lock *fl)
 {
-	struct afs_vnode *vnode = AFS_FS_I(file_inode(fl->fl_file));
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(fl->c.flc_file));
 
 	_enter("");
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index f5dd428e40f4..9c03fcf7ffaa 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -9,7 +9,6 @@
 #include <linux/kernel.h>
 #include <linux/ktime.h>
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/pagemap.h>
 #include <linux/rxrpc.h>
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 08f2c93d6b16..450c44c83a5d 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -1189,8 +1189,8 @@ TRACE_EVENT(afs_flock_op,
 		    __entry->from = fl->fl_start;
 		    __entry->len = fl->fl_end - fl->fl_start + 1;
 		    __entry->op = op;
-		    __entry->type = fl->fl_type;
-		    __entry->flags = fl->fl_flags;
+		    __entry->type = fl->c.flc_type;
+		    __entry->flags = fl->c.flc_flags;
 		    __entry->debug_id = fl->fl_u.afs.debug_id;
 			   ),
 

-- 
2.43.0


