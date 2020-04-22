Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3761B4829
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDVPFn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:05:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:58120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbgDVPDH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 65CADAE3C;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9F4C51E0EAA; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 17/23] idr: Use xas_erase() in ida_free()
Date:   Wed, 22 Apr 2020 17:02:50 +0200
Message-Id: <20200422150256.23473-18-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Explicitely clear marks in ida_free() by calling xas_erase() instead of
relying on xas_store() on implicitely doing this.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/idr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/idr.c b/lib/idr.c
index fd4877fef06d..4ee06bc7208a 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -511,7 +511,7 @@ void ida_free(struct ida *ida, unsigned int id)
 		if (bitmap_empty(bitmap->bitmap, IDA_BITMAP_BITS)) {
 			kfree(bitmap);
 delete:
-			xas_store(&xas, NULL);
+			xas_erase(&xas);
 		}
 	}
 	xas_unlock_irqrestore(&xas, flags);
-- 
2.16.4

