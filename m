Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040AB5FC17C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 09:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJLHxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 03:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJLHxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:53:20 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150C8B1B94;
        Wed, 12 Oct 2022 00:53:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VS-qA-q_1665561193;
Received: from 30.221.128.220(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VS-qA-q_1665561193)
          by smtp.aliyun-inc.com;
          Wed, 12 Oct 2022 15:53:14 +0800
Message-ID: <28d64f00-e408-9fc2-9506-63c1d8b08b9c@linux.alibaba.com>
Date:   Wed, 12 Oct 2022 15:53:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH 3/5] cachefiles: resend an open request if the read
 request's object is closed
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, dhowells@redhat.com,
        xiang@kernel.org
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20221011131552.23833-1-zhujia.zj@bytedance.com>
 <20221011131552.23833-4-zhujia.zj@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20221011131552.23833-4-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/11/22 9:15 PM, Jia Zhu wrote:
> @@ -254,12 +282,18 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
>  	 * request distribution fair.
>  	 */
>  	xa_lock(&cache->reqs);
> -	req = xas_find_marked(&xas, UINT_MAX, CACHEFILES_REQ_NEW);
> -	if (!req && cache->req_id_next > 0) {
> -		xas_set(&xas, 0);
> -		req = xas_find_marked(&xas, cache->req_id_next - 1, CACHEFILES_REQ_NEW);
> +retry:
> +	xas_for_each_marked(&xas, req, xa_max, CACHEFILES_REQ_NEW) {
> +		if (cachefiles_ondemand_skip_req(req))
> +			continue;
> +		break;
>  	}
>  	if (!req) {
> +		if (cache->req_id_next > 0 && xa_max == ULONG_MAX) {
> +			xas_set(&xas, 0);
> +			xa_max = cache->req_id_next - 1;
> +			goto retry;
> +		}

I would suggest abstracting the "xas_for_each_marked(...,
CACHEFILES_REQ_NEW)" part into a helper function to avoid the "goto retry".


> @@ -392,8 +434,16 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
>  	wake_up_all(&cache->daemon_pollwq);
>  	wait_for_completion(&req->done);
>  	ret = req->error;
> +	kfree(req);
> +	return ret;
>  out:
>  	kfree(req);
> +	/* Reset the object to close state in error handling path.
> +	 * If error occurs after creating the anonymous fd,
> +	 * cachefiles_ondemand_fd_release() will set object to close.
> +	 */
> +	if (opcode == CACHEFILES_OP_OPEN)
> +		cachefiles_ondemand_set_object_close(req->object);

This may cause use-after-free since @req has been freed.



-- 
Thanks,
Jingbo
