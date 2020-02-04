Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDC3D151C1B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 15:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBDOZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 09:25:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:49650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727261AbgBDOZT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:25:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 18C1CAEEC;
        Tue,  4 Feb 2020 14:25:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 060921E0D13; Tue,  4 Feb 2020 15:25:16 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 6/8] idr: Use xas_erase() in ida_destroy()
Date:   Tue,  4 Feb 2020 15:25:12 +0100
Message-Id: <20200204142514.15826-7-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200204142514.15826-1-jack@suse.cz>
References: <20200204142514.15826-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Explicitely clear marks (and set XA_MARK_FREE) in ida_destroy() by
calling xas_erase() instead of relying on xas_store() on implicitely
doing this.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/idr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/idr.c b/lib/idr.c
index c2cf2c52bbde..fd4877fef06d 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -543,7 +543,7 @@ void ida_destroy(struct ida *ida)
 	xas_for_each(&xas, bitmap, ULONG_MAX) {
 		if (!xa_is_value(bitmap))
 			kfree(bitmap);
-		xas_store(&xas, NULL);
+		xas_erase(&xas);
 	}
 	xas_unlock_irqrestore(&xas, flags);
 }
-- 
2.16.4

