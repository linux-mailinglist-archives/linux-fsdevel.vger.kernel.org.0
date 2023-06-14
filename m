Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89F872F130
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 02:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241685AbjFNA4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 20:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241616AbjFNAz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 20:55:57 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785BB19A7
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 17:55:55 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f9b8f1c2fdso12760201cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 17:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20221208.gappssmtp.com; s=20221208; t=1686704154; x=1689296154;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaaZfP5b0MBIX/0QtjC91Ch/wkFs4stZm9HNYoUJRdU=;
        b=1DipXB4Zvdo83WYdDuQWdq0GhsqbYSCMx22dBHUtPr3PqRgR/0fbK/Xix/JIGrpWeE
         oeevYr+m3/gNJgfdUHCaYw0/h/sRACff7Ay5qe7Cr2Z3nl7q3Jl538VtoXelJcWLynHy
         hllZCyobMM2WcetlbxPBmUcjb8gTWp7+Wm+HpXZExlbxBJOJ7QsuCwlGEYzu9lsEwgXb
         BKkiS+j/OPQ0twS23SAjeSPkR+CK5mRahtnmYo5f/sS6eqS8iaP+F4P9BK69lLpybWbZ
         GDSjWo02alZOL54pmot/WCbzRoZA/HyIm3VfO6cu8zL/okllNBS+uS4SSSXTOXl+qbq0
         /qMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686704154; x=1689296154;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaaZfP5b0MBIX/0QtjC91Ch/wkFs4stZm9HNYoUJRdU=;
        b=S4nUuN/kcItfhhjbK/25b5gpHKcjAq1aGCfbI6C5V0xo8Ml+PZ4/5pxOK43hmbF96K
         8GGj9SP2bM0lOaxrzkKUGm0+39BcefLCVsEcmlLJIqSnGIij1tcnfoK3YzAmFcEiAAWY
         ir6mQ340UiL9Bz3eT3L6kEZF5dXwDBF+dkIi+8ltrBauvABbL5Zfa3Kv5v88yPCjYu2x
         j7w9NjoGBb96kdxY7HytPGq0QiFZJsx9CP7CjfKsNmKooXq/EAhr/bLE5Q4FsNWFOIca
         qEnOWVWGNgb1CSvL+tHEf7udJmgTjppzSg6YL5Eslnb69ry0uNNdLmxHa5eVcEbR6X8L
         HPNw==
X-Gm-Message-State: AC+VfDy1mqj/wFLnIMaO5inbbJXlEDorrUO1j1LjAodHrD9iz6rBx9/R
        nRwdhg6mxeXG6edv3UjSu4ESQC5IWfmGprWbt40nCmb/WvQMiSMVJHs=
X-Google-Smtp-Source: ACHHUZ6XhOwvnNQTHXluLZ+guCFf5AsxHtHb0kUENYgQECeQHCrzrPPeowtBAC6JoBVjFPJCRjA5RALcpXIooH35HAs=
X-Received: by 2002:ac8:57ce:0:b0:3f5:1f9c:5b28 with SMTP id
 w14-20020ac857ce000000b003f51f9c5b28mr508745qta.42.1686704153760; Tue, 13 Jun
 2023 17:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230519074047.1739879-1-dhowells@redhat.com>
In-Reply-To: <20230519074047.1739879-1-dhowells@redhat.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Tue, 13 Jun 2023 20:55:43 -0400
Message-ID: <CAOg9mSR6Yh=p0QLvYFH168W1_fyNo-wd3WhXdSSuHoYOFmf9mw@mail.gmail.com>
Subject: Re: [PATCH v20 00/32] splice, block: Use page pinning and kill ITER_PIPE
To:     David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello... I used
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?=
h=3Diov-extract
to build 6.4.0-rc2-00037-g0c3c931ab6d1 and ran xfstests
through with no regressions on orangefs. You can add a
tested by me if you'd like...

-Mike

On Fri, May 19, 2023 at 3:42=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Hi Jens, Al, Christoph,
>
> The first half of this patchset kills off ITER_PIPE to avoid a race betwe=
en
> truncate, iov_iter_revert() on the pipe and an as-yet incomplete DMA to a
> bio with unpinned/unref'ed pages from an O_DIRECT splice read.  This caus=
es
> memory corruption[2].  Instead, we use filemap_splice_read(), which invok=
es
> the buffered file reading code and splices from the pagecache into the
> pipe; direct_splice_read(), which bulk-allocates a buffer, reads into it
> and then pushes the filled pages into the pipe; or handle it in
> filesystem-specific code.
>
>  (1) Simplify the calculations for the number of pages to be reclaimed in
>      direct_splice_read().
>
>  (2) Turn do_splice_to() into a helper so that it can be used by overlayf=
s
>      and coda to perform the checks on the lower fs.
>
>  (3) Provide shmem with its own splice_read to handle non-existent pages
>      in the pagecache.  We don't want a ->read_folio() as we don't want t=
o
>      populate holes, but filemap_get_pages() requires it.
>
>  (4) Provide overlayfs with its own splice_read to call down to a lower
>      layer as overlayfs doesn't provide ->read_folio().
>
>  (5) Provide coda with its own splice_read to call down to a lower layer =
as
>      coda doesn't provide ->read_folio().
>
>  (6) Direct ->splice_read to direct_splice_read() in tty, procfs, kernfs
>      and random files as they just copy to the output buffer and don't
>      splice pages.
>
>  (7) Provide stubs for afs, ceph, ecryptfs, ext4, f2fs, nfs, ntfs3, ocfs2=
,
>      orangefs, xfs and zonefs to do locking and/or revalidation.
>
>  (8) Change generic_file_splice_read() to just switch between
>      filemap_splice_read() and direct_splice_read() rather than using
>      ITER_PIPE.
>
>  (9) Make cifs use generic_file_splice_read().
>
> (10) Remove ITER_PIPE and its paraphernalia as generic_file_splice_read()
>      was the only user.
>
> The second half of the patchset rolls page-pinning out to the bio struct
> and the block layer, using iov_iter_extract_pages() to get pages and noti=
ng
> with BIO_PAGE_PINNED if the data pages attached to a bio are pinned.  If
> the data pages come from a non-user-backed iterator, then the pages are
> left unpinned and unref'd, relying on whoever set up the I/O to do the
> retaining
>
> (10) Don't hold a ref on ZERO_PAGE in iomap_dio_zero().
>
> (11) Fix bio_flagged() so that it doesn't prevent a gcc optimisation.
>
> (12) Make the bio struct carry a pair of flags to indicate the cleanup
>      mode.  BIO_NO_PAGE_REF is replaced with BIO_PAGE_REFFED (indicating
>      FOLL_GET was used) and BIO_PAGE_PINNED (indicating FOLL_PIN was used=
)
>      is added.
>
>      BIO_PAGE_REFFED will go away, but at the moment fs/direct-io.c sets =
it
>      and this series does not fully address that file.
>
> (13) Add a function, bio_release_page(), to release a page appropriately =
to
>      the cleanup mode indicated by the BIO_PAGE_* flags.
>
> (14) Make bio_iov_iter_get_pages() use iov_iter_extract_pages() to retain
>      the pages appropriately and clean them up later.
>
> (15) Make bio_map_user_iov() also use iov_iter_extract_pages().
>
> I've pushed the patches here also:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs=
.git/log/?h=3Diov-extract
>
> David
>
> Changes:
> =3D=3D=3D=3D=3D=3D=3D=3D
> ver #20)
>  - Make direct_splice_read() limit the read to eof for regular files and
>    blockdevs.
>  - Check against s_maxbytes on the backing store, not a devnode inode.
>  - Provide stubs for afs, ceph, ecryptfs, ext4, f2fs, nfs, ntfs3, ocfs2,
>    orangefs, xfs and zonefs.
>  - Always use direct_splice_read() for 9p, trace and sockets.
>
> ver #19)
>  - Remove a missed get_page() on the zeropage in shmem_splice_read().
>
> ver #18)
>  - Split out the cifs bits from the patch the switches
>    generic_file_splice_read() over to using the non-ITER_PIPE splicing.
>  - Don't get/put refs on the zeropage in shmem_splice_read().
>
> ver #17)
>  - Rename do_splice_to() to vfs_splice_read() and export it so that it ca=
n
>    be a helper and make overlayfs and coda use it, allowing duplicate
>    checks to be removed.
>
> ver #16)
>  - The filemap_get_pages() changes are now upstream.
>  - filemap_splice_read() and direct_splice_read() are now upstream.
>  - iov_iter_extract_pages() is now upstream.
>
> ver #15)
>  - Fixed up some errors in overlayfs_splice_read().
>
> ver #14)
>  - Some changes to generic_file_buffered_splice_read():
>    - Rename to filemap_splice_read() and move to mm/filemap.c.
>    - Create a helper, pipe_head_buf().
>    - Use init_sync_kiocb().
>  - Some changes to generic_file_direct_splice_read():
>    - Use alloc_pages_bulk_array() rather than alloc_pages_bulk_list().
>    - Use release_pages() instead of __free_page() in a loop.
>    - Rename to direct_splice_read().
>  - Rearrange the patches to implement filemap_splice_read() and
>    direct_splice_read() separately to changing generic_file_splice_read()=
.
>  - Don't call generic_file_splice_read() when there isn't a ->read_folio(=
).
>  - Insert patches to fix read_folio-less cases:
>    - Make tty, procfs, kernfs and (u)random use direct_splice_read().
>    - Make overlayfs and coda call down to a lower layer.
>    - Give shmem its own splice-read that doesn't insert missing pages.
>  - Fixed a min() with mixed type args on some arches.
>
> ver #13)
>  - Only use allocation in advance and ITER_BVEC for DIO read-splice.
>  - Make buffered read-splice get pages directly from the pagecache.
>  - Alter filemap_get_pages() & co. so that it doesn't need an iterator.
>
> ver #12)
>  - Added the missing __bitwise on the iov_iter_extraction_t typedef.
>  - Rebased on -rc7.
>  - Don't specify FOLL_PIN to pin_user_pages_fast().
>  - Inserted patch at front to fix race between DIO read and truncation th=
at
>    caused memory corruption when iov_iter_revert() got called on an
>    ITER_PIPE iterator[2].
>  - Inserted a patch after that to remove the now-unused ITER_PIPE and its
>    helper functions.
>  - Removed the ITER_PIPE bits from iov_iter_extract_pages().
>
> ver #11)
>  - Fix iov_iter_extract_kvec_pages() to include the offset into the page =
in
>    the returned starting offset.
>  - Use __bitwise for the extraction flags
>
> ver #10)
>  - Fix use of i->kvec in iov_iter_extract_bvec_pages() to be i->bvec.
>  - Drop bio_set_cleanup_mode(), open coding it instead.
>
> ver #9)
>  - It's now not permitted to use FOLL_PIN outside of mm/, so:
>  - Change iov_iter_extract_mode() into iov_iter_extract_will_pin() and
>    return true/false instead of FOLL_PIN/0.
>  - Drop of folio_put_unpin() and page_put_unpin() and instead call
>    unpin_user_page() (and put_page()) directly as necessary.
>  - Make __bio_release_pages() call bio_release_page() instead of
>    unpin_user_page() as there's no BIO_* -> FOLL_* translation to do.
>  - Drop the FOLL_* renumbering patch.
>  - Change extract_flags to extraction_flags.
>
> ver #8)
>  - Import Christoph Hellwig's changes.
>    - Split the conversion-to-extraction patch.
>    - Drop the extract_flags arg from iov_iter_extract_mode().
>    - Don't default bios to BIO_PAGE_REFFED, but set explicitly.
>  - Switch FOLL_PIN and FOLL_GET when renumbering so PIN is at bit 0.
>  - Switch BIO_PAGE_PINNED and BIO_PAGE_REFFED so PINNED is at bit 0.
>  - We should always be using FOLL_PIN (not FOLL_GET) for DIO, so adjust t=
he
>    patches for that.
>
> ver #7)
>  - For now, drop the parts to pass the I/O direction to iov_iter_*pages*(=
)
>    as it turned out to be a lot more complicated, with places not setting
>    IOCB_WRITE when they should, for example.
>  - Drop all the patches that changed things other then the block layer's
>    bio handling.  The netfslib and cifs changes can go into a separate
>    patchset.
>  - Add support for extracting pages from KVEC-type iterators.
>  - When extracting from BVEC/KVEC, skip over empty vecs at the front.
>
> ver #6)
>  - Fix write() syscall and co. not setting IOCB_WRITE.
>  - Added iocb_is_read() and iocb_is_write() to check IOCB_WRITE.
>  - Use op_is_write() in bio_copy_user_iov().
>  - Drop the iterator direction checks from smbd_recv().
>  - Define FOLL_SOURCE_BUF and FOLL_DEST_BUF and pass them in as part of
>    gup_flags to iov_iter_get/extract_pages*().
>  - Replace iov_iter_get_pages*2() with iov_iter_get_pages*() and remove.
>  - Add back the function to indicate the cleanup mode.
>  - Drop the cleanup_mode return arg to iov_iter_extract_pages().
>  - Provide a helper to clean up a page.
>  - Renumbered FOLL_GET and FOLL_PIN and made BIO_PAGE_REFFED/PINNED have
>    the same numerical values, enforced with an assertion.
>  - Converted AF_ALG, SCSI vhost, generic DIO, FUSE, splice to pipe, 9P an=
d
>    NFS.
>  - Added in the patches to make CIFS do top-to-bottom iterators and use
>    various of the added extraction functions.
>  - Added a pair of work-in-progess patches to make sk_buff fragments stor=
e
>    FOLL_GET and FOLL_PIN.
>
> ver #5)
>  - Replace BIO_NO_PAGE_REF with BIO_PAGE_REFFED and split into own patch.
>  - Transcribe FOLL_GET/PIN into BIO_PAGE_REFFED/PINNED flags.
>  - Add patch to allow bio_flagged() to be combined by gcc.
>
> ver #4)
>  - Drop the patch to move the FOLL_* flags to linux/mm_types.h as they're
>    no longer referenced by linux/uio.h.
>  - Add ITER_SOURCE/DEST cleanup patches.
>  - Make iov_iter/netfslib iter extraction patches use ITER_SOURCE/DEST.
>  - Allow additional gup_flags to be passed into iov_iter_extract_pages().
>  - Add struct bio patch.
>
> ver #3)
>  - Switch to using EXPORT_SYMBOL_GPL to prevent indirect 3rd-party access
>    to get/pin_user_pages_fast()[1].
>
> ver #2)
>  - Rolled the extraction cleanup mode query function into the extraction
>    function, returning the indication through the argument list.
>  - Fixed patch 4 (extract to scatterlist) to actually use the new
>    extraction API.
>
> Link: https://lore.kernel.org/r/Y3zFzdWnWlEJ8X8/@infradead.org/ [1]
> Link: https://lore.kernel.org/r/000000000000b0b3c005f3a09383@google.com/ =
[2]
> Link: https://lore.kernel.org/r/166697254399.61150.1256557652599252121.st=
git@warthog.procyon.org.uk/ # rfc
> Link: https://lore.kernel.org/r/166722777223.2555743.162508599131141451.s=
tgit@warthog.procyon.org.uk/ # rfc
> Link: https://lore.kernel.org/r/166732024173.3186319.18204305072070871546=
.stgit@warthog.procyon.org.uk/ # rfc
> Link: https://lore.kernel.org/r/166869687556.3723671.10061142538708346995=
.stgit@warthog.procyon.org.uk/ # rfc
> Link: https://lore.kernel.org/r/166920902005.1461876.2786264600108839814.=
stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/166997419665.9475.15014699817597102032.st=
git@warthog.procyon.org.uk/ # v3
> Link: https://lore.kernel.org/r/167305160937.1521586.133299343565358971.s=
tgit@warthog.procyon.org.uk/ # v4
> Link: https://lore.kernel.org/r/167344725490.2425628.13771289553670112965=
.stgit@warthog.procyon.org.uk/ # v5
> Link: https://lore.kernel.org/r/167391047703.2311931.8115712773222260073.=
stgit@warthog.procyon.org.uk/ # v6
> Link: https://lore.kernel.org/r/20230120175556.3556978-1-dhowells@redhat.=
com/ # v7
> Link: https://lore.kernel.org/r/20230123173007.325544-1-dhowells@redhat.c=
om/ # v8
> Link: https://lore.kernel.org/r/20230124170108.1070389-1-dhowells@redhat.=
com/ # v9
> Link: https://lore.kernel.org/r/20230125210657.2335748-1-dhowells@redhat.=
com/ # v10
> Link: https://lore.kernel.org/r/20230126141626.2809643-1-dhowells@redhat.=
com/ # v11
> Link: https://lore.kernel.org/r/20230207171305.3716974-1-dhowells@redhat.=
com/ # v12
> Link: https://lore.kernel.org/r/20230209102954.528942-1-dhowells@redhat.c=
om/ # v13
> Link: https://lore.kernel.org/r/20230214171330.2722188-1-dhowells@redhat.=
com/ # v14
> Link: https://lore.kernel.org/r/20230308143754.1976726-1-dhowells@redhat.=
com/ # v16
> Link: https://lore.kernel.org/r/20230308165251.2078898-1-dhowells@redhat.=
com/ # v17
> Link: https://lore.kernel.org/r/20230314220757.3827941-1-dhowells@redhat.=
com/ # v18
> Link: https://lore.kernel.org/r/20230315163549.295454-1-dhowells@redhat.c=
om/ # v19
>
> Additional patches that got folded in:
>
> Link: https://lore.kernel.org/r/20230213134619.2198965-1-dhowells@redhat.=
com/ # v1
> Link: https://lore.kernel.org/r/20230213153301.2338806-1-dhowells@redhat.=
com/ # v2
> Link: https://lore.kernel.org/r/20230214083710.2547248-1-dhowells@redhat.=
com/ # v3
>
> Christoph Hellwig (1):
>   block: Replace BIO_NO_PAGE_REF with BIO_PAGE_REFFED with inverted
>     logic
>
> David Howells (31):
>   splice: Fix filemap of a blockdev
>   splice: Clean up direct_splice_read() a bit
>   splice: Make direct_read_splice() limit to eof where appropriate
>   splice: Make do_splice_to() generic and export it
>   splice: Make splice from a DAX file use direct_splice_read()
>   shmem: Implement splice-read
>   overlayfs: Implement splice-read
>   coda: Implement splice-read
>   tty, proc, kernfs, random: Use direct_splice_read()
>   net: Make sock_splice_read() use direct_splice_read() by default
>   9p:  Add splice_read stub
>   afs: Provide a splice-read stub
>   ceph: Provide a splice-read stub
>   ecryptfs: Provide a splice-read stub
>   ext4: Provide a splice-read stub
>   f2fs: Provide a splice-read stub
>   nfs: Provide a splice-read stub
>   ntfs3: Provide a splice-read stub
>   ocfs2: Provide a splice-read stub
>   orangefs: Provide a splice-read stub
>   xfs: Provide a splice-read stub
>   zonefs: Provide a splice-read stub
>   splice: Convert trace/seq to use direct_splice_read()
>   splice: Do splice read from a file without using ITER_PIPE
>   cifs: Use generic_file_splice_read()
>   iov_iter: Kill ITER_PIPE
>   iomap: Don't get an reference on ZERO_PAGE for direct I/O block
>     zeroing
>   block: Fix bio_flagged() so that gcc can better optimise it
>   block: Add BIO_PAGE_PINNED and associated infrastructure
>   block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages
>   block: convert bio_map_user_iov to use iov_iter_extract_pages
>
>  block/bio.c               |  29 +--
>  block/blk-map.c           |  22 +-
>  block/blk.h               |  12 ++
>  drivers/char/random.c     |   4 +-
>  drivers/tty/tty_io.c      |   4 +-
>  fs/9p/vfs_file.c          |  26 ++-
>  fs/afs/file.c             |  20 +-
>  fs/ceph/file.c            |  66 +++++-
>  fs/cifs/cifsfs.c          |   8 +-
>  fs/cifs/cifsfs.h          |   3 -
>  fs/cifs/file.c            |  16 --
>  fs/coda/file.c            |  29 ++-
>  fs/direct-io.c            |   2 +
>  fs/ecryptfs/file.c        |  27 ++-
>  fs/ext4/file.c            |  13 +-
>  fs/f2fs/file.c            |  68 +++++-
>  fs/iomap/direct-io.c      |   1 -
>  fs/kernfs/file.c          |   2 +-
>  fs/nfs/file.c             |  26 ++-
>  fs/nfs/internal.h         |   2 +
>  fs/nfs/nfs4file.c         |   2 +-
>  fs/ntfs3/file.c           |  36 +++-
>  fs/ocfs2/file.c           |  42 +++-
>  fs/ocfs2/ocfs2_trace.h    |   3 +
>  fs/orangefs/file.c        |  25 ++-
>  fs/overlayfs/file.c       |  23 +-
>  fs/proc/inode.c           |   4 +-
>  fs/proc/proc_sysctl.c     |   2 +-
>  fs/proc_namespace.c       |   6 +-
>  fs/splice.c               |  93 ++++----
>  fs/xfs/xfs_file.c         |  33 ++-
>  fs/xfs/xfs_trace.h        |   2 +-
>  fs/zonefs/file.c          |  43 +++-
>  include/linux/bio.h       |   5 +-
>  include/linux/blk_types.h |   3 +-
>  include/linux/splice.h    |   3 +
>  include/linux/uio.h       |  14 --
>  kernel/trace/trace.c      |   2 +-
>  lib/iov_iter.c            | 431 +-------------------------------------
>  mm/filemap.c              |   7 +-
>  mm/shmem.c                | 134 +++++++++++-
>  net/socket.c              |   2 +-
>  42 files changed, 717 insertions(+), 578 deletions(-)
>
