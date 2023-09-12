Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF6779DB38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 23:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbjILVzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 17:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjILVzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9627C10EF
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 14:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694555632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=izRMO0+clPHPJelBQ3I6SnaOJe4iPlUB6R2hsGJNWFo=;
        b=hfxkWG63f6aDbBgjb9NkptSbNCDwktJ8xv+slb/RPmlJJTKoWxTXdWznCyCKY6eiR7NY2O
        MCFoeYZc2rin9X73+YbP1W99QS/3vgkcUPQDKYBVdpgwd6eTWW+9W9l5yIBolRIHtbA+26
        vU8Tujzd1a6MukpKTze1/98b2cYtFOo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-RTPqsAnpPkKjcFCRwolZfQ-1; Tue, 12 Sep 2023 17:53:49 -0400
X-MC-Unique: RTPqsAnpPkKjcFCRwolZfQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0D7F29ABA2B;
        Tue, 12 Sep 2023 21:53:48 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7417740C2009;
        Tue, 12 Sep 2023 21:53:48 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     gfs2@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, aahringo@redhat.com
Subject: [PATCHv2 nfsd/master 5/7] dlm: use fl_owner from lockd
Date:   Tue, 12 Sep 2023 17:53:22 -0400
Message-Id: <20230912215324.3310111-6-aahringo@redhat.com>
In-Reply-To: <20230912215324.3310111-1-aahringo@redhat.com>
References: <20230912215324.3310111-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Acked-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/plock.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index e6b4c1a21446..ee6e0236d4f8 100644
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

