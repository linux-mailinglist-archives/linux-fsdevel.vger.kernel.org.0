Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216A8182657
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 01:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgCLAti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 20:49:38 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:50920 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731423AbgCLAti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:49:38 -0400
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 764693A2A95;
        Thu, 12 Mar 2020 11:49:33 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jCC2W-0005cM-1s; Thu, 12 Mar 2020 11:49:32 +1100
Date:   Thu, 12 Mar 2020 11:49:32 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations V5
Message-ID: <20200312004932.GH10776@dread.disaster.area>
References: <20200227052442.22524-1-ira.weiny@intel.com>
 <20200305155144.GA5598@lst.de>
 <20200309170437.GA271052@iweiny-DESK2.sc.intel.com>
 <20200311033614.GQ1752567@magnolia>
 <20200311063942.GE10776@dread.disaster.area>
 <20200311064412.GA11819@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311064412.GA11819@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=SS2py6AdgQ4A:10
        a=7-415B0cAAAA:8 a=AbD9mO_pjJUxJnZMvogA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 11, 2020 at 07:44:12AM +0100, Christoph Hellwig wrote:
> On Wed, Mar 11, 2020 at 05:39:42PM +1100, Dave Chinner wrote:
> > IOWs, the dax_associate_page() related functionality probably needs
> > to be a filesystem callout - part of the aops vector, I think, so
> > that device dax can still use it. That way XFS can go it's own way,
> > while ext4 and device dax can continue to use the existing mechanism
> > mechanisn that is currently implemented....
> 
> s/XFS/XFS with rmap/, as most XFS file systems currently don't have
> that enabled we'll also need to keep the legacy path around.

Sure, that's trivially easy to handle in the XFS code once the
callouts are in place.

But, quite frankly, we can enforce rmap to be enabled 
enabled because nobody is using a reflink enabled FS w/ DAX right
now. Everyone will have to mkfs their filesystems anyway to enable
reflink+dax, so we simply don't allow reflink+dax to be enabled
unless rmap is also enabled. Simple, easy, trivial.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
