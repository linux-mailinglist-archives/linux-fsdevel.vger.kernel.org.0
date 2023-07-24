Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF04D75FDFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 19:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjGXRmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 13:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGXRmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:42:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D795E55
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 10:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690220490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=j48/9P37CpBRGRsqJBOd0KCivq5UbeFFAqfa49yRMBk=;
        b=BItzssYRKgb2PptzNRUJIehA0S7BaiM0EZvK/QbfaLuvaxV33LQuEGP7UGXBgoFxp2kBQ1
        iUMCPnoDYcNsC/x3dvvOCFSGe2iUpDvFKh5kudFFhO1CAT7VVCxaH7ziPaAuEF7cWkhiy5
        Prut5ghbIE3tcCgMEpS21N5grJkFyjs=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-4f5zd9PFNOuws8Q3x83PtA-1; Mon, 24 Jul 2023 13:41:25 -0400
X-MC-Unique: 4f5zd9PFNOuws8Q3x83PtA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C61062A5957E;
        Mon, 24 Jul 2023 17:41:24 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B673400F1F;
        Mon, 24 Jul 2023 17:41:23 +0000 (UTC)
From:   Jan Stancek <jstancek@redhat.com>
To:     dhowells@redhat.com, kuba@kernel.org, netdev@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk, jstancek@redhat.com
Subject: [PATCH v2] splice, net: Fix splice_to_socket() for O_NONBLOCK socket
Date:   Mon, 24 Jul 2023 19:39:04 +0200
Message-Id: <023c0e21e595e00b93903a813bc0bfb9a5d7e368.1690219914.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
Changes in v2:
- add David's Acked-by
- add netdev list

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

