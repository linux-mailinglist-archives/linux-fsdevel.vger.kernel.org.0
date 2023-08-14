Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FB977C22B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 23:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjHNVM3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 17:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjHNVMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3895A1737
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692047487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSSlrsFejfUvsXC9yE3hAzAsATkv/23guIVtEFIrrmY=;
        b=ZOKBDQL5vWO8ul+Crt1IM8b5SdxctD9AOGF96FDoCH3lyLkUNgKnkjDeAHkTmKVVgSnpS4
        UAlyxAsc50SGuBNlHmqAQe4pF/lwB5ZiIYQkse9kUfikBksTnpXwRtjriOyQ5z2RQpY0Ex
        vR2HNvo+WhvZR/8TjWEiN2plMnnb9hU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-leEMYXNCOcyXP1rcvNUETg-1; Mon, 14 Aug 2023 17:11:24 -0400
X-MC-Unique: leEMYXNCOcyXP1rcvNUETg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB5D7185A78B;
        Mon, 14 Aug 2023 21:11:23 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FBB5C15BAE;
        Mon, 14 Aug 2023 21:11:23 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org
Subject: [RFCv2 5/7] dlm: use fl_owner from lockd
Date:   Mon, 14 Aug 2023 17:11:14 -0400
Message-Id: <20230814211116.3224759-6-aahringo@redhat.com>
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

This patch is changing the fl_owner value in case of an nfs lock request
to not be the pid of lockd. Instead this patch changes it to be the
owner value that nfs is giving us.

Currently there exists proved problems with this behaviour. One nfsd
server was created to export a gfs2 filesystem mount. Two nfs clients
doing a nfs mount of this export. Those two clients should conflict each
other operating on the same nfs file.

A small test program was written:

int main(int argc, const char *argv[])
{
	struct flock fl = {
		.l_type = F_WRLCK,
		.l_whence = SEEK_SET,
		.l_start = 1L,
		.l_len = 1L,
	};
	int fd;

	fd = open("filename", O_RDWR | O_CREAT, 0700);
	printf("try to lock...\n");
	fcntl(fd, F_SETLKW, &fl);
	printf("locked!\n");
	getc(stdin);

	return 0;
}

Running on both clients at the same time and don't interrupting by
pressing any key. It will show that both clients are able to acquire the
lock which shouldn't be the case. The issue is here that the fl_owner
value is the same and the lock context of both clients should be
separated.

This patch lets lockd define how to deal with lock contexts and chose
hopefully the right fl_owner value. A test after this patch was made and
the locks conflicts each other which should be the case.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/plock.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 00e1d802a81c..0094fa4004cc 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -145,6 +145,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
+	op->info.owner = (__u64)(long)fl->fl_owner;
 	/* async handling */
 	if (fl->fl_lmops && fl->fl_lmops->lm_grant) {
 		op_data = kzalloc(sizeof(*op_data), GFP_NOFS);
@@ -154,9 +155,6 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 			goto out;
 		}
 
-		/* fl_owner is lockd which doesn't distinguish
-		   processes on the nfs client */
-		op->info.owner	= (__u64) fl->fl_pid;
 		op_data->callback = fl->fl_lmops->lm_grant;
 		locks_init_lock(&op_data->flc);
 		locks_copy_lock(&op_data->flc, fl);
@@ -168,8 +166,6 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		send_op(op);
 		rv = FILE_LOCK_DEFERRED;
 		goto out;
-	} else {
-		op->info.owner	= (__u64)(long) fl->fl_owner;
 	}
 
 	send_op(op);
@@ -326,10 +322,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
-	if (fl->fl_lmops && fl->fl_lmops->lm_grant)
-		op->info.owner	= (__u64) fl->fl_pid;
-	else
-		op->info.owner	= (__u64)(long) fl->fl_owner;
+	op->info.owner = (__u64)(long)fl->fl_owner;
 
 	if (fl->fl_flags & FL_CLOSE) {
 		op->info.flags |= DLM_PLOCK_FL_CLOSE;
@@ -389,7 +382,7 @@ int dlm_posix_cancel(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	info.number = number;
 	info.start = fl->fl_start;
 	info.end = fl->fl_end;
-	info.owner = (__u64)fl->fl_pid;
+	info.owner = (__u64)(long)fl->fl_owner;
 
 	rv = do_lock_cancel(&info);
 	switch (rv) {
@@ -450,10 +443,7 @@ int dlm_posix_get(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
 	op->info.end		= fl->fl_end;
-	if (fl->fl_lmops && fl->fl_lmops->lm_grant)
-		op->info.owner	= (__u64) fl->fl_pid;
-	else
-		op->info.owner	= (__u64)(long) fl->fl_owner;
+	op->info.owner = (__u64)(long)fl->fl_owner;
 
 	send_op(op);
 	wait_event(recv_wq, (op->done != 0));
-- 
2.31.1

