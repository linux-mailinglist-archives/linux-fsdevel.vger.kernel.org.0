Return-Path: <linux-fsdevel+bounces-36130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F209DC155
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 10:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD205163C9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 09:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1893417625C;
	Fri, 29 Nov 2024 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="YFWw5uDm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2570170A15
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871923; cv=none; b=pKbnDaMV24JSmbAswFYjkUWVQ0sLvgyeUkO+H8dUNOBsuMR/GErN6B7spmInQkVkkuFYpbUkL0oIK5kYexU5iPBzd2JWbLq2CnMXJaNKjO6Bwy8dRm99rZmj7Y3vLW/C6oU83slYP2sLEAVGusSFZSP1seqIqcng0zD0/Bqf6U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871923; c=relaxed/simple;
	bh=6Ofjd3lsBtR9sLdqVHv2uq0QaDdVeE4LdyhtDMLUz+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBuqmJ5bzaoJxckefWFBTp4uEE1PIeRGuvfRuSePPGfuwV286Wb4gG48ZIKtBxFF7FcbGJ3DEg4EAOOZOd35i9h1BxkAnYnsKMIiOR5GsFl6LbgsrFbmljXqySFI18zgbUyR/LYiE9gbLkk05LgeKuUNjlqU+BdTtEm5Ugup760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=YFWw5uDm; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net [IPv6:2a02:6b8:c07:109:0:640:efe1:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id F26E060E18;
	Fri, 29 Nov 2024 12:18:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id SIX747HOl0U0-puwfVSDK;
	Fri, 29 Nov 2024 12:18:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732871911; bh=ot2jlcBchNY/FjHrqVluTtlM6+/wbytJf+Jwus3KUAE=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=YFWw5uDmbvD03YHhHgXqjOBUiW9wz93xesWOwJpSNjWUPMPtTL+1I7CMuf5bo34W3
	 BTrGLw3r32O1IU+8bRyPGtTVdbhPNs+RNu8PiGjWXUzi+008H64DOtJ34hPQEYZ2NL
	 TGczrmaO5i21wAIJ9ubfsbvFrPiHkzjbsfJFsy74=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Steven Whitehouse <swhiteho@redhat.com>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] gfs2: miscellaneous spelling fixes
Date: Fri, 29 Nov 2024 12:03:55 +0300
Message-ID: <20241129090355.365972-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241129090355.365972-1-dmantipov@yandex.ru>
References: <20241129090355.365972-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling here and there as suggested by codespell.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/gfs2/bmap.c       | 2 +-
 fs/gfs2/dir.c        | 2 +-
 fs/gfs2/lock_dlm.c   | 4 ++--
 fs/gfs2/quota.c      | 2 +-
 fs/gfs2/recovery.c   | 2 +-
 fs/gfs2/rgrp.c       | 4 ++--
 fs/gfs2/trace_gfs2.h | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 1795c4e8dbf6..100784403758 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1194,7 +1194,7 @@ const struct iomap_ops gfs2_iomap_ops = {
  * @inode: The inode
  * @lblock: The logical block number
  * @bh_map: The bh to be mapped
- * @create: True if its ok to alloc blocks to satify the request
+ * @create: True if its ok to alloc blocks to satisfy the request
  *
  * The size of the requested mapping is defined in bh_map->b_size.
  *
diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 85736135bcf5..dc5879e055ab 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -1259,7 +1259,7 @@ static int compare_dents(const void *a, const void *b)
  * @sort_start: index of the directory array to start our sort
  * @copied: pointer to int that's non-zero if a entry has been copied out
  *
- * Jump through some hoops to make sure that if there are hash collsions,
+ * Jump through some hoops to make sure that if there are hash collisions,
  * they are read out at the beginning of a buffer.  We want to minimize
  * the possibility that they will fall into different readdir buffers or
  * that someone will want to seek to that location.
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 58aeeae7ed8c..e8099e293212 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -425,7 +425,7 @@ static void gdlm_cancel(struct gfs2_glock *gl)
  * 10. gfs2_control sets control_lock lvb = new gen + bits for failed jids
  * 12. gfs2_recover does journal recoveries for failed jids identified above
  * 14. gfs2_control clears control_lock lvb bits for recovered jids
- * 15. gfs2_control checks if recover_block == recover_start (step 3 occured
+ * 15. gfs2_control checks if recover_block == recover_start (step 3 occurred
  *     again) then do nothing, otherwise if recover_start > recover_block
  *     then clear BLOCK_LOCKS.
  *
@@ -823,7 +823,7 @@ static void gfs2_control_func(struct work_struct *work)
 
 	/*
 	 * No more jid bits set in lvb, all recovery is done, unblock locks
-	 * (unless a new recover_prep callback has occured blocking locks
+	 * (unless a new recover_prep callback has occurred blocking locks
 	 * again while working above)
 	 */
 
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index d919edfb8dda..2989f5f3295e 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -11,7 +11,7 @@
  * avoids the bottleneck of constantly touching the quota file, but introduces
  * fuzziness in the current usage value of IDs that are being used on different
  * nodes in the cluster simultaneously.  So, it is possible for a user on
- * multiple nodes to overrun their quota, but that overrun is controlable.
+ * multiple nodes to overrun their quota, but that overrun is controllable.
  * Since quota tags are part of transactions, there is no need for a quota check
  * program to be run on node crashes or anything like that.
  *
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 527353c36aa5..779db78f9c80 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -154,7 +154,7 @@ int __get_log_header(struct gfs2_sbd *sdp, const struct gfs2_log_header *lh,
  * @blk: the block to look at
  * @head: the log header to return
  *
- * Read the log header for a given segement in a given journal.  Do a few
+ * Read the log header for a given segment in a given journal.  Do a few
  * sanity checks on it.
  *
  * Returns: 0 on success,
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index b14e54b38ee8..a0aec705c5ee 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1028,7 +1028,7 @@ static int gfs2_ri_update(struct gfs2_inode *ip)
  * special file, which might have been updated if someone expanded the
  * filesystem (via gfs2_grow utility), which adds new resource groups.
  *
- * Returns: 0 on succeess, error code otherwise
+ * Returns: 0 on success, error code otherwise
  */
 
 int gfs2_rindex_update(struct gfs2_sbd *sdp)
@@ -1912,7 +1912,7 @@ static void try_rgrp_unlink(struct gfs2_rgrpd *rgd, u64 *last_unlinked, u64 skip
  * the lock for this rgrp's glock is significantly greater than the
  * time taken for resource groups on average. We introduce a margin in
  * the form of the variable @var which is computed as the sum of the two
- * respective variences, and multiplied by a factor depending on @loops
+ * respective variances, and multiplied by a factor depending on @loops
  * and whether we have a lot of data to base the decision on. This is
  * then tested against the square difference of the means in order to
  * decide whether the result is statistically significant or not.
diff --git a/fs/gfs2/trace_gfs2.h b/fs/gfs2/trace_gfs2.h
index 8eae8d62a413..04535e07d090 100644
--- a/fs/gfs2/trace_gfs2.h
+++ b/fs/gfs2/trace_gfs2.h
@@ -429,7 +429,7 @@ TRACE_EVENT(gfs2_ail_flush,
  * Objectives:
  * Latency: Bmap request time
  * Performance: Block allocator tracing
- * Correctness: Test of disard generation vs. blocks allocated
+ * Correctness: Test of discard generation vs. blocks allocated
  */
 
 /* Map an extent of blocks, possibly a new allocation */
-- 
2.47.1


