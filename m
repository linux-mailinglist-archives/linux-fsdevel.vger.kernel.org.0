Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DEF2EED91
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 07:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbhAHGsE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 01:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbhAHGsE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 01:48:04 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5022CC0612F5;
        Thu,  7 Jan 2021 22:47:24 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxlYO-008GZK-Fc; Fri, 08 Jan 2021 06:47:20 +0000
Date:   Fri, 8 Jan 2021 06:47:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH] fs: process fput task_work with TWA_SIGNAL
Message-ID: <20210108064720.GO3579531@ZenIV.linux.org.uk>
References: <d6ddf6c2-3789-2e10-ba71-668cba03eb35@kernel.dk>
 <20210108052651.GM3579531@ZenIV.linux.org.uk>
 <CA+icZUWZePRQ6h8TLekp3EMNvLG22o4stV7OaGVCnm9VeX6d=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWZePRQ6h8TLekp3EMNvLG22o4stV7OaGVCnm9VeX6d=w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 08, 2021 at 07:21:52AM +0100, Sedat Dilek wrote:
> On Fri, Jan 8, 2021 at 6:30 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Tue, Jan 05, 2021 at 11:29:11AM -0700, Jens Axboe wrote:
> > > Song reported a boot regression in a kvm image with 5.11-rc, and bisected
> > > it down to the below patch. Debugging this issue, turns out that the boot
> > > stalled when a task is waiting on a pipe being released. As we no longer
> > > run task_work from get_signal() unless it's queued with TWA_SIGNAL, the
> > > task goes idle without running the task_work. This prevents ->release()
> > > from being called on the pipe, which another boot task is waiting on.
> > >
> > > Use TWA_SIGNAL for the file fput work to ensure it's run before the task
> > > goes idle.
> > >
> > > Fixes: 98b89b649fce ("signal: kill JOBCTL_TASK_WORK")
> > > Reported-by: Song Liu <songliubraving@fb.com>
> > > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > >
> > > ---
> > >
> > > The other alternative here is obviously to re-instate the:
> > >
> > > if (unlikely(current->task_works))
> > >       task_work_run();
> > >
> > > in get_signal() that we had before this change. Might be safer in case
> > > there are other cases that need to ensure the work is run in a timely
> > > fashion, though I do think it's cleaner to long term to correctly mark
> > > task_work with the needed notification type. Comments welcome...
> >
> > Interesting...  I think I've missed the discussion of that thing; could
> > you forward the relevant thread my way or give an archive link to it?
> 
> See [1].
> 
> - Sedat -
> 
> [1] https://marc.info/?t=160987156600001&r=1&w=2

Thanks; will check tomorrow.
