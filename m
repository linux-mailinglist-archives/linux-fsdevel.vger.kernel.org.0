Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFDA474AD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 11:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391256AbfGYJ6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 05:58:00 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56936 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391219AbfGYJ6A (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:58:00 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0FF29DC7C5BF9DD8D752;
        Thu, 25 Jul 2019 17:57:57 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Jul
 2019 17:57:47 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "David Sterba" <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v4 19/24] erofs: add erofs_allocpage()
Date:   Thu, 25 Jul 2019 17:56:53 +0800
Message-ID: <20190725095658.155779-20-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725095658.155779-1-gaoxiang25@huawei.com>
References: <20190725095658.155779-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces an temporary _on-stack_ page
pool to reuse the freed page directly as much as
it can for better performance and release all pages
at a time, it also slightly reduces the possibility of
the potential memory allocation failure.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/internal.h |  2 ++
 fs/erofs/utils.c    | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 410e1b7ef82e..d450ab130d5e 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -492,6 +492,8 @@ int erofs_namei(struct inode *dir, struct qstr *name,
 extern const struct file_operations erofs_dir_fops;
 
 /* utils.c */
+struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp, bool nofail);
+
 #if (EROFS_PCPUBUF_NR_PAGES > 0)
 void *erofs_get_pcpubuf(unsigned int pagenr);
 #define erofs_put_pcpubuf(buf) do { \
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index ffaa226746b8..34d0aad1af83 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -9,6 +9,20 @@
 #include "internal.h"
 #include <linux/pagevec.h>
 
+struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp, bool nofail)
+{
+	struct page *page;
+
+	if (!list_empty(pool)) {
+		page = lru_to_page(pool);
+		DBG_BUGON(page_ref_count(page) != 1);
+		list_del(&page->lru);
+	} else {
+		page = alloc_pages(gfp | (nofail ? __GFP_NOFAIL : 0), 0);
+	}
+	return page;
+}
+
 #if (EROFS_PCPUBUF_NR_PAGES > 0)
 static struct {
 	u8 data[PAGE_SIZE * EROFS_PCPUBUF_NR_PAGES];
-- 
2.17.1

