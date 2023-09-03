Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32338790D61
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Sep 2023 20:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbjICSBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Sep 2023 14:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjICSBg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Sep 2023 14:01:36 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42346D9;
        Sun,  3 Sep 2023 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S9Vu6m4/BeTB9HCncSagEJ1QKniB6AXPYafpsvd+t/Y=; b=Hz8Rmv8O0J2BQeSNcabh+Masdo
        83vXuhpL/rmZRAyGK/sdDLMDWcoPLWqjyjoTZVq2EK9MHu5USNzF07SWBN//D9CoRrK4EfXj6HiOu
        rIbcpi8cYA6CCGFrzL8EkiILQfT9h/ix/FIKmyDT7SPteIyYOtNnPW48R6jEv10NLDQ4OYuW9KlVt
        fPnTxHMbCgwiTmYAyCxgCjczVVZUBzuyWMwXAqh7vyvittDtBpTMBpsxXuHDMjItIU7/pPhIY5t+J
        dmaUY/ekdwOg31wUNKABWQA8QzDpTJvjIlyALWnL3MpWLvJKPuilp2Lip1LFj3/N3jVAF6KaYecJs
        MflbsOrw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qcrPa-0037Rq-20;
        Sun, 03 Sep 2023 18:01:26 +0000
Date:   Sun, 3 Sep 2023 19:01:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>,
        brauner@kernel.org, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Subject: Re: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
Message-ID: <20230903180126.GL3390869@ZenIV>
References: <000000000000e6432a06046c96a5@google.com>
 <ZPQYyMBFmqrfqafL@dread.disaster.area>
 <20230903083357.75mq5l43gakuc2z7@f>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903083357.75mq5l43gakuc2z7@f>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 03, 2023 at 10:33:57AM +0200, Mateusz Guzik wrote:
> On Sun, Sep 03, 2023 at 03:25:28PM +1000, Dave Chinner wrote:
> > On Sat, Sep 02, 2023 at 09:11:34PM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    b97d64c72259 Merge tag '6.6-rc-smb3-client-fixes-part1' of..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14136d8fa80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=958c1fdc38118172
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Been happening for months, apparently, yet for some reason it now
> > thinks a locking hang in __fdget_pos() is an XFS issue?
> > 
> > #syz set subsystems: fs
> > 
> 
> The report does not have info necessary to figure this out -- no
> backtrace for whichever thread which holds f_pos_lock. I clicked on a
> bunch of other reports and it is the same story.
> 
> Can the kernel be configured to dump backtraces from *all* threads?
> 
> If there is no feature like that I can hack it up.

<break>t

over serial console, or echo t >/proc/sysrq-trigger would do it...

"Locking hang in __fdget_pos()" would mean either something stuck inside
->read/->write/->read_iter/->write_iter/->llseek instance, making
any further syscalls in that bunch on the same open file to block,
or a lost fdput_pos() somewhere; AFAICS, we don't have anything of
the latter variety, but the former is too wide to tell anything
useful.
