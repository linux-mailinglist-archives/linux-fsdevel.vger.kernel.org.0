Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE39420A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 11:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfFLJYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 05:24:14 -0400
Received: from foss.arm.com ([217.140.110.172]:48282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731233AbfFLJYO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:24:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4179B28;
        Wed, 12 Jun 2019 02:24:13 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E54E3F246;
        Wed, 12 Jun 2019 02:24:12 -0700 (PDT)
Date:   Wed, 12 Jun 2019 10:24:04 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Stephen Bates <sbates@raithlin.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "shhuiw@foxmail.com" <shhuiw@foxmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] io_uring: fix SQPOLL cpu check
Message-ID: <20190612092403.GA38578@lakrids.cambridge.arm.com>
References: <5D2859FE-DB39-48F5-BBB5-6EDD3791B6C3@raithlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D2859FE-DB39-48F5-BBB5-6EDD3791B6C3@raithlin.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:56:06PM +0000, Stephen  Bates wrote:
> The array_index_nospec() check in io_sq_offload_start() is performed
> before any checks on p->sq_thread_cpu are done. This means cpu is
> clamped and therefore no error occurs when out-of-range values are
> passed in from userspace. This is in violation of the specification
> for io_ring_setup() and causes the io_ring_setup unit test in liburing
> to regress.
> 
> Add a new bounds check on sq_thread_cpu at the start of
> io_sq_offload_start() so we can exit the function early when bad
> values are passed in.
> 
> Fixes: 975554b03edd ("io_uring: fix SQPOLL cpu validation")
> Signed-off-by: Stephen Bates <sbates@raithlin.com>

Aargh. My original patch [1] handled that correctly, and this case was
explicitly called out in the commit message, which was retained even
when the patch was "simplified". That's rather disappointing. :/

Thanks,
Mark.

[1] https://lore.kernel.org/lkml/20190430123451.44227-1-mark.rutland@arm.com/

> ---
>  fs/io_uring.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 30a5687..e458470 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2316,6 +2316,9 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
>  {
>  	int ret;
>  
> +	if (p->sq_thread_cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
>  	init_waitqueue_head(&ctx->sqo_wait);
>  	mmgrab(current->mm);
>  	ctx->sqo_mm = current->mm;
> -- 
> 2.7.4
> 
