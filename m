Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381A1635FDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 14:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbiKWNcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 08:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbiKWNbZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:31:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BB584317
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 05:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669209028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JdH5iMj2hJ3f18CCrntex26NGDaDwSvrSAcFPbFoP58=;
        b=dG74Zd2uoHINo8cmD0xOf0yw+2sw26843q+SxQPbnYXU/H3AS3SvWdf7wCAtWlMZpUQsY9
        WB7ftNuyoJCH7729+jzqEz9ok+9+OL6lqBvlDsaTcVjFXaQHmbXk2+tudy1c/fGL5sAj2a
        xKYs35TBt2rN7dWpUdXHh3VgTBhBW48=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-SZdBQVGmOMmF1asWSPMeUg-1; Wed, 23 Nov 2022 08:10:25 -0500
X-MC-Unique: SZdBQVGmOMmF1asWSPMeUg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82D8F833AEF;
        Wed, 23 Nov 2022 13:10:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0551477F5D;
        Wed, 23 Nov 2022 13:10:22 +0000 (UTC)
Subject: [PATCH v2 0/4] iov_iter: Add extraction helpers
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Rohith Surabattula <rohiths.msft@gmail.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cachefs@redhat.com, Matthew Wilcox <willy@infradead.org>,
        linux-cifs@vger.kernel.org, Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@lst.de>, dhowells@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 23 Nov 2022 13:10:20 +0000
Message-ID: <166920902005.1461876.2786264600108839814.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Al,

Here are four patches to provide support for extracting pages from an
iov_iter, where such a thing makes sense, if you could take a look?

The first couple of patches provide iov_iter general stuff:

 (1) Move the FOLL_* flags to linux/mm_types.h so that linux/uio.h can make
     use of them.

 (2) Add a function to list-only, get or pin pages from an iterator as a
     future replacement for iov_iter_get_pages*().  Pointers to the pages
     are placed into an array (which will get allocated if not provided)
     and, depending on the iterator type and direction, the pages will have
     a ref or a pin get on them, or left untouched (on the assumption that
     the caller manages their lifetime).

     The determination is:

	UBUF/IOVEC + READ	-> pin
	UBUF/IOVEC + WRITE	-> get
	PIPE + READ		-> list-only
	BVEC/XARRAY		-> list-only
	Anything else		-> EFAULT

     The function also returns an indication of which of "list only, get or
     pin" the extraction function did to aid in cleaning up (returning 0,
     FOLL_GET or FOLL_PIN as appropriate).

     [!] NOTE that this function is not marked EXPORT_SYMBOL_GPL because
     	 it's intended as a replacement for iov_iter_get_pages*(), which is
     	 not itself marked _GPL.

Then there are a couple of patches that add stuff to netfslib that I want
to use there as well as in cifs:

 (3) Add a netfslib function to use (2) to extract pages from an ITER_IOBUF
     or ITER_UBUF iterator into an ITER_BVEC iterator.  This will get or
     pin the pages as appropriate.

 (4) Add a netfslib function to extract pages from an iterator that's of
     type ITER_UBUF/IOVEC/BVEC/KVEC/XARRAY and add them to a scatterlist.

     The function in (2) is used for a UBUF and IOVEC iterators, so those
     need cleaning up afterwards.  BVEC and XARRAY iterators are ungot and
     unpinned and may be rendered into elements that span multiple pages,
     for example if large folios are present.

Changes:
========
ver #2)
 - Rolled the extraction cleanup mode query function into the extraction
   function, returning the indication through the argument list.
 - Fixed patch 4 (extract to scatterlist) to actually use the new
   extraction API.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-extract

David

Link: https://lore.kernel.org/r/166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166722777223.2555743.162508599131141451.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166732024173.3186319.18204305072070871546.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166869687556.3723671.10061142538708346995.stgit@warthog.procyon.org.uk/ # rfc

---
David Howells (4):
      mm: Move FOLL_* defs to mm_types.h
      iov_iter: Add a function to extract a page list from an iterator
      netfs: Add a function to extract a UBUF or IOVEC into a BVEC iterator
      netfs: Add a function to extract an iterator into a scatterlist


 fs/netfs/Makefile        |   1 +
 fs/netfs/iterator.c      | 367 +++++++++++++++++++++++++++++++++++++++
 include/linux/mm.h       |  74 --------
 include/linux/mm_types.h |  73 ++++++++
 include/linux/netfs.h    |   7 +
 include/linux/uio.h      |   4 +
 lib/iov_iter.c           | 350 +++++++++++++++++++++++++++++++++++++
 mm/vmalloc.c             |   1 +
 8 files changed, 803 insertions(+), 74 deletions(-)
 create mode 100644 fs/netfs/iterator.c


