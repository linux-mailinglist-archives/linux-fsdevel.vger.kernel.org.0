Return-Path: <linux-fsdevel+bounces-9764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3559F844C61
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939321F24EEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388091474CF;
	Wed, 31 Jan 2024 23:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQ2yxmgC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8831474B6;
	Wed, 31 Jan 2024 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742271; cv=none; b=pcU6kg0OIfZOpaRlY6yMH0f1Slr32onBABjFpKQStPm+vzqw7E4+Xjh8Jh68DivpphG4xqwD8MquecUs3UyIQxZsnWBMfIE7pBPoVvoSKZdg2xateWLU2UigM60JrFjS05jxtYuz/J7eXRFKN0Ivy1Owgj7W+wIU0QIvuvLQjUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742271; c=relaxed/simple;
	bh=lt+oKLJUC48gDmjw1y21ssCmdJC4YA8AHvCegy98kEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0369fZysez4eBH0YeNTcEnJq5VXADq3NCSR3Q10mAvvl2PcJlEEGODK7s9ggK3xSsvcMKNrSoR7O9KBreELv9aSaXbFKcmhi/8ssKSrCCQLdzF2Xn8K2/G708e2y5C4iAvBmU1D0sGZ+FRq9jfPdGM1hCSlFhTuKyPp1IQaI1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQ2yxmgC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA4FC43609;
	Wed, 31 Jan 2024 23:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742271;
	bh=lt+oKLJUC48gDmjw1y21ssCmdJC4YA8AHvCegy98kEY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CQ2yxmgC28107Kau7/ccyZGZRGK5iUG+YZPwKedOd1g3VeyM/MCegE2d94WDhS8BJ
	 1jWsaQgJr1RDKrGASU/V1OI9FaZEFGz0C7pAp+SROGBT7OHoZC5K343veTcNwfVNUv
	 li5qQlgOqi3kno+ik7DOFFXHF/HBpH6Xnqz6bWeMXM0GGSt1soUq0SIyksv9CQnNUz
	 fEBleUU197/Roj1kwRNRUzLAfxEtxYO6CY1h7WUOCk1toaotkBxhQndt+RbQxrxlIa
	 F3fP7a6tm6c6KVkvKglxnKZtmnK1hXaJj5upbBmKdy5E2jb5UfW0uKRP57115+GWIS
	 TsYdZI6gwND5A==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:15 -0500
Subject: [PATCH v3 34/47] 9p: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-34-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5390; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lt+oKLJUC48gDmjw1y21ssCmdJC4YA8AHvCegy98kEY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFyepmoy/WJ4nMuHI/1auaqF0xE3bBNBZQeI
 IEYB/X2x5mJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcgAKCRAADmhBGVaC
 FQHJEACqIdAaO+PcmXbqT2RlGQptXethNxFqqJ5jHncN3XRhwkl3ISe2vxiPtVXfgUMXsXvtg5Q
 Xx0U4y7KVlRpgmjDEq6tYZieyOFCZfZQt2dmXfP2w45jxhKjzchv6dAK9n02dtnp0/BJKQ/33aw
 8IhLaOUtn989ETCwSVryLxBZqfxgM0PgXGsXUH5aznuzHZ02EeuO5YWvxKd778ZFaJpD2GpRu1u
 l+baoDm9uXK62x/wuaMbSB/AG5gaNDgEK8HBxqz0zfmlPk5OCsdqTdk0oJJH+WISUOrrIKbRFxK
 inxDG0lf9fryuHjCK/AJ/6RvXpaU3U7wlt3ofFm9AiLUw87zNBJ/oclk6zAJqExCcYmGxz/vfJr
 JrtCuxwds3pt8DT67CduU0b/Q+lVz+P6PCbGLqxHTpSdNCtoOTu/rac2vskwCnanlNLs9phHeMg
 JM6voFU+G7d0ABYjJkVkp8vZMmuCp5SXGmlkUtdSo5uIxOlRo7oybqmb/4Xt7JKFfrqpGeyNOru
 22IivsuLub37ZpVxrHEdwBsQyJtm4wDPl3oNy14HRVg2SIFQ3EiL+CIatXm91Y/cHfR8YGcNa6M
 pzkjArY9qTdMS8zm7IfwJ5aE3VJl2702WV2NdD0XReSznaY8EKFRYb57bKbZhKedj1ZOLMFphdC
 J3gJmxUtygqaSvw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/9p/vfs_file.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index a1dabcf73380..abdbbaee5184 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/sched.h>
 #include <linux/file.h>
@@ -108,7 +107,7 @@ static int v9fs_file_lock(struct file *filp, int cmd, struct file_lock *fl)
 
 	p9_debug(P9_DEBUG_VFS, "filp: %p lock: %p\n", filp, fl);
 
-	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
+	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->c.flc_type != F_UNLCK) {
 		filemap_write_and_wait(inode->i_mapping);
 		invalidate_mapping_pages(&inode->i_data, 0, -1);
 	}
@@ -127,7 +126,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	fid = filp->private_data;
 	BUG_ON(fid == NULL);
 
-	BUG_ON((fl->fl_flags & FL_POSIX) != FL_POSIX);
+	BUG_ON((fl->c.flc_flags & FL_POSIX) != FL_POSIX);
 
 	res = locks_lock_file_wait(filp, fl);
 	if (res < 0)
@@ -136,7 +135,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	/* convert posix lock to p9 tlock args */
 	memset(&flock, 0, sizeof(flock));
 	/* map the lock type */
-	switch (fl->fl_type) {
+	switch (fl->c.flc_type) {
 	case F_RDLCK:
 		flock.type = P9_LOCK_TYPE_RDLCK;
 		break;
@@ -152,7 +151,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 		flock.length = 0;
 	else
 		flock.length = fl->fl_end - fl->fl_start + 1;
-	flock.proc_id = fl->fl_pid;
+	flock.proc_id = fl->c.flc_pid;
 	flock.client_id = fid->clnt->name;
 	if (IS_SETLKW(cmd))
 		flock.flags = P9_LOCK_FLAGS_BLOCK;
@@ -207,13 +206,13 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	 * incase server returned error for lock request, revert
 	 * it locally
 	 */
-	if (res < 0 && fl->fl_type != F_UNLCK) {
-		unsigned char type = fl->fl_type;
+	if (res < 0 && fl->c.flc_type != F_UNLCK) {
+		unsigned char type = fl->c.flc_type;
 
-		fl->fl_type = F_UNLCK;
+		fl->c.flc_type = F_UNLCK;
 		/* Even if this fails we want to return the remote error */
 		locks_lock_file_wait(filp, fl);
-		fl->fl_type = type;
+		fl->c.flc_type = type;
 	}
 	if (flock.client_id != fid->clnt->name)
 		kfree(flock.client_id);
@@ -235,7 +234,7 @@ static int v9fs_file_getlock(struct file *filp, struct file_lock *fl)
 	 * if we have a conflicting lock locally, no need to validate
 	 * with server
 	 */
-	if (fl->fl_type != F_UNLCK)
+	if (fl->c.flc_type != F_UNLCK)
 		return res;
 
 	/* convert posix lock to p9 tgetlock args */
@@ -246,7 +245,7 @@ static int v9fs_file_getlock(struct file *filp, struct file_lock *fl)
 		glock.length = 0;
 	else
 		glock.length = fl->fl_end - fl->fl_start + 1;
-	glock.proc_id = fl->fl_pid;
+	glock.proc_id = fl->c.flc_pid;
 	glock.client_id = fid->clnt->name;
 
 	res = p9_client_getlock_dotl(fid, &glock);
@@ -255,13 +254,13 @@ static int v9fs_file_getlock(struct file *filp, struct file_lock *fl)
 	/* map 9p lock type to os lock type */
 	switch (glock.type) {
 	case P9_LOCK_TYPE_RDLCK:
-		fl->fl_type = F_RDLCK;
+		fl->c.flc_type = F_RDLCK;
 		break;
 	case P9_LOCK_TYPE_WRLCK:
-		fl->fl_type = F_WRLCK;
+		fl->c.flc_type = F_WRLCK;
 		break;
 	case P9_LOCK_TYPE_UNLCK:
-		fl->fl_type = F_UNLCK;
+		fl->c.flc_type = F_UNLCK;
 		break;
 	}
 	if (glock.type != P9_LOCK_TYPE_UNLCK) {
@@ -270,7 +269,7 @@ static int v9fs_file_getlock(struct file *filp, struct file_lock *fl)
 			fl->fl_end = OFFSET_MAX;
 		else
 			fl->fl_end = glock.start + glock.length - 1;
-		fl->fl_pid = -glock.proc_id;
+		fl->c.flc_pid = -glock.proc_id;
 	}
 out:
 	if (glock.client_id != fid->clnt->name)
@@ -294,7 +293,7 @@ static int v9fs_file_lock_dotl(struct file *filp, int cmd, struct file_lock *fl)
 	p9_debug(P9_DEBUG_VFS, "filp: %p cmd:%d lock: %p name: %pD\n",
 		 filp, cmd, fl, filp);
 
-	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
+	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->c.flc_type != F_UNLCK) {
 		filemap_write_and_wait(inode->i_mapping);
 		invalidate_mapping_pages(&inode->i_data, 0, -1);
 	}
@@ -325,16 +324,16 @@ static int v9fs_file_flock_dotl(struct file *filp, int cmd,
 	p9_debug(P9_DEBUG_VFS, "filp: %p cmd:%d lock: %p name: %pD\n",
 		 filp, cmd, fl, filp);
 
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->c.flc_flags & FL_FLOCK))
 		goto out_err;
 
-	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
+	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->c.flc_type != F_UNLCK) {
 		filemap_write_and_wait(inode->i_mapping);
 		invalidate_mapping_pages(&inode->i_data, 0, -1);
 	}
 	/* Convert flock to posix lock */
-	fl->fl_flags |= FL_POSIX;
-	fl->fl_flags ^= FL_FLOCK;
+	fl->c.flc_flags |= FL_POSIX;
+	fl->c.flc_flags ^= FL_FLOCK;
 
 	if (IS_SETLK(cmd) | IS_SETLKW(cmd))
 		ret = v9fs_file_do_lock(filp, cmd, fl);

-- 
2.43.0


