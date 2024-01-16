Return-Path: <linux-fsdevel+bounces-8102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C909782F74D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03861C249AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC8C36137;
	Tue, 16 Jan 2024 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHlGAQGr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A920F36119;
	Tue, 16 Jan 2024 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434434; cv=none; b=CGJ0GDRbT9WL2UtiPRthq4Xii94OERl7kd1Qb0uBdviERF8brmgcUUbtAwc8fFRrVB9jUIKHXB2dsHCHgfEzKivN4Mb6BQkrmCqWyr04qmQYI0Tpig4W5TKV+gx3Rpga/sM8Qw72yVxH/+3oecgpdeMFAS/busM0mhPH1anQMSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434434; c=relaxed/simple;
	bh=L8KWqCV+F6kRLVRE9vKyR+AlpShZquRypPwqDG+IUPM=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=BjxrJXXvOfjprA94HjGEnBXFTTlEA4LzWxw+xEP7icwnYjv2u6LvEBTZrsr9iL9OCLINnwf/2ct0Rj+dvEx3BKdzkVsOqL42PFU2NoRlNyks5S7TZU/7I13EEtwCqr4yksBKZRF37EmiHN6UiDq/XENGU6PFhgxQ5bEXBU90chs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHlGAQGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD8CC433F1;
	Tue, 16 Jan 2024 19:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434434;
	bh=L8KWqCV+F6kRLVRE9vKyR+AlpShZquRypPwqDG+IUPM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tHlGAQGrdtJ1Sj0SUi5L5S89CQlL0SpIdzwZdxA6LL1v4X4qpvY8yfkHTLCDGvZ6B
	 iQw0f1rVJuJMQVeb+rmA8w7NCI1hRrlzlMDU9AitgqnFebgxldWy+dVvzzDAq/Tm+6
	 RtIpLlTNl+355Z7Uiyu3jOEv+5gGs0G3n8FOUB92TKxkpDK10G20h2BJwrgO7o5sDn
	 NhszLst+TbXIn1affBO0arej+72uIINXLf6hlFHxL8KR3HkClwMJQJ39eDjH+LU3Qv
	 QCpHYUurT888QMUqqK3lyW7KNFaTyWLktOijU87T08uSxo+0pMpuTi0LCNaoksrLxp
	 H31zCSvGwjWEQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:46:03 -0500
Subject: [PATCH 07/20] filelock: make posix_same_owner take file_lock_core
 pointers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-7-c9d0f4370a5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2980; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=L8KWqCV+F6kRLVRE9vKyR+AlpShZquRypPwqDG+IUPM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0hKHK+H6Wkmd5yy5pmBcEetzKB2FUGxYvp+
 5WYVbVWJ0+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIQAKCRAADmhBGVaC
 FfuDEAC1pXoqFjMnpCKnUAWdI7HObvstTJBvHYUMBv0MiYVuPTUFjyy5BpzewkqsX7tDPL/HeZv
 4lapZ+H2O5NFTp8NU2u5rNdf0G5TVcdxVMlTVbpi1uk52G26ChpIXgopPFS36u3ySx55EK/OotB
 ZB7gOiGnE7ymo5ma/cv9NuY92Z8QUb2UqX9Wl8GRewVeZzDcUr9N9c6Btdaqr0AwVYx1yx+D7rT
 WTG2NZ1jWAt+bKNgJmCOuGX++dbMf0MygG+DKr5kcYV+AhkKR6FF34WF5S84v2mbrPSAT3PBRJx
 qpauTEIq0+ae7frYtnoZFGeeZuFjSUyHsEq9BYCJUtTDWiVtqYHBKgzbDScB34MnlmBKrmAV/WR
 i/A2C63TP0hdSEaZAukKlsdIsSQuzhyLIjeikc4xxbVubS0RJkBJdQNm9qSNXGdjNTV+WJtbcxc
 KVDkGSYC+X01uU18pCKbj1onAe0DjPzJg/Tf4yCuRjcCaG913ZF9mH5VMNnqcVzKc0hJqtFq/Pb
 qlf2oi4fUYyGbKL4xjVAxz0Ysrj98g/Bpi+1P2jcFUfKXyzdmzTMqonkCP7ZlY1lKKp/oBCPp9U
 5ZJA97fX57PuqWUugyvEE04bash6Pjuzo52Ci4GAcOf4wZh2X4j8rlKdmVkpwhkTE2MqiS5yPsh
 eyktM/o+0wCzteQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Change posix_same_owner to take struct file_lock_core pointers, and
convert the callers to pass those in.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index e09920cc9da2..0c47497eb1a4 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -597,9 +597,9 @@ static inline int locks_overlap(struct file_lock *fl1, struct file_lock *fl2)
 /*
  * Check whether two locks have the same owner.
  */
-static int posix_same_owner(struct file_lock *fl1, struct file_lock *fl2)
+static int posix_same_owner(struct file_lock_core *fl1, struct file_lock_core *fl2)
 {
-	return fl1->fl_core.fl_owner == fl2->fl_core.fl_owner;
+	return fl1->fl_owner == fl2->fl_owner;
 }
 
 /* Must be called with the flc_lock held! */
@@ -864,7 +864,7 @@ static bool posix_locks_conflict(struct file_lock *caller_fl,
 	/* POSIX locks owned by the same process do not conflict with
 	 * each other.
 	 */
-	if (posix_same_owner(caller_fl, sys_fl))
+	if (posix_same_owner(&caller_fl->fl_core, &sys_fl->fl_core))
 		return false;
 
 	/* Check whether they overlap */
@@ -882,7 +882,7 @@ static bool posix_test_locks_conflict(struct file_lock *caller_fl,
 {
 	/* F_UNLCK checks any locks on the same fd. */
 	if (caller_fl->fl_core.fl_type == F_UNLCK) {
-		if (!posix_same_owner(caller_fl, sys_fl))
+		if (!posix_same_owner(&caller_fl->fl_core, &sys_fl->fl_core))
 			return false;
 		return locks_overlap(caller_fl, sys_fl);
 	}
@@ -985,7 +985,7 @@ static struct file_lock *what_owner_is_waiting_for(struct file_lock *block_fl)
 	struct file_lock *fl;
 
 	hash_for_each_possible(blocked_hash, fl, fl_core.fl_link, posix_owner_key(block_fl)) {
-		if (posix_same_owner(fl, block_fl)) {
+		if (posix_same_owner(&fl->fl_core, &block_fl->fl_core)) {
 			while (fl->fl_core.fl_blocker)
 				fl = fl->fl_core.fl_blocker;
 			return fl;
@@ -1012,7 +1012,7 @@ static int posix_locks_deadlock(struct file_lock *caller_fl,
 	while ((block_fl = what_owner_is_waiting_for(block_fl))) {
 		if (i++ > MAX_DEADLK_ITERATIONS)
 			return 0;
-		if (posix_same_owner(caller_fl, block_fl))
+		if (posix_same_owner(&caller_fl->fl_core, &block_fl->fl_core))
 			return 1;
 	}
 	return 0;
@@ -1185,13 +1185,13 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 
 	/* Find the first old lock with the same owner as the new lock */
 	list_for_each_entry(fl, &ctx->flc_posix, fl_core.fl_list) {
-		if (posix_same_owner(request, fl))
+		if (posix_same_owner(&request->fl_core, &fl->fl_core))
 			break;
 	}
 
 	/* Process locks with this owner. */
 	list_for_each_entry_safe_from(fl, tmp, &ctx->flc_posix, fl_core.fl_list) {
-		if (!posix_same_owner(request, fl))
+		if (!posix_same_owner(&request->fl_core, &fl->fl_core))
 			break;
 
 		/* Detect adjacent or overlapping regions (if same lock type) */

-- 
2.43.0


