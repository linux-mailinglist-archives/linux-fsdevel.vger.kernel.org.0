Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9667675B5A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 19:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjGTRaf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 13:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjGTRae (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:30:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E132722;
        Thu, 20 Jul 2023 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kZsL+fRMiTUhIF6cbkchAwMMymJQNGnAWsHwN+ewJ0E=; b=njeSPSpguzsHoVcLskuzq3zqvP
        fh6yPSsenkfbn+nzasVka6Xcr/4vmVhShCMCWCwccY/VDY/4+EqZ6a08xnubBsxwKl52NFXncUna4
        neUTaeTjchLENIA5+N7KASwQHi+8BunPa3WVG3+qM2zJZS/VsHgKNdC3WNzT8Z0ZdCyCAAa63J5HO
        odj5alfVy+NbSyQkfnrweVtwROQS+w3gW7W6y/yPIhdJMID2yZo2if0EGxr+MMkGK/ewsl7+0JUUO
        Lic2g6Q5iNJbymXPLx0wql6EaA2fSSUuHxU3BlG3N8SbfsK71rrv+19uHkhsEycQKptguXZYHDf72
        A53SA8Eg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMXTc-000IDQ-47; Thu, 20 Jul 2023 17:30:08 +0000
Date:   Thu, 20 Jul 2023 18:30:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
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
        linux-m68k@lists.linux-m68k.org
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
Message-ID: <ZLlvII/jMPTT32ef@casper.infradead.org>
References: <000000000000dbce4e05f170f289@google.com>
 <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
 <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
 <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
 <2575F983-D170-4B79-A6BA-912D4ED2CC73@dubeyko.com>
 <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com>
 <Y7bw7X1Y5KtmPF5s@casper.infradead.org>
 <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com>
 <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 05:27:57PM +0200, Dmitry Vyukov wrote:
> On Thu, 5 Jan 2023 at 17:45, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
> > > On Wed, Jan 04, 2023 at 08:37:16PM -0800, Viacheslav Dubeyko wrote:
> > >> Also, as far as I can see, available volume in report (mount_0.gz) somehow corrupted already:
> > >
> > > Syzbot generates deliberately-corrupted (aka fuzzed) filesystem images.
> > > So basically, you can't trust anything you read from the disc.
> > >
> >
> > If the volume has been deliberately corrupted, then no guarantee that file system
> > driver will behave nicely. Technically speaking, inode write operation should never
> > happened for corrupted volume because the corruption should be detected during
> > b-tree node initialization time. If we would like to achieve such nice state of HFS/HFS+
> > drivers, then it requires a lot of refactoring/implementation efforts. I am not sure that
> > it is worth to do because not so many guys really use HFS/HFS+ as the main file
> > system under Linux.
> 
> 
> Most popular distros will happily auto-mount HFS/HFS+ from anything
> inserted into USB (e.g. what one may think is a charger). This creates
> interesting security consequences for most Linux users.
> An image may also be corrupted non-deliberately, which will lead to
> random memory corruptions if the kernel trusts it blindly.

Then we should delete the HFS/HFS+ filesystems.  They're orphaned in
MAINTAINERS and if distros are going to do such a damnfool thing,
then we must stop them.
