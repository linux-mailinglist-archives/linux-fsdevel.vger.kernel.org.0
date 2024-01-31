Return-Path: <linux-fsdevel+bounces-9743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6B1844C00
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA085B2F3E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4751C487B3;
	Wed, 31 Jan 2024 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNSSJ0C2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866FA487A1;
	Wed, 31 Jan 2024 23:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742188; cv=none; b=q+d68ppkJlemR6VunOnX6YKi5zZLnHeuhE/CzDFs3eW2NjzSCkBC52fTVzVlB2kCbpQ01IkvUPSfFmKVp5VNii+dc9l+H0Yf0zXQCmTh+Umd2Kh3Rbzpotq2aO2kp7wznqXk4hM5f2wFjKm2LFQt0rRrSxrmfjCSj805wLiTFYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742188; c=relaxed/simple;
	bh=EFlVkHnQmHeR5AVV8oxG1B2hEEbbFRmZ+IYq2868ekg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sXp+uXF8Z0QLOu7941AaQlK3ad64cC+MdgOM8bC5sHCjHj7APzyKTqtvy6hK1O8wY5bhXk2AO2McksQOGhjW5xO0/+qtOS8HV8M9xU4SfA9ipUu4gEg6ac5fgOxe73PAVwo1sEzzPlP3SNOpZJGz9K0Q6UvmHN3pJUU+Lez/s84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNSSJ0C2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED29C43390;
	Wed, 31 Jan 2024 23:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742188;
	bh=EFlVkHnQmHeR5AVV8oxG1B2hEEbbFRmZ+IYq2868ekg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lNSSJ0C2ImGgbX5Yjnil+TU6NTI8bH/1NDhTxylgzSifvgPkVBaRtJ15E2GF08Xc5
	 a8Miydg1cJjHleheXfSLxQHq6Wk2B3Dlih/ixufNoR3j0S/+cpX8Tlk32Ub7EsFPZY
	 Hhd3AOca7cBs0d6ZvT1e2/KB8euURzhAc4chOK+XbGq1vPko6pyZcOsOxdR0lEY2W9
	 BMr88DfxtIuEAdMXzKgqAz8SjPuVzK/rHZYeSWlEE7r2rRwFy1N4OzSqo1HKzFILOv
	 u9bxXIPgN/iw0mRimW/JTA6ABtex+i5jRrVBLcBPNe36fmGdQINcIqqx9iXY5NvRh1
	 6+JT9FcwqWTIQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:01:54 -0500
Subject: [PATCH v3 13/47] ocfs2: convert to using new filelock helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-13-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1614; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=EFlVkHnQmHeR5AVV8oxG1B2hEEbbFRmZ+IYq2868ekg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFvuUuTAN70pAU+Kmn0DRaJoAkSOm7A1E3Kh
 z4g08wxjvCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRbwAKCRAADmhBGVaC
 FeF+EACtppk80KFUuP+h+mRcJmDCxjXiwNMLVg00WEjEKc5OeQDZYuvb7SvezUq4CXdp61o4BV8
 9JHBfPxT+UTIzDUm5QDDLA3d6jXol8Owe186Mgt7I/FfK33jS5eNlkbHuzStmUvDAPWqlZ4DT0M
 mNVdX+Ahgn4XaR9I/PkgT63kVRa9avOSowc3MTfmkaI8GsWF0CWbLCqJ8yWkLcH7HSRjlJF9Ofk
 DNvy6ByoTAGv4yFkA7wbm2QnxK4MvEcjNVeHVC9LE3o1kAP86MxsODOzm5/8vfaWUJHe2bIgS9G
 ian0ODKke6CZNEWat7txiph5BzieOwa95RA8y4z3ODKuD/u74Ykv28fQSQm0L9kSAvlvZMvMLHR
 yP85I4EaQj3Y3xUwfDjk44EpbQp0/TQ/n7I7jYgRNHSAKnwQCZISnxBlVqPFYwrjGW1lXrijpQh
 JuL+Ms2RattMv6J3/iA14l62VO0Wv3P2R91sGycp+t3e2ENZiltNFfRzgAoqoWMlZxA6YhOy+Pz
 BD6jjCYvBoYT1uBoD8IL+2+QOxwmULpFnYthyQummT3FM2QMH0Q5qhyu0LZVTt2eQg5cwEMzScw
 /dgQsIHppiwE5+FMaEUjkDtkiSLLuNialqpAEbyLFnEBmsr38iJwFBwC+EjF5Mm/8pkoZn1/zMp
 uJILMsk5XIkaSOA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert to using the new file locking helper functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ocfs2/locks.c      | 4 ++--
 fs/ocfs2/stack_user.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/locks.c b/fs/ocfs2/locks.c
index f37174e79fad..ef4fd91b586e 100644
--- a/fs/ocfs2/locks.c
+++ b/fs/ocfs2/locks.c
@@ -27,7 +27,7 @@ static int ocfs2_do_flock(struct file *file, struct inode *inode,
 	struct ocfs2_file_private *fp = file->private_data;
 	struct ocfs2_lock_res *lockres = &fp->fp_flock;
 
-	if (fl->fl_type == F_WRLCK)
+	if (lock_is_write(fl))
 		level = 1;
 	if (!IS_SETLKW(cmd))
 		trylock = 1;
@@ -107,7 +107,7 @@ int ocfs2_flock(struct file *file, int cmd, struct file_lock *fl)
 	    ocfs2_mount_local(osb))
 		return locks_lock_file_wait(file, fl);
 
-	if (fl->fl_type == F_UNLCK)
+	if (lock_is_unlock(fl))
 		return ocfs2_do_funlock(file, cmd, fl);
 	else
 		return ocfs2_do_flock(file, inode, cmd, fl);
diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
index 9b76ee66aeb2..c11406cd87a8 100644
--- a/fs/ocfs2/stack_user.c
+++ b/fs/ocfs2/stack_user.c
@@ -744,7 +744,7 @@ static int user_plock(struct ocfs2_cluster_connection *conn,
 		return dlm_posix_cancel(conn->cc_lockspace, ino, file, fl);
 	else if (IS_GETLK(cmd))
 		return dlm_posix_get(conn->cc_lockspace, ino, file, fl);
-	else if (fl->fl_type == F_UNLCK)
+	else if (lock_is_unlock(fl))
 		return dlm_posix_unlock(conn->cc_lockspace, ino, file, fl);
 	else
 		return dlm_posix_lock(conn->cc_lockspace, ino, file, cmd, fl);

-- 
2.43.0


