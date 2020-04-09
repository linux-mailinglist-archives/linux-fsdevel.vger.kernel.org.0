Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F121A3401
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 14:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgDIM3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 08:29:01 -0400
Received: from verein.lst.de ([213.95.11.211]:46513 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDIM3B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:29:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DE2B068C4E; Thu,  9 Apr 2020 14:28:56 +0200 (CEST)
Date:   Thu, 9 Apr 2020 14:28:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 7/8] fs/xfs: Change
 xfs_ioctl_setattr_dax_invalidate() to xfs_ioctl_dax_check()
Message-ID: <20200409122856.GA17929@lst.de>
References: <20200407182958.568475-1-ira.weiny@intel.com> <20200407182958.568475-8-ira.weiny@intel.com> <20200408022318.GJ24067@dread.disaster.area> <20200408095803.GB30172@quack2.suse.cz> <20200408210950.GL24067@dread.disaster.area> <20200408222636.GC664132@iweiny-DESK2.sc.intel.com> <20200408234817.GP24067@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408234817.GP24067@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 09:48:17AM +1000, Dave Chinner wrote:
> > Christoph in particular said that a 'lazy change' is: "... straight from
> > the playbook for arcane and confusing API designs."
> > 
> > 	"But returning an error and doing a lazy change anyway is straight from
> > 	the playbook for arcane and confusing API designs."
> > 
> > 	-- https://lore.kernel.org/lkml/20200403072731.GA24176@lst.de/
> > 
> > Did I somehow misunderstand this?
> 
> Yes. Clearing the on-disk flag successfully should not return an
> error.
> 
> What is wrong is having it clear the flag successfully and returning
> an error because the operation doesn't take immediate effect, then
> having the change take effect later after telling the application
> there was an error.
> 
> That's what Christoph was saying is "straight from the playbook for
> arcane and confusing API designs."

Yes.

> There's absolutely nothing wrong with setting/clearing the on-disk
> flag and having the change take effect some time later depending on
> some external context. We've done this sort of thing for a -long
> time- and it's not XFS specific at all.
> 
> e.g.  changing the on-disk APPEND flag doesn't change the write
> behaviour of currently open files - it only affects the behaviour of
> future file opens. IOWs, we can have the flag set on disk, but we
> can still write randomly to the inode as long as we have a file
> descriptor that was opened before the APPEND on disk flag was set.
> 
> That's exactly the same class of behaviour as we are talking about
> here for the on-disk DAX flag.

Some people consider that a bug, though.  But I don't think we can
change that now.  In general I don't think APIs that don't take
immediate effect are all that great, but in some cases we can live
with them if they are properly documented.  But APIs that return
an error, but actually take effect later anyway are just crazy.
