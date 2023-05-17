Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0903A705BB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 02:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjEQAID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 20:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjEQAIC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 20:08:02 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B13E12F;
        Tue, 16 May 2023 17:08:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ViqAzYl_1684282076;
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0ViqAzYl_1684282076)
          by smtp.aliyun-inc.com;
          Wed, 17 May 2023 08:07:57 +0800
Message-ID: <b8549484-5385-0410-c849-4d0c591574f9@linux.alibaba.com>
Date:   Wed, 17 May 2023 08:07:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] fuse: fix return value of inode_inline_reclaim_one_dmap
 in error path
Content-Language: en-US
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com, linux-fsdevel@vger.kernel.org
Cc:     gerry@linux.alibaba.com, linux-kernel@vger.kernel.org
References: <20230424123250.125404-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20230424123250.125404-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping...

On 4/24/23 8:32 PM, Jingbo Xu wrote:
> When range already got reclaimed by somebody else, return NULL so that
> the caller could retry to allocate or reclaim another range, instead of
> mistakenly returning the range already got reclaimed and reused by
> others.
> 
> Reported-by: Liu Jiang <gerry@linux.alibaba.com>
> Fixes: 9a752d18c85a ("virtiofs: add logic to free up a memory range")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/dax.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 8e74f278a3f6..59aadfd89ee5 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -985,6 +985,7 @@ inode_inline_reclaim_one_dmap(struct fuse_conn_dax *fcd, struct inode *inode,
>  	node = interval_tree_iter_first(&fi->dax->tree, start_idx, start_idx);
>  	/* Range already got reclaimed by somebody else */
>  	if (!node) {
> +		dmap = NULL;
>  		if (retry)
>  			*retry = true;
>  		goto out_write_dmap_sem;

-- 
Thanks,
Jingbo
