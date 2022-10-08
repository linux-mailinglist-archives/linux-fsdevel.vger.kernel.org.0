Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B975F847B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 11:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJHJAu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 05:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJHJAj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 05:00:39 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F945A8B8;
        Sat,  8 Oct 2022 02:00:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VRcD6Ms_1665219618;
Received: from 30.221.130.66(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VRcD6Ms_1665219618)
          by smtp.aliyun-inc.com;
          Sat, 08 Oct 2022 17:00:19 +0800
Message-ID: <514c06f7-017d-bca5-6a87-0dae54c0d83d@linux.alibaba.com>
Date:   Sat, 8 Oct 2022 17:00:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 5/5] cachefiles: add restore command to recover
 inflight ondemand read requests
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, dhowells@redhat.com,
        xiang@kernel.org
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20220818135204.49878-1-zhujia.zj@bytedance.com>
 <20220818135204.49878-6-zhujia.zj@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220818135204.49878-6-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/18/22 9:52 PM, Jia Zhu wrote:
> Previously, in ondemand read scenario, if the anonymous fd was closed by
> user daemon, inflight and subsequent read requests would return EIO.
> As long as the device connection is not released, user daemon can hold
> and restore inflight requests by setting the request flag to
> CACHEFILES_REQ_NEW.
> 
> Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
>  fs/cachefiles/daemon.c   |  1 +
>  fs/cachefiles/internal.h |  3 +++
>  fs/cachefiles/ondemand.c | 23 +++++++++++++++++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index c74bd1f4ecf5..014369266cb2 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -77,6 +77,7 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
>  	{ "tag",	cachefiles_daemon_tag		},
>  #ifdef CONFIG_CACHEFILES_ONDEMAND
>  	{ "copen",	cachefiles_ondemand_copen	},
> +	{ "restore",	cachefiles_ondemand_restore	},
>  #endif
>  	{ "",		NULL				}
>  };
> diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
> index b4af67f1cbd6..d504c61a5f03 100644
> --- a/fs/cachefiles/internal.h
> +++ b/fs/cachefiles/internal.h
> @@ -303,6 +303,9 @@ extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
>  				     char *args);
>  
> +extern int cachefiles_ondemand_restore(struct cachefiles_cache *cache,
> +					char *args);
> +
>  extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
>  extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
>  
> diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
> index 79ffb19380cd..5b1c447da976 100644
> --- a/fs/cachefiles/ondemand.c
> +++ b/fs/cachefiles/ondemand.c
> @@ -178,6 +178,29 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
>  	return ret;
>  }
>  
> +int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
> +{
> +	struct cachefiles_req *req;
> +
> +	XA_STATE(xas, &cache->reqs, 0);
> +
> +	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * Search the requests which being processed before
> +	 * the user daemon crashed.
> +	 * Set the CACHEFILES_REQ_NEW flag and user daemon will reprocess it.
> +	 */

The comment can be improved as:

	Reset the requests to CACHEFILES_REQ_NEW state, so that the
        requests have been processed halfway before the crash of the
        user daemon could be reprocessed after the recovery.


> +	xas_lock(&xas);
> +	xas_for_each(&xas, req, ULONG_MAX)
> +		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
> +	xas_unlock(&xas);
> +
> +	wake_up_all(&cache->daemon_pollwq);
> +	return 0;
> +}
> +
>  static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
>  {
>  	struct cachefiles_object *object;

-- 
Thanks,
Jingbo
