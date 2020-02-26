Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5112916F5D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 03:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgBZCzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 21:55:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:53696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbgBZCzh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:55:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D474AAC4A;
        Wed, 26 Feb 2020 02:55:35 +0000 (UTC)
Date:   Tue, 25 Feb 2020 20:55:31 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com
Subject: Re: [PATCH v2] iomap: return partial I/O count on error in
 iomap_dio_bio_actor
Message-ID: <20200226025531.k7miaxfu2yzt3kh6@fiona>
References: <20200220152355.5ticlkptc7kwrifz@fiona>
 <20200221045110.612705204E@d06av21.portsmouth.uk.ibm.com>
 <20200225205342.GA12066@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225205342.GA12066@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12:53 25/02, Christoph Hellwig wrote:
> On Fri, Feb 21, 2020 at 10:21:04AM +0530, Ritesh Harjani wrote:
> > >   		if (dio->error) {
> > >   			iov_iter_revert(dio->submit.iter, copied);
> > > -			copied = ret = 0;
> > > +			ret = 0;
> > >   			goto out;
> > >   		}
> > 
> > But if I am seeing this correctly, even after there was a dio->error
> > if you return copied > 0, then the loop in iomap_dio_rw will continue
> > for next iteration as well. Until the second time it won't copy
> > anything since dio->error is set and from there I guess it may return
> > 0 which will break the loop.
> 
> In addition to that copied is also iov_iter_reexpand call.  We don't
> really need the re-expand in case of errors, and in fact we also
> have the iov_iter_revert call before jumping out, so this will
> need a little bit more of an audit and properly documented in the
> commit log.
> 
> > 
> > Is this the correct flow? Shouldn't the while loop doing
> > iomap_apply in iomap_dio_rw should also break in case of
> > dio->error? Or did I miss anything?
> 
> We'd need something there iff we care about a good number of written
> in case of the error.  Goldwyn, can you explain what you need this
> number for in btrfs?  Maybe with a pointer to the current code base?

btrfs needs to account for the bytes "processed", failed or
uptodate. This is currently performed in
fs/btrfs/inode.c:__end_write_update_ordered().

For the current development version, how I am using it is in my git
branch btrfs-iomap-dio [1]. The related commit besides this patch
is:

9aeb2b31d10b ("btrfs: Use ->iomap_end() instead of btrfs_dio_data")

[1] https://github.com/goldwynr/linux/tree/btrfs-iomap-dio

-- 
Goldwyn
