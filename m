Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5BF13AC60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 15:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgANOgX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 09:36:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgANOgX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:36:23 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D121F2467D;
        Tue, 14 Jan 2020 14:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579012582;
        bh=6cgZGxZ4TavF4DzZ2Kn7H5hN65Uua64pqMp/PYHU7qQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VNqABQjX0XGSMHpI5bSQIxKEmIpWrFy6DwKiPJzi4Zgfz4Shp+Cxj3rKhg6n8rkBd
         pZDcusaSChnZTu/qF88fWlzZzOtNq63rcU/BmcONtDBPYZmj0DU34baonUDyFRuZPK
         pRuz+WiixACDehrSmQ4O4GbZmW7uTWXdsxR8ILhA=
Received: by mail-vs1-f47.google.com with SMTP id s16so8324696vsc.10;
        Tue, 14 Jan 2020 06:36:21 -0800 (PST)
X-Gm-Message-State: APjAAAXve5RsNXbASpfYFc3N11A/Rm0Q5iRRMX77MCV9dnhBTG8SOYMh
        YkSD3a+czIpuMfoF144hlzFPdCSjoEiEK8dS1Ds=
X-Google-Smtp-Source: APXvYqw3E77CcPD7PJWzNpgOU4PGzwiob4S3qlUZlRL7Ci+FJrSm/SBt/exsYZpF9EOTbroq1yuxIWfKwV7VO1Z9OF4=
X-Received: by 2002:a67:8010:: with SMTP id b16mr1549481vsd.90.1579012580656;
 Tue, 14 Jan 2020 06:36:20 -0800 (PST)
MIME-Version: 1.0
References: <20191216182656.15624-1-fdmanana@kernel.org> <20191216182656.15624-2-fdmanana@kernel.org>
 <CAL3q7H5+CMRkJ9yAa2AeB0aKtA=b_yW2g9JSQwCOhOtLNrH1iQ@mail.gmail.com>
 <20200107175739.GC472651@magnolia> <CAL3q7H5TuaLDW3aXSa68pxvLu4s1Gg38RRSRyA430LxK302k3A@mail.gmail.com>
 <20200108161536.GC5552@magnolia> <CAL3q7H7jOD6eEurdEb-VHn3_xcZVnYEJxnaomgUHtFcH5XowHw@mail.gmail.com>
 <20200109191201.GC8247@magnolia>
In-Reply-To: <20200109191201.GC8247@magnolia>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 14 Jan 2020 14:36:09 +0000
X-Gmail-Original-Message-ID: <CAL3q7H79W2b2P5snLxsoAy=iAPByiKu1dDEt0=Np2RHUXhfafQ@mail.gmail.com>
Message-ID: <CAL3q7H79W2b2P5snLxsoAy=iAPByiKu1dDEt0=Np2RHUXhfafQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: allow deduplication of eof block into the end of
 the destination file
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 9, 2020 at 7:12 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Thu, Jan 09, 2020 at 07:00:09PM +0000, Filipe Manana wrote:
> > On Wed, Jan 8, 2020 at 4:15 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > >
> > > On Wed, Jan 08, 2020 at 11:36:04AM +0000, Filipe Manana wrote:
> > > > On Tue, Jan 7, 2020 at 5:57 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > > >
> > > > > On Tue, Jan 07, 2020 at 04:23:15PM +0000, Filipe Manana wrote:
> > > > > > On Mon, Dec 16, 2019 at 6:28 PM <fdmanana@kernel.org> wrote:
> > > > > > >
> > > > > > > From: Filipe Manana <fdmanana@suse.com>
> > > > > > >
> > > > > > > We always round down, to a multiple of the filesystem's block size, the
> > > > > > > length to deduplicate at generic_remap_check_len().  However this is only
> > > > > > > needed if an attempt to deduplicate the last block into the middle of the
> > > > > > > destination file is requested, since that leads into a corruption if the
> > > > > > > length of the source file is not block size aligned.  When an attempt to
> > > > > > > deduplicate the last block into the end of the destination file is
> > > > > > > requested, we should allow it because it is safe to do it - there's no
> > > > > > > stale data exposure and we are prepared to compare the data ranges for
> > > > > > > a length not aligned to the block (or page) size - in fact we even do
> > > > > > > the data compare before adjusting the deduplication length.
> > > > > > >
> > > > > > > After btrfs was updated to use the generic helpers from VFS (by commit
> > > > > > > 34a28e3d77535e ("Btrfs: use generic_remap_file_range_prep() for cloning
> > > > > > > and deduplication")) we started to have user reports of deduplication
> > > > > > > not reflinking the last block anymore, and whence users getting lower
> > > > > > > deduplication scores.  The main use case is deduplication of entire
> > > > > > > files that have a size not aligned to the block size of the filesystem.
> > > > > > >
> > > > > > > We already allow cloning the last block to the end (and beyond) of the
> > > > > > > destination file, so allow for deduplication as well.
> > > > > > >
> > > > > > > Link: https://lore.kernel.org/linux-btrfs/2019-1576167349.500456@svIo.N5dq.dFFD/
> > > > > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > > >
> > > > > > Darrick, Al, any feedback?
> > > > >
> > > > > Is there a fstest to check for correct operation of dedupe at or beyond
> > > > > source and destfile EOF?  Particularly if one range is /not/ at EOF?
> > > >
> > > > Such as what generic/158 does already?
> > >
> > > Urk, heh. :)
> > >
> > > > > And that an mmap read of the EOF block will see zeroes past EOF before
> > > > > and after the dedupe operation?
> > > >
> > > > Can you elaborate a bit more? Why an mmap read and not a buffered or a
> > > > direct IO read before and after deduplication?
> > > > Is there anything special for the mmap reads on xfs, is that your
> > > > concern? Or is the idea to deduplicate while the file is mmap'ed?
> > >
> > > I cite mmap reads past EOF specifically because unlike buffered/direct
> > > reads where the VFS will stop reading exactly at EOF, a memory mapping
> > > maps in an entire memory page, and the fs is supposed to ensure that the
> > > bytes past EOF are zeroed.
> >
> > Ok, on btrfs we zero out the rest of the page both in for all reads.
> >
> > So, it's not problem:
> >
> > $ file_size=$((64 * 1024 + 500))
> > $ xfs_io -f -c "pwrite -S 0xba 0 $file_size" foo
> > $ xfs_io -f -c "pwrite -S 0xba 0 $file_size" bar
> > $ sync
> >
> > $ xfs_io -c "mmap 0 68K" -c "mread -v 0 68K" -c "dedupe bar 0 0
> > $file_size" -c "mread -v 0 68K" foo
> >
> > Both mreads returns exactly the same, eof is still the same and all
> > bytes after it have a value of 0.
> >
> > This is the same as it is for cloning.
>
> Oh good. :)
>
> > >
> > > Hm now that I look at g/158 it doesn't actually verify mmap reads.  I
> > > looked around and can't really see anything that checks mmap reads
> > > before and after a dedupe operation at EOF.
> > >
> > > > > If I fallocate a 16k file, write 'X' into the first 5000 bytes,
> > > > > write 'X' into the first 66,440 bytes (60k + 5000) of a second file, and
> > > > > then try to dedupe (first file, 0-8k) with (second file, 60k-68k),
> > > > > should that work?
> > > >
> > > > You haven't mentioned the size of the second file, nor if the first
> > > > file has a size of 16K which I assume (instead of fallocate with the
> > > > keep size flag).
> > >
> > > Er, sorry, yes.  The first file is 16,384 bytes long; the second file is
> > > 66,440 bytes.
> > >
> > > > Anyway, I assume you actually meant to dedupe the range 0 - 5000 from
> > > > the first file into the range 60k - 60k + 5000 of the second file, and
> > > > that the second file has a size of 60k + 5000.
> > >
> > > Nope, I meant to say to dedupe the range (offset: 0, length: 8192) from
> > > the first file into the second file (offset: 61440, length: 8192).  The
> > > source range is entirely below EOF, and the dest range ends right at
> > > EOF in the second file.
> >
> > The dedupe operations fails with -EINVAL, both before and after this patch,
> > since the whenever one of ranges crosses eof, we must fail dedupe with -EINVAL.
> > This happens at generic_remap_checks(), which called before
> > generic_remap_check_len().
> >
> > This is no different from the other existing tests in fstests, which
> > cover this case already.
>
> Ah, ok.
>
> > > > If so, that fails with -EINVAL because the source range is not block
> > > > size aligned, and we already have generic fstests that test attempt to
> > > > duplication and clone non-aligned ranges that don't end at eof.
> > > > This patch doesn't change that behaviour, it only aims to allow
> > > > deduplication of the eof block of the source file into the eof of the
> > > > destination file.
> > > >
> > > >
> > > > >
> > > > > I'm convinced that we could support dedupe to EOF when the ranges of the
> > > > > two files both end at the respective file's EOF, but it's the weirder
> > > > > corner cases that I worry about...
> > > >
> > > > Well, we used to do that in btrfs before migrating to the generic code.
> > > > Since I discovered the corruption due to deduplication of the eof
> > > > block into the middle of a file in 2018's summer, the btrfs fix
> > > > allowed deduplication of the eof block only if the destination end
> > > > offset matched the eof of the destination file:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=de02b9f6bb65a6a1848f346f7a3617b7a9b930c0
> > > >
> > > > Since then no issues were found nor users reported any problems so far.
> > >
> > > <nod> I'm ok with that one scenario, it's the "one range ends at eof,
> > > the other doesn't" case that I'm picking on. :)
> > >
> > > (Another way to shut me up would be to run generic/52[12] with
> > > TIME_FACTOR=1000 (i.e. 1 billion fsx ops) and see what comes exploding
> > > out. :))
> >
> > Well, it will take nearly 2 weeks to get those tests to complete with
> > 1 billion ops, taking into
> > account each takes around 500 seconds to run here (on xfs) with 1
> > million operations...
>
> I know.  I probably should have clarified: every month or two I build a
> kernel from tip, throw it in a VM, and let it run for however long it
> goes until it dies, fixing whatever problems as I find them.
>
> *So far* no billionaire plutocrats have complained about the huge
> compute bills that are probably racking up. ;)
>
> (FWIW I also tossed your patch onto another one of these VMs and it
> hasn't died yet, so that's probably an ok sign)

For 100 million ops, on 5.5-rc5 kernel with this patchset and on xfs:

$ TIME_FACTOR=100 MKFS_OPTIONS="-m reflink=1,rmapbt=1" ./check
generic/521 generic/522
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 debian5 5.5.0-rc5-btrfs-next-67 #1 SMP
PREEMPT Thu Jan 9 13:48:07 WET 2020
MKFS_OPTIONS  -- -f -m reflink=1,rmapbt=1 /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

generic/521 482s ...  48961s
generic/522 536s ...  54432s
Ran: generic/521 generic/522
Passed all 2 tests

Similar for btrfs, no problems found (yet at least).

Thanks.

>
> > >
> > > > Any other specific test you would like to see?
> > >
> > > No, just that.  And mmap reads. :)
> >
> > Given that we allow cloning of eof into eof already (and that doesn't
> > cause any known problems),
> > I don't see why you are so concerned with allowing dedupe to behave the same.
> >
> > The only thing I can see it could be a problem would be comparing the
> > contents of the last page beyond the eof position,
> > but as stated on the changelog, it's not a problem since we call
> > vfs_dedupe_file_range_compare() before we
> > round down the length at generic_remap_check_len() - the data compare
> > function already has the correct behaviour.
>
> <nod>
>
> --D
>
> > Thanks.
> >
> > >
> > > --D
> > >
> > > > Thanks.
> > > >
> > > > >
> > > > > --D
> > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > > ---
> > > > > > >  fs/read_write.c | 10 ++++------
> > > > > > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/read_write.c b/fs/read_write.c
> > > > > > > index 5bbf587f5bc1..7458fccc59e1 100644
> > > > > > > --- a/fs/read_write.c
> > > > > > > +++ b/fs/read_write.c
> > > > > > > @@ -1777,10 +1777,9 @@ static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
> > > > > > >   * else.  Assume that the offsets have already been checked for block
> > > > > > >   * alignment.
> > > > > > >   *
> > > > > > > - * For deduplication we always scale down to the previous block because we
> > > > > > > - * can't meaningfully compare post-EOF contents.
> > > > > > > - *
> > > > > > > - * For clone we only link a partial EOF block above the destination file's EOF.
> > > > > > > + * For clone we only link a partial EOF block above or at the destination file's
> > > > > > > + * EOF.  For deduplication we accept a partial EOF block only if it ends at the
> > > > > > > + * destination file's EOF (can not link it into the middle of a file).
> > > > > > >   *
> > > > > > >   * Shorten the request if possible.
> > > > > > >   */
> > > > > > > @@ -1796,8 +1795,7 @@ static int generic_remap_check_len(struct inode *inode_in,
> > > > > > >         if ((*len & blkmask) == 0)
> > > > > > >                 return 0;
> > > > > > >
> > > > > > > -       if ((remap_flags & REMAP_FILE_DEDUP) ||
> > > > > > > -           pos_out + *len < i_size_read(inode_out))
> > > > > > > +       if (pos_out + *len < i_size_read(inode_out))
> > > > > > >                 new_len &= ~blkmask;
> > > > > > >
> > > > > > >         if (new_len == *len)
> > > > > > > --
> > > > > > > 2.11.0
> > > > > > >
