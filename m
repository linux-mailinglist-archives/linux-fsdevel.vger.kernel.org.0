Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 194F01429CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 12:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgATLsA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 06:48:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:59634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbgATLsA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:48:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 74F4BB3CC;
        Mon, 20 Jan 2020 11:47:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BF0761E0CF1; Mon, 20 Jan 2020 12:47:57 +0100 (CET)
Date:   Mon, 20 Jan 2020 12:47:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-xfs <linux-xfs@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Boaz Harrosh <boaz@plexistor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 0/3 v2] xfs: Fix races between readahead and hole punching
Message-ID: <20200120114757.GF19861@quack2.suse.cz>
References: <20190829131034.10563-1-jack@suse.cz>
 <CAOQ4uxiDqtpsH_Ot5N+Avq0h5MBXsXwgDdNbdRC0QDZ-e+zefg@mail.gmail.com>
 <CAOQ4uxgP_32c6QLh2cZXXs7yJ6e8MRR=yfEBjpv02FeC_HpKhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgP_32c6QLh2cZXXs7yJ6e8MRR=yfEBjpv02FeC_HpKhg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 19-01-20 10:35:08, Amir Goldstein wrote:
> On Fri, Jan 17, 2020 at 12:50 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, Aug 29, 2019 at 4:10 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > Hello,
> > >
> > > this is a patch series that addresses a possible race between readahead and
> > > hole punching Amir has discovered [1]. The first patch makes madvise(2) to
> > > handle readahead requests through fadvise infrastructure, the third patch
> > > then adds necessary locking to XFS to protect against the race. Note that
> > > other filesystems need similar protections but e.g. in case of ext4 it isn't
> > > so simple without seriously regressing mixed rw workload performance so
> > > I'm pushing just xfs fix at this moment which is simple.
> > >
> >
> > Jan,
> >
> > Could you give a quick status update about the state of this issue for
> > ext4 and other fs. I remember some solutions were discussed.
> > Perhaps this could be a good topic for a cross track session in LSF/MM?
> > Aren't the challenges posed by this race also relevant for RWF_UNCACHED?
> >
> 
> Maybe a silly question:
> 
> Can someone please explain to me why we even bother truncating pages on
> punch hole?
> Wouldn't it solve the race if instead we zeroed those pages and marked them
> readonly?

Not if we also didn't keep them locked. Page reclaim can reclaim clean
unlocked pages any time it wants... Plus the CPU overhead of zeroing
potentially large ranges of pages would be significant.

> The comment above trunacte_pagecache_range() says:
>  * This function should typically be called before the filesystem
>  * releases resources associated with the freed range (eg. deallocates
>  * blocks). This way, pagecache will always stay logically coherent
>  * with on-disk format, and the filesystem would not have to deal with
>  * situations such as writepage being called for a page that has already
>  * had its underlying blocks deallocated.
> 
> So in order to prevent writepage from being called on a punched hole,
> we need to make sure that page write fault will be called, which is the same
> state as if an exiting hole has been read into page cache but not written yet.
> Right? Wrong?

Also the writeback in the comment you mention above is just an example. As
the race you've found shows, there is a problem with reading as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
