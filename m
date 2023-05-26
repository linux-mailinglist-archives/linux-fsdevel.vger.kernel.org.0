Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC59712F07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 23:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjEZVma (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 17:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjEZVm3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 17:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA01DF
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 May 2023 14:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685137310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=I2DiPgqm3c5QPJhRJAJCbIB9OqdP8JSz4YiRYoqTjK8=;
        b=DIFN6vJPQdkrZ/aN2VvvUWJRN560iH5bsGmpBKOOkcC9bRtu17eZI80NVWJcUfm+k9BikT
        1BqV+pOxOWufFDTs90uMCxUZfSz0XcThAG2H3MoUuapX2mbzjQ4QD4Yc2iDIhxgj9xXOks
        DaVqGmlq6IRmbIprJORJd9cQ5jViKO4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-GRqTbWv-PT2iy4i50bmzWQ-1; Fri, 26 May 2023 17:41:47 -0400
X-MC-Unique: GRqTbWv-PT2iy4i50bmzWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A45FB811E7C;
        Fri, 26 May 2023 21:41:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0C92140E961;
        Fri, 26 May 2023 21:41:43 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v4 0/3] block: Make old dio use iov_iter_extract_pages() and page pinning
Date:   Fri, 26 May 2023 22:41:39 +0100
Message-Id: <20230526214142.958751-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph, David, Lorenzo,

Here are three patches that go on top of the similar patches for bio
structs now in the block tree that make the old block direct-IO code use
iov_iter_extract_pages() and page pinning.

There are three patches:

 (1) Make page pinning neither add nor remove a pin to/from a ZERO_PAGE,
     thereby allowing the dio code to insert zero pages in the middle of
     dealing with pinned pages.  This also mitigates a potential problem
     whereby userspace could force the overrun the pin counter of a zero
     page.

     A pair of functions are provided to wrap the testing of a page or
     folio to see if it is a zero page.

 (2) Provide a function to allow an additional pin to be taken on a page we
     already have pinned (and do nothing for a zero page).

 (3) Switch direct-io.c over to using page pinning and to use
     iov_iter_extract_pages() so that pages from non-user-backed iterators
     aren't pinned.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-old-dio

David

Changes
=======
ver #4)
 - Use _inc rather than _add ops when we're just adding 1.

ver #3)
 - Move is_zero_page() and is_zero_folio() to mm.h for dependency reasons.
 - Add more comments and adjust the docs about pinning zero pages.
 - Rename page_get_additional_pin() to folio_add_pin().
 - Use is_zero_folio() in folio_add_pin().
 - Rename need_unpin to is_pinned in struct dio.

ver #2)
 - Fix use of ZERO_PAGE().
 - Add wrappers for testing if a page is a zero page.
 - Return the zero page obtained, not ZERO_PAGE(0) unconditionally.
 - Need to set BIO_PAGE_PINNED conditionally, and not BIO_PAGE_REFFED.

Link: https://lore.kernel.org/r/ZGxfrOLZ4aN9/MvE@infradead.org/ [1]
Link: https://lore.kernel.org/r/20230525155102.87353-1-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20230525223953.225496-1-dhowells@redhat.com/ # v2
Link: https://lore.kernel.org/r/20230526112859.654506-1-dhowells@redhat.com/ # v3

David Howells (3):
  mm: Don't pin ZERO_PAGE in pin_user_pages()
  mm: Provide a function to get an additional pin on a page
  block: Use iov_iter_extract_pages() and page pinning in direct-io.c

 Documentation/core-api/pin_user_pages.rst |  6 ++
 fs/direct-io.c                            | 72 ++++++++++++++---------
 include/linux/mm.h                        | 27 ++++++++-
 mm/gup.c                                  | 58 +++++++++++++++++-
 4 files changed, 131 insertions(+), 32 deletions(-)

