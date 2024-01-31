Return-Path: <linux-fsdevel+bounces-9773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961DF844C8D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48478298599
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF7514D447;
	Wed, 31 Jan 2024 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nyz4BOiv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A7014D426;
	Wed, 31 Jan 2024 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742308; cv=none; b=XT8dVb8rtsXqnPxifciIwJUlO2x4aGQhcqABWp2PoJdDoJZzWx7T04sONFI/E13PhIJ99SPnZ1hWr5hbpWChglm8BD8v3F8lXLib+ZtMpdobUeMoVT5uqfFENOwR3yHakfLL3FzTmh6ADJJVRkp9RNqhguWTrJYR7L5cCftX2IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742308; c=relaxed/simple;
	bh=zBEQAnXiMZJe4QRF33dUYq06POQWEY8Fz8nVDZKBnJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o2goLsEtgNdalyRXhF0S2qQVlnO4QTOvQ+9StX9373Qo2iWFpW7ut6GuH11gQMO4P+sj/SN07W9OgftkPGmU7+kNW3tq66dwPRHv7TRB+8ACGV48xx9pxg0HUbdwWwpjdfTFTyYryO3RAG+m8S+DriWnH+L7TRGcnATeHNu2KV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nyz4BOiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D61C43330;
	Wed, 31 Jan 2024 23:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742307;
	bh=zBEQAnXiMZJe4QRF33dUYq06POQWEY8Fz8nVDZKBnJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nyz4BOivW44cbjphxKFgKghcs5rKHI5JuEZCoD7BBHArtmTFWt1/ZQA1jYFQl0W6w
	 NJagd014rViw3KhRoWYfh8K1fLVL0N2VIfnl+JIQj6fuOFS/WETvmpNUfpAEFuVI2T
	 gFKJu1CI1nG537UFvtSpraQYXXETen50FMKpFCSWSsStyGejkABG6ubWVMR5YZer7S
	 I9h3HLzn32B0p6/vBKmuSmKbMdaB9D1XW5M84Vwse3oizaMsyz6De4tlSi+O0FBDUY
	 DkJGVs0KJpv2mTTThV2fravipD1vFG1jJHG/TFpj7rulfta1LTFhfDZVJfPpyztUdu
	 M2taDOVCnSMtw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:24 -0500
Subject: [PATCH v3 43/47] ocfs2: adapt to breakup of struct file_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-43-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=zBEQAnXiMZJe4QRF33dUYq06POQWEY8Fz8nVDZKBnJM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFzffLuLGCb6wJC3ZnImhz7hLMiQatYWsAWx
 A2TEcmrZqqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcwAKCRAADmhBGVaC
 FbP4EACb3skq+/Ot6pcuM7Ni6QyiG4Ogfv4oMqQomznq5s5Hp3CwL2zAY3qSoehH5AMzK+KvRRS
 6b00hs8OL13W/SF21Njq7Vy8gmAAh2OJhc0xG/Jb3aIoYbEeQU7giec5fzkTH/+Okc7c60UwbMh
 fY8VP066LimEoCSa7J30BMV90F52JuTc1M44K1Gw/+Aw+I7KidNtFeYwu1FpkJ0qVz9bIuSp5lq
 kR37bvbHD5pMvG0WyX7thsBaS3FBjfNfWqixezQOTIlurrwvGpQhIOYa/YL2hZn3Ft0otn+5ZER
 Sk/H8rsofIWQa2Q+obTxlZflAGw1dNSI7UkvyvXgxxrhBQXXMI1N+SB1FjMQBra0p7UF9mAITc+
 vsLqkKD1Gp+bwfFtw/xhVGfmxPc+tyB1dsUs5/6aCLSjY8XQswmhT9Cy06G/jeMFyx2UVN3NgOf
 8mPsDOdEqftE4xzC2rLo+UArgQBdWsPPfJspVvsGhzwrwrSp4WtLUc9MrdPIQDxj/ykqkDeLOVZ
 CwkXtXxXqKObLyzLRQl8tSNMwrmTnLHjRQqc54W3otiJVeVRVkctKIFvf9RGW1H5aYQhMkYDUH2
 B0/wgcsV5hRBSQeMkYU/L5iDwxjB0yi3cqRiXSCnAntmakaXxUlxZXp7hfrSBd3Tx9alhkrhc0h
 y++bjy9bE9iqK/A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Most of the existing APIs have remained the same, but subsystems that
access file_lock fields directly need to reach into struct
file_lock_core now.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ocfs2/locks.c      | 9 ++++-----
 fs/ocfs2/stack_user.c | 1 -
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/locks.c b/fs/ocfs2/locks.c
index 84ad403b5998..6de944818c56 100644
--- a/fs/ocfs2/locks.c
+++ b/fs/ocfs2/locks.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/fcntl.h>
 
@@ -54,8 +53,8 @@ static int ocfs2_do_flock(struct file *file, struct inode *inode,
 		 */
 
 		locks_init_lock(&request);
-		request.fl_type = F_UNLCK;
-		request.fl_flags = FL_FLOCK;
+		request.c.flc_type = F_UNLCK;
+		request.c.flc_flags = FL_FLOCK;
 		locks_lock_file_wait(file, &request);
 
 		ocfs2_file_unlock(file);
@@ -101,7 +100,7 @@ int ocfs2_flock(struct file *file, int cmd, struct file_lock *fl)
 	struct inode *inode = file->f_mapping->host;
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 
-	if (!(fl->fl_flags & FL_FLOCK))
+	if (!(fl->c.flc_flags & FL_FLOCK))
 		return -ENOLCK;
 
 	if ((osb->s_mount_opt & OCFS2_MOUNT_LOCALFLOCKS) ||
@@ -119,7 +118,7 @@ int ocfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 	struct inode *inode = file->f_mapping->host;
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 
-	if (!(fl->fl_flags & FL_POSIX))
+	if (!(fl->c.flc_flags & FL_POSIX))
 		return -ENOLCK;
 
 	return ocfs2_plock(osb->cconn, OCFS2_I(inode)->ip_blkno, file, cmd, fl);
diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
index 39b7e47a8618..c11406cd87a8 100644
--- a/fs/ocfs2/stack_user.c
+++ b/fs/ocfs2/stack_user.c
@@ -9,7 +9,6 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
-#define _NEED_FILE_LOCK_FIELD_MACROS
 #include <linux/filelock.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>

-- 
2.43.0


