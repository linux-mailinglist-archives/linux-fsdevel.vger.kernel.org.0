Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73581AF5B8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 00:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgDRWvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 18:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgDRWvd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:51:33 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC368C061A41
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 15:51:32 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id j20so4381300edj.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 15:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LJG/tvH74vPoZBWRmNdYjJBmTLQ93YDBV04Re8a/V+U=;
        b=KFN2BQBgovkjPW//Nj/G8X+du1tRzLXj3PCGFEzq/F5Zsi2k2lzaSPr7Eim84Z00wY
         o4Zc/B9YK556Iq9QhV8vk+JD5GbiG6musD/+6BRa8VHL62dCSI+QUoXisnlz9uIMXMHL
         yiWinSld4vUf9bOMhpCaheaghCuxM9BftbPgd0nAKIvsEAeug2B3rCDtofQvM3+nkGhF
         oSqB6MiYRP+75flGNSdr2NK6HCegAL+XJ75G/Fjv0QjR27pJNR+BcYg+UX/UXM10NTYj
         Zc+MD8TwBw0tfPOef1OUjuzMoceCf6+juHrK0ycAyga1RwV58qs7ET/d/p2X775r6S30
         IXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LJG/tvH74vPoZBWRmNdYjJBmTLQ93YDBV04Re8a/V+U=;
        b=KQzSQK60qdcEFjWzCMClSQawtYKiECM2yT03iCdBtHdWX7YqWkJU/+4FpIojXoYHDR
         1nsXu3FdEjwvUnJSLAZX8GBuwTj1gMITpK4sIQGNrs5RDIUb2xOb+30tTCon90pMVGKA
         r+NeZJBIL+0NVtfUtPe6oUAM0MzT6KS3HL5LuXvkx/ylHMuG6bC7CgKkkwhbBBMvQLhW
         d0g9tOCqrMFcEZwc0XguAWFl0VvGHlGOOthz/sICN/+4x7lLXcpCKZYyr8Sfu/1pHVCx
         Jr1pyIOXeO3HOkVJhXX1Iz8f1SP3mPyajRwTpA/0Z7kR/dRd3AXceI/2sOzVhM8Uscuy
         jdzA==
X-Gm-Message-State: AGi0PuYt9NgDq/SgWESOlkcD3AHOZRQIyKL0cENCF9vRU/G5n9XbZZzP
        Ijf9Z82Qdb0cstvEWFsl2+PLf0537ClN/g==
X-Google-Smtp-Source: APiQypJovF9nvn1Yr9ZkK7hvEAqP4GrPPtpF1BNuB0WcmsdP6W/7lfIf/XIOf4WoWYBYdHzCtr5a9g==
X-Received: by 2002:aa7:d056:: with SMTP id n22mr8533808edo.281.1587250291361;
        Sat, 18 Apr 2020 15:51:31 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:6c58:b8bc:cdc6:2e2d])
        by smtp.gmail.com with ESMTPSA id g21sm2616767ejm.79.2020.04.18.15.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 15:51:30 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Subject: [RFC PATCH 4/5] orangefs: call __clear_page_buffers to simplify code
Date:   Sun, 19 Apr 2020 00:51:22 +0200
Message-Id: <20200418225123.31850-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
References: <20200418225123.31850-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since __clear_page_buffers is exported, we can call __clear_page_buffers
to simplify code in the four places.

Cc: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>
Cc: devel@lists.orangefs.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
The order for set_page_private and ClearPagePrivate is swapped in
__clear_page_buffers, not sure it is identical or not, so this is
RFC.

Thanks,
Guoqing

 fs/orangefs/inode.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 12ae630fbed7..8e1591d8bf24 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/bvec.h>
+#include <linux/buffer_head.h>
 #include "protocol.h"
 #include "orangefs-kernel.h"
 #include "orangefs-bufmap.h"
@@ -64,9 +65,7 @@ static int orangefs_writepage_locked(struct page *page,
 	}
 	if (wr) {
 		kfree(wr);
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		__clear_page_buffers(page);
 	}
 	return ret;
 }
@@ -460,17 +459,13 @@ static void orangefs_invalidatepage(struct page *page,
 
 	if (offset == 0 && length == PAGE_SIZE) {
 		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		__clear_page_buffers(page);
 		return;
 	/* write range entirely within invalidate range (or equal) */
 	} else if (page_offset(page) + offset <= wr->pos &&
 	    wr->pos + wr->len <= page_offset(page) + offset + length) {
 		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		__clear_page_buffers(page);
 		/* XXX is this right? only caller in fs */
 		cancel_dirty_page(page);
 		return;
@@ -537,9 +532,7 @@ static void orangefs_freepage(struct page *page)
 {
 	if (PagePrivate(page)) {
 		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		__clear_page_buffers(page);
 	}
 }
 
-- 
2.17.1

