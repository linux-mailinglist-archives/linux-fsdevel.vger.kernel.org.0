Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031C370C010
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjEVNvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjEVNvQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6F4F1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 06:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kGDTJmq3DDohFHD29/Tz1iEiU3NPoA4j4ZXKsNyfFas=;
        b=h8nHPq0ddfFN//T/OU+L+C1XlEzc/OwTtANiWh/e9YJmlGyi1wYceDuBWantt8yOte01e8
        VNcPogsu6vDmAsVQ3KpJOERThwDWKa5Bl34JrrHxK69G14y+LRIxQukCTfX+XN3cnPTEL3
        nbGjJ5mG2dpISNoQvf7vGF2N+9l9LPk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-GF2qHbhqMgCoLwYu32rSBQ-1; Mon, 22 May 2023 09:50:27 -0400
X-MC-Unique: GF2qHbhqMgCoLwYu32rSBQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E02933800E87;
        Mon, 22 May 2023 13:50:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4396BC1ED99;
        Mon, 22 May 2023 13:50:20 +0000 (UTC)
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
Subject: [PATCH v22 00/31] splice: Kill ITER_PIPE
Date:   Mon, 22 May 2023 14:49:47 +0100
Message-Id: <20230522135018.2742245-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

I've split off splice patchset and moved the block patches to a separate
branch (though they are dependent on this one).

This patchset kills off ITER_PIPE to avoid a race between truncate,
iov_iter_revert() on the pipe and an as-yet incomplete DMA to a bio with
unpinned/unref'ed pages from an O_DIRECT splice read.  This causes memory
corruption[2].  Instead, we use filemap_splice_read(), which invokes the
buffered file reading code and splices from the pagecache into the pipe;
copy_splice_read(), which bulk-allocates a buffer, reads into it and then
pushes the filled pages into the pipe; or handle it in filesystem-specific
code.

 (1) Rename direct_splice_read() to copy_splice_read().

 (2) Simplify the calculations for the number of pages to be reclaimed in
     copy_splice_read().

 (3) Turn do_splice_to() into a helper, vfs_splice_read(), so that it can
     be used by overlayfs and coda to perform the checks on the lower fs.

 (4) Make vfs_splice_read() jump to copy_splice_read() to handle direct-I/O
     and DAX.

 (5) Provide shmem with its own splice_read to handle non-existent pages
     in the pagecache.  We don't want a ->read_folio() as we don't want to
     populate holes, but filemap_get_pages() requires it.

 (6) Provide overlayfs with its own splice_read to call down to a lower
     layer as overlayfs doesn't provide ->read_folio().

 (7) Provide coda with its own splice_read to call down to a lower layer as
     coda doesn't provide ->read_folio().

 (8) Direct ->splice_read to copy_splice_read() in tty, procfs, kernfs
     and random files as they just copy to the output buffer and don't
     splice pages.

 (9) Provide wrappers for afs, ceph, ecryptfs, ext4, f2fs, nfs, ntfs3,
     ocfs2, orangefs, xfs and zonefs to do locking and/or revalidation.

(10) Make cifs use filemap_splice_read().

(11) Replace pointers to generic_file_splice_read() with pointers to
     filemap_splice_read() as DIO and DAX are handled in the caller;
     filesystems can still provide their own alternate ->splice_read() op.

(12) Remove generic_file_splice_read().

(13) Remove ITER_PIPE and its paraphernalia as generic_file_splice_read()
     was the only user.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=kill-iter-pipe

David

Changes:
========
ver #22)
 - Adjusted a bunch of patch subject lines.
 - In NFS, fix format spec in dprintk() for *ppos.
 - In ocfs2, pass 1 to ocfs2_inode_lock_atomic() rather than true.
 - In ocfs2, pass the splice flags into the tracepoint.
 - Added kdoc for filemap_splice_read() and copy_splice_read().

ver #21)
 - Split off the block-layer changes into a separate branch.
 - Check for zero len in vfs_splice_read().
 - Check s_maxbytes in filemap_splice_read().
 - Rename direct_splice_read() to copy_splice_read().
 - The direct I/O and DAX handling needs to be in vfs_splice_read(), not
   generic_file_splice_read(), before ->splice_read() is called.
 - Don't need #ifdef CONFIG_FS_DAX as IS_DAX() is false if !CONFIG_FS_DAX.
 - Replace pointers to generic_file_splice_read() to filemap_splice_read().
 - Remove generic_file_splice_read().
 - In ceph, drop the caps ref.
 - In NFS, Fix pos -> ppos in dprintk().

ver #20)
 - Make direct_splice_read() limit the read to eof for regular files and
   blockdevs.
 - Check against s_maxbytes on the backing store, not a devnode inode.
 - Provide wrappers for afs, ceph, ecryptfs, ext4, f2fs, nfs, ntfs3, ocfs2,
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
Link: https://lore.kernel.org/r/20230519074047.1739879-1-dhowells@redhat.com/ #v20

Additional patches that got folded in:

Link: https://lore.kernel.org/r/20230213134619.2198965-1-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20230213153301.2338806-1-dhowells@redhat.com/ # v2
Link: https://lore.kernel.org/r/20230214083710.2547248-1-dhowells@redhat.com/ # v3

David Howells (31):
  splice: Fix filemap_splice_read() to use the correct inode
  splice: Make filemap_splice_read() check s_maxbytes
  splice: Rename direct_splice_read() to copy_splice_read()
  splice: Clean up copy_splice_read() a bit
  splice: Make do_splice_to() generic and export it
  splice: Check for zero count in vfs_splice_read()
  splice: Make splice from an O_DIRECT fd use copy_splice_read()
  splice: Make splice from a DAX file use copy_splice_read()
  shmem: Implement splice-read
  overlayfs: Implement splice-read
  coda: Implement splice-read
  tty, proc, kernfs, random: Use copy_splice_read()
  net: Make sock_splice_read() use copy_splice_read() by default
  9p:  Add splice_read wrapper
  afs: Provide a splice-read wrapper
  ceph: Provide a splice-read wrapper
  ecryptfs: Provide a splice-read wrapper
  ext4: Provide a splice-read wrapper
  f2fs: Provide a splice-read wrapper
  nfs: Provide a splice-read wrapper
  ntfs3: Provide a splice-read wrapper
  ocfs2: Provide a splice-read wrapper
  orangefs: Provide a splice-read wrapper
  xfs: Provide a splice-read wrapper
  zonefs: Provide a splice-read wrapper
  trace: Convert trace/seq to use copy_splice_read()
  cifs: Use filemap_splice_read()
  splice: Use filemap_splice_read() instead of
    generic_file_splice_read()
  splice: Remove generic_file_splice_read()
  iov_iter: Kill ITER_PIPE
  splice: kdoc for filemap_splice_read() and copy_splice_read()

 block/fops.c            |   2 +-
 drivers/char/random.c   |   4 +-
 drivers/tty/tty_io.c    |   4 +-
 fs/9p/vfs_file.c        |  26 ++-
 fs/adfs/file.c          |   2 +-
 fs/affs/file.c          |   2 +-
 fs/afs/file.c           |  20 +-
 fs/bfs/file.c           |   2 +-
 fs/btrfs/file.c         |   2 +-
 fs/ceph/file.c          |  65 +++++-
 fs/cifs/cifsfs.c        |  12 +-
 fs/cifs/cifsfs.h        |   3 -
 fs/cifs/file.c          |  16 --
 fs/coda/file.c          |  29 ++-
 fs/cramfs/inode.c       |   2 +-
 fs/ecryptfs/file.c      |  27 ++-
 fs/erofs/data.c         |   2 +-
 fs/exfat/file.c         |   2 +-
 fs/ext2/file.c          |   2 +-
 fs/ext4/file.c          |  13 +-
 fs/f2fs/file.c          |  43 +++-
 fs/fat/file.c           |   2 +-
 fs/fuse/file.c          |   2 +-
 fs/gfs2/file.c          |   4 +-
 fs/hfs/inode.c          |   2 +-
 fs/hfsplus/inode.c      |   2 +-
 fs/hostfs/hostfs_kern.c |   2 +-
 fs/hpfs/file.c          |   2 +-
 fs/jffs2/file.c         |   2 +-
 fs/jfs/file.c           |   2 +-
 fs/kernfs/file.c        |   2 +-
 fs/minix/file.c         |   2 +-
 fs/nfs/file.c           |  23 ++-
 fs/nfs/internal.h       |   2 +
 fs/nfs/nfs4file.c       |   2 +-
 fs/nilfs2/file.c        |   2 +-
 fs/ntfs/file.c          |   2 +-
 fs/ntfs3/file.c         |  31 ++-
 fs/ocfs2/file.c         |  43 +++-
 fs/ocfs2/ocfs2_trace.h  |   3 +
 fs/omfs/file.c          |   2 +-
 fs/orangefs/file.c      |  22 +-
 fs/overlayfs/file.c     |  23 ++-
 fs/proc/inode.c         |   4 +-
 fs/proc/proc_sysctl.c   |   2 +-
 fs/proc_namespace.c     |   6 +-
 fs/ramfs/file-mmu.c     |   2 +-
 fs/ramfs/file-nommu.c   |   2 +-
 fs/read_write.c         |   2 +-
 fs/reiserfs/file.c      |   2 +-
 fs/romfs/mmap-nommu.c   |   2 +-
 fs/splice.c             | 127 ++++++------
 fs/sysv/file.c          |   2 +-
 fs/ubifs/file.c         |   2 +-
 fs/udf/file.c           |   2 +-
 fs/ufs/file.c           |   2 +-
 fs/vboxsf/file.c        |   2 +-
 fs/xfs/xfs_file.c       |  30 ++-
 fs/xfs/xfs_trace.h      |   2 +-
 fs/zonefs/file.c        |  40 +++-
 include/linux/fs.h      |   8 +-
 include/linux/splice.h  |   3 +
 include/linux/uio.h     |  14 --
 kernel/trace/trace.c    |   2 +-
 lib/iov_iter.c          | 431 +---------------------------------------
 mm/filemap.c            |  31 ++-
 mm/shmem.c              | 134 ++++++++++++-
 net/socket.c            |   2 +-
 68 files changed, 694 insertions(+), 621 deletions(-)

