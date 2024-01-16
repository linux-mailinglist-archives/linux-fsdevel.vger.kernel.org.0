Return-Path: <linux-fsdevel+bounces-8097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D776882F71A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59692284808
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929AE7317F;
	Tue, 16 Jan 2024 19:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2pWv0r7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95186EB6D;
	Tue, 16 Jan 2024 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434415; cv=none; b=j5oz3xRz9Urwa+YTybpN4KwWTZJOCis62HqkCr3IZDw9KKkoddLjFX0gEzaNyeZMmo3hz/CupZvR5tuHFFgTmooAnkTrQq4RQ5CHYb5wFM5eyT0SDtvyfLp8ol1Px3hh8+9VylOdXPNZSWw4d3CRtT1sw8JFa1ggT6fiAsGq0sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434415; c=relaxed/simple;
	bh=Zuc5pqQZA4yFDsa5+cs+KGgtjnisDfvU7E2gkuENnu0=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=j+Q2TyoXzdZsPg5DZdpAkEN71hsTDXQevqYdZOja873PoKglnxixPGsbBrNdFz7wIorNa85zzH4/LpgzTh1GIIDgMT6olTclH0W73ln9Qkpv2e7ZEoOyNbjQYR7BCaYWJsca42p+LkLlDdZM5pnPdkvTH6ML3rTr8AZqhpk+WiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2pWv0r7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A414C43142;
	Tue, 16 Jan 2024 19:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434414;
	bh=Zuc5pqQZA4yFDsa5+cs+KGgtjnisDfvU7E2gkuENnu0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j2pWv0r7LdBzbHVH8+EBNEcNxIw97N3r8CjxZHjqsvtNyXBIjYaKYX/GPXLu38znn
	 3ThFK21AMa7tomaFHwkRZsWQFlBrkEscqE3uuJEV9tsAXMcH7myVMGNNfgfgxF7GpI
	 MfPHetbc7OcD4B1wHTW1oxZ5hHnVzA1IUwlMFcsCIxx46Hih4dYOSxPFMFtYYRul5a
	 u3TeRGziT+ZMaddafMzrmVRCXpAG0M5NrVUhiPbnmZt95ImoI3SqVcrm6W+bwUdT3F
	 E0hONLbn7h4Mj4rmNxEZ190nq2Cu97DyaVswUZ9ePWFzTy7x/wMmMSQtep5jCt+r6j
	 s8XpnZqa+lE1Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:45:58 -0500
Subject: [PATCH 02/20] filelock: add coccinelle scripts to move fields to
 struct file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-2-c9d0f4370a5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3928; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Zuc5pqQZA4yFDsa5+cs+KGgtjnisDfvU7E2gkuENnu0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0g8OD2WzitEXeN7LiiOMhKmguOki1VVqGqH
 ZmSsKqxGxeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIAAKCRAADmhBGVaC
 FXSWD/9bZgoEqI8ZEftXS3u6TWrIG0t8R4wW2XlKcdNNKP6xtKYghCHQCiMP5Vww3T+3ZfIydtW
 kPZ3hfcd76g/khDE4o/055hlYgI9Rlq2py3uNweBQkxUdm+vWgXdoCsEoMANv2WXaGVMAla2JZh
 IV/aCqYSWUNDhQ5TY1UmU5d+cB81sRzK6PtIpLldoT7bHHq0M6EukLOGqI+Flt8ycuyhENil2t4
 QjzGeCDniVnMWeeNF/+Ts5e5wKpw0TS+x5r+D7bI/brkW31m/5sDgC6MW/i7lpG0E0bm1l0Uha3
 F2wx03gujaodVFAti5nCwC/gUw2vhowmFFixJLQyUk3FXl0ZWRFMjcdsUaec8zXyu0dpPeoIdEq
 llr8srK/yOFPUXnmhkUVeVPOJwdzf9czrAdn81unv1jHShSkKGIC1Qcok2lR1YuciiE4voYMpHo
 ofwia965HNSKIAGez3Raiz23QprdwsZcZo4mIU7PZDf2KocsUdsWLa+MpxfUTN54hZcA2AVoV90
 jm+G7UttCVDuu2Uah4vZFA8luC5nZtD+STB1eD4vBswzHwLJ2ycJbImHkCvVDaVSbNJMmDoZnhq
 N6cf6IvnzL5L6yqu8KkHNagJUpRWKMOi1B9JOvaCQ9FQUFi3M0RmZ3r/DILyWq97icxunvB8gOo
 LDnH+Nylx5MxtDQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add some coccinelle scripts to handle the move of several fields from
struct file_lock to struct file_lock_core.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 cocci/filelock.cocci  | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++
 cocci/filelock2.cocci |  6 ++++
 cocci/nlm.cocci       | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)

diff --git a/cocci/filelock.cocci b/cocci/filelock.cocci
new file mode 100644
index 000000000000..b84151ba091a
--- /dev/null
+++ b/cocci/filelock.cocci
@@ -0,0 +1,81 @@
+@@
+struct file_lock *fl;
+@@
+(
+- fl->fl_blocker
++ fl->fl_core.fl_blocker
+|
+- fl->fl_list
++ fl->fl_core.fl_list
+|
+- fl->fl_link
++ fl->fl_core.fl_link
+|
+- fl->fl_blocked_requests
++ fl->fl_core.fl_blocked_requests
+|
+- fl->fl_blocked_member
++ fl->fl_core.fl_blocked_member
+|
+- fl->fl_owner
++ fl->fl_core.fl_owner
+|
+- fl->fl_flags
++ fl->fl_core.fl_flags
+|
+- fl->fl_type
++ fl->fl_core.fl_type
+|
+- fl->fl_pid
++ fl->fl_core.fl_pid
+|
+- fl->fl_link_cpu
++ fl->fl_core.fl_link_cpu
+|
+- fl->fl_wait
++ fl->fl_core.fl_wait
+|
+- fl->fl_file
++ fl->fl_core.fl_file
+)
+
+@@
+struct file_lock fl;
+@@
+(
+- fl.fl_blocker
++ fl.fl_core.fl_blocker
+|
+- fl.fl_list
++ fl.fl_core.fl_list
+|
+- fl.fl_link
++ fl.fl_core.fl_link
+|
+- fl.fl_blocked_requests
++ fl.fl_core.fl_blocked_requests
+|
+- fl.fl_blocked_member
++ fl.fl_core.fl_blocked_member
+|
+- fl.fl_owner
++ fl.fl_core.fl_owner
+|
+- fl.fl_flags
++ fl.fl_core.fl_flags
+|
+- fl.fl_type
++ fl.fl_core.fl_type
+|
+- fl.fl_pid
++ fl.fl_core.fl_pid
+|
+- fl.fl_link_cpu
++ fl.fl_core.fl_link_cpu
+|
+- fl.fl_wait
++ fl.fl_core.fl_wait
+|
+- fl.fl_file
++ fl.fl_core.fl_file
+)
diff --git a/cocci/filelock2.cocci b/cocci/filelock2.cocci
new file mode 100644
index 000000000000..0154a14e81ca
--- /dev/null
+++ b/cocci/filelock2.cocci
@@ -0,0 +1,6 @@
+@@
+struct file_lock *fl;
+struct list_head *li;
+@@
+- list_for_each_entry(fl, li, fl_list)
++ list_for_each_entry(fl, li, fl_core.fl_list)
diff --git a/cocci/nlm.cocci b/cocci/nlm.cocci
new file mode 100644
index 000000000000..8ec5d02871e1
--- /dev/null
+++ b/cocci/nlm.cocci
@@ -0,0 +1,81 @@
+@@
+struct nlm_lock *nlck;
+@@
+(
+- nlck->fl.fl_blocker
++ nlck->fl.fl_core.fl_blocker
+|
+- nlck->fl.fl_list
++ nlck->fl.fl_core.fl_list
+|
+- nlck->fl.fl_link
++ nlck->fl.fl_core.fl_link
+|
+- nlck->fl.fl_blocked_requests
++ nlck->fl.fl_core.fl_blocked_requests
+|
+- nlck->fl.fl_blocked_member
++ nlck->fl.fl_core.fl_blocked_member
+|
+- nlck->fl.fl_owner
++ nlck->fl.fl_core.fl_owner
+|
+- nlck->fl.fl_flags
++ nlck->fl.fl_core.fl_flags
+|
+- nlck->fl.fl_type
++ nlck->fl.fl_core.fl_type
+|
+- nlck->fl.fl_pid
++ nlck->fl.fl_core.fl_pid
+|
+- nlck->fl.fl_link_cpu
++ nlck->fl.fl_core.fl_link_cpu
+|
+- nlck->fl.fl_wait
++ nlck->fl.fl_core.fl_wait
+|
+- nlck->fl.fl_file
++ nlck->fl.fl_core.fl_file
+)
+
+@@
+struct nlm_args *argp;
+@@
+(
+- argp->lock.fl.fl_blocker
++ argp->lock.fl.fl_core.fl_blocker
+|
+- argp->lock.fl.fl_list
++ argp->lock.fl.fl_core.fl_list
+|
+- argp->lock.fl.fl_link
++ argp->lock.fl.fl_core.fl_link
+|
+- argp->lock.fl.fl_blocked_requests
++ argp->lock.fl.fl_core.fl_blocked_requests
+|
+- argp->lock.fl.fl_blocked_member
++ argp->lock.fl.fl_core.fl_blocked_member
+|
+- argp->lock.fl.fl_owner
++ argp->lock.fl.fl_core.fl_owner
+|
+- argp->lock.fl.fl_flags
++ argp->lock.fl.fl_core.fl_flags
+|
+- argp->lock.fl.fl_type
++ argp->lock.fl.fl_core.fl_type
+|
+- argp->lock.fl.fl_pid
++ argp->lock.fl.fl_core.fl_pid
+|
+- argp->lock.fl.fl_link_cpu
++ argp->lock.fl.fl_core.fl_link_cpu
+|
+- argp->lock.fl.fl_wait
++ argp->lock.fl.fl_core.fl_wait
+|
+- argp->lock.fl.fl_file
++ argp->lock.fl.fl_core.fl_file
+)

-- 
2.43.0


