Return-Path: <linux-fsdevel+bounces-23761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286ED9328E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 16:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FB92862EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2024 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414E91A7079;
	Tue, 16 Jul 2024 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKqsfdlu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996151A7064;
	Tue, 16 Jul 2024 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140080; cv=none; b=f+rea+OoqavkNBq4YjpU4T4nx7tFNq5Lp4Mmysw03KYDrmQ6vtMlhHoJv7mea8ds6p2YpuSKoC9GUgVDsZLNqGbzCOoklwUo6XrKbJ/VZ+JOjsjoQNRTcoHlqKBSaqwinQ2Rx5Am1j14rHJTH06gjvNe5xGSzDysUPJ+hYL9ejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140080; c=relaxed/simple;
	bh=uuIJAID7Sqitid6jmfvPGjOSny5Hs9Hth3mwjC7K58E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lycprZ565AZaRFDJb84cY3Z5MH0hdZ4BpOsGfxAPk0cVXBLDtRSH6BKHoIJX8NIPU70KhKYaBrY2fPAkEDYv6Yxf9MNrAZ2OOe9jCLo6OYaE/loBzZ/irMgbAhYiJvOE4Qsrs5bsq8mjjiqbmlU6wkMM7l0U07HsNHAXAPgNcZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKqsfdlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6D3C4AF0E;
	Tue, 16 Jul 2024 14:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721140080;
	bh=uuIJAID7Sqitid6jmfvPGjOSny5Hs9Hth3mwjC7K58E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WKqsfdlux64PIXghyukyCHdpPRqswEgQJDHZlio1yX7/R2UEPt/Wcj8YHkM7wYzmU
	 2BcyZqLMirOd5G2wTTuSxxC9ywEwQUBssaFJXIbFmP+vSZq4EmezmIIvv6VBbBVA1Q
	 12f5cAaF7sfchggJfupSL+gsKLXpQq1DMC5HxKch+A+uYo0/yYKHBX9/9rdQcTvAwg
	 zyf66CebOjJ8ukFuU068yMjHiFJGHkE3rZ0DrXsJLJYFYMc/Yq7FsswCSQ7QuCC9B0
	 NY1UO6vBkMLZ0jHfWghZCG96pFIPKZfLkKM/zqKjJxAvnZmB554uSaAN4UQ44ipJ9A
	 oVIauLnsT1XFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/18] fs: better handle deep ancestor chains in is_subdir()
Date: Tue, 16 Jul 2024 10:26:50 -0400
Message-ID: <20240716142713.2712998-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142713.2712998-1-sashal@kernel.org>
References: <20240716142713.2712998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.40
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
index 9ae808fba517b..99a1b966521a3 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3202,28 +3202,25 @@ EXPORT_SYMBOL(d_splice_alias);
   
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


