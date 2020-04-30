Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939551C09BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 23:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgD3VxB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 17:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgD3Vwq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:52:46 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70932C035495
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:46 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id r16so5831660edw.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0x0u2gx9fn/eR0FN5+bPGwv0n6eHZLnbohIE4ZZX1xA=;
        b=EKSoG5Ew33JLpPLoDYTtE+/Mgaiip4zvgBvwtrD+hzLSfo0W4PoRueJtf0vHDfylth
         bljRy4d4FM68XWGdNeOkwmfpot8DYA8ccYVAgwhAOhIi49XGb7to4+pAAZneDZCwf4G6
         IkFcj1IZ9Qq8NOMnothYcg8j2FPeyvEg43skasH+eZw77B+t7Qfs+j68ULZzmwKal/h3
         9saDCk1g1y7x4x+j5cKc0w4eHvhoxpHehsWHYcMrqIF522cmVjrQX9TO1JsfPCvOuR/I
         zHxuTKM5R0LSq/EtBs1ZI6S/nV/ouTfbgPwVZmpLRJi6srnLa57HKoMQe8NfaoufTaQa
         mUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0x0u2gx9fn/eR0FN5+bPGwv0n6eHZLnbohIE4ZZX1xA=;
        b=jdE+/rYgYnDxr2cL5UzY6mNFtrO597quXSfOgxc7CuvDKrjoa083NUfFalVUpQ0FcS
         ugQreSbMmHIZRkhhCRLUMxPCD/h+ok4sTtM5zsyqrIQD4jv69Z2QzEQ1OuGYoY+KJ1ib
         ntjvzNFjp84sS7r9wubBw2Du14cfrxJzuiHAug28MAq9lba9b0yXi4Ka6v01PcymyzZS
         b3ZRLK0isy3fd2mTU8BYj9RpERoirG6xfMpO34Wq8kF2fqt33PfjCl6fEqzKz7iysuOD
         V6VS4KddqfgjDMh71ODdzQBcarYsGr6h7DevgmBX5iku8eYdZpfOhHsTa0KorX2TvYHG
         HiuA==
X-Gm-Message-State: AGi0PuYxA0A5WIpytcyHsKLBn7Ghxq9wY96EzqLJX2XWKiCH5HPAQ8Ss
        7Dzopr11ZSHvZZIeSLA6YxS7Ch1IrwK8Kg==
X-Google-Smtp-Source: APiQypKmEI+P+Q9Igmy/Z+wtCcfy41Y3uqyWZUCr4Xom2jUvuVGNOvsSANgZbWuTvpeKE8zdOXrN5A==
X-Received: by 2002:aa7:ce0f:: with SMTP id d15mr995432edv.327.1588283565020;
        Thu, 30 Apr 2020 14:52:45 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b82f:dfc:5e2a:e7cc])
        by smtp.gmail.com with ESMTPSA id f13sm92022ejd.2.2020.04.30.14.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:52:44 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Subject: [RFC PATCH V2 8/9] orangefs: use attach/clear_page_private
Date:   Thu, 30 Apr 2020 23:44:49 +0200
Message-Id: <20200430214450.10662-9-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
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
RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.
2. avoid potential use-after-free as suggested by Dave Chinner.

 fs/orangefs/inode.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 12ae630fbed7..139c450aca68 100644
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
+	kfree(clear_page_private(page));
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
+		kfree(clear_page_private(page));
 		return;
 	/* write range entirely within invalidate range (or equal) */
 	} else if (page_offset(page) + offset <= wr->pos &&
 	    wr->pos + wr->len <= page_offset(page) + offset + length) {
-		kfree((struct orangefs_write_range *)page_private(page));
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
-		put_page(page);
+		kfree(clear_page_private(page));
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
+	kfree(clear_page_private(page));
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

