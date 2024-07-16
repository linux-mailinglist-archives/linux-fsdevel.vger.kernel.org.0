Return-Path: <linux-fsdevel+bounces-23764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340E3932940
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 16:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A527B224E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 14:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DBA1AD9CC;
	Tue, 16 Jul 2024 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQs5JO8e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA93E1A2C12;
	Tue, 16 Jul 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140215; cv=none; b=tEvqUzBA+zE3yVSTA7t1GcjzwBjchhbfnV7GX0bWInohxczKVGM6yMw/jJTLXAVdlZv3alDn+HNs1AHwnqp2puWP+gI31ZIBT7bN+yvV4OukM4ZaR4IqrqYolgU9IbwoUnqHfsNF9J8IUlPRKU+nCH/pcfgVpkQ/lfZkWhN/xbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140215; c=relaxed/simple;
	bh=6yXjER20qZ2cVxsEGMvxHRNT5+nIS1xUWtyl3BM3zUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mi66WEmCSCCpaxQUYB3fBci9NKJNkXRrvhbJkZRvb9p/sj+Oilu7wm7LsmqsjQyG9Zr75e3N1dHlojt/vNoIiL/Qma+2L3YDMlp7w7kWwYROcAKi1uBPX1RBOAf212gL/OVO5nZz0dfmkguocv1pKgwlIb6kOlsUr+H1s6BonJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQs5JO8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F58C4AF0D;
	Tue, 16 Jul 2024 14:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140214;
	bh=6yXjER20qZ2cVxsEGMvxHRNT5+nIS1xUWtyl3BM3zUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQs5JO8eaxNuZf9NbzzJjrKuCpzgfKnX0SxlwIi7AnDHkaVMmSnce+OiKxwLNkR0B
	 5jZ3LNr8zn9t4WZoH54G6yD8JHzcpvDPzvsJfR/gHIh368kT2Kf1uCWltL0wm4eZG9
	 w31xf9Zql9+FvunrsHt8vAs15ffVUGfvpIP8/SIKii1K+HK+JOVV+qiBHxZpE6d6xw
	 q2wSISQ/EcxgAzW6Qwhcyb/5mI8mzzIo6XFPLXuycC+z38gDNRilz4r/Re+ayMv+h0
	 ZOWBYd7+eH1KyC1o1kflW5ZZQ5rLvrCcNJKh5+5ibRlRRRhEXoBIxhatjXuDLadO6+
	 31QuhX6/2W34A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 7/7] fs: better handle deep ancestor chains in is_subdir()
Date: Tue, 16 Jul 2024 10:29:47 -0400
Message-ID: <20240716142953.2714154-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142953.2714154-1-sashal@kernel.org>
References: <20240716142953.2714154-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.221
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
index 976c7474d62a9..db81d0f5bdc00 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3086,28 +3086,25 @@ EXPORT_SYMBOL(d_splice_alias);
   
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


