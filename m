Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C671A798A55
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 18:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244794AbjIHQES (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 12:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244738AbjIHQER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433AA1FC6
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 09:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694189013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Sg3a7A43hEMYTaK7v8cHzLS7F7QYnrJJZ8kuLsBU9fQ=;
        b=dHGPMZPyfkWFdlNafrbhWSIHRb+UVaG1ibdWz6pIqGzNfruifFeSgVlUr25n0gqhgzb26E
        fONdZhb7alByfGZZ4cxo+S/S2w4O0Fv9RvCARqUNe3GhFyIrLXmOCjb/UZteT3rYk2netT
        x9dn7V8Hcs1vfwolNDrClQSB1AiJzKQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-IdWsmPpvOLu2t5V-Jpa52w-1; Fri, 08 Sep 2023 12:03:30 -0400
X-MC-Unique: IdWsmPpvOLu2t5V-Jpa52w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E4CF916C82;
        Fri,  8 Sep 2023 16:03:29 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1A7463F6C;
        Fri,  8 Sep 2023 16:03:27 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iov_iter: Add kunit tests and fix iov_iter_extract_pages()
Date:   Fri,  8 Sep 2023 17:03:19 +0100
Message-ID: <20230908160322.1714302-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens, Christoph, Al,

Here are two patches to add some kunit tests for the iov_iter stuff and a
patch to fix a couple of bugs found by these tests.

It's by no means comprehensive, but it does at least test the basic
copy_to_iter(), copy_from_iter() and iov_iter_extract_pages() for
ITER_KVEC, ITER_BVEC and ITER_XARRAY.

I've left ITER_UBUF and ITER_IOVEC untested for now as they require
userspace VM interaction and I'm not sure if that's possible under kunit
tests.  I've also left ITER_DISCARD for the moment as that does nothing and
can't be extracted.

The kunit tests should also perhaps be using folios rather than pages, but
for the moment I'm using pages because I'm using vmap() and also
iov_iter_extract_pages() doesn't yet have a folio equivalent.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-fixes

David

David Howells (3):
  iov_iter: Fix iov_iter_extract_pages()
  iov_iter: Kunit tests for copying to/from an iterator
  iov_iter: Kunit tests for page extraction

 lib/Kconfig.debug    |  11 +
 lib/Makefile         |   1 +
 lib/iov_iter.c       |  30 +-
 lib/kunit_iov_iter.c | 777 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 804 insertions(+), 15 deletions(-)
 create mode 100644 lib/kunit_iov_iter.c

