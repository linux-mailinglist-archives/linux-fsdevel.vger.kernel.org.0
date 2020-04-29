Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77301BD8BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 11:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgD2Jtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 05:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgD2Jtk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:49:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69AF620775;
        Wed, 29 Apr 2020 09:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588153779;
        bh=WsmEci1RYX3gAXKaPKi6kDaOGwHuQghjcCQy84kcjQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CagCh6zTlW6+JwlUlk8EMFhgv7Z5QyoiQHoq1ssaAhPo7jVgu2CFYCdEz3uvXNAET
         hjGNZD2vHO38Fb0/pRRwPTT8U/Wj4qB/QmtzsSYSxQ4QZwlVW8YKKs/SC6Yxq4/ePp
         k1BWwULan3xoevpUBDH3MlmxEsxQSKxNIN2xQX9g=
Date:   Wed, 29 Apr 2020 11:49:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] blktrace: break out of blktrace setup on
 concurrent calls
Message-ID: <20200429094937.GB2081185@kroah.com>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429074627.5955-6-mcgrof@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 07:46:26AM +0000, Luis Chamberlain wrote:
> We use one blktrace per request_queue, that means one per the entire
> disk.  So we cannot run one blktrace on say /dev/vda and then /dev/vda1,
> or just two calls on /dev/vda.
> 
> We check for concurrent setup only at the very end of the blktrace setup though.
> 
> If we try to run two concurrent blktraces on the same block device the
> second one will fail, and the first one seems to go on. However when
> one tries to kill the first one one will see things like this:
> 
> The kernel will show these:
> 
> ```
> debugfs: File 'dropped' in directory 'nvme1n1' already present!
> debugfs: File 'msg' in directory 'nvme1n1' already present!
> debugfs: File 'trace0' in directory 'nvme1n1' already present!
> ``
> 
> And userspace just sees this error message for the second call:
> 
> ```
> blktrace /dev/nvme1n1
> BLKTRACESETUP(2) /dev/nvme1n1 failed: 5/Input/output error
> ```
> 
> The first userspace process #1 will also claim that the files
> were taken underneath their nose as well. The files are taken
> away form the first process given that when the second blktrace
> fails, it will follow up with a BLKTRACESTOP and BLKTRACETEARDOWN.
> This means that even if go-happy process #1 is waiting for blktrace
> data, we *have* been asked to take teardown the blktrace.
> 
> This can easily be reproduced with break-blktrace [0] run_0005.sh test.
> 
> Just break out early if we know we're already going to fail, this will
> prevent trying to create the files all over again, which we know still
> exist.
> 
> [0] https://github.com/mcgrof/break-blktrace
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  kernel/trace/blktrace.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 5c52976bd762..383045f67cb8 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -4,6 +4,8 @@
>   *
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/blkdev.h>
>  #include <linux/blktrace_api.h>
> @@ -516,6 +518,11 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
>  	 */
>  	strreplace(buts->name, '/', '_');
>  
> +	if (q->blk_trace) {
> +		pr_warn("Concurrent blktraces are not allowed\n");
> +		return -EBUSY;

You have access to a block device here, please use dev_warn() instead
here for that, that makes it obvious as to what device a "concurrent
blktrace" was attempted for.

thanks,

greg k-h
