Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B45F9BCE8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2019 12:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfHXKBT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Aug 2019 06:01:19 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51218 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfHXKBT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Aug 2019 06:01:19 -0400
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru [188.32.48.208])
        by mail.ispras.ru (Postfix) with ESMTPSA id 2678854006A;
        Sat, 24 Aug 2019 13:01:16 +0300 (MSK)
From:   Denis Efremov <efremov@ispras.ru>
To:     akpm@linux-foundation.org
Cc:     Denis Efremov <efremov@ispras.ru>,
        Akinobu Mita <akinobu.mita@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
        dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-media@vger.kernel.org, Erdem Tumurov <erdemus@gmail.com>,
        Vladimir Shelekhov <vshel@iis.nsk.su>
Subject: [PATCH v2] lib/memweight.c: open codes bitmap_weight()
Date:   Sat, 24 Aug 2019 13:01:02 +0300
Message-Id: <20190824100102.1167-1-efremov@ispras.ru>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821074200.2203-1-efremov@ispras.ru>
References: <20190821074200.2203-1-efremov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch open codes the bitmap_weight() call. The direct
invocation of hweight_long() allows to remove the BUG_ON and
excessive "longs to bits, bits to longs" conversion.

BUG_ON was required to check that bitmap_weight() will return
a correct value, i.e. the computed weight will fit the int type
of the return value. With this patch memweight() controls the
computation directly with size_t type everywhere. Thus, the BUG_ON
becomes unnecessary.

Total size reduced:
./scripts/bloat-o-meter lib/memweight.o.old lib/memweight.o.new
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-10 (-10)
Function                                     old     new   delta
memweight                                    162     152     -10

Co-developed-by: Erdem Tumurov <erdemus@gmail.com>
Signed-off-by: Erdem Tumurov <erdemus@gmail.com>
Co-developed-by: Vladimir Shelekhov <vshel@iis.nsk.su>
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

