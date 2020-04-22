Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91DF1B482A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDVPFn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:05:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:58096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728055AbgDVPDH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 59AF3AD26;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7313E1E0E83; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 07/23] xarray: Switch __xa_cmpxchg() to use xas_store_noinit()
Date:   Wed, 22 Apr 2020 17:02:40 +0200
Message-Id: <20200422150256.23473-8-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently there are four places that end up calling into __xa_cmpxchg().
Two in drivers/infiniband/hw/mlx5/odp.c, one in fs/erofs/utils.c and one
in mm/shmem.c. The xarray in the first three places do not contain any
marks ever, the fourth place originally used radix_tree_delete_item()
which didn't touch marks either. So we are safe to switch __xa_cmpxchg()
to use xas_store_noinit(). Also document that __xa_cmpxchg() now does
not touch marks at all - i.e., it has ordinary store semantics without
specialcasing NULL value. If someone ever needs xa_cmpxchg() equivalent
that would really cause mark clearing on storing NULL, we can create
xa_erase_item() function.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/xarray.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index a372c59e3914..d87045d120ad 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1460,7 +1460,8 @@ EXPORT_SYMBOL(xa_store);
  *
  * You must already be holding the xa_lock when calling this function.
  * It will drop the lock if needed to allocate memory, and then reacquire
- * it afterwards.
+ * it afterwards. The call does not change any xarray marks except for
+ * XA_FREE_MARK if free tracking is enabled.
  *
  * Context: Any context.  Expects xa_lock to be held on entry.  May
  * release and reacquire xa_lock if @gfp flags permit.
@@ -1478,7 +1479,7 @@ void *__xa_cmpxchg(struct xarray *xa, unsigned long index,
 	do {
 		curr = xas_load(&xas);
 		if (curr == old) {
-			xas_store(&xas, entry);
+			xas_store_noinit(&xas, entry);
 			if (xa_track_free(xa)) {
 				if (entry && !curr)
 					xas_clear_mark(&xas, XA_FREE_MARK);
-- 
2.16.4

