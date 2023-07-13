Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE6E7521CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 14:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjGMMt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 08:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjGMMtM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:49:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68DD30E0;
        Thu, 13 Jul 2023 05:48:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C76CD610A0;
        Thu, 13 Jul 2023 12:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52ECC433C7;
        Thu, 13 Jul 2023 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689252525;
        bh=tmijwWm6ESORLzsPn45u413P6RTnuxpjAXkT3JhcMWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBqYnKHUTKDVlqXtIu/EGAuBAu6w3azr0i5RyYe+m6dIQ7BAZrfSpBuAi3XQiX4g0
         Jcpc48OKW6DXOeUx7+RrNDm1vC7CXzaPZNUu7daJ08lZzlSrn9chLbgKQaDJKM5YSz
         s5OBAyr/Aj3+SWfuyclLn3KvCoc+p5up7ZviS8JNIj5673tdfJs3UMvekIyGW+TFTt
         6tpRM06iTeIt42IUURUwHaCaHlXW1tQGeQ7UyKh4TjZKzeRPTPUI8pBkoNWV0KK58Q
         0Bo1I2MDhq4SNqKU3ZBmWxkGYtJy7MYF0wO2/49auhM4Qu4wSFHlszw7ejz4K3oT1X
         R3JAPGw8A6v+A==
Date:   Thu, 13 Jul 2023 14:48:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Al Viro <viro@zeniv.linux.org.uk>,
        xu xin <xu.xin16@zte.com.cn>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v1] fs: proc: Add error checking for d_hash_and_lookup()
Message-ID: <20230713-hinhalten-spinnen-7d1c9d0b5200@brauner>
References: <20230713113303.6512-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230713113303.6512-1-machel@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 07:32:48PM +0800, Wang Ming wrote:
> In case of failure, d_hash_and_lookup() returns NULL or an error
> pointer. The proc_fill_cache() needs to add the handling of the
> error pointer returned by d_hash_and_lookup().
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  fs/proc/base.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index bbc998fd2a2f..4c0e8329b318 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2071,6 +2071,8 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
>  	ino_t ino = 1;
>  
>  	child = d_hash_and_lookup(dir, &qname);
> +	if (IS_ERR(child))
> +		goto end_instantiate;

As procfs doesn't have a separate dentry hash function this doesn't make
much sense. It will always be either NULL or valid.
