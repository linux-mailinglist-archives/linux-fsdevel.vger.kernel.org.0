Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA5713CB64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 18:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAORxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 12:53:17 -0500
Received: from mga14.intel.com ([192.55.52.115]:43844 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbgAORxQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:53:16 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 09:53:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="256860679"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2020 09:53:16 -0800
Date:   Wed, 15 Jan 2020 09:53:15 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH V2 09/12] fs: Prevent mode change if file is mmap'ed
Message-ID: <20200115175315.GC23311@iweiny-DESK2.sc.intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-10-ira.weiny@intel.com>
 <06258747f6824a35adfaa999ab4c2261@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06258747f6824a35adfaa999ab4c2261@AcuMS.aculab.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 10:21:45AM +0000, David Laight wrote:
> From ira.weiny@intel.com
> > Sent: 10 January 2020 19:30
> > 
> > Page faults need to ensure the inode mode is correct and consistent with
> > the vmf information at the time of the fault.  There is no easy way to
> > ensure the vmf information is correct if a mode change is in progress.
> > Furthermore, there is no good use case to require a mode change while
> > the file is mmap'ed.
> > 
> > Track mmap's of the file and fail the mode change if the file is
> > mmap'ed.
> 
> This seems wrong to me.
> I presume the 'mode changes' are from things like 'chmod -w ...'.

No...  Sorry...  "mode" was a _very_ bad name.  In this context "mode" was the
"DAX mode" not the file mode.

> mmap() should be no different to open().
> Only the permissions set when the file is opened count.
> 
> Next you'll be stopping unlink() when a file is open :-)

hehehe   :-D  no ... sorry that was not the meaning.

To be clear what this is preventing is a change from non-DAX to DAX or vice
versa while a file is mmap'ed.

I'm looking at a better name for this.  For this commit message is this more
clear?

<commit>
fs: Prevent DAX change if file is mmap'ed
  
Page faults need to ensure the inode DAX configuration is correct and 
consistent with the vmf information at the time of the fault.  There is
no easy way to ensure the vmf information is correct if a DAX change is
in progress.  Furthermore, there is no good use case to require changing
DAX configs while the file is mmap'ed.

Track mmap's of the file and fail the DAX change if the file is mmap'ed.
</commit>

Sorry for the confusion,
Ira

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
