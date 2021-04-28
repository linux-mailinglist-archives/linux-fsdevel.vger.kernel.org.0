Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC44536DD7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 18:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241292AbhD1Qvs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 12:51:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240477AbhD1Qvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619628661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TVg4TK3ftOVnWUIDPLvRsoA0GP0bFUZQWBEdvpHV2VI=;
        b=A4TMFfGG1Wkfxo+JsG9qd+aQAUeguzv1n49qW2uvNVpcszv1Br5gJNvRFFOQN1jmXXm1jP
        WInV585U0kF/X4UqeHqqYlnWzsrlmBw3Wc2YgNuYwSg5QevarhIUAtTLcgQlv3Zg33F5nY
        6MTf/HiiMf90fM9aTvoGf28C0yJch4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-Ioxs4MaVNfOj94iVShIaHQ-1; Wed, 28 Apr 2021 12:50:57 -0400
X-MC-Unique: Ioxs4MaVNfOj94iVShIaHQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 611DF1006CAA;
        Wed, 28 Apr 2021 16:50:50 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-128.rdu2.redhat.com [10.10.116.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C09C710027A5;
        Wed, 28 Apr 2021 16:50:49 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 558DF223D99; Wed, 28 Apr 2021 12:50:49 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com,
        dan.j.williams@intel.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, jack@suse.cz,
        willy@infradead.org, slp@redhat.com, Greg Kurz <groug@kaod.org>
Subject: [PATCH v5 1/3] dax: Add an enum for specifying dax wakup mode
Date:   Wed, 28 Apr 2021 12:50:38 -0400
Message-Id: <20210428165040.1856202-2-vgoyal@redhat.com>
In-Reply-To: <20210428165040.1856202-1-vgoyal@redhat.com>
References: <20210428165040.1856202-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan mentioned that he is not very fond of passing around a boolean true/false
to specify if only next waiter should be woken up or all waiters should be
woken up. He instead prefers that we introduce an enum and make it very
explicity at the callsite itself. Easier to read code.

This patch should not introduce any change of behavior.

Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index b3d27fdc6775..c8cd2ae4440b 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -144,6 +144,16 @@ struct wait_exceptional_entry_queue {
 	struct exceptional_entry_key key;
 };
 
+/**
+ * enum dax_wake_mode: waitqueue wakeup behaviour
+ * @WAKE_NEXT: wake only the first waiter in the waitqueue
+ * @WAKE_ALL: wake all waiters in the waitqueue
+ */
+enum dax_wake_mode {
+	WAKE_ALL,
+	WAKE_NEXT,
+};
+
 static wait_queue_head_t *dax_entry_waitqueue(struct xa_state *xas,
 		void *entry, struct exceptional_entry_key *key)
 {
@@ -182,7 +192,8 @@ static int wake_exceptional_entry_func(wait_queue_entry_t *wait,
  * The important information it's conveying is whether the entry at
  * this index used to be a PMD entry.
  */
-static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
+static void dax_wake_entry(struct xa_state *xas, void *entry,
+			   enum dax_wake_mode mode)
 {
 	struct exceptional_entry_key key;
 	wait_queue_head_t *wq;
@@ -196,7 +207,7 @@ static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
 	 * must be in the waitqueue and the following check will see them.
 	 */
 	if (waitqueue_active(wq))
-		__wake_up(wq, TASK_NORMAL, wake_all ? 0 : 1, &key);
+		__wake_up(wq, TASK_NORMAL, mode == WAKE_ALL ? 0 : 1, &key);
 }
 
 /*
@@ -268,7 +279,7 @@ static void put_unlocked_entry(struct xa_state *xas, void *entry)
 {
 	/* If we were the only waiter woken, wake the next one */
 	if (entry && !dax_is_conflict(entry))
-		dax_wake_entry(xas, entry, false);
+		dax_wake_entry(xas, entry, WAKE_NEXT);
 }
 
 /*
@@ -286,7 +297,7 @@ static void dax_unlock_entry(struct xa_state *xas, void *entry)
 	old = xas_store(xas, entry);
 	xas_unlock_irq(xas);
 	BUG_ON(!dax_is_locked(old));
-	dax_wake_entry(xas, entry, false);
+	dax_wake_entry(xas, entry, WAKE_NEXT);
 }
 
 /*
@@ -524,7 +535,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 
 		dax_disassociate_entry(entry, mapping, false);
 		xas_store(xas, NULL);	/* undo the PMD join */
-		dax_wake_entry(xas, entry, true);
+		dax_wake_entry(xas, entry, WAKE_ALL);
 		mapping->nrexceptional--;
 		entry = NULL;
 		xas_set(xas, index);
@@ -937,7 +948,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	xas_lock_irq(xas);
 	xas_store(xas, entry);
 	xas_clear_mark(xas, PAGECACHE_TAG_DIRTY);
-	dax_wake_entry(xas, entry, false);
+	dax_wake_entry(xas, entry, WAKE_NEXT);
 
 	trace_dax_writeback_one(mapping->host, index, count);
 	return ret;
-- 
2.25.4

