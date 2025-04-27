Return-Path: <linux-fsdevel+bounces-47458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75689A9E48E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Apr 2025 22:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0813BC7FB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Apr 2025 20:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05C61FFC5F;
	Sun, 27 Apr 2025 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Eyi0uW+x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30E11CD15;
	Sun, 27 Apr 2025 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745784933; cv=none; b=Tq9xRGwFtTkW09nZ54ggXR6nxvBlD/cWZ94r4LHSg87pWl+OixRcsipvs1mK9oqqBuEi+c2sPApwA+XsobGbZYdQj49BFwn9DsYzCPw5raPh/KsoEtgdtV/YGdd4xCeIDnj38dwoHHw86iQ1oCr2j1/+UCUiTx3UYr5Q78EwKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745784933; c=relaxed/simple;
	bh=GmVSpCRVER7SlA0s64ZgQ2L9CE1XycbUoDtUAnJgWvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aW1ZLZ6dGgbhYCtfSCCmQA3HELiim4VuYkbtCxQUQRU3QHalsYuv7iYSbNOEIY2QDj40CVhwtyYBvdlGMLL2wNxNhoDqdvwOHwkBygtRXdPsYnAohlyNQZia5t3ncIPggLRCa7SIIcThxdK2az4TV1WN4Ttlv+4VWUTpmrCy2Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Eyi0uW+x; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.8])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7C87F5275401;
	Sun, 27 Apr 2025 20:15:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7C87F5275401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1745784919;
	bh=aWVTrCpEpTf0YZ8exFyzgkKvArZllltnDxxIduvkrMo=;
	h=From:To:Cc:Subject:Date:From;
	b=Eyi0uW+xbL+3AOVNZI2KTAC1wOmS9yJR5qDRyn92hJwnfNRMqMG3FMnNzSwVdvTvF
	 IewDDOw7ubduhIQbO3aXEc1B2/5arBcJs8Oc5L6beBuPxL1dut3eO5NLtY3kuQiHAm
	 aOm6CsHWwH0lxWsOBO15SsRlm0u8wna9+DfOA+kU=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: linux-kernel@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-bcache@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] sort.h: hoist cmp_int() into generic header file
Date: Sun, 27 Apr 2025 23:14:49 +0300
Message-ID: <20250427201451.900730-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Deduplicate the same functionality implemented in several places by
moving the cmp_int() helper macro into linux/sort.h.

The macro performs a three-way comparison of the arguments mostly useful
in different sorting strategies and algorithms.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

https://lore.kernel.org/linux-xfs/20250426150359.GQ25675@frogsfrogsfrogs/T/#u

 drivers/md/bcache/btree.c |  3 +--
 fs/bcachefs/util.h        |  3 +--
 fs/pipe.c                 |  3 +--
 fs/xfs/xfs_zone_gc.c      |  2 --
 include/linux/sort.h      | 10 ++++++++++
 5 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index ed40d8600656..2cc2eb24dc8a 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -36,6 +36,7 @@
 #include <linux/sched/clock.h>
 #include <linux/rculist.h>
 #include <linux/delay.h>
+#include <linux/sort.h>
 #include <trace/events/bcache.h>
 
 /*
@@ -559,8 +560,6 @@ static void mca_data_alloc(struct btree *b, struct bkey *k, gfp_t gfp)
 	}
 }
 
-#define cmp_int(l, r)		((l > r) - (l < r))
-
 #ifdef CONFIG_PROVE_LOCKING
 static int btree_lock_cmp_fn(const struct lockdep_map *_a,
 			     const struct lockdep_map *_b)
diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
index 3e52c7f8ddd2..7ec1fc8b46f9 100644
--- a/fs/bcachefs/util.h
+++ b/fs/bcachefs/util.h
@@ -16,6 +16,7 @@
 #include <linux/preempt.h>
 #include <linux/ratelimit.h>
 #include <linux/slab.h>
+#include <linux/sort.h>
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
 
@@ -669,8 +670,6 @@ static inline void percpu_memset(void __percpu *p, int c, size_t bytes)
 
 u64 *bch2_acc_percpu_u64s(u64 __percpu *, unsigned);
 
-#define cmp_int(l, r)		((l > r) - (l < r))
-
 static inline int u8_cmp(u8 l, u8 r)
 {
 	return cmp_int(l, r);
diff --git a/fs/pipe.c b/fs/pipe.c
index da45edd68c41..45077c37bad1 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -26,6 +26,7 @@
 #include <linux/memcontrol.h>
 #include <linux/watch_queue.h>
 #include <linux/sysctl.h>
+#include <linux/sort.h>
 
 #include <linux/uaccess.h>
 #include <asm/ioctls.h>
@@ -76,8 +77,6 @@ static unsigned long pipe_user_pages_soft = PIPE_DEF_BUFFERS * INR_OPEN_CUR;
  * -- Manfred Spraul <manfred@colorfullife.com> 2002-05-09
  */
 
-#define cmp_int(l, r)		((l > r) - (l < r))
-
 #ifdef CONFIG_PROVE_LOCKING
 static int pipe_lock_cmp_fn(const struct lockdep_map *a,
 			    const struct lockdep_map *b)
diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
index 81c94dd1d596..2f9caa3eb828 100644
--- a/fs/xfs/xfs_zone_gc.c
+++ b/fs/xfs/xfs_zone_gc.c
@@ -290,8 +290,6 @@ xfs_zone_gc_query_cb(
 	return 0;
 }
 
-#define cmp_int(l, r)		((l > r) - (l < r))
-
 static int
 xfs_zone_gc_rmap_rec_cmp(
 	const void			*a,
diff --git a/include/linux/sort.h b/include/linux/sort.h
index 8e5603b10941..c01ef804a0eb 100644
--- a/include/linux/sort.h
+++ b/include/linux/sort.h
@@ -4,6 +4,16 @@
 
 #include <linux/types.h>
 
+/**
+ * cmp_int - perform a three-way comparison of the arguments
+ * @l: the left argument
+ * @r: the right argument
+ *
+ * Return: 1 if the left argument is greater than the right one; 0 if the
+ * arguments are equal; -1 if the left argument is less than the right one.
+ */
+#define cmp_int(l, r) (((l) > (r)) - ((l) < (r)))
+
 void sort_r(void *base, size_t num, size_t size,
 	    cmp_r_func_t cmp_func,
 	    swap_r_func_t swap_func,
-- 
2.49.0


