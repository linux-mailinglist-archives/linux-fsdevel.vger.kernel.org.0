Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE34C47A25B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Dec 2021 22:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbhLSV3L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Dec 2021 16:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhLSV3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Dec 2021 16:29:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ACFC061574;
        Sun, 19 Dec 2021 13:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HCLE3zNdSqR+ISEFtkrY5xukRhj9jR6+pEOmgVRlmtQ=; b=Xd0J2PyK7qkcFulIfhfUaS7rvj
        IwIzrDQXskmHEB3SOvUbArpNZu9iYV8hrevzUj8Ta4qnTBBOwh+MsF0FNbx+LqY5EMeSSmOg0a5qU
        jPOBq0dKqUMLUstjKr1o3vWduaNeChPHcjMaEzNJMDW1qrI/nYTuzPaY+Q/5Chwtgc7yIkCeUeyn5
        voRpd+Qxek2KK5w09v94xUpsPwAfCJJvd6vbMvhhZnlDZc+jib4P3lIQmj0tJMMFHlWGStqVMnZOZ
        bWtuwoAsP1ZQ+BwTWS4xNQ0p2hTzsgrDz3m/Dd2A6a2XAqSAph0wYFEEv9LqP+0BwcdfakzHYqdUC
        YRtua2Lg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mz3jq-00H5He-D1; Sun, 19 Dec 2021 21:29:02 +0000
Date:   Sun, 19 Dec 2021 13:29:02 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Baokun Li <libaokun1@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yukuai3@huawei.com, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] sysctl: returns -EINVAL when a negative value is
 passed to proc_doulongvec_minmax
Message-ID: <Yb+kHuIFnCKcfM5l@bombadil.infradead.org>
References: <20211209085635.1288737-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209085635.1288737-1-libaokun1@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 09, 2021 at 04:56:35PM +0800, Baokun Li wrote:
> When we pass a negative value to the proc_doulongvec_minmax() function,
> the function returns 0, but the corresponding interface value does not
> change.
> 
> we can easily reproduce this problem with the following commands:
>     `cd /proc/sys/fs/epoll`
>     `echo -1 > max_user_watches; echo $?; cat max_user_watches`
> 
> This function requires a non-negative number to be passed in, so when
> a negative number is passed in, -EINVAL is returned.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  kernel/sysctl.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 7f07b058b180..537d2f75faa0 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1149,10 +1149,9 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table,
>  					     sizeof(proc_wspace_sep), NULL);
>  			if (err)
>  				break;
> -			if (neg)
> -				continue;
> +
>  			val = convmul * val / convdiv;
> -			if ((min && val < *min) || (max && val > *max)) {
> +			if (neg || (min && val < *min) || (max && val > *max)) {
>  				err = -EINVAL;
>  				break;
>  			}

I'd much prefer if we stick to the pattern:

err = proc_get_long(...);
if (err || neg) {
	err = -EINVAL;
	break;
}        

Look at the other proc_get_long() uses.

But otherwise yes we should do this, please Cc Andrew Morton in your
next patch and I'll Ack it. Also extend the commit log to include that
proc_get_long() always returns -EINVAL on error and so we embrace the
pattern already used in other places where we also check for a negative
value and it is not allowed.

Did you get to inspect all other unsigned proc calls? If not feel free,
and thanks for your patch!!!

Curious do you have docs on Hulk Robot?

  Luis
