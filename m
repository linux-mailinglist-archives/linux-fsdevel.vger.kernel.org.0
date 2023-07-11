Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC3974E3CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 03:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGKB7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 21:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjGKB7H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:59:07 -0400
Received: from out28-78.mail.aliyun.com (out28-78.mail.aliyun.com [115.124.28.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A7994;
        Mon, 10 Jul 2023 18:59:05 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1186628|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0158702-0.000342115-0.983788;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.Tqe65Uz_1689040731;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Tqe65Uz_1689040731)
          by smtp.aliyun-inc.com;
          Tue, 11 Jul 2023 09:58:58 +0800
Date:   Tue, 11 Jul 2023 09:58:59 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [Cluster-devel] gfs2 write bandwidth regression on 6.4-rc3 compareto 5.15.y
Cc:     Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
In-Reply-To: <20230711085830.FA1E.409509F4@e16-tech.com>
References: <CAHc6FU5YYADEE1m2skcZxOb5fC24JDcJvHtBoq6ZCttB3BhObA@mail.gmail.com> <20230711085830.FA1E.409509F4@e16-tech.com>
Message-Id: <20230711095850.2CD4.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

> Hi,
> 
> > Hi Wang Yugui,
> > 
> > On Sun, May 28, 2023 at 5:53?PM Wang Yugui <wangyugui@e16-tech.com> wrote:
> > > Hi,
> > >
> > > > Hi,
> > > >
> > > > gfs2 write bandwidth regression on 6.4-rc3 compare to 5.15.y.
> > > >
> > > > we added  linux-xfs@ and linux-fsdevel@ because some related problem[1]
> > > > and related patches[2].
> > > >
> > > > we compared 6.4-rc3(rather than 6.1.y) to 5.15.y because some related patches[2]
> > > > work only for 6.4 now.
> > > >
> > > > [1] https://lore.kernel.org/linux-xfs/20230508172406.1CF3.409509F4@e16-tech.com/
> > > > [2] https://lore.kernel.org/linux-xfs/20230520163603.1794256-1-willy@infradead.org/
> > > >
> > > >
> > > > test case:
> > > > 1) PCIe3 SSD *4 with LVM
> > > > 2) gfs2 lock_nolock
> > > >     gfs2 attr(T) GFS2_AF_ORLOV
> > > >    # chattr +T /mnt/test
> > > > 3) fio
> > > > fio --name=global --rw=write -bs=1024Ki -size=32Gi -runtime=30 -iodepth 1
> > > > -ioengine sync -zero_buffers=1 -direct=0 -end_fsync=1 -numjobs=1 \
> > > >       -name write-bandwidth-1 -filename=/mnt/test/sub1/1.txt \
> > > >       -name write-bandwidth-2 -filename=/mnt/test/sub2/1.txt \
> > > >       -name write-bandwidth-3 -filename=/mnt/test/sub3/1.txt \
> > > >       -name write-bandwidth-4 -filename=/mnt/test/sub4/1.txt
> > > > 4) patches[2] are applied to 6.4-rc3.
> > > >
> > > >
> > > > 5.15.y result
> > > >       fio WRITE: bw=5139MiB/s (5389MB/s),
> > > > 6.4-rc3 result
> > > >       fio  WRITE: bw=2599MiB/s (2725MB/s)
> > >
> > > more test result:
> > >
> > > 5.17.0  WRITE: bw=4988MiB/s (5231MB/s)
> > > 5.18.0  WRITE: bw=5165MiB/s (5416MB/s)
> > > 5.19.0  WRITE: bw=5511MiB/s (5779MB/s)
> > > 6.0.5   WRITE: bw=3055MiB/s (3203MB/s), WRITE: bw=3225MiB/s (3382MB/s)
> > > 6.1.30  WRITE: bw=2579MiB/s (2705MB/s)
> > >
> > > so this regression  happen in some code introduced in 6.0,
> > > and maybe some minor regression in 6.1 too?
> > 
> > thanks for this bug report. Bob has noticed a similar looking
> > performance regression recently, and it turned out that commit
> > e1fa9ea85ce8 ("gfs2: Stop using glock holder auto-demotion for now")
> > inadvertently caused buffered writes to fall back to writing single
> > pages instead of multiple pages at once. That patch was added in
> > v5.18, so it doesn't perfectly align with the regression history
> > you're reporting, but maybe there's something else going on that we're
> > not aware of.
> > 
> > In any case, the regression introduced by commit e1fa9ea85ce8 should
> > be fixed by commit c8ed1b359312 ("gfs2: Fix duplicate
> > should_fault_in_pages() call"), which ended up in v6.5-rc1.
> > 
> > Could you please check where we end up with that fix?
> 
> I applied c8ed1b359312 on 6.1.36.
> # the build/test of 6.5-rc1 is yet not ready.
> 
> fio performance result:
>   WRITE: bw=2683MiB/s (2813MB/s)
> 
> but  the performance of fio 'Laying out IO file' is improved.
> Jobs: 4 (f=4): [F(4)][100.0%][w=5168MiB/s][w=5168 IOPS][eta 00m:00s]
> 
> so there seems 2 problems,  one is fixed by c8ed1b359312.
> but another is still left.


We build/test on 6.5-rc1 too.
fio  WRITE: bw=2643MiB/s (2771MB/s)

the performance of fio 'Laying out IO file'.
Jobs: 4 (f=4): [F(4)][100.0%][w=4884MiB/s][w=4884 IOPS][eta 00m:00s]

so the performance result on 6.5-rc1 is the same level as
6.1.36 with c8ed1b359312.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/07/11


