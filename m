Return-Path: <linux-fsdevel+bounces-9757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C613844D54
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DAC0B30AA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C514B1419AF;
	Wed, 31 Jan 2024 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezeLi77R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B7D3CF68;
	Wed, 31 Jan 2024 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742244; cv=none; b=icL2UjKuVHTyZdoH4i4X19EtPm5OOMGKTQYxSmYZ7Z6wvH70HoE9zi2T/Gkv1SI5j2vEGAQmgNsndfn7N0tDOIa8kbEHKJB4olcwJaOn3F3gA+mmDaS8liQcK5w6nYk4nJ4KF3DYIcfx0HIjEEJ/ziYMtZX1SuqNc1aFRoZGQN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742244; c=relaxed/simple;
	bh=Z1i7xtMOMqvm3D7J9G0rdH3DGYJGfjyVOTowr14DW4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mv3xfWrUG3qQ3/w5eWFndQGq19d4rfQASfvdWxznf9D+5A29kDYdDlBrbTbgfMnaRONhEiXoaqhrgaWnnuBHpXwtd5yAT7HJTsi5XUM6h/eo/KqvK1uuF8LYEvLQE0NJx9rr/ENM0dzME44LpLxbEE8SC+rsU94MB6LL8b0mh9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezeLi77R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D382BC433B2;
	Wed, 31 Jan 2024 23:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742243;
	bh=Z1i7xtMOMqvm3D7J9G0rdH3DGYJGfjyVOTowr14DW4I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ezeLi77RDC+M1M2PGVDqofoaYkKFWZx0BAyYGOzKAPHsqWMUe7xLTjpnu4PvioChG
	 iGZwkecDAT27heYOpKXXAviTfBzS4j6lnoeIsfm7aGa0M9Z4/lxvn5EFHVXxkeZP9r
	 HXzPDmLetN26GcPJdEMKXjpchS1MFHFkSPArD7BO8II60E4uZuEjBQ8OvvhUMTbS8N
	 3+0Sxt9Ki9uL/pzVkLoXmGQI54jn8i21BPWDWwFqopO6411gryQWyNj9YwX1TQxOvp
	 s4+XzPVoKlACpUfflzE+NJ6PKIXrNbkI5vIYslelVhIFhO3Kr7UWr2nNkxIpUvO+GB
	 krms0StfW8P5w==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:08 -0500
Subject: [PATCH v3 27/47] filelock: clean up locks_delete_block internals
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-27-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1848; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Z1i7xtMOMqvm3D7J9G0rdH3DGYJGfjyVOTowr14DW4I=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFxdSj2FyNqB+Gw8Plq5ShJdeZ8Mw/eSh1Ig
 3sO5sTmrJ2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcQAKCRAADmhBGVaC
 FVtCEADGeoEvKshm2+1gQy+z0fWDa7I+c8HaoX9GoO9xbTseu7MbPgfZlZSMSNROy+j4TEVc2GS
 A6Ny3poezAmDA4f1y50X2cVUWak3D1HwslyoVfmHOEcJsuWCp6KuAAmpGCWJCypye53gKSKDrbM
 hOB1GY6em/gj8ASt5oAWjinaXWgmfzFNONOdJVzam2X2kR6L3t//gw3pEhRXYEHdliEJKFfTUcR
 DSskL8b/KsgPjE8jpp2davDT+m2Va9WDqVIzm368X5n3JE5QjswtGSrEdR2OFE1Se740x+/8yrS
 ioHiB5xlKlYuIa5Oda3puIiTwJuE8yqefwNsBE4vAWdKHbzF4yGTtKtNC1lH6H4LtcP84PoMuKg
 d2v5VWVVHY1yInW1jkSLZcVAoQ8y4w0HX5ITn/RoQAf1UKzX9cMby6h5cuI4HrEZGgkY9Wnrp6h
 zTR38CBYsTL3R7+HWwJks/tWESERQaI08fBiAZvh8o3R5kajGS4/uSvqM07WbYtMyS2BYvlyEgl
 hTc1to+r2E8UrpyHOkLpSwVfLiWDOGJCX0w8xeVWvRLs0ng3IvbcQfHIV9RdNeXAvVl0Cc8+jbO
 DE63d718vTniChHhHYvl8NRy9hGyCbL4mRHpeMzNj7qE8uYnbMIkQotCQ4pQWDUJ9TXUpAZjQFd
 CtKW7Z7FK3oaDOA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Rework the internals of locks_delete_block to use struct file_lock_core
(mostly just for clarity's sake). The prototype is not changed.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 0aa1c94671cd..a2be1e0b5a94 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -697,9 +697,10 @@ static void __locks_wake_up_blocks(struct file_lock_core *blocker)
  *
  *	lockd/nfsd need to disconnect the lock while working on it.
  */
-int locks_delete_block(struct file_lock *waiter)
+int locks_delete_block(struct file_lock *waiter_fl)
 {
 	int status = -ENOENT;
+	struct file_lock_core *waiter = &waiter_fl->c;
 
 	/*
 	 * If fl_blocker is NULL, it won't be set again as this thread "owns"
@@ -722,21 +723,21 @@ int locks_delete_block(struct file_lock *waiter)
 	 * no new locks can be inserted into its fl_blocked_requests list, and
 	 * can avoid doing anything further if the list is empty.
 	 */
-	if (!smp_load_acquire(&waiter->c.flc_blocker) &&
-	    list_empty(&waiter->c.flc_blocked_requests))
+	if (!smp_load_acquire(&waiter->flc_blocker) &&
+	    list_empty(&waiter->flc_blocked_requests))
 		return status;
 
 	spin_lock(&blocked_lock_lock);
-	if (waiter->c.flc_blocker)
+	if (waiter->flc_blocker)
 		status = 0;
-	__locks_wake_up_blocks(&waiter->c);
-	__locks_delete_block(&waiter->c);
+	__locks_wake_up_blocks(waiter);
+	__locks_delete_block(waiter);
 
 	/*
 	 * The setting of fl_blocker to NULL marks the "done" point in deleting
 	 * a block. Paired with acquire at the top of this function.
 	 */
-	smp_store_release(&waiter->c.flc_blocker, NULL);
+	smp_store_release(&waiter->flc_blocker, NULL);
 	spin_unlock(&blocked_lock_lock);
 	return status;
 }

-- 
2.43.0


