Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F61132AF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 17:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgAGQS5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 11:18:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728335AbgAGQS4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 11:18:56 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93DF02146E;
        Tue,  7 Jan 2020 16:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578413934;
        bh=VHaQ61kdMj1zQ28aJj/C17UOc1bhJar0a2DB7650RJo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rZi0gUw5vTAwlfrpb2ixg2DIo+LTfSYmSN1bqVUfHuKHB340JxlkfmiV5SS3c/o85
         2lnjYqtZplqfqgtDo91GCqRhhx9wRWUlrUZHqsAOacB/sDyYbvThQWHBGV0BrCKB8V
         /YzpTv14l8x+EcEW72dmW8s2Rf+5iosvk4++KGEI=
Received: by mail-vs1-f47.google.com with SMTP id g23so34246851vsr.7;
        Tue, 07 Jan 2020 08:18:54 -0800 (PST)
X-Gm-Message-State: APjAAAWIqQzRwCjfc+3YEDAD8THYPNlvDR7nJo+fiuALjXmf2saKbbXO
        LPsGR2B+sE2+8xCYmOxWnM5F44YRryCi5zwAX5A=
X-Google-Smtp-Source: APXvYqzvpalX9mYxg6Cv3airS1ivUXrhzCkCxHPr449SlfZoXw65XfEJe/ap5H8kaopm7p5nfYOfCqLcTkym5I6xFfA=
X-Received: by 2002:a67:af11:: with SMTP id v17mr34139741vsl.99.1578413933613;
 Tue, 07 Jan 2020 08:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20191216182656.15624-1-fdmanana@kernel.org> <20191216182656.15624-3-fdmanana@kernel.org>
 <20191229052240.GG13306@hungrycats.org>
In-Reply-To: <20191229052240.GG13306@hungrycats.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 7 Jan 2020 16:18:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5FcdsA3NEcRae4iE5k8j8tHe-3KjKo_tTg6=fu0c_0gw@mail.gmail.com>
Message-ID: <CAL3q7H5FcdsA3NEcRae4iE5k8j8tHe-3KjKo_tTg6=fu0c_0gw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Btrfs: make deduplication with range including the
 last block work
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 29, 2019 at 5:22 AM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Mon, Dec 16, 2019 at 06:26:56PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Since btrfs was migrated to use the generic VFS helpers for clone and
> > deduplication, it stopped allowing for the last block of a file to be
> > deduplicated when the source file size is not sector size aligned (when
> > eof is somewhere in the middle of the last block). There are two reasons
> > for that:
> >
> > 1) The generic code always rounds down, to a multiple of the block size,
> >    the range's length for deduplications. This means we end up never
> >    deduplicating the last block when the eof is not block size aligned,
> >    even for the safe case where the destination range's end offset matches
> >    the destination file's size. That rounding down operation is done at
> >    generic_remap_check_len();
> >
> > 2) Because of that, the btrfs specific code does not expect anymore any
> >    non-aligned range length's for deduplication and therefore does not
> >    work if such nona-aligned length is given.
> >
> > This patch addresses that second part, and it depends on a patch that
> > fixes generic_remap_check_len(), in the VFS, which was submitted ealier
> > and has the following subject:
> >
> >   "fs: allow deduplication of eof block into the end of the destination file"
> >
> > These two patches address reports from users that started seeing lower
> > deduplication rates due to the last block never being deduplicated when
> > the file size is not aligned to the filesystem's block size.
> >
> > Link: https://lore.kernel.org/linux-btrfs/2019-1576167349.500456@svIo.N5dq.dFFD/
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Should these patches be marked for stable (5.0+, but see below for
> caveats about 5.0)?  The bug affects 5.3 and 5.4 which are still active,
> and dedupe is an important feature for some users.

Usually I only mark things for stable that are critical: corruptions,
crashes and memory leaks for example.
I don't think this is a critical issue, since none of those things
happen. It's certainly inconvenient to not have
an extent fully deduplicated, but it's just that.

If a maintainer wants to add it for stable, I'm fine with it.

>
> > ---
> >  fs/btrfs/ioctl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 3418decb9e61..c41c276ff272 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -3237,6 +3237,7 @@ static void btrfs_double_extent_lock(struct inode *inode1, u64 loff1,
> >  static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
> >                                  struct inode *dst, u64 dst_loff)
> >  {
> > +     const u64 bs = BTRFS_I(src)->root->fs_info->sb->s_blocksize;
> >       int ret;
> >
> >       /*
> > @@ -3244,7 +3245,7 @@ static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
> >        * source range to serialize with relocation.
> >        */
> >       btrfs_double_extent_lock(src, loff, dst, dst_loff, len);
> > -     ret = btrfs_clone(src, dst, loff, len, len, dst_loff, 1);
> > +     ret = btrfs_clone(src, dst, loff, len, ALIGN(len, bs), dst_loff, 1);
>
> A heads-up for anyone backporting this to 5.0:  this patch depends on
>
>         57a50e2506df Btrfs: remove no longer needed range length checks for deduplication

For any kernel without that cleanup patch, backporting the first patch
in the series (the one touching only fs/read_write.c) is enough.
For any kernel with that cleanup patch, then both patches in the
series are needed.

Thanks.

>
> Simply resolving the git conflict without including 57a50e2506df produces
> a kernel where dedupe rounds the size of the dst file up to the next
> block boundary.  This is because 57a50e2506df changes the value of
> "len".  Before 57a50e2506df, "len" is equivalent to "ALIGN(len, bs)"
> at the btrfs_clone line; after 57a50e2506df, "len" is the unaligned
> dedupe request length passed to the btrfs_extent_same_range function.
> This changes the semantics of the btrfs_clone line significantly.
>
> 57a50e2506df is in 5.1, so 5.1+ kernels do not require any additional
> patches.
>
> 4.20 and earlier don't have the bug, so don't need a fix.
>
> >       btrfs_double_extent_unlock(src, loff, dst, dst_loff, len);
> >
> >       return ret;
> > --
> > 2.11.0
> >
