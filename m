Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57EF44F05F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 23:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfFUVO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 17:14:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfFUVO6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 17:14:58 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3077F205C9;
        Fri, 21 Jun 2019 21:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561151697;
        bh=+A5ovqJOpzLcVONMQRqVKOitIoP9VN9sjk5zTETdR4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j9DfiZ1uUH08EceCSIPbtAHoj+1iKMIXKrynwMLsOWtqLgEvj48Zi/fotz29tZEY+
         tCYq1rAzXvfnE+5rfL6YujS5izY4ah+/Y9ndYmG1Hqs3rbscRdy5Dcw0/GVUAW7vts
         4zcql4EErO0CmjrdcxzOSjskFJq4jMSCuFI+hxms=
Date:   Fri, 21 Jun 2019 14:14:55 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chandan Rajendra <chandan@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, yuchao0@huawei.com,
        hch@infradead.org
Subject: Re: [PATCH V3 4/7] fs/mpage.c: Integrate read callbacks
Message-ID: <20190621211454.GC167064@gmail.com>
References: <20190616160813.24464-1-chandan@linux.ibm.com>
 <20190616160813.24464-5-chandan@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616160813.24464-5-chandan@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 16, 2019 at 09:38:10PM +0530, Chandan Rajendra wrote:
> This commit adds code to make do_mpage_readpage() to be "read callbacks"
> aware i.e. for files requiring decryption, do_mpage_readpage() now
> sets up the read callbacks state machine when allocating a bio and later
> starts execution of the state machine after file data is read from the
> underlying disk.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> ---
>  fs/mpage.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/mpage.c b/fs/mpage.c
> index 436a85260394..611ad122fc92 100644
> --- a/fs/mpage.c
> +++ b/fs/mpage.c
> @@ -30,6 +30,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/pagevec.h>
>  #include <linux/cleancache.h>
> +#include <linux/read_callbacks.h>
>  #include "internal.h"
>  
>  /*
> @@ -49,6 +50,8 @@ static void mpage_end_io(struct bio *bio)
>  	struct bio_vec *bv;
>  	struct bvec_iter_all iter_all;
>  
> +	if (read_callbacks_end_bio(bio))
> +		return;
>  	bio_for_each_segment_all(bv, bio, iter_all) {
>  		struct page *page = bv->bv_page;
>  		page_endio(page, bio_op(bio),
> @@ -309,6 +312,12 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  					gfp);
>  		if (args->bio == NULL)
>  			goto confused;
> +
> +		if (read_callbacks_setup(inode, args->bio, NULL)) {
> +			bio_put(args->bio);
> +			args->bio = NULL;
> +			goto confused;
> +		}
>  	}
>  
>  	length = first_hole << blkbits;
> @@ -330,7 +339,7 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
>  confused:
>  	if (args->bio)
>  		args->bio = mpage_bio_submit(REQ_OP_READ, op_flags, args->bio);
> -	if (!PageUptodate(page))
> +	if (!PageUptodate(page) && !PageError(page))
>  		block_read_full_page(page, args->get_block);
>  	else
>  		unlock_page(page);
> -- 
> 2.19.1

Why is the !PageError() check needed here?

- Eric
