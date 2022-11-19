Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399DE631076
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 20:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiKSTjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Nov 2022 14:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiKSTjv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Nov 2022 14:39:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA1010548;
        Sat, 19 Nov 2022 11:39:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89382B80764;
        Sat, 19 Nov 2022 19:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D66C433C1;
        Sat, 19 Nov 2022 19:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668886788;
        bh=+C+DiIjfUNvrIUtozO8tzaUQ95kuqAMyl5Xq7IgDY2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WONmlaT9hsYTSDq8NULSBTZUyBsKljuUiElU7Bl4o+SCNVRp3YIId0DskwQ5jXd2T
         69dFw+5fhoAa69Dk+fAfTHMCI0lqTJ3ahMkYu5bmFnY6pqQX2GO9ARtAx19j1Z92Ga
         n8xrTatWiOUCzSmLbSyf2d85sQp3su6D8vdS/6/Lm4PUXiNUEednzYzucPs7XKueBC
         qVqoXvxmQyx7d0a8yU6lOZOxn6iHTQ1ILmn9TUpPPEZ+/aCIJZ1IxPUfiqzl2/C++J
         1k/WSgOwmNnTmC9BAlHWi2fy1T6DJlIsoCSsb3EptDLeXutiL7vIhPDuveCAlfYNVm
         52aAvG3OmCd/g==
Date:   Sat, 19 Nov 2022 11:39:43 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Clear a UBSAN shift-out-of-bounds warning
Message-ID: <Y3kw4IP2BVcbFoGT@sol.localdomain>
References: <20221110031024.204-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110031024.204-1-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 10, 2022 at 11:10:24AM +0800, Zhen Lei wrote:
> UBSAN: shift-out-of-bounds in fs/locks.c:2572:16
> left shift of 1 by 63 places cannot be represented in type 'long long int'
> 
> Switch the calculation method to ((quarter - 1) * 2 + 1) can help us
> eliminate this false positive.
> 
> On the other hand, the old implementation has problems with char and
> short types, although not currently involved.
> printf("%d: %x\n", sizeof(char),  INT_LIMIT(char));
> printf("%d: %x\n", sizeof(short), INT_LIMIT(short));
> 1: ffffff7f
> 2: ffff7fff
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e654435f16512c1..88d42e2daed9f6c 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1131,7 +1131,7 @@ struct file_lock_context {
>  
>  /* The following constant reflects the upper bound of the file/locking space */
>  #ifndef OFFSET_MAX
> -#define INT_LIMIT(x)	(~((x)1 << (sizeof(x)*8 - 1)))
> +#define INT_LIMIT(x)	((((x)1 << (sizeof(x) * 8 - 2)) - 1) * 2  + 1)
>  #define OFFSET_MAX	INT_LIMIT(loff_t)
>  #define OFFT_OFFSET_MAX	INT_LIMIT(off_t)
>  #endif

This problem has already been solved by type_max() in include/linux/overflow.h.
How about removing INT_LIMIT() and using type_max() instead?

- Eric
