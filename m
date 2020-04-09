Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9041A372C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 17:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgDIP3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 11:29:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:25819 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728251AbgDIP3p (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:29:45 -0400
IronPort-SDR: EAqBOIe7A8WuZBFNhpSADYFgv8RtMqLOO8LYbUuxTf2gl4oEa0pBId5PY5VPC6BIo0KinzWqWE
 1GGvnWeJC/3w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 08:29:45 -0700
IronPort-SDR: VicGFp3oywAC4FzoKR8Eu5U9ZwW9zVzpVKjiSxXCh5g9tiamiE0eUd3nl+fKuSZ4hQgRPKbUVu
 e/BKwKKZUkaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; 
   d="scan'208";a="286922766"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga002.fm.intel.com with ESMTP; 09 Apr 2020 08:29:45 -0700
Date:   Thu, 9 Apr 2020 08:29:44 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 6/8] fs/xfs: Combine xfs_diflags_to_linux() and
 xfs_diflags_to_iflags()
Message-ID: <20200409152944.GA801705@iweiny-DESK2.sc.intel.com>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-7-ira.weiny@intel.com>
 <20200408020827.GI24067@dread.disaster.area>
 <20200408170923.GC569068@iweiny-DESK2.sc.intel.com>
 <20200408210236.GK24067@dread.disaster.area>
 <20200408220734.GA664132@iweiny-DESK2.sc.intel.com>
 <20200408232106.GO24067@dread.disaster.area>
 <20200409001206.GD664132@iweiny-DESK2.sc.intel.com>
 <20200409003021.GJ6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409003021.GJ6742@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 08, 2020 at 05:30:21PM -0700, Darrick J. Wong wrote:

[snip]

> 
> But you're right, this thing keeps swirling around and around and around
> because we can't ever get to agreement on this.  Maybe I'll just become
> XFS BOFH MAINTAINER and make a decision like this:
> 
>  1 Applications must call statx to discover the current S_DAX state.
> 
>  2 There exists an advisory file inode flag FS_XFLAG_DAX that is set based on
>    the parent directory FS_XFLAG_DAX inode flag.  This advisory flag can be
>    changed after file creation, but it does not immediately affect the S_DAX
>    state.
> 
>    If FS_XFLAG_DAX is set and the fs is on pmem then it will enable S_DAX at
>    inode load time; if FS_XFLAG_DAX is not set, it will not enable S_DAX.
>    Unless overridden...
> 
>  3 There exists a dax= mount option.
> 
>    "-o dax=never" means "never set S_DAX, ignore FS_XFLAG_DAX"
>    "-o dax=always" means "always set S_DAX (at least on pmem), ignore FS_XFLAG_DAX"
>         "-o dax" by itself means "dax=always"
>    "-o dax=iflag" means "follow FS_XFLAG_DAX" and is the default

per-Dave '-o dax=inode'

> 
>  4 There exists an advisory directory inode flag FS_XFLAG_DAX that can be
>    changed at any time.  The flag state is copied into any files or
>    subdirectories when they are created within that directory.

Good.

>    If programs
>    require file access runs in S_DAX mode, they must create those files
>    inside a directory with FS_XFLAG_DAX set, or mount the fs with an
>    appropriate dax mount option.

Why do we need this to be true?  If the FS_XFLAG_DAX flag can be cleared why
not set it and allow the S_DAX change to occur later just like clearing it?
The logic is exactly the same.

> 
>  5 Programs that require a specific file access mode (DAX or not DAX) must

s/must/can/

>    do one of the following:
> 
>    (a) create files in directories with the FS_XFLAG_DAX flag set as needed;

Again if we allow clearing the flag why not setting?  So this is 1 option they
'can' do.

> 
>    (b) have the administrator set an override via mount option;
> 
>    (c) if they need to change a file's FS_XFLAG_DAX flag so that it does not
>        match the S_DAX state (as reported by statx), they must cause the
>        kernel to evict the inode from memory.  This can be done by:
> 
>        i>   closing the file;
>        ii>  re-opening the file and using statx to see if the fs has
>             changed the S_DAX flag;

i and ii need to be 1 step the user must follow.

>        iii> if not, either unmount and remount the filesystem, or
>             closing the file and using drop_caches.
> 
>  6 I no longer think it's too wild to require that users who want to
>    squeeze every last bit of performance out of the particular rough and
>    tumble bits of their storage also be exposed to the difficulties of
>    what happens when the operating system can't totally virtualize those
>    hardware capabilities.  Your high performance sports car is not a
>    Toyota minivan, as it were.

I'm good with this statement.  But I think we need to clean up the verbiage for
the documentation...  ;-)

Thanks for the summary.  I like these to get everyone on the same page.  :-D
Ira

> 
> I think (like Dave said) that if you set XFS_IDONTCACHE on the inode
> when you change the DAX flag, the VFS will kill the inode the instant
> the last user close()s the file.  Then 5.c.ii will actually work.
> 
> --D
> 
> > > 
> > > > Furthermore, if we did want an interface like that why not allow
> > > > the on-disk flag to be set as well as cleared?
> > > 
> > > Well, why not - it's why I implemented the flag in the first place!
> > > The only problem we have here is how to safely change the in-memory
> > > DAX state, and that largely has nothing to do with setting/clearing
> > > the on-disk flag....
> > 
> > With the above change to xfs_diflags_to_iflags() I think we are ok here.
> > 
> > Ira
> > 
