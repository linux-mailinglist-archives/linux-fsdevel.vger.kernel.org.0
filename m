Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B1245E313
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 23:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbhKYWrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 17:47:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240668AbhKYWpS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 17:45:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 796B761131;
        Thu, 25 Nov 2021 22:42:04 +0000 (UTC)
Date:   Thu, 25 Nov 2021 22:42:01 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware
 with sub-page faults
Message-ID: <YaAROdPCqNzSKCjh@arm.com>
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com>
 <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <YZ6idVy3zqQC4atv@arm.com>
 <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 11:25:54PM +0100, Andreas Gruenbacher wrote:
> On Wed, Nov 24, 2021 at 9:37 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Wed, Nov 24, 2021 at 08:03:58PM +0000, Matthew Wilcox wrote:
> > > On Wed, Nov 24, 2021 at 07:20:24PM +0000, Catalin Marinas wrote:
> > > > +++ b/fs/btrfs/ioctl.c
> > > > @@ -2223,7 +2223,8 @@ static noinline int search_ioctl(struct inode *inode,
> > > >
> > > >     while (1) {
> > > >             ret = -EFAULT;
> > > > -           if (fault_in_writeable(ubuf + sk_offset, *buf_size - sk_offset))
> > > > +           if (fault_in_exact_writeable(ubuf + sk_offset,
> > > > +                                        *buf_size - sk_offset))
> > > >                     break;
> > > >
> > > >             ret = btrfs_search_forward(root, &key, path, sk->min_transid);
> > >
> > > Couldn't we avoid all of this nastiness by doing ...
> >
> > I had a similar attempt initially but I concluded that it doesn't work:
> >
> > https://lore.kernel.org/r/YS40qqmXL7CMFLGq@arm.com
> >
> > > @@ -2121,10 +2121,9 @@ static noinline int copy_to_sk(struct btrfs_path *path,
> > >                  * problem. Otherwise we'll fault and then copy the buffer in
> > >                  * properly this next time through
> > >                  */
> > > -               if (copy_to_user_nofault(ubuf + *sk_offset, &sh, sizeof(sh))) {
> > > -                       ret = 0;
> > > +               ret = __copy_to_user_nofault(ubuf + *sk_offset, &sh, sizeof(sh));
> > > +               if (ret)
> >
> > There is no requirement for the arch implementation to be exact and copy
> > the maximum number of bytes possible. It can fail early while there are
> > still some bytes left that would not fault. The only requirement is that
> > if it is restarted from where it faulted, it makes some progress (on
> > arm64 there is one extra byte).
> >
> > >                         goto out;
> > > -               }
> > >
> > >                 *sk_offset += sizeof(sh);
> > > @@ -2196,6 +2195,7 @@ static noinline int search_ioctl(struct inode *inode,
> > >         int ret;
> > >         int num_found = 0;
> > >         unsigned long sk_offset = 0;
> > > +       unsigned long next_offset = 0;
> > >
> > >         if (*buf_size < sizeof(struct btrfs_ioctl_search_header)) {
> > >                 *buf_size = sizeof(struct btrfs_ioctl_search_header);
> > > @@ -2223,7 +2223,8 @@ static noinline int search_ioctl(struct inode *inode,
> > >
> > >         while (1) {
> > >                 ret = -EFAULT;
> > > -               if (fault_in_writeable(ubuf + sk_offset, *buf_size - sk_offset))
> > > +               if (fault_in_writeable(ubuf + sk_offset + next_offset,
> > > +                                       *buf_size - sk_offset - next_offset))
> > >                         break;
> > >
> > >                 ret = btrfs_search_forward(root, &key, path, sk->min_transid);
> > > @@ -2235,11 +2236,12 @@ static noinline int search_ioctl(struct inode *inode,
> > >                 ret = copy_to_sk(path, &key, sk, buf_size, ubuf,
> > >                                  &sk_offset, &num_found);
> > >                 btrfs_release_path(path);
> > > -               if (ret)
> > > +               if (ret > 0)
> > > +                       next_offset = ret;
> >
> > So after this point, ubuf+sk_offset+next_offset is writeable by
> > fault_in_writable(). If copy_to_user() was attempted on
> > ubuf+sk_offset+next_offset, all would be fine, but copy_to_sk() restarts
> > the copy from ubuf+sk_offset, so it returns exacting the same ret as in
> > the previous iteration.
> 
> So this means that after a short copy_to_user_nofault(), copy_to_sk()
> needs to figure out the actual point of failure. We'll have the same
> problem elsewhere, so this should probably be a generic helper. The
> alignment hacks are arch specific, so maybe we can have a generic
> version that assumes no alignment restrictions, with arch-specific
> overrides.
> 
> Once we know the exact point of failure, a
> fault_in_writeable(point_of_failure, 1) in search_ioctl() will tell if
> the failure is pertinent. Once we know that the failure isn't
> pertinent, we're safe to retry the original fault_in_writeable().

The "exact point of failure" is problematic since copy_to_user() may
fail a few bytes before the actual fault point (e.g. by doing an
unaligned store). As per Linus' reply, we can work around this by doing
a sub-page fault_in_writable(point_of_failure, align) where 'align'
should cover the copy_to_user() impreciseness.

(of course, fault_in_writable() takes the full size argument but behind
the scene it probes the 'align' prefix at sub-page fault granularity)

-- 
Catalin
