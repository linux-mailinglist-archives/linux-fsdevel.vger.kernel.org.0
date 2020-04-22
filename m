Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A0A1B4821
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgDVPEA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:04:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:58114 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbgDVPDH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5EB3FADEB;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 928911E0E6E; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 14/23] workingset: Use xas_store_noinit() to clear shadow entry
Date:   Wed, 22 Apr 2020 17:02:47 +0200
Message-Id: <20200422150256.23473-15-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shadow entries have no marks. Use xas_store_noinit() to clear the entry
so avoid unneeded initialization of the xarray marks. This provides a
nice boost to truncate numbers. Sample benchmark showing time to
truncate 128 files 1GB each on machine with 64GB of RAM (so about half
of entries are shadow entries):

         AVG      STDDEV
Vanilla  4.825s   0.036
Patched  4.516s   0.014

So we can see about 6% reduction in overall truncate time.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/truncate.c   | 2 +-
 mm/workingset.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index dd9ebc1da356..baef636564cc 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -39,7 +39,7 @@ static inline void __clear_shadow_entry(struct address_space *mapping,
 	xas_set_update(&xas, workingset_update_node);
 	if (xas_load(&xas) != entry)
 		return;
-	xas_store(&xas, NULL);
+	xas_store_noinit(&xas, NULL);
 	mapping->nrexceptional--;
 }
 
diff --git a/mm/workingset.c b/mm/workingset.c
index 474186b76ced..6a492140057f 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -537,7 +537,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	 * We could store a shadow entry here which was the minimum of the
 	 * shadow entries we were tracking ...
 	 */
-	xas_store(&xas, NULL);
+	xas_store_noinit(&xas, NULL);
 	__inc_lruvec_slab_state(node, WORKINGSET_NODERECLAIM);
 
 out_invalid:
-- 
2.16.4

