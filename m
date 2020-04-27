Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36741B94D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 03:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgD0BEw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 21:04:52 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:44681 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbgD0BEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 21:04:52 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 135283A48CB;
        Mon, 27 Apr 2020 11:04:45 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jSsCS-0000xz-SL; Mon, 27 Apr 2020 11:04:44 +1000
Date:   Mon, 27 Apr 2020 11:04:44 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] fibmap: Warn and return an error in case of block >
 INT_MAX
Message-ID: <20200427010444.GF2040@dread.disaster.area>
References: <cover.1587670914.git.riteshh@linux.ibm.com>
 <e34d1ac05d29aeeb982713a807345a0aaafc7fe0.1587670914.git.riteshh@linux.ibm.com>
 <20200424191739.GA217280@gmail.com>
 <20200424225425.6521D4C040@d06av22.portsmouth.uk.ibm.com>
 <20200424234058.GA29705@bombadil.infradead.org>
 <20200424234647.GX6749@magnolia>
 <20200425070335.B43334C046@d06av22.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425070335.B43334C046@d06av22.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10 a=7-415B0cAAAA:8
        a=XPaiuk4yifFrNG777nsA:9 a=DN0oiWT_x0Zc_wvr:21 a=PPZh3J10_SXtonLC:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 25, 2020 at 12:33:34PM +0530, Ritesh Harjani wrote:
> 
> 
> On 4/25/20 5:16 AM, Darrick J. Wong wrote:
> > On Fri, Apr 24, 2020 at 04:40:58PM -0700, Matthew Wilcox wrote:
> > > On Sat, Apr 25, 2020 at 04:24:24AM +0530, Ritesh Harjani wrote:
> > > > Ok, I see.
> > > > Let me replace WARN() with below pr_warn() line then. If no objections,
> > > > then will send this in a v2 with both patches combined as Darrick
> > > > suggested. - (with Reviewed-by tags of Jan & Christoph).
> > > > 
> > > > pr_warn("fibmap: this would truncate fibmap result\n");
> > > 
> > > We generally don't like userspace to be able to trigger kernel messages
> > > on demand, so they can't swamp the logfiles.  printk_ratelimited()?
> > 
> > Or WARN_ON_ONCE...
> 
> So, Eric was mentioning WARN_** are mostly for kernel side of bugs.
> But this is mostly a API fault which affects user side and also to
> warn the user about the possible truncation in the block fibmap
> addr.
> Also WARN_ON_ONCE, will be shown only once and won't be printed for
> every other file for which block addr > INT_MAX.
> 
> I think we could go with below. If ok, I could post this in v2.
> 
> pr_warn_ratelimited("fibmap: would truncate fibmap result\n");

Please include the process ID, the superblock ID and the task name
that is triggering this warning. Otherwise the administrator will
have no clue what is generating it and so won't be able to fix it...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
