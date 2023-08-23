Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BC578626F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 23:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbjHWVfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 17:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbjHWVf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EB710EC
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 14:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692826441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=htB9ruBs/M3gzRN+MQhu18/VcxVtJfis4P4SxexSrGE=;
        b=jNPKGorNknZUAX9j04pmaAQwHqCpSpyq2qGiIhvF5n86rujE+TlTI+aDbVT4fcgalKZtNo
        MUVlMU/fsXOcqEsWhuhIXGWIqs9eSccWW0LQDbDk0JDGTf2DZODMvuA5ZuLFf4BkYbTIaP
        xB7nM7G2xNfnWJpWAYDQAZh3djYokYs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-j9OrqPG9M-uKAhTJKw2f4g-1; Wed, 23 Aug 2023 17:33:54 -0400
X-MC-Unique: j9OrqPG9M-uKAhTJKw2f4g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60E94185A78B;
        Wed, 23 Aug 2023 21:33:54 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1971640C6F4C;
        Wed, 23 Aug 2023 21:33:54 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org
Subject: [PATCH 2/7] lockd: don't call vfs_lock_file() for pending requests
Date:   Wed, 23 Aug 2023 17:33:47 -0400
Message-Id: <20230823213352.1971009-3-aahringo@redhat.com>
In-Reply-To: <20230823213352.1971009-1-aahringo@redhat.com>
References: <20230823213352.1971009-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch returns nlm_lck_blocked in nlmsvc_lock() when an asynchronous
lock request is pending. During testing I ran into the case with the
side-effects that lockd is waiting for only one lm_grant() callback
because it's already part of the nlm_blocked list. If another
asynchronous for the same nlm_block is triggered two lm_grant()
callbacks will occur but lockd was only waiting for one.

To avoid any change of existing users this handling will only being made
when export_op_support_safe_async_lock() returns true.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/lockd/svclock.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 6e3b230e8317..aa4174fbaf5b 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -531,6 +531,23 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 		goto out;
 	}
 
+	spin_lock(&nlm_blocked_lock);
+	/*
+	 * If this is a lock request for an already pending
+	 * lock request we return nlm_lck_blocked without calling
+	 * vfs_lock_file() again. Otherwise we have two pending
+	 * requests on the underlaying ->lock() implementation but
+	 * only one nlm_block to being granted by lm_grant().
+	 */
+	if (export_op_support_safe_async_lock(inode->i_sb->s_export_op,
+					      nlmsvc_file_file(file)->f_op) &&
+	    !list_empty(&block->b_list)) {
+		spin_unlock(&nlm_blocked_lock);
+		ret = nlm_lck_blocked;
+		goto out;
+	}
+	spin_unlock(&nlm_blocked_lock);
+
 	if (!wait)
 		lock->fl.fl_flags &= ~FL_SLEEP;
 	mode = lock_to_openmode(&lock->fl);
@@ -543,13 +560,6 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 			ret = nlm_granted;
 			goto out;
 		case -EAGAIN:
-			/*
-			 * If this is a blocking request for an
-			 * already pending lock request then we need
-			 * to put it back on lockd's block list
-			 */
-			if (wait)
-				break;
 			ret = async_block ? nlm_lck_blocked : nlm_lck_denied;
 			goto out;
 		case FILE_LOCK_DEFERRED:
-- 
2.31.1

