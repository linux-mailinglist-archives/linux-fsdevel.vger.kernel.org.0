Return-Path: <linux-fsdevel+bounces-49374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3993ABB96E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3F71B607BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1BB286404;
	Mon, 19 May 2025 09:19:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA41827F724;
	Mon, 19 May 2025 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646345; cv=none; b=vAGVVAtN6YMZ5BXV+Sk0Twae6rSo2f1frjyfZC2IpiSuDXKH86vzkdqo9r75yRLecf1dA1r0EzNNDpg85RZ25h2FlL8/LUDoJziEisFrTqnYAtaUQBU4pCGcbEfncLd0zo9euxWply9ON4fY0zn6ejZw+2FFS6+kpS7oQoBkIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646345; c=relaxed/simple;
	bh=4lmBLhJUCTN3YqRABT7fFsjPpJXFoz041muQQWVH95M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BkaaF6W8L9JJdOh5kVdJUirO1aMrmSqUw0In/AWt/VQlN5GxboGGQZ4Y63tVeppLB/jMEF306BiJWtEj2y4QDu6wytGmpQSwbJ9LSvTUF1bwSqWxbFfMJk7j651Sy0002lDYGbXRsIRdHJjy7xUm4xpdy/ct7Yk1HjU7QWWHGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-c8-682af770481e
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yskelg@gmail.com,
	yunseong.kim@ericsson.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com
Subject: [PATCH v16 32/42] dept: assign unique dept_key to each distinct dma fence caller
Date: Mon, 19 May 2025 18:18:16 +0900
Message-Id: <20250519091826.19752-33-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfZ57e++lo+amEr2+JHM1vrEMZcJyYoYhi4k3U7cZPyj6Qeu4
	WaulaMvrFhMQJKzYoijiVKAUrbUUwVs0dVLCKHZDI5ZReWkQB1vcULAGbbciG2s1fjn55X/O
	+Z0vhyHkXskSRq3NEXRapUZBSUnpVLzloyN/J6rWz2kh9KqchIstDgp815oQONqKMUzc2QKD
	4UkEr+8/IKCm2oegYewRAW3eUQRu2zEK+v+YD/5QkIKe6goKShpbKOh7Noth5GwVhiZxOzy2
	PiHh3kkLhpoJCi7UlOBo+QtDxGqnwVq0EsZt52mYHUuGntEBCbgDH8IPdSMUtLt7SPC6xjH0
	/3iRglHHnATueX8hIWxaCr5TRgk0P7dQ8CxsJcAaCtLwa6cZg9e8EFpLo8Kyl/9J4GdjJ4ay
	S9cx+IdvI+go/w2D6BigwBOaxOAUqwmYuXIHwbhpiobjJyI0XCg2Iag4fpaE0pFUeP1P9HLt
	q2Qorm8lofnfAZSexjvqHIj3TAYJvtSZz8+EHlK8O2wm+bsWjr91/hHNl3YEaN4s5vJOWyLf
	2D6B+YbpkIQX7d9TvDhdRfOGKT/mn/f20l8t2yP9NFPQqPME3bpN+6WqFs8Yebh4Y4G/sYwq
	QkNJBhTHcGwKZ2wept+x39tBxZhiV3NDQxEixgnscs5pfCIxIClDsAPvcYO1w8iAGGYBm8F1
	W9JiMyS7kmurvIZjLGM/4Z4a7eit832uqbXzjScumgcqPG9yOZvK+ZvqyJiTY+vjOF+Fl3i7
	sJj7yTZEnkQyM5pnR3K1Ni9LqdakJKkKteqCpK+zs0QU/S7r0dm9LjTt29mFWAYp4mWt7rUq
	uUSZpy/M6kIcQygSZHbnGpVclqks/FbQZe/T5WoEfRdaypCKRbKPw/mZcvYbZY5wSBAOC7p3
	XczELSlCxvb8rczclv5IguGyx5p7SuyOLGs4PehyXa1dta3v99QaQ5qY9l3gZrpZNL18wfbt
	1udswLbaFXTJzi+6e3fh5hufb1ttci2vCuy5tS5euf1AMDhvr+KIP8O96IO12YdSKrNvP913
	RpNf9Vnhn8SmcyXlBekZm7/c0WKeqZdV0lcOKki9SpmcSOj0yv8Bb5O8i1kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUhTexjH7++8/M5xtTqsUYfiUi2ke40sK+uh25UL/eGvlxsRRBSEHurQ
	VmqyqWURaJp49WovYJapzRnL5krbDOxlc7hcLcks1zQxS6mR5UuUW9e3vLPL/efhw/f78Hn+
	eXhadYNdyOtS0mR9ipSkwQpGseO3nJWp36K0q290zIXgaD4D5XVWDO23ahFYG7IpGGiJh87Q
	IIKJp89oKC1pR1DV95qGBk8vAkfNaQwd7+aALziCwVtSiCGnug7D80+TFPRcvEBBre1PeGMO
	MNB6zkRB6QCGK6U5VHh8oGDMbOHAnBUJ/TVlHEz2xYC318+Cu8LLgqN7BVyu7MHwwOFlwNPY
	T0HHvXIMvdZpFlo9jxkIFS+C9vNFLNwcNmH4FDLTYA6OcPDCZaTAY5wP9blha97X7yw8KnJR
	kHftNgW+V/cROPPfUmCz+jG4g4MU2G0lNIxfb0HQXzzEwZm/xzi4kl2MoPDMRQZye2Jh4p/w
	5YrRGMi+Ws/AzSk/+iOOWCutiLgHR2iSaz9GxoMvMXGEjAx5YhLJ3bLXHMl1dnPEaEsn9poo
	Uv1ggCJVX4IssVn+wsT25QJHCoZ8FBlua+N2/rxPsemgnKTLkPWr4hIV2jp3H5OavfG4rzoP
	Z6Gu6AIUwYvCOtHnceIZxsJysatrjJ5htbBEtBcF2AKk4GnBP0vsrHiFChDPzxP2ig9Nv8/s
	MEKk2HD2FjXDSmG9+LHIgv5zLhZr610/PBHhvLvQ/SNXCbGir7aSOYcURvSTBal1KRnJki4p
	NtpwRJuZojsefeBosg2FH8h8avJ8IxrtiG9GAo80s5X1jl+1KlbKMGQmNyORpzVqpcX+i1al
	PChlnpD1RxP06UmyoRkt4hnNAuXWPXKiSjgkpclHZDlV1v/fUnzEwiy0ZmjJB/+zoem1n0/2
	VG3eNa4sQZ/3lxvUzcu46theJmFzU/67Jtd00+OVfTUPAw7v7CnvnTnzcsoDSyXV2gPbNm1o
	jdwdiBAOv49rce1XvkS6/J3xg5daG9XHJhwJyRmmzvStV9vStq9ednJLonOdtM9T5owcfits
	xI1zQ21k6oSGMWilmChab5D+BZdIMXw8AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

dma fence can be used at various points in the code and it's very hard
to distinguish dma fences between different usages.  Using a single
dept_key for all the dma fences could trigger false positive reports.

Assign unique dept_key to each distinct dma fence wait to avoid false
positive reports.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/dma-buf/dma-fence.c | 18 ++++-----
 include/linux/dma-fence.h   | 74 +++++++++++++++++++++++++++++--------
 2 files changed, 68 insertions(+), 24 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index a45e5416f2dd..f6a26e9bbe0e 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -481,7 +481,7 @@ int dma_fence_signal(struct dma_fence *fence)
 EXPORT_SYMBOL(dma_fence_signal);
 
 /**
- * dma_fence_wait_timeout - sleep until the fence gets signaled
+ * __dma_fence_wait_timeout - sleep until the fence gets signaled
  * or until timeout elapses
  * @fence: the fence to wait on
  * @intr: if true, do an interruptible wait
@@ -499,7 +499,7 @@ EXPORT_SYMBOL(dma_fence_signal);
  * See also dma_fence_wait() and dma_fence_wait_any_timeout().
  */
 signed long
-dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
+__dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
 {
 	signed long ret;
 
@@ -520,7 +520,7 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
 	trace_dma_fence_wait_end(fence);
 	return ret;
 }
-EXPORT_SYMBOL(dma_fence_wait_timeout);
+EXPORT_SYMBOL(__dma_fence_wait_timeout);
 
 /**
  * dma_fence_release - default release function for fences
@@ -747,7 +747,7 @@ dma_fence_default_wait_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
 }
 
 /**
- * dma_fence_default_wait - default sleep until the fence gets signaled
+ * __dma_fence_default_wait - default sleep until the fence gets signaled
  * or until timeout elapses
  * @fence: the fence to wait on
  * @intr: if true, do an interruptible wait
@@ -759,7 +759,7 @@ dma_fence_default_wait_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
  * functions taking a jiffies timeout.
  */
 signed long
-dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
+__dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 {
 	struct default_wait_cb cb;
 	unsigned long flags;
@@ -808,7 +808,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 	spin_unlock_irqrestore(fence->lock, flags);
 	return ret;
 }
-EXPORT_SYMBOL(dma_fence_default_wait);
+EXPORT_SYMBOL(__dma_fence_default_wait);
 
 static bool
 dma_fence_test_signaled_any(struct dma_fence **fences, uint32_t count,
@@ -828,7 +828,7 @@ dma_fence_test_signaled_any(struct dma_fence **fences, uint32_t count,
 }
 
 /**
- * dma_fence_wait_any_timeout - sleep until any fence gets signaled
+ * __dma_fence_wait_any_timeout - sleep until any fence gets signaled
  * or until timeout elapses
  * @fences: array of fences to wait on
  * @count: number of fences to wait on
@@ -848,7 +848,7 @@ dma_fence_test_signaled_any(struct dma_fence **fences, uint32_t count,
  * See also dma_fence_wait() and dma_fence_wait_timeout().
  */
 signed long
-dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
+__dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 			   bool intr, signed long timeout, uint32_t *idx)
 {
 	struct default_wait_cb *cb;
@@ -916,7 +916,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 
 	return ret;
 }
-EXPORT_SYMBOL(dma_fence_wait_any_timeout);
+EXPORT_SYMBOL(__dma_fence_wait_any_timeout);
 
 /**
  * DOC: deadline hints
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index e7ad819962e3..d7dc7dcd213f 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -393,8 +393,22 @@ int dma_fence_signal_locked(struct dma_fence *fence);
 int dma_fence_signal_timestamp(struct dma_fence *fence, ktime_t timestamp);
 int dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 				      ktime_t timestamp);
-signed long dma_fence_default_wait(struct dma_fence *fence,
+signed long __dma_fence_default_wait(struct dma_fence *fence,
 				   bool intr, signed long timeout);
+
+/*
+ * Associate every caller with its own dept map.
+ */
+#define dma_fence_default_wait(f, intr, t)				\
+({									\
+	signed long __ret;						\
+									\
+	sdt_might_sleep_start_timeout(NULL, t);				\
+	__ret = __dma_fence_default_wait(f, intr, t);			\
+	sdt_might_sleep_end();						\
+	__ret;								\
+})
+
 int dma_fence_add_callback(struct dma_fence *fence,
 			   struct dma_fence_cb *cb,
 			   dma_fence_func_t func);
@@ -609,12 +623,37 @@ static inline ktime_t dma_fence_timestamp(struct dma_fence *fence)
 	return fence->timestamp;
 }
 
-signed long dma_fence_wait_timeout(struct dma_fence *,
+signed long __dma_fence_wait_timeout(struct dma_fence *,
 				   bool intr, signed long timeout);
-signed long dma_fence_wait_any_timeout(struct dma_fence **fences,
+signed long __dma_fence_wait_any_timeout(struct dma_fence **fences,
 				       uint32_t count,
 				       bool intr, signed long timeout,
 				       uint32_t *idx);
+/*
+ * Associate every caller with its own dept map.
+ */
+#define dma_fence_wait_timeout(f, intr, t)				\
+({									\
+	signed long __ret;						\
+									\
+	sdt_might_sleep_start_timeout(NULL, t);				\
+	__ret = __dma_fence_wait_timeout(f, intr, t);			\
+	sdt_might_sleep_end();						\
+	__ret;								\
+})
+
+/*
+ * Associate every caller with its own dept map.
+ */
+#define dma_fence_wait_any_timeout(fpp, count, intr, t, idx)		\
+({									\
+	signed long __ret;						\
+									\
+	sdt_might_sleep_start_timeout(NULL, t);				\
+	__ret = __dma_fence_wait_any_timeout(fpp, count, intr, t, idx);	\
+	sdt_might_sleep_end();						\
+	__ret;								\
+})
 
 /**
  * dma_fence_wait - sleep until the fence gets signaled
@@ -630,19 +669,24 @@ signed long dma_fence_wait_any_timeout(struct dma_fence **fences,
  * fence might be freed before return, resulting in undefined behavior.
  *
  * See also dma_fence_wait_timeout() and dma_fence_wait_any_timeout().
+ *
+ * Associate every caller with its own dept map.
  */
-static inline signed long dma_fence_wait(struct dma_fence *fence, bool intr)
-{
-	signed long ret;
-
-	/* Since dma_fence_wait_timeout cannot timeout with
-	 * MAX_SCHEDULE_TIMEOUT, only valid return values are
-	 * -ERESTARTSYS and MAX_SCHEDULE_TIMEOUT.
-	 */
-	ret = dma_fence_wait_timeout(fence, intr, MAX_SCHEDULE_TIMEOUT);
-
-	return ret < 0 ? ret : 0;
-}
+#define dma_fence_wait(f, intr)						\
+({									\
+	signed long __ret;						\
+									\
+	sdt_might_sleep_start_timeout(NULL, MAX_SCHEDULE_TIMEOUT);	\
+	__ret = __dma_fence_wait_timeout(f, intr, MAX_SCHEDULE_TIMEOUT);\
+	sdt_might_sleep_end();						\
+									\
+	/*								\
+	 * Since dma_fence_wait_timeout cannot timeout with		\
+	 * MAX_SCHEDULE_TIMEOUT, only valid return values are		\
+	 * -ERESTARTSYS and MAX_SCHEDULE_TIMEOUT.			\
+	 */								\
+	__ret < 0 ? __ret : 0;						\
+})
 
 void dma_fence_set_deadline(struct dma_fence *fence, ktime_t deadline);
 
-- 
2.17.1


