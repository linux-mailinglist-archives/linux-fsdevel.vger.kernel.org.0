Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 226AC16FD4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 12:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgBZLRn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 06:17:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:58540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgBZLRn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:17:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4917FACCE;
        Wed, 26 Feb 2020 11:17:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9D3F61E0EA2; Wed, 26 Feb 2020 12:17:40 +0100 (CET)
Date:   Wed, 26 Feb 2020 12:17:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>, ira.weiny@intel.com,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 07/13] fs: Add locking for a dynamic address space
 operations state
Message-ID: <20200226111740.GF10728@quack2.suse.cz>
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <20200221004134.30599-8-ira.weiny@intel.com>
 <20200221174449.GB11378@lst.de>
 <20200221224419.GW10776@dread.disaster.area>
 <20200224175603.GE7771@lst.de>
 <20200225000937.GA10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225000937.GA10776@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 25-02-20 11:09:37, Dave Chinner wrote:
> /me wonders if the best thing to do is to add a ->fault callout to
> tell the filesystem to lock/unlock the inode right up at the top of
> the page fault path, outside even the mmap_sem.  That means all the
> methods that the page fault calls are protected against S_DAX
> changes, and it gives us a low cost method of serialising page
> faults against DIO (e.g. via inode_dio_wait())....

Well, that's going to be pretty hard. The main problem is: you cannot
lookup VMA until you hold mmap_sem and the inode is inside the VMA. And
this is a fundamental problem because until you hold mmap_sem, the address
space can change and thus the virtual address you are faulting can be
changing inode it is mapped to. So you would have to do some dance like:

lock mmap_sem
lookup vma
get inode reference
drop mmap_sem
tell fs about page fault
lock mmap_sem
is the vma still the same?

And I'm pretty confident the overhead will be visible in page fault
intensive workloads...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
