Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E8479103E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 05:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351229AbjIDDCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Sep 2023 23:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjIDDCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Sep 2023 23:02:42 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9EC10E;
        Sun,  3 Sep 2023 20:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f0F1mT0oTx0cuxqaIamdvQUQP90eouQn4jLAgHy5Lho=; b=SH9O2kzmjwTcdAresHcuTllhNM
        wIJ50gPWrtRS0vyNfVkhn/+IYH9mvdX8xPUtTAjGr/2IbW94zxkwtNBIkhNbN6IS69JtYdD1q/XAo
        t13UXd8hxOqeKHncB/mMFr7tOaTuZy0LnQ0SR+3szubrB4KoRF8OMZCBzuai3yuYPcF9F+5GLSzsu
        ulrnW8EicTg5oyx+KdWadfkfR9+L5+qEBP4zQ+VSkSCDZTSuIY4x0b1lVx9YdWzQklQGgE9ZiHfjV
        u7kNO6l9vk7MeCq6xDN7KVS0+s6rDIf2g4n9WKwgHGVdBCoNcuW9YoOtkc9rjFTjQuyX5glDhDtRb
        cKPVBeiA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qczrF-003DLH-2p;
        Mon, 04 Sep 2023 03:02:33 +0000
Date:   Mon, 4 Sep 2023 04:02:33 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>,
        brauner@kernel.org, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Subject: Re: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
Message-ID: <20230904030233.GP3390869@ZenIV>
References: <000000000000e6432a06046c96a5@google.com>
 <ZPQYyMBFmqrfqafL@dread.disaster.area>
 <20230903083357.75mq5l43gakuc2z7@f>
 <ZPUIQzsCSNlnBFHB@dread.disaster.area>
 <20230903231338.GN3390869@ZenIV>
 <ZPU2n48GoSRMBc7j@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPU2n48GoSRMBc7j@dread.disaster.area>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 04, 2023 at 11:45:03AM +1000, Dave Chinner wrote:

> > thread B: write()
> > 	finds file
> > 	grabs ->f_pos_lock
> > 	calls into filesystem
> > 	blocks on fs lock held by A
> > thread C: read()/write()/lseek() on the same file
> > 	blocks on ->f_pos_lock
> 
> Yes, that's exactly what I said in a followup email - we need to
> know what happened to thread A, because that might be where we are
> stuck on a leaked lock.
> 
> I saw quite a few reports where lookup/readdir are also stuck trying
> to get an inode lock - those at the "thread B"s in the above example
> - but there's no indication left of what happened with thread A.
> 
> If thread A was blocked iall that time on something, then the hung
> task timer should fire on it, too.  If it is running in a tight
> loop, the NMI would have dumped a stack trace from it.
> 
> But neither of those things happened, so it's either leaked
> something or it's in a loop with a short term sleep so doesn't
> trigger the hung task timer. sysrq-w output will capture that
> without all the noise of sysrq-t....

Here's what brought sysrq-t:

| > The report does not have info necessary to figure this out -- no
| > backtrace for whichever thread which holds f_pos_lock. I clicked on a
| > bunch of other reports and it is the same story.
| > 
| > Can the kernel be configured to dump backtraces from *all* threads?
| > 
| > If there is no feature like that I can hack it up.
|
| <break>t
|
| over serial console, or echo t >/proc/sysrq-trigger would do it...

A question specifically about getting the stack traces...
