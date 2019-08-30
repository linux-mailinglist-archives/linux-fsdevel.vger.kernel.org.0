Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215E1A2DFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 06:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfH3EKu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 00:10:50 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:45494 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725648AbfH3EKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 00:10:50 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 57F2D36124F;
        Fri, 30 Aug 2019 14:10:44 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i3YFG-0003Gk-Ja; Fri, 30 Aug 2019 14:10:42 +1000
Date:   Fri, 30 Aug 2019 14:10:42 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Boaz Harrosh <boaz@plexistor.com>,
        Kai =?iso-8859-1?Q?M=E4kisara_=28Kolumbus=29?= 
        <kai.makisara@kolumbus.fi>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC] Re: broken userland ABI in configfs binary attributes
Message-ID: <20190830041042.GB7777@dread.disaster.area>
References: <20190826024838.GN1131@ZenIV.linux.org.uk>
 <20190826162949.GA9980@ZenIV.linux.org.uk>
 <B35B5EA9-939C-49F5-BF65-491D70BCA8D4@kolumbus.fi>
 <20190826193210.GP1131@ZenIV.linux.org.uk>
 <b362af55-4f45-bf29-9bc4-dd64e6b04688@plexistor.com>
 <20190827172734.GS1131@ZenIV.linux.org.uk>
 <20190829222258.GA16625@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829222258.GA16625@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=N2kktmuLRUS6YMNfu2cA:9 a=5YWUSbzEL5tuTBhT:21
        a=7ahwL-F6K2TBhvZj:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 11:22:58PM +0100, Al Viro wrote:
> On Tue, Aug 27, 2019 at 06:27:35PM +0100, Al Viro wrote:
> 
> > Most of them are actually pure bollocks - "it can never happen, but if it does,
> > let's return -EWHATEVER to feel better".  Some are crap like -EINTR, which is
> > also bollocks - for one thing, process might've been closing files precisely
> > because it's been hit by SIGKILL.  For another, it's a destructor.  It won't
> > be retried by the caller - there's nothing called for that object afterwards.
> > What you don't do in it won't be done at all.
> > 
> > And some are "commit on final close" kind of thing, both with the hardware
> > errors and parsing errors.
> 
> FWIW, here's the picture for fs/*: 6 instances.
> 
> afs_release():
> 	 calls vfs_fsync() if file had been opened for write, tries to pass
> 	the return value to caller.  Job for ->flush(), AFAICS.
> 
> coda_psdev_release():
> 	returns -1 in situation impossible after successful ->open().
> 	Can't happen without memory corruption.
> 
> configfs_release_bin_file():
> 	discussed upthread
> 
> dlm device_close():
> 	returns -ENOENT if dlm_find_lockspace_local(proc->lockspace) fails.
> No idea if that can happen.
> 
> reiserfs_file_release():
> 	tries to return an error if it can't free preallocated blocks.
> 
> xfs_release():
> 	similar to the previous case.

Not quite right. XFS only returns an error if there is data
writeback failure or filesystem corruption or shutdown detected
during whatever operation it is performing.

We don't really care what is done with the error that we return;
we're just returning an error because that's what the function
prototype indicates we should do...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
