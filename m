Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DE572D06A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 22:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbjFLUZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 16:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbjFLUZ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB2B10FC
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 13:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686601480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=S42fl/HoNEU97xotwFSAjJfWCsSnH9zjSpzpvH3McME=;
        b=iTZ2GIDrd7a2zlIof7CPzjUAiYfZOY0rhB/smX79yVHp6/Fd8Ns40wzYdCWwL9X3JJ93P0
        PFgiywoHCUDcTZPmXP+KdEMl7+TX/lo5AsIHYfGK/OGNYUSNzg+TfsTmz2gNw4sgVWsso1
        V7nFB+6KdSKCOMG1Bc7KOAD83rL7rL4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-xzVXP3XYOhqICv2yzeVXDA-1; Mon, 12 Jun 2023 16:24:38 -0400
X-MC-Unique: xzVXP3XYOhqICv2yzeVXDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 230618037AA;
        Mon, 12 Jun 2023 20:24:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A51B12956;
        Mon, 12 Jun 2023 20:24:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, David Hildenbrand <david@redhat.com>,
        kernel test robot <oliver.sang@intel.com>
cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: Fix dio_bio_alloc() to set BIO_PAGE_PINNED
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <545462.1686601473.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 12 Jun 2023 21:24:33 +0100
Message-ID: <545463.1686601473@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

    =

Fix dio_bio_alloc() to set BIO_PAGE_PINNED, not BIO_PAGE_REFFED, so that
the bio code unpins the pinned pages rather than putting a ref on them.

The issue was causing:

        WARNING: CPU: 6 PID: 2220 at mm/gup.c:76 try_get_folio

This can be caused by creating a file on a loopback UDF filesystem, openin=
g
it O_DIRECT and making two writes to it from the same source buffer.

Fixes: 1ccf164ec866 ("block: Use iov_iter_extract_pages() and page pinning=
 in direct-io.c")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202306120931.a9606b88-oliver.sang@i=
ntel.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@infradead.org>
cc: David Hildenbrand <david@redhat.com>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Matthew Wilcox <willy@infradead.org>
cc: Jan Kara <jack@suse.cz>
cc: Jeff Layton <jlayton@kernel.org>
cc: Jason Gunthorpe <jgg@nvidia.com>
cc: Logan Gunthorpe <logang@deltatee.com>
cc: Hillf Danton <hdanton@sina.com>
cc: Christian Brauner <brauner@kernel.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
---

Notes:
    ver #2)
     - Remove comment on requiring references for all pages.

 fs/direct-io.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 14049204cac8..5d4c5be0fb41 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -414,8 +414,8 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio=
,
 		bio->bi_end_io =3D dio_bio_end_aio;
 	else
 		bio->bi_end_io =3D dio_bio_end_io;
-	/* for now require references for all pages */
-	bio_set_flag(bio, BIO_PAGE_REFFED);
+	if (dio->need_unpin)
+		bio_set_flag(bio, BIO_PAGE_PINNED);
 	sdio->bio =3D bio;
 	sdio->logical_offset_in_bio =3D sdio->cur_page_fs_offset;
 }

