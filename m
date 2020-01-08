Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3EAB13409C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 12:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgAHLgR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 06:36:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgAHLgR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:36:17 -0500
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07D2B20656;
        Wed,  8 Jan 2020 11:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578483376;
        bh=6l5MrTMa36YQHowQlrBJo4LPKmB21icAwjOtvtoNU7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GK8Ncn/C5GO4nYCOUjSepzM9ghLttFM3Ui24XFm6Ca5/t2HcuGXOM349u2zy7G6h7
         qXMkhbiAS1E0bIhCp0wXKgQyP7TIcLVcE6pr2HEVWrHdN/MFKD+1QdmvewSPILpnMP
         vJ2PG1d5aedv5Llsy67T52cyGK651AR0rKwFDbwA=
Received: by mail-ua1-f48.google.com with SMTP id c14so960832uaq.11;
        Wed, 08 Jan 2020 03:36:15 -0800 (PST)
X-Gm-Message-State: APjAAAWCwtbAAYnUG8FbsSEpcTAZdceLqakMYZcbvq9qkJDOBMkCQQFV
        x8lNYoOL7WtraFoTK+d3dd8xWY8ffF+KpLilybs=
X-Google-Smtp-Source: APXvYqxBYjnwEvjxQOq9WcUn/wTWUag1L2k2a/9dif0jVh9/EZ1sln6m0OjzOjjXtG45Zb5xZ8wQi8owxM8/s5KEM+s=
X-Received: by 2002:ab0:738c:: with SMTP id l12mr2749363uap.135.1578483375023;
 Wed, 08 Jan 2020 03:36:15 -0800 (PST)
MIME-Version: 1.0
References: <20191216182656.15624-1-fdmanana@kernel.org> <20191216182656.15624-2-fdmanana@kernel.org>
 <CAL3q7H5+CMRkJ9yAa2AeB0aKtA=b_yW2g9JSQwCOhOtLNrH1iQ@mail.gmail.com> <20200107175739.GC472651@magnolia>
In-Reply-To: <20200107175739.GC472651@magnolia>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 8 Jan 2020 11:36:04 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5TuaLDW3aXSa68pxvLu4s1Gg38RRSRyA430LxK302k3A@mail.gmail.com>
Message-ID: <CAL3q7H5TuaLDW3aXSa68pxvLu4s1Gg38RRSRyA430LxK302k3A@mail.gmail.com>
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

On Tue, Jan 7, 2020 at 5:57 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Tue, Jan 07, 2020 at 04:23:15PM +0000, Filipe Manana wrote:
> > On Mon, Dec 16, 2019 at 6:28 PM <fdmanana@kernel.org> wrote:
> > >
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > We always round down, to a multiple of the filesystem's block size, the
> > > length to deduplicate at generic_remap_check_len().  However this is only
> > > needed if an attempt to deduplicate the last block into the middle of the
> > > destination file is requested, since that leads into a corruption if the
> > > length of the source file is not block size aligned.  When an attempt to
> > > deduplicate the last block into the end of the destination file is
> > > requested, we should allow it because it is safe to do it - there's no
> > > stale data exposure and we are prepared to compare the data ranges for
> > > a length not aligned to the block (or page) size - in fact we even do
> > > the data compare before adjusting the deduplication length.
> > >
> > > After btrfs was updated to use the generic helpers from VFS (by commit
> > > 34a28e3d77535e ("Btrfs: use generic_remap_file_range_prep() for cloning
> > > and deduplication")) we started to have user reports of deduplication
> > > not reflinking the last block anymore, and whence users getting lower
> > > deduplication scores.  The main use case is deduplication of entire
> > > files that have a size not aligned to the block size of the filesystem.
> > >
> > > We already allow cloning the last block to the end (and beyond) of the
> > > destination file, so allow for deduplication as well.
> > >
> > > Link: https://lore.kernel.org/linux-btrfs/2019-1576167349.500456@svIo.N5dq.dFFD/
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >
> > Darrick, Al, any feedback?
>
> Is there a fstest to check for correct operation of dedupe at or beyond
> source and destfile EOF?  Particularly if one range is /not/ at EOF?

Such as what generic/158 does already?


> And that an mmap read of the EOF block will see zeroes past EOF before
> and after the dedupe operation?

Can you elaborate a bit more? Why an mmap read and not a buffered or a
direct IO read before and after deduplication?
Is there anything special for the mmap reads on xfs, is that your
concern? Or is the idea to deduplicate while the file is mmap'ed?

>
> If I fallocate a 16k file, write 'X' into the first 5000 bytes,
> write 'X' into the first 66,440 bytes (60k + 5000) of a second file, and
> then try to dedupe (first file, 0-8k) with (second file, 60k-68k),
> should that work?

You haven't mentioned the size of the second file, nor if the first
file has a size of 16K which I assume (instead of fallocate with the
keep size flag).

Anyway, I assume you actually meant to dedupe the range 0 - 5000 from
the first file into the range 60k - 60k + 5000 of the second file, and
that the second file has a size of 60k + 5000.
If so, that fails with -EINVAL because the source range is not block
size aligned, and we already have generic fstests that test attempt to
duplication and clone non-aligned ranges that don't end at eof.
This patch doesn't change that behaviour, it only aims to allow
deduplication of the eof block of the source file into the eof of the
destination file.


>
> I'm convinced that we could support dedupe to EOF when the ranges of the
> two files both end at the respective file's EOF, but it's the weirder
> corner cases that I worry about...

Well, we used to do that in btrfs before migrating to the generic code.
Since I discovered the corruption due to deduplication of the eof
block into the middle of a file in 2018's summer, the btrfs fix
allowed deduplication of the eof block only if the destination end
offset matched the eof of the destination file:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=de02b9f6bb65a6a1848f346f7a3617b7a9b930c0

Since then no issues were found nor users reported any problems so far.

Any other specific test you would like to see?

Thanks.

>
> --D
>
> > Thanks.
> >
> > > ---
> > >  fs/read_write.c | 10 ++++------
> > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/read_write.c b/fs/read_write.c
> > > index 5bbf587f5bc1..7458fccc59e1 100644
> > > --- a/fs/read_write.c
> > > +++ b/fs/read_write.c
> > > @@ -1777,10 +1777,9 @@ static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
> > >   * else.  Assume that the offsets have already been checked for block
> > >   * alignment.
> > >   *
> > > - * For deduplication we always scale down to the previous block because we
> > > - * can't meaningfully compare post-EOF contents.
> > > - *
> > > - * For clone we only link a partial EOF block above the destination file's EOF.
> > > + * For clone we only link a partial EOF block above or at the destination file's
> > > + * EOF.  For deduplication we accept a partial EOF block only if it ends at the
> > > + * destination file's EOF (can not link it into the middle of a file).
> > >   *
> > >   * Shorten the request if possible.
> > >   */
> > > @@ -1796,8 +1795,7 @@ static int generic_remap_check_len(struct inode *inode_in,
> > >         if ((*len & blkmask) == 0)
> > >                 return 0;
> > >
> > > -       if ((remap_flags & REMAP_FILE_DEDUP) ||
> > > -           pos_out + *len < i_size_read(inode_out))
> > > +       if (pos_out + *len < i_size_read(inode_out))
> > >                 new_len &= ~blkmask;
> > >
> > >         if (new_len == *len)
> > > --
> > > 2.11.0
> > >
