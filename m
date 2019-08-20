Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5C4953E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 03:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfHTB4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 21:56:25 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3942 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728647AbfHTB4Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 21:56:25 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id C61FAB30F28E0AFC2348;
        Tue, 20 Aug 2019 09:56:21 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 20 Aug 2019 09:56:21 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 20 Aug 2019 09:56:20 +0800
Date:   Tue, 20 Aug 2019 09:55:41 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Gao Xiang <hsiangkao@aol.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        "Richard Weinberger" <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>, Chao Yu <yuchao0@huawei.com>,
        Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.cz>, Miao Xie <miaoxie@huawei.com>,
        devel <devel@driverdev.osuosl.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-erofs <linux-erofs@lists.ozlabs.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Jaegeuk Kim" <jaegeuk@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Li Guifu" <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, "Pavel Machek" <pavel@denx.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190820015541.GA159846@architecture4>
References: <20190818155812.GB13230@infradead.org>
 <20190818161638.GE1118@sol.localdomain>
 <20190818162201.GA16269@infradead.org>
 <20190818172938.GA14413@sol.localdomain>
 <20190818174702.GA17633@infradead.org>
 <20190818181654.GA1617@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190818201405.GA27398@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190819160923.GG15198@magnolia>
 <20190819203051.GA10075@hsiangkao-HP-ZHAN-66-Pro-G1>
 <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bdb91cbf-985b-5a2c-6019-560b79739431@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Qu,

On Tue, Aug 20, 2019 at 08:55:32AM +0800, Qu Wenruo wrote:
> [...]
> >>> I have made a simple fuzzer to inject messy in inode metadata,
> >>> dir data, compressed indexes and super block,
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/commit/?h=experimental-fuzzer
> >>>
> >>> I am testing with some given dirs and the following script.
> >>> Does it look reasonable?
> >>>
> >>> # !/bin/bash
> >>>
> >>> mkdir -p mntdir
> >>>
> >>> for ((i=0; i<1000; ++i)); do
> >>> 	mkfs/mkfs.erofs -F$i testdir_fsl.fuzz.img testdir_fsl > /dev/null 2>&1
> >>
> >> mkfs fuzzes the image? Er....
> > 
> > Thanks for your reply.
> > 
> > First, This is just the first step of erofs fuzzer I wrote yesterday night...
> > 
> >>
> >> Over in XFS land we have an xfs debugging tool (xfs_db) that knows how
> >> to dump (and write!) most every field of every metadata type.  This
> >> makes it fairly easy to write systematic level 0 fuzzing tests that
> >> check how well the filesystem reacts to garbage data (zeroing,
> >> randomizing, oneing, adding and subtracting small integers) in a field.
> >> (It also knows how to trash entire blocks.)
> 
> The same tool exists for btrfs, although lacks the write ability, but
> that dump is more comprehensive and a great tool to learn the on-disk
> format.
> 
> 
> And for the fuzzing defending part, just a few kernel releases ago,
> there is none for btrfs, and now we have a full static verification
> layer to cover (almost) all on-disk data at read and write time.
> (Along with enhanced runtime check)
> 
> We have covered from vague values inside tree blocks and invalid/missing
> cross-ref find at runtime.
> 
> Currently the two layered check works pretty fine (well, sometimes too
> good to detect older, improper behaved kernel).
> - Tree blocks with vague data just get rejected by verification layer
>   So that all members should fit on-disk format, from alignment to
>   generation to inode mode.
> 
>   The error will trigger a good enough (TM) error message for developer
>   to read, and if we have other copies, we retry other copies just as
>   we hit a bad copy.
> 
> - At runtime, we have much less to check
>   Only cross-ref related things can be wrong now. since everything
>   inside a single tree block has already be checked.
> 
> In fact, from my respect of view, such read time check should be there
> from the very beginning.
> It acts kinda of a on-disk format spec. (In fact, by implementing the
> verification layer itself, it already exposes a lot of btrfs design
> trade-offs)
> 
> Even for a fs as complex (buggy) as btrfs, we only take 1K lines to
> implement the verification layer.
> So I'd like to see every new mainlined fs to have such ability.

It's already on our schedule, but we have limited manpower. Rome was
not built in a day, as I mentioned eariler, we are doing our best.

In principle, all the new Linux features on-disk can build their
debugging tools, not only for file systems. You can hardly let your
newborn baby go to university immediately.

We're developping out of our interests for Linux community (our
high level bosses care nothing except for money, you know) and
we hope to better join in and contribute to Linux community, we need
more time to enrich our eco-system in our spare time.

All HUAWEI smartphone products will continue using this filesystem,
and its performance and stability is proven by our 10+ millions
products, and maintaining this filesystem is one of our paid jobs.

> 
> > 
> > Actually, compared with XFS, EROFS has rather simple on-disk format.
> > What we inject one time is quite deterministic.
> > 
> > The first step just purposely writes some random fuzzed data to
> > the base inode metadata, compressed indexes, or dir data field
> > (one round one field) to make it validity and coverability.
> > 
> >>
> >> You might want to write such a debugging tool for erofs so that you can
> >> take apart crashed images to get a better idea of what went wrong, and
> >> to write easy fuzzing tests.
> > 
> > Yes, we will do such a debugging tool of course. Actually Li Guifu is now
> > developping a erofs-fuse to support old linux versions or other OSes for
> > archiveing only use, we will base on that code to develop a better fuzzer
> > tool as well.
> 
> Personally speaking, debugging tool is way more important than a running
> kernel module/fuse.
> It's human trying to write the code, most of time is spent educating
> code readers, thus debugging tool is way more important than dead cold code.

Debugging tools and erofs-fuse share common code, that is to parse
the filesystem. That was the main point that I want to say.

Thanks,
Gao Xiang

> 
> Thanks,
> Qu
> > 
> > Thanks,
> > Gao Xiang
> > 
> >>
> >> --D
> >>
> >>> 	umount mntdir
> >>> 	mount -t erofs -o loop testdir_fsl.fuzz.img mntdir
> >>> 	for j in `find mntdir -type f`; do
> >>> 		md5sum $j > /dev/null
> >>> 	done
> >>> done
> >>>
> >>> Thanks,
> >>> Gao Xiang
> >>>
> >>>>
> >>>> Thanks,
> >>>> Gao Xiang
> >>>>
> 



