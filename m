Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6931C1C23
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 19:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgEARnL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 13:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729572AbgEARnL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 13:43:11 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD65FC061A0C;
        Fri,  1 May 2020 10:43:10 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUZgo-00G5Gh-Jb; Fri, 01 May 2020 17:43:06 +0000
Date:   Fri, 1 May 2020 18:43:06 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] eventfd: convert to f_op->read_iter()
Message-ID: <20200501174306.GM23230@ZenIV.linux.org.uk>
References: <c71b2091-a86e-cc81-056d-de2f1e839f50@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c71b2091-a86e-cc81-056d-de2f1e839f50@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 01, 2020 at 11:18:05AM -0600, Jens Axboe wrote:

> -	if (res > 0 && put_user(ucnt, (__u64 __user *)buf))
> +	if (res > 0 && copy_to_iter(&ucnt, res, iov) < res)

*whoa*

It is correct, but only because here res > 0 <=> res == 8.
And that's not trivial at the first glance.

Please, turn that into something like

	if (iov_iter_count(to) < sizeof(ucnt))
		return -EINVAL;
	spin_lock_irq(&ctx->wqh.lock);
	if (!ctx->count) {
		if (unlikely(file->f_flags & O_NONBLOCK) {
			spin_unlock_irq(&ctx->wqh.lock)
			return -EAGAIN;
		}
		__add_wait_queue(&ctx->wqh, &wait);
		for (;;) {
			set_current_state(TASK_INTERRUPTIBLE);
			if (ctx->count)
				break;
			if (signal_pending(current)) {
				spin_unlock_irq(&ctx->wqh.lock)
				return -ERESTARTSYS;
			}
			spin_unlock_irq(&ctx->wqh.lock);
			schedule();
			spin_lock_irq(&ctx->wqh.lock);
		}
		__remove_wait_queue(&ctx->wqh, &wait);
		__set_current_state(TASK_RUNNING);
	}
	eventfd_ctx_do_read(ctx, &ucnt);
	if (waitqueue_active(&ctx->wqh))
		wake_up_locked_poll(&ctx->wqh, EPOLLOUT);
	spin_unlock_irq(&ctx->wqh.lock);
	if (unlikely(copy_to_iter(&ucnt, sizeof(ucnt), to) != sizeof(ucnt)))
		return -EFAULT;
	return sizeof(ucnt);
