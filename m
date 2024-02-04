Return-Path: <linux-fsdevel+bounces-10202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADAA848A84
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 03:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FF4BB24842
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 02:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2A0A92E;
	Sun,  4 Feb 2024 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LGcxzo4I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2916FC5;
	Sun,  4 Feb 2024 02:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013064; cv=none; b=BOgqL7YbO7aAqSDpdIwJkxsWqYUzlqGYrqq79sNVruofc8l6bCaAWnaPO7uf9dlLdtvMpYdJ90pGFuAtOeApsAEQQv2vNXnrx9s+Mi/iYFEbjw56UkZTlDUAE11fXy+MW39PYuI+ih7kS/e4XJ82pi7d1a+rzde6c5uPon/0bQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013064; c=relaxed/simple;
	bh=v5nm9WdCUwUgJfQ97cmtXjLDq45y1UqLvQaZ0A5z2ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mcOxfLIfb2dkG+Y5phLajGHnPekorfz+l78YgV2ViDcvRGz0UBcv9AaHl94c9TeVShT9uIa27pCVAFS07C4MPSX9KgolojM6pbuteDGa7ZtaK8sWUX87XTnefrUcn+syAKAOgYsLeVeoBx7vSmy3ideWTou9dlXIlIMLlL2Mxqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LGcxzo4I; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WNs3vukbXJtl12Oxlgybl8Hl88cxUtaVDUYMxN0ihgM=; b=LGcxzo4IlqtZEUOa+v0SpEXnZ2
	DQTG2ASGJxbT8A1OnFm4F9VWP9wkAiedcZhFYqXPzd5TMBUJ4k4H1KScdcc1Os45IRjg3QN0b+7FK
	fyLWpO/DTbglgPM8gcpubs7ZL9gghTV4JoaRg37REEWWmhLGJl8CZeFzNsKHrA73MUu0vvzMgBWMe
	++e7gAMZ/ItTOzFUpw83GE7onAOlJGzWnsfVFuyA03K8I2Bo6kidvJ1ohmTwruTuvISmmg/52K6bT
	ZS88i3QMl+eKMct5NUDkCCeMZeXlhWn2TXNe1BMXcFSLLwoB9iHlUZmnk6FNzzqzDlUoAIZLS6eXL
	QHGwd72g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rWS4i-004rCp-0J;
	Sun, 04 Feb 2024 02:17:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-cifs@vger.kernel.org
Subject: [PATCH 02/13] rcu pathwalk: prevent bogus hard errors from may_lookup()
Date: Sun,  4 Feb 2024 02:17:28 +0000
Message-Id: <20240204021739.1157830-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

If lazy call of ->permission() returns a hard error, check that
try_to_unlazy() succeeds before returning it.  That both makes
life easier for ->permission() instances and closes the race
in ENOTDIR handling - it is possible that positive d_can_lookup()
seen in link_path_walk() applies to the state *after* unlink() +
mkdir(), while nd->inode matches the state prior to that.

Normally seeing e.g. EACCES from permission check in rcu pathwalk
means that with some timings non-rcu pathwalk would've run into
the same; however, running into a non-executable regular file
in the middle of a pathname would not get to permission check -
it would fail with ENOTDIR instead.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 4e0de939fea1..9342fa6a38c2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1717,7 +1717,11 @@ static inline int may_lookup(struct mnt_idmap *idmap,
 {
 	if (nd->flags & LOOKUP_RCU) {
 		int err = inode_permission(idmap, nd->inode, MAY_EXEC|MAY_NOT_BLOCK);
-		if (err != -ECHILD || !try_to_unlazy(nd))
+		if (!err)		// success, keep going
+			return 0;
+		if (!try_to_unlazy(nd))
+			return -ECHILD;	// redo it all non-lazy
+		if (err != -ECHILD)	// hard error
 			return err;
 	}
 	return inode_permission(idmap, nd->inode, MAY_EXEC);
-- 
2.39.2


