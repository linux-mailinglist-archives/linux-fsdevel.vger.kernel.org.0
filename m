Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5479610119F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 04:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfKSDKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 22:10:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbfKSDKX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 22:10:23 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4CFE2070E;
        Tue, 19 Nov 2019 03:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574133023;
        bh=OvPo829X0NAds8jIa2J1IO7KdmDGATW9k1H4VdHCgZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bc79nIT9S2/aFOSzlDK80fUaTc6Zz43X96zMIi1Er/0IDrt1qAxMI389WCzvYks5X
         mm/a9p3FFANlWHsCGxvGIL7UwmW6F2Hv9IqBR/OCIv7BKHYMtC72zCXTKEVuli/chM
         Kt17k27cyDap7yAUdDizjzTL4Mafnwy5Gnqgx9Jk=
Date:   Mon, 18 Nov 2019 19:10:21 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+991400e8eba7e00a26e1@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        riteshh@linux.ibm.com, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, viro@zeniv.linux.org.uk
Subject: Re: WARNING in iov_iter_pipe
Message-ID: <20191119031021.GI3147@sol.localdomain>
References: <000000000000d60aa50596c63063@google.com>
 <20191108103148.GE20863@quack2.suse.cz>
 <20191111081628.GB14058@bobrowski>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111081628.GB14058@bobrowski>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 11, 2019 at 07:16:29PM +1100, Matthew Bobrowski wrote:
> On Fri, Nov 08, 2019 at 11:31:48AM +0100, Jan Kara wrote:
> > On Thu 07-11-19 10:54:10, syzbot wrote:
> > > syzbot found the following crash on:
> > > 
> > > HEAD commit:    c68c5373 Add linux-next specific files for 20191107
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=13d6bcfce00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=742545dcdea21726
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=991400e8eba7e00a26e1
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1529829ae00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a55c0ce00000
> > > 
> > > The bug was bisected to:
> > > 
> > > commit b1b4705d54abedfd69dcdf42779c521aa1e0fbd3
> > > Author: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> > > Date:   Tue Nov 5 12:01:37 2019 +0000
> > > 
> > >     ext4: introduce direct I/O read using iomap infrastructure
> > 
> > Hum, interesting and from the first looks the problem looks real.
> > Deciphered reproducer is:
> > 
> > int fd0 = open("./file0", O_RDWR | O_CREAT | O_EXCL | O_DIRECT, 0);
> > int fd1 = open("./file0, O_RDONLY);
> > write(fd0, "some_data...", 512);
> > sendfile(fd0, fd1, NULL, 0x7fffffa7);
> >   -> this is interesting as it will result in reading data from 'file0' at
> >      offset X with buffered read and writing them with direct write to
> >      offset X+512. So this way we'll grow the file up to those ~2GB in
> >      512-byte chunks.
> > - not sure if we ever get there but the remainder of the reproducer is:
> > fd2 = open("./file0", O_RDWR | O_CREAT | O_NOATIME | O_SYNC, 0);
> > sendfile(fd2, fd0, NULL, 0xffffffff)
> >   -> doesn't seem too interesting as fd0 is at EOF so this shouldn't do
> >      anything.
> > 
> > Matthew, can you have a look?
> 
> Sorry Jan, I've been crazy busy lately and I'm out at training this
> week. Let me take a look at this and see whether I can determine
> what's happening here.
> 

FYI, syzbot is still seeing this on linux-next.

Also, a new thread was started to discuss this:
https://lkml.kernel.org/linux-ext4/20191113180032.GB12013@quack2.suse.cz/T/#u
(Mentioning this in case anyone is following this thread only.)

- Eric
