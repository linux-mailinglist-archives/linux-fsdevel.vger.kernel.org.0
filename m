Return-Path: <linux-fsdevel+bounces-23762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B988993290C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 16:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FB81C21EEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 14:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA0C19E7C6;
	Tue, 16 Jul 2024 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGmtq7vV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42DE1AAE3D;
	Tue, 16 Jul 2024 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140140; cv=none; b=tFL0yTt7xJjJCOoJSQAgxw0gZ9UUXdgQkumbspHI8/0GKvp3v6/vKMmfF/DHyxQNxPsRkBOaUT4XaTv83WeWioHXqQJJdWnpq14VoGbIEHuu/ms3l32lakEnA/HTwpF/dLXc8+Ev4LqeUIcHRgWNYYDIKQkSY5Ig4Bpz0Q6fPeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140140; c=relaxed/simple;
	bh=gvbCHdIym+20o8pm8b0bFRnIVP/gQWuJtFiCtTGYwuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Du1jwluQKO1Eg/xTNFauypFgfU/Cu7vU4ahqnibB/HotyFcHR3z6wuZmxWqy78PMSFXQCO1wvNzFfBlrV5e2P40qlqtyOZhdjGO/nH05aI2jOgb2n70iA9P5Djq4dXIFht5hb1Y808Nx/InZSAjWo9ik4Ev9Kk20ObrSazzMWzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGmtq7vV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2FCC4AF10;
	Tue, 16 Jul 2024 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140139;
	bh=gvbCHdIym+20o8pm8b0bFRnIVP/gQWuJtFiCtTGYwuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OGmtq7vV2RaUCZokKzXHiOklcOH8p/n04/VUs+D7vt45lRFBDcH6DGT6yyfbzP8FF
	 gvF86RpG2BjdlhA+b4fEsVj3oQ1XZ2AN9mLcZkpwhgUhxdWShU6YLuTh9sSlroiWuY
	 3EUXQD1rW1qGf13aX7ZGe/TwiCbPQldLsDFAgRugny1K3fA4QTSLc6C47LZMXt1JvT
	 REtKUVuv05kkkssmpjSyc3lpfUtzW0U2ZubxeaF2/vAwohmy+dYIhh5RXrDVjQKYIA
	 XiG/1FsbMjX5vVf56fpZewXR731T9h8M6yYqde1SwRzQMliOzUFfrDvNcmEkREqKHM
	 kSVB1xHwhNocA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/15] fs: better handle deep ancestor chains in is_subdir()
Date: Tue, 16 Jul 2024 10:28:09 -0400
Message-ID: <20240716142825.2713416-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142825.2713416-1-sashal@kernel.org>
References: <20240716142825.2713416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.99
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
index b09bc88dbbec7..0c8f7b7226193 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3203,28 +3203,25 @@ EXPORT_SYMBOL(d_splice_alias);
   
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


