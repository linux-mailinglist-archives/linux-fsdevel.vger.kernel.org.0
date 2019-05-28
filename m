Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B17F2C2E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 11:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfE1JRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 05:17:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:47768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbfE1JRb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 05:17:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C7C7AFE1;
        Tue, 28 May 2019 09:17:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B0BBE1E3F53; Tue, 28 May 2019 11:17:29 +0200 (CEST)
Date:   Tue, 28 May 2019 11:17:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-btrfs@vger.kernel.org, kilobyte@angband.pl,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, david@fromorbit.com,
        willy@infradead.org, hch@lst.de, dsterba@suse.cz,
        nborisov@suse.com, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 04/18] dax: Introduce IOMAP_DAX_COW to CoW edges during
 writes
Message-ID: <20190528091729.GD9607@quack2.suse.cz>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-5-rgoldwyn@suse.de>
 <20190521165158.GB5125@magnolia>
 <1e9951c1-d320-e480-3130-dc1f4b81ef2c@cn.fujitsu.com>
 <20190523115109.2o4txdjq2ft7fzzc@fiona>
 <1620c513-4ce2-84b0-33dc-2675246183ea@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620c513-4ce2-84b0-33dc-2675246183ea@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 27-05-19 16:25:41, Shiyang Ruan wrote:
> On 5/23/19 7:51 PM, Goldwyn Rodrigues wrote:
> > > 
> > > Hi,
> > > 
> > > I'm working on reflink & dax in XFS, here are some thoughts on this:
> > > 
> > > As mentioned above: the second iomap's offset and length must match the
> > > first.  I thought so at the beginning, but later found that the only
> > > difference between these two iomaps is @addr.  So, what about adding a
> > > @saddr, which means the source address of COW extent, into the struct iomap.
> > > The ->iomap_begin() fills @saddr if the extent is COW, and 0 if not.  Then
> > > handle this @saddr in each ->actor().  No more modifications in other
> > > functions.
> > 
> > Yes, I started of with the exact idea before being recommended this by Dave.
> > I used two fields instead of one namely cow_pos and cow_addr which defined
> > the source details. I had put it as a iomap flag as opposed to a type
> > which of course did not appeal well.
> > 
> > We may want to use iomaps for cases where two inodes are involved.
> > An example of the other scenario where offset may be different is file
> > comparison for dedup: vfs_dedup_file_range_compare(). However, it would
> > need two inodes in iomap as well.
> > 
> Yes, it is reasonable.  Thanks for your explanation.
> 
> One more thing RFC:
> I'd like to add an end-io callback argument in ->dax_iomap_actor() to update
> the metadata after one whole COW operation is completed.  The end-io can
> also be called in ->iomap_end().  But one COW operation may call
> ->iomap_apply() many times, and so does the end-io.  Thus, I think it would
> be nice to move it to the bottom of ->dax_iomap_actor(), called just once in
> each COW operation.

I'm sorry but I don't follow what you suggest. One COW operation is a call
to dax_iomap_rw(), isn't it? That may call iomap_apply() several times,
each invocation calls ->iomap_begin(), ->actor() (dax_iomap_actor()),
->iomap_end() once. So I don't see a difference between doing something in
->actor() and ->iomap_end() (besides the passed arguments but that does not
seem to be your concern). So what do you exactly want to do?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
