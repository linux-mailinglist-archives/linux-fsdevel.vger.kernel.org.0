Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5074B9AC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 09:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbiBQIRa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 03:17:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbiBQIR3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:17:29 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5B21B9100;
        Thu, 17 Feb 2022 00:17:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V4gvygv_1645085823;
Received: from rsjd01523.et2sqa(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0V4gvygv_1645085823)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Feb 2022 16:17:09 +0800
Date:   Thu, 17 Feb 2022 16:17:03 +0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/22] cachefiles: extract generic function for daemon
 methods
Message-ID: <20220217081703.GA10016@rsjd01523.et2sqa>
Reply-To: bo.liu@linux.alibaba.com
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
 <20220209060108.43051-4-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209060108.43051-4-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 09, 2022 at 02:00:49PM +0800, Jeffle Xu wrote:
> ... so that the following new devnode can reuse most of the code when
> implementing its own methods.
>

Looks good.

Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
liubo

> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/cachefiles/daemon.c | 70 +++++++++++++++++++++++++++---------------
>  1 file changed, 45 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
> index 7ac04ee2c0a0..6b8d7c5bbe5d 100644
> --- a/fs/cachefiles/daemon.c
> +++ b/fs/cachefiles/daemon.c
> @@ -78,6 +78,34 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
>  	{ "",		NULL				}
>  };
>  
> +static struct cachefiles_cache *cachefiles_daemon_open_cache(void)
> +{
> +	struct cachefiles_cache *cache;
> +
> +	/* allocate a cache record */
> +	cache = kzalloc(sizeof(struct cachefiles_cache), GFP_KERNEL);
> +	if (cache) {
> +		mutex_init(&cache->daemon_mutex);
> +		init_waitqueue_head(&cache->daemon_pollwq);
> +		INIT_LIST_HEAD(&cache->volumes);
> +		INIT_LIST_HEAD(&cache->object_list);
> +		spin_lock_init(&cache->object_list_lock);
> +
> +		/* set default caching limits
> +		 * - limit at 1% free space and/or free files
> +		 * - cull below 5% free space and/or free files
> +		 * - cease culling above 7% free space and/or free files
> +		 */
> +		cache->frun_percent = 7;
> +		cache->fcull_percent = 5;
> +		cache->fstop_percent = 1;
> +		cache->brun_percent = 7;
> +		cache->bcull_percent = 5;
> +		cache->bstop_percent = 1;
> +	}
> +
> +	return cache;
> +}
>  
>  /*
>   * Prepare a cache for caching.
> @@ -96,31 +124,13 @@ static int cachefiles_daemon_open(struct inode *inode, struct file *file)
>  	if (xchg(&cachefiles_open, 1) == 1)
>  		return -EBUSY;
>  
> -	/* allocate a cache record */
> -	cache = kzalloc(sizeof(struct cachefiles_cache), GFP_KERNEL);
> +
> +	cache = cachefiles_daemon_open_cache();
>  	if (!cache) {
>  		cachefiles_open = 0;
>  		return -ENOMEM;
>  	}
>  
> -	mutex_init(&cache->daemon_mutex);
> -	init_waitqueue_head(&cache->daemon_pollwq);
> -	INIT_LIST_HEAD(&cache->volumes);
> -	INIT_LIST_HEAD(&cache->object_list);
> -	spin_lock_init(&cache->object_list_lock);
> -
> -	/* set default caching limits
> -	 * - limit at 1% free space and/or free files
> -	 * - cull below 5% free space and/or free files
> -	 * - cease culling above 7% free space and/or free files
> -	 */
> -	cache->frun_percent = 7;
> -	cache->fcull_percent = 5;
> -	cache->fstop_percent = 1;
> -	cache->brun_percent = 7;
> -	cache->bcull_percent = 5;
> -	cache->bstop_percent = 1;
> -
>  	file->private_data = cache;
>  	cache->cachefilesd = file;
>  	return 0;
> @@ -209,10 +219,11 @@ static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
>  /*
>   * Take a command from cachefilesd, parse it and act on it.
>   */
> -static ssize_t cachefiles_daemon_write(struct file *file,
> -				       const char __user *_data,
> -				       size_t datalen,
> -				       loff_t *pos)
> +static ssize_t cachefiles_daemon_do_write(struct file *file,
> +					  const char __user *_data,
> +					  size_t datalen,
> +					  loff_t *pos,
> +			const struct cachefiles_daemon_cmd *cmds)
>  {
>  	const struct cachefiles_daemon_cmd *cmd;
>  	struct cachefiles_cache *cache = file->private_data;
> @@ -261,7 +272,7 @@ static ssize_t cachefiles_daemon_write(struct file *file,
>  	}
>  
>  	/* run the appropriate command handler */
> -	for (cmd = cachefiles_daemon_cmds; cmd->name[0]; cmd++)
> +	for (cmd = cmds; cmd->name[0]; cmd++)
>  		if (strcmp(cmd->name, data) == 0)
>  			goto found_command;
>  
> @@ -284,6 +295,15 @@ static ssize_t cachefiles_daemon_write(struct file *file,
>  	goto error;
>  }
>  
> +static ssize_t cachefiles_daemon_write(struct file *file,
> +				       const char __user *_data,
> +				       size_t datalen,
> +				       loff_t *pos)
> +{
> +	return cachefiles_daemon_do_write(file, _data, datalen, pos,
> +					  cachefiles_daemon_cmds);
> +}
> +
>  /*
>   * Poll for culling state
>   * - use EPOLLOUT to indicate culling state
> -- 
> 2.27.0
