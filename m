Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3306B1B32FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 01:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgDUXQM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 19:16:12 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57798 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726039AbgDUXQL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 19:16:11 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03LNFr6S004708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 19:15:54 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 78DCE42030C; Tue, 21 Apr 2020 19:15:53 -0400 (EDT)
Date:   Tue, 21 Apr 2020 19:15:53 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        bugzilla-daemon@bugzilla.kernel.org, linux-ext4@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [Bug 207367] Accraid / aptec / Microsemi / ext4 / larger then
 16TB
Message-ID: <20200421231553.GB4278@mit.edu>
References: <bug-207367-13602@https.bugzilla.kernel.org/>
 <bug-207367-13602-zdl9QZH6DN@https.bugzilla.kernel.org/>
 <20200421042039.BF8074C046@d06av22.portsmouth.uk.ibm.com>
 <20200421050850.GB27860@dread.disaster.area>
 <20200421080405.GA4149@infradead.org>
 <20200421162910.GB5118@quack2.suse.cz>
 <20200421164554.GA3271@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421164554.GA3271@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 09:45:54AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 21, 2020 at 06:29:10PM +0200, Jan Kara wrote:
> > Well, there are two problems with this - firstly, ocfs2 is also using jbd2
> > and it knows nothing about iomap. So that would have to be implemented.
> > Secondly, you have to somehow pass iomap ops to jbd2 so it all boils down
> > to passing some callback to jbd2 during journal init to map blocks anyway
> > as Dave said. And then it is upto filesystem to do the mapping - usually
> > directly using its internal block mapping function - so no need for iomap
> > AFAICT.
> 
> You'll need to describe the mapping some how.  So why not reuse an
> existing mechanism instead of creating a new ad-hoc one?

Well, we could argue that bmap() is an "existing mechanism" --- again,
bmap() returns a u64, so it's perfectly fine.  It's FIBMAP which is
"fundamentally broken", not bmap().  If the goal is to eventually
eliminate bmap() and aops->bmap(), sure, then we should force march
all file systems to use iomap_bmap(), including ocfs2.

Otherwise, if the goal alert users of FIBMAP when it's returning an
corrutped block number, why not move the check if the block is larger
than INT_MAX to ioctl_fibmap() in fs/ioctl.c, instead of in
iomap_bmap()?

If we can't fix this, I'm beginning to think that switching to iomap
for fiemap and bmap is actually a lose for ext4.  It's causing
performance regressions, and now we see it's causing functionality
regressions.  Sure, it's saving a bit of code size, but is it really
worth it to use iomap for fiemap/bmap?

						- Ted
