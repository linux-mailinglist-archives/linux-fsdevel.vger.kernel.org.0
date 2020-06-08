Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD9C1F1891
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 14:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbgFHMNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 08:13:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:60686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbgFHMNO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:13:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E7970AC24;
        Mon,  8 Jun 2020 12:13:13 +0000 (UTC)
Date:   Mon, 8 Jun 2020 07:13:06 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 2/3] btrfs: Wait for extent bits to release page
Message-ID: <20200608121306.657yrfkyvj5vpkva@fiona>
References: <20200605204838.10765-1-rgoldwyn@suse.de>
 <20200605204838.10765-3-rgoldwyn@suse.de>
 <CAL3q7H6zFBCMf6YeB-adf08t0ov0WMzLKUOOQK-QqACnRnNULA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6zFBCMf6YeB-adf08t0ov0WMzLKUOOQK-QqACnRnNULA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11:20 08/06, Filipe Manana wrote:
> On Fri, Jun 5, 2020 at 9:48 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> >
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >
> > While trying to release a page, the extent containing the page may be locked
> > which would stop the page from being released. Wait for the
> > extent lock to be cleared, if blocking is allowed and then clear
> > the bits.
> >
> > While we are at it, clean the code of try_release_extent_state() to make
> > it simpler.
> >
> > Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> > Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> I'm confused Goldwyn.
> 
> Previously in another thread [1] you mentioned you dropped this patch
> from a previous patchset because
> it was causing locking issues (iirc you mentioned a deadlock in
> another different thread).
> 
> Now you send exactly the same patch (unless I missed some very subtle
> change, in which case keeping the reviewed-by tags is not correct).
> Are the locking issues gone? What fixed them?
> And how did you trigger those issues, some specific fstest (which?),
> some other test (which/how)?

I ran xfstests and did not find the lockups I was finding earlier.
Unfortunately, I don't have the lockups, but the process would wait for
the extent_bits to get unlocked.

> 
> And if this patch is now working for some reason, then why are patches
> 1/3 and 3/3 needed?
> Wasn't patch 1/3 motivated exactly because this patch (2/3) was
> causing the locking issues.

This patch reduces the amount of time btrfs has to fallback to the
buffered path. Probably I should point this out in the patch header.
The other two patches are required to make sure we don't err during
transient release page errors, while this one reduces the amount of
these transient errors in the first place.


> 
> Thanks.
> 
> [1] https://lore.kernel.org/linux-btrfs/20200526164428.sirhx6yjsghxpnqt@fiona/
> 
> > ---
> >  fs/btrfs/extent_io.c | 37 ++++++++++++++++---------------------
> >  fs/btrfs/extent_io.h |  2 +-
> >  fs/btrfs/inode.c     |  4 ++--
> >  3 files changed, 19 insertions(+), 24 deletions(-)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index c59e07360083..0ab444d2028d 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -4466,33 +4466,28 @@ int extent_invalidatepage(struct extent_io_tree *tree,
> >   * are locked or under IO and drops the related state bits if it is safe
> >   * to drop the page.
> >   */
> > -static int try_release_extent_state(struct extent_io_tree *tree,
> > +static bool try_release_extent_state(struct extent_io_tree *tree,
> >                                     struct page *page, gfp_t mask)
> >  {
> >         u64 start = page_offset(page);
> >         u64 end = start + PAGE_SIZE - 1;
> > -       int ret = 1;
> >
> >         if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
> > -               ret = 0;
> > -       } else {
> > -               /*
> > -                * at this point we can safely clear everything except the
> > -                * locked bit and the nodatasum bit
> > -                */
> > -               ret = __clear_extent_bit(tree, start, end,
> > -                                ~(EXTENT_LOCKED | EXTENT_NODATASUM),
> > -                                0, 0, NULL, mask, NULL);
> > -
> > -               /* if clear_extent_bit failed for enomem reasons,
> > -                * we can't allow the release to continue.
> > -                */
> > -               if (ret < 0)
> > -                       ret = 0;
> > -               else
> > -                       ret = 1;
> > +               if (!gfpflags_allow_blocking(mask))
> > +                       return false;
> > +               wait_extent_bit(tree, start, end, EXTENT_LOCKED);
> >         }
> > -       return ret;
> > +       /*
> > +        * At this point we can safely clear everything except the locked and
> > +        * nodatasum bits. If clear_extent_bit failed due to -ENOMEM,
> > +        * don't allow release.
> > +        */
> > +       if (__clear_extent_bit(tree, start, end,
> > +                               ~(EXTENT_LOCKED | EXTENT_NODATASUM), 0, 0,
> > +                               NULL, mask, NULL) < 0)
> > +               return false;
> > +
> > +       return true;
> >  }
> >
> >  /*
> > @@ -4500,7 +4495,7 @@ static int try_release_extent_state(struct extent_io_tree *tree,
> >   * in the range corresponding to the page, both state records and extent
> >   * map records are removed
> >   */
> > -int try_release_extent_mapping(struct page *page, gfp_t mask)
> > +bool try_release_extent_mapping(struct page *page, gfp_t mask)
> >  {
> >         struct extent_map *em;
> >         u64 start = page_offset(page);
> > diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> > index 9a10681b12bf..6cba4ad6ebc1 100644
> > --- a/fs/btrfs/extent_io.h
> > +++ b/fs/btrfs/extent_io.h
> > @@ -189,7 +189,7 @@ typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
> >                                           struct page *page, size_t pg_offset,
> >                                           u64 start, u64 len);
> >
> > -int try_release_extent_mapping(struct page *page, gfp_t mask);
> > +bool try_release_extent_mapping(struct page *page, gfp_t mask);
> >  int try_release_extent_buffer(struct page *page);
> >
> >  int extent_read_full_page(struct page *page, get_extent_t *get_extent,
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 1242d0aa108d..8cb44c49c1d2 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -7887,8 +7887,8 @@ btrfs_readpages(struct file *file, struct address_space *mapping,
> >
> >  static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
> >  {
> > -       int ret = try_release_extent_mapping(page, gfp_flags);
> > -       if (ret == 1) {
> > +       bool ret = try_release_extent_mapping(page, gfp_flags);
> > +       if (ret) {
> >                 ClearPagePrivate(page);
> >                 set_page_private(page, 0);
> >                 put_page(page);
> > --
> > 2.25.0
> >
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”

-- 
Goldwyn
