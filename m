Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF07119CF5F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 06:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbgDCEjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 00:39:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:19394 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgDCEjD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 00:39:03 -0400
IronPort-SDR: H/LQxK3d0Y3xA0ApWFa+6DRBQjdAJjbAP/3PQFZfUI66Od1mF+IgVnVaImVnpeV6ZV7EDcWrZI
 x+sksbogFKAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 21:39:02 -0700
IronPort-SDR: xKrqCXM86SXhnugdFt3obxFXmfKoeWIC1M5kbMc+05JVG/0Gfn2PTYInne6x+V61j2AhVn+fUh
 37/DnQQipmOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,338,1580803200"; 
   d="scan'208";a="241021226"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga007.fm.intel.com with ESMTP; 02 Apr 2020 21:39:01 -0700
Date:   Thu, 2 Apr 2020 21:39:01 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations V5
Message-ID: <20200403043901.GH3952565@iweiny-DESK2.sc.intel.com>
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
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 01, 2020 at 04:00:21AM +0000, Darrick J. Wong wrote:
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

One other thing to add here.  They _can_ set the FS_XFLAG_DAX on a file with
data and force an eviction to get S_DAX to change.

I think that is a nice reason to have a different error code returned.

> 
> Ok?  Let's please get this part finished for 5.8, then we can get back
> to arguing about fs-rmap and reflink and dax and whatnot.

I'm happy to see you motivated to get this in.

I'm starting with a new xfstest to make sure we agree on the semantics prior to
more patches.  I hope to have the xfstest patch sent tomorrow sometime.

Ira

> 
> --D
