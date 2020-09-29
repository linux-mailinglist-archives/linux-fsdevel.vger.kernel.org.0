Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61D27C245
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 12:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgI2KVz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 06:21:55 -0400
Received: from verein.lst.de ([213.95.11.211]:39127 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgI2KVz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:21:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2B07C68B02; Tue, 29 Sep 2020 12:21:53 +0200 (CEST)
Date:   Tue, 29 Sep 2020 12:21:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@lst.de>,
        Eric Biggers <ebiggers@kernel.org>,
        "syzbot+51177e4144d764827c45@syzkaller.appspotmail.com" 
        <syzbot+51177e4144d764827c45@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: WARNING in __kernel_read (2)
Message-ID: <20200929102152.GA14610@lst.de>
References: <000000000000da992305b02e9a51@google.com> <3b3de066852d4e30bd9d85bd28023100@AcuMS.aculab.com> <642ed0b4810d44ab97a7832ccb8b3e44@AcuMS.aculab.com> <20200928221441.GF1340@sol.localdomain> <20200929063815.GB1839@lst.de> <20200929064648.GA238449@sol.localdomain> <20200929065601.GA2095@lst.de> <e81e2721e8ce4612b0fc6098d311d378@AcuMS.aculab.com> <CACT4Y+ax5YN5r=zL1NaxB_9S_7e6aUiL3tmBc6-8UMwuJpnn_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ax5YN5r=zL1NaxB_9S_7e6aUiL3tmBc6-8UMwuJpnn_Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 29, 2020 at 10:21:19AM +0200, Dmitry Vyukov wrote:
> On Tue, Sep 29, 2020 at 10:06 AM David Laight <David.Laight@aculab.com> wrote:
> >
> > From: Christoph Hellwig
> > > Sent: 29 September 2020 07:56
> > >
> > > On Mon, Sep 28, 2020 at 11:46:48PM -0700, Eric Biggers wrote:
> > > > > Linus asked for it.  What is the call chain that we hit it with?
> > > >
> > > > Call Trace:
> > > >  kernel_read+0x52/0x70 fs/read_write.c:471
> > > >  kernel_read_file fs/exec.c:989 [inline]
> > > >  kernel_read_file+0x2e5/0x620 fs/exec.c:952
> > > >  kernel_read_file_from_fd+0x56/0xa0 fs/exec.c:1076
> > > >  __do_sys_finit_module+0xe6/0x190 kernel/module.c:4066
> > > >  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> > > >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > >
> > > > See the email from syzbot for the full details:
> > > > https://lkml.kernel.org/linux-fsdevel/000000000000da992305b02e9a51@google.com
> > >
> > > Passing a fs without read permissions definitively looks bogus for
> > > the finit_module syscall.  So I think all we need is an extra check
> > > to validate the fd.
> >
> > The sysbot test looked like it didn't even have a regular file.
> > I thought I saw a test for that - but it might be in a different path.
> >
> > You do need to ensure that 'exec' doesn't need read access.
> 
> The test tried to load a module from /dev/input/mouse
> 
> r2 = syz_open_dev$mouse(&(0x7f0000000000)='/dev/input/mouse#\x00',
> 0x101, 0x109887)
> finit_module(r2, 0x0, 0x0)
> 
> because... why not? Everything is a file! :)

Yes, syzbot is fine here.  It is the modules code that needs to better
verify the fd.
