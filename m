Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7B077C22A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 23:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjHNVMa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 17:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjHNVMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9B6171F
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 14:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692047484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MTB6n9Lzh+gnb3QJmth1T9LtSZXZSrD2dMC30pyrg2M=;
        b=LIlI0Fe/G4NMJTGvjbqGqitkD5ZuRyh8E93j3dkJJ7m1q6/Q1/8/4+IZRMd1E0QiDFEjlM
        iVvbLIscn5vplAp/pqI68UI05nvGygfy5JAOzO0zPh118xUVQkwTiWwhMIJLXmEaktYA78
        7zKVQJC0BdupbRYEthZfRXJq4M7h8Pg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-y8MG4fJXP6KTkDjUXyzaRA-1; Mon, 14 Aug 2023 17:11:23 -0400
X-MC-Unique: y8MG4fJXP6KTkDjUXyzaRA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8ED3E3804060;
        Mon, 14 Aug 2023 21:11:22 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40DE0C15BAD;
        Mon, 14 Aug 2023 21:11:22 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org
Subject: [RFCv2 1/7] lockd: fix race in async lock request handling
Date:   Mon, 14 Aug 2023 17:11:10 -0400
Message-Id: <20230814211116.3224759-2-aahringo@redhat.com>
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

The introducing of the new B_PENDING_CALLBACK nlm_block flag will handle
async lock requests on a pending lock requests as a retry on the caller
level to hit the -EAGAIN case.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/lockd/svclock.c          | 100 ++++++++++++++++++++++++++----------
 include/linux/lockd/lockd.h |   2 +
 2 files changed, 74 insertions(+), 28 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index c43ccdf28ed9..7d63524bdb81 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -133,6 +133,7 @@ nlmsvc_remove_block(struct nlm_block *block)
 {
 	if (!list_empty(&block->b_list)) {
 		spin_lock(&nlm_blocked_lock);
+		block->b_flags &= ~B_PENDING_CALLBACK;
 		list_del_init(&block->b_list);
 		spin_unlock(&nlm_blocked_lock);
 		nlmsvc_release_block(block);
@@ -232,6 +233,7 @@ nlmsvc_create_block(struct svc_rqst *rqstp, struct nlm_host *host,
 	kref_init(&block->b_count);
 	INIT_LIST_HEAD(&block->b_list);
 	INIT_LIST_HEAD(&block->b_flist);
+	mutex_init(&block->b_cb_mutex);
 
 	if (!nlmsvc_setgrantargs(call, lock))
 		goto failed_free;
@@ -289,6 +291,8 @@ static void nlmsvc_free_block(struct kref *kref)
 
 	dprintk("lockd: freeing block %p...\n", block);
 
+	WARN_ON_ONCE(block->b_flags & B_PENDING_CALLBACK);
+
 	/* Remove block from file's list of blocks */
 	list_del_init(&block->b_flist);
 	mutex_unlock(&file->f_mutex);
@@ -532,6 +536,13 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 		goto out;
 	}
 
+	mutex_lock(&block->b_cb_mutex);
+	if (block->b_flags & B_PENDING_CALLBACK)
+		goto pending_request;
+
+	/* Append to list of blocked */
+	nlmsvc_insert_block(block, NLM_NEVER);
+
 	if (!wait)
 		lock->fl.fl_flags &= ~FL_SLEEP;
 	mode = lock_to_openmode(&lock->fl);
@@ -541,9 +552,13 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 	dprintk("lockd: vfs_lock_file returned %d\n", error);
 	switch (error) {
 		case 0:
+			nlmsvc_remove_block(block);
 			ret = nlm_granted;
-			goto out;
+			goto out_cb_mutex;
 		case -EAGAIN:
+			if (!wait)
+				nlmsvc_remove_block(block);
+pending_request:
 			/*
 			 * If this is a blocking request for an
 			 * already pending lock request then we need
@@ -552,26 +567,29 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 			if (wait)
 				break;
 			ret = async_block ? nlm_lck_blocked : nlm_lck_denied;
-			goto out;
+			goto out_cb_mutex;
 		case FILE_LOCK_DEFERRED:
+			block->b_flags |= B_PENDING_CALLBACK;
+
 			if (wait)
 				break;
 			/* Filesystem lock operation is in progress
 			   Add it to the queue waiting for callback */
 			ret = nlmsvc_defer_lock_rqst(rqstp, block);
-			goto out;
+			goto out_cb_mutex;
 		case -EDEADLK:
+			nlmsvc_remove_block(block);
 			ret = nlm_deadlock;
-			goto out;
+			goto out_cb_mutex;
 		default:			/* includes ENOLCK */
+			nlmsvc_remove_block(block);
 			ret = nlm_lck_denied_nolocks;
-			goto out;
+			goto out_cb_mutex;
 	}
 
 	ret = nlm_lck_blocked;
-
-	/* Append to list of blocked */
-	nlmsvc_insert_block(block, NLM_NEVER);
+out_cb_mutex:
+	mutex_unlock(&block->b_cb_mutex);
 out:
 	mutex_unlock(&file->f_mutex);
 	nlmsvc_release_block(block);
@@ -728,34 +746,60 @@ nlmsvc_update_deferred_block(struct nlm_block *block, int result)
 		block->b_flags |= B_TIMED_OUT;
 }
 
+static int __nlmsvc_grant_deferred(struct nlm_block *block,
+				   struct file_lock *fl,
+				   int result)
+{
+	int rc = 0;
+
+	dprintk("lockd: nlmsvc_notify_blocked block %p flags %d\n",
+					block, block->b_flags);
+	if (block->b_flags & B_QUEUED) {
+		if (block->b_flags & B_TIMED_OUT) {
+			rc = -ENOLCK;
+			goto out;
+		}
+		nlmsvc_update_deferred_block(block, result);
+	} else if (result == 0)
+		block->b_granted = 1;
+
+	nlmsvc_insert_block_locked(block, 0);
+	svc_wake_up(block->b_daemon);
+out:
+	return rc;
+}
+
 static int nlmsvc_grant_deferred(struct file_lock *fl, int result)
 {
-	struct nlm_block *block;
-	int rc = -ENOENT;
+	struct nlm_block *iter, *block = NULL;
+	int rc;
 
 	spin_lock(&nlm_blocked_lock);
-	list_for_each_entry(block, &nlm_blocked, b_list) {
-		if (nlm_compare_locks(&block->b_call->a_args.lock.fl, fl)) {
-			dprintk("lockd: nlmsvc_notify_blocked block %p flags %d\n",
-							block, block->b_flags);
-			if (block->b_flags & B_QUEUED) {
-				if (block->b_flags & B_TIMED_OUT) {
-					rc = -ENOLCK;
-					break;
-				}
-				nlmsvc_update_deferred_block(block, result);
-			} else if (result == 0)
-				block->b_granted = 1;
-
-			nlmsvc_insert_block_locked(block, 0);
-			svc_wake_up(block->b_daemon);
-			rc = 0;
+	list_for_each_entry(iter, &nlm_blocked, b_list) {
+		if (nlm_compare_locks(&iter->b_call->a_args.lock.fl, fl)) {
+			kref_get(&iter->b_count);
+			block = iter;
 			break;
 		}
 	}
 	spin_unlock(&nlm_blocked_lock);
-	if (rc == -ENOENT)
-		printk(KERN_WARNING "lockd: grant for unknown block\n");
+
+	if (!block) {
+		pr_warn("lockd: grant for unknown pending block\n");
+		return -ENOENT;
+	}
+
+	/* don't interfere with nlmsvc_lock() */
+	mutex_lock(&block->b_cb_mutex);
+	block->b_flags &= ~B_PENDING_CALLBACK;
+
+	spin_lock(&nlm_blocked_lock);
+	WARN_ON_ONCE(list_empty(&block->b_list));
+	rc = __nlmsvc_grant_deferred(block, fl, result);
+	spin_unlock(&nlm_blocked_lock);
+	mutex_unlock(&block->b_cb_mutex);
+
+	nlmsvc_release_block(block);
 	return rc;
 }
 
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index f42594a9efe0..91f55458f5fc 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -185,10 +185,12 @@ struct nlm_block {
 	struct nlm_file *	b_file;		/* file in question */
 	struct cache_req *	b_cache_req;	/* deferred request handling */
 	struct cache_deferred_req * b_deferred_req;
+	struct mutex		b_cb_mutex;	/* callback mutex */
 	unsigned int		b_flags;	/* block flags */
 #define B_QUEUED		1	/* lock queued */
 #define B_GOT_CALLBACK		2	/* got lock or conflicting lock */
 #define B_TIMED_OUT		4	/* filesystem too slow to respond */
+#define B_PENDING_CALLBACK	8	/* pending callback for lock request */
 };
 
 /*
-- 
2.31.1

