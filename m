Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A822278D40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 17:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgIYPxp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 11:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgIYPxo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 11:53:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAA6C0613CE;
        Fri, 25 Sep 2020 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YVkX1AFaHFQ10Cu8+Y2oeIelkhmu78mT2NIzs7fqtMQ=; b=NitexxSY1jUxbPqeqAnRyxlSim
        Pke3nJ6OB+4ldDJoCkjq5rYaW6lhhnmwIHAUTTD/E90VZBCuTlEMrb6co0sn21tEalpWRkhOgDY4p
        lrT4m30bqDa7FOrYaT/BajizhiL10K/FXCr9VGBIwqvzlqmp4StUxytktVeXTmT7KJHfvs6go15RG
        e+jBfLUaypKyydrYNHqHhSgn9FA+IWspbnOcLXS7TxyTQyvUCPdqnG5ArOOityCN43JCZZZfO35m7
        N+ADN4a17fXCyhiSfvBgBdpe0Y9qBwAjqOVwnVy/w/hQmdgdaN4qSS4kn/zClO0xtmE62bKZ8flnz
        LJaWNQ/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLq2W-0002Nb-SY; Fri, 25 Sep 2020 15:53:41 +0000
Date:   Fri, 25 Sep 2020 16:53:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Qian Cai <cai@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
Message-ID: <20200925155340.GG32101@casper.infradead.org>
References: <CA+icZUUgwcLP8O9oDdUMT0SzEQHjn+LkFFkPL3NsLCBhDRSyGw@mail.gmail.com>
 <f623da731d7c2e96e3a37b091d0ec99095a6386b.camel@redhat.com>
 <CA+icZUVO65ADxk5SZkZwV70ax5JCzPn8PPfZqScTTuvDRD1smQ@mail.gmail.com>
 <20200924200225.GC32101@casper.infradead.org>
 <CA+icZUV3aL_7MptHbradtnd8P6X9VO-=Pi2gBezWaZXgeZFMpg@mail.gmail.com>
 <20200924235756.GD32101@casper.infradead.org>
 <CA+icZUWcx5hBjU35tfY=7KXin7cA5AAY8AMKx-pjYnLCsQywGw@mail.gmail.com>
 <CA+icZUWMs5Xz5vMP370uUBCqzgjq6Aqpy+krZMNg-5JRLxaALA@mail.gmail.com>
 <20200925134608.GE32101@casper.infradead.org>
 <CA+icZUV9tNMbTC+=MoKp3rGmhDeO9ScW7HC+WUTCCvSMpih7DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUV9tNMbTC+=MoKp3rGmhDeO9ScW7HC+WUTCCvSMpih7DA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 25, 2020 at 04:01:02PM +0200, Sedat Dilek wrote:
> On Fri, Sep 25, 2020 at 3:46 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Sep 25, 2020 at 03:36:01PM +0200, Sedat Dilek wrote:
> > > > I have applied your diff on top of Linux v5.9-rc6+ together with
> > > > "iomap: Set all uptodate bits for an Uptodate page".
> > > >
> > > > Run LTP tests:
> > > >
> > > > #1: syscalls (all)
> > > > #2: syscalls/preadv203
> > > > #3: syscalls/dirtyc0w
> > > >
> > > > With #1 I see some failures with madvise0x tests.
> >
> > Why do you think these failures are related to my patches?
> 
> Oh sorry, I was not saying it is related to your patches and I am not
> familiar with all syscalls LTP tests.

It's probably a good idea to become familiar with the tests.  I'm not,
but a good way to work with any test-suite is to run it against a
presumed-good kernel, then against a kernel with changes and see whether
the failures change.

> You said:
> > Qian reported preadv203.c could reproduce it easily on POWER and ARM.
> > They have 64kB pages, so it's easier to hit.  You need to have a
> > filesystem with block size < page size to hit the problem.
> 
> Here on my x86-64 Debian host I use Ext4-FS.
> I can setup a new partition with a different filesystem if this helps.
> Any recommendations?

If I understand the output from preadv203 correctly, it sets up a loop
block device with a new filesystem on it, so it doesn't matter what your
host fs is.  What I don't know is how to change the block size for that
filesystem.

> How does the assertion look like in the logs?
> You have an example.

I happen to have one from my testing last night:

0006 ------------[ cut here ]------------
0006 WARNING: CPU: 5 PID: 1417 at fs/iomap/buffered-io.c:80 iomap_page_release+0xb1/0xc0
0006 bam!
0006 Modules linked in:
0006 CPU: 5 PID: 1417 Comm: fio Kdump: loaded Not tainted 5.8.0-00001-g51f85a97ccdd-dirty #54
0006 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1 04/01/2014
0006 RIP: 0010:iomap_page_release+0xb1/0xc0
0006 Code: 45 d9 48 8b 03 48 c1 e8 02 83 e0 01 75 13 38 d0 75 18 4c 89 ef e8 1f 6a f8 ff 5b 41 5c 41 5d 5d c3 eb eb e8 e1 07 f4 ff eb 8c <0f> 0b eb e4 0f 0b eb a8 0f 0b eb ac 0f 1f 00 55 48 89 e5 41 56 41
0006 RSP: 0018:ffffc90001ed3a40 EFLAGS: 00010202
0006 RAX: 0000000000000001 RBX: ffffea0001458ec0 RCX: ffffffff81cf75a7
0006 RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8880727d1f90
0006 RBP: ffffc90001ed3a58 R08: 0000000000000000 R09: ffff888051ddd6e8
0006 R10: 0000000000000005 R11: 0000000000000230 R12: 0000000000000004
0006 R13: ffff8880727d1f80 R14: 0000000000000005 R15: ffffea0001458ec0
0006 FS:  00007fe4bdd9df00(0000) GS:ffff88807f540000(0000) knlGS:0000000000000000
0006 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
0006 CR2: 00007fe4bdd50000 CR3: 000000006f7e6005 CR4: 0000000000360ea0
0006 Call Trace:
0006  iomap_releasepage+0x58/0xc0
0006  try_to_release_page+0x4b/0x60
0006  invalidate_inode_pages2_range+0x38b/0x3f0

I would suggest that you try applying just the assertion to Linus'
kernel, then try to make it fire.  Then apply the fix and see if you
can still make the assertion fire.

FWIW, I got it to fire with generic/095 from the xfstests test suite.
