Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F161B4825
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgDVPD7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:03:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:58130 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728099AbgDVPDI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6237AAE18;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 810F81E0E8B; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 10/23] dax: Convert xas_store() to xas_store_noinit()
Date:   Wed, 22 Apr 2020 17:02:43 +0200
Message-Id: <20200422150256.23473-11-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All remaining users of xas_store() store non-NULL entries so xas_store()
and xas_store_noinit() are equivalent. Replace xas_store() with
xas_store_noinit().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/dax.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 03c6ca693f3c..1c905830ee10 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -283,7 +283,7 @@ static void dax_unlock_entry(struct xa_state *xas, void *entry)
 	BUG_ON(dax_is_locked(entry));
 	xas_reset(xas);
 	xas_lock_irq(xas);
-	old = xas_store(xas, entry);
+	old = xas_store_noinit(xas, entry);
 	xas_unlock_irq(xas);
 	BUG_ON(!dax_is_locked(old));
 	dax_wake_entry(xas, entry, false);
@@ -295,7 +295,7 @@ static void dax_unlock_entry(struct xa_state *xas, void *entry)
 static void *dax_lock_entry(struct xa_state *xas, void *entry)
 {
 	unsigned long v = xa_to_value(entry);
-	return xas_store(xas, xa_mk_value(v | DAX_LOCKED));
+	return xas_store_noinit(xas, xa_mk_value(v | DAX_LOCKED));
 }
 
 static unsigned long dax_entry_size(void *entry)
@@ -923,7 +923,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 	 */
 	xas_reset(xas);
 	xas_lock_irq(xas);
-	xas_store(xas, entry);
+	xas_store_noinit(xas, entry);
 	xas_clear_mark(xas, PAGECACHE_TAG_DIRTY);
 	dax_wake_entry(xas, entry, false);
 
-- 
2.16.4

