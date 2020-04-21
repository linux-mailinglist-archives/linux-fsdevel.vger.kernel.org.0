Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856D51B2CA5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 18:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgDUQ3N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 12:29:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:36772 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgDUQ3N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:29:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E83F7AAB2;
        Tue, 21 Apr 2020 16:29:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AF1001E0E57; Tue, 21 Apr 2020 18:29:10 +0200 (CEST)
Date:   Tue, 21 Apr 2020 18:29:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        bugzilla-daemon@bugzilla.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [Bug 207367] Accraid / aptec / Microsemi / ext4 / larger then
 16TB
Message-ID: <20200421162910.GB5118@quack2.suse.cz>
References: <bug-207367-13602@https.bugzilla.kernel.org/>
 <bug-207367-13602-zdl9QZH6DN@https.bugzilla.kernel.org/>
 <20200421042039.BF8074C046@d06av22.portsmouth.uk.ibm.com>
 <20200421050850.GB27860@dread.disaster.area>
 <20200421080405.GA4149@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421080405.GA4149@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 21-04-20 01:04:05, Christoph Hellwig wrote:
> On Tue, Apr 21, 2020 at 03:08:50PM +1000, Dave Chinner wrote:
> > > 4. fs/jbd2/journal.c
> > 
> > Broken on filesystems where the journal file might be placed beyond
> > a 32 bit block number, iomap_bmap() just makes that obvious. Needs
> > fixing.
> 
> I think this wants to use iomap, as that would solve all the problems.

Well, there are two problems with this - firstly, ocfs2 is also using jbd2
and it knows nothing about iomap. So that would have to be implemented.
Secondly, you have to somehow pass iomap ops to jbd2 so it all boils down
to passing some callback to jbd2 during journal init to map blocks anyway
as Dave said. And then it is upto filesystem to do the mapping - usually
directly using its internal block mapping function - so no need for iomap
AFAICT.
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
