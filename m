Return-Path: <linux-fsdevel+bounces-8103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A33F582F752
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4099E1F25765
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEF87A724;
	Tue, 16 Jan 2024 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGt5MOni"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBD37A710;
	Tue, 16 Jan 2024 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434439; cv=none; b=kFNiPad7veTFyXx4olAT5dGGZ2UIOQh6nXNKjDLPJSV6DS+EfMN33leAgM7T1HBLJ4h+FxKjs02MGa0Hdu7IplIWnz3hcih/RknPX09r74SdMZupWRcGaI9N1Dn4PKaUyY9CyGBmh8P4sLWeCaIGGkqUbJ/xWhbAzOyofSIkIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434439; c=relaxed/simple;
	bh=WIy21odrljEB/8swbFzVsTPOFgQ6www6fvkeNvY4iqY=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=Yfi8G7ghwnMznsd0WZZfrth1FC5Re3LuKKlKL+8+4rsHWKyKiX22VSW5K/WxWcqWlfR3w18q7SSE/Iv41PKe5gWvDuoL5TINxte8KU2XfI+GVJuH1ugEd8HWGd7rgzxehX8rym933XO+CDnYWqEZQQJgHG8ioAjVwa+HbNZJTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGt5MOni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E2AC43601;
	Tue, 16 Jan 2024 19:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434438;
	bh=WIy21odrljEB/8swbFzVsTPOFgQ6www6fvkeNvY4iqY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dGt5MOniA8nfT85OoK0KWNQ4NT9/XemjVhwDT+efQCLEjfiTLRnvIj7LiZt02k3EW
	 17NTxfrGKdCg43vu+P4kGL0hBVy/91aq4gKXgjT1FFFXSay+dVliMzxcGsFeFEdvuE
	 raPX8KnHP9y0VvGADbWlAN2WTaGMTmjHg4nsQItG044lqNNC0zxhMWEupvVVkNIlcJ
	 O/alVqebMPNpY3guN5B7+na+zWXhepZ95j9mwR8uwv72nPfJ0h5ISqHB1nC2T0AdmV
	 rYLUoLQFvcxEJjiQY875sCy+bo6iq5DdWI1gcLG5A2OzA8P0xm5WjWwO40k6SaHVJC
	 JLEOkl2Iu4B0Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:46:04 -0500
Subject: [PATCH 08/20] filelock: convert posix_owner_key to take
 file_lock_core arg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-8-c9d0f4370a5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1521; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WIy21odrljEB/8swbFzVsTPOFgQ6www6fvkeNvY4iqY=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGWm3SHI8HlRl76pu2TSIazqmfWFiBENf9VKaxrnEIZCTfeT4
 okCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJlpt0hAAoJEAAOaEEZVoIViQUQAKxb
 +b9el1PF/VmfJamuXgUyj19YbaXbVQKO6E9pjWNjQskJL75ddlMjtr/y744PPDGj9H4ju0pIWNh
 sqUSybtawT3M//aDvubTbkntkfvR4H0nySFl+vjiUI9p1/0DOAyz6ATkQhWQUMx3/tabewpUuUk
 iDBVltVkaiou7x8enWO23IUKYzeFAwK9j3gMvebdeYYcq9qDKH8kTSmXkHuyYUbaJ2rf0FrZWSW
 V4d5VyKbfzrNC8ghF4jG4sCiUycWCspWtx4EDvpE2F6FGEZ2tZomyZx1WEwbJea3jnf36JafysI
 DO3lpxuv39GLe5qUA6BV6H5e/PgRo01V2YsHIMgizY+rRheXglPhPQ+m+hKxJ6KtJ59X7BNsIHI
 SaHMZ4l42DhK04tsSRjtW1YUidY3i0wNJ4mRU667+oToOvzPs5SxGNZRhscsTc/YbphZcPQETyk
 YaMgKjO3AqFvdvvx8GOA448/IKYA1UAaaIFOXbO8ZalbMlp+73fSz4lIhg8d19zMfVZIk4vlRdW
 oqNJWTbFE7Wp4J/IVsYpedrJWOzAaiBftTtGNhANyWJsqJN33mkmkJumIuDG0Z8dqu1kizBGXN1
 3ETLW5FK7hnpj9pfc/YAaRCYCyLO8ZaTzl/yvQEW5pYRAVwFvRCfV2TVl4rbCfuW90M1KG9qOEB
 qzYZR
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert posix_owner_key to take struct file_lock_core pointer, and fix
up the callers to pass one in.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 0c47497eb1a4..6432bcfb55a0 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -637,9 +637,9 @@ static void locks_delete_global_locks(struct file_lock *fl)
 }
 
 static unsigned long
-posix_owner_key(struct file_lock *fl)
+posix_owner_key(struct file_lock_core *flc)
 {
-	return (unsigned long) fl->fl_core.fl_owner;
+	return (unsigned long) flc->fl_owner;
 }
 
 static void locks_insert_global_blocked(struct file_lock *waiter)
@@ -647,7 +647,7 @@ static void locks_insert_global_blocked(struct file_lock *waiter)
 	lockdep_assert_held(&blocked_lock_lock);
 
 	hash_add(blocked_hash, &waiter->fl_core.fl_link,
-		 posix_owner_key(waiter));
+		 posix_owner_key(&waiter->fl_core));
 }
 
 static void locks_delete_global_blocked(struct file_lock *waiter)
@@ -984,7 +984,7 @@ static struct file_lock *what_owner_is_waiting_for(struct file_lock *block_fl)
 {
 	struct file_lock *fl;
 
-	hash_for_each_possible(blocked_hash, fl, fl_core.fl_link, posix_owner_key(block_fl)) {
+	hash_for_each_possible(blocked_hash, fl, fl_core.fl_link, posix_owner_key(&block_fl->fl_core)) {
 		if (posix_same_owner(&fl->fl_core, &block_fl->fl_core)) {
 			while (fl->fl_core.fl_blocker)
 				fl = fl->fl_core.fl_blocker;

-- 
2.43.0


