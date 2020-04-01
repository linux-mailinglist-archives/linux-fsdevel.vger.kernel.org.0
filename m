Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C42A919A983
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 12:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732170AbgDAKZQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 06:25:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:46580 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgDAKZP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:25:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 36C6DAD39;
        Wed,  1 Apr 2020 10:25:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 387F51E11F4; Wed,  1 Apr 2020 12:25:11 +0200 (CEST)
Date:   Wed, 1 Apr 2020 12:25:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations V5
Message-ID: <20200401102511.GC19466@quack2.suse.cz>
References: <20200227052442.22524-1-ira.weiny@intel.com>
 <20200305155144.GA5598@lst.de>
 <20200309170437.GA271052@iweiny-DESK2.sc.intel.com>
 <20200311033614.GQ1752567@magnolia>
 <20200311062952.GA11519@lst.de>
 <CAPcyv4h9Xg61jk=Uq17xC6AGj9yOSAJnCaTzHcfBZwOVdRF9dw@mail.gmail.com>
 <20200316095224.GF12783@quack2.suse.cz>
 <20200316095509.GA13788@lst.de>
 <20200401040021.GC56958@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401040021.GC56958@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 01-04-20 04:00:21, Darrick J. Wong wrote:
> On Mon, Mar 16, 2020 at 10:55:09AM +0100, Christoph Hellwig wrote:
> > On Mon, Mar 16, 2020 at 10:52:24AM +0100, Jan Kara wrote:
> > > > This sounds reasonable to me.
> > > > 
> > > > As for deprecating the mount option, I think at a minimum it needs to
> > > > continue be accepted as an option even if it is ignored to not break
> > > > existing setups.
> > > 
> > > Agreed. But that's how we usually deprecate mount options. Also I'd say
> > > that statx() support for reporting DAX state and some education of
> > > programmers using DAX is required before we deprecate the mount option
> > > since currently applications check 'dax' mount option to determine how much
> > > memory they need to set aside for page cache before they consume everything
> > > else on the machine...
> > 
> > I don't even think we should deprecate it.  It isn't painful to maintain
> > and actually useful for testing.  Instead we should expand it into a
> > tristate:
> > 
> >   dax=off
> >   dax=flag
> >   dax=always
> > 
> > where the existing "dax" option maps to "dax=always" and nodax maps
> > to "dax=off". and dax=flag becomes the default for DAX capable devices.
> 
> That works for me.  In summary:
> 
>  - Applications must call statx to discover the current S_DAX state.
> 
>  - There exists an advisory file inode flag FS_XFLAG_DAX that can be
>    changed on files that have no blocks allocated to them.  Changing
>    this flag does not necessarily change the S_DAX state immediately
>    but programs can query the S_DAX state via statx.

I generally like the proposal but I think the fact that toggling
FS_XFLAG_DAX will not have immediate effect on S_DAX will cause quite some
confusion and ultimately bug reports. I'm thinking whether we could somehow
improve this... For example an ioctl that would try to make set inode flags
effective by evicting the inode (and returning EBUSY if the eviction is
impossible for some reason)?

								Honza

> 
>    If FS_XFLAG_DAX is set and the fs is on pmem then it will always
>    enable S_DAX at inode load time; if FS_XFLAG_DAX is not set, it will
>    never enable S_DAX.  Unless overridden...
> 
>  - There exists a dax= mount option.  dax=off means "never set S_DAX,
>    ignore FS_XFLAG_DAX"; dax=always means "always set S_DAX (at least on
>    pmem), ignore FS_XFLAG_DAX"; and dax=iflag means "follow FS_XFLAG_DAX"
>    and is the default.  "dax" by itself means "dax=always".  "nodax"
>    means "dax=off".
> 
>  - There exists an advisory directory inode flag FS_XFLAG_DAX that can
>    be changed at any time.  The flag state is copied into any files or
>    subdirectories created within that directory.  If programs require
>    that file access runs in S_DAX mode, they'll have to create those
>    files themselves inside a directory with FS_XFLAG_DAX set, or mount
>    the fs with dax=always.
> 
> Ok?  Let's please get this part finished for 5.8, then we can get back
> to arguing about fs-rmap and reflink and dax and whatnot.
> 
> --D
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
