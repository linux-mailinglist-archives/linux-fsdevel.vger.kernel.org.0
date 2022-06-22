Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F67A554176
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 06:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356902AbiFVERA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 00:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356845AbiFVEQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 00:16:10 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A4FB7EA
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jun 2022 21:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XO8RatToLOYlx5LqtT10Kw6Qkwp7D31l2wdQV5VDJCQ=; b=Jx4GAwsit5tbwMiF8FH0gLGTDH
        +HQ1G71/iYAK7tnLy1ASylqDrgXQMvrkL44b0HGXeUDUuG7PM+uuJMRM+zT6gAROclL53sbK2kbEw
        v1K6BTv40EFLg0kF7AcM/1K1Lq3s+XVmZ90NoaW+iUiyIC3tpclxeialYKFTCAlTl7oLuj1IJamKm
        lYxxvEnj2z4rtVhNCKDjxJUQ6wR/aOxdTXmwLdBP1lnkNIlF2oPgPqN1Ns3DzLuMPplaj3Y98wnxi
        2IOdabpo1uu1soQGZjnuZ05WL3R+y45iIHUT769HmyCtNDSG0BRjSofqb4TgxMlqygrCtjtdVahgj
        sakWBEyQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o3rma-003608-3G;
        Wed, 22 Jun 2022 04:16:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 41/44] ceph: switch the last caller of iov_iter_get_pages_alloc()
Date:   Wed, 22 Jun 2022 05:15:49 +0100
Message-Id: <20220622041552.737754-41-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622041552.737754-1-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
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

