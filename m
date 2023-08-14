Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB69077C236
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 23:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjHNVNC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 17:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjHNVM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83B1173A
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 14:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692047487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tZEXFed81ekvMweSZpvZmhvnw/W3DW6CK17WR1HloMI=;
        b=TnA+b6TAWuu/JyB2YJNDh51HFBdwNcm4l7aIIgT2otlWp8y40yF1szAYAYit80OTAVY0Ln
        pqvocIQrNb4hzsUUXVekX8MGDJJ1pC+t0UCK/cR9TIDUpuf30UsziXpdJpyK/299bENhiS
        ZOnM0YXYxqIB1571SQOfPjc5+QFORFM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-OwVOreIAOrWvXEOKEJzbog-1; Mon, 14 Aug 2023 17:11:24 -0400
X-MC-Unique: OwVOreIAOrWvXEOKEJzbog-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BE3F3C0253A;
        Mon, 14 Aug 2023 21:11:24 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0000CC15BAD;
        Mon, 14 Aug 2023 21:11:23 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org
Subject: [RFCv2 6/7] dlm: use FL_SLEEP to check if blocking request
Date:   Mon, 14 Aug 2023 17:11:15 -0400
Message-Id: <20230814211116.3224759-7-aahringo@redhat.com>
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

This patch uses the FL_SLEEP flag in struct file_lock to check if it's a
blocking request in case if the request coming from nfs lockd process
indicated by lm_grant() is set.

IF FL_SLEEP is set a asynchronous blocking request is being made and
it's waiting for lm_grant() callback being called to signal the lock was
granted. If it's not set a synchronous non-blocking request is being made.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/plock.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 0094fa4004cc..524771002a2f 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -140,7 +140,6 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	op->info.optype		= DLM_PLOCK_OP_LOCK;
 	op->info.pid		= fl->fl_pid;
 	op->info.ex		= (fl->fl_type == F_WRLCK);
-	op->info.wait		= IS_SETLKW(cmd);
 	op->info.fsid		= ls->ls_global_id;
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
@@ -148,24 +147,31 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	op->info.owner = (__u64)(long)fl->fl_owner;
 	/* async handling */
 	if (fl->fl_lmops && fl->fl_lmops->lm_grant) {
-		op_data = kzalloc(sizeof(*op_data), GFP_NOFS);
-		if (!op_data) {
-			dlm_release_plock_op(op);
-			rv = -ENOMEM;
-			goto out;
-		}
+		if (fl->fl_flags & FL_SLEEP) {
+			op_data = kzalloc(sizeof(*op_data), GFP_NOFS);
+			if (!op_data) {
+				dlm_release_plock_op(op);
+				rv = -ENOMEM;
+				goto out;
+			}
 
-		op_data->callback = fl->fl_lmops->lm_grant;
-		locks_init_lock(&op_data->flc);
-		locks_copy_lock(&op_data->flc, fl);
-		op_data->fl		= fl;
-		op_data->file	= file;
+			op->info.wait = 1;
+			op_data->callback = fl->fl_lmops->lm_grant;
+			locks_init_lock(&op_data->flc);
+			locks_copy_lock(&op_data->flc, fl);
+			op_data->fl		= fl;
+			op_data->file	= file;
 
-		op->data = op_data;
+			op->data = op_data;
 
-		send_op(op);
-		rv = FILE_LOCK_DEFERRED;
-		goto out;
+			send_op(op);
+			rv = FILE_LOCK_DEFERRED;
+			goto out;
+		} else {
+			op->info.wait = 0;
+		}
+	} else {
+		op->info.wait = IS_SETLKW(cmd);
 	}
 
 	send_op(op);
-- 
2.31.1

