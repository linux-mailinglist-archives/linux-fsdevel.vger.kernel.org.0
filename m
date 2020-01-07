Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4D391321A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 09:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgAGIrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 03:47:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:53468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgAGIrZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:47:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DDBEAADCF;
        Tue,  7 Jan 2020 08:47:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5454F1E0B47; Tue,  7 Jan 2020 09:47:23 +0100 (CET)
Date:   Tue, 7 Jan 2020 09:47:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Sitsofe Wheeler <sitsofe@gmail.com>, linux-fsdevel@vger.kernel.org,
        drh@sqlite.org
Subject: Re: Questions about filesystems from SQLite author presentation
Message-ID: <20200107084723.GA26849@quack2.suse.cz>
References: <CALjAwxi3ZpRZLS9QaGfAqwAVST0Biyj_p-b22f=iq_ns4ZQyiA@mail.gmail.com>
 <20200106101518.GI23195@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106101518.GI23195@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 06-01-20 21:15:18, Dave Chinner wrote:
> On Mon, Jan 06, 2020 at 07:24:53AM +0000, Sitsofe Wheeler wrote:
> > For 3. it sounded like Jan Kara was saying there wasn't anything at
> > the moment (hypothetically you could introduce a call that marked the
> > extents as "unwritten" but it doesn't sound like you can do that
> 
> You can do that with fallocate() - FALLOC_FL_ZERO_RANGE will mark
> the unused range as unwritten in XFS, or you can just punch a hole
> to free the unused space with FALLOC_FL_PUNCH_HOLE...

Yes, this works for ext4 the same way.

> > today) and even if you wanted to use something like TRIM it wouldn't
> > be worth it unless you were trimming a large (gigabytes) amount of
> > data (https://youtu.be/-oP2BOsMpdo?t=6330 ).
> 
> Punch the space out, then run a periodic background fstrim so the
> filesystem can issue efficient TRIM commands over free space...

Yes, in that particular case Richard was mentioning with Sqlite, he was
asking about a situation where he has a DB file which has 64k free here,
256k free there and whether it helps the OS in any way to tell that these
areas are free (but will likely get reused in the future). And in this case
I told him that punching out the free space is going to do more harm than
good (due to fragmentation) and using FALLOC_FL_ZERO_RANGE isn't going to
bring any benefit to the filesystem or the storage. He was also wondering
whether using TRIM for these free areas on disk is useful and I told him
that for current devices I don't think it will bring any benefit with the
sizes he is talking about.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
