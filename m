Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA9A711000
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 17:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbjEYPwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 11:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbjEYPv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 11:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A662018D
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685029871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Dnh9Ymd0aXLnszSbYXuRCQIZeE9p62JOLrx7AW+9I7M=;
        b=ehftH4zHYp4i803rNveNXev4o0LZC77COF1qxPShhcvrGQdCfb+oz36iu1CvhNUKoPxFfv
        5Mh+u2V5bxPZtQvbPSYDFEM4JksLPnPzjWtMuYJ4Amfv/MeCZz1VLJrcfMQ0pr6fR3OPnz
        9lQmHa8TJy78d/qdIjK0w8SQDl+IqO8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-138-tBX-uUEGPaSF-e1H0150-Q-1; Thu, 25 May 2023 11:51:08 -0400
X-MC-Unique: tBX-uUEGPaSF-e1H0150-Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E1DD8030D2;
        Thu, 25 May 2023 15:51:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7180D200BA65;
        Thu, 25 May 2023 15:51:04 +0000 (UTC)
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
Subject: [RFC PATCH 0/3] block: Make old dio use iov_iter_extract_pages() and page pinning
Date:   Thu, 25 May 2023 16:50:59 +0100
Message-Id: <20230525155102.87353-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

 (1) Make page pinning not add or remove a pin to/from the ZERO_PAGE,
     thereby allowing the dio code to insert zero pages in the middle of
     dealing with pinned pages.

 (2) Provide a function to allow an additional pin to be taken on a page we
     already have pinned (and do nothing for the zero page).

 (3) Switch direct-io.c over to using page pinning and to use
     iov_iter_extract_pages() so that pages from non-user-backed iterators
     aren't pinned.

Note that I haven't managed to test this yet as SELinux is refusing to let
me mount things like ext2 filesystems on account of it not having xattrs:-/

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-old-dio

David

Link: https://lore.kernel.org/r/ZGxfrOLZ4aN9/MvE@infradead.org/ [1]

David Howells (3):
  mm: Don't pin ZERO_PAGE in pin_user_pages()
  mm: Provide a function to get an additional pin on a page
  block: Use iov_iter_extract_pages() and page pinning in direct-io.c

 fs/direct-io.c     | 68 ++++++++++++++++++++++++++++------------------
 include/linux/mm.h |  1 +
 mm/gup.c           | 54 +++++++++++++++++++++++++++++++++++-
 3 files changed, 95 insertions(+), 28 deletions(-)

