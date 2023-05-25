Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EF3711A3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 00:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbjEYWk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 18:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjEYWkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 18:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C7B9E
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 15:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685054403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XfXqmZRZyewS7hbeld3Fb741MiT0i4I4BJ+K3KWmVSM=;
        b=Qiwyob4Cc7Qh5Kkv1neb3NaRS2dIBl7fuYlz6dRvHseDZv4E1ZHHzx7mWs1gnZmoE15KJG
        o5Uuzcw1m2aiKlVRjY8iN6lPEl8THWCZE9XYN63EV4CILWM6dlcI9Ot7ID7ZpnR3eDsUHj
        fwGtK4l5z5QFgQ3Ym+0a0kF3Ak1Qt6Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-uSF_FvTSNk6_plfteQwiVw-1; Thu, 25 May 2023 18:39:59 -0400
X-MC-Unique: uSF_FvTSNk6_plfteQwiVw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A406D29AA39B;
        Thu, 25 May 2023 22:39:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC8D7C154D1;
        Thu, 25 May 2023 22:39:55 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>
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
Subject: [RFC PATCH v2 0/3] block: Make old dio use iov_iter_extract_pages() and page pinning
Date:   Thu, 25 May 2023 23:39:50 +0100
Message-Id: <20230525223953.225496-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph, David,

Since Christoph asked nicely[1] ;-), here are three patches that go on top
of the similar patches for bio structs now in the block tree that make the
old block direct-IO code use iov_iter_extract_pages() and page pinning.

There are three patches:

 (1) Make page pinning not add or remove a pin to/from a ZERO_PAGE, thereby
     allowing the dio code to insert zero pages in the middle of dealing
     with pinned pages.

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
ver #2)
 - Fix use of ZERO_PAGE().
 - Add wrappers for testing if a page is a zero page.
 - Return the zero page obtained, not ZERO_PAGE(0) unconditionally.
 - Need to set BIO_PAGE_PINNED conditionally, and not BIO_PAGE_REFFED.

Link: https://lore.kernel.org/r/ZGxfrOLZ4aN9/MvE@infradead.org/ [1]
Link: https://lore.kernel.org/r/20230525155102.87353-1-dhowells@redhat.com/ # v1

David Howells (3):
  mm: Don't pin ZERO_PAGE in pin_user_pages()
  mm: Provide a function to get an additional pin on a page
  block: Use iov_iter_extract_pages() and page pinning in direct-io.c

 fs/direct-io.c          | 72 ++++++++++++++++++++++++-----------------
 include/linux/mm.h      |  1 +
 include/linux/pgtable.h | 10 ++++++
 mm/gup.c                | 54 ++++++++++++++++++++++++++++++-
 4 files changed, 107 insertions(+), 30 deletions(-)

