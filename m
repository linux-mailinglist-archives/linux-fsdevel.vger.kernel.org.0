Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B92D68D98B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 14:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjBGNkS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 08:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjBGNkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:40:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F9E23D83
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Feb 2023 05:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675777167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+ct4EEN1Tx2kpi+pcudcB8r2YKIl9DGh1ohw3MpFlVY=;
        b=EogV5usZ2Zsv4unCeXk52t9gjqtRlL13wfpnxVOtHbow6VRXwL41HgbQ18X9E+mYqA7x7e
        6Qu9w4O/jEijJNGPERqPs2Jgho8la4QlpiNJq5zjnrFo1JeTf/ozZYbjJbfDdb+MGT2n9D
        hhGf3aBhLBvxAE0W4IGIEEzxFLB+71E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-WvHxkaGVM-CnLEd43YiVOQ-1; Tue, 07 Feb 2023 08:39:24 -0500
X-MC-Unique: WvHxkaGVM-CnLEd43YiVOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D0D6887401;
        Tue,  7 Feb 2023 13:39:23 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8AE3175AD;
        Tue,  7 Feb 2023 13:39:20 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 0/2] iomap, splice: Fix DIO/splice_read race memory corruptor and kill off ITER_PIPE
Date:   Tue,  7 Feb 2023 13:39:14 +0000
Message-Id: <20230207133916.3109147-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Jens, Christoph, Al,

Syzbot found a bug[1] that my bio/FOLL_PIN code[2] inadvertently
introduced.  The problem is that with my patches, pages obtained from
kernel-backed iterators aren't ref'd or pinned when they're extracted and
thus struct bio doesn't retain them.  A DIO-read from a file through iomap
that races with truncate may in __iomap_dio_rw() call iov_iter_revert() on
the iov_iter it was given.

Unfortunately, if the iterator is an ITER_PIPE, the reversion has side
effects: the pages rolled back get released.  Those pages, however, are not
retained by the uncompleted bio and may get modified after their release.

The first patch fixes this by switching to bulk allocating all the
necessary pages up front and adding them to an ITER_BVEC iterator, doing
the I/O and only then trimming the excess pages.  The remaining pages are
then pushed into the pipe.  This has the downside (as the code stands) of
not handling any partial page lurking in the pipe - though that could be
places as the first element in the bvec.  OTOH, using the bulk allocation
API should be more efficient.

As this is the only user of ITER_PIPE, the second patch removes ITER_PIPE
and all its associated iov_iter helper functions.

Thanks to Hillf Danton for spotting that iov_iter_revert() was involved[3].

[!] Jens: Note that there's a window in the linux-block/for-next branch
    with a memory corruptor bug that someone bisecting might hit.  These
    two patches would be better pushed to the front of my iov-extract
    branch to eliminate the window.  Would it be possible for you to
    replace my branch in your for-next branch at this point?

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-fixes

David

Link: https://lore.kernel.org/r/000000000000b0b3c005f3a09383@google.com/ [1]
Link: https://lore.kernel.org/r/20230126141626.2809643-1-dhowells@redhat.com/ [2]
Link: https://lore.kernel.org/r/20230207094731.1390-1-hdanton@sina.com/ [3]

David Howells (2):
  vfs, iomap: Fix generic_file_splice_read() to avoid reversion of
    ITER_PIPE
  iov_iter: Kill ITER_PIPE

 fs/cifs/file.c      |   8 +-
 fs/splice.c         |  76 ++++++-
 include/linux/uio.h |  14 --
 lib/iov_iter.c      | 492 +-------------------------------------------
 mm/filemap.c        |   3 -
 5 files changed, 72 insertions(+), 521 deletions(-)

