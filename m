Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8974001C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 17:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbhICPJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 11:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239566AbhICPJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:09:28 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34734C061575;
        Fri,  3 Sep 2021 08:08:28 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id b64so6127130qkg.0;
        Fri, 03 Sep 2021 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=dfVAyRi3egcPmrpkkX6mL213sIGpEaRWvxdiTkq+xW8=;
        b=EWcq229FL/ntUEq82qpPUWBWKHdqlgiM75aaopWI0EXKXMdaGvWC9k5+Djmpf9cuh4
         b8Px+qCiOFbdSlTTv3bCUWjo/NV+fV2FfDhtVBTe+11Hyzzc0GtfIzt9fM6pWJdOsQTo
         Hw091772P+VcEN0wpXd2QJDN5P2CBMbRXMqIqUPHoTTS4oCbdr33nxJebB3k0cLE1JVx
         35kVoZO3fqZcIp7tDFWrd/ielCIlkFmjs/qNYQvB0vIZOGZG2GKfB2JH//Zfs1FulZVX
         gOTOWaFGN1mnjDgUBankLRTMLHBaoKykGiP6F5yFw7iKyEEFMRF86tzacUtCHWKO2oZM
         RWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=dfVAyRi3egcPmrpkkX6mL213sIGpEaRWvxdiTkq+xW8=;
        b=sn4I3exGBD8q3ec6r19GyxvO/DYghe4OBEERsdUgPGoZbcQjCSnZoPH0W8ElPrWPUN
         SwNZlBRv22SrdqangNRNmk7vvOa0LCVWYThNyStC0wCFR+DxO7UgW7iahvnuyX6s1iTw
         2ciMdRDN59Ux7sT2RYYJXDEDY7mmUfNosKrLUczPQZTG9iz/6GdFadhZWA6ONa7SJdoY
         jkKoG3z90NvIFV+vWkKTMBf7njkLli+9Rv5Gucy2iQx7xdCqPPLSLQcsWlZIdk0gD6SB
         O1Vq+L4if7upBjk7PAm4P87M5r8pDovMCpy/ZEPR7NUGsqNsKVd3JjpjZigMwfTlJ/Ov
         898A==
X-Gm-Message-State: AOAM532cDxzb+6noWwUqtI1AwOMnLgJhio91jNhBcxSFEDqpWDJhdrAp
        dai/eoe+hnfRZfnYqxj814bKbbpC0+eFN4dm1gM=
X-Google-Smtp-Source: ABdhPJxOxNoEKZDrnzr5I27hdDLrYAI3fzlDltFTJm77mMKSv9gWkp9I05ZDbo+9/cQzt6JSbVvTx3kldRbLUD+SG7w=
X-Received: by 2002:a05:620a:2844:: with SMTP id h4mr3924402qkp.388.1630681707290;
 Fri, 03 Sep 2021 08:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com>
In-Reply-To: <20210827164926.1726765-1-agruenba@redhat.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 3 Sep 2021 16:07:51 +0100
Message-ID: <CAL3q7H709FSbHtinPRqe6XtZEvhmkSVBhFHUGMiVDW7Ngb3wrQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/19] gfs2: Fix mmap + page fault deadlocks
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 5:51 PM Andreas Gruenbacher <agruenba@redhat.com> w=
rote:
>
> Hi all,
>
> here's another update on top of v5.14-rc7.  Changes:
>
>  * Some of the patch descriptions have been improved.
>
>  * Patch "gfs2: Eliminate ip->i_gh" has been moved further to the front.
>
> At this point, I'm not aware of anything that still needs fixing,

Hi, thanks for doing this.

In btrfs we also have a deadlock (after the conversion to use iomap
for direct IO) triggered by your recent test case for fstests,
generic/647 [1].
Even though we can fix it in btrfs without touching iomap, iov_iter,
etc, it would be too complex for such a rare and exotic case (a user
passing a buffer for a direct IO read/write that is memory mapped to
the same file range of the operation is very uncommon at least). But
this patchset would make the fix much simpler and cleaner.

One thing I noticed is that, for direct IO reads, despite setting the
->nofault attribute of the iov_iter to true, we can still get page
faults while in the iomap code.
This happens when reading from holes and unwritten/prealloc extents,
because iomap calls iov_iter_zero() and this seems to ignore the value
of ->nofault.
Is that intentional? I can get around it by surrounding the iomap call
with pagefault_disable() / pagefault_enable(), but it seems odd to do
so, given that iov_iter->nofault was set to true.

[1] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=3Dd3c=
bdabffc4cb28850e97bc7bd8a7a1460db94e5

Thanks.

>
>
> The first two patches are independent of the core of this patch queue
> and I've asked the respective maintainers to have a look, but I've not
> heard back from them.  The first patch should just go into Al's tree;
> it's a relatively straight-forward fix.  The second patch really needs
> to be looked at; it might break things:
>
>   iov_iter: Fix iov_iter_get_pages{,_alloc} page fault return value
>   powerpc/kvm: Fix kvm_use_magic_page
>
>
> Al and Linus seem to have a disagreement about the error reporting
> semantics that functions fault_in_{readable,writeable} and
> fault_in_iov_iter_{readable,writeable} should have.  I've implemented
> Linus's suggestion of returning the number of bytes not faulted in and I
> think that being able to tell if "nothing", "something" or "everything"
> could be faulted in does help, but I'll live with anything that allows
> us to make progress.
>
>
> The iomap changes should ideally be reviewed by Christoph; I've not
> heard from him about those.
>
>
> Thanks,
> Andreas
>
> Andreas Gruenbacher (16):
>   iov_iter: Fix iov_iter_get_pages{,_alloc} page fault return value
>   powerpc/kvm: Fix kvm_use_magic_page
>   gup: Turn fault_in_pages_{readable,writeable} into
>     fault_in_{readable,writeable}
>   iov_iter: Turn iov_iter_fault_in_readable into
>     fault_in_iov_iter_readable
>   iov_iter: Introduce fault_in_iov_iter_writeable
>   gfs2: Add wrapper for iomap_file_buffered_write
>   gfs2: Clean up function may_grant
>   gfs2: Move the inode glock locking to gfs2_file_buffered_write
>   gfs2: Eliminate ip->i_gh
>   gfs2: Fix mmap + page fault deadlocks for buffered I/O
>   iomap: Fix iomap_dio_rw return value for user copies
>   iomap: Support partial direct I/O on user copy failures
>   iomap: Add done_before argument to iomap_dio_rw
>   gup: Introduce FOLL_NOFAULT flag to disable page faults
>   iov_iter: Introduce nofault flag to disable page faults
>   gfs2: Fix mmap + page fault deadlocks for direct I/O
>
> Bob Peterson (3):
>   gfs2: Eliminate vestigial HIF_FIRST
>   gfs2: Remove redundant check from gfs2_glock_dq
>   gfs2: Introduce flag for glock holder auto-demotion
>
>  arch/powerpc/kernel/kvm.c           |   3 +-
>  arch/powerpc/kernel/signal_32.c     |   4 +-
>  arch/powerpc/kernel/signal_64.c     |   2 +-
>  arch/x86/kernel/fpu/signal.c        |   7 +-
>  drivers/gpu/drm/armada/armada_gem.c |   7 +-
>  fs/btrfs/file.c                     |   7 +-
>  fs/btrfs/ioctl.c                    |   5 +-
>  fs/ext4/file.c                      |   5 +-
>  fs/f2fs/file.c                      |   2 +-
>  fs/fuse/file.c                      |   2 +-
>  fs/gfs2/bmap.c                      |  60 +----
>  fs/gfs2/file.c                      | 245 ++++++++++++++++++--
>  fs/gfs2/glock.c                     | 340 +++++++++++++++++++++-------
>  fs/gfs2/glock.h                     |  20 ++
>  fs/gfs2/incore.h                    |   5 +-
>  fs/iomap/buffered-io.c              |   2 +-
>  fs/iomap/direct-io.c                |  21 +-
>  fs/ntfs/file.c                      |   2 +-
>  fs/xfs/xfs_file.c                   |   6 +-
>  fs/zonefs/super.c                   |   4 +-
>  include/linux/iomap.h               |  11 +-
>  include/linux/mm.h                  |   3 +-
>  include/linux/pagemap.h             |  58 +----
>  include/linux/uio.h                 |   4 +-
>  lib/iov_iter.c                      | 103 +++++++--
>  mm/filemap.c                        |   4 +-
>  mm/gup.c                            | 139 +++++++++++-
>  27 files changed, 785 insertions(+), 286 deletions(-)
>
> --
> 2.26.3
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
