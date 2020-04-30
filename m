Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7565F1C09C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 23:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgD3VxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 17:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgD3Vwj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:52:39 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6EDC09B040
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:39 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id re23so5985664ejb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Cwm7q37wd5a49T4hM9tpsz7D3qzUxu8CT8JBwv0w4c=;
        b=NGAEKGruhKtx7ZWTrFdEqTmqAVl/YDbNX5SVHiheCt5mgGQXMvPqVsB2mWj4W+6TZx
         avj1y2aqFM2fM4mYbpeY1mNHjz5L5wFBJHZ7nqGDO/UfrsVe7K3fK+19Qz0xhaRBCJF8
         cnG9jsv0Y3cuCHExnrUC59PgGg5ldN6zReZ4l/MkqDih/pWf2Qq5leOqyJa1Ea1uUvqL
         KSJUgjKhSgiIMTbhcESV0rK/2/wlrqs0rRp/j53oVanG3NSXpHazoglUXFC2CIoq8QGs
         T0RBK7fYVyj0odwSJ7t5g5PDfIz9c6vhMkT7fz1ruAgadlRAj8EWlz0SjkauUs46ppHW
         r7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Cwm7q37wd5a49T4hM9tpsz7D3qzUxu8CT8JBwv0w4c=;
        b=scWJ6guJUJBDTLKn97K0vk5a9QgvR4GmOmEMU8POoNzs3EW3vW4lt9zmNA/RCfN7DU
         JfbOXpgeP4E/YA1PWY8Zbh32lIdWsQdjcoqyTFGYPssffJ5ZNnVr8jPmV2sNrwTi6lXX
         GYQsclxNdOo4Eit97PPKEX1N9oJfuXRHteGPGz30pioie2O8Yt9E/MT6GfboR5wtVVoX
         Pv0mQgWsSo46UzR9M2dxyG5IcpeQl6C89QW5G4i5uekoQ3Wh2GaduiwFQzjjhbFt8Usu
         luzclZ0vp3Zc7S9ycr4xNlQ4xwDdptgQWSUy/DNg7SXNX2EWd7PUVw6wzj2nZ5k+Vgpq
         njrg==
X-Gm-Message-State: AGi0PuZy8HQuK+T1JV9cfha/FlhKVcF7SAWAkK66gGqxfpNioLxZu8+o
        z7GNg3goY317MPd0NUjUmcBJ4nOJOTBLiA==
X-Google-Smtp-Source: APiQypIDTj3Uj7biPphTd2Cba892cORi5pdinqFvBm6XPxrzHDikqrxlAy/dZ1nN6NDVa1Eq5TMhqw==
X-Received: by 2002:a17:906:b2c4:: with SMTP id cf4mr538626ejb.340.1588283557346;
        Thu, 30 Apr 2020 14:52:37 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b82f:dfc:5e2a:e7cc])
        by smtp.gmail.com with ESMTPSA id f13sm92022ejd.2.2020.04.30.14.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:52:36 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yafang Shao <laoar.shao@gmail.com>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [RFC PATCH V2 1/9] include/linux/pagemap.h: introduce attach/clear_page_private
Date:   Thu, 30 Apr 2020 23:44:42 +0200
Message-Id: <20200430214450.10662-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
References: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The logic in attach_page_buffers and  __clear_page_buffers are quite
paired, but

1. they are located in different files.

2. attach_page_buffers is implemented in buffer_head.h, so it could be
   used by other files. But __clear_page_buffers is static function in
   buffer.c and other potential users can't call the function, md-bitmap
   even copied the function.

So, introduce the new attach/clear_page_private to replace them. With
the new pair of function, we will remove the usage of attach_page_buffers
and  __clear_page_buffers in next patches. Thanks for the new names from
Christoph Hellwig.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Yafang Shao <laoar.shao@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org
Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Cc: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>
Cc: devel@lists.orangefs.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Roman Gushchin <guro@fb.com>
Cc: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
RFC -> RFC V2:  Address the comments from Christoph Hellwig
1. change function names to attach/clear_page_private and add comments.
2. change the return type of attach_page_private.

 include/linux/pagemap.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a8f7bd8ea1c6..2e515f210b18 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -205,6 +205,41 @@ static inline int page_cache_add_speculative(struct page *page, int count)
 	return __page_cache_add_speculative(page, count);
 }
 
+/**
+ * attach_page_private - attach data to page's private field and set PG_private.
+ * @page: page to be attached and set flag.
+ * @data: data to attach to page's private field.
+ *
+ * Need to take reference as mm.h said "Setting PG_private should also increment
+ * the refcount".
+ */
+static inline void attach_page_private(struct page *page, void *data)
+{
+	get_page(page);
+	set_page_private(page, (unsigned long)data);
+	SetPagePrivate(page);
+}
+
+/**
+ * clear_page_private - clear page's private field and PG_private.
+ * @page: page to be cleared.
+ *
+ * The counterpart function of attach_page_private.
+ * Return: private data of page or NULL if page doesn't have private data.
+ */
+static inline void *clear_page_private(struct page *page)
+{
+	void *data = (void *)page_private(page);
+
+	if (!PagePrivate(page))
+		return NULL;
+	ClearPagePrivate(page);
+	set_page_private(page, 0);
+	put_page(page);
+
+	return data;
+}
+
 #ifdef CONFIG_NUMA
 extern struct page *__page_cache_alloc(gfp_t gfp);
 #else
-- 
2.17.1

