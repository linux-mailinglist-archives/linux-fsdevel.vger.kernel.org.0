Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7726A70A38B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 May 2023 02:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjETABw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 20:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjETABt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 20:01:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95FCE49
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 17:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684540862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j9lKnYQLAbUm3aZ6/GDqCuwrLRq8hWqBI2gRgBsDQ1U=;
        b=EcSn++6UvIY1mUa78/TBg4jHLDhNCxouCyL4Z75WTD9o2DSPwDfHSBnYeC9HlYLFUnzNFf
        u3fQ0oY15hRlA435D7l5btq1RbyAPv1S5eG7qNaT5hxHCvcRTaWnF8t/W1Y4V+gU2UW4v9
        /Pc0fJCeT2SDuobmGZSslic6HCiPs5I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-HCwIrqq4N0uEJGXPHYI5kg-1; Fri, 19 May 2023 20:00:57 -0400
X-MC-Unique: HCwIrqq4N0uEJGXPHYI5kg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA588800969;
        Sat, 20 May 2023 00:00:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE04C2166B25;
        Sat, 20 May 2023 00:00:54 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Steve French <stfrench@microsoft.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v21 01/30] splice: Fix filemap of a blockdev
Date:   Sat, 20 May 2023 01:00:20 +0100
Message-Id: <20230520000049.2226926-2-dhowells@redhat.com>
In-Reply-To: <20230520000049.2226926-1-dhowells@redhat.com>
References: <20230520000049.2226926-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix filemap_splice_read() to use file->f_mapping->host, not file->f_inode,
as the source of the file size because in the case of a block device,
file->f_inode points to the block-special file (which is typically 0
length) and not the backing store.

Fixes: 07073eb01c5f ("splice: Add a func to do a splice from a buffered file without ITER_PIPE")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
cc: Steve French <stfrench@microsoft.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 mm/filemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b4c9bd368b7e..a2006936a6ae 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2900,7 +2900,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 	do {
 		cond_resched();
 
-		if (*ppos >= i_size_read(file_inode(in)))
+		if (*ppos >= i_size_read(in->f_mapping->host))
 			break;
 
 		iocb.ki_pos = *ppos;
@@ -2916,7 +2916,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 		 * part of the page is not copied back to userspace (unless
 		 * another truncate extends the file - this is desired though).
 		 */
-		isize = i_size_read(file_inode(in));
+		isize = i_size_read(in->f_mapping->host);
 		if (unlikely(*ppos >= isize))
 			break;
 		end_offset = min_t(loff_t, isize, *ppos + len);

