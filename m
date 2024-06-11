Return-Path: <linux-fsdevel+bounces-21376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F47A902F72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 06:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264381C21EB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 04:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A920C16F915;
	Tue, 11 Jun 2024 04:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzH4xQIz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DA92570;
	Tue, 11 Jun 2024 04:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718079358; cv=none; b=SmuMXwmu5ermsYssFLX32GwO4y+AA7SUO8xL64/NVhdMconMVbBEsk9zidM8vcY6mraskDrClBD3AFBeHy+9o1k8uqSLO00ud+57b40uMgM9GlKAJKFeSDMBLRJH9HW+IRtfJEeapel8JyjnCmLw7WDXCAyY3OvfmDYbSeIyWDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718079358; c=relaxed/simple;
	bh=N5EBSpcZkFiMtrh5336xOXwbPXQGG7sXkoPFqYbcyZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PmZLiDN//PWxFVYH6bHUyPJk/8Wmb/AT0TvN7GMV+co6gkE1T9E78yuQPYAyCI4n64OF/8ukD+NaG4tHChvr3GRpcWmngzpkK3XUQ8Po0YxeZgoOlS9uWwYUfgI/+cdthsllVApFuV1T9iWMkconGTy842A96sPzchnunGoI1l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzH4xQIz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42121d27861so45000995e9.0;
        Mon, 10 Jun 2024 21:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718079355; x=1718684155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cuWqGCjonoMFuxbnfFMq9beCr3z21M9jL/dtMf8LQx8=;
        b=VzH4xQIz0mAY1EP+ubbMyWQaMvwO1D4E46tAja1dShdSiNIX04/iP3Wzf/zzQBgxqd
         ftbg1MeXHBWvY5HM+EX0RKAGOppie64+c+HCbqP7a8FrpFtoHtNp0Pr1icgbaufF1Evt
         +jKOmgDTaoy3iEo9rp/KUoq97vgYlHhLRnP7XOw0iVDXwKNuJatpJbNiw2m6CvwCG8QU
         j6zFd85TL8U9JXbx34mJiQp4fA+Yp/RGUhXC6qz/j1k8ebrqfBWqSSiRkHckpf0wPdAv
         eAJqwHmssgIfA5PVAbI4KZyqcHxVJ+4SCcwtlU6QhacCtYoNb6S8a3uY10pysD4QhRFZ
         khMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718079355; x=1718684155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cuWqGCjonoMFuxbnfFMq9beCr3z21M9jL/dtMf8LQx8=;
        b=cdJYdw/ba331nVBd3DAgVl0HqXfbg2BIVliMH7Jac1CTJ9xVxPJNgDHWscQmMv3a2H
         pPWVV+cHcArdMl6XtKVm5GBd0DQylQ7eBp/MBVDxcCmSMRnrR1PepqMUPK0tbg58qqgX
         Pf7boO9qNlhIUrKIw4yBIndPKiEeGrxppBi+0ynkLzCi4F0zmApebAD+fhQAoZqSKB43
         /LK7QEepiIKNKuUNfDSOhOBq4yw9U7uWPAV2S1u/Yfjso9cZ+QSKMk1TeokX2uL9sqjg
         ZWixo4FIRFH+KSUOqgFpoy4HOgUHRTU7zgg9eqICp7wCcPyuvGkJaQ6yiLepSFkTxPN7
         bpzA==
X-Forwarded-Encrypted: i=1; AJvYcCVL6SNyO/G/cHx5Q0oL0JnQhjIeh7OrGNN5REml3oCPp0/R319DG8fRQ9y6L2x9mpqdh7AMNa1n3ft2k7qeBXMtAssis2n7ctRLZIgqbkO3MRJZTVu4emnsnDYM9uqGJnVqA74e59pFu58H/A==
X-Gm-Message-State: AOJu0YyEOmKocfjblAF5cDlyty+G6YF0iSKIqWeEMm7Mp2sU3t77v//Z
	WdtfK9PjpO3mItezb2ozPWodJkTbqA2BVMfr+g7zaC9kKeZcD8e7
X-Google-Smtp-Source: AGHT+IFicW8ljaCkwjAN3Iw/H2Hd7qjENa96RDpVcje1uZV3DonXeyvLiaD7i2wCkHm+DfQMyu+vxA==
X-Received: by 2002:a05:600c:1ca3:b0:421:6b79:8900 with SMTP id 5b1f17b1804b1-4216b798c9cmr64041135e9.41.1718079354540;
        Mon, 10 Jun 2024 21:15:54 -0700 (PDT)
Received: from f.. (cst-prg-65-249.cust.vodafone.cz. [46.135.65.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158149008sm194405165e9.29.2024.06.10.21.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 21:15:54 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	dave@fromorbit.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: partially sanitize i_state zeroing on inode creation
Date: Tue, 11 Jun 2024 06:15:40 +0200
Message-ID: <20240611041540.495840-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

new_inode used to have the following:
	spin_lock(&inode_lock);
	inodes_stat.nr_inodes++;
	list_add(&inode->i_list, &inode_in_use);
	list_add(&inode->i_sb_list, &sb->s_inodes);
	inode->i_ino = ++last_ino;
	inode->i_state = 0;
	spin_unlock(&inode_lock);

over time things disappeared, got moved around or got replaced (global
inode lock with a per-inode lock), eventually this got reduced to:
	spin_lock(&inode->i_lock);
	inode->i_state = 0;
	spin_unlock(&inode->i_lock);

But the lock acquire here does not synchronize against anyone.

Additionally iget5_locked performs i_state = 0 assignment without any
locks to begin with and the two combined look confusing at best.

It looks like the current state is a leftover which was not cleaned up.

Ideally it would be an invariant that i_state == 0 to begin with, but
achieving that would require dealing with all filesystem alloc handlers
one by one.

In the meantime drop the misleading locking and move i_state zeroing to
alloc_inode so that others don't need to deal with it by hand.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I diffed this against fs-next + my inode hash patch as it adds one
i_state = 0 case. Should that patch not be accepted this bit can be
easily dropped from this one.

I brought the entire thing up quite some time ago [1] and Dave Chinner
noted that perhaps the lock has a side effect of providing memory
barriers which otherwise would not be there and which are needed by
someone.

For new_inode and alloc_inode consumers all fences are already there
anyway due to immediate lock usage.

Arguably new_inode_pseudo escape without it but I don't find the code at
hand to be affected in any meanignful way -- the only 2 consumers
(get_pipe_inode and sock_alloc) perform numerous other stores to the
inode immediately after. By the time it gets added to anything looking
at i_state, flushing that should be handled by whatever thing which adds
it. Mentioning this just in case.

[1] https://lore.kernel.org/all/CAGudoHF_Y0shcU+AMRRdN5RQgs9L_HHvBH8D4K=7_0X72kYy2g@mail.gmail.com/

 fs/inode.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 149adf8ab0ea..3967e68311a6 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -276,6 +276,10 @@ static struct inode *alloc_inode(struct super_block *sb)
 		return NULL;
 	}
 
+	/*
+	 * FIXME: the code should be able to assert i_state == 0 instead.
+	 */
+	inode->i_state = 0;
 	return inode;
 }
 
@@ -1023,14 +1027,7 @@ EXPORT_SYMBOL(get_next_ino);
  */
 struct inode *new_inode_pseudo(struct super_block *sb)
 {
-	struct inode *inode = alloc_inode(sb);
-
-	if (inode) {
-		spin_lock(&inode->i_lock);
-		inode->i_state = 0;
-		spin_unlock(&inode->i_lock);
-	}
-	return inode;
+	return alloc_inode(sb);
 }
 
 /**
@@ -1254,7 +1251,6 @@ struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
 		struct inode *new = alloc_inode(sb);
 
 		if (new) {
-			new->i_state = 0;
 			inode = inode_insert5(new, hashval, test, set, data);
 			if (unlikely(inode != new))
 				destroy_inode(new);
@@ -1297,7 +1293,6 @@ struct inode *iget5_locked_rcu(struct super_block *sb, unsigned long hashval,
 
 	new = alloc_inode(sb);
 	if (new) {
-		new->i_state = 0;
 		inode = inode_insert5(new, hashval, test, set, data);
 		if (unlikely(inode != new))
 			destroy_inode(new);
-- 
2.43.0


