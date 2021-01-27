Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9723A30569A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 10:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhA0JPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 04:15:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:58202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234658AbhA0JNY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:13:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E08A1AD78;
        Wed, 27 Jan 2021 09:12:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A78BE1E14C5; Wed, 27 Jan 2021 10:12:37 +0100 (CET)
Date:   Wed, 27 Jan 2021 10:12:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, Maxim Levitsky <mlevitsk@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] bdev: Do not return EBUSY if bdev discard races with
 write
Message-ID: <20210127091237.GA3108@quack2.suse.cz>
References: <20210107154034.1490-1-jack@suse.cz>
 <20210126100215.GA10966@quack2.suse.cz>
 <29be3d51-43b4-b4eb-66e0-669c517ed830@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29be3d51-43b4-b4eb-66e0-669c517ed830@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-01-21 10:22:56, Jens Axboe wrote:
> On 1/26/21 3:02 AM, Jan Kara wrote:
> > On Thu 07-01-21 16:40:34, Jan Kara wrote:
> >> blkdev_fallocate() tries to detect whether a discard raced with an
> >> overlapping write by calling invalidate_inode_pages2_range(). However
> >> this check can give both false negatives (when writing using direct IO
> >> or when writeback already writes out the written pagecache range) and
> >> false positives (when write is not actually overlapping but ends in the
> >> same page when blocksize < pagesize). This actually causes issues for
> >> qemu which is getting confused by EBUSY errors.
> >>
> >> Fix the problem by removing this conflicting write detection since it is
> >> inherently racy and thus of little use anyway.
> >>
> >> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> >> CC: "Darrick J. Wong" <darrick.wong@oracle.com>
> >> Link: https://lore.kernel.org/qemu-devel/20201111153913.41840-1-mlevitsk@redhat.com
> >> Signed-off-by: Jan Kara <jack@suse.cz>
> > 
> > Jens, can you please pick up this patch? Thanks!
> 
> Picked it up for 5.12, hope that works. It looks simple enough but not
> really meeting criteria for 5.11 at this point.

Sure, 5.12 is fine. We've been living with the current behavior for quite
some time and not many people complained...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
