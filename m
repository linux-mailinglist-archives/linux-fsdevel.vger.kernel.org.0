Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508FC19E98E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Apr 2020 08:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDEGTs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Apr 2020 02:19:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:48527 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgDEGTs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Apr 2020 02:19:48 -0400
IronPort-SDR: 0JF/wGpFCelx3CgApolLUStyJsNdNVW979B04mnerw1lWq6BEC8nlYkVqDFCp9KIufPhX6tg3h
 hV5j6Xo/vMng==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2020 23:19:47 -0700
IronPort-SDR: 0110s7953263huErBoTRO4j83eC8Y3EFM92Atlg5RxKrkmln04D0YozOxKZzJHYAvkykohpDAn
 6hdmIjIg2wtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,346,1580803200"; 
   d="scan'208";a="253776526"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga006.jf.intel.com with ESMTP; 04 Apr 2020 23:19:46 -0700
Date:   Sat, 4 Apr 2020 23:19:46 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations V5
Message-ID: <20200405061945.GA94792@iweiny-DESK2.sc.intel.com>
References: <20200316095509.GA13788@lst.de>
 <20200401040021.GC56958@magnolia>
 <20200401102511.GC19466@quack2.suse.cz>
 <20200402085327.GA19109@lst.de>
 <20200402205518.GF3952565@iweiny-DESK2.sc.intel.com>
 <20200403072731.GA24176@lst.de>
 <20200403154828.GJ3952565@iweiny-DESK2.sc.intel.com>
 <20200403170338.GD29920@quack2.suse.cz>
 <20200403181843.GK3952565@iweiny-DESK2.sc.intel.com>
 <20200403183746.GQ80283@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403183746.GQ80283@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > 
> > In summary:
> > 
> >  - Applications must call statx to discover the current S_DAX state.
> 
> Ok.
> 
> >  - There exists an advisory file inode flag FS_XFLAG_DAX that is set based on
> >    the parent directory FS_XFLAG_DAX inode flag.  (There is no way to change
> >    this flag after file creation.)
> > 
> >    If FS_XFLAG_DAX is set and the fs is on pmem then it will enable S_DAX at
> >    inode load time; if FS_XFLAG_DAX is not set, it will not enable S_DAX.
> >    Unless overridden...
> 
> Ok, fine with me. :)

:-D

> 
> >  - There exists a dax= mount option.
> > 
> >    "-o dax=off" means "never set S_DAX, ignore FS_XFLAG_DAX"
> >    	"-o nodax" means "dax=off"
> 
> I surveyed the three fses that support dax and found that none of the
> filesystems actually have a 'nodax' flag.  Now would be the time not to
> add such a thing, and make people specify dax=off instead.  It would
> be handy if we could have a single fsparam_enum for figuring out the dax
> mount options.

yes good point.

I'm working on updating the documentation patch and I think this might also
be better as:

	-o dax=never

Which is the opposite of 'always'.

> 
> >    "-o dax=always" means "always set S_DAX (at least on pmem), ignore FS_XFLAG_DAX"
> >    	"-o dax" by itself means "dax=always"
> >    "-o dax=iflag" means "follow FS_XFLAG_DAX" and is the default
> > 
> >  - There exists an advisory directory inode flag FS_XFLAG_DAX that can be
> >    changed at any time.  The flag state is copied into any files or
> >    subdirectories when they are created within that directory.  If programs
> >    require file access runs in S_DAX mode, they'll have to create those files
> 
> "...they must create..."

yes

> 
> >    inside a directory with FS_XFLAG_DAX set, or mount the fs with an
> >    appropriate dax mount option.
> 
> Otherwise seems ok to me.

Thanks!
Ira

