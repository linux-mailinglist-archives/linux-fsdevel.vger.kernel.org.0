Return-Path: <linux-fsdevel+bounces-8889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6605983BF9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9875F1C23052
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1220C604D4;
	Thu, 25 Jan 2024 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiiyjDvd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E64E604BC;
	Thu, 25 Jan 2024 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179460; cv=none; b=FWrqAj6+z/RRAxSmMp7zeLYvJTkTLKtjFFG0YHRsSihyMtzAID0iBxMV0iyEK3F+6SqFK2ge09gyceuX37IaXZNr7hEzPuay42aJ5W+7N9C7G3NXyXIwDMn4qA2CfjUW1UkzS8gsFH7Kxp48eeBXrDGrc5Y2RJsyH2HuNbff/nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179460; c=relaxed/simple;
	bh=30KJx0Hyv2s41cGRszMYoB7mdxNuB2UrCQt/ZqfUUKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WqHdzpfksHTXzrIKxNOG5Lr5xcNWnhRBmuoznlLzsX9DJrbqVMdzFE/GsG0AdsEntnjqaXL/ALHCS/1xkvue7SiW9Vysbh3/MSkkx1H9Twxe50n4inYX4bNcx6gf96hoVd/lzTh6ei8d+tNCvb3tKUrbe9Ur5h5bwv5d5rJUuvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiiyjDvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98658C43141;
	Thu, 25 Jan 2024 10:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179460;
	bh=30KJx0Hyv2s41cGRszMYoB7mdxNuB2UrCQt/ZqfUUKs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tiiyjDvdbfKZx0exBt2/0RN//cStQCjFtnSPakaxjiqbG09QwFo18dipIHYu7nzxn
	 RVwkrr5dktoACJi88yZZZ9/HdBEr6P3GkbdKOiUk+n5ZstTXnePmN6GpkM2K7hDVPx
	 LH9pboX0utRBk1s/irQx+LbBWJpf5vAR4ARbUrw3AqHjbpvTEhu7xS8ossIVwbv/fu
	 ogcFceg+N1ZNJXgWNskpnXHSSTB2X5Nw/htf4Yk9gn/ErCwg75B1ruqJyoi/RUopPR
	 FbEjrWjNePswBEiH+qAOTDzd6cqovM4jzQVfGagjbGN7mPPG7xAvI7mpLZGaJPhazb
	 hLdACVJxsLmOg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:42:58 -0500
Subject: [PATCH v2 17/41] filelock: make locks_{insert,delete}_global_locks
 take file_lock_core arg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-17-7485322b62c7@kernel.org>
References: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
In-Reply-To: <20240125-flsplit-v2-0-7485322b62c7@kernel.org>
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
 Shyam Prasad N <sprasad@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: linux-kernel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, 
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
 linux-cifs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2261; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=30KJx0Hyv2s41cGRszMYoB7mdxNuB2UrCQt/ZqfUUKs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs8SdqxMRoDIm0JB0F9m6FWBPyTlwlnxaXNh
 stmXIt6zp+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PAAKCRAADmhBGVaC
 FaThD/40Eel9ws4bpv6pYZmYpdrd8jeJp98F+T2aA7ikIwzWJsKndDyk2Egd1khC7kp7criXZWY
 krm85yb2xHZQOmQf/65I+9iuO8dkgZX0fP/ApSqlVYuaPqEVNQfpOCv7EK7vt4XgUDBTnANna/s
 VAeGNE31T/jCfCNaJuyl99kSQY0TEYzBbZ1wFgODmNgtAUwkcQGh0Q+h587Ob/gLDKpGzC1Beiv
 hbHo1r6r3rLV3Ca/QTWQQps5FVrE6OEDI0YEp6P6paTU0rqH+LGTrECH65hSaY/SmYlR/2p5MwK
 mMWHnpaqxrBhhBANC8odgeQKG4T4FFtGoe1O0Sp6VB230qO8WJ1OcQAfzPb9ohfMwZyxtrEJzvO
 Dq8VeRwzGTjqfYe7ozmHCBLm8edr736h6MKUTPpTl3F2noKOg62yKz7sJTDhkwYnY00TOvQTRYJ
 DuApjYo3w6BpPZ9AEkFXTaV0GN6OCI18G0iiKUevHQRm4Ahrs8GFqBtmNj0ukxxpr3uwA0cISpY
 A0tNo4Bt2+aWAdVg2A5OlHrWd6PGiVmJbR3FtRi/kxP2fsHbzX76yBtPbYMrdGPOX00Ekh/UpNd
 Sm7ASI6azyN8L4WZus725Ekd+SPYNpoqUr4GqP6F7NNzHcDRYic/6hgKvLNo5vOGQdFamQlbYMa
 bdHjgLS82BZCPGA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert these functions to take a file_lock_core instead of a file_lock.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index effe84f954f9..ad4bb9cd4c9d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -596,20 +596,20 @@ static int posix_same_owner(struct file_lock_core *fl1, struct file_lock_core *f
 }
 
 /* Must be called with the flc_lock held! */
-static void locks_insert_global_locks(struct file_lock *fl)
+static void locks_insert_global_locks(struct file_lock_core *flc)
 {
 	struct file_lock_list_struct *fll = this_cpu_ptr(&file_lock_list);
 
 	percpu_rwsem_assert_held(&file_rwsem);
 
 	spin_lock(&fll->lock);
-	fl->fl_core.flc_link_cpu = smp_processor_id();
-	hlist_add_head(&fl->fl_core.flc_link, &fll->hlist);
+	flc->flc_link_cpu = smp_processor_id();
+	hlist_add_head(&flc->flc_link, &fll->hlist);
 	spin_unlock(&fll->lock);
 }
 
 /* Must be called with the flc_lock held! */
-static void locks_delete_global_locks(struct file_lock *fl)
+static void locks_delete_global_locks(struct file_lock_core *flc)
 {
 	struct file_lock_list_struct *fll;
 
@@ -620,12 +620,12 @@ static void locks_delete_global_locks(struct file_lock *fl)
 	 * is done while holding the flc_lock, and new insertions into the list
 	 * also require that it be held.
 	 */
-	if (hlist_unhashed(&fl->fl_core.flc_link))
+	if (hlist_unhashed(&flc->flc_link))
 		return;
 
-	fll = per_cpu_ptr(&file_lock_list, fl->fl_core.flc_link_cpu);
+	fll = per_cpu_ptr(&file_lock_list, flc->flc_link_cpu);
 	spin_lock(&fll->lock);
-	hlist_del_init(&fl->fl_core.flc_link);
+	hlist_del_init(&flc->flc_link);
 	spin_unlock(&fll->lock);
 }
 
@@ -814,13 +814,13 @@ static void
 locks_insert_lock_ctx(struct file_lock *fl, struct list_head *before)
 {
 	list_add_tail(&fl->fl_core.flc_list, before);
-	locks_insert_global_locks(fl);
+	locks_insert_global_locks(&fl->fl_core);
 }
 
 static void
 locks_unlink_lock_ctx(struct file_lock *fl)
 {
-	locks_delete_global_locks(fl);
+	locks_delete_global_locks(&fl->fl_core);
 	list_del_init(&fl->fl_core.flc_list);
 	locks_wake_up_blocks(fl);
 }

-- 
2.43.0


