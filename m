Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7933A614F50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 17:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiKAQcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 12:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiKAQbp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 12:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F19E1D0FF
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Nov 2022 09:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667320250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=11t7t2M5S9FVtreaeqc7IEi/JpUAAyL70GwctMIr/Uo=;
        b=Te/2OClzQvuE3DOrbMqoIT/c7F+xFHkAhFqZwboye3DhdqfRwpOuSDVOXJ41pPNClBWx/C
        pzD1kit/cvn7kbAiTC3CezfPrRZQ5JdR3V3tyMoR8LeHrEanKOq3BorYV3eWpWKwtQVp93
        HD5+NhTshDkA1tycdyJHrDlPSPEllCo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-UXHRu4KIP5SSs1TCerXLMw-1; Tue, 01 Nov 2022 12:30:46 -0400
X-MC-Unique: UXHRu4KIP5SSs1TCerXLMw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E801E811E81;
        Tue,  1 Nov 2022 16:30:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD9AC4EA49;
        Tue,  1 Nov 2022 16:30:42 +0000 (UTC)
Subject: [RFC PATCH 00/12] smb3: Add iter helpers and use iov_iters down to
 the network transport
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-cachefs@redhat.com, John Hubbard <jhubbard@nvidia.com>,
        linux-cifs@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>, linux-mm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-crypto@vger.kernel.org,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Christoph Hellwig <hch@lst.de>, dhowells@redhat.com,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 01 Nov 2022 16:30:41 +0000
Message-ID: <166732024173.3186319.18204305072070871546.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Steve, Al, Christoph,

Here's an updated version of a subset of my branch to make the cifs/smb3
driver pass iov_iters down to the lowest layers where they can be passed to
the network transport.

The first couple of patches provide iov_iter general stuff:

 (1) Move the FOLL_* flags to linux/mm_types.h so that linux/uio.h can make
     use of them.

 (2) Add a function to extract/get/pin pages from an iterator as a future
     replacement for iov_iter_get_pages*().  It also adds a function by
     which the caller can determine which of "extract/get/pin" the
     extraction function will actually do to aid in cleaning up.

Then there are a couple of patches that add stuff to netfslib that I want
to use there as well as in cifs:

 (3) Add a netfslib function to use (2) to extract pages from an ITER_IOBUF
     or ITER_UBUF iterator into an ITER_BVEC iterator.

 (4) Add a netfslib function to use (2) to extract pages from an iterator
     that's of type ITER_UBUF/IOVEC/BVEC/KVEC/XARRAY and add them to a
     scatterlist.  The function in (2) is used for a UBUF and IOVEC
     iterators, so those need cleaning up afterwards; BVEC and XARRAY
     iterators can be rendered into elements that span multiple pages.

Then there are some cifs helpers that work with iterators:

 (5) Implement cifs_splice_read() to use an ITER_BVEC rather than an
     ITER_PIPE, bulk-allocating the pages, attaching them to the bvec,
     doing the I/O and then pushing the pages into the pipe.  This avoids
     the problem with cifs wanting to split the pipe iterator in a later
     patch.

 (6) Add a function to walk through an ITER_BVEC/KVEC/XARRAY iterator and
     add elements to an RDMA SGE list.  Only the DMA addresses are stored,
     and an element may span multiple pages (say if an xarray contains a
     multipage folio).

 (7) Add a function to walk through an ITER_BVEC/KVEC/XARRAY iterator and
     pass the contents into a shash function.

 (8) Add functions to walk through an ITER_XARRAY iterator and perform
     various sorts of cleanup on the folios held therein, to be used on I/o
     completion.

 (9) Add a function to read from the transport TCP socket directly into an
     iterator.

Then come the patches that actually do the work of iteratorising cifs:

(10) The main patch.  Replace page lists with iterators.  It extracts the
     pages from ITER_UBUF and ITER_IOVEC iterators to an ITER_BVEC
     iterator, pinning or getting refs on them, before passing them down as
     the I/O may be done from a worker thread.

     The iterator is extracted into a scatterlist in order to talk to the
     crypto interface or to do RDMA.

(11) In the cifs RDMA code, extract the iterator into an RDMA SGE[] list,
     removing the scatterlist intermediate - at least for smbd_send().
     There appear to be other ways for cifs to talk to the RDMA layer that
     don't go through that that I haven't managed to work out.

(12) Remove a chunk of now-unused code.

Note also that I haven't managed to test all the combinations of transport.
Samba doesn't support RDMA and ksmbd doesn't support encryption.  I can
test them separately, but not together.  That said, rdma, sign, seal and
sign+seal seem to work.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-for-viro

Note that this is based on a merge of Al's work.iov_iter branch with
v6.1-rc2.

David

Link: https://lore.kernel.org/r/166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk/
---
David Howells (12):
      mm: Move FOLL_* defs to mm_types.h
      iov_iter: Add a function to extract a page list from an iterator
      netfs: Add a function to extract a UBUF or IOVEC into a BVEC iterator
      netfs: Add a function to extract an iterator into a scatterlist
      cifs: Implement splice_read to pass down ITER_BVEC not ITER_PIPE
      cifs: Add a function to build an RDMA SGE list from an iterator
      cifs: Add a function to Hash the contents of an iterator
      cifs: Add some helper functions
      cifs: Add a function to read into an iter from a socket
      cifs: Change the I/O paths to use an iterator rather than a page list
      cifs: Build the RDMA SGE list directly from an iterator
      cifs: Remove unused code


 fs/cifs/Kconfig          |    1 +
 fs/cifs/cifsencrypt.c    |  172 +++-
 fs/cifs/cifsfs.c         |   12 +-
 fs/cifs/cifsfs.h         |    6 +
 fs/cifs/cifsglob.h       |   31 +-
 fs/cifs/cifsproto.h      |   11 +-
 fs/cifs/cifssmb.c        |   13 +-
 fs/cifs/connect.c        |   16 +
 fs/cifs/file.c           | 1793 ++++++++++++++++++--------------------
 fs/cifs/fscache.c        |   22 +-
 fs/cifs/fscache.h        |   10 +-
 fs/cifs/misc.c           |  127 +--
 fs/cifs/smb2ops.c        |  378 ++++----
 fs/cifs/smb2pdu.c        |   45 +-
 fs/cifs/smbdirect.c      |  503 +++++++----
 fs/cifs/smbdirect.h      |    4 +-
 fs/cifs/transport.c      |   57 +-
 fs/netfs/Makefile        |    1 +
 fs/netfs/iterator.c      |  346 ++++++++
 include/linux/mm.h       |   74 --
 include/linux/mm_types.h |   73 ++
 include/linux/netfs.h    |    5 +
 include/linux/uio.h      |   29 +
 lib/iov_iter.c           |  333 +++++++
 24 files changed, 2390 insertions(+), 1672 deletions(-)
 create mode 100644 fs/netfs/iterator.c


