Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 219D719DDD5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 20:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgDCSVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 14:21:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:18906 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbgDCSVV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:21:21 -0400
IronPort-SDR: VZ0H3B9KbBHxRSWub6qinqn+F3JK/++W6PF1JUo/oTTtP9MmmehZlw+zeFxXMF6OHs3VANg1bF
 JXJYI1jBJcyw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 11:21:21 -0700
IronPort-SDR: sp8cZ70vgPQc5t7j6RPTbbWyIa3gSPNsDNol5w7wkY13nJXDnjUzdpL2AbyBHILKa9VKDt/vsN
 ET4hmAjW9Sjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="scan'208";a="238957020"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga007.jf.intel.com with ESMTP; 03 Apr 2020 11:21:20 -0700
Date:   Fri, 3 Apr 2020 11:21:20 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20200403182119.GL3952565@iweiny-DESK2.sc.intel.com>
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
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 03, 2020 at 11:18:43AM -0700, 'Ira Weiny' wrote:
[snip]

> 
> Ok For 5.8 why don't we not allow FS_XFLAG_DAX to be changed on files _at_
> _all_...

To be fair, I believe Christoph advocated for this at one time or another...

Ira

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
> 
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
> 
> 
> ???
> 
> Ira
> 
