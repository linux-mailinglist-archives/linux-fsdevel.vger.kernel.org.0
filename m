Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9634B67BD9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 22:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbjAYVH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 16:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjAYVHz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:07:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BF34ABFD
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 13:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674680826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ADJBHBSQO9c3rp8+698fJfvCCb9Mh4itPrPUhtne/TY=;
        b=O6pTvXYKrGtbdDf2Wm8YYNO8wdmit6G2hmqdCLFq0oF10b5j/4FREeGWldSMy94SnRhepf
        jWKMxhziNFQyzRbnz6cNkJ6TYpCZFxC4bdhaKRJOTghhDdythvSbmD40LY7jc43X2oeLpS
        2j66X55M1wILIXa3JHcfMtc0Ra414QE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-AVIQIay9PYmttcPLYftLlA-1; Wed, 25 Jan 2023 16:07:02 -0500
X-MC-Unique: AVIQIay9PYmttcPLYftLlA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B0651871CD5;
        Wed, 25 Jan 2023 21:07:02 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5482E1121330;
        Wed, 25 Jan 2023 21:07:00 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v10 0/8] iov_iter: Improve page extraction (pin or just list)
Date:   Wed, 25 Jan 2023 21:06:49 +0000
Message-Id: <20230125210657.2335748-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
and to use this in the extraction functions in the block layer bio code.

The patches make the following changes:

 (1) Add a function, iov_iter_extract_pages() to replace
     iov_iter_get_pages*() that gets refs, pins or just lists the pages as
     appropriate to the iterator type.

     Add a function, iov_iter_extract_will_pin() that will indicate from
     the iterator type how the cleanup is to be performed, returning true
     if the pages will need unpinning, false otherwise.

 (2) Make the bio struct carry a pair of flags to indicate the cleanup
     mode.  BIO_NO_PAGE_REF is replaced with BIO_PAGE_REFFED (indicating
     FOLL_GET was used) and BIO_PAGE_PINNED (indicating FOLL_PIN was used)
     is added.

     BIO_PAGE_REFFED will go away, but at the moment fs/direct-io.c sets it
     and this series does not fully address that file.

 (4) Add a function, bio_release_page(), to release a page appropriately to
     the cleanup mode indicated by the BIO_PAGE_* flags.

 (5) Make the iter-to-bio code use iov_iter_extract_pages() to retain the
     pages appropriately and clean them up later.

 (6) Fix bio_flagged() so that it doesn't prevent a gcc optimisation.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-extract

David

Changes:
========
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

Christoph Hellwig (1):
  block: Replace BIO_NO_PAGE_REF with BIO_PAGE_REFFED with inverted
    logic

David Howells (7):
  iov_iter: Define flags to qualify page extraction.
  iov_iter: Add a function to extract a page list from an iterator
  iomap: Don't get an reference on ZERO_PAGE for direct I/O block
    zeroing
  block: Fix bio_flagged() so that gcc can better optimise it
  block: Add BIO_PAGE_PINNED and associated infrastructure
  block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages
  block: convert bio_map_user_iov to use iov_iter_extract_pages

 block/bio.c               |  33 ++--
 block/blk-map.c           |  26 +--
 block/blk.h               |  12 ++
 fs/direct-io.c            |   2 +
 fs/iomap/direct-io.c      |   1 -
 include/linux/bio.h       |   5 +-
 include/linux/blk_types.h |   3 +-
 include/linux/uio.h       |  32 +++-
 lib/iov_iter.c            | 335 +++++++++++++++++++++++++++++++++++++-
 9 files changed, 408 insertions(+), 41 deletions(-)

