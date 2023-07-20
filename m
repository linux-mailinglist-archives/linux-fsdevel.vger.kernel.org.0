Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F3C75BAB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 00:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjGTWiB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 18:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGTWh4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:37:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29517E65;
        Thu, 20 Jul 2023 15:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=5wfB/JnTildGLpqIz22A/N+tA5l0CUHxiDZM+QP0Xnw=; b=Qdrj24cjE0nBvu1VL4hCFUzYtu
        modSy+mz0JT/nbTsDGP4Rqu7vYpq+i2KZ4yfk3YoOuNcRbAQOYiql7azl3dXQ8FAsXH6fcgdu0/I1
        zgIOAlrFrQXnV4palYO9N1gAvMiA0urkN1CRiEYesm4+Mrrl2Sdq31ytxBIT/pAPe99DwqAjtXvrZ
        WRdPHrweHO6h5TAFdPcidCw9HVkffv9qM4d4NUTiJXPj//KjqeGH9X40cMX4+rbeorMp8yn/CETaY
        kazpax+f2FpKq4dC2yflbMBJuQ8r7O0eM2rDzqurfiDz5n1eQnYZx5OQYidLNHh1SZqA0K4ieuH1n
        iFMWH0eQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMcH6-000Vlo-Ox; Thu, 20 Jul 2023 22:37:32 +0000
Date:   Thu, 20 Jul 2023 23:37:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-m68k@lists.linux-m68k.org,
        debian-ports <debian-ports@lists.debian.org>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
Message-ID: <ZLm3LLrsSPYkLYr4@casper.infradead.org>
References: <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
 <2575F983-D170-4B79-A6BA-912D4ED2CC73@dubeyko.com>
 <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com>
 <Y7bw7X1Y5KtmPF5s@casper.infradead.org>
 <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com>
 <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com>
 <ZLlvII/jMPTT32ef@casper.infradead.org>
 <2d0bd58fb757e7771d13f82050a546ec5f7be8de.camel@physik.fu-berlin.de>
 <ZLl2Fq35Ya0cNbIm@casper.infradead.org>
 <CAH8yC8=BwacXyFQret5pKVCzXXO0jLM_u9eW3bTdyPi4y8CSfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH8yC8=BwacXyFQret5pKVCzXXO0jLM_u9eW3bTdyPi4y8CSfw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 05:38:52PM -0400, Jeffrey Walton wrote:
> On Thu, Jul 20, 2023 at 2:39 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Jul 20, 2023 at 07:50:47PM +0200, John Paul Adrian Glaubitz wrote:
> > > > Then we should delete the HFS/HFS+ filesystems.  They're orphaned in
> > > > MAINTAINERS and if distros are going to do such a damnfool thing,
> > > > then we must stop them.
> > >
> > > Both HFS and HFS+ work perfectly fine. And if distributions or users are so
> > > sensitive about security, it's up to them to blacklist individual features
> > > in the kernel.
> > >
> > > Both HFS and HFS+ have been the default filesystem on MacOS for 30 years
> > > and I don't think it's justified to introduce such a hard compatibility
> > > breakage just because some people are worried about theoretical evil
> > > maid attacks.
> > >
> > > HFS/HFS+ mandatory if you want to boot Linux on a classic Mac or PowerMac
> > > and I don't think it's okay to break all these systems running Linux.
> >
> > If they're so popular, then it should be no trouble to find somebody
> > to volunteer to maintain those filesystems.  Except they've been
> > marked as orphaned since 2011 and effectively were orphaned several
> > years before that (the last contribution I see from Roman Zippel is
> > in 2008, and his last contribution to hfs was in 2006).
> 
> One data point may help.. I've been running Linux on an old PowerMac
> and an old Intel MacBook since about 2014 or 2015 or so. I have needed
> the HFS/HFS+ filesystem support for about 9 years now (including that
> "blessed" support for the Apple Boot partition).
> 
> There's never been a problem with Linux and the Apple filesystems.
> Maybe it speaks to the maturity/stability of the code that already
> exists. The code does not need a lot of attention nowadays.
> 
> Maybe the orphaned status is the wrong metric to use to determine
> removal. Maybe a better metric would be installation base. I.e., how
> many users use the filesystem.

I think you're missing the context.  There are bugs in how this filesystem
handles intentionally-corrupted filesystems.  That's being reported as
a critical bug because apparently some distributions automount HFS/HFS+
filesystems presented to them on a USB key.  Nobody is being paid to fix
these bugs.  Nobody is volunteering to fix these bugs out of the kindness
of their heart.  What choice do we have but to remove the filesystem,
regardless of how many happy users it has?
