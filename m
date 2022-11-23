Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D875C636D8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 23:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKWWtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 17:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKWWtg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:49:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B2558BC7
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 14:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669243715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RwK92HT6uXaeNFI0ryIilaUvN1ewEQDVvt+89pcPgvc=;
        b=Wf+8pB/jqNPR7kw15wkeU3bRsrkKw9ZSEDvFTdY9Jdxp7gINfOHt5R1t57vEjSebhKumC6
        EuvNaSoeP6Ulr8TZDy1cWkmd9yQncLuu6lAsLfY0TG+8apGc4YMX0KRhRCabZJtDH4LAd2
        kM7gLpy7VWnRDdTbqA1DAd8wigKVato=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-fSIlp9HwOd2_S9Kz1Ymq0w-1; Wed, 23 Nov 2022 17:48:32 -0500
X-MC-Unique: fSIlp9HwOd2_S9Kz1Ymq0w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9D1A3802B89;
        Wed, 23 Nov 2022 22:48:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6684249BB62;
        Wed, 23 Nov 2022 22:48:28 +0000 (UTC)
Subject: [PATCH v4 0/3] mm, netfs,
 fscache: Stop read optimisation when folio removed from pagecache
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Dave Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-mm@kvack.org, Rohith Surabattula <rohiths.msft@gmail.com>,
        v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        Matthew Wilcox <willy@infradead.org>,
        Steve French <sfrench@samba.org>,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-erofs@lists.ozlabs.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 23 Nov 2022 22:48:25 +0000
Message-ID: <166924370539.1772793.13730698360771821317.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Linus,

How about this then?

I've split the folio_has_private()/filemap_release_folio() call pair
merging into its own patch, separate from the actual bugfix and pulled out
the folio_needs_release() function into mm/internal.h and made
filemap_release_folio() use it.  I've also got rid of the bit clearances
from the network filesystem evict_inode functions as they doesn't seem to
be necessary.

I've also added an additional experimental patch to see if the pair in
shrink_folio_list() can be reduced cleanly to just the release call.  This
involves making filemap_release_folio() have a three-state return.

David

Changes:
========
ver #4)
 - Split has_private/release call pairs into own patch.
 - Moved folio_needs_release() to mm/internal.h and removed open-coded
   version from filemap_release_folio().
 - Don't need to clear AS_RELEASE_ALWAYS in ->evict_inode().
 - Added experimental patch to reduce shrink_folio_list().

ver #3)
 - Fixed mapping_clear_release_always() to use clear_bit() not set_bit().
 - Moved a '&&' to the correct line.

ver #2)
 - Rewrote entirely according to Willy's suggestion[1].

Link: https://lore.kernel.org/r/Yk9V/03wgdYi65Lb@casper.infradead.org/ [1]
Link: https://lore.kernel.org/r/164928630577.457102.8519251179327601178.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/166844174069.1124521.10890506360974169994.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/166869495238.3720468.4878151409085146764.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/1459152.1669208550@warthog.procyon.org.uk/ # v3 also
---
David Howells (3):
      mm: Merge folio_has_private()/filemap_release_folio() call pairs
      mm, netfs, fscache: Stop read optimisation when folio removed from pagecache
      mm: Make filemap_release_folio() better inform shrink_folio_list()


 fs/9p/cache.c           |  2 ++
 fs/afs/internal.h       |  2 ++
 fs/cachefiles/namei.c   |  2 ++
 fs/ceph/cache.c         |  2 ++
 fs/cifs/fscache.c       |  2 ++
 fs/splice.c             |  3 +--
 include/linux/pagemap.h | 23 ++++++++++++++++++++++-
 mm/filemap.c            | 20 +++++++++++++++-----
 mm/huge_memory.c        |  3 +--
 mm/internal.h           | 11 +++++++++++
 mm/khugepaged.c         |  3 +--
 mm/memory-failure.c     |  3 +--
 mm/migrate.c            |  3 +--
 mm/truncate.c           |  6 ++----
 mm/vmscan.c             | 34 +++++++++++++++++-----------------
 15 files changed, 82 insertions(+), 37 deletions(-)


