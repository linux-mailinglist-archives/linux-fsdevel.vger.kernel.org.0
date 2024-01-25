Return-Path: <linux-fsdevel+bounces-8883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A250483BF78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 11:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76E61C23FBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 10:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019BB58114;
	Thu, 25 Jan 2024 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaRSxvPe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8875914C;
	Thu, 25 Jan 2024 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179437; cv=none; b=GQ2whXM3xG4v0PVohPGnsrLIF33xs/pCfciorq8m5SbBWBseABzCQ4UtEMtzk+8Qa+iNELXmDY4q0vCcsOzOdYmSIzddXm0f0ivaQePUabXhRhcj6ckGgxg0+P/h9BFjXEXEstQZLpNPGCKwwbRWvgYfOI4wd4DM1ujn+NEBh98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179437; c=relaxed/simple;
	bh=xAzKg8wMEncnI9mj1UI0sicUhafz7IJtoAlW8dv/xHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cn1/jBTHRunnVkzCz/zhrFGpDCjFOqzdLgxifBJWeh5PDq6zkiXI5Mg+8Bd/wvVVXz3iABBG2zb9P41p2f4Igz27FhskmloN/6qpashJTHT8khBwjHzgbbarH4fAXryjMYcnGsDH0Yg61tp4o7ifo4e0vKZHqVlGQ1jYWjn+CsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaRSxvPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D9AC43330;
	Thu, 25 Jan 2024 10:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179437;
	bh=xAzKg8wMEncnI9mj1UI0sicUhafz7IJtoAlW8dv/xHI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YaRSxvPetFu2rYSeRYRYzlVgyUpsH11siosRosn+7obSwAtpn3ZfuubXEmPCBu4Jb
	 DwVAgxHI2DOLLYFELVNYP7WJzZPnCqdEBoEDIi1wjVoEkDXcccxn7jD8dK+Nu8FEb/
	 4lNfCwEaBgEm82h0pZCdIgw7XuFm/YZHBdRh4f1urEZwvboHdnA9yMc/Vzi94rnQIz
	 OFcT0Jr1VKnTqXwqUKxD6FnmdBUN2PYx3AB2Dgj7he85joQ2TSV4KvNvnL/WPmhJUp
	 1LGE6lcmbkrLkcfu6QC/lDBeSx+AHf+rA27oXN7hQlMx9Ae7e+g8Z/i+GpwQtoFxvH
	 p5/943N2cUOrQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 25 Jan 2024 05:42:52 -0500
Subject: [PATCH v2 11/41] filelock: add coccinelle scripts to move fields
 to struct file_lock_core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-flsplit-v2-11-7485322b62c7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3898; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xAzKg8wMEncnI9mj1UI0sicUhafz7IJtoAlW8dv/xHI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlsjs7+blHS3ofsEO8V8j6Vd8CAOi2fCz9K2JFF
 je2pWMQYFuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZbI7OwAKCRAADmhBGVaC
 FS2mEADEf2Lhz6L0IfktlPToXicgql/FijkRc8+kJn4YA3lT5fFCZecU49h//en/EKSAmJF3mkw
 spCK6gXIvbMMzoA358oIMA1jlwgKTTW40Ad2Ks2RyYfyn+ihEQ5804ufESzJ+Uta2HeStESCDfS
 XAk+n/9Fcx6hm7HwaBjNWkIW8Oqsy28v8AU917hEl9kFdQDfBZ2KJXBR2VAowvnrXPLUOi4Go5r
 FyGJ1R5XeDKy4j4LircdY8Buz4MJMMKO6lZyphsnOmmoF53GQjbLAhvBJkHZMrvPKGlOrwe27Kg
 iL/jF7BXCnHi70hWTG/M5hzLVMnhVWhhVGtnl4ZGtu+Z7IkSFw7LICwdjimt9HNyMV415Os+bTG
 xyB0f0QNMsttM3zkHy31XMA2O/RUmOPVSNU0eE3Si/LdF/ECWnfbAm13sd/4RyNNcnnfypSp+jn
 UXCUaQddUn8qPb6sLeHgTpIVW3+EZnXdxE/6FSaha45i2/K8dURXFxXwQ4D5JvBUslT8ilI1X0b
 nUZ2i1T4laGdCAWkjEPnNv7DFGpRq1MXVLja+tMqoMgDr7Eo0h1b2L8B8Tgx/CnIk/9wQ8wt9CF
 BS9PocgED017gcDCSJkJseF8JRz5osAX8KBRLoXObhow11SwA9Iv/loe3g0mXkGi0G/s1Erc9H3
 r4W3ofJmIcpSJdg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This patch creates two ".cocci" semantic patches in a top level cocci/
directory. These patches were used to help generate several of the
following patches. We can drop this patch or move the files to a more
appropriate location before merging.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 cocci/filelock.cocci | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 cocci/nlm.cocci      | 81 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+)

diff --git a/cocci/filelock.cocci b/cocci/filelock.cocci
new file mode 100644
index 000000000000..93fb4ed8341a
--- /dev/null
+++ b/cocci/filelock.cocci
@@ -0,0 +1,88 @@
+@@
+struct file_lock *fl;
+@@
+(
+- fl->fl_blocker
++ fl->fl_core.flc_blocker
+|
+- fl->fl_list
++ fl->fl_core.flc_list
+|
+- fl->fl_link
++ fl->fl_core.flc_link
+|
+- fl->fl_blocked_requests
++ fl->fl_core.flc_blocked_requests
+|
+- fl->fl_blocked_member
++ fl->fl_core.flc_blocked_member
+|
+- fl->fl_owner
++ fl->fl_core.flc_owner
+|
+- fl->fl_flags
++ fl->fl_core.flc_flags
+|
+- fl->fl_type
++ fl->fl_core.flc_type
+|
+- fl->fl_pid
++ fl->fl_core.flc_pid
+|
+- fl->fl_link_cpu
++ fl->fl_core.flc_link_cpu
+|
+- fl->fl_wait
++ fl->fl_core.flc_wait
+|
+- fl->fl_file
++ fl->fl_core.flc_file
+)
+
+@@
+struct file_lock fl;
+@@
+(
+- fl.fl_blocker
++ fl.fl_core.flc_blocker
+|
+- fl.fl_list
++ fl.fl_core.flc_list
+|
+- fl.fl_link
++ fl.fl_core.flc_link
+|
+- fl.fl_blocked_requests
++ fl.fl_core.flc_blocked_requests
+|
+- fl.fl_blocked_member
++ fl.fl_core.flc_blocked_member
+|
+- fl.fl_owner
++ fl.fl_core.flc_owner
+|
+- fl.fl_flags
++ fl.fl_core.flc_flags
+|
+- fl.fl_type
++ fl.fl_core.flc_type
+|
+- fl.fl_pid
++ fl.fl_core.flc_pid
+|
+- fl.fl_link_cpu
++ fl.fl_core.flc_link_cpu
+|
+- fl.fl_wait
++ fl.fl_core.flc_wait
+|
+- fl.fl_file
++ fl.fl_core.flc_file
+)
+
+@@
+struct file_lock *fl;
+struct list_head *li;
+@@
+- list_for_each_entry(fl, li, fl_list)
++ list_for_each_entry(fl, li, fl_core.flc_list)
diff --git a/cocci/nlm.cocci b/cocci/nlm.cocci
new file mode 100644
index 000000000000..bf22f0a75812
--- /dev/null
+++ b/cocci/nlm.cocci
@@ -0,0 +1,81 @@
+@@
+struct nlm_lock *nlck;
+@@
+(
+- nlck->fl.fl_blocker
++ nlck->fl.fl_core.flc_blocker
+|
+- nlck->fl.fl_list
++ nlck->fl.fl_core.flc_list
+|
+- nlck->fl.fl_link
++ nlck->fl.fl_core.flc_link
+|
+- nlck->fl.fl_blocked_requests
++ nlck->fl.fl_core.flc_blocked_requests
+|
+- nlck->fl.fl_blocked_member
++ nlck->fl.fl_core.flc_blocked_member
+|
+- nlck->fl.fl_owner
++ nlck->fl.fl_core.flc_owner
+|
+- nlck->fl.fl_flags
++ nlck->fl.fl_core.flc_flags
+|
+- nlck->fl.fl_type
++ nlck->fl.fl_core.flc_type
+|
+- nlck->fl.fl_pid
++ nlck->fl.fl_core.flc_pid
+|
+- nlck->fl.fl_link_cpu
++ nlck->fl.fl_core.flc_link_cpu
+|
+- nlck->fl.fl_wait
++ nlck->fl.fl_core.flc_wait
+|
+- nlck->fl.fl_file
++ nlck->fl.fl_core.flc_file
+)
+
+@@
+struct nlm_args *argp;
+@@
+(
+- argp->lock.fl.fl_blocker
++ argp->lock.fl.fl_core.flc_blocker
+|
+- argp->lock.fl.fl_list
++ argp->lock.fl.fl_core.flc_list
+|
+- argp->lock.fl.fl_link
++ argp->lock.fl.fl_core.flc_link
+|
+- argp->lock.fl.fl_blocked_requests
++ argp->lock.fl.fl_core.flc_blocked_requests
+|
+- argp->lock.fl.fl_blocked_member
++ argp->lock.fl.fl_core.flc_blocked_member
+|
+- argp->lock.fl.fl_owner
++ argp->lock.fl.fl_core.flc_owner
+|
+- argp->lock.fl.fl_flags
++ argp->lock.fl.fl_core.flc_flags
+|
+- argp->lock.fl.fl_type
++ argp->lock.fl.fl_core.flc_type
+|
+- argp->lock.fl.fl_pid
++ argp->lock.fl.fl_core.flc_pid
+|
+- argp->lock.fl.fl_link_cpu
++ argp->lock.fl.fl_core.flc_link_cpu
+|
+- argp->lock.fl.fl_wait
++ argp->lock.fl.fl_core.flc_wait
+|
+- argp->lock.fl.fl_file
++ argp->lock.fl.fl_core.flc_file
+)

-- 
2.43.0


