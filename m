Return-Path: <linux-fsdevel+bounces-62630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C097B9B3E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D3E1890EA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDE7322A3F;
	Wed, 24 Sep 2025 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maqs9KnC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83410322778;
	Wed, 24 Sep 2025 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737216; cv=none; b=eRHr6vHBfqMFt+9XWPHdssrXicsnzvyl/PvtX7Ok4HPOG7knd1uTW/vzZ+IgiLaKF3UbOX48Vv0/TxKq6cX8+JunSvknPuiOxfBTGGom6GImHrABKStkcLxzOf1TDg8hYVmZU1n8knAs2MWyOorH/4kOgJLIERaxu6lE8+a2ATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737216; c=relaxed/simple;
	bh=GrboKc4qQ3h3fbYckuUNEybe8bNyxWbdg1Ssvb/s4n0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ei+wAeGdHLF2pKN339BiatXfvUfMvvM6zpA/0uA3WJotB65nDThmX2mOcMs7xthUn8RRxROuucyb1SDzFZNM2g3PuTE8hIFeUbt3aWR3g8OE7+doL3m3lvFvcU1BgezIX+xmDDPNJGga+kFJroMW4ThGy2yKP4EP7W6wsX3nnss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maqs9KnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BB4C116D0;
	Wed, 24 Sep 2025 18:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737216;
	bh=GrboKc4qQ3h3fbYckuUNEybe8bNyxWbdg1Ssvb/s4n0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=maqs9KnCAf9joFI4dNWyKQPTmfqsFzIRPK12TieBUtUtqsB9ySXEIEwPsR5U3k+hT
	 Z0FhZQ/ymfgLJiULgfvqGsxzOeSAs8LsrBJ2bAnZYVVjlVFedQKeDRQIhrKbGDw0qv
	 LdCHEiqTb5gTxQ68Vr0GEqdgnno5sK++0OzxNRKxHGzz2OT2iMMYlOUnLkPfkfxFYJ
	 hpiRRbAXPvJTG2q8xJGAcc5vWqVqEM7BlFkFp4AFV0Oy3rpAqIb1LwPB8y2jIFxQLe
	 EV6FzGUxKqpmS9/NURnYLV3XZgp3MV3EY7lyruxcFXGFz+PjEIcrXEc4cAAgttdfRj
	 +W8Oz54MF90ew==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:05:58 -0400
Subject: [PATCH v3 12/38] nfsd: check for delegation conflicts vs. the same
 client
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-12-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2624; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GrboKc4qQ3h3fbYckuUNEybe8bNyxWbdg1Ssvb/s4n0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMNpsl+4JKqcsLTt/M143QF3IySChjZbHrk2
 ogb9dpJ4HKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzDQAKCRAADmhBGVaC
 FTIdD/4wvBlusZxyUuA1jYy2L2h8MEEd/YIVb6RYwmvMPlv9/oUztunaW7f9Pm9hglH9mZRG2qd
 4SEHWysb5u1DMDuZc2EuD4uqgA8SkHifXeQ8hyZUBcJYUI0TFGuH7NVu/31UV1E/IMoIAKYyhDk
 Os8syViLp3/oiyslnyLY3+jSnAQ8YHYl9dJHd73EHMgEY40XuNDdF/6qNbvbrHTL/PpaSVDsxAQ
 JBoMszR/ROwUAKcfoW0m29CqZkV4LELctNP29iKAsQlTH4yvZJXqTksZiRPh/YkfT+pHCCe0ZJL
 BKaPoUVO7Og7RhPg5fzIjRQE7H+FijJdVj9ZJmyn7mHVjSOO3NupEyM/jMn5H0iMjc1b0CBIDVr
 bUKvMK5Tbwf0Y1N0pR30rPJh2Zl8ItAWMFN/UoSKXv2LgHk76ezNyNy8RptFuYC7wIf15q/iPZm
 QzpmgVmvx3mtWxHNMCrHNDwHpZGR28gQ9Wr/29F3njPtBTaeNjLf3oow+dVzwVeoCcjnpvLd05Z
 NZP5kkZ1M3eKrAvHARKn9atckE/m3a+FW/G3LDjFDPs3lXfQ86dwk2cRwThza9XFLsMSqJBTvWw
 k+mV8GKNU4RjwgIujbIoH8hhNuyphwtKHdDDDGWbTAVeQG7QGXOkEt0opzvOH74kRm1BaJHI1Mq
 FLY+VvWTC+EOxvg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

RFC 8881 requires that the server reply with GDD_UNAVAIL when the client
requests a directory delegation that it already holds.

When setting a directory delegation, check that the client associated
with the stateid doesn't match an existing delegation. If it does,
reject the setlease attempt.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 25e4dc0a1459b73a0484c05cb3d1f0306784bb74..87857b351cd92c509ab7101645e17474f2dabcd4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -88,6 +88,7 @@ void nfsd4_end_grace(struct nfsd_net *nn);
 static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps);
 static void nfsd4_file_hash_remove(struct nfs4_file *fi);
 static void deleg_reaper(struct nfsd_net *nn);
+static bool nfsd_dir_may_setlease(struct file_lease *new, struct file_lease *old);
 
 /* Locking: */
 
@@ -5580,6 +5581,31 @@ static const struct lease_manager_operations nfsd_lease_mng_ops = {
 	.lm_change = nfsd_change_deleg_cb,
 };
 
+static const struct lease_manager_operations nfsd_dir_lease_mng_ops = {
+	.lm_breaker_owns_lease = nfsd_breaker_owns_lease,
+	.lm_break = nfsd_break_deleg_cb,
+	.lm_change = nfsd_change_deleg_cb,
+	.lm_may_setlease = nfsd_dir_may_setlease,
+};
+
+static bool
+nfsd_dir_may_setlease(struct file_lease *new, struct file_lease *old)
+{
+	struct nfs4_delegation *od, *nd;
+
+	/* Only conflicts with other nfsd dir delegs */
+	if (old->fl_lmops != &nfsd_dir_lease_mng_ops)
+		return true;
+
+	od = old->c.flc_owner;
+	nd = new->c.flc_owner;
+
+	/* Are these for the same client? No bueno if so */
+	if (od->dl_stid.sc_client == nd->dl_stid.sc_client)
+		return false;
+	return true;
+}
+
 static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struct nfs4_stateowner *so, u32 seqid)
 {
 	if (nfsd4_has_session(cstate))
@@ -5918,12 +5944,13 @@ static struct file_lease *nfs4_alloc_init_lease(struct nfs4_delegation *dp)
 	fl = locks_alloc_lease();
 	if (!fl)
 		return NULL;
-	fl->fl_lmops = &nfsd_lease_mng_ops;
 	fl->c.flc_flags = FL_DELEG;
 	fl->c.flc_type = deleg_is_read(dp->dl_type) ? F_RDLCK : F_WRLCK;
 	fl->c.flc_owner = (fl_owner_t)dp;
 	fl->c.flc_pid = current->tgid;
 	fl->c.flc_file = dp->dl_stid.sc_file->fi_deleg_file->nf_file;
+	fl->fl_lmops = S_ISDIR(file_inode(fl->c.flc_file)->i_mode) ?
+				&nfsd_dir_lease_mng_ops : &nfsd_lease_mng_ops;
 	return fl;
 }
 

-- 
2.51.0


