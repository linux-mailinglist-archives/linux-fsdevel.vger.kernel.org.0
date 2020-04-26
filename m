Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24C11B9456
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Apr 2020 23:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgDZVtu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 17:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgDZVtt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 17:49:49 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE30C061A41
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:49 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g16so12024875eds.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aGrqSyBlWee4qlVzfbrxmXDEIitY77BfW8OPiMV+fGw=;
        b=VAfCURwTPIE4rJfC8KB4FYWrz+JTx0GQK6awVyjDZRrnwDaaVDjgUgtGtQZznZmmxi
         wFl7jNmlcKuqIyO8p7/DqWXiTjP4SvaWAQzjxmulMXt8Ts4RDHfUM3ELErJt0x5C73AC
         zJywnyx9Cz5oWsMeQfO4c5ejUQ+vDm3Amp7tf72mheUEv9saFlblV0qG8GxVzGe8BxvY
         XbgofnU5SgEU582wK1e9C5GxLR0JqVzv67TRQVvRHms797+XWJFR5orBv3ADbbrwceBM
         E7ucIimM6ELJKj4Xxei35ZC9m3xzeGhs+QRaifvldaOwSBMIrEuwBPzLsQUyxEp4i+95
         N6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aGrqSyBlWee4qlVzfbrxmXDEIitY77BfW8OPiMV+fGw=;
        b=cnjLv7Ipobz2VarXY82Zl4MBBmfSSxsvwnbL4gsrw981zzzlOaPjVMvt9Sd7pIzyAv
         9Sa0fflZ5JbAOeeIl1fRJuxLRzUF7VXq+UfG36nirR6d4K7dyREQ8jhRFHz7oU37AGbv
         kUUdNON/tVpKjsBMb8DQkqDiWNl84JTGatGim+MpRtKJXndftY18FKcXSLV7TZfizt51
         HkM2/QLRwSlK6NDBTy8SaAyOeov/2aBVoTCFHN3e2d8bCh6/ztZV549eFMVVCjGQJhGd
         7XQDp/d+yOxMTnkpzNdAPG14IHumyRRby+IxCzml8JKFILCgUmLQ+pKWd3KSSBMMDMU/
         60Sg==
X-Gm-Message-State: AGi0Pub2el4d5/udqoNdiwFuAlXyRh7OuxG00U3bnmmN4pwgEkuwFNQX
        wKZh6iSqYerei6623p0EYBA+TOtcKzABkBiz
X-Google-Smtp-Source: APiQypL9pOXchtRNeUI9SqBMUqUJAL/dQ0McZChbYcK3Npoe5VpBYEa/V2WAwgwMmnQc4QcKjJFF6w==
X-Received: by 2002:a05:6402:356:: with SMTP id r22mr17183505edw.3.1587937787466;
        Sun, 26 Apr 2020 14:49:47 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:fab1:56ff:feab:56b1])
        by smtp.gmail.com with ESMTPSA id ce18sm2270108ejb.61.2020.04.26.14.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 14:49:46 -0700 (PDT)
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
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 1/9] include/linux/pagemap.h: introduce set/clear_fs_page_private
Date:   Sun, 26 Apr 2020 23:49:17 +0200
Message-Id: <20200426214925.10970-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
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

So, introduce the new set/clear_fs_page_private to replace them since
they are mostly used in fs layer. With the new pair of function, we will
remove the usage of attach_page_buffers and  __clear_page_buffers in
next patches.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: William Kucharski <william.kucharski@oracle.com> 
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 include/linux/pagemap.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a8f7bd8ea1c6..2a165ea647fe 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -205,6 +205,28 @@ static inline int page_cache_add_speculative(struct page *page, int count)
 	return __page_cache_add_speculative(page, count);
 }
 
+static inline void *set_fs_page_private(struct page *page, void *data)
+{
+	get_page(page);
+	set_page_private(page, (unsigned long)data);
+	SetPagePrivate(page);
+
+	return data;
+}
+
+static inline void *clear_fs_page_private(struct page *page)
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

