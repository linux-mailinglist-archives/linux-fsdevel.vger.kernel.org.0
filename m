Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E905FD60D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Oct 2022 10:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJMIRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 04:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJMIRE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A9411B2F5
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 01:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665649022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Lf0JkneyybStbrpIpXreEjdN4fAGJkBzK5ez6xp2EoU=;
        b=iIWKNR/E37qR28iwv2qEBT6rND46NF75007gPBvKVVc9lQx0VPaF0sdv1fm03V0BujdQlb
        z/FHs1t8xCVfpcIhjz4+46Rqr7UqoYf5uCxG+KPQnaV/MGLksg5thU8J70QPA6bUTz70mm
        OfNonoWt+4BMWr/7qwt5mi8K06e0LHE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-140-N37uKCYcNjaxz-U5BrB_-A-1; Thu, 13 Oct 2022 04:17:01 -0400
X-MC-Unique: N37uKCYcNjaxz-U5BrB_-A-1
Received: by mail-wm1-f72.google.com with SMTP id k38-20020a05600c1ca600b003b49a809168so2497125wms.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Oct 2022 01:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lf0JkneyybStbrpIpXreEjdN4fAGJkBzK5ez6xp2EoU=;
        b=VBrCO2H1QRbTXGHukNZ0Fd5wcYzmm3/tYUa8xUnTF1G5+kZbVfTXiNNRi3sLwCOybL
         DmX9uA4dOGZilCCrqNSe5rOUi0WE/NjOlbSN2Ozl4bWgNL9xieiOUrXGJ2AT/tJCEk4M
         oeQX41I8CR7YZrkjIak6QbxzXpDe/ZYUSwLWay9A2Q0CEV3Sp2NirBdAicXAZV30JvBR
         9SCnd3bJ4GDOecinDWfUx11ThU+wHl3cywopV79FDd9WAwv7gj4wzcHR7y3Svs7WD/rs
         nPMSXSSDIhJV7fvkJnXUhy1SirnLt9J8PflR2KjMp2v7nZYty6DI5dbqHvB4AVWhZgWb
         8Ylw==
X-Gm-Message-State: ACrzQf2VZCEXvwI3iikiUvEbv55PnCKx8Q3y1aQLXY/7aeRzs+hT1lOb
        CkGB+dIP43mZmgjbRw2jrsh/pLfp/DB2xK28ln4Y25mXl2ItZTAA6rBPGgIe6Bpri5D8NNo0s1S
        VtZ7SEAsZPvJWh37G9g0iPGlo6vBOp90SQppeFeu0qifI0mNVkdX78+k6IjphajFw+AdUKUTxHw
        2BpA==
X-Received: by 2002:adf:fa10:0:b0:22e:4b8d:81f8 with SMTP id m16-20020adffa10000000b0022e4b8d81f8mr20530403wrr.135.1665649019603;
        Thu, 13 Oct 2022 01:16:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM59JI6VrIb4OVOkj2/utVMiRSOusJQJ4CaWQA1oVpgQSWETLeIenlpVHbWOL5HCzy8MIgMPQQ==
X-Received: by 2002:adf:fa10:0:b0:22e:4b8d:81f8 with SMTP id m16-20020adffa10000000b0022e4b8d81f8mr20530382wrr.135.1665649019214;
        Thu, 13 Oct 2022 01:16:59 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (91-82-183-196.pool.digikabel.hu. [91.82.183.196])
        by smtp.gmail.com with ESMTPSA id bj20-20020a0560001e1400b00228d7078c4esm1510820wrb.4.2022.10.13.01.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 01:16:58 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Cc:     Frank Sorenson <fsorenso@redhat.com>
Subject: [PATCH] fuse: fix readdir cache race
Date:   Thu, 13 Oct 2022 10:16:57 +0200
Message-Id: <20221013081657.3508759-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's a race in fuse's readdir cache that can result in an uninitilized
page being read.  The page lock is supposed to prevent this from happening
but in the following case it doesn't:

Two fuse_add_dirent_to_cache() start out and get the same parameters
(size=0,offset=0).  One of them wins the race to create and lock the page,
after which it fills in data, sets rdc.size and unlocks the page.

In the meantime the page gets evicted from the cache before the other
instance gets to run.  So that one also creates the page, but finds the
size to be mismatched, bails out and leaves the uninitialized page in the
cache.

Fix by making sure that this spurious creation gets undone, so that
the cache always contains valid data (while the page lock is held).  The
__GFP_ZERO is to differentiate this from the case when the page wasn't
evicted between the racing additions, as well as a nice cleanup.

Reported-by: Frank Sorenson <fsorenso@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
Willy,

delete_from_page_cache() exporting was just removed, and seems like it's
deprecated in favor of the folio functions.  Should this code use the folio
one and export that?  Is the code even correct to begin with?

Thanks,
Miklos

fs/fuse/readdir.c | 18 ++++++++++--------
 mm/folio-compat.c |  1 +
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index b4e565711045..4284e28be2e8 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -65,25 +65,27 @@ static void fuse_add_dirent_to_cache(struct file *file,
 		page = find_lock_page(file->f_mapping, index);
 	} else {
 		page = find_or_create_page(file->f_mapping, index,
-					   mapping_gfp_mask(file->f_mapping));
+				mapping_gfp_mask(file->f_mapping) | __GFP_ZERO);
 	}
 	if (!page)
 		return;
 
 	spin_lock(&fi->rdc.lock);
+	addr = kmap_local_page(page);
 	/* Raced with another readdir */
 	if (fi->rdc.version != version || fi->rdc.size != size ||
-	    WARN_ON(fi->rdc.pos != pos))
-		goto unlock;
+	    WARN_ON(fi->rdc.pos != pos)) {
+		/* Was this page just created? */
+		if (!offset && !((struct fuse_dirent *) addr)->namelen)
+			delete_from_page_cache(page);
+		goto unmap;
+	}
 
-	addr = kmap_local_page(page);
-	if (!offset)
-		clear_page(addr);
 	memcpy(addr + offset, dirent, reclen);
-	kunmap_local(addr);
 	fi->rdc.size = (index << PAGE_SHIFT) + offset + reclen;
 	fi->rdc.pos = dirent->off;
-unlock:
+unmap:
+	kunmap_local(addr);
 	spin_unlock(&fi->rdc.lock);
 	unlock_page(page);
 	put_page(page);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index e1e23b4947d7..83aaffa6d701 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -128,6 +128,7 @@ void delete_from_page_cache(struct page *page)
 {
 	return filemap_remove_folio(page_folio(page));
 }
+EXPORT_SYMBOL(delete_from_page_cache);
 
 int try_to_release_page(struct page *page, gfp_t gfp)
 {
-- 
2.37.3

