Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02B21BD8C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 11:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgD2Jug (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 05:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgD2Jug (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:50:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ABC520775;
        Wed, 29 Apr 2020 09:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588153836;
        bh=pulymwHUCy+ILUA/eItQyTrcE9Pq+/nb//736se0uVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvRgpyuCu/jL6tMLpZQVAitTpFH117anPbvmGsSdTbiAlARdIlYkvVaTYIuq5viUZ
         zac4jOJIMVsXc8PjaN7NDU9Z6TjOHuuPedW+BNx7K0DCZCJ5UMMcwPgvmuHGk+KxRe
         btwWd8PTbaYQzqw8QQ38xkiHc7DJTnLS40jtPkxE=
Date:   Wed, 29 Apr 2020 11:50:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] loop: be paranoid on exit and prevent new
 additions / removals
Message-ID: <20200429095034.GC2081185@kroah.com>
References: <20200429074627.5955-1-mcgrof@kernel.org>
 <20200429074627.5955-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429074627.5955-7-mcgrof@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 07:46:27AM +0000, Luis Chamberlain wrote:
> Be pedantic on removal as well and hold the mutex.
> This should prevent uses of addition while we exit.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/block/loop.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index da693e6a834e..6dccba22c9b5 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2333,6 +2333,8 @@ static void __exit loop_exit(void)
>  
>  	range = max_loop ? max_loop << part_shift : 1UL << MINORBITS;
>  
> +	mutex_lock(&loop_ctl_mutex);
> +
>  	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
>  	idr_destroy(&loop_index_idr);
>  
> @@ -2340,6 +2342,8 @@ static void __exit loop_exit(void)
>  	unregister_blkdev(LOOP_MAJOR, "loop");
>  
>  	misc_deregister(&loop_misc);
> +
> +	mutex_unlock(&loop_ctl_mutex);
>  }
>  
>  module_init(loop_init);

What type of issue is this helping with?  Can it be triggered today?  if
so, shouldn't it be backported to stable kernels?

thanks,

greg k-h
