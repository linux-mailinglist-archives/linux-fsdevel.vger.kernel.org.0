Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2A81A38CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 19:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgDIRRi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 13:17:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:45794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbgDIRRi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:17:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6E081ABEF;
        Thu,  9 Apr 2020 17:17:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0D76D1E124D; Thu,  9 Apr 2020 19:17:35 +0200 (CEST)
Date:   Thu, 9 Apr 2020 19:17:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 6/8] fs/xfs: Combine xfs_diflags_to_linux() and
 xfs_diflags_to_iflags()
Message-ID: <20200409171735.GA24720@quack2.suse.cz>
References: <20200407182958.568475-7-ira.weiny@intel.com>
 <20200408020827.GI24067@dread.disaster.area>
 <20200408170923.GC569068@iweiny-DESK2.sc.intel.com>
 <20200408210236.GK24067@dread.disaster.area>
 <20200408220734.GA664132@iweiny-DESK2.sc.intel.com>
 <20200408232106.GO24067@dread.disaster.area>
 <20200409001206.GD664132@iweiny-DESK2.sc.intel.com>
 <20200409003021.GJ6742@magnolia>
 <20200409152944.GA801705@iweiny-DESK2.sc.intel.com>
 <20200409165927.GD6741@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409165927.GD6741@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 09-04-20 09:59:27, Darrick J. Wong wrote:
> And today:
> 
>  1. There exists an in-kernel access mode flag S_DAX that is set when
>     file accesses go directly to persistent memory, bypassing the page
>     cache.  Applications must call statx to discover the current S_DAX
>     state (STATX_ATTR_DAX).
> 
>  2. There exists an advisory file inode flag FS_XFLAG_DAX that is
>     inherited from the parent directory FS_XFLAG_DAX inode flag at file
>     creation time.  This advisory flag can be set or cleared at any
>     time, but doing so does not immediately affect the S_DAX state.
> 
>     Unless overridden by mount options (see (3)), if FS_XFLAG_DAX is set
>     and the fs is on pmem then it will enable S_DAX at inode load time;
>     if FS_XFLAG_DAX is not set, it will not enable S_DAX.
> 
>  3. There exists a dax= mount option.
> 
>     "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."
> 
>     "-o dax=always" means "always set S_DAX (at least on pmem),
>                     and ignore FS_XFLAG_DAX."
> 
>     "-o dax"        is an alias for "dax=always".
> 
>     "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.
> 
>  4. There exists an advisory directory inode flag FS_XFLAG_DAX that can
>     be set or cleared at any time.  The flag state is copied into any
>     files or subdirectories when they are created within that directory.
> 
>  5. Programs that require a specific file access mode (DAX or not DAX)
>     can do one of the following:
> 
>     (a) Create files in directories that the FS_XFLAG_DAX flag set as
>         needed; or
> 
>     (b) Have the administrator set an override via mount option; or
> 
>     (c) Set or clear the file's FS_XFLAG_DAX flag as needed.  Programs
>         must then cause the kernel to evict the inode from memory.  This
>         can be done by:
> 
>         i>  Closing the file and re-opening the file and using statx to
>             see if the fs has changed the S_DAX flag; and
> 
>         ii> If the file still does not have the desired S_DAX access
>             mode, either unmount and remount the filesystem, or close
>             the file and use drop_caches.
> 
>  6. It's not unreasonable that users who want to squeeze every last bit
>     of performance out of the particular rough and tumble bits of their
>     storage also be exposed to the difficulties of what happens when the
>     operating system can't totally virtualize those hardware
>     capabilities.  Your high performance sports car is not a Toyota
>     minivan, as it were.
> 
> Given our overnight discussions, I don't think it'll be difficult to
> hoist XFS_IDONTCACHE to the VFS so that 5.c.i is enough to change the
> S_DAX state if nobody else is using the file.

I still find the "S_DAX changes on inode eviction" confusing but I
guess it's as good as it gets and with XFS_IDONTCACHE lifted to VFS, 
it seems acceptable so OK from me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
