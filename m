Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70D075BBB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 03:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjGUBLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 21:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGUBLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 21:11:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E00AE75;
        Thu, 20 Jul 2023 18:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V/2ey4BODOXs91gbtdZpWPHT0tSIRcVvtYaAB1e+t1E=; b=sbQP7GJscgBh2rBDtbFD9fpXdP
        HGdwrVE1r6B1hEcnWCmthYiWJ2HQuipu7uGlmdNqcwbzHGwEBxk54wmBMm0kiACUpj2KU6iqtpzNI
        islNcmDeV4uhhlRXWDqpfkNd5eLEL1CGm8cuGEB/PWPQVJHwa3cJFnRarnINSMGWnyqjk+K40ybTG
        lILPHDraNqfTM4ZCqRbxOExKUMhDw/zZJaZE6ywu5NvI5q9OAPROufGiP89IsOyv9hvb3wClXXn5U
        QEjTmufDD8TIlvAf6+8O/20xfHkV6EpauP/Tv9D2IWOHXaRSsSf9R9T9Bzap+83cjnIhlen2ND9NP
        TUpCWz0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMefw-000cgY-0k; Fri, 21 Jul 2023 01:11:20 +0000
Date:   Fri, 21 Jul 2023 02:11:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Jeff Layton <jlayton@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-m68k@lists.linux-m68k.org,
        debian-ports <debian-ports@lists.debian.org>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
Message-ID: <ZLnbN4Mm9L5wCzOK@casper.infradead.org>
References: <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com>
 <Y7bw7X1Y5KtmPF5s@casper.infradead.org>
 <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com>
 <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com>
 <ZLlvII/jMPTT32ef@casper.infradead.org>
 <2d0bd58fb757e7771d13f82050a546ec5f7be8de.camel@physik.fu-berlin.de>
 <ZLl2Fq35Ya0cNbIm@casper.infradead.org>
 <868611d7f222a19127783cc8d5f2af2e42ee24e4.camel@kernel.org>
 <ZLmzSEV6Wk+oRVoL@dread.disaster.area>
 <60b57ae9-ff49-de1d-d40d-172c9e6d43d5@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60b57ae9-ff49-de1d-d40d-172c9e6d43d5@linux-m68k.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 21, 2023 at 11:03:28AM +1000, Finn Thain wrote:
> On Fri, 21 Jul 2023, Dave Chinner wrote:
> 
> > > I suspect that this is one of those catch-22 situations: distros are 
> > > going to enable every feature under the sun. That doesn't mean that 
> > > anyone is actually _using_ them these days.
> 
> I think the value of filesystem code is not just a question of how often 
> it gets executed -- it's also about retaining access to the data collected 
> in archives, museums, galleries etc. that is inevitably held in old 
> formats.

That's an argument for adding support to tar, not for maintaining
read/write support.

> > We need to much more proactive about dropping support for unmaintained 
> > filesystems that nobody is ever fixing despite the constant stream of 
> > corruption- and deadlock- related bugs reported against them.
> 
> IMO, a stream of bug reports is not a reason to remove code (it's a reason 
> to revert some commits).
> 
> Anyway, that stream of bugs presumably flows from the unstable kernel API, 
> which is inherently high-maintenance. It seems that a stable API could be 
> more appropriate for any filesystem for which the on-disk format is fixed 
> (by old media, by unmaintained FLOSS implementations or abandoned 
> proprietary implementations).

You've misunderstood.  Google have decided to subject the entire kernel
(including obsolete unmaintained filesystems) to stress tests that it's
never had before.  IOW these bugs have been there since the code was
merged.  There's nothing to back out.  There's no API change to blame.
It's always been buggy and it's never mattered before.

It wouldn't be so bad if Google had also decided to fund people to fix
those bugs, but no, they've decided to dump them on public mailing lists
and berate developers into fixing them.

