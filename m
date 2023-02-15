Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5004697DB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 14:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBONnp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 08:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBONno (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:43:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDCF39CF4
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 05:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676468546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T0SsL9tL69e2AfNVunWu+DTWNqFzKgbmUmmJkonx498=;
        b=im/lwhoiMvqtbisUaqHjF1TyL6SMIB7T6clBrbSww6u/Irpr5YJeHc2NQWmZK0iVWJeT7v
        QcZFg8aP9uPJc03f5KM/Eier3w8CKdK+UTmQtBplwNzPaj2ixqGFLTInTCwKnIQiYoQCbg
        0E+FBsyilRcRCatXrw/nFz1f+frldFs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-5wCxiagSM1-7Z8llImWl5g-1; Wed, 15 Feb 2023 08:42:25 -0500
X-MC-Unique: 5wCxiagSM1-7Z8llImWl5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E18BD3C0D195;
        Wed, 15 Feb 2023 13:42:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 734682166B30;
        Wed, 15 Feb 2023 13:42:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y+nzO2H8AizX4lAQ@infradead.org>
References: <Y+nzO2H8AizX4lAQ@infradead.org> <Y+UJAdnllBw+uxK+@casper.infradead.org> <20230209102954.528942-1-dhowells@redhat.com> <20230209102954.528942-2-dhowells@redhat.com> <909202.1675959337@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+a440341a59e3b7142895@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] splice: Clean up direct_splice_read() a bit
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3113837.1676468540.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 15 Feb 2023 13:42:20 +0000
Message-ID: <3113838.1676468540@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

How about the attached?  I won't fold it down for the moment, but it could=
 be
pushed along later.

David
---
splice: Clean up direct_splice_read() a bit

Do a couple of cleanups to direct_splice_read():

 (1) Cast to struct page **, not void *.

 (2) Simplify the calculation of the number of pages to keep/reclaim in
     direct_splice_read().

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org

diff --git a/fs/splice.c b/fs/splice.c
index 9e798c901087..572d3e2a669a 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -295,7 +295,7 @@ ssize_t direct_splice_read(struct file *in, loff_t *pp=
os,
 	struct kiocb kiocb;
 	struct page **pages;
 	ssize_t ret;
-	size_t used, npages, chunk, remain, reclaim;
+	size_t used, npages, chunk, remain, keep =3D 0;
 	int i;
 =

 	/* Work out how much data we can actually add into the pipe */
@@ -332,11 +332,8 @@ ssize_t direct_splice_read(struct file *in, loff_t *p=
pos,
 	kiocb.ki_pos =3D *ppos;
 	ret =3D call_read_iter(in, &kiocb, &to);
 =

-	reclaim =3D npages * PAGE_SIZE;
-	remain =3D 0;
 	if (ret > 0) {
-		reclaim -=3D ret;
-		remain =3D ret;
+		keep =3D DIV_ROUND_UP(ret, PAGE_SIZE);
 		*ppos =3D kiocb.ki_pos;
 		file_accessed(in);
 	} else if (ret < 0) {
@@ -349,14 +346,12 @@ ssize_t direct_splice_read(struct file *in, loff_t *=
ppos,
 	}
 =

 	/* Free any pages that didn't get touched at all. */
-	reclaim /=3D PAGE_SIZE;
-	if (reclaim) {
-		npages -=3D reclaim;
-		release_pages(pages + npages, reclaim);
-	}
+	if (keep < npages)
+		release_pages(pages + keep, npages - keep);
 =

 	/* Push the remaining pages into the pipe. */
-	for (i =3D 0; i < npages; i++) {
+	remain =3D ret;
+	for (i =3D 0; i < keep; i++) {
 		struct pipe_buffer *buf =3D pipe_head_buf(pipe);
 =

 		chunk =3D min_t(size_t, remain, PAGE_SIZE);

