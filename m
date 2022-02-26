Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836434C5882
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 23:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiBZW0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Feb 2022 17:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiBZW0h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Feb 2022 17:26:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D2B2BD724
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Feb 2022 14:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6PEs54nvsFGtLVlXnoLCl2ZzNZBbOYUR8XUcdycm0vQ=; b=ug+l7MxKXJZ+axQUJk2PlynpRW
        ljXj3qcJIZtcnpANpqCS/NYC3geq4fcssT3jLTDhk2GCNnxtcBtO3S8CNeFdr+GtI4XS8ncWLftua
        6zs7eh48FDdukPcyvPd3fcJ+cInNqBwHI2rYzjwmyxPhLyf0JD0iPMu0nKfPa/kOWbwwRlNW5PJRp
        iH6gD5ijkWVIHf3Pvn7pZdQlg6Xx8cNXR83nAM9OAJtSjsWAh5KMXSFptuo+DbEn8XhQY/b+azl+1
        qV5qhTfEYayXUDvpZzcCzSN91tM3qQgIt7ppT7+vTQGONEmOnzrSTOv8e44YmDLAY6BGXg3FMEc5R
        1A+XQ/UQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nO5Vn-0075ck-SF; Sat, 26 Feb 2022 22:25:59 +0000
Date:   Sat, 26 Feb 2022 22:25:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] direct-io: prevent possible race condition on bio_list
Message-ID: <Yhqo9/695SJbMCBb@casper.infradead.org>
References: <20220226221748.197800-1-dossche.niels@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226221748.197800-1-dossche.niels@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 26, 2022 at 11:17:48PM +0100, Niels Dossche wrote:
> Prevent bio_list from changing in the while loop condition such that the
> body of the loop won't execute with a potentially NULL pointer for
> bio_list, which causes a NULL dereference later on.

Is this something you've seen happen, or something you think might
happen?

> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
> ---
>  fs/direct-io.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 654443558047..806f05407019 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -545,19 +545,22 @@ static inline int dio_bio_reap(struct dio *dio, struct dio_submit *sdio)
>  	int ret = 0;
>  
>  	if (sdio->reap_counter++ >= 64) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&dio->bio_lock, flags);
>  		while (dio->bio_list) {
> -			unsigned long flags;
>  			struct bio *bio;
>  			int ret2;
>  
> -			spin_lock_irqsave(&dio->bio_lock, flags);
>  			bio = dio->bio_list;
>  			dio->bio_list = bio->bi_private;
>  			spin_unlock_irqrestore(&dio->bio_lock, flags);
>  			ret2 = blk_status_to_errno(dio_bio_complete(dio, bio));
>  			if (ret == 0)
>  				ret = ret2;
> +			spin_lock_irqsave(&dio->bio_lock, flags);
>  		}
> +		spin_unlock_irqrestore(&dio->bio_lock, flags);
>  		sdio->reap_counter = 0;
>  	}
>  	return ret;
> -- 
> 2.35.1
> 
