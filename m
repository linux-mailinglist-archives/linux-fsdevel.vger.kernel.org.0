Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754B61B4834
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgDVPDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:03:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:57966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgDVPDF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 159F4AC4D;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 592C41E0B00; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 01/23] xarray: Remove stale comment
Date:   Wed, 22 Apr 2020 17:02:34 +0200
Message-Id: <20200422150256.23473-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit 7e934cf5ace1 "xarray: Fix early termination of
xas_for_each_marked" the comment is no longer relevant since
xas_for_each_marked() can cope with marked NULL entries. Remove the
comment.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/xarray.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index e9e641d3c0c3..dae68dd13a02 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -803,13 +803,6 @@ void *xas_store(struct xa_state *xas, void *entry)
 		xas_init_marks(xas);
 
 	for (;;) {
-		/*
-		 * Must clear the marks before setting the entry to NULL,
-		 * otherwise xas_for_each_marked may find a NULL entry and
-		 * stop early.  rcu_assign_pointer contains a release barrier
-		 * so the mark clearing will appear to happen before the
-		 * entry is set to NULL.
-		 */
 		rcu_assign_pointer(*slot, entry);
 		if (xa_is_node(next) && (!node || node->shift))
 			xas_free_nodes(xas, xa_to_node(next));
-- 
2.16.4

