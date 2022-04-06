Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C094F5D1E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 14:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiDFMOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 08:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiDFMNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:13:52 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3348424F05;
        Wed,  6 Apr 2022 00:56:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V9Kyhod_1649231774;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V9Kyhod_1649231774)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 Apr 2022 15:56:15 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: [PATCH v8 01/20] cachefiles: unmark inode in use in error path
Date:   Wed,  6 Apr 2022 15:55:53 +0800
Message-Id: <20220406075612.60298-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Unmark inode in use if error encountered. If the in-use flag leakage
occurs in cachefiles_open_file(), Cachefiles will complain "Inode
already in use" when later another cookie with the same index key is
looked up.

If the in-use flag leakage occurs in cachefiles_create_tmpfile(), though
the "Inode already in use" warning won't be triggered, fix the leakage
anyway.

Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Fixes: 1f08c925e7a3 ("cachefiles: Implement backing file wrangling")
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/namei.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index f256c8aff7bb..fe1bab0f36d4 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -57,6 +57,16 @@ static void __cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
 	trace_cachefiles_mark_inactive(object, inode);
 }
 
+static void cachefiles_do_unmark_inode_in_use(struct cachefiles_object *object,
+				       struct dentry *dentry)
+{
+	struct inode *inode = d_backing_inode(dentry);
+
+	inode_lock(inode);
+	__cachefiles_unmark_inode_in_use(object, dentry);
+	inode_unlock(inode);
+}
+
 /*
  * Unmark a backing inode and tell cachefilesd that there's something that can
  * be culled.
@@ -68,9 +78,7 @@ void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
 	struct inode *inode = file_inode(file);
 
 	if (inode) {
-		inode_lock(inode);
-		__cachefiles_unmark_inode_in_use(object, file->f_path.dentry);
-		inode_unlock(inode);
+		cachefiles_do_unmark_inode_in_use(object, file->f_path.dentry);
 
 		if (!test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags)) {
 			atomic_long_add(inode->i_blocks, &cache->b_released);
@@ -484,7 +492,7 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 				object, d_backing_inode(path.dentry), ret,
 				cachefiles_trace_trunc_error);
 			file = ERR_PTR(ret);
-			goto out_dput;
+			goto out_unuse;
 		}
 	}
 
@@ -494,15 +502,20 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 		trace_cachefiles_vfs_error(object, d_backing_inode(path.dentry),
 					   PTR_ERR(file),
 					   cachefiles_trace_open_error);
-		goto out_dput;
+		goto out_unuse;
 	}
 	if (unlikely(!file->f_op->read_iter) ||
 	    unlikely(!file->f_op->write_iter)) {
 		fput(file);
 		pr_notice("Cache does not support read_iter and write_iter\n");
 		file = ERR_PTR(-EINVAL);
+		goto out_unuse;
 	}
 
+	goto out_dput;
+
+out_unuse:
+	cachefiles_do_unmark_inode_in_use(object, path.dentry);
 out_dput:
 	dput(path.dentry);
 out:
@@ -590,14 +603,16 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 check_failed:
 	fscache_cookie_lookup_negative(object->cookie);
 	cachefiles_unmark_inode_in_use(object, file);
-	if (ret == -ESTALE) {
-		fput(file);
-		dput(dentry);
+	fput(file);
+	dput(dentry);
+	if (ret == -ESTALE)
 		return cachefiles_create_file(object);
-	}
+	return false;
+
 error_fput:
 	fput(file);
 error:
+	cachefiles_do_unmark_inode_in_use(object, dentry);
 	dput(dentry);
 	return false;
 }
-- 
2.27.0

