Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7ED699F2C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 22:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjBPVst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 16:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjBPVsq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:48:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5301BACE
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 13:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676584075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4OB3pN7HUKRF2HBGdaKO4enU3FqFrSp+zht7+u7JxNg=;
        b=BF8+mD7pfEtb9L2ppVaH+NTi9qovkoYtKjJFGykYIOrhV8fEoCb5OGK4CVKaIHDp0CgxR5
        HnJ+ODMZpAZ4Y+exsvnwpgvoJEziTguyVx0y3D42hMaNYuUF4HzJblfObbatf5V3qhiJBr
        wp+hwJBIZMixli6S/7y5W93hx26u8nc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-pPzLFv9JOBy47XbqpzsHQw-1; Thu, 16 Feb 2023 16:47:51 -0500
X-MC-Unique: pPzLFv9JOBy47XbqpzsHQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E60BC85A588;
        Thu, 16 Feb 2023 21:47:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0DD21121314;
        Thu, 16 Feb 2023 21:47:47 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/17] smb3: Use iov_iters down to the network transport and fix DIO page pinning
Date:   Thu, 16 Feb 2023 21:47:28 +0000
Message-Id: <20230216214745.3985496-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Steve,

Here's an updated version of my patchset to make the cifs/smb3 driver pass
iov_iters down to the lowest layers where they can be passed directly to
the network transport rather than passing lists of pages around.

The series deals with the following issues:

 (-) By pinning pages, it fixes the race between concurrent DIO read and
     fork, whereby the pages containing the DIO read buffer may end up
     belonging to the child process and not the parent - with the result
     that the parent might not see the retrieved data.

 (-) cifs shouldn't take refs on pages extracted from non-user-backed
     iterators (eg. KVEC).  With these changes, cifs will apply the
     appropriate cleanup.  Note that there is the possibility the network
     transport might, but that's beyond the scope of this patchset.

 (-) Making it easier to transition to using folios in cifs rather than
     pages by dealing with them through BVEC and XARRAY iterators.

The first five patches add two facilities to the VM/VFS core, excerpts from
my iov-extract branch[1] that are required in order to do the cifs
iteratorisation:

 (*) Future replacements for file-splicing in the form of functions
     filemap_splice_read() and direct_splice_read().  These allow file
     splicing to be done without the use of an ITER_PIPE iterator, without
     the need to take refs on the pages extracted from KVEC/BVEC/XARRAY
     iterators.  This is necessary to use iov_iter_extract_pages().

     [!] Note that whilst these are added in core code, they are only used
     by cifs at this point.

 (*) Add iov_iter_extract_pages(), a replacement for iov_iter_get_pages*()
     that uses FOLL_PIN on user pages (IOVEC, UBUF) and doesn't pin kernel
     pages (BVEC, KVEC, XARRAY).  This allows cifs to do the page pinning
     correctly.

     [!] Note that whilst this is added in core code, it is only used by
     cifs at this point - though a corresponding change is made to the
     flags argument of iov_iter_get_pages*() so that it doesn't take FOLL_*
     flags, but rather takes iov_iter_extraction_t flags that are
     translated internally to FOLL_* flags.

Then there's a couple of patches to make cifs use the new splice functions.

The series continues with a couple of patches that add stuff to netfslib
that I want to use there as well as in cifs:

 (*) Add a netfslib function to extract and pin pages from an ITER_IOBUF or
     ITER_UBUF iterator into an ITER_BVEC iterator.

 (*) Add a netfslib function to extract pages from an iterator that's of
     type ITER_UBUF/IOVEC/BVEC/KVEC/XARRAY and add them to a scatterlist.
     The cleanup will need to be done as for iov_iter_extract_pages().

     BVEC, KVEC and XARRAY iterators can be rendered into elements that
     span multiple pages.

Added to that are some cifs helpers that work with iterators:

 (*) Add a function to walk through an ITER_BVEC/KVEC/XARRAY iterator and
     add elements to an RDMA SGE list.  Only the DMA addresses are stored,
     and an element may span multiple pages (say if an xarray contains a
     multipage folio).

 (*) Add a function to walk through an ITER_BVEC/KVEC/XARRAY iterator and
     pass the contents into a shash function.

 (*) Add functions to walk through an ITER_XARRAY iterator and perform
     various sorts of cleanup on the folios held therein, to be used on I/O
     completion.

 (*) Add a function to read from the transport TCP socket directly into an
     iterator.

Finally come the patches that actually do the work of iteratorising cifs:

 (*) The main patch.  Replace page lists with iterators.  It extracts the
     pages from ITER_UBUF and ITER_IOVEC iterators to an ITER_BVEC
     iterator, pinning or getting refs on them, before passing them down as
     the I/O may be done from a worker thread.

     The iterator is extracted into a scatterlist in order to talk to the
     crypto interface or to do RDMA.

 (*) In the cifs RDMA code, extract the iterator into an RDMA SGE[] list,
     removing the scatterlist intermediate - at least for smbd_send().
     There appear to be other ways for cifs to talk to the RDMA layer that
     don't go through that that I haven't managed to work out.

 (*) Remove a chunk of now-unused code.

 (*) Allow DIO to/from KVEC-type iterators.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-cifs

David

Link: https://lore.kernel.org/r/20230214171330.2722188-1-dhowells@redhat.com/ [1]
Link: https://lore.kernel.org/r/166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk/
Link: https://lore.kernel.org/r/20230131182855.4027499-1-dhowells@redhat.com/ # v1

David Howells (17):
  mm: Pass info, not iter, into filemap_get_pages()
  splice: Add a func to do a splice from a buffered file without
    ITER_PIPE
  splice: Add a func to do a splice from an O_DIRECT file without
    ITER_PIPE
  iov_iter: Define flags to qualify page extraction.
  iov_iter: Add a function to extract a page list from an iterator
  splice: Export filemap/direct_splice_read()
  cifs: Implement splice_read to pass down ITER_BVEC not ITER_PIPE
  netfs: Add a function to extract a UBUF or IOVEC into a BVEC iterator
  netfs: Add a function to extract an iterator into a scatterlist
  cifs: Add a function to build an RDMA SGE list from an iterator
  cifs: Add a function to Hash the contents of an iterator
  cifs: Add some helper functions
  cifs: Add a function to read into an iter from a socket
  cifs: Change the I/O paths to use an iterator rather than a page list
  cifs: Build the RDMA SGE list directly from an iterator
  cifs: Remove unused code
  cifs: DIO to/from KVEC-type iterators should now work

 block/bio.c               |    6 +-
 block/blk-map.c           |    8 +-
 fs/cifs/Kconfig           |    1 +
 fs/cifs/cifsencrypt.c     |  172 +++-
 fs/cifs/cifsfs.c          |   12 +-
 fs/cifs/cifsfs.h          |    6 +
 fs/cifs/cifsglob.h        |   66 +-
 fs/cifs/cifsproto.h       |   11 +-
 fs/cifs/cifssmb.c         |   15 +-
 fs/cifs/connect.c         |   14 +
 fs/cifs/file.c            | 1772 ++++++++++++++++---------------------
 fs/cifs/fscache.c         |   22 +-
 fs/cifs/fscache.h         |   10 +-
 fs/cifs/misc.c            |  128 +--
 fs/cifs/smb2ops.c         |  362 ++++----
 fs/cifs/smb2pdu.c         |   53 +-
 fs/cifs/smbdirect.c       |  535 ++++++-----
 fs/cifs/smbdirect.h       |    7 +-
 fs/cifs/transport.c       |   54 +-
 fs/netfs/Makefile         |    1 +
 fs/netfs/iterator.c       |  371 ++++++++
 fs/splice.c               |   93 ++
 include/linux/fs.h        |    6 +
 include/linux/netfs.h     |    8 +
 include/linux/pipe_fs_i.h |   20 +
 include/linux/uio.h       |   35 +-
 lib/iov_iter.c            |  284 +++++-
 mm/filemap.c              |  156 +++-
 mm/internal.h             |    6 +
 mm/vmalloc.c              |    1 +
 30 files changed, 2515 insertions(+), 1720 deletions(-)
 create mode 100644 fs/netfs/iterator.c

