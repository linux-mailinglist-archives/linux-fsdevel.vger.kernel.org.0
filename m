Return-Path: <linux-fsdevel+bounces-9752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF51844C24
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4A4284529
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 23:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF26513D51F;
	Wed, 31 Jan 2024 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVNAmxi1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E031A13D50D;
	Wed, 31 Jan 2024 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742224; cv=none; b=qw9DXslHEmpl6NRU/pY8RvXS6GDGe04UJyfMG4KqnBwJ5gP7YYYGsHNCGrPoAxN7b9ADaw6OY3cngo13QrXBS0Sn6BtuV5WUwBBgDtN6dcCBzC0czGYHpBL/Ig1dIoDHCOi6W5t6q0HWdhgH+WA/+YNzeD4JSidmwS6RdjctpOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742224; c=relaxed/simple;
	bh=HcLhLyMTb0uV3nLml2p2oQReU+iiXkPoxKB/zr8tLAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iWJyLR7OYEN/tNITLBdnVKlnL9ngZqz/jW8CbUDkl4ex/LvVErKWbUfO/AwH/F3hGqOCvG5t/M4tI3o0ZQJExUnS5aDflRPsGqPQj5MMNQB3gjg4iKUd/R+JCExucEBqoGvnfN30JF7OoAEVGp+IMwjgMW9FD5hmQBKKMayhQPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVNAmxi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09278C43399;
	Wed, 31 Jan 2024 23:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742223;
	bh=HcLhLyMTb0uV3nLml2p2oQReU+iiXkPoxKB/zr8tLAM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QVNAmxi1i6F1oqR1nDjSI6sAlWfgttyGldYI9QmOV7ZUVOhcfAX+E0NoZwgYO38xX
	 KtfUvn/IGIxoW3hxvZFrZD2G2FTAOl2qDrfTwVcD8pqDAsjEGp43mczTuNdl+xdo8o
	 XEDYDKxWrYjrBpWlJbzU7moItH3FgFgD2Cc6SB+TUETqDwMHUZdhyM/1/Lhdd+mEgQ
	 wdPqIsONFE4UZez3YWbh0sMx349mgaqz89KhgZEWt/Gfwl+yDUzZXLksQH3P+Bihwh
	 DuaSL5Bq0NOIgK+x+tFXgsFKlVORXCJtkpTc3KXt7SdiYahJqjFzfvSOhH+sNfabyK
	 2bGNpH/Ctb+EA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 31 Jan 2024 18:02:03 -0500
Subject: [PATCH v3 22/47] filelock: make locks_{insert,delete}_global_locks
 take file_lock_core arg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-flsplit-v3-22-c6129007ee8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=HcLhLyMTb0uV3nLml2p2oQReU+iiXkPoxKB/zr8tLAM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlutFxeTa4E2kYEHNuBcC2Pw7Gr50YkKLnTstR6
 aNLAut81X2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbrRcQAKCRAADmhBGVaC
 FTu3EACcK9RVjwnt0r8GlR/FGOGylMhxITZC9JaUrZbWc7gcMdUdvTFGYIGbIjpHAcUu+5I8vaB
 p9xg9e5SHmAyK7JhZxl1nQrdxMqsOiVY6Yez1QAVjYxAffljEkfqKfZwIl5FVZ9W4shbrqMsj4n
 vIgjFuruTFjZEYU7y5TbFIpEpWjVpCSVIsZseq+f6aPWTOhviRFbcEf+hfn+ibcreHeDROx+h90
 ILa7AM6Gujz3xzVL6mzxcdov0f/diDoqC1K5ZIbycBBxFp5rVdcZrTHJpaVaWrRkdm6oAeZK+1k
 e+NJDUs4qR1z3UQoAEzrH0H3bUvgvBj/+gjASNo0VjkoaFAv6Ep4BUSI1HDhRx/AXdUjCRIyIXf
 LGlZWGZg6lPagPrA55jXzIUfgXAbepYHCTKi1B+GcopocpfbjMM1HwPbdf0bQvp9hP7RI3BC9CI
 3QNneTqSJLdD8yeNHRvvKTJ8LacFEEBOQql13VHFh6eiSVxU1ewUYFR2GBr9kcj0cnrsb2MKp3q
 CT1jjqZPaUk6xgBsOephGU5f6qxxUcJUBgJLQEg0mKeYr1FCzPvwkq7Q+KYQBEgxatYzUru4qE1
 4K60QBu/dKWJjXKk7OLfHyYcqokj3Z7qILeHSj0QNGBDs9mq5hw6TpkriHHfiyzEIkwypAPEUFP
 SUlsBbSEnLn0Uhw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert these functions to take a file_lock_core instead of a file_lock.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 1cfd02562e9f..fa9b2beed0d7 100644
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
-	fl->c.flc_link_cpu = smp_processor_id();
-	hlist_add_head(&fl->c.flc_link, &fll->hlist);
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
-	if (hlist_unhashed(&fl->c.flc_link))
+	if (hlist_unhashed(&flc->flc_link))
 		return;
 
-	fll = per_cpu_ptr(&file_lock_list, fl->c.flc_link_cpu);
+	fll = per_cpu_ptr(&file_lock_list, flc->flc_link_cpu);
 	spin_lock(&fll->lock);
-	hlist_del_init(&fl->c.flc_link);
+	hlist_del_init(&flc->flc_link);
 	spin_unlock(&fll->lock);
 }
 
@@ -814,13 +814,13 @@ static void
 locks_insert_lock_ctx(struct file_lock *fl, struct list_head *before)
 {
 	list_add_tail(&fl->c.flc_list, before);
-	locks_insert_global_locks(fl);
+	locks_insert_global_locks(&fl->c);
 }
 
 static void
 locks_unlink_lock_ctx(struct file_lock *fl)
 {
-	locks_delete_global_locks(fl);
+	locks_delete_global_locks(&fl->c);
 	list_del_init(&fl->c.flc_list);
 	locks_wake_up_blocks(fl);
 }

-- 
2.43.0


