Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C37786272
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 23:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238138AbjHWVfy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 17:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbjHWVfh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766F710EF
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692826441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MHYX4a6Baf9t0hYlusUokWnG9KN4LxtXmYn0dFm/ZDM=;
        b=EDSGm0ZMxL/Y/ARssEh0hbvWESPADuerKrmUzdKaO0PI5EP7lwlYGphBljVrnYOGt9G9wR
        odMAWzQbXtAxbgPjkwLiCGYMNbjsnY4xcACtpTzH+kjjVZStLCZSUr7R9OYi1mnzcTfTOI
        zXK9mulQI9P1ayMG1djvG3jKccjUP8k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-7W_F9yi9MmS-MNHeCgyAGw-1; Wed, 23 Aug 2023 17:33:56 -0400
X-MC-Unique: 7W_F9yi9MmS-MNHeCgyAGw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C690A856DED;
        Wed, 23 Aug 2023 21:33:55 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E5BF400E02F;
        Wed, 23 Aug 2023 21:33:55 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     cluster-devel@redhat.com, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org
Subject: [PATCH 6/7] dlm: use FL_SLEEP to determine blocking vs non-blocking
Date:   Wed, 23 Aug 2023 17:33:51 -0400
Message-Id: <20230823213352.1971009-7-aahringo@redhat.com>
In-Reply-To: <20230823213352.1971009-1-aahringo@redhat.com>
References: <20230823213352.1971009-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch uses the FL_SLEEP flag in struct file_lock to determine if
the lock request is a blocking or non-blocking request. Before dlm was
using IS_SETLKW() was being used which is not usable for lock requests
coming from lockd when EXPORT_OP_SAFE_ASYNC_LOCK inside the export flags
is set.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/plock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 0094fa4004cc..0c6ed5eeb840 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -140,7 +140,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 	op->info.optype		= DLM_PLOCK_OP_LOCK;
 	op->info.pid		= fl->fl_pid;
 	op->info.ex		= (fl->fl_type == F_WRLCK);
-	op->info.wait		= IS_SETLKW(cmd);
+	op->info.wait		= !!(fl->fl_flags & FL_SLEEP);
 	op->info.fsid		= ls->ls_global_id;
 	op->info.number		= number;
 	op->info.start		= fl->fl_start;
-- 
2.31.1

