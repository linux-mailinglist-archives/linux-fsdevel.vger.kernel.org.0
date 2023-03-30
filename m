Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449906D129D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 00:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjC3Wxc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 18:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjC3WxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:53:16 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8E01B376;
        Thu, 30 Mar 2023 15:52:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o11so19589158ple.1;
        Thu, 30 Mar 2023 15:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680216718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sp3oL8gR+feCzBtBEIRQNelsB/4aCxleO1/qJetCfrI=;
        b=ZzfnJlyCR9ebl8WjWt8agZFeCtO3yen2mwirvoxeEDrm5cizOY8/0/tpAyILaVr3KM
         y286mG6wAFbkAjpJUE8zGLHRwl8EQeez+gC1xZ4TKZ0fQUb0Rm1Qrs4Xsqrm+JCSBeGm
         94KnMnWL+TTdPsC0grcaQRZbeGUajCSruZxq9ba4tCUugDHa/ts5jilsmNfE49WxX+6o
         KipMs503CppEfCkkE3Zt7c5m3lSS1JdaNdsXbM2f8bA7A2eimJEhzTi5y8GHwqW6kyAd
         Z04HelhkYnIRnuejm7tcCqSX7Eoio7zodJCaPWMyufwwO516QkKklc4tBIrjHVjwB8xc
         r/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680216718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sp3oL8gR+feCzBtBEIRQNelsB/4aCxleO1/qJetCfrI=;
        b=cWNeR0vqfVqedCxK+Aavl2+xatWp8vRy8OaQ95fG2lLyy9gJYY2/8u3466NUhWwXJy
         pKZ5TyssPpVfiV5vv+yt27k2AFvXKRoCIlV7BZlZ8i7uTGCi9UkEexSaBYuC00gZ51Hi
         8rfD+Q0GKtzvnmrSL8lSJpZpXfZZkoYp9Ak65q1bj0CA70Hjk1HrSrg24CSLjmGO8ISu
         3mzphNhpIhN/lm/rJ1p1P2Zl4G7akJcPGGVI1UthjJwv0647cyw7CpnAITUsSkJzjLW9
         6VRAeEloUl9/3EMwEsgZrLBb2n+7Mc9WyCAptaYO2FB/GjkndUvA2vI5Th+CWRvKIVGo
         9+2A==
X-Gm-Message-State: AAQBX9dSBBwOPbMCQ6Jt5NCPLTHWjMYelLzGxVGodoabQnNd/p6FBo1S
        TSWsz2wq/4R0gpRFOQ1eJZQ=
X-Google-Smtp-Source: AKy350bTDHbNqPBn7ys5TCr9Ij+9cG+vNU9Iwh2RJSuaXBgGn6vD9V6OFLUlrxHPhRerNAtfgiYO4A==
X-Received: by 2002:a17:90b:1c8f:b0:23d:39e0:13b with SMTP id oo15-20020a17090b1c8f00b0023d39e0013bmr27282801pjb.43.1680216718098;
        Thu, 30 Mar 2023 15:51:58 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:93aa:8e39:c08b:8c2c])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a174300b0023f545c055bsm3668091pjm.33.2023.03.30.15.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:51:57 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 30 Mar 2023 15:51:54 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     martin@omnibond.com, axboe@kernel.dk, akpm@linux-foundation.org,
        hubcap@omnibond.com, willy@infradead.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, brauner@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com, linux-mm@kvack.org, devel@lists.orangefs.org
Subject: Re: [PATCH 1/5] zram: remove the call to page_endio in the bio
 end_io handler
Message-ID: <ZCYSincU0FlULyWJ@google.com>
References: <20230328112716.50120-1-p.raghav@samsung.com>
 <CGME20230328112718eucas1p214a859cfb3d7b45523356bcc16c373b1@eucas1p2.samsung.com>
 <20230328112716.50120-2-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328112716.50120-2-p.raghav@samsung.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 01:27:12PM +0200, Pankaj Raghav wrote:
> zram_page_end_io function is called when alloc_page is used (for
> partial IO) to trigger writeback from the user space. The pages used for

No, it was used with zram_rw_page since rw_page didn't carry the bio.

> this operation is never locked or have the writeback set. So, it is safe

VM had the page lock and wait to unlock.

> to remove the call to page_endio() function that unlocks or marks
> writeback end on the page.
> 
> Rename the endio handler from zram_page_end_io to zram_read_end_io as
> the call to page_endio() is removed and to associate the callback to the
> operation it is used in.

Since zram removed the rw_page and IO comes with bio from now on,
IIUC, we are fine since every IO will go with chained-IO. Right?

> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/block/zram/zram_drv.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index b7bb52f8dfbd..3300e7eda2f6 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -606,12 +606,8 @@ static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
>  	atomic64_dec(&zram->stats.bd_count);
>  }
>  
> -static void zram_page_end_io(struct bio *bio)
> +static void zram_read_end_io(struct bio *bio)
>  {
> -	struct page *page = bio_first_page_all(bio);
> -
> -	page_endio(page, op_is_write(bio_op(bio)),
> -			blk_status_to_errno(bio->bi_status));
>  	bio_put(bio);
>  }
>  
> @@ -635,7 +631,7 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
>  	}
>  
>  	if (!parent)
> -		bio->bi_end_io = zram_page_end_io;
> +		bio->bi_end_io = zram_read_end_io;
>  	else
>  		bio_chain(bio, parent);
>  
> -- 
> 2.34.1
> 
