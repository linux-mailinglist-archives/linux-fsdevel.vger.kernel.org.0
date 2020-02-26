Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F8D170375
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 16:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgBZP5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 10:57:32 -0500
Received: from mga12.intel.com ([192.55.52.136]:20933 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbgBZP53 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:57:29 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 07:57:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; 
   d="scan'208";a="231443910"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga008.jf.intel.com with ESMTP; 26 Feb 2020 07:57:28 -0800
Date:   Wed, 26 Feb 2020 07:57:28 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 07/13] fs: Add locking for a dynamic address space
 operations state
Message-ID: <20200226155727.GA22036@iweiny-DESK2.sc.intel.com>
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <20200221004134.30599-8-ira.weiny@intel.com>
 <20200221174449.GB11378@lst.de>
 <20200221224419.GW10776@dread.disaster.area>
 <20200224175603.GE7771@lst.de>
 <20200225000937.GA10776@dread.disaster.area>
 <20200226111740.GF10728@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226111740.GF10728@quack2.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 12:17:40PM +0100, Jan Kara wrote:
> On Tue 25-02-20 11:09:37, Dave Chinner wrote:
> > /me wonders if the best thing to do is to add a ->fault callout to
> > tell the filesystem to lock/unlock the inode right up at the top of
> > the page fault path, outside even the mmap_sem.  That means all the
> > methods that the page fault calls are protected against S_DAX
> > changes, and it gives us a low cost method of serialising page
> > faults against DIO (e.g. via inode_dio_wait())....
> 
> Well, that's going to be pretty hard. The main problem is: you cannot
> lookup VMA until you hold mmap_sem and the inode is inside the VMA. And
> this is a fundamental problem because until you hold mmap_sem, the address
> space can change and thus the virtual address you are faulting can be
> changing inode it is mapped to. So you would have to do some dance like:
> 
> lock mmap_sem
> lookup vma
> get inode reference
> drop mmap_sem
> tell fs about page fault
> lock mmap_sem
> is the vma still the same?
> 
> And I'm pretty confident the overhead will be visible in page fault
> intensive workloads...

I did not get to this level of detail...  Rather I looked at it from a high
level perspective and thought "does the mode need to change while someone has
the mmap?"  My thought is, that it does not make a lot of sense.  Generally the
user has mmaped with some use case in mind (either DAX or non-DAX) and it seems
reasonable to keep that mode consistent while the map is in place.

So I punted and restricted the change.

Ira

> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
