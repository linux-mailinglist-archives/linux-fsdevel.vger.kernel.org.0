Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5498C697FC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 16:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjBOPmW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 10:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjBOPmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:42:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C023866B
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 07:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676475669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Us0zCop2bZgqcPW/JXsl5O/r2nwlZx53CdefM19JIrA=;
        b=O1bfMbTkva/nAHkOFP6VlwmPxkeINoo9LNoNsKbSxwqtkhZMp86Fz7+RE8NsSdYtiqWf9u
        EiX9A+iOKRBb25II7NFbn1cowzeckeRkYGsI/QUsr2HTLjZQfKRn545Z4GthoUufqcgAOH
        E7Jb45NfWkMl+tO7TzL4gHNO17OpFRk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-LVpfoPQGNw6GNKM_irhueg-1; Wed, 15 Feb 2023 10:41:02 -0500
X-MC-Unique: LVpfoPQGNw6GNKM_irhueg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2A5E885620;
        Wed, 15 Feb 2023 15:41:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BF9418EC1;
        Wed, 15 Feb 2023 15:40:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegshWgUYZLc5v-Vwf6g3ZGmfnHsT_t9JLwxFoV8wPrvBnA@mail.gmail.com>
References: <CAJfpegshWgUYZLc5v-Vwf6g3ZGmfnHsT_t9JLwxFoV8wPrvBnA@mail.gmail.com> <20230214171330.2722188-1-dhowells@redhat.com> <20230214171330.2722188-6-dhowells@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH v15 05/17] overlayfs: Implement splice-read
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3370084.1676475658.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 15 Feb 2023 15:40:58 +0000
Message-ID: <3370085.1676475658@warthog.procyon.org.uk>
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

How about the attached then?

David
---
overlayfs: Implement splice-read

Implement splice-read for overlayfs by passing the request down a layer
rather than going through generic_file_splice_read() which is going to be
changed to assume that ->read_folio() is present on buffered files.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: John Hubbard <jhubbard@nvidia.com>
cc: David Hildenbrand <david@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-unionfs@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
Notes:
    ver #15)
     - Remove redundant FMODE_CAN_ODIRECT check on real file.
     - Do rw_verify_area() on the real file, not the overlay file.
     - Fix a file leak.

 fs/overlayfs/file.c |   33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index c9d0c362c7ef..72a545da51a2 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -419,6 +419,37 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, str=
uct iov_iter *iter)
 	return ret;
 }
 =

+static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
+			       struct pipe_inode_info *pipe, size_t len,
+			       unsigned int flags)
+{
+	const struct cred *old_cred;
+	struct fd real;
+	ssize_t ret;
+
+	ret =3D ovl_real_fdget(in, &real);
+	if (ret)
+		return ret;
+
+	ret =3D -EINVAL;
+	if (!real.file->f_op->splice_read)
+		goto out_fdput;
+
+	ret =3D rw_verify_area(READ, real.file, ppos, len);
+	if (unlikely(ret < 0))
+		goto out_fdput;
+
+	old_cred =3D ovl_override_creds(file_inode(in)->i_sb);
+	ret =3D real.file->f_op->splice_read(real.file, ppos, pipe, len, flags);
+
+	revert_creds(old_cred);
+	ovl_file_accessed(in);
+out_fdput:
+	fdput(real);
+
+	return ret;
+}
+
 /*
  * Calling iter_file_splice_write() directly from overlay's f_op may dead=
lock
  * due to lock order inversion between pipe->mutex in iter_file_splice_wr=
ite()
@@ -695,7 +726,7 @@ const struct file_operations ovl_file_operations =3D {
 	.fallocate	=3D ovl_fallocate,
 	.fadvise	=3D ovl_fadvise,
 	.flush		=3D ovl_flush,
-	.splice_read    =3D generic_file_splice_read,
+	.splice_read    =3D ovl_splice_read,
 	.splice_write   =3D ovl_splice_write,
 =

 	.copy_file_range	=3D ovl_copy_file_range,

