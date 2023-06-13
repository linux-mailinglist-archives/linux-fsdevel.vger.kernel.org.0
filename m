Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25C572EE6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 23:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbjFMV4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 17:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbjFMV4E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FC11FCE
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 14:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686693304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1PjQMG6Yu1qBPrMj044V/Nk+rlr/96uKkoV0wYpuazQ=;
        b=VyS4vceJT/SlwAe7Gh+kKBCLPdcXCa4IIGTY1fG3NtTW9WV7obQfqe+DVkl6IAA8QoGoIv
        eynGzG/DAUuaHBsjRgZ4derzQg8vKPgFWTcf4Zw+ldXLI+4D1svWBupc7Tx5p1UxgWOEHG
        9CeVefrjA7TbmYqZIc4/8aI5lUo12f0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-3wnroJiJOTC1wvpPs_598w-1; Tue, 13 Jun 2023 17:54:57 -0400
X-MC-Unique: 3wnroJiJOTC1wvpPs_598w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A1BE3C0CEF0;
        Tue, 13 Jun 2023 21:54:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D29182166B25;
        Tue, 13 Jun 2023 21:54:39 +0000 (UTC)
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
Subject: [PATCH] block: Fix dio_cleanup() to advance the head index
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1193484.1686693279.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 13 Jun 2023 22:54:39 +0100
Message-ID: <1193485.1686693279@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

    =

Fix dio_bio_cleanup() to advance the head index into the list of pages pas=
t
the pages it has released, as __blockdev_direct_IO() will call it twice if
do_direct_IO() fails.

The issue was causing:

        WARNING: CPU: 6 PID: 2220 at mm/gup.c:76 try_get_folio

This can be triggered by setting up a clean pair of UDF filesystems on
loopback devices and running the generic/451 xfstest with them as the
scratch and test partitions.  Something like the following:

    fallocate /mnt2/udf_scratch -l 1G
    fallocate /mnt2/udf_test -l 1G
    mknod /dev/lo0 b 7 0
    mknod /dev/lo1 b 7 1
    losetup lo0 /mnt2/udf_scratch
    losetup lo1 /mnt2/udf_test
    mkfs -t udf /dev/lo0
    mkfs -t udf /dev/lo1
    cd xfstests
    ./check generic/451

with xfstests configured by putting the following into local.config:

    export FSTYP=3Dudf
    export DISABLE_UDF_TEST=3D1
    export TEST_DEV=3D/dev/lo1
    export TEST_DIR=3D/xfstest.test
    export SCRATCH_DEV=3D/dev/lo0
    export SCRATCH_MNT=3D/xfstest.scratch

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
 fs/direct-io.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 0643f1bb4b59..2ceb378b93c0 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -459,6 +459,7 @@ static inline void dio_cleanup(struct dio *dio, struct=
 dio_submit *sdio)
 	if (dio->is_pinned)
 		unpin_user_pages(dio->pages + sdio->head,
 				 sdio->tail - sdio->head);
+	sdio->head =3D sdio->tail;
 }
 =

 /*

