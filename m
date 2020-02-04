Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F34AE151C20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 15:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgBDOZX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 09:25:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:49688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbgBDOZV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:25:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7ECF5B035;
        Tue,  4 Feb 2020 14:25:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EBCCA1E0CF7; Tue,  4 Feb 2020 15:25:15 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 3/8] xarray: Explicitely set XA_FREE_MARK in __xa_cmpxchg()
Date:   Tue,  4 Feb 2020 15:25:09 +0100
Message-Id: <20200204142514.15826-4-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204142514.15826-1-jack@suse.cz>
References: <20200204142514.15826-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__xa_cmpxchg() relies on xas_store() to set XA_FREE_MARK when storing
NULL into xarray that has free tracking enabled. Make the setting of
XA_FREE_MARK explicit similarly as its clearing currently it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/xarray.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index ae8b7070e82c..4e32497c51bd 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1477,8 +1477,12 @@ void *__xa_cmpxchg(struct xarray *xa, unsigned long index,
 		curr = xas_load(&xas);
 		if (curr == old) {
 			xas_store(&xas, entry);
-			if (xa_track_free(xa) && entry && !curr)
-				xas_clear_mark(&xas, XA_FREE_MARK);
+			if (xa_track_free(xa)) {
+				if (entry && !curr)
+					xas_clear_mark(&xas, XA_FREE_MARK);
+				else if (!entry && curr)
+					xas_set_mark(&xas, XA_FREE_MARK);
+			}
 		}
 	} while (__xas_nomem(&xas, gfp));
 
-- 
2.16.4

