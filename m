Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0921C680BB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 12:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbjA3LPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 06:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbjA3LPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 06:15:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA0426BC
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 03:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675077259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TIVgjeUj3dIgfNSWC3z+gWYtjjdQE8DbXVt88JyPe4o=;
        b=MGyRoK4y9/HxSwUept3Wwwscs1rBCMyjouy67JTw/CqvMYqcF0hgL/KsWwnJBqD+uTzac1
        hwN77VXpZ7EcEcyCNLCtJ9LuK8q3oIxDl/9VQfhaXK9ztt7525bpk6WtyW/Xv3tvxOiveZ
        cVdAAn6svdBmeWETRCBbO+XCPqSgogA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-QpjC7TFzNricGKbyb3dEiw-1; Mon, 30 Jan 2023 06:14:14 -0500
X-MC-Unique: QpjC7TFzNricGKbyb3dEiw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8A93801779;
        Mon, 30 Jan 2023 11:14:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37CEB2166B26;
        Mon, 30 Jan 2023 11:14:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jeff Layton <jlayton@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3351098.1675077249.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 30 Jan 2023 11:14:09 +0000
Message-ID: <3351099.1675077249@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

Could you consider pulling this patchset into the block tree?  I think tha=
t
Al's fears wrt to pinned pages being removed from page tables causing dead=
lock
have been answered.  Granted, there is still the issue of how to handle
vmsplice and a bunch of other places to fix, not least skbuff handling.

I also have patches to fix cifs in a separate branch that I would also lik=
e to
push in this merge window - and that requires the first two patches from t=
his
series also, so would it be possible for you to merge at least those two
rather than manually applying them?

Thanks,
David
-~-
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

     BIO_PAGE_REFFED will go away, but at the moment fs/direct-io.c sets i=
t
     and this series does not fully address that file.

 (4) Add a function, bio_release_page(), to release a page appropriately t=
o
     the cleanup mode indicated by the BIO_PAGE_* flags.

 (5) Make the iter-to-bio code use iov_iter_extract_pages() to retain the
     pages appropriately and clean them up later.

 (6) Fix bio_flagged() so that it doesn't prevent a gcc optimisation.

Changes:
=3D=3D=3D=3D=3D=3D=3D=3D
ver #12) (unposted)
 - Added the missing __bitwise on the iov_iter_extraction_t typedef.

ver #11)
 - Fix iov_iter_extract_kvec_pages() to include the offset into the page i=
n
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
 - We should always be using FOLL_PIN (not FOLL_GET) for DIO, so adjust th=
e
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
Link: https://lore.kernel.org/r/166697254399.61150.1256557652599252121.stg=
it@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166722777223.2555743.162508599131141451.st=
git@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166732024173.3186319.18204305072070871546.=
stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166869687556.3723671.10061142538708346995.=
stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/166920902005.1461876.2786264600108839814.s=
tgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/166997419665.9475.15014699817597102032.stg=
it@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/167305160937.1521586.133299343565358971.st=
git@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/167344725490.2425628.13771289553670112965.=
stgit@warthog.procyon.org.uk/ # v5
Link: https://lore.kernel.org/r/167391047703.2311931.8115712773222260073.s=
tgit@warthog.procyon.org.uk/ # v6
Link: https://lore.kernel.org/r/20230120175556.3556978-1-dhowells@redhat.c=
om/ # v7
Link: https://lore.kernel.org/r/20230123173007.325544-1-dhowells@redhat.co=
m/ # v8
Link: https://lore.kernel.org/r/20230124170108.1070389-1-dhowells@redhat.c=
om/ # v9
Link: https://lore.kernel.org/r/20230125210657.2335748-1-dhowells@redhat.c=
om/ # v10
Link: https://lore.kernel.org/r/20230126141626.2809643-1-dhowells@redhat.c=
om/ # v11

---
The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f6=
5:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags=
/iov-extract-20230130

for you to fetch changes up to fd20d0c1852ebb3f37ec7101feb0cdd8695f32a5:

  block: convert bio_map_user_iov to use iov_iter_extract_pages (2023-01-2=
7 22:13:21 +0000)

----------------------------------------------------------------
Make block-bio use pinning

----------------------------------------------------------------
Christoph Hellwig (1):
      block: Replace BIO_NO_PAGE_REF with BIO_PAGE_REFFED with inverted lo=
gic

David Howells (7):
      iov_iter: Define flags to qualify page extraction.
      iov_iter: Add a function to extract a page list from an iterator
      iomap: Don't get an reference on ZERO_PAGE for direct I/O block zero=
ing
      block: Fix bio_flagged() so that gcc can better optimise it
      block: Add BIO_PAGE_PINNED and associated infrastructure
      block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages
      block: convert bio_map_user_iov to use iov_iter_extract_pages

 block/bio.c               |  33 ++---
 block/blk-map.c           |  26 ++--
 block/blk.h               |  12 ++
 fs/direct-io.c            |   2 +
 fs/iomap/direct-io.c      |   1 -
 include/linux/bio.h       |   5 +-
 include/linux/blk_types.h |   3 +-
 include/linux/uio.h       |  35 ++++-
 lib/iov_iter.c            | 335 +++++++++++++++++++++++++++++++++++++++++=
++++-
 9 files changed, 411 insertions(+), 41 deletions(-)

