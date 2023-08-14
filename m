Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD1077C234
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 23:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjHNVMc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 17:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjHNVMQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A41172E
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692047486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ha7qooP5xHAJkp/n5Tt2zY2sO83T4RUyDIe+tf4ioM=;
        b=ATAfHbrCQH55hEfTGmpfd0Wu/Vb3r+/berkZljRsyKWdSzaygBR8BEZrQbi+WwSnReJxWe
        x06otNJ8l7Zr4p9fD5qbMIDqb/HLUDxGdxJ1Ap3P1gUKWvv1AGUunnZr9aRCpZft2ebJj6
        QUcpcD3NK80RpAK5f5hfDotyLkzI6rw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-zltn7uhJN3WG1u-waD-sIw-1; Mon, 14 Aug 2023 17:11:23 -0400
X-MC-Unique: zltn7uhJN3WG1u-waD-sIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E13F28007A4;
        Mon, 14 Aug 2023 21:11:22 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95902C15BAD;
        Mon, 14 Aug 2023 21:11:22 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org
Subject: [RFCv2 2/7] lockd: FILE_LOCK_DEFERRED only on FL_SLEEP
Date:   Mon, 14 Aug 2023 17:11:11 -0400
Message-Id: <20230814211116.3224759-3-aahringo@redhat.com>
In-Reply-To: <20230814211116.3224759-1-aahringo@redhat.com>
References: <20230814211116.3224759-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

This patch removes to handle non-blocking lock requests as asynchronous
lock request returning FILE_LOCK_DEFERRED. When fl_lmops and lm_grant()
is set and a non-blocking lock request returns FILE_LOCK_DEFERRED will
end in an WARNING to signal the user the misusage of the API.

The reason why we moving to make non-blocking lock request as
synchronized call is that we already doing this behaviour for unlock or
cancellation as well. Those are POSIX lock operations which are handled
in an synchronized way and waiting for an answer. For non-blocking lock
requests the answer will probably arrive in the same time as unlock or
cancellation operations as those are trylock operations only.

In case of a blocking lock request we need to have it asynchronously
because the time when the lock request getting granted is unknown.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/lockd/svclock.c | 39 +++++++--------------------------------
 1 file changed, 7 insertions(+), 32 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 7d63524bdb81..1e74a578d7de 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -440,31 +440,6 @@ static void nlmsvc_freegrantargs(struct nlm_rqst *call)
 	locks_release_private(&call->a_args.lock.fl);
 }
 
-/*
- * Deferred lock request handling for non-blocking lock
- */
-static __be32
-nlmsvc_defer_lock_rqst(struct svc_rqst *rqstp, struct nlm_block *block)
-{
-	__be32 status = nlm_lck_denied_nolocks;
-
-	block->b_flags |= B_QUEUED;
-
-	nlmsvc_insert_block(block, NLM_TIMEOUT);
-
-	block->b_cache_req = &rqstp->rq_chandle;
-	if (rqstp->rq_chandle.defer) {
-		block->b_deferred_req =
-			rqstp->rq_chandle.defer(block->b_cache_req);
-		if (block->b_deferred_req != NULL)
-			status = nlm_drop_reply;
-	}
-	dprintk("lockd: nlmsvc_defer_lock_rqst block %p flags %d status %d\n",
-		block, block->b_flags, ntohl(status));
-
-	return status;
-}
-
 /*
  * Attempt to establish a lock, and if it can't be granted, block it
  * if required.
@@ -569,14 +544,14 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 			ret = async_block ? nlm_lck_blocked : nlm_lck_denied;
 			goto out_cb_mutex;
 		case FILE_LOCK_DEFERRED:
-			block->b_flags |= B_PENDING_CALLBACK;
+			/* lock requests without waiters are handled in
+			 * a non async way. Let assert this to inform
+			 * the user about a API violation.
+			 */
+			WARN_ON_ONCE(!wait);
 
-			if (wait)
-				break;
-			/* Filesystem lock operation is in progress
-			   Add it to the queue waiting for callback */
-			ret = nlmsvc_defer_lock_rqst(rqstp, block);
-			goto out_cb_mutex;
+			block->b_flags |= B_PENDING_CALLBACK;
+			break;
 		case -EDEADLK:
 			nlmsvc_remove_block(block);
 			ret = nlm_deadlock;
-- 
2.31.1

