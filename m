Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C14779DB30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 23:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbjILVyk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 17:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbjILVyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B6C810CC
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 14:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694555629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=//nek6/ne2ovuV3WtIFZKKv22HdvaTJOJBdTaDhEBYo=;
        b=a5WUL1dBC+cjvJBCh1MBL5LUM4uFwg/gnbvBMrj0zvZ9N8F+lbg/n8+PTEFSLFS43Dgg9s
        tA3y/B4mzC7gb3Jr7MS/+Qa3anYvXTpH4ZdnWzlwJZEHK9P3Cv0zv1/3N502xPaJlfwOqw
        iXy9NSLKV6oCoba6jb/X3SUVqQOvpTY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-nhOZnKV9MfCsXEZtQEdBIQ-1; Tue, 12 Sep 2023 17:53:48 -0400
X-MC-Unique: nhOZnKV9MfCsXEZtQEdBIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA3BC181A6E6;
        Tue, 12 Sep 2023 21:53:47 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D9C940C2009;
        Tue, 12 Sep 2023 21:53:47 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     gfs2@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, aahringo@redhat.com
Subject: [PATCHv2 nfsd/master 2/7] lockd: don't call vfs_lock_file() for pending requests
Date:   Tue, 12 Sep 2023 17:53:19 -0400
Message-Id: <20230912215324.3310111-3-aahringo@redhat.com>
In-Reply-To: <20230912215324.3310111-1-aahringo@redhat.com>
References: <20230912215324.3310111-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/lockd/svclock.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index d500e32ebb18..c313622a9578 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -541,6 +541,22 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
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
+	if (exportfs_lock_op_is_async(inode->i_sb->s_export_op) &&
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
@@ -553,13 +569,6 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
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

