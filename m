Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D7C70B72B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 09:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjEVH5S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 03:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjEVH4q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 03:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DE1B6
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 00:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684742121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+Y/VY/1bCM7OTbyEqv3AVM1otfl3olIIYs7Uq2R/A4=;
        b=Flp0/U8ydaXqe6G3E9h3Emts9sIwoUaBYu2c/NVX/Laj+zzQ9tqoFBdcnxuVUUlZ7MNypn
        zGX6skNrYXIFkR0XZR7ZyhBlhK+lyf6Mf17aq2njDPCt5UZ/pG8YCPlBt+lc/Yu35uDyz2
        +V0O5vdvn1cwm1iQrRMRHfPxlunDTM0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-Fp-BK7lKNVK23BF0WPdKPQ-1; Mon, 22 May 2023 03:55:19 -0400
X-MC-Unique: Fp-BK7lKNVK23BF0WPdKPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 129AC1C02D2D;
        Mon, 22 May 2023 07:55:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18E20C54184;
        Mon, 22 May 2023 07:55:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230520-sekunde-vorteil-f2d588e40b68@brauner>
References: <20230520-sekunde-vorteil-f2d588e40b68@brauner> <20230520000049.2226926-1-dhowells@redhat.com> <20230520000049.2226926-4-dhowells@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH v21 03/30] splice: Rename direct_splice_read() to copy_splice_read()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2468126.1684742114.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 22 May 2023 08:55:14 +0100
Message-ID: <2468127.1684742114@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> For the future it'd be nice if exported functions would always get
> proper kernel doc,

Something like the attached?

David
---
commit 0362042ba0751fc5457b0548fb9006f9d7dfbeca
Author: David Howells <dhowells@redhat.com>
Date:   Mon May 22 08:34:24 2023 +0100

    splice: kdoc for filemap_splice_read() and copy_splice_read()
    =

    Provide kerneldoc comments for filemap_splice_read() and
    copy_splice_read().
    =

    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Christian Brauner <brauner@kernel.org>
    cc: Christoph Hellwig <hch@lst.de>
    cc: Jens Axboe <axboe@kernel.dk>
    cc: Steve French <smfrench@gmail.com>
    cc: Al Viro <viro@zeniv.linux.org.uk>
    cc: linux-mm@kvack.org
    cc: linux-block@vger.kernel.org
    cc: linux-cifs@vger.kernel.org
    cc: linux-fsdevel@vger.kernel.org

diff --git a/fs/splice.c b/fs/splice.c
index 9be4cb3b9879..5292a8fa929d 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -299,8 +299,25 @@ void splice_shrink_spd(struct splice_pipe_desc *spd)
 	kfree(spd->partial);
 }
 =

-/*
- * Copy data from a file into pages and then splice those into the output=
 pipe.
+/**
+ * copy_splice_read -  Copy data from a file and splice the copy into a p=
ipe
+ * @in: The file to read from
+ * @ppos: Pointer to the file position to read from
+ * @pipe: The pipe to splice into
+ * @len: The amount to splice
+ * @flags: The SPLICE_F_* flags
+ *
+ * This function allocates a bunch of pages sufficient to hold the reques=
ted
+ * amount of data (but limited by the remaining pipe capacity), passes it=
 to
+ * the file's ->read_iter() to read into and then splices the used pages =
into
+ * the pipe.
+ *
+ * On success, the number of bytes read will be returned and *@ppos will =
be
+ * updated if appropriate; 0 will be returned if there is no more data to=
 be
+ * read; -EAGAIN will be returned if the pipe had no space, and some othe=
r
+ * negative error code will be returned on error.  A short read may occur=
 if
+ * the pipe has insufficient space, we reach the end of the data or we hi=
t a
+ * hole.
  */
 ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 			 struct pipe_inode_info *pipe,
diff --git a/mm/filemap.c b/mm/filemap.c
index 603b562d69b1..1f235a6430fd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2871,9 +2871,24 @@ size_t splice_folio_into_pipe(struct pipe_inode_inf=
o *pipe,
 	return spliced;
 }
 =

-/*
- * Splice folios from the pagecache of a buffered (ie. non-O_DIRECT) file=
 into
- * a pipe.
+/**
+ * filemap_splice_read -  Splice data from a file's pagecache into a pipe
+ * @in: The file to read from
+ * @ppos: Pointer to the file position to read from
+ * @pipe: The pipe to splice into
+ * @len: The amount to splice
+ * @flags: The SPLICE_F_* flags
+ *
+ * This function gets folios from a file's pagecache and splices them int=
o the
+ * pipe.  Readahead will be called as necessary to fill more folios.  Thi=
s may
+ * be used for blockdevs also.
+ *
+ * On success, the number of bytes read will be returned and *@ppos will =
be
+ * updated if appropriate; 0 will be returned if there is no more data to=
 be
+ * read; -EAGAIN will be returned if the pipe had no space, and some othe=
r
+ * negative error code will be returned on error.  A short read may occur=
 if
+ * the pipe has insufficient space, we reach the end of the data or we hi=
t a
+ * hole.
  */
 ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 			    struct pipe_inode_info *pipe,

