Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E4D79DB3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 23:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbjILVzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 17:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237627AbjILVz0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:55:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF5A710FD
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 14:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694555635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WKKgxmIlfy876ZCkegSn2o5H5r0hmbOJQT9z4FozSm0=;
        b=brL4vfRxkj4C4Y3yxio6AhtOBeT3Vo/+Cyg00bKhpc/dLPb5ZWXt5wA2iYuaYs9ofnSITx
        PGeZIoLFcAviBjYeUPPUdBGBUJ2SABLGQxAPHtoPvkXWt4th5CHyggh6kWxqque2UUKb3f
        quHWTOoL+ReHpk3GO9c1yZpcc00G2BE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-u60wuQfRNNGAfCVGSoidmw-1; Tue, 12 Sep 2023 17:53:49 -0400
X-MC-Unique: u60wuQfRNNGAfCVGSoidmw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2011D816529;
        Tue, 12 Sep 2023 21:53:49 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C71A940C2009;
        Tue, 12 Sep 2023 21:53:48 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     gfs2@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, aahringo@redhat.com
Subject: [PATCHv2 nfsd/master 6/7] dlm: use FL_SLEEP to determine blocking vs non-blocking
Date:   Tue, 12 Sep 2023 17:53:23 -0400
Message-Id: <20230912215324.3310111-7-aahringo@redhat.com>
In-Reply-To: <20230912215324.3310111-1-aahringo@redhat.com>
References: <20230912215324.3310111-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch uses the FL_SLEEP flag in struct file_lock to determine if
the lock request is a blocking or non-blocking request. Before dlm was
using IS_SETLKW() was being used which is not usable for lock requests
coming from lockd when EXPORT_OP_ASYNC_LOCK inside the export flags
is set.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/plock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index ee6e0236d4f8..d814c5121367 100644
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

