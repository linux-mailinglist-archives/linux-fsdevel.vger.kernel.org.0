Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B85A6BA1D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCNWJF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCNWJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:09:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1F34AFF9
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678831691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0EFAYC76sQRuIJ4YVGnYA8T7rOf78ia0Aa+hXH+8NiY=;
        b=VhWpjFFQN7hJgg1rbsJhAn4rSEZVmCV5n9d7fOy+QQfEPyloRGMRRZlGP9koXsNSLKLUq0
        6UDjucqPA/SBJsxOn8ikhNjd9/QtDzgCtdluP5gyLfWL3ue4e0nTywzKaqqBMlyFg6oUF2
        qxRM/WDHCWV7evM5eIRFkuGBoUgIG9c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-ahYS2-hiNluHyCTgwX6laQ-1; Tue, 14 Mar 2023 18:08:07 -0400
X-MC-Unique: ahYS2-hiNluHyCTgwX6laQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FBA9811E9C;
        Tue, 14 Mar 2023 22:08:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE9AB140EBF4;
        Tue, 14 Mar 2023 22:08:04 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v18 00/15] splice, block: Use page pinning and kill ITER_PIPE
Date:   Tue, 14 Mar 2023 22:07:42 +0000
Message-Id: <20230314220757.3827941-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens, Al, Christoph,

The first half of this patchset kills off ITER_PIPE to avoid a race between
truncate, iov_iter_revert() on the pipe and an as-yet incomplete DMA to a
bio with unpinned/unref'ed pages from an O_DIRECT splice read.  This causes
memory corruption[2].  Instead, we use filemap_splice_read(), which invokes
the buffered file reading code and splices from the pagecache into the
pipe; direct_splice_read(), which bulk-allocates a buffer, reads into it
and then pushes the filled pages into the pipe; or handle it in
filesystem-specific code.

 (1) Simplify the calculations for the number of pages to be reclaimed in
     direct_splice_read().

 (2) Turn do_splice_to() into a helper so that it can be used by overlayfs
     and coda to perform the checks on the lower fs.

 (3) Provide shmem with its own splice_read to handle non-existent pages
     in the pagecache.  We don't want a ->read_folio() as we don't want to
     populate holes, but filemap_get_pages() requires it.

 (4) Provide overlayfs with its own splice_read to call down to a lower
     layer as overlayfs doesn't provide ->read_folio().

 (5) Provide coda with its own splice_read to call down to a lower layer as
     coda doesn't provide ->read_folio().

 (6) Direct ->splice_read to direct_splice_read() in tty, procfs, kernfs
     and random files as they just copy to the output buffer and don't
     splice pages.

 (7) Change generic_file_splice_read() to just switch between
     filemap_splice_read() and direct_splice_read() rather than using
     ITER_PIPE.

 (8) Make cifs use generic_file_splice_read().

 (9) Remove ITER_PIPE and its paraphernalia as generic_file_splice_read()
     was the only user.

The second half of the patchset rolls page-pinning out to the bio struct
and the block layer, using iov_iter_extract_pages() to get pages and noting
with BIO_PAGE_PINNED if the data pages attached to a bio are pinned.  If
the data pages come from a non-user-backed iterator, then the pages are
left unpinned and unref'd, relying on whoever set up the I/O to do the
retaining

(10) Don't hold a ref on ZERO_PAGE in iomap_dio_zero().

(11) Fix bio_flagged() so that it doesn't prevent a gcc optimisation.

(12) Make the bio struct carry a pair of flags to indicate the cleanup
     mode.  BIO_NO_PAGE_REF is replaced with BIO_PAGE_REFFED (indicating
     FOLL_GET was used) and BIO_PAGE_PINNED (indicating FOLL_PIN was used)
     is added.

     BIO_PAGE_REFFED will go away, but at the moment fs/direct-io.c sets it
     and this series does not fully address that file.

(13) Add a function, bio_release_page(), to release a page appropriately to
     the cleanup mode indicated by the BIO_PAGE_* flags.

(14) Make bio_iov_iter_get_pages() use iov_iter_extract_pages() to retain
     the pages appropriately and clean them up later.

(15) Make bio_map_user_iov() also use iov_iter_extract_pages().

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-extract

David

Changes:
========
ver #18)
 - Split out the cifs bits from the patch the switches
   generic_file_splice_read() over to using the non-ITER_PIPE splicing.
 - Don't get/put refs on the zeropage in shmem_splice_read().

ver #17)
 - Rename do_splice_to() to vfs_splice_read() and export it so that it can
   be a helper and make overlayfs and coda use it, allowing duplicate
   checks to be removed.

ver #16)
 - The filemap_get_pages() changes are now upstream.
 - filemap_splice_read() and direct_splice_read() are now upstream.
 - iov_iter_extract_pages() is now upstream.

ver #15)
 - Fixed up some errors in overlayfs_splice_read().

ver #14)
 - Some changes to generic_file_buffered_splice_read():
   - Rename to filemap_splice_read() and move to mm/filemap.c.
   - Create a helper, pipe_head_buf().
   - Use init_sync_kiocb().
 - Some changes to generic_file_direct_splice_read():
   - Use alloc_pages_bulk_array() rather than alloc_pages_bulk_list().
   - Use release_pages() instead of __free_page() in a loop.
   - Rename to direct_splice_read().
 - Rearrange the patches to implement filemap_splice_read() and
   direct_splice_read() separately to changing generic_file_splice_read().
 - Don't call generic_file_splice_read() when there isn't a ->read_folio().
 - Insert patches to fix read_folio-less cases:
   - Make tty, procfs, kernfs and (u)random use direct_splice_read().
   - Make overlayfs and coda call down to a lower layer.
   - Give shmem its own splice-read that doesn't insert missing pages.
 - Fixed a min() with mixed type args on some arches.

ver #13)
 - Only use allocation in advance and ITER_BVEC for DIO read-splice.
 - Make buffered read-splice get pages directly from the pagecache.
 - Alter filemap_get_pages() & co. so that it doesn't need an iterator.

ver #12)
 - Added the missing __bitwise on the iov_iter_extraction_t typedef.
 - Rebased on -rc7.
 - Don't specify FOLL_PIN to pin_user_pages_fast().
 - Inserted patch at front to fix race between DIO read and truncation that
   caused memory corruption when iov_iter_revert() got called on an
   ITER_PIPE iterator[2].
 - Inserted a patch after that to remove the now-unused ITER_PIPE and its
   helper functions.
 - Removed the ITER_PIPE bits from iov_iter_extract_pages().

ver #11)
 - Fix iov_iter_extract_kvec_pages() to include the offset into the page in
   the returned starting offset.
 - Use __bitwise for the extraction flags

ver #10)
 - Fix use of i->kvec in iov_iter_extract_bvec_pages() to be i->bvec.
 - Drop bio_set_cleanup_mode(), open coding it instead.

ver #9)
 - It's now not permitted to use FOLL_PIN outside of mm/, so:
 - Change iov_iter_extract_mode() into iov_iter_extract_will_pin() and
   return true/false instead of FOLL_PIN/0.
 - Drop of folio_put_unpin() and page_put_unpin() and instead call
   unpin_user_page() (and put_page()) directly as necessary.
 - Make __bio_release_pages() call bio_release_page() instead of
   unpin_user_page() as there's no BIO_* -> FOLL_* translation to do.
 - Drop the FOLL_* renumbering patch.
 - Change extract_flags to extraction_flags.

ver #8)
 - Import Christoph Hellwig's changes.
   - Split the conversion-to-extraction patch.
   - Drop the extract_flags arg from iov_iter_extract_mode().
   - Don't default bios to BIO_PAGE_REFFED, but set explicitly.
 - Switch FOLL_PIN and FOLL_GET when renumbering so PIN is at bit 0.
 - Switch BIO_PAGE_PINNED and BIO_PAGE_REFFED so PINNED is at bit 0.
 - We should always be using FOLL_PIN (not FOLL_GET) for DIO, so adjust the
   patches for that.

ver #7)
 - For now, drop the parts to pass the I/O direction to iov_iter_*pages*()
   as it turned out to be a lot more complicated, with places not setting
   IOCB_WRITE when they should, for example.
 - Drop all the patches that changed things other then the block layer's
   bio handling.  The netfslib and cifs changes can go into a separate
   patchset.
 - Add support for extracting pages from KVEC-type iterators.
 - When extracting from BVEC/KVEC, skip over empty vecs at the front.

ver #6)
 - Fix write() syscall and co. not setting IOCB_WRITE.
 - Added iocb_is_read() and iocb_is_write() to check IOCB_WRITE.
 - Use op_is_write() in bio_copy_user_iov().
 - Drop the iterator direction checks from smbd_recv().
 - Define FOLL_SOURCE_BUF and FOLL_DEST_BUF and pass them in as part of
   gup_flags to iov_iter_get/extract_pages*().
 - Replace iov_iter_get_pages*2() with iov_iter_get_pages*() and remove.
 - Add back the function to indicate the cleanup mode.
 - Drop the cleanup_mode return arg to iov_iter_extract_pages().
 - Provide a helper to clean up a page.
 - Renumbered FOLL_GET and FOLL_PIN and made BIO_PAGE_REFFED/PINNED have
   the same numerical values, enforced with an assertion.
 - Converted AF_ALG, SCSI vhost, generic DIO, FUSE, splice to pipe, 9P and
   NFS.
 - Added in the patches to make CIFS do top-to-bottom iterators and use
   various of the added extraction functions.
 - Added a pair of work-in-progess patches to make sk_buff fragments store
   FOLL_GET and FOLL_PIN.

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

Link: https://lore.kernel.org/r/Y3zFzdWnWlEJ8X8/@infradead.org/ [1]
Link: https://lore.kernel.org/r/000000000000b0b3c005f3a09383@google.com/ [2]
Link: https://lore.kernel.org/r/166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166722777223.2555743.162508599131141451.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166732024173.3186319.18204305072070871546.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166869687556.3723671.10061142538708346995.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166920902005.1461876.2786264600108839814.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/166997419665.9475.15014699817597102032.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk/ # v5
Link: https://lore.kernel.org/r/167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk/ # v6
Link: https://lore.kernel.org/r/20230120175556.3556978-1-dhowells@redhat.com/ # v7
Link: https://lore.kernel.org/r/20230123173007.325544-1-dhowells@redhat.com/ # v8
Link: https://lore.kernel.org/r/20230124170108.1070389-1-dhowells@redhat.com/ # v9
Link: https://lore.kernel.org/r/20230125210657.2335748-1-dhowells@redhat.com/ # v10
Link: https://lore.kernel.org/r/20230126141626.2809643-1-dhowells@redhat.com/ # v11
Link: https://lore.kernel.org/r/20230207171305.3716974-1-dhowells@redhat.com/ # v12
Link: https://lore.kernel.org/r/20230209102954.528942-1-dhowells@redhat.com/ # v13
Link: https://lore.kernel.org/r/20230214171330.2722188-1-dhowells@redhat.com/ # v14
Link: https://lore.kernel.org/r/20230308143754.1976726-1-dhowells@redhat.com/ # v16
Link: https://lore.kernel.org/r/20230308165251.2078898-1-dhowells@redhat.com/ # v17

Additional patches that got folded in:

Link: https://lore.kernel.org/r/20230213134619.2198965-1-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20230213153301.2338806-1-dhowells@redhat.com/ # v2
Link: https://lore.kernel.org/r/20230214083710.2547248-1-dhowells@redhat.com/ # v3

Christoph Hellwig (1):
  block: Replace BIO_NO_PAGE_REF with BIO_PAGE_REFFED with inverted
    logic

David Howells (14):
  splice: Clean up direct_splice_read() a bit
  splice: Make do_splice_to() generic and export it
  shmem: Implement splice-read
  overlayfs: Implement splice-read
  coda: Implement splice-read
  tty, proc, kernfs, random: Use direct_splice_read()
  splice: Do splice read from a file without using ITER_PIPE
  cifs: Use generic_file_splice_read()
  iov_iter: Kill ITER_PIPE
  iomap: Don't get an reference on ZERO_PAGE for direct I/O block
    zeroing
  block: Fix bio_flagged() so that gcc can better optimise it
  block: Add BIO_PAGE_PINNED and associated infrastructure
  block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages
  block: convert bio_map_user_iov to use iov_iter_extract_pages

 block/bio.c               |  29 +--
 block/blk-map.c           |  22 +-
 block/blk.h               |  12 ++
 drivers/char/random.c     |   4 +-
 drivers/tty/tty_io.c      |   4 +-
 fs/cifs/cifsfs.c          |   8 +-
 fs/cifs/cifsfs.h          |   3 -
 fs/cifs/file.c            |  16 --
 fs/coda/file.c            |  29 ++-
 fs/direct-io.c            |   2 +
 fs/iomap/direct-io.c      |   1 -
 fs/kernfs/file.c          |   2 +-
 fs/overlayfs/file.c       |  23 +-
 fs/proc/inode.c           |   4 +-
 fs/proc/proc_sysctl.c     |   2 +-
 fs/proc_namespace.c       |   6 +-
 fs/splice.c               |  76 +++----
 include/linux/bio.h       |   5 +-
 include/linux/blk_types.h |   3 +-
 include/linux/splice.h    |   3 +
 include/linux/uio.h       |  14 --
 lib/iov_iter.c            | 429 +-------------------------------------
 mm/filemap.c              |   4 +-
 mm/shmem.c                | 135 +++++++++++-
 24 files changed, 285 insertions(+), 551 deletions(-)

