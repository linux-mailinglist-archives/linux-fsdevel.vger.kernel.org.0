Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D4A4F8148
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 16:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiDGOIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 10:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343828AbiDGOHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:07:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEBCE0AEF;
        Thu,  7 Apr 2022 07:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96B7FB82777;
        Thu,  7 Apr 2022 14:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAE5C385A7;
        Thu,  7 Apr 2022 14:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649340336;
        bh=h/ekb5QtQwdaE1nuKp1Ak9uQSLC0j8BMRSRfXRUcEK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6HvBPLWrJ06i4vlOTF8BnZ3iqItHqw/nsH/nNnEwo+N32fsRbK0SKgF5EwQsMH+9
         nvPFZqZ7FMctoEz4BWfpfOwdcQGV/g66hr+wb+2qpXqSeo5pU2cJGRZYxCHMNEfndq
         UEG9V0T3FTni5dw/r0Jd55uxSPQIfnPqxSx60c+bSgkaxtA8yILAntPnPoAS5tvbSM
         uOSoGF+r+t/Lzp7Y/LuPML8bXRgjF+voyEegUOCTM4Ku8YeS0zqz18A7fwukVcOZ69
         Z4TNP76n/xxzt9umz8R5oYeVg/FxuVoELTWeU1AKtq222UQfTpr+II4qi1xvboJoHF
         lCyCEDNDgga8g==
Date:   Thu, 7 Apr 2022 22:05:26 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: Re: [PATCH v8 13/20] erofs: add erofs_fscache_read_folios() helper
Message-ID: <Yk7vfDqd4gVoVlqz@debian>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
References: <20220406075612.60298-1-jefflexu@linux.alibaba.com>
 <20220406075612.60298-14-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406075612.60298-14-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 06, 2022 at 03:56:05PM +0800, Jeffle Xu wrote:
> Add erofs_fscache_read_folios() helper reading from fscache. It supports
> on-demand read semantics. That is, it will make the backend prepare for
> the data when cache miss. Once data ready, it will reinitiate a read
> from the cache.
> 
> This helper can then be used to implement .readpage()/.readahead() of
> on-demand read semantics.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/fscache.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 1c88614203d2..d38a6efc8e50 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -5,6 +5,35 @@
>  #include <linux/fscache.h>
>  #include "internal.h"
>  
> +/*
> + * Read data from fscache and fill the read data into page cache described by
> + * @start/len, which shall be both aligned with PAGE_SIZE. @pstart describes
> + * the start physical address in the cache file.
> + */
> +static int erofs_fscache_read_folios(struct fscache_cookie *cookie,
> +				     struct address_space *mapping,
> +				     loff_t start, size_t len,
> +				     loff_t pstart)
> +{
> +	struct netfs_cache_resources cres;
> +	struct iov_iter iter;
> +	int ret;
> +
> +	memset(&cres, 0, sizeof(cres));
> +
> +	ret = fscache_begin_read_operation(&cres, cookie);
> +	if (ret)
> +		return ret;
> +
> +	iov_iter_xarray(&iter, READ, &mapping->i_pages, start, len);
> +
> +	ret = fscache_read(&cres, pstart, &iter,
> +			   NETFS_READ_HOLE_ONDEMAND, NULL, NULL);
> +
> +	fscache_end_operation(&cres);
> +	return ret;
> +}
> +
>  static const struct address_space_operations erofs_fscache_meta_aops = {
>  };
>  
> -- 
> 2.27.0
> 
