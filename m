Return-Path: <linux-fsdevel+bounces-14674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE1687E0AC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 23:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC13628104D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 22:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56E221101;
	Sun, 17 Mar 2024 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="jPK73T8A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC320DD3
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710714374; cv=none; b=Tj8MHPhzgcUqw7vKjLOHDFK4uIlS2MSxIt1uot4mjYYOtzDwyc7/1p45FKmwyglRraOPyPNDU7kOR47ylXeNNrMepvRhsTA12nsn6wEpB0DrZxa0e17stJbEVAhMZNSwAJ1jy7ZrneZd4ftQVEo7jxzakbIHRVPPtdjNqNRv6rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710714374; c=relaxed/simple;
	bh=2ILFQFummNtUIGUFunnD5bIkIyw4o7vvK3MhZizkHzE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=icCnOuhCR2lnT2+6hLwLhfDQAufEjvf/zAWjhL+gkRRdGtzc92yf9tHLfYtcgBC8cSBJ5Lvj7HQlWFS/XPME4B7cVoaVGTxmkAkRRQFxekU8lW8/V3QjQtSLYCaPQiqBU30DkUgu0MmMpY+Z7swifjzH7Prk7NuUao8muCtqEo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=jPK73T8A; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:1d83:0:640:2ab:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 82A8B60B9E;
	Mon, 18 Mar 2024 01:20:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 4K2gmq0qBSw0-GmY21k2O;
	Mon, 18 Mar 2024 01:20:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1710714005; bh=iQUT6P1P0gpp7wdVJjA3v3Kvvy6aD/2Si3PucnB9LZI=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=jPK73T8AcbNCHQAZDYbGCYKBZlM8w3BosA/60jOsFyGXu1wqiFdnt4HpGGRetnQc7
	 6ytHWdIYdW14WV5KLcojdp16T5GxCA3KSdSXm/5t0Kc2EkSszAzg+weTr+/KJESb9n
	 KQWugDRU3WnuBZd1N8oGArZFJlq0jPGOZyxCuOJA=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Ivan Trofimov <i.trofimow@yandex.ru>
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC] eventpoll: optimize epoll_ctl by reusing eppoll_entry allocations
Date: Mon, 18 Mar 2024 01:20:04 +0300
Message-Id: <20240317222004.76084-1-i.trofimow@yandex.ru>
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
per-epoll-instance memory cost, which amounts to 72 bytes for 64-bit.

Signed-off-by: Ivan Trofimov <i.trofimow@yandex.ru>
---
This is my first ever attempt at submiting a patch for the kernel,
so please don't hesitate to point out mistakes I'm doing in the process.

 fs/eventpoll.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 882b89edc..c4094124c 100644
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
+ * This functions either consumes the pwq_slot, or allocates a new
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
 
@@ -1384,7 +1419,7 @@ static void ep_ptable_queue_proc(struct file *file, wait_queue_head_t *whead,
 	if (unlikely(!epi))	// an earlier allocation has failed
 		return;
 
-	pwq = kmem_cache_alloc(pwq_cache, GFP_KERNEL);
+	pwq = ep_alloc_pwq(epi->ep);
 	if (unlikely(!pwq)) {
 		epq->epi = NULL;
 		return;
-- 
2.34.1


