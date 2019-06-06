Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2718536F8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 11:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfFFJKf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 05:10:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:40448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727450AbfFFJKf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:10:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E298CAF90;
        Thu,  6 Jun 2019 09:10:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 564401E3F51; Thu,  6 Jun 2019 11:10:33 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        <linux-fsdevel@vger.kernel.org>, linux-nvdimm@lists.01.org,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] dax: Fix xarray entry association for mixed mappings
Date:   Thu,  6 Jun 2019 11:10:28 +0200
Message-Id: <20190606091028.31715-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When inserting entry into xarray, we store mapping and index in
corresponding struct pages for memory error handling. When it happened
that one process was mapping file at PMD granularity while another
process at PTE granularity, we could wrongly deassociate PMD range and
then reassociate PTE range leaving the rest of struct pages in PMD range
without mapping information which could later cause missed notifications
about memory errors. Fix the problem by calling the association /
deassociation code if and only if we are really going to update the
xarray (deassociating and associating zero or empty entries is just
no-op so there's no reason to complicate the code with trying to avoid
the calls for these cases).

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/dax.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index f74386293632..9fd908f3df32 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -728,12 +728,11 @@ static void *dax_insert_entry(struct xa_state *xas,
 
 	xas_reset(xas);
 	xas_lock_irq(xas);
-	if (dax_entry_size(entry) != dax_entry_size(new_entry)) {
+	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
+		void *old;
+
 		dax_disassociate_entry(entry, mapping, false);
 		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
-	}
-
-	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
@@ -742,7 +741,7 @@ static void *dax_insert_entry(struct xa_state *xas,
 		 * existing entry is a PMD, we will just leave the PMD in the
 		 * tree and dirty it if necessary.
 		 */
-		void *old = dax_lock_entry(xas, new_entry);
+		old = dax_lock_entry(xas, new_entry);
 		WARN_ON_ONCE(old != xa_mk_value(xa_to_value(entry) |
 					DAX_LOCKED));
 		entry = new_entry;
-- 
2.16.4

