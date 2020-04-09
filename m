Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37FD71A387F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 18:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgDIQ7q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 12:59:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49242 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgDIQ7p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:59:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039Gi6JY002917;
        Thu, 9 Apr 2020 16:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=2vbxrvgNae4PvH58+vdCGOVIxMP0N5RBuClEHaxXJNk=;
 b=xKvnTo5bcC8lhUbN1W6Pkt877W06I5m5K9sh5mqZG9i25ksVkM/TKL61eX1HVto3EFUd
 Jl4pYSK7hpt/9LfhTfXf0+okBQjUXUuRQZOE1CGHuZUFaP9Fw9aPkxI6cw5mHDGckNMe
 vEOzzuJaJg1IZRN+nA6lVmMYpKy0qmljq0xtRNXbvoID3jBLnvUd3GGefuSszEetAW4m
 1nbCB9oAm40GV+nX8mg2dKU9EWeirp1nAhXOnWq9kfIb//HnwbbNg/9JqzmjS5FAY+Y6
 It7gr1+xAW3Lh6qDwRvGS92HthaG+WcptQkT5Jhu5O9OKoROM8L/CzK+hc6lo18uPNWB IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3091m12qja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 16:59:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039Ggc4F168728;
        Thu, 9 Apr 2020 16:59:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 309gdc7ysq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 16:59:30 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 039GxSSX028659;
        Thu, 9 Apr 2020 16:59:29 GMT
Received: from localhost (/10.159.158.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Apr 2020 09:59:28 -0700
Date:   Thu, 9 Apr 2020 09:59:27 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 6/8] fs/xfs: Combine xfs_diflags_to_linux() and
 xfs_diflags_to_iflags()
Message-ID: <20200409165927.GD6741@magnolia>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-7-ira.weiny@intel.com>
 <20200408020827.GI24067@dread.disaster.area>
 <20200408170923.GC569068@iweiny-DESK2.sc.intel.com>
 <20200408210236.GK24067@dread.disaster.area>
 <20200408220734.GA664132@iweiny-DESK2.sc.intel.com>
 <20200408232106.GO24067@dread.disaster.area>
 <20200409001206.GD664132@iweiny-DESK2.sc.intel.com>
 <20200409003021.GJ6742@magnolia>
 <20200409152944.GA801705@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409152944.GA801705@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090121
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 08:29:44AM -0700, Ira Weiny wrote:
> On Wed, Apr 08, 2020 at 05:30:21PM -0700, Darrick J. Wong wrote:
> 
> [snip]
> 
> > 
> > But you're right, this thing keeps swirling around and around and around
> > because we can't ever get to agreement on this.  Maybe I'll just become
> > XFS BOFH MAINTAINER and make a decision like this:
> > 
> >  1 Applications must call statx to discover the current S_DAX state.
> > 
> >  2 There exists an advisory file inode flag FS_XFLAG_DAX that is set based on
> >    the parent directory FS_XFLAG_DAX inode flag.  This advisory flag can be
> >    changed after file creation, but it does not immediately affect the S_DAX
> >    state.
> > 
> >    If FS_XFLAG_DAX is set and the fs is on pmem then it will enable S_DAX at
> >    inode load time; if FS_XFLAG_DAX is not set, it will not enable S_DAX.
> >    Unless overridden...
> > 
> >  3 There exists a dax= mount option.
> > 
> >    "-o dax=never" means "never set S_DAX, ignore FS_XFLAG_DAX"
> >    "-o dax=always" means "always set S_DAX (at least on pmem), ignore FS_XFLAG_DAX"
> >         "-o dax" by itself means "dax=always"
> >    "-o dax=iflag" means "follow FS_XFLAG_DAX" and is the default
> 
> per-Dave '-o dax=inode'

Ok.

> > 
> >  4 There exists an advisory directory inode flag FS_XFLAG_DAX that can be
> >    changed at any time.  The flag state is copied into any files or
> >    subdirectories when they are created within that directory.
> 
> Good.
> 
> >    If programs
> >    require file access runs in S_DAX mode, they must create those files
> >    inside a directory with FS_XFLAG_DAX set, or mount the fs with an
> >    appropriate dax mount option.
> 
> Why do we need this to be true?  If the FS_XFLAG_DAX flag can be cleared why
> not set it and allow the S_DAX change to occur later just like clearing it?
> The logic is exactly the same.

I think I'll just delete this sentence since I started pushing all that
verbiage towards (5).

To answer your question, yes, FS_XFLAG_DAX can be set on a file at any
time, the same as it can be cleared at any time.  Sorry that was
unclear, I'll fix that for the next draft (below).

> > 
> >  5 Programs that require a specific file access mode (DAX or not DAX) must
> 
> s/must/can/

Ok.

> >    do one of the following:
> > 
> >    (a) create files in directories with the FS_XFLAG_DAX flag set as needed;
> 
> Again if we allow clearing the flag why not setting?  So this is 1 option they
> 'can' do.
> 
> > 
> >    (b) have the administrator set an override via mount option;
> > 
> >    (c) if they need to change a file's FS_XFLAG_DAX flag so that it does not
> >        match the S_DAX state (as reported by statx), they must cause the
> >        kernel to evict the inode from memory.  This can be done by:
> > 
> >        i>   closing the file;
> >        ii>  re-opening the file and using statx to see if the fs has
> >             changed the S_DAX flag;
> 
> i and ii need to be 1 step the user must follow.

Ok, I'll combine these.

> >        iii> if not, either unmount and remount the filesystem, or
> >             closing the file and using drop_caches.
> > 
> >  6 I no longer think it's too wild to require that users who want to
> >    squeeze every last bit of performance out of the particular rough and
> >    tumble bits of their storage also be exposed to the difficulties of
> >    what happens when the operating system can't totally virtualize those
> >    hardware capabilities.  Your high performance sports car is not a
> >    Toyota minivan, as it were.
> 
> I'm good with this statement.  But I think we need to clean up the verbiage for
> the documentation...  ;-)

Heh. :)

> Thanks for the summary.  I like these to get everyone on the same page.  :-D

And today:

 1. There exists an in-kernel access mode flag S_DAX that is set when
    file accesses go directly to persistent memory, bypassing the page
    cache.  Applications must call statx to discover the current S_DAX
    state (STATX_ATTR_DAX).

 2. There exists an advisory file inode flag FS_XFLAG_DAX that is
    inherited from the parent directory FS_XFLAG_DAX inode flag at file
    creation time.  This advisory flag can be set or cleared at any
    time, but doing so does not immediately affect the S_DAX state.

    Unless overridden by mount options (see (3)), if FS_XFLAG_DAX is set
    and the fs is on pmem then it will enable S_DAX at inode load time;
    if FS_XFLAG_DAX is not set, it will not enable S_DAX.

 3. There exists a dax= mount option.

    "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."

    "-o dax=always" means "always set S_DAX (at least on pmem),
                    and ignore FS_XFLAG_DAX."

    "-o dax"        is an alias for "dax=always".

    "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.

 4. There exists an advisory directory inode flag FS_XFLAG_DAX that can
    be set or cleared at any time.  The flag state is copied into any
    files or subdirectories when they are created within that directory.

 5. Programs that require a specific file access mode (DAX or not DAX)
    can do one of the following:

    (a) Create files in directories that the FS_XFLAG_DAX flag set as
        needed; or

    (b) Have the administrator set an override via mount option; or

    (c) Set or clear the file's FS_XFLAG_DAX flag as needed.  Programs
        must then cause the kernel to evict the inode from memory.  This
        can be done by:

        i>  Closing the file and re-opening the file and using statx to
            see if the fs has changed the S_DAX flag; and

        ii> If the file still does not have the desired S_DAX access
            mode, either unmount and remount the filesystem, or close
            the file and use drop_caches.

 6. It's not unreasonable that users who want to squeeze every last bit
    of performance out of the particular rough and tumble bits of their
    storage also be exposed to the difficulties of what happens when the
    operating system can't totally virtualize those hardware
    capabilities.  Your high performance sports car is not a Toyota
    minivan, as it were.

Given our overnight discussions, I don't think it'll be difficult to
hoist XFS_IDONTCACHE to the VFS so that 5.c.i is enough to change the
S_DAX state if nobody else is using the file.

--D

> > 
> > > Furthermore, if we did want an interface like that why not allow
> > > the on-disk flag to be set as well as cleared?
> > 
> > Well, why not - it's why I implemented the flag in the first place!
> > The only problem we have here is how to safely change the in-memory
> > DAX state, and that largely has nothing to do with setting/clearing
> > the on-disk flag....
> 
> With the above change to xfs_diflags_to_iflags() I think we are ok here.
> 
> Ira
> 
--D

> Ira
> 
> > 
> > I think (like Dave said) that if you set XFS_IDONTCACHE on the inode
> > when you change the DAX flag, the VFS will kill the inode the instant
> > the last user close()s the file.  Then 5.c.ii will actually work.
> > 
> > --D
> > 
> > > > 
> > > > > Furthermore, if we did want an interface like that why not allow
> > > > > the on-disk flag to be set as well as cleared?
> > > > 
> > > > Well, why not - it's why I implemented the flag in the first place!
> > > > The only problem we have here is how to safely change the in-memory
> > > > DAX state, and that largely has nothing to do with setting/clearing
> > > > the on-disk flag....
> > > 
> > > With the above change to xfs_diflags_to_iflags() I think we are ok here.
> > > 
> > > Ira
> > > 
