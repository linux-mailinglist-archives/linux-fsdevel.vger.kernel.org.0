Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867FB292DDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 20:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgJSS7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 14:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbgJSS7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 14:59:20 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA90C0613CE;
        Mon, 19 Oct 2020 11:59:20 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k25so963482ioh.7;
        Mon, 19 Oct 2020 11:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5x9XsX6bugHbxc6Lf+avQGPGc1m0dcjvoBpjbAMIo0=;
        b=J2k3/AFXZl88bLHwbndRa5qLGvTl9eV5G+onfb/NjzBxv+GhMoCIcKm+CTtTYIlpu2
         TQp019+opsp2xWLV0Z3JEq7VDL+nP2loWSf/2Y3ONeKyQRiQ+sZHlNTwhg+kX3w3rR9+
         ftO3qDRlxFFYgiyyMW+iJy3ks5Ihn8M4xN6/z9uEEKsoJbJU+odf8xD4ygyVEL93uxFY
         QTxMXyuW1x/GpegzVZXV65szFdtlpXZXqzdbAUl/PjzIQz8F7VS/V011AgvHPHFGlOXA
         11EhfSTFH4WKm8/kEYeRmIfwYsCAoHEhuw1Moy45GWXU5+1mHf/zHTuTXDfQhuqnfEFX
         Hjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M5x9XsX6bugHbxc6Lf+avQGPGc1m0dcjvoBpjbAMIo0=;
        b=DtTk71B4HRCrYHtkN9MiyuEmBZN6b/UaXLUhlEJem0U0ZtLkzf3lTJonxEYUPnzSs+
         gx6cneTffSQX7B+SWUzeGzvagUky7guFxeqS9unalOGOmO+G8/u/nYHShwiH9cKU7ImY
         BCQL3RhgOH57qO+EY1DYczpke2SnViKJhDFmJCfjwKqKv2B68tmz9QmxkSRdICr50/1C
         QwiAAyWthNiDgMSyQkNCY5/LBNs29qLAMdk+Y1GBhQ0pbylEPNjz1AmcTcv3qzCtO+Cx
         92XXXenbyuKs6q0lp0D7nCq+kwno4d+sHMvemBFPItMgEreLDYDQ+eqIyTXpOvvSXUDO
         /INA==
X-Gm-Message-State: AOAM533zb6tb4OcmFGNFNtgIwQpv6pu+jq95H8+BVD+lCNGT/sjODDSV
        wGD5W1hOliAFOVBm8AZFB726BhIIcQ==
X-Google-Smtp-Source: ABdhPJyjwsYgkDUBJ3+EJ0I645+jH5uXhu+jpv8syVAUp/5dSz7B8F1W145DwBNmCjCI453wHONG0g==
X-Received: by 2002:a05:6602:1306:: with SMTP id h6mr738846iov.160.1603133959141;
        Mon, 19 Oct 2020 11:59:19 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id t12sm538770ilh.18.2020.10.19.11.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 11:59:18 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, sfrench@samba.org,
        linux-cifs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 1/2] cifs: convert to add_to_page_cache()
Date:   Mon, 19 Oct 2020 14:59:10 -0400
Message-Id: <20201019185911.2909471-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is just open coding add_to_page_cache(), and the next patch will
delete add_to_page_cache_locked().

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 fs/cifs/file.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index be46fab4c9..a17a21181e 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4296,20 +4296,12 @@ readpages_get_pages(struct address_space *mapping, struct list_head *page_list,
 
 	page = lru_to_page(page_list);
 
-	/*
-	 * Lock the page and put it in the cache. Since no one else
-	 * should have access to this page, we're safe to simply set
-	 * PG_locked without checking it first.
-	 */
-	__SetPageLocked(page);
-	rc = add_to_page_cache_locked(page, mapping,
-				      page->index, gfp);
+	rc = add_to_page_cache(page, mapping,
+			       page->index, gfp);
 
 	/* give up if we can't stick it in the cache */
-	if (rc) {
-		__ClearPageLocked(page);
+	if (rc)
 		return rc;
-	}
 
 	/* move first page to the tmplist */
 	*offset = (loff_t)page->index << PAGE_SHIFT;
@@ -4328,12 +4320,9 @@ readpages_get_pages(struct address_space *mapping, struct list_head *page_list,
 		if (*bytes + PAGE_SIZE > rsize)
 			break;
 
-		__SetPageLocked(page);
-		rc = add_to_page_cache_locked(page, mapping, page->index, gfp);
-		if (rc) {
-			__ClearPageLocked(page);
+		rc = add_to_page_cache(page, mapping, page->index, gfp);
+		if (rc)
 			break;
-		}
 		list_move_tail(&page->lru, tmplist);
 		(*bytes) += PAGE_SIZE;
 		expected_index++;
-- 
2.28.0

