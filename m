Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AEE566187
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 04:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbiGECxX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jul 2022 22:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiGECxS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC04412ADE
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Jul 2022 19:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656989597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IO5s2XTb28ds6WNmuxbOoWdKOYzQy22aHcNkPEZLzDI=;
        b=MSb5VxlSONgKIAZEbWL1PR40hkvOOB7yz1iUGX2MdTcZnWuRUBM4coFhYkXVg57Up8jO1s
        PH7u6H0xZSqpWhcr7BK0zOjoI8HxbgKhUSIeQq/5G7bCkMka0c7ITQfvO2YV65lf2dbOGY
        bTsyuk/GncBJbcadt5fKilcyiXsiWr0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-VJrG7vTiMjCp7-_rw66tVg-1; Mon, 04 Jul 2022 22:53:12 -0400
X-MC-Unique: VJrG7vTiMjCp7-_rw66tVg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BC0E101A58E;
        Tue,  5 Jul 2022 02:53:11 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A82FD492C3B;
        Tue,  5 Jul 2022 02:53:07 +0000 (UTC)
From:   xiubli@redhat.com
To:     dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, ceph-devel@vger.kernel.org,
        marc.dionne@auristor.com, linux-afs@lists.infradead.org,
        Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v2 2/2] afs: unlock the folio when vnode is marked deleted
Date:   Tue,  5 Jul 2022 10:52:55 +0800
Message-Id: <20220705025255.331695-3-xiubli@redhat.com>
In-Reply-To: <20220705025255.331695-1-xiubli@redhat.com>
References: <20220705025255.331695-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

The check_write_begin() should unlock the folio if return non-zero,
otherwise locked.

URL: https://tracker.ceph.com/issues/56423
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/afs/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 42118a4f3383..5a9ed181d724 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -379,7 +379,13 @@ static int afs_check_write_begin(struct file *file, loff_t pos, unsigned len,
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 
-	return test_bit(AFS_VNODE_DELETED, &vnode->flags) ? -ESTALE : 0;
+	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
+		folio_unlock(folio);
+		folio_put(folio);
+		return -ESTALE;
+	}
+
+	return 0;
 }
 
 static void afs_free_request(struct netfs_io_request *rreq)
-- 
2.36.0.rc1

