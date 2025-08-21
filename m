Return-Path: <linux-fsdevel+bounces-58653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EECB30657
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1593B799C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3D938C616;
	Thu, 21 Aug 2025 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="yia2gpxu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6651138C602
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807642; cv=none; b=T1kQ+Yy63wt2qekItfMLt/jP1TzXYOqHiZn6xq2B4PyR5QvYDGZd7+/TTgozQryzdIXvXStqTxzf+AM2R21+9wxLYbIrCxyiykZLvtR90Mh2cMb7jP7d89qT4B+XGgIeg1Fud907xvaWRgUvZuhqX8h/KHTjnqe2lc/EK/MXePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807642; c=relaxed/simple;
	bh=E1CZO0qANMqkotvvGy80SzBF1+IOn0iuawhmFtdmLq8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTB5I5mR+NuDsJMHLk4iUOFCVa+af/P7agi8c03aJRl8aKoSm8iegvN9/0d7gYzxbH69+LeyV1NQEzIhAh+INfRXihGPkZQ6k398S8TglwqqTvmEedqa3XN6QXwbm0nu6UaUCESnnDPuom2AJWkAH7ZBEyUJ8d3RRrM1lv263OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=yia2gpxu; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d603acc23so12082047b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807640; x=1756412440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cq8CitEHOIa1E1kCzffFkimm5JhYQkJcPbJMgOYWCnc=;
        b=yia2gpxuXEbFsf+uTotXb53zaiUVeBugX9No5DdR0DnMpdpGwfDJv7sGU9aNhe7Xyx
         W70oHhLQagkGNI8ZNe7VvZX5iwYyhXsrl4kGRzIWJRVSo50NAC7C23DIEK/Gooj1Nz3T
         jXrDSdA2cJ7EQiAUwXJom4NV1uAPhUYGHSw9sYtBPOKvN5ouxLFL9Z3+SJUesVFNTgyR
         hJdmzkmt4v4ZCpSpbSRdIu6fGltc1W6KRuEy+cCdonEhilJYfINjZkYbb3FqHSkewUH3
         XjZLs3nMZjXdy9Ay8R+76anr6ZsuhGtIqvT146slkpzxBDeDnx+nsGsioiC2uNOJZDQV
         pWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807640; x=1756412440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cq8CitEHOIa1E1kCzffFkimm5JhYQkJcPbJMgOYWCnc=;
        b=vcfODmmGQ/yT1+MWRSP9fF78tBHi3O6b5pedMp78NkjfADKh3B26+Yml8i2e5iQDAd
         sQAdaI3vWOZrE9XdPJEhKWI+F0ejt5NEzfRzzQyD1TDh3jsIOoufw5XYPnK0LQZ/D4W/
         S+4k5pyx0VY77Wy8ePbijtPCGVv1OE/doK0jwCKtyHwQZVkbSTizKQXB5B/0M+zn/JzY
         Xgoha5+by3KqeVBAB2QCbBzILc4c+8H04AkIlck+wx0qTzBFy6V+0e29OEaSVglHsPrB
         B2hWaY1zXuj83D3JBOkOHPar9+baNT+92NOqJI/AhjmKCMTYoD/VejgReZo+dQaThUxe
         lT4Q==
X-Gm-Message-State: AOJu0YwlBCb74G+g6k/9u0kcfA5Rjeg3bhTxKnmt4mrCRJ8wmUVp38QD
	w7HxqDM3pvWXvIoLXFkfbShM7XtNf0Ln+xEyZCS1teLfaVxQ8owkh7TDqmzOgnk+TH19+cGtOH/
	d+gvRbn+Z7Q==
X-Gm-Gg: ASbGncvHddTQNmS02zxY9A0OoTXvgwzJ3oTSYZ4vp7GLyRwfHxfRz21KOl1D1z4X0Y2
	DF6X5AizNg79VAEj95FCAp6E0ntTetVD5rVBMwApMj6apSw216jqoGHvvp4bg9j5TaH2xnJq8Uk
	15aoyi+M3On0M7FZy7HrR8uy9ViZiD71qVZGQcNuzmmdPAahgU3K8VPcePVWWakWj54WxQvApS0
	7CsulIj7cEzh3dCeuIO8eIs3SV07F3HQzvh5waSirtbs4DvouseqfnpiN3oB+I9uuhLXdBFkSwP
	/2NGgwNWGduHaztc8U3tqm30ojzgSwJ6VRdmr9AWF7Qm4Qp1Ku38ky88tLzRs+yaeX1i/piI/BU
	IIZpmuMIcfFBdLxuh503IAXGF3HHUSw02dVqKaQQ6SxM4syTwDjgNselYX7k=
X-Google-Smtp-Source: AGHT+IF2O7wlpGJrENGQ2aGvG1BuhjQkjhrQFkStA83E9K3W/Lj4TvLcWt9Rj28gyNPq2k4QeOthLw==
X-Received: by 2002:a05:690c:7109:b0:71f:d22b:3526 with SMTP id 00721157ae682-71fdc2b148amr8123447b3.10.1755807639150;
        Thu, 21 Aug 2025 13:20:39 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fd92b885fsm2500997b3.10.2025.08.21.13.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:38 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 16/50] fs: change evict_inodes to use iput instead of evict directly
Date: Thu, 21 Aug 2025 16:18:27 -0400
Message-ID: <1198cd4cd35c5875fbf95dc3dca68650bb176bb1.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
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
index 72981b890ec6..80ad327746a7 100644
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
-		if (atomic_read(&inode->i_count))
-			continue;
-
 		spin_lock(&inode->i_lock);
-		if (atomic_read(&inode->i_count)) {
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


