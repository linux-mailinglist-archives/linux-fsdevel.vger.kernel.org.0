Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9931DA488
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 00:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgESW2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 18:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgESW2j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 18:28:39 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0D4C061A0E
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 15:28:39 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jbAiu-00C3IO-5R; Tue, 19 May 2020 22:28:32 +0000
Date:   Tue, 19 May 2020 23:28:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Thiago Macieira <thiago.macieira@intel.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fcntl(F_DUPFD) causing apparent file descriptor table corruption
Message-ID: <20200519222832.GU23230@ZenIV.linux.org.uk>
References: <1645568.el9gB4U55B@tjmaciei-mobl1>
 <20200519214520.GS23230@ZenIV.linux.org.uk>
 <6266026.WxYS4g2YVZ@tjmaciei-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6266026.WxYS4g2YVZ@tjmaciei-mobl1>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 19, 2020 at 03:18:13PM -0700, Thiago Macieira wrote:

> > I really wonder about the missing couple of syscalls in your strace, though;
> > could you verify that they _are_ missing and see what the fix above does to
> > your testcase?
> 
> Looking at my terminal backtrace, I might have made a copy & paste mistake of 
> the trace while flipping pages. Unfortunately, the trace file I had in /tmp 
> was lost because I needed to reboot the machine. The other traces I have in my 
> terminal show:
> 
> fcntl(2, F_DUPFD, 134217728)            = 134217728
> close(134217728)                        = 0
> fcntl(2, F_DUPFD, 268435456)            = 268435456
> close(268435456)                        = 0
> fcntl(2, F_DUPFD, 536870912)            = 536870912
> close(536870912)                        = 0
> write(1, "success\n", 8)                = ?
> ^C^Czsh: killed     sudo strace ./dupfd-bug
> 
> I had to killall -9 strace at this point. See the attached oops.

BS values in the array of struct file pointers due to the problem above.
And very likely a memory corruption as well.

> Then I insisted:
> 
> fcntl(2, F_DUPFD, 67108864)             = 67108864
> close(67108864)                         = 0
> fcntl(2, F_DUPFD, 134217728)            = 134217728
> close(134217728)                        = 0
> fcntl(2, F_DUPFD, 268435456Shared connection to <REDACTED> closed.
> 
> At this point, I need to drive to the office to reboot the machine. Building 
> the kernel and testing will take a few days.
> 
> Note to self: don't play with possible kernel bugs without a VM.

... at least not without remote console, complete with ability to
powercycle the box.
