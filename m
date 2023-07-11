Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D49F74E3F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 04:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjGKCJM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 22:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjGKCJL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 22:09:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA06136;
        Mon, 10 Jul 2023 19:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=XyKenLjvs1L+lR6yAc0FRSo1jPgG5FIXSLMnx1/HtTE=; b=QZeyHjlYsAz1uwu5m3O2fnv+6U
        M+6xODkBKt511Bd7Ng/HPZnpFQ8CmGy+OUB7vnqUzR9KbK12YpqmZf2jIKyrpvmgHc1LU5xQiXjNy
        yN4Lx9sde9VCsZdVCwPOZ1hd9NnVIHY4PBV+yU9N/25vPLp8ceI4y5Hi7Ek3648nK+QcnKtoQPOFY
        R03lKo4esJvGDE0MlrO57icqMX9cC3NcYRzjzDQ6Is0Wyw+KA3jiNnC4kC0dT+fioXHtNYDs1X8yY
        EXM76m2a2O2/4H04sA8NPRpXinLDfEmlScS6V4bt/xVZtPjkvZK4Q9SNbc6BfDDcjNwVMo7N3zJV5
        AiwBPs8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJ2o9-00FCD7-A3; Tue, 11 Jul 2023 02:08:53 +0000
Date:   Tue, 11 Jul 2023 03:08:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [Cluster-devel] gfs2 write bandwidth regression on 6.4-rc3
 compareto 5.15.y
Message-ID: <ZKy5tYed3EiPPZSi@casper.infradead.org>
References: <20230523085929.614A.409509F4@e16-tech.com>
 <20230528235314.7852.409509F4@e16-tech.com>
 <CAHc6FU5YYADEE1m2skcZxOb5fC24JDcJvHtBoq6ZCttB3BhObA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU5YYADEE1m2skcZxOb5fC24JDcJvHtBoq6ZCttB3BhObA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:19:54PM +0200, Andreas Gruenbacher wrote:
> Hi Wang Yugui,
> 
> On Sun, May 28, 2023 at 5:53 PM Wang Yugui <wangyugui@e16-tech.com> wrote:
> > Hi,
> >
> > > Hi,
> > >
> > > gfs2 write bandwidth regression on 6.4-rc3 compare to 5.15.y.
> > >
> > > we added  linux-xfs@ and linux-fsdevel@ because some related problem[1]
> > > and related patches[2].
> > >
> > > we compared 6.4-rc3(rather than 6.1.y) to 5.15.y because some related patches[2]
> > > work only for 6.4 now.
> > >
> > > [1] https://lore.kernel.org/linux-xfs/20230508172406.1CF3.409509F4@e16-tech.com/
> > > [2] https://lore.kernel.org/linux-xfs/20230520163603.1794256-1-willy@infradead.org/
> > >
> > >
> > > test case:
> > > 1) PCIe3 SSD *4 with LVM
> > > 2) gfs2 lock_nolock
> > >     gfs2 attr(T) GFS2_AF_ORLOV
> > >    # chattr +T /mnt/test
> > > 3) fio
> > > fio --name=global --rw=write -bs=1024Ki -size=32Gi -runtime=30 -iodepth 1
> > > -ioengine sync -zero_buffers=1 -direct=0 -end_fsync=1 -numjobs=1 \
> > >       -name write-bandwidth-1 -filename=/mnt/test/sub1/1.txt \
> > >       -name write-bandwidth-2 -filename=/mnt/test/sub2/1.txt \
> > >       -name write-bandwidth-3 -filename=/mnt/test/sub3/1.txt \
> > >       -name write-bandwidth-4 -filename=/mnt/test/sub4/1.txt
> > > 4) patches[2] are applied to 6.4-rc3.
> > >
> > >
> > > 5.15.y result
> > >       fio WRITE: bw=5139MiB/s (5389MB/s),
> > > 6.4-rc3 result
> > >       fio  WRITE: bw=2599MiB/s (2725MB/s)
> >
> > more test result:
> >
> > 5.17.0  WRITE: bw=4988MiB/s (5231MB/s)
> > 5.18.0  WRITE: bw=5165MiB/s (5416MB/s)
> > 5.19.0  WRITE: bw=5511MiB/s (5779MB/s)
> > 6.0.5   WRITE: bw=3055MiB/s (3203MB/s), WRITE: bw=3225MiB/s (3382MB/s)
> > 6.1.30  WRITE: bw=2579MiB/s (2705MB/s)
> >
> > so this regression  happen in some code introduced in 6.0,
> > and maybe some minor regression in 6.1 too?
> 
> thanks for this bug report. Bob has noticed a similar looking
> performance regression recently, and it turned out that commit
> e1fa9ea85ce8 ("gfs2: Stop using glock holder auto-demotion for now")
> inadvertently caused buffered writes to fall back to writing single
> pages instead of multiple pages at once. That patch was added in
> v5.18, so it doesn't perfectly align with the regression history
> you're reporting, but maybe there's something else going on that we're
> not aware of.

Dave gave a good explanation of the problem here:

https://lore.kernel.org/linux-xfs/ZKybxCxzmuI1TFYn@dread.disaster.area/

It's a pagecache locking contention problem rather than an individual
filesystem problem.

... are you interested in supporting large folios in gfs2?  ;-)
