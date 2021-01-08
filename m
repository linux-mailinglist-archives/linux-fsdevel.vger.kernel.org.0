Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C8A2EF549
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 17:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbhAHP7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 10:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbhAHP7C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:59:02 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B4AC061380;
        Fri,  8 Jan 2021 07:58:21 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxu9P-008Nht-Tr; Fri, 08 Jan 2021 15:58:08 +0000
Date:   Fri, 8 Jan 2021 15:58:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH] fs: process fput task_work with TWA_SIGNAL
Message-ID: <20210108155807.GQ3579531@ZenIV.linux.org.uk>
References: <d6ddf6c2-3789-2e10-ba71-668cba03eb35@kernel.dk>
 <20210108052651.GM3579531@ZenIV.linux.org.uk>
 <20210108064639.GN3579531@ZenIV.linux.org.uk>
 <245fba32-76cc-c4e1-6007-0b1f8a22a86b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <245fba32-76cc-c4e1-6007-0b1f8a22a86b@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 08, 2021 at 08:13:25AM -0700, Jens Axboe wrote:
> > Anyway, bedtime for me; right now it looks like at least for task ==
> > current we always want TWA_SIGNAL.  I'll look into that more tomorrow
> > when I get up, but so far it smells like switching everything to
> > TWA_SIGNAL would be the right thing to do, if not going back to bool
> > notify for task_work_add()...
> 
> Before the change, the fact that we ran task_work off get_signal() and
> thus processed even non-notify work in that path was a bit of a mess,
> imho. If you have work that needs processing now, in the same manner as
> signals, then you really should be using TWA_SIGNAL. For this pipe case,
> and I'd need to setup and reproduce it again, the task must have a
> signal pending and that would have previously caused the task_work to
> run, and now it does not. TWA_RESUME technically didn't change its
> behavior, it's still the same notification type, we just don't run
> task_work unconditionally (regardless of notification type) from
> get_signal().

It sure as hell did change behaviour.  Think of the effect of getting
hit with SIGSTOP.  That's what that "bit of a mess" had been about.
Work done now vs. possibly several days later when SIGCONT finally
gets sent.

> I think the main question here is if we want to re-instate the behavior
> of running task_work off get_signal(). I'm leaning towards not doing
> that and ensuring that callers that DO need that are using TWA_SIGNAL.

Can you show the callers that DO NOT need it?
