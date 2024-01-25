Return-Path: <linux-fsdevel+bounces-8890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B1C83BF9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93579284FBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30362605CD;
	Thu, 25 Jan 2024 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JksKtL65"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F093605BE;
	Thu, 25 Jan 2024 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179464; cv=none; b=KFu6fOhhSz1Hb/L/fJzUSR6YG90VuNFuwTU2YSNeXnCcP7bTb6tPQt8eErj34NF313lqpKrhs7igsryKDVYOUtL5P87Xn63TSl0UKa26c28im0k7bZDnaYTbc35hdCP10AV3m5+YdEgCz90XYIgW/BbSjxUtqTFPT+nV6yRuNEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179464; c=relaxed/simple;
	bh=yEgsl63krJAEbBQLVgpupLgJGjIkvPZV4h5VmWEXOMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VLiI9/wcp4/DqLoqgzKjatFBhN147N8kTzJzPS8FpGFizRib9Yde7r+pcW1TrFRkbl+70saWrfvlS99At76qf26D7vW4vAKCFYcSffuVV++U3+ieAHpuYYp0nHPFBIIKgJ4XNwQOiQPoqL2GK9Y+tEc/iq1hBZ1rlQE+bWjHeMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JksKtL65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB14C43330;
	Thu, 25 Jan 2024 10:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179464;
	bh=yEgsl63krJAEbBQLVgpupLgJGjIkvPZV4h5VmWEXOMg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JksKtL65NlYSk17V1EHtEAmZvozOXuyvW+W5vd4CUZNwi3cJpUb/1hTV0h7RSRI18
	 Box/fXjNsECImaHdepjdNhEjW6srazwWMTO5Owfi/gVlHCqNGFsTBz/hfa0NGMGo5n
	 OEA6hHxkXPo8X1Algk7bFbcURsTaU4Yvs/fiTQSkjE+ZrjFSgBP+aA7xEEDv8D0tjI
	 45CIdEyreWQUubivEZ4A3WkfNs27YE7zMwNVdwWdjTHS+9F1AgAVyUN7FHypgSzgov
	 +jHN0/SgoC09Q6+oQUJXiDQ7Gx6CT29YTy2Vfvxgu1O3MuxOH/lJw9lJMeD1if37w0
	 XWCW4kosQONqg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:42:59 -0500
Subject: [PATCH v2 18/41] filelock: convert
 locks_{insert,delete}_global_blocked
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-18-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1970; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yEgsl63krJAEbBQLVgpupLgJGjIkvPZV4h5VmWEXOMg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs8OyzCvzcQ1F61nn18VGX0tcoV+/UQeV2Lp
 mPMUjAW9s6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7PAAKCRAADmhBGVaC
 FZq5D/9rEPSWrwWnu+eU909ZOHVStVEVRh9iR4HO0skOFyaI1h1nFU+jx2X99RUlsHHIxpWmExL
 6adx3SaCbqV1/+qIZOsmAa3Y7K/jXep0BBkcVcVOi5TBbC2H0gwI9jTkGzbLMCv/LYL+YmfAq15
 YxwwpiQaCVkxju76SVnelHcWQFKqkvCvhGZR1WuH6kCKZbRxP2xZSN5l/4uEVMkwJgB1xwtZLBz
 HT+mE7qb7sYZXo2T1b7BvrLnndED1wD/e3MeXfB4JofImWnfMDkCoRAMInHE0iEzIXluR5eWCzn
 XUL8SiXcE4q8T3Wyeg36HmbKRW297+ggolI7+AwxjvCjF+1DdHkfR1rsCMhikZFKKgglslBDl4V
 porhXSfsqGeyPPatCPO5cJJcV4ZSpcg8zfj24nlBYsXtKPq2GsAgYUGRZ0Mp9NV4RMe6MhN6Inp
 ZQvJnmsQ332sUh2GUqaDI5ElrwRiBfnmyBzPPBpfCLJrfnkOD53wOb8YtpuYqZjoGZ3H1F/1yL7
 ApQ7yKGBSBGvIPoj6DKb5VyPPLRXgMW0t6IORPM5Ka+6F1riCiU84jq2Pl26ApTOCVViPfHFbqP
 z12jOWMnCqiFDCLM8bF6xQSlH9HBMqIcYNYCI4LUe3ii0o+gIgCHMJxUE5GaLGOOFzc+J/I81SP
 7iDDfqHh5q3c2Kw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Have locks_insert_global_blocked and locks_delete_global_blocked take a
struct file_lock_core pointer.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index ad4bb9cd4c9d..d6d47612527c 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -635,19 +635,18 @@ posix_owner_key(struct file_lock_core *flc)
 	return (unsigned long) flc->flc_owner;
 }
 
-static void locks_insert_global_blocked(struct file_lock *waiter)
+static void locks_insert_global_blocked(struct file_lock_core *waiter)
 {
 	lockdep_assert_held(&blocked_lock_lock);
 
-	hash_add(blocked_hash, &waiter->fl_core.flc_link,
-		 posix_owner_key(&waiter->fl_core));
+	hash_add(blocked_hash, &waiter->flc_link, posix_owner_key(waiter));
 }
 
-static void locks_delete_global_blocked(struct file_lock *waiter)
+static void locks_delete_global_blocked(struct file_lock_core *waiter)
 {
 	lockdep_assert_held(&blocked_lock_lock);
 
-	hash_del(&waiter->fl_core.flc_link);
+	hash_del(&waiter->flc_link);
 }
 
 /* Remove waiter from blocker's block list.
@@ -657,7 +656,7 @@ static void locks_delete_global_blocked(struct file_lock *waiter)
  */
 static void __locks_delete_block(struct file_lock *waiter)
 {
-	locks_delete_global_blocked(waiter);
+	locks_delete_global_blocked(&waiter->fl_core);
 	list_del_init(&waiter->fl_core.flc_blocked_member);
 }
 
@@ -768,7 +767,7 @@ static void __locks_insert_block(struct file_lock *blocker,
 	list_add_tail(&waiter->fl_core.flc_blocked_member,
 		      &blocker->fl_core.flc_blocked_requests);
 	if ((blocker->fl_core.flc_flags & (FL_POSIX|FL_OFDLCK)) == FL_POSIX)
-		locks_insert_global_blocked(waiter);
+		locks_insert_global_blocked(&waiter->fl_core);
 
 	/* The requests in waiter->fl_blocked are known to conflict with
 	 * waiter, but might not conflict with blocker, or the requests

-- 
2.43.0


