Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68D31B4819
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgDVPDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:03:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:58120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbgDVPDJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8DA0FAE83;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B4E661E0E86; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 22/23] testing: Switch xa_store_order() to xas_store_noinit()
Date:   Wed, 22 Apr 2020 17:02:55 +0200
Message-Id: <20200422150256.23473-23-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

xa_store_order() is currently only used for non-NULL entries. So
xas_store_noinit() is equivalent to xas_store() and we can safely use it
in xa_store_order.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/test_xarray.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index fc16eac1cbb9..3adc29819b0d 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -76,7 +76,7 @@ static void *xa_store_order(struct xarray *xa, unsigned long index,
 
 	do {
 		xas_lock(&xas);
-		curr = xas_store(&xas, entry);
+		curr = xas_store_noinit(&xas, entry);
 		xas_unlock(&xas);
 	} while (xas_nomem(&xas, gfp));
 
-- 
2.16.4

