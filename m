Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53B655149B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 11:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbiFTJlu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 05:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240451AbiFTJlt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:41:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9247613DE5;
        Mon, 20 Jun 2022 02:41:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0519A21B78;
        Mon, 20 Jun 2022 09:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655718107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R/GL2lalnHPhQAgk6CBBzZ8pLzaVTGrAV5EgR6xbabE=;
        b=fIem8q4jWWViCYSJeHJECfZqxPaIYSW00i7SSjnKOv3LAiu+z84D+VWQedWB+udPLiIh1o
        UmHXKT2uX9nYmYzelZsyipsnmZSg58V6MrqZSq+zWDt1ywgN8sKR2ze8sfzXroWL1Yli4L
        83Ms9LXLgIyFmk++e0TI8EmKfEiG5YE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655718107;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R/GL2lalnHPhQAgk6CBBzZ8pLzaVTGrAV5EgR6xbabE=;
        b=f1XvwbVjH//3xk71q7QyNnd8BKSl6wnmAYo8ttQ6oBfMIJWGfh/IEr1E/STfKSroVmEL3D
        SOOjkcH8QTcaz2Aw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EBCA52C141;
        Mon, 20 Jun 2022 09:41:46 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AFAF4A0636; Mon, 20 Jun 2022 11:41:46 +0200 (CEST)
Date:   Mon, 20 Jun 2022 11:41:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 3/3] fs/buffer: Make submit_bh & submit_bh_wbc return type
 as void
Message-ID: <20220620094146.vlhtxiqv7ncehgfn@quack3.lan>
References: <cover.1655703466.git.ritesh.list@gmail.com>
 <ba89f469a59cfaca49478ee391e6bc9dde456e19.1655703467.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba89f469a59cfaca49478ee391e6bc9dde456e19.1655703467.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 20-06-22 11:28:42, Ritesh Harjani wrote:
> submit_bh/submit_bh_wbc are non-blocking functions which just submits
> the bio and returns. The caller of submit_bh/submit_bh_wbc needs to wait
> on buffer till I/O completion and then check buffer head's b_state field
> to know if there was any I/O error.
> 
> Hence there is no need for these functions to have any return type.
> Even now they always returns 0. Hence drop the return value and make
> their return type as void to avoid any confusion.
> 
> Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c                 | 9 ++++-----
>  include/linux/buffer_head.h | 2 +-
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 313283af15b6..6671abc98e21 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -52,7 +52,7 @@
>  #include "internal.h"
>  
>  static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
> -static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
> +static void submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
>  			 struct writeback_control *wbc);
>  
>  #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
> @@ -2994,7 +2994,7 @@ static void end_bio_bh_io_sync(struct bio *bio)
>  	bio_put(bio);
>  }
>  
> -static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
> +static void submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
>  			 struct writeback_control *wbc)
>  {
>  	struct bio *bio;
> @@ -3037,12 +3037,11 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
>  	}
>  
>  	submit_bio(bio);
> -	return 0;
>  }
>  
> -int submit_bh(int op, int op_flags, struct buffer_head *bh)
> +void submit_bh(int op, int op_flags, struct buffer_head *bh)
>  {
> -	return submit_bh_wbc(op, op_flags, bh, NULL);
> +	submit_bh_wbc(op, op_flags, bh, NULL);
>  }
>  EXPORT_SYMBOL(submit_bh);
>  
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index c9d1463bb20f..392d7d5aec05 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -205,7 +205,7 @@ void ll_rw_block(int, int, int, struct buffer_head * bh[]);
>  int sync_dirty_buffer(struct buffer_head *bh);
>  int __sync_dirty_buffer(struct buffer_head *bh, int op_flags);
>  void write_dirty_buffer(struct buffer_head *bh, int op_flags);
> -int submit_bh(int, int, struct buffer_head *);
> +void submit_bh(int op, int op_flags, struct buffer_head *bh);
>  void write_boundary_block(struct block_device *bdev,
>  			sector_t bblock, unsigned blocksize);
>  int bh_uptodate_or_lock(struct buffer_head *bh);
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
