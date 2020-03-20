Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E597018D305
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 16:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCTPfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 11:35:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:34710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgCTPfd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:35:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D2A7DACB5;
        Fri, 20 Mar 2020 15:35:31 +0000 (UTC)
Date:   Fri, 20 Mar 2020 10:35:28 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com, linux-ext4@vger.kernel.org,
        darrick.wong@oracle.com, willy@infradead.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] iomap: return partial I/O count on error in
 iomap_dio_bio_actor
Message-ID: <20200320153528.theulg3fuzmdjhgl@fiona>
References: <20200319150805.uaggnfue5xgaougx@fiona>
 <20200320140538.GA27895@infradead.org>
 <02209ec3-62b4-595f-b84e-2cd8838ac41b@toxicpanda.com>
 <20200320143500.GA16143@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320143500.GA16143@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On  7:35 20/03, Christoph Hellwig wrote:
> On Fri, Mar 20, 2020 at 10:23:43AM -0400, Josef Bacik wrote:
> > I'm not sure what you're looking at specifically wrt error handling, but I
> > can explain __endio_write_update_ordered.
> > 
> > Btrfs has ordered extents to keep track of an extent that currently has IO
> > being done on it.  Generally that IO takes multiple bio's, so we keep track
> > of the outstanding size of the IO being done, and each bio completes and
> > thus removes its size from the pending size.  If any one of those bios has
> > an error we need to make sure we discard the whole ordered extent, as part
> > of it won't be valid. Just a cursory look at the current code I assume
> > that's what's confusing you, we call this when we have an error in the
> > O_DIRECT code.  This is just so we get the proper cleanup for the ordered
> > extent.  People will wait on the ordered extent to be completed, so if we've
> > started an ordered extent and aren't able to complete the range we need to
> > do __endio_write_update_ordered() so that the ordered extent is finished and
> > we wakeup any waiters.
> > 
> > Does this help?  If I need to I can context switch into whatever you're
> > looking at, but I'm going to avoid looking and hope I can just shout useful
> > information in your direction ;).  Thanks,
> 
> Yes, this helps a lot.  This is about the patches from Goldwyn to
> convert btrfs to use the iomap direct I/O code.  And in that series
> he currently calls __endio_write_update_ordered from the ->iomap_end
> method, which for direct I/O is called after all bios are submitted
> to complete ordered extents for a range after an I/O error, that
> is one that no I/O has been submitted to, and the accounting for that
> is a little complicated..

I think you meant "some" instead of "no".

Yes, keeping the information in iomap->private and setting in
btrfs_submit_direct() would be better. I will modify the code and
re-test. Thanks!

-- 
Goldwyn
