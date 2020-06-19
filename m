Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BC5200022
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 04:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgFSCUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 22:20:07 -0400
Received: from fieldses.org ([173.255.197.46]:52028 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbgFSCUG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 22:20:06 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id D77A814D8; Thu, 18 Jun 2020 22:20:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D77A814D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1592533205;
        bh=tPBUrS2dw2CNJJWnlKPuvieHEc3u/i6Wc5TU2ZESPC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nLr3ZJr5/23V2Y5xzN5XfJB1JaO/LXjJBJuS+O9NwynuGAP6WZCnDsmGJwbFzBeu7
         2+PmhFrjYHVYcPEwhS1oEEaCN089NnTXR8009D++ZJHgKiTSZrj3ZVUK7gfouBnZMZ
         /ZnVxmQsv1Fntbiv/ofG3OoLwKStJVESrWdppses=
Date:   Thu, 18 Jun 2020 22:20:05 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>, jlayton@redhat.com
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200619022005.GA25414@fieldses.org>
References: <24692989-2ee0-3dcc-16d8-aa436114f5fb@sandeen.net>
 <20200617172456.GP11245@magnolia>
 <8f0df756-4f71-9d96-7a52-45bf51482556@sandeen.net>
 <20200617181816.GA18315@fieldses.org>
 <4cbb5cbe-feb4-2166-0634-29041a41a8dc@sandeen.net>
 <20200617184507.GB18315@fieldses.org>
 <20200618013026.ewnhvf64nb62k2yx@gabell>
 <20200618030539.GH2005@dread.disaster.area>
 <20200618034535.h5ho7pd4eilpbj3f@gabell>
 <20200618223948.GI2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618223948.GI2005@dread.disaster.area>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 19, 2020 at 08:39:48AM +1000, Dave Chinner wrote:
> On Wed, Jun 17, 2020 at 11:45:35PM -0400, Masayoshi Mizuma wrote:
> > Thank you for pointed it out.
> > How about following change? I believe it works both xfs and btrfs...
> > 
> > diff --git a/fs/super.c b/fs/super.c
> > index b0a511bef4a0..42fc6334d384 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -973,6 +973,9 @@ int reconfigure_super(struct fs_context *fc)
> >                 }
> >         }
> > 
> > +       if (sb->s_flags & SB_I_VERSION)
> > +               fc->sb_flags |= MS_I_VERSION;
> > +
> >         WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
> >                                  (fc->sb_flags & fc->sb_flags_mask)));
> >         /* Needs to be ordered wrt mnt_is_readonly() */
> 
> This will prevent SB_I_VERSION from being turned off at all. That
> will break existing filesystems that allow SB_I_VERSION to be turned
> off on remount, such as ext4.
> 
> The manipulations here need to be in the filesystem specific code;
> we screwed this one up so badly there is no "one size fits all"
> behaviour that we can implement in the generic code...

My memory was that after Jeff Layton's i_version patches, there wasn't
really a significant performance hit any more, so the ability to turn it
off is no longer useful.

But looking back through Jeff's postings, I don't see him claiming that;
e.g. in:

	https://lore.kernel.org/lkml/20171222120556.7435-1-jlayton@kernel.org/
	https://lore.kernel.org/linux-nfs/20180109141059.25929-1-jlayton@kernel.org/
	https://lore.kernel.org/linux-nfs/1517228795.5965.24.camel@redhat.com/

he reports comparing old iversion behavior to new iversion behavior, but
not new iversion behavior to new noiversion behavior.

--b.
