Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB73B17CAFC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 03:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCGCch (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 21:32:37 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34521 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726237AbgCGCch (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 21:32:37 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0272WCYq023096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Mar 2020 21:32:12 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3485142045B; Fri,  6 Mar 2020 21:32:12 -0500 (EST)
Date:   Fri, 6 Mar 2020 21:32:12 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        cmaiolino@redhat.com, david@fromorbit.com
Subject: Re: [PATCHv5 3/6] ext4: Move ext4 bmap to use iomap infrastructure.
Message-ID: <20200307023212.GA7845@mit.edu>
References: <cover.1582880246.git.riteshh@linux.ibm.com>
 <8bbd53bd719d5ccfecafcce93f2bf1d7955a44af.1582880246.git.riteshh@linux.ibm.com>
 <20200228152524.GE8036@magnolia>
 <20200302085840.A41E3A4053@d06av23.portsmouth.uk.ibm.com>
 <20200303154709.GB8037@magnolia>
 <20200304124211.GC21048@quack2.suse.cz>
 <20200304153745.GG8036@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304153745.GG8036@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 07:37:45AM -0800, Darrick J. Wong wrote:
> > > This makes me wonder if you still need the filemap_write_and_wait in the
> > > JDATA case because otherwise the journal flush won't have the effect of
> > > writing all the dirty pagecache back to the filesystem?  OTOH I suppose
> > > the implicit write-and-wait call after we clear JDATA will not be
> > > writing to the journal.
> > > 
> > > Even more weirdly, the FIEMAP code doesn't drop JDATA at all...?
> > 
> > Yeah, it should do that but that's only performance optimization so that we
> > bother with journal flushing only when someone uses block mapping call on
> > a file with journalled dirty data. So you can hardly notice the bug by
> > testing...
> 
> If we ever decide to deprecate FIBMAP officially and push bootloaders to
> use FIEMAP, then we'll have to emulate all the flushing behaviors.  But
> that's something for a separate patch.

This is really only needed for LILO, since I believe this is the only
bootloader which uses the output of FIBMAP to determine the block
number where it will attempt to ***write*** into a data block of a
mounted file system.

I seem to recall either Dave or Christoph ranting at one point that
any program which attempted to write into a mounted file system using
the output of FIEMAP was insane, and we should not be encouraging that
kind of wacko behavior.  :-)

What most bootloaders want is simply the accurate list of block
locations so they can write that into the stage 1 bootloader so it can
read the stage 2 bootloader from the disk.  The reason why we have the
JDATA hack in the bmap code is because LILO will get the block
location, and then try to write config information into that block.
So we are trying to prevent LILO's write of the boot command line from
possibly getting rewritten after a journal replay.  (Of course, no
distribution installer would do something as rude as to just forcibly
rebooting the system without a clean unmount, so this would *never* be
a problem, RIGHT?  :-)

In any case, I'd much rather try to get LILO fixed to do something
sane, rather that move that heavy-ugly JDATA code into FIEMAP, where
it might get triggered unnecessarily by 99.9% of the users who are
doing something not-insane.

							- Ted
