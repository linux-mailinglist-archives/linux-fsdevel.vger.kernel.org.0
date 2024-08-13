Return-Path: <linux-fsdevel+bounces-25792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B70399507D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 16:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360161F2214A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B9B19E7F0;
	Tue, 13 Aug 2024 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTtlUPAL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768FA19E7CF;
	Tue, 13 Aug 2024 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559802; cv=none; b=WJqPBIZcP+p+ysIAL8P9AD11qPjboL0I6KSpjSYoD7nN31k2BKMips9FFnE6d69a3VlryGE3MUuhIbb17mbDpt06qC8pebCPqkKNgwuVxBZ++c1hzyrGua5afu2M5bjhPggHo3TEkDX5De0hzWmrqSGKhGsNvG3yUYtvVWfoIEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559802; c=relaxed/simple;
	bh=bhgyqFJhLj3szMeIbBFy4xq0s2+nZawpLVHX5YAzDE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=trtW5gaD/N/BaygGsa7u6igCn0mcYtdHRXkIuV6QS4DfXVqzov/XVep9Zfh3LLxCeN84iKiXZCikPoWjoYtwWodEreH+I3IEQUes0XfkG7NN29rOEfIEf15McqetbxraOPdbaJAMbzmwJSi/o+yhYbQFMlRatP/+AbQ6JugRtKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTtlUPAL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bb8e62575eso2157848a12.3;
        Tue, 13 Aug 2024 07:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723559799; x=1724164599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=06XWappbYAI/s6oOKIug1LztC/DU+0CIJj5hM25fR7Q=;
        b=CTtlUPALjLa+ub+BfdmkTHPEQCiOxvj0geT6TNNQdZtGAADMRargzlZ6/etgPiGbMK
         H5vLknwz/IiUekfwgrR8x/Y74iRnrnKlysk8qGzv7ONbyIpyUFlNnLelO4KQ2n6N0HQC
         mKRfkQWG44QdATkP3Pmk9l7nt5nt2EW8dBvobDQ7xQl/WyN1STuz+3hiTYtjLCWh8RfP
         /iuTsV/KwoxQW7l4xcEGexWScvc5n+AG7wnr0WXs+41lDnE9fGDDcllH3sFvTlQi6r5P
         2EIpVJGIxNH3P5DkXA0pXmSuGVZI434Yhn0WNnYeqdcgrVrM4ggDB6Ns1QdubdXM7W6k
         6Z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559799; x=1724164599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06XWappbYAI/s6oOKIug1LztC/DU+0CIJj5hM25fR7Q=;
        b=FcF52PrGZCx57VqgaY1WgGvnYabdInUBcCyYhV8cJA3yDrN1xB7lx6o8kDBIww7Zgb
         vNc6qo+ZEMGXNlesE4ZSzmSyswpd5xFnGz7O8KH3Sm40CFVsj6aTUpRvEAcEuQ6kKbDx
         LRtsBmgyAuZCwWIrRCrTzvZj3X77ugxeEiF0ifGtEriIw5EcxvztV6xfy1f6WuQbNiQa
         wZ+WqP1eh9TEht3ska3OOXM1ohCDX06LyEpG9b2SQcIohseTzTClElEPPW4tkyuVTmJM
         y76bu66MGW2k+6M32FM9RFTTfUt2+JCtO12vPkzPSuMq+kTpafIC+lbDRzgx9UwmR55x
         oEUw==
X-Forwarded-Encrypted: i=1; AJvYcCVhZS8xhAflhpGVTt3fIl9iRjQGcBC+WTwU5J0uPjgWQlPqF2qyVUzJqitoTPaqWdbhjQtGTcuf15HnpArdNw5fTyar+SoVly91q/XE6vcJXTzMqNOmZuHDdy9mv9spX+iTLyqwI37LYJmuCg==
X-Gm-Message-State: AOJu0Yw7+06SL/4MRGnPzaFHNTn+AKbOt+flFSf/Z64QLB+Mjpjw+LMM
	b0+Lgv9dZ+HzEdBcgqzYFKo9yh5Tdz74qhXdxBV+P6Se8MFqDCg3
X-Google-Smtp-Source: AGHT+IF+l2cFGHe1AZOvVdEPtIY0oSo9CvNvMg/JQZDX+0XemrxLVRZet+vtAmMqmKwrG7IVMLBwBA==
X-Received: by 2002:a05:6402:2813:b0:58b:1a5e:c0e7 with SMTP id 4fb4d7f45d1cf-5bd44c79641mr2768807a12.35.1723559798252;
        Tue, 13 Aug 2024 07:36:38 -0700 (PDT)
Received: from f.. (cst-prg-84-71.cust.vodafone.cz. [46.135.84.71])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5be9a0946easm478484a12.55.2024.08.13.07.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:36:37 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	jlayton@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: drop one lock trip in evict()
Date: Tue, 13 Aug 2024 16:36:26 +0200
Message-ID: <20240813143626.1573445-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most commonly neither I_LRU_ISOLATING nor I_SYNC are set, but the stock
kernel takes a back-to-back relock trip to check for them.

It probably can be avoided altogether, but for now massage things back
to just one lock acquire.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

there are smp_mb's in the area I'm going to look at removing at some
point(tm), in the meantime I think this is an easy cleanup

has a side effect of whacking a inode_wait_for_writeback which was only
there to deal with not holding the lock

 fs/fs-writeback.c | 17 +++--------------
 fs/inode.c        |  5 +++--
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 4451ecff37c4..1a5006329f6f 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1510,13 +1510,12 @@ static int write_inode(struct inode *inode, struct writeback_control *wbc)
  * Wait for writeback on an inode to complete. Called with i_lock held.
  * Caller must make sure inode cannot go away when we drop i_lock.
  */
-static void __inode_wait_for_writeback(struct inode *inode)
-	__releases(inode->i_lock)
-	__acquires(inode->i_lock)
+void inode_wait_for_writeback(struct inode *inode)
 {
 	DEFINE_WAIT_BIT(wq, &inode->i_state, __I_SYNC);
 	wait_queue_head_t *wqh;
 
+	lockdep_assert_held(&inode->i_lock);
 	wqh = bit_waitqueue(&inode->i_state, __I_SYNC);
 	while (inode->i_state & I_SYNC) {
 		spin_unlock(&inode->i_lock);
@@ -1526,16 +1525,6 @@ static void __inode_wait_for_writeback(struct inode *inode)
 	}
 }
 
-/*
- * Wait for writeback on an inode to complete. Caller must have inode pinned.
- */
-void inode_wait_for_writeback(struct inode *inode)
-{
-	spin_lock(&inode->i_lock);
-	__inode_wait_for_writeback(inode);
-	spin_unlock(&inode->i_lock);
-}
-
 /*
  * Sleep until I_SYNC is cleared. This function must be called with i_lock
  * held and drops it. It is aimed for callers not holding any inode reference
@@ -1757,7 +1746,7 @@ static int writeback_single_inode(struct inode *inode,
 		 */
 		if (wbc->sync_mode != WB_SYNC_ALL)
 			goto out;
-		__inode_wait_for_writeback(inode);
+		inode_wait_for_writeback(inode);
 	}
 	WARN_ON(inode->i_state & I_SYNC);
 	/*
diff --git a/fs/inode.c b/fs/inode.c
index 73183a499b1c..d48d29d39cd2 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -582,7 +582,7 @@ static void inode_unpin_lru_isolating(struct inode *inode)
 
 static void inode_wait_for_lru_isolating(struct inode *inode)
 {
-	spin_lock(&inode->i_lock);
+	lockdep_assert_held(&inode->i_lock);
 	if (inode->i_state & I_LRU_ISOLATING) {
 		DEFINE_WAIT_BIT(wq, &inode->i_state, __I_LRU_ISOLATING);
 		wait_queue_head_t *wqh;
@@ -593,7 +593,6 @@ static void inode_wait_for_lru_isolating(struct inode *inode)
 		spin_lock(&inode->i_lock);
 		WARN_ON(inode->i_state & I_LRU_ISOLATING);
 	}
-	spin_unlock(&inode->i_lock);
 }
 
 /**
@@ -765,6 +764,7 @@ static void evict(struct inode *inode)
 
 	inode_sb_list_del(inode);
 
+	spin_lock(&inode->i_lock);
 	inode_wait_for_lru_isolating(inode);
 
 	/*
@@ -774,6 +774,7 @@ static void evict(struct inode *inode)
 	 * the inode.  We just have to wait for running writeback to finish.
 	 */
 	inode_wait_for_writeback(inode);
+	spin_unlock(&inode->i_lock);
 
 	if (op->evict_inode) {
 		op->evict_inode(inode);
-- 
2.43.0


