Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1F526566F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 03:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgIKBMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 21:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKBMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 21:12:09 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5EAC061573;
        Thu, 10 Sep 2020 18:12:08 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGXbh-00E2kB-Ba; Fri, 11 Sep 2020 01:12:05 +0000
Date:   Fri, 11 Sep 2020 02:12:05 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pipe: honor IOCB_NOWAIT
Message-ID: <20200911011205.GG1236603@ZenIV.linux.org.uk>
References: <cedfa436-47a3-7cbc-1948-75d0e28cfdc5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cedfa436-47a3-7cbc-1948-75d0e28cfdc5@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 07, 2020 at 09:21:02AM -0600, Jens Axboe wrote:
> Pipe only looks at O_NONBLOCK for non-blocking operation, which means that
> io_uring can't easily poll for it or attempt non-blocking issues. Check for
> IOCB_NOWAIT in locking the pipe for reads and writes, and ditto when we
> decide on whether or not to block or return -EAGAIN.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> If this is acceptable, then I can add S_ISFIFO to the whitelist on file
> descriptors we can IOCB_NOWAIT try for, then poll if we get -EAGAIN
> instead of using thread offload.

Will check.  In the meanwhile, blacklist eventpoll again.  Because your
attempts at "nonblocking" there had been both ugly as hell *AND* fail
to prevent blocking.  And frankly, I'm very tempted to rip that crap
out entirely.  Seriously, *look* at the code you've modified in
do_epoll_ctl().  And tell me why the hell is grabbing ->mtx in that
function needs to be infested with trylocks, while exact same mutex
taken in loop_check_proc() called under those is fine with mutex_lock().
Ditto for calls of vfs_poll() inside ep_insert(), GFP_KERNEL allocations
in ep_ptable_queue_proc(), synchronize_rcu() callable from ep_modify()
(from the same function), et sodding cetera.

No, this is _not_ an invitation to spread the same crap over even more
places in there; I just want to understand where had that kind of voodoo
approach comes from.  And that's directly relevant for this patch,
because it looks like the same kind of thing.

What is your semantics for IOCB_NOWAIT?  What should and what should _not_
be waited for?
