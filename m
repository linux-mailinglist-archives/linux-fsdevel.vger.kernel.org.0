Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79209632D83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 20:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiKUT5b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 14:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiKUT53 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:57:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5FAF3D;
        Mon, 21 Nov 2022 11:57:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 202A2B80FB3;
        Mon, 21 Nov 2022 19:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF875C433C1;
        Mon, 21 Nov 2022 19:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669060644;
        bh=PlEG374jgvvPAmbP1UZkk6V9iaSjnsu+iBrZex7YiPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hEI/2m6l224DSR4aa1k8ORBaKETPS4C/Q5FINywByeZLmuI4KOqjcs3SwaqBtODlG
         5TnX+RETzd5HHT11xKSnqeIxcg8WPq5q4ORoi6WgKqZDIIo9g6z6VY7CQUAiJYnxO2
         kGJeOejLN6C8I2IhavCMidvVlGYJGCf2NM/J2KrFqwvJTnXM+Fnw9ctMCyj6Dd4VDP
         6GrHK9/BjmrfzL9DgOOF/XsmW/16Zbq6lrfKKYCr+9KHmvDLVVNOFAphpCVPp+rjrP
         mEa5hxuccGqYi4bauODy0+l0v5+6lKncGP++zPGkJ60j/2Ty2lykBi1Kq1ca9sImLX
         q5lbSgPZOPRhw==
Date:   Mon, 21 Nov 2022 19:57:23 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fs: clear a UBSAN shift-out-of-bounds warning
Message-ID: <Y3vYIyaxzdXNrFq7@gmail.com>
References: <20221121024418.1800-1-thunder.leizhen@huawei.com>
 <20221121024418.1800-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121024418.1800-3-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 10:44:18AM +0800, Zhen Lei wrote:
> UBSAN: shift-out-of-bounds in fs/locks.c:2572:16
> left shift of 1 by 63 places cannot be represented in type 'long long int'
> 
> Switch the calculation method to type_max() can help us eliminate this
> false positive.
> 
> On the other hand, the old implementation has problems with char and
> short types, although not currently involved.
> printf("%d: %x\n", sizeof(char),  INT_LIMIT(char));
> printf("%d: %x\n", sizeof(short), INT_LIMIT(short));
> 1: ffffff7f
> 2: ffff7fff
> 
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  include/linux/fs.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e654435f16512c1..a384741b1449457 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1131,9 +1131,8 @@ struct file_lock_context {
>  
>  /* The following constant reflects the upper bound of the file/locking space */
>  #ifndef OFFSET_MAX
> -#define INT_LIMIT(x)	(~((x)1 << (sizeof(x)*8 - 1)))
> -#define OFFSET_MAX	INT_LIMIT(loff_t)
> -#define OFFT_OFFSET_MAX	INT_LIMIT(off_t)
> +#define OFFSET_MAX	type_max(loff_t)
> +#define OFFT_OFFSET_MAX	type_max(off_t)
>  #endif
>  
>  extern void send_sigio(struct fown_struct *fown, int fd, int band);
> -- 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
