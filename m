Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F03075B606
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 20:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGTSAJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 14:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGTSAI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:00:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10B0270C;
        Thu, 20 Jul 2023 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V7G2UtptYlwfwVXmCQnk4Mjk/yUqKgviUimViNIUGao=; b=APuLBZisvMr6cQw8KUoNNdpuMH
        BpT5J/c1XSPhDXrksvjXAixfS/BvGwt0RsKlTzcOKgWsSmYVJIZr2Kx1k2BZfobhgBng4kFQdoqUr
        lIAAgVrxtPhrO8wG68By//7CqCS1swkCl2dZVSduoiMFQgIok4rPGzIYGdLIahYNg3OV7ReHZ2dwY
        H5P0IAuC4uqBUbb8WItLwTsvqLsNDkPlSP5U12Csd8QukocOIfGcqi7BTMfJNjaCCs2qazoNqJBom
        fFrmqGJIoTzq3xz4xc+rPrWjCLGUlDnMbB5IuuT+OLwYKn2k89jCBhzJfCY2r5VaJAEDNn+TrPsDn
        /S8+glug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qMXwM-000JgO-RJ; Thu, 20 Jul 2023 17:59:50 +0000
Date:   Thu, 20 Jul 2023 18:59:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
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
Message-ID: <ZLl2Fq35Ya0cNbIm@casper.infradead.org>
References: <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
 <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
 <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
 <2575F983-D170-4B79-A6BA-912D4ED2CC73@dubeyko.com>
 <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com>
 <Y7bw7X1Y5KtmPF5s@casper.infradead.org>
 <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com>
 <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com>
 <ZLlvII/jMPTT32ef@casper.infradead.org>
 <2d0bd58fb757e7771d13f82050a546ec5f7be8de.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d0bd58fb757e7771d13f82050a546ec5f7be8de.camel@physik.fu-berlin.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 07:50:47PM +0200, John Paul Adrian Glaubitz wrote:
> > Then we should delete the HFS/HFS+ filesystems.  They're orphaned in
> > MAINTAINERS and if distros are going to do such a damnfool thing,
> > then we must stop them.
> 
> Both HFS and HFS+ work perfectly fine. And if distributions or users are so
> sensitive about security, it's up to them to blacklist individual features
> in the kernel.
> 
> Both HFS and HFS+ have been the default filesystem on MacOS for 30 years
> and I don't think it's justified to introduce such a hard compatibility
> breakage just because some people are worried about theoretical evil
> maid attacks.
> 
> HFS/HFS+ mandatory if you want to boot Linux on a classic Mac or PowerMac
> and I don't think it's okay to break all these systems running Linux.

If they're so popular, then it should be no trouble to find somebody
to volunteer to maintain those filesystems.  Except they've been
marked as orphaned since 2011 and effectively were orphaned several
years before that (the last contribution I see from Roman Zippel is
in 2008, and his last contribution to hfs was in 2006).
