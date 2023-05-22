Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE0A70CBB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 22:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbjEVU6m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 16:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjEVU6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 16:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B638BC2
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684789073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SVo/OPz1sjS/f50cGx7T062W5Iem3nbuZQWCmdXefsI=;
        b=eFRFUUlq38nrPysQ9eCHOh54VCzOZ3W3tKDWniKf6svcKoetaG6ZJV4rDYreERS45LIiX/
        KBimpjx4cv0tBZK6AB5IqZBbQEDQ/lOJMGAaeaqDZnbfIXLSiy4QFsYPAGcsuyeOUUiLEY
        lwHplaA1yiNPYBQvltCGJ92RXn8eLWE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-xDKuyN60P1WngCzk1RKB_Q-1; Mon, 22 May 2023 16:57:49 -0400
X-MC-Unique: xDKuyN60P1WngCzk1RKB_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E652F800BFF;
        Mon, 22 May 2023 20:57:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 552731121314;
        Mon, 22 May 2023 20:57:46 +0000 (UTC)
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
Subject: [PATCH v21 0/6] block: Use page pinning
Date:   Mon, 22 May 2023 21:57:38 +0100
Message-Id: <20230522205744.2825689-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens, Al, Christoph,

This patchset rolls page-pinning out to the bio struct and the block layer,
using iov_iter_extract_pages() to get pages and noting with BIO_PAGE_PINNED
if the data pages attached to a bio are pinned.  If the data pages come
from a non-user-backed iterator, then the pages are left unpinned and
unref'd, relying on whoever set up the I/O to do the retaining.

This requires the splice-read patchset to have been applied first,
otherwise reversion of the ITER_PAGE iterator can race with truncate and
return pages to the allocator whilst they're still undergoing DMA[2].

 (1) Don't hold a ref on ZERO_PAGE in iomap_dio_zero().

 (2) Fix bio_flagged() so that it doesn't prevent a gcc optimisation.

 (3) Make the bio struct carry a pair of flags to indicate the cleanup
     mode.  BIO_NO_PAGE_REF is replaced with BIO_PAGE_REFFED (indicating
     FOLL_GET was used) and BIO_PAGE_PINNED (indicating FOLL_PIN was used)
     is added.

     BIO_PAGE_REFFED will go away, but at the moment fs/direct-io.c sets it
     and this series does not fully address that file.

 (4) Add a function, bio_release_page(), to release a page appropriately to
     the cleanup mode indicated by the BIO_PAGE_* flags.

 (5) Make bio_iov_iter_get_pages() use iov_iter_extract_pages() to retain
     the pages appropriately and clean them up later.

 (6) Make bio_map_user_iov() also use iov_iter_extract_pages().

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-extract

David

Changes:
========
ver #21)
 - Split off the splice-read patchset to reduce the patch count.

ver #20)
 - Make direct_splice_read() limit the read to eof for regular files and
   blockdevs.
 - Check against s_maxbytes on the backing store, not a devnode inode.
 - Provide stubs for afs, ceph, ecryptfs, ext4, f2fs, nfs, ntfs3, ocfs2,
   orangefs, xfs and zonefs.
 - Always use direct_splice_read() for 9p, trace and sockets.

ver #19)
 - Remove a missed get_page() on the zeropage in shmem_splice_read().

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
Link: https://lore.kernel.org/r/20230314220757.3827941-1-dhowells@redhat.com/ # v18
Link: https://lore.kernel.org/r/20230315163549.295454-1-dhowells@redhat.com/ # v19
Link: https://lore.kernel.org/r/20230519074047.1739879-1-dhowells@redhat.com/ # v20

Splice-read patch subset:
Link: https://lore.kernel.org/r/20230520000049.2226926-1-dhowells@redhat.com/ # v21
Link: https://lore.kernel.org/r/20230522135018.2742245-1-dhowells@redhat.com/ # v22

Additional patches that got folded in:

Link: https://lore.kernel.org/r/20230213134619.2198965-1-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20230213153301.2338806-1-dhowells@redhat.com/ # v2
Link: https://lore.kernel.org/r/20230214083710.2547248-1-dhowells@redhat.com/ # v3

Christoph Hellwig (1):
  block: Replace BIO_NO_PAGE_REF with BIO_PAGE_REFFED with inverted
    logic

David Howells (5):
  iomap: Don't get an reference on ZERO_PAGE for direct I/O block
    zeroing
  block: Fix bio_flagged() so that gcc can better optimise it
  block: Add BIO_PAGE_PINNED and associated infrastructure
  block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages
  block: convert bio_map_user_iov to use iov_iter_extract_pages

 block/bio.c               | 29 +++++++++++++++--------------
 block/blk-map.c           | 22 +++++++++++-----------
 block/blk.h               | 12 ++++++++++++
 fs/direct-io.c            |  2 ++
 fs/iomap/direct-io.c      |  1 -
 include/linux/bio.h       |  5 +++--
 include/linux/blk_types.h |  3 ++-
 7 files changed, 45 insertions(+), 29 deletions(-)

