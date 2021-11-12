Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E0344E6B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 13:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbhKLMrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 07:47:51 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4089 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235131AbhKLMrg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:47:36 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HrJDx5BRjz67ZgZ;
        Fri, 12 Nov 2021 20:44:17 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 12 Nov 2021 13:44:42 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ebiggers@kernel.org>, <tytso@mit.edu>, <corbet@lwn.net>,
        <viro@zeniv.linux.org.uk>, <hughd@google.com>,
        <akpm@linux-foundation.org>
CC:     <linux-fscrypt@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH 4/5] shmem: Avoid segfault in shmem_read_mapping_page_gfp()
Date:   Fri, 12 Nov 2021 13:44:10 +0100
Message-ID: <20211112124411.1948809-5-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211112124411.1948809-1-roberto.sassu@huawei.com>
References: <20211112124411.1948809-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Check the hwpoison page flag only if the page is valid in
shmem_read_mapping_page_gfp(). The PageHWPoison() macro tries to access
the page flags and cannot work on an error pointer.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 23c91a8beb78..427863cbf0dc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4222,7 +4222,7 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 	else
 		unlock_page(page);
 
-	if (PageHWPoison(page))
+	if (!IS_ERR(page) && PageHWPoison(page))
 		page = ERR_PTR(-EIO);
 
 	return page;
-- 
2.32.0

