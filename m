Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2B8665DF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 15:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbjAKOcG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 09:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbjAKObm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:31:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E823752B
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 06:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673447263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Encmrg/Q4pn4U4TaedIzlRttIsiQ9mtGF2IR0CVdSuk=;
        b=Ge0jJUV+wWT5y4MH4ONcnbmSul5rUe4Rzp5y8P3ipTWuPCT26HordYOr+CNCqbdc+raNX9
        qn6Bw63c7Cf8KFpmY/+ILY8zxJT5mD+MCbxoF8kFHf8pYdJsPZWeuDSxO6oCGlu/lV3GMC
        rF2vxuuAdK+ouiHr2Eo//850zV9XAUs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-lPtvx7LnPke_XH7ONluRdw-1; Wed, 11 Jan 2023 09:27:39 -0500
X-MC-Unique: lPtvx7LnPke_XH7ONluRdw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1301857D0D;
        Wed, 11 Jan 2023 14:27:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0D39492C14;
        Wed, 11 Jan 2023 14:27:35 +0000 (UTC)
Subject: [PATCH v5 0/9] iov_iter: Add extraction helpers
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cachefs@redhat.com,
        Jan Kara <jack@suse.cz>, Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>, linux-cifs@vger.kernel.org,
        dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 11 Jan 2023 14:27:35 +0000
Message-ID: <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
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

Here are patches clean up some use of READ/WRITE and ITER_SOURCE/DEST,
patches to provide support for extracting pages from an iov_iter and a
patch to use the primary extraction function in the block layer bio code if
you could take a look?

[!] NOTE that I've switched the functions to be exported GPL-only at
    Christoph's request[1].  They are, however, intended as a replacement
    for iov_iter_get_pages*(), which is not marked _GPL - so that
    functionality will probably become unavailable to non-GPL 3rd party
    modules in future.

The first three patches deal with ITER_SOURCE/DEST:

 (1) Switch ITER_SOURCE/DEST to an enum and add a couple of helper
     functions to query if an iterator represents a source or a destination
     buffer.  Using an enum may allow extra consistency warnings from the
     compiler.

 (2) Use the ITER_SOURCE/DEST values in the iov_iter core functions rather
     than READ/WRITE.

 (3) Get rid of most of the callers of iov_iter_rw(), using the IOCB_WRITE
     and IOMAP_WRITE instead where available.  This leaves only two places
     looking at the this value: a consistency check in cifs and a single
     place in the block layer.

The next patch adds a replacement for iov_iter_get_pages*(), including
Logan's new version:

 (4) Add a function to list-only, get or pin pages from an iterator as a
     future replacement for iov_iter_get_pages*().  Pointers to the pages
     are placed into an array (which will get allocated if not provided)
     and, depending on the iterator type and direction, the pages will have
     a ref or a pin get on them or be left untouched (on the assumption
     that the caller manages their lifetime).

     The determination is:

	UBUF/IOVEC + DEST	-> pin
	UBUF/IOVEC + SOURCE	-> get
	PIPE + DEST		-> list-only
	BVEC/XARRAY		-> list-only
	Anything else		-> EFAULT

     The function also returns an indication of which of "list only, get or
     pin" the extraction function did to aid in cleaning up (returning 0,
     FOLL_GET or FOLL_PIN as appropriate).

Then there are a couple of patches that add stuff to netfslib that I want
to use there as well as in cifs:

 (5) Add a netfslib function to use (4) to extract pages from an ITER_IOBUF
     or ITER_UBUF iterator into an ITER_BVEC iterator.  This will get or
     pin the pages as appropriate.

 (6) Add a netfslib function to extract pages from an iterator that's of
     type ITER_UBUF/IOVEC/BVEC/KVEC/XARRAY and add them to a scatterlist.

     The function in (4) is used for a UBUF and IOVEC iterators, so those
     need cleaning up afterwards.  BVEC and XARRAY iterators are ungot and
     unpinned and may be rendered into elements that span multiple pages,
     for example if large folios are present.

Finally, there are a set of three patches to make the block layer's BIO
code use iov_iter_extract_pages():

 (7) Replace BIO_NO_PAGE_REF with BIO_PAGE_REFFED (opposite logic).

 (8) Make the block layer's BIO code pin pages or leave pages unaltered
     rather than getting a ref on the pages when the circumstances warrant,
     and noting in the bio struct what cleanups should be performed so that
     the bio cleanup code then does the right thing.

 (9) Remove an unnecessary check against 0 in bio_flagged() (it returns
     bool) thus allowing the gcc optimiser to combine multiple instances of
     the bitwise-AND on the same flags value.

Changes:
========
ver #5)
 - Replace BIO_NO_PAGE_REF with BIO_PAGE_REFFED and split into own patch.
 - Transcribe FOLL_GET/PIN into BIO_PAGE_REFFED/PINNED flags.
 - Add patch to allow bio_flagged() to be combined by gcc.

ver #4)
 - Drop the patch to move the FOLL_* flags to linux/mm_types.h as they're
   no longer referenced by linux/uio.h.
 - Add ITER_SOURCE/DEST cleanup patches.
 - Make iov_iter/netfslib iter extraction patches use ITER_SOURCE/DEST.
 - Allow additional gup_flags to be passed into iov_iter_extract_pages().
 - Add struct bio patch.

ver #3)
 - Switch to using EXPORT_SYMBOL_GPL to prevent indirect 3rd-party access
   to get/pin_user_pages_fast()[1].

ver #2)
 - Rolled the extraction cleanup mode query function into the extraction
   function, returning the indication through the argument list.
 - Fixed patch 4 (extract to scatterlist) to actually use the new
   extraction API.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-extract

David

Link: https://lore.kernel.org/r/Y3zFzdWnWlEJ8X8/@infradead.org/ [1]
Link: https://lore.kernel.org/r/166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166722777223.2555743.162508599131141451.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166732024173.3186319.18204305072070871546.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166869687556.3723671.10061142538708346995.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166920902005.1461876.2786264600108839814.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/166997419665.9475.15014699817597102032.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk/ # v4

---
David Howells (9):
      iov_iter: Change the direction macros into an enum
      iov_iter: Use the direction in the iterator functions
      iov_iter: Use IOCB/IOMAP_WRITE if available rather than iterator direction
      iov_iter: Add a function to extract a page list from an iterator
      netfs: Add a function to extract a UBUF or IOVEC into a BVEC iterator
      netfs: Add a function to extract an iterator into a scatterlist
      bio: Rename BIO_NO_PAGE_REF to BIO_PAGE_REFFED and invert the meaning
      iov_iter, block: Make bio structs pin pages rather than ref'ing if appropriate
      bio: Fix bio_flagged() so that it can be combined


 block/bio.c               |  59 ++++--
 block/fops.c              |   8 +-
 fs/9p/vfs_addr.c          |   2 +-
 fs/affs/file.c            |   4 +-
 fs/ceph/file.c            |   2 +-
 fs/dax.c                  |   6 +-
 fs/direct-io.c            |  22 +--
 fs/exfat/inode.c          |   6 +-
 fs/ext2/inode.c           |   2 +-
 fs/f2fs/file.c            |  10 +-
 fs/fat/inode.c            |   4 +-
 fs/fuse/dax.c             |   2 +-
 fs/fuse/file.c            |   8 +-
 fs/hfs/inode.c            |   2 +-
 fs/hfsplus/inode.c        |   2 +-
 fs/iomap/direct-io.c      |   6 +-
 fs/jfs/inode.c            |   2 +-
 fs/netfs/Makefile         |   1 +
 fs/netfs/iterator.c       | 367 ++++++++++++++++++++++++++++++++++
 fs/nfs/direct.c           |   2 +-
 fs/nilfs2/inode.c         |   2 +-
 fs/ntfs3/inode.c          |   2 +-
 fs/ocfs2/aops.c           |   2 +-
 fs/orangefs/inode.c       |   2 +-
 fs/reiserfs/inode.c       |   2 +-
 fs/udf/inode.c            |   2 +-
 include/linux/bio.h       |   5 +-
 include/linux/blk_types.h |   3 +-
 include/linux/netfs.h     |   7 +
 include/linux/uio.h       |  59 ++++--
 lib/iov_iter.c            | 407 +++++++++++++++++++++++++++++++++++---
 mm/vmalloc.c              |   1 +
 32 files changed, 903 insertions(+), 108 deletions(-)
 create mode 100644 fs/netfs/iterator.c


