Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FE33D30A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 02:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhGVXaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 19:30:00 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:36214 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhGVXaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 19:30:00 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6ils-0031Ow-4I; Fri, 23 Jul 2021 00:10:32 +0000
Date:   Fri, 23 Jul 2021 00:10:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] io_uring: refactor io_sq_offload_create()
Message-ID: <YPoI+GYrgZgWN/dW@zeniv-ca.linux.org.uk>
References: <cover.1618916549.git.asml.silence@gmail.com>
 <939776f90de8d2cdd0414e1baa29c8ec0926b561.1618916549.git.asml.silence@gmail.com>
 <YPnqM0fY3nM5RdRI@zeniv-ca.linux.org.uk>
 <57758edf-d064-d37e-e544-e0c72299823d@kernel.dk>
 <YPn/m56w86xAlbIm@zeniv-ca.linux.org.uk>
 <a85df247-137f-721c-6056-a5c340eed90e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a85df247-137f-721c-6056-a5c340eed90e@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 05:42:55PM -0600, Jens Axboe wrote:

> > So how can we possibly get there with tsk->files == NULL and what does it
> > have to do with files, anyway?
> 
> It's not the clearest, but the files check is just to distinguish between
> exec vs normal cancel. For exec, we pass in files == NULL. It's not
> related to task->files being NULL or not, we explicitly pass NULL for
> exec.

Er...  So turn that argument into bool cancel_all, and pass false on exit and
true on exit?  While we are at it, what happens if you pass io_uring descriptor
to another process, close yours and then have the recepient close the one it
has gotten?  AFAICS, io_ring_ctx_wait_and_kill(ctx) will be called in context
of a process that has never done anything io_uring-related.  Can it end up
trying to resubmit some requests?

I rather hope it can't happen, but I don't see what would prevent it...
