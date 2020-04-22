Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5A41B481E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgDVPDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:03:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:58108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbgDVPDH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5B6DEADC2;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7CD441E0E89; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 09/23] dax: Use dax_store_noinit() in grab_mapping_entry()
Date:   Wed, 22 Apr 2020 17:02:42 +0200
Message-Id: <20200422150256.23473-10-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Although we store NULL here, there aren't any marks set on the entry
so use xas_store_noinit() to save some time when trying to reinitialize
marks. Furthermore we actually overwrite the entry shortly afterwards
with new PTE entry anyway.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/dax.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index f8358928549c..03c6ca693f3c 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -523,7 +523,11 @@ static void *grab_mapping_entry(struct xa_state *xas,
 		}
 
 		dax_disassociate_entry(entry, mapping, false);
-		xas_store(xas, NULL);	/* undo the PMD join */
+		/*
+		 * Remove PMD entry. There should be no marks set for the entry
+ 		 * so don't bother reinitializing them with xas_erase().
+		 */
+		xas_store_noinit(xas, NULL);
 		dax_wake_entry(xas, entry, true);
 		mapping->nrexceptional--;
 		entry = NULL;
-- 
2.16.4

