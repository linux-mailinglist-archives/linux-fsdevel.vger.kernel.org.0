Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAFFB151C1C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 15:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgBDOZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 09:25:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:49672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbgBDOZU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:25:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 67B2DAF32;
        Tue,  4 Feb 2020 14:25:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0A8ED1E0D14; Tue,  4 Feb 2020 15:25:16 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 7/8] mm: Use xas_erase() in collapse_file()
Date:   Tue,  4 Feb 2020 15:25:13 +0100
Message-Id: <20200204142514.15826-8-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204142514.15826-1-jack@suse.cz>
References: <20200204142514.15826-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When undoing failed collapse of ordinary pages into a huge page, use
xas_erase() to explicitly clear any xarray marks that may have been
added to entries.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b679908743cb..13e061581cd0 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1800,7 +1800,7 @@ static void collapse_file(struct mm_struct *mm,
 					break;
 				nr_none--;
 				/* Put holes back where they were */
-				xas_store(&xas, NULL);
+				xas_erase(&xas);
 				continue;
 			}
 
-- 
2.16.4

