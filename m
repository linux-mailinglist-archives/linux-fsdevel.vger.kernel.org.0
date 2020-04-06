Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB81C19F320
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgDFKAI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 06:00:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:36166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbgDFKAH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:00:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7CFCCADCC;
        Mon,  6 Apr 2020 10:00:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 354011E1244; Mon,  6 Apr 2020 12:00:05 +0200 (CEST)
Date:   Mon, 6 Apr 2020 12:00:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
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
Message-ID: <20200406100005.GB1143@quack2.suse.cz>
References: <20200316095224.GF12783@quack2.suse.cz>
 <20200316095509.GA13788@lst.de>
 <20200401040021.GC56958@magnolia>
 <20200401102511.GC19466@quack2.suse.cz>
 <20200402085327.GA19109@lst.de>
 <20200402205518.GF3952565@iweiny-DESK2.sc.intel.com>
 <20200403072731.GA24176@lst.de>
 <20200403154828.GJ3952565@iweiny-DESK2.sc.intel.com>
 <20200403170338.GD29920@quack2.suse.cz>
 <20200403181843.GK3952565@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403181843.GK3952565@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 03-04-20 11:18:43, Ira Weiny wrote:
> Ok For 5.8 why don't we not allow FS_XFLAG_DAX to be changed on files _at_
> _all_...
> 
> In summary:
> 
>  - Applications must call statx to discover the current S_DAX state.
> 
>  - There exists an advisory file inode flag FS_XFLAG_DAX that is set based on
>    the parent directory FS_XFLAG_DAX inode flag.  (There is no way to change
>    this flag after file creation.)
> 
>    If FS_XFLAG_DAX is set and the fs is on pmem then it will enable S_DAX at
>    inode load time; if FS_XFLAG_DAX is not set, it will not enable S_DAX.
>    Unless overridden...

OK, after considering all the options we were hashing out here, I think
this is the best API. There isn't the confusing "S_DAX will magically
switch on inode eviction" and although the functionality is limited, I
think 90% of users would end up using the functionality like this anyway.

>  - There exists a dax= mount option.
> 
>    "-o dax=off" means "never set S_DAX, ignore FS_XFLAG_DAX"
>    	"-o nodax" means "dax=off"
>    "-o dax=always" means "always set S_DAX (at least on pmem), ignore FS_XFLAG_DAX"
>    	"-o dax" by itself means "dax=always"
>    "-o dax=iflag" means "follow FS_XFLAG_DAX" and is the default
> 
>  - There exists an advisory directory inode flag FS_XFLAG_DAX that can be
>    changed at any time.  The flag state is copied into any files or
>    subdirectories when they are created within that directory.  If programs
>    require file access runs in S_DAX mode, they'll have to create those files
>    inside a directory with FS_XFLAG_DAX set, or mount the fs with an
>    appropriate dax mount option.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
