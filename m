Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190601C9D9F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 23:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgEGVo2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 17:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgEGVo1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 17:44:27 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83529C05BD0B
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 14:44:27 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id y24so6893329edo.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x1k2am9O4R7Y4YHJ4Be5yH8QLb/HmP/D5mGyD5wTZwk=;
        b=DqSTGd8rzc46rV5EX1cpfSoxdzSXi4EvLLhtIxUZl7wvMLlAIHdW2/4M0GfdL8Fm1d
         6UNkyIXF2cOpVkbG98ZwWik0/In1ULaWpxc4NZsEFId32aSQ+K+Kk/tFkHawqNT1T0aq
         duA15dILclSATjQAKk1C3lIVZp8bDdeQeFx+u6u1eelDaZoN8qUPdwr9FHW6O8U9x2JP
         02M1BU4hAwTponPR7/EG8mYRfPmx+PClEJ+oofvj7xM07KBIqu8Bf/V/MD4qZ5ix/shu
         CsMPyXhtGCgZF5A5Zn3OlGyVUNNwJ6skkk/tjB4DJ9BOZ5TnVKN48ej8XsTfb6oW11z2
         lijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x1k2am9O4R7Y4YHJ4Be5yH8QLb/HmP/D5mGyD5wTZwk=;
        b=dTQEyJyotcOr4wTCTtY/dvLdG+Etcr6XupQLJphFI/7NUUsGf12STzLhloyhDx4Xq7
         avhq71obxQVL3YaLem0NMg7TdNmuwTQD0iUgjnfxOHpGfrnEPE3JvUFz8Ejlm3tNvcju
         m9milCx4YcBGNRJnI1Ptpi3diz8AI+3KHEC0bAIurEvLuLAtw7jiimMgNqrC159zeooW
         lGhh3ibnUgaAGfPw5FzLJvvzUm5/GvTKSbKc0aWPHo7ul4+LTG/Xn6RbZF5qpbMoeTRB
         iUpS42WpIx9ASiw9+k+oHKy1nBvulm0AZe58FMhaPq4eQQATqddR9OrqVEVKElih+RQB
         2pWQ==
X-Gm-Message-State: AGi0PuYxXVZjLIwJtVV6PSkuhmd+zabfXZkSUuU8xeGqj8NczmYep68A
        AaSFsBIGx0Ys+DPgVT3BsUEUBHGmT3k/Yg==
X-Google-Smtp-Source: APiQypKU+QDtTzAGbt+rGx7x4k3z0gzwhpSfgQcNFLq8Sc/4CGP3DKvBCi/+fwfP+Bt5DxySqrSSLw==
X-Received: by 2002:a05:6402:4a:: with SMTP id f10mr14429868edu.274.1588887866036;
        Thu, 07 May 2020 14:44:26 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ee:a39a:b93a:c084])
        by smtp.gmail.com with ESMTPSA id k3sm613530edi.60.2020.05.07.14.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:25 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Subject: [RFC PATCH V3 08/10] orangefs: use attach/detach_page_private
Date:   Thu,  7 May 2020 23:43:58 +0200
Message-Id: <20200507214400.15785-9-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
References: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the new pair function is introduced, we can call them to clean the
code in orangefs.

Cc: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>
Cc: devel@lists.orangefs.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
RFC V2 -> RFC V3
1. rename clear_page_private to detach_page_private.

RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.
2. avoid potential use-after-free as suggested by Dave Chinner.

 fs/orangefs/inode.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 12ae630fbed7..48f0547d4850 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -62,12 +62,7 @@ static int orangefs_writepage_locked(struct page *page,
 	} else {
 		ret = 0;
 	}
-	if (wr) {
-		kfree(wr);
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
-	}
+	kfree(detach_page_private(page));
 	return ret;
 }
 
@@ -409,9 +404,7 @@ static int orangefs_write_begin(struct file *file,
 	wr->len = len;
 	wr->uid = current_fsuid();
 	wr->gid = current_fsgid();
-	SetPagePrivate(page);
-	set_page_private(page, (unsigned long)wr);
-	get_page(page);
+	attach_page_private(page, wr);
 okay:
 	return 0;
 }
@@ -459,18 +452,12 @@ static void orangefs_invalidatepage(struct page *page,
 	wr = (struct orangefs_write_range *)page_private(page);
 
 	if (offset == 0 && length == PAGE_SIZE) {
-		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		kfree(detach_page_private(page));
 		return;
 	/* write range entirely within invalidate range (or equal) */
 	} else if (page_offset(page) + offset <= wr->pos &&
 	    wr->pos + wr->len <= page_offset(page) + offset + length) {
-		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		kfree(detach_page_private(page));
 		/* XXX is this right? only caller in fs */
 		cancel_dirty_page(page);
 		return;
@@ -535,12 +522,7 @@ static int orangefs_releasepage(struct page *page, gfp_t foo)
 
 static void orangefs_freepage(struct page *page)
 {
-	if (PagePrivate(page)) {
-		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
-	}
+	kfree(detach_page_private(page));
 }
 
 static int orangefs_launder_page(struct page *page)
@@ -740,9 +722,7 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
 	wr->len = PAGE_SIZE;
 	wr->uid = current_fsuid();
 	wr->gid = current_fsgid();
-	SetPagePrivate(page);
-	set_page_private(page, (unsigned long)wr);
-	get_page(page);
+	attach_page_private(page, wr);
 okay:
 
 	file_update_time(vmf->vma->vm_file);
-- 
2.17.1

