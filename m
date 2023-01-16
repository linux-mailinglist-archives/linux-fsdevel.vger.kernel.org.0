Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4871866D2DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbjAPXPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjAPXOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:14:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215243018D
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QRj9zo8/4XGZMXr1F9brjuZIjMqL4+pPYiSkNjAxJaI=;
        b=ADNhJ5RaphOyrv2VKiTQ0d86cKMMX33CC0AL2olvSwdfWuy8XoDsDkkY3fLJKLCF6sUo8Q
        sjhbxEP3flogl470hXSRpBi9+xVsDs6ilkigM7AB1z7LZmrAvDA3R5HGTTllSEnXZ4B1m3
        19X+TLFFo0alVpqvHc31V9KDl5yjDzI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-R7KYRgH-NsqGjrjFzNEidA-1; Mon, 16 Jan 2023 18:10:27 -0500
X-MC-Unique: R7KYRgH-NsqGjrjFzNEidA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4611F2A59556;
        Mon, 16 Jan 2023 23:10:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F21AD51FF;
        Mon, 16 Jan 2023 23:10:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 20/34] vfs: Make splice use iov_iter_extract_pages()
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 23:10:25 +0000
Message-ID: <167391062544.2311931.15195962488932892568.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make splice's iter_to_pipe() use iov_iter_extract_pages().  Splice requests
will rejected if the request if the cleanup mode is going to be anything
other than put_pages() since we're going to be attaching pages from the
iterator to a pipe and then returning to the caller, leaving the spliced
pages to their fates at some unknown time in the future.

Note this will cause some requests to fail that could work before - such as
splicing from an XARRAY-type iterator - if there's any way to do it as
extraction doesn't take refs or pins on non-user-backed iterators.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-fsdevel@vger.kernel.org
---

 fs/splice.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 19c5b5adc548..c3433266ba1b 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1159,14 +1159,18 @@ static int iter_to_pipe(struct iov_iter *from,
 	size_t total = 0;
 	int ret = 0;
 
+	/* For the moment, all pages attached to a pipe must have refs, not pins. */
+	if (WARN_ON(iov_iter_extract_mode(from, FOLL_SOURCE_BUF) != FOLL_GET))
+		return -EIO;
+
 	while (iov_iter_count(from)) {
-		struct page *pages[16];
+		struct page *pages[16], **ppages = pages;
 		ssize_t left;
 		size_t start;
 		int i, n;
 
-		left = iov_iter_get_pages(from, pages, ~0UL, 16, &start,
-					  FOLL_SOURCE_BUF);
+		left = iov_iter_extract_pages(from, &ppages, ~0UL, 16,
+					      FOLL_SOURCE_BUF, &start);
 		if (left <= 0) {
 			ret = left;
 			break;


