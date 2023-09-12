Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D4979DB36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 23:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjILVyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 17:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237565AbjILVyo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D52D10D9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 14:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694555632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IckdSVzMK+BSFRjaA/U5gFIv6MBdqOAoK8cZbMlk/7Y=;
        b=RbToKeRDI8PlRy56U3ZSZKZL0rFaHgJIP+WTf+tlyqBF4mmTfCTS/PFo4D0XSXH4zWKnOu
        cKynLWRhCvkTX1oKnHzzjgyUBLmUBXSDx7RWBIwksPYNdbUrttJMQBo/avVvCXvscDpEYM
        5OtYdehZWDkAMkGGAgMMFN+wPFL1wjQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-FlW2D6UtODqTg0xXP3PKsQ-1; Tue, 12 Sep 2023 17:53:49 -0400
X-MC-Unique: FlW2D6UtODqTg0xXP3PKsQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D5673806702;
        Tue, 12 Sep 2023 21:53:48 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FD2440C200A;
        Tue, 12 Sep 2023 21:53:48 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     gfs2@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, aahringo@redhat.com
Subject: [PATCHv2 nfsd/master 4/7] lockd: add doc to enable EXPORT_OP_ASYNC_LOCK
Date:   Tue, 12 Sep 2023 17:53:21 -0400
Message-Id: <20230912215324.3310111-5-aahringo@redhat.com>
In-Reply-To: <20230912215324.3310111-1-aahringo@redhat.com>
References: <20230912215324.3310111-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds a note to enable EXPORT_OP_ASYNC_LOCK for
asynchronous lock request handling.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/locks.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 76ad05f8070a..d4e49a990a8d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2264,11 +2264,13 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
  * To avoid blocking kernel daemons, such as lockd, that need to acquire POSIX
  * locks, the ->lock() interface may return asynchronously, before the lock has
  * been granted or denied by the underlying filesystem, if (and only if)
- * lm_grant is set. Callers expecting ->lock() to return asynchronously
- * will only use F_SETLK, not F_SETLKW; they will set FL_SLEEP if (and only if)
- * the request is for a blocking lock. When ->lock() does return asynchronously,
- * it must return FILE_LOCK_DEFERRED, and call ->lm_grant() when the lock
- * request completes.
+ * lm_grant is set. Additionally EXPORT_OP_ASYNC_LOCK in export_operations
+ * flags need to be set.
+ *
+ * Callers expecting ->lock() to return asynchronously will only use F_SETLK,
+ * not F_SETLKW; they will set FL_SLEEP if (and only if) the request is for a
+ * blocking lock. When ->lock() does return asynchronously, it must return
+ * FILE_LOCK_DEFERRED, and call ->lm_grant() when the lock request completes.
  * If the request is for non-blocking lock the file system should return
  * FILE_LOCK_DEFERRED then try to get the lock and call the callback routine
  * with the result. If the request timed out the callback routine will return a
-- 
2.31.1

