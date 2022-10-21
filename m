Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524D4607336
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 11:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiJUJEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 05:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiJUJEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:04:48 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF2C4D273;
        Fri, 21 Oct 2022 02:04:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VSikrQi_1666343077;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSikrQi_1666343077)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 17:04:38 +0800
Date:   Fri, 21 Oct 2022 17:04:36 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] netfs: export helpers for request and subrequest
Message-ID: <Y1JgpEfsKH0vYbw0@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jingbo Xu <jefflexu@linux.alibaba.com>,
        dhowells@redhat.com, xiang@kernel.org, chao@kernel.org,
        linux-erofs@lists.ozlabs.org, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20221021084912.61468-1-jefflexu@linux.alibaba.com>
 <20221021084912.61468-2-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221021084912.61468-2-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 21, 2022 at 04:49:11PM +0800, Jingbo Xu wrote:
> Export netfs_put_subrequest() and netfs_rreq_completed().
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/netfs/io.c         | 3 ++-
>  fs/netfs/objects.c    | 1 +
>  include/linux/netfs.h | 2 ++
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/netfs/io.c b/fs/netfs/io.c
> index 428925899282..58dd56e3e780 100644
> --- a/fs/netfs/io.c
> +++ b/fs/netfs/io.c
> @@ -94,12 +94,13 @@ static void netfs_read_from_server(struct netfs_io_request *rreq,
>  /*
>   * Release those waiting.
>   */
> -static void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
> +void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
>  {
>  	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
>  	netfs_clear_subrequests(rreq, was_async);
>  	netfs_put_request(rreq, was_async, netfs_rreq_trace_put_complete);
>  }
> +EXPORT_SYMBOL(netfs_rreq_completed);
>  
>  /*
>   * Deal with the completion of writing the data to the cache.  We have to clear
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index e17cdf53f6a7..478cc1a1664c 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -158,3 +158,4 @@ void netfs_put_subrequest(struct netfs_io_subrequest *subreq, bool was_async,
>  	if (dead)
>  		netfs_free_subrequest(subreq, was_async);
>  }
> +EXPORT_SYMBOL(netfs_put_subrequest);
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index f2402ddeafbf..d519fb709d7f 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -282,6 +282,8 @@ int netfs_write_begin(struct netfs_inode *, struct file *,
>  		struct address_space *, loff_t pos, unsigned int len,
>  		struct folio **, void **fsdata);
>  
> +void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async);
> +
>  void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t, bool);
>  void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
>  			  enum netfs_sreq_ref_trace what);
> -- 
> 2.19.1.6.gb485710b
