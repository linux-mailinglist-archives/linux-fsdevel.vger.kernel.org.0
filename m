Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A811541CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgBFKXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:23:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:52730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728261AbgBFKW7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:22:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 28473B2E3;
        Thu,  6 Feb 2020 10:22:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1AA691E0E31; Thu,  6 Feb 2020 11:22:54 +0100 (CET)
Date:   Thu, 6 Feb 2020 11:22:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>, jack@suse.cz,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, cmaiolino@redhat.com
Subject: Re: [RFCv2 0/4] ext4: bmap & fiemap conversion to use iomap
Message-ID: <20200206102254.GK14001@quack2.suse.cz>
References: <cover.1580121790.git.riteshh@linux.ibm.com>
 <20200130160018.GC3445353@magnolia>
 <20200205124750.AE9DDA404D@d06av23.portsmouth.uk.ibm.com>
 <20200205155733.GH6874@magnolia>
 <20200206052619.D4BBCA405F@b06wcsmtp001.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200206052619.D4BBCA405F@b06wcsmtp001.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 06-02-20 10:56:18, Ritesh Harjani wrote:
> 
> 
> On 2/5/20 9:27 PM, Darrick J. Wong wrote:
> > On Wed, Feb 05, 2020 at 06:17:44PM +0530, Ritesh Harjani wrote:
> > > 
> > > 
> > > On 1/30/20 11:04 PM, Ritesh Harjani wrote:
> > > > 
> > > > 
> > > > On 1/30/20 9:30 PM, Darrick J. Wong wrote:
> > > > > On Tue, Jan 28, 2020 at 03:48:24PM +0530, Ritesh Harjani wrote:
> > > > > > Hello All,
> > > > > > 
> > > > > > Background
> > > > > > ==========
> > > > > > There are RFCv2 patches to move ext4 bmap & fiemap calls to use
> > > > > > iomap APIs.
> > > > > > This reduces the users of ext4_get_block API and thus a step
> > > > > > towards getting
> > > > > > rid of buffer_heads from ext4. Also reduces a lot of code by
> > > > > > making use of
> > > > > > existing iomap_ops (except for xattr implementation).
> > > > > > 
> > > > > > Testing (done on ext4 master branch)
> > > > > > ========
> > > > > > 'xfstests -g auto' passes with default mkfs/mount configuration
> > > > > > (v/s which also pass with vanilla kernel without this patch). Except
> > > > > > generic/473 which also failes on XFS. This seems to be the test
> > > > > > case issue
> > > > > > since it expects the data in slightly different way as compared
> > > > > > to what iomap
> > > > > > returns.
> > > > > > Point 2.a below describes more about this.
> > > > > > 
> > > > > > Observations/Review required
> > > > > > ============================
> > > > > > 1. bmap related old v/s new method differences:-
> > > > > >      a. In case if addr > INT_MAX, it issues a warning and
> > > > > >         returns 0 as the block no. While earlier it used to return the
> > > > > >         truncated value with no warning.
> > > > > 
> > > > > Good...
> > > > > 
> > > > > >      b. block no. is only returned in case of iomap->type is
> > > > > > IOMAP_MAPPED,
> > > > > >         but not when iomap->type is IOMAP_UNWRITTEN. While with
> > > > > > previously
> > > > > >         we used to get block no. for both of above cases.
> > > > > 
> > > > > Assuming the only remaining usecase of bmap is to tell old bootloaders
> > > > > where to find vmlinuz blocks on disk, I don't see much reason to map
> > > > > unwritten blocks -- there's no data there, and if your bootloader writes
> > > > > to the filesystem(!) then you can't read whatever was written there
> > > > > anyway.
> > > > 
> > > > Yes, no objection there. Just wanted to get it reviewed.
> > > > 
> > > > 
> > > > > 
> > > > > Uh, can we put this ioctl on the deprecation list, please? :)
> > > > > 
> > > > > > 2. Fiemap related old v/s new method differences:-
> > > > > >      a. iomap_fiemap returns the disk extent information in exact
> > > > > >         correspondence with start of user requested logical
> > > > > > offset till the
> > > > > >         length requested by user. While in previous implementation the
> > > > > >         returned information used to give the complete extent
> > > > > > information if
> > > > > >         the range requested by user lies in between the extent mapping.
> > > > > 
> > > > > This is a topic of much disagreement.  The FIEMAP documentation says
> > > > > that the call must return data for the requested range, but *may* return
> > > > > a mapping that extends beyond the requested range.
> > > > > 
> > > > > XFS (and now iomap) only return data for the requested range, whereas
> > > > > ext4 has (had?) the behavior you describe.  generic/473 was an attempt
> > > > > to enforce the ext4 behavior across all filesystems, but I put it in my
> > > > > dead list and never run it.
> > > > > 
> > > > > So it's a behavioral change, but the new behavior isn't forbidden.
> > > > 
> > > > Sure, thanks.
> > > > 
> > > > > 
> > > > > >      b. iomap_fiemap adds the FIEMAP_EXTENT_LAST flag also at the last
> > > > > >         fiemap_extent mapping range requested by the user via fm_length (
> > > > > >         if that has a valid mapped extent on the disk).
> > > > > 
> > > > > That sounds like a bug.  _LAST is supposed to be set on the last extent
> > > > > in the file, not the last record in the queried dataset.
> > > > 
> > > > Thought so too, sure will spend some time to try fixing it.
> > > 
> > > Looked into this. I think below should fix our above reported problem with
> > > current iomap code.
> > > If no objection I will send send PATCHv3 with below fix as the first
> > > patch in the series.
> > > 
> > > diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> > > index bccf305ea9ce..ee53991810d5 100644
> > > --- a/fs/iomap/fiemap.c
> > > +++ b/fs/iomap/fiemap.c
> > > @@ -100,7 +100,12 @@ int iomap_fiemap(struct inode *inode, struct
> > > fiemap_extent_info *fi,
> > >          }
> > > 
> > >          if (ctx.prev.type != IOMAP_HOLE) {
> > > -               ret = iomap_to_fiemap(fi, &ctx.prev, FIEMAP_EXTENT_LAST);
> > > +               u32 flags = 0;
> > > +               loff_t isize = i_size_read(inode);
> > > +
> > > +               if (ctx.prev.offset + ctx.prev.length >= isize)
> > 
> > What happens if ctx.prev actually is the last iomap in the file, but
> > isize extends beyond that?  e.g.,
> > 
> > # xfs_io -f -c 'pwrite 0 64k' /a
> > # truncate -s 100m /a
> > # filefrag -v /a
> 
> Err.. should never miss this truncate case.
> 
> Digging further, I see even generic_block_fiemap() does not take care of
> this case if the file isize is extended by truncate.
> It happens to mark _LAST only based on i_size_read(). It seems only ext*
> family and hpfs filesystem seems to be using this currently.
> And gfs2 was the user of this api till sometime back before it finally
> moved to use iomap_fiemap() api.
> 
> 
> > 
> > I think we need the fiemap variant of the iomap_begin functions to pass
> > a flag in the iomap that the fiemap implementation can pick up.
> 
> Sure, let me do some digging on this one. One challenge which I think would
> be for filesystems to tell *efficiently* on whether this is the
> last extent or not (without checking on every iomap_begin call about,
> if there exist a next extent on the disk by doing more I/O - that's why
> *efficiently*).
> 
> If done then -
> we could use IOMAP_FIEMAP as the flag to pass to iomap_begin functions
> and it could return us the iomap->type marked with IOMAP_EXTENT_LAST which
> could represent that this is actually the last extent on disk for
> this inode.

So I think IOMAP_EXTENT_LAST should be treated as an optional flag. If the
fs can provide it in a cheap way, do so. Otherwise don't bother. Because
ultimately, the FIEMAP caller has to deal with not seeing IOMAP_EXTENT_LAST
anyway (e.g. if the file has no extents or if someone modifies the file
between the calls). So maybe we need to rather update the documentation
that the IOMAP_EXTENT_LAST is best-effort only?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
