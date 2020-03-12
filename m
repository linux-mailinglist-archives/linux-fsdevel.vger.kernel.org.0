Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654981829BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 08:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbgCLH1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 03:27:33 -0400
Received: from verein.lst.de ([213.95.11.211]:35189 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387898AbgCLH1d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 03:27:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A1F4D68B05; Thu, 12 Mar 2020 08:27:29 +0100 (CET)
Date:   Thu, 12 Mar 2020 08:27:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH V5 00/12] Enable per-file/per-directory DAX operations
 V5
Message-ID: <20200312072729.GA9345@lst.de>
References: <20200227052442.22524-1-ira.weiny@intel.com> <20200305155144.GA5598@lst.de> <20200309170437.GA271052@iweiny-DESK2.sc.intel.com> <20200311033614.GQ1752567@magnolia> <20200311063942.GE10776@dread.disaster.area> <20200311064412.GA11819@lst.de> <20200312004932.GH10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312004932.GH10776@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 11:49:32AM +1100, Dave Chinner wrote:
> > > IOWs, the dax_associate_page() related functionality probably needs
> > > to be a filesystem callout - part of the aops vector, I think, so
> > > that device dax can still use it. That way XFS can go it's own way,
> > > while ext4 and device dax can continue to use the existing mechanism
> > > mechanisn that is currently implemented....
> > 
> > s/XFS/XFS with rmap/, as most XFS file systems currently don't have
> > that enabled we'll also need to keep the legacy path around.
> 
> Sure, that's trivially easy to handle in the XFS code once the
> callouts are in place.
> 
> But, quite frankly, we can enforce rmap to be enabled 
> enabled because nobody is using a reflink enabled FS w/ DAX right
> now. Everyone will have to mkfs their filesystems anyway to enable
> reflink+dax, so we simply don't allow reflink+dax to be enabled
> unless rmap is also enabled. Simple, easy, trivial.

True, I think rmap will be required for DAX+reflink.  But we still
need the legacy infrastructure for error reporting.
