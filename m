Return-Path: <linux-fsdevel+bounces-8100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC1882F73E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE971C248E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932D27E787;
	Tue, 16 Jan 2024 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHwTTmLI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D232E7E774;
	Tue, 16 Jan 2024 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434427; cv=none; b=Hq1UaIhdFFFdiExriD9dV4QF59kt1ZjcQW4TrGKQK0hyQo3notZc0nyv29q26PDHL2YL1wL76eImc7FXAl/GStDLT76dGGM+ADd/y6PKRJTjbTDuiCLH/zEBqo1H+bej7QbiJE4H+gfhdG/3/8cCiathX5gbaAKxA/vjzH5FFG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434427; c=relaxed/simple;
	bh=yDsuU1Zw9gxCujhD8xa64udMU/oaPFDr1SbUE7U7jIE=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=Gm5XytrZXJE5w3odaqk5Mo5ElW4TDCCIXpF/e4SziN325Iq1MSN3o+WhS4AnDyHDfXdLxyKK91ZUP0BUzTkSfzend3zDXmvT23mhheOeOroN8ZvuJpinfWBykbUUvzOIppRLDOVy/4YDF2Lvid3BuMb3fn8v4pS+YHV6FX4eQH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHwTTmLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D0EC433B2;
	Tue, 16 Jan 2024 19:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434426;
	bh=yDsuU1Zw9gxCujhD8xa64udMU/oaPFDr1SbUE7U7jIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VHwTTmLIU5WtY7YZEJ2Ur6v7Bc2ZO+L1BCAmSHvG3hHBEdwUCECGl2SJV8aBJvx3N
	 v/Debi9V8tv6BQtgxHaOUxHee6rmDUHnYs+8gMn1l5ImaiTQGludKNR0jNBoz+XLq6
	 g3grmjkpLmcStczkUuKYNMxNdHLf4gVUWD1A41xHYZfAAlMW2R6LDdGVhcZzt03++a
	 C5iqveKFWqbVdu1TxuzWNT/RK6kfECrS6Rw4ayUSwjX5hRtxq7BLLbaIwzl5aB5ewK
	 qbCgX0XpEI9IPmfuVImexA+tUOCKKmQBbsqRHkP5Vag1lcVDjyVzJFtfjJrX4ZlznG
	 WokiLMswsbsMw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:46:01 -0500
Subject: [PATCH 05/20] filelock: convert some internal functions to use
 file_lock_core instead
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-5-c9d0f4370a5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yDsuU1Zw9gxCujhD8xa64udMU/oaPFDr1SbUE7U7jIE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0gVcrXW2g/TK7GdwhFc0QwsV1CF3i6HJklQ
 lY6mK00vy6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIAAKCRAADmhBGVaC
 FUDwD/0W6sL9ycLrZsOaPzmRJdLOqA0UnNIsgyMABRAU9sMIKmGthsGs45uq3K4T6agyWoD6VJK
 VSypAHRxBZQQYwJNhZrGy5oQ4M1vheZK/uCLxUmZoHVsSluowKgeDURi3UZW0WGSR7LD6mxEB6h
 OUFMMarXNOjcKJPK81g8RX4RqG8fMz4u5SYy2tzwwKxBFhCwFz09yTbz9BDZwoZgWbNMYcqpRSk
 uhGEVNUfKx3yWIs9mva9QL3wlzUm4GD3T+DS/ukCdxtRAl2YVIpAzPc5bNvzWehP2uVwG+HK7qB
 Halx0h+4TVBQLFcp4saLYx0ujQ0D+H/6G7l0/Gxx6Rw2aB3A7KX8z6yO78dnRO5ZrD6ocU76GDZ
 PtelVsqxVFxIOvisTjXdUMPyfw72AU7tc9eRDV8jLdpgta2U2V+UPBl/mg4rNEabfJI4qbst3+0
 MuTAOQVIiRkrBd7uXHLnfZF0oSeqpoz659Vazg5Y6NeHRACxf07kXSJ1AqDNnCcvZCc+XqOBY0U
 ZKuLL1c+2c0gLjTQqAzbgUwPwe69JrA8hMO5avGsjuB808lw+YW53U8gNLEWyrZT+LFm4CyUCbu
 pfrKAIOtsH3h/mKbBFybrByDWokTbO2YXB9ySd5qgD/gqgniIMSLgG3kmfhTENkNyHT4RM8pH7s
 sTXiDx4/HahrMKA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert some internal fs/locks.c function to take and deal with struct
file_lock_core instead of struct file_lock:

- locks_init_lock_heads
- locks_alloc_lock
- locks_init_lock

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index afe6e82a6207..42221cecd331 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -258,13 +258,13 @@ locks_free_lock_context(struct inode *inode)
 	}
 }
 
-static void locks_init_lock_heads(struct file_lock *fl)
+static void locks_init_lock_heads(struct file_lock_core *flc)
 {
-	INIT_HLIST_NODE(&fl->fl_core.fl_link);
-	INIT_LIST_HEAD(&fl->fl_core.fl_list);
-	INIT_LIST_HEAD(&fl->fl_core.fl_blocked_requests);
-	INIT_LIST_HEAD(&fl->fl_core.fl_blocked_member);
-	init_waitqueue_head(&fl->fl_core.fl_wait);
+	INIT_HLIST_NODE(&flc->fl_link);
+	INIT_LIST_HEAD(&flc->fl_list);
+	INIT_LIST_HEAD(&flc->fl_blocked_requests);
+	INIT_LIST_HEAD(&flc->fl_blocked_member);
+	init_waitqueue_head(&flc->fl_wait);
 }
 
 /* Allocate an empty lock structure. */
@@ -273,7 +273,7 @@ struct file_lock *locks_alloc_lock(void)
 	struct file_lock *fl = kmem_cache_zalloc(filelock_cache, GFP_KERNEL);
 
 	if (fl)
-		locks_init_lock_heads(fl);
+		locks_init_lock_heads(&fl->fl_core);
 
 	return fl;
 }
@@ -354,7 +354,7 @@ locks_dispose_list(struct list_head *dispose)
 void locks_init_lock(struct file_lock *fl)
 {
 	memset(fl, 0, sizeof(struct file_lock));
-	locks_init_lock_heads(fl);
+	locks_init_lock_heads(&fl->fl_core);
 }
 EXPORT_SYMBOL(locks_init_lock);
 

-- 
2.43.0


