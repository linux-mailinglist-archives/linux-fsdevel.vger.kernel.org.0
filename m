Return-Path: <linux-fsdevel+bounces-62641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9B8B9B4DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9C2163672
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D390B32A810;
	Wed, 24 Sep 2025 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FygU2Epc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095CF31B812;
	Wed, 24 Sep 2025 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737255; cv=none; b=fJUT6OLBkvZlqFF1GX4wmngIQwhOpod8fw0EfiDCWPBpTt1b7MU+ZXcBVM3uCTUp+FIrPXvqXAxnXea4oL0ckVkarpiIuKTcp0lE/Xxgdo8XzsJySF73kxQVBJtKrvGCCNCpJ/1c4qLPtvo0BKS8GTC9/bE4AKKpmP8xuouoAAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737255; c=relaxed/simple;
	bh=jKbdNMRBVIX0B01osOz9mn1qjWvvPHIuxQWeV1raF0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XGB58V2HPrbVj5JLTL0RBNaYcnHCo4ihqgAgItJb2bByn65bL6wb9VE1ZWhJKXEttxTdYgiy8esoqwHLiN5mW1L+hquHamfx/ui+mjSh1mdEEuynBHm5W+0ULB6CnlsF/25BaK52vQ/ulUGwDQoZcOse+G5lvGTa+ZWbF9pu+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FygU2Epc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607A8C4CEF4;
	Wed, 24 Sep 2025 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737254;
	bh=jKbdNMRBVIX0B01osOz9mn1qjWvvPHIuxQWeV1raF0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FygU2EpcVOlYA/GZWsreqtWS4RdfnkrZ8L0DOODWffe8TcceEDmGe3u+G65IsYrAr
	 Oa7k4cvYLFr2KdGzw6e8D/XDOmReMwy2Z1bqMPY5ER6h7Sury0eWa3Y2FhSEg3yjPl
	 Cmk9+YkIeBY778G8TmGjxk9C3KzWkq4ZVYUDXJcgoactCO1l4/1rmBp8XcDTb4OaXW
	 qjgo6FVDgXAVYZ4sGGhq/eN1+IClzMzOXHytKgepKefSRHAHlUMlYPpB6k/PtSQeel
	 tfei9pL8yKV9a9tCD7cK1Myzrrx6KE48jTnh4ysKaL2JmQFhzlhG2haRay5AtpNRO5
	 Z4vFdmPa9FqtQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:09 -0400
Subject: [PATCH v3 23/38] nfsd: update the fsnotify mark when setting or
 removing a dir delegation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-23-9f3af8bc5c40@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2299; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=jKbdNMRBVIX0B01osOz9mn1qjWvvPHIuxQWeV1raF0E=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMPG85QEzVOwxruh+e7XYVOqNCa6yqZsTbdY
 qvqbm+fYTaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzDwAKCRAADmhBGVaC
 FZlJEACvNpCbUOl/h9fjfmcW35DUUvBSaEij3Pc94L1revgE4+4D93foZg7ON+eKGpJ4CciZSRr
 1aw3Re4Cj4BR0jksVSoxiCgQLpDerrtTow5Ooc+GNVkiKXNArHvcP5XYtTfjOHKNYadVqrwtCfj
 2eX+oqBLdTM4DzqFU32k5kL2UJu534oUrbV9I/XR/6eAnF4qx9waQTwg4vjaBpQ/ppayLmrg9as
 D4s5mDO5noinelVdRzC+iA5URX3b4LqUkdy0PLbRT346LHfNXx8ZE0PQURpBwuVDRiNN8iKJv+3
 9w6ZC/jm9QDZVuHDpOaPd7U3aAwmwbCbX+M8j3fCmeoJ4ma0sJOF+0swZOq9z6SSEiptMNs1idF
 0ZoBt1OHL24B4V54S6c7uivR3kAtfOXDciLiBeMOUavoZ2sizTJWxirU/mQmZilA1LW0X3z/7Uc
 h2qgpdrofK7EBEllvje4I+YkZtBaPUq2JkEYsfSrsvG2vY352Sfqo+y04MltrK5TquAos8hcyP5
 wmfgmHJEKD1qhJvktCd9SUYzk3Ffalyf0SsoygohQDY7Y8qE3VqN2vwqvwIEcdXfgaKjvYxEw25
 dZiGKyXsJZ9tr9/V9rjVjJ4vsGZJoe66fLYZAXMITs5AAR3/xhHP9+8LzJ3cp5ioxngMD28tluV
 6FgVIKDrU5/qAEg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new helper function that will update the mask on the nfsd_file's
fsnotify_mark to be a union of all current directory delegations on an
inode. Call that when directory delegations are added or removed.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e219556e0959dbf0a8147d5edbb725da125a978f..eac9e9360e568caf1f615d230cff39e022107f12 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1259,6 +1259,37 @@ static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct f
 	}
 }
 
+static void nfsd_fsnotify_recalc_mask(struct nfsd_file *nf)
+{
+	struct fsnotify_mark *mark = &nf->nf_mark->nfm_mark;
+	struct inode *inode = file_inode(nf->nf_file);
+	u32 lease_mask, set = 0, clear = 0;
+
+	/* This is only needed when adding or removing dir delegs */
+	if (!S_ISDIR(inode->i_mode))
+		return;
+
+	/* Set up notifications for any ignored delegation events */
+	lease_mask = inode_lease_ignore_mask(inode);
+
+	if (lease_mask & FL_IGN_DIR_CREATE)
+		set |= FS_CREATE;
+	else
+		clear |= FS_CREATE;
+
+	if (lease_mask & FL_IGN_DIR_DELETE)
+		set |= FS_DELETE;
+	else
+		clear |= FS_DELETE;
+
+	if (lease_mask & FL_IGN_DIR_RENAME)
+		set |= FS_RENAME;
+	else
+		clear |= FS_RENAME;
+
+	fsnotify_modify_mark_mask(mark, set, clear);
+}
+
 static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
@@ -1267,6 +1298,7 @@ static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 	WARN_ON_ONCE(!fp->fi_delegees);
 
 	nfsd4_finalize_deleg_timestamps(dp, nf->nf_file);
+	nfsd_fsnotify_recalc_mask(nf);
 	kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
 	put_deleg_file(fp);
 }
@@ -9507,8 +9539,10 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	spin_unlock(&clp->cl_lock);
 	spin_unlock(&state_lock);
 
-	if (!status)
+	if (!status) {
+		nfsd_fsnotify_recalc_mask(nf);
 		return dp;
+	}
 
 	/* Something failed. Drop the lease and clean up the stid */
 	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);

-- 
2.51.0


