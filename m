Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3E83973DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 09:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfHUHuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 03:50:04 -0400
Received: from mail.ispras.ru ([83.149.199.45]:50720 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfHUHuE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 03:50:04 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Aug 2019 03:50:03 EDT
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru [188.32.48.208])
        by mail.ispras.ru (Postfix) with ESMTPSA id 1679B540081;
        Wed, 21 Aug 2019 10:42:23 +0300 (MSK)
From:   Denis Efremov <efremov@ispras.ru>
To:     akpm@linux-foundation.org
Cc:     Denis Efremov <efremov@ispras.ru>,
        Akinobu Mita <akinobu.mita@gmail.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-media@vger.kernel.org, Erdem Tumurov <erdemus@gmail.com>,
        Vladimir Shelekhov <vshel@iis.nsk.su>
Subject: [PATCH] lib/memweight.c: optimize by inlining bitmap_weight()
Date:   Wed, 21 Aug 2019 10:42:00 +0300
Message-Id: <20190821074200.2203-1-efremov@ispras.ru>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch inlines bitmap_weight() call. Thus, removing the BUG_ON,
and 'longs to bits -> bits to longs' conversion by directly calling
hweight_long().

./scripts/bloat-o-meter lib/memweight.o.old lib/memweight.o.new
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-10 (-10)
Function                                     old     new   delta
memweight                                    162     152     -10

Co-developed-by: Erdem Tumurov <erdemus@gmail.com>
Co-developed-by: Vladimir Shelekhov <vshel@iis.nsk.su>
Signed-off-by: Erdem Tumurov <erdemus@gmail.com>
Signed-off-by: Vladimir Shelekhov <vshel@iis.nsk.su>
Signed-off-by: Denis Efremov <efremov@ispras.ru>
---
 lib/memweight.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/memweight.c b/lib/memweight.c
index 94dd72ccaa7f..f050b2b4c5e2 100644
--- a/lib/memweight.c
+++ b/lib/memweight.c
@@ -20,11 +20,13 @@ size_t memweight(const void *ptr, size_t bytes)
 
 	longs = bytes / sizeof(long);
 	if (longs) {
-		BUG_ON(longs >= INT_MAX / BITS_PER_LONG);
-		ret += bitmap_weight((unsigned long *)bitmap,
-				longs * BITS_PER_LONG);
+		const unsigned long *bitmap_long =
+			(const unsigned long *)bitmap;
+
 		bytes -= longs * sizeof(long);
-		bitmap += longs * sizeof(long);
+		for (; longs > 0; longs--, bitmap_long++)
+			ret += hweight_long(*bitmap_long);
+		bitmap = (const unsigned char *)bitmap_long;
 	}
 	/*
 	 * The reason that this last loop is distinct from the preceding
-- 
2.21.0

