Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7441321B4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 09:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgAGIzI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 03:55:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:56418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgAGIzI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:55:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AB338ACD5;
        Tue,  7 Jan 2020 08:55:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 61F311E0B47; Tue,  7 Jan 2020 09:55:06 +0100 (CET)
Date:   Tue, 7 Jan 2020 09:55:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sitsofe Wheeler <sitsofe@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
        drh@sqlite.org, Jan Kara <jack@suse.cz>
Subject: Re: Questions about filesystems from SQLite author presentation
Message-ID: <20200107085506.GB26849@quack2.suse.cz>
References: <CALjAwxi3ZpRZLS9QaGfAqwAVST0Biyj_p-b22f=iq_ns4ZQyiA@mail.gmail.com>
 <20200106101518.GI23195@dread.disaster.area>
 <CALjAwxgzsZTBBCQYqCBoMeYtMs3jHSqGMBPQ32KrmaQr50dPAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjAwxgzsZTBBCQYqCBoMeYtMs3jHSqGMBPQ32KrmaQr50dPAg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 07-01-20 08:40:00, Sitsofe Wheeler wrote:
> On Mon, 6 Jan 2020 at 10:16, Dave Chinner <david@fromorbit.com> wrote:
> > > today) and even if you wanted to use something like TRIM it wouldn't
> > > be worth it unless you were trimming a large (gigabytes) amount of
> > > data (https://youtu.be/-oP2BOsMpdo?t=6330 ).
> >
> > Punch the space out, then run a periodic background fstrim so the
> > filesystem can issue efficient TRIM commands over free space...
> 
> Jan mentions this over on https://youtu.be/-oP2BOsMpdo?t=6268 .
> Basically he advises against hole punching if you're going to write to
> that area again because it fragments the file, hurts future
> performance etc. But I guess if you were using FALLOC_FL_ZERO_RANGE no
> hole is punched (so no fragmentation) and you likely get faster reads
> of that area until the data is rewritten too.

Yes, no fragmentation in this case (well, there's still the fact that
the extent tree needs to record that a particular range is marked as
unwritten so that will get fragmented but it is merged again as soon as the
range is written).

> Are areas that have had
> FALLOC_FL_ZERO_RANGE run on them eligible for trimming if someone goes
> on to do a background trim (Jan - doesn't this sound like the best of
> both both worlds)?

No, these areas are still allocated for the file and thus background trim
will not touch them. Concievably, we could use trim for such areas but
technically this is going to be too expensive to discover them (you'd need
to read all the inodes and their extent trees to discover them) at least
for ext4 and I belive for xfs as well.

> My question is what happens if you call FALLOC_FL_ZERO_RANGE and your
> filesystem is too dumb to mark extents unwritten - will it literally
> go away and write a bunch of zeros over that region and your disk is a
> slow HDD or will that call just fail? It's almost like you need
> something that can tell you if FALLOC_FL_ZERO_RANGE is efficient...

It is upto the filesystem how it implements the operation but so far we
managed to maintain a situation that FALLOC_FL_ZERO_RANGE returns error if
it is not efficient.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
