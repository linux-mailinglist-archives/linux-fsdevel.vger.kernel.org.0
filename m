Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC302EF6FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 19:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbhAHSGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 13:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbhAHSGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:06:33 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705BFC061381;
        Fri,  8 Jan 2021 10:05:53 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxw8l-008PGL-MG; Fri, 08 Jan 2021 18:05:35 +0000
Date:   Fri, 8 Jan 2021 18:05:35 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH] fs: process fput task_work with TWA_SIGNAL
Message-ID: <20210108180535.GR3579531@ZenIV.linux.org.uk>
References: <d6ddf6c2-3789-2e10-ba71-668cba03eb35@kernel.dk>
 <20210108052651.GM3579531@ZenIV.linux.org.uk>
 <20210108064639.GN3579531@ZenIV.linux.org.uk>
 <245fba32-76cc-c4e1-6007-0b1f8a22a86b@kernel.dk>
 <20210108155807.GQ3579531@ZenIV.linux.org.uk>
 <41e33492-7b01-6801-cbb1-78ecef0c9fc0@kernel.dk>
 <2cdd6d47-7eb1-3ab1-7aa8-80c54819009b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cdd6d47-7eb1-3ab1-7aa8-80c54819009b@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 08, 2021 at 09:26:40AM -0700, Jens Axboe wrote:
> >> Can you show the callers that DO NOT need it?
> > 
> > OK, so here's my suggestion:
> > 
> > 1) For 5.11, we just re-instate the task_work run in get_signal(). This
> >    will make TWA_RESUME have the exact same behavior as before.
> > 
> > 2) For 5.12, I'll prepare a patch that collapses TWA_RESUME and TWA_SIGNAL,
> >    turning it into a bool again (notify or no notify).
> > 
> > How does that sound?
> 
> Attached the patches - #1 is proposed for 5.11 to fix the current issue,
> and then 2-4 can get queued for 5.12 to totally remove the difference
> between TWA_RESUME and TWA_SIGNAL.
> 
> Totally untested, but pretty straight forward.

	Umm...  I'm looking at the callers of get_signal() and I really wonder
how your support for TIF_NOTIFY_SIGNAL interacts with saved sigmask handling
by various do_signal() (calls of restore_saved_sigmask()).  Could you give
pointers to relevant discussion or a braindump on the same?  I realize that
it had been months ago, but...

	Do we even need restore_saved_sigmask_unless() now?  Could
set_user_sigmask() simply set TIF_NOTIFY_SIGNAL?  Oleg, could you comment
on that?

	Another fun question is how does that thing interact with
single-stepping logics; it's been about 8 years since I looked into
those horrors, but they used to be bloody awful...

	What I'm trying to figure out is how costly TIF_NOTIFY_SIGNAL is
on the work execution side; task_work_add() side is cheap enough, it's
delivery that is interesting.
