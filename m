Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442B179DB33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 23:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbjILVyo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 17:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjILVyl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B28D10D2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 14:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694555631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bm5ioigpX2H28oED9HeU/1D9TJk7vRwYC7hWBAcGBxQ=;
        b=cYFUikieXJbN13wZk3BBU0Dsy1+LC/11ZaXFAtUdD8CnP/6LLoSwqD6MWseFaLFL0RIGIC
        PAjz2CTcbsRTQfccLm9D12WRco6HheJSmeHjNybGiUJZyOLM2J3yyzkxPwe6yPNvPRW031
        nTcVpMLaxvTrIubGwDt6Se77GH5pRNA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-nnXGloXVPLiYsP6t52r-AQ-1; Tue, 12 Sep 2023 17:53:48 -0400
X-MC-Unique: nnXGloXVPLiYsP6t52r-AQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A4AA181A6E0;
        Tue, 12 Sep 2023 21:53:48 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C061B40C2009;
        Tue, 12 Sep 2023 21:53:47 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     gfs2@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, aahringo@redhat.com
Subject: [PATCHv2 nfsd/master 3/7] lockd: fix race in async lock request handling
Date:   Tue, 12 Sep 2023 17:53:20 -0400
Message-Id: <20230912215324.3310111-4-aahringo@redhat.com>
In-Reply-To: <20230912215324.3310111-1-aahringo@redhat.com>
References: <20230912215324.3310111-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch fixes a race in async lock request handling between adding
the relevant struct nlm_block to nlm_blocked list after the request was
sent by vfs_lock_file() and nlmsvc_grant_deferred() does a lookup of the
nlm_block in the nlm_blocked list. It could be that the async request is
completed before the nlm_block was added to the list. This would end
in a -ENOENT and a kernel log message of "lockd: grant for unknown
block".

To solve this issue we add the nlm_block before the vfs_lock_file() call
to be sure it has been added when a possible nlmsvc_grant_deferred() is
called. If the vfs_lock_file() results in an case when it wouldn't be
added to nlm_blocked list, the nlm_block struct will be removed from
this list again.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/lockd/svclock.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index c313622a9578..993999297e31 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -555,6 +555,9 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 		ret = nlm_lck_blocked;
 		goto out;
 	}
+
+	/* Append to list of blocked */
+	nlmsvc_insert_block_locked(block, NLM_NEVER);
 	spin_unlock(&nlm_blocked_lock);
 
 	if (!wait)
@@ -566,9 +569,12 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 	dprintk("lockd: vfs_lock_file returned %d\n", error);
 	switch (error) {
 		case 0:
+			nlmsvc_remove_block(block);
 			ret = nlm_granted;
 			goto out;
 		case -EAGAIN:
+			if (!wait)
+				nlmsvc_remove_block(block);
 			ret = async_block ? nlm_lck_blocked : nlm_lck_denied;
 			goto out;
 		case FILE_LOCK_DEFERRED:
@@ -579,17 +585,16 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 			ret = nlmsvc_defer_lock_rqst(rqstp, block);
 			goto out;
 		case -EDEADLK:
+			nlmsvc_remove_block(block);
 			ret = nlm_deadlock;
 			goto out;
 		default:			/* includes ENOLCK */
+			nlmsvc_remove_block(block);
 			ret = nlm_lck_denied_nolocks;
 			goto out;
 	}
 
 	ret = nlm_lck_blocked;
-
-	/* Append to list of blocked */
-	nlmsvc_insert_block(block, NLM_NEVER);
 out:
 	mutex_unlock(&file->f_mutex);
 	nlmsvc_release_block(block);
-- 
2.31.1

