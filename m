Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7433562902
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 04:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiGACaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 22:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiGACaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D2D6599FE
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 19:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656642608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQz5T2SvnREyVd422FUfN9wuhrBc8hz6OFIwBIgy+C4=;
        b=OqLk9mfhx8LzU79yL8IsrCf9siFKlHg01La3/EkXZfUTd5hmzjYvCPEQ+pAouuGzUC6qie
        qGgnab58vnSY7TfsGo/Ca76F0s09GzrU5/BFvE9PFWmQ5tJiDXG84btKJEiUGBOJelFrzC
        +DqHvnlPs6GvcnbOu6lsIMKsJSI5VOY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-NEJFAeYDO4uDDcgj9LEyvw-1; Thu, 30 Jun 2022 22:30:04 -0400
X-MC-Unique: NEJFAeYDO4uDDcgj9LEyvw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 702CF101A588;
        Fri,  1 Jul 2022 02:30:04 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5CBBC2026D64;
        Fri,  1 Jul 2022 02:30:00 +0000 (UTC)
From:   xiubli@redhat.com
To:     jlayton@kernel.org, idryomov@gmail.com, dhowells@redhat.com
Cc:     vshankar@redhat.com, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, willy@infradead.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH 2/2] ceph: do not release the folio lock in kceph
Date:   Fri,  1 Jul 2022 10:29:47 +0800
Message-Id: <20220701022947.10716-3-xiubli@redhat.com>
In-Reply-To: <20220701022947.10716-1-xiubli@redhat.com>
References: <20220701022947.10716-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

The netfs layer should be responsible to unlock and put the folio,
and we will always return 0 when succeeds.

URL: https://tracker.ceph.com/issues/56423
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/addr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index fe6147f20dee..3ef5200e2005 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1310,16 +1310,16 @@ static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned
 	if (snapc) {
 		int r;
 
-		folio_unlock(folio);
-		folio_put(folio);
 		if (IS_ERR(snapc))
 			return PTR_ERR(snapc);
 
+		folio_unlock(folio);
 		ceph_queue_writeback(inode);
 		r = wait_event_killable(ci->i_cap_wq,
 					context_is_writeable_or_written(inode, snapc));
 		ceph_put_snap_context(snapc);
-		return r == 0 ? -EAGAIN : r;
+		folio_lock(folio);
+		return r == 0 ? -EAGAIN : 0;
 	}
 	return 0;
 }
-- 
2.36.0.rc1

