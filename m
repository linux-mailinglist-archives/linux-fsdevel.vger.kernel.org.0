Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C333D68C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 23:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhGZU4C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 16:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231207AbhGZU4C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 16:56:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3055D601FD;
        Mon, 26 Jul 2021 21:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627335390;
        bh=eLPynMHmHQRZC/8yd3FOQ9sa5kDDVw+mscIe5Y/qQXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0Dqa33+z6IcueJoSCg2PJ9GTNnucTgFhD5cpspGOwaluxZ+1Hk2xHcQBiGWxjxpw
         bdMC8lqpsIkjqWPwYhPlVhHiNX7kPUPjWUqmGj3Av6q0pWE7EgDWBKE930H0VzgT66
         YrBSVCMQVjZy5H40gnv934Ql8g5atXgirVn8btVlZWJ32YuUZLsWEhzARxHywZcs9L
         q+T1z1+uwth8DgAgqJhb0cwghK+1kM2GXJVw+v5BieCFPrVK9MKvrQNjBnrkY7Hzqg
         ov5Ij5birIDa+TBBNggNmO+EBn5mCcUPdurjqaMV2P6XnUQlkOkBTi5hfEDK+RbJFg
         PEG1R9q0nlCfA==
Date:   Mon, 26 Jul 2021 14:36:29 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Jianan <huangjianan@oppo.com>,
        linux-erofs@lists.ozlabs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
Subject: Re: [PATCH v7] iomap: make inline data support more flexible
Message-ID: <20210726213629.GF8572@magnolia>
References: <CAHpGcMJBhWcwteLDSBU3hgwq1tk_+LqogM1ZM=Fv8U0VtY5hMg@mail.gmail.com>
 <20210723174131.180813-1-hsiangkao@linux.alibaba.com>
 <20210725221639.426565-1-agruenba@redhat.com>
 <YP4fk75mr/mIotDy@B-P7TQMD6M-0146.local>
 <CAHc6FU7904K4XrUhOoHp8uoBrDN0kyZ+q54anMXrJUBVCNA29A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU7904K4XrUhOoHp8uoBrDN0kyZ+q54anMXrJUBVCNA29A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 26, 2021 at 09:22:41AM +0200, Andreas Gruenbacher wrote:
> On Mon, Jul 26, 2021 at 4:36 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > On Mon, Jul 26, 2021 at 12:16:39AM +0200, Andreas Gruenbacher wrote:
> > > Here's a fixed and cleaned up version that passes fstests on gfs2.
> > >
> > > I see no reason why the combination of tail packing + writing should
> > > cause any issues, so in my opinion, the check that disables that
> > > combination in iomap_write_begin_inline should still be removed.
> >
> > Since there is no such fs for tail-packing write, I just do a wild
> > guess, for example,
> >  1) the tail-end block was not inlined, so iomap_write_end() dirtied
> >     the whole page (or buffer) for the page writeback;
> >  2) then it was truncated into a tail-packing inline block so the last
> >     extent(page) became INLINE but dirty instead;
> >  3) during the late page writeback for dirty pages,
> >     if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
> >     would be triggered in iomap_writepage_map() for such dirty page.
> >
> > As Matthew pointed out before,
> > https://lore.kernel.org/r/YPrms0fWPwEZGNAL@casper.infradead.org/
> > currently tail-packing inline won't interact with page writeback, but
> > I'm afraid a supported tail-packing write fs needs to reconsider the
> > whole stuff how page, inode writeback works and what the pattern is
> > with the tail-packing.
> >
> > >
> > > It turns out that returning the number of bytes copied from
> > > iomap_read_inline_data is a bit irritating: the function is really used
> > > for filling the page, but that's not always the "progress" we're looking
> > > for.  In the iomap_readpage case, we actually need to advance by an
> > > antire page, but in the iomap_file_buffered_write case, we need to
> > > advance by the length parameter of iomap_write_actor or less.  So I've
> > > changed that back.
> > >
> > > I've also renamed iomap_inline_buf to iomap_inline_data and I've turned
> > > iomap_inline_data_size_valid into iomap_within_inline_data, which seems
> > > more useful to me.
> > >
> > > Thanks,
> > > Andreas
> > >
> > > --
> > >
> > > Subject: [PATCH] iomap: Support tail packing
> > >
> > > The existing inline data support only works for cases where the entire
> > > file is stored as inline data.  For larger files, EROFS stores the
> > > initial blocks separately and then can pack a small tail adjacent to the
> > > inode.  Generalise inline data to allow for tail packing.  Tails may not
> > > cross a page boundary in memory.
> > >
> > > We currently have no filesystems that support tail packing and writing,
> > > so that case is currently disabled (see iomap_write_begin_inline).  I'm
> > > not aware of any reason why this code path shouldn't work, however.
> > >
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Darrick J. Wong <djwong@kernel.org>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Andreas Gruenbacher <andreas.gruenbacher@gmail.com>
> > > Tested-by: Huang Jianan <huangjianan@oppo.com> # erofs
> > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > ---
> > >  fs/iomap/buffered-io.c | 34 +++++++++++++++++++++++-----------
> > >  fs/iomap/direct-io.c   | 11 ++++++-----
> > >  include/linux/iomap.h  | 22 +++++++++++++++++++++-
> > >  3 files changed, 50 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 87ccb3438bec..334bf98fdd4a 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -205,25 +205,29 @@ struct iomap_readpage_ctx {
> > >       struct readahead_control *rac;
> > >  };
> > >
> > > -static void
> > > -iomap_read_inline_data(struct inode *inode, struct page *page,
> > > +static int iomap_read_inline_data(struct inode *inode, struct page *page,
> > >               struct iomap *iomap)
> > >  {
> > > -     size_t size = i_size_read(inode);
> > > +     size_t size = i_size_read(inode) - iomap->offset;
> >
> > I wonder why you use i_size / iomap->offset here,
> 
> This function is supposed to copy the inline or tail data at
> iomap->inline_data into the page passed to it. Logically, the inline
> data starts at iomap->offset and extends until i_size_read(inode).
> Relative to the page, the inline data starts at offset 0 and extends
> until i_size_read(inode) - iomap->offset. It's as simple as that.

It's only as simple as that because the inline data read code is overfit
to the single use case (gfs2) that it supports.  So far in its history,
iomap has never had to support inline data regions that do not coincide
or overlap with EOF, nor has it had to support regions that do not start
at pos==0.  That is why it is appropriate to use the memcpy -> memset ->
return PAGE_SIZE pattern and short-circuit what we do everywhere else in
iomap.

For a non-inline readpage call, filesystems are allowed to return
mappings for blocks beyond EOF.  The call to iomap_adjust_read_range
sets us up to read data from disk through the EOF block, and for the
remainder of the page we zero the post-eof blocks within that page.

IOWs, for reads, __gfs2_iomap_get probably ought to set iomap->length to
gfs2_max_stuffed_size() like it does for writes, and we ought to
generalize iomap_read_inline_data to stop copying after
min(iomap->length, i_size_read() - iomap->offset) bytes.  If it then
discovers that it has indeed reached EOF, then we can zero the rest of
the page and add that quantity to the number of bytes read.

Right now for gfs2 the two arguments to min are always the same so the
function omits all the bits that would make the zeroing actually
conditional on whether we really hit EOF, and pass any copied size other
than PAGE_SIZE back to iomap_readpage_actor.  Given that we still don't
have any filesystems that require us to support inline regions entirely
below EOF I'm fine with omitting the general (and hence untestable)
solution... for now.

(I now think I understand why someone brought up inline data regions in
the middle of files last week.)

--D

> > and why you completely ignoring iomap->length field returning by fs.
> 
> In the iomap_readpage case (iomap_begin with flags == 0),
> iomap->length will be the amount of data up to the end of the inode.
> In the iomap_file_buffered_write case (iomap_begin with flags ==
> IOMAP_WRITE), iomap->length will be the size of iomap->inline_data.
> (For extending writes, we need to write beyond the current end of
> inode.) So iomap->length isn't all that useful for
> iomap_read_inline_data.
> 
> > Using i_size here instead of iomap->length seems coupling to me in the
> > beginning (even currently in practice there is some limitation.)
> 
> And what is that?
> 
> Thanks,
> Andreas
> 
