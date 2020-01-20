Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A36142A01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 13:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgATMDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 07:03:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:40058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgATMDl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:03:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5D6BAAC24;
        Mon, 20 Jan 2020 12:03:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AF8751E0CF1; Mon, 20 Jan 2020 13:03:33 +0100 (CET)
Date:   Mon, 20 Jan 2020 13:03:33 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-xfs <linux-xfs@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Boaz Harrosh <boaz@plexistor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/3 v2] xfs: Fix races between readahead and hole punching
Message-ID: <20200120120333.GG19861@quack2.suse.cz>
References: <20190829131034.10563-1-jack@suse.cz>
 <CAOQ4uxiDqtpsH_Ot5N+Avq0h5MBXsXwgDdNbdRC0QDZ-e+zefg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiDqtpsH_Ot5N+Avq0h5MBXsXwgDdNbdRC0QDZ-e+zefg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Fri 17-01-20 12:50:58, Amir Goldstein wrote:
> On Thu, Aug 29, 2019 at 4:10 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello,
> >
> > this is a patch series that addresses a possible race between readahead and
> > hole punching Amir has discovered [1]. The first patch makes madvise(2) to
> > handle readahead requests through fadvise infrastructure, the third patch
> > then adds necessary locking to XFS to protect against the race. Note that
> > other filesystems need similar protections but e.g. in case of ext4 it isn't
> > so simple without seriously regressing mixed rw workload performance so
> > I'm pushing just xfs fix at this moment which is simple.
> >
> 
> Could you give a quick status update about the state of this issue for
> ext4 and other fs. I remember some solutions were discussed.

Shortly: I didn't get to this. I'm sorry :-|. I'll bump up a priority but I
can't promise anything at the moment.

> Perhaps this could be a good topic for a cross track session in LSF/MM?

Maybe although this is one of the cases where it's easy to chat about
possible solutions but somewhat tedious to write one so I'm not sure how
productive that would be. BTW my discussion with Kent [1] is in fact very
related to this problem (the interval lock he has is to stop exactly races
like this).

> Aren't the challenges posed by this race also relevant for RWF_UNCACHED?

Do you have anything particular in mind? I don't see how RWF_UNCACHED would
make this any better or worse than DIO / readahead...

								Honza

[1] https://lore.kernel.org/linux-fsdevel/20191216193852.GA8664@kmo-pixel/
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
