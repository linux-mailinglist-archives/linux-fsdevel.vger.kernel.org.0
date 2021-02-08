Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E4A3128DA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 03:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhBHCBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 21:01:14 -0500
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:54405 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhBHCBN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 21:01:13 -0500
Received: from dread.disaster.area (pa49-181-52-82.pa.nsw.optusnet.com.au [49.181.52.82])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id CDDAA1140C21;
        Mon,  8 Feb 2021 13:00:03 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l8vqM-00BtB6-3Z; Mon, 08 Feb 2021 13:00:02 +1100
Date:   Mon, 8 Feb 2021 13:00:02 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Joel Becker <jlbec@evilplan.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH 00/18] new API for FS_IOC_[GS]ETFLAGS/FS_IOC_FS[GS]ETXATTR
Message-ID: <20210208020002.GM4626@dread.disaster.area>
References: <20210203124112.1182614-1-mszeredi@redhat.com>
 <20210203130501.GY308988@casper.infradead.org>
 <CAJfpegs3YWybmH7iKDLQ-KwmGieS1faO1uSZ-ADB0UFYOFPEnQ@mail.gmail.com>
 <20210203135827.GZ308988@casper.infradead.org>
 <CAJfpegvHFHcCPtyJ+w6uRx+hLH9JAT46WJktF_nez-ZZAria7A@mail.gmail.com>
 <20210203142802.GA308988@casper.infradead.org>
 <CAJfpegtW5-XObARX87A8siTJNxTCkzXG=QY5tTRXVUvHXXZn3g@mail.gmail.com>
 <20210203145620.GB308988@casper.infradead.org>
 <CAJfpegvV19DT+nQcW5OiLsGWjnp9-DoLAY16S60PewSLcKLTMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvV19DT+nQcW5OiLsGWjnp9-DoLAY16S60PewSLcKLTMA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=7pwokN52O8ERr2y46pWGmQ==:117 a=7pwokN52O8ERr2y46pWGmQ==:17
        a=kj9zAlcOel0A:10 a=qa6Q16uM49sA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=JXGzyL3g34njaGKGXqwA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 03, 2021 at 04:03:06PM +0100, Miklos Szeredi wrote:
> On Wed, Feb 3, 2021 at 3:56 PM Matthew Wilcox <willy@infradead.org> wrote:
> 
> > But let's talk specifics.  What does CIFS need to contact the server for?
> > Could it be cached earlier?
> 
> I don't understand what CIFS is doing, and I don't really care.   This
> is the sort of operation where adding a couple of network roundtrips
> so that the client can obtain the credentials required to perform the
> operation doesn't really matter.  We won't have thousands of chattr(1)
> calls per second.

Incorrect.

The xfs utilities can do recursive directory traversal to change
things like the project ID across an entire directory tree. Or to
change extent size hints.

We also have 'xfs_io -c "lsattr -R" ...' and 'lsprog -R' which will
do a recursive descent to list the requested attributes of all
directories and files in the tree...

So, yeah, we do indeed do thousands of these fsxattr based
operations a second, sometimes tens of thousands a second or more,
and sometimes they are issued in bulk in performance critical paths
for container build/deployment operations....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
