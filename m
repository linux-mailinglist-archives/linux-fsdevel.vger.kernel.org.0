Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8CB75913C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 11:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGSJK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 05:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjGSJK6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A04121
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jul 2023 02:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689757815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aMIgzXiT1F2iEJnG15o5FqJ6MShjQORJM5LN2yDl3KI=;
        b=aJQtS3NO2hYHYF/3bv13bvEDsTmrbU+7uffuykWZVdLAsnYpi8ezRwHZQKVt+oGBzIhSkM
        TLoFisY361TvJfJfVS7HBpdD7tdmnaRj+FfMjvlWo96LWDkR40LIlsONRqzSUz6lOQ8hXo
        bY2XJEN9g60RoEeNHCDz+8MHji+K7Zg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-WzdpLWmjPkmtkdFW_z-X1A-1; Wed, 19 Jul 2023 05:10:11 -0400
X-MC-Unique: WzdpLWmjPkmtkdFW_z-X1A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28B5688D580;
        Wed, 19 Jul 2023 09:10:11 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6ADBF6CCA;
        Wed, 19 Jul 2023 09:10:09 +0000 (UTC)
From:   Jan Stancek <jstancek@redhat.com>
To:     dhowells@redhat.com, kuba@kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, jstancek@redhat.com
Subject: [PATCH] splice, net: Fix splice_to_socket() for O_NONBLOCK socket
Date:   Wed, 19 Jul 2023 11:07:52 +0200
Message-Id: <7854000d2ce5ac32b75782a7c4574f25a11b573d.1689757133.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

LTP sendfile07 [1], which expects sendfile() to return EAGAIN when
transferring data from regular file to a "full" O_NONBLOCK socket,
started failing after commit 2dc334f1a63a ("splice, net: Use
sendmsg(MSG_SPLICE_PAGES) rather than ->sendpage()").
sendfile() no longer immediately returns, but now blocks.

Removed sock_sendpage() handled this case by setting a MSG_DONTWAIT
flag, fix new splice_to_socket() to do the same for O_NONBLOCK sockets.

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/sendfile/sendfile07.c

Fixes: 2dc334f1a63a ("splice, net: Use sendmsg(MSG_SPLICE_PAGES) rather than ->sendpage()")
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 fs/splice.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 004eb1c4ce31..3e2a31e1ce6a 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -876,6 +876,8 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 			msg.msg_flags |= MSG_MORE;
 		if (remain && pipe_occupancy(pipe->head, tail) > 0)
 			msg.msg_flags |= MSG_MORE;
+		if (out->f_flags & O_NONBLOCK)
+			msg.msg_flags |= MSG_DONTWAIT;
 
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, bvec, bc,
 			      len - remain);
-- 
2.31.1

