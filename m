Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446A4675C35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 18:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjATR4t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 12:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjATR4s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:56:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F77EC17E
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 09:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674237367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L1vbMszv9II0pr/36LhZgm3t0G5zZlJBs1R5Ur/EGww=;
        b=CKfWbxXeBa7aMnhtztYh99aPfvRIcOhvdqrCfjg0FBMuxF4NoHiQ0ImhAy9oLVAnBgTXdw
        ShViXthNEi/hVZ/dSDOUSe7T9McLhTI43VXoeJyfhuW8+y++PYgxCHoKga9ru0YFPnPoce
        t+4NjGvp/IjAcl4q416U0101aPkjRsE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-JeBkd2PCM0urfNQeCIc4vA-1; Fri, 20 Jan 2023 12:56:04 -0500
X-MC-Unique: JeBkd2PCM0urfNQeCIc4vA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8474B802C1D;
        Fri, 20 Jan 2023 17:56:02 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31E7253AA;
        Fri, 20 Jan 2023 17:56:01 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/8] iov_iter: Improve page extraction (ref, pin or just list)
Date:   Fri, 20 Jan 2023 17:55:48 +0000
Message-Id: <20230120175556.3556978-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al, Christoph,

Here are patches to provide support for extracting pages from an iov_iter
and a patch to use the primary extraction function in the block layer bio
code.

The patches make the following changes:

 (1) Add a function, iov_iter_extract_pages() to replace
     iov_iter_get_pages*() that gets refs, pins or just lists the pages as
     appropriate to the iterator type and the I/O direction.

     Add a function, iov_iter_extract_mode() that will indicate from the
     iterator type and the I/O direction how the cleanup is to be
     performed, returning FOLL_GET, FOLL_PIN or 0.

 (2) Add a function, folio_put_unpin(), and a wrapper, page_put_unpin(),
     that take a page and the return from iov_iter_extract_mode() and do
     the right thing to clean up the page.

 (3) Make the bio struct carry a pair of flags to indicate the cleanup
     mode.  BIO_NO_PAGE_REF is replaced with BIO_PAGE_REFFED (equivalent to
     FOLL_GET) and BIO_PAGE_PINNED (equivalent to BIO_PAGE_PINNED) is
     added.

 (4) Add a function, bio_release_page(), to release a page appropriately to
     the cleanup mode indicated by the BIO_PAGE_* flags.

 (5) Make the iter-to-bio code use iov_iter_extract_pages() to retain the
     pages appropriately and clean them up later.

 (6) Fix bio_flagged() so that it doesn't prevent a gcc optimisation.

 (7) Renumber FOLL_GET and FOLL_PIN down so that they're at bits 0 and 1
     and coincident with BIO_PAGE_REFFED and BIO_PAGE_PINNED.  The compiler
     can then optimise on that.  Also, it's probably going to be necessary
     to embed these in the page pointer in sk_buff fragments.  This patch
     can go independently through the mm tree.

Changes:
========
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

I've pushed the patches (excluding the two WIP networking patches) here
also:

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
Link: https://lore.kernel.org/r/167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk/ # v5
Link: https://lore.kernel.org/r/167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk/ # v6

David Howells (8):
  iov_iter: Define flags to qualify page extraction.
  iov_iter: Add a function to extract a page list from an iterator
  mm: Provide a helper to drop a pin/ref on a page
  block: Rename BIO_NO_PAGE_REF to BIO_PAGE_REFFED and invert the
    meaning
  block: Add BIO_PAGE_PINNED
  block: Make bio structs pin pages rather than ref'ing if appropriate
  block: Fix bio_flagged() so that gcc can better optimise it
  mm: Renumber FOLL_GET and FOLL_PIN down

 block/bio.c               |  43 ++--
 block/blk-map.c           |  26 +--
 block/blk.h               |  29 +++
 fs/iomap/direct-io.c      |   1 -
 include/linux/bio.h       |   5 +-
 include/linux/blk_types.h |   3 +-
 include/linux/mm.h        |  17 +-
 include/linux/uio.h       |  35 ++-
 lib/iov_iter.c            | 438 +++++++++++++++++++++++++++++++++++++-
 mm/gup.c                  |  22 ++
 10 files changed, 571 insertions(+), 48 deletions(-)

