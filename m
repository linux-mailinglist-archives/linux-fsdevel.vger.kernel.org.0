Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C00C550300
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbiFRFgW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbiFRFgC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:36:02 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE2968987
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XO8RatToLOYlx5LqtT10Kw6Qkwp7D31l2wdQV5VDJCQ=; b=CzlYwJyxdW41H/fj/ZKLImHI5e
        7erRUiv0ZOp+HSnPdNrCPfrBHQgYi7wa9qd8JjKwaIiCvmOuc8ghR+IXnpT9CIrgqwIN76tA8iKhU
        Sy6W+NkM2MngLPFf35nQrTq/3e6/HOpW1gNjv1NHorP5xFfcQQezaQJThyOjev+iCGVTQOh7W/3U8
        bQaSK0R6pfVDOVVBKPxpWo58NyWGvQNkK0EtabfH1Qoizb7l2k7AgbVrQQpRDh/Sc8YOBrAB9+Cgl
        eKFblD5JH9TZKqIqK8ZZnz5D5ZuMZD+uIVyyvOUneX1FL9AJIiENVxhsmKf0OimmmHvOK1Yog8jHb
        +GY11SMA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2R7X-001VS0-Kp;
        Sat, 18 Jun 2022 05:35:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 28/31] ceph: switch the last caller of iov_iter_get_pages_alloc()
Date:   Sat, 18 Jun 2022 06:35:35 +0100
Message-Id: <20220618053538.359065-29-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618053538.359065-1-viro@zeniv.linux.org.uk>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

here nothing even looks at the iov_iter after the call, so we couldn't
care less whether it advances or not.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/ceph/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6dee88815491..3c8a7cf19e5d 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -329,7 +329,7 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 
 	dout("%s: pos=%llu orig_len=%zu len=%llu\n", __func__, subreq->start, subreq->len, len);
 	iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages, subreq->start, len);
-	err = iov_iter_get_pages_alloc(&iter, &pages, len, &page_off);
+	err = iov_iter_get_pages_alloc2(&iter, &pages, len, &page_off);
 	if (err < 0) {
 		dout("%s: iov_ter_get_pages_alloc returned %d\n", __func__, err);
 		goto out;
-- 
2.30.2

