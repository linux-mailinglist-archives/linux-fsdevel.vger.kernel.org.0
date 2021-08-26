Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C7A3F8AC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 17:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242882AbhHZPME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 11:12:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237317AbhHZPMD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 11:12:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E333B60F21;
        Thu, 26 Aug 2021 15:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629990676;
        bh=YIVjWXw8f+ZBPD7zdaxiLaLkxWEJo/Ev3bHAZJpMGGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwIQ3u4HypRcZ0l2pi/CUVTLmWvNM+eWTq/XyYEfj4FurR5GlzGNOubvbYnDD3yRL
         N3mmB0NhI3n1SwAEl54C7mR6cEgPDf3MgDNv6tK09pzOgviTRnL8yQ0XvlNPDAi7Jt
         7A8/HL3tD0tZ3QXVcgdleoHaGCXYVEjvTmaP4OhnSI98AiXaPbwHzmAo9WzADNmKY2
         At+wezzks80f03wkv4tH6F+Z9IZGP3GAW5zlNZ/8QDJiMj7DPKQCAISt+mx1DBjTps
         v8Wn5aTnm2Fg7ipKZlcBBTlwKrSYYXJ9vWeervl40kMwdHW8uEZzqaaRBGDGhqVu8E
         jWIgH5T22HYaA==
Date:   Thu, 26 Aug 2021 08:11:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 8/9] xfs: factor out a xfs_buftarg_is_dax helper
Message-ID: <20210826151115.GK12640@magnolia>
References: <20210826135510.6293-1-hch@lst.de>
 <20210826135510.6293-9-hch@lst.de>
 <CAPcyv4jXAxSABiZ543xDWOnx0xGAq+LqjbQdqjs+6wbFgsqYyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jXAxSABiZ543xDWOnx0xGAq+LqjbQdqjs+6wbFgsqYyg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 26, 2021 at 07:37:29AM -0700, Dan Williams wrote:
> [ add Darrick ]
> 
> 
> On Thu, Aug 26, 2021 at 7:07 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Refactor the DAX setup code in preparation of removing
> > bdev_dax_supported.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  fs/xfs/xfs_super.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> Darrick, any concerns with me taking this through the dax tree?

Nope.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> >
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 2c9e26a44546..5a89bf601d97 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -314,6 +314,14 @@ xfs_set_inode_alloc(
> >         return (mp->m_flags & XFS_MOUNT_32BITINODES) ? maxagi : agcount;
> >  }
> >
> > +static bool
> > +xfs_buftarg_is_dax(
> > +       struct super_block      *sb,
> > +       struct xfs_buftarg      *bt)
> > +{
> > +       return bdev_dax_supported(bt->bt_bdev, sb->s_blocksize);
> > +}
> > +
> >  STATIC int
> >  xfs_blkdev_get(
> >         xfs_mount_t             *mp,
> > @@ -1549,11 +1557,10 @@ xfs_fs_fill_super(
> >                 xfs_warn(mp,
> >                 "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
> >
> > -               datadev_is_dax = bdev_dax_supported(mp->m_ddev_targp->bt_bdev,
> > -                       sb->s_blocksize);
> > +               datadev_is_dax = xfs_buftarg_is_dax(sb, mp->m_ddev_targp);
> >                 if (mp->m_rtdev_targp)
> > -                       rtdev_is_dax = bdev_dax_supported(
> > -                               mp->m_rtdev_targp->bt_bdev, sb->s_blocksize);
> > +                       rtdev_is_dax = xfs_buftarg_is_dax(sb,
> > +                                               mp->m_rtdev_targp);
> >                 if (!rtdev_is_dax && !datadev_is_dax) {
> >                         xfs_alert(mp,
> >                         "DAX unsupported by block device. Turning off DAX.");
> > --
> > 2.30.2
> >
> >
