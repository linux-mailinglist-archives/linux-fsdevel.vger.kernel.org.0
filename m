Return-Path: <linux-fsdevel+bounces-9753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0E4844CC7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9642EB25DD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB83F13DBB7;
	Wed, 31 Jan 2024 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAOAOSU7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD913DBA3;
	Wed, 31 Jan 2024 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742228; cv=none; b=V7dGNI5iG2URUZO30mj3GHCzpiPOuX2xytJpBLXGBiZcn4ixAd0qPOp0wKLdkA/5uDSf7rv5uS1zJvRaPs7aLxXNqDsjK4+Ixyxo9uA6I3INs0EQ/DUEcnzNG0KdZ89rQycLXdEerRyb7GdPqnhCMSS6xO1Tws5GTj4Dd/R/Vto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742228; c=relaxed/simple;
	bh=4tOxyT/oI/1lhQqF55YACz3kQzpHB6F0e4ImXu1UTTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hRSX0Ax9vD+KzQjxAwFoRK2JRvQnI0/IuCy+qrGS67Zf2M1w87Cp7UlM/x6YKYAGSm9ipZsiezycl0GmcQv4QpQx7Wdd8ko7b+Wx89r0CWYn1MRAMqwgV78lWEUtdnUFG+J+YuK1ZE48tFv6eF1x/N5ZDD0PLjKuBQiE91Xkyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAOAOSU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0132EC433A6;
	Wed, 31 Jan 2024 23:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742227;
	bh=4tOxyT/oI/1lhQqF55YACz3kQzpHB6F0e4ImXu1UTTE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qAOAOSU72/AyfKkvF82DBj4l6z2FUZhEzDLspP4Zza4VobRC08tCPqbPqgXcRk/bQ
	 agKiM+HnRmXCpomdoak4LOK+MAUb98NeBAYWhcHK3NagKwbFW6l83FoU6lVt7fym73
	 Q1aWIAG0qdLLdDS4qKhCw0MGSmYZSe3SPcZlA8mX6XYJoK58j5k0xOuFmgMMIb3Ctx
	 i2qeohjbl29DxnwMFvViRC6b1ldMix8DPg4EtQr71JFXkl3r3SZyiWNiIHr9O+VNTV
	 Y95pnJ3sPb0xJbw22iSPNb8bxuTGEOVgEBK8I/uZcX3AqAgsP1DF5YdqDI+BR0ynT/
	 /cXGkyb8wH3kg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:04 -0500
Subject: [PATCH v3 23/47] filelock: convert
 locks_{insert,delete}_global_blocked
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-23-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1916; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4tOxyT/oI/1lhQqF55YACz3kQzpHB6F0e4ImXu1UTTE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFxwdWZ98doXE/30aQXIB5Fy9rJC1xuYMBJr
 LGavtYdxSKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcQAKCRAADmhBGVaC
 FbD1EACyRTlXeLr4ITR55lqhiH1Lzhy+kEtVEr7rjKSgz5Nudf7AbcCeSzVzjocTz/XqBa6r/7x
 4UMD3pw0kazDCz/3PZSS5kWmXumuAk52BCoiQEGUD53wpGezyQP2kWrBA/uG7j4KaLVV+1b/LiM
 Swt52WxlfhZruRF1xuh/hhDvTvUdGpKvp8XZuSn9ImtHwhwebwZip4sNw1mZhM9wsujde+7aO0t
 C6WC9Ioxuy3cqt/0UaN9JogWGYpBPERfyxeyJmlScyAV7WxwWL9tYadE4RRZhUkIcuqWT1oHrZG
 qQ45NPsxlApwwmRRtK0Btw4hIYb5XcNKQkMvDGS65mWAGFvvEHMYbjvrh6YZ/5yT1csUBcVNMCZ
 vqAmLMEAj3+0AYqnNC/SLv4r4bVjss9bCbjp5P+kmqodPSQWQlBb73BahiHG9+wEdED1drjhf+0
 vkgH+sC5BXJ5QQovo/tMF3gKVHwDd6dkT8KPSTupgqX+toXjH9rK8clcJug4EyiSeeZvVWqYhhC
 pbT9DowBVsq9IXXFbhqae8nm8tWHL7yF3l+L9DP49rP35zKjfTUsHxdqZeqXBRpzOFwqnl59GvV
 XMZ2FnDnaFIaodzxCpAcTo8EyxcEuO2yZvNUe49uND7eP+KC7Bp/5aMRsgkNVBEqL0r8ybHeuxw
 aRVlkpicLoRvccQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Have locks_insert_global_blocked and locks_delete_global_blocked take a
struct file_lock_core pointer.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index fa9b2beed0d7..ef67a5a7bae8 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -635,19 +635,18 @@ posix_owner_key(struct file_lock_core *flc)
 	return (unsigned long) flc->flc_owner;
 }
 
-static void locks_insert_global_blocked(struct file_lock *waiter)
+static void locks_insert_global_blocked(struct file_lock_core *waiter)
 {
 	lockdep_assert_held(&blocked_lock_lock);
 
-	hash_add(blocked_hash, &waiter->c.flc_link,
-		 posix_owner_key(&waiter->c));
+	hash_add(blocked_hash, &waiter->flc_link, posix_owner_key(waiter));
 }
 
-static void locks_delete_global_blocked(struct file_lock *waiter)
+static void locks_delete_global_blocked(struct file_lock_core *waiter)
 {
 	lockdep_assert_held(&blocked_lock_lock);
 
-	hash_del(&waiter->c.flc_link);
+	hash_del(&waiter->flc_link);
 }
 
 /* Remove waiter from blocker's block list.
@@ -657,7 +656,7 @@ static void locks_delete_global_blocked(struct file_lock *waiter)
  */
 static void __locks_delete_block(struct file_lock *waiter)
 {
-	locks_delete_global_blocked(waiter);
+	locks_delete_global_blocked(&waiter->c);
 	list_del_init(&waiter->c.flc_blocked_member);
 }
 
@@ -768,7 +767,7 @@ static void __locks_insert_block(struct file_lock *blocker,
 	list_add_tail(&waiter->c.flc_blocked_member,
 		      &blocker->c.flc_blocked_requests);
 	if ((blocker->c.flc_flags & (FL_POSIX|FL_OFDLCK)) == FL_POSIX)
-		locks_insert_global_blocked(waiter);
+		locks_insert_global_blocked(&waiter->c);
 
 	/* The requests in waiter->fl_blocked are known to conflict with
 	 * waiter, but might not conflict with blocker, or the requests

-- 
2.43.0


