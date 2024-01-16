Return-Path: <linux-fsdevel+bounces-8110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1211282F778
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4011C24A3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1704383AC;
	Tue, 16 Jan 2024 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Euy8jp42"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05D622327;
	Tue, 16 Jan 2024 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434466; cv=none; b=PFYJFyAtn3D3rwT9PY8Hx5oimjeVTimj67gRI28PGTiKY3BfcyakUUoJ0xm7Ed5q9uUef+GNaE40PuR6gOoOiDllAM7oFOgKCa+n6+A2CGQ7yOU6Wy1yxkrexxSXvael7fYYy6ndzPxV09sOHpb8bjVIz+YQPwezgRXm7Pxqp78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434466; c=relaxed/simple;
	bh=k31YYXg5FDv3rraEGkSgE9ZS/UMoQf+Bn2AlHkK2D+Y=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=p/olZxMfataSKoL8Sh0IPAhSoBCDj8x3kyU/DeXt8aznzxecTxFD+1jQ9YM04l7BHR552qzt8c4D4k0qsMcmK5AIlNXAozoqBBJzjEsbVguXtO9OY39RAmDvTCm/FUhkz1hE7+ylNCHVMZGGbmCkdbpEodTlisclrZfWnWyVYgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Euy8jp42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2588BC43142;
	Tue, 16 Jan 2024 19:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434465;
	bh=k31YYXg5FDv3rraEGkSgE9ZS/UMoQf+Bn2AlHkK2D+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Euy8jp42XA5XpHnPXHrVkcKDXDfmeE85YbvjbgSQgcf4LbN9g/kxZDRvpau1jA1He
	 f3KDRyqlNMHDpklXXBduM0sjx+2jzV2R2Lz5IP3ItkgKlGdq1NE2sHQBgDMZP+9aZZ
	 E+BFXJxcg2sDonqdLfOG7sNjRhZ/sLdEUH8RBHt+PJ3Jusba6yLMFUloE4Er+9xKN6
	 39ri7F5c3CWMxFP8m4XuT5e8FY/4FYS5gywMgABTg1dzODxsYG9TK/Bl69axIxzfca
	 xsDL6egBAH5pHVleqfMBauOtlV9UE3o/bV3ryjSGiHpJkDmVJ0lximdd46YaCprENE
	 zdu5t3B3TsOTQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:46:11 -0500
Subject: [PATCH 15/20] filelock: clean up locks_delete_block internals
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-15-c9d0f4370a5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=k31YYXg5FDv3rraEGkSgE9ZS/UMoQf+Bn2AlHkK2D+Y=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0iOaoejNGmyUHU5TWqFozQu5KOWFSGI/C7u
 k7MmzGMzSGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIgAKCRAADmhBGVaC
 FUKPEAC5Vb2188d7pEqtHBFUx21aU2oHLqH8KgcTxbFjDoYS6uTISygh9vaZ/BxicnDFRUFlAf4
 UUzvWZwqlF2JreutIWvZ8/3vkumPFfPIBuKP2ghif6h4eOswePI+WKe9wIpM3M06SEBaVb+aWay
 IUcrFcG0XzDKBUpwr55kP5CDYXNsjQHTLgrUVtoCK6A6OuzRbh4WE0ILtek4g5c4MwO00WiL5vi
 kVXb7e6AMqLJoZwkbIeN5bV/DZTIvrI71HfnenLai2sHVtDUfC1bO3gR4Z8He20hXE3wgTJe7xY
 IrYp0A9FCcjxv1iMHNuQaT+lQQw1XkilxuYAXZ6qdnsx2GXMk3MHUvuBpxiZYzt5djBv+Oo1+K5
 2wINec6lLFIj/rYyTeBWdMuOCWXSANwXVyEl9XckkRmJUVG3rTx7oIEhtDa5S9bK3nd1Pq6e+DH
 Nrx2Gzbt9CwR4KJEy90sLDTtKEduiUgpln57bMJgTBgrguYzODQZqajizQh5vmjWo83RSvQQJOU
 W74f/b92sAJwGAsz2vxdrnZZsKYGVIUWz226rRSQ/pZS+gmJ+h5EHX5efWmrbpLP6M/HV/0a78E
 7AZyluCCd7LDYNaHNZ4ucfc+sD4aGJGnR3nw6QABf3XRuVPFG7Kw8lQCECLdVH9yufmN/H1nHJL
 TvrKQKYa7K1yGIQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Rework the internals of locks_delete_block to use struct file_lock_core
(mostly just for clarity's sake). The prototype is not changed.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 1bc69a96b96d..3a028a8aafeb 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -720,9 +720,10 @@ static void __locks_wake_up_blocks(struct file_lock_core *blocker)
  *
  *	lockd/nfsd need to disconnect the lock while working on it.
  */
-int locks_delete_block(struct file_lock *waiter)
+int locks_delete_block(struct file_lock *waiter_fl)
 {
 	int status = -ENOENT;
+	struct file_lock_core *waiter = &waiter_fl->fl_core;
 
 	/*
 	 * If fl_blocker is NULL, it won't be set again as this thread "owns"
@@ -745,21 +746,21 @@ int locks_delete_block(struct file_lock *waiter)
 	 * no new locks can be inserted into its fl_blocked_requests list, and
 	 * can avoid doing anything further if the list is empty.
 	 */
-	if (!smp_load_acquire(&waiter->fl_core.fl_blocker) &&
-	    list_empty(&waiter->fl_core.fl_blocked_requests))
+	if (!smp_load_acquire(&waiter->fl_blocker) &&
+	    list_empty(&waiter->fl_blocked_requests))
 		return status;
 
 	spin_lock(&blocked_lock_lock);
-	if (waiter->fl_core.fl_blocker)
+	if (waiter->fl_blocker)
 		status = 0;
-	__locks_wake_up_blocks(&waiter->fl_core);
-	__locks_delete_block(&waiter->fl_core);
+	__locks_wake_up_blocks(waiter);
+	__locks_delete_block(waiter);
 
 	/*
 	 * The setting of fl_blocker to NULL marks the "done" point in deleting
 	 * a block. Paired with acquire at the top of this function.
 	 */
-	smp_store_release(&waiter->fl_core.fl_blocker, NULL);
+	smp_store_release(waiter->fl_blocker, NULL);
 	spin_unlock(&blocked_lock_lock);
 	return status;
 }

-- 
2.43.0


