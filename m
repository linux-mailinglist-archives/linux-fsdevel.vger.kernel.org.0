Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB8B1B4807
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgDVPDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:03:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:57994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgDVPDF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2B435AD9F;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 649C11E0E76; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 04/23] xarray: Switch xa_store_range() to use xas_store_noinit()
Date:   Wed, 22 Apr 2020 17:02:37 +0200
Message-Id: <20200422150256.23473-5-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is only a single user of xa_store_range() and that is
mm/memremap.c which does not use marks at all. Just switch
xa_store_range() to use xas_store_noinit() to avoid implicit (and
unnecessary for all users) initialization of xarray marks.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/xarray.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 2eb634e8bf15..49fafcee1c8e 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1602,7 +1602,7 @@ void *xa_store_range(struct xarray *xa, unsigned long first,
 		}
 		do {
 			xas_set_range(&xas, first, last);
-			xas_store(&xas, entry);
+			xas_store_noinit(&xas, entry);
 			if (xas_error(&xas))
 				goto unlock;
 			first += xas_size(&xas);
-- 
2.16.4

