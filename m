Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC6D46FBA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 08:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbhLJHkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 02:40:09 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:35934 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235453AbhLJHkA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:40:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-8PLOr_1639121783;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V-8PLOr_1639121783)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 15:36:24 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RFC 03/19] cachefiles: refactor cachefiles_adjust_size()
Date:   Fri, 10 Dec 2021 15:36:03 +0800
Message-Id: <20211210073619.21667-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In demand-read mode, fs using fscache for demand-read doesn't know the
exact file size of the data blob file, and the input @object_size
parameter of fscache_acquire_cookie() could be fake in this case.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/interface.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 51c968cd00a6..b85051250cb7 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -110,6 +110,7 @@ static int cachefiles_adjust_size(struct cachefiles_object *object)
 {
 	struct iattr newattrs;
 	struct file *file = object->file;
+	struct cachefiles_cache *cache = object->volume->cache;
 	uint64_t ni_size;
 	loff_t oi_size;
 	int ret;
@@ -123,6 +124,9 @@ static int cachefiles_adjust_size(struct cachefiles_object *object)
 	if (!file)
 		return -ENOBUFS;
 
+	if (cache->mode == CACHEFILES_MODE_DEMAND)
+		return 0;
+
 	oi_size = i_size_read(file_inode(file));
 	if (oi_size == ni_size)
 		return 0;
-- 
2.27.0

