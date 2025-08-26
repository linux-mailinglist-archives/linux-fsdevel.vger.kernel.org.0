Return-Path: <linux-fsdevel+bounces-59253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AED2B36E57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2248E4610
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F341535FC24;
	Tue, 26 Aug 2025 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Wr0maEcw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DFA35CECD
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222881; cv=none; b=MjI5s04OsMw/DWT2bJRdHyQAwe/q2DbMhr784rWRs9jjnZITzGKajX1anHAhMUnGVBm0DHLQwC9nB5cWoKYtwM/4TJvjlDQ7wQZDovZCQyc6YJl6EgNJCERy+bHSmhp5PI6sKdPSZUNTV3YXb7sNINrF+Fc+1YXq5C53pFJ4dwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222881; c=relaxed/simple;
	bh=3EjK7e1wo9m6QIxNaE+tEjCwYN+DkEURl0dI7nbECcA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJirMCcCG9AKLHxRhntp3S32xvO9z5GIWylZdu2oZRYD/GZDsUKSxjwO+PlnZVS5GwagYBim1XCzH4sM+qBOSOi/Z4jEAjrRpNFYqdx5GeyHhSh19w+v9Jri4MrxyN8EWXKRq1bZR2auZisJCFG60wd6z+LL5Uk73/wbN5syXoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Wr0maEcw; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d605a70bdso37816517b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 08:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222875; x=1756827675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShFlqp5VOipOeM7qzYThb9TpsgG09sUanUCy1d9D4RI=;
        b=Wr0maEcwFRF6AKZxE59ULTSS8opjYy1ESQuAR6xP2rwpUAvHZMhx0gbecia4vGBMlw
         ZUdLkrAJ6JkvidItwaV/tfmZJWmZ2E0svXesR00FEXYHGvhMEnx9sUrSrMRrZF9J36Cw
         SRwx8BXsRx8d/p7O0TJNV5bzcwuzgG5CrQfCMGtJJrSOv4ffnjQiJQWkHIO8tJT1sRvs
         GJDdVwvQhhxXFoftGApjiJ8FLJH6BPrF2SCNNBr3y0Hx8KpB2eLznBa79Vl4fiQAzUpQ
         zzaWz7rM9ZrMsFPbgmy82cgV4SZSW4Y+dIBmMjDsTs+3Fp841dUo5C7vJeXJW7yEOSu5
         qPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222875; x=1756827675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShFlqp5VOipOeM7qzYThb9TpsgG09sUanUCy1d9D4RI=;
        b=FF58PIieij87ocNcd17XfvQNUX8ttGLKa7bai8wetfZHrdodwPKgCSvxoz/Dl5ewV/
         mm5wpVUZOeVB9ZDS50hztpDwehs0H0JSezZWObApeTa6GL1qRWEV2/rj0hnpnC8zkavL
         eBmMaY/MSpp26V9y5iXGnKd4r9uNu2OH3vbPwIpPvNHRXvIagx31c4WjPg4GM9A8RSy5
         ViWS+TFqrAcmgVr0QWnIVsZu/ycoCSX/knjc3VKV+tj5V/BdMHXi03y/b3Jt1q0pKwDA
         PQYqMLhk6Gvug9TMWqeJt372VsbJiH+NdjbBQz/UfCP3q9WZC7gZR8xrjE+UyjOx108u
         BsHA==
X-Gm-Message-State: AOJu0YzEhGAFD6ECv+NDcKqY1r/AnPX6Qb4z0i1LUPNIvsFDATXRtl4C
	Toe7nO5IqbUF8lXvlnEdj6KpKYEhd//NQrtOOgNgLxIusXRiQ6roayNza0jM9FETrPCimmhvWql
	PQve+
X-Gm-Gg: ASbGnctKU4asPgQS4EnpVbJYDnRDYHSfhaG18C9eOfs0oKZYXrpo6BcPtDr+cgK+STq
	CNMbL9JNLxG+6KWsnzBpyLcHVrerbiJpsBa1o/i7LbmOzvZPdnPLbVR3WoiqHV4beSTbajAdIHX
	/6YtTZsx8ONDkvFVvciQ227n//1M3geotdlqSgmwXhf/bvzblDfYeEQCa8FK+AadvRu3MqLxX59
	lR4Z/ZT9G588F9qzK94dums9S57EAaV5sPo8zoJFhMmjRxvNqR9rT6+2049X30Kc4d9dwZuoqAM
	iFe8H2WE+a+zaEdVqviqTIBpXJ4aGcOp4Ozl7+8Me44UqHUtQuPB/YTwqfgTzWGQ3AMUirUbeOQ
	hDlW9eignGKNP9UQeYI7UUI1IC1Di/6CQiFAMtZQf8l2zyvTpCNun5m7Vbznu0P3uF297Iw==
X-Google-Smtp-Source: AGHT+IFxo/w7op/ge+NmnsNsGn77AjHcEkfsy56WOUb8EsB10dRusVpRuEuCR4A5mjkx2bVUh5AkJg==
X-Received: by 2002:a05:690c:6082:b0:721:10a3:6584 with SMTP id 00721157ae682-72110a36c63mr79058537b3.11.1756222874743;
        Tue, 26 Aug 2025 08:41:14 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18af680sm25272777b3.58.2025.08.26.08.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 18/54] fs: change evict_inodes to use iput instead of evict directly
Date: Tue, 26 Aug 2025 11:39:18 -0400
Message-ID: <2e71234c109ee6a45a469022436cc5c3d31914ed.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At evict_inodes() time, we no longer have SB_ACTIVE set, so we can
easily go through the normal iput path to clear any inodes. Update
dispose_list() to check how we need to free the inode, and then grab a
full reference to the inode while we're looping through the remaining
inodes, and simply iput them at the end.

Since we're just calling iput we don't really care about the i_count on
the inode at the current time.  Remove the i_count checks and just call
iput on every inode we find.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 399598e90693..ede9118bb649 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -933,7 +933,7 @@ static void evict(struct inode *inode)
  * Dispose-list gets a local list with local inodes in it, so it doesn't
  * need to worry about list corruption and SMP locks.
  */
-static void dispose_list(struct list_head *head)
+static void dispose_list(struct list_head *head, bool for_lru)
 {
 	while (!list_empty(head)) {
 		struct inode *inode;
@@ -941,8 +941,12 @@ static void dispose_list(struct list_head *head)
 		inode = list_first_entry(head, struct inode, i_lru);
 		list_del_init(&inode->i_lru);
 
-		evict(inode);
-		iobj_put(inode);
+		if (for_lru) {
+			evict(inode);
+			iobj_put(inode);
+		} else {
+			iput(inode);
+		}
 		cond_resched();
 	}
 }
@@ -964,21 +968,13 @@ void evict_inodes(struct super_block *sb)
 again:
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		if (icount_read(inode))
-			continue;
-
 		spin_lock(&inode->i_lock);
-		if (icount_read(inode)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
 		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
 
-		inode->i_state |= I_FREEING;
-		iobj_get(inode);
+		__iget(inode);
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
@@ -991,13 +987,13 @@ void evict_inodes(struct super_block *sb)
 		if (need_resched()) {
 			spin_unlock(&sb->s_inode_list_lock);
 			cond_resched();
-			dispose_list(&dispose);
+			dispose_list(&dispose, false);
 			goto again;
 		}
 	}
 	spin_unlock(&sb->s_inode_list_lock);
 
-	dispose_list(&dispose);
+	dispose_list(&dispose, false);
 }
 EXPORT_SYMBOL_GPL(evict_inodes);
 
@@ -1108,7 +1104,7 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 
 	freed = list_lru_shrink_walk(&sb->s_inode_lru, sc,
 				     inode_lru_isolate, &freeable);
-	dispose_list(&freeable);
+	dispose_list(&freeable, true);
 	return freed;
 }
 
-- 
2.49.0


