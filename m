Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2F656617E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 04:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbiGECxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jul 2022 22:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiGECxN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EC0712ACF
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Jul 2022 19:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656989590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5gBDt9xizJowYxZ6K4OUy4YfwIDH6udc7YJZaKywnk=;
        b=BRT0Hq0UwyVBmJCBKbsK3XxK9ec1YytHM4cyC9Q7Lwz7soF3+vL+k+o4P/HhyHf6XsTSSu
        n6F4NFkP9yeofjbJpTQ/d5BpOWspOhAyVyOvLYK31gSuHxczS+kL2sJ1GytrvgXd2rAZk6
        cSygQ0rdRD/8TUSdHn147aJS07jyX/E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-d4L5pg-wNECoB06x4-JZ1A-1; Mon, 04 Jul 2022 22:53:07 -0400
X-MC-Unique: d4L5pg-wNECoB06x4-JZ1A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BD7385A582;
        Tue,  5 Jul 2022 02:53:07 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48E33492C3B;
        Tue,  5 Jul 2022 02:53:02 +0000 (UTC)
From:   xiubli@redhat.com
To:     dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, ceph-devel@vger.kernel.org,
        marc.dionne@auristor.com, linux-afs@lists.infradead.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v2 1/2] netfs: do not unlock and put the folio twice
Date:   Tue,  5 Jul 2022 10:52:54 +0800
Message-Id: <20220705025255.331695-2-xiubli@redhat.com>
In-Reply-To: <20220705025255.331695-1-xiubli@redhat.com>
References: <20220705025255.331695-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

check_write_begin() will unlock and put the folio when return
non-zero. So we should avoid unlocking and putting it twice in
netfs layer.

URL: https://tracker.ceph.com/issues/56423
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/netfs/buffered_read.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 42f892c5712e..b6fd6e5fe019 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -320,7 +320,7 @@ static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
  * pointer to the fsdata cookie that gets returned to the VM to be passed to
  * write_end.  It is permitted to sleep.  It should return 0 if the request
  * should go ahead; unlock the folio and return -EAGAIN to cause the folio to
- * be regot; or return an error.
+ * be regot; or unlock the folio and return an error.
  *
  * The calling netfs must initialise a netfs context contiguous to the vfs
  * inode before calling this.
@@ -353,7 +353,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 			trace_netfs_failure(NULL, NULL, ret, netfs_fail_check_write_begin);
 			if (ret == -EAGAIN)
 				goto retry;
-			goto error;
+			goto error_unlocked;
 		}
 	}
 
@@ -375,7 +375,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 				   NETFS_READ_FOR_WRITE);
 	if (IS_ERR(rreq)) {
 		ret = PTR_ERR(rreq);
-		goto error;
+		goto error_locked;
 	}
 	rreq->no_unlock_folio	= folio_index(folio);
 	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
@@ -402,12 +402,12 @@ int netfs_write_begin(struct netfs_inode *ctx,
 
 	ret = netfs_begin_read(rreq, true);
 	if (ret < 0)
-		goto error;
+		goto error_locked;
 
 have_folio:
 	ret = folio_wait_fscache_killable(folio);
 	if (ret < 0)
-		goto error;
+		goto error_locked;
 have_folio_no_wait:
 	*_folio = folio;
 	_leave(" = 0");
@@ -415,9 +415,10 @@ int netfs_write_begin(struct netfs_inode *ctx,
 
 error_put:
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_failed);
-error:
+error_locked:
 	folio_unlock(folio);
 	folio_put(folio);
+error_unlocked:
 	_leave(" = %d", ret);
 	return ret;
 }
-- 
2.36.0.rc1

