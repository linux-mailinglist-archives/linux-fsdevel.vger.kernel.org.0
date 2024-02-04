Return-Path: <linux-fsdevel+bounces-10203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50640848A93
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 03:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830181C21F7F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 02:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8DFEAD2;
	Sun,  4 Feb 2024 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BfiaI6RP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBBC6FA8;
	Sun,  4 Feb 2024 02:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013064; cv=none; b=mCkDyvVh3RmGzDwoVrJzY0dWQ678j9YRE/LTuqWysCDw6flnnu8rJb+LyfTV5YkoL8K/WZSBiFIh06UHotNJn3El71bkyU9nF6W97CeMMeUa42zePgI+yNebWAhiK1Yabzc+ydM7glJ2uLK20xpvoa2R2y35HTvXj2g+yX9V2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013064; c=relaxed/simple;
	bh=j6rsvNN8oo5Bvj0EJ/yVmFHfs8Um7QkVVzBq0K42Rqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cPgtVnBcKCWxjXzi7+XVXHH0zFHCgwZ+zZKo749MYFARMsaH2v/qnNpx4PCaCQ50yS1KZflORTm8Eg9ahQvuxVTW0VU1xYBIwI89aVhj5p5N+ig5oTtviOnxt1Vg8NXrH9mB+0cIcojiOaMGn7766pRFg/OPDElmY0cFCWv34pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BfiaI6RP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1HFI4KKL79Sd/NlR6QYbK/LO3YNDNZj8ruRJ2Po8n78=; b=BfiaI6RPnXysexAqLOvzi/xd4/
	xNQPKqHFXPKgXHMATcWLBhPpjAX2hBrdsZ4f2kv8pFN9qnEXeVAY/T/0zHISphhPHGp983TaopYhX
	JiEhRug4uAeivhZ62q8RBH8BwurRmaVlNA1rrxGt8VaXyN1F6MeVAYVwVaU2/Ficj/n1MLKSqBm8K
	koW3ZUCW855MWUF1bfbFJBFasSiwUaGxg4mXy5aTcN9Woh5mqF0sOTyPKg3TEC3/QJx4HsDKAe90F
	Tp1hdtHYVWhp05Uq7XiM2VqM0KEfl6fQwDbgJmGRk5d0g0ZKc2lEjYLtjlvY+eZSGgv/puzMo0UXt
	NvAu0mpw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rWS4h-004rCn-2m;
	Sun, 04 Feb 2024 02:17:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-cifs@vger.kernel.org
Subject: [PATCH 01/13] fs/super.c: don't drop ->s_user_ns until we free struct super_block itself
Date: Sun,  4 Feb 2024 02:17:27 +0000
Message-Id: <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204021436.GH2087318@ZenIV>
References: <20240204021436.GH2087318@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Avoids fun races in RCU pathwalk...  Same goes for freeing LSM shite
hanging off super_block's arse.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/super.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index d35e85295489..d6efeba0d0ce 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -274,9 +274,10 @@ static void destroy_super_work(struct work_struct *work)
 {
 	struct super_block *s = container_of(work, struct super_block,
 							destroy_work);
-	int i;
-
-	for (i = 0; i < SB_FREEZE_LEVELS; i++)
+	security_sb_free(s);
+	put_user_ns(s->s_user_ns);
+	kfree(s->s_subtype);
+	for (int i = 0; i < SB_FREEZE_LEVELS; i++)
 		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
 	kfree(s);
 }
@@ -296,9 +297,6 @@ static void destroy_unused_super(struct super_block *s)
 	super_unlock_excl(s);
 	list_lru_destroy(&s->s_dentry_lru);
 	list_lru_destroy(&s->s_inode_lru);
-	security_sb_free(s);
-	put_user_ns(s->s_user_ns);
-	kfree(s->s_subtype);
 	shrinker_free(s->s_shrink);
 	/* no delays needed */
 	destroy_super_work(&s->destroy_work);
@@ -409,9 +407,6 @@ static void __put_super(struct super_block *s)
 		WARN_ON(s->s_dentry_lru.node);
 		WARN_ON(s->s_inode_lru.node);
 		WARN_ON(!list_empty(&s->s_mounts));
-		security_sb_free(s);
-		put_user_ns(s->s_user_ns);
-		kfree(s->s_subtype);
 		call_rcu(&s->rcu, destroy_super_rcu);
 	}
 }
-- 
2.39.2


