Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED581A6930
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 17:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731132AbgDMPxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 11:53:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:23003 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730923AbgDMPxb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:53:31 -0400
IronPort-SDR: +3V5bGy9diZ/WUc47UtQVOPLdy3RvpUz8enl4F/x1qmMJA439Pl2fytohnLi2YWq+vqDzO+48q
 6WHZz4r/Q6mg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 08:53:27 -0700
IronPort-SDR: OdZguRshJhPs+cTxV/tPWG8TIeOnFVJ2u5n/nZNKVJpmOpxpT7j2PQ/KiSZolC9qxXx2g+nh/z
 CfE7wE398vOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="252910113"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga003.jf.intel.com with ESMTP; 13 Apr 2020 08:53:26 -0700
Date:   Mon, 13 Apr 2020 08:53:26 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] xfs/XXX: Add xfs/XXX
Message-ID: <20200413155325.GA1560218@iweiny-DESK2.sc.intel.com>
References: <20200413054419.1560503-1-ira.weiny@intel.com>
 <CAOQ4uxguVRysAuVEtQmPj+x=RDtDnGCtNeGvbvXNuvppwagwDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxguVRysAuVEtQmPj+x=RDtDnGCtNeGvbvXNuvppwagwDg@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 13, 2020 at 10:54:36AM +0300, Amir Goldstein wrote:
> On Mon, Apr 13, 2020 at 9:06 AM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > Add XXX to test per file DAX operations.
> 
> Please change commit title to "xfs: Add test for per file DAX operations"
> The title Add xfs/XXX is not useful even if XXX where a number.

Thanks and...  yes this really should have been marked RFC as the requirements
have been in flux and I never meant for this to be merged until the kernel
patches are merged.  Hence keeping the number XXX.

RFC would have been better.

I've update v8.  thanks!

> 
> But the kernel patch suggests that there is an intention to make
> this behavior also applicable to ext4??
> If that is the case I would recommend making this a generic tests
> which requires filesystem support for -o dax=XXX

I have a patch set for ext4 which is not quite passing this.  I'm not sure what
is going on yet.

Once that is working I was going to move this to generic.  (The documentation
in the kernel patch set also reflects ext4 being different from xfs for the
time being.)

This is mainly because I'm not sure if ext4 will make 5.8 or not.  Would you
prefer making this generic now?  I assume there is some way to mark generic
tests for a subset of FS's?  I have not figured that out yet.

> 
> >
> > The following is tested[*]
> >
> >  1. There exists an in-kernel access mode flag S_DAX that is set when
> >     file accesses go directly to persistent memory, bypassing the page
> >     cache.  Applications must call statx to discover the current S_DAX
> >     state (STATX_ATTR_DAX).
> >
> >  2. There exists an advisory file inode flag FS_XFLAG_DAX that is
> >     inherited from the parent directory FS_XFLAG_DAX inode flag at file
> >     creation time.  This advisory flag can be set or cleared at any
> >     time, but doing so does not immediately affect the S_DAX state.
> >
> >     Unless overridden by mount options (see (3)), if FS_XFLAG_DAX is set
> >     and the fs is on pmem then it will enable S_DAX at inode load time;
> >     if FS_XFLAG_DAX is not set, it will not enable S_DAX.
> >
> >  3. There exists a dax= mount option.
> >
> >     "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."
> >
> >     "-o dax=always" means "always set S_DAX (at least on pmem),
> >                     and ignore FS_XFLAG_DAX."
> >
> >     "-o dax"        is an alias for "dax=always".
> >
> >     "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.
> >
> >  4. There exists an advisory directory inode flag FS_XFLAG_DAX that can
> >     be set or cleared at any time.  The flag state is copied into any
> >     files or subdirectories when they are created within that directory.
> >
> >  5. Programs that require a specific file access mode (DAX or not DAX)
> >     can do one of the following:
> >
> >     (a) Create files in directories that the FS_XFLAG_DAX flag set as
> >         needed; or
> >
> >     (b) Have the administrator set an override via mount option; or
> >
> >     (c) Set or clear the file's FS_XFLAG_DAX flag as needed.  Programs
> >         must then cause the kernel to evict the inode from memory.  This
> >         can be done by:
> >
> >         i>  Closing the file and re-opening the file and using statx to
> >             see if the fs has changed the S_DAX flag; and
> >
> >         ii> If the file still does not have the desired S_DAX access
> >             mode, either unmount and remount the filesystem, or close
> >             the file and use drop_caches.
> >
> >  6. It's not unreasonable that users who want to squeeze every last bit
> >     of performance out of the particular rough and tumble bits of their
> >     storage also be exposed to the difficulties of what happens when the
> >     operating system can't totally virtualize those hardware
> >     capabilities.  Your high performance sports car is not a Toyota
> >     minivan, as it were.
> >
> > [*] https://lore.kernel.org/lkml/20200409165927.GD6741@magnolia/
> >
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >
> > ---
> > Changes from v6 (kernel patch set):
> >         Start versions tracking the kernel patch set.
> >         Update for new requirements
> >
> > Changes from V1 (xfstests patch):
> >         Add test to ensure moved files preserve their flag
> >         Check chattr of non-dax flags (check bug found by Darrick)
> > ---
> ...
> > --- a/tests/xfs/group
> > +++ b/tests/xfs/group
> > @@ -511,3 +511,4 @@
> >  511 auto quick quota
> >  512 auto quick acl attr
> >  513 auto mount
> > +999 auto
> 
> The test looks also 'quick'

Sure! Updated in v8

Thanks for the review!
Ira

> 
> Thanks,
> Amir.
