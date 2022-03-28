Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474574E8C52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 04:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbiC1Cv3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Mar 2022 22:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbiC1Cv1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:51:27 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA00545519;
        Sun, 27 Mar 2022 19:49:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0V8KSgjt_1648435779;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V8KSgjt_1648435779)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Mar 2022 10:49:42 +0800
Date:   Mon, 28 Mar 2022 10:49:39 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        gregkh@linuxfoundation.org, fannaihao@baidu.com,
        tao.peng@linux.alibaba.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
        eguan@linux.alibaba.com, gerry@linux.alibaba.com,
        torvalds@linux-foundation.org
Subject: Re: [Linux-cachefs] [PATCH v6 14/22] erofs: add
 erofs_fscache_read_folios() helper
Message-ID: <YkEiQywvozBKTExr@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        gregkh@linuxfoundation.org, fannaihao@baidu.com,
        tao.peng@linux.alibaba.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, tianzichen@kuaishou.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
        eguan@linux.alibaba.com, gerry@linux.alibaba.com,
        torvalds@linux-foundation.org
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
 <20220325122223.102958-15-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220325122223.102958-15-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 25, 2022 at 08:22:15PM +0800, Jeffle Xu wrote:
> Add erofs_fscache_read_folios() helper reading from fscache. It supports
> on-demand read semantics. That is, it will make the backend prepare for
> the data when cache miss. Once data ready, it will reinitiate a read
> from the cache.
> 
> This helper can then be used to implement .readpage()/.readahead() of
> on-demand read semantics.
> 
> Besides also add erofs_fscache_read_folio() wrapper helper.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 30383d9adb62..6a55f7b5f883 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -7,6 +7,45 @@
>  
>  static struct fscache_volume *volume;
>  
> +/*
> + * erofs_fscache_read_folios - Read data from fscache.
> + *
> + * Fill the read data into page cache described by @start/len, which shall be
> + * both aligned with PAGE_SIZE. @pstart describes the corresponding physical
> + * start address in the cache file.
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
> +static inline int erofs_fscache_read_folio(struct fscache_cookie *cookie,
> +					   struct folio *folio, loff_t pstart)

I've seen two users of this helper,

 1) erofs_fscache_readpage_noinline
 2) erofs_fscache_readpage_blob

Actually, we could fold such logic in these users since this additional
helper doesn't enhance the readability but increase the overhead when
reading the code.

It'd be better to get rid of it instead.

Thanks,
Gao Xiang

> +{
> +	return erofs_fscache_read_folios(cookie, folio_file_mapping(folio),
> +					 folio_pos(folio), folio_size(folio),
> +					 pstart);
> +}
> +
>  static const struct address_space_operations erofs_fscache_blob_aops = {
>  };
>  
> -- 
> 2.27.0
> 
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
