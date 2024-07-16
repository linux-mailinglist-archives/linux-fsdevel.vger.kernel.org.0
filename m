Return-Path: <linux-fsdevel+bounces-23766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B82932962
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 16:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6381F20FEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E425F1B0138;
	Tue, 16 Jul 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1ynLfSn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488C01B0127;
	Tue, 16 Jul 2024 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140250; cv=none; b=cpVXMbVdnfvSStyAavjL6SahEcCSLpQqyk1obzo/PdrMlE6Dk5fFSlPaNgrCKjPRUS9CbYYxS2+HHZBEYNZQksCRb+YFDIiHWe6KtM2uTTSC4hdIrCCvjfiQurWjxzjApX+/yWpkI69iRk+GuAfcRFSu58cLiuaK4wHzt7k1PBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140250; c=relaxed/simple;
	bh=JB7FpzoeqtwLJkHES8RfcRvvPze5GkSItXCifJDKpsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrcw/csIcA1eEfcayOXpFM0OceWiDvqikC4D38PlZY/PNjMLgtATD7J4xK1vp6SkyjXb2DaGzYFbyqGrpyxstze2vgtYVZdbQjsGPcG6YDjS1wntWZLF/FZDBJTV+uX47bPFBpjbT34oPk6AH5w2LUR2oJXbaNj37sU4eGQ1qf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1ynLfSn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A24C116B1;
	Tue, 16 Jul 2024 14:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140249;
	bh=JB7FpzoeqtwLJkHES8RfcRvvPze5GkSItXCifJDKpsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1ynLfSnecfyRP4hYPkZKcie1Mb3BMaTSD3yaU6JVzSD5Ri7Ocikkp6wFiUkV98uB
	 xbkVe1mwCcRF1l5fQO4fvboqoA++x5F9X6IsZdqDv7K8r9ANfFw7Q9lGtb3K+dIABC
	 BHbqyx3KjEtS1ytEn7wWlMOXVgCc/s+sm3U9L2IDm/EGcSorilufvZCfpgtixlus53
	 O7VI9taVBcl4l1RXg37bMz+XYiPu6SDMoy0qZo7K5O5tSgOGOBaLnzqpfOT7qa2EXh
	 qaagaBg7KwyoyDoykhI59PUcrBuuGSPPABDfLoEL8ybHOlm+cgKWBF6joby8ZDTHTq
	 PtCq1dPlwbdGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/3] fs: better handle deep ancestor chains in is_subdir()
Date: Tue, 16 Jul 2024 10:30:42 -0400
Message-ID: <20240716143043.2714553-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716143043.2714553-1-sashal@kernel.org>
References: <20240716143043.2714553-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.317
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 391b59b045004d5b985d033263ccba3e941a7740 ]

Jan reported that 'cd ..' may take a long time in deep directory
hierarchies under a bind-mount. If concurrent renames happen it is
possible to livelock in is_subdir() because it will keep retrying.

Change is_subdir() from simply retrying over and over to retry once and
then acquire the rename lock to handle deep ancestor chains better. The
list of alternatives to this approach were less then pleasant. Change
the scope of rcu lock to cover the whole walk while at it.

A big thanks to Jan and Linus. Both Jan and Linus had proposed
effectively the same thing just that one version ended up being slightly
more elegant.

Reported-by: Jan Kara <jack@suse.cz>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 4d96eb591f5d9..93671238abce1 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3003,28 +3003,25 @@ EXPORT_SYMBOL(d_splice_alias);
   
 bool is_subdir(struct dentry *new_dentry, struct dentry *old_dentry)
 {
-	bool result;
+	bool subdir;
 	unsigned seq;
 
 	if (new_dentry == old_dentry)
 		return true;
 
-	do {
-		/* for restarting inner loop in case of seq retry */
-		seq = read_seqbegin(&rename_lock);
-		/*
-		 * Need rcu_readlock to protect against the d_parent trashing
-		 * due to d_move
-		 */
-		rcu_read_lock();
-		if (d_ancestor(old_dentry, new_dentry))
-			result = true;
-		else
-			result = false;
-		rcu_read_unlock();
-	} while (read_seqretry(&rename_lock, seq));
-
-	return result;
+	/* Access d_parent under rcu as d_move() may change it. */
+	rcu_read_lock();
+	seq = read_seqbegin(&rename_lock);
+	subdir = d_ancestor(old_dentry, new_dentry);
+	 /* Try lockless once... */
+	if (read_seqretry(&rename_lock, seq)) {
+		/* ...else acquire lock for progress even on deep chains. */
+		read_seqlock_excl(&rename_lock);
+		subdir = d_ancestor(old_dentry, new_dentry);
+		read_sequnlock_excl(&rename_lock);
+	}
+	rcu_read_unlock();
+	return subdir;
 }
 EXPORT_SYMBOL(is_subdir);
 
-- 
2.43.0


