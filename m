Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C878E77C233
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 23:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjHNVMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 17:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjHNVMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430251739
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692047486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/wqENBbj5y41JI93zB5OgbUzN7ReqPGhx+L0gn4tfM8=;
        b=CtzLw4Sw9dlbc0uecfgcBg0NLhvC9p/C3sygPOSm73iUfoCG7iXsZixBnJNeh8fYlvgF8K
        jbo6fgbTInoju9dF1g4vq0rSOOYooNRhtTiUHDxDxe8BTQA3grmd+Wo3RKcRPMxaNrhguX
        EQ2NMQpnFosCS1ANFWnEkdJzi43NLws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-94EUavPJO_GClPydUkdbng-1; Mon, 14 Aug 2023 17:11:24 -0400
X-MC-Unique: 94EUavPJO_GClPydUkdbng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96F41185A78F;
        Mon, 14 Aug 2023 21:11:23 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A510C15BAD;
        Mon, 14 Aug 2023 21:11:23 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org
Subject: [RFCv2 4/7] locks: update lock callback documentation
Date:   Mon, 14 Aug 2023 17:11:13 -0400
Message-Id: <20230814211116.3224759-5-aahringo@redhat.com>
In-Reply-To: <20230814211116.3224759-1-aahringo@redhat.com>
References: <20230814211116.3224759-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch updates the existing documentation regarding recent changes
to vfs_lock_file() and lm_grant() is set. In case of lm_grant() is set
we only handle FILE_LOCK_DEFERRED in case of FL_SLEEP in fl_flags is not
set. This is the case of an blocking lock request. Non-blocking lock
requests, when FL_SLEEP is not set, are handled in a synchronized way.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/locks.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index df8b26a42524..a8e51f462b43 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2255,21 +2255,21 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
  * To avoid blocking kernel daemons, such as lockd, that need to acquire POSIX
  * locks, the ->lock() interface may return asynchronously, before the lock has
  * been granted or denied by the underlying filesystem, if (and only if)
- * lm_grant is set. Callers expecting ->lock() to return asynchronously
- * will only use F_SETLK, not F_SETLKW; they will set FL_SLEEP if (and only if)
- * the request is for a blocking lock. When ->lock() does return asynchronously,
- * it must return FILE_LOCK_DEFERRED, and call ->lm_grant() when the lock
- * request completes.
- * If the request is for non-blocking lock the file system should return
- * FILE_LOCK_DEFERRED then try to get the lock and call the callback routine
- * with the result. If the request timed out the callback routine will return a
+ * lm_grant and FL_SLEEP in fl_flags is set. Callers expecting ->lock() to return
+ * asynchronously will only use F_SETLK, not F_SETLKW; When ->lock() does return
+ * asynchronously, it must return FILE_LOCK_DEFERRED, and call ->lm_grant() when
+ * the lock request completes. The lm_grant() callback must be called in a
+ * sleepable context.
+ *
+ * If the request timed out the ->lm_grant() callback routine will return a
  * nonzero return code and the file system should release the lock. The file
- * system is also responsible to keep a corresponding posix lock when it
- * grants a lock so the VFS can find out which locks are locally held and do
- * the correct lock cleanup when required.
- * The underlying filesystem must not drop the kernel lock or call
- * ->lm_grant() before returning to the caller with a FILE_LOCK_DEFERRED
- * return code.
+ * system is also responsible to keep a corresponding posix lock when it grants
+ * a lock so the VFS can find out which locks are locally held and do the correct
+ * lock cleanup when required.
+ *
+ * If the request is for non-blocking lock (when F_SETLK and FL_SLEEP in fl_flags is not set)
+ * the file system should return -EAGAIN if failed to acquire or zero if acquiring was
+ * successfully without calling the ->lm_grant() callback routine.
  */
 int vfs_lock_file(struct file *filp, unsigned int cmd, struct file_lock *fl, struct file_lock *conf)
 {
-- 
2.31.1

