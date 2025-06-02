Return-Path: <linux-fsdevel+bounces-50352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A85DACB130
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F26189E88C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0320423BCEE;
	Mon,  2 Jun 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz1dfezB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5161323A993;
	Mon,  2 Jun 2025 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872989; cv=none; b=lF3RmgPp/MP7O3SMljkdBXT94vGvaBzml6z3dKOQa2qRYHUf04DEeGpjTbOYhwB6nGTHU3YC+hJ4ORFrKFC9WI0ZuzH+vM9KyBwZCEM5Eb6FaY9fXBiw8bbdJDjSHRZzqVA5tDn8JdEIdgKHCGgIkV+1xAqLgT1mSh2rRIEUDTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872989; c=relaxed/simple;
	bh=Pz55JuEEdLCPilzrHKqDX5mWZdXe/U4sVTUky1eCFX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=moHhATYa5qmdiq5DkFoLPlgcOcmJhYPt8z6Jb5YAgG6oFSf3IgxiN0tDFg9HYzMccqRPoH90cIr8fsEaCTwh9Wgz0ib8mFeBMWGB+GqF52bEQBXNAeHEdntt3XXLwv1qSJt26OHkhuDbsCoEp0mmcMfLmIGtpoiASv1wT2VPYl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz1dfezB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47F8C4CEF0;
	Mon,  2 Jun 2025 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872988;
	bh=Pz55JuEEdLCPilzrHKqDX5mWZdXe/U4sVTUky1eCFX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sz1dfezBREnI0gVUCr8j87GmlF19pB6tuAMbiS/ED6wCiq/k7Nt3r9IIKRcEhasZi
	 L5bJnXcdn2VI9Dpvt9PSBwxqd6p5rQ5Kv5mX0k7bIJkfpBFYiQpat3MqAivPa1YfJm
	 tvwR8+HX6ko8hEPnnS17Z89HnF/QCZXIbLUkq07k/kTM9JIxZbkUW45QNKB8XDt0sk
	 hvbTyInUPH/Ddctyd7TjFn0EnUBcx1B4S1c8Zk0bzdaQzL5mbGWEbf5knz7wqMyhz3
	 KFOVwZ2+paaXHa4b/BhUe2+8grcgF62jtmywhKmgHo6Gq2a3IG6movNNlyj4DPOFNE
	 Fb+ojMiyO3SPA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:02:05 -0400
Subject: [PATCH RFC v2 22/28] nfsd: update the fsnotify mark when setting
 or removing a dir delegation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-22-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2347; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Pz55JuEEdLCPilzrHKqDX5mWZdXe/U4sVTUky1eCFX4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7pF2+xZkaJPqdnmOahnyjGwgiTAqmYC2EuT
 41/q3TC7nWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u6QAKCRAADmhBGVaC
 FfBcD/4stoDSJG2Rrvar396rOzV8JxwBy1maDQ9VHvj5tI58Ahj8l9ESUK7WJxZIzePPymVwCFi
 yLuuE9kVoTKvkrj8ps5dRr4F66yGl5oS6yFQazHQ2cM66fhgJO/jNHhK+fdZY6UT+i/hSAW7fLE
 kZCEkfEe588gXZYHqJIHHQ/1WwCt24HG7gXvmCZ5D07Z1Z2b/pNM4HHs7gGKGSd11OLdRXvszjm
 H6CcFJgFNhx1nJ5C3XRCy0HxNJeWlRltL8U8rUmTTx1CaHx4xsU9ceqf3QaioKMY+T9JnODZDDx
 e0NeAu3Yd9hiFFbIaRSHTziHiIUJYoqIKltS77jFk5iJCg7IqyCwqA4Rc5wCfWWCsWJs47CZ05o
 HswxHPCgcrnXzt2JgWWd0hS2D9PuT8BJyS3fYAfBKA5sRQZJS1W34PtAbu1p8bJBKJczef93jwf
 tXSAp2XL39xNJ2E2P+A+PXhQQBq+JLkiZLnkS63mrH9MeNwI3zYR1mzw8VQjS1y9xqQtBCIiTRy
 P3deIlugpW3FBVzrF18zDhwpevvM/1sYockg11sAyaWqbGIyOUqyfl9wksI782nHYh5bht7g881
 bV58IoalhgmSkiGlItD9CgCsjTpIDujToLsmAes36Uxwo3me0IXXYmO9k07nhvUYHq4GkrRfx31
 uqb1qulwFavBKnw==
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
index ebebfd6d304627d6c82bae5b84ea6c599d9e9474..164020a01b737f76d2780b30274e75dcc3def819 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1302,6 +1302,37 @@ static void put_deleg_file(struct nfs4_file *fp)
 		nfs4_file_put_access(fp, NFS4_SHARE_ACCESS_READ);
 }
 
+static void nfsd_fsnotify_recalc_mask(struct nfsd_file *nf)
+{
+	struct fsnotify_mark *fsn_mark = &nf->nf_mark->nfm_mark;
+	struct inode *inode = file_inode(nf->nf_file);
+	u32 lease_mask, mask = 0;
+	bool recalc = false;
+
+	/* This is only needed when adding or removing dir delegs */
+	if (!S_ISDIR(inode->i_mode))
+		return;
+
+	/* Set up notifications for any ignored delegation events */
+	lease_mask = inode_lease_ignore_mask(inode);
+	if (lease_mask & FL_IGN_DIR_CREATE)
+		mask |= FS_CREATE;
+	if (lease_mask & FL_IGN_DIR_DELETE)
+		mask |= FS_DELETE;
+	if (lease_mask & FL_IGN_DIR_RENAME)
+		mask |= FS_RENAME;
+
+	spin_lock(&fsn_mark->lock);
+	if (fsn_mark->mask != mask) {
+		fsn_mark->mask = mask;
+		recalc = true;
+	}
+	spin_unlock(&fsn_mark->lock);
+
+	if (recalc)
+		fsnotify_recalc_mask(fsn_mark->connector);
+}
+
 static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
@@ -1309,6 +1340,7 @@ static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 
 	WARN_ON_ONCE(!fp->fi_delegees);
 
+	nfsd_fsnotify_recalc_mask(nf);
 	kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
 	put_deleg_file(fp);
 }
@@ -9487,8 +9519,10 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
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
2.49.0


