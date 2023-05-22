Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FB370C035
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjEVNwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjEVNwT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:52:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27CDE50
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9C/VFkhLRxHq1Y6ot9RmxNuYhTHdz11f1qiRk1qH2g0=;
        b=FBduurpmvEvzjEo9cCdSOWcxsg5Zz75aTinPNK86OehzivEtmg4w5HZYJJmhEuTD5BWbSI
        w/AlAKZY2/2+tmXxP3LWdchEJUlgHvLv0cFqONnn0vYDT4r4cLXgJfG/ZWM0y22s6sw6gK
        K5epBUiWFvoRjg22V6Nfe0BQzN3+dIE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-yJ4lna96OoqIQQett0IxRw-1; Mon, 22 May 2023 09:50:58 -0400
X-MC-Unique: yJ4lna96OoqIQQett0IxRw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA9502812946;
        Mon, 22 May 2023 13:50:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C7CF20296C6;
        Mon, 22 May 2023 13:50:52 +0000 (UTC)
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
        Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH v22 08/31] splice: Make splice from a DAX file use copy_splice_read()
Date:   Mon, 22 May 2023 14:49:55 +0100
Message-Id: <20230522135018.2742245-9-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make a read splice from a DAX file go directly to copy_splice_read() to do
the reading as filemap_splice_read() is unlikely to find any pagecache to
splice.

I think this affects only erofs, Ext2, Ext4, fuse and XFS.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-erofs@lists.ozlabs.org
cc: linux-ext4@vger.kernel.org
cc: linux-xfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---

Notes:
    ver #21)
     - Don't need #ifdef CONFIG_FS_DAX as IS_DAX() is false if !CONFIG_FS_DAX.
     - Needs to be in vfs_splice_read(), not generic_file_splice_read().

 fs/splice.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 76126b1aafcb..8268248df3a9 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -908,10 +908,10 @@ long vfs_splice_read(struct file *in, loff_t *ppos,
 	if (unlikely(!in->f_op->splice_read))
 		return warn_unsupported(in, "read");
 	/*
-	 * O_DIRECT doesn't deal with the pagecache, so we allocate a buffer,
-	 * copy into it and splice that into the pipe.
+	 * O_DIRECT and DAX don't deal with the pagecache, so we allocate a
+	 * buffer, copy into it and splice that into the pipe.
 	 */
-	if ((in->f_flags & O_DIRECT))
+	if ((in->f_flags & O_DIRECT) || IS_DAX(in->f_mapping->host))
 		return copy_splice_read(in, ppos, pipe, len, flags);
 	return in->f_op->splice_read(in, ppos, pipe, len, flags);
 }

