Return-Path: <linux-fsdevel+bounces-8104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD0E82F757
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 21:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6684F283E2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B83D376F7;
	Tue, 16 Jan 2024 19:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3Roeunt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCFF21A13;
	Tue, 16 Jan 2024 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434442; cv=none; b=iHV08Vm7ohmOFFqSbQrN7ws1ko6yTJWd2MZwG7D7zT2a9JW/wcWX/kKexwoyc7IDgPsrPK6yGG3qDe++0hFCRAj57CK9m9Yk0KDC734sDJJeQRpF6PcOAbvYCMg4XB1/fQI/2cBXJ2yz780gjiJ93ZEDamUcMyIv7VEft/HxKsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434442; c=relaxed/simple;
	bh=lyhSP5HzeA0ph/whZtydwjXJ8veikzHXxSTgaLspo7s=;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	b=l0oMNL8JpxLf5dhE+PScMGl8ezeFKq58ASAKdVkhAVp7SuREJBaMgWUGYW329PRU6POqZB4nZYQOTmviC7/bs/NpZuPJfJ5Dbj7yfZpj7TcmDb8UXo3B18r+pNpLTt4i1ij5ExsOx92t+7Q3aR2tiE4JPhPkClz2VQ/diPDe3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3Roeunt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C87C43390;
	Tue, 16 Jan 2024 19:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434442;
	bh=lyhSP5HzeA0ph/whZtydwjXJ8veikzHXxSTgaLspo7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z3RoeuntzeKcYRnwrOeyfzDfHrTbafuIVNtokBNKPYnLbxpquCCGkbRE54bmxCMdP
	 zUT1NjRDe5bk5bRh0mXfLpmtcUmhmeuh5eoqPdzqOP3TaoMx/sV6Lm/3ef8rPR0yWi
	 sGSzzZM8trRr5wUaZINMwa9jCvz3DmgjFL+AzLYFdrQ4+Z4RJx1hx3OMpxR9KqlN3w
	 65bmHvEcbqOzfqYXYye8w1xIT3mBPsoVriqq6ckMkDGz6nepq7wWOwf+K9SitNyPBt
	 l6v/HE/DXZAX7h24J+K7Pb+mUSrg7P2bhb2D9APZeBF/EVns9Bf4qENSIFQvhhvNXh
	 BSC12xLkllPvA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jan 2024 14:46:05 -0500
Subject: [PATCH 09/20] filelock: make locks_{insert,delete}_global_locks
 take file_lock_core arg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240116-flsplit-v1-9-c9d0f4370a5d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2249; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lyhSP5HzeA0ph/whZtydwjXJ8veikzHXxSTgaLspo7s=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlpt0hz1Ko0HqQBzrZ/7Hx3siPwo6L37SNYA3Wx
 p/570vr4B2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZabdIQAKCRAADmhBGVaC
 FRnDD/9vyfqWXL7+QxBzzsMwaHgDFWjgRUcBj6KcaxIxXKrTh52QtoRwHc0kjuBbcTuSRsWtULp
 Xdweq1h4P/ng7LluanZRzSHFUXoV9tIIDGq+vrXGsn2vm1U2ClzZ95nwP1j7+kuQvmzTdFve8X8
 FriQhEXfxg8xnvIPDg/hie+7n/lTJHdIVPrycU0FWd/YkM4kHA5O6IJoChB5GtjhDVggeN64jGC
 E/tz8qLYwaY3jOY8jR6kp00CCxbFmK5fYH9lX7S3K24pPw1NYIO/x2Vsr9hJhB46TZ2xgMoUora
 itaIOxnxJAwbg98WuOjg8vV96Jpd3g6b7fr+kS00ZjlEpmo/YkGNxSxpaHWNgIRFpe+X3jHz+Xi
 kV9wH2ZBi7hExCvRLJMi9AT9VO/iyO3YmB8JAMjSNOFDPCNv+WlEBScgBpKvhU4YFooDexJV6By
 Gecje1jtMb3112xFqhWWC2/2p1wQL8KhuZpBFE7eIRykNEttkwvpWCRlB4Co6DtYbt67EfaRg55
 m57z7XXJ3Xff80/L7NNrtSNdZVVjG7SsCBI6oHxSx+LNNFFvenFybi5sYxw5fAi3i3rlXIRpUjF
 w9w9M97hVus/hh7GImpOmOujIsjrELVG+O7+T8HIBKH6mwk+laWdHC5YmjMfJzASRIXSEmo/bOe
 N/vgaPByfpQn6MA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert these functions to take a file_lock_core instead of a file_lock.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 6432bcfb55a0..5fe54f48b9c1 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -603,20 +603,20 @@ static int posix_same_owner(struct file_lock_core *fl1, struct file_lock_core *f
 }
 
 /* Must be called with the flc_lock held! */
-static void locks_insert_global_locks(struct file_lock *fl)
+static void locks_insert_global_locks(struct file_lock_core *flc)
 {
 	struct file_lock_list_struct *fll = this_cpu_ptr(&file_lock_list);
 
 	percpu_rwsem_assert_held(&file_rwsem);
 
 	spin_lock(&fll->lock);
-	fl->fl_core.fl_link_cpu = smp_processor_id();
-	hlist_add_head(&fl->fl_core.fl_link, &fll->hlist);
+	flc->fl_link_cpu = smp_processor_id();
+	hlist_add_head(&flc->fl_link, &fll->hlist);
 	spin_unlock(&fll->lock);
 }
 
 /* Must be called with the flc_lock held! */
-static void locks_delete_global_locks(struct file_lock *fl)
+static void locks_delete_global_locks(struct file_lock_core *flc)
 {
 	struct file_lock_list_struct *fll;
 
@@ -627,12 +627,12 @@ static void locks_delete_global_locks(struct file_lock *fl)
 	 * is done while holding the flc_lock, and new insertions into the list
 	 * also require that it be held.
 	 */
-	if (hlist_unhashed(&fl->fl_core.fl_link))
+	if (hlist_unhashed(&flc->fl_link))
 		return;
 
-	fll = per_cpu_ptr(&file_lock_list, fl->fl_core.fl_link_cpu);
+	fll = per_cpu_ptr(&file_lock_list, flc->fl_link_cpu);
 	spin_lock(&fll->lock);
-	hlist_del_init(&fl->fl_core.fl_link);
+	hlist_del_init(&flc->fl_link);
 	spin_unlock(&fll->lock);
 }
 
@@ -821,13 +821,13 @@ static void
 locks_insert_lock_ctx(struct file_lock *fl, struct list_head *before)
 {
 	list_add_tail(&fl->fl_core.fl_list, before);
-	locks_insert_global_locks(fl);
+	locks_insert_global_locks(&fl->fl_core);
 }
 
 static void
 locks_unlink_lock_ctx(struct file_lock *fl)
 {
-	locks_delete_global_locks(fl);
+	locks_delete_global_locks(&fl->fl_core);
 	list_del_init(&fl->fl_core.fl_list);
 	locks_wake_up_blocks(fl);
 }

-- 
2.43.0


