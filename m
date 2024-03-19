Return-Path: <linux-fsdevel+bounces-14830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125E488051A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 19:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CF81C2343D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 18:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4D939AF9;
	Tue, 19 Mar 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="iFUt69Vn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C762939AC9
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710874194; cv=none; b=aToJxMnsRLbF0d6yWUydNmCj+H5+B0Z5z/8lnTRSObJq1NZd7tY6cQoi7ndCKDa5ri6L69OQEFBbSK13bj2dV7DVNd7V5uaOx5pQwhwcXfjK1NPLvhzT05lcWnkmwm1s6iGtJ8Odpd34YZo8u149RmJLK7DP3kdjSc4EBcvPRFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710874194; c=relaxed/simple;
	bh=ueqAp9zOHpO1D7i5gNMcL0x9xn7MpoTz4WcRSlFA7vE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b1s3qUxMZb2NxrSSOtzjGl2879I/gX6WDna3PiDUr1e8/MB8D49bEVxt3iorYVs4o5VthjNRVrMBUwEjuLbtCv6yBTF5L/59RxFlRH2sC2QUJUDuYXBB9WWVavfUzikkLA6QsgEQLWhQsOqzCzypQu/ZVnWc4/LIJ1HEU0Ya0a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=iFUt69Vn; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1498:0:640:4af2:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 8607B60E10;
	Tue, 19 Mar 2024 21:49:41 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id enJ2r3xBYiE0-PLCQubVJ;
	Tue, 19 Mar 2024 21:49:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1710874181; bh=6d+CpemBtK0eqi0Cr0V7mbsOvlgIoLemtrkM+z7l8Ww=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=iFUt69VnaDdZS30OrwT70mq5A+2Dj5ls6R3iud3srl+yeW9vQZ+jy63J5rQEIE+gM
	 2R0aw6BlP8MqTTU8A2MPUrWP3kdDdwbPGifRX4ttIFm2WmpRtasRdflsTO07nRtht6
	 Vi1SVjIKWYGTEbfnhqSbeflOzLngsYen7Ds7hWzo=
Authentication-Results: mail-nwsmtp-smtp-production-main-33.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Ivan Trofimov <i.trofimow@yandex.ru>
To: ebiggers@kernel.org,
	brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 RFC] eventpoll: try to reuse eppoll_entry allocations
Date: Tue, 19 Mar 2024 21:49:40 +0300
Message-Id: <20240319184940.112678-1-i.trofimow@yandex.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of unconditionally allocating and deallocating pwq objects,
try to reuse them by storing the entry in the eventpoll struct
at deallocation request, and consuming that entry at allocation request.
This way every EPOLL_CTL_ADD operation immediately following an
EPOLL_CTL_DEL operation effectively cancels out its pwq allocation
with the preceding deallocation.

With this patch applied I'm observing ~13% overall speedup when 
benchmarking the following scenario:
1. epoll_ctl(..., EPOLL_CTL_ADD, ...)
2. epoll_ctl(..., EPOLL_CTL_DEL, ...)
which should be a pretty common one for either applications dealing with
a lot of short-lived connections or applications doing a DEL + ADD dance
per level-triggered FD readiness.

This optimization comes with a sizeof(void*) + sizeof(struct eppoll_entry)
per-epoll-instance memory cost, which amounts to 72 bytes for 64-bit

Signed-off-by: Ivan Trofimov <i.trofimow@yandex.ru>
---
NULL check before kmem_cache_free in ep_free is left in place,
as an attempt to pass NULL to kmem_cache_free leads to BUG.

Changes in v2:
 - Fix the typo in ep_alloc_pwq docstring
 - Add a comment about why calling ep_pwq_alloc in the
   ep_ptable_queue_proc callback is safe

 fs/eventpoll.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 882b89edc..c8fb9ec70 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -219,6 +219,9 @@ struct eventpoll {
 	u64 gen;
 	struct hlist_head refs;
 
+	/* a single-item cache used to reuse eppoll_entry allocations */
+	struct eppoll_entry *pwq_slot;
+
 	/*
 	 * usage count, used together with epitem->dying to
 	 * orchestrate the disposal of this struct
@@ -648,6 +651,36 @@ static void ep_remove_wait_queue(struct eppoll_entry *pwq)
 	rcu_read_unlock();
 }
 
+/*
+ * This function either consumes the pwq_slot, or allocates a new
+ * eppoll_entry if the slot is empty.
+ * Must be called with "mtx" held.
+ */
+static struct eppoll_entry *ep_alloc_pwq(struct eventpoll *ep)
+{
+	struct eppoll_entry *pwq = ep->pwq_slot;
+
+	if (pwq) {
+		ep->pwq_slot = NULL;
+		return pwq;
+	}
+	return kmem_cache_alloc(pwq_cache, GFP_KERNEL);
+}
+
+/*
+ * This function either fills the pwq_slot with the eppoll_entry,
+ * or deallocates the entry if the slot is already filled.
+ * Must be called with "mtx" held.
+ */
+static void ep_free_pwq(struct eventpoll *ep, struct eppoll_entry *pwq)
+{
+	if (!ep->pwq_slot) {
+		ep->pwq_slot = pwq;
+		return;
+	}
+	kmem_cache_free(pwq_cache, pwq);
+}
+
 /*
  * This function unregisters poll callbacks from the associated file
  * descriptor.  Must be called with "mtx" held.
@@ -660,7 +693,7 @@ static void ep_unregister_pollwait(struct eventpoll *ep, struct epitem *epi)
 	while ((pwq = *p) != NULL) {
 		*p = pwq->next;
 		ep_remove_wait_queue(pwq);
-		kmem_cache_free(pwq_cache, pwq);
+		ep_free_pwq(ep, pwq);
 	}
 }
 
@@ -789,6 +822,8 @@ static void ep_free(struct eventpoll *ep)
 	mutex_destroy(&ep->mtx);
 	free_uid(ep->user);
 	wakeup_source_unregister(ep->ws);
+	if (ep->pwq_slot)
+		kmem_cache_free(pwq_cache, ep->pwq_slot);
 	kfree(ep);
 }
 
@@ -1384,7 +1419,11 @@ static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead,
 	if (unlikely(!epi))	// an earlier allocation has failed
 		return;
 
-	pwq = kmem_cache_alloc(pwq_cache, GFP_KERNEL);
+	/*
+	 * The callback is invoked from within ep_insert, which is called
+	 * with the ep->mtx held, so this is safe.
+	 */
+	pwq = ep_alloc_pwq(epi->ep);
 	if (unlikely(!pwq)) {
 		epq->epi = NULL;
 		return;
-- 
2.34.1


